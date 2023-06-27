Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EAD740089
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBGb-0000mc-2z; Tue, 27 Jun 2023 12:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGR-00009l-Bl
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGK-0005py-PY
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8ceso18828005e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882191; x=1690474191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CntAb+cgLtatchfM+3lzjapvTHJaq2r9C16N2thtx8U=;
 b=RSdoGeIOhjPGBh7hnRqlIiKjmplaUDhh5qegHRToHsrfsF+BAXO2Pn9+jzLeP0akNi
 fsAzMg7RR6U/tOsTI8To/qBK1YAhmjvueWV7Oj/sxaCMy+f1z3+vWAlWf39jBnYWPxaT
 jvVTdH2G0Uasfk0j37yWG+DIKk4gl8eFRIYOv6Al2ve6IylmEii72lDpr0wcxXb/89GB
 m66FzDiDRypnDUAL0ZfRw0Rf63lJrojZJckX9fYi2ePCoImY1IoJcVxtDD/iwdFXylzS
 bJOMsAD8DTloVFkKa7ef2kGjatlLFjDWhWk9pJRlEvCP7qtNCviiXu7Fwqhs/AyKpNDT
 +akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882191; x=1690474191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CntAb+cgLtatchfM+3lzjapvTHJaq2r9C16N2thtx8U=;
 b=UMRA8cvyYfBYLS2v5h741g+sjP7poNUJ+famWJ+KRoyXqtnzCrvgcoHs/JFEO+xO5R
 I3gSyflci9ZwsTLProoLYOa7NHW5gFS4zTbpyyySN9Aef6Sor08V7NOLsAOUwWZLbZsT
 dtE9HbXzt2Xu40kkgvg5zQeTfVbApKCzMBQTKvhQypF6FiLpv1z+zmEdY3RmQKLjn6rR
 4XlU43km8DZfsOsUYRfBLNTe4ETttl1RcKMUXOLZQ+Bi0jAKWRFyjyO4V7NaCVhx4MJ+
 e+aYpsiApL1SrY4N2pMCGdAOVRIxS1hbP0BjNrVSKdOoYkfw+Ls6aUl8Y/gHX59RGuMo
 b/3w==
X-Gm-Message-State: AC+VfDzvrkUl13Ayvk6jNMM0M4ANtHsVOFF0ncG004otKvt0vp/NGWHI
 2/HXEui7LlCaV2kjHNq7RCQGUg==
X-Google-Smtp-Source: ACHHUZ5M4B6hlWsQciw3F2OZYFfD8+hhwlXLkyBoakXNzwi0aiT6O7Y0SUtCdmB7DWg5IsCS2sCzCg==
X-Received: by 2002:a05:600c:295:b0:3f9:c8b2:dfbd with SMTP id
 21-20020a05600c029500b003f9c8b2dfbdmr13605224wmk.19.1687882190973; 
 Tue, 27 Jun 2023 09:09:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p23-20020a1c7417000000b003f9b0f640b1sm11192228wmc.22.2023.06.27.09.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:09:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A53901FFC7;
 Tue, 27 Jun 2023 17:09:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 15/36] tests/docker: convert riscv64-cross to lcitool
Date: Tue, 27 Jun 2023 17:09:22 +0100
Message-Id: <20230627160943.2956928-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

We still need to base this on Debian Sid until riscv64 is promoted to
a release architecture (or another distro provides a full cross
compile target). We use the new qemu-minimal project description to
avoid bringing in all the extra dependencies because every extra
package is another chance for sid to fail.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../dockerfiles/debian-riscv64-cross.docker   | 119 +++++++++++-------
 tests/lcitool/projects/qemu-minimal.yml       |   4 +
 tests/lcitool/refresh                         |  10 +-
 3 files changed, 87 insertions(+), 46 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 081404e014..a2d879ee1f 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -1,54 +1,85 @@
+# THIS FILE WAS AUTO-GENERATED
 #
-# Docker cross-compiler target for riscv64
+#  $ lcitool dockerfile --layers all --cross riscv64 debian-sid qemu-minimal
 #
-# Currently the only distro that gets close to cross compiling riscv64
-# images is Debian Sid (with unofficial ports). As this is a moving
-# target we keep the library list minimal and are aiming to migrate
-# from this hack as soon as we are able.
-#
-FROM docker.io/library/debian:sid-slim
+# https://gitlab.com/libvirt/libvirt-ci
 
-# Add ports
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
-    DEBIAN_FRONTEND=noninteractive eatmydata apt update -yy && \
-    DEBIAN_FRONTEND=noninteractive eatmydata apt upgrade -yy
-
-# Install common build utilities
-RUN DEBIAN_FRONTEND=noninteractive eatmydata apt install -yy \
-    bison \
-    bc \
-    build-essential \
-    ca-certificates \
-    debian-ports-archive-keyring \
-    dpkg-dev \
-    flex \
-    gettext \
-    git \
-    libglib2.0-dev \
-    ninja-build \
-    pkg-config \
-    python3 \
-    python3-venv
+FROM docker.io/library/debian:sid-slim
 
-# Add ports and riscv64 architecture
-RUN echo "deb http://ftp.ports.debian.org/debian-ports/ sid main" >> /etc/apt/sources.list
-RUN dpkg --add-architecture riscv64
+RUN export DEBIAN_FRONTEND=noninteractive && \
+    apt-get update && \
+    apt-get install -y eatmydata && \
+    eatmydata apt-get dist-upgrade -y && \
+    eatmydata apt-get install --no-install-recommends -y \
+                      bash \
+                      bc \
+                      bison \
+                      ca-certificates \
+                      ccache \
+                      findutils \
+                      flex \
+                      gcc \
+                      git \
+                      libglib2.0-dev \
+                      locales \
+                      make \
+                      meson \
+                      ninja-build \
+                      pkgconf \
+                      python3 \
+                      python3-venv \
+                      sed \
+                      tar && \
+    eatmydata apt-get autoremove -y && \
+    eatmydata apt-get autoclean -y && \
+    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
+    dpkg-reconfigure locales
 
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
+ENV LANG "en_US.UTF-8"
+ENV MAKE "/usr/bin/make"
+ENV NINJA "/usr/bin/ninja"
+ENV PYTHON "/usr/bin/python3"
 
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt install -y --no-install-recommends \
-         gcc-riscv64-linux-gnu \
-         libc6-dev-riscv64-cross \
-         libfdt-dev:riscv64 \
-         libffi-dev:riscv64 \
-         libglib2.0-dev:riscv64 \
-         libpixman-1-dev:riscv64
+RUN export DEBIAN_FRONTEND=noninteractive && \
+    dpkg --add-architecture riscv64 && \
+    eatmydata apt-get install debian-ports-archive-keyring && \
+    eatmydata echo 'deb http://ftp.ports.debian.org/debian-ports/ sid main' > /etc/apt/sources.list.d/ports.list && \
+    eatmydata echo 'deb http://ftp.ports.debian.org/debian-ports/ unreleased main' >> /etc/apt/sources.list.d/ports.list && \
+    eatmydata apt-get update && \
+    eatmydata apt-get dist-upgrade -y && \
+    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
+    eatmydata apt-get install --no-install-recommends -y \
+                      g++-riscv64-linux-gnu \
+                      gcc-riscv64-linux-gnu \
+                      libc6-dev:riscv64 \
+                      libfdt-dev:riscv64 \
+                      libffi-dev:riscv64 \
+                      libglib2.0-dev:riscv64 \
+                      libpixman-1-dev:riscv64 && \
+    eatmydata apt-get autoremove -y && \
+    eatmydata apt-get autoclean -y && \
+    mkdir -p /usr/local/share/meson/cross && \
+    printf "[binaries]\n\
+c = '/usr/bin/riscv64-linux-gnu-gcc'\n\
+ar = '/usr/bin/riscv64-linux-gnu-gcc-ar'\n\
+strip = '/usr/bin/riscv64-linux-gnu-strip'\n\
+pkgconfig = '/usr/bin/riscv64-linux-gnu-pkg-config'\n\
+\n\
+[host_machine]\n\
+system = 'linux'\n\
+cpu_family = 'riscv64'\n\
+cpu = 'riscv64'\n\
+endian = 'little'\n" > /usr/local/share/meson/cross/riscv64-linux-gnu && \
+    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
+    mkdir -p /usr/libexec/ccache-wrappers && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-c++ && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-cc && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-g++ && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-gcc
 
-# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV ABI "riscv64-linux-gnu"
+ENV MESON_OPTS "--cross-file=riscv64-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=riscv64-linux-gnu-
 ENV DEF_TARGET_LIST riscv64-softmmu,riscv64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
index b60fec715c..d44737dc1d 100644
--- a/tests/lcitool/projects/qemu-minimal.yml
+++ b/tests/lcitool/projects/qemu-minimal.yml
@@ -4,6 +4,8 @@ packages:
  - bash
  - bc
  - bison
+ - ccache
+ - findutils
  - flex
  - g++
  - gcc
@@ -21,3 +23,5 @@ packages:
  - pkg-config
  - python3
  - python3-venv
+ - sed
+ - tar
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 5e06fb2cf5..b54566edcc 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -63,12 +63,12 @@ add_user_mapping = [
     "  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi\n"
 ]
 
-def generate_dockerfile(host, target, cross=None, trailer=None):
+def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None):
     filename = Path(src_dir, "tests", "docker", "dockerfiles", host + ".docker")
     cmd = lcitool_cmd + ["dockerfile"]
     if cross is not None:
         cmd.extend(["--cross", cross])
-    cmd.extend([target, "qemu"])
+    cmd.extend([target, project])
 
     if trailer is not None:
         trailer += "\n".join(add_user_mapping)
@@ -164,6 +164,12 @@ try:
                         trailer=cross_build("powerpc64le-linux-gnu-",
                                             "ppc64-softmmu,ppc64-linux-user"))
 
+    generate_dockerfile("debian-riscv64-cross", "debian-sid",
+                        project="qemu-minimal",
+                        cross="riscv64",
+                        trailer=cross_build("riscv64-linux-gnu-",
+                                            "riscv64-softmmu,riscv64-linux-user"))
+
     generate_dockerfile("debian-s390x-cross", "debian-11",
                         cross="s390x",
                         trailer=cross_build("s390x-linux-gnu-",
-- 
2.39.2


