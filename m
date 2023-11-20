Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEF87F16EE
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:13:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55th-0006Nd-6u; Mon, 20 Nov 2023 10:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tQ-0005rz-Uq
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:59 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tB-0001Cf-A7
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:51 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c6b30aca06so55029131fa.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492918; x=1701097718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCRqk6YT3bsj71ZXwzX8pG0SOXxV0ZtG0Z5l0HsDHlo=;
 b=F6b+lNVN5EY7oRWbCZlg0ds00XuFgj0g0YvZQjRD34hfjRJHKAIYvgOHbSy+ennXqM
 afnIizMnUH1i+kh0UU0mlS6nPbNwgymqsEJY6Pt/dVdK+KouG5BFb0AbndqdkvfDFioX
 17XQYx1MeTOIt0QlV0+TMYpu/i4DoB28I+OTJQUx/1T25Zwus4kLYdwkM9FjTW16zky1
 3/jNBmO2B1YJ+UfmINSGbCmTZLj4GrEar3r7oxfMpMEmVI0tQ0+X25R6TEySblPikFC7
 gWQVcGYNStQCjg5pwsQ67tiU0SnHeQ2eBNhmTHGtz+TYPvzNLmpJmqP8EneWyugqQkmb
 P0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492918; x=1701097718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NCRqk6YT3bsj71ZXwzX8pG0SOXxV0ZtG0Z5l0HsDHlo=;
 b=MLQmQuUnAm1bfhSfe4Y+gVs4KKhYld0mZbkYrCusxXsBKkOpj55tPCXQMtPfsilkRe
 sI7ZddlESxt5pYoqU7Kgith5GD2A+2Ar7x2NB40wmyb9zG33gtFWla0tMZOUlhLKe1Xp
 11/ptyoWjmf62bPXEBHptMXk7jSAg/2fNWdyRxKhNb1qUmwquAw5mrSPrpURwQ8SsTYe
 UFHo9uTP6NEkWvNB7g9NoAd0lUrY3d3bFCL8nXm/1wSSPcFd7FHjAlKt2RH15BgBnpv8
 4bD+Mx1Dg+1qIeahRbqlxTg/djQG+bcbNYn0L9yOCUl0FCdIRhd60tm2Ps5Kxvk2KhK5
 E88g==
X-Gm-Message-State: AOJu0YwjCo4NWCvNjBl7HEn/TXAzfNZtSftVV1u3uOJzzcKOojaWnXvr
 0K1/96/SyHbhpXsxC632ndnYtg==
X-Google-Smtp-Source: AGHT+IFFTFT2xVXHJjqWvOWRwCM6+7ymXoqgGD9Tp5MS/WTaMGY68gI4TXwyKt+7dAQb9KsG80Mhdw==
X-Received: by 2002:a2e:150e:0:b0:2c8:3410:2be with SMTP id
 s14-20020a2e150e000000b002c8341002bemr4070977ljd.22.1700492918023; 
 Mon, 20 Nov 2023 07:08:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r14-20020a05600c35ce00b004094d4292aesm13683058wmq.18.2023.11.20.07.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4951065755;
 Mon, 20 Nov 2023 15:08:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 03/14] tests/docker: merge debian-native with debian-amd64
Date: Mon, 20 Nov 2023 15:08:22 +0000
Message-Id: <20231120150833.2552739-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

debian-native isn't really needed and suffers from the problem of
tracking a distros dependencies rather than the projects. With a
little surgery we can make the debian-amd64 container architecture
neutral and allow people to use it to build a native QEMU.

Rename it so it follows the same non-arch pattern of the other distro
containers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
---
 .gitlab-ci.d/buildtest.yml                    | 12 ++---
 .gitlab-ci.d/containers.yml                   |  2 +-
 tests/docker/Makefile.include                 |  3 --
 tests/docker/dockerfiles/debian-native.docker | 54 -------------------
 .../{debian-amd64.docker => debian.docker}    |  7 ++-
 tests/lcitool/refresh                         |  9 ++--
 6 files changed, 18 insertions(+), 69 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-native.docker
 rename tests/docker/dockerfiles/{debian-amd64.docker => debian.docker} (96%)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index da72f7c690..7f9af83b10 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -70,7 +70,7 @@ build-system-debian:
   needs:
     job: amd64-debian-container
   variables:
-    IMAGE: debian-amd64
+    IMAGE: debian
     CONFIGURE_ARGS: --with-coroutine=sigaltstack
     TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4eb-softmmu
       sparc-softmmu xtensa-softmmu
@@ -82,7 +82,7 @@ check-system-debian:
     - job: build-system-debian
       artifacts: true
   variables:
-    IMAGE: debian-amd64
+    IMAGE: debian
     MAKE_CHECK_ARGS: check
 
 avocado-system-debian:
@@ -91,7 +91,7 @@ avocado-system-debian:
     - job: build-system-debian
       artifacts: true
   variables:
-    IMAGE: debian-amd64
+    IMAGE: debian
     MAKE_CHECK_ARGS: check-avocado
     AVOCADO_TAGS: arch:arm arch:i386 arch:riscv64 arch:sh4 arch:sparc arch:xtensa
 
@@ -101,7 +101,7 @@ crash-test-debian:
     - job: build-system-debian
       artifacts: true
   variables:
-    IMAGE: debian-amd64
+    IMAGE: debian
   script:
     - cd build
     - make NINJA=":" check-venv
@@ -589,7 +589,7 @@ build-tools-and-docs-debian:
     # when running on 'master' we use pre-existing container
     optional: true
   variables:
-    IMAGE: debian-amd64
+    IMAGE: debian
     MAKE_CHECK_ARGS: check-unit ctags TAGS cscope
     CONFIGURE_ARGS: --disable-system --disable-user --enable-docs --enable-tools
     QEMU_JOB_PUBLISH: 1
@@ -609,7 +609,7 @@ build-tools-and-docs-debian:
 # of what topic branch they're currently using
 pages:
   extends: .base_job_template
-  image: $CI_REGISTRY_IMAGE/qemu/debian-amd64:$QEMU_CI_CONTAINER_TAG
+  image: $CI_REGISTRY_IMAGE/qemu/debian:$QEMU_CI_CONTAINER_TAG
   stage: test
   needs:
     - job: build-tools-and-docs-debian
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 8637a13d86..ae79d4c58b 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -11,7 +11,7 @@ amd64-debian-container:
   extends: .container_job_template
   stage: containers
   variables:
-    NAME: debian-amd64
+    NAME: debian
 
 amd64-ubuntu2204-container:
   extends: .container_job_template
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index cd4688bf07..5ba5b50ab9 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -88,9 +88,6 @@ DOCKER_PARTIAL_IMAGES += debian-s390x-cross
 DOCKER_PARTIAL_IMAGES += fedora
 endif
 
-# The native build should never use the registry
-docker-image-debian-native: DOCKER_REGISTRY=
-
 # alpine has no adduser
 docker-image-alpine: NOUSER=1
 
diff --git a/tests/docker/dockerfiles/debian-native.docker b/tests/docker/dockerfiles/debian-native.docker
deleted file mode 100644
index abac7d7cd7..0000000000
--- a/tests/docker/dockerfiles/debian-native.docker
+++ /dev/null
@@ -1,54 +0,0 @@
-#
-# Docker Debian Native
-#
-# This is intended to build QEMU on native host systems. Debian is
-# chosen due to the broadest range on supported host systems for QEMU.
-#
-# This docker target is based on the docker.io Debian Bullseye base
-# image rather than QEMU's base because we would otherwise confuse the
-# build grabbing stuff from the registry built for other
-# architectures.
-#
-FROM docker.io/library/debian:bullseye-slim
-MAINTAINER Alex Bennée <alex.bennee@linaro.org>
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
-
-# Install common build utilities
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
-
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy --arch-only qemu
-
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt install -y --no-install-recommends \
-        cscope \
-        genisoimage \
-        exuberant-ctags \
-        global \
-        libbz2-dev \
-        liblzo2-dev \
-        libgcrypt20-dev \
-        libfdt-dev \
-        librdmacm-dev \
-        libsasl2-dev \
-        libsnappy-dev \
-        libvte-dev \
-        netcat-openbsd \
-        ninja-build \
-        openssh-client \
-        python3-numpy \
-        python3-opencv \
-        python3-venv
-
-ENV QEMU_CONFIGURE_OPTS $QEMU_CONFIGURE_OPTS
-ENV DEF_TARGET_LIST "none"
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian.docker
similarity index 96%
rename from tests/docker/dockerfiles/debian-amd64.docker
rename to tests/docker/dockerfiles/debian.docker
index 9b50fb2f63..b5e642d5b6 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -155,10 +155,13 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   cscope\
   global\
-  linux-headers-amd64
+  linux-headers-generic
 RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
 RUN cd /usr/src/netmap && git checkout v11.3
-RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --kernel-dir=$(ls -d /usr/src/linux-headers-*-amd64) && make install
+RUN cd /usr/src/netmap/LINUX && \
+  ./configure --no-drivers --no-apps \
+  --kernel-dir=$(ls -d /usr/src/linux-headers-*-$(dpkg --print-architecture)) \
+  && make install
 ENV QEMU_CONFIGURE_OPTS --enable-netmap
 # As a final step configure the user (if env is defined)
 ARG USER
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 7c211eba2e..993683cf48 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -99,10 +99,13 @@ debian12_extras = [
     "  apt install -y --no-install-recommends \\\n",
     "  cscope\\\n",
     "  global\\\n",
-    "  linux-headers-amd64\n",
+    "  linux-headers-generic\n",
     "RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap\n",
     "RUN cd /usr/src/netmap && git checkout v11.3\n",
-    "RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --kernel-dir=$(ls -d /usr/src/linux-headers-*-amd64) && make install\n",
+    "RUN cd /usr/src/netmap/LINUX && \\\n",
+    "  ./configure --no-drivers --no-apps \\\n",
+    "  --kernel-dir=$(ls -d /usr/src/linux-headers-*-$(dpkg --print-architecture)) \\\n",
+    "  && make install\n",
     "ENV QEMU_CONFIGURE_OPTS --enable-netmap\n"
 ]
 
@@ -123,7 +126,7 @@ try:
     #
     generate_dockerfile("alpine", "alpine-318")
     generate_dockerfile("centos8", "centos-stream-8")
-    generate_dockerfile("debian-amd64", "debian-12",
+    generate_dockerfile("debian", "debian-12",
                         trailer="".join(debian12_extras))
     generate_dockerfile("fedora", "fedora-38")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
-- 
2.39.2


