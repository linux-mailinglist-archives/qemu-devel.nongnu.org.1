Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2144180EC2E
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:40:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD20m-0004L5-BM; Tue, 12 Dec 2023 07:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1zn-0002ZO-AJ
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:19 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1zi-0000Fr-Tx
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:18 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-54f4f7d082cso5919294a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384573; x=1702989373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tD7bO+DUD+k+B6E3Kx/bmS2SAE12lsrmdjyahyo0DL0=;
 b=IwboWPP1Hz2yzRAXXXxXX+3IrreP6piNjisFppW5+ZsL1zZDCb0NCmgQpnmjdJf3yo
 ZJ9dAWhZGFFZwFRHuyKfPEit07n4k3+ZrQ+apQQvozvwyBdYChLAaD/yWbrmYuGoCeYV
 vv8fgc0GmsBZr98O2JqXaDfh05eOdSJO7mTpg5AZGZNFwsed1sKzmB5ps9HWTjO2NEfa
 p4LMlr1wSyueV4VCyDgrWuo5CpOq3R6tsus9NvNl+o1EVLpAQNiz2Ube2pd5+hmuzs8v
 1SmoRzRTRmu5PjME/fqWDbJqPShVw9xqK8umZRSvq+6qK2e3/V/2XdoJ28qrMilLhvVK
 pAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384573; x=1702989373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tD7bO+DUD+k+B6E3Kx/bmS2SAE12lsrmdjyahyo0DL0=;
 b=Vra4NKxJ2Eh4EVCCRYrM60E4/AqI+aT6VJhCFTRrAAnHQU9c88MCpOXp+lGrV3EOwD
 LNM9ajrtCCj0KPIWu0Qsol3jfLrQkALonOJfBm7HmkHIlChXPOYwQwdndU200zoghalI
 AWEMbwcmUvwsesnzIAy1Iw6+MewCnuPGqduM24BVA6KEtMbO9ebGyFerf8JSd5KwtF77
 0K/7/nnMs0ZgDVUUp6gJLJrLRBcHPAgWEqrIVw8y7HbnU/tEkZji2NLTRKTpjtAK0EXa
 Bxg342seQTnFvJYgOtZaFoCtY4e4QJfThVT/aIKcMNONCF/ubdG9y+Jm+CEX0k1YZVeo
 8Rng==
X-Gm-Message-State: AOJu0YyNlgQP+rel2TpqXuYCzmyKq/YBljohPwWmtKfO7mbwX2esKO5/
 AVZyzB51gZ3LPX8FfDzlCdpGmk8R/I/TeWUwq/iZGw==
X-Google-Smtp-Source: AGHT+IE/qHb9fNxUNnSXjqWADnF4Tee8OxeD9a0SVcwJqjMerPr0gBSFID/RTiz54qADX6SbJz9OHw==
X-Received: by 2002:a50:9f0d:0:b0:551:cb5d:da61 with SMTP id
 b13-20020a509f0d000000b00551cb5dda61mr164867edf.7.1702384573271; 
 Tue, 12 Dec 2023 04:36:13 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 cy25-20020a0564021c9900b00551cf39a97asm127284edb.56.2023.12.12.04.36.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:36:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Subject: [PATCH v2 18/23] accel/tcg: Un-inline retaddr helpers to
 'user-retaddr.h'
Date: Tue, 12 Dec 2023 13:33:54 +0100
Message-ID: <20231212123401.37493-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

set_helper_retaddr() is only used in accel/tcg/user-exec.c.

clear_helper_retaddr() is only used in accel/tcg/user-exec.c
and accel/tcg/user-exec.c.

No need to expose their definitions to all user-emulation
files including "exec/cpu_ldst.h", move them to a new
"user-retaddr.h" header (restricted to accel/tcg/).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-retaddr.h | 28 ++++++++++++++++++++++++++++
 include/exec/cpu_ldst.h  | 28 ++--------------------------
 accel/tcg/cpu-exec.c     |  3 +++
 accel/tcg/user-exec.c    |  1 +
 4 files changed, 34 insertions(+), 26 deletions(-)
 create mode 100644 accel/tcg/user-retaddr.h

diff --git a/accel/tcg/user-retaddr.h b/accel/tcg/user-retaddr.h
new file mode 100644
index 0000000000..e0f57e1994
--- /dev/null
+++ b/accel/tcg/user-retaddr.h
@@ -0,0 +1,28 @@
+#ifndef ACCEL_TCG_USER_RETADDR_H
+#define ACCEL_TCG_USER_RETADDR_H
+
+#include "qemu/atomic.h"
+
+extern __thread uintptr_t helper_retaddr;
+
+static inline void set_helper_retaddr(uintptr_t ra)
+{
+    helper_retaddr = ra;
+    /*
+     * Ensure that this write is visible to the SIGSEGV handler that
+     * may be invoked due to a subsequent invalid memory operation.
+     */
+    signal_barrier();
+}
+
+static inline void clear_helper_retaddr(void)
+{
+    /*
+     * Ensure that previous memory operations have succeeded before
+     * removing the data visible to the signal handler.
+     */
+    signal_barrier();
+    helper_retaddr = 0;
+}
+
+#endif
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 6061e33ac9..25e7239cc5 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -300,31 +300,7 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, abi_ptr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
 
-#if defined(CONFIG_USER_ONLY)
-
-extern __thread uintptr_t helper_retaddr;
-
-static inline void set_helper_retaddr(uintptr_t ra)
-{
-    helper_retaddr = ra;
-    /*
-     * Ensure that this write is visible to the SIGSEGV handler that
-     * may be invoked due to a subsequent invalid memory operation.
-     */
-    signal_barrier();
-}
-
-static inline void clear_helper_retaddr(void)
-{
-    /*
-     * Ensure that previous memory operations have succeeded before
-     * removing the data visible to the signal handler.
-     */
-    signal_barrier();
-    helper_retaddr = 0;
-}
-
-#else
+#if !defined(CONFIG_USER_ONLY)
 
 #include "tcg/oversized-guest.h"
 
@@ -376,7 +352,7 @@ static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
     return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
 }
 
-#endif /* defined(CONFIG_USER_ONLY) */
+#endif /* !defined(CONFIG_USER_ONLY) */
 
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c938eb96f8..e591992d0c 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -44,6 +44,9 @@
 #include "tb-context.h"
 #include "internal-common.h"
 #include "internal-target.h"
+#if defined(CONFIG_USER_ONLY)
+#include "user-retaddr.h"
+#endif
 
 /* -icount align implementation. */
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 68b252cb8e..2575f0842f 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -31,6 +31,7 @@
 #include "tcg/tcg-ldst.h"
 #include "internal-common.h"
 #include "internal-target.h"
+#include "user-retaddr.h"
 
 __thread uintptr_t helper_retaddr;
 
-- 
2.41.0


