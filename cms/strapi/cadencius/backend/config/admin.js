module.exports = ({ env }) => ({
  auth: {
    secret: env('ADMIN_JWT_SECRET', '6cf17d7368c751c0d55e1d5559258b62'),
  },
});
