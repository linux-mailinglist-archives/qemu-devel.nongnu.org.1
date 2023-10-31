Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 656137DCF89
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:45:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpyW-0004oC-Bz; Tue, 31 Oct 2023 10:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyU-0004nc-EH
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:10 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyR-000299-6S
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:09 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507a55302e0so8157794e87.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763445; x=1699368245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDwhAtHS+d6WUGQVUolnjo7slYgF5qy8hsz+yP82M5I=;
 b=Tpx3QEfZW7ZkiQhMorV4ACcpTmjXs05m/Be2IUktZVerW/vl1KhTv1kGOGspJFgbWh
 R/oRe+3fDiDSHGXzOaLaNnpOeuvlAIcS/GZUwtzgypBJPCzNI/PhTLdRg0Ts00LVJItl
 x92FqJSoLma97jEbSvP58zxkCnEMjb5VW9fWecx/xAGEF2AZVIGwUd5zx2ZHIrmuCT2p
 hajqh6Qvg7A6SC2YoFMUUVwqwIq2Z0qeexM9sXxb3kIlJ+hZa58OGJqhXjLWqtl2GAro
 Dw+TivcrtSmOMGDc+9cxMdm1ew7z7gvyihjKnIuwiP8s2HtCyW42ozitW5hgp+giV7pi
 K5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763445; x=1699368245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XDwhAtHS+d6WUGQVUolnjo7slYgF5qy8hsz+yP82M5I=;
 b=GJy3hpXNaOk/qlC5DXypIZd4XuG6/4LgKmQte296Bo8AKplZixbZ1Vj3lvt2R16Jgd
 2HgJtHNui4RAygYl/pBLQ6vnsF9kkdntIuElM/+ik1p9lHzItU1caaDZbZaq1p3E4xqT
 IduA8/2iDBH+SUg1LiwKaSqAENd64gPZqEzluKmYtN4DFoFp7kFWRIHNcKnw7sr/bNoo
 /UTHbtMbzZs5CsEVpDGN8fui8yRKK6XThgEDezvCmsUtBi4bOAjKaM5xScufRr5vo6xH
 OaGtz87Dd2T80XWACxD+DaiHDmZ1fEoDPVA3s9+Ou3woXt92Gu3MqKqaXmKXIQmNlQLT
 sMEg==
X-Gm-Message-State: AOJu0YwE7D0JXgcxgwICYyl2r3RgewjbQN2s4SKj0zTsukpdda7icT04
 wv7SldmJUQnbOEqASrYzP/SWbw==
X-Google-Smtp-Source: AGHT+IGckidljawGozS67yHP4gRmV1qZ01bTFNM67Bg0zQ7hkxKQtPuCcMonmgYh7gwjmt8W5ds5pg==
X-Received: by 2002:ac2:4d17:0:b0:509:fc0:9267 with SMTP id
 r23-20020ac24d17000000b005090fc09267mr6230097lfi.15.1698763445599; 
 Tue, 31 Oct 2023 07:44:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t4-20020adff604000000b0032db4e660d9sm1670110wrp.56.2023.10.31.07.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1938B65723;
 Tue, 31 Oct 2023 14:44:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 03/19] gitlab: split alpha testing into a legacy container
Date: Tue, 31 Oct 2023 14:43:45 +0000
Message-Id: <20231031144401.1238210-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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

The current bookworm compiler doesn't build the static binaries due to
bug #1054412 and it might be awhile before it gets fixed. The problem
of keeping older architecture compilers running isn't going to go away
so lets prepare the ground. Create a legacy container and move some
tests around so the others can get upgraded.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231029145033.592566-4-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 25af1bc41e..bb24e052f6 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -256,6 +256,7 @@ build-user:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system
+      --target-list-exclude=alpha-linux-user
     MAKE_CHECK_ARGS: check-tcg
 
 build-user-static:
@@ -265,6 +266,18 @@ build-user-static:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system --static
+      --target-list-exclude=alpha-linux-user
+    MAKE_CHECK_ARGS: check-tcg
+
+# targets stuck on older compilers
+build-legacy:
+  extends: .native_build_job_template
+  needs:
+    job: amd64-debian-legacy-cross-container
+  variables:
+    IMAGE: debian-legacy-test-cross
+    TARGETS: alpha-linux-user alpha-softmmu
+    CONFIGURE_ARGS: --disable-tools
     MAKE_CHECK_ARGS: check-tcg
 
 build-user-hexagon:
@@ -285,7 +298,7 @@ build-some-softmmu:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --enable-debug
-    TARGETS: xtensa-softmmu arm-softmmu aarch64-softmmu alpha-softmmu
+    TARGETS: xtensa-softmmu arm-softmmu aarch64-softmmu
     MAKE_CHECK_ARGS: check-tcg
 
 # We build tricore in a very minimal tricore only container
@@ -318,7 +331,7 @@ clang-user:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-system
-      --target-list-exclude=microblazeel-linux-user,aarch64_be-linux-user,i386-linux-user,m68k-linux-user,mipsn32el-linux-user,xtensaeb-linux-user
+      --target-list-exclude=alpha-linux-user,microblazeel-linux-user,aarch64_be-linux-user,i386-linux-user,m68k-linux-user,mipsn32el-linux-user,xtensaeb-linux-user
       --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
     MAKE_CHECK_ARGS: check-unit check-tcg
 
@@ -505,7 +518,7 @@ build-tci:
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


