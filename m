Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F347E5F87
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 21:57:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0pbr-0006Z6-9f; Wed, 08 Nov 2023 15:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anders.roxell@linaro.org>)
 id 1r0pbm-0006YK-N9
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:57:07 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anders.roxell@linaro.org>)
 id 1r0pbk-00060y-Gd
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:57:06 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-66d09b6d007so1101136d6.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 12:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699477023; x=1700081823; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ji4njZ+4q88MA37ALRixXONbwnIbm1jpxzZxEzk39Yo=;
 b=DfInwT8PU1jVHmdSdvMNwvOPbPZo0ba2ZOzEQiYQlsZr0izhONMxmH2gVPa85VE0We
 n+FkunrkNLP6MJoP9sTmKeyQmBB3029JxZuXhyiW8/eO5j5Z7FFxaS6iauRe9Nb1c3dk
 krTTINj/xYZKtNmLa81BmrGQRlPhVVU9c2pDQSQQIL2YZH+vQNJXuflcDn8KuvkSwHk4
 wD0bcG7tQszKHbvvgVdD1CwNhs+mxMGACK7sudZN9u4lVM/AuxEMNdpoRm7Py/Cu2r/5
 tilqj/FVSTE3IrFH17InTDApU8R27rj5lhMq+wf0Fd1eVa8FukfuXePjs7tLBUtHknXF
 poHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699477023; x=1700081823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ji4njZ+4q88MA37ALRixXONbwnIbm1jpxzZxEzk39Yo=;
 b=Yht7j+p/J0irfQ0v2op5i3vOu1EkfdXygJB6cmBD2MiuRYRpa1optVoNLDWXHwGjpM
 bg38XokuDILF4G0MUzEoSiFsDxko2BZ486rAKKejng1tw7poHiCXKz6xrldAmtmFNDAU
 3h8q4kI5mhSmAGQPBcGPTziOUub1SbxNPZCdvOi80z8dPbqJwybIe0W1nl3CG32E1o4X
 Ct2OeiRmS5tQsRU0k4TQd49lDyBJjOceFhIMSZPiTEyFHgks9nv7FSxumf4GzNVXps9V
 KWpb/jqwkvAy9M0+xo7uMLeXe3Sfzmra+wd+TqV4MDHWwFlV/2bsLqJsJ9JCaijtAY8w
 InpA==
X-Gm-Message-State: AOJu0Yy3EFsVCDP4/zy7I1eHTIvEVAVT34H4bgHMDByj8SXFRhxO/GfO
 CsEcxX6yFQk5bocVTpM+bjHhcaCGEhLzUoE6XqKV6g==
X-Google-Smtp-Source: AGHT+IEP8i8YyC5moWI21I4W/HZqm6PESKPPEBKSlrClGZuFu8nox5xYzVVLwsevx+ikFJ2p7TbUG/tYmabHRZ2Uvyw=
X-Received: by 2002:ad4:5f4e:0:b0:671:8630:f590 with SMTP id
 p14-20020ad45f4e000000b006718630f590mr3242847qvg.18.1699477023267; Wed, 08
 Nov 2023 12:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20231108165602.3865524-1-alex.bennee@linaro.org>
In-Reply-To: <20231108165602.3865524-1-alex.bennee@linaro.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 8 Nov 2023 21:56:52 +0100
Message-ID: <CADYN=9LQqymjkg+eh8vLETfVa_P=wL6Vbg-D+Q7oFqxJ8La0ag@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/docker: merge debian-native with debian-amd64
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=anders.roxell@linaro.org; helo=mail-qv1-xf31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 8 Nov 2023 at 17:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> debian-native isn't really needed and suffers from the problem of
> tracking a distros dependencies rather than the projects. With a
> little surgery we can make the debian-amd64 container architecture
> neutral and allow people to use it to build a native QEMU.
>
> Rename it so it follows the same non-arch pattern of the other distro
> containers.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Anders Roxell <anders.roxell@linaro.org>

I tried it on my arm machine and it worked as expected.
And this should work for me

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

> ---
>  .gitlab-ci.d/buildtest.yml                    | 12 ++---
>  .gitlab-ci.d/containers.yml                   |  2 +-
>  tests/docker/Makefile.include                 |  3 --
>  tests/docker/dockerfiles/debian-native.docker | 54 -------------------
>  .../{debian-amd64.docker =3D> debian.docker}    |  7 ++-
>  tests/lcitool/refresh                         |  9 ++--
>  6 files changed, 18 insertions(+), 69 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-native.docker
>  rename tests/docker/dockerfiles/{debian-amd64.docker =3D> debian.docker}=
 (96%)
>
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index da72f7c690..7f9af83b10 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -70,7 +70,7 @@ build-system-debian:
>    needs:
>      job: amd64-debian-container
>    variables:
> -    IMAGE: debian-amd64
> +    IMAGE: debian
>      CONFIGURE_ARGS: --with-coroutine=3Dsigaltstack
>      TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4eb-softmmu
>        sparc-softmmu xtensa-softmmu
> @@ -82,7 +82,7 @@ check-system-debian:
>      - job: build-system-debian
>        artifacts: true
>    variables:
> -    IMAGE: debian-amd64
> +    IMAGE: debian
>      MAKE_CHECK_ARGS: check
>
>  avocado-system-debian:
> @@ -91,7 +91,7 @@ avocado-system-debian:
>      - job: build-system-debian
>        artifacts: true
>    variables:
> -    IMAGE: debian-amd64
> +    IMAGE: debian
>      MAKE_CHECK_ARGS: check-avocado
>      AVOCADO_TAGS: arch:arm arch:i386 arch:riscv64 arch:sh4 arch:sparc ar=
ch:xtensa
>
> @@ -101,7 +101,7 @@ crash-test-debian:
>      - job: build-system-debian
>        artifacts: true
>    variables:
> -    IMAGE: debian-amd64
> +    IMAGE: debian
>    script:
>      - cd build
>      - make NINJA=3D":" check-venv
> @@ -589,7 +589,7 @@ build-tools-and-docs-debian:
>      # when running on 'master' we use pre-existing container
>      optional: true
>    variables:
> -    IMAGE: debian-amd64
> +    IMAGE: debian
>      MAKE_CHECK_ARGS: check-unit ctags TAGS cscope
>      CONFIGURE_ARGS: --disable-system --disable-user --enable-docs --enab=
le-tools
>      QEMU_JOB_PUBLISH: 1
> @@ -609,7 +609,7 @@ build-tools-and-docs-debian:
>  # of what topic branch they're currently using
>  pages:
>    extends: .base_job_template
> -  image: $CI_REGISTRY_IMAGE/qemu/debian-amd64:$QEMU_CI_CONTAINER_TAG
> +  image: $CI_REGISTRY_IMAGE/qemu/debian:$QEMU_CI_CONTAINER_TAG
>    stage: test
>    needs:
>      - job: build-tools-and-docs-debian
> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> index 8637a13d86..ae79d4c58b 100644
> --- a/.gitlab-ci.d/containers.yml
> +++ b/.gitlab-ci.d/containers.yml
> @@ -11,7 +11,7 @@ amd64-debian-container:
>    extends: .container_job_template
>    stage: containers
>    variables:
> -    NAME: debian-amd64
> +    NAME: debian
>
>  amd64-ubuntu2204-container:
>    extends: .container_job_template
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
> index cd4688bf07..5ba5b50ab9 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -88,9 +88,6 @@ DOCKER_PARTIAL_IMAGES +=3D debian-s390x-cross
>  DOCKER_PARTIAL_IMAGES +=3D fedora
>  endif
>
> -# The native build should never use the registry
> -docker-image-debian-native: DOCKER_REGISTRY=3D
> -
>  # alpine has no adduser
>  docker-image-alpine: NOUSER=3D1
>
> diff --git a/tests/docker/dockerfiles/debian-native.docker b/tests/docker=
/dockerfiles/debian-native.docker
> deleted file mode 100644
> index abac7d7cd7..0000000000
> --- a/tests/docker/dockerfiles/debian-native.docker
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -#
> -# Docker Debian Native
> -#
> -# This is intended to build QEMU on native host systems. Debian is
> -# chosen due to the broadest range on supported host systems for QEMU.
> -#
> -# This docker target is based on the docker.io Debian Bullseye base
> -# image rather than QEMU's base because we would otherwise confuse the
> -# build grabbing stuff from the registry built for other
> -# architectures.
> -#
> -FROM docker.io/library/debian:bullseye-slim
> -MAINTAINER Alex Benn=C3=A9e <alex.bennee@linaro.org>
> -
> -# Duplicate deb line as deb-src
> -RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sou=
rces.list
> -
> -# Install common build utilities
> -RUN apt update && \
> -    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata
> -
> -RUN apt update && \
> -    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt build-dep -yy --arch-only qemu
> -
> -RUN apt update && \
> -    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt install -y --no-install-recommends \
> -        cscope \
> -        genisoimage \
> -        exuberant-ctags \
> -        global \
> -        libbz2-dev \
> -        liblzo2-dev \
> -        libgcrypt20-dev \
> -        libfdt-dev \
> -        librdmacm-dev \
> -        libsasl2-dev \
> -        libsnappy-dev \
> -        libvte-dev \
> -        netcat-openbsd \
> -        ninja-build \
> -        openssh-client \
> -        python3-numpy \
> -        python3-opencv \
> -        python3-venv
> -
> -ENV QEMU_CONFIGURE_OPTS $QEMU_CONFIGURE_OPTS
> -ENV DEF_TARGET_LIST "none"
> -# As a final step configure the user (if env is defined)
> -ARG USER
> -ARG UID
> -RUN if [ "${USER}" ]; then \
> -  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/=
dockerfiles/debian.docker
> similarity index 96%
> rename from tests/docker/dockerfiles/debian-amd64.docker
> rename to tests/docker/dockerfiles/debian.docker
> index 9b50fb2f63..b5e642d5b6 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian.docker
> @@ -155,10 +155,13 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>    apt install -y --no-install-recommends \
>    cscope\
>    global\
> -  linux-headers-amd64
> +  linux-headers-generic
>  RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
>  RUN cd /usr/src/netmap && git checkout v11.3
> -RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --ker=
nel-dir=3D$(ls -d /usr/src/linux-headers-*-amd64) && make install
> +RUN cd /usr/src/netmap/LINUX && \
> +  ./configure --no-drivers --no-apps \
> +  --kernel-dir=3D$(ls -d /usr/src/linux-headers-*-$(dpkg --print-archite=
cture)) \
> +  && make install
>  ENV QEMU_CONFIGURE_OPTS --enable-netmap
>  # As a final step configure the user (if env is defined)
>  ARG USER
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 10c54a377c..13250f40c4 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -99,10 +99,13 @@ debian12_extras =3D [
>      "  apt install -y --no-install-recommends \\\n",
>      "  cscope\\\n",
>      "  global\\\n",
> -    "  linux-headers-amd64\n",
> +    "  linux-headers-generic\n",
>      "RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/net=
map\n",
>      "RUN cd /usr/src/netmap && git checkout v11.3\n",
> -    "RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps =
--kernel-dir=3D$(ls -d /usr/src/linux-headers-*-amd64) && make install\n",
> +    "RUN cd /usr/src/netmap/LINUX && \\\n",
> +    "  ./configure --no-drivers --no-apps \\\n",
> +    "  --kernel-dir=3D$(ls -d /usr/src/linux-headers-*-$(dpkg --print-ar=
chitecture)) \\\n",
> +    "  && make install\n",
>      "ENV QEMU_CONFIGURE_OPTS --enable-netmap\n"
>  ]
>
> @@ -123,7 +126,7 @@ try:
>      #
>      generate_dockerfile("alpine", "alpine-318")
>      generate_dockerfile("centos8", "centos-stream-8")
> -    generate_dockerfile("debian-amd64", "debian-12",
> +    generate_dockerfile("debian", "debian-12",
>                          trailer=3D"".join(debian12_extras))
>      generate_dockerfile("fedora", "fedora-38")
>      generate_dockerfile("opensuse-leap", "opensuse-leap-15")
> --
> 2.39.2
>

