class AddTsvectorNameInFoods < ActiveRecord::Migration[6.0]
  def up
    add_column :foods, :tsv, :tsvector
    add_index :foods, :tsv, using: "gin"

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON foods FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        tsv, 'pg_catalog.english', name
      );
    SQL

    now = Time.current.to_s(:db)
    update("UPDATE foods SET updated_at = '#{now}'")
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON foods
    SQL

    remove_index :foods, :tsv
    remove_column :foods, :tsv
  end
end
