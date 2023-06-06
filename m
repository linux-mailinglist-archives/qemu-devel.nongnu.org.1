Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C6723E53
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIv-0007nc-1u; Tue, 06 Jun 2023 05:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIo-0007iu-Ps
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:34 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIj-0004iB-DF
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:34 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30af86a966eso4817010f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044907; x=1688636907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TyN8BBiVX37l+68qnT5ImTB054PoDyS+aJzg6ATQJOw=;
 b=oZLBBLGnyvCQ64wdmjZ0t0d7QUAdATdjGS8WWl/9u+1s6LjZuCOqlD193ocCW/o0Tm
 eeOsU1F3QTx2rCiBUpT9Ev3h6ZoM+4g5bUeYReSGHOGHxcrevZ1SUrJR5uy1TaACFZ7S
 q/YKVXDJisfuiLSxdrCIoRLQzKnRJzSqnqcWtpgluzPoxSmqInmHQuKHoljtnv+9DJhZ
 GmFbMd3nfWJdFScN/UyiPWlK+tLHYad2xVbvZSI7eScna197jzKYa7eUZH4eb4C2IH5z
 Jz9udl2oE9msUFFZQxiU4TQmo+qElHe5WQSrpbm5f2hAu2KSdquYpiKTGnoUypxxZKBt
 KjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044907; x=1688636907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TyN8BBiVX37l+68qnT5ImTB054PoDyS+aJzg6ATQJOw=;
 b=iW9BQuTcklJol0Fxa23d2MvwlHz9HeF17Gqa5aC/IKo/K2BhnwNMxWYuaPDD4E+voD
 8b0SYG6LP5SpqKfs2hXndCr2ayuSBAXEemyfB9G4RXexD0wjCuU+fs3W3Ye8YY2uXH21
 5DfV7l4MX1IAD8DTtnLaKEzqFnXIyBK/fOELTHntKUrGw4eiWFFo/LT7SzitU5E0f5oM
 BzBgMh4yjPk5X2Fus8VmhfljrF4DsD8JSgUosVt0q/ku+1fwNz02PisgLI2Oq1Pc+67K
 GDUUxkzTBsmfvqRPm51OIJDdyPVxEHfxdJhHiSHZn3ufWRmzOHP4drwOhPGbe9jNBzVM
 7pLw==
X-Gm-Message-State: AC+VfDz72bbH5NRDPu1jBuw73kv1zO9Z69FrIAAsbBjWp1KtxlSecGhb
 0q4IJJBRxdfXyH4eIbt0VrQCOvEX/gOB4ca5EJA=
X-Google-Smtp-Source: ACHHUZ6purKBS/ChM2OrYV1rg3zpUV8ydSd3HDFi3qkPeGDXoOyMbapecLJ5vncn4ZPq8PN17HP0qw==
X-Received: by 2002:a5d:6903:0:b0:306:3da7:f33c with SMTP id
 t3-20020a5d6903000000b003063da7f33cmr1289926wru.63.1686044907232; 
 Tue, 06 Jun 2023 02:48:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/42] target/arm: Use tcg_gen_qemu_ld_i128 for LDXP
Date: Tue,  6 Jun 2023 10:47:55 +0100
Message-Id: <20230606094814.3581397-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

While we don't require 16-byte atomicity here, using a single larger
load simplifies the code, and makes it a closer match to STXP.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1d34c5a7031..1fff74c73a0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2386,14 +2386,14 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
                                TCGv_i64 addr, int size, bool is_pair)
 {
     int idx = get_mem_index(s);
-    MemOp memop = s->be_data;
+    MemOp memop;
 
     g_assert(size <= 3);
     if (is_pair) {
         g_assert(size >= 2);
         if (size == 2) {
             /* The pair must be single-copy atomic for the doubleword.  */
-            memop |= MO_64 | MO_ALIGN;
+            memop = finalize_memop(s, MO_64 | MO_ALIGN);
             tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
             if (s->be_data == MO_LE) {
                 tcg_gen_extract_i64(cpu_reg(s, rt), cpu_exclusive_val, 0, 32);
@@ -2403,21 +2403,30 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
                 tcg_gen_extract_i64(cpu_reg(s, rt2), cpu_exclusive_val, 0, 32);
             }
         } else {
-            /* The pair must be single-copy atomic for *each* doubleword, not
-               the entire quadword, however it must be quadword aligned.  */
-            memop |= MO_64;
-            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx,
-                                memop | MO_ALIGN_16);
+            /*
+             * The pair must be single-copy atomic for *each* doubleword, not
+             * the entire quadword, however it must be quadword aligned.
+             * Expose the complete load to tcg, for ease of tlb lookup,
+             * but indicate that only 8-byte atomicity is required.
+             */
+            TCGv_i128 t16 = tcg_temp_new_i128();
 
-            TCGv_i64 addr2 = tcg_temp_new_i64();
-            tcg_gen_addi_i64(addr2, addr, 8);
-            tcg_gen_qemu_ld_i64(cpu_exclusive_high, addr2, idx, memop);
+            memop = finalize_memop_atom(s, MO_128 | MO_ALIGN_16,
+                                        MO_ATOM_IFALIGN_PAIR);
+            tcg_gen_qemu_ld_i128(t16, addr, idx, memop);
 
+            if (s->be_data == MO_LE) {
+                tcg_gen_extr_i128_i64(cpu_exclusive_val,
+                                      cpu_exclusive_high, t16);
+            } else {
+                tcg_gen_extr_i128_i64(cpu_exclusive_high,
+                                      cpu_exclusive_val, t16);
+            }
             tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
             tcg_gen_mov_i64(cpu_reg(s, rt2), cpu_exclusive_high);
         }
     } else {
-        memop |= size | MO_ALIGN;
+        memop = finalize_memop(s, size | MO_ALIGN);
         tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
         tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
     }
-- 
2.34.1


