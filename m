Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B92B7DA66C
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:34:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdE-0006DF-VI; Sat, 28 Oct 2023 06:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgdB-0006Ae-Ft
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:25 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd6-0003A5-7w
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32f7c44f6a7so222266f8f.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489198; x=1699093998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOohqrrDiZJNNE6BJJ+qouc5a6zBuGTEa7edb0jfkyU=;
 b=mMFO0szoFRqILLC5DZoiJmJY2xc0KJyQwnJ8m/GGM6QLyQ+Rk2z5tFhR/1DuSc5OZs
 wOFIms432rnS7OATLycbQpfo5Gg7rD4y/84ATAliEegIeVUFV2LmW6VCGSit3BAd3SmB
 3ei3AUyIgQAW7a8VkYn02BgUBp5D3VCQMn4dcErd7TatNH/KijpPwNnx6X+3XY/hez8i
 mKJ+sysgeWD+8o/10cfTVr9Haare4Mwlj3h1begf2sKRUdNq9c7oc5L87/z5DDEpnLR+
 6sMFaHmqnYCt9ctFN25w32AjIuxR99EC3w2MQKyzYuPvuMfR0znZTeD69QpHiqXxSsuV
 XXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489198; x=1699093998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VOohqrrDiZJNNE6BJJ+qouc5a6zBuGTEa7edb0jfkyU=;
 b=M2YQWvAAp9SnqVpQSM/YWqp3vOY/uGe8c/KFLsQFjxsvIDvRjtAms6zq25gb51o0jG
 Q0HcmbPr6HoRvnpws9i/Plq3pH1/YPpZtomkhfm8wZDELklJ9vEtRSkXJ93A2bj+bOw7
 jy3ISlyfbcAnSK4M38QjYP8S7CRKrFvXcLlL0V6CSoF1iRaTEMBjgWuC+z+4jIxYSISg
 S0y5Smb+NtVOCVP6v5nInsLdhoK+zqJ7+j+zPY7Gj9+yeYjCGzqs9tcK8SxgKIfk8trv
 JcRnpoviOzHsz2RPd2TQ5VNjeSfcVcJIwHo9eBxyuJs//6CJPJQCMcLA6h5CBbOs1GM+
 vhBQ==
X-Gm-Message-State: AOJu0YwmRz8tuVPKekbRDZCiDJqvyg/fcqjzR760bUYqPgsHdPeLEwib
 DUK3/wv5Gi47e4FqJ87J5TMN9A==
X-Google-Smtp-Source: AGHT+IEgCbCMqbYe5wz5RJ67IRpy2C4XSo/eexLK6YoZI7JX9nnTBPCKSWRQkJqH31X//2Sw2g9Pxw==
X-Received: by 2002:a05:6000:11c8:b0:319:72f8:7249 with SMTP id
 i8-20020a05600011c800b0031972f87249mr3546980wrx.66.1698489198037; 
 Sat, 28 Oct 2023 03:33:18 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x14-20020a5d444e000000b0031980294e9fsm3568243wrr.116.2023.10.28.03.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E12995F7A1;
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
Subject: [PATCH 09/17] tests/docker: use debian-all-test-cross for mips64
Date: Sat, 28 Oct 2023 11:33:03 +0100
Message-Id: <20231028103311.347104-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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
 configure                                     |  2 +-
 .gitlab-ci.d/container-cross.yml              |  6 ------
 tests/docker/Makefile.include                 |  1 -
 .../dockerfiles/debian-mips64-cross.docker    | 19 -------------------
 4 files changed, 1 insertion(+), 27 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-mips64-cross.docker

diff --git a/configure b/configure
index c7c811fb02..2bcbf0fc36 100755
--- a/configure
+++ b/configure
@@ -1327,7 +1327,7 @@ probe_target_compiler() {
         container_cross_prefix=mips64el-linux-gnuabi64-
         ;;
       mips64)
-        container_image=debian-mips64-cross
+        container_image=debian-all-test-cross
         container_cross_prefix=mips64-linux-gnuabi64-
         ;;
       nios2)
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index cf2fcaa59e..f863a14664 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -40,12 +40,6 @@ hexagon-cross-container:
   variables:
     NAME: debian-hexagon-cross
 
-mips64-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-mips64-cross
-
 mips64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index f482b1e92d..b4296d3c5e 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -123,7 +123,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 
 # These images may be good enough for building tests but not for test builds
 DOCKER_PARTIAL_IMAGES += debian-loongarch-cross
-DOCKER_PARTIAL_IMAGES += debian-mips64-cross
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
 DOCKER_PARTIAL_IMAGES += debian-mips-cross
 DOCKER_PARTIAL_IMAGES += debian-nios2-cross
diff --git a/tests/docker/dockerfiles/debian-mips64-cross.docker b/tests/docker/dockerfiles/debian-mips64-cross.docker
deleted file mode 100644
index ba965cf564..0000000000
--- a/tests/docker/dockerfiles/debian-mips64-cross.docker
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
-        gcc-mips64-linux-gnuabi64 \
-        libc6-dev-mips64-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


