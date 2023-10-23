Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE5A7D3EF5
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:18:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzQw-0005WD-Pq; Mon, 23 Oct 2023 14:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQu-0005VA-Gn
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:44 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQp-00085c-M9
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:44 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5849fc56c62so740927eaf.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084818; x=1698689618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcT+t2NWvvAgl7ag7U9fcr97JnnF4drB4JEVTRDmT40=;
 b=mQkW5tIj3yWQgjTi6C0WcCpCINt/dwAoqOEYlN4ID+EapZBwBhZMFty8iekGzZyory
 tCV66mSb2nmFBgLg1sdZe9hb1Jn5OEizVlP/wfibCvEE4GaWYOonTkUoQfbHz3j/VSi9
 fVZGGJbzzMyFTgfDCyM6TIYVEbWMD1jf9zGjmf6CDViEyVlO1koEJxM3yeOwkhZY0GHH
 7xJ/KbC/ghfkT3s0mwIqi8ciSKU4YUerhQr7lzc9lFKLJH0gsXtCKRnEpS+Ox4s9RPar
 rY2N/j6p2s0tSLM9SKLYUggCgVleJqOkdKykYltVDPF20sDoxkpJMdyaYvXbSnYicG2M
 +g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084818; x=1698689618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcT+t2NWvvAgl7ag7U9fcr97JnnF4drB4JEVTRDmT40=;
 b=wXpAHVSnj3p/GGsGGgAUEHqRMdhEPLiBDlnB6YZ7GSkIzPVCl0P8cT36epqStCv6xA
 8x7q4TCe7CsUiGCIw1ZGo4BdF1QCaQVzblHmoCmhX0ZGjYtLWlHkXwLanX41pgZhJO9c
 ZRroJJC0xrwpIZDd5fMTqwHRHHRsYfHeB5Q/Y8H98TdlX7cMlVBgwuPuZiLRlCHqVaXb
 IRNEnMDAS4fSf8GFp9u9A8DosMG/1ya/7PqhL6t2nhFJ+htdpMjlltWYdiwbACYupiHG
 CW2XNIs1mC6fa5+5CNfXmlbsdCyr3zGnsAZ4TZhCNyVtN2WAVjE+jnoirDwBAhS54nbk
 XYtg==
X-Gm-Message-State: AOJu0YyV7lD9Ikj2EgZYUuh1eBGrlN8ULaNOtSiioS4z2nSF5QuHLb/s
 on8gVhCdbFaPSghUVtOdu0VxzbjvuPlkJqYrVN8=
X-Google-Smtp-Source: AGHT+IG0Drd2MMEtgAcNjrQHIZwLI2zOeB4cogpvZf0p5VR/Ovfolsy76o8TReHSCktrbocPEoqwpw==
X-Received: by 2002:a05:6358:810c:b0:168:d6cd:7b2e with SMTP id
 p12-20020a056358810c00b00168d6cd7b2emr5661037rwk.29.1698084817955; 
 Mon, 23 Oct 2023 11:13:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jordan Niethe <jniethe5@gmail.com>
Subject: [PULL v3 08/38] tcg/ppc: Use PADDI in tcg_out_movi
Date: Mon, 23 Oct 2023 11:12:59 -0700
Message-Id: <20231023181329.171490-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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
index 6337b1e8be..f4235383c6 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -719,6 +719,38 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
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
 
@@ -1017,6 +1049,25 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
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


