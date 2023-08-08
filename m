Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971E774C81
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:10:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTx4-0007kI-IH; Tue, 08 Aug 2023 17:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTx2-0007jn-US
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTx1-0005xd-17
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:12 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bb84194bf3so40473955ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528950; x=1692133750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWVD9ChkStM4MlCzbWF7GaEM5UjeZi9WpfIZ1Gpn9gU=;
 b=xRQ/pWmylwqPQAdvAUM3tOnrGeDcpeQcEZxr1yQ9BkO0ER+nEfxtwIpCq0up0gzzem
 kFX8nUugi97y7EeEhgX3e0/h6LiBVaIUaO/YbXpEAPAUOW+O9u1tN6NK5YOyBtM0GoSI
 zhslAW+Aa5rvUE9IXG/qeTFXXSV5ClCCgk/Q3arNpWgCgQHXHs7LKq0MWoPXIPfaJxyG
 Ar+frlrH84kAcMzNboDV2EcEDsHKJltWDpK27oFG2jIgO26TXkUXmBK4uMCsgkuq80YN
 idMGSM6bNXS4gx/iH/FuHXRIr7inUrS9/w0N3mtPRo0ndKlB1Yen88z78YIz4EKD3G81
 dt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528950; x=1692133750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWVD9ChkStM4MlCzbWF7GaEM5UjeZi9WpfIZ1Gpn9gU=;
 b=PysElt9nO3ZfEIoBYQfO8kct4BbMDYb8NrCp3yPqUcW+9JG/+0bDymiV9QLy3EW7VC
 pgr/WbyNKQFREPZapz3xky26EgZAdXVpatAj7Yw5CZvNgxkEw69FfqS79avRF/gBoIcQ
 +V+MuR8w+f9Rcmpv8RquuK1ZtKtkVRBlU+6vqmb7Ww2nx3E+fS8Q17cl0lRtjOBS5WPX
 LQ9LsGlmr8QQCFyX4jw3aAX6GRQbpwJzP0+0IGJUi+7i2o5tTjM5oqM5RcrhgYGKZ3Qh
 SH8RalroTdWcVhDT7R33PqcmaZiJNpWYFQXBwxj2bHNmDWnSzFHSYsroRNVO4FtZCbgF
 P1qA==
X-Gm-Message-State: AOJu0YylnqejLS8iCNUrfSz6D4JeYoZSTvwfnjIH/5DdE0KRa2qFMNX4
 Dg0bcvAVI9lTMK6ijxj6tPZ47X2ITZCGZ9NZ9x4=
X-Google-Smtp-Source: AGHT+IGh+p2+MG9O2W9ujeAT7r48dI4wLSWYsmuI/StahD/aPuSqj0gKBLfBoi9sge4oX3RiXVig7w==
X-Received: by 2002:a17:902:7795:b0:1b3:b3c5:1d1f with SMTP id
 o21-20020a170902779500b001b3b3c51d1fmr821569pll.8.1691528949724; 
 Tue, 08 Aug 2023 14:09:09 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:09:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 13/14] linux-user: Rewrite fixed probe_guest_base
Date: Tue,  8 Aug 2023 14:08:55 -0700
Message-Id: <20230808210856.95568-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Create a set of subroutines to collect a set of guest addresses,
all of which must be mappable on the host.  Use this within the
renamed pgb_fixed subroutine to validate the user's choice of
guest_base specified by the -B command-line option.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 188 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 161 insertions(+), 27 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 06d81f83b1..a5f9dd5b31 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2504,6 +2504,157 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
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
+ * @addr_last: host last address
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
@@ -2512,33 +2663,21 @@ static void pgb_fail_in_use(const char *image_name)
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
@@ -2784,7 +2923,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
     }
 
     if (have_guest_base) {
-        pgb_have_guest_base(image_name, guest_loaddr, guest_hiaddr, align);
+        pgb_fixed(image_name, guest_loaddr, guest_hiaddr, align);
     } else if (reserved_va) {
         pgb_reserved_va(image_name, guest_loaddr, guest_hiaddr, align);
     } else if (guest_loaddr) {
@@ -2795,13 +2934,8 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
 
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


