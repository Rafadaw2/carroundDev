<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250601152334 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio CHANGE latitud_recogida latitud_recogida DOUBLE PRECISION DEFAULT NULL, CHANGE longitud_recogida longitud_recogida DOUBLE PRECISION DEFAULT NULL, CHANGE latitud_entrega latitud_entrega DOUBLE PRECISION DEFAULT NULL, CHANGE longitud_entrega longitud_entrega DOUBLE PRECISION DEFAULT NULL
        SQL);
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio CHANGE latitud_recogida latitud_recogida INT DEFAULT NULL, CHANGE longitud_recogida longitud_recogida INT DEFAULT NULL, CHANGE latitud_entrega latitud_entrega INT DEFAULT NULL, CHANGE longitud_entrega longitud_entrega INT DEFAULT NULL
        SQL);
    }
}
