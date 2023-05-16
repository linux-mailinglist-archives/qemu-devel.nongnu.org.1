Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5348B705824
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0cM-000074-QW; Tue, 16 May 2023 15:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c0-0008TU-Kz
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:32 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0by-0003hv-Mu
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:32 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so13457882a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266329; x=1686858329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=peJEfVzHrcMF90ZjxGIbaEJp8Gj9YCBgCnVRbK/FL9k=;
 b=LYReWlvmgFOaI1hdUN/H6WF3Fso+et9COcYdU6xRrGX8+9C1JnR/+NYdfhStvE9IqM
 vN7fmXZZP5mp0yWD22COsrmjGIp0QiA40Hy0Jvckcn9+CEiEOwtzKGjH8fQwAvq5Gc/V
 gVyO1OhieRVeY+A2SnjTX/S+jhGhS6Chq08tQm/i9AJtrGhjxMmu2O9PmOT8rOVK8IQ/
 yvoUBgrJ/FWFiQH/wcH/wxdUHWtufRvn6N4y9GsH1pxdoe3qs9B30xjUdoOwAjRMplL3
 25IdB7OAqDT2OlkIRc9maY/xXDDiSLbrveqwrnDkc4kBrtCV0Q/iRhPO1Is2/RfD3OVq
 WkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266329; x=1686858329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=peJEfVzHrcMF90ZjxGIbaEJp8Gj9YCBgCnVRbK/FL9k=;
 b=Lk7zPOzIAmINttq1A0xRC2dLcL4oa7F7hRx5/4eZS+YptOK1mvNn7VqK4TX/C9v6GT
 cp4br0izTUtK7EAv5cAOs+XiCPDstoe5BJdXciNLyObKFhfqbzCyP2XjmPWfgD11WkQe
 /3P1vNKG4Ufrmujlyf9huv48VmvXpTaBHFXYTaAaqc1Dt8BzYjNKDJmAQsIp1up/4SdG
 WC8bVrrs/zWKAYYhqY13AVZnmqXvYXmIGP60aouv7hI+yEIZMnAcmqn7vrs5C5R7Rxkx
 w+EcxTxrenxmv2yctsIKmcgqIF09/tzCPrL6hrVR/xg3LGUzdjvkKn6+OkKL8D4H9DAw
 0HOg==
X-Gm-Message-State: AC+VfDxohKNaOsLooehEfQkRuShCGIEr4bSpD10hztBfYpU4jTAbE98z
 ztqH3xPZR0Tu5Sv0rfgYS+3vZHEdpfWgan9WCfU=
X-Google-Smtp-Source: ACHHUZ7Oz+gCU5GPZhOvX/lOxhTXi7n8/xuOP5aJHTJvJFb+CeLNTs/vFtIbpra3xjPv15wAIgHeaA==
X-Received: by 2002:a05:6a21:7891:b0:101:209e:bc57 with SMTP id
 bf17-20020a056a21789100b00101209ebc57mr35507622pzc.50.1684266328810; 
 Tue, 16 May 2023 12:45:28 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 46/80] tcg/sparc64: Use atom_and_align_for_opc
Date: Tue, 16 May 2023 12:41:11 -0700
Message-Id: <20230516194145.1749305-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
 tcg/sparc64/tcg-target.c.inc | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index bb23038529..9676b745a2 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1009,6 +1009,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 typedef struct {
     TCGReg base;
     TCGReg index;
+    TCGAtomAlign aa;
 } HostAddress;
 
 bool tcg_target_has_memory_bswap(MemOp memop)
@@ -1028,13 +1029,13 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
-    unsigned a_bits = get_alignment_bits(opc);
-    unsigned s_bits = opc & MO_SIZE;
+    MemOp s_bits = opc & MO_SIZE;
     unsigned a_mask;
 
     /* We don't support unaligned accesses. */
-    a_bits = MAX(a_bits, s_bits);
-    a_mask = (1u << a_bits) - 1;
+    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
+    h->aa.align = MAX(h->aa.align, s_bits);
+    a_mask = (1u << h->aa.align) - 1;
 
 #ifdef CONFIG_SOFTMMU
     int mem_index = get_mmuidx(oi);
@@ -1086,11 +1087,13 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     cc = TARGET_LONG_BITS == 64 ? BPCC_XCC : BPCC_ICC;
     tcg_out_bpcc0(s, COND_NE, BPCC_PN | cc, 0);
 #else
-    if (a_bits != s_bits) {
-        /*
-         * Test for at least natural alignment, and defer
-         * everything else to the helper functions.
-         */
+    /*
+     * If the size equals the required alignment, we can skip the test
+     * and allow host SIGBUS to deliver SIGBUS to the guest.
+     * Otherwise, test for at least natural alignment and defer
+     * everything else to the helper functions.
+     */
+    if (s_bits != get_alignment_bits(opc)) {
         tcg_debug_assert(check_fit_tl(a_mask, 13));
         tcg_out_arithi(s, TCG_REG_G0, addr_reg, a_mask, ARITH_ANDCC);
 
-- 
2.34.1


