Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B497DACD7
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:52:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77m-0007Ss-9k; Sun, 29 Oct 2023 10:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77k-0007RL-6t
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:44 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77f-00056N-JT
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:43 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c503dbe50dso53296261fa.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591038; x=1699195838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clAsXQk4CcruGbOXHReH1yVf9BfUQKuu3xZ4btQvLbE=;
 b=VdmwDwgDmsCvvcEHJayoOIouyPdJCE9Y+srZBBM7oqbs0PJAxf+NLS+wyjPD8TbW0u
 PGTNCP/ClrTnkenBGWjIsAZNmB3bRsBLytB+qwU2O8x4gxCK5TNLXRm23P5CR/rZF2bh
 IG9uc14Jvg7CTqMOPSTn3T5v4zGZ+Vpc236HsWOgZmvu/pkLhoVCC6AKM13BMmhwP6U6
 0z+Vw+K2IT/yDvcGEvU9lbPVjld4Rz9HpqOK0QdWN3m+Q5GLWO5qrqnNyLzzv7ZEw8eM
 GgZYG0p7bWp0VD307QUsa+6FhLyMXNct78XeLfHdqlfnfEF5i9FO5iTjJTaqTeor8sFa
 R8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591038; x=1699195838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=clAsXQk4CcruGbOXHReH1yVf9BfUQKuu3xZ4btQvLbE=;
 b=qXYKmXe+r93dB7Jy/bOIXzuOv9qciEW8Sv4xtQTBm5c3IUGX8QY2MjzixZoizoob/a
 6sVNuF+XVv/m3tWITAa0f9VIf3QgdBUoV5Sp3xRQYVHikZh/RVeKfeqzouV1h/wBoEh5
 wMcgwjng+fhzqmMft83GwbDcYs3n3lUCmDgjsRVAF9kH/AATbt1vy1/YidPSB5pjZA1j
 xTJ5DKCsCkj4vYAL1mG5W87yLRByaSuzt9zWRtH/PI1X0YjKFpyRJG6Npd8/T6qT565Y
 TpeaBs+V76QXDdPx4SvlzM39ijYnM6ABHwTXcukhr4axvZcC9VHcOilDn2atlWw/AK4g
 vKig==
X-Gm-Message-State: AOJu0YwXN4TGUInjhEcOYyHmFyMttRr5F2spyZVpnwAb6zKREeIfiAPq
 A5k3bkfhVQmAIeK0w8Cv7qe8hA==
X-Google-Smtp-Source: AGHT+IFAltfSv5XD5XHX3gMGWkRZItuHsomKUik/nCvXtKIzNIqsHDl9NDfOBP0UBkAZ1BYq6GSUUg==
X-Received: by 2002:a2e:965a:0:b0:2c5:130c:d41e with SMTP id
 z26-20020a2e965a000000b002c5130cd41emr6088153ljh.29.1698591037853; 
 Sun, 29 Oct 2023 07:50:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d12-20020a05600c3acc00b004068495910csm10002000wms.23.2023.10.29.07.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E8ED95F7A0;
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
Subject: [PATCH v2 09/19] tests/docker: use debian-all-test-cross for hppa
Date: Sun, 29 Oct 2023 14:50:23 +0000
Message-Id: <20231029145033.592566-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22e.google.com
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
Message-Id: <20231028103311.347104-8-alex.bennee@linaro.org>
---
 configure                                     |  5 +++++
 .gitlab-ci.d/container-cross.yml              |  6 ------
 tests/docker/Makefile.include                 |  1 -
 .../dockerfiles/debian-hppa-cross.docker      | 19 -------------------
 4 files changed, 5 insertions(+), 26 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-hppa-cross.docker

diff --git a/configure b/configure
index 8707bd2e78..0a755c71a0 100755
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


