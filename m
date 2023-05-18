Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1F70846E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzf5A-0003Fw-Vg; Thu, 18 May 2023 10:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzf58-0003FO-QJ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:58:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzf56-0006Eb-VL
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:58:18 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ae507af2e5so9852165ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684421895; x=1687013895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WN5f6LZLAKAImcWbx9PFX4CVTDe90YhzungcepWPB5g=;
 b=Mpki+lrGlt+HZ5TG5riBNDRzNhrg7GbIHydb24oNqCG5qlz/TSZzEqIOPSJbJA8mep
 zw14mad2wmxUrLwXa604qr/p6MPl9sgCwtUZV+q6C2ELPv8ThIAl3lFvCYKnKkP+5+yF
 6XK+MWKWiU4YHcu9p2Ph6JsMw8l+95FjCzefcZRLEFldopNavGRDgg3YiiyGKchcvR8i
 MBZIby/EpLPFnTREsm+m0jOCsaPdImixiBHBKjONyD8w4tiurA00SrjpjFqepdKaQsfT
 KTYSRVfQ3WQWXJQQ7IRP5BT0cfaNpxDnheexm1W7GnNF+to5OrL5G66Z2/vZjXC7nB2f
 oS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684421895; x=1687013895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WN5f6LZLAKAImcWbx9PFX4CVTDe90YhzungcepWPB5g=;
 b=XwA8syUCoCeozMjTACOxVclWjIDyterFMxhmwuHRYloF83t7uCsY5RFYar9M1spBJD
 7hlyB1/rx1bqsPs8nWi81CVoIXUdRyTnkgIuCAKaUsV+aw/BuEZ8K/FcoGed7slht2b5
 VecQK3LRsGTaquE3JG5mortjAKrRpvFQKAiER7OMNPyl+KXblGgn9XX6Oyfcw+eKsyF7
 6Ff4oBk+sTeLKaNTjvlFWoSBDacdIUptjaWAH+w45OX3pQzcJPo6rGmbgD0Hf1fjTfmA
 kK4Js6S5hxeEtf4PFQiIod9iAqRNX1smvQAh3A8+VRiR+NyNtUcSqhrMH8D/wUbtOGos
 R31Q==
X-Gm-Message-State: AC+VfDzRVmWRvuoQBaFFxXSSMaosoLL8wWDixQCBnSmic5NGxAl5MO1m
 Vo8oKQeXLjnZ1vqAzHCsBo+gmNF51J9lmFTGS3k=
X-Google-Smtp-Source: ACHHUZ7VQQZ0ikJAWkNp8xCHvjVjdu+SxPZN/PKZrzG19hW5frCu1EN8wKEo5D8AiunaxEhqi282pQ==
X-Received: by 2002:a17:902:ec8c:b0:1a9:80a0:47ef with SMTP id
 x12-20020a170902ec8c00b001a980a047efmr2772161plg.20.1684421895453; 
 Thu, 18 May 2023 07:58:15 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a17090a2fcb00b0023cfdbb6496sm3545128pjm.1.2023.05.18.07.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 07:58:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	peter.maydell@linaro.org
Subject: [PATCH] accel/tcg: Fix append_mem_cb
Date: Thu, 18 May 2023 07:58:13 -0700
Message-Id: <20230518145813.2940745-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

In fcdab382c8b9 we removed a tcg_gen_extu_tl_i64 from gen_empty_mem_cb,
and failed to adjust the associated copy, leading to a failed assert.

Fixes: fcdab382c8b9 ("accel/tcg: Widen plugin_gen_empty_mem_callback to i64")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 34be1b940c..5b73a39ce5 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -254,33 +254,6 @@ static TCGOp *copy_op(TCGOp **begin_op, TCGOp *op, TCGOpcode opc)
     return op;
 }
 
-static TCGOp *copy_extu_i32_i64(TCGOp **begin_op, TCGOp *op)
-{
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* mov_i32 */
-        op = copy_op(begin_op, op, INDEX_op_mov_i32);
-        /* mov_i32 w/ $0 */
-        op = copy_op(begin_op, op, INDEX_op_mov_i32);
-    } else {
-        /* extu_i32_i64 */
-        op = copy_op(begin_op, op, INDEX_op_extu_i32_i64);
-    }
-    return op;
-}
-
-static TCGOp *copy_mov_i64(TCGOp **begin_op, TCGOp *op)
-{
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* 2x mov_i32 */
-        op = copy_op(begin_op, op, INDEX_op_mov_i32);
-        op = copy_op(begin_op, op, INDEX_op_mov_i32);
-    } else {
-        /* mov_i64 */
-        op = copy_op(begin_op, op, INDEX_op_mov_i64);
-    }
-    return op;
-}
-
 static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
 {
     if (UINTPTR_MAX == UINT32_MAX) {
@@ -295,18 +268,6 @@ static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
     return op;
 }
 
-static TCGOp *copy_extu_tl_i64(TCGOp **begin_op, TCGOp *op)
-{
-    if (TARGET_LONG_BITS == 32) {
-        /* extu_i32_i64 */
-        op = copy_extu_i32_i64(begin_op, op);
-    } else {
-        /* mov_i64 */
-        op = copy_mov_i64(begin_op, op);
-    }
-    return op;
-}
-
 static TCGOp *copy_ld_i64(TCGOp **begin_op, TCGOp *op)
 {
     if (TCG_TARGET_REG_BITS == 32) {
@@ -451,9 +412,6 @@ static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
         tcg_debug_assert(begin_op && begin_op->opc == INDEX_op_ld_i32);
     }
 
-    /* extu_tl_i64 */
-    op = copy_extu_tl_i64(&begin_op, op);
-
     if (type == PLUGIN_GEN_CB_MEM) {
         /* call */
         op = copy_call(&begin_op, op, HELPER(plugin_vcpu_mem_cb),
-- 
2.34.1


