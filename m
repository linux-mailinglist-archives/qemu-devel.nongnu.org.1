Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C39CD773AAA
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNYj-0001H3-Nh; Tue, 08 Aug 2023 10:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYh-0001Gu-Ci
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYf-0000Kv-Qn
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:39 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bb84194bf3so37314275ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691504376; x=1692109176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WP5X3yCy/F02UfY2IJEZNxNCZRfNcnMSpoz9Z2/i/O0=;
 b=DjPDKkCYUrLbCi3qVOlSJpUQ6MH4oxO+uWmqHQ+3G73C8vfHV4l/X2crQqxR9KJTHs
 kqLhOhwuX6ifJPOuPug6uclbJ5Qj6ktLQAgw2Y+NorXhLlApgHtNwo0O4+KjlVMDj+kQ
 ehXjlEndlX+7z/PZeuD+zoyIX1QqM4fDqhOQa6FVgM82EK7igag9QswGmwLgfDUrTF87
 hknskbn8K4UxS/EgFpa15npy+lZy8s69JLGJJxHmSa2PS8dxhOmhPmQr3InzWBacdMEI
 FTy9rx/ig+4ZwnUbJM/jKYHeBB7DyNiI+DbV4Txva+Fnu9FAlyArUhJQaWpjGSIBKKFn
 95Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691504376; x=1692109176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WP5X3yCy/F02UfY2IJEZNxNCZRfNcnMSpoz9Z2/i/O0=;
 b=dlm79IzlpaYaqW+Dpog9xwSM1E6Vl1cy+uI31hTp9tX6ZySAQhWewgw+cAbLZ8bDop
 hCYyHDdbib2G6inEwjK9+Xb/6Y3bFVtXixphWQNxwibns9srtHwKBLp1nQYa2x1P/pSe
 2GtjhXeELpvkggKr+jIGAlb5ijBzpKS30o1v6EK2+3qtSYLqfr23bE2AllgSY3TaSe0I
 RRhtL0n1sEmbEsOe7itWonv3eVhHiTGuVIep4Bv6noJY6Bdf8PDtqzJ0GveYvhKP+dfw
 Y/VLW0D2BWQa08eYhvBXxc8DnBAGhFCoioFwld3XAmgvIuuzRKrQaf9LdUZVPr6BUSMm
 ukxg==
X-Gm-Message-State: AOJu0Yx1lU3uWR0uadWIzUnX/wnjf4svxuqYdhpn9xWDCcPmnvAuVgAO
 VRClWZ0c31LJABcS8q9Qzhk=
X-Google-Smtp-Source: AGHT+IE5ZaWCfvmAmuZTBgI/nHMnBXeXe1R1RtofICQ3orHjer1jyiUkCvogs8/5v0s2gRz5NRISeQ==
X-Received: by 2002:a17:902:7683:b0:1bb:141c:3034 with SMTP id
 m3-20020a170902768300b001bb141c3034mr11812569pll.12.1691504376306; 
 Tue, 08 Aug 2023 07:19:36 -0700 (PDT)
Received: from localhost.localdomain ([223.104.41.22])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170902b68300b001bb1f0605b2sm9043985pls.214.2023.08.08.07.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 07:19:36 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC v4 08/11] target/mips: Add support for native library calls
Date: Tue,  8 Aug 2023 22:17:36 +0800
Message-Id: <20230808141739.3110740-9-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x636.google.com
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
mips target. When special instructions reserved for native calls
are encountered, the code now performs address translation and
generates the corresponding native call.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 configs/targets/mips-linux-user.mak   |  1 +
 configs/targets/mips64-linux-user.mak |  1 +
 target/mips/tcg/translate.c           | 21 ++++++++++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

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
index 74af91e4f5..51a5c1d49b 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -36,6 +36,7 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
+#include "native/native.h"
 
 /*
  * Many sysemu-only helpers are not reachable for user-only.
@@ -13487,7 +13488,7 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
 static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
-    uint32_t op1;
+    uint32_t op1, sig;
 
     rs = (ctx->opcode >> 21) & 0x1f;
     rt = (ctx->opcode >> 16) & 0x1f;
@@ -13583,6 +13584,24 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 #endif
         break;
     case OPC_SYSCALL:
+        sig = (ctx->opcode) >> 6;
+        if ((sig == 0xffff) && native_bypass_enabled()) {
+            TCGv arg1 = tcg_temp_new();
+            TCGv arg2 = tcg_temp_new();
+            TCGv arg3 = tcg_temp_new();
+            TCGv ret = tcg_temp_new();
+            const char *fun_name = lookup_symbol((ctx->base.pc_next) & 0xfff);
+            tcg_gen_mov_tl(arg1, cpu_gpr[4]);
+            tcg_gen_mov_tl(arg2, cpu_gpr[5]);
+            tcg_gen_mov_tl(arg3, cpu_gpr[6]);
+#if defined(TARGET_MIPS64)
+            gen_native_call_i64(fun_name, ret, arg1, arg2, arg3);
+#else
+            gen_native_call_i32(fun_name, ret, arg1, arg2, arg3);
+#endif
+            tcg_gen_mov_tl(cpu_gpr[2], ret);
+            break;
+        }
         generate_exception_end(ctx, EXCP_SYSCALL);
         break;
     case OPC_BREAK:
-- 
2.34.1


