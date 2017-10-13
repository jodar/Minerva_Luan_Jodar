# Desenvolvimento do Blog

Foi adicionado nos controllers, `Posts` e `Comments`, autenticação para os
endpoints. O único método que não requer autenticação é o `index` de
ambos os `controllers`.

Para desenvolvimento da API fiz diversas pesquisas, principalmente para
elaboração dos testes. No geral, para o desenvolvimento do sistema, me guiei
basicamente por tutorias e artigos. Além disso, consegui por em prática
algumas técnicas que aprende ao longo do projeto freela na qual trabalho.

Para testar as Endpoints, utilizei POSTMAN e CURL.
Também foi adicionado testes com RSpec: Testes de requests e models.

Nos testes, utilizei a gem FactoryGirl, Pry, Faker, shoulda-matchers...
