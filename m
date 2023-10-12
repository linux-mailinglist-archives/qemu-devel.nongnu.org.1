Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC19E7C63BC
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:12:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn2V-0000uC-3U; Thu, 12 Oct 2023 00:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2T-0000u4-NY
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2R-00021x-26
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-690d8fb3b7eso491270b3a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083864; x=1697688664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TVoZ2RuX06sDlhFDfm7miA4ai3fPJXkQ20LTdcME8CY=;
 b=C9WdJawVOopO2Up6bwzZe94rxQNcfH0ASt3UAB8QZUKn+MnEqk1/8dH1EO9Ws2ShlD
 2oMDk2YKUkZHivgjQPQ+4qIo5jjYQ9aSuKZIBkfBB5CY5SaeL/AIzo6mx9dBGh39Auwi
 k9A00pBFchjuBQVs2cWkpGN1kObshZH+7UpSVkq8lMIzyP4GIVQ9nxPj1LPUg16ipREV
 0rbF4jsg3NKszwoffPqMzzm5vAi0y68z9iYaO4/8Yj+A92XqtF17vKg1afvaMUVcCCIv
 EwChAy6TmatpF89N6+IyNpbaXovbaKw9N/V8khCPvAHrYoaZq9zEWJo3r/pAj8Xn0oHt
 IP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083864; x=1697688664;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TVoZ2RuX06sDlhFDfm7miA4ai3fPJXkQ20LTdcME8CY=;
 b=H+UOriLxHX2auyx5HAKnBYRvEpIhV8AL0G/Yh+lgZ+AweRzZhKauZKYQZ2n/eNCtiD
 ia6skLnFtBfO4M+vzpK3EiSZmcmscSdUj+qo2c014d4Q6JL3Woi9+RGkdqOUiAKjh+hS
 9XOhIuVoXc55Bo4l1+fQiBuuyB2w3ZTE2Cl0TNcB1cHfBvW/SOBXtCvRsG+6Y660eRTG
 C89U2hgsRk+T97T8HDeBYD3f5QhcFC4dsso0l5Ncn6yMxB/L99zzNW+dzYZgI0zKQ5UL
 2Pcn7KYiGcWjKrtKR2u/xeWZDjCHWCK5zt/iksoEzb8BviTEkEUr9J3LYvvl4bqZ6KmG
 HOPQ==
X-Gm-Message-State: AOJu0YwzzlUYeQQ10+wEBpVjG3xMxtF4RO+TYoT6QIAdkY+R+Odi0UE6
 hO2oC/oGZeyHg2hPLuzOgnxVaydUJUzUSQ==
X-Google-Smtp-Source: AGHT+IHUDK3HQdt8Ar/mDQf5CFXyUDcynZ1T5AesRwLFG8jHGXkq2qhMu/IbcPqplsKWQzY9dyPNDg==
X-Received: by 2002:a05:6a20:841c:b0:174:2d20:5404 with SMTP id
 c28-20020a056a20841c00b001742d205404mr3544330pzd.37.1697083864464; 
 Wed, 11 Oct 2023 21:11:04 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:03 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/54] riscv-to-apply queue
Date: Thu, 12 Oct 2023 14:09:57 +1000
Message-ID: <20231012041051.2572507-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The following changes since commit a51e5124a655b3dad80b36b18547cb1eca2c5eb2:

  Merge tag 'pull-omnibus-111023-1' of https://gitlab.com/stsquad/qemu into staging (2023-10-11 09:43:10 -0400)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20231012-1

for you to fetch changes up to 837570cef237b634eb4c245363470deebea7089d:

  target/riscv: Fix vfwmaccbf16.vf (2023-10-12 12:50:13 +1000)

----------------------------------------------------------------
Second RISC-V PR for 8.2

 * Add support for the max CPU
 * Detect user choice in TCG
 * Clear CSR values at reset and sync MPSTATE with host
 * Fix the typo of inverted order of pmpaddr13 and pmpaddr14
 * Split TCG/KVM accelerators from cpu.c
 * Add extension properties for all cpus
 * Replace GDB exit calls with proper shutdown
 * Support KVM_GET_REG_LIST
 * Remove RVG warning
 * Use env_archcpu for better performance
 * Deprecate capital 'Z' CPU properties
 * Fix vfwmaccbf16.vf

----------------------------------------------------------------
Alvin Chang (1):
      disas/riscv: Fix the typo of inverted order of pmpaddr13 and pmpaddr14

Clément Chigot (5):
      softmmu: add means to pass an exit code when requesting a shutdown
      softmmu: pass the main loop status to gdb "Wxx" packet
      hw/misc/sifive_test.c: replace exit calls with proper shutdown
      hw/char: riscv_htif: replace exit calls with proper shutdown
      gdbstub: replace exit calls with proper shutdown for softmmu

Daniel Henrique Barboza (45):
      target/riscv/cpu.c: split CPU options from riscv_cpu_extensions[]
      target/riscv/cpu.c: skip 'bool' check when filtering KVM props
      target/riscv/cpu.c: split kvm prop handling to its own helper
      target/riscv: add DEFINE_PROP_END_OF_LIST() to riscv_cpu_options[]
      target/riscv/cpu.c: split non-ratified exts from riscv_cpu_extensions[]
      target/riscv/cpu.c: split vendor exts from riscv_cpu_extensions[]
      target/riscv/cpu.c: add riscv_cpu_add_qdev_prop_array()
      target/riscv/cpu.c: add riscv_cpu_add_kvm_unavail_prop_array()
      target/riscv/cpu.c: limit cfg->vext_spec log message
      target/riscv: add 'max' CPU type
      avocado, risc-v: add tuxboot tests for 'max' CPU
      target/riscv: deprecate the 'any' CPU type
      target/riscv/cpu.c: use offset in isa_ext_is_enabled/update_enabled
      target/riscv: make CPUCFG() macro public
      target/riscv/cpu.c: introduce cpu_cfg_ext_auto_update()
      target/riscv/cpu.c: use cpu_cfg_ext_auto_update() during realize()
      target/riscv/cpu.c: introduce RISCVCPUMultiExtConfig
      target/riscv: use isa_ext_update_enabled() in init_max_cpu_extensions()
      target/riscv/cpu.c: honor user choice in cpu_cfg_ext_auto_update()
      target/riscv/cpu.c: consider user option with RVG
      target/riscv: introduce TCG AccelCPUClass
      target/riscv: move riscv_cpu_realize_tcg() to TCG::cpu_realizefn()
      target/riscv: move riscv_cpu_validate_set_extensions() to tcg-cpu.c
      target/riscv: move riscv_tcg_ops to tcg-cpu.c
      target/riscv/cpu.c: add .instance_post_init()
      target/riscv: move 'host' CPU declaration to kvm.c
      target/riscv/cpu.c: mark extensions arrays as 'const'
      target/riscv: move riscv_cpu_add_kvm_properties() to kvm.c
      target/riscv: make riscv_add_satp_mode_properties() public
      target/riscv: remove kvm-stub.c
      target/riscv: introduce KVM AccelCPUClass
      target/riscv: move KVM only files to kvm subdir
      target/riscv/kvm: do not use riscv_cpu_add_misa_properties()
      target/riscv/cpu.c: export set_misa()
      target/riscv/tcg: introduce tcg_cpu_instance_init()
      target/riscv/cpu.c: make misa_ext_cfgs[] 'const'
      target/riscv/tcg: move riscv_cpu_add_misa_properties() to tcg-cpu.c
      target/riscv/cpu.c: export isa_edata_arr[]
      target/riscv/cpu: move priv spec functions to tcg-cpu.c
      target/riscv: add riscv_cpu_get_name()
      target/riscv/tcg-cpu.c: add extension properties for all cpus
      target/riscv/kvm: improve 'init_multiext_cfg' error msg
      target/riscv/kvm: support KVM_GET_REG_LIST
      target/riscv/tcg: remove RVG warning
      target/riscv: deprecate capital 'Z' CPU properties

Max Chou (1):
      target/riscv: Fix vfwmaccbf16.vf

Richard W.M. Jones (1):
      target/riscv: Use env_archcpu for better performance

liguang.zhang (1):
      target/riscv: Clear CSR values at reset and sync MPSTATE with host

 docs/about/deprecated.rst             |   35 ++
 include/gdbstub/syscalls.h            |    9 +
 include/sysemu/runstate.h             |    2 +
 include/sysemu/sysemu.h               |    2 +-
 target/riscv/cpu-qom.h                |    1 +
 target/riscv/cpu.h                    |   34 +-
 target/riscv/{ => kvm}/kvm_riscv.h    |    2 +-
 target/riscv/tcg/tcg-cpu.h            |   27 +
 disas/riscv.c                         |    4 +-
 gdbstub/gdbstub.c                     |    5 +-
 gdbstub/system.c                      |    6 +
 gdbstub/user.c                        |    6 +
 hw/char/riscv_htif.c                  |    5 +-
 hw/intc/riscv_aplic.c                 |    2 +-
 hw/misc/sifive_test.c                 |    9 +-
 hw/riscv/virt.c                       |    2 +-
 system/main.c                         |    2 +-
 system/runstate.c                     |   16 +-
 target/riscv/cpu.c                    | 1030 +++++++--------------------------
 target/riscv/cpu_helper.c             |    3 +-
 target/riscv/csr.c                    |    1 +
 target/riscv/kvm-stub.c               |   30 -
 target/riscv/{kvm.c => kvm/kvm-cpu.c} |  272 ++++++++-
 target/riscv/tcg/tcg-cpu.c            |  949 ++++++++++++++++++++++++++++++
 target/riscv/vector_helper.c          |    2 +-
 target/riscv/kvm/meson.build          |    1 +
 target/riscv/meson.build              |    4 +-
 target/riscv/tcg/meson.build          |    2 +
 tests/avocado/tuxrun_baselines.py     |   32 +
 29 files changed, 1604 insertions(+), 891 deletions(-)
 rename target/riscv/{ => kvm}/kvm_riscv.h (95%)
 create mode 100644 target/riscv/tcg/tcg-cpu.h
 delete mode 100644 target/riscv/kvm-stub.c
 rename target/riscv/{kvm.c => kvm/kvm-cpu.c} (81%)
 create mode 100644 target/riscv/tcg/tcg-cpu.c
 create mode 100644 target/riscv/kvm/meson.build
 create mode 100644 target/riscv/tcg/meson.build

