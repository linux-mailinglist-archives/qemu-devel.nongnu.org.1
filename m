Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D90896E397
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Sep 2024 21:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smIcO-0006pD-AT; Thu, 05 Sep 2024 15:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smIcJ-0006bO-Ts
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:58:07 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smIcH-0005RA-Jz
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:58:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2021c08b95cso19292295ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725566284; x=1726171084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+DuOGftFxDY3qyDKXAwk5F1NE2ERbb7vqAY+mBTnz/c=;
 b=SQOqyc1wkgjJEUniUJ95LFIiHPmJEmCuAVnXVbp+eYnw5FwiknoXoLqgTfh0ayk4E7
 UCsqgHEobHKQSIF9apZuQCr1tkkxKvHQdnry5yfigwsptgxuhqMiJRmme9xoIQPwkqFh
 ax3+YPT6/BoqB1B98wl3sNmSpNUMdK/qR8pAZ2Z0aBgN4jSPATbAOSnIezw6bNwjPli3
 NJ5FJgb+9NG3mekNehF5T5gIitnUJgJSV+SQxH3ZlUG00FH5k8jiSFuRuCi+DYuJSR6N
 IYg9nf5KCXRFUHTGrgfKKg9KsOYcq7Qp7WXgXKuEEJNMbOirtEW8JlH+gUoRSMgXJonN
 ESSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725566284; x=1726171084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+DuOGftFxDY3qyDKXAwk5F1NE2ERbb7vqAY+mBTnz/c=;
 b=N4muBr/HLDXqrYatlfNOxsO59Rp19515hYpEYNA8qYhIhlizGygeNHStBn7zzNyn8t
 qwLVOevN/DV1tPdVAqgDP5qP1hwP5V9GzmGXMqE3ydh2OGNcw7dNJ8aRWoOzHk4TS0E/
 Fo0u4kJjeI5Bi9YeDF2wSLL+HA7xxfmsk/+Ct+NYZgLHlqNFsnvR0K7MwMc4KIqAqQUp
 JmKBMVz+urp8uWWMdsjiISlfk4DQt3w4ySG8AM9MjJwR3thIwBlgg2+j3uoPMi/cHbCa
 fWMyBC7Scl30bB6RaA5n3kkkiuUIKjEwxrkjtFIa6MXWmya0dBN0KU+Z6MM0YYTLn32S
 O6HQ==
X-Gm-Message-State: AOJu0YyYS85jFfZScVU/m422xMAvXuX+6CNEQA3VrDT1BgK4WbBfOeWo
 DlNlZqxdEjzDigBDrxTrS3h/3tJCsEqQL5Y/sBc5glKYcndmu9YcCPZoog==
X-Google-Smtp-Source: AGHT+IHQHYrzhROAHuoNY5GhwPg1+QW4LUc6hAypGRADPoyf3+ThbP+M9KlPfIjFAgwks565JRngcg==
X-Received: by 2002:a17:902:dac1:b0:202:4bd9:aea5 with SMTP id
 d9443c01a7336-206b833f304mr126702805ad.14.1725566283762; 
 Thu, 05 Sep 2024 12:58:03 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.145])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea5554dsm32031355ad.235.2024.09.05.12.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 12:58:03 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v6 4/8] tests/lcitool: Update libvirt-ci and add libcbor
 dependency
Date: Fri,  6 Sep 2024 01:57:31 +0600
Message-Id: <20240905195735.16911-5-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240905195735.16911-1-dorjoychy111@gmail.com>
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

libcbor dependecy is necessary for adding virtio-nsm and nitro-enclave
machine support in the following commits. libvirt-ci has already been
updated with the dependency upstream and this commit updates libvirt-ci
submodule in QEMU to latest upstream. Also the libcbor dependency has
been added to tests/lcitool/projects/qemu.yml.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 .gitlab-ci.d/cirrus/macos-13.vars                     | 2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 1 +
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 1 +
 tests/docker/dockerfiles/alpine.docker                | 1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armel-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-i686-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
 tests/docker/dockerfiles/debian.docker                | 1 +
 tests/docker/dockerfiles/fedora.docker                | 1 +
 tests/docker/dockerfiles/opensuse-leap.docker         | 3 ++-
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
 tests/lcitool/libvirt-ci                              | 2 +-
 tests/lcitool/projects/qemu.yml                       | 1 +
 20 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/macos-13.vars b/.gitlab-ci.d/cirrus/macos-13.vars
index ac3fa3a847..b10b7f34de 100644
--- a/.gitlab-ci.d/cirrus/macos-13.vars
+++ b/.gitlab-ci.d/cirrus/macos-13.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
index 24cfec3b89..2bbab50ca0 100644
--- a/.gitlab-ci.d/cirrus/macos-14.vars
+++ b/.gitlab-ci.d/cirrus/macos-14.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index 71a0f0c433..4fb3c7555f 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -35,6 +35,7 @@ packages:
   - libcacard-dev
   - libcap-ng-dev
   - libcapstone-dev
+  - libcbor-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index d8de967b18..d79399caf3 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -35,6 +35,7 @@ packages:
   - libcacard-dev
   - libcap-ng-dev
   - libcapstone-dev
+  - libcbor-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 54b9721997..a0136181d3 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -45,6 +45,7 @@ RUN apk update && \
         libaio-dev \
         libbpf-dev \
         libcap-ng-dev \
+        libcbor-dev \
         libdrm-dev \
         libepoxy-dev \
         libffi-dev \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 136c3a79a1..5c5a753aca 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -92,6 +92,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:amd64 \
                       libcap-ng-dev:amd64 \
                       libcapstone-dev:amd64 \
+                      libcbor-dev:amd64 \
                       libcmocka-dev:amd64 \
                       libcurl4-gnutls-dev:amd64 \
                       libdaxctl-dev:amd64 \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 233f6ee1de..7724b5f7fb 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -92,6 +92,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:arm64 \
                       libcap-ng-dev:arm64 \
                       libcapstone-dev:arm64 \
+                      libcbor-dev:arm64 \
                       libcmocka-dev:arm64 \
                       libcurl4-gnutls-dev:arm64 \
                       libdaxctl-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index 8476fc8cce..5e9c4002db 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -95,6 +95,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:armel \
                       libcap-ng-dev:armel \
                       libcapstone-dev:armel \
+                      libcbor-dev:armel \
                       libcmocka-dev:armel \
                       libcurl4-gnutls-dev:armel \
                       libdaxctl-dev:armel \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index f26385e0b9..d64c2a2cbd 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -92,6 +92,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:armhf \
                       libcap-ng-dev:armhf \
                       libcapstone-dev:armhf \
+                      libcbor-dev:armhf \
                       libcmocka-dev:armhf \
                       libcurl4-gnutls-dev:armhf \
                       libdaxctl-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 3fe8ee623d..5b548c764b 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -95,6 +95,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:i386 \
                       libcap-ng-dev:i386 \
                       libcapstone-dev:i386 \
+                      libcbor-dev:i386 \
                       libcmocka-dev:i386 \
                       libcurl4-gnutls-dev:i386 \
                       libdaxctl-dev:i386 \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 2862785692..c375921c2d 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -94,6 +94,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:mips64el \
                       libcap-ng-dev:mips64el \
                       libcapstone-dev:mips64el \
+                      libcbor-dev:mips64el \
                       libcmocka-dev:mips64el \
                       libcurl4-gnutls-dev:mips64el \
                       libdaxctl-dev:mips64el \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 0d559ae4ba..370f8d9c90 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -94,6 +94,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:mipsel \
                       libcap-ng-dev:mipsel \
                       libcapstone-dev:mipsel \
+                      libcbor-dev:mipsel \
                       libcmocka-dev:mipsel \
                       libcurl4-gnutls-dev:mipsel \
                       libdaxctl-dev:mipsel \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 8c1dcec9cf..393d0300c6 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -92,6 +92,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:ppc64el \
                       libcap-ng-dev:ppc64el \
                       libcapstone-dev:ppc64el \
+                      libcbor-dev:ppc64el \
                       libcmocka-dev:ppc64el \
                       libcurl4-gnutls-dev:ppc64el \
                       libdaxctl-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 72668e0315..cbe590080d 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -92,6 +92,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:s390x \
                       libcap-ng-dev:s390x \
                       libcapstone-dev:s390x \
+                      libcbor-dev:s390x \
                       libcmocka-dev:s390x \
                       libcurl4-gnutls-dev:s390x \
                       libdaxctl-dev:s390x \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 42bd0067d1..631fe6b671 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -41,6 +41,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev \
                       libcap-ng-dev \
                       libcapstone-dev \
+                      libcbor-dev \
                       libcmocka-dev \
                       libcurl4-gnutls-dev \
                       libdaxctl-dev \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index ecdefaff1a..a01c004cfa 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -61,6 +61,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                libbpf-devel \
                libcacard-devel \
                libcap-ng-devel \
+               libcbor-devel \
                libcmocka-devel \
                libcurl-devel \
                libdrm-devel \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 66143621fe..751919c1ec 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -4,7 +4,7 @@
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.opensuse.org/opensuse/leap:15.5
+FROM registry.opensuse.org/opensuse/leap:15.6
 
 RUN zypper update -y && \
     zypper install -y \
@@ -46,6 +46,7 @@ RUN zypper update -y && \
            libbz2-devel \
            libcacard-devel \
            libcap-ng-devel \
+           libcbor-devel \
            libcmocka-devel \
            libcurl-devel \
            libdrm-devel \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 3a7de6a318..ecd5c4fd08 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -41,6 +41,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev \
                       libcap-ng-dev \
                       libcapstone-dev \
+                      libcbor-dev \
                       libcmocka-dev \
                       libcurl4-gnutls-dev \
                       libdaxctl-dev \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 789b4601bc..a8253ca565 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 789b4601bce4e01f43fdb6ad4ce5ab4e46674440
+Subproject commit a8253ca5656c34c1d91f2c1170bd0cbf117358f1
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 252e871f80..35878951b6 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -42,6 +42,7 @@ packages:
  - libc-static
  - libcacard
  - libcap-ng
+ - libcbor
  - libcurl
  - libdrm
  - libepoxy
-- 
2.39.2


