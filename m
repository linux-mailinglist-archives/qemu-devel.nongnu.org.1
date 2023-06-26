Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E873E3D4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKZ-0000PG-P5; Mon, 26 Jun 2023 11:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJq-0000Ie-82
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJl-0002q0-AP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:57 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-313f363a6f1so1043038f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793991; x=1690385991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=127W7wRPbfPQOykLNoSBb4NbL3xPnrED2pwGlM7FDmI=;
 b=DGEoL4kZUJug8GivfqPyYyJrVh1wB+EvziHjvvlnNcvReJODYZi7iFNNUy709oHqwO
 lpF+McSzJfOHaeqnnvp3c8tZkQ/y4EOT0mC5os2cmHAZYAN3WgZcBWs4+Ddez1+MCm/N
 G0E12nUPx+U21XFlIOGqZQvusqjgXPatGpdk2TmNNKQd+YpvNEjHjsZEXlcXrgaQ3A1r
 sQP1qLARZmlbC58xkZInKEKqVNBVvQphKS1kia5HVUztOSRF2nV5Gh77o1GGrfqyhKnu
 ltLr+9etvtcd0zjr49bKrCz4sD1QaYfKShqNre7iB6BzlWCgtl73mtrGGgiUQwqKnkBa
 McSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793991; x=1690385991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=127W7wRPbfPQOykLNoSBb4NbL3xPnrED2pwGlM7FDmI=;
 b=GG79wONojNcrNONn85falvK/R8bo9lOfLh1Z5tibF/jAn987u5G13Lsq8LeQOwknIL
 vuvlv5a2+RtGeu3C+MS/fyWOyYvsgQIbn1+drwVOVyiRdPJrkRVHBZKlMlm3qnHduSG1
 TI5l+Z/KVukaSrYDRO+1J/ao0BKUBaaKpvdQRHOBo6xBdMkccdjVb+UqprIeQYFukAJE
 mr9WL8q28MaCoaU/VovoVhHTBYz/ULvUFgBkugHC6tkMFzlP0XJpajgNJTwIju6ZCMop
 3dyYgm5BoAxn4iFxwERJ2BNwgkomIBzDHdunOspJoiRBTAXJQUeiJa1Va62traxUrgQM
 siFw==
X-Gm-Message-State: AC+VfDy0S5yMFmBfLHF7drKKW9ldd2WSfNY4m5kIzb0Akee//f6oiwqs
 kOcaxJajeISZYtoeeTnVv24TiWXjgj6uKmuOZ6wpJ9Hk
X-Google-Smtp-Source: ACHHUZ6vMKjQgUQdKSD00pxRru7Ld8/KGU0cUswhvpo8L9H4gVf/P631fci0KxiEgWXK3h17ROQ2Mw==
X-Received: by 2002:a5d:4f11:0:b0:313:dfa2:1a85 with SMTP id
 c17-20020a5d4f11000000b00313dfa21a85mr5605363wru.27.1687793991507; 
 Mon, 26 Jun 2023 08:39:51 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 08/22] accel: Replace target_ulong with vaddr in probe_*()
Date: Mon, 26 Jun 2023 17:39:31 +0200
Message-Id: <20230626153945.76180-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

From: Anton Johansson <anjo@rev.ng>

Functions for probing memory accesses (and functions that call these)
are updated to take a vaddr for guest virtual addresses over
target_ulong.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621135633.1649-9-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 14 +++++++-------
 accel/stubs/tcg-stub.c  |  4 ++--
 accel/tcg/cputlb.c      | 12 ++++++------
 accel/tcg/user-exec.c   |  8 ++++----
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index f5508e242b..cc1c3556f6 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -413,16 +413,16 @@ static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
  * Finally, return the host address for a page that is backed by RAM,
  * or NULL if the page requires I/O.
  */
-void *probe_access(CPUArchState *env, target_ulong addr, int size,
+void *probe_access(CPUArchState *env, vaddr addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
 
-static inline void *probe_write(CPUArchState *env, target_ulong addr, int size,
+static inline void *probe_write(CPUArchState *env, vaddr addr, int size,
                                 int mmu_idx, uintptr_t retaddr)
 {
     return probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
 }
 
-static inline void *probe_read(CPUArchState *env, target_ulong addr, int size,
+static inline void *probe_read(CPUArchState *env, vaddr addr, int size,
                                int mmu_idx, uintptr_t retaddr)
 {
     return probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
@@ -447,7 +447,7 @@ static inline void *probe_read(CPUArchState *env, target_ulong addr, int size,
  * Do handle clean pages, so exclude TLB_NOTDIRY from the returned flags.
  * For simplicity, all "mmio-like" flags are folded to TLB_MMIO.
  */
-int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
+int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr);
 
@@ -460,7 +460,7 @@ int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
  * and must be consumed or copied immediately, before any further
  * access or changes to TLB @mmu_idx.
  */
-int probe_access_full(CPUArchState *env, target_ulong addr, int size,
+int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool nonfault, void **phost,
                       CPUTLBEntryFull **pfull, uintptr_t retaddr);
@@ -581,7 +581,7 @@ struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
  *
  * Note: this function can trigger an exception.
  */
-tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
                                         void **hostp);
 
 /**
@@ -596,7 +596,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
  * Note: this function can trigger an exception.
  */
 static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
-                                                target_ulong addr)
+                                                vaddr addr)
 {
     return get_page_addr_code_hostp(env, addr, NULL);
 }
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 0998e601ad..a9e7a2d5b4 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -26,14 +26,14 @@ void tcg_flush_jmp_cache(CPUState *cpu)
 {
 }
 
-int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
+int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr)
 {
      g_assert_not_reached();
 }
 
-void *probe_access(CPUArchState *env, target_ulong addr, int size,
+void *probe_access(CPUArchState *env, vaddr addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
      /* Handled by hardware accelerator. */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index bdf400f6e6..d873e58a5d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1499,7 +1499,7 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
     }
 }
 
-static int probe_access_internal(CPUArchState *env, target_ulong addr,
+static int probe_access_internal(CPUArchState *env, vaddr addr,
                                  int fault_size, MMUAccessType access_type,
                                  int mmu_idx, bool nonfault,
                                  void **phost, CPUTLBEntryFull **pfull,
@@ -1508,7 +1508,7 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
-    target_ulong page_addr = addr & TARGET_PAGE_MASK;
+    vaddr page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK;
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
@@ -1551,7 +1551,7 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
     return flags;
 }
 
-int probe_access_full(CPUArchState *env, target_ulong addr, int size,
+int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool nonfault, void **phost, CPUTLBEntryFull **pfull,
                       uintptr_t retaddr)
@@ -1568,7 +1568,7 @@ int probe_access_full(CPUArchState *env, target_ulong addr, int size,
     return flags;
 }
 
-int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
+int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr)
 {
@@ -1589,7 +1589,7 @@ int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
     return flags;
 }
 
-void *probe_access(CPUArchState *env, target_ulong addr, int size,
+void *probe_access(CPUArchState *env, vaddr addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     CPUTLBEntryFull *full;
@@ -1648,7 +1648,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
  * NOTE: This function will trigger an exception if the page is
  * not executable.
  */
-tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
                                         void **hostp)
 {
     CPUTLBEntryFull *full;
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index dc8d6b5d40..d71e26a7b5 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -721,7 +721,7 @@ int page_unprotect(target_ulong address, uintptr_t pc)
     return current_tb_invalidated ? 2 : 1;
 }
 
-static int probe_access_internal(CPUArchState *env, target_ulong addr,
+static int probe_access_internal(CPUArchState *env, vaddr addr,
                                  int fault_size, MMUAccessType access_type,
                                  bool nonfault, uintptr_t ra)
 {
@@ -759,7 +759,7 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
     cpu_loop_exit_sigsegv(env_cpu(env), addr, access_type, maperr, ra);
 }
 
-int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
+int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t ra)
 {
@@ -771,7 +771,7 @@ int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
     return flags;
 }
 
-void *probe_access(CPUArchState *env, target_ulong addr, int size,
+void *probe_access(CPUArchState *env, vaddr addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t ra)
 {
     int flags;
@@ -783,7 +783,7 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
     return size ? g2h(env_cpu(env), addr) : NULL;
 }
 
-tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
                                         void **hostp)
 {
     int flags;
-- 
2.34.1


