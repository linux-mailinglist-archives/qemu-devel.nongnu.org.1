Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0C87F1F49
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:38:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5BwL-0006oD-AB; Mon, 20 Nov 2023 16:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bvy-0006eM-7a
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:35:58 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bvv-0004DL-00
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:35:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40a48775c58so21420005e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516153; x=1701120953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJsPtTyJ8AvLk2JmJxbXP+WyZeZtfo9yWUZ/XM9f5N8=;
 b=oP3wfeLpB3ZBWZDclWN2uV7Jb7+65wnS6ZRtM70NnmA6jvOmmh+hNu9lQjlkACUq3t
 HZ5xuvrismjZpv60fL1WnsVa5DKBVPy+ReueWf/13WLk/zEBAfo9iqfScxEXFZue89t5
 81xlUPxyZByyVIR2qKcTdgR+5pFGoVQ17mcTS7Ma0Fv/xclqa/tYVv6BcTt2cUdDHvYU
 WQFnrH6J/lrGHpNQzdNwXwSaZsIXmOnExjS+CTeoYx0OyTUKOTm+rYIQmelsVI4l9864
 9pyWaD53qSSfJvKqUO2vKcwZlbJIbgeYMNLiFzvzsHmF+MzC2yWLsIqj6E9wZohSb15u
 WmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516153; x=1701120953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJsPtTyJ8AvLk2JmJxbXP+WyZeZtfo9yWUZ/XM9f5N8=;
 b=mvqtNzHF5SrIQmsDaL8si8QNSeV9x5UcVdFdblFd9rM9usr6ChucRwjFgWd+gcWxjz
 oSWl1s/g7S6dcfkQDJKy6MkPuN81XhuZFAgnwdGRaRMTFJCSvlsGPEah+UDdUlP2S+sI
 pOTb69ORgJmQq68Vxb2nWgivDBu2nxvW+4e9kl+nziuvkn8L2YKPRxV4DVkCMd/6D0pL
 /Vxo/cAy4vhPZNNz6lSuZLmN2MEwjTUDqDj2duHXlk0tkAH/KWuNU1aQivakQwdewj2u
 6dKw+IjbABb4CZTGoz/nyzWVBB4miqCRZbyOvv07W25tsKAHSbozfFG3qrfWfZvgIsTJ
 5zeQ==
X-Gm-Message-State: AOJu0YyXiUByhwl6FqUsUTL36H5WjO+ZvSFJTLcyohCQtDC6oG7KYHFl
 +hJJfm4L7LYrTdlcnZZ0bmxNpnCr464284xgUtg=
X-Google-Smtp-Source: AGHT+IGaU7Di37CDPM7YHvwmjuIz3SZqWetIjdoyZIOCCdwwPPXAThpDcu0+ZMAY6J0jgcTGBkPzlA==
X-Received: by 2002:a05:600c:3143:b0:406:44e6:c00d with SMTP id
 h3-20020a05600c314300b0040644e6c00dmr7281481wmo.2.1700516153074; 
 Mon, 20 Nov 2023 13:35:53 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a7bc8c6000000b004030e8ff964sm18673462wml.34.2023.11.20.13.35.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:35:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-9.0 15/25] backends: Simplify
 host_memory_backend_memory_complete()
Date: Mon, 20 Nov 2023 22:32:49 +0100
Message-ID: <20231120213301.24349-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Return early if bc->alloc is NULL. De-indent the if() ladder.

Note, this avoids a pointless call to error_propagate() with
errp=NULL at the 'out:' label.

Change trivial when reviewed with 'git-diff --ignore-all-space'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/hostmem.c | 133 +++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 66 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 747e7838c0..1723c19165 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -328,83 +328,84 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     void *ptr;
     uint64_t sz;
 
-    if (bc->alloc) {
-        bc->alloc(backend, &local_err);
-        if (local_err) {
-            goto out;
-        }
+    if (!bc->alloc) {
+        return;
+    }
+    bc->alloc(backend, &local_err);
+    if (local_err) {
+        goto out;
+    }
 
-        ptr = memory_region_get_ram_ptr(&backend->mr);
-        sz = memory_region_size(&backend->mr);
+    ptr = memory_region_get_ram_ptr(&backend->mr);
+    sz = memory_region_size(&backend->mr);
 
-        if (backend->merge) {
-            qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE);
-        }
-        if (!backend->dump) {
-            qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
-        }
+    if (backend->merge) {
+        qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE);
+    }
+    if (!backend->dump) {
+        qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
+    }
 #ifdef CONFIG_NUMA
-        unsigned long lastbit = find_last_bit(backend->host_nodes, MAX_NODES);
-        /* lastbit == MAX_NODES means maxnode = 0 */
-        unsigned long maxnode = (lastbit + 1) % (MAX_NODES + 1);
-        /* ensure policy won't be ignored in case memory is preallocated
-         * before mbind(). note: MPOL_MF_STRICT is ignored on hugepages so
-         * this doesn't catch hugepage case. */
-        unsigned flags = MPOL_MF_STRICT | MPOL_MF_MOVE;
-        int mode = backend->policy;
+    unsigned long lastbit = find_last_bit(backend->host_nodes, MAX_NODES);
+    /* lastbit == MAX_NODES means maxnode = 0 */
+    unsigned long maxnode = (lastbit + 1) % (MAX_NODES + 1);
+    /* ensure policy won't be ignored in case memory is preallocated
+     * before mbind(). note: MPOL_MF_STRICT is ignored on hugepages so
+     * this doesn't catch hugepage case. */
+    unsigned flags = MPOL_MF_STRICT | MPOL_MF_MOVE;
+    int mode = backend->policy;
 
-        /* check for invalid host-nodes and policies and give more verbose
-         * error messages than mbind(). */
-        if (maxnode && backend->policy == MPOL_DEFAULT) {
-            error_setg(errp, "host-nodes must be empty for policy default,"
-                       " or you should explicitly specify a policy other"
-                       " than default");
-            return;
-        } else if (maxnode == 0 && backend->policy != MPOL_DEFAULT) {
-            error_setg(errp, "host-nodes must be set for policy %s",
-                       HostMemPolicy_str(backend->policy));
-            return;
-        }
+    /* check for invalid host-nodes and policies and give more verbose
+     * error messages than mbind(). */
+    if (maxnode && backend->policy == MPOL_DEFAULT) {
+        error_setg(errp, "host-nodes must be empty for policy default,"
+                   " or you should explicitly specify a policy other"
+                   " than default");
+        return;
+    } else if (maxnode == 0 && backend->policy != MPOL_DEFAULT) {
+        error_setg(errp, "host-nodes must be set for policy %s",
+                   HostMemPolicy_str(backend->policy));
+        return;
+    }
 
-        /* We can have up to MAX_NODES nodes, but we need to pass maxnode+1
-         * as argument to mbind() due to an old Linux bug (feature?) which
-         * cuts off the last specified node. This means backend->host_nodes
-         * must have MAX_NODES+1 bits available.
-         */
-        assert(sizeof(backend->host_nodes) >=
-               BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
-        assert(maxnode <= MAX_NODES);
+    /* We can have up to MAX_NODES nodes, but we need to pass maxnode+1
+     * as argument to mbind() due to an old Linux bug (feature?) which
+     * cuts off the last specified node. This means backend->host_nodes
+     * must have MAX_NODES+1 bits available.
+     */
+    assert(sizeof(backend->host_nodes) >=
+           BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
+    assert(maxnode <= MAX_NODES);
 
 #ifdef HAVE_NUMA_HAS_PREFERRED_MANY
-        if (mode == MPOL_PREFERRED && numa_has_preferred_many() > 0) {
-            /*
-             * Replace with MPOL_PREFERRED_MANY otherwise the mbind() below
-             * silently picks the first node.
-             */
-            mode = MPOL_PREFERRED_MANY;
-        }
+    if (mode == MPOL_PREFERRED && numa_has_preferred_many() > 0) {
+        /*
+         * Replace with MPOL_PREFERRED_MANY otherwise the mbind() below
+         * silently picks the first node.
+         */
+        mode = MPOL_PREFERRED_MANY;
+    }
 #endif
 
-        if (maxnode &&
-            mbind(ptr, sz, mode, backend->host_nodes, maxnode + 1, flags)) {
-            if (backend->policy != MPOL_DEFAULT || errno != ENOSYS) {
-                error_setg_errno(errp, errno,
-                                 "cannot bind memory to host NUMA nodes");
-                return;
-            }
+    if (maxnode &&
+        mbind(ptr, sz, mode, backend->host_nodes, maxnode + 1, flags)) {
+        if (backend->policy != MPOL_DEFAULT || errno != ENOSYS) {
+            error_setg_errno(errp, errno,
+                             "cannot bind memory to host NUMA nodes");
+            return;
         }
+    }
 #endif
-        /* Preallocate memory after the NUMA policy has been instantiated.
-         * This is necessary to guarantee memory is allocated with
-         * specified NUMA policy in place.
-         */
-        if (backend->prealloc) {
-            qemu_prealloc_mem(memory_region_get_fd(&backend->mr), ptr, sz,
-                              backend->prealloc_threads,
-                              backend->prealloc_context, &local_err);
-            if (local_err) {
-                goto out;
-            }
+    /* Preallocate memory after the NUMA policy has been instantiated.
+     * This is necessary to guarantee memory is allocated with
+     * specified NUMA policy in place.
+     */
+    if (backend->prealloc) {
+        qemu_prealloc_mem(memory_region_get_fd(&backend->mr), ptr, sz,
+                          backend->prealloc_threads,
+                          backend->prealloc_context, &local_err);
+        if (local_err) {
+            goto out;
         }
     }
 out:
-- 
2.41.0


