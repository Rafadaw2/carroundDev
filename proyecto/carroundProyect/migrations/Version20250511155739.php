<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250511155739 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql(<<<'SQL'
            CREATE TABLE centro (id INT AUTO_INCREMENT NOT NULL, cliente_id INT DEFAULT NULL, nombre VARCHAR(255) NOT NULL, direccion VARCHAR(255) NOT NULL, telefono INT NOT NULL, INDEX IDX_2675036BDE734E51 (cliente_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB
        SQL);
        $this->addSql(<<<'SQL'
            CREATE TABLE cliente (id INT AUTO_INCREMENT NOT NULL, nif VARCHAR(255) NOT NULL, razon_social VARCHAR(255) NOT NULL, direccion VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB
        SQL);
        $this->addSql(<<<'SQL'
            CREATE TABLE receptor (id INT AUTO_INCREMENT NOT NULL, email VARCHAR(255) NOT NULL, nombre VARCHAR(255) NOT NULL, apellido1 VARCHAR(255) NOT NULL, apellido2 VARCHAR(255) DEFAULT NULL, nif VARCHAR(255) NOT NULL, telefono INT NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB
        SQL);
        $this->addSql(<<<'SQL'
            CREATE TABLE servicio (id INT AUTO_INCREMENT NOT NULL, vehiculo_id INT DEFAULT NULL, creador_id INT NOT NULL, conductor_id INT DEFAULT NULL, direccion_recogida VARCHAR(255) NOT NULL, direccion_entrega VARCHAR(255) NOT NULL, fecha DATE NOT NULL, hora_entrega_prevista VARCHAR(255) DEFAULT NULL, hora_entrega_real VARCHAR(255) DEFAULT NULL, hora_recogida_prevista VARCHAR(255) DEFAULT NULL, hora_recogida_real VARCHAR(255) DEFAULT NULL, franja_disponibilidad VARCHAR(255) NOT NULL, km_inicial INT DEFAULT NULL, km_final INT DEFAULT NULL, INDEX IDX_CB86F22A25F7D575 (vehiculo_id), INDEX IDX_CB86F22A62F40C3D (creador_id), INDEX IDX_CB86F22AA49DECF0 (conductor_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB
        SQL);
        $this->addSql(<<<'SQL'
            CREATE TABLE usuario (id INT AUTO_INCREMENT NOT NULL, centro_id INT DEFAULT NULL, email VARCHAR(180) NOT NULL, roles JSON NOT NULL, password VARCHAR(255) NOT NULL, nombre VARCHAR(255) NOT NULL, apellido1 VARCHAR(255) NOT NULL, apellido2 VARCHAR(255) DEFAULT NULL, INDEX IDX_2265B05D298137A7 (centro_id), UNIQUE INDEX UNIQ_IDENTIFIER_EMAIL (email), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB
        SQL);
        $this->addSql(<<<'SQL'
            CREATE TABLE vehiculo (id INT AUTO_INCREMENT NOT NULL, marca VARCHAR(255) NOT NULL, modelo VARCHAR(255) NOT NULL, matricula VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB
        SQL);
        $this->addSql(<<<'SQL'
            CREATE TABLE vehiculo_receptor (vehiculo_id INT NOT NULL, receptor_id INT NOT NULL, INDEX IDX_B2B2C38525F7D575 (vehiculo_id), INDEX IDX_B2B2C385386D8D01 (receptor_id), PRIMARY KEY(vehiculo_id, receptor_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB
        SQL);
        $this->addSql(<<<'SQL'
            CREATE TABLE messenger_messages (id BIGINT AUTO_INCREMENT NOT NULL, body LONGTEXT NOT NULL, headers LONGTEXT NOT NULL, queue_name VARCHAR(190) NOT NULL, created_at DATETIME NOT NULL COMMENT '(DC2Type:datetime_immutable)', available_at DATETIME NOT NULL COMMENT '(DC2Type:datetime_immutable)', delivered_at DATETIME DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)', INDEX IDX_75EA56E0FB7336F0 (queue_name), INDEX IDX_75EA56E0E3BD61CE (available_at), INDEX IDX_75EA56E016BA31DB (delivered_at), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE centro ADD CONSTRAINT FK_2675036BDE734E51 FOREIGN KEY (cliente_id) REFERENCES cliente (id)
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio ADD CONSTRAINT FK_CB86F22A25F7D575 FOREIGN KEY (vehiculo_id) REFERENCES vehiculo (id)
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio ADD CONSTRAINT FK_CB86F22A62F40C3D FOREIGN KEY (creador_id) REFERENCES usuario (id)
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio ADD CONSTRAINT FK_CB86F22AA49DECF0 FOREIGN KEY (conductor_id) REFERENCES usuario (id)
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE usuario ADD CONSTRAINT FK_2265B05D298137A7 FOREIGN KEY (centro_id) REFERENCES centro (id)
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE vehiculo_receptor ADD CONSTRAINT FK_B2B2C38525F7D575 FOREIGN KEY (vehiculo_id) REFERENCES vehiculo (id) ON DELETE CASCADE
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE vehiculo_receptor ADD CONSTRAINT FK_B2B2C385386D8D01 FOREIGN KEY (receptor_id) REFERENCES receptor (id) ON DELETE CASCADE
        SQL);
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql(<<<'SQL'
            ALTER TABLE centro DROP FOREIGN KEY FK_2675036BDE734E51
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio DROP FOREIGN KEY FK_CB86F22A25F7D575
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio DROP FOREIGN KEY FK_CB86F22A62F40C3D
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE servicio DROP FOREIGN KEY FK_CB86F22AA49DECF0
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE usuario DROP FOREIGN KEY FK_2265B05D298137A7
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE vehiculo_receptor DROP FOREIGN KEY FK_B2B2C38525F7D575
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE vehiculo_receptor DROP FOREIGN KEY FK_B2B2C385386D8D01
        SQL);
        $this->addSql(<<<'SQL'
            DROP TABLE centro
        SQL);
        $this->addSql(<<<'SQL'
            DROP TABLE cliente
        SQL);
        $this->addSql(<<<'SQL'
            DROP TABLE receptor
        SQL);
        $this->addSql(<<<'SQL'
            DROP TABLE servicio
        SQL);
        $this->addSql(<<<'SQL'
            DROP TABLE usuario
        SQL);
        $this->addSql(<<<'SQL'
            DROP TABLE vehiculo
        SQL);
        $this->addSql(<<<'SQL'
            DROP TABLE vehiculo_receptor
        SQL);
        $this->addSql(<<<'SQL'
            DROP TABLE messenger_messages
        SQL);
    }
}
