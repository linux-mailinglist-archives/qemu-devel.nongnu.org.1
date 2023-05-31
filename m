Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F277174FA
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:14:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D3s-0006sx-0J; Wed, 31 May 2023 00:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3h-0006ot-Co
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:37 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3f-00069D-K8
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:37 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-19f6f8c8283so2117417fac.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505814; x=1688097814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wZqbKGvvBLnxdV8hORtypSTdUMPJNxpFAqcst10iFXc=;
 b=ipVfoGUQiwD8E+nlTnRN7Z/HDWoW2+6JE9Xyf41aAOa86bnTy5s4/Kld2hAAhBsGaN
 DGm4W5Sf3iUHNY6Mso3BUCxdciQrtC0Qi6bcJK30K9pk48QvyD8O7GERZlfIcqbawtND
 jTLaHe8EjL4JW3t+LCnEkX/rX2BQXMs1XaCAJRvY6V9ywKrVsZ1SQseiL9g8116PXD70
 uZ70TPxwUTSabc/rsPVo1NZzX89k2jRKufGel/y5ekoPg8SXXoz0P1WWW1aYYWyy0nN4
 K2A8NH2tjqD8oO+PQ32oUnKrNk4DIypYLe67EQGXSAnVYSnGqC04PIoQq+u5rJRMcI+f
 1DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505814; x=1688097814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZqbKGvvBLnxdV8hORtypSTdUMPJNxpFAqcst10iFXc=;
 b=CQkogMSdcXiL/aSQRPUNNlSqjfN1g0H77Z5FmylCz8dHd+qYTdgA4LXVtaawOifgz+
 s8kMRKR/pfc2vYoa5ZDoPf7TDz1SO3/j5Qr8C/y3axh3Ayash1jQ9eqJA44LryrZp0e1
 eELwuYWtyPcvcACGibYaX1NDq8lhjz4UHjXBVT7ETwAEgChmPZEa71tdF9s3sAgHrGDo
 CbHJimP83p0TJwPEeG/CXmTbw2WyzHsO4kmpar8/xDcZkcEp2HctTMS2+TGPNLyGnqQJ
 +Vl/ym7pjeJjeSqb3FfEbvgYuKIuWWufkxtUBl2zVX7dZl15H8BS1qd5J8X0m1hk3aH0
 BMdg==
X-Gm-Message-State: AC+VfDxGG2UmLynMNr+v0JttGWrmDmNKcT2Ih7kAvPwQZ72Pp4CJW2nN
 2ssffvrjmT18RyX7sV8wt4YXPiV6ApTNSKmobZY=
X-Google-Smtp-Source: ACHHUZ71rssNWJvAV/9gcXyrGYvQo0f9shWP3DXGRlFkpEgmT7xtgdz8YWFY3VZ0hSyD7x4a8EAlCQ==
X-Received: by 2002:a05:6808:3405:b0:398:4d7f:6c7e with SMTP id
 by5-20020a056808340500b003984d7f6c7emr2407138oib.46.1685505814431; 
 Tue, 30 May 2023 21:03:34 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/48] tcg/sparc64: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 30 May 2023 21:02:46 -0700
Message-Id: <20230531040330.8950-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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


