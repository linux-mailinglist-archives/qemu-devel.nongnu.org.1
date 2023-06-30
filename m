Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DDD744221
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:24:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFImR-0004eA-Lc; Fri, 30 Jun 2023 14:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFImP-0004cy-MJ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:23:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFImH-0001fu-PM
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:23:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc54caad5so13708585e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688149408; x=1690741408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYONftyZEy/mDoKyYXPlJOEpSTTJ0oXWSrdquW0QcdQ=;
 b=LLFK0WGd1DDW+D3QyF57wT+EkNcUlUbXslQftYe8FwW7qsr6zjXSX43Ghi8WcEVxv+
 bQc17vMwh/+HXgoafUUK/oxQ/Tvtupvl6T+nYREsXtThhCEyrqO/iuHoqKTu2UiR2ePv
 NxHtYVb2zZBJTPKxXviaFkA+bdlNKixvCuHQfaZZ9HE8qDlNaHxbzuD1v3XE5f2VhVmR
 Xm+5ru//YwrmJdOKFBUH6xHxBTRB8o38ha2Q0E6Jvfz0HNI/Y3FD9tYKha5mkxvCUTJ+
 JkWxp99GI6Lg8t0dAxBK0y0OGk12gVUFBnQ4AWPQ5LqODH0cW3s/8DRi66mWm92S2NKC
 stcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688149408; x=1690741408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYONftyZEy/mDoKyYXPlJOEpSTTJ0oXWSrdquW0QcdQ=;
 b=UQ3YxpGL9DYlDBB+qSU1n8DQGAYRFnnUeL8CtI/+FvpGa4wNbVwbHX40X4PBSJvoXr
 ZZalyHeKbAuxjPILai1e9R1aUR4Q8P1AseBpaCxuSNF5xQXiIjsYyU/BeHSBQEvqcuD0
 HNBsXtmSph2EJ6CzqoYqaYt3Vn72fmdKa/ZcDCHjNm4nqJKLow624F2qCVGph17uPsSV
 hWujJXV8KhyctzxZWmI+PDQKl+ZyMhglUjN6yEd5ookn+hMNwRh3qMngPVx3Hjg7Z/Xk
 g974xhFwIe+38PRcQ779z0LoBEWrq1CwUesRHEo872yVsv2cqedSk/+Xkl6xbf9WZxSr
 W/SA==
X-Gm-Message-State: AC+VfDzaqrAWLt/obygyAIOfYzbAsUkYRqUXCPVASHYCQ3z/Fba6BTea
 P4AnJVtOLir8KzhzgIKFvIEhaw==
X-Google-Smtp-Source: ACHHUZ4A8vApT5elwEgpYpWxShjuLMbONT0TjFff70hJJGjVSUCZI9pRLPR2hqXEpxPPxbRqhoyM2w==
X-Received: by 2002:a1c:4c12:0:b0:3fb:b1af:a455 with SMTP id
 z18-20020a1c4c12000000b003fbb1afa455mr2712307wmf.5.1688149408151; 
 Fri, 30 Jun 2023 11:23:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z26-20020a1c4c1a000000b003f91e32b1ebsm10231195wmf.17.2023.06.30.11.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:23:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A2C991FFC7;
 Fri, 30 Jun 2023 19:04:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v4 15/38] tests/docker: convert riscv64-cross to lcitool
Date: Fri, 30 Jun 2023 19:04:00 +0100
Message-Id: <20230630180423.558337-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

We still need to base this on Debian Sid until riscv64 is promoted to
a release architecture (or another distro provides a full cross
compile target). We use the new qemu-minimal project description to
avoid bringing in all the extra dependencies because every extra
package is another chance for sid to fail.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - moved qemu-minimal changes to previous commit
---
 .../dockerfiles/debian-riscv64-cross.docker   | 119 +++++++++++-------
 tests/lcitool/refresh                         |  10 +-
 2 files changed, 83 insertions(+), 46 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 081404e014..a2d879ee1f 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -1,54 +1,85 @@
+# THIS FILE WAS AUTO-GENERATED
 #
-# Docker cross-compiler target for riscv64
+#  $ lcitool dockerfile --layers all --cross riscv64 debian-sid qemu-minimal
 #
-# Currently the only distro that gets close to cross compiling riscv64
-# images is Debian Sid (with unofficial ports). As this is a moving
-# target we keep the library list minimal and are aiming to migrate
-# from this hack as soon as we are able.
-#
-FROM docker.io/library/debian:sid-slim
+# https://gitlab.com/libvirt/libvirt-ci
 
-# Add ports
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
-    DEBIAN_FRONTEND=noninteractive eatmydata apt update -yy && \
-    DEBIAN_FRONTEND=noninteractive eatmydata apt upgrade -yy
-
-# Install common build utilities
-RUN DEBIAN_FRONTEND=noninteractive eatmydata apt install -yy \
-    bison \
-    bc \
-    build-essential \
-    ca-certificates \
-    debian-ports-archive-keyring \
-    dpkg-dev \
-    flex \
-    gettext \
-    git \
-    libglib2.0-dev \
-    ninja-build \
-    pkg-config \
-    python3 \
-    python3-venv
+FROM docker.io/library/debian:sid-slim
 
-# Add ports and riscv64 architecture
-RUN echo "deb http://ftp.ports.debian.org/debian-ports/ sid main" >> /etc/apt/sources.list
-RUN dpkg --add-architecture riscv64
+RUN export DEBIAN_FRONTEND=noninteractive && \
+    apt-get update && \
+    apt-get install -y eatmydata && \
+    eatmydata apt-get dist-upgrade -y && \
+    eatmydata apt-get install --no-install-recommends -y \
+                      bash \
+                      bc \
+                      bison \
+                      ca-certificates \
+                      ccache \
+                      findutils \
+                      flex \
+                      gcc \
+                      git \
+                      libglib2.0-dev \
+                      locales \
+                      make \
+                      meson \
+                      ninja-build \
+                      pkgconf \
+                      python3 \
+                      python3-venv \
+                      sed \
+                      tar && \
+    eatmydata apt-get autoremove -y && \
+    eatmydata apt-get autoclean -y && \
+    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
+    dpkg-reconfigure locales
 
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
+ENV LANG "en_US.UTF-8"
+ENV MAKE "/usr/bin/make"
+ENV NINJA "/usr/bin/ninja"
+ENV PYTHON "/usr/bin/python3"
 
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt install -y --no-install-recommends \
-         gcc-riscv64-linux-gnu \
-         libc6-dev-riscv64-cross \
-         libfdt-dev:riscv64 \
-         libffi-dev:riscv64 \
-         libglib2.0-dev:riscv64 \
-         libpixman-1-dev:riscv64
+RUN export DEBIAN_FRONTEND=noninteractive && \
+    dpkg --add-architecture riscv64 && \
+    eatmydata apt-get install debian-ports-archive-keyring && \
+    eatmydata echo 'deb http://ftp.ports.debian.org/debian-ports/ sid main' > /etc/apt/sources.list.d/ports.list && \
+    eatmydata echo 'deb http://ftp.ports.debian.org/debian-ports/ unreleased main' >> /etc/apt/sources.list.d/ports.list && \
+    eatmydata apt-get update && \
+    eatmydata apt-get dist-upgrade -y && \
+    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
+    eatmydata apt-get install --no-install-recommends -y \
+                      g++-riscv64-linux-gnu \
+                      gcc-riscv64-linux-gnu \
+                      libc6-dev:riscv64 \
+                      libfdt-dev:riscv64 \
+                      libffi-dev:riscv64 \
+                      libglib2.0-dev:riscv64 \
+                      libpixman-1-dev:riscv64 && \
+    eatmydata apt-get autoremove -y && \
+    eatmydata apt-get autoclean -y && \
+    mkdir -p /usr/local/share/meson/cross && \
+    printf "[binaries]\n\
+c = '/usr/bin/riscv64-linux-gnu-gcc'\n\
+ar = '/usr/bin/riscv64-linux-gnu-gcc-ar'\n\
+strip = '/usr/bin/riscv64-linux-gnu-strip'\n\
+pkgconfig = '/usr/bin/riscv64-linux-gnu-pkg-config'\n\
+\n\
+[host_machine]\n\
+system = 'linux'\n\
+cpu_family = 'riscv64'\n\
+cpu = 'riscv64'\n\
+endian = 'little'\n" > /usr/local/share/meson/cross/riscv64-linux-gnu && \
+    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
+    mkdir -p /usr/libexec/ccache-wrappers && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-c++ && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-cc && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-g++ && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-gcc
 
-# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV ABI "riscv64-linux-gnu"
+ENV MESON_OPTS "--cross-file=riscv64-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=riscv64-linux-gnu-
 ENV DEF_TARGET_LIST riscv64-softmmu,riscv64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 5e06fb2cf5..b54566edcc 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -63,12 +63,12 @@ add_user_mapping = [
     "  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi\n"
 ]
 
-def generate_dockerfile(host, target, cross=None, trailer=None):
+def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None):
     filename = Path(src_dir, "tests", "docker", "dockerfiles", host + ".docker")
     cmd = lcitool_cmd + ["dockerfile"]
     if cross is not None:
         cmd.extend(["--cross", cross])
-    cmd.extend([target, "qemu"])
+    cmd.extend([target, project])
 
     if trailer is not None:
         trailer += "\n".join(add_user_mapping)
@@ -164,6 +164,12 @@ try:
                         trailer=cross_build("powerpc64le-linux-gnu-",
                                             "ppc64-softmmu,ppc64-linux-user"))
 
+    generate_dockerfile("debian-riscv64-cross", "debian-sid",
+                        project="qemu-minimal",
+                        cross="riscv64",
+                        trailer=cross_build("riscv64-linux-gnu-",
+                                            "riscv64-softmmu,riscv64-linux-user"))
+
     generate_dockerfile("debian-s390x-cross", "debian-11",
                         cross="s390x",
                         trailer=cross_build("s390x-linux-gnu-",
-- 
2.39.2


