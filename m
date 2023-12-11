Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A074080DCE3
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:24:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnjy-0004tm-1W; Mon, 11 Dec 2023 16:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnju-0004oL-Sn
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:58 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnjq-0005on-S3
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:58 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a1e35c2807fso661961266b.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329771; x=1702934571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6uthcvrcMhZYh7TDKG7c2NiXaXu0mJGOW4mt+82VSg=;
 b=bPZHzTPrBMqsZQgq+L+fsyRS5L0K8Uuinr0Y1f19IGXTtPwEYVT1ySFYRj/IzFrbWS
 V9/kliGFEkRrogO3xWCb8n9UcRLYkmLDL5wj3YDWCWpl6z9fxj9XVBio2U1BheViFwfF
 nChIz+gnd1Xb+tq7ciC1n9V74a9DgtXjuMD4rBbQrTk2eukbUrJg8VlMKVavFW6xKuRC
 O6VTN8SzJE0FEHL3zaOn4ankuNseIKpMUfkzHmwjlab5MSUlJ0+e7bl3H2WniKAxIeOY
 x69ujnLHhxRPG3SSoZzHMeAAf1SqCuTut9Lv33ngp9OchzED7aqbL7QaAik61egyjKDk
 Vd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329771; x=1702934571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6uthcvrcMhZYh7TDKG7c2NiXaXu0mJGOW4mt+82VSg=;
 b=nEl4AayIi0D+pk0Ju+U931k0Rs4WrJju45qtfJ1rqXS80U5WXpO21T0B1J7vfH3GiO
 Zlk80/ewX3M3gGavHOoYKC9kBq6YbAAE1Lqc28aHCei1M984E/X7CpTlG5aYTaJMuD4F
 tEZXES7NQ2783P0fmyYrtTx+0MiZj8rFLwI2JhX1hWmozxKZRuzAS05CzJ8tLiQanxmp
 ggmiuqjLrzu5ooK7H9JRbByfOcPjX7PgqoCFIiHIPhUop8pQIZcobt2tCWTF54YWhZCc
 Greo+bZUAgnmxMVBIVrSvnsmOQ8jQsnKPmvR1aU/bWvHfKvpx8TXg5wQSwXfS1uwou7V
 8OLg==
X-Gm-Message-State: AOJu0YzVS8DKMpANLoVNPxIEbCYYyV+WwiYy3obtGot0DnCLy1udUlZn
 J8/CzzYPSa33BJf09w7Ifdth6aesiGLhrdyXSJjsPw==
X-Google-Smtp-Source: AGHT+IFlpVH0gwUDj/yMopdJoeguSuQyN6Lebwbbjz5C0g1LrsAluDRrDlDlHZ53Q8jSf07ddyD6kw==
X-Received: by 2002:a17:906:284:b0:a19:940f:b9d3 with SMTP id
 4-20020a170906028400b00a19940fb9d3mr2189538ejf.25.1702329771198; 
 Mon, 11 Dec 2023 13:22:51 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 tj10-20020a170907c24a00b00a1db7b77675sm5407638ejc.90.2023.12.11.13.22.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:22:50 -0800 (PST)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 20/24] exec: Declare abi_ptr type in its own 'tcg/abi_ptr.h'
 header
Date: Mon, 11 Dec 2023 22:19:57 +0100
Message-ID: <20231211212003.21686-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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
create a new "tcg/abi_ptr.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu_ldst.h   | 17 +++--------------
 include/exec/exec-all.h   |  1 +
 include/exec/translator.h |  5 ++++-
 include/tcg/abi_ptr.h     | 32 ++++++++++++++++++++++++++++++++
 accel/tcg/cputlb.c        |  1 +
 5 files changed, 41 insertions(+), 15 deletions(-)
 create mode 100644 include/tcg/abi_ptr.h

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 25e7239cc5..c69f02b699 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -65,18 +65,9 @@
 #include "exec/memopidx.h"
 #include "qemu/int128.h"
 #include "cpu.h"
+#include "tcg/abi_ptr.h"
 
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
index df3d93a2e2..6a634c0889 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,6 +22,7 @@
 
 #include "cpu.h"
 #if defined(CONFIG_USER_ONLY)
+#include "tcg/abi_ptr.h"
 #include "exec/cpu_ldst.h"
 #endif
 #include "exec/translation-block.h"
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 6d3f59d095..16d2449292 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -19,7 +19,10 @@
  */
 
 #include "qemu/bswap.h"
-#include "exec/cpu_ldst.h"	/* for abi_ptr */
+#include "exec/cpu-common.h"
+#include "exec/cpu-defs.h"
+#include "cpu.h"
+#include "tcg/abi_ptr.h"
 
 /**
  * gen_intermediate_code
diff --git a/include/tcg/abi_ptr.h b/include/tcg/abi_ptr.h
new file mode 100644
index 0000000000..415e31cabb
--- /dev/null
+++ b/include/tcg/abi_ptr.h
@@ -0,0 +1,32 @@
+/*
+ * TCG abi_ptr type
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef TCG_ABI_PTR_H
+#define TCG_ABI_PTR_H
+
+#include "cpu-param.h"
+
+#if defined(CONFIG_USER_ONLY)
+/* sparc32plus has 64bit long but 32bit space address
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
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index db3f93fda9..c4500d3261 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -41,6 +41,7 @@
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
 #endif
+#include "tcg/abi_ptr.h"
 #include "tcg/tcg-ldst.h"
 #include "tcg/oversized-guest.h"
 
-- 
2.41.0


