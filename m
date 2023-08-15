Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C732377D3CE
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:01:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Ax-0005AT-Gr; Tue, 15 Aug 2023 15:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Au-00058Q-Dj
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Ar-000151-6Z
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:55 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686ba29ccb1so3897348b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129472; x=1692734272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3yC0mxP+Pzdku/R2U4WTUfNcg5S21JJsMYdzIv6kLFM=;
 b=YjELarhXxYAmk6Gw2a3lI0J16SSyPIWBrh/gEeiXfSSE+hf5ZX0gjSzTgexkuilwWr
 u+s/OshZSJzIOw0oJF33mdxlqs9nAgP3PR17Kv8vnExd7OSw7Rq966xOdab4TBg1Wxor
 6SIpezfQSDmvN9MpTOzBrHn+4qUgIKGcNl74n4vG1cpz+KAKsM3w5wq4l5TZtNB2iPMV
 yobdiUmgPTbyik6M8E+dPRlF4XSPDeVkCONeoSEpmPHYidnEPRBFE+e8C6vv4H/z8lzt
 L7zg2DDMAbVqVmOAiJsEpeQ0vjU3xGlU0/iSqAaH7kiNp5PEwa4kNk+f0tsWaUPZ0qPN
 I5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129472; x=1692734272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3yC0mxP+Pzdku/R2U4WTUfNcg5S21JJsMYdzIv6kLFM=;
 b=htoPolQCYx2/K6hUhXtjazKgYDZovZMLJCafVuVCjhgfv5dqCGy7OSj8hN6d+StydQ
 PmPRBV8qlL6sblcEVSG6IUF7jfocKnUIE2bVspiI6tr6hUqla/by0HUY1NWzb3pDj18j
 JMZ6CX9IrH14xx1P7T+yKSAZHUjf3m7EwyEvC2mVCFWd30xsC91NYeSeYqQTN5bi1nar
 EEvd4N5pBIsbHlvB77IO1tFJZmrlRRVa/wa+h3jkJgY78buXnbg/W3AzzJ34FPI97J7d
 ko29WrtYdo1EL73i5kkB+c2QvORqF/MrO78LclZ9DpfmOZzdnGZmCLeva5UrTED7wfHs
 5NUA==
X-Gm-Message-State: AOJu0YxC7j9wN4Wa6FTcurAKI3RsV2VgC1S46IfvSdg9NownZngKnIAn
 VDmZQjd/ODnxWKzGOPMwWEo9EjA2nafB/Uk+EIQ=
X-Google-Smtp-Source: AGHT+IFpxqFJrhKk6a4hnsSQNnBJ3s2roGPqX1B2zc9yb+rY4iNV7RCz3ox2BJgTi3fp28ns4GZNmQ==
X-Received: by 2002:a05:6a00:1392:b0:687:9785:13c7 with SMTP id
 t18-20020a056a00139200b00687978513c7mr3799044pfg.13.1692129471957; 
 Tue, 15 Aug 2023 12:57:51 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 09/14] tcg/ppc: Use PADDI in tcg_out_movi
Date: Tue, 15 Aug 2023 12:57:36 -0700
Message-Id: <20230815195741.8325-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
index b7d1b4f1bb..40472f3d00 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -714,6 +714,38 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
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
 
@@ -1012,6 +1044,25 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
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


