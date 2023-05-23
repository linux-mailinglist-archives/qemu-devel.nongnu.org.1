Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E957870DE0B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:54:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SSW-0004ad-CF; Tue, 23 May 2023 09:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSD-0004Ig-Ev
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:33 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SS9-00030F-GG
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:33 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d2467d640so6480913b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850007; x=1687442007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wZqbKGvvBLnxdV8hORtypSTdUMPJNxpFAqcst10iFXc=;
 b=COHHOmsaIjZG39q6zg74Ktlio7u+mEC2PrH+PgR7ot9+JLiiDzjMv8q6SCfSSdTb5x
 5YaSWiq5MBqUMHk4pr2iB7zz65lB65hvtEHl2gzgMw7zFk1sFPyrzUkVobpEtc5u77VK
 bYJ4foGJ4g9wWkuHzfgTJ6JYD/8wGXf5ro3uG7DPQzd0mXyu4EKrjosm1Wt4UmckdhO5
 qSzR1Olht9HcUw1Fx5mhOtAfTenYaEuv8RyhdsdLAX9uOaAy5ah4BCflTa0YxO31sG7y
 EwFlwSpJJHWngcOKQQG54UtUB3G575VpWEZewZvE29WndwYIWL9CaeBxv4H7CnDhXR1p
 XgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850007; x=1687442007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZqbKGvvBLnxdV8hORtypSTdUMPJNxpFAqcst10iFXc=;
 b=RtLzocZEWQYfF5uoklUmz1TmAmoUB+MwrIdb5fJbZu29HDw/2O397EE7zp53kHS2+J
 mgKbfPMvHU5YouWjbp6RTZMuqTa+X3xToGIz8QlJaOeL1my9KKEUElNJEj/aZWznpTT7
 +hhHZFamhyn1jE+LT5/H4LC3Bxr5p9Tq1AYfHvfLkhj62i1jK6iHDWqdXXRbslpXm6j3
 vtQYbeRnxcuynXrnH5kazrJjb4PY00tiVuXiJflcTn/sHVLGaZPCtP7e/Rd63rjYeepl
 8bdC4P23mMtskUTZ2Ot5SzAqd/wfVprsOphRzMomHYo2aQwBN14zz5qZF2ohTaHpWGZn
 44Nw==
X-Gm-Message-State: AC+VfDyElhuYoISZuPAGGo4j5+7BM/m2Q7qupF7wuo/ilH/XqI+1H/9D
 TRpHkt/4CBWzAaL1e4+aPunf6/fO4gj5KT/I3yI=
X-Google-Smtp-Source: ACHHUZ4hF8OuZRDSyRqz+GNENDqvO3WzaNe0TQ/l/FVcHx3mfPG41VvYFw7F5ZR2ngIJvfnJJLKTGw==
X-Received: by 2002:a05:6a20:e68e:b0:104:41a0:c51a with SMTP id
 mz14-20020a056a20e68e00b0010441a0c51amr13121910pzb.38.1684850007323; 
 Tue, 23 May 2023 06:53:27 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/52] tcg/sparc64: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 23 May 2023 06:52:34 -0700
Message-Id: <20230523135322.678948-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

All uses replaced with TCGContext.addr_type.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index d2d0f604c2..48efd83817 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1027,6 +1027,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                            TCGReg addr_reg, MemOpIdx oi,
                                            bool is_ld)
 {
+    TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
     MemOp s_bits = opc & MO_SIZE;
@@ -1063,7 +1064,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_arith(s, TCG_REG_T1, TCG_REG_T1, TCG_REG_T3, ARITH_ADD);
 
     /* Load the tlb comparator and the addend. */
-    tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_T2, TCG_REG_T1, cmp_off);
+    tcg_out_ld(s, addr_type, TCG_REG_T2, TCG_REG_T1, cmp_off);
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_T1, TCG_REG_T1, add_off);
     h->base = TCG_REG_T1;
 
@@ -1084,7 +1085,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->label_ptr[0] = s->code_ptr;
 
     /* bne,pn %[xi]cc, label0 */
-    cc = TARGET_LONG_BITS == 64 ? BPCC_XCC : BPCC_ICC;
+    cc = addr_type == TCG_TYPE_I32 ? BPCC_ICC : BPCC_XCC;
     tcg_out_bpcc0(s, COND_NE, BPCC_PN | cc, 0);
 #else
     /*
@@ -1110,7 +1111,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 #endif
 
     /* If the guest address must be zero-extended, do in the delay slot.  */
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         tcg_out_ext32u(s, TCG_REG_T2, addr_reg);
         h->index = TCG_REG_T2;
     } else {
-- 
2.34.1


