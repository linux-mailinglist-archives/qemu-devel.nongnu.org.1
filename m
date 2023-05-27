Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04487713632
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 21:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2zQw-0003aA-5C; Sat, 27 May 2023 15:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2zQs-0003a1-Nx
 for qemu-devel@nongnu.org; Sat, 27 May 2023 15:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2zQq-0001q9-GT
 for qemu-devel@nongnu.org; Sat, 27 May 2023 15:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685215106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OiqCQIjVBiAOsxVLm+rtbLWVnEn5+VUEeD4u9ZR0DzI=;
 b=cyMHzM8XTMs9jrztB9xtUL3Ee+jbwndFi6ICeaR2cA0QxTW6MRyaFiXjKOJLwXKgkvPVtr
 RkyiuZRIabCM0T7JRKKy2Ao2dDIjwZzmM4jBjN+KnkatZYyi3SsJQ/OBZmq6RTv0uSLaik
 N+toOkXRORFKinuaEav3T9HC7ThAqXQ=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-p1uJw8XLPiGv_q1bplbs3g-1; Sat, 27 May 2023 15:18:23 -0400
X-MC-Unique: p1uJw8XLPiGv_q1bplbs3g-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-45742278ecbso327059e0c.1
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 12:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685215103; x=1687807103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OiqCQIjVBiAOsxVLm+rtbLWVnEn5+VUEeD4u9ZR0DzI=;
 b=awVDFp+7KLR2d3HJ7a0JaqNEDonAIjv9G9zXgNGcM+uhHIS47cBTssFWWyVt0qXDlz
 u4+dplfZPFMbKKh8gAfSEPnxCOQJIgXR7HH/FnOG5RtqHlfAbcwfeNLlKRr2VVpvV/wi
 2sHPkyFQEfOO3KUe3a6yvQtQUfQgVkhRmdC15Hq61I+ccVNIo25A2SupLKW1cVRuQ/X/
 OdCHYIO+0klO2FV3A7efF/cULPk2TWtsxeEM7KOyff/WVvmQhFnuYzEJKZOJ18Srg0Mu
 4reZ1p6tzXs6KDqvpyz4QF4bF+ZQPUXOm5lHYzlyl3obYbRbnCfugL7SQfvKpEssb4wf
 5rtA==
X-Gm-Message-State: AC+VfDy2ECWoSTpQvABoFDmr1X4htjMuPsAv7BQqRyqNBeWYN6mn13pQ
 mXHgftsOGbzVw/bUcozQsI0vDW3AYynEBjZ0Mt2teqOU/YeJESV/cKLA9b+UJeh1qmYKvyWRV3s
 fKN1WWH0lzG0wHu69Xc0A+Pm664hnZLc=
X-Received: by 2002:a05:6102:2dc:b0:42f:46d1:ffad with SMTP id
 h28-20020a05610202dc00b0042f46d1ffadmr1815831vsh.22.1685215102800; 
 Sat, 27 May 2023 12:18:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4KAYUOUnuAp7YWZAvguqGzNnt3484W6uJEE/47Fk8fOmLECnmmcEqlkD86LHJOo8YYKmsMw4eKI21nYY0Fo80=
X-Received: by 2002:a05:6102:2dc:b0:42f:46d1:ffad with SMTP id
 h28-20020a05610202dc00b0042f46d1ffadmr1815830vsh.22.1685215102575; Sat, 27
 May 2023 12:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <20230527092851.705884-3-pbonzini@redhat.com>
 <923f7d6b-73c8-eeb0-2e3c-1c129126a950@eik.bme.hu>
In-Reply-To: <923f7d6b-73c8-eeb0-2e3c-1c129126a950@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 27 May 2023 21:18:10 +0200
Message-ID: <CABgObfbJXaPdLEzp0UXyhO5k4895xibN87Lb60wmtU-cXbDoZg@mail.gmail.com>
Subject: Re: [PATCH 2/5] configure: rename --enable-pypi to --enable-download, 
 control subprojects too
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Maydell,
 Peter" <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, "P. Berrange, Daniel" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008f3f0b05fcb1b7f9"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000008f3f0b05fcb1b7f9
Content-Type: text/plain; charset="UTF-8"

Il sab 27 mag 2023, 18:49 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:

> On Sat, 27 May 2023, Paolo Bonzini wrote:
> > The behavior of --{enable,disable}-pypi is similar to that of
> > -Dwrapmode={default,nodownload} respectively.  In particular,
> > in both cases a feature needs to be explicitly enabled for the
> > dependency to be downloaded.
>
> Is this the default? Can it default to disabled so it won't download
> anytihng unless asked to do that? By default it should just report if
> something is missing and let the users decide how they want to install it.
>

It is the default but only for features that are explicitly enabled on the
configure command line. For example sphinx will not be installed unless
--enable-docs is present.

However, if in the future we remove the bundled dtc sources from the
tarball, that might be an exception in that dtc would be downloaded anyway.
To be clear, this is not something that is changed by this series.

Paolo


> Regards,
> BALATON Zoltan
>
> > bindir="bin"
> > skip_meson=no
> > vfio_user_server="disabled"
> > @@ -756,9 +756,9 @@ for opt do
> >   --with-git-submodules=*)
> >       git_submodules_action="$optarg"
> >   ;;
> > -  --disable-pypi) pypi="disabled"
> > +  --disable-download) download="disabled"
> >   ;;
> > -  --enable-pypi) pypi="enabled"
> > +  --enable-download) download="enabled"
> >   ;;
> >   --enable-plugins) if test "$mingw32" = "yes"; then
> >                         error_exit "TCG plugins not currently supported
> on Windows platforms"
> > @@ -962,7 +962,7 @@ python="$(command -v "$python")"
> > # - venv is allowed to use system packages;
> > # - all setup can be performed offline;
> > # - missing packages may be fetched from PyPI,
> > -#   unless --disable-pypi is passed.
> > +#   unless --disable-download is passed.
> > # - pip is not installed into the venv when possible,
> > #   but ensurepip is called as a fallback when necessary.
> >
> > @@ -979,7 +979,7 @@ python="$python -B"
> > mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
> >
> > mkvenv_flags=""
> > -if test "$pypi" = "enabled" ; then
> > +if test "$download" = "enabled" ; then
> >     mkvenv_flags="--online"
> > fi
> >
> > @@ -1002,7 +1002,7 @@ meson="$(cd pyvenv/bin; pwd)/meson"
> > # Conditionally ensure Sphinx is installed.
> >
> > mkvenv_flags=""
> > -if test "$pypi" = "enabled" -a "$docs" = "enabled" ; then
> > +if test "$download" = "enabled" -a "$docs" = "enabled" ; then
> >     mkvenv_flags="--online"
> > fi
> >
> > @@ -1942,11 +1942,8 @@ if test "$skip_meson" = no; then
> >
> >   rm -rf meson-private meson-info meson-logs
> >
> > -  # Prevent meson from automatically downloading wrapped subprojects
> when missing.
> > -  # You can use 'meson subprojects download' before running configure.
> > -  meson_option_add "--wrap-mode=nodownload"
> > -
> >   # Built-in options
> > +  test "$download" = "disabled" && meson_option_add
> "--wrap-mode=nodownload"
> >   test "$bindir" != "bin" && meson_option_add "-Dbindir=$bindir"
> >   test "$default_feature" = no && meson_option_add
> -Dauto_features=disabled
> >   test "$static" = yes && meson_option_add -Dprefer_static=true
> > diff --git a/subprojects/.gitignore b/subprojects/.gitignore
> > new file mode 100644
> > index 000000000000..7560ebb0b1a0
> > --- /dev/null
> > +++ b/subprojects/.gitignore
> > @@ -0,0 +1,3 @@
> > +/packagecache
> > +
> > +/slirp
> >

--0000000000008f3f0b05fcb1b7f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 27 mag 2023, 18:49 BALATON Zoltan &lt;<a href=
=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; ha scritto:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On Sat, 27 May 2023, Paolo Bonzini wrote=
:<br>
&gt; The behavior of --{enable,disable}-pypi is similar to that of<br>
&gt; -Dwrapmode=3D{default,nodownload} respectively.=C2=A0 In particular,<b=
r>
&gt; in both cases a feature needs to be explicitly enabled for the<br>
&gt; dependency to be downloaded.<br>
<br>
Is this the default? Can it default to disabled so it won&#39;t download <b=
r>
anytihng unless asked to do that? By default it should just report if <br>
something is missing and let the users decide how they want to install it.<=
br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I=
t is the default but only for features that are explicitly enabled on the c=
onfigure command line. For example sphinx will not be installed unless --en=
able-docs is present.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Ho=
wever, if in the future we remove the bundled dtc sources from the tarball,=
 that might be an exception in that dtc would be downloaded anyway. To be c=
lear, this is not something that is changed by this series.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
&gt; bindir=3D&quot;bin&quot;<br>
&gt; skip_meson=3Dno<br>
&gt; vfio_user_server=3D&quot;disabled&quot;<br>
&gt; @@ -756,9 +756,9 @@ for opt do<br>
&gt;=C2=A0 =C2=A0--with-git-submodules=3D*)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0git_submodules_action=3D&quot;$optarg&quot;<=
br>
&gt;=C2=A0 =C2=A0;;<br>
&gt; -=C2=A0 --disable-pypi) pypi=3D&quot;disabled&quot;<br>
&gt; +=C2=A0 --disable-download) download=3D&quot;disabled&quot;<br>
&gt;=C2=A0 =C2=A0;;<br>
&gt; -=C2=A0 --enable-pypi) pypi=3D&quot;enabled&quot;<br>
&gt; +=C2=A0 --enable-download) download=3D&quot;enabled&quot;<br>
&gt;=C2=A0 =C2=A0;;<br>
&gt;=C2=A0 =C2=A0--enable-plugins) if test &quot;$mingw32&quot; =3D &quot;y=
es&quot;; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0error_exit &quot;TCG plugins not currently supported on=
 Windows platforms&quot;<br>
&gt; @@ -962,7 +962,7 @@ python=3D&quot;$(command -v &quot;$python&quot;)&q=
uot;<br>
&gt; # - venv is allowed to use system packages;<br>
&gt; # - all setup can be performed offline;<br>
&gt; # - missing packages may be fetched from PyPI,<br>
&gt; -#=C2=A0 =C2=A0unless --disable-pypi is passed.<br>
&gt; +#=C2=A0 =C2=A0unless --disable-download is passed.<br>
&gt; # - pip is not installed into the venv when possible,<br>
&gt; #=C2=A0 =C2=A0but ensurepip is called as a fallback when necessary.<br=
>
&gt;<br>
&gt; @@ -979,7 +979,7 @@ python=3D&quot;$python -B&quot;<br>
&gt; mkvenv=3D&quot;$python ${source_path}/python/scripts/mkvenv.py&quot;<b=
r>
&gt;<br>
&gt; mkvenv_flags=3D&quot;&quot;<br>
&gt; -if test &quot;$pypi&quot; =3D &quot;enabled&quot; ; then<br>
&gt; +if test &quot;$download&quot; =3D &quot;enabled&quot; ; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0mkvenv_flags=3D&quot;--online&quot;<br>
&gt; fi<br>
&gt;<br>
&gt; @@ -1002,7 +1002,7 @@ meson=3D&quot;$(cd pyvenv/bin; pwd)/meson&quot;<=
br>
&gt; # Conditionally ensure Sphinx is installed.<br>
&gt;<br>
&gt; mkvenv_flags=3D&quot;&quot;<br>
&gt; -if test &quot;$pypi&quot; =3D &quot;enabled&quot; -a &quot;$docs&quot=
; =3D &quot;enabled&quot; ; then<br>
&gt; +if test &quot;$download&quot; =3D &quot;enabled&quot; -a &quot;$docs&=
quot; =3D &quot;enabled&quot; ; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0mkvenv_flags=3D&quot;--online&quot;<br>
&gt; fi<br>
&gt;<br>
&gt; @@ -1942,11 +1942,8 @@ if test &quot;$skip_meson&quot; =3D no; then<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0rm -rf meson-private meson-info meson-logs<br>
&gt;<br>
&gt; -=C2=A0 # Prevent meson from automatically downloading wrapped subproj=
ects when missing.<br>
&gt; -=C2=A0 # You can use &#39;meson subprojects download&#39; before runn=
ing configure.<br>
&gt; -=C2=A0 meson_option_add &quot;--wrap-mode=3Dnodownload&quot;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0# Built-in options<br>
&gt; +=C2=A0 test &quot;$download&quot; =3D &quot;disabled&quot; &amp;&amp;=
 meson_option_add &quot;--wrap-mode=3Dnodownload&quot;<br>
&gt;=C2=A0 =C2=A0test &quot;$bindir&quot; !=3D &quot;bin&quot; &amp;&amp; m=
eson_option_add &quot;-Dbindir=3D$bindir&quot;<br>
&gt;=C2=A0 =C2=A0test &quot;$default_feature&quot; =3D no &amp;&amp; meson_=
option_add -Dauto_features=3Ddisabled<br>
&gt;=C2=A0 =C2=A0test &quot;$static&quot; =3D yes &amp;&amp; meson_option_a=
dd -Dprefer_static=3Dtrue<br>
&gt; diff --git a/subprojects/.gitignore b/subprojects/.gitignore<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..7560ebb0b1a0<br>
&gt; --- /dev/null<br>
&gt; +++ b/subprojects/.gitignore<br>
&gt; @@ -0,0 +1,3 @@<br>
&gt; +/packagecache<br>
&gt; +<br>
&gt; +/slirp<br>
&gt;</blockquote></div></div></div>

--0000000000008f3f0b05fcb1b7f9--


