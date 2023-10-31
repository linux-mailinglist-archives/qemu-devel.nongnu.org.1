Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5440C7DCF86
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:45:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpyY-0004oo-2r; Tue, 31 Oct 2023 10:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyW-0004oI-8A
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyT-00029t-Ae
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40859c46447so37953825e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763448; x=1699368248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UP+el9zXc/Zi57Qh90eA4w6Sr5YdMSWfNVrtYXcuHAY=;
 b=FjI0SGClXsOb1d5TeCO9Ut9dorBVqQOsp4xdafhJb66m6WbSREZXg5zzCMOylqkvCI
 WEBL0ii1/Pr0iuwZW5UYtzZxtTtS5f00S/gBzTsSl5Mngk0S5nBhdSWtOQvM3aTUUoOA
 TwRC/+Ih7q16S9aPCPRiKVIADI+740Q5DKvfx4fT5w9RXvAZbQY0rzAjeuh/oFkKXylG
 XTMLRdgi9VHX8JM/C0lHu9vokoCsoKiMEldjBAU0A0t1ufCqX4VraRVYfhvcet+rYJsn
 E44SzRQgdm6xsa6lQ97pt8OnyMdL4ECvRcqs/kAjzarGp+jRNCTUexo/RRZyOjrU4asv
 T2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763448; x=1699368248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UP+el9zXc/Zi57Qh90eA4w6Sr5YdMSWfNVrtYXcuHAY=;
 b=j+c1QQCyC9eM2YcAzH3wg0c1UH/OZHUG9Qid91B80T6P47GvUKiiuVXTG9NlUEqbl5
 7FYOlainECH/NueQnq3j13j3TPNVx3bB1V9ALKN9xAhjiSiXPQU8pC2Jj4rea17wHn3v
 LlzjSSV40mZ5JeaPpWBX/RD8CekqZQP2Q9fTD6eMsDk0mJkk/6BG+BbDsZ+jEDqemrnO
 qSLROgs7rzZFGwD5wq+2AL4hBFHsohXoRIUW1j4RaJ7PiEwA3FkR47Tr2ihZxbmziHRC
 pWGn6g8MQ3ZdhE8niI67ofl66bK/MQTrctnQNQOseqYR7yFn/YWlNw4GHhNC9prg21un
 Hp5Q==
X-Gm-Message-State: AOJu0YxbLm/pQePCoBBM3rIOhUwNy2anLL4dJvxIIZ9XAqoCyB59t7NH
 mib2wC1tuaRbppYnvJuNXLjMTNbBf4Uzlehyz+Q=
X-Google-Smtp-Source: AGHT+IHRmAC78i8Kk3yG+4mH/LPADV6L1YyHHWKAEi7ADKTm8J9TWuk0nL/L4TXmf+cL9dTgOziUHA==
X-Received: by 2002:a05:600c:4e89:b0:406:545a:f8fe with SMTP id
 f9-20020a05600c4e8900b00406545af8femr11441935wmq.29.1698763447933; 
 Tue, 31 Oct 2023 07:44:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a18-20020a5d5092000000b0032db8f7f378sm1662959wrt.71.2023.10.31.07.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 42EC065725;
 Tue, 31 Oct 2023 14:44:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 05/19] gitlab: add build-loongarch to matrix
Date: Tue, 31 Oct 2023 14:43:47 +0000
Message-Id: <20231031144401.1238210-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
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

We have the compiler and with a few updates a container that can build
QEMU so we should at least run the check-tcg smoke tests.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231029145033.592566-6-alex.bennee@linaro.org>

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


