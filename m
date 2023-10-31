Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2677DCFA3
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:50:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpyZ-0004pL-0U; Tue, 31 Oct 2023 10:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyW-0004oD-2N
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:12 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyT-00029j-9m
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:11 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507a3b8b113so8292975e87.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763447; x=1699368247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQGp6YloSStGiLyvzpzmbyXDw10os3RcjMFIgCFvBmg=;
 b=dkE1fgfQsj/cOrDyEyKdM2tiXB9IYP+gjGlgXjuH4Y1lRCcPK/DeWhrbyL5kudSeuU
 /h51SUfAqjoHbSJRX5qz00f3SZ6gtYbWpV4BImu3y6wcabS22zBG5gESz/nF5AJDYN5a
 X1VqD95rJJlLBtX0DTtDvbgiguecQ336xzNAswoSo5Goniq54XHnKseYtro5dYDK1b/b
 KEHSZ+SEXY9rt5LZYXVSLkkmsw6+hVg2IUwXqh2aPGYzkVFP73c7UkrzZeRZWng65PJd
 9tgPzETa5JFRA+qFSXYXtP+SCNNSOJs/qO8VkPNx+ulLAiJWg0TpVQ6XTkgMGMVv3jz5
 iiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763447; x=1699368247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQGp6YloSStGiLyvzpzmbyXDw10os3RcjMFIgCFvBmg=;
 b=EPdfGzMkznroB4C395Rlm+mbHKhWgZ2Q4vs4rjxPWkh6j193MASxjIBzQq8jEyYzDi
 O437Zt5Kglsv1+AnYQM2JX3aOfGprJhZLtOqDvBq4OwQ/2CLeAWlTzj0aF2Fqh9p+UV6
 DrdcBns9oPXmVBBce5q1Dk4wniyjFoYHn6QtBXyYM+y6+bHSk5j687oKMn/eqpBHhcog
 S2TaWug5XPWy74jefM7AF629hhMLuQ07lT8E1wrCGZy/J1fbYfE1G5nyf4P7UeSwNs0R
 mqCg0uf9odsT7BlaUef2ofFEB8SibAGfuN/ZRdh+u2N0D5IsacpjJ/dEsEhSfhdLO4uw
 q06A==
X-Gm-Message-State: AOJu0Yx/APx/k4mP0Msi3T0sSnlarnUhx+pFUxlmbGTN3ETNvQVikney
 sh/CICkYI/+cv7AXSmJnFGHa0g==
X-Google-Smtp-Source: AGHT+IFt1PEzvVklQiafhhiDe+EYifpsk4PFx7DbGNYayhGPPBJ1JnL8w9DHhptrlh9ohbor2gf99A==
X-Received: by 2002:a05:6512:3a96:b0:505:7896:18de with SMTP id
 q22-20020a0565123a9600b00505789618demr4795714lfu.45.1698763447772; 
 Tue, 31 Oct 2023 07:44:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 16-20020a05600c229000b0040596352951sm1929366wmf.5.2023.10.31.07.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5B6F565728;
 Tue, 31 Oct 2023 14:44:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 06/19] tests/docker: use debian-legacy-test-cross for alpha
Date: Tue, 31 Oct 2023 14:43:48 +0000
Message-Id: <20231031144401.1238210-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x129.google.com
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
Message-Id: <20231029145033.592566-7-alex.bennee@linaro.org>

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


