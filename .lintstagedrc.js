module.exports = {
  '*.ts': ['npm run test', 'npm run lint --fix'],
  '*.{ts,md,sol}': 'npm run format',
};
