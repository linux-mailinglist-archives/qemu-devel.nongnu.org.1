Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E647385D6
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByKN-0004C6-8T; Wed, 21 Jun 2023 09:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKJ-0004AY-GZ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:51 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKG-00056v-1Q
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mLHEPhwrRRbn4qdNfuRDBHjNN58ksRLR5GIU2bzeh2s=; b=cVnbvqn9fKRn4FBh/T0KI0gRP9
 4Va5muMZo7gFHJQZlJQYRe+3l3Grq/tlCAv0VafKuZFOpThy07MlkomXTkNYJXUW/41sQ9yQbnoKO
 N4T7gotvEF9oUwuWO3o0+J06zQEUSBmjemQt+RqeranPaQMh5T+xNGLi3zh6KTzn352s=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com
Subject: [PATCH v3 00/12] Start replacing target_ulong with vaddr
Date: Wed, 21 Jun 2023 15:56:21 +0200
Message-ID: <20230621135633.1649-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This is a first patchset in removing target_ulong from non-target/
directories.  As use of target_ulong is spread accross the codebase we
are attempting to target as few maintainers as possible with each
patchset in order to ease reviewing.

The following instances of target_ulong remain in accel/ and tcg/
    - atomic helpers (atomic_common.c.inc), cpu_atomic_*()
      (atomic_template.h,) and cpu_[st|ld]*()
      (cputlb.c/ldst_common.c.inc) are only used in target/ and can
      be pulled out into a separate target-specific file;

    - walk_memory_regions() is used in user-exec.c and
      linux-user/elfload.c;

    - kvm_find_sw_breakpoint() in kvm-all.c used in target/;

Changes in v2:
    - addr argument in tb_invalidate_phys_addr() changed from vaddr
      to hwaddr;

    - Removed previous patch:

        "[PATCH 4/8] accel/tcg: Replace target_ulong with vaddr in helper_unaligned_*()"

      as these functions are removed by Richard's patches;

    - First patch:

        "[PATCH 1/8] accel: Replace `target_ulong` with `vaddr` in TB/TLB"

      has been split into patches 1-7 to ease reviewing;

    - Pulled in target/ changes to cpu_get_tb_cpu_state() into this
      patchset.  This was done to avoid pointer casts to target_ulong *
      which would break for 32-bit targets on a 64-bit BE host;

      Note the small target/ changes are collected in a single
      patch to not break bisection.  If it's still desirable to split
      based on maintainer, let me know;

    - `last` argument of pageflags_[find|next] changed from target_long
       to vaddr.  This change was left out of the last patchset due to
       triggering a "Bad ram pointer" error (softmmu/physmem.c:2273)
       when running make check for a i386-softmmu target.

       I was not able to recreate this on master or post rebase on
       Richard's tcg-once branch.

Changes in v3:
    - Rebased on master

Finally, the grand goal is to allow for heterogeneous QEMU binaries
consisting of multiple frontends.

RFC: https://lists.nongnu.org/archive/html/qemu-devel/2022-12/msg04518.html

Anton Johansson (12):
  accel: Replace target_ulong in tlb_*()
  accel/tcg/translate-all.c: Widen pc and cs_base
  target: Widen pc/cs_base in cpu_get_tb_cpu_state
  accel/tcg/cputlb.c: Widen CPUTLBEntry access functions
  accel/tcg/cputlb.c: Widen addr in MMULookupPageData
  accel/tcg/cpu-exec.c: Widen pc to vaddr
  accel/tcg: Widen pc to vaddr in CPUJumpCache
  accel: Replace target_ulong with vaddr in probe_*()
  accel/tcg: Replace target_ulong with vaddr in *_mmu_lookup()
  accel/tcg: Replace target_ulong with vaddr in translator_*()
  accel/tcg: Replace target_ulong with vaddr in page_*()
  cpu: Replace target_ulong with hwaddr in tb_invalidate_phys_addr()

 accel/stubs/tcg-stub.c       |   6 +-
 accel/tcg/cpu-exec.c         |  43 ++++---
 accel/tcg/cputlb.c           | 233 +++++++++++++++++------------------
 accel/tcg/internal.h         |   6 +-
 accel/tcg/tb-hash.h          |  12 +-
 accel/tcg/tb-jmp-cache.h     |   2 +-
 accel/tcg/tb-maint.c         |   2 +-
 accel/tcg/translate-all.c    |  13 +-
 accel/tcg/translator.c       |  10 +-
 accel/tcg/user-exec.c        |  58 +++++----
 cpu.c                        |   2 +-
 include/exec/cpu-all.h       |  10 +-
 include/exec/cpu-defs.h      |   4 +-
 include/exec/cpu_ldst.h      |  10 +-
 include/exec/exec-all.h      |  95 +++++++-------
 include/exec/translate-all.h |   2 +-
 include/exec/translator.h    |   6 +-
 include/qemu/plugin-memory.h |   2 +-
 target/alpha/cpu.h           |   4 +-
 target/arm/cpu.h             |   4 +-
 target/arm/helper.c          |   4 +-
 target/avr/cpu.h             |   4 +-
 target/cris/cpu.h            |   4 +-
 target/hexagon/cpu.h         |   4 +-
 target/hppa/cpu.h            |   5 +-
 target/i386/cpu.h            |   4 +-
 target/loongarch/cpu.h       |   6 +-
 target/m68k/cpu.h            |   4 +-
 target/microblaze/cpu.h      |   4 +-
 target/mips/cpu.h            |   4 +-
 target/nios2/cpu.h           |   4 +-
 target/openrisc/cpu.h        |   5 +-
 target/ppc/cpu.h             |   8 +-
 target/ppc/helper_regs.c     |   4 +-
 target/riscv/cpu.h           |   4 +-
 target/riscv/cpu_helper.c    |   4 +-
 target/rx/cpu.h              |   4 +-
 target/s390x/cpu.h           |   4 +-
 target/sh4/cpu.h             |   4 +-
 target/sparc/cpu.h           |   4 +-
 target/tricore/cpu.h         |   4 +-
 target/xtensa/cpu.h          |   4 +-
 42 files changed, 307 insertions(+), 313 deletions(-)

--
2.41.0

