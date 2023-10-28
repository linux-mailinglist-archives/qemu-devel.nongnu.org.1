Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CEE7DA66D
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:34:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdB-0006Ab-T0; Sat, 28 Oct 2023 06:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd9-000696-Vl
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd5-00039O-TX
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40859c46447so19686705e9.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489195; x=1699093995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81A+fTHfkK/i+u7qQsM4s5VTWm7Z9pz42133Nfe8nnY=;
 b=R+N8xND++dg8mOHUh/tSqliS+L7LAlC6rR9GOLBytBKO80Ms93FJ8pSURVE84c/2Z8
 Gn919OU7wG7AtJezD28u2nGrzS9/7DV0nDuVhJq2BEHkcofq5skah8oPnp/UY9WDCbDU
 64i2PdESFTeoejxNlzGLdq5tVX0hPcru/0UuwWeVWbXqTE78LFkdAgNUpt6eq9MjN6YL
 zNMFlsvj2dXIbNM0fqwnYvA/jcaBxVU3ON3ptAndM6a8q3V65XTWv9Q5wkRZuk/1GWNK
 /khSBuxhKwMpSLwxch2dinOUtFwTJaDU3N1KEI8g0wuqDqeyNFw9kjjmSUelcST+iWeS
 0auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489195; x=1699093995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81A+fTHfkK/i+u7qQsM4s5VTWm7Z9pz42133Nfe8nnY=;
 b=M6sMF2G7OjwIAci1DKaU43+k/ctLca7jhzr0MnWyFJwdg9ttXWWKhzwYI+1trGKpSE
 Aadtxv9pfzoMVVFBvIts2HMWdHpXrVl6bQF8DzrYWnoe4JN4ENQfGghUbpM9m+ftye4M
 S6RA9XHCDTIfK2q9ve2H+YOe5SlF/crb9zwZPnn2z5u6EAaa/aXzFGuJsXKJPYVJ5Hxx
 D178y3J8iP1Yi/qssm1gKzXL4mb5SIL6/SU1EGFypjBE9WZrnzYZBO+f89fnmqa9n7Vt
 bqlKKDqX+Hl4X+ba+0LDpGRDwpDrISsE69SX/GFzkgvRDk2cY5EJdUJY4ZIQSp3V4nY6
 p6Tg==
X-Gm-Message-State: AOJu0Ywgi+tXaeJqJmrpUHPcbeceS6UGzSdXX5tVPtpeDM62gTe22yLK
 XW1RjyhH2CbH3NuL4NcLn9Oesw==
X-Google-Smtp-Source: AGHT+IFDNSY5w4MiE3Hblns+UY/1zoqnRR3bdbrncvY6Ou6QXwRHMChq+O+EDT2m5c7yiDXADp6+nQ==
X-Received: by 2002:a05:600c:4452:b0:405:1ba2:4fcb with SMTP id
 v18-20020a05600c445200b004051ba24fcbmr4221321wmn.16.1698489194908; 
 Sat, 28 Oct 2023 03:33:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c9-20020a7bc849000000b00405d9a950a2sm7076142wml.28.2023.10.28.03.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 96E265F79E;
 Sat, 28 Oct 2023 11:33:12 +0100 (BST)
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
Subject: [PATCH 06/17] tests/docker: use debian-all-test-cross for power
Date: Sat, 28 Oct 2023 11:33:00 +0100
Message-Id: <20231028103311.347104-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Maintaining two sets of containers for test building is silly. While
it makes sense for the QEMU cross-compile targets to have their own
fat containers built by lcitool we might as well merge the other
random debian based compilers into the same one used on gitlab.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                                     |  4 ++--
 .gitlab-ci.d/container-cross.yml              |  6 -----
 tests/docker/Makefile.include                 |  1 -
 .../debian-powerpc-test-cross.docker          | 23 -------------------
 4 files changed, 2 insertions(+), 32 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-powerpc-test-cross.docker

diff --git a/configure b/configure
index 37d1b10b87..8707bd2e78 100755
--- a/configure
+++ b/configure
@@ -1325,12 +1325,12 @@ probe_target_compiler() {
         container_cross_prefix=nios2-linux-gnu-
         ;;
       ppc)
-        container_image=debian-powerpc-test-cross
+        container_image=debian-all-test-cross
         container_cross_prefix=powerpc-linux-gnu-
         container_cross_cc=${container_cross_prefix}gcc
         ;;
       ppc64|ppc64le)
-        container_image=debian-powerpc-test-cross
+        container_image=debian-all-test-cross
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         container_cross_cc=${container_cross_prefix}gcc-10
         ;;
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 61f23561b7..ec56990bc5 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -76,12 +76,6 @@ mipsel-debian-cross-container:
   variables:
     NAME: debian-mipsel-cross
 
-powerpc-test-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-powerpc-test-cross
-
 ppc64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 654f24b188..356986d687 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -122,7 +122,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 	$(call debian-toolchain, $@)
 
 # These images may be good enough for building tests but not for test builds
-DOCKER_PARTIAL_IMAGES += debian-powerpc-test-cross
 DOCKER_PARTIAL_IMAGES += debian-hppa-cross
 DOCKER_PARTIAL_IMAGES += debian-loongarch-cross
 DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
diff --git a/tests/docker/dockerfiles/debian-powerpc-test-cross.docker b/tests/docker/dockerfiles/debian-powerpc-test-cross.docker
deleted file mode 100644
index 23779413d3..0000000000
--- a/tests/docker/dockerfiles/debian-powerpc-test-cross.docker
+++ /dev/null
@@ -1,23 +0,0 @@
-#
-# Docker powerpc/ppc64/ppc64le cross-compiler target
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
-        gcc-powerpc-linux-gnu \
-        libc6-dev-powerpc-cross \
-        gcc-10-powerpc64-linux-gnu \
-        libc6-dev-ppc64-cross \
-        gcc-10-powerpc64le-linux-gnu \
-        libc6-dev-ppc64el-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


