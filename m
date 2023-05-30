Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82660716D22
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44ab-0001pr-Mk; Tue, 30 May 2023 15:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zh-0000pV-SX
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:07 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Ze-0000ua-AP
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:05 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d30ab1f89so3289506b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473201; x=1688065201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=alUoCrNxLlSLGgJuIyIfT1FvZkAeWBPMCr4vG57zR6w=;
 b=JusTvAAtF2NPddoLjBme6rsVpKAc8g6+WyWQaOWRZ1EGPq6B61+6yA/VF1xFZPc7S9
 BzW27NRLsUgCVh31jP15QrEE7Ctmfzprx+iKLX8godxEkDbyfX3+NvXLwiqgfYiwrzOf
 mmfYe/e+9ujazP0F75crzA5yo4TeKnuUlPxyMnyFFR2GJmtBHe1YA0SHWvHAfTMu1eb+
 KZZGyMRxAKHd1eYfSn3h8Kxe65hMAjY4Cjh9L6Ef0yRDDvgoRTAlZs4yQey0pHKUhXA2
 mFdz666al1sYDuFTgwVtQAaPGClpOrxo5yf36T98q/HPYlXvnQO6o/OICLkKrWv4M7x6
 qEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473201; x=1688065201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=alUoCrNxLlSLGgJuIyIfT1FvZkAeWBPMCr4vG57zR6w=;
 b=d6pefoF/CRfWtYioTrRRa4sLzDRg2r9KTsbsxRAuhIXuwpl1hfwR/2wmg6hiB1hJ5v
 MGoBvj0Qb7XETcXCiv5jEEPqePPcIcM3cceP19677LkSb9CBzwvF0wZr4Fu0igkVBGPR
 nXsd+3jujg/fFceP+EtiGlCiJMa+wsOJEz/TzPeCvXmY7C4xUVn3syodvl5hFIOtERbj
 8QW5sbOpMQODRHrK2BUz/oJRNmn2D7ZYwg/cW4nBEMvD59nYal1c0chI22aoR3cQyntM
 GLT2UTcb10lQz1kvLL8/VgCC+swU7SfmC1E+54Z2vd/Jee1DzI9DuzMTDXe2A2VVsMEM
 fRIw==
X-Gm-Message-State: AC+VfDxwzxOGBdRl5LGJNpk4eecUoWmqemmeEl9E0sxSl1taf0bPsBS1
 j6qt2Plo01CYohFWjwoAwuIgd9TGth8YsSiS/+M=
X-Google-Smtp-Source: ACHHUZ7QPVTz1VAbDC8bNiT+zNDCFWsrMkMqCP0oBa/ekzhKyd8JmAesFZZDBD6UFZ/Y1JRGKQxl3g==
X-Received: by 2002:a05:6a21:339a:b0:105:dafa:fec2 with SMTP id
 yy26-20020a056a21339a00b00105dafafec2mr3862395pzb.53.1685473200893; 
 Tue, 30 May 2023 12:00:00 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/27] accel/tcg: Extract load_atom_extract_al16_or_al8 to host
 header
Date: Tue, 30 May 2023 11:59:34 -0700
Message-Id: <20230530185949.410208-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 35ce6d6368..6063395e11 100644
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


