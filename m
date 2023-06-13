Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A2072E148
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90V9-0005km-68; Tue, 13 Jun 2023 05:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90V6-0005kG-Qc
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:44 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Uy-0005gc-Ku
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:44 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5147e8972a1so9235104a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649173; x=1689241173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G228fEEG3KGPqTypnQQNKK4WYtjAfFhy5BxWLUD+e/U=;
 b=R4rj8sg6Hi0kVUyzc1faFJ1L557UaQ0xAO9Hcf5jAjeQNBD0weg2dfiyBC/CWE3CuF
 YyiRdR253zu7VNRtRXEVkN08gzWpP3rcxmvCzd8Uj1JAcJah1F9ZbOK6rhXL/H7UzZrH
 b5ehSPregSQXwUfmwJ/k2yREToZMONAfs/8rntWN4nVV+oolcSSsm+sukGNyQNoLg68j
 hJ1gVCUEERKe6/RqpsDTjPv9A5JJ56P/pGC4cI/kX7thT0+VubPuDpnYGqw/1wovPbVV
 HiFaGv2BJb3rrcT+QNld8RBkK9cc3yb5f/VFIcYhe78q6a2dYRttBASU3FrrhMcO1VRS
 Esog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649173; x=1689241173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G228fEEG3KGPqTypnQQNKK4WYtjAfFhy5BxWLUD+e/U=;
 b=I1K8yjzF0vqpDHCWiBVUwdosaDNvKNcNn4J+p4Dy5aSUbAjtMfWuRSeA6b5xBhEJUd
 C5NyiSdNaHuSV+LrN46sH8LmBZuDizJqo8l101N3yQnqTAqKZhPrR/dTMTeoUXfh+Cxk
 duKZwSGiQqcdAR0HDKmV4kkCi8+uZVejdOV5w9EAlqYoIHUJaAbkt2lXxslRTCoy6iBU
 Ot9MrOCX1Yl0PxynhGuTnBihwGuHye0k1gmRTZV717yMuYY8gdI+jelKeb/nqGGeL7aE
 1h6IM82nywJ/U36+rcO0mxVaG/KpC8/gDiTF0Mfh2w6uvctN67om+KR0g3p2N8Ty3MMP
 805g==
X-Gm-Message-State: AC+VfDx+D1FNGpjwnzgEVICuREL29Q5t+0f/NozBNHLPzKs+DqaxGGNU
 mqGknLmBcjH52xOc+GHt0xYRRNzEplkWl479wXCLrw==
X-Google-Smtp-Source: ACHHUZ7EF8NRUhbcNcf/o6GffypDnxFTyPcq1+IQkLeDMH3F83pnFhg6YxQXQc53f4b+QgK4eyTBDw==
X-Received: by 2002:a05:6402:1487:b0:518:670a:7c57 with SMTP id
 e7-20020a056402148700b00518670a7c57mr2243685edv.14.1686649173369; 
 Tue, 13 Jun 2023 02:39:33 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 a25-20020aa7d919000000b00511aea132b9sm6198912edr.3.2023.06.13.02.39.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:39:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/17] exec/ram_addr: Return number of dirty pages in
 cpu_physical_memory_set_dirty_lebitmap()
Date: Tue, 13 Jun 2023 11:38:20 +0200
Message-Id: <20230613093822.63750-16-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

From: Joao Martins <joao.m.martins@oracle.com>

In preparation for including the number of dirty pages in the
vfio_get_dirty_bitmap() tracepoint, return the number of dirty pages in
cpu_physical_memory_set_dirty_lebitmap() similar to
cpu_physical_memory_sync_dirty_bitmap().

To avoid counting twice when GLOBAL_DIRTY_RATE is enabled, stash the
number of bits set per bitmap quad in a variable (@nbits) and reuse it
there.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230530180556.24441-2-joao.m.martins@oracle.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/ram_addr.h | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 90a8269290..9f2e3893f5 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -334,14 +334,23 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
 }
 
 #if !defined(_WIN32)
-static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
-                                                          ram_addr_t start,
-                                                          ram_addr_t pages)
+
+/*
+ * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
+ * the number of dirty pages in @bitmap passed as argument. On the other hand,
+ * cpu_physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
+ * weren't set in the global migration bitmap.
+ */
+static inline
+uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
+                                                ram_addr_t start,
+                                                ram_addr_t pages)
 {
     unsigned long i, j;
-    unsigned long page_number, c;
+    unsigned long page_number, c, nbits;
     hwaddr addr;
     ram_addr_t ram_addr;
+    uint64_t num_dirty = 0;
     unsigned long len = (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
     unsigned long hpratio = qemu_real_host_page_size() / TARGET_PAGE_SIZE;
     unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
@@ -369,6 +378,7 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                 if (bitmap[k]) {
                     unsigned long temp = leul_to_cpu(bitmap[k]);
 
+                    nbits = ctpopl(temp);
                     qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
 
                     if (global_dirty_tracking) {
@@ -377,10 +387,12 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                                 temp);
                         if (unlikely(
                             global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
-                            total_dirty_pages += ctpopl(temp);
+                            total_dirty_pages += nbits;
                         }
                     }
 
+                    num_dirty += nbits;
+
                     if (tcg_enabled()) {
                         qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
                                    temp);
@@ -409,9 +421,11 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
         for (i = 0; i < len; i++) {
             if (bitmap[i] != 0) {
                 c = leul_to_cpu(bitmap[i]);
+                nbits = ctpopl(c);
                 if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
-                    total_dirty_pages += ctpopl(c);
+                    total_dirty_pages += nbits;
                 }
+                num_dirty += nbits;
                 do {
                     j = ctzl(c);
                     c &= ~(1ul << j);
@@ -424,6 +438,8 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
             }
         }
     }
+
+    return num_dirty;
 }
 #endif /* not _WIN32 */
 
-- 
2.38.1


