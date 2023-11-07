Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C257E3331
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:49:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C99-0008El-Nq; Mon, 06 Nov 2023 21:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C94-0008A6-4G
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:50 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C92-0005pp-4o
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:49 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-45db0df090eso1104896137.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325327; x=1699930127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwItf/Y8t1sjJEnssrxfJSiyzynmgIaR+NwTubGqvjs=;
 b=NXUn0tS4cpAhzpI1GoMHoF6fkhe9K+pE3UkBJbm9YeIJnj8x9S/MPLFTWxdNjApV+y
 0BkKinstXabpUkBKW79dmEtq8AkZ3x5uvIr6vnpChZx9TB6hUcgyF7R/KMSYTWSIRai7
 t3U+Vgo5DNFZr6t1f76Stk3am8iVdIpW89euqUmALM2uk3EzMsDc7fIFhZV6K7Dziq+c
 /EL8y7cdFRa3M41iiMqokjrnTyUX+LQDsMPclddx4HN/QvtVgN7RG4H88uDIcw0nS5sb
 gL5UTaRP8VRtT7AAYoaPq2f42tH/XTEqxNRrnOQelwv8BgpUy5JRxWUXYWBdFMgePiDl
 amfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325327; x=1699930127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwItf/Y8t1sjJEnssrxfJSiyzynmgIaR+NwTubGqvjs=;
 b=RKAPTaD430fqWNvE1hgRP02yAVt5LHV13ArmvT7B6/aYBLp1i5VMW7tnSvSDsOxIGt
 2LG+LBCTTPnHDDjZxixRHpViVO1Em0nMStdtgCFGEqigs3xLZ7KY0wlMawE96F13wXzZ
 4SrCn5U4v1G9yuKIoB4CMwagfVBWVlooWWFuGFueae3eagP4auluztSO/5ZTFjDocy+W
 q+z6JyJeqnD10c/pqfxyfAFbWY2VeyxQV14m56ADro7OQgX6eCsICrrdKekpXKJ6Tg25
 iyFLXLIGlyVtmDk+mHoEZT4CChnLD+pmDBN6KOo1q+Zb+D9TbJufjyLo7DaYcOYDGHrd
 48WA==
X-Gm-Message-State: AOJu0YycEGAo+L8CnviVwg8lvgJ5Sqvp7j+6S0ZQQU3RTZTXdsxpcW23
 MO0Tgj1PVxsLuL7mNUJR2lT4Jh+LwTkLdhK1Mf8=
X-Google-Smtp-Source: AGHT+IG7YUg+KG1xhIBqzV7Y8F9C+3TmsL+Mw3A1fBqPRNe8IOvNhBrTndokISY17I3JZCkkRb6KSw==
X-Received: by 2002:a67:e0d7:0:b0:45d:aebd:7f49 with SMTP id
 m23-20020a67e0d7000000b0045daebd7f49mr6754232vsl.16.1699325327183; 
 Mon, 06 Nov 2023 18:48:47 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PATCH 04/35] util: Add cpuinfo for loongarch64
Date: Mon,  6 Nov 2023 18:48:11 -0800
Message-Id: <20231107024842.7650-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=richard.henderson@linaro.org; helo=mail-vs1-xe35.google.com
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
Reviewed-by: Jiajie Chen <c@jia.je>
Message-Id: <20230916220151.526140-4-richard.henderson@linaro.org>
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
index 769b24f2e0..1bfff81087 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -113,6 +113,8 @@ if cpu == 'aarch64'
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


