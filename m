Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C923C83674F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:13:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRvyQ-0004Is-C3; Mon, 22 Jan 2024 10:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rRvyM-0004Hy-Sy
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:12:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rRvyK-0003cH-SD
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705936343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l20pWk89ZMNI9RJydz+Cxj+WYc8ObkedL3T/1eQWtzg=;
 b=DDUGAi+ctUvbtupPDzGQS3UvWUk0Bac5BqvvtbTayZ7Ayo3A3dNrAqZCCEIdh+AIWV5ax0
 WAaHmp3iKS4uV+8W0ld6rnwBbPcuyWdRSQUE6nFh+AqgAgn27HOGrdse6vtGksqiIVxeP2
 xXFXSskPmMdp410vwL0O/XQrPgcsMbk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-y7OmrsfYPwKemMQfQMHSUQ-1; Mon, 22 Jan 2024 10:12:21 -0500
X-MC-Unique: y7OmrsfYPwKemMQfQMHSUQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40e9d6a366aso33742975e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 07:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705936339; x=1706541139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l20pWk89ZMNI9RJydz+Cxj+WYc8ObkedL3T/1eQWtzg=;
 b=FrcFzPAGqU6NJXlXuVT3skzG3bKShLSR4Uf8LR7Z4hz0VgeobgQ2EUuTKjWJ3fMPEO
 14yqA1sTQtMFTDt/mmc0cdt7UIjC4SJTy0QUBQ63cjqxWigTgmESOgjqmQ13MFf+yAD0
 DkE2No6bzyu/mjM7QgpV0KT2+1cKHgB8+kOlX0a9V1A5Cf6UAj14qpEJ9Ajunxnthosz
 eN7ic7/+YrrZqZruIdkAIQH2Y8z6ft6TCMm9ctF4d4cLETO1tIt7czCOwJqf8xfymUVc
 peSA6y9wyBBmALvbIGHcFYL5LMn5h9hlIx5S+9M1gDIHskXjVLOooxI4G3A4Kk1mLaCH
 bZfw==
X-Gm-Message-State: AOJu0YyllHKzo5wYWte7mUZSPYvkLL2IVmgpwQBxjVb/VPc81nYAJQRv
 qfRmd4XK/cnyW3XEHVUS7Tl1EIbZnM0ddziJ+sWdq4ykbVzYGgrhwOVqYiKLzOT35XWtJk9lGjY
 Jj3NzgDGw60w+MXbiN/C9qumIWx4wZ7D1rqUZD4g9xi7AS2zJ84MLOL1M3U1C1HUUtKXNISp6xQ
 CNMNn3QKsR5W9CxSlunQVu78yyTyG0T+1DSpFu
X-Received: by 2002:a05:600c:4292:b0:40e:5ad1:5820 with SMTP id
 v18-20020a05600c429200b0040e5ad15820mr2360858wmc.161.1705936339635; 
 Mon, 22 Jan 2024 07:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU7pIzXU5V0DyNVSgHWiHcTOmKQP8U4GOPOdTx0Yw5yymjpYb1j2I4hHXnfukTf0J8XTdaAQ==
X-Received: by 2002:a05:600c:4292:b0:40e:5ad1:5820 with SMTP id
 v18-20020a05600c429200b0040e5ad15820mr2360851wmc.161.1705936339186; 
 Mon, 22 Jan 2024 07:12:19 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 iv17-20020a05600c549100b0040e5034d8e0sm43676181wmb.43.2024.01.22.07.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 07:12:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH] cpu-exec: simplify jump cache management
Date: Mon, 22 Jan 2024 16:12:17 +0100
Message-ID: <20240122151217.348058-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Unless I'm missing something egregious, the jmp cache is only every
populated with a valid entry by the same thread that reads the cache.
Therefore, the contents of any valid entry are always consistent and
there is no need for any acquire/release magic.

Indeed ->tb has to be accessed with atomics, because concurrent
invalidations would otherwise cause data races.  But ->pc is only ever
accessed by one thread, and accesses to ->tb and ->pc within tb_lookup
can never race with another tb_lookup.  While the TranslationBlock
(especially the flags) could be modified by a concurrent invalidation,
store-release and load-acquire operations on the cache entry would
not add any additional ordering beyond what you get from performing
the accesses within a single thread.

Because of this, there is really nothing to win in splitting the CF_PCREL
and !CF_PCREL paths.  It is easier to just always use the ->pc field in
the jump cache.

I noticed this while working on splitting commit 8ed558ec0cb
("accel/tcg: Introduce TARGET_TB_PCREL", 2022-10-04) into multiple
pieces, for the sake of finding a more fine-grained bisection
result for https://gitlab.com/qemu-project/qemu/-/issues/2092.
It does not (and does not intend to) fix that issue; therefore
it may make sense to not commit it until the root cause
of issue #2092 is found.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tb-jmp-cache.h |  8 +++---
 accel/tcg/cpu-exec.c     | 56 +++++++++++++++-------------------------
 2 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/accel/tcg/tb-jmp-cache.h b/accel/tcg/tb-jmp-cache.h
index bb424c8a05b..4ab8553afcc 100644
--- a/accel/tcg/tb-jmp-cache.h
+++ b/accel/tcg/tb-jmp-cache.h
@@ -13,9 +13,11 @@
 #define TB_JMP_CACHE_SIZE (1 << TB_JMP_CACHE_BITS)
 
 /*
- * Accessed in parallel; all accesses to 'tb' must be atomic.
- * For CF_PCREL, accesses to 'pc' must be protected by a
- * load_acquire/store_release to 'tb'.
+ * Invalidated in parallel; all accesses to 'tb' must be atomic.
+ * A valid entry is read/written by a single CPU, therefore there is
+ * no need for qatomic_rcu_read() and pc is always consistent with a
+ * non-NULL value of 'tb'.  Strictly speaking pc is only needed for
+ * CF_PCREL, but it's used always for simplicity.
  */
 struct CPUJumpCache {
     struct rcu_head rcu;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 67eda9865ee..bdccf375288 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -253,43 +253,29 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, vaddr pc,
     hash = tb_jmp_cache_hash_func(pc);
     jc = cpu->tb_jmp_cache;
 
-    if (cflags & CF_PCREL) {
-        /* Use acquire to ensure current load of pc from jc. */
-        tb = qatomic_load_acquire(&jc->array[hash].tb);
-
-        if (likely(tb &&
-                   jc->array[hash].pc == pc &&
-                   tb->cs_base == cs_base &&
-                   tb->flags == flags &&
-                   tb_cflags(tb) == cflags)) {
-            return tb;
-        }
-        tb = tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
-        if (tb == NULL) {
-            return NULL;
-        }
-        jc->array[hash].pc = pc;
-        /* Ensure pc is written first. */
-        qatomic_store_release(&jc->array[hash].tb, tb);
-    } else {
-        /* Use rcu_read to ensure current load of pc from *tb. */
-        tb = qatomic_rcu_read(&jc->array[hash].tb);
-
-        if (likely(tb &&
-                   tb->pc == pc &&
-                   tb->cs_base == cs_base &&
-                   tb->flags == flags &&
-                   tb_cflags(tb) == cflags)) {
-            return tb;
-        }
-        tb = tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
-        if (tb == NULL) {
-            return NULL;
-        }
-        /* Use the pc value already stored in tb->pc. */
-        qatomic_set(&jc->array[hash].tb, tb);
+    tb = qatomic_read(&jc->array[hash].tb);
+    if (likely(tb &&
+               jc->array[hash].pc == pc &&
+               tb->cs_base == cs_base &&
+               tb->flags == flags &&
+               tb_cflags(tb) == cflags)) {
+        goto hit;
     }
 
+    tb = tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
+    if (tb == NULL) {
+        return NULL;
+    }
+
+    jc->array[hash].pc = pc;
+    qatomic_set(&jc->array[hash].tb, tb);
+
+hit:
+    /*
+     * As long as tb is not NULL, the contents are consistent.  Therefore,
+     * the virtual PC has to match for non-CF_PCREL translations.
+     */
+    assert((tb_cflags(tb) & CF_PCREL) || tb->pc == pc);
     return tb;
 }
 
-- 
2.43.0


