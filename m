Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE36C7A2202
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:11:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhARd-0003Vw-D7; Fri, 15 Sep 2023 11:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARF-0003Bi-NG
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARB-00028m-Ib
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31aeef88a55so1966174f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694790531; x=1695395331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3U6CnUO4H14TWX5ohGrwMIlPaGspMb8A4A9i0+k5wOY=;
 b=I1IkS+K6jnCb2pJ+v0NbsftTKWD+4d0ZV91LgFXw1kVF4PlXf4iOGhwgmOiaQHJ5zI
 FmxXUdFunSFEY19u1e4ojemBcm9/13lQar2lGDCjTAdfkTdRHILUUa0XLNMBA0lOEZWF
 zyCEwUNStTTbn0xbK7U5i7Iysyv5M0K4hxn84QAhW5YAKPSRdxjk+Vxs2k/+j2fdsGt5
 RD725QS7CAYKnG88hB3bWwMZVEcOKrKxdnpGhQTbIes66cmJzbUCEaQpCxWt+3ZrDUUU
 2sbtVaRfUYvVvpXz6P9Ubk7VPZoiavNoMc0/wYfZcYM3zES1VuIQJLd+vf1nMH1bEK7F
 aaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694790531; x=1695395331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3U6CnUO4H14TWX5ohGrwMIlPaGspMb8A4A9i0+k5wOY=;
 b=OIORixz1kuflHQ2GTUbYx/mPqil/amWC/LhqRAimFGf/omEfhWsSBFeXzJS4GVUqea
 gmVu/TK87LfFs0mJsoYCdjb1HNmBchHFNDnBI/1BaOv1FzTXz02zu2klg7/RQ8NWZqq5
 4nE1EI8VVIdavBJnrLsxsd65wqPHB7oxoeDI1tX9ANZ7kJKZ6Pb0dE+QzwpWFjtD9GYM
 8Z3b/Q0/wd6+ItwSx4o9FbHI5S86O7/tfcajlSs+Lby51tm0fPVnjcfkPtLwG4bDdJuE
 TpC2TAUXDbSTV7/c/UsNq+xsdATgIzkC4I21Vi6jfzKmZ05K2G5ZNfvXkP0WSAdtWbZN
 DxOg==
X-Gm-Message-State: AOJu0YyQFdiQ2JQRuLT4IQwE0ppl7q2PL8/MGUL+tOtzMrN7eb8BSTLr
 QM3cNONKnt98R2hr8ZFZkIErgA==
X-Google-Smtp-Source: AGHT+IETxEyINegd9fFmiSsJQeSp9cWdLmSRsdO1dCzn4SqMT3nhXOvrwe/JLBee8xaPNc2KtqheQA==
X-Received: by 2002:a5d:5011:0:b0:313:f399:6cea with SMTP id
 e17-20020a5d5011000000b00313f3996ceamr1813982wrt.4.1694790531231; 
 Fri, 15 Sep 2023 08:08:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o6-20020adfeac6000000b0031c6dc684f8sm4648409wrn.20.2023.09.15.08.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:08:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 196991FFBC;
 Fri, 15 Sep 2023 16:08:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 1/9] tests: update Debian images to Bookworm
Date: Fri, 15 Sep 2023 16:08:41 +0100
Message-Id: <20230915150849.595896-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150849.595896-1-alex.bennee@linaro.org>
References: <20230915150849.595896-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Bookworm has been out a while now. Time to update our containers to
the current stable. This requires the latest lcitool repo so update
the sub-module too.

For some reason the MIPs containers won't build so skip those for now.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230914155422.426639-2-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index b66b9cc191..abbf45d402 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch x86_64 debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch x86_64 debian-12 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -47,11 +47,9 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
-                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
-                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -67,8 +65,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
-RUN /usr/bin/pip3 install tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
@@ -84,7 +80,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       g++-x86-64-linux-gnu \
                       gcc-x86-64-linux-gnu \
                       libaio-dev:amd64 \
-                      libasan5:amd64 \
+                      libasan6:amd64 \
                       libasound2-dev:amd64 \
                       libattr1-dev:amd64 \
                       libbpf-dev:amd64 \
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 02262bc70e..a60afa2166 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all debian-11 qemu
+#  $ lcitool dockerfile --layers all debian-12 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -32,7 +32,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libaio-dev \
-                      libasan5 \
+                      libasan6 \
                       libasound2-dev \
                       libattr1-dev \
                       libbpf-dev \
@@ -115,11 +115,9 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
-                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
-                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -145,8 +143,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3 install tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index a0a968b8c6..64cf42728b 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch aarch64 debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch aarch64 debian-12 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -47,11 +47,9 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
-                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
-                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -67,8 +65,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
-RUN /usr/bin/pip3 install tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
@@ -84,7 +80,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       g++-aarch64-linux-gnu \
                       gcc-aarch64-linux-gnu \
                       libaio-dev:arm64 \
-                      libasan5:arm64 \
+                      libasan6:arm64 \
                       libasound2-dev:arm64 \
                       libattr1-dev:arm64 \
                       libbpf-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index f1fc34a28a..de72903fb2 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch armv6l debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch armv6l debian-12 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -47,11 +47,9 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
-                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
-                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -67,8 +65,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
-RUN /usr/bin/pip3 install tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
@@ -84,7 +80,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       g++-arm-linux-gnueabi \
                       gcc-arm-linux-gnueabi \
                       libaio-dev:armel \
-                      libasan5:armel \
+                      libasan6:armel \
                       libasound2-dev:armel \
                       libattr1-dev:armel \
                       libbpf-dev:armel \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index a278578211..2274f3d005 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch armv7l debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch armv7l debian-12 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -47,11 +47,9 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
-                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
-                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -67,8 +65,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
-RUN /usr/bin/pip3 install tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
@@ -84,7 +80,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       g++-arm-linux-gnueabihf \
                       gcc-arm-linux-gnueabihf \
                       libaio-dev:armhf \
-                      libasan5:armhf \
+                      libasan6:armhf \
                       libasound2-dev:armhf \
                       libattr1-dev:armhf \
                       libbpf-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 30e5efa986..bb9e88c7b3 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch ppc64le debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch ppc64le debian-12 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -47,11 +47,9 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
-                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
-                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -67,8 +65,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
-RUN /usr/bin/pip3 install tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
@@ -84,7 +80,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       g++-powerpc64le-linux-gnu \
                       gcc-powerpc64le-linux-gnu \
                       libaio-dev:ppc64el \
-                      libasan5:ppc64el \
+                      libasan6:ppc64el \
                       libasound2-dev:ppc64el \
                       libattr1-dev:ppc64el \
                       libbpf-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index ee6db7b526..503d466dbc 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch s390x debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch s390x debian-12 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -47,11 +47,9 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
-                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
-                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
@@ -67,8 +65,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales
 
-RUN /usr/bin/pip3 install tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
@@ -84,7 +80,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       g++-s390x-linux-gnu \
                       gcc-s390x-linux-gnu \
                       libaio-dev:s390x \
-                      libasan5:s390x \
+                      libasan6:s390x \
                       libasound2-dev:s390x \
                       libattr1-dev:s390x \
                       libbpf-dev:s390x \
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
index 4180cd8674..d3e212060c 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -32,7 +32,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libaio-dev \
-                      libasan5 \
+                      libasan6 \
                       libasound2-dev \
                       libattr1-dev \
                       libbrlapi-dev \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 88493f00f6..94c2c16118 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -32,7 +32,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libaio-dev \
-                      libasan5 \
+                      libasan6 \
                       libasound2-dev \
                       libattr1-dev \
                       libbpf-dev \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index bbd55b4d18..e6c1d040f6 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit bbd55b4d18cce8f89b5167675e434a6941315634
+Subproject commit e6c1d040f66e5badf4bd1ab54d98a534c6510f5e
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 4584870ea1..8b1adfbdfb 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -93,7 +93,7 @@ def generate_pkglist(vm, target):
 # Netmap still needs to be manually built as it is yet to be packaged
 # into a distro. We also add cscope and gtags which are used in the CI
 # test
-debian11_extras = [
+debian12_extras = [
     "# netmap/cscope/global\n",
     "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
     "  apt install -y --no-install-recommends \\\n",
@@ -123,8 +123,8 @@ try:
     #
     generate_dockerfile("alpine", "alpine-318")
     generate_dockerfile("centos8", "centos-stream-8")
-    generate_dockerfile("debian-amd64", "debian-11",
-                        trailer="".join(debian11_extras))
+    generate_dockerfile("debian-amd64", "debian-12",
+                        trailer="".join(debian12_extras))
     generate_dockerfile("fedora", "fedora-38")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
     generate_dockerfile("ubuntu2004", "ubuntu-2004")
@@ -133,24 +133,24 @@ try:
     #
     # Cross compiling builds
     #
-    generate_dockerfile("debian-amd64-cross", "debian-11",
+    generate_dockerfile("debian-amd64-cross", "debian-12",
                         cross="x86_64",
                         trailer=cross_build("x86_64-linux-gnu-",
                                             "x86_64-softmmu,"
                                             "x86_64-linux-user,"
                                             "i386-softmmu,i386-linux-user"))
 
-    generate_dockerfile("debian-arm64-cross", "debian-11",
+    generate_dockerfile("debian-arm64-cross", "debian-12",
                         cross="aarch64",
                         trailer=cross_build("aarch64-linux-gnu-",
                                             "aarch64-softmmu,aarch64-linux-user"))
 
-    generate_dockerfile("debian-armel-cross", "debian-11",
+    generate_dockerfile("debian-armel-cross", "debian-12",
                         cross="armv6l",
                         trailer=cross_build("arm-linux-gnueabi-",
                                             "arm-softmmu,arm-linux-user,armeb-linux-user"))
 
-    generate_dockerfile("debian-armhf-cross", "debian-11",
+    generate_dockerfile("debian-armhf-cross", "debian-12",
                         cross="armv7l",
                         trailer=cross_build("arm-linux-gnueabihf-",
                                             "arm-softmmu,arm-linux-user"))
@@ -165,7 +165,7 @@ try:
                         trailer=cross_build("mipsel-linux-gnu-",
                                             "mipsel-softmmu,mipsel-linux-user"))
 
-    generate_dockerfile("debian-ppc64el-cross", "debian-11",
+    generate_dockerfile("debian-ppc64el-cross", "debian-12",
                         cross="ppc64le",
                         trailer=cross_build("powerpc64le-linux-gnu-",
                                             "ppc64-softmmu,ppc64-linux-user"))
@@ -176,7 +176,7 @@ try:
                         trailer=cross_build("riscv64-linux-gnu-",
                                             "riscv64-softmmu,riscv64-linux-user"))
 
-    generate_dockerfile("debian-s390x-cross", "debian-11",
+    generate_dockerfile("debian-s390x-cross", "debian-12",
                         cross="s390x",
                         trailer=cross_build("s390x-linux-gnu-",
                                             "s390x-softmmu,s390x-linux-user"))
-- 
2.39.2


