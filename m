Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4637DA67C
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:37:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdE-0006Cz-Vx; Sat, 28 Oct 2023 06:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgdB-0006Al-Mi
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd5-00039H-Ts
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-409299277bbso15369045e9.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489194; x=1699093994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmmVzaMQ0MzDNYa/SE4+Ao0LJRweYzXid6cnF3jeVus=;
 b=UIG/ihdHisyArUX8g0r9UQz9G37nUBwcxOz2+EtZG6bEFsRSfKy50DEEo7zFT0OwL+
 2wt9oGklx5usenqDom7J/MZDgH4KJmWOfGrdWuY3pHNnFIqiH59cnyYmT5T71HO8ISNf
 rbW5ZJzKmMyMOLkGFPC78h6Ghz8DT6r8jAE6pDCjY96Y06/9MevGaGBsAGIkX2NpvwRe
 oOfV85U/ImnF5NWBCDi2WvyG35hsWQfwmMen5qtvSKkhyu17svJ4J4Q/S9pftRBLKx0k
 rDrmzvJPtWvdLv0BOrjKhc4pC1TratwDvMWF7wOQtl/SbbyvTzC+SGAK4FPPPtBwxfnv
 urOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489194; x=1699093994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmmVzaMQ0MzDNYa/SE4+Ao0LJRweYzXid6cnF3jeVus=;
 b=JZk9asGkr8mgjU1yfLHFm307OxFsyMxI0P8On//CZCsJtKgk2W3Z8ohFEOOz0fJGUm
 5Z7TumyZ5FrlzPQJ4DOjf8TV/Uc008L7TrqDgtHRlgU/Qi+lP5vtDZF3HinWaajjODLJ
 6E654YrChCHYWjlND5eYhL5/Ai/4S+rvyJqIDTzJw3t8Hg5YPylIemtORvHBDU3AnM+H
 S2w1JluoahLqZ/k7AJsPQv+jJoOC1dnSaoClQ8nfkMfGgM8aWIQuXBVFOv/QoxB8sSIa
 rFGQYb0ZK91XoG6zpouuH5mBZS/lYQ6OEX+668OFYqccm9v2lXJVWS6o87ix7Subv0Fy
 tZ+g==
X-Gm-Message-State: AOJu0YwCUoR+9mZIQyyVGS6KL9TvrJKtPVsa6xYgfAoIBCJKbF9AZ+1H
 VzBFMDTUvqqIJraUIkFb5UEjPA==
X-Google-Smtp-Source: AGHT+IG2laybkcAyUTlj4d4frPpHwtGo4j1Cm4E9eq3KF9tdxStSRPg5lWL5JVrtGd2h38xkomctqA==
X-Received: by 2002:a05:600c:45c8:b0:401:c338:ab94 with SMTP id
 s8-20020a05600c45c800b00401c338ab94mr4454266wmo.29.1698489194425; 
 Sat, 28 Oct 2023 03:33:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z6-20020a05600c220600b00407b93d8085sm7038650wml.27.2023.10.28.03.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4AA325F799;
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
Subject: [PATCH 03/17] gitlab: split alpha testing into a legacy container
Date: Sat, 28 Oct 2023 11:32:57 +0100
Message-Id: <20231028103311.347104-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

The current bookworm compiler doesn't build the static binaries due to
bug #1054412 and it might be awhile before it gets fixes. The problem
of keeping older architecture compilers running isn't going to go away
so lets prepare the ground. Create a legacy container and move some
tests around so the others can get upgraded.

While checking the softmmu TCG tests I realised more had been added so
that makes up a little bit for the lost alpha-softmmu coverage.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml                    | 20 ++++++--
 .gitlab-ci.d/container-cross.yml              |  6 +++
 .../dockerfiles/debian-all-test-cross.docker  |  4 +-
 .../debian-legacy-test-cross.docker           | 46 +++++++++++++++++++
 4 files changed, 70 insertions(+), 6 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-legacy-test-cross.docker

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 25af1bc41e..d670fb42b9 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -256,6 +256,7 @@ build-user:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system
+      --target-list-exclude=alpha-linux-user
     MAKE_CHECK_ARGS: check-tcg
 
 build-user-static:
@@ -264,6 +265,18 @@ build-user-static:
     job: amd64-debian-user-cross-container
   variables:
     IMAGE: debian-all-test-cross
+    CONFIGURE_ARGS: --disable-tools --disable-system --static
+      --target-list-exclude=alpha-linux-user
+    MAKE_CHECK_ARGS: check-tcg
+
+# targets stuck on older compilers
+build-user-legacy:
+  extends: .native_build_job_template
+  needs:
+    job: amd64-debian-legacy-cross-container
+  variables:
+    IMAGE: debian-legacy-test-cross
+    TARGETS: alpha-linux-user
     CONFIGURE_ARGS: --disable-tools --disable-system --static
     MAKE_CHECK_ARGS: check-tcg
 
@@ -278,6 +291,7 @@ build-user-hexagon:
     MAKE_CHECK_ARGS: check-tcg
 
 # Only build the softmmu targets we have check-tcg tests for
+# (skip alpha due to missing compilers, others need their own containers)
 build-some-softmmu:
   extends: .native_build_job_template
   needs:
@@ -285,7 +299,7 @@ build-some-softmmu:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --enable-debug
-    TARGETS: xtensa-softmmu arm-softmmu aarch64-softmmu alpha-softmmu
+    TARGETS: arm-softmmu aarch64-softmmu i386-softmmu riscv64-softmmu s390x-softmmu xtensa-softmmu
     MAKE_CHECK_ARGS: check-tcg
 
 # We build tricore in a very minimal tricore only container
@@ -318,7 +332,7 @@ clang-user:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-system
-      --target-list-exclude=microblazeel-linux-user,aarch64_be-linux-user,i386-linux-user,m68k-linux-user,mipsn32el-linux-user,xtensaeb-linux-user
+      --target-list-exclude=alpha-linux-user,microblazeel-linux-user,aarch64_be-linux-user,i386-linux-user,m68k-linux-user,mipsn32el-linux-user,xtensaeb-linux-user
       --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
     MAKE_CHECK_ARGS: check-unit check-tcg
 
@@ -505,7 +519,7 @@ build-tci:
   variables:
     IMAGE: debian-all-test-cross
   script:
-    - TARGETS="aarch64 alpha arm hppa m68k microblaze ppc64 s390x x86_64"
+    - TARGETS="aarch64 arm hppa m68k microblaze ppc64 s390x x86_64"
     - mkdir build
     - cd build
     - ../configure --enable-tcg-interpreter --disable-docs --disable-gtk --disable-vnc
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 2848166ba3..80c540230a 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -16,6 +16,12 @@ amd64-debian-user-cross-container:
   variables:
     NAME: debian-all-test-cross
 
+amd64-debian-legacy-cross-container:
+  extends: .container_job_template
+  stage: containers
+  variables:
+    NAME: debian-legacy-test-cross
+
 arm64-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 54e957d5e7..205173b0a5 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -28,8 +28,6 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         ninja-build \
         gcc-aarch64-linux-gnu \
         libc6-dev-arm64-cross \
-        gcc-alpha-linux-gnu \
-        libc6.1-dev-alpha-cross \
         gcc-arm-linux-gnueabihf \
         libc6-dev-armhf-cross \
         gcc-hppa-linux-gnu \
@@ -66,7 +64,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
 RUN /usr/bin/pip3 install tomli
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
-ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
+ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
new file mode 100644
index 0000000000..763d36dfe3
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
@@ -0,0 +1,46 @@
+# Docker legacy cross-compiler target (tests and minimal qemu)
+#
+# Compilers for some of our older targets which we cant currently
+# upgrade. Currently:
+#
+#   libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
+#
+# As we are targeting check-tcg here we only need minimal qemu
+# dependencies and the relevant cross compilers.
+
+FROM docker.io/library/debian:11-slim
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+
+RUN export DEBIAN_FRONTEND=noninteractive && \
+    apt-get update && \
+    apt-get install -y eatmydata && \
+    eatmydata apt-get dist-upgrade -y && \
+    apt build-dep -yy qemu
+
+# Add extra build tools and as many cross compilers as we can for testing
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+        apt install -y --no-install-recommends \
+        bison \
+        ccache \
+        clang  \
+        flex \
+        git \
+        ninja-build \
+        gcc-alpha-linux-gnu \
+        libc6.1-dev-alpha-cross \
+        python3-pip \
+        python3-setuptools \
+        python3-venv \
+        python3-wheel
+
+RUN /usr/bin/pip3 install tomli
+
+ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
+ENV DEF_TARGET_LIST alpha-linux-user
+# As a final step configure the user (if env is defined)
+ARG USER
+ARG UID
+RUN if [ "${USER}" ]; then \
+  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.39.2


