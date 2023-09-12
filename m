Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5D79D50F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 17:36:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg5Q4-0007LP-Ka; Tue, 12 Sep 2023 11:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qg5Pn-0007HU-8d
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:34:59 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qg5Pe-0001Vx-2B
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9xyWjylzXMbZW64C2HzpuT96Qjl+S/XBz/V7NQOBmrw=; b=Hk+lz3wn68ZqHehJI60ZFnlPtd
 o9Exw7o9Sp3zBzzAEUT40eZSTqJNvYhqCEqdwIa78myQm9hu9vGn6RMDidtWPeJTlnqi9skmh10x1
 vp7Y72RCJDmu6EraHVWK8d7nFAvtpiNnhKOqDpAEURtP+Zzup+DqRE9BCLXQgxc4CcZo=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 00/11] Reduce usage of CPUArchState in cputlb.c
Date: Tue, 12 Sep 2023 17:34:17 +0200
Message-ID: <20230912153428.17816-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patchset reduces the dependence of cputlb.c on the full
CPUArchState, instead replacing it with the generic CPUState. Target-
facing functions such as probe_access(), cpu_ld*(), etc. are not
modified in this patchset, the idea is to try and isolate all usage of
CPUArchState into smaller wrapper functions that can eventually be
compiled and linked into the target, whilst keeping accel/tcg/
target-independent.

Anton Johansson (11):
  target/arm: Replace TARGET_PAGE_ENTRY_EXTRA
  include: Introduce tlb_ptr field to CPUState
  accel/tcg: Modify tlb_*() to use CPUState
  accel/tcg: Modify probe_access_internal() to use CPUState
  accel/tcg: Modifies memory access functions to use CPUState
  accel/tcg: Modify atomic_mmu_lookup() to use CPUState
  accel/tcg: Use CPUState in atomicity helpers
  include/exec: Remove env_tlb()
  tcg: Update env_tlb() comments
  accel/tcg: Unify user and softmmu do_[st|ld]*_mmu()
  accel/tcg: move ld/st helpers to ldst_common.c.inc

 accel/tcg/atomic_template.h    |  20 +-
 include/exec/cpu-all.h         |  11 +-
 include/exec/cpu-defs.h        |  18 +-
 include/exec/cpu_ldst.h        |   8 +-
 include/hw/core/cpu.h          |   6 +
 target/arm/cpu-param.h         |  12 -
 accel/tcg/cputlb.c             | 756 ++++++++++++---------------------
 accel/tcg/user-exec.c          | 276 +++---------
 target/arm/ptw.c               |   4 +-
 target/arm/tcg/mte_helper.c    |   2 +-
 target/arm/tcg/sve_helper.c    |   2 +-
 target/arm/tcg/tlb_helper.c    |   4 +-
 target/arm/tcg/translate-a64.c |   2 +-
 accel/tcg/ldst_atomicity.c.inc |  88 ++--
 accel/tcg/ldst_common.c.inc    | 225 ++++++++++
 tcg/aarch64/tcg-target.c.inc   |   2 +-
 tcg/arm/tcg-target.c.inc       |   2 +-
 17 files changed, 644 insertions(+), 794 deletions(-)

--
2.41.0

