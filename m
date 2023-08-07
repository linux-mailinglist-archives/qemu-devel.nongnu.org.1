Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C697729EC
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:58:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2c0-00060W-EP; Mon, 07 Aug 2023 11:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qT2bn-0005zG-Rf
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:57:29 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qT2bl-0002W8-I1
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9x8pXBD0B+40ESo4OYJFn57YwfCf4aQCsV1k2T7MFlA=; b=A9MwkoTxkBCDgN8ozuYNYD9M6G
 J7ZoLU3GmHKyoqhAaagXH6oZHPL7s3UcCXe5JsgUKEKR34GA9c8dhABcmUZAYYVVEzrFM7WaMsuTy
 CYD8Ju3DwSShyCExEMX90yhHCvk10mMA2Wuj33hhyfwUw4NiN+gH6VXnctD1OZ/Cw8e0=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, rbolshakov@ddn.com,
 anielhb413@gmail.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
Subject: [PATCH 0/9] Replace remaining target_ulong in system-mode accel
Date: Mon,  7 Aug 2023 17:56:57 +0200
Message-ID: <20230807155706.9580-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patchset replaces the remaining uses of target_ulong in the accel/
directory.  Specifically, the address type of a few kvm/hvf functions
is widened to vaddr, and the address type of the cpu_[st|ld]*()
functions is changed to abi_ptr (which is re-typedef'd to vaddr in
system mode).

As a starting point, my goal is to be able to build cputlb.c once for
system mode, and this is a step in that direction by reducing the
target-dependence of accel/.

* Changes in v2:
    - Removed explicit target_ulong casts from 3rd and 4th patches.

Anton Johansson (9):
  accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
  accel/hvf: Widen pc/saved_insn for hvf_sw_breakpoint
  target: Use vaddr for kvm_arch_[insert|remove]_hw_breakpoint
  target: Use vaddr for hvf_arch_[insert|remove]_hw_breakpoint
  Replace target_ulong with abi_ptr in cpu_[st|ld]*()
  include/exec: typedef abi_ptr to vaddr in softmmu
  include/exec: Widen tlb_hit/tlb_hit_page()
  accel/tcg: Widen address arg. in tlb_compare_set()
  accel/tcg: Update run_on_cpu_data static assert

 accel/tcg/atomic_template.h  | 16 ++++++++--------
 include/exec/cpu-all.h       |  4 ++--
 include/exec/cpu_ldst.h      | 28 ++++++++++++++--------------
 include/sysemu/hvf.h         | 12 +++++-------
 include/sysemu/kvm.h         | 12 +++++-------
 accel/hvf/hvf-accel-ops.c    |  4 ++--
 accel/hvf/hvf-all.c          |  2 +-
 accel/kvm/kvm-all.c          |  3 +--
 accel/tcg/cputlb.c           | 17 +++++++++--------
 target/arm/hvf/hvf.c         |  4 ++--
 target/arm/kvm64.c           |  6 ++----
 target/i386/hvf/hvf.c        |  4 ++--
 target/i386/kvm/kvm.c        |  8 +++-----
 target/ppc/kvm.c             | 13 ++++++-------
 target/riscv/vector_helper.c |  2 +-
 target/rx/op_helper.c        |  6 +++---
 target/s390x/kvm/kvm.c       |  6 ++----
 17 files changed, 68 insertions(+), 79 deletions(-)

--
2.41.0

