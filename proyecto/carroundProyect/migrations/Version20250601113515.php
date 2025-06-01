<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250601113515 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio ADD latitud_recogida INT DEFAULT NULL, ADD longitud_recogida INT DEFAULT NULL, ADD latitud_entrega INT DEFAULT NULL, ADD longitud_entrega INT DEFAULT NULL, DROP latitud, DROP longitud
        SQL);
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio ADD latitud INT DEFAULT NULL, ADD longitud INT DEFAULT NULL, DROP latitud_recogida, DROP longitud_recogida, DROP latitud_entrega, DROP longitud_entrega
        SQL);
    }
}
