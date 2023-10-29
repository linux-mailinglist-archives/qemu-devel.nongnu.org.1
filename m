Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 359117DACD4
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:52:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77p-0007WM-6O; Sun, 29 Oct 2023 10:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77k-0007RK-6g
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77f-00056C-D2
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32f7db21967so765143f8f.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591036; x=1699195836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVl0amLRfGSvSjhVIa/kIq6GAW9b4gC6uASrU+KdCu0=;
 b=dD9krj0+Vg9hPyQdpefVIJxAnOLQOUdpwYjiFWVdfQ1a9XMGlueJBMmG/HXgCCrifx
 q5yF7pYALNlj8Du66QiI1ycuI0ICVxmqPlSyuLEIoCRYiWwuddB59wDbDInNHN2WD6NQ
 4HUgSfm1RmVx1qTwtD296tjBZWrHUngiVi0xJ+/ggSDEm0O7Jse3DVj9TbxYInqBXOS4
 lN89jghWsY/iqpw00PzqrHyLkjOEBGOfRCWBhYe9cDuA1fAviF4oGfjfFvxXlpftWDMD
 pmwxsBlaKjjpTxVkDb1i4vxhzhDaMehI4oq6E9tGbGs8rbUoF7B47KJB/3OY7f6VCZVP
 O6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591036; x=1699195836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVl0amLRfGSvSjhVIa/kIq6GAW9b4gC6uASrU+KdCu0=;
 b=t8bhzohMNmPgP9e/1Egc1parHYnpGKg3/T4PdZzPdaQ/RfS+XwvBv1Z3QC1tK4hciC
 7iXT/w4O1jjgm7ICaeiB3Myw5TOKK2KfbL6QO2AAZTu9h8F01IBzbXVtN2TMsNib3Nr4
 ym8BrKe560Abl3g936VKicO3o7uc/igGH8Yi8Mo34PTZdsJQsFB++38QAtd7+/Tfr7VQ
 IEzq5oeFVxDbHe/pNkOqkHgIGvXXHmyEhj/uBmbW9dSdpBeIRBRFGJCukPDrdYvDBdY0
 +X0RZnMKc8sLXhEmhXNaIy47ZKtKePp5K36M0lyozaQVenbYBzDFekXw1SM/ttdvyu1S
 ktFA==
X-Gm-Message-State: AOJu0YwRK6Ymw1lm0tjAqAOahIBg8i+Jdf/9cxjL5sY1qOzCzgVodgzM
 XS+IVUx0ZV6Y7BXcQuX8ZlOlmg==
X-Google-Smtp-Source: AGHT+IFlYs8BfTQ+5aODafL1Zg61UXgx01OEa9mICht4XyDiP5vrP3FpJBFeaSppbP/sGTbK+KbMYA==
X-Received: by 2002:a5d:6643:0:b0:32f:8181:7d39 with SMTP id
 f3-20020a5d6643000000b0032f81817d39mr1334362wrw.9.1698591036706; 
 Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bu3-20020a056000078300b0032dab20e773sm6200141wrb.69.2023.10.29.07.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 58A965F7A3;
 Sun, 29 Oct 2023 14:50:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kyle Evans <kevans@freebsd.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 03/19] gitlab: split alpha testing into a legacy container
Date: Sun, 29 Oct 2023 14:50:17 +0000
Message-Id: <20231029145033.592566-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
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

The current bookworm compiler doesn't build the static binaries due to
bug #1054412 and it might be awhile before it gets fixed. The problem
of keeping older architecture compilers running isn't going to go away
so lets prepare the ground. Create a legacy container and move some
tests around so the others can get upgraded.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231028103311.347104-4-alex.bennee@linaro.org>

---
v2
  - split other softmmu patches into a new patch
---
 .gitlab-ci.d/buildtest.yml                    | 19 ++++++--
 .gitlab-ci.d/container-cross.yml              |  6 +++
 .../dockerfiles/debian-all-test-cross.docker  |  4 +-
 .../debian-legacy-test-cross.docker           | 46 +++++++++++++++++++
 4 files changed, 69 insertions(+), 6 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-legacy-test-cross.docker

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 25af1bc41e..bb24e052f6 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -256,6 +256,7 @@ build-user:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system
+      --target-list-exclude=alpha-linux-user
     MAKE_CHECK_ARGS: check-tcg
 
 build-user-static:
@@ -265,6 +266,18 @@ build-user-static:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system --static
+      --target-list-exclude=alpha-linux-user
+    MAKE_CHECK_ARGS: check-tcg
+
+# targets stuck on older compilers
+build-legacy:
+  extends: .native_build_job_template
+  needs:
+    job: amd64-debian-legacy-cross-container
+  variables:
+    IMAGE: debian-legacy-test-cross
+    TARGETS: alpha-linux-user alpha-softmmu
+    CONFIGURE_ARGS: --disable-tools
     MAKE_CHECK_ARGS: check-tcg
 
 build-user-hexagon:
@@ -285,7 +298,7 @@ build-some-softmmu:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --enable-debug
-    TARGETS: xtensa-softmmu arm-softmmu aarch64-softmmu alpha-softmmu
+    TARGETS: xtensa-softmmu arm-softmmu aarch64-softmmu
     MAKE_CHECK_ARGS: check-tcg
 
 # We build tricore in a very minimal tricore only container
@@ -318,7 +331,7 @@ clang-user:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-system
-      --target-list-exclude=microblazeel-linux-user,aarch64_be-linux-user,i386-linux-user,m68k-linux-user,mipsn32el-linux-user,xtensaeb-linux-user
+      --target-list-exclude=alpha-linux-user,microblazeel-linux-user,aarch64_be-linux-user,i386-linux-user,m68k-linux-user,mipsn32el-linux-user,xtensaeb-linux-user
       --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
     MAKE_CHECK_ARGS: check-unit check-tcg
 
@@ -505,7 +518,7 @@ build-tci:
   variables:
     IMAGE: debian-all-test-cross
   script:
-    - TARGETS="aarch64 alpha arm hppa m68k microblaze ppc64 s390x x86_64"
+    - TARGETS="aarch64 arm hppa m68k microblaze ppc64 s390x x86_64"
     - mkdir build
     - cd build
     - ../configure --enable-tcg-interpreter --disable-docs --disable-gtk --disable-vnc
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 2848166ba3..80c540230a 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -16,6 +16,12 @@ amd64-debian-user-cross-container:
   variables:
     NAME: debian-all-test-cross
 
+amd64-debian-legacy-cross-container:
+  extends: .container_job_template
+  stage: containers
+  variables:
+    NAME: debian-legacy-test-cross
+
 arm64-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 54e957d5e7..205173b0a5 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -28,8 +28,6 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         ninja-build \
         gcc-aarch64-linux-gnu \
         libc6-dev-arm64-cross \
-        gcc-alpha-linux-gnu \
-        libc6.1-dev-alpha-cross \
         gcc-arm-linux-gnueabihf \
         libc6-dev-armhf-cross \
         gcc-hppa-linux-gnu \
@@ -66,7 +64,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
 RUN /usr/bin/pip3 install tomli
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
-ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
+ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
new file mode 100644
index 0000000000..763d36dfe3
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
@@ -0,0 +1,46 @@
+# Docker legacy cross-compiler target (tests and minimal qemu)
+#
+# Compilers for some of our older targets which we cant currently
+# upgrade. Currently:
+#
+#   libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
+#
+# As we are targeting check-tcg here we only need minimal qemu
+# dependencies and the relevant cross compilers.
+
+FROM docker.io/library/debian:11-slim
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+
+RUN export DEBIAN_FRONTEND=noninteractive && \
+    apt-get update && \
+    apt-get install -y eatmydata && \
+    eatmydata apt-get dist-upgrade -y && \
+    apt build-dep -yy qemu
+
+# Add extra build tools and as many cross compilers as we can for testing
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+        apt install -y --no-install-recommends \
+        bison \
+        ccache \
+        clang  \
+        flex \
+        git \
+        ninja-build \
+        gcc-alpha-linux-gnu \
+        libc6.1-dev-alpha-cross \
+        python3-pip \
+        python3-setuptools \
+        python3-venv \
+        python3-wheel
+
+RUN /usr/bin/pip3 install tomli
+
+ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
+ENV DEF_TARGET_LIST alpha-linux-user
+# As a final step configure the user (if env is defined)
+ARG USER
+ARG UID
+RUN if [ "${USER}" ]; then \
+  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


