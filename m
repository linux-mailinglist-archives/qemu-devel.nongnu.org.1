Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 261957DACD3
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:52:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77q-0007Xt-1R; Sun, 29 Oct 2023 10:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77n-0007Uw-Dc
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:47 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77i-00057s-6U
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:47 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32f78dcf036so693506f8f.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591041; x=1699195841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifnDTC7wfj+PooeFzDEu5s54tBM3Ed0ClHgMpWiJrQ0=;
 b=jwvzdYbm1cldryOPHKujyxNQmRGVgiv0x3HrWCeuoAeKZ83IWuSKuA3ResSO8j/W7k
 ECcoHQbCGPe431F4TVAU6/+n+moXw6HSRWL1j8dC04De2fsWhKxg1ED/v01A+liUvUjC
 mIelt+j4WuOA09SwznZ5O35cymNMgqqxQ4ijQ8HVO+aVxjlrzBggoOtBFmgzZnchCwvw
 NvjMHCsHNXQCg5k6gsK3xxeKEu+VQBi5eRkmMEpuhUpy60a2cekEUp5rOoBHm2BxrEPh
 Rf6xSA45Q4+e25j3WB1/hNQObQYV43JvO7zZR1/h+xyh+bbRSLWAFDz1UDUwcWebqJaE
 Hebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591041; x=1699195841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifnDTC7wfj+PooeFzDEu5s54tBM3Ed0ClHgMpWiJrQ0=;
 b=KcsWiTa8021Wv882Cf6IXiOO19o4C6jHqsntImeNEaTOftN61SC9IIoxhQVute+DP3
 y79GPN8AKLkrCROfOfVZL9VhVESldDz5ZRkuT8t1YRVzMTXxc/ifMl0zArbIEbJcyJ1c
 zb6LwtqJJrSgbFwk0S5jh8YXmGVmjIwnjJ/+07Soc6EqE7tofBNzYhBM1hrp80kJ4BKu
 2RH9VcTedjw37AZ/hLaD/VB3i7SJNBPGtXSl22BwOBitdWLXjqT5xVs3KiGJvKif+lvN
 YwQ36Di4WJj3f3CYGGjbR8JT8/fkZp7Esj6bOjwX5GrANrCCOeZkXEs/CQATWS3HtGWx
 gitg==
X-Gm-Message-State: AOJu0YxArjy9nezxaLueAoNC1AteJKOkKlgLFiM8oWACztE1r6hv9Dzn
 UQTasvEZurtsSaxzfW2poLRxxw==
X-Google-Smtp-Source: AGHT+IGIlUKyOX3kv4zsgmImBfKduAXrOFCwgVw4XliS8oxUf6LmCE1UfjDU6Tuu5MUVNaWCUA6iRA==
X-Received: by 2002:a05:6000:1004:b0:32d:a4d0:1364 with SMTP id
 a4-20020a056000100400b0032da4d01364mr10421883wrx.29.1698591040774; 
 Sun, 29 Oct 2023 07:50:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w16-20020adfcd10000000b0032da75af3easm6056015wrm.80.2023.10.29.07.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 295335F7A1;
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
Subject: [PATCH v2 11/19] tests/docker: use debian-all-test-cross for mips64
Date: Sun, 29 Oct 2023 14:50:25 +0000
Message-Id: <20231029145033.592566-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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
Message-Id: <20231028103311.347104-10-alex.bennee@linaro.org>
---
 configure                                     |  2 +-
 .gitlab-ci.d/container-cross.yml              |  6 ------
 tests/docker/Makefile.include                 |  1 -
 .../dockerfiles/debian-mips64-cross.docker    | 19 -------------------
 4 files changed, 1 insertion(+), 27 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-mips64-cross.docker

diff --git a/configure b/configure
index c7c811fb02..2bcbf0fc36 100755
--- a/configure
+++ b/configure
@@ -1327,7 +1327,7 @@ probe_target_compiler() {
         container_cross_prefix=mips64el-linux-gnuabi64-
         ;;
       mips64)
-        container_image=debian-mips64-cross
+        container_image=debian-all-test-cross
         container_cross_prefix=mips64-linux-gnuabi64-
         ;;
       nios2)
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index d42d89b26e..df5eb3ccb6 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -46,12 +46,6 @@ loongarch-debian-cross-container:
   variables:
     NAME: debian-loongarch-cross
 
-mips64-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-mips64-cross
-
 mips64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index fb93eca537..5831744a39 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -122,7 +122,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 	$(call debian-toolchain, $@)
 
 # These images may be good enough for building tests but not for test builds
-DOCKER_PARTIAL_IMAGES += debian-mips64-cross
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
 DOCKER_PARTIAL_IMAGES += debian-mips-cross
 DOCKER_PARTIAL_IMAGES += debian-nios2-cross
diff --git a/tests/docker/dockerfiles/debian-mips64-cross.docker b/tests/docker/dockerfiles/debian-mips64-cross.docker
deleted file mode 100644
index ba965cf564..0000000000
--- a/tests/docker/dockerfiles/debian-mips64-cross.docker
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
-        gcc-mips64-linux-gnuabi64 \
-        libc6-dev-mips64-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


