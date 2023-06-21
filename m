Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E943573837D
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:20:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwo9-0006nW-VA; Wed, 21 Jun 2023 08:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnu-0006e3-Iy
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:21 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwns-0000K3-P7
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:18 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5149aafef44so6965448a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687349951; x=1689941951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJm2HHOE+JbF1SBBMy6pxmjuiMpXMHdJ6dJJZMNNmag=;
 b=RGV+bKP26P4vvhtYwLfzeH1JRUKooTPZj6S3PeV3ZWJS+mHwAxYwVmdxh1xcgEZIUM
 mAEFA/hCZBTB4NqhF3E6qleNkEl+tnVUSbVD16g5tswjSMFATZuRI1DTRVswAOztDwO5
 65n/MgWlHO15bSUjvU62rIvD+jmnTYek4OWHni7PBXCimRtGJPHr1JeM9ZHZkHGLnAN7
 u5c4CjkSSMPRpYLvqzkeXTFcxPhrqZi84LLRuy/JNlCCiYtf5IbV/D9wD0XXvXFhuhh5
 G3OaH0qVk5mev1QnW/KeUfbUWLdys9trKuRNQyRe8+/tESk9mWD1CzyU1SXQr0Y4M6mH
 JxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687349951; x=1689941951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJm2HHOE+JbF1SBBMy6pxmjuiMpXMHdJ6dJJZMNNmag=;
 b=HJp7rHlqzFRUpqQsXjdCLfnjwmu2kG+P1iNlPihcSUkHNNUUUMGc43WpI3KdnoeyeL
 Dns5EMELWgF0DH25k9N2WuT9XsuABe78riGWEzfkPjiToshKqDxu2nL7bcPnB/1ztWrA
 dX2BH8qbIOzPrK2FvKdHb4u984ZjG3WWV++win9/3mRKdN93OVh4f/gJt2sg45bl4ALU
 5zZdchONkfW+yBAdtE/R4V+yc/zr5d4e638kHZcNX/IVoG6dYggherrwCgUKhIgWIw0H
 VsbE+uJs32dP9y6QqLTgGqZAwJkMldo/zRVzRgZ7oITHCo8In9+wKjUSOi1joQmg7bJv
 SCiA==
X-Gm-Message-State: AC+VfDyPxJNY+dbXui96X0LUcXYE0gOPVlU+dqSrqY5oebz0tv/ODSVM
 3j3Az0YQCnyamzpeqivUC+FYmW0Efb4UHdZh0AeZCVAz
X-Google-Smtp-Source: ACHHUZ7LYB5e8SUZc9l5W8hIqFzmXtL1+k11R7xGoThs2iQ5KuueflSB5MmziJ9OzBe4B4ibRdooMg==
X-Received: by 2002:a05:6402:344c:b0:51a:5ac3:4df7 with SMTP id
 l12-20020a056402344c00b0051a5ac34df7mr5454152edc.0.1687349951425; 
 Wed, 21 Jun 2023 05:19:11 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 s6-20020a056402014600b0051bdf152295sm543176edu.76.2023.06.21.05.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 05:19:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 7/9] accel/tcg: Add TLB_CHECK_ALIGNED
Date: Wed, 21 Jun 2023 14:19:00 +0200
Message-Id: <20230621121902.1392277-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621121902.1392277-1-richard.henderson@linaro.org>
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x533.google.com
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

This creates a per-page method for checking of alignment.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h |  4 +++-
 accel/tcg/cputlb.c     | 27 ++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 8018ce783e..e61100fc80 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -346,8 +346,10 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_BSWAP            (1 << 0)
 /* Set if TLB entry contains a watchpoint.  */
 #define TLB_WATCHPOINT       (1 << 1)
+/* Set if TLB entry requires aligned accesses.  */
+#define TLB_CHECK_ALIGNED    (1 << 2)
 
-#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT)
+#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED)
 
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 61f4d94a4d..cb7b4b01e9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1553,7 +1553,7 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
     flags |= full->slow_flags[access_type];
 
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
-    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))) {
+    if (flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED)) {
         *phost = NULL;
         return TLB_MMIO;
     }
@@ -1909,6 +1909,31 @@ static bool mmu_lookup(CPUArchState *env, target_ulong addr, MemOpIdx oi,
         tcg_debug_assert((flags & TLB_BSWAP) == 0);
     }
 
+    /*
+     * This alignment check differs from the one above, in that this is
+     * based on the atomicity of the operation. The intended use case is
+     * the ARM memory type field of each PTE, where access to pages with
+     * Device memory type require alignment.
+     */
+    if (unlikely(flags & TLB_CHECK_ALIGNED)) {
+        MemOp size = l->memop & MO_SIZE;
+
+        switch (l->memop & MO_ATOM_MASK) {
+        case MO_ATOM_NONE:
+            size = MO_8;
+            break;
+        case MO_ATOM_IFALIGN_PAIR:
+        case MO_ATOM_WITHIN16_PAIR:
+            size = size ? size - 1 : 0;
+            break;
+        default:
+            break;
+        }
+        if (addr & ((1 << size) - 1)) {
+            cpu_unaligned_access(env_cpu(env), addr, type, l->mmu_idx, ra);
+        }
+    }
+
     return crosspage;
 }
 
-- 
2.34.1


