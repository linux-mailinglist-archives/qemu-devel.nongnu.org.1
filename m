Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8027CA461BB
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Feb 2025 15:07:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI1Z-0001Kg-5s; Wed, 26 Feb 2025 09:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI11-00014G-Je
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:59 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0x-0005i7-Nn
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:59 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4397e5d5d99so43436515e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578634; x=1741183434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDLyudi3+640ZQ27IJ0M4Zn6FgkrKumyqduUtKFDbuA=;
 b=o7eUxCDwYAOkFqZGhEQM7vYzFH1OS3kjrPeryLFUI2tQHtaS/qtvLWuriSELGUHLOc
 5I0zU56Bu/sU9matAl+LAfiHIj0pvca8bN4Z2HGg+gxls+/Fa9RxnFwOuBfw7zM2oqz9
 qguD9TOghOk4YRdTIfppxE5PAkQpxQL7w5swLohISrl7lrfRgE2lKLxbFQaVUrbf2wA0
 hYWBhUVIKc3GheeT23K80abdgvSB+BjZSL5GzwywE1f57zx+enNiBYs1bXrZJmD6n2RX
 fmljVwd6bOuccm/f6eJ2ErXce/cOywkGv1W/vvSj8I0s6gqMgvohC3al+jfZHtVM0Zwi
 S5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578634; x=1741183434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDLyudi3+640ZQ27IJ0M4Zn6FgkrKumyqduUtKFDbuA=;
 b=q+D2FXU9MQ3vi75bbg4EEtyzKhs+nHfMqq8ExMvGuDdZQSxlSAv+y4BWhBNpsVgGQh
 mG20TkS/D3uLAmA40vSzglk3lF25pphupelNY5KTgw6psY8TfMbpTUSH3+hHY54UvjVH
 jVuO+3io4ZjuO59tvXPPY9LEKoqd9z7HZgT+hrnkFXhvjK80/DHtksK5xOfVPDi1jw6u
 ATzLJN1HEn50jGCo1zGmH/tfprKabfMKCToT3AmK0MxrenWoZL9gWxz8xLNBzmZ5XjUQ
 jiGvborMDwdtKszKs/pEky7qDcn1uqjglzz86EE0hli5KbCjDUx7GoN5WwM5Sjm5dxdK
 DxuQ==
X-Gm-Message-State: AOJu0YwGkg/SaOmPyxEirwqfwznL+cSkTEQi0EP1q8QtUaV8HRQbL6a7
 CuZEP8fTKfCGNq5601Rb2l/mCd09n/3z6I6TKAAPo10hVhvyMdLW4w3fABlA18k=
X-Gm-Gg: ASbGncsi+qj+F1tLpHXG64J7PuZfgmDAiOKnU8BJHA0lmFzVeu7lhZo/FrNr9aH/pnU
 WYvf2ndDNJBqI1laDUWCn1lWWiDJkiPlNmn/e/DkABTX3mPdAgADgbDKpMZipFj8+aUP0JIcqlO
 tU36EiYRJU974CjfUEYy/TkIWzTY/iI9yX4plf86m7dLJBi8j5dWG4CnmXP0g22tHaKeSM2wUwM
 pSXV8M5UoTyS4Q4eLtGOuULpbvAZQJNE5sScWsKwzRZjgciJL+8RDkMpT1CLbRT1C7ZtkWRLKOO
 FEwVR3S7QQKEFqtwg8Dz9yGFBuAW
X-Google-Smtp-Source: AGHT+IElI6K7n4ytq16EbPhewDJArfCdhSGtKYaaY4/b3ql0joxoOKIP0aGjmqeZy3jMVQcEwx2aZg==
X-Received: by 2002:a05:600c:3b0c:b0:439:99d1:d4a4 with SMTP id
 5b1f17b1804b1-43ab0f42a0dmr65121775e9.18.1740578632530; 
 Wed, 26 Feb 2025 06:03:52 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5393e5sm22633445e9.20.2025.02.26.06.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D707560370;
 Wed, 26 Feb 2025 14:03:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 09/25] libvirt-ci: bump to latest for vulkan-tools (libvirt MR
 525)
Date: Wed, 26 Feb 2025 14:03:27 +0000
Message-Id: <20250226140343.3907080-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The alpine baseline has also been updated in the meantime so we need
to address that while we are at it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/cirrus/freebsd-14.vars                   | 2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 1 +
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 1 +
 tests/docker/dockerfiles/alpine.docker                | 5 +++--
 tests/docker/dockerfiles/centos9.docker               | 1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 3 ++-
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 3 ++-
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 3 ++-
 tests/docker/dockerfiles/debian-i686-cross.docker     | 3 ++-
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 3 ++-
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 3 ++-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 3 ++-
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 3 ++-
 tests/docker/dockerfiles/debian.docker                | 3 ++-
 tests/docker/dockerfiles/fedora-rust-nightly.docker   | 1 +
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 1 +
 tests/docker/dockerfiles/fedora.docker                | 1 +
 tests/docker/dockerfiles/opensuse-leap.docker         | 1 +
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
 tests/lcitool/libvirt-ci                              | 2 +-
 tests/lcitool/projects/qemu.yml                       | 1 +
 tests/lcitool/refresh                                 | 2 +-
 tests/vm/generated/freebsd.json                       | 1 +
 24 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars b/.gitlab-ci.d/cirrus/freebsd-14.vars
index 0997c47af5..19ca0d3663 100644
--- a/.gitlab-ci.d/cirrus/freebsd-14.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-14.vars
@@ -11,6 +11,6 @@ MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
 PIP3='/usr/local/bin/pip'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
+PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 vulkan-tools xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
index 25dff322e6..b039465f56 100644
--- a/.gitlab-ci.d/cirrus/macos-14.vars
+++ b/.gitlab-ci.d/cirrus/macos-14.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index 288156d1e4..dbcd2e076d 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -123,6 +123,7 @@ packages:
   - tar
   - tesseract-ocr
   - tesseract-ocr-eng
+  - vulkan-tools
   - xorriso
   - zlib1g-dev
   - zstd
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index d497139ef3..4b8ee3d885 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -121,6 +121,7 @@ packages:
   - tar
   - tesseract-ocr
   - tesseract-ocr-eng
+  - vulkan-tools
   - xorriso
   - zlib1g-dev
   - zstd
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index f87c40fbfe..bf3bd5a30d 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all alpine-319 qemu
+#  $ lcitool dockerfile --layers all alpine-321 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/alpine:3.19
+FROM docker.io/library/alpine:3.21
 
 RUN apk update && \
     apk upgrade && \
@@ -111,6 +111,7 @@ RUN apk update && \
         vde2-dev \
         virglrenderer-dev \
         vte3-dev \
+        vulkan-tools \
         which \
         xen-dev \
         xorriso \
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index a9681c8a96..a942835a1d 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -115,6 +115,7 @@ RUN dnf distro-sync -y && \
         usbredir-devel \
         util-linux \
         vte291-devel \
+        vulkan-tools \
         which \
         xorriso \
         zlib-devel \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 644fd3734d..0535585428 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -58,6 +58,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
+                      vulkan-tools \
                       xorriso \
                       zstd && \
     eatmydata apt-get autoremove -y && \
@@ -135,7 +136,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsndio-dev:amd64 \
                       libspice-protocol-dev:amd64 \
                       libspice-server-dev:amd64 \
-                      libssh-gcrypt-dev:amd64 \
+                      libssh-dev:amd64 \
                       libsystemd-dev:amd64 \
                       libtasn1-6-dev:amd64 \
                       libubsan1:amd64 \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 060da53796..6b1e4fc827 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -58,6 +58,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
+                      vulkan-tools \
                       xorriso \
                       zstd && \
     eatmydata apt-get autoremove -y && \
@@ -134,7 +135,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsndio-dev:arm64 \
                       libspice-protocol-dev:arm64 \
                       libspice-server-dev:arm64 \
-                      libssh-gcrypt-dev:arm64 \
+                      libssh-dev:arm64 \
                       libsystemd-dev:arm64 \
                       libtasn1-6-dev:arm64 \
                       libubsan1:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index a481fc9695..cf0fe63af9 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -58,6 +58,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
+                      vulkan-tools \
                       xorriso \
                       zstd && \
     eatmydata apt-get autoremove -y && \
@@ -134,7 +135,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsndio-dev:armhf \
                       libspice-protocol-dev:armhf \
                       libspice-server-dev:armhf \
-                      libssh-gcrypt-dev:armhf \
+                      libssh-dev:armhf \
                       libsystemd-dev:armhf \
                       libtasn1-6-dev:armhf \
                       libubsan1:armhf \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 61bc361e85..1c84dfb945 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -58,6 +58,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
+                      vulkan-tools \
                       xorriso \
                       zstd && \
     eatmydata apt-get autoremove -y && \
@@ -134,7 +135,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsndio-dev:i386 \
                       libspice-protocol-dev:i386 \
                       libspice-server-dev:i386 \
-                      libssh-gcrypt-dev:i386 \
+                      libssh-dev:i386 \
                       libsystemd-dev:i386 \
                       libtasn1-6-dev:i386 \
                       libubsan1:i386 \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 9f6c4763c5..257204eae4 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -58,6 +58,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
+                      vulkan-tools \
                       xorriso \
                       zstd && \
     eatmydata apt-get autoremove -y && \
@@ -133,7 +134,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsndio-dev:mips64el \
                       libspice-protocol-dev:mips64el \
                       libspice-server-dev:mips64el \
-                      libssh-gcrypt-dev:mips64el \
+                      libssh-dev:mips64el \
                       libsystemd-dev:mips64el \
                       libtasn1-6-dev:mips64el \
                       libudev-dev:mips64el \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 2e979111e0..395c84d65b 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -58,6 +58,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
+                      vulkan-tools \
                       xorriso \
                       zstd && \
     eatmydata apt-get autoremove -y && \
@@ -133,7 +134,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsndio-dev:mipsel \
                       libspice-protocol-dev:mipsel \
                       libspice-server-dev:mipsel \
-                      libssh-gcrypt-dev:mipsel \
+                      libssh-dev:mipsel \
                       libsystemd-dev:mipsel \
                       libtasn1-6-dev:mipsel \
                       libudev-dev:mipsel \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 8ee450dba0..1ae227ccde 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -58,6 +58,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
+                      vulkan-tools \
                       xorriso \
                       zstd && \
     eatmydata apt-get autoremove -y && \
@@ -134,7 +135,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsndio-dev:ppc64el \
                       libspice-protocol-dev:ppc64el \
                       libspice-server-dev:ppc64el \
-                      libssh-gcrypt-dev:ppc64el \
+                      libssh-dev:ppc64el \
                       libsystemd-dev:ppc64el \
                       libtasn1-6-dev:ppc64el \
                       libubsan1:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index f451a07c4c..afa81a57ba 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -58,6 +58,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
+                      vulkan-tools \
                       xorriso \
                       zstd && \
     eatmydata apt-get autoremove -y && \
@@ -133,7 +134,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsnappy-dev:s390x \
                       libsndio-dev:s390x \
                       libspice-protocol-dev:s390x \
-                      libssh-gcrypt-dev:s390x \
+                      libssh-dev:s390x \
                       libsystemd-dev:s390x \
                       libtasn1-6-dev:s390x \
                       libubsan1:s390x \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 505330a9e2..5b3bac43cc 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -87,7 +87,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsndio-dev \
                       libspice-protocol-dev \
                       libspice-server-dev \
-                      libssh-gcrypt-dev \
+                      libssh-dev \
                       libsystemd-dev \
                       libtasn1-6-dev \
                       libubsan1 \
@@ -131,6 +131,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
+                      vulkan-tools \
                       xorriso \
                       zlib1g-dev \
                       zstd && \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index a8e4fb279a..fe4a6ed48d 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -132,6 +132,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                util-linux \
                virglrenderer-devel \
                vte291-devel \
+               vulkan-tools \
                which \
                xen-devel \
                xorriso \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 7dc3eb03f5..a950344402 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -61,6 +61,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                tesseract \
                tesseract-langpack-eng \
                util-linux \
+               vulkan-tools \
                which \
                xorriso \
                zstd && \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index b64399af66..014e3ccf17 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -132,6 +132,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                util-linux \
                virglrenderer-devel \
                vte291-devel \
+               vulkan-tools \
                which \
                xen-devel \
                xorriso \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 4d5fb3e3a1..e90225dc23 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -115,6 +115,7 @@ RUN zypper update -y && \
            util-linux \
            virglrenderer-devel \
            vte-devel \
+           vulkan-tools \
            which \
            xen-devel \
            xorriso \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index e1b70b536d..88ce4ef9a9 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -130,6 +130,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
+                      vulkan-tools \
                       xorriso \
                       zlib1g-dev \
                       zstd && \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index b6a65806bc..18c4bfe02c 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit b6a65806bc9b2b56985f5e97c936b77c7e7a99fc
+Subproject commit 18c4bfe02c467e5639bf9a687139735ccd7a3fff
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 80bcac0902..c07242f272 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -122,6 +122,7 @@ packages:
  - usbredir
  - virglrenderer
  - vte
+ - vulkan-tools
  - which
  - xen
  - xorriso
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 53f8d2585f..aa551aca9b 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -163,7 +163,7 @@ try:
     #
     # Standard native builds
     #
-    generate_dockerfile("alpine", "alpine-319")
+    generate_dockerfile("alpine", "alpine-321")
     generate_dockerfile("centos9", "centos-stream-9")
     generate_dockerfile("debian", "debian-12",
                         trailer="".join(debian12_extras))
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 81fc38d798..c03e1cd586 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -73,6 +73,7 @@
     "usbredir",
     "virglrenderer",
     "vte3",
+    "vulkan-tools",
     "xorriso",
     "zstd"
   ],
-- 
2.39.5


