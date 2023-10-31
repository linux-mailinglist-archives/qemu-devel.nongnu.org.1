Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADEE7DCF8E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:46:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpyc-0004ro-Jq; Tue, 31 Oct 2023 10:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyZ-0004pZ-F9
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyX-0002Bb-M2
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:15 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32d9d8284abso3643249f8f.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763452; x=1699368252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcyv0RYN9JSVoQBV0y0IqvvxryTWpI+BdywLMNyX2vM=;
 b=DIKdI1Asyx9CPZXDGS6qNz1sjP0cPztllb+D2TXz3yspKCYBTn2M+ge1ULpyODv73+
 8vBLA3JNYxqGkAzrnIpqMQs+pkRzbVfRoRwKkwY4AsFm3Q8pFwsYEkMxRD6v/1XQqfWy
 Usv5mPFZjdAitd6EjB5YCp7CUuBi4XYMxeFktshigzGiqYVV0lYDhpYFvI5S5EWhuOJ2
 BoiXov4H+B1w/DKbFVY0DWg9bdI1JFCCWOSrhfNfS95zhtPEE2hLDOOBcdiOxksORrlz
 zwOxkLO/JHn2Bhh6OGNc7guonLdie1V8mP1Q3slLCRSpphBv4SW4XLCJkzrSA5UwFrVm
 fZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763452; x=1699368252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcyv0RYN9JSVoQBV0y0IqvvxryTWpI+BdywLMNyX2vM=;
 b=RhBfHpngML2J9MPCDi4i5TPv6JvCWSZ0mjvzFnXf/SYsMr/2uGfTmkvpbpYJWFyy5B
 SCrb5Iae2a8uvBezfGiUmeg6EnbJex+boLCKcCP2A0DMp9QD3OEpmqnL8bo7+hK8/hLh
 BzjFBrd8OwpooP03pw6NA4esPergDh3gqaOr5GEqUNRKKi+mr5FFF/UtkxrKllOkUq98
 7JivgvBxigY2NJ94PQ6/Srv0V0z3CD0RnOb3g9gsSffzl6wOFhjYQlw1CJlV9oWJ4x6w
 shEjPHRtN0da4rRUlkgO5+ry1XbiwJxC0uqYV7Rg661+KJD9+EhVSJTPSWKSeuoy8fWO
 hiTQ==
X-Gm-Message-State: AOJu0YxXIOHA3mA5BY8Dbr1WvZNZuax/czQ5fg71+NEKP0lZUtDMuexa
 PQpy29uq2Rxsd3FAImkYLUNagA==
X-Google-Smtp-Source: AGHT+IEo633aXVSwqRQkIeiM5udbskhBGHAD4fv0sU5T7gM58uLB+c4zxyNVd1IGx8FE3Z998HehOA==
X-Received: by 2002:a5d:4c45:0:b0:32d:a2d6:4058 with SMTP id
 n5-20020a5d4c45000000b0032da2d64058mr9422563wrt.62.1698763452299; 
 Tue, 31 Oct 2023 07:44:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w12-20020a5d544c000000b0031c52e81490sm1668986wrv.72.2023.10.31.07.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ED46465712;
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
Subject: [PULL 12/19] tests/docker: use debian-all-test-cross for mips
Date: Tue, 31 Oct 2023 14:43:54 +0000
Message-Id: <20231031144401.1238210-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
Message-Id: <20231029145033.592566-13-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 2dddc3c82d..791c48c4e4 100755
--- a/configure
+++ b/configure
@@ -1330,6 +1330,10 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=mips64-linux-gnuabi64-
         ;;
+      mips)
+        container_image=debian-all-test-cross
+        container_cross_prefix=mips-linux-gnu-
+        ;;
       nios2)
         container_image=debian-nios2-cross
         container_cross_prefix=nios2-linux-gnu-
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index df5eb3ccb6..053330d6f4 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -52,12 +52,6 @@ mips64el-debian-cross-container:
   variables:
     NAME: debian-mips64el-cross
 
-mips-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-mips-cross
-
 mipsel-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 5831744a39..dfa9617bb9 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -123,7 +123,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 
 # These images may be good enough for building tests but not for test builds
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
-DOCKER_PARTIAL_IMAGES += debian-mips-cross
 DOCKER_PARTIAL_IMAGES += debian-nios2-cross
 DOCKER_PARTIAL_IMAGES += debian-riscv64-test-cross
 DOCKER_PARTIAL_IMAGES += debian-sparc64-cross
diff --git a/tests/docker/dockerfiles/debian-mips-cross.docker b/tests/docker/dockerfiles/debian-mips-cross.docker
deleted file mode 100644
index 2cbc568ed1..0000000000
--- a/tests/docker/dockerfiles/debian-mips-cross.docker
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# Docker mips cross-compiler target
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
-            gcc-mips-linux-gnu \
-            libc6-dev-mips-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


