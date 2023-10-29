Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 239267DACD2
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:52:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77w-0007eJ-2i; Sun, 29 Oct 2023 10:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77q-0007Yv-41
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:50 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77k-00059O-UX
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so26962275e9.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591043; x=1699195843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkWb8KxbRn7S6TI1+xj2cQh6vUFfFjkeGhBJwdoRHV8=;
 b=TjniL1Pnnn1YOPZOrLAK6tkZfpRduhEcCgn9U1OzksbAMkRKMHIn4jgnTB5BXdNfrD
 QO5YAYBXjPKdKkzXfZmSj4tkedBspzIQVTDYS3w7gNRuplIJ1tzJsKBgjkd9Rz6KwRgd
 Xedbu0nkDMzoomiECgP7p5OhW1GSXfK/6q1HqfQhU/O8pGaQ/ZRafveFpfQIZL/dyG0T
 X3MgGUPCvI1vSP8BhxZ69JpU8qa1NIQ2goVhSMO4aDHVj35sr3tYioFSBcPLkeQ17VuP
 B2PiGzaiLKNumzZlHW5uB+gpB6N48BKvDDQ3DFUkdUX8xcgUVy5o2lTwqPWA8n+uX9vu
 8lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591043; x=1699195843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mkWb8KxbRn7S6TI1+xj2cQh6vUFfFjkeGhBJwdoRHV8=;
 b=wGbso4mQd+uRHO6ZIBeLn7mvoc85tocExRVnT46RnQG7UsF404d6Qcj4vx+r3QYOzh
 eUkPZYSsmlTP1fMHzxcWumzcMwnU1zG8DRbNSrjX71uyaU83+22GZARZElxx3zRh2KHa
 WcWsr2wBtSxkSxx42f5VMoaUNiHL4KkWb1jCs1EX/BPYtn0n2u8xzUsdzuKeALxJSoEm
 M83Fbgz1z/myPT2U7eSwle4uBfEeIClFS5/FrfCF3xElx34TvCuBM+QIccwrO0YIVnRB
 OOI4hfYzHxzPaUjmHsMLIwwZBmot7L0/int4i+KLXNKBuD7a6mtuxPLzs8gF2+ZVIena
 JZDw==
X-Gm-Message-State: AOJu0Yy4bWl87ZMbHZgzMG3ewUDJEKMOYI2GSfLE0w6pzBfknIdhnJYG
 hZ4qZbNMjxV6TR8VYXSYb6x3uw==
X-Google-Smtp-Source: AGHT+IEVTlnRaHYZMcl14+pX0w7cT+0URhI3FUpZ31W2gGGp7q2ZdzmeeqRtXTDCDxmWvMW3yIPZwQ==
X-Received: by 2002:a05:6000:1445:b0:32f:7a07:be07 with SMTP id
 v5-20020a056000144500b0032f7a07be07mr4472813wrx.17.1698591043581; 
 Sun, 29 Oct 2023 07:50:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k6-20020adff286000000b0032da8fb0d05sm6071554wro.110.2023.10.29.07.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 89FDD656E6;
 Sun, 29 Oct 2023 14:50:35 +0000 (GMT)
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
Subject: [PATCH v2 15/19] tests/docker: upgrade debian-all-test-cross to
 bookworm
Date: Sun, 29 Oct 2023 14:50:29 +0000
Message-Id: <20231029145033.592566-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231028103311.347104-14-alex.bennee@linaro.org>
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


