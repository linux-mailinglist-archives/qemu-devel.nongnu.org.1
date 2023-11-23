Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 100227F6377
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:59:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C46-0005xp-3G; Thu, 23 Nov 2023 10:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C44-0005wY-5E
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:28 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C42-0002KS-0S
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:27 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3316c6e299eso664078f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754984; x=1701359784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMbBVPJ7LZvKSOdEEVIAuSDiAeoOvkqePYwyW/x2dpE=;
 b=MYwtyZEj32XuO26l4LCMKeeVIGTJlFEiLrpSsquQRs2YgIxyuqaxKQnWhhtGlSdjVd
 x4xam9bqRQteKCPFNII9iYawNDc1nD281Cyfb23XB0tACJicKwyqTZGIghdqY4TkHtU7
 rTXnN4gSfrLpWzF52QPjKI5D8iEZPWNcMmCeM8JjzOz6m7rwDClqoQRmj0LNefZA3KN0
 UJZQO8O32JfJx1RooRpwq5jA+DUT6skEkmuuyuqhUrGktyQplE/7a4saYZI/80LWsOUw
 MThinApVJc6KRod+jan3m0Wn9NvJqH2aGpqgUB++ptSVSVgxA31qLnXf4jWTsNUIC6gv
 8FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754984; x=1701359784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMbBVPJ7LZvKSOdEEVIAuSDiAeoOvkqePYwyW/x2dpE=;
 b=D5Zl3xyAmmAfpClZ7kwwbUmZPBl3mkcym1BY8mBOXOiyYRdBxn4DbozU+NyRdWKjO5
 RfanPQfDtSrEif3pB+x9SnqqJQSlj1N1N90Rl7hAsogY5OgLlXFyZxK9Zbso07l2XeK7
 yw/lGFwzG19CqJi90xrizPJajU9KrUi39bVQTzLP1moVBUDFqHUim6bI9BhmnSyCn9ah
 ozzxX3PEJlEjgSpIv+jOmtjISlkacarfxIWB848daFEqPAMLJT8c1UGjkkgLvBdQYSz7
 u1Rff6swBbwcCNv+KDPIYEhjVG5WREZG7nbALrvE22Fit9QeowG09BayfMxh5RDUqtrR
 /+oQ==
X-Gm-Message-State: AOJu0YwRwr/Pmwj5RZMwiwToL8ex1XJ0kiLaEMnLr393RfsI0733SxTK
 yW1S3vTDTqAsBntv65mFkR5ihw==
X-Google-Smtp-Source: AGHT+IHkzIM6uwUhQ0q0R3KfX4nqVDqturXhco3/Xda2HXRwGfoooizoGwkyBv7K6gQoY+tnm22afA==
X-Received: by 2002:a5d:5643:0:b0:32d:81b5:82d0 with SMTP id
 j3-20020a5d5643000000b0032d81b582d0mr3622687wrw.33.1700754984567; 
 Thu, 23 Nov 2023 07:56:24 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v10-20020adff68a000000b003316db2d48dsm1967498wrp.34.2023.11.23.07.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EC3A4645F7;
 Thu, 23 Nov 2023 15:56:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 02/14] .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura)
Date: Thu, 23 Nov 2023 15:56:08 +0000
Message-Id: <20231123155620.3042891-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123155620.3042891-1-alex.bennee@linaro.org>
References: <20231123155620.3042891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

macOS 14 "Sonoma" was released on September 2023 [1].

According to QEMU's support policy, we stop supporting the
previous major release two years after the the new major
release has been published. Replace the macOS 12 (Monterey)
testing by macOS 13 (Ventura, released on October 2022, [2]).

Refresh the generated files by running:

  $ make lcitool-refresh

[1] https://www.apple.com/newsroom/2023/09/macos-sonoma-is-available-today/
[2] https://www.apple.com/newsroom/2022/10/macos-ventura-is-now-available/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20231108162022.76189-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231120150833.2552739-3-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index e7f1f83c2c..07dc6edae1 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -59,13 +59,13 @@ x64-freebsd-13-build:
     INSTALL_COMMAND: pkg install -y
     TEST_TARGETS: check
 
-aarch64-macos-12-base-build:
+aarch64-macos-13-base-build:
   extends: .cirrus_build_job
   variables:
-    NAME: macos-12
+    NAME: macos-13
     CIRRUS_VM_INSTANCE_TYPE: macos_instance
     CIRRUS_VM_IMAGE_SELECTOR: image
-    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-monterey-base:latest
+    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-ventura-base:latest
     CIRRUS_VM_CPUS: 12
     CIRRUS_VM_RAM: 24G
     UPDATE_COMMAND: brew update
diff --git a/.gitlab-ci.d/cirrus/macos-12.vars b/.gitlab-ci.d/cirrus/macos-13.vars
similarity index 95%
rename from .gitlab-ci.d/cirrus/macos-12.vars
rename to .gitlab-ci.d/cirrus/macos-13.vars
index 5f3fb346d1..534f029956 100644
--- a/.gitlab-ci.d/cirrus/macos-12.vars
+++ b/.gitlab-ci.d/cirrus/macos-13.vars
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool variables macos-12 qemu
+#  $ lcitool variables macos-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 10c54a377c..7c211eba2e 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -203,7 +203,7 @@ try:
     # Cirrus packages lists for GitLab
     #
     generate_cirrus("freebsd-13")
-    generate_cirrus("macos-12")
+    generate_cirrus("macos-13")
 
     #
     # VM packages lists
-- 
2.39.2


