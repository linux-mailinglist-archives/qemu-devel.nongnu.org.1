Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 004A37497E7
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 11:04:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKuI-0000Id-IQ; Thu, 06 Jul 2023 05:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHKuG-0000IU-NO
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 05:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHKuE-000754-G5
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 05:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688634244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j3FkJaHrHtXNucQGzjMKt3XBk6cdWPD0/7g2mPItFSk=;
 b=TekLGW0RmaVZHSBgUXuIqrKxfO+BAvuqzKKrjSGPmfvyhvvDUoNvuEW8KKIblvebFUkQIH
 llJLpGg1rl+pyGgTdIBuwXKYIpfPUmcs6K1LR3qC1PVXWfkC9qfJBV2qXRqCkDV5UGNHrk
 kygx3/jKciHV0PrVARNMsVNc9r+sJgo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-OR9CZzenPrmduM0Y2xy-7w-1; Thu, 06 Jul 2023 05:04:03 -0400
X-MC-Unique: OR9CZzenPrmduM0Y2xy-7w-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b6f97c9d54so4811511fa.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 02:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688634241; x=1691226241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j3FkJaHrHtXNucQGzjMKt3XBk6cdWPD0/7g2mPItFSk=;
 b=kPsvd2wcU8s+yih4u44hdHf1dau7m6SfMrilMRxZeiVsdyLA2FbRXNIlOGeVhZYBSL
 Mmz/yNzBtL2S7Vx7Au8XUI8ck+3oBUB/Hwfsh+RaJnvecH/9GRGzddvAr68V9X9l2jG7
 l5Q5Y0zTEuJOFY0rphmHw/RGp1WJEsXa55I/901HfuU8WUxM8yl7IwRD9yXy1d3ngU1q
 +I1isG9oLkcYFKP97qXH/7Er1TRPKR1mu47iPvoI05Fbztvb/A+wrnOJsZWPQ3hp0Sz4
 BNxSYJkXvhOvxZLYmQVnsoX54YOHDs9qGKsV8cUKggD6KrZxBolmvR2izdTu4yZVdlof
 COoQ==
X-Gm-Message-State: ABy/qLaM/jjdD4rGnsk692YzhTu/XcKRIrdvBa8Q1fF7XDRdQwA5j3ja
 RBsLht4vzLqbCXGOZ+mcQ3wNFe1BaiacR+8sy/ZzObUGBfzDlXe/U6ObpH09NAdDgLZbuUEJdCa
 e6UHlHHDIb4GnywVte+otOHOEMwoKIk8=
X-Received: by 2002:a2e:8496:0:b0:2b6:ecdd:16cf with SMTP id
 b22-20020a2e8496000000b002b6ecdd16cfmr742784ljh.40.1688634241692; 
 Thu, 06 Jul 2023 02:04:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE5dVW1NRYvigcTRA+o0ZbeehhRbwFeK7+yLNpUtfFt6xQyOddqwqmYnSiLkq3TPpf//NDLaAr8br1gPjth7bI=
X-Received: by 2002:a2e:8496:0:b0:2b6:ecdd:16cf with SMTP id
 b22-20020a2e8496000000b002b6ecdd16cfmr742765ljh.40.1688634241365; Thu, 06 Jul
 2023 02:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230706064736.178962-1-thuth@redhat.com>
In-Reply-To: <20230706064736.178962-1-thuth@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 6 Jul 2023 12:03:50 +0300
Message-ID: <CAPMcbCrZp62ha5jS26-XLTduPuf04xDgr_E=dJXu1oWp283Vtg@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Remove the logic to link C code with the C++
 linker
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001cd1e105ffcdcc32"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000001cd1e105ffcdcc32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jul 6, 2023 at 9:47=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:

> We are not mixing C++ with C code anymore, the only remaining
> C++ code in qga/vss-win32/ is used for a plain C++ executable.
> Thus we can remove the hacks for linking C code with the C++ linker
> now to simplify meson.build a little bit, and also to avoid that
> some C++ code sneaks in by accident again.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  meson.build     | 24 ++++++------------------
>  scripts/main.c  |  1 -
>  qga/meson.build |  2 +-
>  3 files changed, 7 insertions(+), 20 deletions(-)
>  delete mode 100644 scripts/main.c
>
> diff --git a/meson.build b/meson.build
> index 5559b36859..620457bb95 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -473,19 +473,10 @@ if targetos !=3D 'darwin'
>    warn_flags +=3D ['-Wthread-safety']
>  endif
>
> -# Check that the C++ compiler exists and works with the C compiler.
> -link_language =3D 'c'
> -linker =3D cc
> +# Set up C++ compiler flags
>  qemu_cxxflags =3D []
>  if 'cpp' in all_languages
>    qemu_cxxflags =3D ['-D__STDC_LIMIT_MACROS', '-D__STDC_CONSTANT_MACROS'=
,
> '-D__STDC_FORMAT_MACROS'] + qemu_cflags
> -  if cxx.links(files('scripts/main.c'), args: qemu_cflags)
> -    link_language =3D 'cpp'
> -    linker =3D cxx
> -  else
> -    message('C++ compiler does not work with C compiler')
> -    message('Disabling C++-specific optional code')
> -  endif
>  endif
>
>  # clang does not support glibc + FORTIFY_SOURCE (is it still true?)
> @@ -1600,7 +1591,7 @@ if not get_option('snappy').auto() or have_system
>    snappy =3D cc.find_library('snappy', has_headers: ['snappy-c.h'],
>                             required: get_option('snappy'))
>  endif
> -if snappy.found() and not linker.links('''
> +if snappy.found() and not cc.links('''
>     #include <snappy-c.h>
>     int main(void) { snappy_max_compressed_length(4096); return 0; }''',
> dependencies: snappy)
>    snappy =3D not_found
> @@ -2746,7 +2737,7 @@ config_host_data.set('CONFIG_AF_VSOCK',
> cc.has_header_symbol(
>
>  have_vss =3D false
>  have_vss_sdk =3D false # old xp/2003 SDK
> -if targetos =3D=3D 'windows' and link_language =3D=3D 'cpp'
> +if targetos =3D=3D 'windows' and 'cpp' in all_languages
>    have_vss =3D cxx.compiles('''
>      #define __MIDL_user_allocate_free_DEFINED__
>      #include <vss.h>
> @@ -3827,7 +3818,6 @@ foreach target : target_dirs
>                 c_args: c_args,
>                 dependencies: arch_deps + deps + exe['dependencies'],
>                 objects: lib.extract_all_objects(recursive: true),
> -               link_language: link_language,
>                 link_depends: [block_syms, qemu_syms] +
> exe.get('link_depends', []),
>                 link_args: link_args,
>                 win_subsystem: exe['win_subsystem'])
> @@ -4061,10 +4051,8 @@ summary_info +=3D {'host CPU':          cpu}
>  summary_info +=3D {'host endianness':   build_machine.endian()}
>  summary_info +=3D {'C compiler':        '
> '.join(meson.get_compiler('c').cmd_array())}
>  summary_info +=3D {'Host C compiler':   ' '.join(meson.get_compiler('c',
> native: true).cmd_array())}
> -if link_language =3D=3D 'cpp'
> +if 'cpp' in all_languages
>    summary_info +=3D {'C++ compiler':    '
> '.join(meson.get_compiler('cpp').cmd_array())}
> -else
> -  summary_info +=3D {'C++ compiler':      false}
>  endif
>  if targetos =3D=3D 'darwin'
>    summary_info +=3D {'Objective-C compiler': '
> '.join(meson.get_compiler('objc').cmd_array())}
> @@ -4074,13 +4062,13 @@ if get_option('optimization') !=3D 'plain'
>    option_cflags +=3D ['-O' + get_option('optimization')]
>  endif
>  summary_info +=3D {'CFLAGS':            ' '.join(get_option('c_args') +
> option_cflags)}
> -if link_language =3D=3D 'cpp'
> +if 'cpp' in all_languages
>    summary_info +=3D {'CXXFLAGS':        ' '.join(get_option('cpp_args') =
+
> option_cflags)}
>  endif
>  if targetos =3D=3D 'darwin'
>    summary_info +=3D {'OBJCFLAGS':       ' '.join(get_option('objc_args')=
 +
> option_cflags)}
>  endif
> -link_args =3D get_option(link_language + '_link_args')
> +link_args =3D get_option('c_link_args')
>  if link_args.length() > 0
>    summary_info +=3D {'LDFLAGS':         ' '.join(link_args)}
>  endif
> diff --git a/scripts/main.c b/scripts/main.c
> deleted file mode 100644
> index b552c8e4ed..0000000000
> --- a/scripts/main.c
> +++ /dev/null
> @@ -1 +0,0 @@
> -int main(void) {}
> diff --git a/qga/meson.build b/qga/meson.build
> index d3291b4376..dd18092f56 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -9,7 +9,7 @@ endif
>  have_qga_vss =3D get_option('qga_vss') \
>    .require(targetos =3D=3D 'windows',
>             error_message: 'VSS support requires Windows') \
> -  .require(link_language =3D=3D 'cpp',
> +  .require('cpp' in all_languages,
>             error_message: 'VSS support requires a C++ compiler') \
>    .require(have_vss, error_message: '''VSS support requires VSS headers.
>      If your Visual Studio installation doesn't have the VSS headers,
> --
> 2.39.3
>
>

--0000000000001cd1e105ffcdcc32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 6=
, 2023 at 9:47=E2=80=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.co=
m">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">We are not mixing C++ with C code anymore, the only rema=
ining<br>
C++ code in qga/vss-win32/ is used for a plain C++ executable.<br>
Thus we can remove the hacks for linking C code with the C++ linker<br>
now to simplify meson.build a little bit, and also to avoid that<br>
some C++ code sneaks in by accident again.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0| 24 ++++++------------------<br>
=C2=A0scripts/main.c=C2=A0 |=C2=A0 1 -<br>
=C2=A0qga/meson.build |=C2=A0 2 +-<br>
=C2=A03 files changed, 7 insertions(+), 20 deletions(-)<br>
=C2=A0delete mode 100644 scripts/main.c<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 5559b36859..620457bb95 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -473,19 +473,10 @@ if targetos !=3D &#39;darwin&#39;<br>
=C2=A0 =C2=A0warn_flags +=3D [&#39;-Wthread-safety&#39;]<br>
=C2=A0endif<br>
<br>
-# Check that the C++ compiler exists and works with the C compiler.<br>
-link_language =3D &#39;c&#39;<br>
-linker =3D cc<br>
+# Set up C++ compiler flags<br>
=C2=A0qemu_cxxflags =3D []<br>
=C2=A0if &#39;cpp&#39; in all_languages<br>
=C2=A0 =C2=A0qemu_cxxflags =3D [&#39;-D__STDC_LIMIT_MACROS&#39;, &#39;-D__S=
TDC_CONSTANT_MACROS&#39;, &#39;-D__STDC_FORMAT_MACROS&#39;] + qemu_cflags<b=
r>
-=C2=A0 if cxx.links(files(&#39;scripts/main.c&#39;), args: qemu_cflags)<br=
>
-=C2=A0 =C2=A0 link_language =3D &#39;cpp&#39;<br>
-=C2=A0 =C2=A0 linker =3D cxx<br>
-=C2=A0 else<br>
-=C2=A0 =C2=A0 message(&#39;C++ compiler does not work with C compiler&#39;=
)<br>
-=C2=A0 =C2=A0 message(&#39;Disabling C++-specific optional code&#39;)<br>
-=C2=A0 endif<br>
=C2=A0endif<br>
<br>
=C2=A0# clang does not support glibc + FORTIFY_SOURCE (is it still true?)<b=
r>
@@ -1600,7 +1591,7 @@ if not get_option(&#39;snappy&#39;).auto() or have_sy=
stem<br>
=C2=A0 =C2=A0snappy =3D cc.find_library(&#39;snappy&#39;, has_headers: [&#3=
9;snappy-c.h&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 required: get_option(&#39;snappy&#39;))<br>
=C2=A0endif<br>
-if snappy.found() and not linker.links(&#39;&#39;&#39;<br>
+if snappy.found() and not cc.links(&#39;&#39;&#39;<br>
=C2=A0 =C2=A0 #include &lt;snappy-c.h&gt;<br>
=C2=A0 =C2=A0 int main(void) { snappy_max_compressed_length(4096); return 0=
; }&#39;&#39;&#39;, dependencies: snappy)<br>
=C2=A0 =C2=A0snappy =3D not_found<br>
@@ -2746,7 +2737,7 @@ config_host_data.set(&#39;CONFIG_AF_VSOCK&#39;, cc.ha=
s_header_symbol(<br>
<br>
=C2=A0have_vss =3D false<br>
=C2=A0have_vss_sdk =3D false # old xp/2003 SDK<br>
-if targetos =3D=3D &#39;windows&#39; and link_language =3D=3D &#39;cpp&#39=
;<br>
+if targetos =3D=3D &#39;windows&#39; and &#39;cpp&#39; in all_languages<br=
>
=C2=A0 =C2=A0have_vss =3D cxx.compiles(&#39;&#39;&#39;<br>
=C2=A0 =C2=A0 =C2=A0#define __MIDL_user_allocate_free_DEFINED__<br>
=C2=A0 =C2=A0 =C2=A0#include &lt;vss.h&gt;<br>
@@ -3827,7 +3818,6 @@ foreach target : target_dirs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c_args: c_args,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dependencies: arch_=
deps + deps + exe[&#39;dependencies&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 objects: lib.extrac=
t_all_objects(recursive: true),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_language: link=
_language,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link_depends: [bloc=
k_syms, qemu_syms] + exe.get(&#39;link_depends&#39;, []),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link_args: link_arg=
s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 win_subsystem: exe[=
&#39;win_subsystem&#39;])<br>
@@ -4061,10 +4051,8 @@ summary_info +=3D {&#39;host CPU&#39;:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 cpu}<br>
=C2=A0summary_info +=3D {&#39;host endianness&#39;:=C2=A0 =C2=A0build_machi=
ne.endian()}<br>
=C2=A0summary_info +=3D {&#39;C compiler&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
#39; &#39;.join(meson.get_compiler(&#39;c&#39;).cmd_array())}<br>
=C2=A0summary_info +=3D {&#39;Host C compiler&#39;:=C2=A0 =C2=A0&#39; &#39;=
.join(meson.get_compiler(&#39;c&#39;, native: true).cmd_array())}<br>
-if link_language =3D=3D &#39;cpp&#39;<br>
+if &#39;cpp&#39; in all_languages<br>
=C2=A0 =C2=A0summary_info +=3D {&#39;C++ compiler&#39;:=C2=A0 =C2=A0 &#39; =
&#39;.join(meson.get_compiler(&#39;cpp&#39;).cmd_array())}<br>
-else<br>
-=C2=A0 summary_info +=3D {&#39;C++ compiler&#39;:=C2=A0 =C2=A0 =C2=A0 fals=
e}<br>
=C2=A0endif<br>
=C2=A0if targetos =3D=3D &#39;darwin&#39;<br>
=C2=A0 =C2=A0summary_info +=3D {&#39;Objective-C compiler&#39;: &#39; &#39;=
.join(meson.get_compiler(&#39;objc&#39;).cmd_array())}<br>
@@ -4074,13 +4062,13 @@ if get_option(&#39;optimization&#39;) !=3D &#39;pla=
in&#39;<br>
=C2=A0 =C2=A0option_cflags +=3D [&#39;-O&#39; + get_option(&#39;optimizatio=
n&#39;)]<br>
=C2=A0endif<br>
=C2=A0summary_info +=3D {&#39;CFLAGS&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39; &#39;.join(get_option(&#39;c_args&#39;) + option_cflags)}<=
br>
-if link_language =3D=3D &#39;cpp&#39;<br>
+if &#39;cpp&#39; in all_languages<br>
=C2=A0 =C2=A0summary_info +=3D {&#39;CXXFLAGS&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39; &#39;.join(get_option(&#39;cpp_args&#39;) + option_cflags)}<br>
=C2=A0endif<br>
=C2=A0if targetos =3D=3D &#39;darwin&#39;<br>
=C2=A0 =C2=A0summary_info +=3D {&#39;OBJCFLAGS&#39;:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0&#39; &#39;.join(get_option(&#39;objc_args&#39;) + option_cflags)}<br=
>
=C2=A0endif<br>
-link_args =3D get_option(link_language + &#39;_link_args&#39;)<br>
+link_args =3D get_option(&#39;c_link_args&#39;)<br>
=C2=A0if link_args.length() &gt; 0<br>
=C2=A0 =C2=A0summary_info +=3D {&#39;LDFLAGS&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&#39; &#39;.join(link_args)}<br>
=C2=A0endif<br>
diff --git a/scripts/main.c b/scripts/main.c<br>
deleted file mode 100644<br>
index b552c8e4ed..0000000000<br>
--- a/scripts/main.c<br>
+++ /dev/null<br>
@@ -1 +0,0 @@<br>
-int main(void) {}<br>
diff --git a/qga/meson.build b/qga/meson.build<br>
index d3291b4376..dd18092f56 100644<br>
--- a/qga/meson.build<br>
+++ b/qga/meson.build<br>
@@ -9,7 +9,7 @@ endif<br>
=C2=A0have_qga_vss =3D get_option(&#39;qga_vss&#39;) \<br>
=C2=A0 =C2=A0.require(targetos =3D=3D &#39;windows&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_message: &#39;VSS support r=
equires Windows&#39;) \<br>
-=C2=A0 .require(link_language =3D=3D &#39;cpp&#39;,<br>
+=C2=A0 .require(&#39;cpp&#39; in all_languages,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_message: &#39;VSS support r=
equires a C++ compiler&#39;) \<br>
=C2=A0 =C2=A0.require(have_vss, error_message: &#39;&#39;&#39;VSS support r=
equires VSS headers.<br>
=C2=A0 =C2=A0 =C2=A0If your Visual Studio installation doesn&#39;t have the=
 VSS headers,<br>
-- <br>
2.39.3<br>
<br>
</blockquote></div>

--0000000000001cd1e105ffcdcc32--


