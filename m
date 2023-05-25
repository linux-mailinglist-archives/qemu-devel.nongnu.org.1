Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FF1711A91
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:27:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLl-000610-EL; Thu, 25 May 2023 19:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLd-0005v2-T6
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:24 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLX-0005pq-NZ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:21 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-528cdc9576cso84499a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057173; x=1687649173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nH2fDEqJMLjGJ94XHGNSezah8PhFABFUd5z9bFsr8bY=;
 b=s9bev9EzPbIp+avWjI4z0rBnz3v1tsdGaCA1JdAoq23NX0C8oaTaUS9D9hpdB7KVcb
 2rQuV1mf/xpygvJBlxdE4M6eMSV16/9MbRRaKjlKDb0aeX+umV0nGcSN13QekHtDp8jd
 7sC6IUbxPDRmBA+kcOSh6I4pmg+97EjuwC5kiGCPAf/7CNLUgJ8wWw8g7HyIXTmwr5U0
 Ku8ra8HQ2syC9CqNjOT4Y108+wFgUGVlTJQJXV9bv97DdGUUrgWlHszgzStYY5D4PDso
 9kZe5V3KjJCuS5CkjmiPBBhZB6MqGTtaD3vJJNHmjXU0juHLv/pSEIL7ZqGojubv8/iN
 UzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057173; x=1687649173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nH2fDEqJMLjGJ94XHGNSezah8PhFABFUd5z9bFsr8bY=;
 b=Co6uQmlXfFkj0RYtOfG3uvah7oN2THRVs96nMPfhl/xsh/5V6kDATNAjPtLmaxHDd9
 4oPWR7muFS843oRtUhF86I8j+WNJwwQ6ilgL2tkJHEGDd4GItm8GrmPrXr04XzFL2dhM
 N49ztyVYJyTBDOujVHgwk23hBmJn3zNNuzUE8L0kEkccIoXcD0XF0n3sX1uFapqeHEAq
 m1A211IdXlM4EmMF7gQ5PCfZw8G9tC2xozHQ5bkaxJ9nxoMqvzC/MjJObBUbxTZ+Zxl7
 mu9TDYkjjjPYDO68GR7ytzXYI0DmZXTspcDZu3MrNy668+HYmduld6Xdz9ZrGQ+nMiLw
 oIAg==
X-Gm-Message-State: AC+VfDzHJ8dvxrsPxWbV1rkyaOWOYth79RNGhHG6wl0KWr534xmmsy/N
 iz482Q2/VCyDOq4/8R5sbAsykl73uGh7MmkTNHI=
X-Google-Smtp-Source: ACHHUZ6kH3TwrP3AcFPImJ9h1OioenQfoag7bp8khrysXiymlvLCOGFPBIpdzLQLT5iloBLMdmSOmg==
X-Received: by 2002:a17:902:ab5a:b0:1ac:acb5:4336 with SMTP id
 ij26-20020a170902ab5a00b001acacb54336mr412392plb.33.1685057173345; 
 Thu, 25 May 2023 16:26:13 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 17/20] target/arm: Move mte check for store-exclusive
Date: Thu, 25 May 2023 16:25:55 -0700
Message-Id: <20230525232558.1758967-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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


