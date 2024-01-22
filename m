Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F26083685D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:34:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwJY-0003Zj-Kb; Mon, 22 Jan 2024 10:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rRwJW-0003ZO-Qw
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:34:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rRwJU-0007Pj-Do
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705937655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+7P5ipDvKnmA5AmW+74Fn4dvN3Z0iN+Z9S+DLDhIE78=;
 b=R6h9ssSz6PLyTjzZDeamSErfYIy/mi2EYTF94fwPoUU8f20dyi/G3mgFpKs98Ow+hCCAdO
 2KtbmiNWv5+Wbt18wDu6KlI5vUqEKZgTuIq1ymljdUBwXHjakJpSAxhrgiwU6JL5jVs0OZ
 8Vi7mlHoMAe6vyt6KhBBqvtDPC9sdKE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-QeARJw_BPdGTEXjSxyYorQ-1; Mon, 22 Jan 2024 10:34:13 -0500
X-MC-Unique: QeARJw_BPdGTEXjSxyYorQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e59340c2aso31129125e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 07:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705937652; x=1706542452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+7P5ipDvKnmA5AmW+74Fn4dvN3Z0iN+Z9S+DLDhIE78=;
 b=relkxVdhbhJjiDjB03loat4JqqwSG5KmdpG0DJuEvdBhUzMHnkMWSOqSyZ1hho2m57
 VP0FOqNtCz3rYxXSRakc6R9bDVieTXkpyzufIAClg0CtWvOkTC8SU6PzBW5DKp82nIda
 zi9yVJWJ0h9CtAhuUrln5EOPfQVJT/a/4dUJX4lWSqK8xuHgioJNnBxmgHLYulywv7Ss
 JuYbCk3DETeofk3RTdjrRQKnEu6oc24dg8DyCYHnDwGOenbNBCT9iM7EkL9aK5Cq4Jge
 o1dNOrcmy/Ufz41Ot5GHfJu2oOKqAKYopqC305T0WPzzT3sL4E0WHiR9WMaxQ6cedHE4
 rN1Q==
X-Gm-Message-State: AOJu0YxTDxPWSIqzvTIBkSvbM2iuAC+hg1Ek96NuPWIiDQ6Igp2M/FCB
 xYEYT03kTPnDU7DX3I1NB3lJ3799ELhnmJNiPDCixtZ7Mw6lhCPMSeVJc1xbamZl1wKaqnsqlYh
 j0rs2Mwm1fNNHdFRh6RbOeB4pJawAl4T4pu7SRqCpInXAJMVqQz2iuB5hkXFVAFM8Wb6mHYbfe7
 R1oy4UZREKbNCkKX6byXoA6Ci901vqriRAP5hO
X-Received: by 2002:a05:600c:4792:b0:40d:6af2:f965 with SMTP id
 k18-20020a05600c479200b0040d6af2f965mr1727496wmo.106.1705937651874; 
 Mon, 22 Jan 2024 07:34:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY8XlAtkZpb/ezDeYsebtkIyLQdKM5wxAur/d/9tL6HVx+jP4o03lQAiSdiLhcpP82zVy1Kw==
X-Received: by 2002:a05:600c:4792:b0:40d:6af2:f965 with SMTP id
 k18-20020a05600c479200b0040d6af2f965mr1727488wmo.106.1705937651368; 
 Mon, 22 Jan 2024 07:34:11 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 n4-20020adffe04000000b00339272c885csm6921113wrr.87.2024.01.22.07.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 07:34:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2] cpu-exec: simplify jump cache management
Date: Mon, 22 Jan 2024 16:34:09 +0100
Message-ID: <20240122153409.351959-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 accel/tcg/tb-jmp-cache.h |  8 +++--
 accel/tcg/cpu-exec.c     | 66 ++++++++++++++--------------------------
 2 files changed, 28 insertions(+), 46 deletions(-)

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
index 67eda9865ee..40c268bfa1f 100644
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
 
@@ -1012,14 +998,8 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                  */
                 h = tb_jmp_cache_hash_func(pc);
                 jc = cpu->tb_jmp_cache;
-                if (cflags & CF_PCREL) {
-                    jc->array[h].pc = pc;
-                    /* Ensure pc is written first. */
-                    qatomic_store_release(&jc->array[h].tb, tb);
-                } else {
-                    /* Use the pc value already stored in tb->pc. */
-                    qatomic_set(&jc->array[h].tb, tb);
-                }
+                jc->array[h].pc = pc;
+                qatomic_set(&jc->array[h].tb, tb);
             }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.43.0


