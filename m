Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C36B7BD38D
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:36:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjsC-0001ST-0t; Mon, 09 Oct 2023 02:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qpjs9-0001S8-S4
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qpjs7-00059N-7h
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696833366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKKCMosWn2sEtc7QyetZMYZJkMpUbSZeqw+wKgRIqbU=;
 b=K59rNWhJi+zzG42EKNqyKiJgCnwNwAS372PRhqnBcPWoPk/tPLx+bUXsgQfQdC76y+bn3e
 dmQbx0XmJcrm72/4u7aVKp2IS5FCZD2veIL6366iIu0/BhyleSgCh3v7GkgKjHBbcgSDv0
 qZZC5unRG1aULKWerRsQf66Bz7igCCg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-vS796u77NQml_m_IDVpx9Q-1; Mon, 09 Oct 2023 02:36:03 -0400
X-MC-Unique: vS796u77NQml_m_IDVpx9Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32661ca30d9so2791813f8f.0
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 23:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696833362; x=1697438162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKKCMosWn2sEtc7QyetZMYZJkMpUbSZeqw+wKgRIqbU=;
 b=hvymJ9TgYiptJuWUZ8srmS5tjOcPGbqiWURQiTyv3lVk2dLTLHRWfBNlL0Vqiq32+N
 1CcGGEFiFlDRbV6sdAOQ3MxcmPkdCJL+GA9dOUetaEB3AczM4aVx78rbG3yoOoNLQob2
 OsQv3ILoynXDig1I6noOwwg2awezQCZ0YOTnV3YeqljH3fkBrvhBD4HjQRl4vfyPnbIt
 EWybD81LKkOGxpC6K2ArgBLvQpKgbJclwGFh+pxrstjVH2BKZOAjsba8TXveQamvDtvt
 ybdDTSNALrvuoun3OBd5vjOLQ1qBXA42otkgmj9Abics2IJTSWWX95Mm56thRqX0dIv2
 098A==
X-Gm-Message-State: AOJu0YwqWvoBtVdjIEFWzEJ0IrVfmY5DnHA2Bpkivo7B4SYIgbJQ0Brc
 8WzHF9gTNK9GA+033zPp+23xQsjBDAV1gdSA6O9ZmO7KqCeUUlBkHaQQN22vG9+AkO23SNszfjm
 bcLSFaswM7Ex2htSfVGVp5fzXP5JMd0q7iXvbSb4mob0xxDuYu3jKL5NN9tW6TZZuNfcoJH/y76
 I=
X-Received: by 2002:a5d:6a07:0:b0:314:350a:6912 with SMTP id
 m7-20020a5d6a07000000b00314350a6912mr12842863wru.36.1696833361556; 
 Sun, 08 Oct 2023 23:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUSSwx72myo9TByDEPMQnwQLdiVea5UGApW+gTgVWlg0YNf2GZyStBD8oPJQoyysbBfqaY0g==
X-Received: by 2002:a5d:6a07:0:b0:314:350a:6912 with SMTP id
 m7-20020a5d6a07000000b00314350a6912mr12842840wru.36.1696833360860; 
 Sun, 08 Oct 2023 23:36:00 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a7bce0a000000b00405953973c3sm12451415wmc.6.2023.10.08.23.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 23:35:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: phildmd@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/25] tcg: Correct invalid mentions of 'softmmu' by
 'system-mode'
Date: Mon,  9 Oct 2023 08:35:55 +0200
Message-ID: <20231009063556.72450-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009063556.72450-1-pbonzini@redhat.com>
References: <20231009063556.72450-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
index 5bf2761bf48..68b252cb8e8 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -940,7 +940,7 @@ void *page_get_target_data(target_ulong address)
 void page_reset_target_data(target_ulong start, target_ulong last) { }
 #endif /* TARGET_PAGE_DATA_SIZE */
 
-/* The softmmu versions of these helpers are in cputlb.c.  */
+/* The system-mode versions of these helpers are in cputlb.c.  */
 
 static void *cpu_mmu_lookup(CPUState *cpu, vaddr addr,
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
index 69f2daf2c2b..3afb896a3a5 100644
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
index a2f60106aff..0d9c2d157b0 100644
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
index 8f7091002bd..801302d85d7 100644
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
index f664cf14849..637b9e68707 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -760,12 +760,13 @@ static void alloc_tcg_plugin_context(TCGContext *s)
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
@@ -1349,7 +1350,7 @@ static void tcg_context_init(unsigned max_cpus)
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


