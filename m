Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBD97DA670
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdA-000693-EK; Sat, 28 Oct 2023 06:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd8-00068W-Ly
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd5-00039L-Tt
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40859c466efso22306125e9.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489194; x=1699093994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+21oYDUa6l2DS/PBwo+zu7q5Jbf22dovQxd1uWRyFY=;
 b=sNtcBcn1ku08f9JYBUUU+WIH/c9qrjHTLk7/LwuDfmhrYdFx/5U+LmooqyFzQELsnS
 mDcebz5TYcLmb5remRl8Os1fqlfLapBI6sPy/Zmb9o5UuyG1t4R9Pw/Wgqsv6/BcOIaX
 yGAyaxMUU7eTkhXoW4ctP8hvIvv/OACIbURsOy8EAiAEXpq6dsSbSfg37+J0Sbu42eGf
 1uyi/P6ufNsuD1aIoiFHJEUblD+VRc5kS1G9E6yuFA5n6C7/SpTL4MVHma1pSWFZNFe7
 QsMhp7QlQnluLzGB5SdVBwssy3/rt9wjmpVEaI8KA2vUUGSqX3OI01W40fLfKonU68PE
 PnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489194; x=1699093994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+21oYDUa6l2DS/PBwo+zu7q5Jbf22dovQxd1uWRyFY=;
 b=lNcqHJ1+BzGh7q4B4x/FjlKvHq+XrL+vCsrIJE0oRPDoRi4DvKLzvEvcK2W+2whG8N
 tDVoNSsNTBLux6wwf/tbOrKgnYDzcPsZw/ceTEbDeXlWwWJYChHIu2z/f0tu5dzMpWNk
 NwrmA+D1B7p0VUdcYuFNBF5nuIzREYIey9+zvLs3J/CP/5gRV5hexsoWSbK/pcskpMFa
 YQo8raEVqXbxkPpkDYl1WRg8Zcw7h4lw6DmyDkDqf684lv6Trdl1NAL5vZsgcL5aRXds
 dUm4odtElUQRot8oYABJ1og2+KcRBoQkmrz4vIYZPPw7ceDzL49z6n/D4p31XZccdlwE
 mtUw==
X-Gm-Message-State: AOJu0YxSzf87xDg9WOI2EDzd4T+9UWTiQxCQTSgao8QuIX6nn7VoxrGS
 H9OjB+YkH74GXfhXIWPStGMxiQ==
X-Google-Smtp-Source: AGHT+IFuQXwnaEYmVavdPQABYk4MUD+sfjuGGoJ+ZfJKV5ThH7oXTgWmZaTWMz2vvYzff5I73iKx5A==
X-Received: by 2002:a05:600c:3b1c:b0:405:39c1:a98b with SMTP id
 m28-20020a05600c3b1c00b0040539c1a98bmr4094519wms.20.1698489194637; 
 Sat, 28 Oct 2023 03:33:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 az32-20020a05600c602000b004053e9276easm7270654wmb.32.2023.10.28.03.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 626FB5F79A;
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
Subject: [PATCH 04/17] tests/docker: use debian-legacy-test-cross for alpha
Date: Sat, 28 Oct 2023 11:32:58 +0100
Message-Id: <20231028103311.347104-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
 configure                                     |  5 +++++
 .gitlab-ci.d/container-cross.yml              |  6 ------
 tests/docker/Makefile.include                 |  1 -
 .../dockerfiles/debian-alpha-cross.docker     | 19 -------------------
 4 files changed, 5 insertions(+), 26 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker

diff --git a/configure b/configure
index b4ea78c77d..c8d0d4f7cb 100755
--- a/configure
+++ b/configure
@@ -1281,6 +1281,11 @@ probe_target_compiler() {
         container_cross_prefix=aarch64-linux-gnu-
         container_cross_cc=${container_cross_prefix}gcc
         ;;
+      alpha)
+        container_image=debian-legacy-test-cross
+        container_cross_prefix=alpha-linux-gnu-
+        container_cross_cc=${container_cross_prefix}gcc
+        ;;
       arm)
         # We don't have any bigendian build tools so we only use this for ARM
         container_image=debian-armhf-cross
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 80c540230a..c2394ff001 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -1,9 +1,3 @@
-alpha-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-alpha-cross
-
 amd64-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index ab68b2dbad..25147f0220 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -122,7 +122,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 	$(call debian-toolchain, $@)
 
 # These images may be good enough for building tests but not for test builds
-DOCKER_PARTIAL_IMAGES += debian-alpha-cross
 DOCKER_PARTIAL_IMAGES += debian-powerpc-test-cross
 DOCKER_PARTIAL_IMAGES += debian-hppa-cross
 DOCKER_PARTIAL_IMAGES += debian-loongarch-cross
diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests/docker/dockerfiles/debian-alpha-cross.docker
deleted file mode 100644
index 7fa7bf1bde..0000000000
--- a/tests/docker/dockerfiles/debian-alpha-cross.docker
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
-        gcc-alpha-linux-gnu \
-        libc6.1-dev-alpha-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


