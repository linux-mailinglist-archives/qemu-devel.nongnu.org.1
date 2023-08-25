Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D5E788539
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZUM0-0006AY-DY; Fri, 25 Aug 2023 06:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZULw-0006AE-K1
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:47:45 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZULu-0001fS-03
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:47:44 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso6938055ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 03:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692960460; x=1693565260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09OaEyYJZcHE/3bJp2djfXBDd7BocbAE4OWvoduONqw=;
 b=OLTpPodxZg+abY0nG+fNn1LaaBXwa075XVRyA+UgpTFHQtk1EID+E0fJDN0jQfjo2E
 LDv347YTiqJLUokW/3r3ZkxiQBxuPybHRTGFceK0LS+i59/9tuXwl8CpIAFMLHBVGvIs
 SNdYBq00bdDR6ddoRj8LHhfi1/zH3JVB9sndGKTLsKsbwfnTWe/P0fnsNUHCcEg0AwmO
 fPjRjhtlyEHLD1XzJWyhhFmFSEH9FUeTML41mv/4vkSR/g+f9tfPOV/TGhUzxhv3UZSx
 G10ngJxaR2wb7BBHuq56kb2rx+XDx+mkTAtK0UtQ61jEx9q4I8fnHs7zM0cmpQDdkizp
 jC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692960460; x=1693565260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09OaEyYJZcHE/3bJp2djfXBDd7BocbAE4OWvoduONqw=;
 b=VEEmQtahnv64E/j2kfmRq8ppfZ5Zd/Ds+XrNzcdKE+IVxzaWMurjIflhFlyA7lE0R9
 4E+c998rNw/3lZ4SDX/Ha0ZCSeYVAMWKs5fdb/UMHueSQ5IxJzHKbOBe5B1aHWGPJaQp
 hXbhkdKqFaA90zTlOq9U5nUWLX9pOlqh2oo6guyMAy/3zP3TDwVXvT/TbVlYkZgPXZle
 YLIr6gnIuztNB+JyaBiApNIIxk3Wx9mBETb2DAEHMhGuZ+b570VJCcAUkBApK2wdJwp+
 G4ce+c6YN6+ZV3tQoMlt18hgSNJyIUHNOBRRXdyUOI6pBCzSnA+I3ZZABLsUGgA2ZDci
 27ug==
X-Gm-Message-State: AOJu0YxkaGhsbtQrYxHeECSTSQFK363r13eXArXmzKqdjRJu2Z8vpdgM
 +ne/BpCorcgeR54tgSJWtGJIWrsSfrGHHg==
X-Google-Smtp-Source: AGHT+IHXTHk+aO0b0o9k4TXo6cbBN/pe3jz2jCdPqAWXW5zIgqO9PKfNVV5k6ZFj+uHZOuCBDOYO7Q==
X-Received: by 2002:a17:903:26cb:b0:1bc:98dd:e857 with SMTP id
 jg11-20020a17090326cb00b001bc98dde857mr17263175plb.38.1692960460449; 
 Fri, 25 Aug 2023 03:47:40 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.15])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170902ce8500b001b89891bfc4sm1346985plg.199.2023.08.25.03.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:47:40 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC v5 07/10] target/mips: Add support for native library calls
Date: Fri, 25 Aug 2023 18:45:23 +0800
Message-Id: <20230825104526.1754950-8-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
References: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit introduces support for native library calls on the
mips target. When encountering special instructions reserved
for native calls, this commit extracts the function name and
generates the corresponding native call.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 configs/targets/mips-linux-user.mak   |  1 +
 configs/targets/mips64-linux-user.mak |  1 +
 target/mips/tcg/translate.c           | 36 ++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/configs/targets/mips-linux-user.mak b/configs/targets/mips-linux-user.mak
index b4569a9893..fa005d487a 100644
--- a/configs/targets/mips-linux-user.mak
+++ b/configs/targets/mips-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_ABI_MIPSO32=y
 TARGET_SYSTBL_ABI=o32
 TARGET_SYSTBL=syscall_o32.tbl
 TARGET_BIG_ENDIAN=y
+CONFIG_NATIVE_CALL=y
diff --git a/configs/targets/mips64-linux-user.mak b/configs/targets/mips64-linux-user.mak
index d2ff509a11..ecfe6bcf73 100644
--- a/configs/targets/mips64-linux-user.mak
+++ b/configs/targets/mips64-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_BASE_ARCH=mips
 TARGET_SYSTBL_ABI=n64
 TARGET_SYSTBL=syscall_n64.tbl
 TARGET_BIG_ENDIAN=y
+CONFIG_NATIVE_CALL=y
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 74af91e4f5..fa58f9e12f 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -36,6 +36,7 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
+#include "native/native.h"
 
 /*
  * Many sysemu-only helpers are not reachable for user-only.
@@ -13484,10 +13485,38 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void gen_native_call(DisasContext *ctx, CPUMIPSState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    char *func_name;
+    TCGv arg1 = tcg_temp_new();
+    TCGv arg2 = tcg_temp_new();
+    TCGv arg3 = tcg_temp_new();
+    TCGv ret = tcg_temp_new();
+    tcg_gen_mov_tl(arg1, cpu_gpr[4]);
+    tcg_gen_mov_tl(arg2, cpu_gpr[5]);
+    tcg_gen_mov_tl(arg3, cpu_gpr[6]);
+#if defined(TARGET_MIPS64)
+    uint64_t func_tmp =
+        translator_ldq(env, &ctx->base, ctx->base.pc_next + 8);
+    ctx->base.pc_next += 12;
+    func_name = g2h(env_cpu(env), func_tmp);
+    gen_native_call_i64(func_name, ret, arg1, arg2, arg3);
+#else
+    uint32_t func_tmp =
+        translator_ldl(env, &ctx->base, ctx->base.pc_next + 4);
+    ctx->base.pc_next += 4;
+    func_name = g2h(env_cpu(env), func_tmp);
+    gen_native_call_i32(func_name, ret, arg1, arg2, arg3);
+#endif
+    tcg_gen_mov_tl(cpu_gpr[2], ret);
+#endif
+}
+
 static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
-    uint32_t op1;
+    uint32_t op1, sig;
 
     rs = (ctx->opcode >> 21) & 0x1f;
     rt = (ctx->opcode >> 16) & 0x1f;
@@ -13583,6 +13612,11 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 #endif
         break;
     case OPC_SYSCALL:
+        sig = (ctx->opcode) >> 6;
+        if ((sig == 0xffff) && native_bypass_enabled()) {
+            gen_native_call(ctx, env);
+            break;
+        }
         generate_exception_end(ctx, EXCP_SYSCALL);
         break;
     case OPC_BREAK:
-- 
2.34.1


