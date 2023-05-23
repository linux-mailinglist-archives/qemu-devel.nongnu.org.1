Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 632EA70DEE2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:13:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SSt-0005He-HH; Tue, 23 May 2023 09:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSH-0004bY-TX
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:39 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SS7-0002zu-IM
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:36 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d577071a6so3557887b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850006; x=1687442006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0B6ZiccHfjA9+3V6I3lMmu3S/Ef9HuPrl6mcYOHXodE=;
 b=x4HTLSoqRgazApQT252BV9W4VbPWh4fLVYMlkxXXuzWRsPUVxVsNhBOZsIDR/39wd/
 lgAhhoAN8LLUn39XxhEI/wJi1FPhBoXR8FEjdChwYthZWt1huLzmk3Y/CUaO4tRAammU
 Iw8ijHkRWs4pm5sSSvgy3X9phoYG2ldNMD6edoAG4pBHfKxseNmeN2AzTJxAsZHgsMId
 RBxc7l7bEDdSIDQtbJ9VGW6669shAEQDV12QumQcY1zBtcaxEy/V5wDbOmywwY7M0WO4
 KHlNHQZYjs+tWBC9Zoqx7tv1NZk3wfcwUMp1F1rHhJZZGGyasFK1WZCTIXyWGFQBsqf+
 Hesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850006; x=1687442006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0B6ZiccHfjA9+3V6I3lMmu3S/Ef9HuPrl6mcYOHXodE=;
 b=So+joKc7LlCVCsUG7l3MjED7A75hVule6ZKzZXAj2ZoiTBZNeldHVoY1EIW4PCpZEr
 Xuz2T+9xhVW1J2OiZSc4jh8h8ZA0xBiF4eMbFKmRkG4caQuKOeWuy86cOIMzRqMxbZTD
 FzJdrYphmNHd4znNW4JOG544EjFK2lxdPXsj/GHTrZgzBueHxIpDIyEUmCPnqCk+IZJA
 zYqlnVr4T/zaqkFbM1fgWDGh28cvxWRLd+x3nrXa6rolGNNyjJUAm8Ubyoq35S+wKNkH
 44XFIW9oQj+YVQSJBy+wbPm5rY4BvJA5m84RJ1xvrchRpZqrV9aykx8SgETJfV5EhhzO
 MMmQ==
X-Gm-Message-State: AC+VfDyjFyPJd+DTMmpOhjlYBbkrQQbHX7yGc1I1NmcWTjBrv7xmdiCO
 Ykbx5IAMaQGmmEgKKlpdpAF8/XSDk4Wf1C7wGyw=
X-Google-Smtp-Source: ACHHUZ5ya2ugQvs28eApBbrSuwzANS8OhNe/qisc9UPBAiUmbcqmdbscaSw/ZXnQgpx1Rtr0ltuIXQ==
X-Received: by 2002:a05:6a20:a111:b0:10c:3535:162f with SMTP id
 q17-20020a056a20a11100b0010c3535162fmr4770325pzk.0.1684850005799; 
 Tue, 23 May 2023 06:53:25 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/52] tcg/riscv: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 23 May 2023 06:52:32 -0700
Message-Id: <20230523135322.678948-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

All uses replaced with TCGContext.addr_type.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index ff6334980f..45bd09cfc4 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -908,6 +908,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
                                            TCGReg addr_reg, MemOpIdx oi,
                                            bool is_ld)
 {
+    TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
     TCGAtomAlign aa;
@@ -949,19 +950,19 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
     addr_adj = addr_reg;
     if (a_mask < s_mask) {
         addr_adj = TCG_REG_TMP0;
-        tcg_out_opc_imm(s, TARGET_LONG_BITS == 32 ? OPC_ADDIW : OPC_ADDI,
+        tcg_out_opc_imm(s, addr_type == TCG_TYPE_I32 ? OPC_ADDIW : OPC_ADDI,
                         addr_adj, addr_reg, s_mask - a_mask);
     }
     compare_mask = s->page_mask | a_mask;
     if (compare_mask == sextreg(compare_mask, 0, 12)) {
         tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addr_adj, compare_mask);
     } else {
-        tcg_out_movi(s, TCG_TYPE_TL, TCG_REG_TMP1, compare_mask);
+        tcg_out_movi(s, addr_type, TCG_REG_TMP1, compare_mask);
         tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP1, TCG_REG_TMP1, addr_adj);
     }
 
     /* Load the tlb comparator and the addend.  */
-    tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_TMP0, TCG_REG_TMP2,
+    tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2,
                is_ld ? offsetof(CPUTLBEntry, addr_read)
                      : offsetof(CPUTLBEntry, addr_write));
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_REG_TMP2,
@@ -973,7 +974,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
 
     /* TLB Hit - translate address using addend.  */
     addr_adj = addr_reg;
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         addr_adj = TCG_REG_TMP0;
         tcg_out_ext32u(s, addr_adj, addr_reg);
     }
@@ -995,7 +996,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
     }
 
     TCGReg base = addr_reg;
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         tcg_out_ext32u(s, TCG_REG_TMP0, base);
         base = TCG_REG_TMP0;
     }
-- 
2.34.1


