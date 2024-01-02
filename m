Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC7B821647
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:02:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3s-0003wz-BQ; Mon, 01 Jan 2024 20:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3o-0003nJ-Rw
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:16 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3n-00076e-Az
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:16 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bb53e20a43so7596606b6e.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160754; x=1704765554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2uOfnGHlQ+o+S9iOylPG+ACTd3Ii4k/xbpKgSOUwLQ=;
 b=Z0nnq+/b1pW4yKSicEQF9GaDRiXWh+0hlcENiwZ/kShnZpxvRe0wt/b5DN6RS/McI3
 vVhImIxmWesfn/+k1CVCiXQZtsMnAaavU/+DaUbGCeplS7gHngGTCk5BDcen+g7yY+YE
 3f79uChMAitwr/OlAxKvA178ds1cb6uxsskKvDn8ZufNObxnEjQ5c7eMozcbI1BgJerA
 7U4hbEfMGV9maDzE9kUVdbqmEf4epQHiDWy8+toctbxJG7S43yNcRDqEkhM9pgHifchR
 JSTYknfuxS9ImascdbN83vp0AC+UafEXtHmPBVTM4gm3yAKCLM+kcxu8X3YJFvjngy2j
 w95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160754; x=1704765554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2uOfnGHlQ+o+S9iOylPG+ACTd3Ii4k/xbpKgSOUwLQ=;
 b=q5GHnplpMxD4d+LBTH8TVoFAsUe4l45N98lTVMrkKZp7sRTZAEFW14j2r5QFUWfljD
 n2/uHIUdLq8Zb/Xj/FGiA899tPm6SONyXpv/aCLA1c4bEWk/NYmMoqrraZLM5eFS6TQg
 +Fr8CUvJ3Y+Si6NoDNzW0PUgK6W6PMk7zpMJbke9SU/sT7zLSoRezsbHSKu5fznrBNZJ
 jdH60BNo0eX+eROAOynSXird13zFVbfa/6FxORuHt6u6OkibcK46FZoOO0zrE9EQZY/d
 mw52rD5TVvnnLiVaqG7IJuFO5LnLkqNwjcSRs+kuKeROCqw1zN09+25lW7lmDSEOyzXF
 TIyQ==
X-Gm-Message-State: AOJu0Yxca5SbZaqSph+MgV4BQwuQUfp4IDJJs7Y3/N6i7q10znkB4wQ5
 NSLsYt+Wac+mSU85+tjhwCex9eDFUmaK67RAUPXxXOw0YVQ=
X-Google-Smtp-Source: AGHT+IFG95tlgadQklNOeu0a1JBMiiEE3NcS664mbmF1vUGQpBVLRx+EvOVCWXQvq/WmVfUMVGqirQ==
X-Received: by 2002:a05:6808:130e:b0:3b9:dcf0:63b9 with SMTP id
 y14-20020a056808130e00b003b9dcf063b9mr20258295oiv.23.1704160753974; 
 Mon, 01 Jan 2024 17:59:13 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:59:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 29/33] linux-user: Allow TARGET_PAGE_BITS_VARY
Date: Tue,  2 Jan 2024 12:58:04 +1100
Message-Id: <20240102015808.132373-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

If set, match the host and guest page sizes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 9ba4dc5872..d00a0d7d1f 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -55,6 +55,7 @@
 #include "loader.h"
 #include "user-mmap.h"
 #include "accel/tcg/perf.h"
+#include "exec/page-vary.h"
 
 #ifdef CONFIG_SEMIHOSTING
 #include "semihosting/semihost.h"
@@ -683,6 +684,7 @@ int main(int argc, char **argv, char **envp)
     int i;
     int ret;
     int execfd;
+    int host_page_size;
     unsigned long max_reserved_va;
     bool preserve_argv0;
 
@@ -794,6 +796,16 @@ int main(int argc, char **argv, char **envp)
                                  opt_one_insn_per_tb, &error_abort);
         ac->init_machine(NULL);
     }
+
+    /*
+     * Finalize page size before creating CPUs.
+     * This will do nothing if !TARGET_PAGE_BITS_VARY.
+     * The most efficient setting is to match the host.
+     */
+    host_page_size = qemu_real_host_page_size();
+    set_preferred_target_page_bits(ctz32(host_page_size));
+    finalize_target_page_bits();
+
     cpu = cpu_create(cpu_type);
     env = cpu_env(cpu);
     cpu_reset(cpu);
@@ -807,8 +819,6 @@ int main(int argc, char **argv, char **envp)
      */
     max_reserved_va = MAX_RESERVED_VA(cpu);
     if (reserved_va != 0) {
-        int host_page_size = qemu_real_host_page_size();
-
         if ((reserved_va + 1) % host_page_size) {
             char *s = size_to_str(host_page_size);
             fprintf(stderr, "Reserved virtual address not aligned mod %s\n", s);
@@ -907,7 +917,7 @@ int main(int argc, char **argv, char **envp)
      * If we're in a chroot with no /proc, fall back to 1 page.
      */
     if (mmap_min_addr == 0) {
-        mmap_min_addr = qemu_real_host_page_size();
+        mmap_min_addr = host_page_size;
         qemu_log_mask(CPU_LOG_PAGE,
                       "host mmap_min_addr=0x%lx (fallback)\n",
                       mmap_min_addr);
-- 
2.34.1


