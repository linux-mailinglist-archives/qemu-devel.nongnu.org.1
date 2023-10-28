Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0337DA674
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:35:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdD-0006Bw-Qz; Sat, 28 Oct 2023 06:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgdB-0006An-Mi
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:25 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd5-00039i-Ts
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:25 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c5210a1515so43385521fa.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489196; x=1699093996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1bHGR0bxCm0oeHMRXA/Rzgk8YpqHzUyqeCh99ot5F8Q=;
 b=hbsmzKSJlntZj5Ja6DVDEvqIjTJ/bsTb2GI0vBnWrISdMGcRuIEU9V53VnpabLgvDj
 vbf5JqbNVSUB9d9sTCp/ZGOReMwnO/AiyVMSeiwBc1uz7l1e75BUb3TtknHw5o+yhw1Z
 eCtn5WGOHmKCTgiZywhyQTF3xYHJ0qppOH+1y8TU3sDbVgcIhJxswSHqwWCYkkjKabGy
 UWOGl2f4zO1SXM0c7xA+x+RwrzbSSZgjc3gAQqR7tWKMxWKpGOhoG0k84Gcqwj/Mv5pL
 SU3ANAwcCnUYrherjefJSt1vu6dLEUXTYoLmXQ8hNFfVYME/tknM+LsYhG8bZZ/16bn2
 seUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489196; x=1699093996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1bHGR0bxCm0oeHMRXA/Rzgk8YpqHzUyqeCh99ot5F8Q=;
 b=wJ3DOwaVbADO4ewlp5irDiRsBCIEYb96GaRo/aW+39KA+8ezkpJltnNGiR3xkUIaXV
 XdvHtRQQ3BkWcFh5qXYHKqFrPPQ9wH0qjAmgVpTxdEz+l5liy3VX/3AInzMr3SpQzoeT
 MAgquWTSEKr4V1bhq5DwWIQnHkwIMMLZzP7JL1Izuct+mjDeBvzq9cy/Ez0pif9/TRm5
 TiSPHStyAHa+BcxcNX7mCfcpKgwh4Nviupt/prIrBwS7dhIxAgHhsBoZa+HTjTdhqYJr
 tEoa60rE8XjDJnW2lNogowAhCPmdZITuQVU8laiV5a1nR7jJg1b91l6H3ti0Jt1AtjmZ
 yrBA==
X-Gm-Message-State: AOJu0YwaVQwMF6FaZHT13QqeTdpWEt/PaLtTnkxwhc6MnSjGBbBWlr7w
 kErBEBdvvy2ilAtQaK/FGtNgCw==
X-Google-Smtp-Source: AGHT+IHkDirjs31qzpiShSelgnCsagCOMQgIvji88Q3mH+o6HacgiG40ZxQsOglzpjLTyX4+awU5GQ==
X-Received: by 2002:a2e:b752:0:b0:2c5:9a5:a1c2 with SMTP id
 k18-20020a2eb752000000b002c509a5a1c2mr3305725ljo.30.1698489196043; 
 Sat, 28 Oct 2023 03:33:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ay32-20020a05600c1e2000b004065daba6casm7187734wmb.46.2023.10.28.03.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7F1595F79B;
 Sat, 28 Oct 2023 11:33:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 05/17] tests/docker: move sh4 to use debian-legacy-test-cross
Date: Sat, 28 Oct 2023 11:32:59 +0100
Message-Id: <20231028103311.347104-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
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

sh4 is another target which doesn't work with bookworm compilers. To
keep on buster move across to the debian-legacy-test-cross image and
update accordingly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                                     |  4 ++++
 .gitlab-ci.d/buildtest.yml                    |  2 +-
 .gitlab-ci.d/container-cross.yml              |  6 ------
 tests/docker/Makefile.include                 |  2 +-
 .../dockerfiles/debian-all-test-cross.docker  |  4 +---
 .../debian-legacy-test-cross.docker           |  3 ++-
 .../dockerfiles/debian-sh4-cross.docker       | 19 -------------------
 7 files changed, 9 insertions(+), 31 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-sh4-cross.docker

diff --git a/configure b/configure
index c8d0d4f7cb..37d1b10b87 100755
--- a/configure
+++ b/configure
@@ -1334,6 +1334,10 @@ probe_target_compiler() {
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         container_cross_cc=${container_cross_prefix}gcc-10
         ;;
+      sh4)
+        container_image=debian-legacy-test-cross
+        container_cross_prefix=sh4-linux-gnu-
+        ;;
       tricore)
         container_image=debian-tricore-cross
         container_cross_prefix=tricore-
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index d670fb42b9..983c95e785 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -276,7 +276,7 @@ build-user-legacy:
     job: amd64-debian-legacy-cross-container
   variables:
     IMAGE: debian-legacy-test-cross
-    TARGETS: alpha-linux-user
+    TARGETS: alpha-linux-user sh4-linux-user
     CONFIGURE_ARGS: --disable-tools --disable-system --static
     MAKE_CHECK_ARGS: check-tcg
 
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index c2394ff001..61f23561b7 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -110,12 +110,6 @@ s390x-debian-cross-container:
   variables:
     NAME: debian-s390x-cross
 
-sh4-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-sh4-cross
-
 sparc64-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 25147f0220..654f24b188 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -130,7 +130,7 @@ DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
 DOCKER_PARTIAL_IMAGES += debian-mips-cross
 DOCKER_PARTIAL_IMAGES += debian-nios2-cross
 DOCKER_PARTIAL_IMAGES += debian-riscv64-test-cross
-DOCKER_PARTIAL_IMAGES += debian-sh4-cross debian-sparc64-cross
+DOCKER_PARTIAL_IMAGES += debian-sparc64-cross
 DOCKER_PARTIAL_IMAGES += debian-xtensa-cross
 DOCKER_PARTIAL_IMAGES += fedora-cris-cross
 
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 205173b0a5..43cc083318 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -52,8 +52,6 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         libc6-dev-riscv64-cross \
         gcc-s390x-linux-gnu \
         libc6-dev-s390x-cross \
-        gcc-sh4-linux-gnu \
-        libc6-dev-sh4-cross \
         gcc-sparc64-linux-gnu \
         libc6-dev-sparc64-cross \
         python3-pip \
@@ -64,7 +62,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
 RUN /usr/bin/pip3 install tomli
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
-ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
+ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
index 763d36dfe3..d9b37995a2 100644
--- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
@@ -4,6 +4,7 @@
 # upgrade. Currently:
 #
 #   libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
+#   sh4-linux-user: binaries don't run with bookworm compiler
 #
 # As we are targeting check-tcg here we only need minimal qemu
 # dependencies and the relevant cross compilers.
@@ -38,7 +39,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
 RUN /usr/bin/pip3 install tomli
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
-ENV DEF_TARGET_LIST alpha-linux-user
+ENV DEF_TARGET_LIST alpha-linux-user,sh4-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-sh4-cross.docker b/tests/docker/dockerfiles/debian-sh4-cross.docker
deleted file mode 100644
index 6bd8171d33..0000000000
--- a/tests/docker/dockerfiles/debian-sh4-cross.docker
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
-        gcc-sh4-linux-gnu \
-        libc6-dev-sh4-cross
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


