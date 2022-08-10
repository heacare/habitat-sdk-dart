import 'package:dwn_sdk/src/jose.dart';
import 'package:test/test.dart';

void main() {
  group('JWE', () {
    group('Example JWE Using General JWE JSON Serialization (RFC7516)', () {
      final List<JsonWebKey> keys = <JsonWebKey>[
        JsonWebKey.fromJson(
          <String, dynamic>{
            'kty': 'RSA',
            'kid': '2011-04-29',
            'n': 'sXchDaQebHnPiGvyDOAT4saGEUetSyo9MKLOoWFsueri23bOdgWp4Dy1Wl'
                'UzewbgBHod5pcM9H95GQRV3JDXboIRROSBigeC5yjU1hGzHHyXss8UDpre'
                'cbAYxknTcQkhslANGRUZmdTOQ5qTRsLAt6BTYuyvVRdhS8exSZEy_c4gs_'
                '7svlJJQ4H9_NxsiIoLwAEk7-Q3UXERGYw_75IDrGA84-lA_-Ct4eTlXHBI'
                'Y2EaV7t7LjJaynVJCpkv4LKjTTAumiGUIuQhrNhZLuF_RJLqHpM2kgWFLU'
                '7-VTdL1VbC2tejvcI2BlMkEpk1BzBZI0KQB0GaDWFLN-aEAw3vRw',
            'e': 'AQAB',
            'd': 'VFCWOqXr8nvZNyaaJLXdnNPXZKRaWCjkU5Q2egQQpTBMwhprMzWzpR8Sxq'
                '1OPThh_J6MUD8Z35wky9b8eEO0pwNS8xlh1lOFRRBoNqDIKVOku0aZb-ry'
                'nq8cxjDTLZQ6Fz7jSjR1Klop-YKaUHc9GsEofQqYruPhzSA-QgajZGPbE_'
                '0ZaVDJHfyd7UUBUKunFMScbflYAAOYJqVIVwaYR5zWEEceUjNnTNo_CVSj'
                '-VvXLO5VZfCUAVLgW4dpf1SrtZjSt34YLsRarSb127reG_DUwg9Ch-Kyvj'
                'T1SkHgUWRVGcyly7uvVGRSDwsXypdrNinPA4jlhoNdizK2zF2CWQ',
            'p': '9gY2w6I6S6L0juEKsbeDAwpd9WMfgqFoeA9vEyEUuk4kLwBKcoe1x4HG68'
                'ik918hdDSE9vDQSccA3xXHOAFOPJ8R9EeIAbTi1VwBYnbTp87X-xcPWlEP'
                'krdoUKW60tgs1aNd_Nnc9LEVVPMS390zbFxt8TN_biaBgelNgbC95sM',
            'q': 'uKlCKvKv_ZJMVcdIs5vVSU_6cPtYI1ljWytExV_skstvRSNi9r66jdd9-y'
                'BhVfuG4shsp2j7rGnIio901RBeHo6TPKWVVykPu1iYhQXw1jIABfw-MVsN'
                '-3bQ76WLdt2SDxsHs7q7zPyUyHXmps7ycZ5c72wGkUwNOjYelmkiNS0',
            'dp': 'w0kZbV63cVRvVX6yk3C8cMxo2qCM4Y8nsq1lmMSYhG4EcL6FWbX5h9yuv'
                'ngs4iLEFk6eALoUS4vIWEwcL4txw9LsWH_zKI-hwoReoP77cOdSL4AVcra'
                'Hawlkpyd2TWjE5evgbhWtOxnZee3cXJBkAi64Ik6jZxbvk-RR3pEhnCs',
            'dq': 'o_8V14SezckO6CNLKs_btPdFiO9_kC1DsuUTd2LAfIIVeMZ7jn1Gus_Ff'
                '7B7IVx3p5KuBGOVF8L-qifLb6nQnLysgHDh132NDioZkhH7mI7hPG-PYE_'
                'odApKdnqECHWw0J-F0JWnUd6D2B_1TvF9mXA2Qx-iGYn8OVV1Bsmp6qU',
            'qi': 'eNho5yRBEBxhGBtQRww9QirZsB66TrfFReG_CcteI1aCneT0ELGhYlRlC'
                'tUkTRclIfuEPmNsNDPbLoLqqCVznFbvdB7x-Tl-m0l_eFTj2KiqwGqE9PZ'
                'B9nNTwMVvH3VRRSLWACvPnSiwP8N5Usy-WRXS-V7TbpxIhvepTfE0NNo'
          },
        ),
        JsonWebKey.fromJson(<String, dynamic>{
          'kty': 'oct',
          'k': 'GawgguFyGrWKav7AX4VKUg',
          'kid': '7'
        }),
      ];

      final JWE jwe = JWE.fromJson(<String, dynamic>{
        'protected': 'eyJlbmMiOiJBMTI4Q0JDLUhTMjU2In0',
        'unprotected': <String, dynamic>{
          'jku': 'https://server.example.com/keys.jwks'
        },
        'recipients': <Map<String, dynamic>>[
          <String, dynamic>{
            'header': <String, dynamic>{'alg': 'RSA1_5', 'kid': '2011-04-29'},
            'encrypted_key': 'UGhIOguC7IuEvf_NPVaXsGMoLOmwvc1GyqlIKOK1nN94nHPoltGRhWhw7Zx0-'
                'kFm1NJn8LE9XShH59_i8J0PH5ZZyNfGy2xGdULU7sHNF6Gp2vPLgNZ__deLKx'
                'GHZ7PcHALUzoOegEI-8E66jX2E4zyJKx-YxzZIItRzC5hlRirb6Y5Cl_p-ko3'
                'YvkkysZIFNPccxRU7qve1WYPxqbb2Yw8kZqa2rMWI5ng8OtvzlV7elprCbuPh'
                'cCdZ6XDP0_F8rkXds2vE4X-ncOIM8hAYHHi29NX0mcKiRaD0-D-ljQTP-cFPg'
                'wCp6X-nZZd9OHBv-B3oWh2TbqmScqXMR4gp_A'
          },
          <String, dynamic>{
            'header': <String, dynamic>{'alg': 'A128KW', 'kid': '7'},
            'encrypted_key':
                '6KB707dM9YTIgHtLvtgWQ8mKwboJW3of9locizkDTHzBC2IlrT1oOQ'
          }
        ],
        'iv': 'AxY8DCtDaGlsbGljb3RoZQ',
        'ciphertext': 'KDlTtXchhZTGufMYmOYGS4HffxPSUrfmqCHXaI9wOGY',
        'tag': 'Mz-VPPyU4RlcuYv1IwIvzw'
      });

      test('Decrypt using key 1', () async {
        final JsonWebKeyStore keyStore = JsonWebKeyStore()..addKey(keys[0]);

        final JosePayload payload = await jwe.jwe.getPayload(keyStore);
        expect(payload.stringContent, 'Live long and prosper.');
      });

      test('Decrypt using key 2', () async {
        final JsonWebKeyStore keyStore = JsonWebKeyStore()..addKey(keys[1]);

        final JosePayload payload = await jwe.jwe.getPayload(keyStore);
        expect(payload.stringContent, 'Live long and prosper.');
      });
    });

    group('Example JWE with one recipient', () {
      final JWE jwe = JWE.fromJson(<String, dynamic>{
        'protected': 'eyJlbmMiOiJBMTI4Q0JDLUhTMjU2In0',
        'recipients': <Map<String, dynamic>>[
          <String, dynamic>{
            'header': <String, dynamic>{'alg': 'A128KW', 'kid': '7'},
            'encrypted_key':
                '6KB707dM9YTIgHtLvtgWQ8mKwboJW3of9locizkDTHzBC2IlrT1oOQ'
          }
        ],
        'iv': 'AxY8DCtDaGlsbGljb3RoZQ',
        'ciphertext': 'KDlTtXchhZTGufMYmOYGS4HffxPSUrfmqCHXaI9wOGY',
        'tag': 'Mz-VPPyU4RlcuYv1IwIvzw'
      });

      test('Encoding round trip', () async {
        expect(jwe.toJson(), <String, dynamic>{
          'protected': 'eyJlbmMiOiJBMTI4Q0JDLUhTMjU2In0',
          'recipients': <Map<String, dynamic>>[
            <String, dynamic>{
              'header': <String, dynamic>{'alg': 'A128KW', 'kid': '7'},
              'encrypted_key':
                  '6KB707dM9YTIgHtLvtgWQ8mKwboJW3of9locizkDTHzBC2IlrT1oOQ'
            }
          ],
          'iv': 'AxY8DCtDaGlsbGljb3RoZQ',
          'ciphertext': 'KDlTtXchhZTGufMYmOYGS4HffxPSUrfmqCHXaI9wOGY',
          'tag': 'Mz-VPPyU4RlcuYv1IwIvzw'
        });
      });
    });
  });

  group('JWS', () {
    group('Example JWS Using General JWS JSON Serialization (RFC7515)', () {
      final List<JsonWebKey> keys = <JsonWebKey>[
        JsonWebKey.fromJson(<String, dynamic>{
          'kty': 'RSA',
          'kid': '2010-12-29',
          'n': 'ofgWCuLjybRlzo0tZWJjNiuSfb4p4fAkd_wWJcyQoTbji9k0l8W26mPddx'
              'HmfHQp-Vaw-4qPCJrcS2mJPMEzP1Pt0Bm4d4QlL-yRT-SFd2lZS-pCgNMs'
              'D1W_YpRPEwOWvG6b32690r2jZ47soMZo9wGzjb_7OMg0LOL-bSf63kpaSH'
              'SXndS5z5rexMdbBYUsLA9e-KXBdQOS-UTo7WTBEMa2R2CapHg665xsmtdV'
              'MTBQY4uDZlxvb3qCo5ZwKh9kG4LT6_I5IhlJH7aGhyxXFvUK-DWNmoudF8'
              'NAco9_h9iaGNj8q2ethFkMLs91kzk2PAcDTW9gb54h4FRWyuXpoQ',
          'e': 'AQAB',
          'd': 'Eq5xpGnNCivDflJsRQBXHx1hdR1k6Ulwe2JZD50LpXyWPEAeP88vLNO97I'
              'jlA7_GQ5sLKMgvfTeXZx9SE-7YwVol2NXOoAJe46sui395IW_GO-pWJ1O0'
              'BkTGoVEn2bKVRUCgu-GjBVaYLU6f3l9kJfFNS3E0QbVdxzubSu3Mkqzjkn'
              '439X0M_V51gfpRLI9JYanrC4D4qAdGcopV_0ZHHzQlBjudU2QvXt4ehNYT'
              'CBr6XCLQUShb1juUO1ZdiYoFaFQT5Tw8bGUl_x_jTj3ccPDVZFD9pIuhLh'
              'BOneufuBiB4cS98l2SR_RQyGWSeWjnczT0QU91p1DhOVRuOopznQ',
          'p': '4BzEEOtIpmVdVEZNCqS7baC4crd0pqnRH_5IB3jw3bcxGn6QLvnEtfdUdi'
              'YrqBdss1l58BQ3KhooKeQTa9AB0Hw_Py5PJdTJNPY8cQn7ouZ2KKDcmnPG'
              'BY5t7yLc1QlQ5xHdwW1VhvKn-nXqhJTBgIPgtldC-KDV5z-y2XDwGUc',
          'q': 'uQPEfgmVtjL0Uyyx88GZFF1fOunH3-7cepKmtH4pxhtCoHqpWmT8YAmZxa'
              'ewHgHAjLYsp1ZSe7zFYHj7C6ul7TjeLQeZD_YwD66t62wDmpe_HlB-TnBA'
              '-njbglfIsRLtXlnDzQkv5dTltRJ11BKBBypeeF6689rjcJIDEz9RWdc',
          'dp': 'BwKfV3Akq5_MFZDFZCnW-wzl-CCo83WoZvnLQwCTeDv8uzluRSnm71I3Q'
              'CLdhrqE2e9YkxvuxdBfpT_PI7Yz-FOKnu1R6HsJeDCjn12Sk3vmAktV2zb'
              '34MCdy7cpdTh_YVr7tss2u6vneTwrA86rZtu5Mbr1C1XsmvkxHQAdYo0',
          'dq': 'h_96-mK1R_7glhsum81dZxjTnYynPbZpHziZjeeHcXYsXaaMwkOlODsWa'
              '7I9xXDoRwbKgB719rrmI2oKr6N3Do9U0ajaHF-NKJnwgjMd2w9cjz3_-ky'
              'NlxAr2v4IKhGNpmM5iIgOS1VZnOZ68m6_pbLBSp3nssTdlqvd0tIiTHU',
          'qi': 'IYd7DHOhrWvxkwPQsRM2tOgrjbcrfvtQJipd-DlcxyVuuM9sQLdgjVk2o'
              'y26F0EmpScGLq2MowX7fhd_QJQ3ydy5cY7YIBi87w93IKLEdfnbJtoOPLU'
              'W0ITrJReOgo1cq9SbsxYawBgfp_gh6A5603k2-ZQwVK0JKSHuLFkuQ3U'
        }),
        JsonWebKey.fromJson(<String, dynamic>{
          'kid': 'e9bc097a-ce51-4036-9562-d2ade882db0d',
          'kty': 'EC',
          'crv': 'P-256',
          'x': 'f83OJ3D2xF1Bg8vub9tLe1gHMzV76e8Tus9uPHvRVEU',
          'y': 'x_FEzRu9m36HLN_tue659LNpXW6pCyStikYjKIWI5a0',
          'd': 'jpsQnnGQmL-YBIffH1136cspYG6-0iY7X1fCE9-E9LI'
        }),
      ];

      final JWS jws = JWS.fromJson(<String, dynamic>{
        'payload':
            'eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGF'
                'tcGxlLmNvbS9pc19yb290Ijp0cnVlfQ',
        'signatures': <Map<String, dynamic>>[
          <String, dynamic>{
            'protected': 'eyJhbGciOiJSUzI1NiJ9',
            'header': <String, dynamic>{'kid': '2010-12-29'},
            'signature': 'cC4hiUPoj9Eetdgtv3hF80EGrhuB__dzERat0XF9g2VtQgr9PJbu3XOiZj5RZ'
                'mh7AAuHIm4Bh-0Qc_lF5YKt_O8W2Fp5jujGbds9uJdbF9CUAr7t1dnZcAcQjb'
                'KBYNX4BAynRFdiuB--f_nZLgrnbyTyWzO75vRK5h6xBArLIARNPvkSjtQBMHl'
                'b1L07Qe7K0GarZRmB_eSN9383LcOLn6_dO--xi12jzDwusC-eOkHWEsqtFZES'
                'c6BfI7noOPqvhJ1phCnvWh6IeYI2w9QOYEUipUTI8np6LbgGY9Fs98rqVt5AX'
                'LIhWkWywlVmtVrBp0igcN_IoypGlUPQGe77Rw'
          },
          <String, dynamic>{
            'protected': 'eyJhbGciOiJFUzI1NiJ9',
            'header': <String, dynamic>{
              'kid': 'e9bc097a-ce51-4036-9562-d2ade882db0d'
            },
            'signature':
                'DtEhU3ljbEg8L38VWAfUAqOyKAM6-Xx-F4GawxaepmXFCgfTjDxw5djxLa8IS'
                    'lSApmWQxfKTUJqPP3-Kg6NU1Q'
          }
        ]
      });

      test('Verify using key 1', () async {
        final JsonWebKeyStore keyStore = JsonWebKeyStore()..addKey(keys[0]);

        final JosePayload payload = await jws.jws.getPayload(keyStore);
        expect(
          payload.stringContent,
          '{"iss":"joe",\r\n "exp":1300819380,\r\n "http://example.com/is_root":true}',
        );
      });

      test('Verify using key 2', () async {
        final JsonWebKeyStore keyStore = JsonWebKeyStore()..addKey(keys[1]);

        final JosePayload payload = await jws.jws.getPayload(keyStore);
        expect(
          payload.stringContent,
          '{"iss":"joe",\r\n "exp":1300819380,\r\n "http://example.com/is_root":true}',
        );
      });
    });

    group('Example JWS with one recipient', () {
      final JWS jws = JWS.fromJson(<String, dynamic>{
        'payload':
            'eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGF'
                'tcGxlLmNvbS9pc19yb290Ijp0cnVlfQ',
        'signatures': <Map<String, dynamic>>[
          <String, dynamic>{
            'protected': 'eyJhbGciOiJFUzI1NiJ9',
            'header': <String, dynamic>{
              'kid': 'e9bc097a-ce51-4036-9562-d2ade882db0d'
            },
            'signature':
                'DtEhU3ljbEg8L38VWAfUAqOyKAM6-Xx-F4GawxaepmXFCgfTjDxw5djxLa8IS'
                    'lSApmWQxfKTUJqPP3-Kg6NU1Q'
          }
        ]
      });

      test('Encoding round trip', () async {
        expect(jws.toJson(), <String, dynamic>{
          'payload':
              'eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGF'
                  'tcGxlLmNvbS9pc19yb290Ijp0cnVlfQ',
          'signatures': <Map<String, dynamic>>[
            <String, dynamic>{
              'protected': 'eyJhbGciOiJFUzI1NiJ9',
              'header': <String, dynamic>{
                'kid': 'e9bc097a-ce51-4036-9562-d2ade882db0d'
              },
              'signature':
                  'DtEhU3ljbEg8L38VWAfUAqOyKAM6-Xx-F4GawxaepmXFCgfTjDxw5djxLa8IS'
                      'lSApmWQxfKTUJqPP3-Kg6NU1Q'
            }
          ]
        });
      });
    });
  });
}
