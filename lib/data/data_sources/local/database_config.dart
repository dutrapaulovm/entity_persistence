class DatabaseConfig {
  static const String databaseName = 'contasreceber.db';
  static const int version = 1;

  static List<String> comandosSQL = [
    // Table `estado`
    "CREATE TABLE IF NOT EXISTS estado ("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "UFIBGE TEXT NOT NULL DEFAULT '',"
        "UF TEXT NOT NULL DEFAULT '',"
        "Nome TEXT NOT NULL DEFAULT '',"
        "UNIQUE(UF),"
        "UNIQUE(UFIBGE)"
        ");",

    // Table `cidade`
    "CREATE TABLE IF NOT EXISTS cidade ("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "IBGE TEXT NOT NULL DEFAULT '',"
        "Nome TEXT NOT NULL DEFAULT '',"
        "UNIQUE(IBGE)"
        ");",

    // Table `usuarios`
    "CREATE TABLE IF NOT EXISTS usuarios ("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "Nome TEXT NOT NULL DEFAULT '',"
        "NomeUsuario TEXT NOT NULL DEFAULT '',"
        "Email TEXT NOT NULL DEFAULT '',"
        "Senha TEXT NOT NULL DEFAULT '',"
        "CPF TEXT NOT NULL DEFAULT '',"
        "Endereco TEXT NOT NULL DEFAULT '',"
        "Numero TEXT NOT NULL DEFAULT '',"
        "Cep TEXT NOT NULL DEFAULT '',"
        "CidadeID INTEGER NOT NULL,"
        "Cidade TEXT NOT NULL DEFAULT '',"
        "EstadoID INTEGER NOT NULL,"
        "UF TEXT NOT NULL DEFAULT '',"
        "Telefone TEXT NOT NULL DEFAULT '',"
        "Celular TEXT NOT NULL DEFAULT '',"
        "DataNas DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,"
        "UNIQUE(Email),"
        "UNIQUE(CPF),"
        "FOREIGN KEY(CidadeID) REFERENCES cidade(ID) ON DELETE CASCADE,"
        "FOREIGN KEY(EstadoID) REFERENCES estado(ID) ON DELETE CASCADE"
        ");",

    // Table `restaurantes`
    "CREATE TABLE IF NOT EXISTS restaurantes ("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "Nome TEXT NOT NULL DEFAULT '',"
        "Descricao TEXT NOT NULL DEFAULT '',"
        "Endereco TEXT NOT NULL DEFAULT ''"
        ");",

    // Table `pedidos`
    "CREATE TABLE IF NOT EXISTS pedidos ("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "NumeroPedido TEXT NOT NULL DEFAULT '',"
        "UsuarioID INTEGER NOT NULL,"
        "RestauranteID INTEGER NOT NULL,"
        "Status TEXT NOT NULL DEFAULT '',"
        "DataHora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,"
        "UNIQUE(NumeroPedido),"
        "FOREIGN KEY(UsuarioID) REFERENCES usuarios(ID) ON DELETE CASCADE,"
        "FOREIGN KEY(RestauranteID) REFERENCES restaurantes(ID) ON DELETE CASCADE"
        ");",

    // Table `avaliacoes`
    "CREATE TABLE IF NOT EXISTS avaliacoes ("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "PedidoID INTEGER NOT NULL,"
        "Nota INTEGER NOT NULL DEFAULT 0,"
        "CriandoEm DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,"
        "RemovidoEm DATETIME,"
        "likesCount INTEGER UNSIGNED NOT NULL DEFAULT 0,"
        "Comentario TEXT NOT NULL DEFAULT '',"
        "FOREIGN KEY(PedidoID) REFERENCES pedidos(ID) ON DELETE CASCADE"
        ");",

    // Table `categorias`
    "CREATE TABLE IF NOT EXISTS categorias ("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "Nome TEXT NOT NULL DEFAULT ''"
        ");",

    // Table `enderecos_entrega`
    "CREATE TABLE IF NOT EXISTS enderecos_entrega ("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "UsuarioID INTEGER,"
        "Endereco TEXT NOT NULL DEFAULT '',"
        "Numero TEXT NOT NULL DEFAULT '',"
        "Cep TEXT NOT NULL DEFAULT '',"
        "UF TEXT NOT NULL DEFAULT '',"
        "Cidade TEXT NOT NULL DEFAULT '',"
        "FOREIGN KEY(UsuarioID) REFERENCES usuarios(ID) ON DELETE CASCADE"
        ");",

    // Table `produtos`
    "CREATE TABLE IF NOT EXISTS produtos ("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "Nome TEXT NOT NULL DEFAULT '',"
        "Descricao TEXT NOT NULL DEFAULT '',"
        "Preco REAL NOT NULL DEFAULT 0,"
        "RestauranteID INTEGER NOT NULL,"
        "CategoriaID INTEGER NOT NULL,"
        "FOREIGN KEY(RestauranteID) REFERENCES restaurantes(ID) ON DELETE CASCADE,"
        "FOREIGN KEY(CategoriaID) REFERENCES categorias(ID) ON DELETE CASCADE"
        ");",

    // Table `estoque`
    "CREATE TABLE IF NOT EXISTS estoque ("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "Nome TEXT NOT NULL DEFAULT '',"
        "Descricao TEXT NOT NULL DEFAULT '',"
        "Quantidade REAL NOT NULL DEFAULT 0,"
        "RestauranteID INTEGER NOT NULL,"
        "ProdutoID INTEGER NOT NULL,"
        "FOREIGN KEY(RestauranteID) REFERENCES restaurantes(ID) ON DELETE CASCADE,"
        "FOREIGN KEY(ProdutoID) REFERENCES produtos(ID) ON DELETE CASCADE"
        ");",

    // Table `itenspedido`
    "CREATE TABLE IF NOT EXISTS itenspedido ("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "PedidoID INTEGER NOT NULL,"
        "ProdutoID INTEGER NOT NULL,"
        "Quantidade REAL NOT NULL DEFAULT 0,"
        "PrecoUnitario REAL NOT NULL DEFAULT 0,"
        "Subtotal REAL NOT NULL DEFAULT 0,"
        "FOREIGN KEY(PedidoID) REFERENCES pedidos(ID) ON DELETE CASCADE,"
        "FOREIGN KEY(ProdutoID) REFERENCES produtos(ID) ON DELETE CASCADE"
        ");",
  ];

  static const createTables = '''
                    -- Table `estado`
                    CREATE TABLE IF NOT EXISTS estado (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      UFIBGE TEXT NOT NULL DEFAULT '',
                      UF TEXT NOT NULL DEFAULT '',
                      Nome TEXT NOT NULL DEFAULT '',
                      UNIQUE(UF),
                      UNIQUE(UFIBGE)
                    );

                    -- Table `cidade`
                    CREATE TABLE IF NOT EXISTS cidade (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      IBGE TEXT NOT NULL DEFAULT '',
                      Nome TEXT NOT NULL DEFAULT '',
                      UNIQUE(IBGE)
                    );

                    -- Table `usuarios`
                    CREATE TABLE IF NOT EXISTS usuarios (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      Nome TEXT NOT NULL DEFAULT '',
                      NomeUsuario TEXT NOT NULL DEFAULT '',
                      Email TEXT NOT NULL DEFAULT '',
                      Senha TEXT NOT NULL DEFAULT '',
                      CPF TEXT NOT NULL DEFAULT '',
                      Endereco TEXT NOT NULL DEFAULT '',
                      Numero TEXT NOT NULL DEFAULT '',
                      Cep TEXT NOT NULL DEFAULT '',
                      CidadeID INTEGER NOT NULL,
                      Cidade TEXT NOT NULL DEFAULT '',
                      EstadoID INTEGER NOT NULL,
                      UF TEXT NOT NULL DEFAULT '',
                      Telefone TEXT NOT NULL DEFAULT '',
                      Celular TEXT NOT NULL DEFAULT '',
                      DataNas DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                      UNIQUE(Email),
                      UNIQUE(CPF),
                      FOREIGN KEY(CidadeID) REFERENCES cidade(ID) ON DELETE CASCADE,
                      FOREIGN KEY(EstadoID) REFERENCES estado(ID) ON DELETE CASCADE
                    );

                    -- Table `restaurantes`
                    CREATE TABLE IF NOT EXISTS restaurantes (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      Nome TEXT NOT NULL DEFAULT '',
                      Descricao TEXT NOT NULL DEFAULT '',
                      Endereco TEXT NOT NULL DEFAULT ''
                    );

                    -- Table `pedidos`
                    CREATE TABLE IF NOT EXISTS pedidos (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      NumeroPedido TEXT NOT NULL DEFAULT '',
                      UsuarioID INTEGER NOT NULL,
                      RestauranteID INTEGER NOT NULL,
                      Status TEXT NOT NULL DEFAULT '',
                      DataHora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                      UNIQUE(NumeroPedido),
                      FOREIGN KEY(UsuarioID) REFERENCES usuarios(ID) ON DELETE CASCADE,
                      FOREIGN KEY(RestauranteID) REFERENCES restaurantes(ID) ON DELETE CASCADE
                    );

                    -- Table `avaliacoes`
                    CREATE TABLE IF NOT EXISTS avaliacoes (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      PedidoID INTEGER NOT NULL,
                      Nota INTEGER NOT NULL DEFAULT 0,
                      CriandoEm DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                      RemovidoEm DATETIME,
                      likesCount INTEGER UNSIGNED NOT NULL DEFAULT 0,
                      Comentario TEXT NOT NULL DEFAULT '',
                      FOREIGN KEY(PedidoID) REFERENCES pedidos(ID) ON DELETE CASCADE
                    );

                    -- Table `categorias`
                    CREATE TABLE IF NOT EXISTS categorias (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      Nome TEXT NOT NULL DEFAULT ''
                    );

                    -- Table `enderecos_entrega`
                    CREATE TABLE IF NOT EXISTS enderecos_entrega (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      UsuarioID INTEGER,
                      Endereco TEXT NOT NULL DEFAULT '',
                      Numero TEXT NOT NULL DEFAULT '',
                      Cep TEXT NOT NULL DEFAULT '',
                      UF TEXT NOT NULL DEFAULT '',
                      Cidade TEXT NOT NULL DEFAULT '',
                      FOREIGN KEY(UsuarioID) REFERENCES usuarios(ID) ON DELETE CASCADE
                    );

                    -- Table `produtos`
                    CREATE TABLE IF NOT EXISTS produtos (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      Nome TEXT NOT NULL DEFAULT '',
                      Descricao TEXT NOT NULL DEFAULT '',
                      Preco REAL NOT NULL DEFAULT 0,
                      RestauranteID INTEGER NOT NULL,
                      CategoriaID INTEGER NOT NULL,
                      FOREIGN KEY(RestauranteID) REFERENCES restaurantes(ID) ON DELETE CASCADE,
                      FOREIGN KEY(CategoriaID) REFERENCES categorias(ID) ON DELETE CASCADE
                    );

                    -- Table `estoque`
                    CREATE TABLE IF NOT EXISTS estoque (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      Nome TEXT NOT NULL DEFAULT '',
                      Descricao TEXT NOT NULL DEFAULT '',
                      Quantidade REAL NOT NULL DEFAULT 0,
                      RestauranteID INTEGER NOT NULL,
                      ProdutoID INTEGER NOT NULL,
                      FOREIGN KEY(RestauranteID) REFERENCES restaurantes(ID) ON DELETE CASCADE,
                      FOREIGN KEY(ProdutoID) REFERENCES produtos(ID) ON DELETE CASCADE
                    );

                    -- Table `itenspedido`
                    CREATE TABLE IF NOT EXISTS itenspedido (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      PedidoID INTEGER NOT NULL,
                      ProdutoID INTEGER NOT NULL,
                      Quantidade REAL NOT NULL DEFAULT 0,
                      PrecoUnitario REAL NOT NULL DEFAULT 0,
                      Subtotal REAL NOT NULL DEFAULT 0,
                      FOREIGN KEY(PedidoID) REFERENCES pedidos(ID) ON DELETE CASCADE,
                      FOREIGN KEY(ProdutoID) REFERENCES produtos(ID) ON DELETE CASCADE
                    );

          ''';
}
