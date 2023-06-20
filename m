Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A565573660F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWh4-0003pE-RP; Tue, 20 Jun 2023 04:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgu-0003mz-Js
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:20 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgp-00064h-U2
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:18 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9891c73e0fbso115813666b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249574; x=1689841574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PYEf87haCRmnGkzlV0sYkpkta/m4TWw2ilrcrXYvR6k=;
 b=p8Q8+sjjBxDqa79KLBW1y32ujKPysDJZzDemkL+n0cjLrFFnP4jcbaxDaHPyBRY5yq
 dmFUelnOcgbvIJfG0u6wtGOmJUZ7dNKTFMcidAk/jxngtjhMKopsY+RlVxPLCenlEeAY
 cpdgn6Vgm3tp099DiQ/bEZ4BHQPJ7zp/Y52tMsmDYjuKuZvYzYTPITWyhbeCz61Qfa1p
 h9NxjzoLVMKqrH6s0yf3clher6+uYfsIPCpc1EZLVD15eF/erieM2XCS5baLoa9EkKf+
 3QcSo48nT76RFyHyz9yeoP5BXHqd278wWp+0jWUyGqruTh68TBDIx0bd98mE72F1yZlx
 l/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249574; x=1689841574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PYEf87haCRmnGkzlV0sYkpkta/m4TWw2ilrcrXYvR6k=;
 b=XemTxD+xaagZXr1dVoIN3ny/Ex2tTt2efbn132AoQ7bPvx9cwglYJ578Bm9RRKddO9
 cweOZISNml835KeShGpiokxeVov31zf6kAaCk0YJWpuSCb7KdmYKIUAehcll83MZAst3
 03Gp+Fbe5kFZi3q7oEsa+yssGnlJR4mT149BYn0K9DF1YRJXNm65x7EZyG2ubq5WAfrs
 OoUdK266z93+YZ9c6MP8Jq98GSsgTCPsjYRrZshAFoQ/ly8YH+Xoft/pHWNkPAFAba3o
 YhQl+lsdAWixXA0k1trIM2e7s3emytBFWSRSKTUXjgkqIheWvKFR2A8Va3p9kCeNGjEA
 AkhQ==
X-Gm-Message-State: AC+VfDyPZvxGi3dE5hCAl/71zrQMap3zWyJ+83JQpaZIxCFPYGmyK6Jm
 KZlgC+WOvAcIzu2QQOOV6zEQicIQfirksYuFEwzet7Z9
X-Google-Smtp-Source: ACHHUZ6KnTnHbSlXrq40twhwZ+qWv3V10Dlnx4vfJh8PNXhVpj3FVb/QFQlRO+FkDn+dxrZU6e3TKQ==
X-Received: by 2002:a17:907:3ea4:b0:978:8979:c66c with SMTP id
 hs36-20020a1709073ea400b009788979c66cmr17414933ejc.18.1687249573755; 
 Tue, 20 Jun 2023 01:26:13 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] tcg patch queue
Date: Tue, 20 Jun 2023 10:25:55 +0200
Message-Id: <20230620082611.770620-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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

The following changes since commit 48ab886d3da4f3ab94f79f6c0f8b4535b446bbfd:

  Merge tag 'pull-target-arm-20230619' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-06-19 16:32:25 +0200)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230620

for you to fetch changes up to d7ee93e24359703debf4137f4cc632563aa4e8d1:

  cputlb: Restrict SavedIOTLB to system emulation (2023-06-20 10:02:14 +0200)

----------------------------------------------------------------
tcg: Define _CALL_AIX for clang on ppc64
accel/tcg: Build fix for macos catalina
accel/tcg: Handle MO_ATOM_WITHIN16 in do_st16_leN
accel/tcg: Restrict SavedIOTLB to system emulation
accel/tcg: Use generic 'helper-proto-common.h' header
plugins: Remove unused 'exec/helper-proto.h' header
*: Check for CONFIG_USER_ONLY instead of CONFIG_SOFTMMU

----------------------------------------------------------------
Philippe Mathieu-Daudé (13):
      target/i386: Simplify i386_tr_init_disas_context()
      target/tricore: Remove pointless CONFIG_SOFTMMU guard
      target/m68k: Check for USER_ONLY definition instead of SOFTMMU one
      target/ppc: Check for USER_ONLY definition instead of SOFTMMU one
      hw/core/cpu: Check for USER_ONLY definition instead of SOFTMMU one
      accel/tcg: Check for USER_ONLY definition instead of SOFTMMU one
      meson: Alias CONFIG_SOFTMMU -> CONFIG_SYSTEM_ONLY
      meson: Replace CONFIG_SOFTMMU -> CONFIG_SYSTEM_ONLY
      meson: Replace softmmu_ss -> system_ss
      plugins: Remove unused 'exec/helper-proto.h' header
      accel/tcg/cpu-exec: Use generic 'helper-proto-common.h' header
      exec/cpu-defs: Check for SOFTMMU instead of !USER_ONLY
      cputlb: Restrict SavedIOTLB to system emulation

Richard Henderson (3):
      host/include/x86_64: Use __m128i for "x" constraints
      accel/tcg: Handle MO_ATOM_WITHIN16 in do_st16_leN
      tcg/ppc: Define _CALL_AIX for clang on ppc64(be)

 docs/devel/build-system.rst                      |  14 +--
 meson.build                                      |  15 +--
 accel/tcg/internal.h                             |   6 +-
 host/include/x86_64/host/atomic128-ldst.h        |  25 ++--
 host/include/x86_64/host/load-extract-al16-al8.h |   8 +-
 include/exec/cpu-defs.h                          |  12 +-
 include/hw/core/cpu.h                            |  10 +-
 include/hw/core/tcg-cpu-ops.h                    | 102 ++++++++--------
 target/m68k/helper.h                             |   2 +-
 accel/tcg/cpu-exec.c                             |   6 +-
 accel/tcg/cputlb.c                               |   1 +
 plugins/core.c                                   |   1 -
 target/i386/tcg/translate.c                      |   3 -
 target/m68k/cpu.c                                |  14 +--
 target/m68k/helper.c                             |   4 +-
 target/m68k/translate.c                          |  28 ++---
 target/ppc/cpu_init.c                            |  20 +--
 target/ppc/helper_regs.c                         |   6 +-
 target/tricore/helper.c                          |   2 -
 tcg/ppc/tcg-target.c.inc                         |  23 ++--
 accel/meson.build                                |   4 +-
 accel/qtest/meson.build                          |   2 +-
 accel/stubs/meson.build                          |   2 +-
 accel/tcg/meson.build                            |   6 +-
 audio/meson.build                                |   8 +-
 backends/meson.build                             |  20 +--
 backends/tpm/meson.build                         |   8 +-
 block/meson.build                                |   6 +-
 block/monitor/meson.build                        |   2 +-
 chardev/meson.build                              |   2 +-
 disas/meson.build                                |   2 +-
 dump/meson.build                                 |   4 +-
 ebpf/meson.build                                 |   2 +-
 fsdev/meson.build                                |   4 +-
 gdbstub/meson.build                              |  10 +-
 hw/9pfs/meson.build                              |   2 +-
 hw/acpi/meson.build                              |  10 +-
 hw/adc/meson.build                               |  10 +-
 hw/arm/meson.build                               |   8 +-
 hw/audio/meson.build                             |  28 ++---
 hw/block/meson.build                             |  28 ++---
 hw/char/meson.build                              |  70 +++++------
 hw/core/meson.build                              |  22 ++--
 hw/cpu/meson.build                               |   6 +-
 hw/cxl/meson.build                               |   4 +-
 hw/display/meson.build                           |  76 ++++++------
 hw/dma/meson.build                               |  32 ++---
 hw/gpio/meson.build                              |  26 ++--
 hw/i2c/meson.build                               |   2 +-
 hw/i386/kvm/meson.build                          |   2 +-
 hw/ide/meson.build                               |  28 ++---
 hw/input/meson.build                             |  32 ++---
 hw/intc/meson.build                              |  44 +++----
 hw/ipack/meson.build                             |   2 +-
 hw/ipmi/meson.build                              |   2 +-
 hw/isa/meson.build                               |  18 +--
 hw/mem/meson.build                               |   8 +-
 hw/misc/macio/meson.build                        |   2 +-
 hw/misc/meson.build                              | 148 +++++++++++------------
 hw/net/can/meson.build                           |  16 +--
 hw/net/meson.build                               |  96 +++++++--------
 hw/nubus/meson.build                             |   2 +-
 hw/nvme/meson.build                              |   2 +-
 hw/nvram/meson.build                             |  26 ++--
 hw/pci-bridge/meson.build                        |   4 +-
 hw/pci-host/meson.build                          |   2 +-
 hw/pci/meson.build                               |   8 +-
 hw/pcmcia/meson.build                            |   4 +-
 hw/rdma/meson.build                              |   2 +-
 hw/remote/meson.build                            |   2 +-
 hw/rtc/meson.build                               |  28 ++---
 hw/scsi/meson.build                              |   2 +-
 hw/sd/meson.build                                |  24 ++--
 hw/sensor/meson.build                            |  18 +--
 hw/smbios/meson.build                            |   6 +-
 hw/ssi/meson.build                               |  26 ++--
 hw/timer/meson.build                             |  74 ++++++------
 hw/tpm/meson.build                               |  14 +--
 hw/usb/meson.build                               |  74 ++++++------
 hw/virtio/meson.build                            |  12 +-
 hw/watchdog/meson.build                          |  18 +--
 hw/xen/meson.build                               |   4 +-
 migration/meson.build                            |  12 +-
 monitor/meson.build                              |   6 +-
 net/can/meson.build                              |   2 +-
 net/meson.build                                  |  38 +++---
 qapi/meson.build                                 |   2 +-
 qom/meson.build                                  |   2 +-
 replay/meson.build                               |   2 +-
 semihosting/meson.build                          |   2 +-
 softmmu/meson.build                              |  12 +-
 stats/meson.build                                |   2 +-
 target/alpha/meson.build                         |   6 +-
 target/arm/hvf/meson.build                       |   2 +-
 target/arm/meson.build                           |   6 +-
 target/arm/tcg/meson.build                       |   2 +-
 target/avr/meson.build                           |   6 +-
 target/cris/meson.build                          |   6 +-
 target/hppa/meson.build                          |   6 +-
 target/i386/hax/meson.build                      |   6 +-
 target/i386/hvf/meson.build                      |   2 +-
 target/i386/kvm/meson.build                      |   4 +-
 target/i386/meson.build                          |   8 +-
 target/i386/nvmm/meson.build                     |   4 +-
 target/i386/tcg/sysemu/meson.build               |   2 +-
 target/i386/whpx/meson.build                     |   2 +-
 target/loongarch/meson.build                     |   6 +-
 target/m68k/meson.build                          |   6 +-
 target/microblaze/meson.build                    |   6 +-
 target/mips/meson.build                          |   4 +-
 target/mips/sysemu/meson.build                   |   2 +-
 target/mips/tcg/sysemu/meson.build               |   2 +-
 target/nios2/meson.build                         |   6 +-
 target/openrisc/meson.build                      |   6 +-
 target/ppc/meson.build                           |  10 +-
 target/riscv/meson.build                         |   6 +-
 target/s390x/kvm/meson.build                     |   2 +-
 target/s390x/meson.build                         |   6 +-
 target/sh4/meson.build                           |   6 +-
 target/sparc/meson.build                         |   6 +-
 target/tricore/meson.build                       |   4 +-
 target/xtensa/meson.build                        |   6 +-
 tcg/meson.build                                  |   2 +-
 trace/meson.build                                |   2 +-
 ui/meson.build                                   |  30 ++---
 125 files changed, 864 insertions(+), 854 deletions(-)

