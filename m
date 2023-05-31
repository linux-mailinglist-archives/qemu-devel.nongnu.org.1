Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C99F87174B3
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:05:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D3p-0006pd-Ee; Wed, 31 May 2023 00:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3h-0006os-Bx
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:37 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3f-00069B-KL
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:37 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d18d772bdso6044982b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505814; x=1688097814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t6MYs+KVusU9X98vcPY/El+1ezFgLsYK+uObrx4pe+Y=;
 b=kmxFkjDo/MKc92VkItXDiZNUzVTKhikghBZrF8uiCy3hUgiicSr9h2ik7y+/TI8019
 WRiVPssvjswJ4h/nyHryaHGETwDCdR2vPCE3Or17Ov/z3VWyNBE7eOoXP65l0m3HWjat
 jqsbPllSONqQGw+whFNSHxapaugp8tteBh/V2olNPajm7L8P5NFONKnFnmU8g+4Wpm0K
 nLkBsiqbGLQr1lW7CibhCOfrX5IRJ4wNs2hOMafrKW5j3y71XO2vOcBNqfNJqBBSH7yD
 A8+UDCkaO0OodsNmdZE2VIbn2WHRTk1Kcoc3UgKGZWgPNS+tZ3bvOLMNq9iL+Q6INXxB
 l/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505814; x=1688097814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6MYs+KVusU9X98vcPY/El+1ezFgLsYK+uObrx4pe+Y=;
 b=g0sOBvX0OxK1UtUTepwzX4V7VuYxAM7OhH/IaOXPrSGBuJOE+or+6m38wALKJUQ7IY
 zTkgiGRU/d6uxRSdlEpVYfwWXzbOiGOf3pCI+hGjfBmK5n1fpQVKdG1FVqme7UbYpyag
 djSY35ZFozBI6EmeNzaIpNOdAMnY3aIRcaVTRMrvHT+Lz8bTBkvt1dRYLyarII1dUx49
 /yx5azPtIB6AHH+932rdNnjwqgoyfBUDV1XLeAusJ+IXtKXhVetCECQ9ozFnE1UXBnNF
 DyiBrDcZSijwgh5xPiBZyGD7yePNz0ToAvYaquEN49yT8lFWUznEJxXK7nuDiH1KBaod
 hBdw==
X-Gm-Message-State: AC+VfDyxbIBZZUtcW/ybvQTg04cOpBL7ROiQ/6qY+PBCrolLAX0gXgbL
 WxsGsE3/43H4eiF7qgW7XcQbfwRMeiHGTgYvr4c=
X-Google-Smtp-Source: ACHHUZ7jPr/gaZej8E/7u9L7JVd5K5fmgG4WLEMPZ5ks94U0Rb5FzmKMaJOsye/fK0CdUK+lQhfNDw==
X-Received: by 2002:a05:6a20:4284:b0:110:9b0b:71b6 with SMTP id
 o4-20020a056a20428400b001109b0b71b6mr5467402pzj.37.1685505813721; 
 Tue, 30 May 2023 21:03:33 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/48] tcg/s390x: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 30 May 2023 21:02:45 -0700
Message-Id: <20230531040330.8950-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index 503126cd66..2795242b60 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1745,6 +1745,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                            TCGReg addr_reg, MemOpIdx oi,
                                            bool is_ld)
 {
+    TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
     MemOp s_bits = opc & MO_SIZE;
@@ -1786,7 +1787,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tgen_andi_risbg(s, TCG_REG_R0, addr_reg, tlb_mask);
     } else {
         tcg_out_insn(s, RX, LA, TCG_REG_R0, addr_reg, TCG_REG_NONE, a_off);
-        tgen_andi(s, TCG_TYPE_TL, TCG_REG_R0, tlb_mask);
+        tgen_andi(s, addr_type, TCG_REG_R0, tlb_mask);
     }
 
     if (is_ld) {
@@ -1794,7 +1795,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     } else {
         ofs = offsetof(CPUTLBEntry, addr_write);
     }
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         tcg_out_insn(s, RX, C, TCG_REG_R0, TCG_TMP0, TCG_REG_NONE, ofs);
     } else {
         tcg_out_insn(s, RXY, CG, TCG_REG_R0, TCG_TMP0, TCG_REG_NONE, ofs);
@@ -1807,7 +1808,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_insn(s, RXY, LG, h->index, TCG_TMP0, TCG_REG_NONE,
                  offsetof(CPUTLBEntry, addend));
 
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         tcg_out_insn(s, RRE, ALGFR, h->index, addr_reg);
         h->base = TCG_REG_NONE;
     } else {
@@ -1830,7 +1831,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     }
 
     h->base = addr_reg;
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         tcg_out_ext32u(s, TCG_TMP0, addr_reg);
         h->base = TCG_TMP0;
     }
-- 
2.34.1


