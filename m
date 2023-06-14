Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9E272F19E
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:22:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FBi-0004XU-MK; Tue, 13 Jun 2023 21:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FBg-0004XJ-2p
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:20:40 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FBd-0004S7-WD
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:20:39 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-39c84863e34so4003225b6e.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705636; x=1689297636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YaTAwXCANxG4J1JOic22QCkLK1g2NJR3e6D6p4rHVHA=;
 b=V/tBmmqTTRAZHksSspPkbH9MSq8JalbxDileZh9lFuhyrVXfDJFI+VEUE/7y3pIlVc
 ujEqMyG5SiNP2BGj+DLh+DmJY9CGqhDp2tdp7wE3r+yjww7sTwCr1ToazynNCqZ4jqUZ
 1/tZ/Zwl+JjnjqIDVBGDFUk+BdR5GOX7iZwcl4P212370DS2qWHHWZm8A+tSnKf/oESm
 D10AXpPJKDxhyQOdIgWgEf0idveq8rlFQYtWq9bqMwN9k+vQnkY9Cwb086+1xEfqfz1S
 wmHtLoORZilfonEpInESkRHRd6MYkAIBJmfTu5bXy0U/UlRsb8ik1KYW8slc0kBBpmPY
 aijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705636; x=1689297636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YaTAwXCANxG4J1JOic22QCkLK1g2NJR3e6D6p4rHVHA=;
 b=TO+bAFGp7HFmb1IhWcqW2V54GTyWla4iWvrhOPx1cYkf3J4CyQZ51p4lGR21tI+EJz
 Q+/ahKpvwvNUKi/HxYYKjoyyDo5Is9S8NMRbVNjyjNIqhI5mzgnWXqNULX0oxBxyuazO
 4U6mIxMswiaCXsnYJ0yQMoSTP3THKj8WlAPim3vZSZmYjxTNAgZf5yMdgQ4Sfa8KSDhr
 6NwPDS5YU7yHnGcYhQJXO30dWnEYo5Yj4eU0HyXyFU6AbFX3gsRF1qOZkfkp86t4C5lV
 EJ1uzz/Ck4i892gUxXp5OhtMohYs99xLkY6OJKhDDBdPE0SaVneVkiPDlgkt/0d03SbI
 Kjpw==
X-Gm-Message-State: AC+VfDyKqnsAqDI4ldDJvYWiPjdIzg4z9JIGocY80L/armsIqzxwmb2h
 p6hwYfFpNOtxteQpAP4FSd8/oKWVM9ckhg==
X-Google-Smtp-Source: ACHHUZ5yMviIO0IyLXTCXW/aGYJc2ex5/WruXybMdBHEQjPXvOpkTYteRVFHwRvemPcKPsU+Tv2/jw==
X-Received: by 2002:a05:6808:220f:b0:39a:bda7:adc1 with SMTP id
 bd15-20020a056808220f00b0039abda7adc1mr12026968oib.2.1686705635661; 
 Tue, 13 Jun 2023 18:20:35 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:20:34 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/60] riscv-to-apply queue
Date: Wed, 14 Jun 2023 11:19:17 +1000
Message-Id: <20230614012017.3100663-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit fdd0df5340a8ebc8de88078387ebc85c5af7b40f:

  Merge tag 'pull-ppc-20230610' of https://gitlab.com/danielhb/qemu into staging (2023-06-10 07:25:00 -0700)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20230614

for you to fetch changes up to 860029321d9ebdff47e89561de61e9441fead70a:

  hw/intc: If mmsiaddrcfgh.L == 1, smsiaddrcfg and smsiaddrcfgh are read-only. (2023-06-14 10:04:30 +1000)

----------------------------------------------------------------
Second RISC-V PR for 8.1

* Skip Vector set tail when vta is zero
* Move zc* out of the experimental properties
* Mask the implicitly enabled extensions in isa_string based on priv version
* Rework CPU extension validation and validate MISA changes
* Fixup PMP TLB cacheing errors
* Writing to pmpaddr and MML/MMWP correctly triggers TLB flushes
* Fixup PMP bypass checks
* Deny access if access is partially inside a PMP entry
* Correct OpenTitanState parent type/size
* Fix QEMU crash when NUMA nodes exceed available CPUs
* Fix pointer mask transformation for vector address
* Updates and improvements for Smstateen
* Support disas for Zcm* extensions
* Support disas for Z*inx extensions
* Remove unused decomp_rv32/64 value for vector instructions
* Enable PC-relative translation
* Assume M-mode FW in pflash0 only when "-bios none"
* Support using pflash via -blockdev option
* Add vector registers to log
* Clean up reference of Vector MTYPE
* Remove the check for extra Vector tail elements
* Smepmp: Return error when access permission not allowed in PMP
* Fixes for smsiaddrcfg and smsiaddrcfgh in AIA

----------------------------------------------------------------
Daniel Henrique Barboza (10):
      target/riscv/vector_helper.c: skip set tail when vta is zero
      target/riscv/cpu.c: add riscv_cpu_validate_v()
      target/riscv/cpu.c: remove set_vext_version()
      target/riscv/cpu.c: remove set_priv_version()
      target/riscv: add PRIV_VERSION_LATEST
      target/riscv/cpu.c: add priv_spec validate/disable_exts helpers
      target/riscv/cpu.c: add riscv_cpu_validate_misa_mxl()
      target/riscv/cpu.c: validate extensions before riscv_timer_init()
      target/riscv/cpu.c: remove cfg setup from riscv_cpu_init()
      target/riscv: rework write_misa()

Himanshu Chauhan (1):
      target/riscv: Smepmp: Return error when access permission not allowed in PMP

Ivan Klokov (1):
      util/log: Add vector registers to log

Mayuresh Chitale (3):
      target/riscv: smstateen check for fcsr
      target/riscv: Reuse tb->flags.FS
      target/riscv: smstateen knobs

Philippe Mathieu-Daudé (5):
      hw/riscv/opentitan: Rename machine_[class]_init() functions
      hw/riscv/opentitan: Declare QOM types using DEFINE_TYPES() macro
      hw/riscv/opentitan: Add TYPE_OPENTITAN_MACHINE definition
      hw/riscv/opentitan: Explicit machine type definition
      hw/riscv/opentitan: Correct OpenTitanState parent type/size

Sunil V L (3):
      hw/riscv: virt: Assume M-mode FW in pflash0 only when "-bios none"
      riscv/virt: Support using pflash via -blockdev option
      docs/system: riscv: Add pflash usage details

Tommy Wu (1):
      hw/intc: If mmsiaddrcfgh.L == 1, smsiaddrcfg and smsiaddrcfgh are read-only.

Weiwei Li (33):
      target/riscv: Move zc* out of the experimental properties
      target/riscv: Mask the implicitly enabled extensions in isa_string based on priv version
      target/riscv: Update check for Zca/Zcf/Zcd
      target/riscv: Update pmp_get_tlb_size()
      target/riscv: Move pmp_get_tlb_size apart from get_physical_address_pmp
      target/riscv: Make the short cut really work in pmp_hart_has_privs
      target/riscv: Change the return type of pmp_hart_has_privs() to bool
      target/riscv: Make RLB/MML/MMWP bits writable only when Smepmp is enabled
      target/riscv: Remove unused paramters in pmp_hart_has_privs_default()
      target/riscv: Flush TLB when MMWP or MML bits are changed
      target/riscv: Update the next rule addr in pmpaddr_csr_write()
      target/riscv: Flush TLB when pmpaddr is updated
      target/riscv: Flush TLB only when pmpcfg/pmpaddr really changes
      target/riscv: Separate pmp_update_rule() in pmpcfg_csr_write
      target/riscv: Deny access if access is partially inside the PMP entry
      target/riscv: Fix pointer mask transformation for vector address
      target/riscv: Update cur_pmmask/base when xl changes
      disas: Change type of disassemble_info.target_info to pointer
      target/riscv: Split RISCVCPUConfig declarations from cpu.h into cpu_cfg.h
      target/riscv: Pass RISCVCPUConfig as target_info to disassemble_info
      disas/riscv.c: Support disas for Zcm* extensions
      disas/riscv.c: Support disas for Z*inx extensions
      disas/riscv.c: Remove unused decomp_rv32/64 value for vector instructions
      disas/riscv.c: Fix lines with over 80 characters
      disas/riscv.c: Remove redundant parentheses
      target/riscv: Fix target address to update badaddr
      target/riscv: Introduce cur_insn_len into DisasContext
      target/riscv: Change gen_goto_tb to work on displacements
      target/riscv: Change gen_set_pc_imm to gen_update_pc
      target/riscv: Use true diff for gen_pc_plus_diff
      target/riscv: Enable PC-relative translation
      target/riscv: Remove pc_succ_insn from DisasContext
      target/riscv: Fix initialized value for cur_pmmask

Xiao Wang (2):
      target/riscv/vector_helper.c: clean up reference of MTYPE
      target/riscv/vector_helper.c: Remove the check for extra tail elements

Yin Wang (1):
      hw/riscv: qemu crash when NUMA nodes exceed available CPUs

 docs/system/riscv/virt.rst                     |   31 +
 include/disas/dis-asm.h                        |    2 +-
 include/hw/core/cpu.h                          |    2 +
 include/hw/riscv/opentitan.h                   |    6 +-
 include/qemu/log.h                             |    1 +
 target/riscv/cpu.h                             |  117 +--
 target/riscv/cpu_cfg.h                         |  136 +++
 target/riscv/pmp.h                             |   11 +-
 accel/tcg/cpu-exec.c                           |    3 +
 disas/riscv.c                                  | 1194 +++++++++++++-----------
 hw/intc/riscv_aplic.c                          |    4 +-
 hw/riscv/numa.c                                |    6 +
 hw/riscv/opentitan.c                           |   38 +-
 hw/riscv/virt.c                                |   59 +-
 target/riscv/cpu.c                             |  384 +++++---
 target/riscv/cpu_helper.c                      |   37 +-
 target/riscv/csr.c                             |   75 +-
 target/riscv/pmp.c                             |  205 ++--
 target/riscv/translate.c                       |   99 +-
 target/riscv/vector_helper.c                   |   33 +-
 util/log.c                                     |    2 +
 target/riscv/insn_trans/trans_privileged.c.inc |    2 +-
 target/riscv/insn_trans/trans_rvd.c.inc        |   12 +-
 target/riscv/insn_trans/trans_rvf.c.inc        |   21 +-
 target/riscv/insn_trans/trans_rvi.c.inc        |   46 +-
 target/riscv/insn_trans/trans_rvv.c.inc        |    4 +-
 target/riscv/insn_trans/trans_rvzawrs.c.inc    |    2 +-
 target/riscv/insn_trans/trans_rvzce.c.inc      |   10 +-
 target/riscv/insn_trans/trans_xthead.c.inc     |    2 +-
 29 files changed, 1442 insertions(+), 1102 deletions(-)
 create mode 100644 target/riscv/cpu_cfg.h

