Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81841782E41
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:20:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cn-0001cQ-Lt; Mon, 21 Aug 2023 12:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cM-0001TR-PT
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cK-0005bZ-K9
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bda9207132so27361495ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634739; x=1693239539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/XAMC2SBnpNGK/nIW2dhBAzm2obzzeFfdL7+o9evNL4=;
 b=Uqd3pp3n4hUiSS5XL89jyxcWHBHr0ICdGqNFkeNQuu+Pz6RFanOeIg88XphotCcQc4
 8Rr25+UQAxqcNGhSYP0TxYQ/jivnI5itbbd8gLr5eboTJYa+XlIFpvOi++eWgEx9ZsMl
 Eds2VHnjqKNTlQfjw/kcJvbTdkXQX6BqE3Y3wGPJ47GNGe6wZRmYw4BtyDHhDdxID3hj
 IVM3ZkOqK10sZduxeDXWYkfBKwCAJspdup+fPbd4pnH1Il5j6fqYhm0kezQ42xGtWSl8
 FPTYEzTYptAw3L5VpaqF1lC3p90rFa1UpoOUlwZrh8Q9GUVsHuCcQhDojg8pHDNMk1NE
 Rigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634739; x=1693239539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/XAMC2SBnpNGK/nIW2dhBAzm2obzzeFfdL7+o9evNL4=;
 b=YyNAnvlxM0owG82/2bszfEnI9ryZwwm9YDYEAo03+OyGn94tTKcOSgbvkS2KjeXqiX
 MOsIwFTGwPV60tKy1fYUIsmxB0n+R3Cvh10nSLjSXyuhqGZ/NZAJYl+u7Tl9fCKDmVqk
 cYFk9EEg9JcMtEPXZf97IMIzlsU/kIEnqTW5xJz3BqezVBz0o+vVn8d4OwF6b4V4/WV9
 idGAfMD3EMLzC6tct6WBJ/HCxYQOBbfxGmPi/LkWD01kq3va2ROtYRykRkr2VSssOwgQ
 0Eohf9+YIIZYOuNjJix/hlNK0DbilJjzzxkwYaR7EJKAqNo1Wr5wFFjQ8AaX2BQvBHGj
 iL6w==
X-Gm-Message-State: AOJu0YzUBueam2R9S+PyctJQ2GnTmss1sY5dCA0FzIFzmRhoJw+CABto
 mhB9WZ823HgOx5uVvFUlEFxiHQ+wNetxw6mzIJ0=
X-Google-Smtp-Source: AGHT+IHHkGBg7rXhY9asme/iiSNzExrLamLp+B7LwgIUvmXoyjp5BBDKIwblXcbMglAnbIw8ju4m0Q==
X-Received: by 2002:a17:902:f684:b0:1bf:205e:fe5d with SMTP id
 l4-20020a170902f68400b001bf205efe5dmr9682581plg.7.1692634739368; 
 Mon, 21 Aug 2023 09:18:59 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:18:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v3 04/19] target/ppc: Use clmul_8* routines
Date: Mon, 21 Aug 2023 09:18:38 -0700
Message-Id: <20230821161854.419893-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


