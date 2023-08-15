Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9058E77D3C5
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 21:59:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0At-00057b-G5; Tue, 15 Aug 2023 15:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Aq-00055B-3e
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:52 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0An-00013l-Sw
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:51 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68876bbecb6so462213b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129468; x=1692734268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgvvzZ0eTjUrFQe9+P0KCKj1UuoBbbqjJKbXrC6sZGQ=;
 b=SLLKOxFhZMbNi7Dw6odspzStJ6g0MC6kXHvs+vXl+BiUsxywdOYfD3yAXmL6r+OZ/V
 hVTEjtEvpPC9lpeGvGKokZYK6PM6ALqykNU8645rNZ2SjzvOqOfTR4LIVuawvEKNCFni
 87V7Cf8m2btrdoLzenoZDbOjHG9jbFNgAPcnpZbe7ck7WaYZCc4V4uVNs2U1EYEPsFQE
 XiUs9T38WDYJg9s9fLeWM5loPJR8uv1q5QabstL8B0GGUDBFNVQgY4b+tnrKf4uyx9mR
 NwnOgibsYCOMn8TM5DRMdLg3R2LP/APfabwFXGVMCDL4YzbQe3Y1nhhdRJNJMWM2Nda/
 HI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129468; x=1692734268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgvvzZ0eTjUrFQe9+P0KCKj1UuoBbbqjJKbXrC6sZGQ=;
 b=EPG8ZdecMwqQYxB5oII/auK7zFSz9sWY15wCqxBKDLXeR0fBupcVdnxQmseAej3Kb/
 BjEzRkCgRXIADxAcJOBf92JGFuvbarDBMKuWiDktq/3gNwFzLX8t1Vkf7phbTIT0sVUs
 GgQkh8Cb873xJPOwYrcxPjt3d9N0070740jROyBrRuODMlddx0djRlfdsvRGGlDTqymc
 RmhCls0DAjzQNZSnbYqMj3ejU+k09cL6S7xnaDo427AmSlAlTLMHFpFDreCjX3kyfYfH
 Fj83ugRjbOPc9kKFPr0MVGTu25mWzKKnKjpfA4+J806vwaQq8+Jbp/Hji7vG8aR07Lg+
 G0/Q==
X-Gm-Message-State: AOJu0YyMqG5qMESXfnRtQ+/gwrRZHx00/qamhdub74eNJdJp2e8bvpuG
 eb98nrIX8EizcdTStnHVVkc5Gqjvanlqx/MQ8q4=
X-Google-Smtp-Source: AGHT+IHWnmUryb0NElaSyPWB1k2J1sqWTrDuKjPgqjcANuUnc/7bYbUIIi7jdN5XP2tzJ75zx6Ismw==
X-Received: by 2002:a05:6a00:1acc:b0:688:4c21:a6f0 with SMTP id
 f12-20020a056a001acc00b006884c21a6f0mr2145788pfv.18.1692129468589; 
 Tue, 15 Aug 2023 12:57:48 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 05/14] tcg/ppc: Use ADDPCIS in tcg_out_tb_start
Date: Tue, 15 Aug 2023 12:57:32 -0700
Message-Id: <20230815195741.8325-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

With ISA v3.0, we can use ADDPCIS instead of BCL+MFLR to load NIP.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 19004fa568..36b4f61236 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -362,6 +362,7 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
 #define CRNAND XO19(225)
 #define CROR   XO19(449)
 #define CRNOR  XO19( 33)
+#define ADDPCIS XO19( 2)
 
 #define EXTSB  XO31(954)
 #define EXTSH  XO31(922)
@@ -854,6 +855,19 @@ static inline void tcg_out_sari64(TCGContext *s, TCGReg dst, TCGReg src, int c)
     tcg_out32(s, SRADI | RA(dst) | RS(src) | SH(c & 0x1f) | ((c >> 4) & 2));
 }
 
+static void tcg_out_addpcis(TCGContext *s, TCGReg dst, intptr_t imm)
+{
+    int d0, d1, d2;
+
+    tcg_debug_assert((imm & 0xffff) == 0);
+    tcg_debug_assert(imm == (int32_t)imm);
+
+    d2 = imm & 1;
+    d1 = (imm >> 1) & 0x1f;
+    d0 = (imm >> 6) & 0x3ff;
+    tcg_out32(s, ADDPCIS | RT(dst) | (d1 << 16) | (d0 << 6) | d2);
+}
+
 static void tcg_out_bswap16(TCGContext *s, TCGReg dst, TCGReg src, int flags)
 {
     TCGReg tmp = dst == src ? TCG_REG_R0 : dst;
@@ -2489,9 +2503,14 @@ static void tcg_out_tb_start(TCGContext *s)
 {
     /* Load TCG_REG_TB. */
     if (USE_REG_TB) {
-        /* bcl 20,31,$+4 (preferred form for getting nia) */
-        tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
-        tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
+        if (have_isa_3_00) {
+            /* lnia REG_TB */
+            tcg_out_addpcis(s, TCG_REG_TB, 0);
+        } else {
+            /* bcl 20,31,$+4 (preferred form for getting nia) */
+            tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
+            tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
+        }
     }
 }
 
-- 
2.34.1


