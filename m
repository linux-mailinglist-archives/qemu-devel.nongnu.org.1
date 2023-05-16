Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF33705826
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:59:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0cI-0008TD-7w; Tue, 16 May 2023 15:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0bx-0008Ou-S0
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:30 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0bu-0003fy-RE
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:29 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-24dec03ad8fso49125a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266325; x=1686858325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=COeCBcDhyHAzyrUtiEtch7tCJeKP75ntgsjZMHrLAcw=;
 b=ST7KVI/X+uG6HJ8ZuY28QOQwO49NpfLn8kNqobVDey1otUh1nCB/V2qlokNOJsPX42
 Z+UOwRTNY4PO74quE3k+eXt3SDCcMIBJHWAYmHVuKjR9QcQDsaq4K0NfJDM3L0RRp7Jm
 /6sCaIn6+bDvM0NNi4PCt/hyGZQfYoGVTyDxdgXXcXWrsWpentqUG/sqW2Lg7pPq/yES
 qAT3lpoLFPMb0aummrYd7VTpitJPhKtMeGXdGJacBP0NMLR6X8zsci+YManoPlvzNG9U
 96ean41NrDzFo1wRwr8ZDhAE9dP5pvfUwzZcIbsGYw9siSDVAg5drovWwgGXzEFq7Jbr
 pt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266325; x=1686858325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=COeCBcDhyHAzyrUtiEtch7tCJeKP75ntgsjZMHrLAcw=;
 b=KNfXEuCErtywHYA/Rz2JYJiaithC9MlGdXt6eWh4Rcqx6DemBeuR5uw50BF+ygzneK
 qzR+VQ/q1qGDEhhhfgx8x8nfGHvozv2X1hWgy3GAxKmNUPJmQSGIMTnPgupsMHLTKOuR
 n48ncScQpbLhKBVPGFSjig57X3t0fdxsS+1p5hB8aL8z8VOqJalEyzYY3UkleBh6VOhr
 T1ObAql2uEsVOGnLKhaQdO1FVgC2mE9Y9P5w0E1mg9qimrB5mm6bs7AYRa2YBWB4ihCH
 IS5kF8IcCT+67L0yeMxYuhCYl5+TlLRTN3fzGdkx4cRVKqJTXgZ+JMQSvctAvXhdv9l5
 UhYA==
X-Gm-Message-State: AC+VfDzKOBGqYOubv4rZSPEiDePLgxd2hhfvgDr47sX7VjWd5sl8GVz4
 MCOiHB6iJcViuKHApMgwOrgbwf3Xb6p03+8dkto=
X-Google-Smtp-Source: ACHHUZ6HEblWBWTYut6FI0wxp/zdJt/oyNuW4iWDwQH6xx6J07aeDeXB+AMl3UfyfX74jw3Zf1h+Xw==
X-Received: by 2002:a17:90b:38cb:b0:252:b95c:a701 with SMTP id
 nn11-20020a17090b38cb00b00252b95ca701mr15376666pjb.32.1684266325267; 
 Tue, 16 May 2023 12:45:25 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 42/80] tcg/mips: Use atom_and_align_for_opc
Date: Tue, 16 May 2023 12:41:07 -0700
Message-Id: <20230516194145.1749305-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index cd0254a0d7..3f3fe5b991 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1138,7 +1138,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 
 typedef struct {
     TCGReg base;
-    MemOp align;
+    TCGAtomAlign aa;
 } HostAddress;
 
 bool tcg_target_has_memory_bswap(MemOp memop)
@@ -1158,11 +1158,15 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
-    unsigned a_bits = get_alignment_bits(opc);
+    MemOp a_bits;
     unsigned s_bits = opc & MO_SIZE;
-    unsigned a_mask = (1 << a_bits) - 1;
+    unsigned a_mask;
     TCGReg base;
 
+    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
+    a_bits = h->aa.align;
+    a_mask = (1 << a_bits) - 1;
+
 #ifdef CONFIG_SOFTMMU
     unsigned s_mask = (1 << s_bits) - 1;
     int mem_index = get_mmuidx(oi);
@@ -1281,7 +1285,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 #endif
 
     h->base = base;
-    h->align = a_bits;
     return ldst;
 }
 
@@ -1394,7 +1397,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
     ldst = prepare_host_addr(s, &h, addrlo, addrhi, oi, true);
 
-    if (use_mips32r6_instructions || h.align >= (opc & MO_SIZE)) {
+    if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
         tcg_out_qemu_ld_direct(s, datalo, datahi, h.base, opc, data_type);
     } else {
         tcg_out_qemu_ld_unalign(s, datalo, datahi, h.base, opc, data_type);
@@ -1481,7 +1484,7 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
     ldst = prepare_host_addr(s, &h, addrlo, addrhi, oi, false);
 
-    if (use_mips32r6_instructions || h.align >= (opc & MO_SIZE)) {
+    if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
         tcg_out_qemu_st_direct(s, datalo, datahi, h.base, opc);
     } else {
         tcg_out_qemu_st_unalign(s, datalo, datahi, h.base, opc);
-- 
2.34.1


