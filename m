Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE60E7ED4AF
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 21:58:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Mva-0004tb-9u; Wed, 15 Nov 2023 15:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvT-0004mF-KS
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:57 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvO-000893-Er
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40a48775c58so406875e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 12:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700081744; x=1700686544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDk9A3AkID4sGRaGhwIPug5Icc2SkBEyvmrQK1bQO6g=;
 b=S6ZKKf8yzKD1WsOormRWx/zDpq4+giro42iw9pdYt/s3hjrrusBDR97kYMN1OPIEWq
 v2f1iJRX0rkRds/cI94QkBbq+qI1WBdE+y4K2lXDObnjVJdDoOzkW23HeSvv27w/fBUg
 oXofw9yCxqBG3sslulNFPzR+n5ZycCbNgbOdQYDFYouR9m66OrV1qped992eaXV0FCJ6
 TnS5MBH+VEsGESkK/hJ1QzS7BkzvjG9BHo0vj8ah7B5sHJ04AdjY249F0J407cUWkTnx
 ziFb8UWLKc+4qmDsbRSf5bgQGCz5wJEWLsEQZqJnIbC8Nt6bukKraFnRc3VcNDBsgoIy
 Vjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700081744; x=1700686544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDk9A3AkID4sGRaGhwIPug5Icc2SkBEyvmrQK1bQO6g=;
 b=i21DBcpnQD8GGvWBAddtMdzMgW7DX0r0s44Bdx0qx7pKucNKcaaAupufYaXaNLRtIw
 qAuwK+J1mVoNwqfTGq1HJViisLV5ItuaAcYNNuEgvpmpv8n5cKlNt8VW5mbt1oQqVisV
 AQqZozAWiAxl9Vty/JwsR1hgngFol1gLpHmcRTgrjS9nUW1Lecm0nwjTAavHY4cS96Mt
 DEcjAy8NH8g2b5oEWX5F/UcAT/ffv2STSxqUpFeHd3iYP7wOU9cGGG2rKNN4xYYe7l3H
 tpqYEY0J/Obiep3E7DkQB1RGzNbysPvzyPQr+K0NWa0nOI2ul01byd9cz8sAq8UT/veW
 R5Jg==
X-Gm-Message-State: AOJu0YzQkJxOnRC86KLi/ydSeuWRpws/Stu7O92jYjQ7wiIbcWQk8rRp
 mzdLMJW1GGmv2bBUoqquEe/sjg==
X-Google-Smtp-Source: AGHT+IGDqmJAFaI7IiFi9XiiM18av4OTVvnAnSYw64ISTGxoXXnqvnXtjaIRInBZ1oSh0M8siJEKMA==
X-Received: by 2002:a05:600c:894:b0:40a:44c0:fd43 with SMTP id
 l20-20020a05600c089400b0040a44c0fd43mr400317wmp.17.1700081743849; 
 Wed, 15 Nov 2023 12:55:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g7-20020a05600c4ec700b004094e565e71sm871619wmq.23.2023.11.15.12.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 12:55:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF76C5F7AF;
 Wed, 15 Nov 2023 20:55:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/10] tests/docker: replace fedora-i386 with debian-i686
Date: Wed, 15 Nov 2023 20:55:33 +0000
Message-Id: <20231115205542.3092038-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115205542.3092038-1-alex.bennee@linaro.org>
References: <20231115205542.3092038-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

Fedora is gradually killing off i386 packages in its repos, via a
death-by-1000-cuts process. Thus Debian looks like a better long
term bet for i686 build testing. It has the added advantage that
we can generate it via lcitool too.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231107164109.1449014-1-berrange@redhat.com>
[AJB: tweak commit msg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                                     |   2 +-
 .gitlab-ci.d/container-cross.yml              |  11 +-
 .gitlab-ci.d/crossbuilds.yml                  |  12 +-
 .../dockerfiles/debian-i686-cross.docker      | 182 ++++++++++++++++++
 .../dockerfiles/fedora-i386-cross.docker      |  40 ----
 tests/lcitool/refresh                         |   7 +
 6 files changed, 202 insertions(+), 52 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-i686-cross.docker
 delete mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker

diff --git a/configure b/configure
index abcb199aa8..5e7b76e3a1 100755
--- a/configure
+++ b/configure
@@ -1307,7 +1307,7 @@ probe_target_compiler() {
         container_cross_cc=${container_cross_prefix}gcc
         ;;
       i386)
-        container_image=fedora-i386-cross
+        container_image=debian-i686-cross
         container_cross_prefix=
         ;;
       loongarch64)
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 463ac493ad..8d235cbea0 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -46,6 +46,12 @@ loongarch-debian-cross-container:
   variables:
     NAME: debian-loongarch-cross
 
+i686-debian-cross-container:
+  extends: .container_job_template
+  stage: containers
+  variables:
+    NAME: debian-i686-cross
+
 mips64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
@@ -95,11 +101,6 @@ cris-fedora-cross-container:
   variables:
     NAME: fedora-cris-cross
 
-i386-fedora-cross-container:
-  extends: .container_job_template
-  variables:
-    NAME: fedora-i386-cross
-
 win32-fedora-cross-container:
   extends: .container_job_template
   variables:
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index ac71a2abd3..c2af6c7f44 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -37,25 +37,25 @@ cross-arm64-kvm-only:
     IMAGE: debian-arm64-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
 
-cross-i386-user:
+cross-i686-user:
   extends:
     - .cross_user_build_job
     - .cross_test_artifacts
   needs:
-    job: i386-fedora-cross-container
+    job: i686-debian-cross-container
   variables:
-    IMAGE: fedora-i386-cross
+    IMAGE: debian-i686-cross
     MAKE_CHECK_ARGS: check
 
-cross-i386-tci:
+cross-i686-tci:
   extends:
     - .cross_accel_build_job
     - .cross_test_artifacts
   timeout: 60m
   needs:
-    job: i386-fedora-cross-container
+    job: i686-debian-cross-container
   variables:
-    IMAGE: fedora-i386-cross
+    IMAGE: debian-i686-cross
     ACCEL: tcg-interpreter
     EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins
     MAKE_CHECK_ARGS: check check-tcg
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
new file mode 100644
index 0000000000..3fc4e15acd
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -0,0 +1,182 @@
+# THIS FILE WAS AUTO-GENERATED
+#
+#  $ lcitool dockerfile --layers all --cross-arch i686 debian-11 qemu
+#
+# https://gitlab.com/libvirt/libvirt-ci
+
+FROM docker.io/library/debian:11-slim
+
+RUN export DEBIAN_FRONTEND=noninteractive && \
+    apt-get update && \
+    apt-get install -y eatmydata && \
+    eatmydata apt-get dist-upgrade -y && \
+    eatmydata apt-get install --no-install-recommends -y \
+                      bash \
+                      bc \
+                      bison \
+                      bsdextrautils \
+                      bzip2 \
+                      ca-certificates \
+                      ccache \
+                      dbus \
+                      debianutils \
+                      diffutils \
+                      exuberant-ctags \
+                      findutils \
+                      flex \
+                      gcc \
+                      gcovr \
+                      gettext \
+                      git \
+                      hostname \
+                      libglib2.0-dev \
+                      libpcre2-dev \
+                      libsndio-dev \
+                      libspice-protocol-dev \
+                      llvm \
+                      locales \
+                      make \
+                      meson \
+                      mtools \
+                      ncat \
+                      ninja-build \
+                      openssh-client \
+                      pkgconf \
+                      python3 \
+                      python3-numpy \
+                      python3-opencv \
+                      python3-pillow \
+                      python3-pip \
+                      python3-setuptools \
+                      python3-sphinx \
+                      python3-sphinx-rtd-theme \
+                      python3-venv \
+                      python3-wheel \
+                      python3-yaml \
+                      rpm2cpio \
+                      sed \
+                      socat \
+                      sparse \
+                      tar \
+                      tesseract-ocr \
+                      tesseract-ocr-eng \
+                      xorriso \
+                      zstd && \
+    eatmydata apt-get autoremove -y && \
+    eatmydata apt-get autoclean -y && \
+    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
+    dpkg-reconfigure locales
+
+RUN /usr/bin/pip3 install tomli
+
+ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
+ENV LANG "en_US.UTF-8"
+ENV MAKE "/usr/bin/make"
+ENV NINJA "/usr/bin/ninja"
+ENV PYTHON "/usr/bin/python3"
+
+RUN export DEBIAN_FRONTEND=noninteractive && \
+    dpkg --add-architecture i386 && \
+    eatmydata apt-get update && \
+    eatmydata apt-get dist-upgrade -y && \
+    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
+    eatmydata apt-get install --no-install-recommends -y \
+                      g++-i686-linux-gnu \
+                      gcc-i686-linux-gnu \
+                      libaio-dev:i386 \
+                      libasan6:i386 \
+                      libasound2-dev:i386 \
+                      libattr1-dev:i386 \
+                      libbpf-dev:i386 \
+                      libbrlapi-dev:i386 \
+                      libbz2-dev:i386 \
+                      libc6-dev:i386 \
+                      libcacard-dev:i386 \
+                      libcap-ng-dev:i386 \
+                      libcapstone-dev:i386 \
+                      libcmocka-dev:i386 \
+                      libcurl4-gnutls-dev:i386 \
+                      libdaxctl-dev:i386 \
+                      libdrm-dev:i386 \
+                      libepoxy-dev:i386 \
+                      libfdt-dev:i386 \
+                      libffi-dev:i386 \
+                      libfuse3-dev:i386 \
+                      libgbm-dev:i386 \
+                      libgcrypt20-dev:i386 \
+                      libglib2.0-dev:i386 \
+                      libglusterfs-dev:i386 \
+                      libgnutls28-dev:i386 \
+                      libgtk-3-dev:i386 \
+                      libibumad-dev:i386 \
+                      libibverbs-dev:i386 \
+                      libiscsi-dev:i386 \
+                      libjemalloc-dev:i386 \
+                      libjpeg62-turbo-dev:i386 \
+                      libjson-c-dev:i386 \
+                      liblttng-ust-dev:i386 \
+                      liblzo2-dev:i386 \
+                      libncursesw5-dev:i386 \
+                      libnfs-dev:i386 \
+                      libnuma-dev:i386 \
+                      libpam0g-dev:i386 \
+                      libpipewire-0.3-dev:i386 \
+                      libpixman-1-dev:i386 \
+                      libpng-dev:i386 \
+                      libpulse-dev:i386 \
+                      librbd-dev:i386 \
+                      librdmacm-dev:i386 \
+                      libsasl2-dev:i386 \
+                      libsdl2-dev:i386 \
+                      libsdl2-image-dev:i386 \
+                      libseccomp-dev:i386 \
+                      libselinux1-dev:i386 \
+                      libslirp-dev:i386 \
+                      libsnappy-dev:i386 \
+                      libspice-server-dev:i386 \
+                      libssh-gcrypt-dev:i386 \
+                      libsystemd-dev:i386 \
+                      libtasn1-6-dev:i386 \
+                      libubsan1:i386 \
+                      libudev-dev:i386 \
+                      liburing-dev:i386 \
+                      libusb-1.0-0-dev:i386 \
+                      libusbredirhost-dev:i386 \
+                      libvdeplug-dev:i386 \
+                      libvirglrenderer-dev:i386 \
+                      libvte-2.91-dev:i386 \
+                      libzstd-dev:i386 \
+                      nettle-dev:i386 \
+                      systemtap-sdt-dev:i386 \
+                      xfslibs-dev:i386 \
+                      zlib1g-dev:i386 && \
+    eatmydata apt-get autoremove -y && \
+    eatmydata apt-get autoclean -y && \
+    mkdir -p /usr/local/share/meson/cross && \
+    printf "[binaries]\n\
+c = '/usr/bin/i686-linux-gnu-gcc'\n\
+ar = '/usr/bin/i686-linux-gnu-gcc-ar'\n\
+strip = '/usr/bin/i686-linux-gnu-strip'\n\
+pkgconfig = '/usr/bin/i686-linux-gnu-pkg-config'\n\
+\n\
+[host_machine]\n\
+system = 'linux'\n\
+cpu_family = 'x86'\n\
+cpu = 'i686'\n\
+endian = 'little'\n" > /usr/local/share/meson/cross/i686-linux-gnu && \
+    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
+    mkdir -p /usr/libexec/ccache-wrappers && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-linux-gnu-c++ && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-linux-gnu-cc && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-linux-gnu-g++ && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-linux-gnu-gcc
+
+ENV ABI "i686-linux-gnu"
+ENV MESON_OPTS "--cross-file=i686-linux-gnu"
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-linux-gnu-
+ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
+# As a final step configure the user (if env is defined)
+ARG USER
+ARG UID
+RUN if [ "${USER}" ]; then \
+  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles/fedora-i386-cross.docker
deleted file mode 100644
index b59a9115c4..0000000000
--- a/tests/docker/dockerfiles/fedora-i386-cross.docker
+++ /dev/null
@@ -1,40 +0,0 @@
-FROM registry.fedoraproject.org/fedora:34
-
-ENV PACKAGES \
-    bison \
-    bzip2 \
-    ccache \
-    diffutils \
-    flex \
-    findutils \
-    gcc \
-    git \
-    libfdt-devel.i686 \
-    libffi-devel.i686 \
-    libselinux-devel.i686 \
-    libtasn1-devel.i686 \
-    libzstd-devel.i686 \
-    make \
-    meson \
-    ninja-build \
-    glib2-devel.i686 \
-    glibc-devel.i686 \
-    glibc-static.i686 \
-    gnutls-devel.i686 \
-    nettle-devel.i686 \
-    pcre-devel.i686 \
-    pixman-devel.i686 \
-    python3-tomli \
-    sysprof-capture-devel.i686 \
-    zlib-devel.i686
-
-ENV QEMU_CONFIGURE_OPTS --cpu=i386 --disable-vhost-user
-ENV PKG_CONFIG_LIBDIR /usr/lib/pkgconfig
-
-RUN dnf update -y && dnf install -y $PACKAGES
-RUN rpm -q $PACKAGES | sort > /packages.txt
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 92e7d30982..10c54a377c 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -156,6 +156,13 @@ try:
                         trailer=cross_build("arm-linux-gnueabihf-",
                                             "arm-softmmu,arm-linux-user"))
 
+    generate_dockerfile("debian-i686-cross", "debian-11",
+                        cross="i686",
+                        trailer=cross_build("x86_64-linux-gnu-",
+                                            "x86_64-softmmu,"
+                                            "x86_64-linux-user,"
+                                            "i386-softmmu,i386-linux-user"))
+
     generate_dockerfile("debian-mips64el-cross", "debian-11",
                         cross="mips64el",
                         trailer=cross_build("mips64el-linux-gnuabi64-",
-- 
2.39.2


