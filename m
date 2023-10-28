Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B24757DA66E
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:34:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdU-0006On-31; Sat, 28 Oct 2023 06:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgdQ-0006Nk-Lc
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd6-0003AL-HE
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso22574445e9.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489199; x=1699093999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBUDJb1FmN0uo5F4PjILA3VIdrQLeL6tJBLzek5+1QM=;
 b=soGQZHZj32t9DbXoJIF3AmFSaXX1Mj6s06yBKaXobkC8rqWcfyNljka1Lj73PSppRc
 M73eulFIP66BeOIfZ3VtwN7oS4ycjhZF61YaO7Jex2DNfuL4fkcAL5w+DBYTHdlWdndD
 XrNxRbifB5T4Bd5Djx/zGxpnMecGWFIVW2ChNJqq9lZ340TvR3HJ77fv/OuEN1Zre0xP
 BYz41MAWb5xf346QY9yz1WnwW4vvPMKB8w/1LAnOpXwW8YCU/r+Xnb2gVSq5smEBq/i/
 3KZwtueh1iqEVFE3OAeS6qelxDiJZrsKAgFWpRwm+UQ4bTA06avMs6x9gZsojETRAdQi
 Ozqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489199; x=1699093999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBUDJb1FmN0uo5F4PjILA3VIdrQLeL6tJBLzek5+1QM=;
 b=Z7qwWn8OEct0HDrDEZX/ammj5KPl5LtEMvVgW2qTQRYnKvZw79+Q4+zgKE0COxGz67
 Yt0i5nm5L5zjJZytO3dZPZSZZbrsj+mpwHxlw11TxAyyYxF5+WZJjm6KemzrWkCpJCsC
 GAnGz0o/4cqRiOR3LyvVSoTk/Wgjm8wLgOPDzgZmmdxHKDRwxcV4CcyQ+n2SU8IIwwaY
 fby5f3b9NcabPEK5jXMRF55M08Q8Zq0a06KvHGPTfzdI1jfXI+mQeQxO+QNQ5pCpxb0Z
 EynEiB/Ebagoo3tZVhSPC4SrxRDHudqUqnChT4ST0vboQ83qVmYJr78VB9+zmUYZuic6
 +6cg==
X-Gm-Message-State: AOJu0Yx2Zb4Wl55hcmxQBHUuW1UMpJ68reU3XUPgj/KtJVlCU4j1LbQv
 8XQyoHlos7PMLwaTVCCDp7kVRg==
X-Google-Smtp-Source: AGHT+IF2ozbCUejpK2VPU4TIuD8jAsoxoqu9XYiACVq3CEKRDWexT48RBv4+odhsKWW4WyTU3ZXeug==
X-Received: by 2002:a05:600c:45c4:b0:405:40ab:7693 with SMTP id
 s4-20020a05600c45c400b0040540ab7693mr4428638wmo.31.1698489199128; 
 Sat, 28 Oct 2023 03:33:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 26-20020a05600c021a00b0040813e14b49sm7176737wmi.30.2023.10.28.03.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4FD735F7A3;
 Sat, 28 Oct 2023 11:33:13 +0100 (BST)
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
Subject: [PATCH 13/17] tests/docker: upgrade debian-all-test-cross to bookworm
Date: Sat, 28 Oct 2023 11:33:07 +0100
Message-Id: <20231028103311.347104-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
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

This requires a few more tweaks than usual as:

  - the default sources format has changed
  - bring in python3-tomli from the repos
  - split base install from cross compilers
  - also include libclang-rt-dev for sanitiser builds

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../dockerfiles/debian-all-test-cross.docker  | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 43cc083318..2cc7a24d4d 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -6,10 +6,10 @@
 # basic compilers for as many targets as possible. We shall use this
 # to build and run linux-user tests on GitLab
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 # Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+RUN sed -in "s/Types: deb/Types: deb deb-src/g" /etc/apt/sources.list.d/debian.sources
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -25,7 +25,16 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         clang  \
         flex \
         git \
+        libclang-rt-dev \
         ninja-build \
+        python3-pip \
+        python3-setuptools \
+        python3-tomli \
+        python3-venv \
+        python3-wheel
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+        apt install -y --no-install-recommends \
         gcc-aarch64-linux-gnu \
         libc6-dev-arm64-cross \
         gcc-arm-linux-gnueabihf \
@@ -53,13 +62,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         gcc-s390x-linux-gnu \
         libc6-dev-s390x-cross \
         gcc-sparc64-linux-gnu \
-        libc6-dev-sparc64-cross \
-        python3-pip \
-        python3-setuptools \
-        python3-venv \
-        python3-wheel
+        libc6-dev-sparc64-cross
 
-RUN /usr/bin/pip3 install tomli
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
 ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user
-- 
2.39.2


