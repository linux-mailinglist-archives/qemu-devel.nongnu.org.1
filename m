Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 739AD716D21
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44Zz-0000uj-Cz; Tue, 30 May 2023 15:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zl-0000q9-2f
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:11 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zi-00013f-Ug
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:08 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d1e96c082so3547613b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473204; x=1688065204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/El1igOUyUSoG0S+vLLpz9bS25VlyGmh7TLbBsNw2Xc=;
 b=chht9N1XbPQPblAbNhG/IwmPPMBQQKvKDZhFMOLGqnmR+zroer5ARizWudfG3AuyCK
 PnlY0UpAks5cLT1tVJL7F46x9kL28aNrmC+vRumuLUg4IZ0ry7YzIa10HXYK1iyNWemv
 kZggcKOIygZ4FlWijujSuA6m/t3DEqZMuHFrj6kP1Gi3ZM9m78nFFX1+zo4PE5E2Rybc
 lP7wNjxeys1G8Oox50L3THzCNH+9IMli9w0iGtvAiK2vrdpSuZBCrFw3QksnVOjWPl6w
 v4kKYSL4Scn9V9lQd0O1N4GGytZMBQNSjCvvKNggYVmEkKmBc+JscHRUsbWkvcxmxfGN
 Y9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473204; x=1688065204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/El1igOUyUSoG0S+vLLpz9bS25VlyGmh7TLbBsNw2Xc=;
 b=GHL7a//KifbHrUrhNaXBPeXtayhWSxssNzFHTRfgwfBOLBY/8AOhDFnx9Q80f23TS4
 1KL8IsidvkBoYNMdRUhL3ypFPYSH0a4ACymNlYZhc38qKIXTw1XMXTneTGbZmTYBIfqc
 uqfkTk/MTjDGjEF7SdqoJq4OS/ItiTQia2haUhJNzG1gBtwry0rN1dNO7FUI9BtuSUTp
 GWTi+Fpn0x9+KsbXx45p42pFcw2LXIUDi7hoH7b4KDuIPhSlBkq8IdgXx3SgpZ2KxWJZ
 +E5ruDSgpeuwGBR2EXbaUpappQw9HnYMNUBkfcyCpzkfqR/WF9jXzanZs+G+08PaXFpN
 Dy+Q==
X-Gm-Message-State: AC+VfDxrpHhJ7rXArLA9HAtyAvB8cMrfrt1p/z1bZRh1MgTPM0WSFKHp
 SmaKoi8hLasRBxVnPdOadUn7qCa4bft2/5zdIlY=
X-Google-Smtp-Source: ACHHUZ6/Uzz96MThTwROgSM96Ij4saxGpEbgDza/9KKIiQ9WSdX2kGhDU3rD8ECMvnUN3XnHJgZvZA==
X-Received: by 2002:a05:6a20:4325:b0:10a:e73d:2572 with SMTP id
 h37-20020a056a20432500b0010ae73d2572mr4349769pzk.3.1685473203766; 
 Tue, 30 May 2023 12:00:03 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/27] accel/tcg: Add aarch64 lse2 load_atom_extract_al16_or_al8
Date: Tue, 30 May 2023 11:59:37 -0700
Message-Id: <20230530185949.410208-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


