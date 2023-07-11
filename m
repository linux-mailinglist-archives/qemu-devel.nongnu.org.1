Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CB274EDE1
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 14:17:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJCHa-0001Vt-9H; Tue, 11 Jul 2023 08:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCHP-0001U5-5q
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:15:43 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCHJ-0005Nc-NF
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:15:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-314172bac25so5512032f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 05:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689077734; x=1691669734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2jBqwLYTVPATDHfEQY0x1Pdqr8EcmmmZ1uz1yNnpOk=;
 b=p6NGz2uIHBDN9I0uFZI7kg0TM+VpEChM+v/eJSjTaPcJAAIgPCcOGHOvq5OEegyQ6l
 8D4MKMbJiYuV3g/y4s8toVhTsl83k4nwb42pQ1VpoPt+97G2MFt4xF6pL2s7EzyuMOfd
 NCB0TM7ILcLHZzVglvPUxmcQ5FaeKmKvFUr1CSC9PYeahisrz/KtFrFA0U5X4dR36+7a
 5DBWnEv1b4B/1mpTL4dL/mS89rfmIimOw4kSFc88Bp1KFnRK2ftP6/RFwd43D45iiglZ
 8//sQToKaLWr3oom6ozrEyEbXDOFYjgfAiXdHZuvCKmATv+RINn50OaN/xGoOx567q6R
 nwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689077734; x=1691669734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2jBqwLYTVPATDHfEQY0x1Pdqr8EcmmmZ1uz1yNnpOk=;
 b=c4CWOYQ+pj2n7HjTy0ieQFjvbZvy8XXMSMzfy3vzS+6kQi97fExhsHqbGL/mSWPURW
 ZTYGvVJDw2F+wa8rv2FJ1ScpcT3LkpPxZvEtW8Gx5dd8i+1+py76RoNSwxH2PJ4IPLm6
 HS7bxy/8fQQFQw6JQ0v1m+vJgx+CPBcBthSIwOQOY0wa4LmYk4dpXyGgLr5oea66xoAV
 b6b6lBL7c37Y+NFfGN1MbphxjhxdRoLam69PCOQ2R7iMDVsd2Cz4bSsvjiZsBhjlcQI3
 emIRKekWHTh3DYKiRv2idBrkv9DSTY4oRTiM5SrFXbwHjW4zZSjHwdTzktCn38xXj+L+
 KNfQ==
X-Gm-Message-State: ABy/qLaXBfNjnQUFIWw+dQ44Df6Sl8P/FelxuZRtWVuJv1ky11HcDxib
 H0mKXF7h7WMQww8SRmqFuXKpjpjfv/Xxk7MSo0A=
X-Google-Smtp-Source: APBJJlHhYw/xay9/SBceM0ThLGFtqK9XPJbM6M+UE+iXb0P6dGLQOn0Cd8VQELaY9ceAVLJdWesPMg==
X-Received: by 2002:a5d:4a8a:0:b0:314:20ee:2de7 with SMTP id
 o10-20020a5d4a8a000000b0031420ee2de7mr12412617wrq.11.1689077734589; 
 Tue, 11 Jul 2023 05:15:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c22d800b003fbaade072dsm2409133wmg.23.2023.07.11.05.15.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 05:15:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/16] target/riscv: Move TCG-specific files to
 target/riscv/tcg/
Date: Tue, 11 Jul 2023 14:14:44 +0200
Message-Id: <20230711121453.59138-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711121453.59138-1-philmd@linaro.org>
References: <20230711121453.59138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Move TCG-specific files to the a new 'tcg' sub-directory. Add
stubs for riscv_cpu_[get/set]_fflags and riscv_raise_exception().
Adapt meson rules.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/{ => tcg}/XVentanaCondOps.decode |  0
 target/riscv/{ => tcg}/insn16.decode          |  0
 target/riscv/{ => tcg}/insn32.decode          |  0
 target/riscv/{ => tcg}/xthead.decode          |  0
 target/riscv/{ => tcg}/bitmanip_helper.c      |  0
 target/riscv/{ => tcg}/crypto_helper.c        |  0
 target/riscv/{ => tcg}/fpu_helper.c           |  0
 target/riscv/{ => tcg}/m128_helper.c          |  0
 target/riscv/{ => tcg}/op_helper.c            |  0
 target/riscv/tcg/tcg-stub.c                   | 25 +++++++++++++++++++
 target/riscv/{ => tcg}/translate.c            |  0
 target/riscv/{ => tcg}/vector_helper.c        |  0
 target/riscv/{ => tcg}/zce_helper.c           |  0
 target/riscv/meson.build                      | 18 +------------
 target/riscv/tcg/meson.build                  | 19 ++++++++++++++
 15 files changed, 45 insertions(+), 17 deletions(-)
 rename target/riscv/{ => tcg}/XVentanaCondOps.decode (100%)
 rename target/riscv/{ => tcg}/insn16.decode (100%)
 rename target/riscv/{ => tcg}/insn32.decode (100%)
 rename target/riscv/{ => tcg}/xthead.decode (100%)
 rename target/riscv/{ => tcg}/bitmanip_helper.c (100%)
 rename target/riscv/{ => tcg}/crypto_helper.c (100%)
 rename target/riscv/{ => tcg}/fpu_helper.c (100%)
 rename target/riscv/{ => tcg}/m128_helper.c (100%)
 rename target/riscv/{ => tcg}/op_helper.c (100%)
 create mode 100644 target/riscv/tcg/tcg-stub.c
 rename target/riscv/{ => tcg}/translate.c (100%)
 rename target/riscv/{ => tcg}/vector_helper.c (100%)
 rename target/riscv/{ => tcg}/zce_helper.c (100%)
 create mode 100644 target/riscv/tcg/meson.build

diff --git a/target/riscv/XVentanaCondOps.decode b/target/riscv/tcg/XVentanaCondOps.decode
similarity index 100%
rename from target/riscv/XVentanaCondOps.decode
rename to target/riscv/tcg/XVentanaCondOps.decode
diff --git a/target/riscv/insn16.decode b/target/riscv/tcg/insn16.decode
similarity index 100%
rename from target/riscv/insn16.decode
rename to target/riscv/tcg/insn16.decode
diff --git a/target/riscv/insn32.decode b/target/riscv/tcg/insn32.decode
similarity index 100%
rename from target/riscv/insn32.decode
rename to target/riscv/tcg/insn32.decode
diff --git a/target/riscv/xthead.decode b/target/riscv/tcg/xthead.decode
similarity index 100%
rename from target/riscv/xthead.decode
rename to target/riscv/tcg/xthead.decode
diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/tcg/bitmanip_helper.c
similarity index 100%
rename from target/riscv/bitmanip_helper.c
rename to target/riscv/tcg/bitmanip_helper.c
diff --git a/target/riscv/crypto_helper.c b/target/riscv/tcg/crypto_helper.c
similarity index 100%
rename from target/riscv/crypto_helper.c
rename to target/riscv/tcg/crypto_helper.c
diff --git a/target/riscv/fpu_helper.c b/target/riscv/tcg/fpu_helper.c
similarity index 100%
rename from target/riscv/fpu_helper.c
rename to target/riscv/tcg/fpu_helper.c
diff --git a/target/riscv/m128_helper.c b/target/riscv/tcg/m128_helper.c
similarity index 100%
rename from target/riscv/m128_helper.c
rename to target/riscv/tcg/m128_helper.c
diff --git a/target/riscv/op_helper.c b/target/riscv/tcg/op_helper.c
similarity index 100%
rename from target/riscv/op_helper.c
rename to target/riscv/tcg/op_helper.c
diff --git a/target/riscv/tcg/tcg-stub.c b/target/riscv/tcg/tcg-stub.c
new file mode 100644
index 0000000000..dfe42ae2ac
--- /dev/null
+++ b/target/riscv/tcg/tcg-stub.c
@@ -0,0 +1,25 @@
+/*
+ * QEMU RISC-V TCG stubs
+ *
+ * Copyright (c) 2023 Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+
+target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
+{
+    g_assert_not_reached();
+}
+
+void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong)
+{
+    g_assert_not_reached();
+}
+
+G_NORETURN void riscv_raise_exception(CPURISCVState *env,
+                                      uint32_t exception, uintptr_t pc)
+{
+    g_assert_not_reached();
+}
diff --git a/target/riscv/translate.c b/target/riscv/tcg/translate.c
similarity index 100%
rename from target/riscv/translate.c
rename to target/riscv/tcg/translate.c
diff --git a/target/riscv/vector_helper.c b/target/riscv/tcg/vector_helper.c
similarity index 100%
rename from target/riscv/vector_helper.c
rename to target/riscv/tcg/vector_helper.c
diff --git a/target/riscv/zce_helper.c b/target/riscv/tcg/zce_helper.c
similarity index 100%
rename from target/riscv/zce_helper.c
rename to target/riscv/tcg/zce_helper.c
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 8967dfaded..8ef47f43f9 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -1,34 +1,18 @@
-# FIXME extra_args should accept files()
-gen = [
-  decodetree.process('insn16.decode', extra_args: ['--static-decode=decode_insn16', '--insnwidth=16']),
-  decodetree.process('insn32.decode', extra_args: '--static-decode=decode_insn32'),
-  decodetree.process('xthead.decode', extra_args: '--static-decode=decode_xthead'),
-  decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
-]
-
 riscv_ss = ss.source_set()
 riscv_system_ss = ss.source_set()
 
-riscv_ss.add(gen)
 riscv_ss.add(files(
   'cpu.c',
   'cpu_helper.c',
   'csr.c',
-  'fpu_helper.c',
   'gdbstub.c',
-  'op_helper.c',
-  'vector_helper.c',
-  'bitmanip_helper.c',
-  'translate.c',
-  'm128_helper.c',
-  'crypto_helper.c',
-  'zce_helper.c'
 ))
 
 riscv_system_ss.add(files(
   'debug.c',
 ))
 
+subdir('tcg')
 subdir('sysemu')
 
 target_arch += {'riscv': riscv_ss}
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
new file mode 100644
index 0000000000..65670493b1
--- /dev/null
+++ b/target/riscv/tcg/meson.build
@@ -0,0 +1,19 @@
+# FIXME extra_args should accept files()
+gen = [
+  decodetree.process('insn16.decode', extra_args: ['--static-decode=decode_insn16', '--insnwidth=16']),
+  decodetree.process('insn32.decode', extra_args: '--static-decode=decode_insn32'),
+  decodetree.process('xthead.decode', extra_args: '--static-decode=decode_xthead'),
+  decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
+]
+riscv_ss.add(when: 'CONFIG_TCG', if_true: gen)
+
+riscv_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'fpu_helper.c',
+  'op_helper.c',
+  'vector_helper.c',
+  'bitmanip_helper.c',
+  'translate.c',
+  'm128_helper.c',
+  'crypto_helper.c',
+  'zce_helper.c',
+), if_false: files('tcg-stub.c'))
-- 
2.38.1


