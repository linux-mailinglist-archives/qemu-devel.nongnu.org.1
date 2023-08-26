Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2077B7899D8
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 01:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa2dy-0000T0-DX; Sat, 26 Aug 2023 19:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa2dn-0000Rb-3L
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 19:24:28 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa2dh-00066R-Pf
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 19:24:25 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a7f4f7a8easo1096713b6e.2
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693092260; x=1693697060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4J6eq/v5V1H1fkQEu9wQ8wHYQUH4m1you9F+PZm5SU=;
 b=vCPnKSVbESkMAxpwhkHwJlUwtYIa1IJnx6FSggjfoNMgvBDrHFZ0TNmKfPpur7o5uc
 NsOrTk0OwVzDaQ1d3WBdllcIyhO5/j4fjSuFeU/vy8zrKYj3FIONpBkkZNVg5LkY2cAI
 fdMLj/Y58Hy0cEvJ8uFjWH0WmwNdxVVzositPEP9g7fgaujBTqmDwykU0gFIDyK8cOD4
 PThh/IyCD4hRtfvHgJfA6WGa1OM9Loiq8CAYs2hAp4zczr7+z8uPaxQZKbafrO7ivDup
 xiQM9Octg6rcYpA8flFa2ynnAPYTQUDhwSa3K4Up3uYCMG77jRDxNDEv8kD+SbbftSOB
 XhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693092260; x=1693697060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4J6eq/v5V1H1fkQEu9wQ8wHYQUH4m1you9F+PZm5SU=;
 b=cD9j4Ram9ncrIfCR77p8qWCBCnk/c75ry030iE9mOLBXHxUG2edo+lEbBARqiyiROP
 dHf51IPhURHPS0heL3414tq7B8ru9LJe+w8QmyYqGGQVG2GFYz00nMppQHzXjA533xWP
 yE4k35TUoaDMYAtSCe9Kuu8h6tRPRSASnOa8+weVxW+lBDzulvP8uunpv6GdTzx4oe59
 OZ/av3yznCzwI6i6b/MvndfpEwYjquszRpz0Hx0zvghca422LyaYFf7RedRq0fIlp7V+
 0QHejAUdHrBAsofK3gNyeIk94OiPVrnVW2jlLGhsuVEzHxfgehm5byGPOmyQ4j2wLXQM
 GQgw==
X-Gm-Message-State: AOJu0Yx5fY+GAGCfuBDz8pSDazCK3hwtiQDrQDo9MXmS8D6L9fpdB9N1
 4iU8qkpub9ZaTBSrpq4dPRz2J64tMYt02Z+hcFE=
X-Google-Smtp-Source: AGHT+IEkgIcT5guGsEKuGfa+eAq48d6tDFs0OaE+85KLlPVb7e0mF+WK+sN9mPWT4fSh8vqFCs7C/Q==
X-Received: by 2002:a54:441a:0:b0:3a8:f3e7:d691 with SMTP id
 k26-20020a54441a000000b003a8f3e7d691mr6534937oiw.37.1693092260577; 
 Sat, 26 Aug 2023 16:24:20 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 u9-20020a63a909000000b005633311c70dsm4226472pge.32.2023.08.26.16.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Aug 2023 16:24:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	pbonzini@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH 2/3] softmmu: Use async_run_on_cpu in tcg_commit
Date: Sat, 26 Aug 2023 16:24:14 -0700
Message-Id: <20230826232415.80233-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230826232415.80233-1-richard.henderson@linaro.org>
References: <20230826232415.80233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

After system startup, run the update to memory_dispatch
and the tlb_flush on the cpu.  This eliminates a race,
wherein a running cpu sees the memory_dispatch change
but has not yet seen the tlb_flush.

Since the update now happens on the cpu, we need not use
qatomic_rcu_read to protect the read of memory_dispatch.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1826
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1834
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1846
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 softmmu/physmem.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 7597dc1c39..18277ddd67 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -680,8 +680,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
     IOMMUTLBEntry iotlb;
     int iommu_idx;
     hwaddr addr = orig_addr;
-    AddressSpaceDispatch *d =
-        qatomic_rcu_read(&cpu->cpu_ases[asidx].memory_dispatch);
+    AddressSpaceDispatch *d = cpu->cpu_ases[asidx].memory_dispatch;
 
     for (;;) {
         section = address_space_translate_internal(d, addr, &addr, plen, false);
@@ -2412,7 +2411,7 @@ MemoryRegionSection *iotlb_to_section(CPUState *cpu,
 {
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
     CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
-    AddressSpaceDispatch *d = qatomic_rcu_read(&cpuas->memory_dispatch);
+    AddressSpaceDispatch *d = cpuas->memory_dispatch;
     int section_index = index & ~TARGET_PAGE_MASK;
     MemoryRegionSection *ret;
 
@@ -2487,23 +2486,42 @@ static void tcg_log_global_after_sync(MemoryListener *listener)
     }
 }
 
+static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
+{
+    CPUAddressSpace *cpuas = data.host_ptr;
+
+    cpuas->memory_dispatch = address_space_to_dispatch(cpuas->as);
+    tlb_flush(cpu);
+}
+
 static void tcg_commit(MemoryListener *listener)
 {
     CPUAddressSpace *cpuas;
-    AddressSpaceDispatch *d;
+    CPUState *cpu;
 
     assert(tcg_enabled());
     /* since each CPU stores ram addresses in its TLB cache, we must
        reset the modified entries */
     cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
-    cpu_reloading_memory_map();
-    /* The CPU and TLB are protected by the iothread lock.
-     * We reload the dispatch pointer now because cpu_reloading_memory_map()
-     * may have split the RCU critical section.
+    cpu = cpuas->cpu;
+
+    /*
+     * Defer changes to as->memory_dispatch until the cpu is quiescent.
+     * Otherwise we race between (1) other cpu threads and (2) ongoing
+     * i/o for the current cpu thread, with data cached by mmu_lookup().
+     *
+     * In addition, queueing the work function will kick the cpu back to
+     * the main loop, which will end the RCU critical section and reclaim
+     * the memory data structures.
+     *
+     * That said, the listener is also called during realize, before
+     * all of the tcg machinery for run-on is initialized: thus halt_cond.
      */
-    d = address_space_to_dispatch(cpuas->as);
-    qatomic_rcu_set(&cpuas->memory_dispatch, d);
-    tlb_flush(cpuas->cpu);
+    if (cpu->halt_cond) {
+        async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas));
+    } else {
+        tcg_commit_cpu(cpu, RUN_ON_CPU_HOST_PTR(cpuas));
+    }
 }
 
 static void memory_map_init(void)
-- 
2.34.1


