Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 501B67A23CB
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:44:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBtw-0004Rn-Vx; Fri, 15 Sep 2023 12:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtv-0004Qq-1t
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:39 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtt-0004tN-Dc
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:38 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fdd6011f2so1946257b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796156; x=1695400956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lrofiEdqgOl3RcwS/CbqZ7l9hqJEkeBbwbYNYeWuQXE=;
 b=lGpy69nPnY5EoWwgYozfK5+UWIz9Uv4PFm4haZPNsMMa4Gcv5/igRGOTSHZ20hEnnT
 NgjL/JRyc9n7HRZvVDq8++Tj0hupX1WK2OF81JIeaEr1J1wR5mwvzIlLyCewQI5glnlZ
 oPZlZo6dBpxvPf9ax/OlWy4W5HlpkfMEW4GgkUBRuWp9OgIffGtOoARyAuOEDpeFV3Bl
 94hiAqBFI0gaEpD14CmEyqTvVwF0OqeFfqYM2kDm9asOXWV3NGtwBGXOVhR1UQm754ki
 MfCH1zIWohV52woEHKw2vWzV5kNn0Q5Atcnp4DfNFpaPJ2+A8iK75s5Vt4tmdYuXAQyv
 h5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796156; x=1695400956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lrofiEdqgOl3RcwS/CbqZ7l9hqJEkeBbwbYNYeWuQXE=;
 b=Fk+XyPMl1OylBQivnQ/CKJTAEAjB/VldYv8QTmS/K/6QYQDjG7HlXRzIoAOLg8h4hq
 IuOVBbkxa9tUb5F+bjBv7CZStJ/e+7QNjBCvndcybWa6p38XZcdBCm4PN5r7ZcH9Yv99
 c7Tv8X9b5vsDOFUiy1yR1aRJKKOKCpWmwz4IJO0IGFgTW7gkcoLEpKZXZeCjU8mFeIHc
 XrJ5/mrKmP86rBqlySzfWeM9rVs3EsoCzzKBgkEtUEP26VJaf/rpoY0T7fSdPuKaEFHK
 P89W1tvWNdGwIAIRp5t0u8KTAx0tb29cggtfLjkV5KddOCCzREuw/eviVmvqKLYGeiim
 2NbQ==
X-Gm-Message-State: AOJu0Ywi7lxGrZKiE8noefU7DCVMnJmg/TN807soy83x+Sog1Sa3/De+
 Sr/i4wRwiUQHEGlLtO6lzXXL4tQ00ERXmLJGVrI=
X-Google-Smtp-Source: AGHT+IHUNtQevYdMMGXxCIStrBDWJDfmlUXiEo1WcMOaJ5deo5pdD77J2QaeAgsoiIG9iEqrDLWBRg==
X-Received: by 2002:a05:6a00:23c4:b0:68e:29a6:e247 with SMTP id
 g4-20020a056a0023c400b0068e29a6e247mr2702662pfc.10.1694796156214; 
 Fri, 15 Sep 2023 09:42:36 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/19] target/ppc: Use clmul_8* routines
Date: Fri, 15 Sep 2023 09:42:16 -0700
Message-Id: <20230915164231.123580-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
index 96cdb3c7e3..f45b24d321 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -25,6 +25,7 @@
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
 #include "crypto/aes-round.h"
+#include "crypto/clmul.h"
 #include "fpu/softfloat.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
@@ -1424,6 +1425,18 @@ void helper_vbpermq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
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
@@ -1444,7 +1457,6 @@ void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
     }                                                         \
 }
 
-PMSUM(vpmsumb, u8, u16, uint16_t)
 PMSUM(vpmsumh, u16, u32, uint32_t)
 PMSUM(vpmsumw, u32, u64, uint64_t)
 
-- 
2.34.1


