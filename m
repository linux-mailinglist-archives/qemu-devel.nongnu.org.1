Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7A3711B21
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:27:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LFO-0002fC-MH; Thu, 25 May 2023 20:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFN-0002ed-MT
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:57 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFF-0002Cl-31
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:57 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d18d772bdso438518b3a.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060628; x=1687652628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PelXVvmbJtXORMvHTpXHymW8juD44eXP1zIzDNEopo=;
 b=TQY8ejxP1hQn2OBtZ9M8n2clES6hnmTmDM+Po+iGq/3X7lHnhOkwIvdpFefgKIaokP
 RhWHHgDtPcuNa9gggpTFRjmpqSrV/zaat++QNHWlY+UhKeBQFDZEiFlRiSnn+wIf8UrW
 PZ8z32ALQg6Pxr079xIjgGMprbZxcNc+eOKZ0tjpcV0BiBw1fDNJv6RyQX6tZxsAT+2W
 fLeXTyhZHuMnoGaLcn0RA+q8UzwXsVoAAQEq7bnuJNf4Cg1LoRL+sO+sOwvZvpxrjk0E
 S4QKkcXZKxomrdF3ixxh2/r/Luv9P91JbJmZ8TEKr6d+7i4L1ElpbE5VdCVhorLvQd83
 lC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060628; x=1687652628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PelXVvmbJtXORMvHTpXHymW8juD44eXP1zIzDNEopo=;
 b=eoQXXQOTXjK0MZaG6Kln/VM/eO1wQ69vH80TFLs0fmJyLHyDgWFEIry7u1gvoIMOAY
 4eys2CJEHpqb/cdGy9IHMDTDQ1VgLQJqBehTAN93eTB7Ji+Tsri0v15nQf3FEggmbMBW
 YDVc5gF8mfaA6n/7OcpdcZQ9iOrdsEcEZM2mheuZA2ewYALzqycZYbbzy9tevswUIl0I
 cLL+sGGz33HC8P8vqWord9t7hHCN+0f8hYyeGbOc8LjMSb0N87V8jI3G8YyAe/DvdQju
 By1Sp377zncdi+eETSBgCfq+7WuNIdVgbpgCq44qBwW9QVfBm/pEjbahd1MSyGMSj9dY
 rD+g==
X-Gm-Message-State: AC+VfDyHSfydmehq0bUyjvmN2nTuBij5Qs8D1SxsK3vrjt/P4OPItP1N
 7d4WdSMAelVdcuEIHyJNzyBNsj9y2V5Tqxh/U+g=
X-Google-Smtp-Source: ACHHUZ6Knx2hAO58N+KPD6XiC1bZQwS28vzGQUpljvRXj4CgTJh2L3XbRgx3KvZHvZlmBffV1PExMw==
X-Received: by 2002:a05:6a21:796:b0:10d:b160:3d4f with SMTP id
 mg22-20020a056a21079600b0010db1603d4fmr6246334pzb.38.1685060627890; 
 Thu, 25 May 2023 17:23:47 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 15/16] accel/tcg: Add aarch64 lse2
 load_atom_extract_al16_or_al8
Date: Thu, 25 May 2023 17:23:33 -0700
Message-Id: <20230526002334.1760495-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526002334.1760495-1-richard.henderson@linaro.org>
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 .../aarch64/host/load-extract-al16-al8.h      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 host/include/aarch64/host/load-extract-al16-al8.h

diff --git a/host/include/aarch64/host/load-extract-al16-al8.h b/host/include/aarch64/host/load-extract-al16-al8.h
new file mode 100644
index 0000000000..bd677c5e26
--- /dev/null
+++ b/host/include/aarch64/host/load-extract-al16-al8.h
@@ -0,0 +1,40 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Atomic extract 64 from 128-bit, AArch64 version.
+ *
+ * Copyright (C) 2023 Linaro, Ltd.
+ */
+
+#ifndef AARCH64_LOAD_EXTRACT_AL16_AL8_H
+#define AARCH64_LOAD_EXTRACT_AL16_AL8_H
+
+#include "host/cpuinfo.h"
+#include "tcg/debug-assert.h"
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
+static inline uint64_t load_atom_extract_al16_or_al8(void *pv, int s)
+{
+    uintptr_t pi = (uintptr_t)pv;
+    __int128_t *ptr_align = (__int128_t *)(pi & ~7);
+    int shr = (pi & 7) * 8;
+    uint64_t l, h;
+
+    /*
+     * With FEAT_LSE2, LDP is single-copy atomic if 16-byte aligned
+     * and single-copy atomic on the parts if 8-byte aligned.
+     * All we need do is align the pointer mod 8.
+     */
+    tcg_debug_assert(HAVE_ATOMIC128_RO);
+    asm("ldp %0, %1, %2" : "=r"(l), "=r"(h) : "m"(*ptr_align));
+    return (l >> shr) | (h << (-shr & 63));
+}
+
+#endif /* AARCH64_LOAD_EXTRACT_AL16_AL8_H */
-- 
2.34.1


