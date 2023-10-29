Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8917DACD5
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:52:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77q-0007ZD-QO; Sun, 29 Oct 2023 10:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77l-0007Sq-Ka
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77g-000574-OB
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:45 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso27951095e9.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591039; x=1699195839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyn6lZ7zdK8+M8KYI/JcH/vwPlYYMZ6sIbDMrPrCipY=;
 b=zkXiJV3MSvZe3cDjA7n1Q4sAfl8IFPM+iO5rfW7j8XEPiL4kwXDlDS9clJtFou8rbA
 pAz2GBY+ncsKzQ/PomDV2ql7IwCjhi24GGLacn4tk3dPRDLDMKhwbkzI2K7yJ0kvPPCG
 uSs46f4/utlMokk0sY3XBRJxwLG0wGfBiMGfy1BEVkzSTQmAdopbYeVzhNfObPdJHwA6
 JZoRhC4tx5C4/WpI2BQVg8fzW8tx6t9rql+n6oM8koLupjeFetjugsQUplqGbYDUSHtT
 tnWU39VVF+cKenIO1ZLU2MagPaLz+gFf7zigg87ULc/qzp0Z+HLyiq1Upeeslt+6WgFE
 MrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591039; x=1699195839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyn6lZ7zdK8+M8KYI/JcH/vwPlYYMZ6sIbDMrPrCipY=;
 b=p3f85W0piX1RagMYAQuGZAHsoLcRERCQH2GFut5vytxT1h522z3EZCEuvQUrRY/tzI
 GiviFFfV5hb+aXP6QPECw8aBaDV1bfJZP1buapgLYkHl+qMArS8nE9BzHJubrz8vM9TC
 c+jXU30DelyfrRhntcssWW1mqTJFVCO16GVOyG05CePXbLOuFZc3F0ZPap6jVLctG4e1
 +7Qxc5yOeJVtase0d8QzcEFblyCUmcMajl2+CJS6OMBa5N/aSX7fy0hXBaAK9jJIjZjR
 wkDn191cF338KpXjnSJ+fK2ddmnC6e5lj+zhQ+L3AfHG9ta+/A5grWP/oUhUFPl3e/Hk
 AwTw==
X-Gm-Message-State: AOJu0YzOEPGihJkDbQoxnAXFJ6o1H/ur8RpaBelVUz+0b+CwkEpXgJA8
 AiaZ4Gi8la8x+Zd2hScGaFxUXA==
X-Google-Smtp-Source: AGHT+IE0nnH1ryPWeivEHxboBv8VmCa9P7/U2mxZQJJxfZNJ9DwptUEJYUr1aisb8sU1epCtWhI02A==
X-Received: by 2002:a05:600c:2353:b0:405:2d23:16d9 with SMTP id
 19-20020a05600c235300b004052d2316d9mr6707868wmq.21.1698591039338; 
 Sun, 29 Oct 2023 07:50:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l12-20020adfe9cc000000b003232380ffd7sm6102862wrn.102.2023.10.29.07.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E425656D9;
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
Subject: [PATCH v2 10/19] tests/docker: use debian-all-test-cross for m68k
Date: Sun, 29 Oct 2023 14:50:24 +0000
Message-Id: <20231029145033.592566-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
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
Message-Id: <20231028103311.347104-9-alex.bennee@linaro.org>
---
 configure                                     |  5 +++++
 .gitlab-ci.d/container-cross.yml              |  6 ------
 tests/docker/Makefile.include                 |  2 +-
 .../dockerfiles/debian-m68k-cross.docker      | 19 -------------------
 4 files changed, 6 insertions(+), 26 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-m68k-cross.docker

diff --git a/configure b/configure
index 0a755c71a0..c7c811fb02 100755
--- a/configure
+++ b/configure
@@ -1313,6 +1313,11 @@ probe_target_compiler() {
         container_image=debian-loongarch-cross
         container_cross_prefix=loongarch64-unknown-linux-gnu-
         ;;
+      m68k)
+        container_image=debian-all-test-cross
+        container_cross_prefix=m68k-linux-gnu-
+        container_cross_cc=${container_cross_prefix}gcc
+        ;;
       microblaze)
         container_image=debian-microblaze-cross
         container_cross_prefix=microblaze-linux-musl-
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 66b8844246..d42d89b26e 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -46,12 +46,6 @@ loongarch-debian-cross-container:
   variables:
     NAME: debian-loongarch-cross
 
-m68k-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-m68k-cross
-
 mips64-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 47e58a248e..fb93eca537 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -122,7 +122,7 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 	$(call debian-toolchain, $@)
 
 # These images may be good enough for building tests but not for test builds
-DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
+DOCKER_PARTIAL_IMAGES += debian-mips64-cross
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
 DOCKER_PARTIAL_IMAGES += debian-mips-cross
 DOCKER_PARTIAL_IMAGES += debian-nios2-cross
diff --git a/tests/docker/dockerfiles/debian-m68k-cross.docker b/tests/docker/dockerfiles/debian-m68k-cross.docker
deleted file mode 100644
index 25dd1c1e68..0000000000
--- a/tests/docker/dockerfiles/debian-m68k-cross.docker
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
-        gcc-m68k-linux-gnu \
-        libc6-dev-m68k-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


