Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 097AF7DACCF
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:52:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77v-0007dr-2y; Sun, 29 Oct 2023 10:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77o-0007X9-SE
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77j-00058l-I2
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-408425c7c10so29083225e9.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591042; x=1699195842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8nyizU8hixlWhc4xGz5/y+Ubdw17kvMQCfwhN7bWy0=;
 b=yz8S2+bH7FzemQGZ9NmyrMd89v9xR7Y1IewFgnEIp/55AKy/jkW1Ik25H7KRzA2Uys
 23zD48RzceL9h5ZRZGuWFRuqamoHVcV1NVqJ+1cpfedOdxJUW7raMlhYypT4IX2w8K5g
 AOtYGxCs1us678hLQAQSsSufB4HxSZrDlZJcyHF721IlRmsnIPMOSkeJIqwYWhAqcjts
 UF+1lzcb1xJLy9DJ1w/EfdHkLUgzZx8NKUaAd+YOWPy5cWB/u2oDTS0BUrlfkk61bUEh
 OsrZbuCbdXiPuvrs9Mz8FLL1EXvNDRrY2KL3N6BGl1aAwdH1fzGjEfKiJlBmKmlkbNZm
 WMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591042; x=1699195842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8nyizU8hixlWhc4xGz5/y+Ubdw17kvMQCfwhN7bWy0=;
 b=gw0TZOUrXNoCFrfmSi7sdUlIGAS/yorXXWmLWcv9Hy6ezN6dsMxIYLjJNjIqZyhqH+
 Lj170m5LFrYo+Fp4/pkt71ka8ysM81qfK6fzbwCvErwGhF7Wov1mDBaD39VJBh77LNh7
 eZxLKMtdVSgt6XBAaDoL0VhjKAcPRiEBX+MavQUbIQg1MIjVn+CgAgJ3OBGhmsEoVc/x
 I/9wW34SWnfwb4rDvunKop/gX3nJiJlixetCnx11CohD7gO7S21n3UnDYfJzrSzDmxmT
 bTaVX5jg4JWYFBy/1YiPOuXWv/EBUDUuoa2oYEhSPgWsNiU11T57rVNY4gxA5dnysS2i
 dykw==
X-Gm-Message-State: AOJu0YxNXk9Z3yTYYTzzPTRTikQWuDy3fFP8FGL8ym5mGO4I+mlNVZj9
 TCExBEYWqrpymoes9WzT9+VbOg==
X-Google-Smtp-Source: AGHT+IEgfSzfYO6vDZgImbyiYcCqtRn8Ym9w+WqzryGpLati+NYCe2rW8ZSmgkniwzvZwhU46owxEg==
X-Received: by 2002:a05:600c:4f92:b0:408:543d:5532 with SMTP id
 n18-20020a05600c4f9200b00408543d5532mr6666341wmq.31.1698591042330; 
 Sun, 29 Oct 2023 07:50:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v3-20020a05600c428300b0040596352951sm10062546wmc.5.2023.10.29.07.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5A59D656E5;
 Sun, 29 Oct 2023 14:50:35 +0000 (GMT)
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
Subject: [PATCH v2 13/19] tests/docker: use debian-all-test-cross for riscv64
Date: Sun, 29 Oct 2023 14:50:27 +0000
Message-Id: <20231029145033.592566-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
Message-Id: <20231028103311.347104-12-alex.bennee@linaro.org>
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


