Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 083A77DACDB
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:53:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77t-0007cR-4N; Sun, 29 Oct 2023 10:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77n-0007Up-3c
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77i-00057u-4o
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4084b0223ccso28665835e9.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591041; x=1699195841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGe9/RdkKEwfxEpscY//8qq4WIHN5v1YsW52fWPOhUE=;
 b=M2QmmXc+cL1JMD4O5wz5mmQV+++RFdHNuCXbF+Ja3c3ejOk1co+qRev4ZacK/nSknv
 l3qSZwDkv7UrMT+s9hfxbuNuBK4GzCWjBEKxINhIEHmZkSOC/DayYTd3tLg9tCUq5qOd
 WAg0gDjGgBOWy9cUTZYpS0onwIOUVup4Y9KoO3BkLSKuT0YzrNmsyXAWtUzx7Xw5kxnL
 QVi0VtjyygctNz9zU/WsWU3I67uAH3j+7Hsq4mW9nb6tSxg3BIt+uAeUGQMYqlBo3Ep7
 z8fvJXOSz9bT5+MohUf2W///T8w6cc7YmFJd431dUFQhP3GUctOMcQW5xP83QprtPdaE
 /gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591041; x=1699195841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGe9/RdkKEwfxEpscY//8qq4WIHN5v1YsW52fWPOhUE=;
 b=kAP5yga+PoPSHmSI2aRNprgvDhSbPEhKiiYjAI0Cw+BzJSXGqamLJCXKYYJm22jGB8
 wHy7EoGzvZgwoaS/LlOVsghdaJ3PYbO4kzlBEq+lpEvXVNS0RLCcG1x7sKNUfPPobfbY
 H6ExW72KDs0lNTbdqnqt/BYdxvmDwUDFoS7t0yJ/zQR54LsUBksccG7+Lq23kBaCtsG2
 M+nI3m+toKmIkQUntphXcYsrpIi46e3WFkeojJ4tp5rsLnfOfAV3FY7topZmaeINgaW4
 edwsQXwDnh3OaQ7EKhDpiK/RYpLsa87WFtUb19RN94oobs5jewEEEHrFtvbWMFQcucxf
 Mk2Q==
X-Gm-Message-State: AOJu0YzgzyNg3bIhdmnqACOOB2xsGgk8VpGwzRGfKSsncCTrqjK0wiRS
 TbxsUnW2DZZBOG1oQbJ/OdExnA==
X-Google-Smtp-Source: AGHT+IFk5/WfybKguOj3tdPbkz0isYgTeWp0VgL6Gm9KF67LPjGw5M7NCkT6qP1j6YcB02jDOqXZ9Q==
X-Received: by 2002:a05:600c:19cc:b0:406:8494:f684 with SMTP id
 u12-20020a05600c19cc00b004068494f684mr5691589wmq.23.1698591040561; 
 Sun, 29 Oct 2023 07:50:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j15-20020a05600c130f00b003fbe4cecc3bsm10080311wmf.16.2023.10.29.07.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 427B0656E3;
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
Subject: [PATCH v2 12/19] tests/docker: use debian-all-test-cross for mips
Date: Sun, 29 Oct 2023 14:50:26 +0000
Message-Id: <20231029145033.592566-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231028103311.347104-11-alex.bennee@linaro.org>
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
index df5eb3ccb6..053330d6f4 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -52,12 +52,6 @@ mips64el-debian-cross-container:
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
index 5831744a39..dfa9617bb9 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -123,7 +123,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 
 # These images may be good enough for building tests but not for test builds
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


