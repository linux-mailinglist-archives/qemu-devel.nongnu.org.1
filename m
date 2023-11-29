Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2297FCC6A
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 02:44:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r89bR-00031H-1k; Tue, 28 Nov 2023 20:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r89bK-000316-Te
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 20:42:55 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r89bH-00010F-Cj
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 20:42:54 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso4800886a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 17:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701222047; x=1701826847;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P/FriLM1ETDZdX0Z6B2Tjp1f4iMIZCk1vHjrNhNmZiQ=;
 b=qIQC1nNgpnGtndr0wtCSydYbx66a/ssAHwNTDsm4q03HSbSjcUgOmY5PSACH9+n0m1
 tMZv+9nUeEZAuHE9lttcGdJM81lnRphHdVN2jLjxrUkuBVpDux6sGduJgkfypdi4+b/B
 FSeIW7p6NPhzGiJakS5/kRvYjUJsEiFLAhGw3fkp1Anbt4q79TYEuGIa8PLOb8XJLXcJ
 SLfxVGKvM+FeJl9DpuiV3ZKlg+FG1TgQXi72dkymLOJq33deUIucR/+r19SQck+SCmJ2
 fA1iDwvwHZrEH4corLpWPdM0C0Nn9XIuRruSXFedLLXD+XV1AZNIqoM24MSDr+OO1nzU
 kH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701222047; x=1701826847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P/FriLM1ETDZdX0Z6B2Tjp1f4iMIZCk1vHjrNhNmZiQ=;
 b=ZCd8ulwEEN/dMIrxJ8H7f2w5D/dek00yrUK5snMwfWLSyxLZzRpIqjuFMD3xmZ7kjG
 xObMtggdqOrmnzzRmFNt6WjJWaSzmHfa5aAXaiRDe/TVSUAenR/kT9Nfsllx3eUNFOHx
 FmOXarXM1F1KvDOxWmxBmCEAZzwBT4gFZHqwjejCMKy/sdrPAKQpuFAM00KRB6Ddizrf
 Rqa/ZNHXmVIlVaB4ORTkK1IJfSp3rIeYnwt0xGFLdETElfj8nA9AUhGtg4JKl+EsqiH2
 h8ILL9KylGyFEtxFzO0dF/Qhu3Le1Qdwi9rSDhp12EAzRRYjKQVdKC6f6fSnWlwk/8d4
 9iTw==
X-Gm-Message-State: AOJu0YxOjluULnWCDWE6CdRfItfDCfSnBKET4/Xn8AWaA38LFZcUV7Fw
 C0YBj8U3S2yuxpUXk8jFSSJexLCj2ucvk9EyhGPkbg==
X-Google-Smtp-Source: AGHT+IEbDrgsnLGlv88KeHWB1c1x3SGlC0ey/kSgC8it2aiUiQVaBz5Yv0nmz00dsHCCjdqQZnLHkrT7pdzI3TIwwes=
X-Received: by 2002:a05:6a21:9706:b0:18b:3571:ef12 with SMTP id
 ub6-20020a056a21970600b0018b3571ef12mr15407205pzb.16.1701222045567; Tue, 28
 Nov 2023 17:40:45 -0800 (PST)
MIME-Version: 1.0
References: <4413f00465bda93eda7a7560afb990ca01191062.1701185032.git.yong.huang@smartx.com>
 <6776b07c-f1a8-4b96-9527-de8e0ed16980@linaro.org>
 <ZWYTSrfRL-iXM1LX@redhat.com>
In-Reply-To: <ZWYTSrfRL-iXM1LX@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 29 Nov 2023 09:40:29 +0800
Message-ID: <CAK9dgmYK7D_U2LtbiyFjtoocosAh5j91JLb_ACEpj56YpraNUQ@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: Introduce SM4 symmetric cipher algorithm
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b5e2ff060b409f91"
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x536.google.com
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

--000000000000b5e2ff060b409f91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll try to understand the comment, if i misunderstood, please point out.

On Wed, Nov 29, 2023 at 12:20=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Tue, Nov 28, 2023 at 04:57:20PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Hyman,
> >
> > On 28/11/23 16:24, Hyman Huang wrote:
> > > Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> > >
> > > SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> > > Organization of State Commercial Administration of China (OSCCA)
> > > as an authorized cryptographic algorithms for the use within China.
> > >
> > > Use the crypto-sm4 meson build option for enabling this feature.
> > >
> > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > ---
> > >   crypto/block-luks.c             | 11 ++++++++
> > >   crypto/cipher-gcrypt.c.inc      |  8 ++++++
> > >   crypto/cipher-nettle.c.inc      | 49
> +++++++++++++++++++++++++++++++++
> > >   crypto/cipher.c                 |  6 ++++
> > >   meson.build                     | 23 ++++++++++++++++
> > >   meson_options.txt               |  2 ++
> > >   qapi/crypto.json                |  5 +++-
> > >   scripts/meson-buildoptions.sh   |  3 ++
> > >   tests/unit/test-crypto-cipher.c | 13 +++++++++
> > >   9 files changed, 119 insertions(+), 1 deletion(-)
> >
> >
> > > diff --git a/meson.build b/meson.build
> > > index ec01f8b138..256d3257bb 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -1480,6 +1480,7 @@ endif
> > >   gcrypt =3D not_found
> > >   nettle =3D not_found
> > >   hogweed =3D not_found
> > > +crypto_sm4 =3D not_found
> > >   xts =3D 'none'
> > >   if get_option('nettle').enabled() and get_option('gcrypt').enabled(=
)
> > > @@ -1514,6 +1515,26 @@ if not gnutls_crypto.found()
> > >         xts =3D 'private'
> > >       endif
> > >     endif
> > > +  if get_option('crypto_sm4').enabled()
> >
> > We want to detect it by default (not only when explicitly enabled) ...
> >
> > > +    if get_option('gcrypt').enabled()
> > > +      # SM4 ALG is available in libgcrypt >=3D 1.9
> > > +      crypto_sm4 =3D dependency('libgcrypt', version: '>=3D1.9',
> > > +                              method: 'config-tool',
> > > +                              required: get_option('gcrypt'))
> > > +      # SM4 ALG static compilation
> > > +      if crypto_sm4.found() and get_option('prefer_static')
> > > +        crypto_sm4 =3D declare_dependency(dependencies: [
> > > +          crypto_sm4,
> > > +          cc.find_library('gpg-error', required: true)],
> > > +          version: crypto_sm4.version())
> > > +      endif
> > > +    else
> > > +      # SM4 ALG is available in nettle >=3D 3.9
> > > +      crypto_sm4 =3D dependency('nettle', version: '>=3D3.9',
> > > +                              method: 'pkg-config',
> > > +                              required: get_option('nettle'))
> > > +    endif
> >
> > ... and if it was forced with --enable-crypto_sm4 AND not found,
> > display an error.
> >
> > IIUC your config you try to find the best effort implementation then
> > if not found, keep going silently.
>
> Yes, ignore the get_option() calls, and instead look at .found()
> in the library we just detected
>
ie
>
>   if nettle.found()
>       ....check sm4 in nettle
>   endif
>
>   if gcrypt.found()
>       ....check sm4 in crypt
>   endif
>
> To detect if sm4 is supported, there may be two methods:
One is to specify the version explicitly(ligcrypt >=3D1.9,nettle >=3D 3.9)
as in patch

Another is to use the cc.link for a test. eg:

+      crypto_sm4 =3D gcrypt
+      if gcrypt.found() and not cc.links('''
+        #include <gcrypt.h>
+        void main(void) {
+          gcry_cipher_hd_t handler;
+          gcry_cipher_open(&handler, GCRY_CIPHER_SM4,
GCRY_CIPHER_MODE_ECB, 0);
+        }''', dependencies: gcrypt)
+        crypto_sm4 =3D not_found
+      endif

Is the latter a better choice?


>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
Best regards

--000000000000b5e2ff060b409f91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">I&#39;ll try to understand t=
he comment, if i misunderstood, please point out.</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 29, 2023=
 at 12:20=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange=
@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Tue, Nov 28, 2023 at 04:57:20PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:<br>
&gt; Hi Hyman,<br>
&gt; <br>
&gt; On 28/11/23 16:24, Hyman Huang wrote:<br>
&gt; &gt; Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).<br>
&gt; &gt; <br>
&gt; &gt; SM4 (GBT.32907-2016) is a cryptographic standard issued by the<br=
>
&gt; &gt; Organization of State Commercial Administration of China (OSCCA)<=
br>
&gt; &gt; as an authorized cryptographic algorithms for the use within Chin=
a.<br>
&gt; &gt; <br>
&gt; &gt; Use the crypto-sm4 meson build option for enabling this feature.<=
br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smart=
x.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0crypto/block-luks.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 11 ++++++++<br>
&gt; &gt;=C2=A0 =C2=A0crypto/cipher-gcrypt.c.inc=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 8 ++++++<br>
&gt; &gt;=C2=A0 =C2=A0crypto/cipher-nettle.c.inc=C2=A0 =C2=A0 =C2=A0 | 49 +=
++++++++++++++++++++++++++++++++<br>
&gt; &gt;=C2=A0 =C2=A0crypto/cipher.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++++<br>
&gt; &gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 23 ++++++++++++++++<br>
&gt; &gt;=C2=A0 =C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt; &gt;=C2=A0 =C2=A0qapi/crypto.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +++-<br>
&gt; &gt;=C2=A0 =C2=A0scripts/meson-buildoptions.sh=C2=A0 =C2=A0|=C2=A0 3 +=
+<br>
&gt; &gt;=C2=A0 =C2=A0tests/unit/test-crypto-cipher.c | 13 +++++++++<br>
&gt; &gt;=C2=A0 =C2=A09 files changed, 119 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; <br>
&gt; &gt; diff --git a/meson.build b/meson.build<br>
&gt; &gt; index ec01f8b138..256d3257bb 100644<br>
&gt; &gt; --- a/meson.build<br>
&gt; &gt; +++ b/meson.build<br>
&gt; &gt; @@ -1480,6 +1480,7 @@ endif<br>
&gt; &gt;=C2=A0 =C2=A0gcrypt =3D not_found<br>
&gt; &gt;=C2=A0 =C2=A0nettle =3D not_found<br>
&gt; &gt;=C2=A0 =C2=A0hogweed =3D not_found<br>
&gt; &gt; +crypto_sm4 =3D not_found<br>
&gt; &gt;=C2=A0 =C2=A0xts =3D &#39;none&#39;<br>
&gt; &gt;=C2=A0 =C2=A0if get_option(&#39;nettle&#39;).enabled() and get_opt=
ion(&#39;gcrypt&#39;).enabled()<br>
&gt; &gt; @@ -1514,6 +1515,26 @@ if not gnutls_crypto.found()<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xts =3D &#39;private&#39;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0endif<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0endif<br>
&gt; &gt; +=C2=A0 if get_option(&#39;crypto_sm4&#39;).enabled()<br>
&gt; <br>
&gt; We want to detect it by default (not only when explicitly enabled) ...=
<br>
&gt; <br>
&gt; &gt; +=C2=A0 =C2=A0 if get_option(&#39;gcrypt&#39;).enabled()<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 # SM4 ALG is available in libgcrypt &gt;=3D=
 1.9<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 crypto_sm4 =3D dependency(&#39;libgcrypt&#3=
9;, version: &#39;&gt;=3D1.9&#39;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 method: &#39;config-tool&#39;,<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required: get_option(&#39;gcrypt&=
#39;))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 # SM4 ALG static compilation<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 if crypto_sm4.found() and get_option(&#39;p=
refer_static&#39;)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_sm4 =3D declare_dependency(de=
pendencies: [<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_sm4,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cc.find_library(&#39;gpg-erro=
r&#39;, required: true)],<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 version: crypto_sm4.version()=
)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 endif<br>
&gt; &gt; +=C2=A0 =C2=A0 else<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 # SM4 ALG is available in nettle &gt;=3D 3.=
9<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 crypto_sm4 =3D dependency(&#39;nettle&#39;,=
 version: &#39;&gt;=3D3.9&#39;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 method: &#39;pkg-config&#39;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required: get_option(&#39;nettle&=
#39;))<br>
&gt; &gt; +=C2=A0 =C2=A0 endif<br>
&gt; <br>
&gt; ... and if it was forced with --enable-crypto_sm4 AND not found,<br>
&gt; display an error.<br>
&gt; <br>
&gt; IIUC your config you try to find the best effort implementation then<b=
r>
&gt; if not found, keep going silently.<br>
<br>
Yes, ignore the get_option() calls, and instead look at .found()<br>
in the library we just detected=C2=A0<br></blockquote><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border=
-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
ie<br>
<br>
=C2=A0 if nettle.found()<br>
=C2=A0 =C2=A0 =C2=A0 ....check sm4 in nettle<br>
=C2=A0 endif<br>
<br>
=C2=A0 if gcrypt.found()<br>
=C2=A0 =C2=A0 =C2=A0 ....check sm4 in crypt<br>
=C2=A0 endif<br>
<br></blockquote><div><div><div class=3D"gmail_default" style=3D"font-famil=
y:&quot;comic sans ms&quot;,sans-serif">To detect if sm4 is supported, ther=
e may be two methods:</div><div class=3D"gmail_default" style=3D"font-famil=
y:&quot;comic sans ms&quot;,sans-serif">One is to specify the version expli=
citly(ligcrypt &gt;=3D1.9,nettle &gt;=3D 3.9)=C2=A0</div><div class=3D"gmai=
l_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">as in=
 patch</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif"><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:&quot;comic sans ms&quot;,sans-serif">Another is to use the cc.li=
nk for a test. eg:</div><div class=3D"gmail_default" style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_default"=
 style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">+ =C2=A0 =C2=A0=
 =C2=A0crypto_sm4 =3D gcrypt</div><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">+ =C2=A0 =C2=A0 =C2=A0if gcr=
ypt.found() and not cc.links(&#39;&#39;&#39;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0#include &lt;gcrypt.h&gt;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0void main(void=
) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gcry_cipher_hd_t handler;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gcry_cipher_open(&amp;handler, GCRY_CIPHE=
R_SM4, GCRY_CIPHER_MODE_ECB, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}&#39;&#39=
;&#39;, dependencies: gcrypt)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0crypto_sm4 =
=3D not_found<br>+ =C2=A0 =C2=A0 =C2=A0endif<br></div><br></div><div><div c=
lass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif">Is the latter a better choice?</div></div></div><div>=C2=A0<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);=
padding-left:1ex">
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000b5e2ff060b409f91--

