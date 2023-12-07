Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DFB8085D8
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 11:55:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBC1i-0006Wq-4U; Thu, 07 Dec 2023 05:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBC1d-0006W2-Ms
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:54:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBC1c-00077E-0L
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:54:37 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-332c46d5988so780076f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 02:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701946474; x=1702551274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDpYvaGqiktp3pFhh53LjdujAGzRbMJnxoWS82qu+NI=;
 b=DwrIrN6tr1Bf6AOlgYX5ZmwfK3TGSRy9S33xQZ+Oh91XouiPPyY3pGSIcMfdn7tQ7D
 ZqAJArNV0rqd7oZkf1CX1dC/koF+i0Qf1yS1xQDjQ9Q5toCsBkmOjg6cdca0b1lmVN3X
 B09IfTpb7vIfNSNEF5rlXMTHuQReSyrvFhNizIVUSvR1eiLVQENoe3bDib2/JC9wMfQj
 j4qdseAS8l66+hKlh8L2qvns0Z3MJp+DRpbxi/eRZz7lDeo8bmddqklSaqTa8KlcaaMS
 N3ev0LeXvuPqLJlAqQFaL3Q5RamDehy6iEXHJ8LWoZP9+lxIzNq8po1eoxeDEpoh5ij6
 h7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701946474; x=1702551274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDpYvaGqiktp3pFhh53LjdujAGzRbMJnxoWS82qu+NI=;
 b=tpsOmdUoK0ie/h5zy5dWKSrNVDZ458UAOekAM/hNrdDN2x0svXM9SU4LDIvkD/lE0G
 46R0J/v7typJ0m1Q6ljm5e+8ORX4l9JvJVCLumNGbkKPowCmhoFFKy2DsqOPFcpeZExn
 wh3UMf3eXBGzj+5nKcz6Tjt2tdQxLEWMTmFURyT9BnQvWkC25Rci0zObnyvQp7CFXuol
 lbMAfYYoLIUfxlofcnXT/YI0tJDnru45J+Ey8Vg28fzCcmQGJcOgObYNpNVz68/eATwD
 hMFQoyGq5lC07kOWcUxpjMhLRzJ/OsjIdvB04xD7elIeYgYJ2WUcER8lTBgR7A7jDHzO
 LS0w==
X-Gm-Message-State: AOJu0YzyLe/jZ2YAfSN2giRLLq9SDiCxNj0t76CzsV9OowK3swwmoyUo
 M3e4nsjMFnnnZ/UGcf2mWz8OWCtpnZFPd/xBLTc=
X-Google-Smtp-Source: AGHT+IFhRmHwbUnwOtLZNw0woWZcETXcTnZOByVrU60hf/sg2TCOnmw+TKHKabBFpLB3Q01+WXPhBQ==
X-Received: by 2002:a5d:4b50:0:b0:333:49a8:73e7 with SMTP id
 w16-20020a5d4b50000000b0033349a873e7mr1483873wrs.89.1701946474272; 
 Thu, 07 Dec 2023 02:54:34 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d52c3000000b00333483b468dsm1136211wrv.88.2023.12.07.02.54.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 02:54:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/alpha: Extract clk_helper.c from sys_helper.c
Date: Thu,  7 Dec 2023 11:54:25 +0100
Message-ID: <20231207105426.49339-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231207105426.49339-1-philmd@linaro.org>
References: <20231207105426.49339-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Except helper_load_pcc(), all helpers from sys_helper.c
are system-emulation specific. In preparation of restricting
sys_helper.c to system emulation, extract helper_load_pcc()
to clk_helper.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/clk_helper.c | 32 ++++++++++++++++++++++++++++++++
 target/alpha/sys_helper.c | 15 ---------------
 target/alpha/meson.build  |  1 +
 3 files changed, 33 insertions(+), 15 deletions(-)
 create mode 100644 target/alpha/clk_helper.c

diff --git a/target/alpha/clk_helper.c b/target/alpha/clk_helper.c
new file mode 100644
index 0000000000..26ffc231cd
--- /dev/null
+++ b/target/alpha/clk_helper.c
@@ -0,0 +1,32 @@
+/*
+ *  QEMU Alpha clock helpers.
+ *
+ *  Copyright (c) 2007 Jocelyn Mayer
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "exec/helper-proto.h"
+#include "cpu.h"
+
+uint64_t helper_load_pcc(CPUAlphaState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    /*
+     * In system mode we have access to a decent high-resolution clock.
+     * In order to make OS-level time accounting work with the RPCC,
+     * present it with a well-timed clock fixed at 250MHz.
+     */
+    return (((uint64_t)env->pcc_ofs << 32)
+            | (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) >> 2));
+#else
+    /*
+     * In user-mode, QEMU_CLOCK_VIRTUAL doesn't exist.  Just pass through
+     * the host cpu clock ticks.  Also, don't bother taking PCC_OFS into
+     * account.
+     */
+    return (uint32_t)cpu_get_host_ticks();
+#endif
+}
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index c83c92dd4c..98d9a0fff7 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -27,21 +27,6 @@
 #include "qemu/timer.h"
 
 
-uint64_t helper_load_pcc(CPUAlphaState *env)
-{
-#ifndef CONFIG_USER_ONLY
-    /* In system mode we have access to a decent high-resolution clock.
-       In order to make OS-level time accounting work with the RPCC,
-       present it with a well-timed clock fixed at 250MHz.  */
-    return (((uint64_t)env->pcc_ofs << 32)
-            | (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) >> 2));
-#else
-    /* In user-mode, QEMU_CLOCK_VIRTUAL doesn't exist.  Just pass through the host cpu
-       clock ticks.  Also, don't bother taking PCC_OFS into account.  */
-    return (uint32_t)cpu_get_host_ticks();
-#endif
-}
-
 /* PALcode support special instructions */
 #ifndef CONFIG_USER_ONLY
 void helper_tbia(CPUAlphaState *env)
diff --git a/target/alpha/meson.build b/target/alpha/meson.build
index d3502dd823..ea252c99a5 100644
--- a/target/alpha/meson.build
+++ b/target/alpha/meson.build
@@ -4,6 +4,7 @@ alpha_ss.add(files(
   'fpu_helper.c',
   'gdbstub.c',
   'helper.c',
+  'clk_helper.c',
   'int_helper.c',
   'mem_helper.c',
   'sys_helper.c',
-- 
2.41.0


