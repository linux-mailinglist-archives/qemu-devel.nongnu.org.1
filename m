Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B29C7057B7
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Z2-0006pt-VA; Tue, 16 May 2023 15:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yy-0006oW-LD
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:24 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yv-0002qM-VK
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:24 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64359d9c531so10855445b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266141; x=1686858141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3YFUaaopV6WveVfV6rOwrHSft/KYLRd6VT0ztExKVY=;
 b=sOw/RUc9Mt/aInBfeqFL6pOdR6kkkVAYqZr9IW4ScqNCTYdljtgJxBwu2ScU+bt3mj
 n171MAIQZgsUrD246NEvfPvHdPvc8CzDfa5zsBf6DtTf6n+QlQWKRnNoWr3EUebVm7/T
 W8JmMRshGw+ZRAgY6VJWOU8a4q/z8tvGC7jt3r+Yc0pTXroSvgPvy1viuPy49a5y4PG5
 zM4/YmRjVoEHBIgAMUMIvjp2GXip4D/3wTZfU60h++JE5u6er50xX9Z1kibd7fI1XJiv
 MOVMpxrur6ieoijtYybDlcjZxVF+s2NlkDYM90GknuqXb6Z5jpEXqx3RD/KMjYP/uiRD
 tmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266141; x=1686858141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3YFUaaopV6WveVfV6rOwrHSft/KYLRd6VT0ztExKVY=;
 b=etGLCOqd54TYNdncVEpn+jvAIQXzPwU4Au7osiZdLy/+i8jBOH/Z6eLtA7Pkk0xGc0
 WwgcteqpqGke5J+fDCFaNXWKGlXsK4DL6SPAZ0+0eu9FOMn2jc4C6h5MFgceNfcj5L6P
 QsChwWwTExCfmWYLq4MvxQILR+U7ZF3EAG1GD7iqLVkRef04Wzn5E/Z7KEDOo1Wyklsc
 XvcUiZ2Cs4T1KyWt281uFt3HUufM1tlbNfEQ2TY4t4WyfN49jvraE3FYdJATfsL1WWIF
 IP8Kkn+Fd9Qy0LJha8QW5fgrWNOVyaxO01WEGGTmMdTyZ5QvwrINEI+GafKE3FIqrQfb
 2EoA==
X-Gm-Message-State: AC+VfDyYbXgRovvHVS/1R5bJw7A09SuDu8PRJ+nLzBFqYE3OP+ONTBKj
 HlQmSXnqk0BDu7iIQhcJe0mbFQZybGRqzzb8fxM=
X-Google-Smtp-Source: ACHHUZ5nVGSSLRCxwXl30YJk3/4eVCq1qhQH1lJ5B3ktAYuL5DPUkKe021IRJYhz/hxA+9dOzTAJQA==
X-Received: by 2002:a05:6a00:b54:b0:64c:c841:4e8a with SMTP id
 p20-20020a056a000b5400b0064cc8414e8amr3006039pfo.22.1684266141160; 
 Tue, 16 May 2023 12:42:21 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 38/80] tcg/i386: Use atom_and_align_for_opc
Date: Tue, 16 May 2023 12:41:03 -0700
Message-Id: <20230516194145.1749305-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

No change to the ultimate load/store routines yet, so some atomicity
conditions not yet honored, but plumbs the change to alignment through
the relevant functions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 6d55ba5a1c..3b8528e332 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1774,6 +1774,7 @@ typedef struct {
     int index;
     int ofs;
     int seg;
+    TCGAtomAlign aa;
 } HostAddress;
 
 bool tcg_target_has_memory_bswap(MemOp memop)
@@ -1895,8 +1896,18 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
-    unsigned a_bits = get_alignment_bits(opc);
-    unsigned a_mask = (1 << a_bits) - 1;
+    unsigned a_mask;
+
+#ifdef CONFIG_SOFTMMU
+    h->index = TCG_REG_L0;
+    h->ofs = 0;
+    h->seg = 0;
+#else
+    *h = x86_guest_base;
+#endif
+    h->base = addrlo;
+    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
+    a_mask = (1 << h->aa.align) - 1;
 
 #ifdef CONFIG_SOFTMMU
     int cmp_ofs = is_ld ? offsetof(CPUTLBEntry, addr_read)
@@ -1946,7 +1957,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
      * copy the address and mask.  For lesser alignments, check that we don't
      * cross pages for the complete access.
      */
-    if (a_bits >= s_bits) {
+    if (a_mask >= s_mask) {
         tcg_out_mov(s, ttype, TCG_REG_L1, addrlo);
     } else {
         tcg_out_modrm_offset(s, OPC_LEA + trexw, TCG_REG_L1,
@@ -1977,13 +1988,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     /* TLB Hit.  */
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_L0, TCG_REG_L0,
                offsetof(CPUTLBEntry, addend));
-
-    *h = (HostAddress) {
-        .base = addrlo,
-        .index = TCG_REG_L0,
-    };
 #else
-    if (a_bits) {
+    if (a_mask) {
         ldst = new_ldst_label(s);
 
         ldst->is_ld = is_ld;
@@ -1997,9 +2003,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->label_ptr[0] = s->code_ptr;
         s->code_ptr += 4;
     }
-
-    *h = x86_guest_base;
-    h->base = addrlo;
 #endif
 
     return ldst;
-- 
2.34.1


