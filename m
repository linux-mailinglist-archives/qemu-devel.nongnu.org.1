Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9237B70F4
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:33:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAs-00084T-Kx; Tue, 03 Oct 2023 14:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAn-00081C-Qf
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:11 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAj-0001eZ-RZ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:09 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c60a514f3aso9876375ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357863; x=1696962663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGIr9qTLkG6qDPefA3k2dSggXrteDRo4H56lowl7XH4=;
 b=cAf6gcKSGWuWIKayNzbLU6u0lc4dEsDQajDn0v6rIl0Q6grdpU+HJxMWAzB1fBeJBH
 kV04nWoyxyxUMixScDkEVUfi2D08x/6Of8INTnWbxEoK+FHnN9mIXxHyANFXkoBye/tq
 0TKkq3xZ16IpzK9dj+21uERk9vLuqddIHI6npMP00Qat8oU4jhxc6bp38szqhHPiSYQz
 UuJuVOK3gZTg7aojNiyAjd66VpOsUujXv+VkN5xSQRCrxFSZIykKUWoQdIRt4Hbofrhm
 sxREoj2gvSEMmazp2qZyWXm0MPl9llsg2JEXumQyawfbTdPfa9CpFqtX0ewkp0RziLGq
 EiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357863; x=1696962663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGIr9qTLkG6qDPefA3k2dSggXrteDRo4H56lowl7XH4=;
 b=c3rWhZh5BzW4xKxHN8NecUNrcgPmcDiEPErpIa5z4vk39r1szou7QARRccpHpAGtVy
 CI75Vc8C2NlcNrVzAHb3yQ4jfmoUq8yG/L30Sg5pBIsFrnNwUrxC98ZYhJ3yYSpCdL3C
 qp8ilgS76VQS7xljWZVYNq/79HYrgFS/qI6/+GYpHYyXN0nu1rwxIv6LdR2KLMRjm3qk
 dBebWzTlKadMfLcDX2pi13+YQ+k2suvC8hgxjgNW1gcXaY3s9l+BNtjqS3geGF7FLb0X
 6GWHrQklWd70yAD59WHQ5lS/TlzBi06Zne5mFIGmsuqFItqSxlATw/Zlry+r5rbYyQm6
 z5rg==
X-Gm-Message-State: AOJu0Yz8X5DAz8wXQY1j4rC9atcA+6+wDqNMjdo02jsxHGBNx+/p8Z5j
 8IehM5D0wagSbvdeHNMnykMH39e5B1swokPhtP4=
X-Google-Smtp-Source: AGHT+IGhYn9ct+jzgbqZpM3OacaOlbHMVu6tjA9GCsxV2rvST4tfnWDIl+S+mDuloU9TKG2da4BO2Q==
X-Received: by 2002:a17:902:dacd:b0:1bb:2020:be0d with SMTP id
 q13-20020a170902dacd00b001bb2020be0dmr506455plx.14.1696357863437; 
 Tue, 03 Oct 2023 11:31:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com
Subject: [PATCH v17 04/16] tcg: Record nb_spills in TCGContext
Date: Tue,  3 Oct 2023 11:30:46 -0700
Message-Id: <20231003183058.1639121-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Record the number of times a temporary is forced into memory
and the store would not have been required if there an infinite
number of call-saved cpu registers available.  This excludes
stores that are required by semantics to return computed values
to their home slot in ENV, i.e. NEED_SYNC_ARG.

To be copied into TBStatistics when desired.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  1 +
 tcg/tcg.c         | 36 +++++++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index d60349878f..c2b1a2e187 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -567,6 +567,7 @@ struct TCGContext {
     /* Used by TBStatistics */
     int orig_nb_ops;
     int nb_deleted_ops;
+    int nb_spills;
 
     /* Exit to translator on overflow. */
     sigjmp_buf jmp_trans;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 60be2f429c..471e5eaad9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1495,6 +1495,7 @@ void tcg_func_start(TCGContext *s)
     s->nb_ops = 0;
     s->nb_labels = 0;
     s->nb_deleted_ops = 0;
+    s->nb_spills = 0;
     s->current_frame_offset = s->frame_start;
 
 #ifdef CONFIG_DEBUG_TCG
@@ -4118,8 +4119,11 @@ static inline void temp_dead(TCGContext *s, TCGTemp *ts)
    is non-zero, subsequently release the temporary; if it is positive, the
    temp is dead; if it is negative, the temp is free.  */
 static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
-                      TCGRegSet preferred_regs, int free_or_dead)
+                      TCGRegSet preferred_regs, int free_or_dead,
+                      bool account_spill)
 {
+    bool did_spill = false;
+
     if (!temp_readonly(ts) && !ts->mem_coherent) {
         if (!ts->mem_allocated) {
             temp_allocate_frame(s, ts);
@@ -4132,6 +4136,7 @@ static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
             if (free_or_dead
                 && tcg_out_sti(s, ts->type, ts->val,
                                ts->mem_base->reg, ts->mem_offset)) {
+                did_spill = account_spill;
                 break;
             }
             temp_load(s, ts, tcg_target_available_regs[ts->type],
@@ -4139,6 +4144,7 @@ static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
             /* fallthrough */
 
         case TEMP_VAL_REG:
+            did_spill = account_spill;
             tcg_out_st(s, ts->type, ts->reg,
                        ts->mem_base->reg, ts->mem_offset);
             break;
@@ -4155,6 +4161,9 @@ static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
     if (free_or_dead) {
         temp_free_or_dead(s, ts, free_or_dead);
     }
+    if (did_spill) {
+        s->nb_spills += 1;
+    }
 }
 
 /* free register 'reg' by spilling the corresponding temporary if necessary */
@@ -4162,7 +4171,7 @@ static void tcg_reg_free(TCGContext *s, TCGReg reg, TCGRegSet allocated_regs)
 {
     TCGTemp *ts = s->reg_to_temp[reg];
     if (ts != NULL) {
-        temp_sync(s, ts, allocated_regs, 0, -1);
+        temp_sync(s, ts, allocated_regs, 0, -1, true);
     }
 }
 
@@ -4442,7 +4451,8 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
     ots->val = val;
     ots->mem_coherent = 0;
     if (NEED_SYNC_ARG(0)) {
-        temp_sync(s, ots, s->reserved_regs, preferred_regs, IS_DEAD_ARG(0));
+        temp_sync(s, ots, s->reserved_regs, preferred_regs,
+                  IS_DEAD_ARG(0), false);
     } else if (IS_DEAD_ARG(0)) {
         temp_dead(s, ots);
     }
@@ -4544,7 +4554,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     ots->mem_coherent = 0;
 
     if (NEED_SYNC_ARG(0)) {
-        temp_sync(s, ots, allocated_regs, 0, 0);
+        temp_sync(s, ots, allocated_regs, 0, 0, false);
     }
 }
 
@@ -4621,7 +4631,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
                 break;
             }
             /* Sync the temp back to its slot and load from there.  */
-            temp_sync(s, its, s->reserved_regs, 0, 0);
+            temp_sync(s, its, s->reserved_regs, 0, 0, true);
         }
         /* fall through */
 
@@ -4652,7 +4662,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
         temp_dead(s, its);
     }
     if (NEED_SYNC_ARG(0)) {
-        temp_sync(s, ots, s->reserved_regs, 0, 0);
+        temp_sync(s, ots, s->reserved_regs, 0, 0, false);
     }
     if (IS_DEAD_ARG(0)) {
         temp_dead(s, ots);
@@ -4870,7 +4880,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                  * Cross register class move not supported.  Sync the
                  * temp back to its slot and load from there.
                  */
-                temp_sync(s, ts, i_allocated_regs, 0, 0);
+                temp_sync(s, ts, i_allocated_regs, 0, 0, true);
                 tcg_out_ld(s, ts->type, reg,
                            ts->mem_base->reg, ts->mem_offset);
             }
@@ -5019,7 +5029,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         tcg_debug_assert(!temp_readonly(ts));
 
         if (NEED_SYNC_ARG(i)) {
-            temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
+            temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i), false);
         } else if (IS_DEAD_ARG(i)) {
             temp_dead(s, ts);
         }
@@ -5086,8 +5096,8 @@ static bool tcg_reg_alloc_dup2(TCGContext *s, const TCGOp *op)
         itsl == itsh + (HOST_BIG_ENDIAN ? 1 : -1)) {
         TCGTemp *its = itsl - HOST_BIG_ENDIAN;
 
-        temp_sync(s, its + 0, s->reserved_regs, 0, 0);
-        temp_sync(s, its + 1, s->reserved_regs, 0, 0);
+        temp_sync(s, its + 0, s->reserved_regs, 0, 0, true);
+        temp_sync(s, its + 1, s->reserved_regs, 0, 0, true);
 
         if (tcg_out_dupm_vec(s, vtype, MO_64, ots->reg,
                              its->mem_base->reg, its->mem_offset)) {
@@ -5107,7 +5117,7 @@ static bool tcg_reg_alloc_dup2(TCGContext *s, const TCGOp *op)
         temp_dead(s, itsh);
     }
     if (NEED_SYNC_ARG(0)) {
-        temp_sync(s, ots, s->reserved_regs, 0, IS_DEAD_ARG(0));
+        temp_sync(s, ots, s->reserved_regs, 0, IS_DEAD_ARG(0), false);
     } else if (IS_DEAD_ARG(0)) {
         temp_dead(s, ots);
     }
@@ -5125,7 +5135,7 @@ static void load_arg_reg(TCGContext *s, TCGReg reg, TCGTemp *ts,
                  * Cross register class move not supported.  Sync the
                  * temp back to its slot and load from there.
                  */
-                temp_sync(s, ts, allocated_regs, 0, 0);
+                temp_sync(s, ts, allocated_regs, 0, 0, true);
                 tcg_out_ld(s, ts->type, reg,
                            ts->mem_base->reg, ts->mem_offset);
             }
@@ -5307,7 +5317,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
     for (i = 0; i < nb_oargs; i++) {
         TCGTemp *ts = arg_temp(op->args[i]);
         if (NEED_SYNC_ARG(i)) {
-            temp_sync(s, ts, s->reserved_regs, 0, IS_DEAD_ARG(i));
+            temp_sync(s, ts, s->reserved_regs, 0, IS_DEAD_ARG(i), false);
         } else if (IS_DEAD_ARG(i)) {
             temp_dead(s, ts);
         }
-- 
2.34.1


