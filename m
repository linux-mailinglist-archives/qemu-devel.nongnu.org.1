Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E0173D496
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:30:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXGv-0005an-65; Sun, 25 Jun 2023 17:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGt-0005aM-2E; Sun, 25 Jun 2023 17:27:47 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGp-0003Vr-CC; Sun, 25 Jun 2023 17:27:45 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-54fb3c168fcso2326469a12.0; 
 Sun, 25 Jun 2023 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687728461; x=1690320461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELXa0RrQCUVaZ33o/5bUxq4k9BhayvG3Y38hDK3c1b8=;
 b=YvlJBQjgiPMeFSRavw8zMmmxwPjaDMpCr2Q8vcJvpEJt/SNfeA8Nj3c/Mx7lfKerM8
 wCXtStzjjG2qaoQrNaTWw8PK/DadHoExFpqRAac/MP1fCp9qyDv0sYy9h8eodqU8ISE6
 adzKOin38TAy2wcXbMtkV465M0mRbG44B4DAX1NnY5PQeBfCfNkHhoAIJ9w9Q9dJBNyH
 FngiRbjArx6ArU+QSJc/JIeD8i0D1Q4jaYuoGyijOA7CbgT7DBJcP1aYjPWWAq0+Kk2h
 oN+LQhaB5JgoqR1YMPmHE7fkUFe2K+CInWefFfvmwT+v7mIZv1EDnC9NYFdjQrlMhAPY
 aPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687728461; x=1690320461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELXa0RrQCUVaZ33o/5bUxq4k9BhayvG3Y38hDK3c1b8=;
 b=lP78iAIWqaPSXPBaL43TRuNhurNP4/JExwlVVr74uu2H2C+GX+ewE3dhgKzGPkGh2H
 QxrzekWgfHnXguOto2pPqr8OMXEN+PtWLltEQdSglZGcshJyc57TPvuItERJxM9xjk99
 djTOdIvQQl2lQ/Mzt2tKVbWQW+vzqgjHIZYgn1NsBj05AjM5XKeK5aPr+dNLsH/2BBiH
 GJEaeIFEp5ozEqcj8A57D+F5PlYqZW+Wbn9nmH7K4JpAxEemcSncpXHUT5gGeLtz6gFc
 uLUdVyZHBEpVVp60shqs55XpxlMSNNH2JUP1BmFuydhV8sMGUggBJzS/cXWpg8CswoAB
 VskQ==
X-Gm-Message-State: AC+VfDwZMgBhC9l/7FmoBhvBQ/whgbVk8slBGagAFJvz8mTvHF0x1seh
 bPPXj06eiNY+QLqYl63m+shDDPw6DlPVuOgS9Js=
X-Google-Smtp-Source: ACHHUZ5G+4116E4lEa2fPxs4JiYcOfRCMbSV6YGVwuMCwjqIBlQ20w9cguGffZrloJ1m3Z7WhBbYIw==
X-Received: by 2002:a17:902:ab95:b0:1b0:378e:2768 with SMTP id
 f21-20020a170902ab9500b001b0378e2768mr5641810plr.7.1687728461528; 
 Sun, 25 Jun 2023 14:27:41 -0700 (PDT)
Received: from q1iq-virtual-machine.localdomain ([111.201.135.80])
 by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001b8004ff609sm761343plb.270.2023.06.25.14.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:27:41 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC v3 09/10] target/arm: Add support for native library calls
Date: Mon, 26 Jun 2023 05:27:06 +0800
Message-Id: <20230625212707.1078951-10-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pg1-x535.google.com
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
 target/arm/tcg/translate-a64.c | 27 ++++++++++++++++++++++++++-
 target/arm/tcg/translate.c     | 25 +++++++++++++++++++++++--
 target/arm/tcg/translate.h     |  6 ++++++
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 741a608739..24a664b928 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -35,6 +35,7 @@
 #include "cpregs.h"
 #include "translate-a64.h"
 #include "qemu/atomic128.h"
+#include "native/native-defs.h"
 
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
@@ -2331,11 +2332,35 @@ static void disas_exc(DisasContext *s, uint32_t insn)
         /* BRK */
         gen_exception_bkpt_insn(s, syn_aa64_bkpt(imm16));
         break;
-    case 2:
+    case 2: /* HLT */
         if (op2_ll != 0) {
             unallocated_encoding(s);
             break;
         }
+        if (native_call_enabled() && (!s->native_call_status)) {
+            s->native_call_status = true;
+            s->native_call_id = imm16;
+            break;
+        } else if (native_call_enabled() && (s->native_call_status)) {
+            TCGv_i64 arg1 = tcg_temp_new_i64();
+            TCGv_i64 arg2 = tcg_temp_new_i64();
+            TCGv_i64 arg3 = tcg_temp_new_i64();
+
+            tcg_gen_mov_i64(arg1, cpu_reg(s, 0));
+            tcg_gen_mov_i64(arg2, cpu_reg(s, 1));
+            tcg_gen_mov_i64(arg3, cpu_reg(s, 2));
+
+            TCGv_i32 abi_map = tcg_constant_i32(imm16);
+            TCGv_i32 func_id = tcg_constant_i32(s->native_call_id);
+            TCGv_i64 res = tcg_temp_new_i64();
+            TCGv_i32 mmu_idx = tcg_constant_i32(MMU_USER_IDX);
+            gen_helper_native_call(res, cpu_env, arg1, arg2, arg3,
+                                    abi_map, func_id, mmu_idx);
+            tcg_gen_mov_i64(cpu_reg(s, 0), res);
+            s->native_call_status = false;
+            s->native_call_id = 0;
+            break;
+        }
         /* HLT. This has two purposes.
          * Architecturally, it is an external halting debug instruction.
          * Since QEMU doesn't implement external debug, we treat this as
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7468476724..7b90ce50d0 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -34,7 +34,7 @@
 #include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "cpregs.h"
-
+#include "native/native-defs.h"
 
 #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
 #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
@@ -58,6 +58,7 @@ TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
 TCGv_i64 cpu_exclusive_addr;
 TCGv_i64 cpu_exclusive_val;
 
+
 #include "exec/gen-icount.h"
 
 static const char * const regnames[] =
@@ -1147,12 +1148,32 @@ static inline void gen_hlt(DisasContext *s, int imm)
      * semihosting, to provide some semblance of security
      * (and for consistency with our 32-bit semihosting).
      */
+    if (native_call_enabled() && (!s->native_call_status)) {
+        s->native_call_status = true;
+        s->native_call_id = imm;
+        return;
+    } else if (native_call_enabled() && (s->native_call_status)) {
+        TCGv_i32 arg1 = load_reg(s, 0);
+        TCGv_i32 arg2 = load_reg(s, 1);
+        TCGv_i32 arg3 = load_reg(s, 2);
+
+        TCGv_i32 abi_map = tcg_constant_i32(imm);
+        TCGv_i32 func_id = tcg_constant_i32(s->native_call_id);
+        TCGv_i32 res = tcg_temp_new_i32();
+        TCGv_i32 mmu_idx = tcg_constant_i32(MMU_USER_IDX);
+        gen_helper_native_call_i32(res, cpu_env, arg1, arg2, arg3,
+                                    abi_map, func_id, mmu_idx);
+
+        store_reg(s, 0, res);
+        s->native_call_status = false;
+        s->native_call_id = 0;
+        return;
+    }
     if (semihosting_enabled(s->current_el == 0) &&
         (imm == (s->thumb ? 0x3c : 0xf000))) {
         gen_exception_internal_insn(s, EXCP_SEMIHOST);
         return;
     }
-
     unallocated_encoding(s);
 }
 
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a9d1f4adc2..280f8ba215 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -149,6 +149,12 @@ typedef struct DisasContext {
     int c15_cpar;
     /* TCG op of the current insn_start.  */
     TCGOp *insn_start;
+    /*
+     * Indicate whether the next instruction is a native function call (true)
+     * or not (false).
+     */
+    bool native_call_status;
+    int native_call_id;
 } DisasContext;
 
 typedef struct DisasCompare {
-- 
2.34.1


