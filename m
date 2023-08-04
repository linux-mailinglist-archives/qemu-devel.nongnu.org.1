Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E615770BBF
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:07:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rO-00053v-QN; Fri, 04 Aug 2023 18:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qs-0004mI-Qg
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:55 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qr-0001vX-4N
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bb2468257fso18112725ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186452; x=1691791252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQhgJn+xuWrfht0tZgQrit41wBeRtDQVHgOUdbJWgEM=;
 b=gmsp8c2GoRKN3FQWE/T+jUBYHzwWW5Cs3lkXAiQEBnaYIbWGzgDjMzexZ8lYVwCrQ8
 GPlDgTnS6AKx85oa9px2YGs6oNkOPR3a4ISIJ637XPt5htOtcppM1yoM0U33ABPT57S7
 N5pACJAc5Yr2Cz+gYNGTYpFsiFWI5LlSLZlFOU2DYz3mQhbX8VMuRcRafBXdIa2XRGNg
 E26viS+ZXARzz6vIJ0awUii8HACplyiqzUe9gbPIppQtRA/K+HNVX2u6rHsM8iUjFm09
 1ywX+FVetvRKQiNJgUJx2MPOJe998aVvy+OtHWtlpUvV7M1TzXIsYqrHw1ztKtjmHJwp
 hZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186452; x=1691791252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQhgJn+xuWrfht0tZgQrit41wBeRtDQVHgOUdbJWgEM=;
 b=QWMjdLdR4TO0Vk4y3VuBa8m7IX12jw8a2KCeFCSoV12uz+pwZxEpfLYQdinbCS6/74
 8g0ibbLVPYD1t8fqUCPtHI7QLaj5gBqYEyu4dpUnlC9OVcEeT5Sj+QDnUKtu/pnT7bND
 +B7HOTEb+KGJBVFXqMTZpckKz0XkYvHrwv7jtNQI2KPcHuADbKB8b6PRD9MRparuxYqE
 iUphtDeFzdQFBQIDajVlPtg92qT8gY/9mizDFrslcFfLghL0b2JLwBUp415SGaK2VYdt
 bYO+1mD+Q82JZyn7IRkqBQ69Z275/U51M3GtU/86AwHwSbMFROMvjsuC7JDX+FT568wQ
 aAew==
X-Gm-Message-State: AOJu0Yzt0jKuiFuimQUCakPkhlLrorAUQUP3V6lhO8JiOW3ygmsc0cCo
 I0EtXLNQYZrH1FWdAZ+dV00lUumBN4oJjU8/+r8=
X-Google-Smtp-Source: AGHT+IEgGeZKTgLBqE9Si7q3hVtoVuh0G46dcv5xK/nVwQzB9fIxSYpH5SeG8MZYR3wEDsiHMt9OEg==
X-Received: by 2002:a17:902:bb8b:b0:1b9:d2fc:ba9f with SMTP id
 m11-20020a170902bb8b00b001b9d2fcba9fmr2751404pls.11.1691186451762; 
 Fri, 04 Aug 2023 15:00:51 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 21/24] linux-user: Do not adjust zero_bss for host page size
Date: Fri,  4 Aug 2023 15:00:29 -0700
Message-Id: <20230804220032.295411-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Rely on target_mmap to handle guest vs host page size mismatch.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 54 +++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e853a4ab33..66ab617bd1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2212,44 +2212,36 @@ static abi_ulong setup_arg_pages(struct linux_binprm *bprm,
 
 /* Map and zero the bss.  We need to explicitly zero any fractional pages
    after the data section (i.e. bss).  */
-static void zero_bss(abi_ulong elf_bss, abi_ulong last_bss, int prot)
+static void zero_bss(abi_ulong start_bss, abi_ulong end_bss, int prot)
 {
-    uintptr_t host_start, host_map_start, host_end;
+    abi_ulong align_bss;
 
-    last_bss = TARGET_PAGE_ALIGN(last_bss);
+    align_bss = TARGET_PAGE_ALIGN(start_bss);
+    end_bss = TARGET_PAGE_ALIGN(end_bss);
 
-    /* ??? There is confusion between qemu_real_host_page_size and
-       qemu_host_page_size here and elsewhere in target_mmap, which
-       may lead to the end of the data section mapping from the file
-       not being mapped.  At least there was an explicit test and
-       comment for that here, suggesting that "the file size must
-       be known".  The comment probably pre-dates the introduction
-       of the fstat system call in target_mmap which does in fact
-       find out the size.  What isn't clear is if the workaround
-       here is still actually needed.  For now, continue with it,
-       but merge it with the "normal" mmap that would allocate the bss.  */
+    if (start_bss < align_bss) {
+        int flags = page_get_flags(start_bss);
 
-    host_start = (uintptr_t) g2h_untagged(elf_bss);
-    host_end = (uintptr_t) g2h_untagged(last_bss);
-    host_map_start = REAL_HOST_PAGE_ALIGN(host_start);
-
-    if (host_map_start < host_end) {
-        void *p = mmap((void *)host_map_start, host_end - host_map_start,
-                       prot, MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-        if (p == MAP_FAILED) {
-            perror("cannot mmap brk");
-            exit(-1);
+        if (!(flags & PAGE_VALID)) {
+            /* Map the start of the bss. */
+            align_bss -= TARGET_PAGE_SIZE;
+        } else if (flags & PAGE_WRITE) {
+            /* The page is already mapped writable. */
+            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
+        } else {
+            /* Read-only zeros? */
+            g_assert_not_reached();
         }
     }
 
-    /* Ensure that the bss page(s) are valid */
-    if ((page_get_flags(last_bss-1) & prot) != prot) {
-        page_set_flags(elf_bss & TARGET_PAGE_MASK, last_bss - 1,
-                       prot | PAGE_VALID);
-    }
-
-    if (host_start < host_map_start) {
-        memset((void *)host_start, 0, host_map_start - host_start);
+    if (align_bss < end_bss) {
+        abi_long err = target_mmap(align_bss, end_bss - align_bss, prot,
+                                   MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
+                                   -1, 0);
+        if (err == -1) {
+            perror("cannot mmap brk");
+            exit(-1);
+        }
     }
 }
 
-- 
2.34.1


