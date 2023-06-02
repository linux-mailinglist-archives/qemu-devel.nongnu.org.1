Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E772069E
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:55:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q574s-000392-Jl; Fri, 02 Jun 2023 11:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574q-00037R-Jj
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574n-0003RC-G4
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f6042d610fso21677075e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721148; x=1688313148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CVG899GadG9n5+PuNksPKw1TX7s6N642Zf3CKGOWr8s=;
 b=mcgSSd4Z9UpL9s+ZOn/1rhmcYL43ryPIzlj2a9nbIpUoUQAGq/092q1uPluYkm2OKx
 JefmrImXZiMYH9tl2+7vHuKrq65y8w2gyYZZ2plxTFUY0NAh7zn14KTMmZkRTLKeOEt3
 yjItJk3JdFWb/kso9mL0+sMSEz0MbISXmCFTLhqqKyhGEOZXN/OcZC6npr732tVAAj3G
 ijmfx+1RU0tGL4Waf1YZLiyTP/gNA397kGcWJ/qBzLRhdF6U7zdczfYV5GZYGI7x7yvH
 7rB2Q4qSSFPC6FQAP5/qUC65kJhESF3gzQPgK51cxETzFIfEb0e/HqfnO9p/UvgNgjEe
 Wivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721148; x=1688313148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVG899GadG9n5+PuNksPKw1TX7s6N642Zf3CKGOWr8s=;
 b=AQRA9fYtTFj4uLBMXh+2ElrNt6r+H+u+jl7o4VHyCnFBc1srgxpfVK/GUccmHuex6S
 T5mm7hBwJMRCvoknlBRNovzF02BwsPbkpkDk7EpWyMbAvN8Bj/suDon9FroDLJ4/RBiM
 yb5A/7WKB79dBUZ+hhEGwLwW9HD7oX37dkOQ7MxGX0oHgpSDsQyUhgAz0doqw+QGCcoM
 Kz+VyQ4+9RM/PWAzwYR3b5AjrS5zFvCT52WfW/8C2841FCDj3oA+TGVN5Ej8lwz/tX30
 h3jGzK0OJP4LmQZYTCjI4/57WQLseeixsIgHben0a50L10kuv1OEppEdcDNB+oqZKmB1
 XEjQ==
X-Gm-Message-State: AC+VfDzHewpPCfkpcpaYdmVVnqE5Sg0y/bNnCZowJvnMkp13EpR/KZm3
 Mslj6iu9u6oF9AAlW52WU7XanfBjedWFECh6EUQ=
X-Google-Smtp-Source: ACHHUZ6qaCxFDc04BZpy+nOtIFF2XVg8z8bbgL7WmmoAGE/CV3+zfROkN+19RsMctqxRYLOfBhMwzQ==
X-Received: by 2002:a1c:7c1a:0:b0:3f6:117:6ed7 with SMTP id
 x26-20020a1c7c1a000000b003f601176ed7mr2157119wmc.35.1685721148184; 
 Fri, 02 Jun 2023 08:52:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/20] target/arm: Convert CFINV,
 XAFLAG and AXFLAG to decodetree
Date: Fri,  2 Jun 2023 16:52:07 +0100
Message-Id: <20230602155223.2040685-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Convert the CFINV, XAFLAG and AXFLAG insns to decodetree.
The old decoder handles these in handle_msr_i(), but
the architecture defines them as separate instructions
from MSR (immediate).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  6 ++++
 target/arm/tcg/translate-a64.c | 56 ++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 553f6904d9c..26a0b44cea9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -188,3 +188,9 @@ CLREX           1101 0101 0000 0011 0011 imm:4 010 11111
 DSB_DMB         1101 0101 0000 0011 0011 domain:2 types:2 10- 11111
 ISB             1101 0101 0000 0011 0011 imm:4 110 11111
 SB              1101 0101 0000 0011 0011 0000 111 11111
+
+# PSTATE
+
+CFINV           1101 0101 0000 0 000 0100 0000 000 11111
+XAFLAG          1101 0101 0000 0 000 0100 0000 001 11111
+AXFLAG          1101 0101 0000 0 000 0100 0000 010 11111
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 09258a9854f..33bebe594d1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1809,9 +1809,25 @@ static bool trans_SB(DisasContext *s, arg_SB *a)
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
+    s->base.is_jmp = DISAS_NEXT;
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
 
@@ -1835,10 +1851,17 @@ static void gen_xaflag(void)
 
     /* C | Z */
     tcg_gen_or_i32(cpu_CF, cpu_CF, z);
+
+    s->base.is_jmp = DISAS_NEXT;
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
 
@@ -1847,6 +1870,9 @@ static void gen_axflag(void)
 
     tcg_gen_movi_i32(cpu_NF, 0);
     tcg_gen_movi_i32(cpu_VF, 0);
+
+    s->base.is_jmp = DISAS_NEXT;
+    return true;
 }
 
 /* MSR (immediate) - move immediate to processor state field */
@@ -1859,30 +1885,6 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
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


