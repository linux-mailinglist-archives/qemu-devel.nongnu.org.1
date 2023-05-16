Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3CC7057DD
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:48:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Ye-0006eW-0D; Tue, 16 May 2023 15:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yc-0006dr-8I
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:02 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Ya-0002na-Id
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:01 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5304913530fso8068792a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266119; x=1686858119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BFtx9KYq0Th2HWZb/BY+/P+rVcQ7G1nOi7Bio8e4oI=;
 b=EslWbfjB90BUadvpR2qxu4N6UhJY1ngA1MjB399KaCev/ocB8t23VOXlOwUWWc+rPc
 y4zWiBARwVSWSAFP2wT5Fk+gIoTIkkkxCZT5srFu8cyNS1j0O9hTAooz/TLuqFg3Yixw
 WAa4RMGwbVrFK/vcVqd1rzG5uTUfQOlORhiguOErt2lCYsjRHDoFCuncr6+I+26bxWmb
 yRRvE2BYIAFYDNNWW1p2CUUtvWGvU55tppSFT4HrwUBAMw7vixkn6obuHrPjOBFRZrzp
 v73rjlTOvfTKgZbyUH4pJcUwr0Angjmh/EVW7SN2pZcFcCpfGNxMGezXcbPA9RIh1kPf
 RsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266119; x=1686858119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BFtx9KYq0Th2HWZb/BY+/P+rVcQ7G1nOi7Bio8e4oI=;
 b=OdsuqniOEynJj+a3k0FWg4he/GVTHCg9QJD5H1ndjW/+qwnFpKjR+snjJP/1rhLFe0
 +kzbhePM41UZTOKL39Lz+K4ux07Cwgk+3ZzSIFeDL7mwCb/8/v8tysBOtpItrTWY2xKL
 NtS6jKmiG1P0W7HDq0eOhAZAQWYgipLNjjF75iDLyrfW+X0jg2UnlMZyUU+bnWtrS9yh
 cmxYH0f8SYtRKTLDoYIcce4qECYX8g64orYWG3Z3Rm/BcLzbqTDm0EZTdJaDIc0P0Ip3
 iZXorlJ4SCJmJqDcxLXcKm1spiReikWe8QuDXEaOwclMseRxifqSHl2KSstOM0tespKF
 dVYw==
X-Gm-Message-State: AC+VfDxuzp12oKJ4G2gy/H4dGl820C33ksMHFQ+4mEWrNEKHQLC1jBoQ
 L6W9fcGAw3sjOE/cEuum5hsDGRliIAvg2lHHeKA=
X-Google-Smtp-Source: ACHHUZ6SpR5qrFqtnP7Y8WV5iBuTuyhTXCCrgn57jeVLdfJiHsRciIeeiUF6VrtPmr062ryG1vLNGQ==
X-Received: by 2002:a05:6a20:394d:b0:104:8824:74eb with SMTP id
 r13-20020a056a20394d00b00104882474ebmr19735544pzg.51.1684266119092; 
 Tue, 16 May 2023 12:41:59 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:41:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/80] tcg/i386: Use full load/store helpers in user-only mode
Date: Tue, 16 May 2023 12:40:38 -0700
Message-Id: <20230516194145.1749305-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Instead of using helper_unaligned_{ld,st}, use the full load/store helpers.
This will allow the fast path to increase alignment to implement atomicity
while not immediately raising an alignment exception.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 52 +++------------------------------------
 1 file changed, 4 insertions(+), 48 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 911123cfa8..21553f3c39 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1776,7 +1776,6 @@ typedef struct {
     int seg;
 } HostAddress;
 
-#if defined(CONFIG_SOFTMMU)
 /*
  * Because i686 has no register parameters and because x86_64 has xchg
  * to handle addr/data register overlap, we have placed all input arguments
@@ -1812,7 +1811,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 
     /* resolve label address */
     tcg_patch32(label_ptr[0], s->code_ptr - label_ptr[0] - 4);
-    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+    if (label_ptr[1]) {
         tcg_patch32(label_ptr[1], s->code_ptr - label_ptr[1] - 4);
     }
 
@@ -1834,7 +1833,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 
     /* resolve label address */
     tcg_patch32(label_ptr[0], s->code_ptr - label_ptr[0] - 4);
-    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+    if (label_ptr[1]) {
         tcg_patch32(label_ptr[1], s->code_ptr - label_ptr[1] - 4);
     }
 
@@ -1844,51 +1843,8 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     tcg_out_jmp(s, l->raddr);
     return true;
 }
-#else
-static bool tcg_out_fail_alignment(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    /* resolve label address */
-    tcg_patch32(l->label_ptr[0], s->code_ptr - l->label_ptr[0] - 4);
-
-    if (TCG_TARGET_REG_BITS == 32) {
-        int ofs = 0;
-
-        tcg_out_st(s, TCG_TYPE_PTR, TCG_AREG0, TCG_REG_ESP, ofs);
-        ofs += 4;
-
-        tcg_out_st(s, TCG_TYPE_I32, l->addrlo_reg, TCG_REG_ESP, ofs);
-        ofs += 4;
-        if (TARGET_LONG_BITS == 64) {
-            tcg_out_st(s, TCG_TYPE_I32, l->addrhi_reg, TCG_REG_ESP, ofs);
-            ofs += 4;
-        }
-
-        tcg_out_pushi(s, (uintptr_t)l->raddr);
-    } else {
-        tcg_out_mov(s, TCG_TYPE_TL, tcg_target_call_iarg_regs[1],
-                    l->addrlo_reg);
-        tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_AREG0);
-
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_RAX, (uintptr_t)l->raddr);
-        tcg_out_push(s, TCG_REG_RAX);
-    }
-
-    /* "Tail call" to the helper, with the return address back inline. */
-    tcg_out_jmp(s, (const void *)(l->is_ld ? helper_unaligned_ld
-                                  : helper_unaligned_st));
-    return true;
-}
-
-static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    return tcg_out_fail_alignment(s, l);
-}
-
-static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    return tcg_out_fail_alignment(s, l);
-}
 
+#ifndef CONFIG_SOFTMMU
 static HostAddress x86_guest_base = {
     .index = -1
 };
@@ -1920,7 +1876,7 @@ static inline int setup_guest_base_seg(void)
     return 0;
 }
 #endif /* setup_guest_base_seg */
-#endif /* SOFTMMU */
+#endif /* !SOFTMMU */
 
 /*
  * For softmmu, perform the TLB load and compare.
-- 
2.34.1


