Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A9C80DCDA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:23:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnje-0004ZK-5u; Mon, 11 Dec 2023 16:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnjc-0004X9-UN
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:40 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnjZ-0005mK-QX
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:40 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a1f37fd4b53so595629866b.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329755; x=1702934555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDPDUy3GuLtVTYcoiToi/C6HdVw4jRlY7C7+srVSuzU=;
 b=dpuAsGXvnnpxQpMw7WvT50Ctj21yUJ3N/oov6728zSWv/8YwkMN6nG48iQ3HfV/wAS
 9nnzUa1Cjp/6X5ZJOYiPqwnAUWlmwPU9iwSaiqqT3PNdO057Clfln7D0noHPfhqj0lFm
 L4IkRUlwLtt+puU5Qt8hl2dKhZP2qNYVWsM0S9aXORB9vJs2b0y4jvUGElCok3oSPSs7
 xR4WZ3RAx/i7gNfFtebGUJ+y5xCYa+Dp3+mmIPvxUtJ10J29qMh8g5pc2RVmKlbBXnNd
 RxVaJVBCKN2p8txxIoAASQ7JPJrTX+f33VMzRWUrCbKh4FnZZluB0kqXBL0l/leqQkgp
 PTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329755; x=1702934555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDPDUy3GuLtVTYcoiToi/C6HdVw4jRlY7C7+srVSuzU=;
 b=eEkUklBSEnIhqcUjMG01WHCzwy6Vz/MjResYomYzgyqsutjtZExr72Na2iMllxvgzC
 u+tAjnpRfq4nniJuXr1/a/h405tGRulCqy5n+5qMKt0IeI5+dYxZU+tYLwOK+mEqLFyr
 31CiQjlj3bb5SCWzFWegg2nSdsDx9ST1w1OB7I/PMW7/a9aUl1l1CDPNxrFsfCLZ+piN
 kQCw1MM6bQkdnl4j66oOr6O/Qk2Ch2nLnCpOMEU/cfOYM6wK6rt+Y8oX3g/Tnvn8dmxA
 JbUirxf1QAGMbiG0MomPcxifRp7Y1kdmhmzt4vBx1vT0UsBG6aDElVKS1xFxkrd0Fjy9
 RDUQ==
X-Gm-Message-State: AOJu0Ywsv/viukSNQ5CMfTMfc5LtWz3o4OznvKV0SL7BDaGPLvymymzM
 DIqvdhdUIXZv+wQ4I5+ylQv9rjUf6aPQ18Askwo7hA==
X-Google-Smtp-Source: AGHT+IGWTrFnrdu+BIym/Y7KGDpWmg+mrD8Ku5OoCmfyERaJKGIfeqHgX1KlQsVawhZpFZcq4s245A==
X-Received: by 2002:a17:907:c981:b0:a1b:6ed7:a44f with SMTP id
 uj1-20020a170907c98100b00a1b6ed7a44fmr2023369ejc.137.1702329755619; 
 Mon, 11 Dec 2023 13:22:35 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 tk7-20020a170907c28700b00a1d1ebc2206sm5334509ejc.72.2023.12.11.13.22.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:22:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Claudio Fontana <cfontana@suse.de>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Subject: [PATCH 18/24] accel/tcg: Un-inline retaddr helpers to 'user-retaddr.h'
Date: Mon, 11 Dec 2023 22:19:55 +0100
Message-ID: <20231211212003.21686-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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


