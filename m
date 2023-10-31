Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FD97DCF84
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:45:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpye-0004t8-D5; Tue, 31 Oct 2023 10:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyb-0004ra-Vz
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyZ-0002CR-Nl
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083f613275so41441325e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763454; x=1699368254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVFhKh46M5GfStLPcCrXVqXvAAmQhHpnjdsY7O4fjsA=;
 b=xD8A6YUqDhp+srO+lLY5Dwnu6Mio9ZD/IVGPMDUDbVfGuzQtp+plTZMhnx0EDp/0XP
 MyAq7/wVKffGQp9tlcm06opQ1kkYtjvAWZ8wIlK9Y1FFDHaLaBl8ui35l55XN8cHUuN8
 itqu6YG+cFxOsuTzCFkk2a9ywz57r3zvCZpdSqKJHSSOslnBY/qQWDYrCJVQtTilaF9v
 B2sOolFmj2cdv9UjXU9c6nYezmUPVOIzqPa6gsWCZqeJUZ3v/tTVxfxhb4g7D+kD4mhv
 hL3f1xgozrs2mjXeyvC1XUlsycYs6pSaHspdZxV/8l7ehBycdZJPwhyj93PZsTB2rPZ7
 lQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763454; x=1699368254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LVFhKh46M5GfStLPcCrXVqXvAAmQhHpnjdsY7O4fjsA=;
 b=HO4SdldEReYvSKybUGCNvqAcmqJR8omWgHcg0G21o9UJxPnVoPh0xJCjNAOCOPujC+
 9VZn0mmN4YQcyEYxIRwJvDHk4KLwu9mvsCZ62LzptjIPRbP1s5Tzd4oBf1ntZK7OAlsE
 qu69UqLil+6Kj5Dwb5+fJJh4jiN4GsE10mPK26BuLstjAZeYKkds6V/8Sh3Z16OquZK1
 6pFdm1Z/rGwtmV8ACHn1V6u8UD4zlNHOXfaAtuCqAlV6gspyaiBW7Qm/U4Pzt8Gv9MG0
 U0EUh0TM1+B9sD0lO/MQHBi91XdCpkVoQk72ZTiCWvx9dwaJ4O7XKctA/ImeouZb2CNt
 sMeA==
X-Gm-Message-State: AOJu0YwBzRxd+OjMbgKmNesXKMLAiNkLKEz/3nD5WIvPH6nJAriW170z
 OnbXz15YaEJhWIH9kSVezFWGRA==
X-Google-Smtp-Source: AGHT+IEx+S+W/x1vMVDoHxM2R/Tz/HvNb78VpBvWSglwD0TMtdV/QWly93lOWuNqqxBjaUiN1k7pGw==
X-Received: by 2002:a5d:62cd:0:b0:32c:c35c:2eea with SMTP id
 o13-20020a5d62cd000000b0032cc35c2eeamr7724723wrv.6.1698763454398; 
 Tue, 31 Oct 2023 07:44:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v12-20020a5d4b0c000000b003143c9beeaesm1680729wrq.44.2023.10.31.07.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D806D6572C;
 Tue, 31 Oct 2023 14:44:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 11/19] tests/docker: use debian-all-test-cross for mips64
Date: Tue, 31 Oct 2023 14:43:53 +0000
Message-Id: <20231031144401.1238210-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-Id: <20231029145033.592566-12-alex.bennee@linaro.org>

diff --git a/configure b/configure
index aa29cfb797..2dddc3c82d 100755
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


