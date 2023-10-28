Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E07DA679
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:36:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdR-0006Nj-JV; Sat, 28 Oct 2023 06:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgdI-0006JL-Fd
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd8-0003B0-9r
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so23576125e9.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489201; x=1699094001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GuhB1oqrltzwGhGUiDD3Wy/LeTIaPHbJQgIVwBu8Ch0=;
 b=VvXpSrTpSvPgo1lHLuWivamJq46OJNsqkeEtY5HLSl2icKr6qk95ODb8FIGiChRbIu
 mkdYC0dF71lKOtrG54OIs0RyryvpxB6F21LuaC1V+Emjp5HkwKEvv4zMrjQ+qlHhNCwZ
 3Y0pVg0KscDsu/pDeoOgTyo+dKR4o5BFkFxZi/jMJlr4dGUEGcyDLvwRmXZ0wdhax8p1
 yqBUDcWysoImeK9vbEclnRb3xx2bYqE5/uLqQDzOrxPNQ/GXjhwCfatcClAbOA2to4Sj
 uG/gh1fmQUqtPQYQTVb0SvePwXYXVxv8oATJniitgkZcRjVdUYMJ1nnvuk1oe7GYd5tL
 sPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489201; x=1699094001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GuhB1oqrltzwGhGUiDD3Wy/LeTIaPHbJQgIVwBu8Ch0=;
 b=UZ4hdo+i2pwgQ/pbVgXlVl+WaxwFtOXJx6AfvC7IBFslO4TP60hZAGReycdxEr5Vez
 fTGdXg0IGXqcSszOpf2qCEVklqX2D9YKGqccot1m3pxGKdFR+/FUt+thGuool8ZAmnsp
 /OFncMCwqn6yNnSUcHK4mB1+pnP34t17T8/SxPGMKgnbMtThXQENQR2UgRepijSnBC27
 Bup6ejNXjY8PTKfOTO6jHh870Em7xa0Oi3aG7FWkywM1lXBNCn8IA8AEcoSIgO4oSXNQ
 BMKdNF3VttyswVOQEuB1auVGGcds2YQKiKQQkDeAVg4d/J8ECKQB+PcTkNRSruCcRHTB
 MdmQ==
X-Gm-Message-State: AOJu0Yy2XIwBFBrDGpY51VAQ1d10VW+IZbPVmMuVa+4WF3dgF6i86U0N
 4r3GnvIvBXvpsHB7LlSqm4heNw==
X-Google-Smtp-Source: AGHT+IHirquYuEzAGbzAF18v1CcM1zcHn5LJarzOyZl+/yJchyYHC3Yw2USnOjhpkPN64V1HqcHHmA==
X-Received: by 2002:adf:e548:0:b0:32d:8830:ee2 with SMTP id
 z8-20020adfe548000000b0032d88300ee2mr3609444wrm.43.1698489200940; 
 Sat, 28 Oct 2023 03:33:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h8-20020a056000000800b0032dbf6bf7a2sm3578110wrx.97.2023.10.28.03.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 364F85F7A2;
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
Subject: [PATCH 12/17] tests/docker: use debian-all-test-cross for sparc64
Date: Sat, 28 Oct 2023 11:33:06 +0100
Message-Id: <20231028103311.347104-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
 .../dockerfiles/debian-sparc64-cross.docker   | 19 -------------------
 4 files changed, 4 insertions(+), 26 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docker

diff --git a/configure b/configure
index 20247bc149..7854451913 100755
--- a/configure
+++ b/configure
@@ -1356,6 +1356,10 @@ probe_target_compiler() {
         container_image=debian-legacy-test-cross
         container_cross_prefix=sh4-linux-gnu-
         ;;
+      sparc64)
+        container_image=debian-test-cross
+        container_cross_prefix=sparc64-linux-gnu-
+        ;;
       tricore)
         container_image=debian-tricore-cross
         container_cross_prefix=tricore-
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 1436ef8784..d27e041132 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -73,12 +73,6 @@ s390x-debian-cross-container:
   variables:
     NAME: debian-s390x-cross
 
-sparc64-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-sparc64-cross
-
 tricore-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 0e8133109d..a490d4debd 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -125,7 +125,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 DOCKER_PARTIAL_IMAGES += debian-loongarch-cross
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
 DOCKER_PARTIAL_IMAGES += debian-nios2-cross
-DOCKER_PARTIAL_IMAGES += debian-sparc64-cross
 DOCKER_PARTIAL_IMAGES += debian-xtensa-cross
 DOCKER_PARTIAL_IMAGES += fedora-cris-cross
 
diff --git a/tests/docker/dockerfiles/debian-sparc64-cross.docker b/tests/docker/dockerfiles/debian-sparc64-cross.docker
deleted file mode 100644
index 1ef735f223..0000000000
--- a/tests/docker/dockerfiles/debian-sparc64-cross.docker
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
-        gcc-sparc64-linux-gnu \
-        libc6-dev-sparc64-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


