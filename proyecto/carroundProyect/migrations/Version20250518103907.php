<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250518103907 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio ADD receptor_id INT DEFAULT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio ADD CONSTRAINT FK_CB86F22A386D8D01 FOREIGN KEY (receptor_id) REFERENCES receptor (id)
        SQL);
        $this->addSql(<<<'SQL'
            CREATE INDEX IDX_CB86F22A386D8D01 ON servicio (receptor_id)
        SQL);
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio DROP FOREIGN KEY FK_CB86F22A386D8D01
        SQL);
        $this->addSql(<<<'SQL'
            DROP INDEX IDX_CB86F22A386D8D01 ON servicio
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio DROP receptor_id
        SQL);
    }
}
