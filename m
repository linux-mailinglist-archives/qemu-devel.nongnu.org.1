Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3826F7FA6AB
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 17:41:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7eex-0003tk-Gc; Mon, 27 Nov 2023 11:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r7eer-0003tY-PD
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 11:40:29 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r7eeo-0007vg-PI
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 11:40:29 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6c320a821c4so3731001b3a.2
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 08:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701103101; x=1701707901;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+LsFjr4EOcM39dsaQ91oHp8nIIA28x7XyQrizho1y58=;
 b=VL13qq9ZNzDTurMysc17CN7Z7Svv9g2o8c5THkJmPo4+ZNbVoK8/Vw0RvO+nSNoLow
 Pttk8kH3aM7FSt3VLlEuLH0+vrosw+Nmohb2/jSUedhnHMUZk1vRse5+mhMCh2vtJhy0
 5Gq8wj+w1YkmHI/RUpTigtYDi649KyloXQArjpY5//M3x02EM35j/6EzohaMEYHpL9/Y
 qRkoLc8QTBpuc7jt44cvMiul/xNNdQak7un6po9j6BKIXyL5XnO7YfGKBcPpmDR0v+Rw
 VKdJw0RyYxzeQ4UZrK8YlbGrz2K6Deh5Kx1lYq3oANFGAlzk0sOFDWisB+HkxXvXE46E
 vgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701103101; x=1701707901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+LsFjr4EOcM39dsaQ91oHp8nIIA28x7XyQrizho1y58=;
 b=vfvIGIiwTBIIWuH1X7hpec6qNYJuteSyuPZfS6D10GyiaGovt7AR4ydhv0cU/p3+kV
 l1HiJi6IwuevarDTKCRhJc3b7hrA8Fd36A7sRSUBkCKN0TIKgaA3TFTUIEyMA/OX4wL3
 5+oeNFapMrZ6QWXeZhHAM2Li2b9K2zz/Vq8IxyGRgOAsib8pspE8tsugOxo65SznDq0c
 vRBUMjkFnIXvCw3X/L8nO8/f2ebfx/V1zPNquI/l6SaBcB8klsbjFw8RRA3a/h7YqTrL
 DJpNdGJejrf5IY5DHbeEasTnu0X3cpq0PXs9Unx1fcjr5fFlUC0zWXv9QZFO1dPAoT0l
 o7Kw==
X-Gm-Message-State: AOJu0Ywsqt5NI0fblU+VBhdS40UNtYw0OwZGQwvNxE90pPtY6jWREWWS
 1S25GqEMSJzTH3n/sNroxahIaLW85QU/8oCfrseWOQ==
X-Google-Smtp-Source: AGHT+IHrrdzQRsHZSxRcJJCg3AVDMeMB1eOMduYkVA57GGYR24D04fd1QfAZOYmuUNvd+qN9fR5tcWU+djWkXs4R3iY=
X-Received: by 2002:a05:6a20:daa6:b0:18c:a8ee:b569 with SMTP id
 iy38-20020a056a20daa600b0018ca8eeb569mr2776599pzb.43.1701103100140; Mon, 27
 Nov 2023 08:38:20 -0800 (PST)
MIME-Version: 1.0
References: <386ee33ff8f1dc4e8416b037e548ae36c983d054.1701100272.git.yong.huang@smartx.com>
 <ZWS_lTYeKTLNfDrn@redhat.com>
In-Reply-To: <ZWS_lTYeKTLNfDrn@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 28 Nov 2023 00:38:04 +0800
Message-ID: <CAK9dgmZudtuE280J3Hw4jVq95PvEYMmOE-dGJO-atviQLJAsYQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: Introduce SM4 symmetric cipher algorithm
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000002b4b2060b24eed3"
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42f.google.com
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

--00000000000002b4b2060b24eed3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 12:11=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Mon, Nov 27, 2023 at 11:55:34PM +0800, Hyman Huang wrote:
> > Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> >
> > SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> > Organization of State Commercial Administration of China (OSCCA)
> > as an authorized cryptographic algorithms for the use within China.
>
> Just out of interest, what part of QEMU are you needing to use
> SM4 with ? Is it for a LUKS block driver cipher ?
>

Indeed, the LUKS block driver is the cause. Since SM4 can be accelerated by
encryption cards or hardware modules, we wish to evaluate the performance
overhead of the CPU and the proprietary hardware as in our production,
And the SM4 Algo CPU implementation could be introduced beforehand.

>
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  crypto/block-luks.c             |  7 ++++++
> >  crypto/cipher-gcrypt.c.inc      |  4 ++++
>
> Looking at the gcrypt code, SM4 is only supported in >=3D 1.9.0
>
> QEMU min version is 1.8.0, so you'll need to modify meson.build
> to check whether SM4 is supported and put conditionals in this
> file


> >  crypto/cipher-nettle.c.inc      | 42 +++++++++++++++++++++++++++++++++
>
> Looking at the nettle code, SM4 is only supported in unreleased
> versions thus far.


> So again will need a meson.build check and conditionals.
>
OK, I'll check the library versions in the next versoin.

>
> >  crypto/cipher.c                 |  2 ++
> >  qapi/crypto.json                |  5 +++-
> >  tests/unit/test-crypto-cipher.c | 11 +++++++++
> >  6 files changed, 70 insertions(+), 1 deletion(-)
>
>
> > diff --git a/qapi/crypto.json b/qapi/crypto.json
> > index fd3d46ebd1..95fa10bb6d 100644
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -94,6 +94,8 @@
> >  #
> >  # @twofish-256: Twofish with 256 bit / 32 byte keys
> >  #
> > +# @sm4: SM4 with 128 bit / 16 byte keys (since 8.2)
>
> We're in feature freeze for 8.2, so mark this 9.0 as that'll be the
> next available release this could be merged for.
>
Get it.

>
> > +#
> >  # Since: 2.6
> >  ##
> >  { 'enum': 'QCryptoCipherAlgorithm',
> > @@ -102,7 +104,8 @@
> >             'des', '3des',
> >             'cast5-128',
> >             'serpent-128', 'serpent-192', 'serpent-256',
> > -           'twofish-128', 'twofish-192', 'twofish-256']}
> > +           'twofish-128', 'twofish-192', 'twofish-256',
> > +           'sm4']}
> >
> >  ##
> >  # @QCryptoCipherMode:
> > diff --git a/tests/unit/test-crypto-cipher.c
> b/tests/unit/test-crypto-cipher.c
> > index d9d9d078ff..80a4984e43 100644
> > --- a/tests/unit/test-crypto-cipher.c
> > +++ b/tests/unit/test-crypto-cipher.c
> > @@ -382,6 +382,17 @@ static QCryptoCipherTestData test_data[] =3D {
> >          .plaintext =3D "90afe91bb288544f2c32dc239b2635e6",
> >          .ciphertext =3D "6cb4561c40bf0a9705931cb6d408e7fa",
> >      },
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
> >      {
> >          /* #1 32 byte key, 32 byte PTX */
> >          .path =3D "/crypto/cipher/aes-xts-128-1",
> > --
> > 2.39.1
> >
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
Thanks for the comment,
Yong

--=20
Best regards

--00000000000002b4b2060b24eed3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div cl=
ass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Nov 28, 2023 at 12:11=E2=80=AFAM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color=
:rgb(204,204,204);padding-left:1ex">On Mon, Nov 27, 2023 at 11:55:34PM +080=
0, Hyman Huang wrote:<br>
&gt; Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).<br>
&gt; <br>
&gt; SM4 (GBT.32907-2016) is a cryptographic standard issued by the<br>
&gt; Organization of State Commercial Administration of China (OSCCA)<br>
&gt; as an authorized cryptographic algorithms for the use within China.<br=
>
<br>
Just out of interest, what part of QEMU are you needing to use<br>
SM4 with ? Is it for a LUKS block driver cipher ?<br></blockquote><div><br>=
</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif">Indeed, the LUKS block driver is the cause. Since SM4 ca=
n be accelerated by</div><div class=3D"gmail_default" style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif">encryption cards or hardware modules,=
 we wish to evaluate the performance</div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">overhead of the CPU =
and the proprietary hardware as in our production,=C2=A0</div><div class=3D=
"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">=
And the SM4 Algo CPU implementation could be introduced beforehand.</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pad=
ding-left:1ex">
<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 crypto/block-luks.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 7 ++++++<br>
&gt;=C2=A0 crypto/cipher-gcrypt.c.inc=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++++<br=
>
<br>
Looking at the gcrypt code, SM4 is only supported in &gt;=3D 1.9.0 <br>
<br>
QEMU min version is 1.8.0, so you&#39;ll need to modify meson.build<br>
to check whether SM4 is supported and put conditionals in this<br>
file</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:r=
gb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 crypto/cipher-nettle.c.inc=C2=A0 =C2=A0 =C2=A0 | 42 ++++++++++++=
+++++++++++++++++++++<br>
<br>
Looking at the nettle code, SM4 is only supported in unreleased<br>
versions thus far.=C2=A0</blockquote><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid=
;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
So again will need a meson.build check and conditionals.<br></blockquote><d=
iv><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">OK, I&#=
39;ll check<span class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif"> the library versions in the next versoin.</span><=
/span>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:=
rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 crypto/cipher.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 qapi/crypto.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 5 +++-<br>
&gt;=C2=A0 tests/unit/test-crypto-cipher.c | 11 +++++++++<br>
&gt;=C2=A0 6 files changed, 70 insertions(+), 1 deletion(-)<br>
<br>
<br>
&gt; diff --git a/qapi/crypto.json b/qapi/crypto.json<br>
&gt; index fd3d46ebd1..95fa10bb6d 100644<br>
&gt; --- a/qapi/crypto.json<br>
&gt; +++ b/qapi/crypto.json<br>
&gt; @@ -94,6 +94,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @twofish-256: Twofish with 256 bit / 32 byte keys<br>
&gt;=C2=A0 #<br>
&gt; +# @sm4: SM4 with 128 bit / 16 byte keys (since 8.2)<br>
<br>
We&#39;re in feature freeze for 8.2, so mark this 9.0 as that&#39;ll be the=
<br>
next available release this could be merged for.<br></blockquote><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">Get it.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; +#<br>
&gt;=C2=A0 # Since: 2.6<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;enum&#39;: &#39;QCryptoCipherAlgorithm&#39;,<br>
&gt; @@ -102,7 +104,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;des&#39;, &#39;3de=
s&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cast5-128&#39;,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;serpent-128&#39;, =
&#39;serpent-192&#39;, &#39;serpent-256&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;twofish-128&#39;, &#39;=
twofish-192&#39;, &#39;twofish-256&#39;]}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;twofish-128&#39;, &#39;=
twofish-192&#39;, &#39;twofish-256&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sm4&#39;]}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @QCryptoCipherMode:<br>
&gt; diff --git a/tests/unit/test-crypto-cipher.c b/tests/unit/test-crypto-=
cipher.c<br>
&gt; index d9d9d078ff..80a4984e43 100644<br>
&gt; --- a/tests/unit/test-crypto-cipher.c<br>
&gt; +++ b/tests/unit/test-crypto-cipher.c<br>
&gt; @@ -382,6 +382,17 @@ static QCryptoCipherTestData test_data[] =3D {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .plaintext =3D &quot;90afe91bb288544=
f2c32dc239b2635e6&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ciphertext =3D &quot;6cb4561c40bf0a=
9705931cb6d408e7fa&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
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
&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* #1 32 byte key, 32 byte PTX */<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .path =3D &quot;/crypto/cipher/aes-x=
ts-128-1&quot;,<br>
&gt; -- <br>
&gt; 2.39.1<br>
&gt; <br>
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
</blockquote></div><br clear=3D"all"><div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Thanks for the comme=
nt,</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif">Yong</div></div><div><br></div><span class=3D"gmail_s=
ignature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><=
div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font=
></div></div></div></div></div>

--00000000000002b4b2060b24eed3--

