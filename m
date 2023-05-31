Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 198A87174B7
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:05:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D3p-0006pZ-Ef; Wed, 31 May 2023 00:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3h-0006or-9n
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:37 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3e-00068v-BZ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:36 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d2467d640so6071947b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505813; x=1688097813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kh1osczTPDGp8x+f+m9a8kz2OfGPlp3T/ofnmQAjdR8=;
 b=hx9oDB0bM6iK+loHMxHXp8+gos4W/gWEHDzZflJhRmhnuHp0gXzPilSrXEtNHafOnk
 O8Sx+GDpFvR5PihK1hKlNaUEnt8lGUWXcdaFgaXV/kv7Pyb4/ap/pVA3DTS5TqhYreoS
 WDtTNIWM9IsSIERN1/C4M0W9yRmbiReNlGUDVHq8YPrGOw/jMDTtW+j5AJ2CoDE8MtzG
 Y8+wwQ01j31P7uwuMqpAc5Y1v7Gb1hEPuxDsRgERoZWVw4Qh21wXFrT0aYJ4SRnhW1PT
 h3/c1sFBD1QR4SfymzDyJ9A1eDjg9gzYECd6VCwie70UNmI457EgqI7n9K03zpOu2vqG
 1beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505813; x=1688097813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kh1osczTPDGp8x+f+m9a8kz2OfGPlp3T/ofnmQAjdR8=;
 b=Ly5i2FtJlhrTYLiwicxE27U4W8M9VuBRRsYGvK8voOhtOTljSQ8yPBGNiRCCwEcdwI
 l7R2HNMtGgYDUMHGXdkt0oRPoAGeZ6D6efRVdnAY00KP1m+kmlrSJcsGrvvui2rsJyPt
 8tA3AAfzmiZKsdlsIGZHlUqT+LSmvteqyV8dDjl4eqiQxlTEXpl29gSZxWWvhc2a7nSN
 ghbb0OjpezYjxFXv491TREQqPF4lq5UH8Ls6Ob+kQdto6FMhb+JxHdlfR8cDSSoSmnjl
 74mqGuFV9Rd7CpDqxnGcugLODbvGcM9onN7PeKTs8wRQTsdgn6wk3NbLzbZWKQ4ZaT9e
 DW/Q==
X-Gm-Message-State: AC+VfDwHRcK+2d34zI0UEF2lOFQQcvR6AmuoeA+EKCGzgA2Zc81SSpHY
 xy84hVJN7t9Ok+dBZCKP2g0rRt1e5JRCkGsLegc=
X-Google-Smtp-Source: ACHHUZ566nJ2wx8BkU0Lw7HTFaIsQ/joPuNlkd0pTA6ruJL/8GSSxTmbvz8ab1yNbP6OR1RMmHgA6A==
X-Received: by 2002:a05:6a20:2d23:b0:10f:195f:6556 with SMTP id
 g35-20020a056a202d2300b0010f195f6556mr4093367pzl.31.1685505812855; 
 Tue, 30 May 2023 21:03:32 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/48] tcg/riscv: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 30 May 2023 21:02:44 -0700
Message-Id: <20230531040330.8950-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 tcg/riscv/tcg-target.c.inc | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index c0257124fa..a8f99f7e77 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1195,6 +1195,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
                                            TCGReg addr_reg, MemOpIdx oi,
                                            bool is_ld)
 {
+    TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
     TCGAtomAlign aa;
@@ -1236,19 +1237,19 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
     addr_adj = addr_reg;
     if (a_mask < s_mask) {
         addr_adj = TCG_REG_TMP0;
-        tcg_out_opc_imm(s, TARGET_LONG_BITS == 32 ? OPC_ADDIW : OPC_ADDI,
+        tcg_out_opc_imm(s, addr_type == TCG_TYPE_I32 ? OPC_ADDIW : OPC_ADDI,
                         addr_adj, addr_reg, s_mask - a_mask);
     }
     compare_mask = s->page_mask | a_mask;
     if (compare_mask == sextreg(compare_mask, 0, 12)) {
         tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addr_adj, compare_mask);
     } else {
-        tcg_out_movi(s, TCG_TYPE_TL, TCG_REG_TMP1, compare_mask);
+        tcg_out_movi(s, addr_type, TCG_REG_TMP1, compare_mask);
         tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP1, TCG_REG_TMP1, addr_adj);
     }
 
     /* Load the tlb comparator and the addend.  */
-    tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_TMP0, TCG_REG_TMP2,
+    tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2,
                is_ld ? offsetof(CPUTLBEntry, addr_read)
                      : offsetof(CPUTLBEntry, addr_write));
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_REG_TMP2,
@@ -1259,7 +1260,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
     tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);
 
     /* TLB Hit - translate address using addend.  */
-    if (TARGET_LONG_BITS == 64) {
+    if (addr_type != TCG_TYPE_I32) {
         tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, addr_reg, TCG_REG_TMP2);
     } else if (have_zba) {
         tcg_out_opc_reg(s, OPC_ADD_UW, TCG_REG_TMP0, addr_reg, TCG_REG_TMP2);
@@ -1287,7 +1288,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
 
     if (guest_base != 0) {
         base = TCG_REG_TMP0;
-        if (TARGET_LONG_BITS == 64) {
+        if (addr_type != TCG_TYPE_I32) {
             tcg_out_opc_reg(s, OPC_ADD, base, addr_reg, TCG_GUEST_BASE_REG);
         } else if (have_zba) {
             tcg_out_opc_reg(s, OPC_ADD_UW, base, addr_reg, TCG_GUEST_BASE_REG);
@@ -1295,7 +1296,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
             tcg_out_ext32u(s, base, addr_reg);
             tcg_out_opc_reg(s, OPC_ADD, base, base, TCG_GUEST_BASE_REG);
         }
-    } else if (TARGET_LONG_BITS == 64) {
+    } else if (addr_type != TCG_TYPE_I32) {
         base = addr_reg;
     } else {
         base = TCG_REG_TMP0;
-- 
2.34.1


