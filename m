Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A78A7A23A5
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:33:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBkd-0008Fa-Sp; Fri, 15 Sep 2023 12:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBkc-0008FQ-9E
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:33:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBka-00037U-Jr
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:33:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-69002ef0104so1941724b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694795579; x=1695400379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FATEL2ITPMFfLfw0D9PblDYxfW6TvM3iJL7m+a0EPeE=;
 b=b4DQFUMhJ6wI5PwL7uWxw2OwA1Su2n0UODw5utxrH9bhWuCIscONg9NHhKIsg07o5a
 0vQ4YHlil9t5tur45Umici3oRXmqMwJVjojLbWZnV2C+OpcHE0zsA6wrAOLZAogI2ERG
 Ip0CZFp9U5qfDUijq9SAw8M+fSzr+TmLp8fr8Tvtm/Dv8t1Q7xtF789r7/zdl4JFKbAV
 AowlsJq2URKhW4eBgNCY10BN7wf+mzHxm+xZEzsxYmkGwuq1mSAMUnV5XzbDJjzJc+Fl
 ldd8sPoyzUG4krF4XB0Bk9K+Ha+1lapVK7iDdpgJxTIgR8ZcHz7QTRSSWXKOA65534gD
 NFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694795579; x=1695400379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FATEL2ITPMFfLfw0D9PblDYxfW6TvM3iJL7m+a0EPeE=;
 b=cT2C/c+Zh5VqbReiuuHNYknx7jebbQk/lAf4I0K7rZoCgsZ7GY6bNDFeeCBgnY/IXb
 Af56wGNn10UmYMxE7OJZl89G2W75CsJLB+Leo4hbWpAKzG1wUjxnu34mfE7ukMA1F8uP
 rVF9P2028gMKmFuHwvamyPVLQMiOIwPM1IZcjoBVFhPq6L/7i+iJ3O8vFBcCx0Ghne28
 P6B2u9ADvprSxDBkmdWoidfp0lA5axEE7TW7CCAYSyrXowr2UDyHYsZFddLIskP+yziF
 xWSyzwle2Q0lSTn5ceHiNJfkYmknSD4eVUFsi9ia8207mTXBc+YMw6MrFdYKXnQg88t0
 +0tw==
X-Gm-Message-State: AOJu0YwaZcW03ln0XTf8dGa7IL7mrBJLJuoiRHcG8cOlUEsAhiJCwkmY
 Y2s2yPW/fYgOkw213SDTB93Wk7eUUyGK9QXggDA=
X-Google-Smtp-Source: AGHT+IGpQ3ewsCL4kGaCylh9FGhP9PRVZQbtRmrmetD/LOXjmTnLAx5tvoPRt/AtVJy6RuaF9DNZJQ==
X-Received: by 2002:a05:6a00:1397:b0:68c:3f2:5ff8 with SMTP id
 t23-20020a056a00139700b0068c03f25ff8mr2345537pfg.1.1694795578947; 
 Fri, 15 Sep 2023 09:32:58 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 z3-20020a637e03000000b0057754ae4eb7sm2958497pgc.39.2023.09.15.09.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:32:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 3/3] softmmu: Introduce cpu_address_space_sync
Date: Fri, 15 Sep 2023 09:32:54 -0700
Message-Id: <20230915163254.123338-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915163254.123338-1-richard.henderson@linaro.org>
References: <20230915163254.123338-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Synchronously check and update the address space for the
current cpu for any slow path access.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1866
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memory.h |  6 ++++++
 accel/tcg/cputlb.c    |  2 ++
 softmmu/physmem.c     | 20 ++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 68284428f8..7ec842076f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2780,6 +2780,12 @@ void address_space_cache_destroy(MemoryRegionCache *cache);
 IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
                                             bool is_write, MemTxAttrs attrs);
 
+/*
+ * Ensure all cpu address spaces are up-to-date.
+ * Return true if changes made and tlb flushed.
+ */
+void cpu_address_space_sync(CPUState *cpu);
+
 /* address_space_translate: translate an address range into an address space
  * into a MemoryRegion and an address range into that section.  Should be
  * called from an RCU critical section, to avoid that the last reference
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3270f65c20..91be3f3064 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1827,6 +1827,8 @@ static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
     l->page[1].size = 0;
     crosspage = (addr ^ l->page[1].addr) & TARGET_PAGE_MASK;
 
+    cpu_address_space_sync(env_cpu(env));
+
     if (likely(!crosspage)) {
         mmu_lookup1(env, &l->page[0], l->mmu_idx, type, ra);
 
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index e1c535380a..5a89caa257 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2536,6 +2536,26 @@ static void tcg_commit(MemoryListener *listener)
     }
 }
 
+void cpu_address_space_sync(CPUState *cpu)
+{
+    int i, n = cpu->num_ases;
+    bool need_flush = false;
+
+    for (i = 0; i < n; ++i) {
+        CPUAddressSpace *cpuas = &cpu->cpu_ases[i];
+        uint32_t gen = qatomic_load_acquire(&cpuas->layout_gen);
+
+        if (cpuas->commit_gen != gen) {
+            cpuas->commit_gen = gen;
+            cpuas->memory_dispatch = address_space_to_dispatch(cpuas->as);
+            need_flush = true;
+        }
+    }
+    if (need_flush) {
+        tlb_flush(cpu);
+    }
+}
+
 static void memory_map_init(void)
 {
     system_memory = g_malloc(sizeof(*system_memory));
-- 
2.34.1


