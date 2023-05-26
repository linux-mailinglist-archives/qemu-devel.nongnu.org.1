Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 966C3711B20
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:27:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LFV-0002im-GB; Thu, 25 May 2023 20:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFT-0002gn-37
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:24:03 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFG-0002DI-GP
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:24:02 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso265041b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060629; x=1687652629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6NQFZiOtbz6npGqiyw8uq/rNuokDU9J11iDsc0p5sk=;
 b=NEk6PwrpN1tWfEBYxVopvFRF1iSf5H5UL3yV8vltA+oSrwiIfIcNoWKJf/aGJrB2eZ
 3i68wjSdFNpjBd93m4oxq9hN//7Q2H0Uu4CIJ8DRGlLMcA/okrI985niyK6JqR1cTVJg
 maX4aABJhCnnAMk0n9DNMkwb7arE7EXUrD4He+4kg+jmlA9PBkvrMyLynII85yiMizzU
 G4TZwnmlGEQxmEeh5w2mAb0d0prYUZ+JWT/EVhBBTWjaq+Nb1nWiOflRsarhNeP9rLWE
 C0D0gMFgI2OjJtK9aK/CsO+TCa4D95hChq9xywyX8/FpTnmXhUBpiovE43dItN8uv1zB
 3EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060629; x=1687652629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6NQFZiOtbz6npGqiyw8uq/rNuokDU9J11iDsc0p5sk=;
 b=dAfsAmk0GHYx9T+3+u5FHFbY0g84Vw9KX8YUA+cavYcX9OP5kaUw0g3niIiKcuTPRF
 PcAeSsGuKqGejwZ4l1xfSKZJX7tc8x51UUpaEG8YPnlIimLnBGFQPl+TZHTKE0DG5xCd
 TFpSk+yHjAvcBjwG5puV5fDMNHYQv+iQOZKGJS4tCjDzAJ8QyuEdP5+yxSaDO0lTYYqc
 GAukSAe8aUQzkb7roaEMs3XdRo3zz4kSdWsNJBEtLMruflRpVaNFudRGS7K/jCRpxO+Y
 pqwp1uALfEL1L3HPiyi1jkxTC0/Vo1ui7yzN68AHqYOaQFv2PeKqcsU22qvtN9tYOuMO
 7TLQ==
X-Gm-Message-State: AC+VfDxj5BGvBN7Hyd81RgiaeD/MDSDzu+vih9DIs1/f3Hf5NBJkM/s/
 a7rVUMZC36vNt4V8+FQp1ONDi7ZRDUzolIhVN1c=
X-Google-Smtp-Source: ACHHUZ7Ile414kasxPuMVlVTDt6ydInGvoFxA86BMglMS8DNL8mQh9xafaxVmFHQXqYAaJy0R2eIgQ==
X-Received: by 2002:aa7:8891:0:b0:63b:54e4:871b with SMTP id
 z17-20020aa78891000000b0063b54e4871bmr3705pfe.8.1685060628738; 
 Thu, 25 May 2023 17:23:48 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 16/16] accel/tcg: Add aarch64 store_atom_insert_al16
Date: Thu, 25 May 2023 17:23:34 -0700
Message-Id: <20230526002334.1760495-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526002334.1760495-1-richard.henderson@linaro.org>
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 host/include/aarch64/host/store-insert-al16.h | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 host/include/aarch64/host/store-insert-al16.h

diff --git a/host/include/aarch64/host/store-insert-al16.h b/host/include/aarch64/host/store-insert-al16.h
new file mode 100644
index 0000000000..1943155bc6
--- /dev/null
+++ b/host/include/aarch64/host/store-insert-al16.h
@@ -0,0 +1,47 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Atomic store insert into 128-bit, AArch64 version.
+ *
+ * Copyright (C) 2023 Linaro, Ltd.
+ */
+
+#ifndef AARCH64_STORE_INSERT_AL16_H
+#define AARCH64_STORE_INSERT_AL16_H
+
+/**
+ * store_atom_insert_al16:
+ * @p: host address
+ * @val: shifted value to store
+ * @msk: mask for value to store
+ *
+ * Atomically store @val to @p masked by @msk.
+ */
+static inline void ATTRIBUTE_ATOMIC128_OPT
+store_atom_insert_al16(Int128 *ps, Int128 val, Int128 msk)
+{
+    /*
+     * GCC only implements __sync* primitives for int128 on aarch64.
+     * We can do better without the barriers, and integrating the
+     * arithmetic into the load-exclusive/store-conditional pair.
+     */
+    uint64_t tl, th, vl, vh, ml, mh;
+    uint32_t fail;
+
+    qemu_build_assert(!HOST_BIG_ENDIAN);
+    vl = int128_getlo(val);
+    vh = int128_gethi(val);
+    ml = int128_getlo(msk);
+    mh = int128_gethi(msk);
+
+    asm("0: ldxp %[l], %[h], %[mem]\n\t"
+        "bic %[l], %[l], %[ml]\n\t"
+        "bic %[h], %[h], %[mh]\n\t"
+        "orr %[l], %[l], %[vl]\n\t"
+        "orr %[h], %[h], %[vh]\n\t"
+        "stxp %w[f], %[l], %[h], %[mem]\n\t"
+        "cbnz %w[f], 0b\n"
+        : [mem] "+Q"(*ps), [f] "=&r"(fail), [l] "=&r"(tl), [h] "=&r"(th)
+        : [vl] "r"(vl), [vh] "r"(vh), [ml] "r"(ml), [mh] "r"(mh));
+}
+
+#endif /* AARCH64_STORE_INSERT_AL16_H */
-- 
2.34.1


