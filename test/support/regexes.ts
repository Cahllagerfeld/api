const stringRegex = new RegExp(/(.*?)/);
const documentId = new RegExp(/[\S]{8}-[\S]{4}-[\S]{4}-[\S]{4}-[\S]{12}/);
const numberRegex = new RegExp(/[0-9]+/);
const dateRegex = new RegExp(
  /\d{4}-[01]\d-[0-3]\dT[0-2]\d:[0-5]\d:[0-5]\d\.\d+([+-][0-2]\d:[0-5]\d|Z)/,
);
const versionRegex = new RegExp(
  /Currently running version: \d{1,3}.\d{1,3}.\d{1,3}/,
);

export function getRegex(type: string): RegExp {
  switch (type) {
    case 'TYPE:ID':
      return documentId;

    case 'TYPE:STRING':
      return stringRegex;

    case 'TYPE:NUMBER':
      return numberRegex;

    case 'TYPE:DATE':
      return dateRegex;
    case 'TYPE:VERSION':
      return versionRegex;
    default:
      break;
  }
}
