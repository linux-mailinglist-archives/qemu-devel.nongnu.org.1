Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE1B7415B6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXTt-0005pg-EG; Wed, 28 Jun 2023 11:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXTs-0005pX-BU
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:20 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXTq-0007rc-Bo
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:20 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51d9123a8abso4988388a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967596; x=1690559596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KVcMIQlh++eED2SbSh7NaIs1q42NA3S2CoSjBQgfK/A=;
 b=iy4hV044dzm91+FMiA4qpjEY4yEmvT40OHT1sk9Qk3m6XeeQc1k/3iOJhUnq2x3wb8
 bQSKaxOBuqaa2SST0eWaagFw+CYJhygErlakKKmGzs80JQ/VMvnj5Zmnd3+nKx5mMgnU
 uVhZnfwBEJKipXlbmqbvb/Wu6D7oqPgI3XnpuApRyQQbPrsihVNFzf8ERc8Lah9YUhew
 5EbcwyKRkHWUHSnJ/cUWKhxZnPIf7VpOJzK8siboz3B511gKFbJsA6dwrSRpjnAWRMpM
 AYfJM1d9kbaUZMoqyuM8P4ngRD9JliSqU7uzuF2csHvfVhqFL56QPxCulkIs+nLArxzu
 FJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967596; x=1690559596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KVcMIQlh++eED2SbSh7NaIs1q42NA3S2CoSjBQgfK/A=;
 b=aMYQnt0MTNV0rxzdBDVBvPK7McIuXoUagSXMhVikov/n0fYT8vDDYTxNlufZvSPw4S
 SjzJEMgSYztw5SQJXnCQ5qKth+VyaON7zcsELruunL4TfSNEAxMuZ3fazUCtzRKVwEyF
 PvB2xgxRDEtYEz6wlJPuZcj+C1UCIy0q68B2ZvGTYDJPFkqbDwkk2p2nbrMm5ki022n1
 cy0xpDzsEFv2r8znjbHMvWLIHuvZMyWPLmM991mfpezcOAfC+yC/VmvtvbgXkjriojio
 I4x1Sl0mL642P3HxXSDoghAaojbS2105nQJ6DsPypMB2zqQ0Na5omhX0ujagJjJFVyVH
 MKnA==
X-Gm-Message-State: AC+VfDzUWNG7RYHcHPOfxup4jtHIbbRAGR/RJ4TsQ9NBvxfx2Dr5kM6H
 9ok1DiqHxG0hG8vNTJdBQKNJzgg7FeTfXrAHq+o=
X-Google-Smtp-Source: ACHHUZ4wQqgyw+pfJqoSkUr+zhVmS4sDRvs0Up90ZU+yn5EEFoE5NdcQ1x8axEKrvxiU12nJoO1zxQ==
X-Received: by 2002:aa7:dcd6:0:b0:51d:96d2:6578 with SMTP id
 w22-20020aa7dcd6000000b0051d96d26578mr7534101edu.28.1687967596316; 
 Wed, 28 Jun 2023 08:53:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 v20-20020aa7dbd4000000b00514a5f7a145sm4801898edt.37.2023.06.28.08.53.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:53:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/30] Accelerator patches for 2023-06-28
Date: Wed, 28 Jun 2023 17:52:43 +0200
Message-Id: <20230628155313.71594-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

The following changes since commit b111569da9f82fdf05df03184836a4564adef599:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-06-28 08:42:32 +0200)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-20230628

for you to fetch changes up to 14a868c626e99eea063ecbf6ef86002f6a314f0a:

  exec/memory: Add symbol for the min value of memory listener priority (2023-06-28 14:27:59 +0200)

----------------------------------------------------------------
Accelerators patches

- MAINTAINERS: Update Roman Bolshakov email address
- HAX: Fix a memory leak
- HAX/NVMM/WHPX/HVF: Rename per-accel state as AccelCPUState
- KVM: Restrict specific fields from ArchCPU
- WHPX: Re-enable cross-build gitlab-ci job on case sensitive filesystems
- WHPX: Fix error message when setting ProcessorCount fails
- exec/memory: Add definitions for memory listener priorities

----------------------------------------------------------------

Isaku Yamahata (3):
  exec/memory: Add symbolic value for memory listener priority for accel
  exec/memory: Add symbol for memory listener priority for device
    backend
  exec/memory: Add symbol for the min value of memory listener priority

Philippe Mathieu-Daudé (26):
  MAINTAINERS: Update Roman Bolshakov email address
  docs/devel/testing: Update the 'Docker Debugging' section
  accel: Re-enable WHPX cross-build on case sensitive filesystems
  accel: Document generic accelerator headers
  accel: Remove unused hThread variable on TCG/WHPX
  accel: Fix a leak on Windows HAX
  accel: Destroy HAX vCPU threads once done
  accel: Rename 'hax_vcpu' as 'accel' in CPUState
  accel: Rename HAX 'struct hax_vcpu_state' -> AccelCPUState
  accel: Move HAX hThread to accelerator context
  accel: Remove NVMM unreachable error path
  accel: Rename NVMM 'struct qemu_vcpu' -> AccelCPUState
  accel: Inline NVMM get_qemu_vcpu()
  accel: Remove WHPX unreachable error path
  accel: Rename WHPX 'struct whpx_vcpu' -> AccelCPUState
  accel: Inline WHPX get_whpx_vcpu()
  accel: Rename 'cpu_state' -> 'cs'
  accel: Rename HVF 'struct hvf_vcpu_state' -> AccelCPUState
  accel/kvm: Re-include "exec/memattrs.h" header
  accel/kvm: Declare kvm_direct_msi_allowed in stubs
  hw/intc/arm_gic: Un-inline GIC*/ITS class_name() helpers
  hw/intc/arm_gic: Rename 'first_cpu' argument
  hw/arm/sbsa-ref: Include missing 'sysemu/kvm.h' header
  target/arm: Restrict KVM-specific fields from ArchCPU
  target/ppc: Restrict KVM-specific fields from ArchCPU
  target/riscv: Restrict KVM-specific fields from ArchCPU

Zhao Liu (1):
  target/i386/WHPX: Fix error message when fail to set ProcessorCount

 MAINTAINERS                            |   4 +-
 docs/devel/testing.rst                 |   2 +-
 meson.build                            |   4 +-
 include/exec/memory.h                  |   4 +
 include/hw/core/cpu.h                  |  10 +-
 include/hw/intc/arm_gic.h              |   2 +
 include/hw/intc/arm_gicv3_common.h     |  10 +
 include/hw/intc/arm_gicv3_its_common.h |   9 +
 include/qemu/typedefs.h                |   1 +
 include/sysemu/hax.h                   |   2 +
 include/sysemu/hvf_int.h               |   2 +-
 include/sysemu/kvm.h                   |   3 +
 include/sysemu/nvmm.h                  |   2 +
 include/sysemu/tcg.h                   |   2 +
 include/sysemu/whpx.h                  |   2 +
 include/sysemu/xen.h                   |   2 +
 target/arm/cpu.h                       |   2 +
 target/arm/kvm_arm.h                   |  45 ---
 target/i386/hax/hax-i386.h             |  12 +-
 target/i386/hvf/vmx.h                  |  22 +-
 target/i386/hvf/x86hvf.h               |  18 +-
 target/i386/whpx/whpx-internal.h       |   4 +-
 target/ppc/cpu.h                       |   2 +
 target/riscv/cpu.h                     |   2 +
 accel/hvf/hvf-accel-ops.c              |  21 +-
 accel/kvm/kvm-all.c                    |   5 +-
 accel/stubs/kvm-stub.c                 |   1 +
 accel/tcg/tcg-accel-ops-mttcg.c        |   4 -
 accel/tcg/tcg-accel-ops-rr.c           |   3 -
 hw/arm/sbsa-ref.c                      |   2 +
 hw/arm/virt-acpi-build.c               |   2 +-
 hw/arm/virt.c                          |   1 +
 hw/arm/xen_arm.c                       |   2 +-
 hw/i386/xen/xen-hvm.c                  |   2 +-
 hw/intc/arm_gic_common.c               |  11 +-
 hw/intc/arm_gicv3_common.c             |  14 +
 hw/intc/arm_gicv3_its_common.c         |  12 +
 hw/ppc/e500.c                          |   2 +
 hw/ppc/ppce500_spin.c                  |   2 +
 hw/remote/proxy-memory-listener.c      |   2 +-
 hw/virtio/vhost.c                      |   2 +-
 hw/xen/xen-hvm-common.c                |   2 +-
 hw/xen/xen_pt.c                        |   4 +-
 target/arm/hvf/hvf.c                   | 108 +++----
 target/arm/kvm.c                       |   1 +
 target/i386/hax/hax-accel-ops.c        |   5 +-
 target/i386/hax/hax-all.c              |  26 +-
 target/i386/hax/hax-mem.c              |   2 +-
 target/i386/hax/hax-posix.c            |   4 +-
 target/i386/hax/hax-windows.c          |   6 +-
 target/i386/hvf/hvf.c                  | 106 +++----
 target/i386/hvf/x86.c                  |  28 +-
 target/i386/hvf/x86_descr.c            |  26 +-
 target/i386/hvf/x86_emu.c              |  62 ++---
 target/i386/hvf/x86_mmu.c              |   4 +-
 target/i386/hvf/x86_task.c             |  10 +-
 target/i386/hvf/x86hvf.c               | 372 ++++++++++++-------------
 target/i386/nvmm/nvmm-all.c            |  44 ++-
 target/i386/whpx/whpx-accel-ops.c      |   3 -
 target/i386/whpx/whpx-all.c            |  55 ++--
 target/ppc/mmu_common.c                |   4 +
 target/riscv/cpu.c                     |   2 +-
 target/riscv/machine.c                 |   8 +-
 .mailmap                               |   3 +-
 64 files changed, 582 insertions(+), 559 deletions(-)

-- 
2.38.1


