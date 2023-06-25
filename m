Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3C73D495
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:30:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXGt-0005a7-9E; Sun, 25 Jun 2023 17:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGp-0005Zj-6W
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:44 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGm-0003VL-8O
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:42 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b80512a7f2so1702465ad.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687728459; x=1690320459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Upd0/w+c+7hR3Rqfjl1w2AES8eESheSb+/xurltoVk=;
 b=AO5P/zsoY6AN4gozDugA3cRIUpauIc+4qrgTjv2TONkCyeHARFlUq9of+kMWtcQjXR
 1d3c7Em6UlsMA7Wjhm9fT5Jse8Zw1RfEKKonvWzmFII45VQ6hSZhRSkvvO2SJJFG3l3/
 dgmM+uUMB6MvkqPLIuK5TyLKZBXySbayZ8pdI0nl+f+ewlTbh6rmsG+Wp5KGjyiZswRq
 4hBAl/GfFDFmzDe3rdI1dO7IxczxkxmP11U1cBTHQVFs0mwdzeO642DnPYtNlPI4lKPe
 YwiEEA5+h9/ld6OsTchI3Di92b7AlDASKO1Z7Y7mvbduo++9X4wPenI3qKHRCvC6Ly1v
 Fa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687728459; x=1690320459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Upd0/w+c+7hR3Rqfjl1w2AES8eESheSb+/xurltoVk=;
 b=U10dZdgJPneCE5nNoi8VPGcOsny+GPcwbJtnNQ93GGlM6Wn2TMss1UMj+uhwqEmWLf
 pk4FSThf8fkqEEjz8R2jqxNMQYCxcq3MY5G7T3ZwJbBRVJE1kIwIlohVjfTp/un68uUe
 aEPcDU0SS5wEDpzjQH7iyosnvyLX7s6Y7qbpQ+AfmGv64niw4RJrck2aAxFfry9L1q3P
 KSq9hggHVHtKN2kmRTgzaCN2ZWJMdhXjprxqfMD+eVmevHqkvp4+NyA9M+FWC1NU+LGQ
 52tAfxa+HL5h5jxsW3gWs3oLJbuO+cxWRqohTYjidQcLpK8LFDgqmGl50+AkJ9ft+zeC
 gDog==
X-Gm-Message-State: AC+VfDxtjDRk8C7bZHxxlB4HL+ofBE3PA/8RBYCbqwatAZ85vcZwF9sc
 DGTGbCoJSLIhQ8rz9EDesNc=
X-Google-Smtp-Source: ACHHUZ54sJOvHEW57Ch2w2kYqj/fJWqfTyL2adNNvGFu2ZTNNDKAKi/3qQGmLv/zUX9Fms7kFSO8rA==
X-Received: by 2002:a17:903:1205:b0:1af:aafb:64c8 with SMTP id
 l5-20020a170903120500b001afaafb64c8mr5035549plh.21.1687728458790; 
 Sun, 25 Jun 2023 14:27:38 -0700 (PDT)
Received: from q1iq-virtual-machine.localdomain ([111.201.135.80])
 by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001b8004ff609sm761343plb.270.2023.06.25.14.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:27:38 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC v3 08/10] target/mips: Add support for native library calls
Date: Mon, 26 Jun 2023 05:27:05 +0800
Message-Id: <20230625212707.1078951-9-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Upon encountering specialized instructions reserved for native calls,
store the function id and argument types, then invoke helper.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 target/mips/tcg/translate.c | 26 ++++++++++++++++++++++++++
 target/mips/tcg/translate.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index a6ca2e5a3b..15ab889dca 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -36,6 +36,7 @@
 #include "qemu/qemu-print.h"
 #include "fpu_helper.h"
 #include "translate.h"
+#include "native/native-defs.h"
 
 /*
  * Many sysemu-only helpers are not reachable for user-only.
@@ -13592,6 +13593,31 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 #endif
         break;
     case OPC_SYSCALL:
+        uint32_t sig = (ctx->opcode) >> 6;
+        if (native_call_enabled() && (!ctx->native_call_status) && sig) {
+            ctx->native_call_status = true;
+            ctx->native_call_id = sig;
+            break;
+        } else if (native_call_enabled() && (ctx->native_call_status) && sig) {
+            TCGv arg1 = tcg_temp_new();
+            TCGv arg2 = tcg_temp_new();
+            TCGv arg3 = tcg_temp_new();
+
+            tcg_gen_mov_tl(arg1, cpu_gpr[4]);
+            tcg_gen_mov_tl(arg2, cpu_gpr[5]);
+            tcg_gen_mov_tl(arg3, cpu_gpr[6]);
+
+            TCGv_i32 abi_map = tcg_constant_i32(sig);
+            TCGv_i32 func_id = tcg_constant_i32(ctx->native_call_id);
+            TCGv res = tcg_temp_new();
+            TCGv_i32 mmu_idx = tcg_constant_i32(MMU_USER_IDX);
+            gen_helper_native_call(res, cpu_env, arg1, arg2, arg3,
+                                    abi_map, func_id, mmu_idx);
+            tcg_gen_mov_tl(cpu_gpr[2], res);
+            ctx->native_call_status = false;
+            ctx->native_call_id = 0;
+            break;
+        }
         generate_exception_end(ctx, EXCP_SYSCALL);
         break;
     case OPC_BREAK:
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 69f85841d2..bc603297cc 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -49,6 +49,8 @@ typedef struct DisasContext {
     bool saar;
     bool mi;
     int gi;
+    bool native_call_status;
+    int native_call_id;
 } DisasContext;
 
 #define DISAS_STOP       DISAS_TARGET_0
-- 
2.34.1


