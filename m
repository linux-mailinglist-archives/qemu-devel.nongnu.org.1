Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E087DACDF
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:53:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77n-0007Un-M2; Sun, 29 Oct 2023 10:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77i-0007QV-NQ
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77f-00056L-6J
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-408425c7c10so29082905e9.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591037; x=1699195837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8g/FbTw3THTTUQ2gaTYnZE7pK1Vxfzs6kl2uSd8zVl0=;
 b=J0WPVcGVeTkADfqomhuaVMEXh1e5Wg7/AHt8nSd0Tx9WSms/ZcnhviELcBH1iL6bUW
 +PY883OfIM5sDhrmsaMLyxRaJr4IjC3k/6ncjRbLJtvZbjU8RN6wjj18j8r7phonvqVy
 aIsBIERATdUMYNjCfpcL6hP/fsIaFC6ZyRAuVlEmnwtEd5P2ot5nw2v+eMg2Hv/Ir0tE
 6nVoUEFEkFoYhYEg2nK0oHqP9vDu6exyaJ+p8Zq8osR7uuBXeipeMSKFXwwBuRHiL/gB
 VmhEdsLZtkOjvzYSzBPexwFXMazAshd3x8kTy90cDn7dY0bH36J8NckM7qTtasQfMIdD
 2/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591037; x=1699195837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8g/FbTw3THTTUQ2gaTYnZE7pK1Vxfzs6kl2uSd8zVl0=;
 b=oxpdHLals6jbrsiz+o3+gsFRQOKn4xDe04yAfwIdfOwihSSpcM7oiX2lW7ef8DF1sC
 /P1cFw0vM6cc7imHmZOPmq3T3endZ69QEc0yWAAIU124PxrOENz3lQge785eWN5d4xnj
 JndkLgvY1R228n0EHrEYd7eP1PdBMXdn8SjZYgdLz8n85fx04+7w0rxr2YyuetABWQwS
 0RWGfkV6n45+G4slX1e7vyJjBTcrbZdB1wcTU0Mv8/WPUMa2+KgfZ0mEGEEBOjva46XQ
 tuvnUdDGqFsO4BhueLhk8Vpn7VX+M8xRQA92iowevued1aS8xKqYlSVac18QQnQ6BcMM
 OlgA==
X-Gm-Message-State: AOJu0Yxzom1kORTd9wX5Tyjmyhh27IYV28SKNr8zPOiJOrJYKQObzuU5
 nqAgqySRxBQlvBlGsT0xxsCeig==
X-Google-Smtp-Source: AGHT+IE1r/5isl9DOm5XybR/JYsn52f9v7q06PRgiqW/anw1vtGI40UK0YuzyzVS7isTASLn6sF89w==
X-Received: by 2002:a05:600c:4e94:b0:408:febf:831f with SMTP id
 f20-20020a05600c4e9400b00408febf831fmr6032418wmq.28.1698591037579; 
 Sun, 29 Oct 2023 07:50:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t13-20020a5d534d000000b0032d9548240fsm6116589wrv.82.2023.10.29.07.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D303E655DF;
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
Subject: [PATCH v2 08/19] tests/docker: use debian-all-test-cross for power
Date: Sun, 29 Oct 2023 14:50:22 +0000
Message-Id: <20231029145033.592566-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231028103311.347104-7-alex.bennee@linaro.org>
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
index 3e6d741f62..a1dac0a45f 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -82,12 +82,6 @@ mipsel-debian-cross-container:
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
index f61d97102f..82e06d84b3 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -122,7 +122,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 	$(call debian-toolchain, $@)
 
 # These images may be good enough for building tests but not for test builds
-DOCKER_PARTIAL_IMAGES += debian-powerpc-test-cross
 DOCKER_PARTIAL_IMAGES += debian-hppa-cross
 DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
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


