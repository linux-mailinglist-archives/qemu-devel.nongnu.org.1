Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0987DCF92
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:47:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpyd-0004s8-BP; Tue, 31 Oct 2023 10:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyc-0004rd-1J
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:18 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyZ-0002CN-S9
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:17 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c50906f941so82257431fa.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763454; x=1699368254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UcNQcZ23IH2l6ThOjQB5817AinZo/599nsQ8ogdvZxs=;
 b=VeD5eYBxMMFDpdQkHtd26wnvOQDAAsgE2cJCr7EUFZJLR4UOYRFKNN/IHnQTHkXpGv
 4XHtIVlgTVzJHO/d/GujeQaokGWa1f+SKiNCQVT+kL5tipNLWglH34tfG62QLoOb74ve
 AFU1tsPSbNRfK0b4sHdTD/xvOJLpwa0iwwUPGvSVPurYqCqBCPN5x/dIg0vyxne7Pk7p
 oL8aX9xqLVTsLW/5vcPs9m++YrKEa5z31oJWBCZr6p1CF74j2dgDLGo5jCgSQbup1l7J
 TaM9U8fnKd3vidQyEzYXenkiiGej50aLTpEbNw/ux49KPDEWARHjoXvi5j8h+AbH8VPI
 MMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763454; x=1699368254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UcNQcZ23IH2l6ThOjQB5817AinZo/599nsQ8ogdvZxs=;
 b=Y3AeQBFnUcyKlDwPvhX3IfCptJq5JsM6jVjXI5xnpuO2LLEB4lTf1Wd2GiEAWuyo+F
 Jks26dRt0DSmmodtjrN+2NcmxHGlT3Ca/xiy8gv7b2yiH9iJML/DL/wAXPUDYVSvc6hr
 q65wir14n9nV1VZQn7tD5jdIM8EzxavCNqVYe9MK+4SvAVT2P/BNuytPZaaovpHQRx2V
 /yGyZJvnoXcjl+Wq/JUXdWSeDgextA4ILfHSgToJzzz6ahFHXriZ65T53wMONLpoOuBj
 5kSKyU1NIH7WUUWN3nNS21pUXsecDR0x3HmIelARcrt2x04/bS4kV2z8z0o/Zu0QQXGs
 TqMg==
X-Gm-Message-State: AOJu0YwoAz3FPTrKc1RqqqJ3SuUZ2IH3jfV0a/MVUEuCDRcd8Xn0YY4+
 JcwBYb8cZqfropT817slAtwrgg==
X-Google-Smtp-Source: AGHT+IF1yXXVufKRnY5gPYtKI1PoprzD18CA0sFxGdjt4Jf0sdjQ1nKxbH0bngEZnvBURIhzUBz3IQ==
X-Received: by 2002:a2e:9086:0:b0:2c5:1d11:5688 with SMTP id
 l6-20020a2e9086000000b002c51d115688mr9890672ljg.14.1698763454133; 
 Tue, 31 Oct 2023 07:44:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c471500b0040836519dd9sm1974949wmo.25.2023.10.31.07.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 406D165722;
 Tue, 31 Oct 2023 14:44:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 15/19] tests/docker: upgrade debian-all-test-cross to bookworm
Date: Tue, 31 Oct 2023 14:43:57 +0000
Message-Id: <20231031144401.1238210-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
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

This requires a few more tweaks than usual as:

  - the default sources format has changed
  - bring in python3-tomli from the repos
  - split base install from cross compilers
  - also include libclang-rt-dev for sanitiser builds

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231029145033.592566-16-alex.bennee@linaro.org>

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


