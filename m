Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2697DACD9
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:53:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77p-0007WI-2A; Sun, 29 Oct 2023 10:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77l-0007Se-FH
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77g-000570-Fz
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-409299277bbso21437695e9.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591039; x=1699195839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNNScLl2EnYnhjzXY3DyEkkpccU8fcT69NItdWwEwog=;
 b=AzDbS9VxqZqpXvb5tRQHy2HOshdlQKKqsugc4uX60zbkP51g2lv95bFQixWKtu7gfc
 nDTbX6BJLZL5jjHbwXRYheM/eK1i/Bufs4ayhuVnE1DnLn1zY0KG6mCh28Tqcimb1+yL
 titTozq+Ylfy1Rfg+AwEm11VGD3ek042ja6T/Fs7lRQBkOeqTOmTB9Zb7xnMtTS8qQPW
 fvWBaBeW+/Nr+0wNRVQ8q5/QTf567y/cM0BUBeRPfz7liMaIpk/grA1oHYX92dZWtAFC
 CFkH4CKYTN/rnFtxkC3BBt45V/nYFFwdt96ZciniTlhbPNdxJyhhaKurW2KCCQwW25Xx
 /9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591039; x=1699195839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNNScLl2EnYnhjzXY3DyEkkpccU8fcT69NItdWwEwog=;
 b=fqhxes+N1NAX6NKqNAYnDW49YU0UfUoYET6u9pHgedIQXJMFzHfSLFf1YhocW4TlnN
 EDIoPNeEp1dtrtGSih045NTkk0xWX463eGQFSMAnG+X3ZDtVnu4GlGWXZx/kmdkZWmxx
 W2qDpzm5LWQR4zRw59GEHg7AVE01Njuo74BKF6Kr8hJOqq4f2QglgwxCYBrFqJEITpNE
 pz5IfcSPUfwkFHhlTpIATL3DHJgfigrLJPHMpajih1ccIHlgDHzkRtEjVyMOi2I/kQJg
 By8UzMDJN0pUo/j+C/dlyPuwZZDA95RbeA4qUvdD2KW7lFTb9YKcOygmRH+QhGXo8Fat
 ucBQ==
X-Gm-Message-State: AOJu0Yy7eYofnccH07Dt5k9bdNXQeeYkkcsjFJKTHlcXmKRpbFwJ/lqP
 x6eAb8SdRYrDn0PzbmVHC2sPOQ==
X-Google-Smtp-Source: AGHT+IHmKWtHw3GJtbbrnpOPhDi0YVDwJv7rQYv0enKEFt346OmNLJVlGOsm8lgM7/AU5BlyBJErzw==
X-Received: by 2002:a05:600c:3c9a:b0:408:41b4:7fe0 with SMTP id
 bg26-20020a05600c3c9a00b0040841b47fe0mr6402277wmb.6.1698591039111; 
 Sun, 29 Oct 2023 07:50:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o42-20020a05600c33aa00b0040303a9965asm10141054wmp.40.2023.10.29.07.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9CA7E5F839;
 Sun, 29 Oct 2023 14:50:34 +0000 (GMT)
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
Subject: [PATCH v2 06/19] tests/docker: use debian-legacy-test-cross for alpha
Date: Sun, 29 Oct 2023 14:50:20 +0000
Message-Id: <20231029145033.592566-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
Message-Id: <20231028103311.347104-5-alex.bennee@linaro.org>
---
 configure                                     |  5 +++++
 .gitlab-ci.d/container-cross.yml              |  6 ------
 tests/docker/Makefile.include                 |  1 -
 .../dockerfiles/debian-alpha-cross.docker     | 19 -------------------
 4 files changed, 5 insertions(+), 26 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker

diff --git a/configure b/configure
index b4ea78c77d..c8d0d4f7cb 100755
--- a/configure
+++ b/configure
@@ -1281,6 +1281,11 @@ probe_target_compiler() {
         container_cross_prefix=aarch64-linux-gnu-
         container_cross_cc=${container_cross_prefix}gcc
         ;;
+      alpha)
+        container_image=debian-legacy-test-cross
+        container_cross_prefix=alpha-linux-gnu-
+        container_cross_cc=${container_cross_prefix}gcc
+        ;;
       arm)
         # We don't have any bigendian build tools so we only use this for ARM
         container_image=debian-armhf-cross
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index d200f3e00d..0de1929e74 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -1,9 +1,3 @@
-alpha-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-alpha-cross
-
 amd64-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 5635d1537f..8270bdff6c 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -122,7 +122,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 	$(call debian-toolchain, $@)
 
 # These images may be good enough for building tests but not for test builds
-DOCKER_PARTIAL_IMAGES += debian-alpha-cross
 DOCKER_PARTIAL_IMAGES += debian-powerpc-test-cross
 DOCKER_PARTIAL_IMAGES += debian-hppa-cross
 DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests/docker/dockerfiles/debian-alpha-cross.docker
deleted file mode 100644
index 7fa7bf1bde..0000000000
--- a/tests/docker/dockerfiles/debian-alpha-cross.docker
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
-        gcc-alpha-linux-gnu \
-        libc6.1-dev-alpha-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


