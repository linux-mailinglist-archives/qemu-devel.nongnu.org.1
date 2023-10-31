Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C427DCF95
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:48:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpya-0004r5-Ux; Tue, 31 Oct 2023 10:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyY-0004os-0C
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:14 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyW-0002Ah-88
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:13 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32dc918d454so3656545f8f.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763451; x=1699368251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNAPZGi/6P6pcPJMsH3EA8QH82A+OUjUKwQzzU5zh3E=;
 b=nYaRJMdniZtAkS6mT50SX9z9XLazprI9DFLc6IB/NxB6mcInXKtS67DOhRmOEy/+zn
 lN1syDL+1xuqTkyE11e/jt2Uso0XTvqw/7JC6WtDkghM4Jt6dAYZrLUStbwQQkPr+ZSu
 5CYzYY/+8hLyPAgrp0YywKV5mJ0fzjPw9klT0rtF9HYRsfpVck/UyJdkDAp0YBhnLZwr
 8txx2WW9Pxhq7pIMr4CyHKV5apelC/udQwj2OFDJLyDeM85Ai3QL8JNMMatxLZs6eV+l
 FypaEO+4aBNcVm0MEgDiIdj2Ck2x9TMw8TkpcLyvrAXm+NfgvQ1mdiiv25Izwkyzpx4H
 ADYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763451; x=1699368251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FNAPZGi/6P6pcPJMsH3EA8QH82A+OUjUKwQzzU5zh3E=;
 b=gf2c5AcwnJbPZo59WovZyGJhNnVXiSlPGMYkIxPPLvPasJ+F9drZXbcLQuUhCdIt3n
 atRApkMrKEYB+kxgJJZFaQ5stm6lqTm0oAE+rQvLYwJLyimdX2olXxob5POxtH+rszTc
 oktelrJpc7Pl8Ew09Poal7QbKjVaJxS/bMaEsN7hXJNxA2hCeSYAJWjenp4Y8EqT5FQF
 EsGH2gIjkC1jW5jSDpucTjF7EGpjXByrK3zB9KHql4llwh3SByWhImxX3WzF5Y57wbZ5
 +60MFXv5iDfLeH4jJFNnQ82iIIt4MqeAFbL2uWHKaPv6m3PrBye2+WxvzBc5lpFcwZmT
 GNfg==
X-Gm-Message-State: AOJu0YyY3FP+lIZiC8rJ/0Cp3NfJos2RLEE3lIRqiJTwQwTFfgLKwgLo
 iKsEbnWGFC5/VI0eMPMxthh623VkxgY/6INVHjI=
X-Google-Smtp-Source: AGHT+IEaQIw6fLHHwy6xRzgaoWhdSY45TlA3orsBk7dVl39fd+LBiD/wixNxFMJOS6HYT2O9tOW6RA==
X-Received: by 2002:a5d:6a85:0:b0:32f:7ebc:cf71 with SMTP id
 s5-20020a5d6a85000000b0032f7ebccf71mr5524422wru.1.1698763450853; 
 Tue, 31 Oct 2023 07:44:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l12-20020adffe8c000000b0030647449730sm1652141wrr.74.2023.10.31.07.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 144C96572D;
 Tue, 31 Oct 2023 14:44:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 13/19] tests/docker: use debian-all-test-cross for riscv64
Date: Tue, 31 Oct 2023 14:43:55 +0000
Message-Id: <20231031144401.1238210-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Maintaining two sets of containers for test building is silly. While
it makes sense for the QEMU cross-compile targets to have their own
fat containers built by lcitool we might as well merge the other
random debian based compilers into the same one used on gitlab.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231029145033.592566-14-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 791c48c4e4..0e0f0c60b5 100755
--- a/configure
+++ b/configure
@@ -1347,6 +1347,10 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         ;;
+      riscv64)
+        container_image=debian-all-test-cross
+        container_cross_prefix=riscv64-linux-gnu-
+        ;;
       sh4)
         container_image=debian-legacy-test-cross
         container_cross_prefix=sh4-linux-gnu-
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 053330d6f4..98940d0f3b 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -73,13 +73,6 @@ riscv64-debian-cross-container:
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
index dfa9617bb9..dc55ecf001 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -124,7 +124,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 # These images may be good enough for building tests but not for test builds
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


