Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BAD716D25
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44a0-0000ut-1c; Tue, 30 May 2023 15:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zj-0000pw-HS
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:11 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zh-0000sl-QQ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:07 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d5b4c400fso5417090b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473203; x=1688065203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyUdvq2txp3LfbtBsPCYA96cHuzMiBnuxS7LlEw8L4A=;
 b=uqFjunW9OFf7U88IwZYG8zxebXq+sjVUcQ12wAl2hTaHxbUwwQ3mxQLPtSnWvADBl0
 KSqkiixwAYzLMnzl7gm73vk8VQBZ8/7culG/e4SA1JaLWHLFDsfCtZVRz74T/c2LOT08
 ebuHg+Fm3fGEMYYqnKw8Qa/A7UnstarU4r2ieHx6+semlpwQ7fyl+v7wE9Coy1onYZxC
 35YgSE3hxd8jB7AnA4mdLfR4LTrw/ZGV/354Uv1qbnEYE3Jo6CXe+rCgcQ5q5ey5XSy1
 moM3jlHia9ZX4KoEKllR/dJYWH89j0EQhNbi/L8RwyOEVaI7I4QxzPe+Kybylj8IGjZC
 N24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473203; x=1688065203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qyUdvq2txp3LfbtBsPCYA96cHuzMiBnuxS7LlEw8L4A=;
 b=E3vPDv1Dq7lh1wD3gIol2zkwC38NsYU7BEjh7FLGmsBiOlvPUioHHHN7I3/IdEVUN4
 hUCK8jxDlv6L5TVwn2H3LlRLkmlBysDYy1TOGFynjR7CqbbWefyeddTOpgqm28vWzwsH
 UQFblO/TOAKlIi2Aev3lHZ2QX7IiNJ0kPf479r6qStFgt2Gklsa0cRQrApJZnF4JRYoN
 VjCV+m3OXrlHm/s427V6S27NM8ctX4Cn13Ua9eQy/9M3KzWrEAQZ6lH4M0yOPSe+7kTG
 vOhGTix0+qn92Y0dwIRDDdy8xEEe2k+Nw67xwL0mKKWybhWFINnOHPDu6XDm77WT5Hgu
 wPTg==
X-Gm-Message-State: AC+VfDzHprNcYMpH+6EO/Iv9A5mPnCZSKvd49FXwtDIjMEcp/VoVIGZ5
 Vp6R3d9/As12XFTnNnRt7zP4EtF1U285S/EujNw=
X-Google-Smtp-Source: ACHHUZ5v+JqG9GBAjbFXTZSno8QAu+PTgwBOltdkDqMZzsF6oQgaa5cju5kfDlijtXxw66WnOjidKQ==
X-Received: by 2002:a05:6a21:998c:b0:10c:37ed:3e88 with SMTP id
 ve12-20020a056a21998c00b0010c37ed3e88mr3538235pzb.23.1685473202907; 
 Tue, 30 May 2023 12:00:02 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/27] accel/tcg: Add x86_64 load_atom_extract_al16_or_al8
Date: Tue, 30 May 2023 11:59:36 -0700
Message-Id: <20230530185949.410208-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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


