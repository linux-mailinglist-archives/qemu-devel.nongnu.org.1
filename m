Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D63777DA676
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:35:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdQ-0006Mx-G8; Sat, 28 Oct 2023 06:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgdI-0006JI-0f
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:32 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd7-0003Av-Uv
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083740f92dso22745295e9.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489200; x=1699094000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bU+M83jUNRZkgug/gFeRzCF0q//PFmVsZWhfdTFT9TY=;
 b=cHls56DuOt9QIuOnEECdvO02rYcYpQohBJxna0ODIWI6DlHwq5H7wz9T3z2mRRc7Hv
 hFZCi7za523lzWmY2hV5XuzqoZn5Hkj20yLK+WruUoH6B/g2E1A0dwt9jJouYogNxwgt
 f4KggwPoj4EQs4ZPsxTDuyfXoVkYSik//un25WZs7RE8SmBKjvwAC0dgpteeAwCZ4qDp
 f+dIhJz5vtltOnSC01jBcGUhVNbxPj9j+sZ11LSEPyk8fZ1vbc8FSx/uDjTbjgF+Yf+o
 rcs9r7sNT5PcaWQOJHLZC7dmW2SZ5DinRU7/ZDffoW2dgaWh7hxxkaEwc5Ch9CKI4fmI
 226Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489200; x=1699094000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bU+M83jUNRZkgug/gFeRzCF0q//PFmVsZWhfdTFT9TY=;
 b=ZT9g+xvL+HttrjKFODvc1GMfdQuhKMH49JEC9fC0mk1+lvlabd2mOLaB2cwXn05g2l
 v3iG7tZEn+4F4s7vggiruikVcUUa24Bxmp7cYMUyYKX+8gBOQIHCoYfOE+uSebQiDjso
 yif+W7yDmz9owRdVVE+2oE7Dj/54ytBB6M5DOip0+rMzOByrZuLT1wpPp4dCXSau3Xc5
 bQ0YiHnIDHkPgQ/3dyzFFnwc4EqYCcxDBQXYB3hROFbwD7IQdNucOMBuAtTxvXT1RMWg
 +sydUrI2Pv+OK/PWc6qO2mcDM7UWeAANr5EuNTX+CPENS+HMds9NdCaFEPSDogNivWfw
 17ng==
X-Gm-Message-State: AOJu0YzGQHClnuO2sO9DrW/XxQekOuLdx1d86DkcrrMbogOlyhoPR/Np
 RzznffIhJooNVV4+FD/Wib0ukg==
X-Google-Smtp-Source: AGHT+IGR2SMscu8ijuAuXHWRvH2wmb4Y+tnoqyo4WoaGEU2p8KxW37GG1LUgY1jXGHR2jVq+Jlxr4A==
X-Received: by 2002:a05:600c:190c:b0:402:bcac:5773 with SMTP id
 j12-20020a05600c190c00b00402bcac5773mr4591087wmq.38.1698489200704; 
 Sat, 28 Oct 2023 03:33:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m1-20020a05600c4f4100b004063d8b43e7sm7264686wmq.48.2023.10.28.03.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1F57A5F76C;
 Sat, 28 Oct 2023 11:33:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 11/17] tests/docker: use debian-all-test-cross for riscv64
Date: Sat, 28 Oct 2023 11:33:05 +0100
Message-Id: <20231028103311.347104-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Maintaining two sets of containers for test building is silly. While
it makes sense for the QEMU cross-compile targets to have their own
fat containers built by lcitool we might as well merge the other
random debian based compilers into the same one used on gitlab.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                                     |  4 ++++
 .gitlab-ci.d/container-cross.yml              |  7 -------
 tests/docker/Makefile.include                 |  1 -
 .../debian-riscv64-test-cross.docker          | 19 -------------------
 4 files changed, 4 insertions(+), 27 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-riscv64-test-cross.docker

diff --git a/configure b/configure
index 2d8c7a0312..20247bc149 100755
--- a/configure
+++ b/configure
@@ -1348,6 +1348,10 @@ probe_target_compiler() {
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         container_cross_cc=${container_cross_prefix}gcc-10
         ;;
+      riscv64)
+        container_image=debian-all-test-cross
+        container_cross_prefix=risc64-linux-gnu-
+        ;;
       sh4)
         container_image=debian-legacy-test-cross
         container_cross_prefix=sh4-linux-gnu-
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 0b48bf0172..1436ef8784 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -67,13 +67,6 @@ riscv64-debian-cross-container:
     NAME: debian-riscv64-cross
     QEMU_JOB_OPTIONAL: 1
 
-# we can however build TCG tests using a non-sid base
-riscv64-debian-test-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-riscv64-test-cross
-
 s390x-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 04ac5f9c79..0e8133109d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -125,7 +125,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 DOCKER_PARTIAL_IMAGES += debian-loongarch-cross
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
 DOCKER_PARTIAL_IMAGES += debian-nios2-cross
-DOCKER_PARTIAL_IMAGES += debian-riscv64-test-cross
 DOCKER_PARTIAL_IMAGES += debian-sparc64-cross
 DOCKER_PARTIAL_IMAGES += debian-xtensa-cross
 DOCKER_PARTIAL_IMAGES += fedora-cris-cross
diff --git a/tests/docker/dockerfiles/debian-riscv64-test-cross.docker b/tests/docker/dockerfiles/debian-riscv64-test-cross.docker
deleted file mode 100644
index 6e631295bc..0000000000
--- a/tests/docker/dockerfiles/debian-riscv64-test-cross.docker
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
-        gcc-riscv64-linux-gnu \
-        libc6-dev-riscv64-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


