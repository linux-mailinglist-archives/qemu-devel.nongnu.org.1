Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF617E079E
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:40:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8P-0005E9-Lx; Fri, 03 Nov 2023 13:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy86-0005CX-Dh
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy84-0003PM-S2
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:46 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc1e1e74beso20903295ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033123; x=1699637923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GM4yi8JDoIUa/uFJ4SLpCDL0xOthmcrPMIQLarXEt64=;
 b=LOP+h6t/F9JAstmc5JZPfBVOGA3KLBdqZHWbwQyRDVt/rmyxP0I6t8Z3ySBNMG6SUx
 ZMRNc7eA4S/fWO2EPUj/FOxP5Jpe8oQt4YSTLwMih7zobHURa/apo7s1UEy3vtBXn8i5
 ojpNlE/QyqfGBdVdNkOF5AXi+e8TboBCGkox2zmiYGnlBwOy0wD0disYmg+a6CoAzuZt
 6SQTfextLbCT1W+XI7VgVAw+j02jVB0RcxC1bVkvMJ0f87iX5EBuIlq21y4MyrnV2fjk
 G6LejZ596Ogq4QpfdpasPio5S6Vbmocij26aJaveIDercQsmbElmLK7EpnrbAfRC22RO
 i+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033123; x=1699637923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GM4yi8JDoIUa/uFJ4SLpCDL0xOthmcrPMIQLarXEt64=;
 b=bkCmFtmRtsOoTEw3qByFpiog7I8SNhtMboZXXhlUQuILMU9iKM4jkg2SAB8Zq57mts
 AJhzS81DD/4z5w07yFHbXfmtoO34pBnLlxglHmfMSnBfOIFrayKtObrNiWHPcTEP2uRu
 PA5NdGSdnZ1EkngI9UWOSgX8Mr0mlMQYURdC6QUMASJwE25777H3Rd2MB+6y4NoMhUoz
 iRvHxXkZhMmeDUq/G01vPBdnSaEI+AGygWiiDCscvslSTiljAZogggwjx8nZT3mcl0PC
 MGuvpygL5413bqqchxmgFOpZxY0sOdnFSwobBXxeynbM275QW58m0gsoBf0+XsBJZzm0
 LnDg==
X-Gm-Message-State: AOJu0YxBK6uIRqAEYvdsWRQO+Eno8svHdrEHaEKggeR+U/N8bGLBnbPH
 7JsEC6WDZarR6sRih2epYGZEH+caNDHq6THIVXo=
X-Google-Smtp-Source: AGHT+IHOk48jy14fX83WEuJxAdXjoEHD3tkjw89aTo9x+RRQ39gTPKMGR9SbUvR3dUaf6SJI5iWzEQ==
X-Received: by 2002:a17:902:e744:b0:1cc:4e46:3e45 with SMTP id
 p4-20020a170902e74400b001cc4e463e45mr17924387plf.49.1699033123255; 
 Fri, 03 Nov 2023 10:38:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 01/22] target/sparc: Use tcg_gen_qemu_{ld,
 st}_i128 for ASI_M_BCOPY
Date: Fri,  3 Nov 2023 10:38:20 -0700
Message-Id: <20231103173841.33651-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Align the operation to the 32-byte cacheline.
Use 2 pair of i128 instead of 8 pair of i32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 43 +++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6fc333a6b8..5d55856a54 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1727,28 +1727,35 @@ static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
 
     case GET_ASI_BCOPY:
         assert(TARGET_LONG_BITS == 32);
-        /* Copy 32 bytes from the address in SRC to ADDR.  */
-        /* ??? The original qemu code suggests 4-byte alignment, dropping
-           the low bits, but the only place I can see this used is in the
-           Linux kernel with 32 byte alignment, which would make more sense
-           as a cacheline-style operation.  */
+        /*
+         * Copy 32 bytes from the address in SRC to ADDR.
+         *
+         * From Ross RT625 hyperSPARC manual, section 4.6:
+         * "Block Copy and Block Fill will work only on cache line boundaries."
+         *
+         * It does not specify if an unaliged address is truncated or trapped.
+         * Previous qemu behaviour was to truncate to 4 byte alignment, which
+         * is obviously wrong.  The only place I can see this used is in the
+         * Linux kernel which begins with page alignment, advancing by 32,
+         * so is always aligned.  Assume truncation as the simpler option.
+         *
+         * Since the loads and stores are paired, allow the copy to happen
+         * in the host endianness.  The copy need not be atomic.
+         */
         {
+            MemOp mop = MO_128 | MO_ATOM_IFALIGN_PAIR;
             TCGv saddr = tcg_temp_new();
             TCGv daddr = tcg_temp_new();
-            TCGv four = tcg_constant_tl(4);
-            TCGv_i32 tmp = tcg_temp_new_i32();
-            int i;
+            TCGv_i128 tmp = tcg_temp_new_i128();
 
-            tcg_gen_andi_tl(saddr, src, -4);
-            tcg_gen_andi_tl(daddr, addr, -4);
-            for (i = 0; i < 32; i += 4) {
-                /* Since the loads and stores are paired, allow the
-                   copy to happen in the host endianness.  */
-                tcg_gen_qemu_ld_i32(tmp, saddr, da->mem_idx, MO_UL);
-                tcg_gen_qemu_st_i32(tmp, daddr, da->mem_idx, MO_UL);
-                tcg_gen_add_tl(saddr, saddr, four);
-                tcg_gen_add_tl(daddr, daddr, four);
-            }
+            tcg_gen_andi_tl(saddr, src, -32);
+            tcg_gen_andi_tl(daddr, addr, -32);
+            tcg_gen_qemu_ld_i128(tmp, saddr, da->mem_idx, mop);
+            tcg_gen_qemu_st_i128(tmp, daddr, da->mem_idx, mop);
+            tcg_gen_addi_tl(saddr, saddr, 16);
+            tcg_gen_addi_tl(daddr, daddr, 16);
+            tcg_gen_qemu_ld_i128(tmp, saddr, da->mem_idx, mop);
+            tcg_gen_qemu_st_i128(tmp, daddr, da->mem_idx, mop);
         }
         break;
 
-- 
2.34.1


