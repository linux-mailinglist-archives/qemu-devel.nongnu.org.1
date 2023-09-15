Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DFC7A2332
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:05:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBIj-0000ca-Pz; Fri, 15 Sep 2023 12:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhBIi-0000cL-78
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:04:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhBIg-0004tX-Dj
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:04:11 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31f737b8b69so2182421f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694793848; x=1695398648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AJAMyrA9JlljsasejtQ5jw5FQAx9iCoNU9lvvQ7Zd7E=;
 b=lALti7q7buIaJWx1qGyeWWZ246c5rXycgoiQd7yXDWNI2otELX7GgENrZnJx/mWNh0
 zoRa6+TbGrmgrN8IU2vbOMd8cHYtkeShsRV08H9NQtcu0nIBrbNYvUpx/I1e3dxyWZsm
 k5GkIL9hYb+4B5WXd3ihxWhFeeITBtPIbHD7710glJ4TZt51/kVngtxBqPxisjvQtKEk
 QJAdN+zidT1Hvbli9IxMLml8MLL+EMGiJNY/rurcdP5kl+hsRrK4RmLTuXh+pYQyLl9h
 3tIBUXw/sceBfD3uBXnSPHC5GDulTKZvd02q7ayLy8CGOoIoV+iQo13maT3lUO6vBPep
 /eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694793848; x=1695398648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AJAMyrA9JlljsasejtQ5jw5FQAx9iCoNU9lvvQ7Zd7E=;
 b=Cm1LbZmeVAjCAK18nYdp0VQEHhQAsJMVxLMBBcDxI2u6sMLCGqIYAGtGh6FbVmN3fP
 3/fGoUuTvjgdZVZToZ5JUd7LxF/6VwKAhCsA4CaUkRbw4MkzuQRFRYQfLZw4XmGZOD/k
 V2YT/UTvt/eXMWkO/zFmN3c8je8vzpCo68gQPUDJIEtMi0gb/2WAQqU9x7IzP2kuK137
 bZDVMTvOvZy57EwCIjaAD6vE5+qqR2WlkZweXYfZmDEvpLfeLS+H+8z0txtmyO6HGx/U
 MeDfJ/dQhQKcvOlWTRHryvQAw61gSQxs9uruAaWyYs7MS24lWRYnRiMR/M7xE1B1BPp7
 zLeg==
X-Gm-Message-State: AOJu0YwsWePs7TbQI4uP+IjfDpmQIuWfbvlota/PnrIKqlFjGVoxhF2b
 h0ZrBcbKHSzKH+2RmQqvBFUqRw==
X-Google-Smtp-Source: AGHT+IHhnz/0diuTU/axfYtpqijIycq/fmAm0OXF16RRj+ODI8aKiSRPWdUlaPV8hEhWVD8P4SjPNQ==
X-Received: by 2002:a5d:6d42:0:b0:31f:b7b2:d4e1 with SMTP id
 k2-20020a5d6d42000000b0031fb7b2d4e1mr1735401wri.20.1694793847821; 
 Fri, 15 Sep 2023 09:04:07 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a5d4ace000000b0031c5dda3aedsm4814639wrs.95.2023.09.15.09.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:04:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A76F41FFBB;
 Fri, 15 Sep 2023 17:04:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, berrange@redhat.com, f4bug@amsat.org, pbonzini@redhat.com,
 stefanha@redhat.com, crosa@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH] gitlab: shuffle some targets and reduce avocado noise
Date: Fri, 15 Sep 2023 17:03:58 +0100
Message-Id: <20230915160358.615687-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

We move a couple of targets out of the avocado runs because there are
no tests to run. Tricore already has some coverage, for cris we make
use of the fedora image we have and its own check-tcg tests.

To reduce the noise of CANCEL messages we also set AVOCADO_TAGS
appropriately so we filter down the number of tests we attempt.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index aee9101507..7813cb09a4 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -30,6 +30,7 @@ avocado-system-alpine:
   variables:
     IMAGE: alpine
     MAKE_CHECK_ARGS: check-avocado
+    AVOCADO_TAGS: arch:avr arch:loongarch64 arch:mips64 arch:mipsel
 
 build-system-ubuntu:
   extends:
@@ -40,8 +41,7 @@ build-system-ubuntu:
   variables:
     IMAGE: ubuntu2204
     CONFIGURE_ARGS: --enable-docs
-    TARGETS: alpha-softmmu cris-softmmu hppa-softmmu
-      microblazeel-softmmu mips64el-softmmu
+    TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
 
 check-system-ubuntu:
@@ -61,6 +61,7 @@ avocado-system-ubuntu:
   variables:
     IMAGE: ubuntu2204
     MAKE_CHECK_ARGS: check-avocado
+    AVOCADO_TAGS: arch:alpha arch:microblaze arch:mips64el
 
 build-system-debian:
   extends:
@@ -72,7 +73,7 @@ build-system-debian:
     IMAGE: debian-amd64
     CONFIGURE_ARGS: --with-coroutine=sigaltstack
     TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4eb-softmmu
-      sparc-softmmu xtensaeb-softmmu
+      sparc-softmmu xtensa-softmmu
     MAKE_CHECK_ARGS: check-build
 
 check-system-debian:
@@ -92,6 +93,7 @@ avocado-system-debian:
   variables:
     IMAGE: debian-amd64
     MAKE_CHECK_ARGS: check-avocado
+    AVOCADO_TAGS: arch:arm arch:i386 arch:riscv64 arch:sh4 arch:sparc arch:xtensa
 
 crash-test-debian:
   extends: .native_test_job_template
@@ -114,7 +116,7 @@ build-system-fedora:
   variables:
     IMAGE: fedora
     CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs
-    TARGETS: tricore-softmmu microblaze-softmmu mips-softmmu
+    TARGETS: microblaze-softmmu mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
 
@@ -135,6 +137,8 @@ avocado-system-fedora:
   variables:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check-avocado
+    AVOCADO_TAGS: arch:microblaze arch:mips arch:xtensa arch:m68k
+      arch:riscv32 arch:ppc arch:sparc64
 
 crash-test-fedora:
   extends: .native_test_job_template
@@ -180,6 +184,8 @@ avocado-system-centos:
   variables:
     IMAGE: centos8
     MAKE_CHECK_ARGS: check-avocado
+    AVOCADO_TAGS: arch:ppc64 arch:or1k arch:390x arch:x86_64 arch:rx
+      arch:sh4 arch:nios2
 
 build-system-opensuse:
   extends:
@@ -209,6 +215,7 @@ avocado-system-opensuse:
   variables:
     IMAGE: opensuse-leap
     MAKE_CHECK_ARGS: check-avocado
+    AVOCADO_TAGS: arch:s390x arch:x86_64 arch:aarch64
 
 
 # This jobs explicitly disable TCG (--disable-tcg), KVM is detected by
@@ -292,6 +299,17 @@ build-tricore-softmmu:
     TARGETS: tricore-softmmu
     MAKE_CHECK_ARGS: check-tcg
 
+# cris only has its own TCG tests
+build-cris:
+  extends: .native_build_job_template
+  needs:
+    job: cris-fedora-cross-container
+  variables:
+    IMAGE: fedora-cris-cross
+    CONFIGURE_ARGS: --disable-tools --disable-fdt --enable-debug
+    TARGETS: tricore-softmmu tricore-linux-user
+    MAKE_CHECK_ARGS: check-tcg
+
 clang-system:
   extends: .native_build_job_template
   needs:
-- 
2.39.2


