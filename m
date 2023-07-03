Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 814FD745DE5
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:53:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJzj-0000YC-UO; Mon, 03 Jul 2023 09:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzg-0000Tj-P1
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:32 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJze-00081a-1K
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:32 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fb761efa7aso6914715e87.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392408; x=1690984408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3g1ZdS6tVQBEMQ0D/vXzVLJC2cdpbVKGouDWEpjqWrs=;
 b=BqNSa4sGy0jqk0Ng/If3hEBucc+vnYEzH3ZaGo1qowR+ht25Rog9GosjNLNCS26cDc
 qE7i7zn6idyWklVB9VBlVtYjYRMPn5SZb1Zd/8xSmoatv2STQ0gaNW5ODAZXYdZY0TJe
 jsvY9OWQAVwPt/+i9/K5tDaHQm4Rt2JR2RFhpv5wh14mgwKuTfsjRmLboP90LCulCa14
 +i5jkjtbKS1B9nyN3LNbUmKw/UHtMbHGH3yo94Gtkh6/lj9cb75TCOgh5A+8XI11iR5n
 jUtcJUhA0mFqH4beqiB4bxbz+8sT5KHwJ08B2w/yP23cRV2zEBAF1cObGQGQqHQLuCR5
 9R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392408; x=1690984408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3g1ZdS6tVQBEMQ0D/vXzVLJC2cdpbVKGouDWEpjqWrs=;
 b=YDK+ljMrFntFulAgZijXW5h/J1tkPazV4nu1tTDB0kGqDdKpzrtyQ1WntOsQn0Fd3C
 Pm1ESh47mdj5wrODnW6rArGVhPVoyhVjZBCyWk5s+LcJFRv2nCoJHjtDNiPqmGlEN/kB
 04kX7fdS2kekXATVAqzeEgmDNediSqhI2tZeN1mePBK+NSCAuMmobqtfHtTaKk6J6nH2
 NsOZV+ZetEORz4SoTGzp7aBBDRz9La9iG1UlzNP8e7oACQQdP0aBRG926YJLbTNEOcYw
 qiU5ixSQlzcToNEYdcnwVVnWnf0hPqWpj9305sxzO5EzUPS02qw3Ai0ytqkRz5MVV2Vp
 SJnQ==
X-Gm-Message-State: ABy/qLZheIVTw5xEO+Zc1TbqbpYNhCW95SSYhh0doAL556ZP0nP51O9O
 vMCklcJKpS/Z1ggpq8EZdsjUTA==
X-Google-Smtp-Source: APBJJlFYOChk+Y5gCp5q7eVR23Xaiy+busrbhNoFMfd6wL50EV7OBP+My2xi+q/lsic3y88HO/mraA==
X-Received: by 2002:a05:6512:2811:b0:4fb:92df:a27b with SMTP id
 cf17-20020a056512281100b004fb92dfa27bmr8358926lfb.39.1688392408299; 
 Mon, 03 Jul 2023 06:53:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bcd0a000000b003fa99969e61sm21413074wmj.45.2023.07.03.06.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 595C01FFC5;
 Mon,  3 Jul 2023 14:44:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 13/38] tests/lcitool: add an explicit gcc-native package
Date: Mon,  3 Jul 2023 14:44:02 +0100
Message-Id: <20230703134427.1389440-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x129.google.com
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

We need a native compiler to build the hexagon codegen tools. In our
current images we already have a gcc as a side effect of a broken
dependency between gcovr and lcov but this will be fixed when we move
to bookworm. See
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=987818 for details.

Update the packages while we are at it.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-14-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 40a2b6acc4..016c2321f1 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index c99300bbfa..3c114efa11 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index 5db5c78b31..dfbd47db89 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index ae6600b25f..4e0084e896 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index daa2d48e36..88adf333e9 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 5af04e2054..256e8b5dfe 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 1eeba7fcab..4d19cd2bd7 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 52e89a6dab..642bbde3d1 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
index a0a3cd9e5b..e3dfd68bed 100644
--- a/tests/docker/dockerfiles/fedora-win32-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win32-cross.docker
@@ -29,6 +29,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                diffutils \
                findutils \
                flex \
+               gcc \
                gcovr \
                git \
                glib2-devel \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index b6c1a6a339..0e15c9643a 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -29,6 +29,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                diffutils \
                findutils \
                flex \
+               gcc \
                gcovr \
                git \
                glib2-devel \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 566db8313b..21fd3d2cf9 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -24,6 +24,7 @@ packages:
  - fuse3
  - g++
  - gcc
+ - gcc-native
  - gcovr
  - gettext
  - glib2
-- 
2.39.2


