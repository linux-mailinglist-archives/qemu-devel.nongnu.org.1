Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BD9711B23
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:27:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LFI-0002ca-WC; Thu, 25 May 2023 20:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFG-0002bD-3g
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFD-0002BT-7R
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d2f99c8c3so307139b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060625; x=1687652625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9zblclqYPHjXAc9J8dhxRq0a0SpKKfcw5wbjQnIz2w=;
 b=l6gyj/YhlNXXL4dL6FTfvAuvz9MScaOHX50l0Lk23OP1Vr7MLgUKgZugwRMek//kUx
 X0xvkJWzs/886npzuUhm11Xw7WQNjIEV/V1G3FwZEAG0rEwU0Hx+1WPXtDs8rkLSGeE1
 7+diKi9VUnobGUOgvzmuDFxxotuMcMV6jbnDVPeNoWtKDerqKyNznR/mvJh1irSG+7+n
 F3VNYGGUmXTWxP3rnnbtq0IA12v54BEZ8yzsthuWOUyfjXI5hp4naYrbKUGAqmfXUnP1
 5x2IbP+K+J/PPGleRmcwKof9ifpjAQobQ6QRiPiVU5Nm01fTPuiOndzRXJ0gMpv6bvV0
 PSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060625; x=1687652625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9zblclqYPHjXAc9J8dhxRq0a0SpKKfcw5wbjQnIz2w=;
 b=jjwYor0s1QsbeGD8boGChTcqHdY8Ujam8f8c0CYt5hHfOFnus7vvE6jOahGltY1Car
 hhWWJkK0vlvqIgOhKZkQcEooIvOIqPdIzEBPZzUWvUsJqrWVaXAZWejkz4m7HrGAG8sT
 UzlhOFSW7fJrPwkT6Uf998zAFPCJUhbmzMHF2QSiJrncRB8pd66XItmPDOYPksMFFEnT
 YNMgb41A0/7DOu7sIv4E2fyX+6gJJA77sgLlvus1LZmFLbnrGB1fsbIQovocZ6wx+sX8
 j0rkVg2u2e5c3bF40M0pzJbfchjBdYiCSR/y3LUpeinUaEQgvgEDIbsp+UKkU+figuVd
 9C1w==
X-Gm-Message-State: AC+VfDwX8OGViq+PK8Gm10lUag7qQ/4S/J64/5LUTLmow4kBVST//mA3
 K14uON45g18sDU2DEUjz+WzqQ36YzTAFVjEv2Pg=
X-Google-Smtp-Source: ACHHUZ7nb4glnEIQCR4r1sdokshWennfZ9/v4CqLWuJlb8nYBjtCd1NFDLTOUVonFQ426cSPzfH/rQ==
X-Received: by 2002:a05:6a20:3955:b0:10b:1c98:59b6 with SMTP id
 r21-20020a056a20395500b0010b1c9859b6mr20157pzg.14.1685060625475; 
 Thu, 25 May 2023 17:23:45 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 12/16] accel/tcg: Extract load_atom_extract_al16_or_al8 to
 host header
Date: Thu, 25 May 2023 17:23:30 -0700
Message-Id: <20230526002334.1760495-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526002334.1760495-1-richard.henderson@linaro.org>
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .../generic/host/load-extract-al16-al8.h      | 45 +++++++++++++++++++
 accel/tcg/ldst_atomicity.c.inc                | 36 +--------------
 2 files changed, 47 insertions(+), 34 deletions(-)
 create mode 100644 host/include/generic/host/load-extract-al16-al8.h

diff --git a/host/include/generic/host/load-extract-al16-al8.h b/host/include/generic/host/load-extract-al16-al8.h
new file mode 100644
index 0000000000..d95556130f
--- /dev/null
+++ b/host/include/generic/host/load-extract-al16-al8.h
@@ -0,0 +1,45 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Atomic extract 64 from 128-bit, generic version.
+ *
+ * Copyright (C) 2023 Linaro, Ltd.
+ */
+
+#ifndef HOST_LOAD_EXTRACT_AL16_AL8_H
+#define HOST_LOAD_EXTRACT_AL16_AL8_H
+
+/**
+ * load_atom_extract_al16_or_al8:
+ * @pv: host address
+ * @s: object size in bytes, @s <= 8.
+ *
+ * Load @s bytes from @pv, when pv % s != 0.  If [p, p+s-1] does not
+ * cross an 16-byte boundary then the access must be 16-byte atomic,
+ * otherwise the access must be 8-byte atomic.
+ */
+static inline uint64_t ATTRIBUTE_ATOMIC128_OPT
+load_atom_extract_al16_or_al8(void *pv, int s)
+{
+    uintptr_t pi = (uintptr_t)pv;
+    int o = pi & 7;
+    int shr = (HOST_BIG_ENDIAN ? 16 - s - o : o) * 8;
+    Int128 r;
+
+    pv = (void *)(pi & ~7);
+    if (pi & 8) {
+        uint64_t *p8 = __builtin_assume_aligned(pv, 16, 8);
+        uint64_t a = qatomic_read__nocheck(p8);
+        uint64_t b = qatomic_read__nocheck(p8 + 1);
+
+        if (HOST_BIG_ENDIAN) {
+            r = int128_make128(b, a);
+        } else {
+            r = int128_make128(a, b);
+        }
+    } else {
+        r = atomic16_read_ro(pv);
+    }
+    return int128_getlo(int128_urshift(r, shr));
+}
+
+#endif /* HOST_LOAD_EXTRACT_AL16_AL8_H */
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 57163f5ca2..39ad89800d 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -9,6 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+#include "host/load-extract-al16-al8.h"
+
 #ifdef CONFIG_ATOMIC64
 # define HAVE_al8          true
 #else
@@ -311,40 +313,6 @@ static uint64_t load_atom_extract_al16_or_exit(CPUArchState *env, uintptr_t ra,
     return int128_getlo(r);
 }
 
-/**
- * load_atom_extract_al16_or_al8:
- * @p: host address
- * @s: object size in bytes, @s <= 8.
- *
- * Load @s bytes from @p, when p % s != 0.  If [p, p+s-1] does not
- * cross an 16-byte boundary then the access must be 16-byte atomic,
- * otherwise the access must be 8-byte atomic.
- */
-static inline uint64_t ATTRIBUTE_ATOMIC128_OPT
-load_atom_extract_al16_or_al8(void *pv, int s)
-{
-    uintptr_t pi = (uintptr_t)pv;
-    int o = pi & 7;
-    int shr = (HOST_BIG_ENDIAN ? 16 - s - o : o) * 8;
-    Int128 r;
-
-    pv = (void *)(pi & ~7);
-    if (pi & 8) {
-        uint64_t *p8 = __builtin_assume_aligned(pv, 16, 8);
-        uint64_t a = qatomic_read__nocheck(p8);
-        uint64_t b = qatomic_read__nocheck(p8 + 1);
-
-        if (HOST_BIG_ENDIAN) {
-            r = int128_make128(b, a);
-        } else {
-            r = int128_make128(a, b);
-        }
-    } else {
-        r = atomic16_read_ro(pv);
-    }
-    return int128_getlo(int128_urshift(r, shr));
-}
-
 /**
  * load_atom_4_by_2:
  * @pv: host address
-- 
2.34.1


