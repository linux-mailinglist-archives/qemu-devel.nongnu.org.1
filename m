Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A79716D24
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44ac-0001tu-Um; Tue, 30 May 2023 15:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zk-0000q8-Ld
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:11 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zi-00016q-UT
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:08 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d4e45971bso3294998b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473204; x=1688065204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZ7BWve2ax9nNg/stTzdcYhTAHEn085N1840T2txWHs=;
 b=E5KuEvaQ3plOY63V5pmnLgr6d1PemD7n5C7TsgEMV4rtVJ5fc3sKPaG4mHwmM91mfv
 1oI0rkg6PTh7Re8/P6XlPIJ6+euEYaAAgCirfEK63hpEiWjxv7jh5VpwsmAV5xxQjLrB
 yT9Pz9c0LAn+Ova+o7HaBCnY1d/T3HaY4b35it53L5GgpsE6pxIRq/ajDyQn58S1eBRb
 /9tme2k6BgjP6m1CRMbNQ2W7ETF22P3+eV1IowTR3s761PM3C9DLVJnCa75CRSJzJX4c
 Z44v2DADd2CuPzlPWq9ZPleMk+L6zgSNqFSNsUolI5/OBNBQb10AB3VKV/M5v/xGVoSR
 hBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473204; x=1688065204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZ7BWve2ax9nNg/stTzdcYhTAHEn085N1840T2txWHs=;
 b=KJAlnTRdb9nrgPnUkVkoBa5lNcWx674CmU2TcA2k54X2AFSPLT6jJkG9DoDecsKQAK
 Yi+3oVWlgSZH5Myi4PHQbUkndgBLNgBzUJV+IKmXXoeZ11girc/1L5R4GKAzRDaSYtL6
 EcIBqqc+aCG0VoUcKJz4B6RE9tcIsuONVrajRJinsT95AjpV69S3YsB26/OUaYZW5IpY
 YN7B+AcUChZq+owEFP9EgMjroG+XutJXqwyKqG5iAqCtK0pQ1a4LiPsFjJrLUZUQr5p1
 Cvdd+QIVy9sfpxhY9Ss1qGd2ks1WqsDloAqmiJZ8xqrAI5ggFF7agytJo0x+wX2GEzR2
 AuHA==
X-Gm-Message-State: AC+VfDzBWJbu6biDWbn5KS5owU8oI9JmW2Z62/kwMAk1bXCcvtOCyvXS
 5P9LJy/TTbVzYJD/cDrCfHbZmeOqHZ+Qn3NHmSQ=
X-Google-Smtp-Source: ACHHUZ646a3xt0TTi582gkZvBq5ewieDAcEUhIkC6QJ9Qp+6mdO/qCK3S/Zd7SaSvLJ8CCKU4SK2VA==
X-Received: by 2002:a05:6a20:2698:b0:10c:663c:31c3 with SMTP id
 h24-20020a056a20269800b0010c663c31c3mr2861998pze.29.1685473204591; 
 Tue, 30 May 2023 12:00:04 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/27] accel/tcg: Add aarch64 store_atom_insert_al16
Date: Tue, 30 May 2023 11:59:38 -0700
Message-Id: <20230530185949.410208-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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


