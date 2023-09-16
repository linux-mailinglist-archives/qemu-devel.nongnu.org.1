Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C4B7A332B
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 00:03:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhdMW-0006Hs-Rz; Sat, 16 Sep 2023 18:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMU-0006Gm-QB
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:01:58 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMT-00047I-4X
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:01:58 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c3f97f2239so29854755ad.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694901715; x=1695506515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qK9dl2HMki8c/cc1ceaRkDQQeJ1Zz081BcJFrsyjAmw=;
 b=d/h9xQF5AR0NCZb6Kw5ekJZu7Nr0YkNg8lDdvOMMEhQlHp7O+x1V1XDyNOqJPwhBcB
 Fb9cEqR1Qsk6muS2+O5Hl9ZCR6OmmqsTU0l82gr386TOTVVpv9vL+sM0V18idtKt7b2V
 1wMFQlhzz6adghWv0R4EudE1dVrkLEdj2aKan+wuIQ0KFDeGP7kO/jD0x8BsnW05IwQF
 8hlnbm7JKUuL+VpsO+QiqhpiHSe+rP/iVxcycdD39rXX53Iy7i4N/5u5D8tKGPNEKeCm
 4w8OE8XuG8T8pRq6myomwRO7apONAqILrlOR0GOFZiK53w8gMo4z0tEyXqueRD3l2fSD
 4p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694901715; x=1695506515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qK9dl2HMki8c/cc1ceaRkDQQeJ1Zz081BcJFrsyjAmw=;
 b=SStZfpv61854CtFXRTcGSVI2zckaBcoEbZ8G2PU8IlYxguBYcXLmStF+BfeMAjBGpK
 VFizvOsHZDO05ZBmh0qWDPEjbAYKjkx2Ud2B1hqbdWq83RpTSV/aN39Yl+wj9tXYUZXZ
 ulDzNwq0bB/9eVK5WwAKnOEsI6lSZcNrdMfLMrjvhUsBTi/8JmOeTaeys2jurHUw4heR
 tmOr+z6C9Hliu7o42V12OWuR/+gEfuZAHW6b3AgXO9Z+knsntpvurfqGDnZHkvyl9Ig7
 1DapTeszkXioZFQDjvJLg7iU5Ypyt5mLdKI1Hpz4UteW7a+m/1VhvYue6woZQWncE0la
 AdbQ==
X-Gm-Message-State: AOJu0YzH3JiH4Ktr4YW+e5Q0/to4M1jntpvqeN9KmuerQc9A7BJ1zOtS
 UUTpH6H8ySgkTgpmVZqrwUIKpIKBoBz4N/p13T8=
X-Google-Smtp-Source: AGHT+IFsWNggMULZV+TAaYHwJC3SPxgWVynPa+zxGcQgP55Wm5tc9WJLBD+b46gkIYWHA4Kw+Lt3EQ==
X-Received: by 2002:a17:903:186:b0:1bd:aeb3:9504 with SMTP id
 z6-20020a170903018600b001bdaeb39504mr7095687plg.15.1694901715664; 
 Sat, 16 Sep 2023 15:01:55 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 q3-20020a170902788300b001b531e8a000sm5707763pll.157.2023.09.16.15.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 15:01:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name, c@jia.je, gaosong@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH 3/7] util: Add cpuinfo for loongarch64
Date: Sat, 16 Sep 2023 15:01:47 -0700
Message-Id: <20230916220151.526140-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916220151.526140-1-richard.henderson@linaro.org>
References: <20230916220151.526140-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/loongarch64/host/cpuinfo.h | 21 +++++++++++++++
 util/cpuinfo-loongarch.c                | 35 +++++++++++++++++++++++++
 util/meson.build                        |  2 ++
 3 files changed, 58 insertions(+)
 create mode 100644 host/include/loongarch64/host/cpuinfo.h
 create mode 100644 util/cpuinfo-loongarch.c

diff --git a/host/include/loongarch64/host/cpuinfo.h b/host/include/loongarch64/host/cpuinfo.h
new file mode 100644
index 0000000000..fab664a10b
--- /dev/null
+++ b/host/include/loongarch64/host/cpuinfo.h
@@ -0,0 +1,21 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Host specific cpu identification for LoongArch
+ */
+
+#ifndef HOST_CPUINFO_H
+#define HOST_CPUINFO_H
+
+#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
+#define CPUINFO_LSX             (1u << 1)
+
+/* Initialized with a constructor. */
+extern unsigned cpuinfo;
+
+/*
+ * We cannot rely on constructor ordering, so other constructors must
+ * use the function interface rather than the variable above.
+ */
+unsigned cpuinfo_init(void);
+
+#endif /* HOST_CPUINFO_H */
diff --git a/util/cpuinfo-loongarch.c b/util/cpuinfo-loongarch.c
new file mode 100644
index 0000000000..08b6d7460c
--- /dev/null
+++ b/util/cpuinfo-loongarch.c
@@ -0,0 +1,35 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Host specific cpu identification for LoongArch.
+ */
+
+#include "qemu/osdep.h"
+#include "host/cpuinfo.h"
+
+#ifdef CONFIG_GETAUXVAL
+# include <sys/auxv.h>
+#else
+# include "elf.h"
+#endif
+#include <asm/hwcap.h>
+
+unsigned cpuinfo;
+
+/* Called both as constructor and (possibly) via other constructors. */
+unsigned __attribute__((constructor)) cpuinfo_init(void)
+{
+    unsigned info = cpuinfo;
+    unsigned long hwcap;
+
+    if (info) {
+        return info;
+    }
+
+    hwcap = qemu_getauxval(AT_HWCAP);
+
+    info = CPUINFO_ALWAYS;
+    info |= (hwcap & HWCAP_LOONGARCH_LSX ? CPUINFO_LSX : 0);
+
+    cpuinfo = info;
+    return info;
+}
diff --git a/util/meson.build b/util/meson.build
index c4827fd70a..b136f02aa0 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -112,6 +112,8 @@ if cpu == 'aarch64'
   util_ss.add(files('cpuinfo-aarch64.c'))
 elif cpu in ['x86', 'x86_64']
   util_ss.add(files('cpuinfo-i386.c'))
+elif cpu == 'loongarch64'
+  util_ss.add(files('cpuinfo-loongarch.c'))
 elif cpu in ['ppc', 'ppc64']
   util_ss.add(files('cpuinfo-ppc.c'))
 endif
-- 
2.34.1


