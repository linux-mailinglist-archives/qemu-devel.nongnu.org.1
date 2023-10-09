Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FFF7BE6D7
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:45:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptLy-0000JI-Jo; Mon, 09 Oct 2023 12:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptJl-00056m-Rt
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:41:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptJc-0001Sb-9D
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:41:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-406619b53caso43604565e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696869666; x=1697474466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5m5U8IdFTmwnSfYsG3qTGew7BexOyKIusQXPfvvs/U=;
 b=vz5PqvH9U5rKALlBvgbzKyROM3vzShax7FDmDTQZQbkPlxXAl+F0MgGi2DcxKuc0CQ
 ZCpS/86QS76EOoNuH46DhDGod1Jg6jMES3gkoMabXgPB+FL7Da2wLNge+dMToJpuxrjg
 Uc8Th0VVrh/GVs8f7xDAZwtSzqCEu4yj9t0CioQsuzuJNxj+wY8+45xGIycTLtCQFiTI
 0BWtkIW5TdtfLoJTP73ydoizVOJt/D7u1HYKJ6sA43TDkIPblkh2wQbeQsLdZOBVx3lt
 TTb3p8EuDPWq2kxJOYwlMKXNuYMNV44NqBJi8ChHG3dereCMcGHkjuhbz3siKl6Sojf/
 Y7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696869666; x=1697474466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L5m5U8IdFTmwnSfYsG3qTGew7BexOyKIusQXPfvvs/U=;
 b=v+j1351NgbpRXLbeOOhxFQpZxedDhdqXJi3f74KbzwuYTnpWKtHnS36SyUuJhiImlI
 vtpdFgJ0lBZwOSk91yPtMMfdD71EsBaIXZ/2JvEVNzFseOTmoXzfjewcnGk2ie7jnGzL
 AiKur1wKO0rnPyeiiV+whK8uiyjhlnSNfluO3LSlCmOU5HfUJUxlNB8UJ+CteE/Gxw6J
 PhPvsljeurimR0EpAW5YVxymm/Bl5GpJiD4Do9OMgdQaGlLDyrmMRymc7VWgUuKYhccq
 ucfYFLH6mJQuPiWHaoIPKILzEUiqX5B7lWsFiXZwKULz9bNv9cOF/3FAEKeTehbrlQJ2
 3hIg==
X-Gm-Message-State: AOJu0YyOK/7R+5dR9aVYY6379jPYFu3jNtAYSCQStskB1nVpL/GFEl5z
 gjrhdHC05o08FdlV6aA5XpiPyQ==
X-Google-Smtp-Source: AGHT+IE6ve37LmtyveDWHMjHvGyNZLMJzkDgSCleA6oRmEERxHnq0iDcunlM8h6YkZyDzk2rAV+JEw==
X-Received: by 2002:a05:600c:378d:b0:401:a0b1:aef6 with SMTP id
 o13-20020a05600c378d00b00401a0b1aef6mr14480216wmr.2.1696869666447; 
 Mon, 09 Oct 2023 09:41:06 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 az41-20020a05600c602900b004068495910csm13838934wmb.23.2023.10.09.09.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 09:41:06 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8775C1FFBE;
 Mon,  9 Oct 2023 17:41:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Brad Smith <brad@comstyle.com>, Radoslaw Biernacki <rad@semihalf.com>,
 David Hildenbrand <david@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Nicholas Piggin <npiggin@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/25] tests/lcitool: add swtpm to the package list
Date: Mon,  9 Oct 2023 17:40:42 +0100
Message-Id: <20231009164104.369749-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164104.369749-1-alex.bennee@linaro.org>
References: <20231009164104.369749-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We need this to test some TPM stuff.

Message-Id: <20230925144854.1872513-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/cirrus/macos-12.vars                    | 2 +-
 tests/docker/dockerfiles/alpine.docker               | 1 +
 tests/docker/dockerfiles/centos8.docker              | 1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-amd64.docker         | 1 +
 tests/docker/dockerfiles/debian-arm64-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-ppc64el-cross.docker | 1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker   | 1 +
 tests/docker/dockerfiles/fedora-win32-cross.docker   | 1 +
 tests/docker/dockerfiles/fedora-win64-cross.docker   | 1 +
 tests/docker/dockerfiles/fedora.docker               | 1 +
 tests/docker/dockerfiles/opensuse-leap.docker        | 1 +
 tests/docker/dockerfiles/ubuntu2204.docker           | 1 +
 tests/lcitool/libvirt-ci                             | 2 +-
 tests/lcitool/projects/qemu.yml                      | 1 +
 16 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/macos-12.vars b/.gitlab-ci.d/cirrus/macos-12.vars
index 80eadaab29..5f3fb346d1 100644
--- a/.gitlab-ci.d/cirrus/macos-12.vars
+++ b/.gitlab-ci.d/cirrus/macos-12.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index d25649cb4f..42f6928627 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -100,6 +100,7 @@ RUN apk update && \
         sparse \
         spice-dev \
         spice-protocol \
+        swtpm \
         tar \
         tesseract-ocr \
         usbredir-dev \
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index 68bfe606f5..d97c30e96a 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -107,6 +107,7 @@ RUN dnf distro-sync -y && \
         socat \
         spice-protocol \
         spice-server-devel \
+        swtpm \
         systemd-devel \
         systemtap-sdt-devel \
         tar \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 0991938595..00bdc06021 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -55,6 +55,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       sed \
                       socat \
                       sparse \
+                      swtpm \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 61dbc3ff24..9b50fb2f63 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -124,6 +124,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       sed \
                       socat \
                       sparse \
+                      swtpm \
                       systemtap-sdt-dev \
                       tar \
                       tesseract-ocr \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 74eabb274e..2dae3777f7 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -55,6 +55,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       sed \
                       socat \
                       sparse \
+                      swtpm \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 1ebd6ebd00..180ed836e6 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -55,6 +55,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       sed \
                       socat \
                       sparse \
+                      swtpm \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 59091fed02..d6be2f0cc5 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -55,6 +55,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       sed \
                       socat \
                       sparse \
+                      swtpm \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 48b2f28310..ec0041d6aa 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -55,6 +55,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       sed \
                       socat \
                       sparse \
+                      swtpm \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
index afa988574f..08799219f9 100644
--- a/tests/docker/dockerfiles/fedora-win32-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win32-cross.docker
@@ -55,6 +55,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                socat \
                sparse \
                spice-protocol \
+               swtpm \
                tar \
                tesseract \
                tesseract-langpack-eng \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index cf93a0ca60..f8e4cb70d3 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -55,6 +55,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                socat \
                sparse \
                spice-protocol \
+               swtpm \
                tar \
                tesseract \
                tesseract-langpack-eng \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index f00e9e267c..9e9c71fa94 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -118,6 +118,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                sparse \
                spice-protocol \
                spice-server-devel \
+               swtpm \
                systemd-devel \
                systemtap-sdt-devel \
                tar \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index ed04b4d6da..dc0e36ce48 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -100,6 +100,7 @@ RUN zypper update -y && \
            socat \
            sparse \
            spice-protocol-devel \
+           swtpm \
            systemd-devel \
            systemtap-sdt-devel \
            tar \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 94c2c16118..2ca9cff79c 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -124,6 +124,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       sed \
                       socat \
                       sparse \
+                      swtpm \
                       systemtap-sdt-dev \
                       tar \
                       tesseract-ocr \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index e3ed1e5da1..36bc517161 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit e3ed1e5da101943e53d8d89424e17b22120743f5
+Subproject commit 36bc517161c45ead20224d47f2dc4fa428af6724
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 6f0885170d..82092c9f17 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -110,6 +110,7 @@ packages:
  - spice-protocol
  - spice-server
  - ssh-client
+ - swtpm
  - systemd
  - tar
  - tesseract
-- 
2.39.2


