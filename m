Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7539D7DACDA
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:53:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77s-0007bT-CU; Sun, 29 Oct 2023 10:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77o-0007Wd-JA
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77j-00058V-AJ
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso24461015e9.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591042; x=1699195842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNw5GGlG5jDwwccWpxKsbka+eHh936VBHjbQTGFkmKY=;
 b=HNCsj/MTd7p7N5+2DDj27AZ8V8OMurQ/RBOiW/lsQjDQXEgIdEke4t8UjjSLYWaAlS
 C5GZ2mhK3IebrOuU8G715gdlGAPYr1k0xDY2/8sbO0OdFEcLEANxE98kVsKD7tdGkV5U
 xlaiBtEJ0UfNyD+MtPg1l/uTXXvyp/gj/9h6QvkAydruChRAZRhajXLeAPbtNMQCq1gU
 tXNHfzEtK5NJWmuqf5mH/mmw4ZCP05oFl9VvasvGgw2LdGCzxZgAjLwZip324VNQaKou
 l0h2pP+GNvnUregHpUYJbtmV1wEAK5umgORX5QEr8tTgRkgzXsqjB6ICaFJfMefAifP/
 rdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591042; x=1699195842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNw5GGlG5jDwwccWpxKsbka+eHh936VBHjbQTGFkmKY=;
 b=p/1YOCxyFTNRGQmVxKHSCG+B1R3u5ZqdXGMGg8zBWBfCFGDnW6s0Y48DtMrQdQrAij
 NEXn1x5wiGavX5YrMzaQTe8DXjo0+pesV9jlCIhTucVl8AU9gUgadAmGYwrDUxoAEE4h
 j2YOK3tdfHVxfWdlUjvZGZY5Ju2vknysBgpgjx+WX7v1uYwD28ypXCwABoJeYipeA02P
 SWN60e13hxHHqHhilGEdynpFCbVVh4DVMC+sxhxBC9dnAubNeR3zAt44iAaa2NKtzM0L
 Di9Jc70Oet8C7giT3xiFreLeGDuWyMu2dr1WxfvxvkYgxlAyDthPRQkJVk29vvbYF/F6
 r/Sw==
X-Gm-Message-State: AOJu0YykKPnesNE8284x0Cox2FyZAQLviufet9g+qhkVEAV+R9Ck4+wv
 fzUX12ayQm+yt4hKeif6Y+CBlg==
X-Google-Smtp-Source: AGHT+IFRMzxH1kYR5iJdmz2Fvv2QsGV4VkgcRudX6r/MUrwyjGXI/WVLlL1KxT1KHrQ9Re1xYRB0cg==
X-Received: by 2002:a05:600c:4684:b0:409:231e:2a69 with SMTP id
 p4-20020a05600c468400b00409231e2a69mr6062827wmo.28.1698591041926; 
 Sun, 29 Oct 2023 07:50:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 er14-20020a05600c84ce00b004064cd71aa8sm6708969wmb.34.2023.10.29.07.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 738A15F7A4;
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
Subject: [PATCH v2 14/19] tests/docker: use debian-all-test-cross for sparc64
Date: Sun, 29 Oct 2023 14:50:28 +0000
Message-Id: <20231029145033.592566-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
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
Message-Id: <20231028103311.347104-13-alex.bennee@linaro.org>

---
v2
  - s/debian-test-cross/debian-all-test-cross/
---
 configure                                     |  4 ++++
 .gitlab-ci.d/container-cross.yml              |  6 ------
 tests/docker/Makefile.include                 |  1 -
 .../dockerfiles/debian-sparc64-cross.docker   | 19 -------------------
 4 files changed, 4 insertions(+), 26 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docker

diff --git a/configure b/configure
index 20247bc149..0b9d6a8863 100755
--- a/configure
+++ b/configure
@@ -1356,6 +1356,10 @@ probe_target_compiler() {
         container_image=debian-legacy-test-cross
         container_cross_prefix=sh4-linux-gnu-
         ;;
+      sparc64)
+        container_image=debian-all-test-cross
+        container_cross_prefix=sparc64-linux-gnu-
+        ;;
       tricore)
         container_image=debian-tricore-cross
         container_cross_prefix=tricore-
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 98940d0f3b..463ac493ad 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -79,12 +79,6 @@ s390x-debian-cross-container:
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
index dc55ecf001..cd4688bf07 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -124,7 +124,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 # These images may be good enough for building tests but not for test builds
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


