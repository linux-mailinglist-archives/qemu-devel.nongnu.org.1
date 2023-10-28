Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E797DA671
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdG-0006Fr-B9; Sat, 28 Oct 2023 06:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgdD-0006Bn-86
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd6-0003A3-8H
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso16742165e9.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489198; x=1699093998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khcpUjuKXbYxxFjA3ukw68hKA66dopuVKXv6uOwtSmY=;
 b=vQAxeUAozVx5jOdQRpGKKizaQ+GZ7zSu+uCsc+grWeJJNzBYqoiq9fvmc6jS7RiCs6
 9GHJUQHOy/9hsE+th54XWOKTWGi1ahU+c0x8xPxR0lrsFuyZxy+/zM7lal4eO5x+lnow
 VjBWvBxBAcptyACAzsqEGzVLyHsJQaMu2UKyHFc0i0I7ltc+t9w3HgiIuI1hlEPNUgas
 dYfjOOxIZUO+ObOFgZyuSvWlFkHRCp80emt5/kYx7Gg7IBh/KCEF/FXuA7pLTv+mXwbZ
 Ufq9W7N+ZxeoefrkO7Kv0OugWZ5DGm4h0v34MymYBeEfVuaD4VKYyv21jlq/9YrqQ2f4
 Yzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489198; x=1699093998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khcpUjuKXbYxxFjA3ukw68hKA66dopuVKXv6uOwtSmY=;
 b=Aq/YtlyHn8KlzWXXheFhN41jxN6ObVnlsVxiiWP2KtJx/v0jhLOg7wwrET5Qfj8+qm
 x3hHRyKpvyXgvD9hFcCE15C7Zse66K/4b6E5Mn9aONVyANAU+G4+KMkUn1TX4Ne7P6Er
 +ts0w8SeqM61xWPyyww86FCtZ75OA5CnNn8mCCrt2Okev4Xjv9iEqYkwQdw0G9hVYFbv
 3fLAxONjunWQUqLXTALw4dYu9jEPQBK3YA3vnuPbcoptMkvbDJFYh8W/OEseV677Tmpb
 TAlDfLzKIUgKv3jaUQNS9FbnSlXVyj4tJMUmLQz7he3ealXwu9A+/zjIjCMSBUEsRsjI
 IONQ==
X-Gm-Message-State: AOJu0YyNYXPXFCQ6nUjivHBWXxLGN7mu6x9lJzLzp2C1StsVXqctwFGv
 Nre44UaKLFdm08p6CJn0Qfra4w==
X-Google-Smtp-Source: AGHT+IHyeLXLxfiCfxfmub+zVsiw/qc6TnYX0QPuPXhTCFlSKSGOXQrZV/FuVSyZjOhqktKj420vSA==
X-Received: by 2002:a05:600c:3b9a:b0:401:b92f:eec5 with SMTP id
 n26-20020a05600c3b9a00b00401b92feec5mr9092107wms.9.1698489197941; 
 Sat, 28 Oct 2023 03:33:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h9-20020adfe989000000b003271be8440csm3548603wrm.101.2023.10.28.03.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 05B3B5F797;
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
Subject: [PATCH 10/17] tests/docker: use debian-all-test-cross for mips
Date: Sat, 28 Oct 2023 11:33:04 +0100
Message-Id: <20231028103311.347104-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
 configure                                     |  4 ++++
 .gitlab-ci.d/container-cross.yml              |  6 ------
 tests/docker/Makefile.include                 |  1 -
 .../dockerfiles/debian-mips-cross.docker      | 19 -------------------
 4 files changed, 4 insertions(+), 26 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-mips-cross.docker

diff --git a/configure b/configure
index 2bcbf0fc36..2d8c7a0312 100755
--- a/configure
+++ b/configure
@@ -1330,6 +1330,10 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=mips64-linux-gnuabi64-
         ;;
+      mips)
+        container_image=debian-all-test-cross
+        container_cross_prefix=mips-linux-gnu-
+        ;;
       nios2)
         container_image=debian-nios2-cross
         container_cross_prefix=nios2-linux-gnu-
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index f863a14664..0b48bf0172 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -46,12 +46,6 @@ mips64el-debian-cross-container:
   variables:
     NAME: debian-mips64el-cross
 
-mips-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-mips-cross
-
 mipsel-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index b4296d3c5e..04ac5f9c79 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -124,7 +124,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 # These images may be good enough for building tests but not for test builds
 DOCKER_PARTIAL_IMAGES += debian-loongarch-cross
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
-DOCKER_PARTIAL_IMAGES += debian-mips-cross
 DOCKER_PARTIAL_IMAGES += debian-nios2-cross
 DOCKER_PARTIAL_IMAGES += debian-riscv64-test-cross
 DOCKER_PARTIAL_IMAGES += debian-sparc64-cross
diff --git a/tests/docker/dockerfiles/debian-mips-cross.docker b/tests/docker/dockerfiles/debian-mips-cross.docker
deleted file mode 100644
index 2cbc568ed1..0000000000
--- a/tests/docker/dockerfiles/debian-mips-cross.docker
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# Docker mips cross-compiler target
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
-            gcc-mips-linux-gnu \
-            libc6-dev-mips-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


