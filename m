Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B1B77566A
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:30:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTfW3-0004e5-Cs; Wed, 09 Aug 2023 05:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVv-0004bG-E2
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVs-0003cB-TI
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691573396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7UF4docS3pczfv2bGjGXHzDpLqqty5id5D1OGunvEc=;
 b=jWo8so9TIFYsDjF7OK4XhED83y/HW7DSSYESpyxdvAdxdMfXi0w4TYx4+QIYZIrRWP2i0c
 y+49HkhwOyoREZZV3bNhoMM/DhAYsNo1RxYsjlkuJdChJcv2d3YEOY4XAMlSoubeAiNQzi
 hZSOBKyRa56s5z4swpNSotPjOosT9WA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-1Bv_guLKMfSue9WFgQYZRA-1; Wed, 09 Aug 2023 05:29:54 -0400
X-MC-Unique: 1Bv_guLKMfSue9WFgQYZRA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe45e71db3so34358225e9.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 02:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691573393; x=1692178193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7UF4docS3pczfv2bGjGXHzDpLqqty5id5D1OGunvEc=;
 b=JVkoPSfKPv9wQ65hV4jAdFvptU2pr/Zh17I1p+DzbLji2hYbCjQCxqTMVkeZnU5LYQ
 RLOPaK+99K0SxXa3laQRXTCj1egaziYANJXLOrq68WrNhShITJvWhF7WnzQvP5I15fjI
 h/EW06UYIv3UkS5rfkBneRvIIPRQ9vIRa9HgrTtJkIuaM7feSdpbVkHUD3c/rlXbOcav
 qXPOt3NIRL5CZ9TMy4Av0oqczk6teV2m5QS4Qz0I0dGFZLFlm+0xIp3IvjL+0mS/GWa+
 kglUr4qO1E7yuFTJve0B4VL5edrCgTabvHFDp+6ujFte7OSm1zp511YRBjD8MvI/XRcX
 iuCA==
X-Gm-Message-State: AOJu0YwkCM52I3b+elxnvoDNH9Vi1o/3jN/IeQWVEri+PXwbDaaBaBbx
 vqx59cN7+yEa4LTn6eXW2oYzmLyOIVTbX611rTQJchNzpQbHGz9cCqSf3xkXgJE71nHKbNRAnXf
 zDey2rPx9pSroLvFGRaqFw1x0xj5fUeBytW+aQvMNAtDtPqLe7SLgd2MLDtYxFF7pLSBGehwPW/
 k=
X-Received: by 2002:a1c:7916:0:b0:3fb:e643:1225 with SMTP id
 l22-20020a1c7916000000b003fbe6431225mr1676597wme.13.1691573392858; 
 Wed, 09 Aug 2023 02:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEzLQnudzw2yI+cCPEoQWbtY0RlswAyalwNX/cLVLIpV61+gtHheWvRiOONbU8Gzu5e2i+sA==
X-Received: by 2002:a1c:7916:0:b0:3fb:e643:1225 with SMTP id
 l22-20020a1c7916000000b003fbe6431225mr1676586wme.13.1691573392376; 
 Wed, 09 Aug 2023 02:29:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a05600c2a5400b003fc01189b0dsm1393878wme.42.2023.08.09.02.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 02:29:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 9/9] tests/docker: add python3-tomli dependency to containers
Date: Wed,  9 Aug 2023 11:29:33 +0200
Message-ID: <20230809092933.761524-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809092933.761524-1-pbonzini@redhat.com>
References: <20230809092933.761524-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instead of having CI pick tomli from the vendored wheel at configure
time, place it in the containers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/cirrus/freebsd-13.vars               |  2 +-
 .gitlab-ci.d/cirrus/macos-12.vars                 |  2 +-
 tests/docker/dockerfiles/centos8.docker           |  3 ++-
 .../dockerfiles/debian-all-test-cross.docker      |  7 ++++++-
 .../docker/dockerfiles/debian-amd64-cross.docker  |  4 ++++
 tests/docker/dockerfiles/debian-amd64.docker      |  4 ++++
 .../docker/dockerfiles/debian-arm64-cross.docker  |  4 ++++
 .../docker/dockerfiles/debian-armel-cross.docker  |  4 ++++
 .../docker/dockerfiles/debian-armhf-cross.docker  |  4 ++++
 .../dockerfiles/debian-hexagon-cross.docker       |  6 +++++-
 .../dockerfiles/debian-mips64el-cross.docker      |  4 ++++
 .../docker/dockerfiles/debian-mipsel-cross.docker |  4 ++++
 .../dockerfiles/debian-ppc64el-cross.docker       |  4 ++++
 .../docker/dockerfiles/debian-s390x-cross.docker  |  4 ++++
 .../dockerfiles/debian-tricore-cross.docker       |  2 ++
 tests/docker/dockerfiles/fedora-i386-cross.docker |  1 +
 tests/docker/dockerfiles/opensuse-leap.docker     |  3 ++-
 tests/docker/dockerfiles/ubuntu2004.docker        |  4 +++-
 tests/docker/dockerfiles/ubuntu2204.docker        |  1 +
 tests/lcitool/mappings.yml                        | 15 +++++++++++++++
 tests/lcitool/projects/qemu.yml                   |  1 +
 tests/vm/generated/freebsd.json                   |  1 +
 22 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/freebsd-13.vars b/.gitlab-ci.d/cirrus/freebsd-13.vars
index facb649f5bd..3785afca36d 100644
--- a/.gitlab-ci.d/cirrus/freebsd-13.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-13.vars
@@ -11,6 +11,6 @@ MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
 PIP3='/usr/local/bin/pip-3.8'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py39-numpy py39-pillow py39-pip py39-sphinx py39-sphinx_rtd_theme py39-yaml python3 rpm2cpio sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
+PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py39-numpy py39-pillow py39-pip py39-sphinx py39-sphinx_rtd_theme py39-tomli py39-yaml python3 rpm2cpio sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-12.vars b/.gitlab-ci.d/cirrus/macos-12.vars
index ceb294e1539..80eadaab296 100644
--- a/.gitlab-ci.d/cirrus/macos-12.vars
+++ b/.gitlab-ci.d/cirrus/macos-12.vars
@@ -12,5 +12,5 @@ NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
 PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol tesseract usbredir vde vte3 xorriso zlib zstd'
-PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme'
+PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index da7dc818fb6..fc1830966f4 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -133,7 +133,8 @@ RUN /usr/bin/pip3.8 install \
                     meson==0.63.2 \
                     pillow \
                     sphinx \
-                    sphinx-rtd-theme
+                    sphinx-rtd-theme \
+                    tomli
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index f9f401544a0..54e957d5e74 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -58,7 +58,12 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         libc6-dev-sh4-cross \
         gcc-sparc64-linux-gnu \
         libc6-dev-sparc64-cross \
-        python3-venv
+        python3-pip \
+        python3-setuptools \
+        python3-venv \
+        python3-wheel
+
+RUN /usr/bin/pip3 install tomli
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
 ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index b9871f9c8c7..b66b9cc191b 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -47,9 +47,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -65,6 +67,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
+RUN /usr/bin/pip3 install tomli
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 6d2fa38e3e6..02262bc70ec 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -115,9 +115,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -143,6 +145,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
+RUN /usr/bin/pip3 install tomli
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 3504c771a76..a0a968b8c67 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -47,9 +47,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -65,6 +67,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
+RUN /usr/bin/pip3 install tomli
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index 6d11c9510fd..f1fc34a28ac 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -47,9 +47,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -65,6 +67,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
+RUN /usr/bin/pip3 install tomli
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 37ae575cf7e..a2785782119 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -47,9 +47,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -65,6 +67,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
+RUN /usr/bin/pip3 install tomli
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index c2cfb6a5d0f..153fc7cfb31 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -21,11 +21,15 @@ RUN apt-get update && \
         flex \
         git \
         ninja-build \
-        python3-venv && \
+        python3-pip \
+        python3-setuptools \
+        python3-venv \
+        python3-wheel && \
 # Install QEMU build deps for use in CI
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt build-dep -yy --arch-only qemu
 
+RUN /usr/bin/pip3 install tomli
 
 ENV TOOLCHAIN_INSTALL /opt
 ENV TOOLCHAIN_RELEASE 16.0.0
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 26ed730165a..17d3e01ecc8 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -47,9 +47,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -65,6 +67,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
+RUN /usr/bin/pip3 install tomli
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index ade2f37ed1d..5fcd641f155 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -47,9 +47,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -65,6 +67,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
+RUN /usr/bin/pip3 install tomli
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 08dcffa0a85..30e5efa986e 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -47,9 +47,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -65,6 +67,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
+RUN /usr/bin/pip3 install tomli
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 48a2c10fdbd..ee6db7b526b 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -47,9 +47,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -65,6 +67,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
+RUN /usr/bin/pip3 install tomli
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 5bd1963fb55..c597f8e16b1 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -36,6 +36,8 @@ RUN apt update && \
        python3-wheel \
        python3-venv
 
+RUN /usr/bin/pip3 install tomli
+
 RUN curl -#SL https://github.com/bkoppelmann/package_940/releases/download/tricore-toolchain-9.40/tricore-toolchain-9.4.0.tar.gz \
     | tar -xzC /usr/local/
 
diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles/fedora-i386-cross.docker
index 14c1fb2c93a..b59a9115c4c 100644
--- a/tests/docker/dockerfiles/fedora-i386-cross.docker
+++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
@@ -24,6 +24,7 @@ ENV PACKAGES \
     nettle-devel.i686 \
     pcre-devel.i686 \
     pixman-devel.i686 \
+    python3-tomli \
     sysprof-capture-devel.i686 \
     zlib-devel.i686
 
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index fef8d5a2e45..9392f404fb2 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -130,7 +130,8 @@ RUN /usr/bin/pip3.11 install \
                      meson==0.63.2 \
                      pillow \
                      sphinx \
-                     sphinx-rtd-theme
+                     sphinx-rtd-theme \
+                     tomli
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
index 8f864d19e60..4180cd86740 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -141,7 +141,9 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3 install meson==0.63.2
+RUN /usr/bin/pip3 install \
+                            meson==0.63.2 \
+                            tomli
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 8f939870ae7..88493f00f6f 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -117,6 +117,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-pip \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
+                      python3-tomli \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 3c554099ed6..7e203763f49 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -59,6 +59,15 @@ mappings:
     CentOSStream8:
     OpenSUSELeap15:
 
+  python3-tomli:
+    # test using tomllib
+    apk:
+    Fedora:
+    Debian12:
+    # Not available for Python 3.8/3.9
+    CentOSStream8:
+    OpenSUSELeap15:
+
   python3-venv:
     CentOSStream8: python38
     OpenSUSELeap15: python311-base
@@ -75,3 +84,9 @@ pypi_mappings:
   # Drop packages that need devel headers
   python3-numpy:
     OpenSUSELeap15:
+
+  # see above
+  python3-tomli:
+    apk:
+    Fedora:
+    Debian12:
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 2d31cf792ae..584f78cb7f9 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -96,6 +96,7 @@ packages:
  - python3-pip
  - python3-sphinx
  - python3-sphinx-rtd-theme
+ - python3-tomli
  - python3-venv
  - rpm2cpio
  - sdl2
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 7c435cf23e9..2d5895ebed9 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -56,6 +56,7 @@
     "py39-pip",
     "py39-sphinx",
     "py39-sphinx_rtd_theme",
+    "py39-tomli",
     "py39-yaml",
     "python3",
     "rpm2cpio",
-- 
2.41.0


