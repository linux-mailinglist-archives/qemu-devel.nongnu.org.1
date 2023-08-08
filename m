Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEDC77374D
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:05:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCzr-0001NX-Jn; Mon, 07 Aug 2023 23:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzo-0001LL-Jj
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:56 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzn-0006ZT-2h
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:56 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686d8c8fc65so3555775b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691463773; x=1692068573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbxSTVv8l+gK8qmeoMZlY1+rXFa4fHFVXKxIo6ZA74I=;
 b=nsETV6ytu9ktK/rPexpZSlZwA9rWUWMKq8YcnH8si+UJIZqh48peQ/WtLS89k1PIfU
 RebwJCR2ykljNZiin8H483drqzOOQ01ntHO9le/7K5auRjS6CFtBhjlLqAAT3EdyX/N8
 uJ/Yh5P5dopwT2nr9ZdATEDLEBBZ6as8kpxpvFU+IupzmBwEbTcllhvndW18ICgyOLSI
 n91+8bPBdSbRuEB72qhgeNOkrnWu458sL2HYPnFHgSMlvAvPuGgyY/XkJehRWERV0MyD
 gBJWQY30JvBG5Z6T9p/CJAc7mRiUFstrml3/LW0JrOqMS125Y6wHnN/fcWwkQyw2qzia
 Ay2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691463773; x=1692068573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbxSTVv8l+gK8qmeoMZlY1+rXFa4fHFVXKxIo6ZA74I=;
 b=VgFfoKEDF98U7tSSJhnpUTPH/ZotXqtcFJBbds7U7+V6QWK5G22HeFYM22xQVC8N8F
 RwrZXbgYRFcQdf2lCN2ttmb2q6zyt7w3CDh0oHHwacXWMSb1Ql3VK6izZLIHYBqtZ3eJ
 JP+Au+odt6HwRKs6Ti8Tw4p28JUAqou78u/p2V6HnXFcFRA1MKZVOpoerQCK0yih07uR
 zb2RInZ1+4qvHZJS2dTcKxfcezqJaNKZrWscKwwSfh5hEeBlNHfMu88vMWMBADiCjONU
 96xmS/R7gLsEO0u+C1/2m2SDclhNYjiGcCOKsNRT9tw3JEf1+BwcOpZkpSbbKXbGA5aY
 YKGw==
X-Gm-Message-State: AOJu0YwSsOfN5MEehDKry7uk6/n0awlgB6SQCJ+9ZNbIOKNZ0zunJ0IY
 T3hXHOSNI9vMGzEnPZJlyPzkfZvvwYaVOwmUBUE=
X-Google-Smtp-Source: AGHT+IF+/8GH9jPIzgPP7sKLIb5GL+foKTi/6Ynso99DQ0nZTIxthyvpUdflN1YEBFOjsTmVzZSjaQ==
X-Received: by 2002:a05:6a20:8e28:b0:13c:b1a7:7b1 with SMTP id
 y40-20020a056a208e2800b0013cb1a707b1mr11328219pzj.25.1691463773626; 
 Mon, 07 Aug 2023 20:02:53 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a62e407000000b006870c50efaesm6903609pfh.9.2023.08.07.20.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:02:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com,
	jniethe5@gmail.com,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 2/7] tcg/ppc: Use PADDI in tcg_out_movi
Date: Mon,  7 Aug 2023 20:02:45 -0700
Message-Id: <20230808030250.50602-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808030250.50602-1-richard.henderson@linaro.org>
References: <20230808030250.50602-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PADDI can load 34-bit immediates and 34-bit pc-relative addresses.

Reviewed-by: Jordan Niethe <jniethe5@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 642d0fd128..2141c0bc78 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -707,6 +707,38 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     return true;
 }
 
+/* Ensure that the prefixed instruction does not cross a 64-byte boundary. */
+static bool tcg_out_need_prefix_align(TCGContext *s)
+{
+    return ((uintptr_t)s->code_ptr & 0x3f) == 0x3c;
+}
+
+static void tcg_out_prefix_align(TCGContext *s)
+{
+    if (tcg_out_need_prefix_align(s)) {
+        tcg_out32(s, NOP);
+    }
+}
+
+static ptrdiff_t tcg_pcrel_diff_for_prefix(TCGContext *s, const void *target)
+{
+    return tcg_pcrel_diff(s, target) - (tcg_out_need_prefix_align(s) ? 4 : 0);
+}
+
+/* Output Type 10 Prefix - Modified Load/Store Form (MLS:D) */
+static void tcg_out_mls_d(TCGContext *s, tcg_insn_unit opc, unsigned rt,
+                          unsigned ra, tcg_target_long imm, bool r)
+{
+    tcg_insn_unit p, i;
+
+    p = OPCD(1) | (2 << 24) | (r << 20) | ((imm >> 16) & 0x3ffff);
+    i = opc | TAI(rt, ra, imm);
+
+    tcg_out_prefix_align(s);
+    tcg_out32(s, p);
+    tcg_out32(s, i);
+}
+
 static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
                              TCGReg base, tcg_target_long offset);
 
@@ -992,6 +1024,25 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
+    /*
+     * Load values up to 34 bits, and pc-relative addresses,
+     * with one prefixed insn.
+     */
+    if (have_isa_3_10) {
+        if (arg == sextract64(arg, 0, 34)) {
+            /* pli ret,value = paddi ret,0,value,0 */
+            tcg_out_mls_d(s, ADDI, ret, 0, arg, 0);
+            return;
+        }
+
+        tmp = tcg_pcrel_diff_for_prefix(s, (void *)arg);
+        if (tmp == sextract64(tmp, 0, 34)) {
+            /* pla ret,value = paddi ret,0,value,1 */
+            tcg_out_mls_d(s, ADDI, ret, 0, tmp, 1);
+            return;
+        }
+    }
+
     /* Load 32-bit immediates with two insns.  Note that we've already
        eliminated bare ADDIS, so we know both insns are required.  */
     if (TCG_TARGET_REG_BITS == 32 || arg == (int32_t)arg) {
-- 
2.34.1


