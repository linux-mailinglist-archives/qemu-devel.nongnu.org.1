Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D0B772B27
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:38:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3EZ-0007Sh-0H; Mon, 07 Aug 2023 12:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EP-00076Q-JA
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:22 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EN-0002iU-Jv
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:21 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6877eb31261so3388623b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426238; x=1692031038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWcQY33lfMI5vcNDVB1diRmeJ4ckk4q/UyqRf5tZgVY=;
 b=LMyuvnoaPk7Eh6a/D9KwaDC3vjgvh6QhJwhQedxikjJP/0QmMxtb6PKIOmhuoUdwDA
 e8NSLhRvjO1DkaiAy8PtaOFVv/Ft3Hqe06/yOaayeTM/Y3sxyPT59ZVIGa9orrz7d9wG
 jA6y/GZ7rhzvmDyXXWDGhGmrOdNOn/MfH+ZV6zIxSS39oH8vlGSI2Q8Gfc3RNZ0CXvol
 cHhTAS2WV4kyB4FtJCn/0luqtphtZRNIbLrJ2HfnQAPDuIJu3Obc4/iyohhnfEpegJpy
 4if7EGLBwsh6jGV3V8rRBS6a2bDnbIOt+8Opl8bv8adBxlOPgDOxQgYJLMxAH2bAW6/+
 5SMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426238; x=1692031038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWcQY33lfMI5vcNDVB1diRmeJ4ckk4q/UyqRf5tZgVY=;
 b=Z75L19R6Uam45UE3cSeHlJ2eWCEqu6pVHXisktLbIf+1jw9FUQppE+6Pg5vOJ7NcVX
 r7+gksbTM/xZ/x7fIAOaj+LwIZ+QTqEFqNC0i6qQVN7BCCKZMBt9E3XGmjOwVo+7oB4H
 teUeGdF4DJwQJTaNlyUsrtBiHjazCOOUOhNudpQ8v1/QpJBpBuryhqi3Zzfiackx7cYO
 yppW7H3KPlg4/STrCrEFAzvx8ImmpQRS6bMWu63pvn4suMxenGTMUP73VpQ3UcgeQF1U
 TohuVdRM9fqZy1ViZ7pQ6GSM0BVYJWQyT15Y6RT9qOgyuzgaNgKk/Hj5FxoaUdSVt6GT
 ATsw==
X-Gm-Message-State: AOJu0YyoaxwI2ExXJdLWzLCtS4E6xwLjJ2quObXUuWzO1V1MMdLJkdM5
 j0pAT6uL00nKRTV/XfWwq217KmIApY21vC61Hzc=
X-Google-Smtp-Source: AGHT+IEfEFXH9G4NDAHTjnZmnvn/CYn3uxvgzl7Dej5uSmyiuXeQzJlK+bVBxYtNDt8LUkfh0Ovxfw==
X-Received: by 2002:a17:902:f68c:b0:1b8:9044:b8ae with SMTP id
 l12-20020a170902f68c00b001b89044b8aemr11576832plg.11.1691426238101; 
 Mon, 07 Aug 2023 09:37:18 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH for-8.1 v10 13/14] linux-user: Rewrite fixed probe_guest_base
Date: Mon,  7 Aug 2023 09:37:04 -0700
Message-Id: <20230807163705.9848-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Create a set of subroutines to collect a set of guest addresses,
all of which must be mappable on the host.  Use this within the
renamed pgb_fixed subroutine to validate the user's choice of
guest_base specified by the -B command-line option.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 189 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 162 insertions(+), 27 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 484ab7131a..33c74be3af 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2506,6 +2506,158 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
 #endif
 #endif
 
+/**
+ * pgb_try_mmap:
+ * @addr: host start address
+ * @addr_last: host last address
+ * @keep: do not unmap the probe region
+ *
+ * Return 1 if [@addr, @addr_last] is not mapped in the host,
+ * return 0 if it is not available to map, and -1 on mmap error.
+ * If @keep, the region is left mapped on success, otherwise unmapped.
+ */
+static int pgb_try_mmap(uintptr_t addr, uintptr_t addr_last, bool keep)
+{
+    size_t size = addr_last - addr + 1;
+    void *p = mmap((void *)addr, size, PROT_NONE,
+                   MAP_ANONYMOUS | MAP_PRIVATE |
+                   MAP_NORESERVE | MAP_FIXED_NOREPLACE, -1, 0);
+    int ret;
+
+    if (p == MAP_FAILED) {
+        return errno == EEXIST ? 0 : -1;
+    }
+    ret = p == (void *)addr;
+    if (!keep || !ret) {
+        munmap(p, size);
+    }
+    return ret;
+}
+
+/**
+ * pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t size, uintptr_t brk)
+ * @addr: host address
+ * @size: size
+ * @brk: host brk
+ *
+ * Like pgb_try_mmap, but additionally reserve some memory following brk.
+ */
+static int pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t addr_last,
+                                 uintptr_t brk, bool keep)
+{
+    uintptr_t brk_last = brk + 16 * MiB - 1;
+
+    /* Do not map anything close to the host brk. */
+    if (addr <= brk_last && brk <= addr_last) {
+        return 0;
+    }
+    return pgb_try_mmap(addr, addr_last, keep);
+}
+
+/**
+ * pgb_try_mmap_set:
+ * @ga: set of guest addrs
+ * @base: guest_base
+ * @brk: host brk
+ *
+ * Return true if all @ga can be mapped by the host at @base.
+ * On success, retain the mapping at index 0 for reserved_va.
+ */
+
+typedef struct PGBAddrs {
+    uintptr_t bounds[3][2]; /* start/last pairs */
+    int nbounds;
+    bool with_null_page;
+} PGBAddrs;
+
+static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uintptr_t brk)
+{
+    for (int i = ga->nbounds - 1; i >= 0; --i) {
+        if (pgb_try_mmap_skip_brk(ga->bounds[i][0] + base,
+                                  ga->bounds[i][1] + base,
+                                  brk, i == 0 && reserved_va) <= 0) {
+            return false;
+        }
+    }
+    return true;
+}
+
+/**
+ * pgb_addr_set:
+ * @ga: output set of guest addrs
+ * @guest_loaddr: guest image low address
+ * @guest_loaddr: guest image high address
+ * @identity: create for identity mapping
+ *
+ * Fill in @ga with the image, COMMPAGE and NULL page.
+ */
+static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
+                         abi_ulong guest_hiaddr, bool try_identity)
+{
+    int n;
+
+    /*
+     * With a low commpage, or a guest mapped very low,
+     * we may not be able to use the identity map.
+     */
+    if (try_identity) {
+        if (LO_COMMPAGE != -1 && LO_COMMPAGE < mmap_min_addr) {
+            return false;
+        }
+        if (guest_loaddr != 0 && guest_loaddr < mmap_min_addr) {
+            return false;
+        }
+    }
+
+    memset(ga, 0, sizeof(*ga));
+    n = 0;
+
+    if (reserved_va) {
+        ga->bounds[n][0] = try_identity ? mmap_min_addr : 0;
+        ga->bounds[n][1] = reserved_va;
+        n++;
+        /* LO_COMMPAGE and NULL handled by reserving from 0. */
+    } else {
+        /* Add any LO_COMMPAGE or NULL page. */
+        if (LO_COMMPAGE != -1) {
+            ga->bounds[n][0] = 0;
+            ga->bounds[n][1] = LO_COMMPAGE + TARGET_PAGE_SIZE - 1;
+            n++;
+        } else if (!try_identity) {
+            ga->bounds[n][0] = 0;
+            ga->bounds[n][1] = TARGET_PAGE_SIZE - 1;
+            n++;
+        }
+
+        /* Add the guest image for ET_EXEC. */
+        if (guest_loaddr) {
+            ga->bounds[n][0] = guest_loaddr;
+            ga->bounds[n][1] = guest_hiaddr;
+            n++;
+        }
+    }
+
+    /*
+     * Temporarily disable
+     *   "comparison is always false due to limited range of data type"
+     * due to comparison between unsigned and (possible) 0.
+     */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wtype-limits"
+
+    /* Add any HI_COMMPAGE not covered by reserved_va. */
+    if (reserved_va < HI_COMMPAGE) {
+        ga->bounds[n][0] = HI_COMMPAGE & qemu_host_page_mask;
+        ga->bounds[n][1] = HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
+        n++;
+    }
+
+#pragma GCC diagnostic pop
+
+    ga->nbounds = n;
+    return true;
+}
+
 static void pgb_fail_in_use(const char *image_name)
 {
     error_report("%s: requires virtual address space that is in use "
@@ -2514,33 +2666,21 @@ static void pgb_fail_in_use(const char *image_name)
     exit(EXIT_FAILURE);
 }
 
-static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
-                                abi_ulong guest_hiaddr, long align)
+static void pgb_fixed(const char *image_name, uintptr_t guest_loaddr,
+                      uintptr_t guest_hiaddr, uintptr_t align)
 {
-    const int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
-    void *addr, *test;
+    PGBAddrs ga;
+    uintptr_t brk = (uintptr_t)sbrk(0);
 
     if (!QEMU_IS_ALIGNED(guest_base, align)) {
         fprintf(stderr, "Requested guest base %p does not satisfy "
-                "host minimum alignment (0x%lx)\n",
+                "host minimum alignment (0x%" PRIxPTR ")\n",
                 (void *)guest_base, align);
         exit(EXIT_FAILURE);
     }
 
-    /*
-     * Expand the allocation to the entire reserved_va.
-     * Exclude the mmap_min_addr hole.
-     */
-    if (reserved_va) {
-        guest_loaddr = (guest_base >= mmap_min_addr ? 0
-                        : mmap_min_addr - guest_base);
-        guest_hiaddr = reserved_va;
-    }
-
-    /* Reserve the address space for the binary, or reserved_va. */
-    test = g2h_untagged(guest_loaddr);
-    addr = mmap(test, guest_hiaddr - guest_loaddr + 1, PROT_NONE, flags, -1, 0);
-    if (test != addr) {
+    if (!pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, !guest_base)
+        || !pgb_try_mmap_set(&ga, guest_base, brk)) {
         pgb_fail_in_use(image_name);
     }
 }
@@ -2786,7 +2926,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
     }
 
     if (have_guest_base) {
-        pgb_have_guest_base(image_name, guest_loaddr, guest_hiaddr, align);
+        pgb_fixed(image_name, guest_loaddr, guest_hiaddr, align);
     } else if (reserved_va) {
         pgb_reserved_va(image_name, guest_loaddr, guest_hiaddr, align);
     } else if (guest_loaddr) {
@@ -2797,13 +2937,8 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
 
     /* Reserve and initialize the commpage. */
     if (!init_guest_commpage()) {
-        /*
-         * With have_guest_base, the user has selected the address and
-         * we are trying to work with that.  Otherwise, we have selected
-         * free space and init_guest_commpage must succeeded.
-         */
-        assert(have_guest_base);
-        pgb_fail_in_use(image_name);
+        /* We have already probed for the commpage being free. */
+        g_assert_not_reached();
     }
 
     assert(QEMU_IS_ALIGNED(guest_base, align));
-- 
2.34.1


