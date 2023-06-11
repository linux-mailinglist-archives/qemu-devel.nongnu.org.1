Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C3272B2C4
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:05:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVc-0006SU-JR; Sun, 11 Jun 2023 12:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUj-0005qz-6L
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUd-0000SB-Lz
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f736e0c9a8so25491885e9.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499237; x=1689091237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EhniXz311o/2DcPgdcKAEpSrZXehm+PpvIlCx/ZyH40=;
 b=sSRGz/mcblbfikzBzOQ8d7UvGsbkzHXp7q6oeQ4EigRv2RlU+wf0/KO858BuyjkgXd
 iRmbrepMj0hzSkbKathdsCRD93S1hw/AT7YSV1TsyNDIzfEP7szVDDFDS1ATjsE6DuSm
 A3R+ClsSoUx2beMCbkGp3ykaJg6e9W+JDq2vk5awpcvxig4sYaPA4BsQ2LKSLoRcYNs8
 u/uIeiOyjnNS+h6tqHIjmYKWOWuqKRysttnLdVv/JwFFctcwxBGz67E93E7/PPy5GPO9
 Luw/0nJWRRKQpywl2dm9UJU0yjsjZrTcpwtyQsbiZFBXrCbCSUEZk1ke0nweIhPJcf72
 qIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499237; x=1689091237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EhniXz311o/2DcPgdcKAEpSrZXehm+PpvIlCx/ZyH40=;
 b=PKKPtsq3exZU2VQCnc1rTd90QWp/+wpEVxrXjvuUWAWmDZPi57ju3i6VXR3zO+9reF
 vSEnBmgC4U4QqHRXL/gdb9pSsXU61qWZPihUCjeqJIa4sGGeIErRBVimfFiadougy6zm
 pEv7hQVeJbxAomR5DE8khOjlA4XFOZ7U1+FJ0yvBbU5q3I0D5UJVK1MEq8wvVEYg4grb
 j4f/NETeB3pkkZATv/E9eNJPW8+pQtA8cWYbhSIIAsdXrQSOA2uNBSprFpBcz1CvBicc
 g0/zMztgcSRY2QXgDukotI1hvxo20WnufeoZRl7msuFL/z+UU9FXciLck6L4NWZLpF+a
 IYfA==
X-Gm-Message-State: AC+VfDz5Mr3QLtQRtqobwiZoAxoBVVODYbClWsV4DigK99CuIzDvSnGE
 C2OLa4THUHBbyeIMTU5onJU62Ig1sIGx64pn3Ko=
X-Google-Smtp-Source: ACHHUZ6H0loE2rg1Wp/bDDFTABmwKGaQPGJ8BblhJepmPi+RaBfbOwacng87w+MQ+i74jkE8+4nung==
X-Received: by 2002:a05:600c:365a:b0:3f7:38e1:5e53 with SMTP id
 y26-20020a05600c365a00b003f738e15e53mr4991909wmq.4.1686499237724; 
 Sun, 11 Jun 2023 09:00:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 07/23] target/arm: Convert CFINV,
 XAFLAG and AXFLAG to decodetree
Date: Sun, 11 Jun 2023 17:00:16 +0100
Message-Id: <20230611160032.274823-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Convert the CFINV, XAFLAG and AXFLAG insns to decodetree.
The old decoder handles these in handle_msr_i(), but
the architecture defines them as separate instructions
from MSR (immediate).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-5-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  6 ++++
 target/arm/tcg/translate-a64.c | 53 +++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b3608d38dc9..fd23fc3e0ff 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -188,3 +188,9 @@ CLREX           1101 0101 0000 0011 0011 ---- 010 11111
 DSB_DMB         1101 0101 0000 0011 0011 domain:2 types:2 10- 11111
 ISB             1101 0101 0000 0011 0011 ---- 110 11111
 SB              1101 0101 0000 0011 0011 0000 111 11111
+
+# PSTATE
+
+CFINV           1101 0101 0000 0 000 0100 0000 000 11111
+XAFLAG          1101 0101 0000 0 000 0100 0000 001 11111
+AXFLAG          1101 0101 0000 0 000 0100 0000 010 11111
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 088dfd8b1fd..c1b02b96183 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1864,9 +1864,24 @@ static bool trans_SB(DisasContext *s, arg_SB *a)
     return true;
 }
 
-static void gen_xaflag(void)
+static bool trans_CFINV(DisasContext *s, arg_CFINV *a)
 {
-    TCGv_i32 z = tcg_temp_new_i32();
+    if (!dc_isar_feature(aa64_condm_4, s)) {
+        return false;
+    }
+    tcg_gen_xori_i32(cpu_CF, cpu_CF, 1);
+    return true;
+}
+
+static bool trans_XAFLAG(DisasContext *s, arg_XAFLAG *a)
+{
+    TCGv_i32 z;
+
+    if (!dc_isar_feature(aa64_condm_5, s)) {
+        return false;
+    }
+
+    z = tcg_temp_new_i32();
 
     tcg_gen_setcondi_i32(TCG_COND_EQ, z, cpu_ZF, 0);
 
@@ -1890,10 +1905,16 @@ static void gen_xaflag(void)
 
     /* C | Z */
     tcg_gen_or_i32(cpu_CF, cpu_CF, z);
+
+    return true;
 }
 
-static void gen_axflag(void)
+static bool trans_AXFLAG(DisasContext *s, arg_AXFLAG *a)
 {
+    if (!dc_isar_feature(aa64_condm_5, s)) {
+        return false;
+    }
+
     tcg_gen_sari_i32(cpu_VF, cpu_VF, 31);         /* V ? -1 : 0 */
     tcg_gen_andc_i32(cpu_CF, cpu_CF, cpu_VF);     /* C & !V */
 
@@ -1902,6 +1923,8 @@ static void gen_axflag(void)
 
     tcg_gen_movi_i32(cpu_NF, 0);
     tcg_gen_movi_i32(cpu_VF, 0);
+
+    return true;
 }
 
 /* MSR (immediate) - move immediate to processor state field */
@@ -1914,30 +1937,6 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
     s->base.is_jmp = DISAS_TOO_MANY;
 
     switch (op) {
-    case 0x00: /* CFINV */
-        if (crm != 0 || !dc_isar_feature(aa64_condm_4, s)) {
-            goto do_unallocated;
-        }
-        tcg_gen_xori_i32(cpu_CF, cpu_CF, 1);
-        s->base.is_jmp = DISAS_NEXT;
-        break;
-
-    case 0x01: /* XAFlag */
-        if (crm != 0 || !dc_isar_feature(aa64_condm_5, s)) {
-            goto do_unallocated;
-        }
-        gen_xaflag();
-        s->base.is_jmp = DISAS_NEXT;
-        break;
-
-    case 0x02: /* AXFlag */
-        if (crm != 0 || !dc_isar_feature(aa64_condm_5, s)) {
-            goto do_unallocated;
-        }
-        gen_axflag();
-        s->base.is_jmp = DISAS_NEXT;
-        break;
-
     case 0x03: /* UAO */
         if (!dc_isar_feature(aa64_uao, s) || s->current_el == 0) {
             goto do_unallocated;
-- 
2.34.1


