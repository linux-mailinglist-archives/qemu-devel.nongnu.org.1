Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E01B17DACDC
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:53:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77m-0007Sc-0X; Sun, 29 Oct 2023 10:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77k-0007RA-1W
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77f-00056R-E9
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so27032945e9.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591038; x=1699195838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWp+sro9eTgVGswSfv5JLu3E+WypSNqa+fab5HriMzU=;
 b=LH+VwLlDDpsxOXdjcHOug11WFbrZffHw4onCVZv76vZ/6g7l/N5krVE/i4EmP0B085
 g+JLUe1Z18oa3vIhPJsP8fmZK6NcTsJ2Gih0JcUCT62av0eXcz+AfTXP2DcUTCFXKuyD
 eNScucZQOfV9gFCbOfvjjFDwbL9fcukW883ejsYo7LDSSBmSfT9voKw7aFpr9W9pRML5
 fNJHzmVLjaXPVaaxrfWkG70HFC/p5ePUQYceEPsNrQb/5J8WIn/eMnl6P+mIud1aTOxA
 DP+0FkVC4lMSARZZXlNdncDxAE6gHDf4JrkidU853ZGYNbYxagGFafKJ6EVaBIk31Ht+
 K2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591038; x=1699195838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWp+sro9eTgVGswSfv5JLu3E+WypSNqa+fab5HriMzU=;
 b=uBG4WK2Jj7gOAhzABRkCNCH6v+RXI0uxvuP9JNXwserK5wVP2YOYYOdqjfrp+zdk65
 GKmnjWy4NNQwg0LmLqlhM8SLtWsSzWcR3uDAhIEPU6hzOqvGgYbHpDmTgBZjXBff4hSz
 EOMvo85PzzZjooJODOUL98BX2dv9OQaQlKuM9bXEuZQA+J3m56PrMrzrpnLHrUY7Lii4
 fpeQI65WqCaEGsydAFk9OT//X4DhgLceBGjW4UPRNhR+bptZiY4Lmdivss3CBUF8p16+
 KpY87Rq0i2mYtAzHVfTyD1wA+5tifaMQyKU9bPXEToaFqVYEGaTw9UgrsDaKCjuLY2hx
 Nhkg==
X-Gm-Message-State: AOJu0Yy/wATvSIGWvFV13UlkfBnJ2ZmrLqjo9APMmEVRof/gs9OIM1aF
 TUDK3JbNVJ14TCYvR3t7B7uNMejyaMdZkUZ/aXE=
X-Google-Smtp-Source: AGHT+IEZ6xUB/ZX4uvXdRtsrJ5iTbDlkUZkt0nMe0cgFiRWl86LVfu1aMMP94FKlXa1Qj7YAVUQeSA==
X-Received: by 2002:a5d:5904:0:b0:32d:9a88:e36 with SMTP id
 v4-20020a5d5904000000b0032d9a880e36mr5266481wrd.2.1698591038001; 
 Sun, 29 Oct 2023 07:50:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s10-20020a5d69ca000000b00323287186aasm6075663wrw.32.2023.10.29.07.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 850215F7A5;
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
Subject: [PATCH v2 05/19] gitlab: add build-loongarch to matrix
Date: Sun, 29 Oct 2023 14:50:19 +0000
Message-Id: <20231029145033.592566-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have the compiler and with a few updates a container that can build
QEMU so we should at least run the check-tcg smoke tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml                    |  9 ++++++++
 .gitlab-ci.d/container-cross.yml              |  6 +++++
 tests/docker/Makefile.include                 |  1 -
 .../dockerfiles/debian-loongarch-cross.docker | 22 ++++++++++++++++++-
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 5e9cbf9385..9500ea6e2c 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -303,6 +303,15 @@ build-some-softmmu:
     TARGETS: arm-softmmu aarch64-softmmu i386-softmmu riscv64-softmmu
       s390x-softmmu x86_64-softmmu
     MAKE_CHECK_ARGS: check-tcg
+
+build-loongarch64:
+  extends: .native_build_job_template
+  needs:
+    job: loongarch-debian-cross-container
+  variables:
+    IMAGE: debian-loongarch-cross
+    CONFIGURE_ARGS: --disable-tools --enable-debug
+    TARGETS: loongarch64-linux-user loongarch64-softmmu
     MAKE_CHECK_ARGS: check-tcg
 
 # We build tricore in a very minimal tricore only container
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 80c540230a..d200f3e00d 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -52,6 +52,12 @@ hppa-debian-cross-container:
   variables:
     NAME: debian-hppa-cross
 
+loongarch-debian-cross-container:
+  extends: .container_job_template
+  stage: containers
+  variables:
+    NAME: debian-loongarch-cross
+
 m68k-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index ab68b2dbad..5635d1537f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -125,7 +125,6 @@ docker-image-debian-nios2-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docker \
 DOCKER_PARTIAL_IMAGES += debian-alpha-cross
 DOCKER_PARTIAL_IMAGES += debian-powerpc-test-cross
 DOCKER_PARTIAL_IMAGES += debian-hppa-cross
-DOCKER_PARTIAL_IMAGES += debian-loongarch-cross
 DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
 DOCKER_PARTIAL_IMAGES += debian-mips-cross
diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index b4bf265717..b25e779a2c 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -9,22 +9,42 @@ FROM docker.io/library/debian:11-slim
 # Duplicate deb line as deb-src
 RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
 
+RUN export DEBIAN_FRONTEND=noninteractive && \
+    apt-get update && \
+    apt-get install -y eatmydata && \
+    eatmydata apt-get dist-upgrade -y && \
+    apt build-dep -yy qemu
+
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         build-essential \
+        bison \
         ca-certificates \
+        ccache \
+        clang  \
+        flex \
         curl \
         gettext \
         git \
-        python3-minimal
+        ninja-build \
+        python3-pip \
+        python3-setuptools \
+        python3-venv \
+        python3-wheel
+
+RUN /usr/bin/pip3 install tomli
 
 RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.08/CLFS-loongarch64-8.1-x86_64-cross-tools-gcc-glibc.tar.xz \
     | tar -xJC /opt
 
 ENV PATH $PATH:/opt/cross-tools/bin
 ENV LD_LIBRARY_PATH /opt/cross-tools/lib:/opt/cross-tools/loongarch64-unknown-linux-gnu/lib:$LD_LIBRARY_PATH
+
+ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
+ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch-softmmu
+
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
-- 
2.39.2


