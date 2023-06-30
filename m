Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA002743BD2
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFDCt-0007iS-DT; Fri, 30 Jun 2023 08:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCU-0007gs-Hf
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:11 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCR-0007na-SL
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PMhNF7ppwNFu01VBNI3z+n18+DAqV2M5EE9KvV2kG+o=; b=dwJqGpSNcTSCq2fkzz0WGilBoE
 /4QIPKs3jkAcULSw5u/NI5DUWVrabDlwz0Xj3SP1cHx5Cx/0gRqmroLtKfKyoVW5P7lZY7vMdF/FO
 jTeCqCArchuBmF3rtRVUD26FoxdHrr8Uh7YVgdWuMzhk+o4rJG9yaVHpZ0p6cqVJY+iE=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 peter.maydell@linaro.org, wangyanan55@huawei.com
Subject: [PATCH 0/9] Collapse CPUNegativeOffsetState into CPUState
Date: Fri, 30 Jun 2023 14:25:42 +0200
Message-ID: <20230630122551.21766-1-anjo@rev.ng>
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

CPUNegativeOffsetState is a struct placed immediately before
CPUArchState in the ArchCPU struct.  Its purpose is to ensure that
certain fields (CPUTLBDescFast, IcountDecr) lay within a small negative
offset of CPUArchState in memory.  This is desired for better
code-generation on arm[32|64] and riscv hosts which has addressing
modes with 12- and 11 bits of displacement respectively.

This patchset removes CPUNegativeOffsetState, moves its fields to
CPUState, and statically asserts that the offset to the fields above
is expressable in 11 bits of displacement ( >= -(1 << 11) ). In order
to achieve this the TARGET_PAGE_ENTRY_EXTRA macro in CPUTLBEntryFull
had to be replaced with a union to make CPUTLB target independent.

The motivation for this patchset is twofold:

    1. Parts of the codebase that previously depended on CPUArchState
       to access either CPUTLB or IcountDecr now only depend on the
       target-agnostic CPUState.  This is a step towards building
       accel/ once for system- and once for user-mode.

    2. Targets no longer have to define a CPUNegativeOffsetState
       member of ArchCPU, and QEMU will fail to compile if CPUTLB
       and IcountDecr drift too far from CPUArchState.

Patches will follow that convert accel/tcg/cputlb.c and
accel/tcg/user-exec.c away from CPUArchState.

Anton Johansson (9):
  target/arm: Replace TARGET_PAGE_ENTRY_EXTRA
  include: Move MMUAccessType to tlb-common.h
  include/exec: Move CPUTLB and friends to tlb-common.h
  include/hw: introduce CPU_MAX_NEGATIVE_ENV_OFFSET
  accel: Move CPUTLB to CPUState and assert offset
  Move IcountDecr to CPUState and assert offset
  include/exec: Remove [cpu|env]_neg() functions
  target: Remove CPUNegativeOffsetState field from ArchCPU
  include/exec: Remove CPUNegativeOffsetState

 include/exec/cpu-all.h           |  28 +-----
 include/exec/cpu-defs.h          | 141 ----------------------------
 include/exec/exec-all.h          |   2 +-
 include/exec/tlb-common.h        | 153 +++++++++++++++++++++++++++++++
 include/hw/core/cpu.h            |  27 ++++--
 target/alpha/cpu.h               |   1 -
 target/arm/cpu-param.h           |  12 ---
 target/arm/cpu.h                 |   1 -
 target/avr/cpu.h                 |   1 -
 target/cris/cpu.h                |   1 -
 target/hexagon/cpu.h             |   1 -
 target/hppa/cpu.h                |   1 -
 target/i386/cpu.h                |   1 -
 target/loongarch/cpu.h           |   1 -
 target/m68k/cpu.h                |   1 -
 target/microblaze/cpu.h          |   1 -
 target/mips/cpu.h                |   3 +-
 target/nios2/cpu.h               |   1 -
 target/openrisc/cpu.h            |   1 -
 target/ppc/cpu.h                 |   1 -
 target/riscv/cpu.h               |   1 -
 target/rx/cpu.h                  |   1 -
 target/s390x/cpu.h               |   1 -
 target/sh4/cpu.h                 |   1 -
 target/sparc/cpu.h               |   1 -
 target/tricore/cpu.h             |   1 -
 target/xtensa/cpu.h              |   3 +-
 accel/tcg/cpu-exec.c             |  14 +--
 accel/tcg/tcg-accel-ops-icount.c |   6 +-
 accel/tcg/tcg-accel-ops.c        |   2 +-
 accel/tcg/translate-all.c        |  19 +++-
 accel/tcg/translator.c           |  15 ++-
 softmmu/icount.c                 |   2 +-
 target/arm/ptw.c                 |   4 +-
 target/arm/tcg/mte_helper.c      |   2 +-
 target/arm/tcg/sve_helper.c      |   2 +-
 target/arm/tcg/tlb_helper.c      |   4 +-
 target/arm/tcg/translate-a64.c   |   2 +-
 38 files changed, 222 insertions(+), 238 deletions(-)

--
2.41.0

