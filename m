Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3865723142
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GcZ-0001pu-5R; Mon, 05 Jun 2023 16:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcU-0001oD-ND
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:02 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcM-0003i3-3X
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:02 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-65242634690so2955183b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996153; x=1688588153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zq0inShA79yUCPfBvlF6JU5DFl9lHhMswh4eTv6SbBc=;
 b=MWeAP5Cxoduu0+5FavthYhr0zcLw7TZ3N6oqn/JWCfC77aGzGR3Ekgcmpk6HLt4MHa
 yDNb1NWTJAxQU4c6ty7Ly2M/m0CsZDY2Skn32GFT2AElXLiMeaSnoT5Tya5jHVZiHiib
 TkYZ0cyLnOkSda8U6DErDCmnlzoMXQkqhM0g20UWZ/WI4OIt6NX1zZpG4ESGHA5vFVqL
 O6m5hSoV/RI8o/ElzymRawQ2KLrDc+9dbq1R7aBpE+KU1D23slDDkukHZDse/f7HXVFQ
 1yGtZ0XeOIrbW0HLrfWPdQpxFK+kGV6CHR0qjNi6tcKC80TPa20E+w1DpMQoHUA+wu37
 5vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996153; x=1688588153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zq0inShA79yUCPfBvlF6JU5DFl9lHhMswh4eTv6SbBc=;
 b=UvlXg2S5IUdlzDG2NOUHUqWOlEPQf2D/7eP3Wju1bUyeLTVHYqpjqWH7kzWjnv+a3p
 4t2pC8UNICnlNgdPIEI2Kaj6h7ndYCBEPPYe4Wi25SxysijhJPAA7qtCoSekGN5GfRLE
 bGGJAtJSPQTWk9XwXwhRNkvdjebpW09bMIV2jL45A8wNJHduKqNuxvHZhAdxu0VlA+pl
 NNIZRM664/UThCrPESAlmzblk+1hxceMqxSCdv+hwTOBt4aIPDXRIC442as5OS+RrcGb
 w6cpm30AE174MgVh7tYWjN+KiVFZfA9v76y+Sb0/RoVmOMH+vsZNLIankMCd7nykC6nG
 5kxQ==
X-Gm-Message-State: AC+VfDwV216IO2r4rkxaoLQJaYtqXy/PVI9FyRUrEuTGc/ewgyZ+QLCE
 +Zh9Cz4kRoaMBigmckRo3SC60q0wpX3V3UVwnzI=
X-Google-Smtp-Source: ACHHUZ6FXHLorZpcjEz/I5MPiU3GaDH55KX91kFtMBMbMWmHi4p7Y6avnyR1g/ixYmEEZID9uybpww==
X-Received: by 2002:a05:6a20:8f09:b0:101:1951:d491 with SMTP id
 b9-20020a056a208f0900b001011951d491mr166183pzk.6.1685996152742; 
 Mon, 05 Jun 2023 13:15:52 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:15:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/52] tcg/riscv: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Mon,  5 Jun 2023 13:14:58 -0700
Message-Id: <20230605201548.1596865-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


