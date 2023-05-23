Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F275270DE06
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:53:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SSD-00042m-DP; Tue, 23 May 2023 09:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SS9-0003fx-Nz
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:29 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SS6-0002zn-Fg
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:28 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d4e4598f0so3736182b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850005; x=1687442005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=29bXmsqQNPbVjvNhyJ1/ZBWt/AGatlyo08jEGsuM3hU=;
 b=JK4WSiTF5pBsMNSQQR2YBJmWtZJKpOw7zfnWuaT566ZtaLXJMvJHcvym282h8i83bX
 39WsDBKMQ+8ZAFRcAd/wkPDvrSQu9athoE8TKe7TEmdDrzPOtk3tYArX6NU9V3v3QyMI
 djhpkSZSmnAL1dnHTQETTgEAnz4/zSIPWLjawLFttnwvVJLXxy7o4bp/z8k1fFm2uGeP
 usNfBUWsB4s0AVQPJm2RNCYIl47lQk65e7yIX+NA+7nDcf0HGtHDYVgT8WP03FbsJbGl
 V38zyjpSqH7xnSp3ZPORRidcWPLtW/6Bi5FWc6XkpwBuiutM5TUeWol3zg6alYyLPh4a
 6Frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850005; x=1687442005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29bXmsqQNPbVjvNhyJ1/ZBWt/AGatlyo08jEGsuM3hU=;
 b=iQBtznMRD0IUfB7cNCwb4u88OTzFSuLydCjT/NVVt/3+hMva5kFYzr3lV7062Mx8JJ
 Wb/aC5MI8Mkz3dXE3vSmtKphOZsyfyVezkGUr/lH3o9gdvoTSleR2Qd5/81CmDXk+4el
 Ah9qP8BvzjIJgRnhA2ZxQOS98chmu1GiHERTPV0j58dxbXWzZEQWK+38UXl3Sc4MIuH3
 kGFjJJUZoV9E2tLUJFP5sMyASWj9f1GMYJ4FStslaLyi2QwiM3gx06CV9oEIZ0jUwda/
 EkalNs0nGVOXixdKc0uFgwDk7xdpaOB/3mIJdlJiFHY2TK3Vkx8QVNaHokGJ5CNOhqAj
 N4Jg==
X-Gm-Message-State: AC+VfDxBI0E+04YF7V3af3b7Durtx8vu/WptND3Lao+oqtyFuVDQ56EK
 DRbnKhwBph9h4CMYVVwAPyDSdNkwDkhsKnAOqb0=
X-Google-Smtp-Source: ACHHUZ6D8XDjpQrfnmufl18snjCzq+X06vq8OT7wK6LmTSH4YZPOnTCVKNmzPFISc6knuVlLdM6kUA==
X-Received: by 2002:aa7:88c5:0:b0:64a:f8c9:a42c with SMTP id
 k5-20020aa788c5000000b0064af8c9a42cmr17936635pff.18.1684850005001; 
 Tue, 23 May 2023 06:53:25 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/52] tcg/ppc: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 23 May 2023 06:52:31 -0700
Message-Id: <20230523135322.678948-2-richard.henderson@linaro.org>
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
 tcg/ppc/tcg-target.c.inc | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index d4269dffcf..30372519dd 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2033,6 +2033,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                            TCGReg addrlo, TCGReg addrhi,
                                            MemOpIdx oi, bool is_ld)
 {
+    TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
     MemOp a_bits;
@@ -2085,17 +2086,18 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out32(s, AND | SAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_R0));
 
     /* Load the (low part) TLB comparator into TMP2.  */
-    if (cmp_off == 0 && TCG_TARGET_REG_BITS >= TARGET_LONG_BITS) {
-        uint32_t lxu = (TCG_TARGET_REG_BITS == 32 || TARGET_LONG_BITS == 32
+    if (cmp_off == 0
+        && (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32)) {
+        uint32_t lxu = (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32
                         ? LWZUX : LDUX);
         tcg_out32(s, lxu | TAB(TCG_REG_TMP2, TCG_REG_TMP1, TCG_REG_TMP2));
     } else {
         tcg_out32(s, ADD | TAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP2));
-        if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+        if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
             tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP2,
                        TCG_REG_TMP1, cmp_off + 4 * HOST_BIG_ENDIAN);
         } else {
-            tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_TMP2, TCG_REG_TMP1, cmp_off);
+            tcg_out_ld(s, addr_type, TCG_REG_TMP2, TCG_REG_TMP1, cmp_off);
         }
     }
 
@@ -2103,7 +2105,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
      * Load the TLB addend for use on the fast path.
      * Do this asap to minimize any load use delay.
      */
-    if (TCG_TARGET_REG_BITS >= TARGET_LONG_BITS) {
+    if (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32) {
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
                    offsetof(CPUTLBEntry, addend));
     }
@@ -2138,7 +2140,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         }
 
         /* Mask the address for the requested alignment.  */
-        if (TARGET_LONG_BITS == 32) {
+        if (addr_type == TCG_TYPE_I32) {
             tcg_out_rlw(s, RLWINM, TCG_REG_R0, t, 0,
                         (32 - a_bits) & 31, 31 - s->page_bits);
         } else if (a_bits == 0) {
@@ -2150,7 +2152,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         }
     }
 
-    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+    if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
         /* Low part comparison into cr7. */
         tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
                     0, 7, TCG_TYPE_I32);
@@ -2170,8 +2172,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out32(s, CRAND | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
     } else {
         /* Full comparison into cr7. */
-        tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
-                    0, 7, TCG_TYPE_TL);
+        tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2, 0, 7, addr_type);
     }
 
     /* Load a pointer into the current opcode w/conditional branch-link. */
@@ -2198,7 +2199,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     h->base = guest_base ? TCG_GUEST_BASE_REG : 0;
 #endif
 
-    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+    if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
         /* Zero-extend the guest address for use in the host address. */
         tcg_out_ext32u(s, TCG_REG_R0, addrlo);
         h->index = TCG_REG_R0;
-- 
2.34.1


