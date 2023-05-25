Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B696711AA6
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:29:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLZ-0005qb-O6; Thu, 25 May 2023 19:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLR-0005mg-Jl
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:12 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLO-0005lq-L8
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:08 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d604cc0aaso262797b3a.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057164; x=1687649164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJBfhL5s/JujOKO92cVuqA077g93rVli8DiADyiaM+o=;
 b=A5hvo23gwC8j+XKAUw2mNHEBSYX+NlpEgOv6/2UzF82T7wc6+/iPrcpetNllUrS4hs
 Na5TX/jjAobW1W5F8l5XKWRyKfUisbP4LI3GKQ5AX/tS/HaeBZQmoNRK6WYcJsnlDC6n
 d+Wddaiue+RdosErOmzDA/gNYkq2t0n+a/fIiZmoED0ML81NeKHcbCnjaQEDgm6wsZok
 ygXE/yPyTocEu7Cy/RegdyczI1S7crDdlRO6II/5/3K+ZFn+otSXcOlxhpz1dauJBroy
 4/yFCIjmyclkWySVGLnobllIi51nIwn9jAYWlTJWxeM/q8sG/izfM+EEoPZhTW23DvXn
 rXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057164; x=1687649164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJBfhL5s/JujOKO92cVuqA077g93rVli8DiADyiaM+o=;
 b=JawPNNKQ/jyZIpKWwGJYVPi16qBHbY/WcwZLoNOI5JWR5OWeWnUuSEF+N+VC2xx7nx
 AfVFF/KDAtva/6fuuIR9MlObtFJJWJnaq8Wfv3l2BX5DHagfm05NPzZ8OCNJnCz/KJBK
 vrrdmcIBeq+bD58AVecPeBpVwc0kk5Ixvb+QDKPKOJ5k2TgtMsPQnkeKXTZTW5K2xHaj
 HpZJpm0ihyiYNTlKOdVQzg5dHUEiOaBOGBLxoNuVtog0XrikL6sT4UkUPpSCmqfT2QGr
 yd3vEeGGurVKoLWMRUm8UNPQbF1KsOp1lXPgi6tUTPBDbuZJOatdJk9t554jn4Ivlq94
 egrQ==
X-Gm-Message-State: AC+VfDyyA9kBDBum3CexUuSbZihf6Pl0+iapdIxFGkJknIAznlb3VTgU
 hIvZa0g8zTAtD0FYNspEHclZCmGEAUPnpJ9SVJg=
X-Google-Smtp-Source: ACHHUZ7by6ugjRYSId5qZRJl6roj0B/SLpywQXMONxgsbhRHu2j4E275tj8JRzWnWo0Rp4UYAhZqxw==
X-Received: by 2002:a05:6a20:8f14:b0:10b:27d0:70cc with SMTP id
 b20-20020a056a208f1400b0010b27d070ccmr21617096pzk.20.1685057164437; 
 Thu, 25 May 2023 16:26:04 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 06/20] target/arm: Use tcg_gen_qemu_st_i128 for STZG, STZ2G
Date: Thu, 25 May 2023 16:25:44 -0700
Message-Id: <20230525232558.1758967-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

This fixes a bug in that these two insns should have been using atomic
16-byte stores, since MTE is ARMv8.5 and LSE2 is mandatory from ARMv8.4.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6bb68618a0..51f9d227e7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4070,15 +4070,18 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
 
     if (is_zero) {
         TCGv_i64 clean_addr = clean_data_tbi(s, addr);
-        TCGv_i64 tcg_zero = tcg_constant_i64(0);
+        TCGv_i64 zero64 = tcg_constant_i64(0);
+        TCGv_i128 zero128 = tcg_temp_new_i128();
         int mem_index = get_mem_index(s);
-        int i, n = (1 + is_pair) << LOG2_TAG_GRANULE;
+        MemOp mop = finalize_memop(s, MO_128 | MO_ALIGN);
 
-        tcg_gen_qemu_st_i64(tcg_zero, clean_addr, mem_index,
-                            MO_UQ | MO_ALIGN_16);
-        for (i = 8; i < n; i += 8) {
-            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
-            tcg_gen_qemu_st_i64(tcg_zero, clean_addr, mem_index, MO_UQ);
+        tcg_gen_concat_i64_i128(zero128, zero64, zero64);
+
+        /* This is 1 or 2 atomic 16-byte operations. */
+        tcg_gen_qemu_st_i128(zero128, clean_addr, mem_index, mop);
+        if (is_pair) {
+            tcg_gen_addi_i64(clean_addr, clean_addr, 16);
+            tcg_gen_qemu_st_i128(zero128, clean_addr, mem_index, mop);
         }
     }
 
-- 
2.34.1


