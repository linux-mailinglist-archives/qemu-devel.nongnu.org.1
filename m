Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 068DB7057FD
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:53:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0cW-0000Y2-4W; Tue, 16 May 2023 15:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0by-0008Q6-Kd
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0bw-0003h0-S7
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:30 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1aaea43def7so444675ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266327; x=1686858327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oD9XgB0lT5e/0MS35T27z73KdHZgG8NiY9ZAZ4mWDU=;
 b=ceWK3sC0V1Z8bJ2fNVIAULGuuGwHUajQ1bGat00F+WkEtv0qkvkudqaR17KeviPSEq
 YVv8oU5rWJlePwhLQZXUg2QDlfxa49Znji7WsMNVRhAxEdvpZiXg8y3d0dktW2lNERWa
 BlWVtsKTkl46/cJVBluowUalUmLucAhVe0YlV4B6477AsrqoadJhWs0/ZU/1aMZvfN/p
 mB3jlqZTVpx6EzgTdvRzxujtTMNpUhPMdMzBY/3PIFlYP0Mxj2Ku8IU2ZXcme7SahmvR
 oZXStAAO4UwFk1EhHLyNVpPV1KEWAs8u33lYZNelsRmWsFOs5DiY+YljQH6tCEkf18AK
 hAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266327; x=1686858327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9oD9XgB0lT5e/0MS35T27z73KdHZgG8NiY9ZAZ4mWDU=;
 b=Da07OKv5WTHPqbNG5ouCTPPW/wK0jgYCaC/6407r3rZxdAeoWXLl4lEeLU37eESHDG
 VELwQ5HepWGz8qWwN4zK6pGj+6BEsPkQTea6HFosbaU0NIsf55rx4JHiT14l2XQvfY45
 HmqanCyvGunJi6XMRSqRFum4AVasmD6l4s+rERoSzZRojGSVaHtVhfMsYm8wVVNiSbKV
 AYtdpEw0jZR6YN1OtL4eq7QW2HK7IeWjA6HhsaY9FHdKd9Yl303EEDxvu/Bfvr/2m3h/
 Ql1bBCq5QRnIIY22l6SrGDbB0yD5yOH+Zb0qCgDwEsU1NTK9tXgEywdJwDbYCUk8MxwE
 BQ9g==
X-Gm-Message-State: AC+VfDxIA94gJUcWzPUfEjNiambsme2VxnPyc6+q4f1jY0lHs9tcESOO
 BlDJlAO/5F71EWuZYNhGYpb3EkLzBtQgWq0pnPM=
X-Google-Smtp-Source: ACHHUZ7cCUKtrdQ2lf/oVpiXzlPhGQuzkUekeDk/8tB7kDPCad2MmJkjkqlaj0BUrTBfFRMzCGRFxQ==
X-Received: by 2002:a17:902:ced0:b0:1ad:c736:209a with SMTP id
 d16-20020a170902ced000b001adc736209amr21467118plg.56.1684266326970; 
 Tue, 16 May 2023 12:45:26 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 44/80] tcg/riscv: Use atom_and_align_for_opc
Date: Tue, 16 May 2023 12:41:09 -0700
Message-Id: <20230516194145.1749305-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 tcg/riscv/tcg-target.c.inc | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 37870c89fc..1fc1a9199b 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -910,8 +910,11 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
-    unsigned a_bits = get_alignment_bits(opc);
-    unsigned a_mask = (1u << a_bits) - 1;
+    TCGAtomAlign aa;
+    unsigned a_mask;
+
+    aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
+    a_mask = (1u << aa.align) - 1;
 
 #ifdef CONFIG_SOFTMMU
     unsigned s_bits = opc & MO_SIZE;
@@ -944,7 +947,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
      * cross pages using the address of the last byte of the access.
      */
     addr_adj = addr_reg;
-    if (a_bits < s_bits) {
+    if (a_mask < s_mask) {
         addr_adj = TCG_REG_TMP0;
         tcg_out_opc_imm(s, TARGET_LONG_BITS == 32 ? OPC_ADDIW : OPC_ADDI,
                         addr_adj, addr_reg, s_mask - a_mask);
@@ -983,8 +986,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
         ldst->oi = oi;
         ldst->addrlo_reg = addr_reg;
 
-        /* We are expecting a_bits max 7, so we can always use andi. */
-        tcg_debug_assert(a_bits < 12);
+        /* We are expecting alignment max 7, so we can always use andi. */
+        tcg_debug_assert(a_mask == sextreg(a_mask, 0, 12));
         tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addr_reg, a_mask);
 
         ldst->label_ptr[0] = s->code_ptr;
-- 
2.34.1


