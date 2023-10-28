Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F967DA672
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:35:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdG-0006FB-4t; Sat, 28 Oct 2023 06:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgdD-0006Cf-QH
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd6-00039h-84
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083cd39188so21017365e9.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489196; x=1699093996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnBzYhuqOhbZhlE8bzDSd1Z6QjUEt19/nYehqVxmF20=;
 b=Kyuk3LYy1OrazNOYvgm1NBlNCx+nSpGrAhrhsN0tVSRqNvJp6KXlRqDYIWr0SeTuvx
 uFQuAGoFrK+i19vJiMYcaFZMVylgw3167zokAYKcT//4swVlADRqAuvkhdNH3yq4c7XY
 Ro1/DHPy47/3wsJNM5c80ZyAomHpileH4U3E007bBPns3NJm7hWsKnVeasQTO0bitVf4
 ABCsaSWcHVwC5UlHqVZ+fPU7ImruyLwDMnnAGpvCX25QWMVXimll0P461TObMlMfV28+
 T1VaBBwyCjGvMze/yvdbaMbnvjN6cpWZyCP20hpNrZX75ox9nWG2gTMGgWeYI2QKY/vm
 iZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489196; x=1699093996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnBzYhuqOhbZhlE8bzDSd1Z6QjUEt19/nYehqVxmF20=;
 b=wFejjEk9F6xC2L793kQrautIShyzn4EsavQg7IJAQbwPKVxzHc8A7U/pdt/7Inssh2
 MGy0NPH59SX3XaSN3JvZsbzezYgtcBGc9A9acwpiAV/eCdXwuOWkf533UAPmghaSeR9w
 ye+smKUOW9ZEkdXC6dIoSWy/Oar8r+44w8XGnkOA5b9ogBiteisr6x0fuupmKaaKf4kh
 N7O7vtdY+ITw2BAQV3/Z0uUybe6b1KFl4GFCJRcTDLXv2qx0X9JteH0DR7c2msj0tbmY
 6Ov6oDdcQEcwURSVcn+PTrle+D78Nk7/NAhffR7dM8yWom6KgjaSuNazjbB0qyVnKc//
 PQ0w==
X-Gm-Message-State: AOJu0YyJGDtLxjBsQq8VtF1S2gjDX2Q5U81gY9q0SMQBje6sjlmxABV4
 k+dic3XZNtNwFRTimNnXgxnWZQ==
X-Google-Smtp-Source: AGHT+IF9G83xkZhVkHGqPgsm9M03KC0JeN72SYdREanJ6K221wcC4o+NatIupwWRus17+XwBmHd/mA==
X-Received: by 2002:a5d:598c:0:b0:32d:ad8b:2a04 with SMTP id
 n12-20020a5d598c000000b0032dad8b2a04mr4900418wri.14.1698489196281; 
 Sat, 28 Oct 2023 03:33:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bq22-20020a5d5a16000000b0032f7865a4c7sm1548316wrb.21.2023.10.28.03.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C6CF15F7A0;
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
Subject: [PATCH 08/17] tests/docker: use debian-all-test-cross for m68k
Date: Sat, 28 Oct 2023 11:33:02 +0100
Message-Id: <20231028103311.347104-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
index 5f8616c0fd..cf2fcaa59e 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -40,12 +40,6 @@ hexagon-cross-container:
   variables:
     NAME: debian-hexagon-cross
 
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
index b701f1225a..f482b1e92d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -123,7 +123,7 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 
 # These images may be good enough for building tests but not for test builds
 DOCKER_PARTIAL_IMAGES += debian-loongarch-cross
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


