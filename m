Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5514716D79
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:23:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44oK-0007U8-Cj; Tue, 30 May 2023 15:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44o5-0006oK-Hd
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:57 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44o2-0004jy-PC
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:57 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d1a0d640cso3680480b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474093; x=1688066093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nH2fDEqJMLjGJ94XHGNSezah8PhFABFUd5z9bFsr8bY=;
 b=fVvXtjXNCWOAB9/C1UfSfdy16gKCBFfbTxi0ai7H3QqgODWYkXYwU2JFJjL5v3hhef
 1MxmGZ4Kkk5mTV0Sysm62V1dt8FhbOb59UoThZ8dazte3wuHTKLD6hT+CFMVx4ylVDOy
 efnUhRkyNJR/xO6HSK6nAh5SLSGVpLSOG2ztikNKlEgcc05T7BfsIpU53AgZv5llysoP
 bruRcUtCLM8Ae7WZWCxAfsel6QzvvtI2fNol8UzLZyqSi9HUkyctxHLBy05wYx1fpNfG
 Ghk1SPqZjJ/Js/d3r6XLb974ySLCoFOOi8KlQ/mIx7uu3b2tFoj8WvqJdaKHGOQsN6Jv
 Gt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474093; x=1688066093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nH2fDEqJMLjGJ94XHGNSezah8PhFABFUd5z9bFsr8bY=;
 b=QT6eJgOEzmV9dUVm4GmmvMU05XjZBnAo3CofkJD4+ncr1Ctd0InJkdmzlzNWKw5BLr
 PDfqn4ogo1av6oYolF5Rl3e7j3YSTNcosrljTlptvs3UQCDWRDHtKtsj19l9gFnF6bZf
 0/LNQZiJnm3WmZcCnzpeSA7y2eGoXGh4fo85F6ShmQ0UixsUB7cDGehE5CDlxeLTmqP4
 2Xw4rIaD6cvg6dsTsfj4WGbyWXriujb9YtCIbuC4uxbFrtxItbU4yNSfriTqPOxiUvrf
 fqDj0BcAztFNf2VSlYkRCtVJE1mW+TXQWSEkRfMMRv7Go0eNVdj7QmGCPRq9MSDje7Od
 oM+A==
X-Gm-Message-State: AC+VfDy9ofa2n8VQuRQFTYyxtazVf10BE+0gppN8nBqaXY+wCqVhkJrV
 Ck8VVrGxtF95BQQCtd6OGfPC4mD94FioIxtyaTg=
X-Google-Smtp-Source: ACHHUZ7PAzcVZDtkXATH0T6GfeZpDpgOZukL1Ve8iOIDtxrFqK+x0QNFQRFR26ARVX1k8PwpyQwccw==
X-Received: by 2002:a05:6a00:10c4:b0:646:663a:9d60 with SMTP id
 d4-20020a056a0010c400b00646663a9d60mr3704297pfu.10.1685474093538; 
 Tue, 30 May 2023 12:14:53 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 17/20] target/arm: Move mte check for store-exclusive
Date: Tue, 30 May 2023 12:14:35 -0700
Message-Id: <20230530191438.411344-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Push the mte check behind the exclusive_addr check.
Document the several ways that we are still out of spec
with this implementation.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 42 +++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 49cb7a7dd5..9654c5746a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2524,17 +2524,47 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
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


