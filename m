Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E72781643
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:04:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMQ-00004x-HT; Fri, 18 Aug 2023 21:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMO-0008WG-FN
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMM-0007NZ-5l
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:36 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bf48546ccfso6980285ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406953; x=1693011753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOR8Q/KDHweXHhtPJBOF6KbMNecqFI3FxCLD3VnqMyo=;
 b=xBw/XgejVnzOPPO3ZgB8tMHJfr8SSTR+y4Ga0aJvwGQxJfb/fqTrYcsNQWJ+wZmNvi
 f59dpHckMtlZbNxgSVE8DTdA8DmLlLP+gNjLXkglKAUiSF/0356Gp+my5wUYHaM77mMU
 uG0yQ2gkwIs20ebfhboJoTwwrqIM6A5KoBIzhR40ttMEjaG8z4drF/1QiZsLtZjV3+Kx
 ONIL1P3XAt3Xeynk6oGxVf5j0SSescsnfzbhwH6Q5hgoOWm4oqt/MDOs5pfMU65utHxw
 ye3pLwD7IFk0ei6NMbC2oX6IdzmarZQPdBex/A4oDi+BRYS1jlOO74tlHkGbCi1dNi2x
 h6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406953; x=1693011753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOR8Q/KDHweXHhtPJBOF6KbMNecqFI3FxCLD3VnqMyo=;
 b=iBNNThCyFfbsZcpBBabryViRLukCdo7lLTZBzUuiJiH6ZnQiKCPE+RD+gxE3Z0TAjI
 mqPnsQbtlr7ulQaOA6CjyDrm3JxRM9rfcS0OXxA/POfwS1j/JyxoL/UEdLK618YR5jqN
 HsUe/wXtEL+W2PczxPC6dUgmJ9NLSo6gHoiYmHxh8t3OakMIxKDwBVcfY+G6iC0P+R3w
 NmUAvtNJtkMJWGDzBkowwm4GPN3mdweySE/BrlppLL6z/JY7zYlrXObbFEfgbSPH2Rf9
 a0fNRddTwys6DdjXMp23Py4Y5XPWD3c7iVN17Wim2Lorwb4xBKhdjuVBaJh5sGBHjcYZ
 auRg==
X-Gm-Message-State: AOJu0Yx+DPnYmySoP21i0RWXRmpjn2tj+zIPhpU1FfMXG+7GTZS/0u79
 EUsML0BaICsC0m2qzXUY3TvwZ6solhwgd2EZFcw=
X-Google-Smtp-Source: AGHT+IHqqBD/2+fHFnRSTQ9EEzeidjHZtWqqCXx6/ZnSDfuYhdFqQid9h9ee4nIhAuj7piqa4rqBCg==
X-Received: by 2002:a17:902:ea0d:b0:1b8:9552:2249 with SMTP id
 s13-20020a170902ea0d00b001b895522249mr752814plg.43.1692406952936; 
 Fri, 18 Aug 2023 18:02:32 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 14/18] target/arm: Use clmul_64
Date: Fri, 18 Aug 2023 18:02:14 -0700
Message-Id: <20230819010218.192706-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Use generic routine for 64-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index ffb4b44ce4..1f93510b85 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2003,28 +2003,14 @@ void HELPER(gvec_pmul_b)(void *vd, void *vn, void *vm, uint32_t desc)
  */
 void HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
 {
-    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    intptr_t i, opr_sz = simd_oprsz(desc);
     intptr_t hi = simd_data(desc);
     uint64_t *d = vd, *n = vn, *m = vm;
 
     for (i = 0; i < opr_sz / 8; i += 2) {
-        uint64_t nn = n[i + hi];
-        uint64_t mm = m[i + hi];
-        uint64_t rhi = 0;
-        uint64_t rlo = 0;
-
-        /* Bit 0 can only influence the low 64-bit result.  */
-        if (nn & 1) {
-            rlo = mm;
-        }
-
-        for (j = 1; j < 64; ++j) {
-            uint64_t mask = -((nn >> j) & 1);
-            rlo ^= (mm << j) & mask;
-            rhi ^= (mm >> (64 - j)) & mask;
-        }
-        d[i] = rlo;
-        d[i + 1] = rhi;
+        Int128 r = clmul_64(n[i + hi], m[i + hi]);
+        d[i] = int128_getlo(r);
+        d[i + 1] = int128_gethi(r);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1


