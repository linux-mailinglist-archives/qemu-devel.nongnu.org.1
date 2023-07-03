Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0350C745DBC
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrn-0008Pd-Mb; Mon, 03 Jul 2023 09:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJrA-0007a2-LV
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:44 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr3-0005iZ-5a
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:43 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3143b72c5ffso431318f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391875; x=1690983875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKTgq9uBhU4V0WOGT1hkvfyceDee9sFu3Y7Qjj/4CPk=;
 b=Y3C4P6Q/5PTpF5cTEX3mp5wEAJJn//lzTHLzFWr0vsXQBpc4AOaPwACpSOcIyApUiw
 uMZ7NYpKaJLK/eh3HtGK/X35bly/oaMI7ScmoMtGnYQr2KimEIoIXBUBdapUg+f61VBI
 1WONwTDrk/mekWtrMlzibTv/h0fN0XGSSWF9xKE/gzXLhc14kWPlYYvcNaguNsmeLRHF
 oM90w8Thhb7BHyam47gbJ8niwFHnwu3wzaSk/vN7tMbwLdj4/T3MQveD3/57rlxZ8S/q
 aVYKMvU1xPE/fBlMCrkkbRwQiU5n2sTvEJAyqf73kmZvnO2pOiAATubVmHpSSsWPfpoE
 V3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391875; x=1690983875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKTgq9uBhU4V0WOGT1hkvfyceDee9sFu3Y7Qjj/4CPk=;
 b=CEX6lFPPE5hZBPXHFHp8cJ1Krz02XQSMJtqRF3xvClH1P8dcQPKIkqvTfP1NoEnbdG
 KV3AFfnD8wbdrEqOULR1kBpyS6qEnHmd2pmiONP8F/x3ub5+v5ami1X7X26i+r4uuofE
 fBNJ1fkkXpdq2PnPWg5vubhe1QT4CIPf3X+WWeH4dX98NSYinZTKQJnnt6OmOLQqXeSX
 /BvmlbEbPri99Z5PEmkXMJ7F1YmLUhv+QFQcBGhqcEZeVVgmadrcXHxhLnHSj/tpvt4s
 SV2gQ31sWXc43xOWCL1PO55jKFySpAa3tAl/b4TB5EiuwBQdzqj51T8+QBimxuHmtgMP
 Vyuw==
X-Gm-Message-State: ABy/qLYfJTR1Ke814z5CRGHKJVQbhfccCPHScVs+FJkh2CLfL4EYwwo3
 UCDhRXcs9sVDLSWhxSmHyAJgGw==
X-Google-Smtp-Source: APBJJlFYfnyc9hFfv+NPVHP+tK+bPZVGNRkqT3JaOEWO4rMVeZYEvYoKZgaRxHJtRmsjs2x+M7APOQ==
X-Received: by 2002:adf:ef12:0:b0:314:50d:4540 with SMTP id
 e18-20020adfef12000000b00314050d4540mr12164308wro.18.1688391875602; 
 Mon, 03 Jul 2023 06:44:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c8-20020adfed88000000b0031433443265sm4152449wro.53.2023.07.03.06.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:34 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 070C51FFCA;
 Mon,  3 Jul 2023 14:44:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robert Henry <robhenry@microsoft.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 19/38] plugins: force slow path when plugins instrument memory
 ops
Date: Mon,  3 Jul 2023 14:44:08 +0100
Message-Id: <20230703134427.1389440-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

The lack of SVE memory instrumentation has been an omission in plugin
handling since it was introduced. Fortunately we can utilise the
probe_* functions to force all all memory access to follow the slow
path. We do this by checking the access type and presence of plugin
memory callbacks and if set return the TLB_MMIO flag.

We have to jump through a few hoops in user mode to re-use the flag
but it was the desired effect:

 ./qemu-system-aarch64 -display none -serial mon:stdio \
   -M virt -cpu max -semihosting-config enable=on \
   -kernel ./tests/tcg/aarch64-softmmu/memory-sve \
   -plugin ./contrib/plugins/libexeclog.so,ifilter=st1w,afilter=0x40001808 -d plugin

gives (disas doesn't currently understand st1w):

  0, 0x40001808, 0xe54342a0, ".byte 0xa0, 0x42, 0x43, 0xe5", store, 0x40213010, RAM, store, 0x40213014, RAM, store, 0x40213018, RAM

And for user-mode:

  ./qemu-aarch64 \
    -plugin contrib/plugins/libexeclog.so,afilter=0x4007c0 \
    -d plugin \
    ./tests/tcg/aarch64-linux-user/sha512-sve

gives:

  1..10
  ok 1 - do_test(&tests[i])
  0, 0x4007c0, 0xa4004b80, ".byte 0x80, 0x4b, 0x00, 0xa4", load, 0x5500800370, load, 0x5500800371, load, 0x5500800372, load, 0x5500800373, load, 0x5500800374, load, 0x5500800375, load, 0x5500800376, load, 0x5500800377, load, 0x5500800378, load, 0x5500800379, load, 0x550080037a, load, 0x550080037b, load, 0x550080037c, load, 0x550080037d, load, 0x550080037e, load, 0x550080037f, load, 0x5500800380, load, 0x5500800381, load, 0x5500800382, load, 0x5500800383, load, 0x5500800384, load, 0x5500800385, load, 0x5500800386, lo
  ad, 0x5500800387, load, 0x5500800388, load, 0x5500800389, load, 0x550080038a, load, 0x550080038b, load, 0x550080038c, load, 0x550080038d, load, 0x550080038e, load, 0x550080038f, load, 0x5500800390, load, 0x5500800391, load, 0x5500800392, load, 0x5500800393, load, 0x5500800394, load, 0x5500800395, load, 0x5500800396, load, 0x5500800397, load, 0x5500800398, load, 0x5500800399, load, 0x550080039a, load, 0x550080039b, load, 0x550080039c, load, 0x550080039d, load, 0x550080039e, load, 0x550080039f, load, 0x55008003a0, load, 0x55008003a1, load, 0x55008003a2, load, 0x55008003a3, load, 0x55008003a4, load, 0x55008003a5, load, 0x55008003a6, load, 0x55008003a7, load, 0x55008003a8, load, 0x55008003a9, load, 0x55008003aa, load, 0x55008003ab, load, 0x55008003ac, load, 0x55008003ad, load, 0x55008003ae, load, 0x55008003af

(4007c0 is the ld1b in the sha512-sve)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Robert Henry <robhenry@microsoft.com>
Cc: Aaron Lindsay <aaron@os.amperecomputing.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-20-alex.bennee@linaro.org>

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 8018ce783e..472fe9ad9c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -301,7 +301,7 @@ CPUArchState *cpu_copy(CPUArchState *env);
  * be signaled by probe_access_flags().
  */
 #define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-#define TLB_MMIO            0
+#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
 #define TLB_WATCHPOINT      0
 
 #else
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 200c27eadf..5fa0687cd2 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -464,6 +464,29 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool nonfault, void **phost,
                       CPUTLBEntryFull **pfull, uintptr_t retaddr);
+
+/**
+ * probe_access_mmu() - Like probe_access_full except cannot fault and
+ * doesn't trigger instrumentation.
+ *
+ * @env: CPUArchState
+ * @vaddr: virtual address to probe
+ * @size: size of the probe
+ * @access_type: read, write or execute permission
+ * @mmu_idx: softmmu index
+ * @phost: ptr to return value host address or NULL
+ * @pfull: ptr to return value CPUTLBEntryFull structure or NULL
+ *
+ * The CPUTLBEntryFull structure returned via @pfull is transient
+ * and must be consumed or copied immediately, before any further
+ * access or changes to TLB @mmu_idx.
+ *
+ * Returns: TLB flags as per probe_access_flags()
+ */
+int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
+                          MMUAccessType access_type, int mmu_idx,
+                          void **phost, CPUTLBEntryFull **pfull);
+
 #endif
 
 /* Hide the qatomic_read to make code a little easier on the eyes */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b08f8b7079..fdcbe87352 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -976,6 +976,23 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
 #endif
 
+/**
+ * cpu_plugin_mem_cbs_enabled() - are plugin memory callbacks enabled?
+ * @cs: CPUState pointer
+ *
+ * The memory callbacks are installed if a plugin has instrumented an
+ * instruction for memory. This can be useful to know if you want to
+ * force a slow path for a series of memory accesses.
+ */
+static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
+{
+#ifdef CONFIG_PLUGIN
+    return !!cpu->plugin_mem_cbs;
+#else
+    return false;
+#endif
+}
+
 /**
  * cpu_get_address_space:
  * @cpu: CPU to get address space from
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5b51eff5a4..c2b81ec569 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1513,13 +1513,14 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
                                  int fault_size, MMUAccessType access_type,
                                  int mmu_idx, bool nonfault,
                                  void **phost, CPUTLBEntryFull **pfull,
-                                 uintptr_t retaddr)
+                                 uintptr_t retaddr, bool check_mem_cbs)
 {
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     vaddr page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
+    bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(env_cpu(env));
     CPUTLBEntryFull *full;
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
@@ -1553,7 +1554,9 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
     flags |= full->slow_flags[access_type];
 
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
-    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))) {
+    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))
+        ||
+        (access_type != MMU_INST_FETCH && force_mmio)) {
         *phost = NULL;
         return TLB_MMIO;
     }
@@ -1569,7 +1572,7 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       uintptr_t retaddr)
 {
     int flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                      nonfault, phost, pfull, retaddr);
+                                      nonfault, phost, pfull, retaddr, true);
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
@@ -1580,6 +1583,29 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
     return flags;
 }
 
+int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
+                          MMUAccessType access_type, int mmu_idx,
+                          void **phost, CPUTLBEntryFull **pfull)
+{
+    void *discard_phost;
+    CPUTLBEntryFull *discard_tlb;
+
+    /* privately handle users that don't need full results */
+    phost = phost ? phost : &discard_phost;
+    pfull = pfull ? pfull : &discard_tlb;
+
+    int flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
+                                      true, phost, pfull, 0, false);
+
+    /* Handle clean RAM pages.  */
+    if (unlikely(flags & TLB_NOTDIRTY)) {
+        notdirty_write(env_cpu(env), addr, 1, *pfull, 0);
+        flags &= ~TLB_NOTDIRTY;
+    }
+
+    return flags;
+}
+
 int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr)
@@ -1590,7 +1616,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
 
     flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                  nonfault, phost, &full, retaddr);
+                                  nonfault, phost, &full, retaddr, true);
 
     /* Handle clean RAM pages. */
     if (unlikely(flags & TLB_NOTDIRTY)) {
@@ -1611,7 +1637,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
 
     flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                  false, &host, &full, retaddr);
+                                  false, &host, &full, retaddr, true);
 
     /* Per the interface, size == 0 merely faults the access. */
     if (size == 0) {
@@ -1644,7 +1670,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
     int flags;
 
     flags = probe_access_internal(env, addr, 0, access_type,
-                                  mmu_idx, true, &host, &full, 0);
+                                  mmu_idx, true, &host, &full, 0, false);
 
     /* No combination of flags are expected by the caller. */
     return flags ? NULL : host;
@@ -1667,7 +1693,8 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
     void *p;
 
     (void)probe_access_internal(env, addr, 1, MMU_INST_FETCH,
-                                cpu_mmu_index(env, true), false, &p, &full, 0);
+                                cpu_mmu_index(env, true), false,
+                                &p, &full, 0, false);
     if (p == NULL) {
         return -1;
     }
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 8fbcbf9771..d95b875a6a 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -745,6 +745,10 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
     if (guest_addr_valid_untagged(addr)) {
         int page_flags = page_get_flags(addr);
         if (page_flags & acc_flag) {
+            if ((acc_flag == PAGE_READ || acc_flag == PAGE_WRITE)
+                && cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+                return TLB_MMIO;
+            }
             return 0; /* success */
         }
         maperr = !(page_flags & PAGE_VALID);
@@ -767,7 +771,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
     flags = probe_access_internal(env, addr, size, access_type, nonfault, ra);
-    *phost = flags ? NULL : g2h(env_cpu(env), addr);
+    *phost = (flags & TLB_INVALID_MASK) ? NULL : g2h(env_cpu(env), addr);
     return flags;
 }
 
@@ -778,7 +782,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
     flags = probe_access_internal(env, addr, size, access_type, false, ra);
-    g_assert(flags == 0);
+    g_assert((flags & ~TLB_MMIO) == 0);
 
     return size ? g2h(env_cpu(env), addr) : NULL;
 }
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 42355caa9b..9aaff1546a 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -489,9 +489,9 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         int flags;
 
         env->tlb_fi = fi;
-        flags = probe_access_full(env, addr, 0, MMU_DATA_LOAD,
-                                  arm_to_core_mmu_idx(s2_mmu_idx),
-                                  true, &ptw->out_host, &full, 0);
+        flags = probe_access_full_mmu(env, addr, 0, MMU_DATA_LOAD,
+                                      arm_to_core_mmu_idx(s2_mmu_idx),
+                                      &ptw->out_host, &full);
         env->tlb_fi = NULL;
 
         if (unlikely(flags & TLB_INVALID_MASK)) {
@@ -644,12 +644,12 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
      */
     if (unlikely(!ptw->out_rw)) {
         int flags;
-        void *discard;
 
         env->tlb_fi = fi;
-        flags = probe_access_flags(env, ptw->out_virt, 0, MMU_DATA_STORE,
-                                   arm_to_core_mmu_idx(ptw->in_ptw_idx),
-                                   true, &discard, 0);
+        flags = probe_access_full_mmu(env, ptw->out_virt, 0,
+                                      MMU_DATA_STORE,
+                                      arm_to_core_mmu_idx(ptw->in_ptw_idx),
+                                      NULL, NULL);
         env->tlb_fi = NULL;
 
         if (unlikely(flags & TLB_INVALID_MASK)) {
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 0097522470..7c103fc9f7 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5688,9 +5688,6 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
 
     flags = info.page[0].flags | info.page[1].flags;
     if (unlikely(flags != 0)) {
-#ifdef CONFIG_USER_ONLY
-        g_assert_not_reached();
-#else
         /*
          * At least one page includes MMIO.
          * Any bus operation can fail with cpu_transaction_failed,
@@ -5727,7 +5724,6 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
             memcpy(&env->vfp.zregs[(rd + i) & 31], &scratch[i], reg_max);
         }
         return;
-#endif
     }
 
     /* The entire operation is in RAM, on valid pages. */
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 3430fd3cd8..cec1d4b287 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -91,6 +91,14 @@ sha512-vector: sha512.c
 
 TESTS += sha512-vector
 
+ifneq ($(CROSS_CC_HAS_SVE),)
+sha512-sve: CFLAGS=-O3 -march=armv8.1-a+sve
+sha512-sve: sha512.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+TESTS += sha512-sve
+endif
+
 ifeq ($(HOST_GDB_SUPPORTS_ARCH),y)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
-- 
2.39.2


