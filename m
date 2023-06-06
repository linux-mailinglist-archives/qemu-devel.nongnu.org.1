Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FF8723E46
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:50:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TJ0-0007qz-8H; Tue, 06 Jun 2023 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIt-0007n2-Ae
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIp-0004qa-Ud
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:39 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30c5e5226bdso3960311f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044913; x=1688636913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=saVBLGp5RRxhKxGY9uczCmgcyF1w9c+FkEWPJAN9vhE=;
 b=rZHbFO1PYgaMbNh0f2dza0PVq70N4PnWr39hPDUsF+fqOOEIKXmiwmtspY32Ku/8JK
 0fldZxDQ13CVeXAc4Us5yVTMZIFb7tV9ribyz93RHOKG4HS6QqBY7afD3rD2OBWldzLM
 MPkHNVyqc74bCzqW2Lo/ewVxJTdRg1urNd11Fr6z0TO2wyWbynvePVhMrBXjWcDxvbdq
 S4mr9z8N3xcO+n/7lmoDKC7kEUT1VJONvlfzYNvoIHZihRjxY7y6alyt5W+iy23Nja4h
 JgyVGv5Id1VAbfnp9c2TuL1G4X4tqWqeVyZlJoXveeNDzxm/4d39pbJO+zMQ8qeYe8+J
 38hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044913; x=1688636913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=saVBLGp5RRxhKxGY9uczCmgcyF1w9c+FkEWPJAN9vhE=;
 b=Jc1lZYF8R/qMDQwSbt8N6UCE+6arD7zbRnCzBmL7z2r2M0DQ9bMGkfiCuGxixs/b5x
 P2myAkR3JeXZmL145rO+03Jyoj78RlU3TVf+wjFd7RNgatJCvpEwOYcX1gVecb4FD/+O
 Cw9WDXXBIWIVbMwyzQyI80F12UEwzce3pJ3ab2Ni1ADKu/VSNqUDK0xkdBc41Ex755sq
 oUCiUVD8KTafPca84Bn3wbwMzJOFMTCLi9jWDoWgSWw3iShs5qp0sLSwSAG8wFy0krYV
 TODjJzRdRN3GlgKza/HUGqUmepXZyDBJtXyy9EgJd2ZnUQMQmn3vygySkyYWlChc2MYm
 kKYA==
X-Gm-Message-State: AC+VfDw/WFmPAZ2mg7Q4AzjfNtOIUGc2IrCgxFr75aPbb+jas0rH7klR
 yx6r0HTB3G6cHI7lz+Nt185wVMqcIG3AjgXAjFU=
X-Google-Smtp-Source: ACHHUZ7gXq95dgCvaHf0fDpmiEemip2ijFaDwoLrGwh5t4hFAdmlj4h7oU2HEZ+9R2aW1dH3JjOhEA==
X-Received: by 2002:adf:f212:0:b0:30d:5cce:3bb5 with SMTP id
 p18-20020adff212000000b0030d5cce3bb5mr1399606wro.60.1686044913364; 
 Tue, 06 Jun 2023 02:48:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/42] target/arm: Move mte check for store-exclusive
Date: Tue,  6 Jun 2023 10:48:08 +0100
Message-Id: <20230606094814.3581397-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Push the mte check behind the exclusive_addr check.
Document the several ways that we are still out of spec
with this implementation.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 42 +++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index adedebd1c22..aa93f37e216 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2512,17 +2512,47 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
      */
     TCGLabel *fail_label = gen_new_label();
     TCGLabel *done_label = gen_new_label();
-    TCGv_i64 tmp, dirty_addr, clean_addr;
+    TCGv_i64 tmp, clean_addr;
     MemOp memop;
 
-    memop = (size + is_pair) | MO_ALIGN;
-    memop = finalize_memop(s, memop);
-
-    dirty_addr = cpu_reg_sp(s, rn);
-    clean_addr = gen_mte_check1(s, dirty_addr, true, rn != 31, memop);
+    /*
+     * FIXME: We are out of spec here.  We have recorded only the address
+     * from load_exclusive, not the entire range, and we assume that the
+     * size of the access on both sides match.  The architecture allows the
+     * store to be smaller than the load, so long as the stored bytes are
+     * within the range recorded by the load.
+     */
 
+    /* See AArch64.ExclusiveMonitorsPass() and AArch64.IsExclusiveVA(). */
+    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
     tcg_gen_brcond_i64(TCG_COND_NE, clean_addr, cpu_exclusive_addr, fail_label);
 
+    /*
+     * The write, and any associated faults, only happen if the virtual
+     * and physical addresses pass the exclusive monitor check.  These
+     * faults are exceedingly unlikely, because normally the guest uses
+     * the exact same address register for the load_exclusive, and we
+     * would have recognized these faults there.
+     *
+     * It is possible to trigger an alignment fault pre-LSE2, e.g. with an
+     * unaligned 4-byte write within the range of an aligned 8-byte load.
+     * With LSE2, the store would need to cross a 16-byte boundary when the
+     * load did not, which would mean the store is outside the range
+     * recorded for the monitor, which would have failed a corrected monitor
+     * check above.  For now, we assume no size change and retain the
+     * MO_ALIGN to let tcg know what we checked in the load_exclusive.
+     *
+     * It is possible to trigger an MTE fault, by performing the load with
+     * a virtual address with a valid tag and performing the store with the
+     * same virtual address and a different invalid tag.
+     */
+    memop = size + is_pair;
+    if (memop == MO_128 || !dc_isar_feature(aa64_lse2, s)) {
+        memop |= MO_ALIGN;
+    }
+    memop = finalize_memop(s, memop);
+    gen_mte_check1(s, cpu_reg_sp(s, rn), true, rn != 31, memop);
+
     tmp = tcg_temp_new_i64();
     if (is_pair) {
         if (size == 2) {
-- 
2.34.1


