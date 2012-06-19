module.exports = (sequelize, dataType) ->
  MassiveShot = sequelize.define 'MassiveShot',
    id: dataType.TEXT
    filename: dataType.STRING