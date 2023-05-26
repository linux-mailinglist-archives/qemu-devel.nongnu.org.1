Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D6711B13
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:25:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LFP-0002fK-Bh; Thu, 25 May 2023 20:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFM-0002eR-MB
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:56 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFE-0002CS-Gc
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:56 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2536b4b3398so315002a91.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060627; x=1687652627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XL2uu5kH3GvTJsMYlChrH/3oNrEnlWs1pl5X+z8kRGk=;
 b=Nfk2pJnNbjuYbseWwBUWPpugThBH36gR4ctAJlp11ueEmMHNcUAsgTGklugEY6eojO
 DrTn/k5Y5zLq/UCToC6dlJYbzdFFYrz0RyQhE+74oJZaDjKlyMxhucBgIbrHbI4snSEj
 mU5sqI+JkOsIpurQRr02B5u1wp46Ael3uVgnGEerx9gzWcIeqHsPyjjfnE5WrFOiigel
 bMhFF3UP1PKigtHvSmh5iJRVYhAa2IZ1AdFd9XDDs54LEF+eoGI/ueY6WxWzriS1aYuw
 yHF5zPgDbCHon5C4aMmmpYNkQBQzEcREmJKma+sN2/ihJqIsB87y3kyJ3ktj3eq1uUfk
 i6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060627; x=1687652627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XL2uu5kH3GvTJsMYlChrH/3oNrEnlWs1pl5X+z8kRGk=;
 b=WudDQ7zCcT2SKgVpsx0QJefHG2z4QfhjnmBc+VJItjg63dUOmulb6OKUxXzkrrX92t
 LCDZ13NVDR98UC3wQEM7/QivI91Dtyn1rQccCvzWY/gaPSvK08Cy203Q0NxFVRNa975u
 RjLwCB3D8AXl1qC1u4qrQ4wz/LOwTkNGrFLzjRQ9GWJ1PPNy79Xh2madpPEW8EO66yUf
 XjLmE6h50jn5jqlXsax1Igrfqi/HKfzNjQcx4nEVR4dZz+yZCjpba8VUF1JR0SO789XP
 CQrD/tqvMr13nirH+aSzUzZ5wjmTfuPXrGFwvfSHfydwWDJUCRaQT2Ijbzoq7+AaapLO
 Lf4Q==
X-Gm-Message-State: AC+VfDzVm/J4WrJAt7p8tU4CRL/y54xbTGvYO4kkcfW3kwbCAgl/sm7W
 BaIwRCzPn9fvCKfORNMDariLHiZnmIchzlC4tKA=
X-Google-Smtp-Source: ACHHUZ5om2WyH8YWRwFaxW5iiSlaroOt+n/LENu88gzd9ORnq7SeQ6Pg2APUJ6S5e8jq3JuxVSscDg==
X-Received: by 2002:a17:90a:73ce:b0:256:6b6:baa1 with SMTP id
 n14-20020a17090a73ce00b0025606b6baa1mr542634pjk.10.1685060627106; 
 Thu, 25 May 2023 17:23:47 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 14/16] accel/tcg: Add x86_64 load_atom_extract_al16_or_al8
Date: Thu, 25 May 2023 17:23:32 -0700
Message-Id: <20230526002334.1760495-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526002334.1760495-1-richard.henderson@linaro.org>
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .../x86_64/host/load-extract-al16-al8.h       | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 host/include/x86_64/host/load-extract-al16-al8.h

diff --git a/host/include/x86_64/host/load-extract-al16-al8.h b/host/include/x86_64/host/load-extract-al16-al8.h
new file mode 100644
index 0000000000..31b6fe8c45
--- /dev/null
+++ b/host/include/x86_64/host/load-extract-al16-al8.h
@@ -0,0 +1,50 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Atomic extract 64 from 128-bit, x86_64 version.
+ *
+ * Copyright (C) 2023 Linaro, Ltd.
+ */
+
+#ifndef X86_64_LOAD_EXTRACT_AL16_AL8_H
+#define X86_64_LOAD_EXTRACT_AL16_AL8_H
+
+#ifdef CONFIG_INT128_TYPE
+#include "host/cpuinfo.h"
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
+    __int128_t *ptr_align = (__int128_t *)(pi & ~7);
+    int shr = (pi & 7) * 8;
+    Int128Alias r;
+
+    /*
+     * ptr_align % 16 is now only 0 or 8.
+     * If the host supports atomic loads with VMOVDQU, then always use that,
+     * making the branch highly predictable.  Otherwise we must use VMOVDQA
+     * when ptr_align % 16 == 0 for 16-byte atomicity.
+     */
+    if ((cpuinfo & CPUINFO_ATOMIC_VMOVDQU) || (pi & 8)) {
+        asm("vmovdqu %1, %0" : "=x" (r.i) : "m" (*ptr_align));
+    } else {
+        asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
+    }
+    return int128_getlo(int128_urshift(r.s, shr));
+}
+#else
+/* Fallback definition that must be optimized away, or error.  */
+uint64_t QEMU_ERROR("unsupported atomic")
+    load_atom_extract_al16_or_al8(void *pv, int s);
+#endif
+
+#endif /* X86_64_LOAD_EXTRACT_AL16_AL8_H */
-- 
2.34.1


