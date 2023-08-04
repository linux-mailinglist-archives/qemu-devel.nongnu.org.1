Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31877770B0D
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 23:35:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2Qz-0006Dn-0u; Fri, 04 Aug 2023 17:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qx-0006C1-27
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:07 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qt-0001uO-Tp
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:06 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bbdc05a93bso18866455ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691184842; x=1691789642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THGkRlj9Mp3BqTpP1dcC3/tdLawIOsnAx3v2Co9ZmqU=;
 b=nsPGu4ZOh5Ua0nxvLT22wFjQfOg4q5tjjzAAne0XUxscwiGBOAvPBiEpofL1f0A/91
 DRb1vs+2deml3w0NwUtm4GJ3udXzvR3qYOVbJKMs0U6/AfcX829RRsaeA32VwiAcf0e+
 dRnY+/QWLkkZDCGOfewIssXbSCRb4EX6iCl3kO9I0ITaXk58sdVlaOtRb7IY79zeCWFI
 TACB1RIFi9hxkHCFrv4K10GbiCjY6XxBSE6M/wdexOmk0299bP3XZyiWkErI9uooxYQw
 J3v1kVlxhMOPMAvdN9ZdClPKwAfZyRMMV45Bp4EpN+cvxOjtvkBbCAqSoxvhiKZuaDOq
 FhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691184842; x=1691789642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THGkRlj9Mp3BqTpP1dcC3/tdLawIOsnAx3v2Co9ZmqU=;
 b=aWrt6xmDwuHgDWZ9hNUPUS+lH7MoiIIN84EE7OnyNhSKGr7qMr17gZfKVAAeLeoHLP
 FYRCDlCOVBVsLAZN91r8kAqzaQhNbjnkmT0tqzH+G1A+68y0eselJtBxDIMMk+ClMvIi
 6T0t3GXTdDZJAxviZ/jrQJR1VJv0fpI/coSJgMh4r3eu5sENOfbFfNgh6WqQIn6NQyej
 kx0SaKeGHBxJmXAqmbz4chznaedxUhpNbglOioEcVNHUyY27+rYgdvxra5u52s8RSq39
 VQ9tZt88SZ0q/JczdTjVgfyG81IJcYnU7lqGjJA/tySBOZ+e3d5t/CBs8jjxv4/pNwCk
 Y4dw==
X-Gm-Message-State: AOJu0YxE33DgcRgPWKH69XfrUo+mLO4u7qJeLHZPGX4rKjs/7y0r4JIg
 5LdezZwq2IAfg4YWoI6gSdBcX2dEsM67CgABxK4=
X-Google-Smtp-Source: AGHT+IH4lADEJHvpG4PkQ4bv9mJlJ1n/jWUbIDilBMk5ARuB0k/D9JuKa7BXe/7kUkGwttABpve/MQ==
X-Received: by 2002:a17:902:d2c4:b0:1b8:9b5e:a218 with SMTP id
 n4-20020a170902d2c400b001b89b5ea218mr3244397plc.42.1691184842429; 
 Fri, 04 Aug 2023 14:34:02 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001ae0152d280sm2188662plg.193.2023.08.04.14.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 14:34:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com,
	qemu-ppc@nongnu.org,
	bgray@linux.ibm.com
Subject: [PATCH 7/7] tcg/ppc: Use prefixed instructions for tcg_out_goto_tb
Date: Fri,  4 Aug 2023 14:33:55 -0700
Message-Id: <20230804213355.294443-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804213355.294443-1-richard.henderson@linaro.org>
References: <20230804213355.294443-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

When a direct branch is out of range, we can load the destination for
the indirect branch using PLA (for 16GB worth of buffer) and PLD from
the TranslationBlock for everything larger.

This means the patch affects exactly one instruction: B (plus filler),
PLA or PLD.  Which means we can update and execute the patch atomically.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 76 ++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 18 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 5b243b2353..47c71bb5f2 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2642,31 +2642,41 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     uintptr_t ptr = get_jmp_target_addr(s, which);
 
     if (USE_REG_TB) {
+        /*
+         * With REG_TB, we must always use indirect branching,
+         * so that the branch destination and TCG_REG_TB match.
+         */
         ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
         tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
-    
-        /* TODO: Use direct branches when possible. */
-        set_jmp_insn_offset(s, which);
         tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
-
         tcg_out32(s, BCCTR | BO_ALWAYS);
 
         /* For the unlinked case, need to reset TCG_REG_TB.  */
         set_jmp_reset_offset(s, which);
         tcg_out_mem_long(s, ADDI, ADD, TCG_REG_TB, TCG_REG_TB,
                          -tcg_current_code_size(s));
+        return;
+    }
+
+    if (have_isa_3_10) {
+        /* Align, so that we can patch 8 bytes atomically. */
+        if ((uintptr_t)s->code_ptr & 7) {
+            tcg_out32(s, NOP);
+        }
+        set_jmp_insn_offset(s, which);
+        /* Direct branch will be patched by tb_target_set_jmp_target. */
+        tcg_out_mls_d(s, ADDI, TCG_REG_TMP1, 0, 0, 1);
     } else {
         /* Direct branch will be patched by tb_target_set_jmp_target. */
-        set_jmp_insn_offset(s, which);
-        tcg_out32(s, NOP);
-
+        tcg_out32(s, B);
         /* When branch is out of range, fall through to indirect. */
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (int16_t)ptr);
-        tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
-        tcg_out32(s, BCCTR | BO_ALWAYS);
-        set_jmp_reset_offset(s, which);
     }
+
+    tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
+    tcg_out32(s, BCCTR | BO_ALWAYS);
+    set_jmp_reset_offset(s, which);
 }
 
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
@@ -2674,20 +2684,50 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 {
     uintptr_t addr = tb->jmp_target_addr[n];
     intptr_t diff = addr - jmp_rx;
-    tcg_insn_unit insn;
 
     if (USE_REG_TB) {
         return;
     }
 
-    if (in_range_b(diff)) {
-        insn = B | (diff & 0x3fffffc);
-    } else {
-        insn = NOP;
-    }
+    if (have_isa_3_10) {
+        tcg_insn_unit insn1, insn2;
+        uint64_t pair;
 
-    qatomic_set((uint32_t *)jmp_rw, insn);
-    flush_idcache_range(jmp_rx, jmp_rw, 4);
+        if (in_range_b(diff)) {
+            insn1 = B | (diff & 0x3fffffc);
+            insn2 = NOP;
+        } else if (diff == sextract64(diff, 0, 34)) {
+            /* PLA tmp1, diff */
+            insn1 = OPCD(1) | (2 << 24) | (1 << 20) | ((diff >> 16) & 0x3ffff);
+            insn2 = ADDI | TAI(TCG_REG_TMP1, 0, diff);
+        } else {
+            addr = (uintptr_t)&tb->jmp_target_addr[n];
+            diff = addr - jmp_rx;
+            tcg_debug_assert(diff == sextract64(diff, 0, 34));
+            /* PLD tmp1, diff */
+            insn1 = OPCD(1) | (1 << 20) | ((diff >> 16) & 0x3ffff);
+            insn2 = PLD | TAI(TCG_REG_TMP1, 0, diff);
+        }
+
+        if (HOST_BIG_ENDIAN) {
+            pair = ((uint64_t)insn1) << 32 | insn2;
+        } else {
+            pair = ((uint64_t)insn2) << 32 | insn1;
+        }
+
+        qatomic_set((uint64_t *)jmp_rw, pair);
+        flush_idcache_range(jmp_rx, jmp_rw, 8);
+    } else {
+        tcg_insn_unit insn;
+
+        if (in_range_b(diff)) {
+            insn = B | (diff & 0x3fffffc);
+        } else {
+            insn = NOP;
+        }
+        qatomic_set((uint32_t *)jmp_rw, insn);
+        flush_idcache_range(jmp_rx, jmp_rw, 4);
+    }
 }
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc,
-- 
2.34.1


