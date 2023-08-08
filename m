Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7595773749
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCzv-0001RO-8r; Mon, 07 Aug 2023 23:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzs-0001Pc-Uf
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:03:01 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzr-0006bR-B6
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:03:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686ed1d2594so5014317b3a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691463778; x=1692068578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+PZ+MkLecLrqPhUWEMZ8qOCbS3Yrr8j9Pi4RnELYw4=;
 b=vXRjsnRXqv7Epg9Yr7JAj1qV17tS2XgboGE851OTloUZr0pD9l3+p+5dzLi9B9ArgV
 oUk9wBxCCiaeJyj3LsjjzHYEAeYRlY8qLVnghzNXIyqMzlx2zynbBE+9/oqAJ6J8Qxdi
 QiswrpJR+7Lii5O/JXc+Jc80XXarx9J1unYk3z0Ho9yEB1B2uQa5X1a5mBvzyAPpjaCB
 /2g1HHxWQn8MqeUrknZipX3l2pNrDhDIa6vZsYRO6DLCy9E30e5i9aT8pz/7jrsOFYSF
 v8yo0NAFB+8RR7TBbzRKzDPvV/GOltWKXfK2/eZky6Y6scG2ZKfmD1cB1SzSPz/+LvSK
 KFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691463778; x=1692068578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+PZ+MkLecLrqPhUWEMZ8qOCbS3Yrr8j9Pi4RnELYw4=;
 b=DEsT04vJ8ESyFAOZoEfgjmqJDnAaw9hmRCWvEZ5oT+FK1JLLyx9jCyXCSxpfFIU0hF
 X8hf8o16RVZbW0MrWVh/nKnJ3oGsUXD4/eYrCWvZnPy6x2VTlJSSktMZ18MJ9Bm0/RfU
 +WjCVHntlVfn8QRJ+EZB9tj90ul8LX58G6S8x6RNKBAEnZzfsY5yMP5zDxLXnyVK4zHW
 ZxysvKM25r4h6tLF7/TofNYX9FN5EeuvTkJ2xW0+D/rhSEf7x00+Ko06yVBa+YBfhHJ8
 VLWq7+j0itgU1cdj79bzb9gb1AE7hW6swdvekg+kTttgfrTiDkWvmbhwWWfvZ52YoDWA
 5dfQ==
X-Gm-Message-State: AOJu0YyU8UfnjBB2qe83Ke0It+mbzbHHWGbIfMrMdr6ePYv0o8+1zkpR
 FUVG0+nW/3AIYOkndOuUZD5YlBaH+ifOF+7lNik=
X-Google-Smtp-Source: AGHT+IG2SHkc3Z0P5QwoUodakZTex91zx3mEKUPJ11cZGLQhO/akn1A/2fy6Q4A0SgJRMeu+GlxS5Q==
X-Received: by 2002:a05:6a00:1488:b0:687:6184:def4 with SMTP id
 v8-20020a056a00148800b006876184def4mr14000203pfu.21.1691463777951; 
 Mon, 07 Aug 2023 20:02:57 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a62e407000000b006870c50efaesm6903609pfh.9.2023.08.07.20.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:02:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com,
	jniethe5@gmail.com,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 7/7] tcg/ppc: Use prefixed instructions for tcg_out_goto_tb
Date: Mon,  7 Aug 2023 20:02:50 -0700
Message-Id: <20230808030250.50602-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808030250.50602-1-richard.henderson@linaro.org>
References: <20230808030250.50602-1-richard.henderson@linaro.org>
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

When a direct branch is out of range, we can load the destination for
the indirect branch using PLA (for 16GB worth of buffer) and PLD from
the TranslationBlock for everything larger.

This means the patch affects exactly one instruction: B (plus filler),
PLA or PLD.  Which means we can update and execute the patch atomically.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 63fe4ef995..b686a68247 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2646,31 +2646,38 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     uintptr_t ptr = get_jmp_target_addr(s, which);
 
     if (USE_REG_TB) {
+        /*
+         * With REG_TB, we must always use indirect branching,
+         * so that the branch destination and TCG_REG_TB match.
+         */
         ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
         tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
-    
-        /* TODO: Use direct branches when possible. */
-        set_jmp_insn_offset(s, which);
         tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
-
         tcg_out32(s, BCCTR | BO_ALWAYS);
 
         /* For the unlinked case, need to reset TCG_REG_TB.  */
         set_jmp_reset_offset(s, which);
         tcg_out_mem_long(s, ADDI, ADD, TCG_REG_TB, TCG_REG_TB,
                          -tcg_current_code_size(s));
-    } else {
-        /* Direct branch will be patched by tb_target_set_jmp_target. */
-        set_jmp_insn_offset(s, which);
-        tcg_out32(s, NOP);
+        return;
+    }
 
-        /* When branch is out of range, fall through to indirect. */
+    /* Direct branch will be patched by tb_target_set_jmp_target. */
+    set_jmp_insn_offset(s, which);
+    tcg_out32(s, NOP);
+
+    /* When branch is out of range, fall through to indirect. */
+    if (have_isa_3_10) {
+        ptrdiff_t offset = tcg_pcrel_diff_for_prefix(s, (void *)ptr);
+        tcg_out_8ls_d(s, PLD, TCG_REG_TMP1, 0, offset, 1);
+    } else {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (int16_t)ptr);
-        tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
-        tcg_out32(s, BCCTR | BO_ALWAYS);
-        set_jmp_reset_offset(s, which);
     }
+
+    tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
+    tcg_out32(s, BCCTR | BO_ALWAYS);
+    set_jmp_reset_offset(s, which);
 }
 
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
-- 
2.34.1


