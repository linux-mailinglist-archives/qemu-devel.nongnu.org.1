Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C07547DACD6
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:52:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77o-0007VP-D4; Sun, 29 Oct 2023 10:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77l-0007TO-VM
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77g-000578-Vj
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:45 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32d834ec222so2307843f8f.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591039; x=1699195839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VT+BsD/K1uC8UO+MXugaV+aFFXSnXyb2jJK5zOOiOAg=;
 b=y93cRbGGWJlAhaYU+vr1O/mYEjADUhkwfnWjmR79Z00vMB5lYqfG5IPoaqMGw7GAEa
 OiIPZp1bVAp+yigEot/qMquvKpqGvtJUAFNNJdNw5JspDXwzqwr46TO2ZhXbVsHYO+Tz
 SsLIXpwtieQ2dBlg9dVHCxRSr3/urUuoOCOoIo5saknVurKDNtOPjQOvmwaZo5nin82A
 gNRtFP2pEJIBKoiyqiZzuxkhWIOwU5vFpm734Re+ZZfzCsFd2wIwU1oXWP8Ar3vxMP+Y
 grj/fTAgvcI3IJLZF1almlqJhBiiPBNLhbtRV22QK1YqgfMO7gltMX/zzhARFctv7Es/
 hPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591039; x=1699195839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VT+BsD/K1uC8UO+MXugaV+aFFXSnXyb2jJK5zOOiOAg=;
 b=uVrfs6p0zGaEbdvqlCMP5yMR1N1Rct9mkkjP8+UkVjib9WzyypHGdHRgVw28JAYBee
 PLCueQnyDlQh2p8mNc/77wVlsi/4l0davTUfGB75DQngyeI7sSQlde81uYo/LtTJtsIA
 TBRTMus9dIc6S/DyQZZ3xBNOTbfKsgQK4IK3JRj69ndGaBcjAPvOJkCJlyfJP4LLVFES
 wp9ZlH0PoX9EE9iQ5O86FD6kVO3yON7fGK12MdEcc6KsdSdzdCfnHSTNCc4aFGluCfoE
 Sl6hO9wwUbjJcyb39WV4zylBxskgJYh6MNkyYcegzgjafMTeHcWfQAZAacCKGws51BcS
 8o9Q==
X-Gm-Message-State: AOJu0Yz0yf26mXjDSB+lnZMtgsoM9sP3aCAJ6YIHmeRg6LwxyeWCmAfg
 RwhDBQmrGxNbtFpIP8sqDsQmCw==
X-Google-Smtp-Source: AGHT+IGuuUROeiC/JsEmnfDEm7O3yFmM0VdMLUxn54O/GgVW62Wlsy76FJH7joqqBR/xWEgHR/JBTA==
X-Received: by 2002:adf:d1e8:0:b0:32f:7d50:267e with SMTP id
 g8-20020adfd1e8000000b0032f7d50267emr2958463wrd.9.1698591039565; 
 Sun, 29 Oct 2023 07:50:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j13-20020a5d564d000000b00327bf4f2f14sm6103485wrw.88.2023.10.29.07.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B94445F83F;
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
Subject: [PATCH v2 07/19] tests/docker: move sh4 to use
 debian-legacy-test-cross
Date: Sun, 29 Oct 2023 14:50:21 +0000
Message-Id: <20231029145033.592566-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

sh4 is another target which doesn't work with bookworm compilers. To
keep on buster move across to the debian-legacy-test-cross image and
update accordingly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231028103311.347104-6-alex.bennee@linaro.org>

---
v2
  - fix missing exclude from build-user
  - merge fixes
---
 configure                                     |  4 ++++
 .gitlab-ci.d/buildtest.yml                    |  4 ++--
 .gitlab-ci.d/container-cross.yml              |  6 ------
 tests/docker/Makefile.include                 |  2 +-
 .../dockerfiles/debian-all-test-cross.docker  |  4 +---
 .../debian-legacy-test-cross.docker           |  3 ++-
 .../dockerfiles/debian-sh4-cross.docker       | 19 -------------------
 7 files changed, 10 insertions(+), 32 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-sh4-cross.docker

diff --git a/configure b/configure
index c8d0d4f7cb..37d1b10b87 100755
--- a/configure
+++ b/configure
@@ -1334,6 +1334,10 @@ probe_target_compiler() {
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         container_cross_cc=${container_cross_prefix}gcc-10
         ;;
+      sh4)
+        container_image=debian-legacy-test-cross
+        container_cross_prefix=sh4-linux-gnu-
+        ;;
       tricore)
         container_image=debian-tricore-cross
         container_cross_prefix=tricore-
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 9500ea6e2c..b66d05038f 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -266,7 +266,7 @@ build-user-static:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system --static
-      --target-list-exclude=alpha-linux-user
+      --target-list-exclude=alpha-linux-user,sh4-linux-user
     MAKE_CHECK_ARGS: check-tcg
 
 # targets stuck on older compilers
@@ -276,7 +276,7 @@ build-legacy:
     job: amd64-debian-legacy-cross-container
   variables:
     IMAGE: debian-legacy-test-cross
-    TARGETS: alpha-linux-user alpha-softmmu
+    TARGETS: alpha-linux-user alpha-softmmu sh4-linux-user
     CONFIGURE_ARGS: --disable-tools
     MAKE_CHECK_ARGS: check-tcg
 
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 0de1929e74..3e6d741f62 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -116,12 +116,6 @@ s390x-debian-cross-container:
   variables:
     NAME: debian-s390x-cross
 
-sh4-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-sh4-cross
-
 sparc64-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 8270bdff6c..f61d97102f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -129,7 +129,7 @@ DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
 DOCKER_PARTIAL_IMAGES += debian-mips-cross
 DOCKER_PARTIAL_IMAGES += debian-nios2-cross
 DOCKER_PARTIAL_IMAGES += debian-riscv64-test-cross
-DOCKER_PARTIAL_IMAGES += debian-sh4-cross debian-sparc64-cross
+DOCKER_PARTIAL_IMAGES += debian-sparc64-cross
 DOCKER_PARTIAL_IMAGES += debian-xtensa-cross
 DOCKER_PARTIAL_IMAGES += fedora-cris-cross
 
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 205173b0a5..43cc083318 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -52,8 +52,6 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         libc6-dev-riscv64-cross \
         gcc-s390x-linux-gnu \
         libc6-dev-s390x-cross \
-        gcc-sh4-linux-gnu \
-        libc6-dev-sh4-cross \
         gcc-sparc64-linux-gnu \
         libc6-dev-sparc64-cross \
         python3-pip \
@@ -64,7 +62,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
 RUN /usr/bin/pip3 install tomli
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
-ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
+ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
index 763d36dfe3..d9b37995a2 100644
--- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
@@ -4,6 +4,7 @@
 # upgrade. Currently:
 #
 #   libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
+#   sh4-linux-user: binaries don't run with bookworm compiler
 #
 # As we are targeting check-tcg here we only need minimal qemu
 # dependencies and the relevant cross compilers.
@@ -38,7 +39,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
 RUN /usr/bin/pip3 install tomli
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
-ENV DEF_TARGET_LIST alpha-linux-user
+ENV DEF_TARGET_LIST alpha-linux-user,sh4-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-sh4-cross.docker b/tests/docker/dockerfiles/debian-sh4-cross.docker
deleted file mode 100644
index 6bd8171d33..0000000000
--- a/tests/docker/dockerfiles/debian-sh4-cross.docker
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# Docker cross-compiler target
-#
-# This docker target builds on the Debian Bullseye base image.
-#
-FROM docker.io/library/debian:11-slim
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    apt-get update && \
-    apt-get install -y eatmydata && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y \
-        gcc-sh4-linux-gnu \
-        libc6-dev-sh4-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


