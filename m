Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E885781633
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMI-0008QR-JK; Fri, 18 Aug 2023 21:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMG-0008Py-HR
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAME-0007LA-3i
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:28 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf092a16c9so12716825ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406944; x=1693011744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/XAMC2SBnpNGK/nIW2dhBAzm2obzzeFfdL7+o9evNL4=;
 b=ebjYenVL0k7sB74DGZWzH/tol1yehlK3e+XLJ+Kr4Ax2TE5Cu5QpgjJ9ygo5ZHp6Vy
 azAPtQ0vNSVUPk1/i+wHRADaN+e6/D5nTWJ62K5oDwzdC1hxk+nw9dSXwVhfbxhAIlXY
 zRJJPBtX2J02LJwHlV1necNQCZdAgdYpQp3YrGK6qOeZFAhdQXk1KJ4tJX/JUeJ5VtzD
 iiFY3XddkrnS8LF4TCZCTnv8auqRP6UxEHew23SjfEtKs1KFNEBRAGJQYBhHTNOe6Kkj
 VIUH9PWU1MCM+b7PNfgg7YomawTYxOnL74qJMNsY3/8BKSy3WWgkI+5BAuAgKuJkTbi5
 4Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406944; x=1693011744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/XAMC2SBnpNGK/nIW2dhBAzm2obzzeFfdL7+o9evNL4=;
 b=Gs7OHK+tfZH3F5JshyiPh2nI90ru2NVR+u0MOBcIg6NQVlw4cL9oe6lnR6KQLXefkJ
 bAYpN2weIY4P9kJyhnfwXu49CLy1JCrsr7BHKFuBj+hjNwQh3XSgSkZ5yUKaXCVjQr+G
 hhhk5yrPzA7XjBSvwrQLArvikrKWQeQsVcdz7vPUcajChlkj9Nb8kHzpYlrJzqa6YGDf
 IGG9tP9ll/rh1RoDHekDtyBAh6pzhCr7KvQqe2L04zKKX2+PLU81xIBpIgJEOHFPP5wb
 wzMjpQupgA7CJ6sUg5VOAczuljlDUS9hHGZLrB+ivhC/+DrABmeILtA6tDT4VGCoDDTK
 /ecg==
X-Gm-Message-State: AOJu0YyacT2HmGV9ownmCfoeGr3uHneg8Ag03bH8BAQ0Rbf1smhUhGpp
 54xoRhPmeZJrgMwp4GcinC48Xnx0TEKRBJ38U/U=
X-Google-Smtp-Source: AGHT+IErSEKwHcbZcjwGwccfypLvlHJavs4pnnUg6Wf/fQetRy0j5EzNiqNQNTLKckTb/r5ibOUtgg==
X-Received: by 2002:a17:903:2290:b0:1b8:83a3:7db6 with SMTP id
 b16-20020a170903229000b001b883a37db6mr980824plh.44.1692406944099; 
 Fri, 18 Aug 2023 18:02:24 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 04/18] target/ppc: Use clmul_8* routines
Date: Fri, 18 Aug 2023 18:02:04 -0700
Message-Id: <20230819010218.192706-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Use generic routines for 8-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 834da80fe3..343874863a 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -26,6 +26,7 @@
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
 #include "crypto/aes-round.h"
+#include "crypto/clmul.h"
 #include "fpu/softfloat.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
@@ -1425,6 +1426,18 @@ void helper_vbpermq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 #undef VBPERMQ_INDEX
 #undef VBPERMQ_DW
 
+/*
+ * There is no carry across the two doublewords, so their order does
+ * not matter.  Nor is there partial overlap between registers.
+ */
+void helper_vpmsumb(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+{
+    for (int i = 0; i < 2; ++i) {
+        uint64_t aa = a->u64[i], bb = b->u64[i];
+        r->u64[i] = clmul_8x4_even(aa, bb) ^ clmul_8x4_odd(aa, bb);
+    }
+}
+
 #define PMSUM(name, srcfld, trgfld, trgtyp)                   \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
 {                                                             \
@@ -1445,7 +1458,6 @@ void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
     }                                                         \
 }
 
-PMSUM(vpmsumb, u8, u16, uint16_t)
 PMSUM(vpmsumh, u16, u32, uint32_t)
 PMSUM(vpmsumw, u32, u64, uint64_t)
 
-- 
2.34.1


