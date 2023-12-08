Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 787B780990E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:11:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQKI-00088r-31; Thu, 07 Dec 2023 21:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rBQKF-00088d-Ds
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 21:10:47 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rBQK8-0006mp-M3
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 21:10:45 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ceb27ec331so1074774b3a.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 18:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1702001435; x=1702606235;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7BU7xqHAal3gA8jELYQr+XbFEttsb/vrLSv/B0ihyK0=;
 b=kWejVR3M8ZPGWIaN691exaz1oeHqSpCoId4sKbqGZrKt2DkUxTfe1ZzbLtZK4Lfn+2
 UDi13UQ8nwdK51IFcfISC8C2q5Mmta2mfH+MufBZ/vTuIXGIMZD1Q8GQ5OIbpu4T8VDU
 cyOIpHOo645fYeDSp8Yl/0vE5YD68jHPu1y2lLK/RTxLKus63cJz7F97H/sKZrlxOHY4
 z8S/3VemzvwB4Y3W4Hbg84wU/9WofOxPw8KqW9pRE1PINtHebxuWDyix42S8TH72jkNQ
 u/PuaJ+ztutOGP4cNgNs4TykltRdBikGn6lHuGlJS4lwUJ+G+E+k85MUMgC1MmhbrAF2
 Qzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702001435; x=1702606235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7BU7xqHAal3gA8jELYQr+XbFEttsb/vrLSv/B0ihyK0=;
 b=AJ2fK+y0ph9MdoLmh/GTRbKPB7UJ4ZWfCj6t4U9LUXsCJYwdR1Au5EzT1xAuifXDQg
 h5jiqZv/H38ODh6AwiFXg4KkQT09sHU/Vkp79B0pliqfM4JeoJfteI/Z67fuefq3bQN8
 +20Y3gtMlnK3a9qoisSUlHpQklxUttn6/AFrURnCVhK1Frp0OLLmnTVfqU+4HG9DLZE5
 wrSZIAGb6IrFyYCxHWm3Wo9rRM6Xs5Uq1axXS1cNuuEGi/PB0igQ0mYYojzx+SCXpQXb
 Ui8vqLK/piO3/7gnzVeCqKDsuEPYVqHW7w7O9UnEset0QtZUcXqHcvPW8O1kdG53EEdZ
 o7KA==
X-Gm-Message-State: AOJu0Yz4BgeVgEO2WCiXvckbBELGZjRKv4nqRmveNdMkdZurXzUTbzR6
 /A3PMzbjlQv6/H4rudwbz6IZ+wXkSY94d3xPcWqPKA==
X-Google-Smtp-Source: AGHT+IFMmZRTVcks+cnySqAS06wEHwQmzhLML1DHnxLdMhMfxv6g03O/dNiNh2lFmXKUdnZzeFS1eEvnEndCDkKqU+4=
X-Received: by 2002:a05:6a20:cea7:b0:187:6dd3:946c with SMTP id
 if39-20020a056a20cea700b001876dd3946cmr3072662pzb.61.1702001434113; Thu, 07
 Dec 2023 18:10:34 -0800 (PST)
MIME-Version: 1.0
References: <95b77afe68b898c95d381c9aa039c16b54d2e525.1701963950.git.yong.huang@smartx.com>
 <1634c2c0-c4aa-4b9f-9e2c-83b6ad9fab7e@linaro.org>
In-Reply-To: <1634c2c0-c4aa-4b9f-9e2c-83b6ad9fab7e@linaro.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 8 Dec 2023 10:10:18 +0800
Message-ID: <CAK9dgmaX1F5AXZgZNDVFLDRfcpuU6iMhraeu7VhVxeBD9aZCOg@mail.gmail.com>
Subject: Re: [PATCH v6] crypto: Introduce SM4 symmetric cipher algorithm
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e34577060bf616c4"
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--000000000000e34577060bf616c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll post the changelog between versions in the next version if needed. :)

v6:
- modify the comment about how to enable sm4 crypto feature
v5:
- drop the crypto-sm4 option in build system
v4
- refactor the error report info, change "sm4"->"libsm4"

On Fri, Dec 8, 2023 at 12:02=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Hyman,
>
> On 7/12/23 16:47, Hyman Huang wrote:
> > Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> >
> > SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> > Organization of State Commercial Administration of China (OSCCA)
> > as an authorized cryptographic algorithms for the use within China.
> >
> > Detect the SM4 cipher algorithms and enable the feature silently
> > if it is available.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
>
> What are the changes since v4/v5?
>
> >   crypto/block-luks.c             | 11 ++++++++
> >   crypto/cipher-gcrypt.c.inc      |  8 ++++++
> >   crypto/cipher-nettle.c.inc      | 49 ++++++++++++++++++++++++++++++++=
+
> >   crypto/cipher.c                 |  6 ++++
> >   meson.build                     | 26 +++++++++++++++++
> >   qapi/crypto.json                |  5 +++-
> >   tests/unit/test-crypto-cipher.c | 13 +++++++++
> >   7 files changed, 117 insertions(+), 1 deletion(-)
> >
> > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > index fb01ec38bb..f0813d69b4 100644
> > --- a/crypto/block-luks.c
> > +++ b/crypto/block-luks.c
> > @@ -95,12 +95,23 @@ qcrypto_block_luks_cipher_size_map_twofish[] =3D {
> >       { 0, 0 },
> >   };
> >
> > +#ifdef CONFIG_CRYPTO_SM4
> > +static const QCryptoBlockLUKSCipherSizeMap
> > +qcrypto_block_luks_cipher_size_map_sm4[] =3D {
> > +    { 16, QCRYPTO_CIPHER_ALG_SM4},
> > +    { 0, 0 },
> > +};
> > +#endif
> > +
> >   static const QCryptoBlockLUKSCipherNameMap
> >   qcrypto_block_luks_cipher_name_map[] =3D {
> >       { "aes", qcrypto_block_luks_cipher_size_map_aes },
> >       { "cast5", qcrypto_block_luks_cipher_size_map_cast5 },
> >       { "serpent", qcrypto_block_luks_cipher_size_map_serpent },
> >       { "twofish", qcrypto_block_luks_cipher_size_map_twofish },
> > +#ifdef CONFIG_CRYPTO_SM4
> > +    { "sm4", qcrypto_block_luks_cipher_size_map_sm4},
> > +#endif
> >   };
> >
> >   QEMU_BUILD_BUG_ON(sizeof(struct QCryptoBlockLUKSKeySlot) !=3D 48);
> > diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
> > index a6a0117717..1377cbaf14 100644
> > --- a/crypto/cipher-gcrypt.c.inc
> > +++ b/crypto/cipher-gcrypt.c.inc
> > @@ -35,6 +35,9 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm
> alg,
> >       case QCRYPTO_CIPHER_ALG_SERPENT_256:
> >       case QCRYPTO_CIPHER_ALG_TWOFISH_128:
> >       case QCRYPTO_CIPHER_ALG_TWOFISH_256:
> > +#ifdef CONFIG_CRYPTO_SM4
> > +    case QCRYPTO_CIPHER_ALG_SM4:
> > +#endif
> >           break;
> >       default:
> >           return false;
> > @@ -219,6 +222,11 @@ static QCryptoCipher
> *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
> >       case QCRYPTO_CIPHER_ALG_TWOFISH_256:
> >           gcryalg =3D GCRY_CIPHER_TWOFISH;
> >           break;
> > +#ifdef CONFIG_CRYPTO_SM4
> > +    case QCRYPTO_CIPHER_ALG_SM4:
> > +        gcryalg =3D GCRY_CIPHER_SM4;
> > +        break;
> > +#endif
> >       default:
> >           error_setg(errp, "Unsupported cipher algorithm %s",
> >                      QCryptoCipherAlgorithm_str(alg));
> > diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
> > index 24cc61f87b..42b39e18a2 100644
> > --- a/crypto/cipher-nettle.c.inc
> > +++ b/crypto/cipher-nettle.c.inc
> > @@ -33,6 +33,9 @@
> >   #ifndef CONFIG_QEMU_PRIVATE_XTS
> >   #include <nettle/xts.h>
> >   #endif
> > +#ifdef CONFIG_CRYPTO_SM4
> > +#include <nettle/sm4.h>
> > +#endif
> >
> >   static inline bool qcrypto_length_check(size_t len, size_t blocksize,
> >                                           Error **errp)
> > @@ -426,6 +429,30 @@ DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_twofish,
> >                          QCryptoNettleTwofish, TWOFISH_BLOCK_SIZE,
> >                          twofish_encrypt_native, twofish_decrypt_native=
)
> >
> > +#ifdef CONFIG_CRYPTO_SM4
> > +typedef struct QCryptoNettleSm4 {
> > +    QCryptoCipher base;
> > +    struct sm4_ctx key[2];
> > +} QCryptoNettleSm4;
> > +
> > +static void sm4_encrypt_native(void *ctx, size_t length,
> > +                               uint8_t *dst, const uint8_t *src)
> > +{
> > +    struct sm4_ctx *keys =3D ctx;
> > +    sm4_crypt(&keys[0], length, dst, src);
> > +}
> > +
> > +static void sm4_decrypt_native(void *ctx, size_t length,
> > +                               uint8_t *dst, const uint8_t *src)
> > +{
> > +    struct sm4_ctx *keys =3D ctx;
> > +    sm4_crypt(&keys[1], length, dst, src);
> > +}
> > +
> > +DEFINE_ECB(qcrypto_nettle_sm4,
> > +           QCryptoNettleSm4, SM4_BLOCK_SIZE,
> > +           sm4_encrypt_native, sm4_decrypt_native)
> > +#endif
> >
> >   bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
> >                                QCryptoCipherMode mode)
> > @@ -443,6 +470,9 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm
> alg,
> >       case QCRYPTO_CIPHER_ALG_TWOFISH_128:
> >       case QCRYPTO_CIPHER_ALG_TWOFISH_192:
> >       case QCRYPTO_CIPHER_ALG_TWOFISH_256:
> > +#ifdef CONFIG_CRYPTO_SM4
> > +    case QCRYPTO_CIPHER_ALG_SM4:
> > +#endif
> >           break;
> >       default:
> >           return false;
> > @@ -701,6 +731,25 @@ static QCryptoCipher
> *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
> >
> >               return &ctx->base;
> >           }
> > +#ifdef CONFIG_CRYPTO_SM4
> > +    case QCRYPTO_CIPHER_ALG_SM4:
> > +        {
> > +            QCryptoNettleSm4 *ctx =3D g_new0(QCryptoNettleSm4, 1);
> > +
> > +            switch (mode) {
> > +            case QCRYPTO_CIPHER_MODE_ECB:
> > +                ctx->base.driver =3D &qcrypto_nettle_sm4_driver_ecb;
> > +                break;
> > +            default:
> > +                goto bad_cipher_mode;
> > +            }
> > +
> > +            sm4_set_encrypt_key(&ctx->key[0], key);
> > +            sm4_set_decrypt_key(&ctx->key[1], key);
> > +
> > +            return &ctx->base;
> > +        }
> > +#endif
> >
> >       default:
> >           error_setg(errp, "Unsupported cipher algorithm %s",
> > diff --git a/crypto/cipher.c b/crypto/cipher.c
> > index 74b09a5b26..5f512768ea 100644
> > --- a/crypto/cipher.c
> > +++ b/crypto/cipher.c
> > @@ -38,6 +38,9 @@ static const size_t
> alg_key_len[QCRYPTO_CIPHER_ALG__MAX] =3D {
> >       [QCRYPTO_CIPHER_ALG_TWOFISH_128] =3D 16,
> >       [QCRYPTO_CIPHER_ALG_TWOFISH_192] =3D 24,
> >       [QCRYPTO_CIPHER_ALG_TWOFISH_256] =3D 32,
> > +#ifdef CONFIG_CRYPTO_SM4
> > +    [QCRYPTO_CIPHER_ALG_SM4] =3D 16,
> > +#endif
> >   };
> >
> >   static const size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] =3D {
> > @@ -53,6 +56,9 @@ static const size_t
> alg_block_len[QCRYPTO_CIPHER_ALG__MAX] =3D {
> >       [QCRYPTO_CIPHER_ALG_TWOFISH_128] =3D 16,
> >       [QCRYPTO_CIPHER_ALG_TWOFISH_192] =3D 16,
> >       [QCRYPTO_CIPHER_ALG_TWOFISH_256] =3D 16,
> > +#ifdef CONFIG_CRYPTO_SM4
> > +    [QCRYPTO_CIPHER_ALG_SM4] =3D 16,
> > +#endif
> >   };
> >
> >   static const bool mode_need_iv[QCRYPTO_CIPHER_MODE__MAX] =3D {
> > diff --git a/meson.build b/meson.build
> > index d2c4c2adb3..52f2f85b5a 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1480,6 +1480,7 @@ endif
> >   gcrypt =3D not_found
> >   nettle =3D not_found
> >   hogweed =3D not_found
> > +crypto_sm4 =3D not_found
> >   xts =3D 'none'
> >
> >   if get_option('nettle').enabled() and get_option('gcrypt').enabled()
> > @@ -1505,6 +1506,17 @@ if not gnutls_crypto.found()
> >            cc.find_library('gpg-error', required: true)],
> >           version: gcrypt.version())
> >       endif
> > +    crypto_sm4 =3D gcrypt
> > +    # SM4 ALG is available in libgcrypt >=3D 1.9
> > +    if gcrypt.found() and not cc.links('''
> > +      #include <gcrypt.h>
> > +      int main(void) {
> > +        gcry_cipher_hd_t handler;
> > +        gcry_cipher_open(&handler, GCRY_CIPHER_SM4,
> GCRY_CIPHER_MODE_ECB, 0);
> > +        return 0;
> > +      }''', dependencies: gcrypt)
> > +      crypto_sm4 =3D not_found
> > +    endif
> >     endif
> >     if (not get_option('nettle').auto() or have_system) and not
> gcrypt.found()
> >       nettle =3D dependency('nettle', version: '>=3D3.4',
> > @@ -1513,6 +1525,18 @@ if not gnutls_crypto.found()
> >       if nettle.found() and not cc.has_header('nettle/xts.h',
> dependencies: nettle)
> >         xts =3D 'private'
> >       endif
> > +    crypto_sm4 =3D nettle
> > +    # SM4 ALG is available in nettle >=3D 3.9
> > +    if nettle.found() and not cc.links('''
> > +      #include <nettle/sm4.h>
> > +      int main(void) {
> > +        struct sm4_ctx ctx;
> > +        unsigned char key[16] =3D {0};
> > +        sm4_set_encrypt_key(&ctx, key);
> > +        return 0;
> > +      }''', dependencies: nettle)
> > +      crypto_sm4 =3D not_found
> > +    endif
> >     endif
> >   endif
> >
> > @@ -2199,6 +2223,7 @@ config_host_data.set('CONFIG_GNUTLS_CRYPTO',
> gnutls_crypto.found())
> >   config_host_data.set('CONFIG_TASN1', tasn1.found())
> >   config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
> >   config_host_data.set('CONFIG_NETTLE', nettle.found())
> > +config_host_data.set('CONFIG_CRYPTO_SM4', crypto_sm4.found())
> >   config_host_data.set('CONFIG_HOGWEED', hogweed.found())
> >   config_host_data.set('CONFIG_QEMU_PRIVATE_XTS', xts =3D=3D 'private')
> >   config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
> > @@ -4274,6 +4299,7 @@ summary_info +=3D {'nettle':            nettle}
> >   if nettle.found()
> >      summary_info +=3D {'  XTS':             xts !=3D 'private'}
> >   endif
> > +summary_info +=3D {'SM4 ALG support':   crypto_sm4}
> >   summary_info +=3D {'AF_ALG support':    have_afalg}
> >   summary_info +=3D {'rng-none':          get_option('rng_none')}
> >   summary_info +=3D {'Linux keyring':     have_keyring}
> > diff --git a/qapi/crypto.json b/qapi/crypto.json
> > index fd3d46ebd1..2f2aeff5fd 100644
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -94,6 +94,8 @@
> >   #
> >   # @twofish-256: Twofish with 256 bit / 32 byte keys
> >   #
> > +# @sm4: SM4 with 128 bit / 16 byte keys (since 9.0)
> > +#
> >   # Since: 2.6
> >   ##
> >   { 'enum': 'QCryptoCipherAlgorithm',
> > @@ -102,7 +104,8 @@
> >              'des', '3des',
> >              'cast5-128',
> >              'serpent-128', 'serpent-192', 'serpent-256',
> > -           'twofish-128', 'twofish-192', 'twofish-256']}
> > +           'twofish-128', 'twofish-192', 'twofish-256',
> > +           'sm4']}
> >
> >   ##
> >   # @QCryptoCipherMode:
> > diff --git a/tests/unit/test-crypto-cipher.c
> b/tests/unit/test-crypto-cipher.c
> > index d9d9d078ff..11ab1a54fc 100644
> > --- a/tests/unit/test-crypto-cipher.c
> > +++ b/tests/unit/test-crypto-cipher.c
> > @@ -382,6 +382,19 @@ static QCryptoCipherTestData test_data[] =3D {
> >           .plaintext =3D "90afe91bb288544f2c32dc239b2635e6",
> >           .ciphertext =3D "6cb4561c40bf0a9705931cb6d408e7fa",
> >       },
> > +#ifdef CONFIG_CRYPTO_SM4
> > +    {
> > +        /* SM4, GB/T 32907-2016, Appendix A.1 */
> > +        .path =3D "/crypto/cipher/sm4",
> > +        .alg =3D QCRYPTO_CIPHER_ALG_SM4,
> > +        .mode =3D QCRYPTO_CIPHER_MODE_ECB,
> > +        .key =3D "0123456789abcdeffedcba9876543210",
> > +        .plaintext  =3D
> > +            "0123456789abcdeffedcba9876543210",
> > +        .ciphertext =3D
> > +            "681edf34d206965e86b3e94f536e4246",
> > +    },
> > +#endif
> >       {
> >           /* #1 32 byte key, 32 byte PTX */
> >           .path =3D "/crypto/cipher/aes-xts-128-1",
>
>
Thanks,
Yong

--=20
Best regards

--000000000000e34577060bf616c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">I&#39;ll post the changelog =
between versions in the next version if needed. :)</div><div class=3D"gmail=
_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></=
div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&q=
uot;,sans-serif">v6:</div><div class=3D"gmail_default"><span style=3D"font-=
family:&quot;comic sans ms&quot;,sans-serif">- modify the comment about how=
 to enable sm4 crypto feature</span></div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">v5:</div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">- drop the crypto-sm4 option in build system</div><div class=3D"gmail_de=
fault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">v4</div><=
div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,=
sans-serif">- refactor the error report info, change &quot;sm4&quot;-&gt;&q=
uot;libsm4&quot;</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Fri, Dec 8, 2023 at 12:02=E2=80=AFAM Philippe Math=
ieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-c=
olor:rgb(204,204,204);padding-left:1ex">Hi Hyman,<br>
<br>
On 7/12/23 16:47, Hyman Huang wrote:<br>
&gt; Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).<br>
&gt; <br>
&gt; SM4 (GBT.32907-2016) is a cryptographic standard issued by the<br>
&gt; Organization of State Commercial Administration of China (OSCCA)<br>
&gt; as an authorized cryptographic algorithms for the use within China.<br=
>
&gt; <br>
&gt; Detect the SM4 cipher algorithms and enable the feature silently<br>
&gt; if it is available.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; ---<br>
<br>
What are the changes since v4/v5?<br>
<br>
&gt;=C2=A0 =C2=A0crypto/block-luks.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 11 ++++++++<br>
&gt;=C2=A0 =C2=A0crypto/cipher-gcrypt.c.inc=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +=
+++++<br>
&gt;=C2=A0 =C2=A0crypto/cipher-nettle.c.inc=C2=A0 =C2=A0 =C2=A0 | 49 ++++++=
+++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0crypto/cipher.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++++<br>
&gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 26 +++++++++++++++++<br>
&gt;=C2=A0 =C2=A0qapi/crypto.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 5 +++-<br>
&gt;=C2=A0 =C2=A0tests/unit/test-crypto-cipher.c | 13 +++++++++<br>
&gt;=C2=A0 =C2=A07 files changed, 117 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/crypto/block-luks.c b/crypto/block-luks.c<br>
&gt; index fb01ec38bb..f0813d69b4 100644<br>
&gt; --- a/crypto/block-luks.c<br>
&gt; +++ b/crypto/block-luks.c<br>
&gt; @@ -95,12 +95,23 @@ qcrypto_block_luks_cipher_size_map_twofish[] =3D {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0, 0 },<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#ifdef CONFIG_CRYPTO_SM4<br>
&gt; +static const QCryptoBlockLUKSCipherSizeMap<br>
&gt; +qcrypto_block_luks_cipher_size_map_sm4[] =3D {<br>
&gt; +=C2=A0 =C2=A0 { 16, QCRYPTO_CIPHER_ALG_SM4},<br>
&gt; +=C2=A0 =C2=A0 { 0, 0 },<br>
&gt; +};<br>
&gt; +#endif<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static const QCryptoBlockLUKSCipherNameMap<br>
&gt;=C2=A0 =C2=A0qcrypto_block_luks_cipher_name_map[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;aes&quot;, qcrypto_block_luks_cipher=
_size_map_aes },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;cast5&quot;, qcrypto_block_luks_ciph=
er_size_map_cast5 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;serpent&quot;, qcrypto_block_luks_ci=
pher_size_map_serpent },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;twofish&quot;, qcrypto_block_luks_ci=
pher_size_map_twofish },<br>
&gt; +#ifdef CONFIG_CRYPTO_SM4<br>
&gt; +=C2=A0 =C2=A0 { &quot;sm4&quot;, qcrypto_block_luks_cipher_size_map_s=
m4},<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0QEMU_BUILD_BUG_ON(sizeof(struct QCryptoBlockLUKSKeySlot) !=
=3D 48);<br>
&gt; diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc<b=
r>
&gt; index a6a0117717..1377cbaf14 100644<br>
&gt; --- a/crypto/cipher-gcrypt.c.inc<br>
&gt; +++ b/crypto/cipher-gcrypt.c.inc<br>
&gt; @@ -35,6 +35,9 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm =
alg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case QCRYPTO_CIPHER_ALG_SERPENT_256:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case QCRYPTO_CIPHER_ALG_TWOFISH_128:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case QCRYPTO_CIPHER_ALG_TWOFISH_256:<br>
&gt; +#ifdef CONFIG_CRYPTO_SM4<br>
&gt; +=C2=A0 =C2=A0 case QCRYPTO_CIPHER_ALG_SM4:<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; @@ -219,6 +222,11 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCry=
ptoCipherAlgorithm alg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case QCRYPTO_CIPHER_ALG_TWOFISH_256:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gcryalg =3D GCRY_CIPHER_TWOFIS=
H;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +#ifdef CONFIG_CRYPTO_SM4<br>
&gt; +=C2=A0 =C2=A0 case QCRYPTO_CIPHER_ALG_SM4:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gcryalg =3D GCRY_CIPHER_SM4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Unsuppo=
rted cipher algorithm %s&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 QCryptoCipherAlgorithm_str(alg));<br>
&gt; diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc<b=
r>
&gt; index 24cc61f87b..42b39e18a2 100644<br>
&gt; --- a/crypto/cipher-nettle.c.inc<br>
&gt; +++ b/crypto/cipher-nettle.c.inc<br>
&gt; @@ -33,6 +33,9 @@<br>
&gt;=C2=A0 =C2=A0#ifndef CONFIG_QEMU_PRIVATE_XTS<br>
&gt;=C2=A0 =C2=A0#include &lt;nettle/xts.h&gt;<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; +#ifdef CONFIG_CRYPTO_SM4<br>
&gt; +#include &lt;nettle/sm4.h&gt;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static inline bool qcrypto_length_check(size_t len, size_t=
 blocksize,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Error **errp)<br>
&gt; @@ -426,6 +429,30 @@ DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_twofish,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 QCryptoNettleTwofish, TWOFISH_BLOCK_SIZE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 twofish_encrypt_native, twofish_decrypt_native)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#ifdef CONFIG_CRYPTO_SM4<br>
&gt; +typedef struct QCryptoNettleSm4 {<br>
&gt; +=C2=A0 =C2=A0 QCryptoCipher base;<br>
&gt; +=C2=A0 =C2=A0 struct sm4_ctx key[2];<br>
&gt; +} QCryptoNettleSm4;<br>
&gt; +<br>
&gt; +static void sm4_encrypt_native(void *ctx, size_t length,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *dst, const uint8_t *src)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct sm4_ctx *keys =3D ctx;<br>
&gt; +=C2=A0 =C2=A0 sm4_crypt(&amp;keys[0], length, dst, src);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void sm4_decrypt_native(void *ctx, size_t length,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *dst, const uint8_t *src)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct sm4_ctx *keys =3D ctx;<br>
&gt; +=C2=A0 =C2=A0 sm4_crypt(&amp;keys[1], length, dst, src);<br>
&gt; +}<br>
&gt; +<br>
&gt; +DEFINE_ECB(qcrypto_nettle_sm4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QCryptoNettleSm4, SM4_BLOCK_=
SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sm4_encrypt_native, sm4_decr=
ypt_native)<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCryptoCipherMode mode)<br>
&gt; @@ -443,6 +470,9 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorith=
m alg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case QCRYPTO_CIPHER_ALG_TWOFISH_128:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case QCRYPTO_CIPHER_ALG_TWOFISH_192:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case QCRYPTO_CIPHER_ALG_TWOFISH_256:<br>
&gt; +#ifdef CONFIG_CRYPTO_SM4<br>
&gt; +=C2=A0 =C2=A0 case QCRYPTO_CIPHER_ALG_SM4:<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; @@ -701,6 +731,25 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCry=
ptoCipherAlgorithm alg,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &amp;ctx-=
&gt;base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +#ifdef CONFIG_CRYPTO_SM4<br>
&gt; +=C2=A0 =C2=A0 case QCRYPTO_CIPHER_ALG_SM4:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCryptoNettleSm4 *ctx =3D g=
_new0(QCryptoNettleSm4, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (mode) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case QCRYPTO_CIPHER_MODE_EC=
B:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;base.=
driver =3D &amp;qcrypto_nettle_sm4_driver_ecb;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad_ciph=
er_mode;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sm4_set_encrypt_key(&amp;ct=
x-&gt;key[0], key);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sm4_set_decrypt_key(&amp;ct=
x-&gt;key[1], key);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;ctx-&gt;base;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Unsuppo=
rted cipher algorithm %s&quot;,<br>
&gt; diff --git a/crypto/cipher.c b/crypto/cipher.c<br>
&gt; index 74b09a5b26..5f512768ea 100644<br>
&gt; --- a/crypto/cipher.c<br>
&gt; +++ b/crypto/cipher.c<br>
&gt; @@ -38,6 +38,9 @@ static const size_t alg_key_len[QCRYPTO_CIPHER_ALG__=
MAX] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[QCRYPTO_CIPHER_ALG_TWOFISH_128] =3D 16,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[QCRYPTO_CIPHER_ALG_TWOFISH_192] =3D 24,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[QCRYPTO_CIPHER_ALG_TWOFISH_256] =3D 32,<br>
&gt; +#ifdef CONFIG_CRYPTO_SM4<br>
&gt; +=C2=A0 =C2=A0 [QCRYPTO_CIPHER_ALG_SM4] =3D 16,<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static const size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX]=
 =3D {<br>
&gt; @@ -53,6 +56,9 @@ static const size_t alg_block_len[QCRYPTO_CIPHER_ALG=
__MAX] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[QCRYPTO_CIPHER_ALG_TWOFISH_128] =3D 16,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[QCRYPTO_CIPHER_ALG_TWOFISH_192] =3D 16,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[QCRYPTO_CIPHER_ALG_TWOFISH_256] =3D 16,<br>
&gt; +#ifdef CONFIG_CRYPTO_SM4<br>
&gt; +=C2=A0 =C2=A0 [QCRYPTO_CIPHER_ALG_SM4] =3D 16,<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static const bool mode_need_iv[QCRYPTO_CIPHER_MODE__MAX] =
=3D {<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index d2c4c2adb3..52f2f85b5a 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -1480,6 +1480,7 @@ endif<br>
&gt;=C2=A0 =C2=A0gcrypt =3D not_found<br>
&gt;=C2=A0 =C2=A0nettle =3D not_found<br>
&gt;=C2=A0 =C2=A0hogweed =3D not_found<br>
&gt; +crypto_sm4 =3D not_found<br>
&gt;=C2=A0 =C2=A0xts =3D &#39;none&#39;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0if get_option(&#39;nettle&#39;).enabled() and get_option(&=
#39;gcrypt&#39;).enabled()<br>
&gt; @@ -1505,6 +1506,17 @@ if not gnutls_crypto.found()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cc.find_library(&#39;gpg-erro=
r&#39;, required: true)],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version: gcrypt.version())<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0endif<br>
&gt; +=C2=A0 =C2=A0 crypto_sm4 =3D gcrypt<br>
&gt; +=C2=A0 =C2=A0 # SM4 ALG is available in libgcrypt &gt;=3D 1.9<br>
&gt; +=C2=A0 =C2=A0 if gcrypt.found() and not cc.links(&#39;&#39;&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 #include &lt;gcrypt.h&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 int main(void) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gcry_cipher_hd_t handler;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gcry_cipher_open(&amp;handler, GCRY_CIPHE=
R_SM4, GCRY_CIPHER_MODE_ECB, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 }&#39;&#39;&#39;, dependencies: gcrypt)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 crypto_sm4 =3D not_found<br>
&gt; +=C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (not get_option(&#39;nettle&#39;).auto() or have=
_system) and not gcrypt.found()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0nettle =3D dependency(&#39;nettle&#39;, vers=
ion: &#39;&gt;=3D3.4&#39;,<br>
&gt; @@ -1513,6 +1525,18 @@ if not gnutls_crypto.found()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if nettle.found() and not cc.has_header(&#39=
;nettle/xts.h&#39;, dependencies: nettle)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xts =3D &#39;private&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0endif<br>
&gt; +=C2=A0 =C2=A0 crypto_sm4 =3D nettle<br>
&gt; +=C2=A0 =C2=A0 # SM4 ALG is available in nettle &gt;=3D 3.9<br>
&gt; +=C2=A0 =C2=A0 if nettle.found() and not cc.links(&#39;&#39;&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 #include &lt;nettle/sm4.h&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 int main(void) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sm4_ctx ctx;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char key[16] =3D {0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sm4_set_encrypt_key(&amp;ctx, key);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 }&#39;&#39;&#39;, dependencies: nettle)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 crypto_sm4 =3D not_found<br>
&gt; +=C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0endif<br>
&gt;=C2=A0 =C2=A0endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -2199,6 +2223,7 @@ config_host_data.set(&#39;CONFIG_GNUTLS_CRYPTO&#=
39;, gnutls_crypto.found())<br>
&gt;=C2=A0 =C2=A0config_host_data.set(&#39;CONFIG_TASN1&#39;, tasn1.found()=
)<br>
&gt;=C2=A0 =C2=A0config_host_data.set(&#39;CONFIG_GCRYPT&#39;, gcrypt.found=
())<br>
&gt;=C2=A0 =C2=A0config_host_data.set(&#39;CONFIG_NETTLE&#39;, nettle.found=
())<br>
&gt; +config_host_data.set(&#39;CONFIG_CRYPTO_SM4&#39;, crypto_sm4.found())=
<br>
&gt;=C2=A0 =C2=A0config_host_data.set(&#39;CONFIG_HOGWEED&#39;, hogweed.fou=
nd())<br>
&gt;=C2=A0 =C2=A0config_host_data.set(&#39;CONFIG_QEMU_PRIVATE_XTS&#39;, xt=
s =3D=3D &#39;private&#39;)<br>
&gt;=C2=A0 =C2=A0config_host_data.set(&#39;CONFIG_MALLOC_TRIM&#39;, has_mal=
loc_trim)<br>
&gt; @@ -4274,6 +4299,7 @@ summary_info +=3D {&#39;nettle&#39;:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nettle}<br>
&gt;=C2=A0 =C2=A0if nettle.found()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 summary_info +=3D {&#39;=C2=A0 XTS&#39;:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xts !=3D &#39;private&#39;}<br>
&gt;=C2=A0 =C2=A0endif<br>
&gt; +summary_info +=3D {&#39;SM4 ALG support&#39;:=C2=A0 =C2=A0crypto_sm4}=
<br>
&gt;=C2=A0 =C2=A0summary_info +=3D {&#39;AF_ALG support&#39;:=C2=A0 =C2=A0 =
have_afalg}<br>
&gt;=C2=A0 =C2=A0summary_info +=3D {&#39;rng-none&#39;:=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 get_option(&#39;rng_none&#39;)}<br>
&gt;=C2=A0 =C2=A0summary_info +=3D {&#39;Linux keyring&#39;:=C2=A0 =C2=A0 =
=C2=A0have_keyring}<br>
&gt; diff --git a/qapi/crypto.json b/qapi/crypto.json<br>
&gt; index fd3d46ebd1..2f2aeff5fd 100644<br>
&gt; --- a/qapi/crypto.json<br>
&gt; +++ b/qapi/crypto.json<br>
&gt; @@ -94,6 +94,8 @@<br>
&gt;=C2=A0 =C2=A0#<br>
&gt;=C2=A0 =C2=A0# @twofish-256: Twofish with 256 bit / 32 byte keys<br>
&gt;=C2=A0 =C2=A0#<br>
&gt; +# @sm4: SM4 with 128 bit / 16 byte keys (since 9.0)<br>
&gt; +#<br>
&gt;=C2=A0 =C2=A0# Since: 2.6<br>
&gt;=C2=A0 =C2=A0##<br>
&gt;=C2=A0 =C2=A0{ &#39;enum&#39;: &#39;QCryptoCipherAlgorithm&#39;,<br>
&gt; @@ -102,7 +104,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;des&#39;, &#39;3d=
es&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;cast5-128&#39;,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;serpent-128&#39;,=
 &#39;serpent-192&#39;, &#39;serpent-256&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;twofish-128&#39;, &#39;=
twofish-192&#39;, &#39;twofish-256&#39;]}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;twofish-128&#39;, &#39;=
twofish-192&#39;, &#39;twofish-256&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sm4&#39;]}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0##<br>
&gt;=C2=A0 =C2=A0# @QCryptoCipherMode:<br>
&gt; diff --git a/tests/unit/test-crypto-cipher.c b/tests/unit/test-crypto-=
cipher.c<br>
&gt; index d9d9d078ff..11ab1a54fc 100644<br>
&gt; --- a/tests/unit/test-crypto-cipher.c<br>
&gt; +++ b/tests/unit/test-crypto-cipher.c<br>
&gt; @@ -382,6 +382,19 @@ static QCryptoCipherTestData test_data[] =3D {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.plaintext =3D &quot;90afe91bb=
288544f2c32dc239b2635e6&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.ciphertext =3D &quot;6cb4561c=
40bf0a9705931cb6d408e7fa&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt; +#ifdef CONFIG_CRYPTO_SM4<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* SM4, GB/T 32907-2016, Appendix A.1 */<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .path =3D &quot;/crypto/cipher/sm4&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .alg =3D QCRYPTO_CIPHER_ALG_SM4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mode =3D QCRYPTO_CIPHER_MODE_ECB,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .key =3D &quot;0123456789abcdeffedcba9876=
543210&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .plaintext=C2=A0 =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;0123456789abcdeffedcb=
a9876543210&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ciphertext =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;681edf34d206965e86b3e=
94f536e4246&quot;,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* #1 32 byte key, 32 byte PTX=
 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.path =3D &quot;/crypto/cipher=
/aes-xts-128-1&quot;,<br>
<br>
</blockquote></div><br clear=3D"all"><div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Thanks,</div><div cl=
ass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif">Yong</div><br></div><span class=3D"gmail_signature_prefix">-- </span>=
<br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=
=3D"comic sans ms, sans-serif">Best regards</font></div></div></div>

--000000000000e34577060bf616c4--

