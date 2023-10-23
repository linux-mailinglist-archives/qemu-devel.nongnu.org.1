Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E567A7D3BDF
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxVQ-00011T-8j; Mon, 23 Oct 2023 12:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVE-0000tE-Cn
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVB-0001P9-SM
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:03 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so30010825e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698077399; x=1698682199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGdMBoRQL+JhEHsdcrKM5twfzIuQtQkjsvy/D+szlAY=;
 b=io+jAE0LqfVov+WFFIE6WQLSCa9u4YSJ/IkgNhGFg/B5gtt7wAWemIPvLKT4L/ZhcC
 TZtXrINht9NqgV6lcUHjPu2s7wO7voqSTfpBr8rXknXLMeISg9/tMfhfc2A3emnHucf4
 I9nSiqIIgj0bt17ui+RBXKgTFGovpKKZfd1eCuYG7nLF0tH60wpHJRs0iztpUm6m/H2T
 GUiQ1rm2M6RfW8TwUuISoh91e6szQOTc0rqBFA6+pYfHG56F5tbquPt9gAjwboa7UHmD
 8EmbBMwV01XKED+DuGs4gRQUVLDoRzoHkXMK92/0jcEObsIR7EA/QeJofTAtru9FvWTu
 lXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077399; x=1698682199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGdMBoRQL+JhEHsdcrKM5twfzIuQtQkjsvy/D+szlAY=;
 b=E25cqtPnM4BfCuqYXCgFB8lbVIFobfQXg/Y3B2YzKTU3m05KBL/2AaNYATWFktvaHw
 GDqXcfLjN9OhVcwfT09wS/JIn0WVgKEMVZgTo1q8QqtWw0I1DREwgf/Y9iX4fQKJNeQq
 2HRV1+GIJ+sy0aE2ExXrUYqlbbf1cEazd0DtmpvVVqEW+XRT3I1gmUu8TLOgGLw5qGnq
 /x1Kfugx1juTyT2zFMefw2ipPUhHrANyOf3kLhOp/vWWtUXeLMVazrHQIgQWX0Vl/mh3
 +MqElrUHmo1SeRZVVvTOGJW+o4CWWrVkkYCt536tOKwd9qVVlF3ymwNmNbgMayrP6okV
 ealg==
X-Gm-Message-State: AOJu0Yw6sAR45M/eLhm3Auh/GtIkXwiRRAxR/TcdBrA7kU1cQj1yFqJg
 g5Y1SPvN3OvGzILrzPN9j6vv0oyQF5sI43G1l/A=
X-Google-Smtp-Source: AGHT+IEAYbiSk6HlJTfCQx59AEIv9eVK4W8zcKe+5I5SxbK/btyA0UOr6UY6r0Bs57sy6rJnr1TmAw==
X-Received: by 2002:a05:600c:1c81:b0:405:458d:d54 with SMTP id
 k1-20020a05600c1c8100b00405458d0d54mr7748258wms.33.1698077399469; 
 Mon, 23 Oct 2023 09:09:59 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr.
 [176.170.216.159]) by smtp.gmail.com with ESMTPSA id
 o22-20020a5d58d6000000b003143867d2ebsm8077853wrf.63.2023.10.23.09.09.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Oct 2023 09:09:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 2/9] target/cris: Use tcg_gen_extract_tl
Date: Mon, 23 Oct 2023 18:09:37 +0200
Message-ID: <20231023160944.10692-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023160944.10692-1-philmd@linaro.org>
References: <20231023160944.10692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/cris/translate.c     | 3 +--
 target/i386/tcg/translate.c | 9 +++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index b3974ba0bb..65b07e1d80 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -871,8 +871,7 @@ static void gen_tst_cc (DisasContext *dc, TCGv cc, int cond)
                 bits = 15;
             }
 
-            tcg_gen_shri_tl(cc, cc_result, bits);
-            tcg_gen_andi_tl(cc, cc, 1);
+            tcg_gen_extract_tl(cc, cc_result, bits, 1);
         } else {
             cris_evaluate_flags(dc);
             tcg_gen_andi_tl(cc, cpu_PR[PR_CCS],
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 587d88692a..25289eeec9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1159,8 +1159,7 @@ static void gen_setcc1(DisasContext *s, int b, TCGv reg)
 
     if (cc.cond == TCG_COND_NE && !cc.use_reg2 && cc.imm == 0 &&
         cc.mask != 0 && (cc.mask & (cc.mask - 1)) == 0) {
-        tcg_gen_shri_tl(reg, cc.reg, ctztl(cc.mask));
-        tcg_gen_andi_tl(reg, reg, 1);
+        tcg_gen_extract_tl(reg, cc.reg, ctztl(cc.mask), 1);
         return;
     }
     if (cc.mask != -1) {
@@ -1783,8 +1782,7 @@ static void gen_rot_rm_T1(DisasContext *s, MemOp ot, int op1, int is_right)
        currently dead.  */
     if (is_right) {
         tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask - 1);
-        tcg_gen_shri_tl(cpu_cc_dst, s->T0, mask);
-        tcg_gen_andi_tl(cpu_cc_dst, cpu_cc_dst, 1);
+        tcg_gen_extract_tl(cpu_cc_dst, s->T0, mask, 1);
     } else {
         tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask);
         tcg_gen_andi_tl(cpu_cc_dst, s->T0, 1);
@@ -1873,8 +1871,7 @@ static void gen_rot_rm_im(DisasContext *s, MemOp ot, int op1, int op2,
            currently dead.  */
         if (is_right) {
             tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask - 1);
-            tcg_gen_shri_tl(cpu_cc_dst, s->T0, mask);
-            tcg_gen_andi_tl(cpu_cc_dst, cpu_cc_dst, 1);
+            tcg_gen_extract_tl(cpu_cc_dst, s->T0, mask, 1);
         } else {
             tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask);
             tcg_gen_andi_tl(cpu_cc_dst, s->T0, 1);
-- 
2.41.0


