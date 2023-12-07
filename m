Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 733B6808124
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 07:50:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB8CX-0008Hy-FB; Thu, 07 Dec 2023 01:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rB8CT-0008Hq-L6
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 01:49:33 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rB8CQ-0000dx-1R
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 01:49:33 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5c5fb06b131so383875a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 22:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701931646; x=1702536446;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a5V6udHqopetspaVpssLZQJubDnZOq4rzSzxZLzxgho=;
 b=lvMhKzwsVcotQv+4wYzMmFBjShuTLopd/lx/InSdo3JYkPFllINruy/AP0gO7RgeRc
 q2FOAMi/clJPrdYlne1M8HQhQQX75C35DUKMSLgJUI9Qx4zs/47U4sTCBkOtGRBITWa/
 RkDRqEaZhnPYfgj3jutS/a0L5jbF6A0XQRMhCCed0pxcJacXaJh2/H5avoyENElVG3+7
 uJAhXsYdALfH0qDsrIs1SrTpmrbG5Cf6FAE25/G4JvkPT+y3dj58o8rXfTSQmA0nlEzx
 JuJ2NCB6GIcN/MY43zYErjHD6Wk8FDj03isVFa1WWlJR690U9o+7KBDRozWkQkTTB0Da
 HkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701931646; x=1702536446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a5V6udHqopetspaVpssLZQJubDnZOq4rzSzxZLzxgho=;
 b=iflUzwVvi9yarn0BiZf8Z58eVnQz61IPCFpALLAgVw57+X/0BVn5L3JIZYgNGV/INa
 EW5K2ArMPLgghJai31vqPZATgkTRmaNUDiBC/mD3lcZ4b7f9+nx7KlEmfno+eYqkDQlf
 3YJjYOZn34oh6HIeuw5bNa7+uIKmAL9awVGFL/S81Iff23hHlRO3K8Oa7st5/HBsXIFv
 Pv3RMtCYBGVOO4Bd7XpKS/z291d/eDivRGD3GzMJlKyrs+PXE1Z04n86LIeBdemwJBj2
 cqhyHFl6juGU5LyMRGxe1UvAqnhPKq8+TKU/9aJOU0iQVjs86wGHZNR1PZDjN79QzzsQ
 WHlg==
X-Gm-Message-State: AOJu0Yx3mQ2e2MacX1lJtNvkRz4OaeH+oTJXAWfR4V6j1FG5xCgh7Snl
 DLkhBBMFj1tjwI9ysGWOz2fXhMphNCXcDRc9rKlrCg==
X-Google-Smtp-Source: AGHT+IFGvvYxKYGRvtHgBRm7ar/E29j8KOJfGkYqZS/mhBoIBDk+uXBlYDuxl+jstXLizl9LX5Wxirvg/XdfdcBtrF8=
X-Received: by 2002:a05:6a20:26a8:b0:18c:8d0f:a7b7 with SMTP id
 h40-20020a056a2026a800b0018c8d0fa7b7mr1310699pze.22.1701931644644; Wed, 06
 Dec 2023 22:47:24 -0800 (PST)
MIME-Version: 1.0
References: <3c9608d818225af1e20478f98501594a5fea9353.1701270110.git.yong.huang@smartx.com>
 <ZXCyL9TDaQXXwaoT@redhat.com>
In-Reply-To: <ZXCyL9TDaQXXwaoT@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 7 Dec 2023 14:47:08 +0800
Message-ID: <CAK9dgmaQ0WrDJmgPOj89mKATvGWpB3WEaoAu3Ze-UmsRo2iyFA@mail.gmail.com>
Subject: Re: [PATCH v3] crypto: Introduce SM4 symmetric cipher algorithm
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001c8344060be5d7a9"
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52e.google.com
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

--0000000000001c8344060be5d7a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 1:41=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Wed, Nov 29, 2023 at 11:17:49PM +0800, Hyman Huang wrote:
> > Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> >
> > SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> > Organization of State Commercial Administration of China (OSCCA)
> > as an authorized cryptographic algorithms for the use within China.
> >
> > Use the crypto-sm4 meson build option to explicitly control the
> > feature, which would be detected by default.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  crypto/block-luks.c             | 11 ++++++++
> >  crypto/cipher-gcrypt.c.inc      |  8 ++++++
> >  crypto/cipher-nettle.c.inc      | 49 +++++++++++++++++++++++++++++++++
> >  crypto/cipher.c                 |  6 ++++
> >  meson.build                     | 42 ++++++++++++++++++++++++++++
> >  meson_options.txt               |  2 ++
> >  qapi/crypto.json                |  5 +++-
> >  scripts/meson-buildoptions.sh   |  3 ++
> >  tests/unit/test-crypto-cipher.c | 13 +++++++++
> >  9 files changed, 138 insertions(+), 1 deletion(-)
> >
>
> > diff --git a/meson.build b/meson.build
> > index ec01f8b138..765f9c9f50 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1480,6 +1480,7 @@ endif
> >  gcrypt =3D not_found
> >  nettle =3D not_found
> >  hogweed =3D not_found
> > +crypto_sm4 =3D not_found
> >  xts =3D 'none'
> >
> >  if get_option('nettle').enabled() and get_option('gcrypt').enabled()
> > @@ -1505,6 +1506,28 @@ if not gnutls_crypto.found()
> >           cc.find_library('gpg-error', required: true)],
> >          version: gcrypt.version())
> >      endif
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
> > +      if get_option('crypto_sm4').enabled()
> > +        error('could not link sm4')
> > +      else
> > +        warning('could not link sm4, disabling')
> > +      endif
>
> IMHO we don't need to have an option for 'crypto_sm4', just
> silently disable it if not present in the host provideed
> library.


OK, I don't insist on that and I'll drop the option in the next version.

>
>
> +    endif
> > +    if crypto_sm4.found() and get_option('prefer_static')
> > +      crypto_sm4 =3D declare_dependency(dependencies: [
> > +        gcrypt,
> > +        cc.find_library('gpg-error', required: true)],
> > +        version: gcrypt.version())
> > +    endif
>
> This last if/endif block is redundant. We already have earlier
> logic that detects gpg-error, and we never use the 'crypto_sm4'
> object after this point anyway
>
> >    endif
> >    if (not get_option('nettle').auto() or have_system) and not
> gcrypt.found()
> >      nettle =3D dependency('nettle', version: '>=3D3.4',
> > @@ -1513,6 +1536,23 @@ if not gnutls_crypto.found()
> >      if nettle.found() and not cc.has_header('nettle/xts.h',
> dependencies: nettle)
> >        xts =3D 'private'
> >      endif
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
> > +      if get_option('crypto_sm4').enabled()
> > +        error('could not link sm4')
> > +      else
> > +        warning('could not link sm4, disabling')
> > +      endif
>
> Likewise no need for an option, just silently disable it.
>
> > +    endif
> >    endif
> >  endif
> >
> > @@ -2199,6 +2239,7 @@ config_host_data.set('CONFIG_GNUTLS_CRYPTO',
> gnutls_crypto.found())
> >  config_host_data.set('CONFIG_TASN1', tasn1.found())
> >  config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
> >  config_host_data.set('CONFIG_NETTLE', nettle.found())
> > +config_host_data.set('CONFIG_CRYPTO_SM4', crypto_sm4.found())
> >  config_host_data.set('CONFIG_HOGWEED', hogweed.found())
> >  config_host_data.set('CONFIG_QEMU_PRIVATE_XTS', xts =3D=3D 'private')
> >  config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
> > @@ -4273,6 +4314,7 @@ summary_info +=3D {'nettle':            nettle}
> >  if nettle.found()
> >     summary_info +=3D {'  XTS':             xts !=3D 'private'}
> >  endif
> > +summary_info +=3D {'SM4 ALG support':   crypto_sm4}
> >  summary_info +=3D {'AF_ALG support':    have_afalg}
> >  summary_info +=3D {'rng-none':          get_option('rng_none')}
> >  summary_info +=3D {'Linux keyring':     have_keyring}
> > diff --git a/meson_options.txt b/meson_options.txt
> > index c9baeda639..db8de4ec5b 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -172,6 +172,8 @@ option('nettle', type : 'feature', value : 'auto',
> >         description: 'nettle cryptography support')
> >  option('gcrypt', type : 'feature', value : 'auto',
> >         description: 'libgcrypt cryptography support')
> > +option('crypto_sm4', type : 'feature', value : 'auto',
> > +       description: 'SM4 symmetric cipher algorithm support')
>
> Drop this.
>
> >  option('crypto_afalg', type : 'feature', value : 'disabled',
> >         description: 'Linux AF_ALG crypto backend driver')
> >  option('libdaxctl', type : 'feature', value : 'auto',
>
> > diff --git a/scripts/meson-buildoptions.sh
> b/scripts/meson-buildoptions.sh
> > index 680fa3f581..f189f34829 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -106,6 +106,7 @@ meson_options_help() {
> >    printf "%s\n" '  colo-proxy      colo-proxy support'
> >    printf "%s\n" '  coreaudio       CoreAudio sound support'
> >    printf "%s\n" '  crypto-afalg    Linux AF_ALG crypto backend driver'
> > +  printf "%s\n" '  crypto-sm4      SM4 symmetric cipher algorithm
> support'
> >    printf "%s\n" '  curl            CURL block device driver'
> >    printf "%s\n" '  curses          curses UI'
> >    printf "%s\n" '  dbus-display    -display dbus support'
> > @@ -282,6 +283,8 @@ _meson_option_parse() {
> >      --disable-coroutine-pool) printf "%s" -Dcoroutine_pool=3Dfalse ;;
> >      --enable-crypto-afalg) printf "%s" -Dcrypto_afalg=3Denabled ;;
> >      --disable-crypto-afalg) printf "%s" -Dcrypto_afalg=3Ddisabled ;;
> > +    --enable-crypto-sm4) printf "%s" -Dcrypto_sm4=3Denabled ;;
> > +    --disable-crypto-sm4) printf "%s" -Dcrypto_sm4=3Ddisabled ;;
> >      --enable-curl) printf "%s" -Dcurl=3Denabled ;;
> >      --disable-curl) printf "%s" -Dcurl=3Ddisabled ;;
> >      --enable-curses) printf "%s" -Dcurses=3Denabled ;;
>
> This can go away too
>
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
> Thanks,
Yong

--=20
Best regards

--0000000000001c8344060be5d7a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 7, 202=
3 at 1:41=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange=
@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Wed, Nov 29, 2023 at 11:17:49PM +0800, Hyman Huang wrote:<br>
&gt; Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).<br>
&gt; <br>
&gt; SM4 (GBT.32907-2016) is a cryptographic standard issued by the<br>
&gt; Organization of State Commercial Administration of China (OSCCA)<br>
&gt; as an authorized cryptographic algorithms for the use within China.<br=
>
&gt; <br>
&gt; Use the crypto-sm4 meson build option to explicitly control the<br>
&gt; feature, which would be detected by default.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 crypto/block-luks.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 11 ++++++++<br>
&gt;=C2=A0 crypto/cipher-gcrypt.c.inc=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++++++<=
br>
&gt;=C2=A0 crypto/cipher-nettle.c.inc=C2=A0 =C2=A0 =C2=A0 | 49 ++++++++++++=
+++++++++++++++++++++<br>
&gt;=C2=A0 crypto/cipher.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 6 ++++<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 42 ++++++++++++++++++++++++++++<br>
&gt;=C2=A0 meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 qapi/crypto.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 5 +++-<br>
&gt;=C2=A0 scripts/meson-buildoptions.sh=C2=A0 =C2=A0|=C2=A0 3 ++<br>
&gt;=C2=A0 tests/unit/test-crypto-cipher.c | 13 +++++++++<br>
&gt;=C2=A0 9 files changed, 138 insertions(+), 1 deletion(-)<br>
&gt; <br>
<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index ec01f8b138..765f9c9f50 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -1480,6 +1480,7 @@ endif<br>
&gt;=C2=A0 gcrypt =3D not_found<br>
&gt;=C2=A0 nettle =3D not_found<br>
&gt;=C2=A0 hogweed =3D not_found<br>
&gt; +crypto_sm4 =3D not_found<br>
&gt;=C2=A0 xts =3D &#39;none&#39;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 if get_option(&#39;nettle&#39;).enabled() and get_option(&#39;gc=
rypt&#39;).enabled()<br>
&gt; @@ -1505,6 +1506,28 @@ if not gnutls_crypto.found()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc.find_library(&#39;gpg-error=
&#39;, required: true)],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 version: gcrypt.version())<br>
&gt;=C2=A0 =C2=A0 =C2=A0 endif<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 if get_option(&#39;crypto_sm4&#39;).enabled()<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error(&#39;could not link sm4&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 warning(&#39;could not link sm4, disablin=
g&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 endif<br>
<br>
IMHO we don&#39;t need to have an option for &#39;crypto_sm4&#39;, just<br>
silently disable it if not present in the host provideed<br>
library.</blockquote><div><br></div><div class=3D"gmail_default" style=3D"f=
ont-family:&quot;comic sans ms&quot;,sans-serif">OK, I don&#39;t insist on =
that and I&#39;ll drop the option in the next version.</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;=
border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex=
">=C2=A0<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left=
-color:rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 endif<br>
&gt; +=C2=A0 =C2=A0 if crypto_sm4.found() and get_option(&#39;prefer_static=
&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 crypto_sm4 =3D declare_dependency(dependencies: =
[<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gcrypt,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cc.find_library(&#39;gpg-error&#39;, requ=
ired: true)],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 version: gcrypt.version())<br>
&gt; +=C2=A0 =C2=A0 endif<br>
<br>
This last if/endif block is redundant. We already have earlier<br>
logic that detects gpg-error, and we never use the &#39;crypto_sm4&#39;<br>
object after this point anyway<br>
<br>
&gt;=C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 =C2=A0 if (not get_option(&#39;nettle&#39;).auto() or have_syste=
m) and not gcrypt.found()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 nettle =3D dependency(&#39;nettle&#39;, version: &=
#39;&gt;=3D3.4&#39;,<br>
&gt; @@ -1513,6 +1536,23 @@ if not gnutls_crypto.found()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if nettle.found() and not cc.has_header(&#39;nettl=
e/xts.h&#39;, dependencies: nettle)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 xts =3D &#39;private&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 endif<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 if get_option(&#39;crypto_sm4&#39;).enabled()<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error(&#39;could not link sm4&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 warning(&#39;could not link sm4, disablin=
g&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 endif<br>
<br>
Likewise no need for an option, just silently disable it.<br>
<br>
&gt; +=C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 <br>
&gt; @@ -2199,6 +2239,7 @@ config_host_data.set(&#39;CONFIG_GNUTLS_CRYPTO&#=
39;, gnutls_crypto.found())<br>
&gt;=C2=A0 config_host_data.set(&#39;CONFIG_TASN1&#39;, tasn1.found())<br>
&gt;=C2=A0 config_host_data.set(&#39;CONFIG_GCRYPT&#39;, gcrypt.found())<br=
>
&gt;=C2=A0 config_host_data.set(&#39;CONFIG_NETTLE&#39;, nettle.found())<br=
>
&gt; +config_host_data.set(&#39;CONFIG_CRYPTO_SM4&#39;, crypto_sm4.found())=
<br>
&gt;=C2=A0 config_host_data.set(&#39;CONFIG_HOGWEED&#39;, hogweed.found())<=
br>
&gt;=C2=A0 config_host_data.set(&#39;CONFIG_QEMU_PRIVATE_XTS&#39;, xts =3D=
=3D &#39;private&#39;)<br>
&gt;=C2=A0 config_host_data.set(&#39;CONFIG_MALLOC_TRIM&#39;, has_malloc_tr=
im)<br>
&gt; @@ -4273,6 +4314,7 @@ summary_info +=3D {&#39;nettle&#39;:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nettle}<br>
&gt;=C2=A0 if nettle.found()<br>
&gt;=C2=A0 =C2=A0 =C2=A0summary_info +=3D {&#39;=C2=A0 XTS&#39;:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xts !=3D &#39;private&#39;}<br>
&gt;=C2=A0 endif<br>
&gt; +summary_info +=3D {&#39;SM4 ALG support&#39;:=C2=A0 =C2=A0crypto_sm4}=
<br>
&gt;=C2=A0 summary_info +=3D {&#39;AF_ALG support&#39;:=C2=A0 =C2=A0 have_a=
falg}<br>
&gt;=C2=A0 summary_info +=3D {&#39;rng-none&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 get_option(&#39;rng_none&#39;)}<br>
&gt;=C2=A0 summary_info +=3D {&#39;Linux keyring&#39;:=C2=A0 =C2=A0 =C2=A0h=
ave_keyring}<br>
&gt; diff --git a/meson_options.txt b/meson_options.txt<br>
&gt; index c9baeda639..db8de4ec5b 100644<br>
&gt; --- a/meson_options.txt<br>
&gt; +++ b/meson_options.txt<br>
&gt; @@ -172,6 +172,8 @@ option(&#39;nettle&#39;, type : &#39;feature&#39;,=
 value : &#39;auto&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;nettle cryptography=
 support&#39;)<br>
&gt;=C2=A0 option(&#39;gcrypt&#39;, type : &#39;feature&#39;, value : &#39;=
auto&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;libgcrypt cryptogra=
phy support&#39;)<br>
&gt; +option(&#39;crypto_sm4&#39;, type : &#39;feature&#39;, value : &#39;a=
uto&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;SM4 symmetric cipher alg=
orithm support&#39;)<br>
<br>
Drop this.<br>
<br>
&gt;=C2=A0 option(&#39;crypto_afalg&#39;, type : &#39;feature&#39;, value :=
 &#39;disabled&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;Linux AF_ALG crypto=
 backend driver&#39;)<br>
&gt;=C2=A0 option(&#39;libdaxctl&#39;, type : &#39;feature&#39;, value : &#=
39;auto&#39;,<br>
<br>
&gt; diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoption=
s.sh<br>
&gt; index 680fa3f581..f189f34829 100644<br>
&gt; --- a/scripts/meson-buildoptions.sh<br>
&gt; +++ b/scripts/meson-buildoptions.sh<br>
&gt; @@ -106,6 +106,7 @@ meson_options_help() {<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 colo-proxy=C2=A0 =C2=
=A0 =C2=A0 colo-proxy support&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 coreaudio=C2=A0 =C2=
=A0 =C2=A0 =C2=A0CoreAudio sound support&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 crypto-afalg=C2=A0 =
=C2=A0 Linux AF_ALG crypto backend driver&#39;<br>
&gt; +=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 crypto-sm4=C2=A0 =C2=A0 =
=C2=A0 SM4 symmetric cipher algorithm support&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 curl=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 CURL block device driver&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 curses=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 curses UI&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 dbus-display=C2=A0 =
=C2=A0 -display dbus support&#39;<br>
&gt; @@ -282,6 +283,8 @@ _meson_option_parse() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --disable-coroutine-pool) printf &quot;%s&quot; -D=
coroutine_pool=3Dfalse ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --enable-crypto-afalg) printf &quot;%s&quot; -Dcry=
pto_afalg=3Denabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --disable-crypto-afalg) printf &quot;%s&quot; -Dcr=
ypto_afalg=3Ddisabled ;;<br>
&gt; +=C2=A0 =C2=A0 --enable-crypto-sm4) printf &quot;%s&quot; -Dcrypto_sm4=
=3Denabled ;;<br>
&gt; +=C2=A0 =C2=A0 --disable-crypto-sm4) printf &quot;%s&quot; -Dcrypto_sm=
4=3Ddisabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --enable-curl) printf &quot;%s&quot; -Dcurl=3Denab=
led ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --disable-curl) printf &quot;%s&quot; -Dcurl=3Ddis=
abled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --enable-curses) printf &quot;%s&quot; -Dcurses=3D=
enabled ;;<br>
<br>
This can go away too<br>
<br>
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
</blockquote></div><div class=3D"gmail_default" style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif"></div><div class=3D"gmail_default" style=3D=
"font-family:&quot;comic sans ms&quot;,sans-serif">Thanks,</div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">Yong</div><div><br></div><span class=3D"gmail_signature_prefix">-- </spa=
n><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font fac=
e=3D"comic sans ms, sans-serif">Best regards</font></div></div></div>

--0000000000001c8344060be5d7a9--

