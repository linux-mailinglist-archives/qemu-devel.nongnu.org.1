Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01055723166
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GcR-0001lO-Qx; Mon, 05 Jun 2023 16:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcP-0001kj-8i
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:15:57 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcN-0003ju-Nb
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:15:57 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6537d2a8c20so2336828b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996154; x=1688588154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIYhvEBe+5na9q7sHii4+3BzV/97aBHrhxLYvL4RaKA=;
 b=x1m7aCsS/nkatNWFv0ZemDFOeRejzgwuKIgZCpTSmAvJ62iHyt5wyQ0I6Kt10AlinX
 9IAhctQCgDVboP183ZT5mRDi8roef29FD4BAPMeFOBiELFoaiiOCNjpkJkg05EwP4bRK
 x9+kDVH0fteulBwDVOPEo3rvzQyf+eMkgmrtmypNHPngVkhM7myay2ghQZZOJPlBlV3/
 Nw8swO/2zABK1jJItOct+uj7Ld1vB9ivsVTAM8MJaCC4v17g2jAFGKT/74lWm4ttI2H+
 mjAZXQe1GGN4+sPTf6GNLElvhX+kx3SeOlO1HaRzr8mvN2MyDEZU6WmMHLPzBtxSofK8
 GWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996154; x=1688588154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HIYhvEBe+5na9q7sHii4+3BzV/97aBHrhxLYvL4RaKA=;
 b=HIMfdN9lQZ+BZg+JzkzXjOJgiWsWBbz2G0dLZerLNCzGQ2XeVB2Gs3htr7hAySS8Kx
 jvITByKKErS+e1VMZ/5ZI+wicJcDfEldaAvCLeu9YHJaGanAhPSgWOhj0lfx7NXjwpOM
 W6uvJ/r/IWaahl5+3QD0j3TrWGJXIg3HCnR46JvpoY6Q0iB+TMgyaRh0DWlr5e4DpZ/J
 CFOd45IaTb/dB3aI0H+h7le/Rf2aAia93ksn/np9fBZhdeXnVg1A1058FWD8b4BER3gP
 6Eit8ILwANNITo0YaPohbv22G5QWyRtxfd36iKxy41hFitLrl+jUAhYIbujlimrFAfYN
 ILvg==
X-Gm-Message-State: AC+VfDwmil4a7v/bTRqkjraDzrDZ/qeZ2HhdMcXEoxxMAIWPKT97XLs+
 6z8jbJ75V1wYxH62HAEDOM/npKPj3uhV4mMWwus=
X-Google-Smtp-Source: ACHHUZ52zXmZl+dZk0Es4sNxhgx3vVmceQs28BQcOtuYYai9QjWDqtnu0xJWwgx0ja+ZnsByHc4xrQ==
X-Received: by 2002:a05:6a00:1a12:b0:64f:aea5:7b49 with SMTP id
 g18-20020a056a001a1200b0064faea57b49mr776628pfv.17.1685996154261; 
 Mon, 05 Jun 2023 13:15:54 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:15:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/52] tcg/sparc64: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Mon,  5 Jun 2023 13:15:00 -0700
Message-Id: <20230605201548.1596865-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


