Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F042C7BB61E
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:15:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoin5-000871-T7; Fri, 06 Oct 2023 07:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoin1-00084e-JF
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimx-0000IL-Px
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gc5d66zj1z2mWfgNRF83cak7oV9eJ59PKQmCJrWqMiY=;
 b=E8TuXKXAoVEPBs/CFUuS9ZyDHoPBU9hnmVKokShrYBC1Y7xUOBMjiT+REWyg5WwGxouAFE
 soIX5Y8mNUSXPD5u5zJRxIRa3V9ss3qIaHyp5OC5QTrdU8TtYbGGVunUF8pPbehGD49qT+
 xFUi/vWFpjZ6qd1rizaErl/HBa8tZMM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-L8L747C5NoyAbRVPpqu3kQ-1; Fri, 06 Oct 2023 07:14:33 -0400
X-MC-Unique: L8L747C5NoyAbRVPpqu3kQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae686dafedso181629666b.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590871; x=1697195671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gc5d66zj1z2mWfgNRF83cak7oV9eJ59PKQmCJrWqMiY=;
 b=DaKSvre7rJ1ZBobj/+ppn9QIvSefbbU0435UxLcQLfVnR4hJrwQOTdbmEUQFPYCPug
 5rDJpzR4X+FOgCNjqfBXO4UaG0fnUuRB/Tpkx1Ej91dua0tDIrKpxDPnFg2V3+Ejf0PK
 D8PFG9NpQDrSZvIXBAvNgJWiFOqCqiGKg8huuGbgFrQmlDTgwyOtGrdNw6T/wM0X1Wij
 9wtvhkJNT3TiCxUc6vlVhD6atGHq6YuMiqHEpS6uzNi9X22nx9g/S7Ib2jBL7LyrYqy/
 AxyHnZ3gv4utf7ciQYIGxkukjIGU0GzNWeMvctrdZmVyqhrvejpmHypr9klfF8jQc7ml
 S8Pg==
X-Gm-Message-State: AOJu0Yyo5Ib2ysUoZPJoCO/WgZv6f28sF46U7nH6Z9FevlApzDUaxy55
 S69Lm4/F6YD8mvrcd23xXUvm2t1oCAwattwgAyNDZ5kOIE8/wB0qu7098nq0u/e27qs1L1VBhBr
 T236HJRnN2uRvtcSJuaxRGKOiHk5EJux+z4loGr0BujPMBATZ4krgcYBSZOW34tem38/1hFOf1W
 s=
X-Received: by 2002:aa7:c493:0:b0:532:c690:92c8 with SMTP id
 m19-20020aa7c493000000b00532c69092c8mr6639641edq.31.1696590870861; 
 Fri, 06 Oct 2023 04:14:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN3qqN5KfVWMY9V/woNKMevNQawswShVD/mHxAHqmS3NsOnHCU/zCuAf01oJTZfT9aoKwJ9w==
X-Received: by 2002:aa7:c493:0:b0:532:c690:92c8 with SMTP id
 m19-20020aa7c493000000b00532c69092c8mr6639618edq.31.1696590870301; 
 Fri, 06 Oct 2023 04:14:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a056402069200b005389ebf00a2sm2418116edy.76.2023.10.06.04.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/26] tcg: Correct invalid mentions of 'softmmu' by
 'system-mode'
Date: Fri,  6 Oct 2023 13:13:55 +0200
Message-ID: <20231006111412.13130-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004090629.37473-6-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/user-exec.c                       |  2 +-
 docs/devel/testing.rst                      |  2 +-
 include/qemu/atomic128.h                    |  4 ++--
 include/tcg/tcg-op-common.h                 |  2 +-
 target/riscv/vector_helper.c                |  2 +-
 tcg/aarch64/tcg-target.c.inc                |  4 ++--
 tcg/arm/tcg-target.c.inc                    |  2 +-
 tcg/i386/tcg-target.c.inc                   |  2 +-
 tcg/loongarch64/tcg-target.c.inc            |  4 ++--
 tcg/meson.build                             |  6 +++---
 tcg/mips/tcg-target.c.inc                   |  4 ++--
 tcg/ppc/tcg-target.c.inc                    |  4 ++--
 tcg/region.c                                |  4 ++--
 tcg/riscv/tcg-target.c.inc                  |  4 ++--
 tcg/s390x/tcg-target.c.inc                  |  4 ++--
 tcg/sparc64/tcg-target.c.inc                |  4 ++--
 tcg/tcg.c                                   | 11 ++++++-----
 tests/tcg/Makefile.target                   |  2 +-
 tests/tcg/multiarch/gdbstub/interrupt.py    |  2 +-
 tests/tcg/multiarch/gdbstub/memory.py       |  2 +-
 tests/tcg/multiarch/system/memory.c         |  4 ++--
 tests/tcg/s390x/pgm-specification-softmmu.S |  2 +-
 tests/tcg/s390x/pgm-specification.mak       |  2 +-
 tests/tcg/s390x/softmmu.ld                  |  2 +-
 tests/tcg/xtensa/Makefile.softmmu-target    |  2 +-
 tests/tcg/xtensaeb/Makefile.softmmu-target  |  2 +-
 26 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index ab48cb41e4c..6c1e8ec5a5d 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -939,7 +939,7 @@ void *page_get_target_data(target_ulong address)
 void page_reset_target_data(target_ulong start, target_ulong last) { }
 #endif /* TARGET_PAGE_DATA_SIZE */
 
-/* The softmmu versions of these helpers are in cputlb.c.  */
+/* The system-mode versions of these helpers are in cputlb.c.  */
 
 static void *cpu_mmu_lookup(CPUArchState *env, vaddr addr,
                             MemOp mop, uintptr_t ra, MMUAccessType type)
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 5d1fc0aa95f..f3e24721890 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1458,7 +1458,7 @@ TCG test dependencies
 ~~~~~~~~~~~~~~~~~~~~~
 
 The TCG tests are deliberately very light on dependencies and are
-either totally bare with minimal gcc lib support (for softmmu tests)
+either totally bare with minimal gcc lib support (for system-mode tests)
 or just glibc (for linux-user tests). This is because getting a cross
 compiler to work with additional libraries can be challenging.
 
diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index 34554bf0acc..88af6d4ea3f 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -43,8 +43,8 @@
  * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80878
  *
  * This interpretation is not especially helpful for QEMU.
- * For softmmu, all RAM is always read/write from the hypervisor.
- * For user-only, if the guest doesn't implement such an __atomic_read
+ * For system-mode, all RAM is always read/write from the hypervisor.
+ * For user-mode, if the guest doesn't implement such an __atomic_read
  * then the host need not worry about it either.
  *
  * Moreover, using libatomic is not an option, because its interface is
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a53b15933bb..2048f92b5e1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -265,7 +265,7 @@ void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx);
  *
  * See tcg/README for more info about this TCG operation.
  *
- * NOTE: In softmmu emulation, direct jumps with goto_tb are only safe within
+ * NOTE: In system emulation, direct jumps with goto_tb are only safe within
  * the pages this TB resides in because we don't take care of direct jumps when
  * address mapping changes, e.g. in tlb_flush(). In user mode, there's only a
  * static address translation, so the destination address is always valid, TBs
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index cba02c13203..c9b39fb67f4 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -100,7 +100,7 @@ static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
 /*
  * This function checks watchpoint before real load operation.
  *
- * In softmmu mode, the TLB API probe_access is enough for watchpoint check.
+ * In system mode, the TLB API probe_access is enough for watchpoint check.
  * In user mode, there is no watchpoint support now.
  *
  * It will trigger an exception if there is no mapping in TLB
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 06ea3c76526..88a243a3105 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1643,8 +1643,8 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 #define MIN_TLB_MASK_TABLE_OFS  -512
 
 /*
- * For softmmu, perform the TLB load and compare.
- * For useronly, perform any required alignment tests.
+ * For system-mode, perform the TLB load and compare.
+ * For user-mode, perform any required alignment tests.
  * In both cases, return a TCGLabelQemuLdst structure if the slow path
  * is required and fill in @h with the host address for the fast path.
  */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index b1d56362a74..ec3f9250c29 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -353,7 +353,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define ALL_VECTOR_REGS   0xffff0000u
 
 /*
- * r0-r3 will be overwritten when reading the tlb entry (softmmu only);
+ * r0-r3 will be overwritten when reading the tlb entry (system-mode only);
  * r14 will be overwritten by the BLNE branching to the slow path.
  */
 #ifdef CONFIG_SOFTMMU
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 4e47151241c..788d6081504 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2276,7 +2276,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
     int movop = OPC_MOVL_EvGv;
 
     /*
-     * Do big-endian stores with movbe or softmmu.
+     * Do big-endian stores with movbe or system-mode.
      * User-only without movbe will have its swapping done generically.
      */
     if (memop & MO_BSWAP) {
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index b701df50db8..879a05ace4e 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -891,8 +891,8 @@ bool tcg_target_has_memory_bswap(MemOp memop)
 #define MIN_TLB_MASK_TABLE_OFS  -(1 << 11)
 
 /*
- * For softmmu, perform the TLB load and compare.
- * For useronly, perform any required alignment tests.
+ * For system-mode, perform the TLB load and compare.
+ * For user-mode, perform any required alignment tests.
  * In both cases, return a TCGLabelQemuLdst structure if the slow path
  * is required and fill in @h with the host address for the fast path.
  */
diff --git a/tcg/meson.build b/tcg/meson.build
index 4be4a616caa..895a11d3fa2 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -34,12 +34,12 @@ tcg_user = declare_dependency(link_with: libtcg_user,
                               dependencies: tcg_ss.dependencies())
 user_ss.add(tcg_user)
 
-libtcg_softmmu = static_library('tcg_softmmu',
+libtcg_system = static_library('tcg_system',
                                 tcg_ss.sources() + genh,
                                 name_suffix: 'fa',
                                 c_args: '-DCONFIG_SOFTMMU',
                                 build_by_default: false)
 
-tcg_softmmu = declare_dependency(link_with: libtcg_softmmu,
+tcg_system = declare_dependency(link_with: libtcg_system,
                                  dependencies: tcg_ss.dependencies())
-system_ss.add(tcg_softmmu)
+system_ss.add(tcg_system)
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f52bda48285..e2892edc6ad 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1258,8 +1258,8 @@ bool tcg_target_has_memory_bswap(MemOp memop)
 #define MIN_TLB_MASK_TABLE_OFS  -32768
 
 /*
- * For softmmu, perform the TLB load and compare.
- * For useronly, perform any required alignment tests.
+ * For system-mode, perform the TLB load and compare.
+ * For user-mode, perform any required alignment tests.
  * In both cases, return a TCGLabelQemuLdst structure if the slow path
  * is required and fill in @h with the host address for the fast path.
  */
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 90d76c2c2c7..5c873b21614 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2091,8 +2091,8 @@ bool tcg_target_has_memory_bswap(MemOp memop)
 #define MIN_TLB_MASK_TABLE_OFS  -32768
 
 /*
- * For softmmu, perform the TLB load and compare.
- * For useronly, perform any required alignment tests.
+ * For system-mode, perform the TLB load and compare.
+ * For user-mode, perform any required alignment tests.
  * In both cases, return a TCGLabelQemuLdst structure if the slow path
  * is required and fill in @h with the host address for the fast path.
  */
diff --git a/tcg/region.c b/tcg/region.c
index a0788990964..86692455c00 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -733,7 +733,7 @@ static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
  * and then assigning regions to TCG threads so that the threads can translate
  * code in parallel without synchronization.
  *
- * In softmmu the number of TCG threads is bounded by max_cpus, so we use at
+ * In system-mode the number of TCG threads is bounded by max_cpus, so we use at
  * least max_cpus regions in MTTCG. In !MTTCG we use a single region.
  * Note that the TCG options from the command-line (i.e. -accel accel=tcg,[...])
  * must have been parsed before calling this function, since it calls
@@ -749,7 +749,7 @@ static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
  *
  * However, this user-mode limitation is unlikely to be a significant problem
  * in practice. Multi-threaded guests share most if not all of their translated
- * code, which makes parallel code generation less appealing than in softmmu.
+ * code, which makes parallel code generation less appealing than in system-mode
  */
 void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
 {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index c2bcdea33f9..d6dbcaf3cbb 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1227,8 +1227,8 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 #define MIN_TLB_MASK_TABLE_OFS  -(1 << 11)
 
 /*
- * For softmmu, perform the TLB load and compare.
- * For useronly, perform any required alignment tests.
+ * For system-mode, perform the TLB load and compare.
+ * For user-mode, perform any required alignment tests.
  * In both cases, return a TCGLabelQemuLdst structure if the slow path
  * is required and fill in @h with the host address for the fast path.
  */
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 7552f63a057..4ef9ac3d5bd 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1750,8 +1750,8 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 #define MIN_TLB_MASK_TABLE_OFS  -(1 << 19)
 
 /*
- * For softmmu, perform the TLB load and compare.
- * For useronly, perform any required alignment tests.
+ * For system-mode, perform the TLB load and compare.
+ * For user-mode, perform any required alignment tests.
  * In both cases, return a TCGLabelQemuLdst structure if the slow path
  * is required and fill in @h with the host address for the fast path.
  */
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 01ac26c1920..19d9df4a09a 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1033,8 +1033,8 @@ bool tcg_target_has_memory_bswap(MemOp memop)
 #define MIN_TLB_MASK_TABLE_OFS  -(1 << 12)
 
 /*
- * For softmmu, perform the TLB load and compare.
- * For useronly, perform any required alignment tests.
+ * For system-mode, perform the TLB load and compare.
+ * For user-mode, perform any required alignment tests.
  * In both cases, return a TCGLabelQemuLdst structure if the slow path
  * is required and fill in @h with the host address for the fast path.
  */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ea94d0fbff4..2f56456b25b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -751,12 +751,13 @@ static void alloc_tcg_plugin_context(TCGContext *s)
  * In user-mode we just point tcg_ctx to tcg_init_ctx. See the documentation
  * of tcg_region_init() for the reasoning behind this.
  *
- * In softmmu each caller registers its context in tcg_ctxs[]. Note that in
- * softmmu tcg_ctxs[] does not track tcg_ctx_init, since the initial context
+ * In system-mode each caller registers its context in tcg_ctxs[]. Note that in
+ * system-mode tcg_ctxs[] does not track tcg_ctx_init, since the initial context
  * is not used anymore for translation once this function is called.
  *
- * Not tracking tcg_init_ctx in tcg_ctxs[] in softmmu keeps code that iterates
- * over the array (e.g. tcg_code_size() the same for both softmmu and user-mode.
+ * Not tracking tcg_init_ctx in tcg_ctxs[] in system-mode keeps code that
+ * iterates over the array (e.g. tcg_code_size() the same for both system/user
+ * modes.
  */
 #ifdef CONFIG_USER_ONLY
 void tcg_register_thread(void)
@@ -1340,7 +1341,7 @@ static void tcg_context_init(unsigned max_cpus)
      * In user-mode we simply share the init context among threads, since we
      * use a single region. See the documentation tcg_region_init() for the
      * reasoning behind this.
-     * In softmmu we will have at most max_cpus TCG threads.
+     * In system-mode we will have at most max_cpus TCG threads.
      */
 #ifdef CONFIG_USER_ONLY
     tcg_ctxs = &tcg_ctx;
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 462289f47cc..f3a189c9d46 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -120,7 +120,7 @@ endif
 %: %.S
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 else
-# For softmmu targets we include a different Makefile fragment as the
+# For system targets we include a different Makefile fragment as the
 # build options for bare programs are usually pretty different. They
 # are expected to provide their own build recipes.
 EXTRA_CFLAGS += -ffreestanding
diff --git a/tests/tcg/multiarch/gdbstub/interrupt.py b/tests/tcg/multiarch/gdbstub/interrupt.py
index e222ac94c5a..c016e7afbbf 100644
--- a/tests/tcg/multiarch/gdbstub/interrupt.py
+++ b/tests/tcg/multiarch/gdbstub/interrupt.py
@@ -1,6 +1,6 @@
 from __future__ import print_function
 #
-# Test some of the softmmu debug features with the multiarch memory
+# Test some of the system debug features with the multiarch memory
 # test. It is a port of the original vmlinux focused test case but
 # using the "memory" test instead.
 #
diff --git a/tests/tcg/multiarch/gdbstub/memory.py b/tests/tcg/multiarch/gdbstub/memory.py
index dd25e722813..fb1d06b7bb7 100644
--- a/tests/tcg/multiarch/gdbstub/memory.py
+++ b/tests/tcg/multiarch/gdbstub/memory.py
@@ -1,6 +1,6 @@
 from __future__ import print_function
 #
-# Test some of the softmmu debug features with the multiarch memory
+# Test some of the system debug features with the multiarch memory
 # test. It is a port of the original vmlinux focused test case but
 # using the "memory" test instead.
 #
diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index e29786ae559..6eb2eb16f7f 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -1,14 +1,14 @@
 /*
  * Memory Test
  *
- * This is intended to test the softmmu code and ensure we properly
+ * This is intended to test the system-mode code and ensure we properly
  * behave across normal and unaligned accesses across several pages.
  * We are not replicating memory tests for stuck bits and other
  * hardware level failures but looking for issues with different size
  * accesses when access is:
  *
  *   - unaligned at various sizes (if -DCHECK_UNALIGNED set)
- *   - spanning a (softmmu) page
+ *   - spanning a (system) page
  *   - sign extension when loading
  */
 
diff --git a/tests/tcg/s390x/pgm-specification-softmmu.S b/tests/tcg/s390x/pgm-specification-softmmu.S
index d534f4e505d..86c340aeef0 100644
--- a/tests/tcg/s390x/pgm-specification-softmmu.S
+++ b/tests/tcg/s390x/pgm-specification-softmmu.S
@@ -1,5 +1,5 @@
 /*
- * Common softmmu code for specification exception testing.
+ * Common system code for specification exception testing.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/tests/tcg/s390x/pgm-specification.mak b/tests/tcg/s390x/pgm-specification.mak
index 2999aee26e6..73dc47af0d2 100644
--- a/tests/tcg/s390x/pgm-specification.mak
+++ b/tests/tcg/s390x/pgm-specification.mak
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # List of specification exception tests.
-# Shared between the softmmu and the user makefiles.
+# Shared between the system and the user makefiles.
 PGM_SPECIFICATION_TESTS = \
 	br-odd \
 	cgrl-unaligned \
diff --git a/tests/tcg/s390x/softmmu.ld b/tests/tcg/s390x/softmmu.ld
index ea944eaa3cb..c7a8864407e 100644
--- a/tests/tcg/s390x/softmmu.ld
+++ b/tests/tcg/s390x/softmmu.ld
@@ -1,5 +1,5 @@
 /*
- * Linker script for the softmmu test kernels.
+ * Linker script for the system test kernels.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/tests/tcg/xtensa/Makefile.softmmu-target b/tests/tcg/xtensa/Makefile.softmmu-target
index 78bf72dfaa4..a29571b367c 100644
--- a/tests/tcg/xtensa/Makefile.softmmu-target
+++ b/tests/tcg/xtensa/Makefile.softmmu-target
@@ -1,5 +1,5 @@
 #
-# Xtensa softmmu tests
+# Xtensa system tests
 #
 
 CORE=dc232b
diff --git a/tests/tcg/xtensaeb/Makefile.softmmu-target b/tests/tcg/xtensaeb/Makefile.softmmu-target
index 4204a96d53c..95d0528c372 100644
--- a/tests/tcg/xtensaeb/Makefile.softmmu-target
+++ b/tests/tcg/xtensaeb/Makefile.softmmu-target
@@ -1,5 +1,5 @@
 #
-# Xtensa softmmu tests
+# Xtensa system tests
 #
 
 include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target
-- 
2.41.0


