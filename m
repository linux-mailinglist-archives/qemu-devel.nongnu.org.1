Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FF980EC20
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:39:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD216-0005xM-BP; Tue, 12 Dec 2023 07:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD209-0003eP-MV
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:43 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD206-0000ng-Es
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:41 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a1f0616a15bso632105166b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384588; x=1702989388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XcUJPYPixvkbPwyuTaViLgu23Dq6vUSgutR3BpOkySY=;
 b=M6xa4qnd72QYOjEV61s1iEtUaKTqEHv9R5VNifMFNTPH3G6QaUzz6WiR8JMnGH5wwx
 YU0Qkz9ESIrTNwU4W1Q1ABGWipBxskNscQvKo+JgkRNG5e2X+JC7NuoZjb0b7REwQCyf
 olND/OZZGytwA/phQpbCURL6FbcJSBLTQWES1SUaO7zK4j1xEHl2qn1g8wUMEUVCW+fI
 pYlYWBTfnT7v33Z6/pktjgb7NYfMuoASuRiZVdeb8d5FBXnD5HDDG4rbq42bQ6Sjdf2p
 sGedqGobOEA+/Xbgrzh72yf7vD0wZAVuxhp1VRMBIM+nTn2ckXrXd/9aJRdmqv0guPmb
 DGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384588; x=1702989388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XcUJPYPixvkbPwyuTaViLgu23Dq6vUSgutR3BpOkySY=;
 b=hRD9C0I9Z3r+owZp4vv+HUfQKsKF7TLy8pkqXk+Sqi+5UIf6ofWeI7vX12W1+z+cMo
 6pRV/08xUhjwTZQv2Hxavg3ywxtB/+r3WVtmL5yLWv4MrFFrW1bpH3wVoV+r1/xL+hhd
 X5yyfQcM+Xo1VJ9rcpaN+PPA3rCSy+Jz7L252HG6Kwolz9dB/ZgUf6bOykN+7Pl3T/3h
 0Y99Sx3BKnMxc7ke9f/hPSPQa986Zv/9DcaCaKHZoLjX7jh5UgP1qlPW3jN8m3KZ/u3u
 AuOz9nBuxgaagxAkc73BLje8GWtaE8UMA7lEnJSNx9jQrIltQKxlSc3Yr0fH90slrFON
 5RGA==
X-Gm-Message-State: AOJu0Yz2wmeFNEpVv2oFVPrqwK8ZusWLn2+ML1WPsUgqpEskPsZxg2K1
 KdrpYj7+wGzZbZ6d/Y4asgWq61IfNIFLmB1H6MVd4Q==
X-Google-Smtp-Source: AGHT+IGi/ndeDCRsbzkeIyI2icMnKHZUcY+4/u1N6lfUPc61wGzcvq/Uq1c9+DdTK2NLoK55oG6rdw==
X-Received: by 2002:a17:907:20e9:b0:a19:a19b:78c5 with SMTP id
 rh9-20020a17090720e900b00a19a19b78c5mr3381195ejb.136.1702384587924; 
 Tue, 12 Dec 2023 04:36:27 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 um7-20020a170907cb0700b00a1d8ba21d72sm6180806ejc.201.2023.12.12.04.36.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:36:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 20/23] exec: Declare abi_ptr type in its own 'abi_ptr.h'
 header
Date: Tue, 12 Dec 2023 13:33:56 +0100
Message-ID: <20231212123401.37493-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

The abi_ptr type is declared in "exec/cpu_ldst.h" with all
the load/store helpers. Some source files requiring abi_ptr
type don't need the load/store helpers. In order to simplify,
create a new "exec/abi_ptr.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/abi_ptr.h    | 33 +++++++++++++++++++++++++++++++++
 include/exec/cpu_ldst.h   | 17 +++--------------
 include/exec/exec-all.h   |  1 +
 include/exec/translator.h |  5 ++++-
 accel/tcg/cputlb.c        |  1 +
 5 files changed, 42 insertions(+), 15 deletions(-)
 create mode 100644 include/exec/abi_ptr.h

diff --git a/include/exec/abi_ptr.h b/include/exec/abi_ptr.h
new file mode 100644
index 0000000000..2b6ae470c4
--- /dev/null
+++ b/include/exec/abi_ptr.h
@@ -0,0 +1,33 @@
+/*
+ * QEMU abi_ptr type
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef EXEC_ABI_PTR_H
+#define EXEC_ABI_PTR_H
+
+#include "cpu-param.h"
+
+#if defined(CONFIG_USER_ONLY)
+/*
+ * sparc32plus has 64bit long but 32bit space address
+ * this can make bad result with g2h() and h2g()
+ */
+#if TARGET_VIRT_ADDR_SPACE_BITS <= 32
+typedef uint32_t abi_ptr;
+#define TARGET_ABI_FMT_ptr "%x"
+#else
+typedef uint64_t abi_ptr;
+#define TARGET_ABI_FMT_ptr "%"PRIx64
+#endif
+
+#else /* !CONFIG_USER_ONLY */
+
+#include "exec/target_long.h"
+
+typedef target_ulong abi_ptr;
+#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
+
+#endif /* !CONFIG_USER_ONLY */
+
+#endif
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 25e7239cc5..64e0319996 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -63,20 +63,11 @@
 #define CPU_LDST_H
 
 #include "exec/memopidx.h"
+#include "exec/abi_ptr.h"
 #include "qemu/int128.h"
 #include "cpu.h"
 
 #if defined(CONFIG_USER_ONLY)
-/* sparc32plus has 64bit long but 32bit space address
- * this can make bad result with g2h() and h2g()
- */
-#if TARGET_VIRT_ADDR_SPACE_BITS <= 32
-typedef uint32_t abi_ptr;
-#define TARGET_ABI_FMT_ptr "%x"
-#else
-typedef uint64_t abi_ptr;
-#define TARGET_ABI_FMT_ptr "%"PRIx64
-#endif
 
 #ifndef TARGET_TAGGED_ADDRESSES
 static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
@@ -120,10 +111,8 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
     assert(h2g_valid(x)); \
     h2g_nocheck(x); \
 })
-#else
-typedef target_ulong abi_ptr;
-#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
-#endif
+
+#endif /* CONFIG_USER_ONLY */
 
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
 int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index df3d93a2e2..5b6be2de6c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,6 +22,7 @@
 
 #include "cpu.h"
 #if defined(CONFIG_USER_ONLY)
+#include "exec/abi_ptr.h"
 #include "exec/cpu_ldst.h"
 #endif
 #include "exec/translation-block.h"
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 6d3f59d095..574058b900 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -19,7 +19,10 @@
  */
 
 #include "qemu/bswap.h"
-#include "exec/cpu_ldst.h"	/* for abi_ptr */
+#include "exec/cpu-common.h"
+#include "exec/cpu-defs.h"
+#include "exec/abi_ptr.h"
+#include "cpu.h"
 
 /**
  * gen_intermediate_code
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index db3f93fda9..852a55fbb6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -34,6 +34,7 @@
 #include "qemu/atomic.h"
 #include "qemu/atomic128.h"
 #include "exec/translate-all.h"
+#include "exec/abi_ptr.h"
 #include "trace.h"
 #include "tb-hash.h"
 #include "internal-common.h"
-- 
2.41.0


