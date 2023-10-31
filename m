Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2317DCF91
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:46:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpyb-0004rJ-QQ; Tue, 31 Oct 2023 10:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyY-0004ot-0q
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyV-0002AN-Gu
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso37946735e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763449; x=1699368249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlfpiMm1ZkxUpuex2jZCg4Z5MNGK84oyjoBRAsHr7lg=;
 b=Ohk1YOsgnRS6WdMkhstmHSqyVNkF1aNFjrTf9/3PPra5WGBLuYe3vH4Z1h5TPY4hxF
 76pEuVWapRtYsgGx4MXP9cwWtWJJzw3sA4U1OtNogAYjYCtoTOfnmoojRGqybJHnoIwe
 /Iaqx4jOhRwDnEDxxi42NahkIKCXwaY8+EY5CF+jZK+BECJk76A9Iq9MkWpd07FSSS/k
 x1xpmpur5U2VBrsHiHnTBL1EbGwS2/Ur4nvR5L92uJX7qEMAhWQFiavCQd2GWZz1Qrj9
 GzeRg/eH0i5LiB0jddq0rbOh2kgOQi7VvsRAL/wJI9GipKz7o1+pG9uYjh+n8LmxJ+WX
 qOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763449; x=1699368249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlfpiMm1ZkxUpuex2jZCg4Z5MNGK84oyjoBRAsHr7lg=;
 b=XLE5X1blVbDb6mcFplue+DncypStPUxrfqniY8bqYUYt1p1FTlbqep4XCEflD2d2r0
 z1zmwfDkeAVqRvSjsfFPkWSKXMztO4Bh+tVEWl6Rfw6hOy0Y8V36BAXPSGAeybh3kAyW
 kztG9SarEeqwK7689lHunf8jtrgbsKUU7CbhYAZaUaQbK+dwhR53W1nKChRfDYY/CL8x
 TdWFtRGyIQpIyWgUIdn+Zm403933N281g62yeL5nEqVanxqQnEwDJTjMcduY+XIWp2up
 IQ3b3X9Cqo6+AL2+lqDHOMRNZM9FGgFanRv2clllOgUKhFqvnPrDAVHg9XoLP7X2PPoL
 2N/Q==
X-Gm-Message-State: AOJu0YxMafMaShWbw4R3vARM1wKUGsS/haHeJjWRSWKWh8/Rk9FEJ9xS
 pMPDQLi6zmA7aLrxYUseO53euw==
X-Google-Smtp-Source: AGHT+IEOOLbbHL9nVvQF0C6ee+zIeXlASCXfAFu7jrNMXWBEpMl7c/vB+zaLEzwjf6v7TOk1+Wo4eA==
X-Received: by 2002:a7b:c049:0:b0:405:95c3:e79d with SMTP id
 u9-20020a7bc049000000b0040595c3e79dmr10768534wmc.40.1698763448868; 
 Tue, 31 Oct 2023 07:44:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z18-20020a5d6412000000b00327cd5e5ac1sm1686267wru.1.2023.10.31.07.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7665865729;
 Tue, 31 Oct 2023 14:44:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 07/19] tests/docker: move sh4 to use debian-legacy-test-cross
Date: Tue, 31 Oct 2023 14:43:49 +0000
Message-Id: <20231031144401.1238210-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

sh4 is another target which doesn't work with bookworm compilers. To
keep on buster move across to the debian-legacy-test-cross image and
update accordingly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231030135715.800164-1-alex.bennee@linaro.org>

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
index 9500ea6e2c..da72f7c690 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -256,7 +256,7 @@ build-user:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system
-      --target-list-exclude=alpha-linux-user
+      --target-list-exclude=alpha-linux-user,sh4-linux-user
     MAKE_CHECK_ARGS: check-tcg
 
 build-user-static:
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
index 763d36dfe3..8cc68bc912 100644
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
@@ -30,6 +31,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         ninja-build \
         gcc-alpha-linux-gnu \
         libc6.1-dev-alpha-cross \
+        gcc-sh4-linux-gnu \
+        libc6-dev-sh4-cross \
         python3-pip \
         python3-setuptools \
         python3-venv \
@@ -38,7 +41,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
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


