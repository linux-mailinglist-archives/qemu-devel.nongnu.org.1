Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E67627FCC6C
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 02:46:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r89eT-0003oF-3k; Tue, 28 Nov 2023 20:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r89eQ-0003ny-CV
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 20:46:06 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r89eM-0001Cz-6T
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 20:46:06 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5c1a75a4b6cso3701077a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 17:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701222235; x=1701827035;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zEjYnAC6v5WJlAewBu+qt+4u3p9ijC8c1z31MZr719w=;
 b=OKwMeKdO7fn6H7oqWzHYhHys3xqXJy1xC5VjUPX5JlDVdOkQ/BUAhvUAPJ3rQqrLLD
 tKBXw6OIQyFbOdYMWm8hel/dGoj3jGWGU2C5L8SVTg0TTGDjf0AsSWAelY0Z3irKefQq
 4ifZS08zWZZnKU8mCEGDUC4wmxi/5XW2abzh5CxB8P3L30BJCy3mv+2GfyrofF+h3KoW
 sLL5SBLZMow22TqrdBwxPe/GF+a3vgz0lKXgE4CeZT8nXokAunk5WfG9kTn3vrRghv56
 sLd+qT69c/53VoM07262AiBwRZBR1rMH4q1l9DsWFpmzUvSMq7K9FAyWW+XiPGIHbOOk
 k3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701222235; x=1701827035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zEjYnAC6v5WJlAewBu+qt+4u3p9ijC8c1z31MZr719w=;
 b=CWEe+HII1V5ccW502PxDL/gyGvkGeT8lKeGhFoU4xMftqKu00WOq91uK5/HnVn88UL
 Ql9WN5qOPIu9Nrb1eKCKFdPQt8yE/SfiWez3K/BuJRvVOQfGTAnNwfExXHEoWCGY7eDl
 Ma6tr/j2oIzWL72sxfd5AtfN1+tX8hqxfn2vdNr9QY0Uw3dWpBfG0RTWfNvD3hMB+ZYe
 4Th20Pz7F+W+4wOOkpCmSB5koAO8RSxV+2kezN3/2t1td3abAcOFRoL8gwrZkpfAQDeF
 JX9bktpk2JhEOMa7hkabXCtXl+s3JE9CataMjlxLkWp1aa871qogp2MkQqKtxoR3PSt2
 Rm+g==
X-Gm-Message-State: AOJu0YwON7ImlEziDIHdNDPrkTqGb6pr4h/cp+mwO1ckrVHQS3hTgX3I
 vvl2J1zArItmPDN6PXi7TqDEIpvdTvl36z+27YCr5A==
X-Google-Smtp-Source: AGHT+IG7buEb9bHEgcM6XrBFMfvMh9MX59ec6qMKjmEkNd2JjXvTUPcNPWrKAvyDiApkmLsoe5a9PHP80n1Mh6EU9xo=
X-Received: by 2002:a17:90b:3ecc:b0:285:d7ae:8dd9 with SMTP id
 rm12-20020a17090b3ecc00b00285d7ae8dd9mr7999591pjb.35.1701222234236; Tue, 28
 Nov 2023 17:43:54 -0800 (PST)
MIME-Version: 1.0
References: <4413f00465bda93eda7a7560afb990ca01191062.1701185032.git.yong.huang@smartx.com>
 <6776b07c-f1a8-4b96-9527-de8e0ed16980@linaro.org>
In-Reply-To: <6776b07c-f1a8-4b96-9527-de8e0ed16980@linaro.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 29 Nov 2023 09:43:38 +0800
Message-ID: <CAK9dgmaMexn6d4TiQbcn=1T2Gvx_8tGi4V=MbtAUhuhOYSAE-w@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: Introduce SM4 symmetric cipher algorithm
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f4b7eb060b40aa52"
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52b.google.com
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

--000000000000f4b7eb060b40aa52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 11:57=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> Hi Hyman,
>
> On 28/11/23 16:24, Hyman Huang wrote:
> > Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> >
> > SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> > Organization of State Commercial Administration of China (OSCCA)
> > as an authorized cryptographic algorithms for the use within China.
> >
> > Use the crypto-sm4 meson build option for enabling this feature.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >   crypto/block-luks.c             | 11 ++++++++
> >   crypto/cipher-gcrypt.c.inc      |  8 ++++++
> >   crypto/cipher-nettle.c.inc      | 49 ++++++++++++++++++++++++++++++++=
+
> >   crypto/cipher.c                 |  6 ++++
> >   meson.build                     | 23 ++++++++++++++++
> >   meson_options.txt               |  2 ++
> >   qapi/crypto.json                |  5 +++-
> >   scripts/meson-buildoptions.sh   |  3 ++
> >   tests/unit/test-crypto-cipher.c | 13 +++++++++
> >   9 files changed, 119 insertions(+), 1 deletion(-)
>
>
> > diff --git a/meson.build b/meson.build
> > index ec01f8b138..256d3257bb 100644
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
> > @@ -1514,6 +1515,26 @@ if not gnutls_crypto.found()
> >         xts =3D 'private'
> >       endif
> >     endif
> > +  if get_option('crypto_sm4').enabled()
>
> We want to detect it by default (not only when explicitly enabled) ...
>
Ok, get it.

>
> > +    if get_option('gcrypt').enabled()
> > +      # SM4 ALG is available in libgcrypt >=3D 1.9
> > +      crypto_sm4 =3D dependency('libgcrypt', version: '>=3D1.9',
> > +                              method: 'config-tool',
> > +                              required: get_option('gcrypt'))
> > +      # SM4 ALG static compilation
> > +      if crypto_sm4.found() and get_option('prefer_static')
> > +        crypto_sm4 =3D declare_dependency(dependencies: [
> > +          crypto_sm4,
> > +          cc.find_library('gpg-error', required: true)],
> > +          version: crypto_sm4.version())
> > +      endif
> > +    else
> > +      # SM4 ALG is available in nettle >=3D 3.9
> > +      crypto_sm4 =3D dependency('nettle', version: '>=3D3.9',
> > +                              method: 'pkg-config',
> > +                              required: get_option('nettle'))
> > +    endif
>
> ... and if it was forced with --enable-crypto_sm4 AND not found,
> display an error.
>
Ok.

>
> IIUC your config you try to find the best effort implementation then
> if not found, keep going silently.
>
> > +  endif
> >   endif
>
>
> > diff --git a/scripts/meson-buildoptions.sh
> b/scripts/meson-buildoptions.sh
> > index 680fa3f581..f189f34829 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -106,6 +106,7 @@ meson_options_help() {
> >     printf "%s\n" '  colo-proxy      colo-proxy support'
> >     printf "%s\n" '  coreaudio       CoreAudio sound support'
> >     printf "%s\n" '  crypto-afalg    Linux AF_ALG crypto backend driver=
'
> > +  printf "%s\n" '  crypto-sm4      SM4 symmetric cipher algorithm
> support'
> >     printf "%s\n" '  curl            CURL block device driver'
> >     printf "%s\n" '  curses          curses UI'
> >     printf "%s\n" '  dbus-display    -display dbus support'
> > @@ -282,6 +283,8 @@ _meson_option_parse() {
> >       --disable-coroutine-pool) printf "%s" -Dcoroutine_pool=3Dfalse ;;
> >       --enable-crypto-afalg) printf "%s" -Dcrypto_afalg=3Denabled ;;
> >       --disable-crypto-afalg) printf "%s" -Dcrypto_afalg=3Ddisabled ;;
> > +    --enable-crypto-sm4) printf "%s" -Dcrypto_sm4=3Denabled ;;
> > +    --disable-crypto-sm4) printf "%s" -Dcrypto_sm4=3Ddisabled ;;
> >       --enable-curl) printf "%s" -Dcurl=3Denabled ;;
> >       --disable-curl) printf "%s" -Dcurl=3Ddisabled ;;
> >       --enable-curses) printf "%s" -Dcurses=3Denabled ;;
>
>

--=20
Best regards

--000000000000f4b7eb060b40aa52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 28, 20=
23 at 11:57=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:ph=
ilmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"=
>Hi Hyman,<br>
<br>
On 28/11/23 16:24, Hyman Huang wrote:<br>
&gt; Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).<br>
&gt; <br>
&gt; SM4 (GBT.32907-2016) is a cryptographic standard issued by the<br>
&gt; Organization of State Commercial Administration of China (OSCCA)<br>
&gt; as an authorized cryptographic algorithms for the use within China.<br=
>
&gt; <br>
&gt; Use the crypto-sm4 meson build option for enabling this feature.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0crypto/block-luks.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 11 ++++++++<br>
&gt;=C2=A0 =C2=A0crypto/cipher-gcrypt.c.inc=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +=
+++++<br>
&gt;=C2=A0 =C2=A0crypto/cipher-nettle.c.inc=C2=A0 =C2=A0 =C2=A0 | 49 ++++++=
+++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0crypto/cipher.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++++<br>
&gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 23 ++++++++++++++++<br>
&gt;=C2=A0 =C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A0qapi/crypto.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 5 +++-<br>
&gt;=C2=A0 =C2=A0scripts/meson-buildoptions.sh=C2=A0 =C2=A0|=C2=A0 3 ++<br>
&gt;=C2=A0 =C2=A0tests/unit/test-crypto-cipher.c | 13 +++++++++<br>
&gt;=C2=A0 =C2=A09 files changed, 119 insertions(+), 1 deletion(-)<br>
<br>
<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index ec01f8b138..256d3257bb 100644<br>
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
&gt; @@ -1514,6 +1515,26 @@ if not gnutls_crypto.found()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xts =3D &#39;private&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0endif<br>
&gt; +=C2=A0 if get_option(&#39;crypto_sm4&#39;).enabled()<br>
<br>
We want to detect it by default (not only when explicitly enabled) ...<br><=
/blockquote><div class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif">Ok, get it.</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:=
solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 if get_option(&#39;gcrypt&#39;).enabled()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 # SM4 ALG is available in libgcrypt &gt;=3D 1.9<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 crypto_sm4 =3D dependency(&#39;libgcrypt&#39;, v=
ersion: &#39;&gt;=3D1.9&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 method: &#39;config-tool&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required: get_option(&#39;gcrypt&#39;))=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 # SM4 ALG static compilation<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if crypto_sm4.found() and get_option(&#39;prefer=
_static&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_sm4 =3D declare_dependency(depende=
ncies: [<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_sm4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cc.find_library(&#39;gpg-error&#39=
;, required: true)],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 version: crypto_sm4.version())<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 endif<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 # SM4 ALG is available in nettle &gt;=3D 3.9<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 crypto_sm4 =3D dependency(&#39;nettle&#39;, vers=
ion: &#39;&gt;=3D3.9&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 method: &#39;pkg-config&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required: get_option(&#39;nettle&#39;))=
<br>
&gt; +=C2=A0 =C2=A0 endif<br>
<br>
... and if it was forced with --enable-crypto_sm4 AND not found,<br>
display an error.<br></blockquote><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Ok.</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
IIUC your config you try to find the best effort implementation then<br>
if not found, keep going silently.<br>
<br>
&gt; +=C2=A0 endif<br>
&gt;=C2=A0 =C2=A0endif<br>
<br>
<br>
&gt; diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoption=
s.sh<br>
&gt; index 680fa3f581..f189f34829 100644<br>
&gt; --- a/scripts/meson-buildoptions.sh<br>
&gt; +++ b/scripts/meson-buildoptions.sh<br>
&gt; @@ -106,6 +106,7 @@ meson_options_help() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 colo-proxy=C2=
=A0 =C2=A0 =C2=A0 colo-proxy support&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 coreaudio=C2=A0=
 =C2=A0 =C2=A0 =C2=A0CoreAudio sound support&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 crypto-afalg=C2=
=A0 =C2=A0 Linux AF_ALG crypto backend driver&#39;<br>
&gt; +=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 crypto-sm4=C2=A0 =C2=A0 =
=C2=A0 SM4 symmetric cipher algorithm support&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 curl=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CURL block device driver&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 curses=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 curses UI&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 dbus-display=C2=
=A0 =C2=A0 -display dbus support&#39;<br>
&gt; @@ -282,6 +283,8 @@ _meson_option_parse() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--disable-coroutine-pool) printf &quot;%s&qu=
ot; -Dcoroutine_pool=3Dfalse ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--enable-crypto-afalg) printf &quot;%s&quot;=
 -Dcrypto_afalg=3Denabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--disable-crypto-afalg) printf &quot;%s&quot=
; -Dcrypto_afalg=3Ddisabled ;;<br>
&gt; +=C2=A0 =C2=A0 --enable-crypto-sm4) printf &quot;%s&quot; -Dcrypto_sm4=
=3Denabled ;;<br>
&gt; +=C2=A0 =C2=A0 --disable-crypto-sm4) printf &quot;%s&quot; -Dcrypto_sm=
4=3Ddisabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--enable-curl) printf &quot;%s&quot; -Dcurl=
=3Denabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--disable-curl) printf &quot;%s&quot; -Dcurl=
=3Ddisabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--enable-curses) printf &quot;%s&quot; -Dcur=
ses=3Denabled ;;<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000f4b7eb060b40aa52--

