Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC0E78CA1C
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb27K-0002Zi-Gf; Tue, 29 Aug 2023 13:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb278-0002Sy-3R
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:02:52 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb273-00051l-0z
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:02:47 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-26d4e1ba2dbso2638070a91.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328563; x=1693933363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fWjdOHprwcmj6rv2NjOsjHYB5i71/EZpwY5eum6Xvx8=;
 b=mLdLTWTVRb38qFnbXFDhp8W+DiVhbxemX2L+zdUU8UfWmTpola/h7DZ4VnJ4aNj/e3
 pyCwlAwndHOQCAC07JVnJS10OZBg71z/WPiugkvCuwtNWcdVKi14y/kGs0o9Fx1/WUIm
 SueFsaeyS9ZLLqBN5kouqZBvypVDDE7VUxHhF9BSdIZMGZQnsQJIFZOZLVfVhRMNlu4D
 RO+/vU0JtfxFRnTezD9zliXmDWIAUMhscFja4nBj00jRbmf/NUB1JwVi9IyH1Y2O071h
 iXtPpAFcT2BZm7ZJ1SK/35hUBNXqXnqp0cvO2Vit2d+fTnXvyiDRHA/jcPe5lgMvOiSl
 r0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328563; x=1693933363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWjdOHprwcmj6rv2NjOsjHYB5i71/EZpwY5eum6Xvx8=;
 b=DFpSrjF8lv2AZQdiR+FIpOs7Okvwi67QmnaKBohmJi98w2krmfaxQk9IDe0QGVuIxB
 TJurt6oJVIWOebD9ChB0cReqrfu/LNfslswogApkmlJilfZ0jcS4yHf3BtEgYCieHLI9
 5Dgn+mTL9dvJcwHOfyke9OjBuRTDFyQ8Jetyq6R0WosMqPrsFUTaqmCBzX82eNfC9Hpl
 ZS3TX8x4r34Qjr+82D8EzQDFqFY8GLv/sSJRbOTxThJACOaCF5x3TcAli1+rlYiIrWAO
 Z5XsIm3J/WA+Kjln36wasGX4JmZ4dcOs5LRm/bCr4EajO7sGlB/vvlmdffzBtXmbSHPy
 ILjQ==
X-Gm-Message-State: AOJu0YySD5jg0EVUrd/rhqLQc6NL7Ond94OM4EzeZsCLq2tG/ecWCFh4
 QwsWh0LgtPYPm3PqVd2dSsmzp3w4iYSS3K/C6DE=
X-Google-Smtp-Source: AGHT+IHVaFkZBFYRMIrmm0RuGFZisDG4R8kTdE9Z4VFqz6SRGUiZIIzeqHZnW3qlEnb1i/Y5X40E3w==
X-Received: by 2002:a17:90b:3753:b0:268:c5c7:f7f1 with SMTP id
 ne19-20020a17090b375300b00268c5c7f7f1mr21687533pjb.29.1693328563332; 
 Tue, 29 Aug 2023 10:02:43 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 cv2-20020a17090afd0200b00267b7c5d232sm10989645pjb.48.2023.08.29.10.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 10:02:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 2/4] softmmu: Use async_run_on_cpu in tcg_commit
Date: Tue, 29 Aug 2023 10:02:38 -0700
Message-Id: <20230829170240.765996-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829170240.765996-1-richard.henderson@linaro.org>
References: <20230829170240.765996-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h   |  1 -
 accel/tcg/cpu-exec-common.c | 30 ----------------------------
 softmmu/physmem.c           | 40 +++++++++++++++++++++++++++----------
 3 files changed, 29 insertions(+), 42 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 87dc9a752c..41788c0bdd 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -133,7 +133,6 @@ static inline void cpu_physical_memory_write(hwaddr addr,
 {
     cpu_physical_memory_rw(addr, (void *)buf, len, true);
 }
-void cpu_reloading_memory_map(void);
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
                               bool is_write);
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 9a5fabf625..7e35d7f4b5 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -33,36 +33,6 @@ void cpu_loop_exit_noexc(CPUState *cpu)
     cpu_loop_exit(cpu);
 }
 
-#if defined(CONFIG_SOFTMMU)
-void cpu_reloading_memory_map(void)
-{
-    if (qemu_in_vcpu_thread() && current_cpu->running) {
-        /* The guest can in theory prolong the RCU critical section as long
-         * as it feels like. The major problem with this is that because it
-         * can do multiple reconfigurations of the memory map within the
-         * critical section, we could potentially accumulate an unbounded
-         * collection of memory data structures awaiting reclamation.
-         *
-         * Because the only thing we're currently protecting with RCU is the
-         * memory data structures, it's sufficient to break the critical section
-         * in this callback, which we know will get called every time the
-         * memory map is rearranged.
-         *
-         * (If we add anything else in the system that uses RCU to protect
-         * its data structures, we will need to implement some other mechanism
-         * to force TCG CPUs to exit the critical section, at which point this
-         * part of this callback might become unnecessary.)
-         *
-         * This pair matches cpu_exec's rcu_read_lock()/rcu_read_unlock(), which
-         * only protects cpu->as->dispatch. Since we know our caller is about
-         * to reload it, it's safe to split the critical section.
-         */
-        rcu_read_unlock();
-        rcu_read_lock();
-    }
-}
-#endif
-
 void cpu_loop_exit(CPUState *cpu)
 {
     /* Undo the setting in cpu_tb_exec.  */
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


