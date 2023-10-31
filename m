Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC8E7DCF9D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:49:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpya-0004pq-3L; Tue, 31 Oct 2023 10:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyY-0004pK-FM
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:14 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyW-0002Ao-Jd
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso47171715e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763451; x=1699368251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U30BBgxZL0E6bzjBTiHhMCHKRVxI3F7Um9iUKr2Sfcw=;
 b=xNQwTzYF79eXfiA90NirFxigbdmmtdvTlXXe98Fvg6LZXPtVtpU9at8SC6cimkMfR5
 axeaT6A07AFRj1+HPVwCHbJWGTu4Wk18HpPQhF+xyMX6ze/E8Atp2x9KInBnM25n45uR
 UO6B3AlebPV0L50hwJ4h/heesiNtRHJh82iSbJdjZGhsB9uQFxeRi5vIXXjq2FH3sQLw
 F77JDov1vX9uL61UZhYvdd3i2TDgq2VfkMFH8LxGyWNnh7PvMsUPITHH8cnrVy2dXkI+
 uDbwSgHW317EB9LQNpIHlMBJ6Fw3fY+Nqme0mJ9h+3X3EXv2z1c0EXDwvOaJ+dn6AeH2
 uNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763451; x=1699368251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U30BBgxZL0E6bzjBTiHhMCHKRVxI3F7Um9iUKr2Sfcw=;
 b=ahH3ZeJXCe+DHSXOG3NL0pOV2ouPEFMp0pRuGI2BOXsjf3+5uHzp091QH+/xyQNtej
 RKKIf7I0DWFrevFXmvBne6vtY4XawJ8IUHILnriLlpoZwj6mALFnJSVT+VmItoCCglR7
 6iHI/l7dEHQgkTvtqA2sicJzKc+1YcA4I7yKJduYarRb8MHPsVq5Z0EUh8Lk9vFF0wjY
 3XGequYDmYetMYkzys9BYJvf2+e2SDZ4b05L01bE5diBAkYTjX451UJitqenb6+c9p3M
 S4dLSI94vhTx61iz7krJTqoGJy29LYybR35bNauNEHsucARlLIQF90gQYfnDEalN+SM1
 7qug==
X-Gm-Message-State: AOJu0Ywz0+SqmExABB4xqR3t1IfU1NV+pEYU9G9RN3nYfCpG3+lQBAE+
 PNKoADclZiOLYqAfxIAKzXTY6A==
X-Google-Smtp-Source: AGHT+IE1rVXXhbX4Rod+uuTA1LG5VqpzIO5Vvzi6dGQhqt+ihvZrIKHng+PKFn6RNENKiZsts8Akhw==
X-Received: by 2002:a5d:4390:0:b0:32d:81b5:82d0 with SMTP id
 i16-20020a5d4390000000b0032d81b582d0mr8624104wrq.33.1698763451078; 
 Tue, 31 Oct 2023 07:44:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f7-20020a056000128700b003232f167df5sm1639943wrx.108.2023.10.31.07.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A87E36572B;
 Tue, 31 Oct 2023 14:44:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 09/19] tests/docker: use debian-all-test-cross for hppa
Date: Tue, 31 Oct 2023 14:43:51 +0000
Message-Id: <20231031144401.1238210-10-alex.bennee@linaro.org>
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
Message-Id: <20231029145033.592566-10-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 96b01a280c..be7cfeddc0 100755
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
index a1dac0a45f..66b8844246 100644
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
 loongarch-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 82e06d84b3..47e58a248e 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -122,7 +122,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 	$(call debian-toolchain, $@)
 
 # These images may be good enough for building tests but not for test builds
-DOCKER_PARTIAL_IMAGES += debian-hppa-cross
 DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
 DOCKER_PARTIAL_IMAGES += debian-mips-cross
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


