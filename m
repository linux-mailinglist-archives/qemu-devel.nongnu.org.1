Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAFE71134D
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQK-0008Pk-6X; Thu, 25 May 2023 14:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQH-0008OF-5s
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:49 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQF-0005tc-FD
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:48 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ae50da739dso12485065ad.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038246; x=1687630246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mZHgKT7Em8u8wS7a0495i+fKR6g+xWDjFn9ZPfkhSxA=;
 b=s4XaNTJwR0n5IbxiEU2xtRRiRkxnVsEhcAjYn8e1ErdXp1uz+5W/+Zct37NM8sfyid
 BKaQDPsJ83PB6wds6lup0ufYwSwgaUHzCq9GVKGEEjTLzk+bXHeHaEB6kYzoqwPdqN5s
 QpMQR9jzrX0arnPv4ozqCfMSO9ac/1ehevCdsP2D6LaDGNyc3mugG3BZKtgZzTCXcSFI
 fYEP2IPofdqDjYzDFYtGTZfqk+xiKZp+WDADu7VyfVprwRijzQMvru80NMQq5qsv9AuB
 7nJkItV9Bw8vQ2DIDecc94jYVIQLpl62Ik3jeHJOR1+8ilM5KhM4SM8qW5bwzkrw4S7M
 LF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038246; x=1687630246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZHgKT7Em8u8wS7a0495i+fKR6g+xWDjFn9ZPfkhSxA=;
 b=Ulhxk9Yfx4CO/SiwZoIsJzKtIxxIa1D/5EjXfYrSSaDhMFlv3jJAFKfJlctpE2fdlM
 0I50fqTYkuz9iZQChQUYro0ksZIRTuzrQbXtEK49UMvP0hBf9P4sm3lGQpBMYS/7ePre
 +g12XZAvGKDmSm0PtvkYSTHpbCGJWijiudLBa0uAvm+TfdusrM0tIrq3qWBhkHAymop2
 jp5wQ6Tzt1Z8zOa4xRMOzWGZ8VE6qHG9SX7t0BGhtuvp9DjAu2XjzrPieCAE1eqf084r
 tkAEQuYRUWbwQuFua8mDzLdLWb483YqNDYA0jtWJlm86anDgGnN+lVeMl4+oVmV3tp4W
 HfPw==
X-Gm-Message-State: AC+VfDzoRHKlP8F0ESKGBQIsjA7MZDYHpSkzD39GvSr35Cj1W0fySxje
 S54Xef5SuRTqSKLc9STIfNRhr3XHuRB2iq0+1PA=
X-Google-Smtp-Source: ACHHUZ6426yrE36gFbgY4mDTXcAMug5pmPd6raEWTztKEcOUXEKSdQ4OT+zFhbXnLk3EdNeeHoiHkg==
X-Received: by 2002:a17:902:d4ca:b0:1b0:440:7f5f with SMTP id
 o10-20020a170902d4ca00b001b004407f5fmr1305295plg.49.1685038246220; 
 Thu, 25 May 2023 11:10:46 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/23] tcg/mips: Try three insns with shift and add in
 tcg_out_movi
Date: Thu, 25 May 2023 11:10:23 -0700
Message-Id: <20230525181036.1559435-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

These sequences are inexpensive to test.  Maxing out at three insns
results in the same space as a load plus the constant pool entry.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 9fab424ecc..b86a0679af 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -569,6 +569,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
                              tcg_target_long arg, TCGReg tbreg)
 {
     tcg_target_long tmp;
+    int sh, lo;
 
     if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
         arg = (int32_t)arg;
@@ -591,6 +592,49 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
+    /*
+     * Load bitmasks with a right-shift.  This is good for things
+     * like 0x0fff_ffff_ffff_fff0: ADDUI r,0,0xff00 + DSRL r,r,4.
+     * or similarly using LUI.  For this to work, bit 31 must be set.
+     */
+    if (arg > 0 && (int32_t)arg < 0) {
+        sh = clz64(arg);
+        if (tcg_out_movi_one(s, ret, arg << sh)) {
+            tcg_out_dsrl(s, ret, ret, sh);
+            return;
+        }
+    }
+
+    /*
+     * Load slightly larger constants using left-shift.
+     * Limit this sequence to 3 insns to avoid too much expansion.
+     */
+    sh = ctz64(arg);
+    if (sh && tcg_out_movi_two(s, ret, arg >> sh)) {
+        tcg_out_dsll(s, ret, ret, sh);
+        return;
+    }
+
+    /*
+     * Load slightly larger constants using left-shift and add/or.
+     * Prefer addi with a negative immediate when that would produce
+     * a larger shift.  For this to work, bits 15 and 16 must be set.
+     */
+    lo = arg & 0xffff;
+    if (lo) {
+        if ((arg & 0x18000) == 0x18000) {
+            lo = (int16_t)arg;
+        }
+        tmp = arg - lo;
+        sh = ctz64(tmp);
+        tmp >>= sh;
+        if (tcg_out_movi_one(s, ret, tmp)) {
+            tcg_out_dsll(s, ret, ret, sh);
+            tcg_out_opc_imm(s, lo < 0 ? OPC_DADDIU : OPC_ORI, ret, ret, lo);
+            return;
+        }
+    }
+
     /* Otherwise, put 64-bit constants into the constant pool. */
     tcg_out_movi_pool(s, ret, arg, tbreg);
 }
-- 
2.34.1


