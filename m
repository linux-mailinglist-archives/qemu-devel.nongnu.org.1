Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E36E7DA67A
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdD-0006C5-UX; Sat, 28 Oct 2023 06:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgdA-000699-1d
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:24 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd5-00039m-Tr
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:23 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c50ec238aeso40622541fa.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489196; x=1699093996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVrvJytMOgZkGMhe/n/Zc67wTMwGK+JIiWzg5lM004g=;
 b=FMTBWw5JsqIg5OwoAZ/ljlwelyOBKa4rK5BZpOYI+jvuVdpvfFJSu0MTnmj0Ws6kHR
 vS8MgzOg2tJuI7nPHaTlPoSTeN33Pn7o352Q9lSVqV3XHxpEW09y2Y8PDUY+naYgzMND
 irsPYHE4L7uYy3oc6LX3Vt2awxE08GQLZjxtma+gu68EYod9EcrtOf9mmDu3MsNBUIXI
 VTpkcBJq7Vqu/6UmrZ/li5eCjvEGG8e9H6b0n6juDYFN4rzlRBQF6NDRoUS2LddrkEJ9
 SH3wxSoR3MWwC48QVK7ov/VTg+MSuiFKkIVTHuT1hxTVp3yY2zjQSTxDKmLHaP8SYclC
 KVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489196; x=1699093996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UVrvJytMOgZkGMhe/n/Zc67wTMwGK+JIiWzg5lM004g=;
 b=HDaQNAtzMy3CZFUSj/VuFPAx1ZGN+YnNJVpe/9166asS3rsFHAjghRrPS6/qU2SOtV
 DWX8bsGmNCGfZ7eGGmNXa7EVA4M91n1hs7i7D6TJvhHDGIOEQGbMQi1KP1M87BZp0Yti
 Q3DJiAWF0kGX7VFzGCmQMzCaazuXI4tBUpooWhwWXCIw70EsYSUMZXNsKq2ooSN63cQi
 bEEQle9iKLtbaoBwVgdqFCUN2yTxWxwpOpDUypMK+GfR+QE7vAleonSRbyrx8gAyAtj1
 HPidDKx+Oeux9afSdPwK7P3KpW/qikSj0EolwSPKbb6bCjx/hpRTMxR+5AfK1un3Exao
 +mHg==
X-Gm-Message-State: AOJu0YzuV5JuR6Fv5MeeZWP07PpxQpyR1/eAA/EZg1Q2JyW9VCwiavRH
 CPNAyHqAdxzB9VXagMDNEi603g==
X-Google-Smtp-Source: AGHT+IEsct5ke+XB2OlYcqotBFTvS8EuCPVW2a7o8NpU+vhCyHPq/y9FC4REYsgGvtTYQHPkhApt8A==
X-Received: by 2002:a2e:9a86:0:b0:2bd:180d:67b1 with SMTP id
 p6-20020a2e9a86000000b002bd180d67b1mr3908833lji.51.1698489196532; 
 Sat, 28 Oct 2023 03:33:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m9-20020adfe949000000b0032196c508e3sm3582913wrn.53.2023.10.28.03.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AE4D45F79F;
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
Subject: [PATCH 07/17] tests/docker: use debian-all-test-cross for hppa
Date: Sat, 28 Oct 2023 11:33:01 +0100
Message-Id: <20231028103311.347104-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x230.google.com
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
 configure                                     |  5 +++++
 .gitlab-ci.d/container-cross.yml              |  6 ------
 tests/docker/Makefile.include                 |  1 -
 .../dockerfiles/debian-hppa-cross.docker      | 19 -------------------
 4 files changed, 5 insertions(+), 26 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-hppa-cross.docker

diff --git a/configure b/configure
index 8707bd2e78..0a755c71a0 100755
--- a/configure
+++ b/configure
@@ -1300,6 +1300,11 @@ probe_target_compiler() {
         container_cross_prefix=hexagon-unknown-linux-musl-
         container_cross_cc=${container_cross_prefix}clang
         ;;
+      hppa)
+        container_image=debian-all-test-cross
+        container_cross_prefix=hppa-linux-gnu-
+        container_cross_cc=${container_cross_prefix}gcc
+        ;;
       i386)
         container_image=fedora-i386-cross
         container_cross_prefix=
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index ec56990bc5..5f8616c0fd 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -40,12 +40,6 @@ hexagon-cross-container:
   variables:
     NAME: debian-hexagon-cross
 
-hppa-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-hppa-cross
-
 m68k-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 356986d687..b701f1225a 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -122,7 +122,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 	$(call debian-toolchain, $@)
 
 # These images may be good enough for building tests but not for test builds
-DOCKER_PARTIAL_IMAGES += debian-hppa-cross
 DOCKER_PARTIAL_IMAGES += debian-loongarch-cross
 DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
diff --git a/tests/docker/dockerfiles/debian-hppa-cross.docker b/tests/docker/dockerfiles/debian-hppa-cross.docker
deleted file mode 100644
index dd47ffdfa4..0000000000
--- a/tests/docker/dockerfiles/debian-hppa-cross.docker
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
-        gcc-hppa-linux-gnu \
-        libc6-dev-hppa-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


