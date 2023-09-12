Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1A179DAE7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:30:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAwy-0000dX-Jg; Tue, 12 Sep 2023 17:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwp-0000Wg-7N
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:28 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwm-0007X6-Ph
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:26 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68fcb4dc8a9so2206140b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694554162; x=1695158962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/AkEtNPg4wtt450WOc9tyNJVZZkvsy/I0yfwNJ/SAA=;
 b=CSLkUlagYA6Ihg+IMQAPu9vhINTRywHjoL1EZK6iBbrz8hQg1TCn+ITmU6UkaXaFU0
 N/k7attHu5/kQcw85HU0nemHg76fNFQIp/GJ3Ke2K0FgOgOEL/P0+PYt0eDEdoo2KKEp
 KCA5V4jkgNOkJQMx4fR5RcHLJpm0AlsnJcmhLQlHu4IxHYy3B4g2dwkmh7O7umd4iAs9
 5g0xsHia4dVB6PchBgySDH/zqhgl7N9Wbw09wsQhagHkC2cJgGYkj3xO0Kq5514QV6I/
 TL1u32MF7QPc6Zk6jJhAjY0ME7G3M/OzTi77xxjlC+oCdtqBjIDIPJ1qnrXCsbK1VY45
 MhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694554162; x=1695158962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/AkEtNPg4wtt450WOc9tyNJVZZkvsy/I0yfwNJ/SAA=;
 b=gjmK1QZzmJqxMlSLiTzdak9LYr34rPflt9qAw5vt/qvF+NRAQV/NyAtf88VQy+600D
 0aH0tahXaZ/XyxBQNPyjMJFBXYbRRBFI4NCXVMpVTupeqfk+siobFrfdXe0Emkq9iu12
 uL80obFrAvlrnPpVMKbTZVdppk4SlgKaTbBMupGua72u5VHcI2VyiwpQkjI8lXJl5dlS
 GUe3d/cX3SjxYCiHdAeweqOS9+dlDaOQOjclnSUeVFBoWbn4uJjPj32CzZnQRjp7YSog
 9TXO2NzYpmx0pnNTcTmur5B3XD9iv8Zn/XzAAJyafsXc+QmUPE42UU2sujAZQWyWXR3N
 oMhQ==
X-Gm-Message-State: AOJu0YwzCM72Y+JvMr1d3qgWS2erkXKxaEx7TsT1QOM5C2QyDi2qgjbe
 c4tZh7XA5bBkeuYuTdEEGLw=
X-Google-Smtp-Source: AGHT+IHShwul/Ms1aEHxjppEklQ/AqOGKcpat1s+RUUYpFUWRNz2JaxiZ6xZtnvLy3G8wfbiNI2lgQ==
X-Received: by 2002:a05:6a20:13cf:b0:153:6a8b:8f5d with SMTP id
 ho15-20020a056a2013cf00b001536a8b8f5dmr558064pzc.23.1694554161944; 
 Tue, 12 Sep 2023 14:29:21 -0700 (PDT)
Received: from q1iq-virtual-machine.. ([114.249.236.97])
 by smtp.gmail.com with ESMTPSA id
 u20-20020aa78394000000b0068be4ce33easm7930436pfm.96.2023.09.12.14.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 14:29:21 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC v6 6/9] target/mips: Add support for native library calls
Date: Wed, 13 Sep 2023 05:28:39 +0800
Message-Id: <20230912212842.658374-7-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
References: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x433.google.com
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
 target/mips/tcg/translate.c           | 30 ++++++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

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
index 74af91e4f5..b2d60e83d9 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -31,6 +31,7 @@
 #include "trace.h"
 #include "disas/disas.h"
 #include "fpu_helper.h"
+#include "native/native.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -13484,10 +13485,32 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void gen_native_call(DisasContext *ctx, CPUMIPSState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    char *func_name;
+    uint32_t func_tmp;
+    TCGv arg1 = tcg_temp_new();
+    TCGv arg2 = tcg_temp_new();
+    TCGv arg3 = tcg_temp_new();
+    TCGv ret = tcg_temp_new();
+    tcg_gen_mov_tl(arg1, cpu_gpr[4]);
+    tcg_gen_mov_tl(arg2, cpu_gpr[5]);
+    tcg_gen_mov_tl(arg3, cpu_gpr[6]);
+    ctx->base.pc_next += 4;
+    func_tmp = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+    func_name = g2h(env_cpu(env), ctx->base.pc_next + func_tmp);
+    if (!gen_native_call_tl(func_name, ret, arg1, arg2, arg3)) {
+        gen_reserved_instruction(ctx);
+    }
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
@@ -13583,6 +13606,11 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
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


