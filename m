Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA92470DE1D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SSE-0004Kl-Pb; Tue, 23 May 2023 09:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSC-00044n-6j
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:32 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SS7-0002zz-Qp
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:31 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d2a613ec4so3895245b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850006; x=1687442006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x1u0vvNyx/nixXkB/+OG1xn3VbW+Qfvhi9OOeTFIibc=;
 b=Xwj7FUcxgm6kTvSx3PKeNTZLy/5isLiwg3ZsMRgo8UpKPtoTEB2wrQEVD3G5hKJ32M
 E2kdNBmMsoQLBC5+91672w3sNX6X/vKUWQB2y/O3xUY7dO5qPaGvhLiuHdgaDTdDxaOI
 5CFGy7+uPXFBIe8lZBrPOPVlNGIXI9ryroStiDwgGIncJbrfivJYff59sHjLZvztUQMR
 uXVzLH+ew2ZnAUdQXO2VWMNfaZLfUOgEiCAbEM8MR81g5IP/KdA5a7M8UME2pV+ujFXU
 fgXspuk25CHa3Pvhl1+tSweUFGJh8ek2K85umYBzRtwgQ1rNklkrqNTh19DKRnd8YTci
 +pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850006; x=1687442006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x1u0vvNyx/nixXkB/+OG1xn3VbW+Qfvhi9OOeTFIibc=;
 b=ZlFzSThD/q+3yZCpLwZgxCM3PmVNclJ5ryRNlQs/HtIiMnCeRUUKYz9aJu7J3LfvCg
 Acw0ARQKD0vNWiheerPozaTBt+dj8KMJ5byjh8pWcVq5nqRl6SLtM8lkQtnFrZXn3DIZ
 vXDMNHuhw1gb1DRAki0kFUkoc9GCvGMObZVl1VGzPudNss4X7yAWln/1Bc3UMVYaqQ3f
 mSxe+nsKWBLGxOlEh8bL/WOesiwNS0DK2Bsvq/TdV1CY96Pe/9ABfdfuCUW471WOzdIO
 K2QyPG3cI4TAmHiEVYdv83HHkYLMH/i8m1V60PSmK/WsQSlxz9l85ZtkW1kWQix8i7wH
 XLkw==
X-Gm-Message-State: AC+VfDwgshVPfuN95xAGRW0s7TdIBeNHLSNpO0sJUGEh9+Yn9LisPKtC
 8JKDiJNuwIvyQRSt38IAXwbiJ6NZ4assi6oTssA=
X-Google-Smtp-Source: ACHHUZ5c4/JpOUaH5yTO2yQV0hg/CYhOkK/9rPoLJ8SuI605+SUHOa3PlAjJSu4Vnki3RIM4GuhJog==
X-Received: by 2002:a05:6a00:2314:b0:63b:5c82:e209 with SMTP id
 h20-20020a056a00231400b0063b5c82e209mr17048468pfh.10.1684850006555; 
 Tue, 23 May 2023 06:53:26 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/52] tcg/s390x: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 23 May 2023 06:52:33 -0700
Message-Id: <20230523135322.678948-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 tcg/s390x/tcg-target.c.inc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index dfaa34c264..c32801b829 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1732,6 +1732,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                            TCGReg addr_reg, MemOpIdx oi,
                                            bool is_ld)
 {
+    TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
     unsigned a_mask;
@@ -1773,7 +1774,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tgen_andi_risbg(s, TCG_REG_R0, addr_reg, tlb_mask);
     } else {
         tcg_out_insn(s, RX, LA, TCG_REG_R0, addr_reg, TCG_REG_NONE, a_off);
-        tgen_andi(s, TCG_TYPE_TL, TCG_REG_R0, tlb_mask);
+        tgen_andi(s, addr_type, TCG_REG_R0, tlb_mask);
     }
 
     if (is_ld) {
@@ -1781,7 +1782,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     } else {
         ofs = offsetof(CPUTLBEntry, addr_write);
     }
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         tcg_out_insn(s, RX, C, TCG_REG_R0, TCG_TMP0, TCG_REG_NONE, ofs);
     } else {
         tcg_out_insn(s, RXY, CG, TCG_REG_R0, TCG_TMP0, TCG_REG_NONE, ofs);
@@ -1794,7 +1795,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_insn(s, RXY, LG, h->index, TCG_TMP0, TCG_REG_NONE,
                  offsetof(CPUTLBEntry, addend));
 
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         tcg_out_insn(s, RRE, ALGFR, h->index, addr_reg);
         h->base = TCG_REG_NONE;
     } else {
@@ -1817,7 +1818,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     }
 
     h->base = addr_reg;
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         tcg_out_ext32u(s, TCG_TMP0, addr_reg);
         h->base = TCG_TMP0;
     }
-- 
2.34.1


