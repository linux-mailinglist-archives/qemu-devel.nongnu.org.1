Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3777E5B0D
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 17:22:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0lIA-0001XL-0U; Wed, 08 Nov 2023 11:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0lI6-0001X4-F7
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 11:20:30 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0lI4-0003ak-Iw
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 11:20:30 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c5629fdbf8so88184571fa.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699460426; x=1700065226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O7b19E+VGdyXFjntHvCji4oIOVxdVglhw0moQgJKWxI=;
 b=BsL1NEi1TK/OIVvcmV1kJz/p0VGa9uVM8RcmQIVOIBCQcggyZpjKB2JSkTv7VsSejA
 c/pn454PQT9iBraL34VANmE2gsf+g+TU8g0SixuMUfyVbJ+c4sYLA85Zvse6hI5vrqWe
 DPamD+0EYjSUARtFUM71KIf0W8Tj7StPHjyQCZIBG2TFUuvxoKG1hoRsqDOpB5mxidIJ
 247w8v+RTEWrqmszzzunhMXwqulMVr/yjaADb6Xvk1wdRNw+ADH1G4bt/RLgWS4dsSw/
 /Wxwn644xB0lPCYY/QUw7lq7HcMSY3b3DZzLEiLATSMMb7KseH7i0rM7CD98tId5pxHC
 1hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699460426; x=1700065226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O7b19E+VGdyXFjntHvCji4oIOVxdVglhw0moQgJKWxI=;
 b=sm5UeriiwiOOGsL5ihH8C1DLAC+I7t/xsFJ0/MkV3JQQO/eMS5FdqbWVIfgbL2CFZL
 5cZjU+6Zshg9U5dJulC5iYpmNnivbmTNUT0Km1VzqtbMoFj3ZNiisfVkHpnugzn2OJJp
 Zhd7uJRJc1PYqxBF/s6lOhU+9Eb141yrvldApWWzCHwK+XTCm+EJG1yLACr+o8iD4O3B
 sTh7vzOYwWltwMi2lHwJ9ZCK8mC64heiabdBDosz2o7+NF1atQVLnLUeHn1vhScNhK4s
 rHx0lpp3Q2+GMp4fPsteHytqnOdo4832RFBQUzHYtsbr1rMKVyXstRz5+DxquihkzBN/
 2fnw==
X-Gm-Message-State: AOJu0Yx6hkMZqMEqnhi8eCWSwlqCNCIu8LwXni02K31YBngTE8m+6D5V
 ur0Fk1BChPoqkmFh4JVK57aFnJL0uLFs8zlY4PE=
X-Google-Smtp-Source: AGHT+IG/BKQw1l33a6XinyYX4mj+DT7YsgVTCEQL7HFP6p8vR30kpRKhCw9b2X1ErpwMuQ70qbSTVA==
X-Received: by 2002:a2e:99d8:0:b0:2bc:db70:b563 with SMTP id
 l24-20020a2e99d8000000b002bcdb70b563mr1966110ljj.32.1699460426047; 
 Wed, 08 Nov 2023 08:20:26 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a5d4a8c000000b0032fbd0c7d04sm5267837wrq.55.2023.11.08.08.20.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Nov 2023 08:20:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura)
Date: Wed,  8 Nov 2023 17:20:22 +0100
Message-ID: <20231108162022.76189-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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
---
 .gitlab-ci.d/cirrus.yml                              | 6 +++---
 .gitlab-ci.d/cirrus/{macos-12.vars => macos-13.vars} | 2 +-
 tests/lcitool/refresh                                | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename .gitlab-ci.d/cirrus/{macos-12.vars => macos-13.vars} (95%)

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
index 92e7d30982..2259f131b4 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -196,7 +196,7 @@ try:
     # Cirrus packages lists for GitLab
     #
     generate_cirrus("freebsd-13")
-    generate_cirrus("macos-12")
+    generate_cirrus("macos-13")
 
     #
     # VM packages lists
-- 
2.41.0


