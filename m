Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 160D4816C43
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:34:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBs1-0006WG-0L; Mon, 18 Dec 2023 06:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBrz-0006Vr-BR
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:11 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBrw-0003Gw-TI
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:11 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-336607f4d05so759406f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899187; x=1703503987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ccFOH05Cbw63Xbc7/WOKzLyjuXWoZ8HlICGnlISMfys=;
 b=ptlCBnBrQE8iK3dzQ6Vy4vUEgM6a2DfMAheuD/Xcmq38BGpilpTcqLnko+iu4rsCCs
 hh7e5NEWJ/9SLfeRPEyjRGDSqkjUAQd2gKmkvt/U5iSXlw7tZqRVWzyi7alGRBzfeRi+
 g84qLlKR6H5dtwCQXTRYqc3VbT0iID1Xgc0bK2jZavmE4uOc6DHRAw41gCu1PZO1llC9
 cgftxlGDOITD8ArvyX/7RF3OXogRJOnCZHgyEr28RH23VQhdvqidsGA3XeBAUVfoMd8c
 yDwTlhjYA7vBFQyXji+XU6dYruNtDfVrG6YrgikarlVL2oBR6uAb+4pFGQjljOj+GJtj
 fqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899187; x=1703503987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ccFOH05Cbw63Xbc7/WOKzLyjuXWoZ8HlICGnlISMfys=;
 b=ebFFCIbo8K72SltH4tnyAD1hHBfzhQHHKsZZKpVMhlhWdCXxj0xlK4T4CGtsZAysle
 2hO6mdV1OCuldxnzz9YpNICoYSj6NUaNmjsy8gEENW32y5YQgH1yDxGFYuYkramfx+L1
 r+CG/KWp5yaaYQiiRMBsy8pl7OjYPlpk4jJKb4aLLc/dPAT4gWgHJi6AXY8m3/Nf0Qgb
 6jA85Od6AY7bAE/Le/blF0Q/4G9r0p9UHb7P72hFWFL0eOOVpIB8OEBT4si0gMT1EurH
 gQiQ6RUpGFopyr2aT7We1WeUBO5AXTpMq8d27f8ElWsoYTZRcJ+UwmY9a4OX059a33ov
 05eA==
X-Gm-Message-State: AOJu0Yx3k3SUaONATedyUOh2sqEWmKhY9kSN2l8P9DOGD9zIXc7AgAv1
 miLMyxmla0o9JLclSpT6KRB9rg==
X-Google-Smtp-Source: AGHT+IHOf3EEU+AFFfOA/lk8NFdSRykXTFpc5fkLPo0Ksp2n+GISijoE1Xk9sZuH1PFkpRMAjKd2kw==
X-Received: by 2002:a05:6000:124e:b0:336:5bb0:2f55 with SMTP id
 j14-20020a056000124e00b003365bb02f55mr1733973wrx.5.1702899186692; 
 Mon, 18 Dec 2023 03:33:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/35] target/arm: Implement emulation of nested virtualization
Date: Mon, 18 Dec 2023 11:32:30 +0000
Message-Id: <20231218113305.2511480-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

This patchset adds support for emulating the Arm architectural features
FEAT_NV and FEAT_NV2 which allow nested virtualization, i.e. where a
hypervisor can run a guest which thinks it is running at EL2.

Nominally FEAT_NV is sufficient for this and FEAT_NV2 merely improves
the performance in the nested-virt setup, but in practice hypervisors
such as KVM are going to require FEAT_NV2 and not bother to support
the FEAT_NV-only case, so I have implemented them one after the other
in this single patchset.

The feature is essentially a collection of changes that allow the
hypervisor to lie to the guest so that it thinks it is running in EL2
when it's really at EL1. The best summary of what all the changes are
is in section D8.11 "Nested virtualization" in the Arm ARM, but the
short summary is:
 * EL2 system registers etc trap to EL2 rather than UNDEFing
 * ERET traps to EL2
 * the CurrentEL register reports "EL2" when NV is enabled
 * on exception entry, SPSR_EL1.M may report "EL2" as the EL the
   exception was taken from
 * when HCR_EL1.NV1 is also set, then there are some extra tweaks
   (NV1 == 1 means "guest thinks it is running with HCR_EL2.E2H == 0")
 * some AT S1 address translation insns can be trapped to EL2
and FEAT_NV2 adds:
 * accesses to some system registers are transformed into memory
   accesses instead of trapping to EL2
 * accesses to a few EL2 system registers are redirected to the
   equivalent EL1 registers

This patchset is sufficient that you can run an L0 guest kernel that
has support for FEAT_NV/FEAT_NV2 in its KVM code, and then
inside that start a nested L1 guest that thinks it has EL2 access,
and then run an inner-nested L2 guest under that that can get
to running userspace code. To do that you'll need some not-yet-upstream
patches for both Linux and kvmtool:

https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/nv-6.8-nv2-only
https://gitlab.arm.com/linux-arm/kvmtool/-/commits/nv-v6.6

You'll also want to turn off SVE and SME emulation in QEMU
(-cpu max,sve=off,sme=off) because at the moment the KVM patchset
doesn't handle SVE and nested-virt together (the other option
is to hack kvmtool to make it not ask for both at once, but this
is easier).

(kvmtool is needed here to run the L1 because QEMU itself as a VMM
doesn't yet support asking KVM for an EL2 guest.)

The first three patches in the series aren't strictly part of FEAT_NV:
 * patch 1 is already reviewed; I put it here to avoid having
   to deal with textual conflicts between it and this series
 * patch 2 sets CTR_EL0.{IDC,DIC} for '-cpu max', which is a good
   idea anyway and also works around what Marc Z and I think is
   a KVM bug that otherwise causes boot of the L2 kernel to hang
 * patch 3 is a GIC bug which is not FEAT_NV specific but for
   some reason only manifests when booting an L1 kernel under NV

thanks
-- PMM

Peter Maydell (35):
  target/arm: Don't implement *32_EL2 registers when EL1 is AArch64 only
  target/arm: Set CTR_EL0.{IDC,DIC} for the 'max' CPU
  hw/intc/arm_gicv3_cpuif: handle LPIs in in the list registers
  target/arm: Handle HCR_EL2 accesses for bits introduced with FEAT_NV
  target/arm: Implement HCR_EL2.AT handling
  target/arm: Enable trapping of ERET for FEAT_NV
  target/arm: Always honour HCR_EL2.TSC when HCR_EL2.NV is set
  target/arm: Allow use of upper 32 bits of TBFLAG_A64
  target/arm: Record correct opcode fields in cpreg for E2H aliases
  target/arm: *_EL12 registers should UNDEF when HCR_EL2.E2H is 0
  target/arm: Make EL2 cpreg accessfns safe for FEAT_NV EL1 accesses
  target/arm: Move FPU/SVE/SME access checks up above
    ARM_CP_SPECIAL_MASK check
  target/arm: Trap sysreg accesses for FEAT_NV
  target/arm: Make NV reads of CurrentEL return EL2
  target/arm: Set SPSR_EL1.M correctly when nested virt is enabled
  target/arm: Trap registers when HCR_EL2.{NV,NV1} == {1,1}
  target/arm: Always use arm_pan_enabled() when checking if PAN is
    enabled
  target/arm: Don't honour PSTATE.PAN when HCR_EL2.{NV,NV1} == {1,1}
  target/arm: Treat LDTR* and STTR* as LDR/STR when NV,NV1 is 1,1
  target/arm: Handle FEAT_NV page table attribute changes
  target/arm: Add FEAT_NV to max, neoverse-n2, neoverse-v1 CPUs
  target/arm: Handle HCR_EL2 accesses for FEAT_NV2 bits
  target/arm: Implement VNCR_EL2 register
  target/arm: Handle FEAT_NV2 changes to when SPSR_EL1.M reports EL2
  target/arm: Handle FEAT_NV2 redirection of SPSR_EL2, ELR_EL2, ESR_EL2,
    FAR_EL2
  target/arm: Implement FEAT_NV2 redirection of sysregs to RAM
  target/arm: Report VNCR_EL2 based faults correctly
  target/arm: Mark up VNCR offsets (offsets 0x0..0xff)
  target/arm: Mark up VNCR offsets (offsets 0x100..0x160)
  target/arm: Mark up VNCR offsets (offsets 0x168..0x1f8)
  target/arm: Mark up VNCR offsets (offsets >= 0x200, except GIC)
  hw/intc/arm_gicv3_cpuif: Mark up VNCR offsets for GIC CPU registers
  target/arm: Report HCR_EL2.{NV,NV1,NV2} in cpu dumps
  target/arm: Enhance CPU_LOG_INT to show SPSR on AArch64
    exception-entry
  target/arm: Add FEAT_NV2 to max, neoverse-n2, neoverse-v1 CPUs

 docs/system/arm/emulation.rst  |   2 +
 target/arm/cpregs.h            |  54 ++++-
 target/arm/cpu-features.h      |  10 +
 target/arm/cpu.h               |  24 ++-
 target/arm/syndrome.h          |  20 +-
 target/arm/tcg/translate.h     |  16 +-
 hw/intc/arm_gicv3_cpuif.c      |  28 ++-
 target/arm/cpu.c               |   8 +-
 target/arm/debug_helper.c      |  34 +++-
 target/arm/helper.c            | 360 ++++++++++++++++++++++++++++-----
 target/arm/ptw.c               |  21 ++
 target/arm/tcg/cpu64.c         |  11 +
 target/arm/tcg/hflags.c        |  30 ++-
 target/arm/tcg/op_helper.c     |  16 +-
 target/arm/tcg/tlb_helper.c    |  27 ++-
 target/arm/tcg/translate-a64.c | 162 +++++++++++++--
 16 files changed, 725 insertions(+), 98 deletions(-)

-- 
2.34.1


