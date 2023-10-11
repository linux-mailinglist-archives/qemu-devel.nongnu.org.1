Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C707C5043
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:35:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXM-0001e1-JE; Wed, 11 Oct 2023 06:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX5-0001Kt-9u
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX0-0005Ad-IM
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32483535e51so6415818f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020412; x=1697625212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dCeiBmwJ0znzL5+0oomSpJsnl+/in8TKJzyri18rbQw=;
 b=Z7nQaGm23GamYfklZv5XadE+73j9I8LQ7Um4ANb9KLi0vXw4sdcm7iDxhua/cooJOs
 8mnAjfFRaeN0rRD8E2aU6845aqzuHhzle2g2QBg0KkRroouVC/vGMdFPHrvUGujSlTtW
 xmERIrlqSdZ+WaZIpBJr/2VZ9YGl4mMWW0smp7/fPXrb6PoOcxpofiAzhLrEfghVDBdn
 494UA1p605SF3/ewaiEeUBAyzVTcycYnTsSJe68PpWUAgyIDZUV9h9g+91vnbzZxrt+l
 QWYtUOeywR0fWuWuMzEDJQyQxm+dw0uL4wyhXiAWFpBSpLLUPcIWsVLNtAO2xYr/khwA
 TAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020412; x=1697625212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dCeiBmwJ0znzL5+0oomSpJsnl+/in8TKJzyri18rbQw=;
 b=jmn6DUT0FWuPB8zPOiRVhXY18wQAeJpni3eUdsjxk8hb27ihsL7cR4H6pHcPN4YFT7
 /eonUFDHN2U8cV2jC5UyRscovUcUYmK5g2XFlhZgzdyu/tqvOgogPiOLipKeIgl+wUw8
 ztMrxheE1kluCUrrZHWBi/LOrCUhaFv7C4lV5x+f6AG+bfOtOvDCkMy4+X++Nk/VRLDo
 /ouQbxb5snRii2FK99W+KVPvgYv5QB2Hjc9Tov2XzqlXwV68HjXzVEO+4mf/JM5on+RW
 IvnwT/x+MNaapHnYyHU/77Rqp/MErBBXYgh+YcZsiAAbzmm55EFdyxmBLq/Xdud14Ngl
 AFtQ==
X-Gm-Message-State: AOJu0Yw+BHEXnI1F5nDgU66OXy4jRFGwmOaQoH2VZvnz4Gsi36slOcIR
 C/LSGT53acK59/Bv5eax4k7+1myD3xcUXR6UNrA=
X-Google-Smtp-Source: AGHT+IEyhIo3nHyEsR4hipygRKiWy7Cgeq0RySnhLJHzhMCfVqh3EaF+5IJwc2JtcRTbH1HBSJdIAw==
X-Received: by 2002:adf:fa12:0:b0:321:685f:e0a7 with SMTP id
 m18-20020adffa12000000b00321685fe0a7mr17950491wrr.3.1697020412516; 
 Wed, 11 Oct 2023 03:33:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a5d6904000000b0032710f5584fsm14989523wru.25.2023.10.11.03.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:31 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 873121FFBE;
 Wed, 11 Oct 2023 11:33:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 03/25] tests/lcitool: add swtpm to the package list
Date: Wed, 11 Oct 2023 11:33:07 +0100
Message-Id: <20231011103329.670525-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-4-alex.bennee@linaro.org>

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


