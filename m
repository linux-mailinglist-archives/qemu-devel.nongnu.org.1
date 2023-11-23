Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2365B7F636B
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:57:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C49-0005z6-3b; Thu, 23 Nov 2023 10:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C44-0005x1-T1
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:28 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C42-0002KY-C9
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:28 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3316d3d11e1so613994f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754985; x=1701359785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5Fe1dg8Henr/7Y0lJGTU7R1zcvZaXCxNNJ8QeBwhwE=;
 b=uL10uzt8mIK471qbcQN1sU+ICTjcceVdb12Js0mEzsvho5nNdQ6QAYTahcw10fBKen
 7dz3OhlUVkVeqUpR52dtxrp+MjJ4xywIsM2Du+rzalo7aw9iWjxuKmQKQOjJSFm0Bic/
 LV01loV05oUL1i2vTpuYaVSULBNN7YDndTWCPKUsSOV4RuQ5qmuvV5J9LJT8eeYCx4rw
 EmtoQZmHSO17eIY4cHPcrGeo9wVjES8iaFRCjHZwvGiiAKl9GioNowmHaBnxI2fjLrf1
 Rr54CMu0mS5vVJ9uOyd9L/BrjQcVZC9/HQ+VDdcQQ88mWVfsrY2nppPI3FNNvFY+JyC3
 QPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754985; x=1701359785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n5Fe1dg8Henr/7Y0lJGTU7R1zcvZaXCxNNJ8QeBwhwE=;
 b=Q87GHcwsnrhMPsMFox+TcQqB+4sI68FlPUI2ZGQdXHkCmTJ4FZ6Cqcwu3sjnYh7TI1
 RjNcPSw20n4otRRv3PV/BpMWCQ1JIq+Tf6qe2mkchNpkueEy9RgJ06y/KD26/rbhQv0y
 LQzw89ssi88QTM9HLOBEKhZ2Myv5nDkeAdRWKbKMwVoUMSbsmoVoNlBn9RI1nUpzommj
 XUK2fVLn95fhAPRhoB52vyLVgL+5eMeoL5csmOCJSIb1QHW9jRdyktDl119IzXZwLxbE
 Bkk375qKTLb60HD9N2xP2rc6aMh9mUm6iZVD8WM4pJPwNHfv4kGyMIugeBlHAEbCJR/q
 BSqA==
X-Gm-Message-State: AOJu0Yy9bOz939JA5sqsbDlYLLuqF0CEUoVpu7zZmPaYJgoCzJZrR6ej
 iOk0H5cyGUNsiZNPP+pjNVOwjQ==
X-Google-Smtp-Source: AGHT+IHxEKkqVXd320BZIE/pSI4PSq1OJwIioEPANmH/6X1tsz+tDbNBcjRBO6FBSN3Pcm1RGdPNhQ==
X-Received: by 2002:a5d:67c5:0:b0:331:34b0:d7b3 with SMTP id
 n5-20020a5d67c5000000b0033134b0d7b3mr2702193wrw.15.1700754984808; 
 Thu, 23 Nov 2023 07:56:24 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x1-20020adfec01000000b003313e4dddecsm2004270wrn.108.2023.11.23.07.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F696645F8;
 Thu, 23 Nov 2023 15:56:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 03/14] tests/docker: merge debian-native with debian-amd64
Date: Thu, 23 Nov 2023 15:56:09 +0000
Message-Id: <20231123155620.3042891-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123155620.3042891-1-alex.bennee@linaro.org>
References: <20231123155620.3042891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

debian-native isn't really needed and suffers from the problem of
tracking a distros dependencies rather than the projects. With a
little surgery we can make the debian-amd64 container architecture
neutral and allow people to use it to build a native QEMU.

Rename it so it follows the same non-arch pattern of the other distro
containers.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231120150833.2552739-4-alex.bennee@linaro.org>

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


