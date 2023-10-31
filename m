Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3447DCF9C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:49:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpyZ-0004pV-Mi; Tue, 31 Oct 2023 10:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyX-0004or-RI
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyV-00029y-6K
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40853c639abso44758205e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763448; x=1699368248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndIjKuvnqGHRvHRZNJZiZGvMt1TC/HbwEzRPVDvch8c=;
 b=PD9YTCVTH/Q6MC+s7LGhcKuMOvaLV+HHqRxxlPYKuUjaG6RTxLC1bf//hmehw4uI+Y
 dQRqKMlyfMQQ8osMOuDytkOdRxlgQVX6K85vWEpST3vA4zs30uPP0yvemntxb02/e9Qg
 Sn2FAo3w9Mt4uvAxopngOk0I0EqUbsaH0JzrvqvMNb/Y+4TtshV4h+EtwUGW5Y3U7PxD
 jeFkwZdkB5aYhEQt30qEapeYDFcZO3Jsx+piE6wCPtghjOt9I0JEvJ26q1UkCE0LzQPJ
 4CQHDw6vsNioVWallsCKB7Kse/O99SMqdpCCl3yT+hlp2f3wrkPhQFeZHtq3tRj85sMj
 QBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763448; x=1699368248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndIjKuvnqGHRvHRZNJZiZGvMt1TC/HbwEzRPVDvch8c=;
 b=tr0bZpX7CV8yfM2P/+qLcX/y0bkMUOLkUpQ6FGG3vXuSRqrgbsbp51CzU7uxzS/0bD
 tTU47c80okCj4a7HE38sh33m3otLOaYL90MqhVqHmomQvJySAwOL/7i8u5cZ1yNb/+hc
 rXXtNWnTmf/xxmz5CJ2oFBKxsp/5R0brQ6PupkpfSDykwingASNlgHfvY9z78BOhKx0i
 LDX1dZHCxKP7ANSMz1X2OjW2Fn+O0F4dQTZkYIL/tcRDRKRuPmvaWjrV2x7JWUCtuvNj
 ckNHpmGgjjEi4f44Yp4sJ/oO6JargFBQDEGxlpXqpBSDRMgmbwHeiEDBHVhl74g63ntF
 prCw==
X-Gm-Message-State: AOJu0Yw8pERP6g9U2+oKSPEiGi4sMl9+YjHc7QBoUDZv1P/tjPHIcukX
 FIHi0yzJz+2MF+C1KRGZEODT9g==
X-Google-Smtp-Source: AGHT+IGo6/2fWiIt4bs2DT07gnf4KMkjpevkVPpw7EeNERWQtdDGtu+FLwBdUJ3+XEoCZMsAhHnwTQ==
X-Received: by 2002:a05:600c:1ca9:b0:403:9b7:a720 with SMTP id
 k41-20020a05600c1ca900b0040309b7a720mr11482656wms.1.1698763448125; 
 Tue, 31 Oct 2023 07:44:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h10-20020a05600c350a00b004064cd71aa8sm1964851wmq.34.2023.10.31.07.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF1EF65711;
 Tue, 31 Oct 2023 14:44:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/19] tests/docker: use debian-all-test-cross for m68k
Date: Tue, 31 Oct 2023 14:43:52 +0000
Message-Id: <20231031144401.1238210-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20231029145033.592566-11-alex.bennee@linaro.org>

diff --git a/configure b/configure
index be7cfeddc0..aa29cfb797 100755
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


