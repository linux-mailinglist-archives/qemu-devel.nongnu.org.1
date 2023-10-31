Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AE37DCF8F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:46:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpyc-0004ru-Po; Tue, 31 Oct 2023 10:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpya-0004qP-0b
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyY-0002Bh-6a
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so41480645e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763452; x=1699368252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0q9opczHMBVwOLIFJvZ4NidlFBVmSFtp8ozOnDPze2c=;
 b=UdnbWNJOP4MqPW6p49JzHLYGZICOlsCb8OMsRP6dnfw3oVvwsijbF9n0ZdrdwD3n04
 ilxpL+JHn4gLCyPkZZuov5CP9Evf0aJgUq/+TMRz3cz/+uO/Ec1WDRnKnqZBhSIO0noz
 X7nLcn8pmgtcFha2Hvep/mwLBB3qgoh6lDSE0uukGtCqbZcaWVfqK5AXycSqTLU/cAY0
 2vha3mmYJd2pDu8Xb25IXjcMrz6IjSibDHiUvg9JfqZB//55MBqlSDNQGjTRh2bfDPtj
 O1ovtkLQfrkiWJLozb8h+IZICKv4eV0hp84XHM+nK3x9iA15+Ng2gr6YyGUOHaF+xDUO
 +IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763452; x=1699368252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0q9opczHMBVwOLIFJvZ4NidlFBVmSFtp8ozOnDPze2c=;
 b=twT+rQqt0fGwXJDx1+J/BPY7g1kFmggICLpaozJq7VCkRa4pRIrU5cp4TZIH8J4o3K
 V/hjZ74vyebw9bupAC4La0/HNpT5A8BxJ0ucwMZyNpCjTM+ErOcqLovfPU7fHdz+Ss8I
 nwqNdAefxsjnj98XOzPDSDUq89677RBpBcfHK4hQZXS1rCJclxeEa3Bbohy1z01BjS1q
 Iw2Qrt8spLkB+WoLVeWt+NM3rN2snfeS+cGADJPfEE7U6jbHCFyN7mokZaYz6CrBAS8R
 GO1Oxe9tLP3NOoe2Kab4mC0PoJlnXtjL0vrM/ysFfdf+oIDLpnshKZ8273Hr31NLhpzP
 lMAg==
X-Gm-Message-State: AOJu0Yww4RM/hgelpuDDpVv5i9WG7gODZHRkj346Wo5A//4t8NI7D5Jg
 GWcWc8POxTd1XDmowDJNIYRCsw==
X-Google-Smtp-Source: AGHT+IEmVFvAPhmi8rszmWtjKkPDwDwzTI8C2fMSxvevPDfLsjYSoV0YzvgD/nTpJXGv49j9pmrCYw==
X-Received: by 2002:a05:600c:35cb:b0:406:44e6:c00d with SMTP id
 r11-20020a05600c35cb00b0040644e6c00dmr11157523wmq.2.1698763452603; 
 Tue, 31 Oct 2023 07:44:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c465400b0040588d85b3asm1885190wmo.15.2023.10.31.07.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2CB146572E;
 Tue, 31 Oct 2023 14:44:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 14/19] tests/docker: use debian-all-test-cross for sparc64
Date: Tue, 31 Oct 2023 14:43:56 +0000
Message-Id: <20231031144401.1238210-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
Message-Id: <20231029145033.592566-15-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 0e0f0c60b5..f1456f6123 100755
--- a/configure
+++ b/configure
@@ -1355,6 +1355,10 @@ probe_target_compiler() {
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


