Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2F37DCF9B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:49:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpya-0004qC-Bd; Tue, 31 Oct 2023 10:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyX-0004oq-RH
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:13 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyV-0002Aa-La
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:13 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c50d1b9f22so74854271fa.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763450; x=1699368250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iszDwQafh3cXdksSyYOnUK1+K3HqT7eMCMkWVLpPqWo=;
 b=h4/z//nLWv6huZqu5Ey14cai6hLgzwjUDcvwp4OsbCfhBAVHfXszHi+L8GErkZv+hh
 K+5M6zgWXzldgzPm8kPQ2a/Q5psYOrSTo60PsTjPRsR5Bu8Z7zeVuuOD+r601yxxaYy7
 alCqAn67U0lzYIsiAz+FHX18BLO9PS6dgqiopNMUyIW2359DACA7sHVTkhP3NpBYijeF
 0GwCrCgjatRkbiT+pfrRD8cSuhz0u8ARGk6Qg9uCYOnqXHpkDSBYa0JHrtIiv+16mIUt
 9+lR0Lv1gGg9AwqW38AHl01TfG2M8WNYaikeuki3s3XHX818Na883cuceZG9iwSNjdSf
 4LQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763450; x=1699368250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iszDwQafh3cXdksSyYOnUK1+K3HqT7eMCMkWVLpPqWo=;
 b=w/X85aFSiEJCAUMxnF+1jhGWYNjoxtb1fdNiXq9O/fAV3lrmm5sGBeWeI560qSCZrD
 V3mHrRuCFWiwDq9yKCj67sC/lzmhpR6Ky8DU/OstU6jJQibjri7qNZVAuZ9ttH1FrRsG
 UshHzuI3XCVt8A/i7Twr3DoyAssDcl9XZQYhLUNleoHeuMG2/kwGJOh46JhEMY/xBzc7
 Cui3cfdXm5v5nGeEIW1ZHI7MTpFiYHqb8OYYVvSyGZk4ljcoB+Bintm5uChYOM9+3L3W
 lqzoCPyP2c4DoTXtWgS8ml+gBlNCsSKF9AdoYNN7j3SxvY2Ea5aBhhrOi97uHOOyl07R
 ZTMw==
X-Gm-Message-State: AOJu0Yy7YdDTYvxDUYkqICRznWG2q9e7LN36GxPWTBSPhFsdw/N0ERf4
 g9+7UL9WtSfEBK1mTZ6se8i4hA==
X-Google-Smtp-Source: AGHT+IFSAhU8G7yrJzoiw0tQrtggxgmyFASmgZhmzLPF1p//ncEhJg41kUSiSd5+Q3BM5jbyLOJqmw==
X-Received: by 2002:a2e:9d8c:0:b0:2c4:ff2e:d6cd with SMTP id
 c12-20020a2e9d8c000000b002c4ff2ed6cdmr9984637ljj.2.1698763450063; 
 Tue, 31 Oct 2023 07:44:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m18-20020adff392000000b0032daf848f68sm1645893wro.59.2023.10.31.07.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F0EA6572A;
 Tue, 31 Oct 2023 14:44:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/19] tests/docker: use debian-all-test-cross for power
Date: Tue, 31 Oct 2023 14:43:50 +0000
Message-Id: <20231031144401.1238210-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22f.google.com
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
Message-Id: <20231029145033.592566-9-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 37d1b10b87..96b01a280c 100755
--- a/configure
+++ b/configure
@@ -1325,14 +1325,13 @@ probe_target_compiler() {
         container_cross_prefix=nios2-linux-gnu-
         ;;
       ppc)
-        container_image=debian-powerpc-test-cross
+        container_image=debian-all-test-cross
         container_cross_prefix=powerpc-linux-gnu-
         container_cross_cc=${container_cross_prefix}gcc
         ;;
       ppc64|ppc64le)
-        container_image=debian-powerpc-test-cross
+        container_image=debian-all-test-cross
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
-        container_cross_cc=${container_cross_prefix}gcc-10
         ;;
       sh4)
         container_image=debian-legacy-test-cross
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 3e6d741f62..a1dac0a45f 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -82,12 +82,6 @@ mipsel-debian-cross-container:
   variables:
     NAME: debian-mipsel-cross
 
-powerpc-test-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-powerpc-test-cross
-
 ppc64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index f61d97102f..82e06d84b3 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -122,7 +122,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 	$(call debian-toolchain, $@)
 
 # These images may be good enough for building tests but not for test builds
-DOCKER_PARTIAL_IMAGES += debian-powerpc-test-cross
 DOCKER_PARTIAL_IMAGES += debian-hppa-cross
 DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
diff --git a/tests/docker/dockerfiles/debian-powerpc-test-cross.docker b/tests/docker/dockerfiles/debian-powerpc-test-cross.docker
deleted file mode 100644
index 23779413d3..0000000000
--- a/tests/docker/dockerfiles/debian-powerpc-test-cross.docker
+++ /dev/null
@@ -1,23 +0,0 @@
-#
-# Docker powerpc/ppc64/ppc64le cross-compiler target
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
-        gcc-powerpc-linux-gnu \
-        libc6-dev-powerpc-cross \
-        gcc-10-powerpc64-linux-gnu \
-        libc6-dev-ppc64-cross \
-        gcc-10-powerpc64le-linux-gnu \
-        libc6-dev-ppc64el-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


