Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD94E7E6115
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 00:38:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0s79-00060Z-V5; Wed, 08 Nov 2023 18:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r0s77-0005ng-EZ
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 18:37:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r0s6s-00029I-5I
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 18:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699486640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NTid6SXbBreQgkWHXMzcvO/GT017hkg++wKMuzLo/NM=;
 b=IkbKkyqow8Ix6xksLXBw+2M37VXDliRDybtdJAUxntyhujU3f5vkyequCNPcZypHUR2Fkk
 fFN7tO9aKPTO1anjO6qpM9KmlT3pdKNbrZWDstmaYeWh6mC/RMJhbKdD+5msF7zAIA6f7K
 2vATNpMGMdefE80V7S44ZKMh1gxsocM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-A6okuw21NECfT0icvECPpg-1; Wed, 08 Nov 2023 18:37:16 -0500
X-MC-Unique: A6okuw21NECfT0icvECPpg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9c797b497e8so19381666b.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 15:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699486635; x=1700091435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NTid6SXbBreQgkWHXMzcvO/GT017hkg++wKMuzLo/NM=;
 b=bDYjee2RtFrfb8m1MjT1XdqxKNBIcFW45jF/VHwVJvLe8y+wlNYFUPDBz4Kzv4LzAp
 9FBKXLrUSVbfCsxeXoj4Gklxz5RmNMi1UdARmXEus1cxGYb2uz2MfvuhJpyl2V79sfQ7
 S6J4Odf3yObhyYSn6Ngi8vNC1dLK2ZBuhREv/2a7fTzkFhg/jNfr0raP1NIqfj7YzuZb
 7b8I/eoEbMgm/L/y8JBWHxmHkw0yR+VYDE1LxNMRA3s4M5DYRsAI7oENSBgKxK7VuYaQ
 9jVh84AVMXqD0thfG1qKNRAasui96AqjX3/rX2yVAtpPIs5GpaJ0kG8ynb2SBhKxo1jb
 qCWg==
X-Gm-Message-State: AOJu0Yw3IhVXICjAT9p2DcDRnc5ow9AzajjD/FPPPLNA3yM0i3lhdXFF
 b1jTcDS5amTbCE4lQJCMs+ss0AkcUXOstEAgSEZY8V+EV5MDCW2La7YA3nRR0T2KHnufEL72IiY
 VvOhM7hSYYc/uWXAlAhBezXI606cXkSg=
X-Received: by 2002:a17:907:7f06:b0:9be:7de2:927f with SMTP id
 qf6-20020a1709077f0600b009be7de2927fmr2796339ejc.66.1699486635536; 
 Wed, 08 Nov 2023 15:37:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj5eA3sn0cea9+2iDaWwKpjVOWF4Bb9RHjIOEAr995nG0jNskRf9pfx5bxe+FVJ2VckspBF8rz9A1BFEvQqmg=
X-Received: by 2002:a17:907:7f06:b0:9be:7de2:927f with SMTP id
 qf6-20020a1709077f0600b009be7de2927fmr2796323ejc.66.1699486635201; Wed, 08
 Nov 2023 15:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20231108183251.80572-1-philmd@linaro.org>
 <20231108183251.80572-3-philmd@linaro.org>
In-Reply-To: <20231108183251.80572-3-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 9 Nov 2023 00:37:04 +0100
Message-ID: <CABgObfZXaAT2CsN2LAZZ_8sszq+t+GvL-EH5mdxEFeSo5_GijQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] .gitlab-ci.d/cirrus: Add manual testing of macOS 14
 (Sonoma)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Rene Engel <ReneEngel80@emailn.de>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Howard Spoelstra <hsp.cat7@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000312a4a0609ac9180"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000312a4a0609ac9180
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 8 nov 2023, 19:33 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> Upgrade libvirt-ci so it covers macOS 14. Add a manual entry
> (QEMU_JOB_OPTIONAL: 1) to test on Sonoma release. Refresh the
> lci-tool generated files.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Docs are disabled due to:
>
>   Collecting sphinx
>     Downloading sphinx-7.2.6-py3-none-any.whl.metadata (5.9 kB)
>   Collecting sphinx-rtd-theme
>     Downloading sphinx_rtd_theme-1.3.0-py2.py3-none-any.whl.metadata (4.5
> kB)
>

Same issue: the pip that is installing sphinx is unrelated to the Python
that is used to compile QEMU. Use /opt/homebrew/bin/pip3 instead.

Paolo

  ...
>   Installing collected packages ...
>   ...
>   python determined to be '/opt/homebrew/bin/python3'
>   python version: Python 3.11.6
>   mkvenv: Creating non-isolated virtual environment at 'pyvenv'
>   mkvenv: checking for sphinx>=3D1.6
>   mkvenv: checking for sphinx_rtd_theme>=3D0.5
>   ...
>   Program /opt/homebrew/opt/python@3.12/bin/sphinx-build found: NO
>   ../docs/meson.build:1:15: ERROR: Program '/opt/homebrew/opt/python@3.12=
/bin/sphinx-build'
> not found or not executable
>
> =C2=AF\_(=E3=83=84)_/=C2=AF
> ---
>  .gitlab-ci.d/cirrus.yml           | 17 +++++++++++++++++
>  .gitlab-ci.d/cirrus/macos-14.vars | 16 ++++++++++++++++
>  tests/lcitool/libvirt-ci          |  2 +-
>  tests/lcitool/refresh             |  1 +
>  4 files changed, 35 insertions(+), 1 deletion(-)
>  create mode 100644 .gitlab-ci.d/cirrus/macos-14.vars
>
> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> index 07dc6edae1..84ce143509 100644
> --- a/.gitlab-ci.d/cirrus.yml
> +++ b/.gitlab-ci.d/cirrus.yml
> @@ -74,6 +74,23 @@ aarch64-macos-13-base-build:
>      PKG_CONFIG_PATH:
> /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt=
/homebrew/readline/lib/pkgconfig
>      TEST_TARGETS: check-unit check-block check-qapi-schema
> check-softfloat check-qtest-x86_64
>
> +aarch64-macos-14-base-build:
> +  extends: .cirrus_build_job
> +  variables:
> +    NAME: macos-14
> +    CIRRUS_VM_INSTANCE_TYPE: macos_instance
> +    CIRRUS_VM_IMAGE_SELECTOR: image
> +    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
> +    CIRRUS_VM_CPUS: 12
> +    CIRRUS_VM_RAM: 24G
> +    UPDATE_COMMAND: brew update
> +    INSTALL_COMMAND: brew install
> +    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
> +    PKG_CONFIG_PATH:
> /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt=
/homebrew/readline/lib/pkgconfig
> +    TEST_TARGETS: check-unit check-block check-qapi-schema
> check-softfloat check-qtest-x86_64
> +    QEMU_JOB_OPTIONAL: 1
> +    CONFIGURE_ARGS: --disable-docs
> +
>
>  # The following jobs run VM-based tests via KVM on a Linux-based
> Cirrus-CI job
>  .cirrus_kvm_job:
> diff --git a/.gitlab-ci.d/cirrus/macos-14.vars
> b/.gitlab-ci.d/cirrus/macos-14.vars
> new file mode 100644
> index 0000000000..43070f4a26
> --- /dev/null
> +++ b/.gitlab-ci.d/cirrus/macos-14.vars
> @@ -0,0 +1,16 @@
> +# THIS FILE WAS AUTO-GENERATED
> +#
> +#  $ lcitool variables macos-14 qemu
> +#
> +# https://gitlab.com/libvirt/libvirt-ci
> +
> +CCACHE=3D'/opt/homebrew/bin/ccache'
> +CPAN_PKGS=3D''
> +CROSS_PKGS=3D''
> +MAKE=3D'/opt/homebrew/bin/gmake'
> +NINJA=3D'/opt/homebrew/bin/ninja'
> +PACKAGING_COMMAND=3D'brew'
> +PIP3=3D'/opt/homebrew/bin/pip3'
> +PKGS=3D'bash bc bison bzip2 capstone ccache cmocka ctags curl dbus
> diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc
> jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libsli=
rp
> libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja
> pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse
> spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
> +PYPI_PKGS=3D'PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
> +PYTHON=3D'/opt/homebrew/bin/python3'
> diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> index 36bc517161..77c800186f 160000
> --- a/tests/lcitool/libvirt-ci
> +++ b/tests/lcitool/libvirt-ci
> @@ -1 +1 @@
> -Subproject commit 36bc517161c45ead20224d47f2dc4fa428af6724
> +Subproject commit 77c800186f34b21be7660750577cc5582a914deb
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 2259f131b4..e11d0ba381 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -197,6 +197,7 @@ try:
>      #
>      generate_cirrus("freebsd-13")
>      generate_cirrus("macos-13")
> +    generate_cirrus("macos-14")
>
>      #
>      # VM packages lists
> --
> 2.41.0
>
>

--000000000000312a4a0609ac9180
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 8 nov 2023, 19:33 Philippe Mathieu-Daud=C3=A9 &=
lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Upgrade libvirt-ci so it covers =
macOS 14. Add a manual entry<br>
(QEMU_JOB_OPTIONAL: 1) to test on Sonoma release. Refresh the<br>
lci-tool generated files.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
---<br>
Docs are disabled due to:<br>
<br>
=C2=A0 Collecting sphinx<br>
=C2=A0 =C2=A0 Downloading sphinx-7.2.6-py3-none-any.whl.metadata (5.9 kB)<b=
r>
=C2=A0 Collecting sphinx-rtd-theme<br>
=C2=A0 =C2=A0 Downloading sphinx_rtd_theme-1.3.0-py2.py3-none-any.whl.metad=
ata (4.5 kB)<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Same issue: the pip that is installing sphinx is unrelated to t=
he Python that is used to compile QEMU. Use /opt/homebrew/bin/pip3 instead.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
=C2=A0 ...<br>
=C2=A0 Installing collected packages ...<br>
=C2=A0 ...<br>
=C2=A0 python determined to be &#39;/opt/homebrew/bin/python3&#39;<br>
=C2=A0 python version: Python 3.11.6<br>
=C2=A0 mkvenv: Creating non-isolated virtual environment at &#39;pyvenv&#39=
;<br>
=C2=A0 mkvenv: checking for sphinx&gt;=3D1.6<br>
=C2=A0 mkvenv: checking for sphinx_rtd_theme&gt;=3D0.5<br>
=C2=A0 ...<br>
=C2=A0 Program /opt/homebrew/opt/python@3.12/bin/sphinx-build found: NO<br>
=C2=A0 ../docs/meson.build:1:15: ERROR: Program &#39;/opt/homebrew/opt/pyth=
on@3.12/bin/sphinx-build&#39; not found or not executable<br>
<br>
=C2=AF\_(=E3=83=84)_/=C2=AF<br>
---<br>
=C2=A0.gitlab-ci.d/cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 17 =
+++++++++++++++++<br>
=C2=A0.gitlab-ci.d/cirrus/macos-14.vars | 16 ++++++++++++++++<br>
=C2=A0tests/lcitool/libvirt-ci=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 =
+-<br>
=C2=A0tests/lcitool/refresh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 1 +<br>
=C2=A04 files changed, 35 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 .gitlab-ci.d/cirrus/macos-14.vars<br>
<br>
diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml<br>
index 07dc6edae1..84ce143509 100644<br>
--- a/.gitlab-ci.d/cirrus.yml<br>
+++ b/.gitlab-ci.d/cirrus.yml<br>
@@ -74,6 +74,23 @@ aarch64-macos-13-base-build:<br>
=C2=A0 =C2=A0 =C2=A0PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/=
homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig<br>
=C2=A0 =C2=A0 =C2=A0TEST_TARGETS: check-unit check-block check-qapi-schema =
check-softfloat check-qtest-x86_64<br>
<br>
+aarch64-macos-14-base-build:<br>
+=C2=A0 extends: .cirrus_build_job<br>
+=C2=A0 variables:<br>
+=C2=A0 =C2=A0 NAME: macos-14<br>
+=C2=A0 =C2=A0 CIRRUS_VM_INSTANCE_TYPE: macos_instance<br>
+=C2=A0 =C2=A0 CIRRUS_VM_IMAGE_SELECTOR: image<br>
+=C2=A0 =C2=A0 CIRRUS_VM_IMAGE_NAME: <a href=3D"http://ghcr.io/cirruslabs/m=
acos-sonoma-base:latest" rel=3D"noreferrer noreferrer" target=3D"_blank">gh=
cr.io/cirruslabs/macos-sonoma-base:latest</a><br>
+=C2=A0 =C2=A0 CIRRUS_VM_CPUS: 12<br>
+=C2=A0 =C2=A0 CIRRUS_VM_RAM: 24G<br>
+=C2=A0 =C2=A0 UPDATE_COMMAND: brew update<br>
+=C2=A0 =C2=A0 INSTALL_COMMAND: brew install<br>
+=C2=A0 =C2=A0 PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gette=
xt/bin<br>
+=C2=A0 =C2=A0 PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homeb=
rew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig<br>
+=C2=A0 =C2=A0 TEST_TARGETS: check-unit check-block check-qapi-schema check=
-softfloat check-qtest-x86_64<br>
+=C2=A0 =C2=A0 QEMU_JOB_OPTIONAL: 1<br>
+=C2=A0 =C2=A0 CONFIGURE_ARGS: --disable-docs<br>
+<br>
<br>
=C2=A0# The following jobs run VM-based tests via KVM on a Linux-based Cirr=
us-CI job<br>
=C2=A0.cirrus_kvm_job:<br>
diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-=
14.vars<br>
new file mode 100644<br>
index 0000000000..43070f4a26<br>
--- /dev/null<br>
+++ b/.gitlab-ci.d/cirrus/macos-14.vars<br>
@@ -0,0 +1,16 @@<br>
+# THIS FILE WAS AUTO-GENERATED<br>
+#<br>
+#=C2=A0 $ lcitool variables macos-14 qemu<br>
+#<br>
+# <a href=3D"https://gitlab.com/libvirt/libvirt-ci" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">https://gitlab.com/libvirt/libvirt-ci</a><br>
+<br>
+CCACHE=3D&#39;/opt/homebrew/bin/ccache&#39;<br>
+CPAN_PKGS=3D&#39;&#39;<br>
+CROSS_PKGS=3D&#39;&#39;<br>
+MAKE=3D&#39;/opt/homebrew/bin/gmake&#39;<br>
+NINJA=3D&#39;/opt/homebrew/bin/ninja&#39;<br>
+PACKAGING_COMMAND=3D&#39;brew&#39;<br>
+PIP3=3D&#39;/opt/homebrew/bin/pip3&#39;<br>
+PKGS=3D&#39;bash bc bison bzip2 capstone ccache cmocka ctags curl dbus dif=
futils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-t=
urbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libss=
h libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pk=
g-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protoco=
l swtpm tesseract usbredir vde vte3 xorriso zlib zstd&#39;<br>
+PYPI_PKGS=3D&#39;PyYAML numpy pillow sphinx sphinx-rtd-theme tomli&#39;<br=
>
+PYTHON=3D&#39;/opt/homebrew/bin/python3&#39;<br>
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci<br>
index 36bc517161..77c800186f 160000<br>
--- a/tests/lcitool/libvirt-ci<br>
+++ b/tests/lcitool/libvirt-ci<br>
@@ -1 +1 @@<br>
-Subproject commit 36bc517161c45ead20224d47f2dc4fa428af6724<br>
+Subproject commit 77c800186f34b21be7660750577cc5582a914deb<br>
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh<br>
index 2259f131b4..e11d0ba381 100755<br>
--- a/tests/lcitool/refresh<br>
+++ b/tests/lcitool/refresh<br>
@@ -197,6 +197,7 @@ try:<br>
=C2=A0 =C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0 =C2=A0generate_cirrus(&quot;freebsd-13&quot;)<br>
=C2=A0 =C2=A0 =C2=A0generate_cirrus(&quot;macos-13&quot;)<br>
+=C2=A0 =C2=A0 generate_cirrus(&quot;macos-14&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0 =C2=A0# VM packages lists<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div></div>

--000000000000312a4a0609ac9180--


