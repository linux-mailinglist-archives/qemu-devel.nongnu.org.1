Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 282199B3388
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Oct 2024 15:30:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5QlT-0000Qz-BN; Mon, 28 Oct 2024 10:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qke-00009a-0K
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkb-0003gv-AA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cu9aA/o8xY620Gq2pXnEleLdjXMeArjsOBIgEnKBdxU=;
 b=RM+q5qwU6D4ElFK8gcXOkznCHI0KjeWnipz2VT+P3VXTqmMsjEPBWHVT+6wYpnzI5Qn7SE
 zvAx2tce96ur6ktXbtIrduIgzfOqCUl3ZVrSI772+LsjscL5P+svQcbVYUSoTNajBq0PBi
 t7FiIxxBPkxKfnFEn0uWc09XZr64iWk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-4oQu5R8mOeqXzj8UrS1Dzg-1; Mon, 28 Oct 2024 10:29:42 -0400
X-MC-Unique: 4oQu5R8mOeqXzj8UrS1Dzg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431518ae047so27970415e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125780; x=1730730580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cu9aA/o8xY620Gq2pXnEleLdjXMeArjsOBIgEnKBdxU=;
 b=Q37yeJ534JZSsqEaQv4bxprV+BiCb662XzgwpbBxufLCz6KqYqOWzI4aTYT+pF2faL
 mCHFakBTla+43Ac50gOxHo1YJ1GjG83fS4h7Hp8rK7RVZs88N96fc0ILgGf0DjQWIvW8
 13RfQUItHg7anV17BPZy+ofIK4QZ9ToAoXZFBjwSjdgJuuHz2TohSZ6Rhd976ZolY01j
 V4qqQjngEyU4fUUWctf26X0JIlTuu9lZB3e35sqGz+SkWF4ylmGqiCAJ+27SPXt37rbw
 QT3u+X1p0qHKJWXKOxFGMXr00qShMoJgnXExRTn0PgzMtl0+/+tfeUNp+pEkvV5X8jc8
 d/iw==
X-Gm-Message-State: AOJu0YxC7M8wGZn7VmCCLTqP3eiKLxe8qxS2VIURwndIDEPgSSXNoQMN
 nAoTPoKvkZuDhkXSlYm9inAByPkNEZ/p1ekYP+LNZjdRnL4f+1D+kUTK/Yr18GzAE8/NzAfsAwP
 bX80/RY920kQftHQurzVpE8FvlSVg6ibG9HCY+WFKtzMSW9ZzJ+io8YocKJxaa/NzWc/fPXOsw5
 GTL9c5qdNu+lf5XV4lD0BIuqqxDRb2I3wOpzBuMh8=
X-Received: by 2002:a5d:58db:0:b0:378:8b56:4665 with SMTP id
 ffacd0b85a97d-38080ef7a63mr2837f8f.24.1730125779899; 
 Mon, 28 Oct 2024 07:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxgOxdq9cqMl1utrqHDYKKgMH8HtA5YvvFIlWj4DfNUXtYh6c3LIrlPg19srSYo+z4vkXvXQ==
X-Received: by 2002:a5d:58db:0:b0:378:8b56:4665 with SMTP id
 ffacd0b85a97d-38080ef7a63mr2800f8f.24.1730125779372; 
 Mon, 28 Oct 2024 07:29:39 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b3bb4csm9604068f8f.33.2024.10.28.07.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:29:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 02/24] tests: add 'rust' and 'bindgen' to CI package list
Date: Mon, 28 Oct 2024 15:29:09 +0100
Message-ID: <20241028142932.363687-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Although we're not enabling rust by default yet, we can still add
rust and bindgen to the CI package list.

This demonstrates that we're not accidentally triggering unexpected
build behaviour merely from Rust being present. When we do dev work
to enable rust by default, this will show we're building correctly
on all platforms we target.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20241015133925.311587-2-berrange@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/cirrus/freebsd-14.vars                   | 2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
 .gitlab-ci.d/cirrus/macos-15.vars                     | 2 +-
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 2 ++
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 2 ++
 tests/docker/dockerfiles/alpine.docker                | 2 ++
 tests/docker/dockerfiles/centos9.docker               | 2 ++
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 3 +++
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 3 +++
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 3 +++
 tests/docker/dockerfiles/debian-i686-cross.docker     | 3 +++
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 3 +++
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 3 +++
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 3 +++
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 3 +++
 tests/docker/dockerfiles/debian.docker                | 2 ++
 tests/docker/dockerfiles/fedora-rust-nightly.docker   | 2 ++
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 2 ++
 tests/docker/dockerfiles/fedora.docker                | 2 ++
 tests/docker/dockerfiles/opensuse-leap.docker         | 2 ++
 tests/docker/dockerfiles/ubuntu2204.docker            | 2 ++
 tests/lcitool/projects/qemu.yml                       | 2 ++
 tests/vm/generated/freebsd.json                       | 2 ++
 23 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars b/.gitlab-ci.d/cirrus/freebsd-14.vars
index c0655b21e91..044cec7c145 100644
--- a/.gitlab-ci.d/cirrus/freebsd-14.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-14.vars
@@ -11,6 +11,6 @@ MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
 PIP3='/usr/local/bin/pip-3.8'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
+PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
index 24cfec3b897..1fd03d68b97 100644
--- a/.gitlab-ci.d/cirrus/macos-14.vars
+++ b/.gitlab-ci.d/cirrus/macos-14.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-15.vars b/.gitlab-ci.d/cirrus/macos-15.vars
index 23b2c1d22f4..b6b6d71d473 100644
--- a/.gitlab-ci.d/cirrus/macos-15.vars
+++ b/.gitlab-ci.d/cirrus/macos-15.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index 71a0f0c4336..dd89ba1b3a7 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -7,6 +7,7 @@
 packages:
   - bash
   - bc
+  - bindgen
   - bison
   - bsdextrautils
   - bzip2
@@ -113,6 +114,7 @@ packages:
   - python3-venv
   - python3-yaml
   - rpm2cpio
+  - rustc
   - sed
   - socat
   - sparse
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index d8de967b186..74f14d8d0fe 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -7,6 +7,7 @@
 packages:
   - bash
   - bc
+  - bindgen
   - bison
   - bsdextrautils
   - bzip2
@@ -111,6 +112,7 @@ packages:
   - python3-venv
   - python3-yaml
   - rpm2cpio
+  - rustc
   - sed
   - socat
   - sparse
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 54b97219974..9ce7b5280c0 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -90,6 +90,8 @@ RUN apk update && \
         py3-yaml \
         python3 \
         rpm2cpio \
+        rust \
+        rust-bindgen \
         samurai \
         sdl2-dev \
         sdl2_image-dev \
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 0256865b9e9..a9681c8a96f 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -16,6 +16,7 @@ RUN dnf distro-sync -y && \
         alsa-lib-devel \
         bash \
         bc \
+        bindgen-cli \
         bison \
         brlapi-devel \
         bzip2 \
@@ -102,6 +103,7 @@ RUN dnf distro-sync -y && \
         python3-sphinx_rtd_theme \
         python3-tomli \
         rdma-core-devel \
+        rust \
         sed \
         snappy-devel \
         socat \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 136c3a79a1f..b86949b2e6c 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -13,6 +13,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
@@ -53,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -170,6 +172,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/x86_64-linux-gnu && \
 
 ENV ABI "x86_64-linux-gnu"
 ENV MESON_OPTS "--cross-file=x86_64-linux-gnu"
+ENV RUST_TARGET "x86_64-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-linux-gnu-
 ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 233f6ee1dea..68789791121 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -13,6 +13,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
@@ -53,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -169,6 +171,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/aarch64-linux-gnu && \
 
 ENV ABI "aarch64-linux-gnu"
 ENV MESON_OPTS "--cross-file=aarch64-linux-gnu"
+ENV RUST_TARGET "aarch64-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
 ENV DEF_TARGET_LIST aarch64-softmmu,aarch64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index f26385e0b92..e38b8fcc412 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -13,6 +13,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
@@ -53,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -169,6 +171,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabihf && \
 
 ENV ABI "arm-linux-gnueabihf"
 ENV MESON_OPTS "--cross-file=arm-linux-gnueabihf"
+ENV RUST_TARGET "armv7-unknown-linux-gnueabihf"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
 ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 2328ee1732a..b4d06187390 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -13,6 +13,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
@@ -53,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -168,6 +170,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/i686-linux-gnu && \
 
 ENV ABI "i686-linux-gnu"
 ENV MESON_OPTS "--cross-file=i686-linux-gnu"
+ENV RUST_TARGET "i686-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-linux-gnu-
 ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index bfa96cb507f..4f6c816b3fe 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -13,6 +13,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
@@ -53,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -158,6 +160,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/mips64el-linux-gnuabi64 && \
 
 ENV ABI "mips64el-linux-gnuabi64"
 ENV MESON_OPTS "--cross-file=mips64el-linux-gnuabi64"
+ENV RUST_TARGET "mips64el-unknown-linux-gnuabi64"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips64el-linux-gnuabi64-
 ENV DEF_TARGET_LIST mips64el-softmmu,mips64el-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 4ac314e22e2..a238526b4c5 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -13,6 +13,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
@@ -53,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -166,6 +168,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/mipsel-linux-gnu && \
 
 ENV ABI "mipsel-linux-gnu"
 ENV MESON_OPTS "--cross-file=mipsel-linux-gnu"
+ENV RUST_TARGET "mipsel-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
 ENV DEF_TARGET_LIST mipsel-softmmu,mipsel-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 8c1dcec9cf7..b6c6f5b7b00 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -13,6 +13,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
@@ -53,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -168,6 +170,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/powerpc64le-linux-gnu && \
 
 ENV ABI "powerpc64le-linux-gnu"
 ENV MESON_OPTS "--cross-file=powerpc64le-linux-gnu"
+ENV RUST_TARGET "powerpc64le-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc64le-linux-gnu-
 ENV DEF_TARGET_LIST ppc64-softmmu,ppc64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 72668e03152..14f169984eb 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -13,6 +13,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
@@ -53,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -167,6 +169,7 @@ endian = 'big'\n" > /usr/local/share/meson/cross/s390x-linux-gnu && \
 
 ENV ABI "s390x-linux-gnu"
 ENV MESON_OPTS "--cross-file=s390x-linux-gnu"
+ENV RUST_TARGET "s390x-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
 ENV DEF_TARGET_LIST s390x-softmmu,s390x-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 42bd0067d1b..22b064cbf01 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -13,6 +13,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
@@ -120,6 +121,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index e642db163c7..c2029cc4c6e 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -23,6 +23,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                alsa-lib-devel \
                bash \
                bc \
+               bindgen-cli \
                bison \
                brlapi-devel \
                bzip2 \
@@ -113,6 +114,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-sphinx_rtd_theme \
                python3-zombie-imp \
                rdma-core-devel \
+               rust \
                sed \
                snappy-devel \
                socat \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 6b264d901f7..3ba62b55ad7 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -20,6 +20,7 @@ exec "$@"\n' > /usr/bin/nosync && \
     nosync dnf install -y \
                bash \
                bc \
+               bindgen-cli \
                bison \
                bzip2 \
                ca-certificates \
@@ -53,6 +54,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-sphinx \
                python3-sphinx_rtd_theme \
                python3-zombie-imp \
+               rust \
                sed \
                socat \
                sparse \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index ecdefaff1a1..1980421f6ae 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -23,6 +23,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                alsa-lib-devel \
                bash \
                bc \
+               bindgen-cli \
                bison \
                brlapi-devel \
                bzip2 \
@@ -113,6 +114,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-sphinx_rtd_theme \
                python3-zombie-imp \
                rdma-core-devel \
+               rust \
                sed \
                snappy-devel \
                socat \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index e359a4e5c19..53b94610308 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -96,6 +96,8 @@ RUN zypper update -y && \
            python311-pip \
            python311-setuptools \
            rdma-core-devel \
+           rust \
+           rust-bindgen \
            sed \
            snappy-devel \
            sndio-devel \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 3a7de6a3183..ce3aa39d4f3 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -13,6 +13,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
@@ -120,6 +121,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 252e871f802..6852918642e 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -3,6 +3,7 @@ packages:
  - alsa
  - bash
  - bc
+ - bindgen
  - bison
  - brlapi
  - bzip2
@@ -101,6 +102,7 @@ packages:
  - python3-tomli
  - python3-venv
  - rpm2cpio
+ - rust
  - sdl2
  - sdl2-image
  - sed
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 1eb2757c955..5da8d30bcdf 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -61,6 +61,8 @@
     "py311-tomli",
     "python3",
     "rpm2cpio",
+    "rust",
+    "rust-bindgen-cli",
     "sdl2",
     "sdl2_image",
     "snappy",
-- 
2.47.0


