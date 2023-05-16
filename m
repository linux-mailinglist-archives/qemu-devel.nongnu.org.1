Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF53705817
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0cY-0000lV-5x; Tue, 16 May 2023 15:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c1-0008V5-BF
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:33 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0bx-0003hm-An
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:32 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-24decf5cc03so54197a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266328; x=1686858328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDknFLWtWBKU8G+ToympZ5KLvdGdhGS895Fc1ZFjry8=;
 b=ssM1JCANf8OXdb6Dhy66GB+UqbtGtjMbhXbClq/mg5NrtGbGWILh1Hl5Z0zNYykRB5
 fGzqYHAy+rtT7NXVqd9PW7mU0c4j0TCiSVDnQJv9XKiZdLqnp+EFGWZUCPWjz1ccN7aQ
 fi9gXRem5JXWjzPpBCMcewuFCEya6tAGgqltKXk1Epj4DwCF2g1fGYGfxqwCl+8125qs
 TIgH8buGcYX+CmmoAC3CinwIdffViEOLHTmxt8f8ro/vpIP4WI0orW/ylhDgjVFT6A/Y
 ng6Gl7sbSV0K9EibvRO90Y7AhPB4inrilLrroh/86yR2V9qPAKmUm577bsORI0zpiiql
 U1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266328; x=1686858328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDknFLWtWBKU8G+ToympZ5KLvdGdhGS895Fc1ZFjry8=;
 b=h/Kd2hgcsqoL2YM68WjGYEO4yRGAnBTb8Z9QcZUEhD0mnoLg+zI/IGuklKSuw4rCOC
 iVjnd8U8hUZEuEFIfh9qjLcF2IxfPJCZu8+VHLlTb8aItRg/DiIkZmieRbYsxyGYEfeH
 6Qo32DHW6HULq+IBDvwOMqfaLnhAXUvrqdlBuqAXGcZc7Kqxk0hzcvdWrCxtc8qjhUFh
 M+aHUnKIWhsQd6v6uwKA9fXnEuxVi2NZ6ss1PVHWEAjzKoxEmRwtPTBlBJg9x4nCDNqy
 NLl+db4TX7krEQiQ6GOiBtePWxDIsumfBUNWVkX6BsJctfzncajFGOjSAc8Pa+q5tPpV
 7I5w==
X-Gm-Message-State: AC+VfDzT+QoCOBf/G0r8bpXvXWt6lFGvOn36SmKqty1dLwQmLC22Ya9r
 A5rtgjZ2l0R66U0cL/i/8Qwg5Hgn0EE4QaMSHPE=
X-Google-Smtp-Source: ACHHUZ6+XGQAIAt/7O6VgJG8bLARDbHbsFNB2uEY7Cmj/0Q3MCpSO2JJwFwdd71HxKIdosDN7lFoNA==
X-Received: by 2002:a17:90a:ac06:b0:253:36ca:7ea0 with SMTP id
 o6-20020a17090aac0600b0025336ca7ea0mr1236809pjq.27.1684266327792; 
 Tue, 16 May 2023 12:45:27 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 45/80] tcg/s390x: Use atom_and_align_for_opc
Date: Tue, 16 May 2023 12:41:10 -0700
Message-Id: <20230516194145.1749305-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
 tcg/s390x/tcg-target.c.inc | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 22f0206b5a..8e34b214fc 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1572,6 +1572,7 @@ typedef struct {
     TCGReg base;
     TCGReg index;
     int disp;
+    TCGAtomAlign aa;
 } HostAddress;
 
 bool tcg_target_has_memory_bswap(MemOp memop)
@@ -1733,8 +1734,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
-    unsigned a_bits = get_alignment_bits(opc);
-    unsigned a_mask = (1u << a_bits) - 1;
+    unsigned a_mask;
+
+    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
+    a_mask = (1 << h->aa.align) - 1;
 
 #ifdef CONFIG_SOFTMMU
     unsigned s_bits = opc & MO_SIZE;
@@ -1764,7 +1767,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
      * bits within the address.  For unaligned access, we check that we don't
      * cross pages using the address of the last byte of the access.
      */
-    a_off = (a_bits >= s_bits ? 0 : s_mask - a_mask);
+    a_off = (a_mask >= s_mask ? 0 : s_mask - a_mask);
     tlb_mask = (uint64_t)TARGET_PAGE_MASK | a_mask;
     if (a_off == 0) {
         tgen_andi_risbg(s, TCG_REG_R0, addr_reg, tlb_mask);
@@ -1806,7 +1809,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->addrlo_reg = addr_reg;
 
         /* We are expecting a_bits to max out at 7, much lower than TMLL. */
-        tcg_debug_assert(a_bits < 16);
+        tcg_debug_assert(a_mask <= 0xffff);
         tcg_out_insn(s, RI, TMLL, addr_reg, a_mask);
 
         tcg_out16(s, RI_BRC | (7 << 4)); /* CC in {1,2,3} */
-- 
2.34.1


