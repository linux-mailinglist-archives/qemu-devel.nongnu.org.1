Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCE272FE4F
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 14:19:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9PRa-0001VI-Kb; Wed, 14 Jun 2023 08:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q9PRR-0001TU-F5
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:17:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q9PRE-0006DB-UF
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:17:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0ED63C749;
 Wed, 14 Jun 2023 15:17:14 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E7FCAC251;
 Wed, 14 Jun 2023 15:17:10 +0300 (MSK)
Message-ID: <6693132a-c820-5d04-6f9f-ac38d067e935@tls.msk.ru>
Date: Wed, 14 Jun 2023 15:17:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 00/60] riscv-to-apply queue
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.098,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

14.06.2023 04:19, Alistair Francis wrote:
> The following changes since commit fdd0df5340a8ebc8de88078387ebc85c5af7b40f:
> 
>    Merge tag 'pull-ppc-20230610' of https://gitlab.com/danielhb/qemu into staging (2023-06-10 07:25:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20230614
> 
> for you to fetch changes up to 860029321d9ebdff47e89561de61e9441fead70a:
> 
>    hw/intc: If mmsiaddrcfgh.L == 1, smsiaddrcfg and smsiaddrcfgh are read-only. (2023-06-14 10:04:30 +1000)

Is anything there worth to apply to -stable?

I picked this one:
         hw/riscv: qemu crash when NUMA nodes exceed available CPUs

Anything else?

Thanks!

/mjt

> Daniel Henrique Barboza (10):
>        target/riscv/vector_helper.c: skip set tail when vta is zero
>        target/riscv/cpu.c: add riscv_cpu_validate_v()
>        target/riscv/cpu.c: remove set_vext_version()
>        target/riscv/cpu.c: remove set_priv_version()
>        target/riscv: add PRIV_VERSION_LATEST
>        target/riscv/cpu.c: add priv_spec validate/disable_exts helpers
>        target/riscv/cpu.c: add riscv_cpu_validate_misa_mxl()
>        target/riscv/cpu.c: validate extensions before riscv_timer_init()
>        target/riscv/cpu.c: remove cfg setup from riscv_cpu_init()
>        target/riscv: rework write_misa()
> 
> Himanshu Chauhan (1):
>        target/riscv: Smepmp: Return error when access permission not allowed in PMP
> 
> Ivan Klokov (1):
>        util/log: Add vector registers to log
> 
> Mayuresh Chitale (3):
>        target/riscv: smstateen check for fcsr
>        target/riscv: Reuse tb->flags.FS
>        target/riscv: smstateen knobs
> 
> Philippe Mathieu-Daudé (5):
>        hw/riscv/opentitan: Rename machine_[class]_init() functions
>        hw/riscv/opentitan: Declare QOM types using DEFINE_TYPES() macro
>        hw/riscv/opentitan: Add TYPE_OPENTITAN_MACHINE definition
>        hw/riscv/opentitan: Explicit machine type definition
>        hw/riscv/opentitan: Correct OpenTitanState parent type/size
> 
> Sunil V L (3):
>        hw/riscv: virt: Assume M-mode FW in pflash0 only when "-bios none"
>        riscv/virt: Support using pflash via -blockdev option
>        docs/system: riscv: Add pflash usage details
> 
> Tommy Wu (1):
>        hw/intc: If mmsiaddrcfgh.L == 1, smsiaddrcfg and smsiaddrcfgh are read-only.
> 
> Weiwei Li (33):
>        target/riscv: Move zc* out of the experimental properties
>        target/riscv: Mask the implicitly enabled extensions in isa_string based on priv version
>        target/riscv: Update check for Zca/Zcf/Zcd
>        target/riscv: Update pmp_get_tlb_size()
>        target/riscv: Move pmp_get_tlb_size apart from get_physical_address_pmp
>        target/riscv: Make the short cut really work in pmp_hart_has_privs
>        target/riscv: Change the return type of pmp_hart_has_privs() to bool
>        target/riscv: Make RLB/MML/MMWP bits writable only when Smepmp is enabled
>        target/riscv: Remove unused paramters in pmp_hart_has_privs_default()
>        target/riscv: Flush TLB when MMWP or MML bits are changed
>        target/riscv: Update the next rule addr in pmpaddr_csr_write()
>        target/riscv: Flush TLB when pmpaddr is updated
>        target/riscv: Flush TLB only when pmpcfg/pmpaddr really changes
>        target/riscv: Separate pmp_update_rule() in pmpcfg_csr_write
>        target/riscv: Deny access if access is partially inside the PMP entry
>        target/riscv: Fix pointer mask transformation for vector address
>        target/riscv: Update cur_pmmask/base when xl changes
>        disas: Change type of disassemble_info.target_info to pointer
>        target/riscv: Split RISCVCPUConfig declarations from cpu.h into cpu_cfg.h
>        target/riscv: Pass RISCVCPUConfig as target_info to disassemble_info
>        disas/riscv.c: Support disas for Zcm* extensions
>        disas/riscv.c: Support disas for Z*inx extensions
>        disas/riscv.c: Remove unused decomp_rv32/64 value for vector instructions
>        disas/riscv.c: Fix lines with over 80 characters
>        disas/riscv.c: Remove redundant parentheses
>        target/riscv: Fix target address to update badaddr
>        target/riscv: Introduce cur_insn_len into DisasContext
>        target/riscv: Change gen_goto_tb to work on displacements
>        target/riscv: Change gen_set_pc_imm to gen_update_pc
>        target/riscv: Use true diff for gen_pc_plus_diff
>        target/riscv: Enable PC-relative translation
>        target/riscv: Remove pc_succ_insn from DisasContext
>        target/riscv: Fix initialized value for cur_pmmask
> 
> Xiao Wang (2):
>        target/riscv/vector_helper.c: clean up reference of MTYPE
>        target/riscv/vector_helper.c: Remove the check for extra tail elements
> 
> Yin Wang (1):
>        hw/riscv: qemu crash when NUMA nodes exceed available CPUs
> 
>   docs/system/riscv/virt.rst                     |   31 +
>   include/disas/dis-asm.h                        |    2 +-
>   include/hw/core/cpu.h                          |    2 +
>   include/hw/riscv/opentitan.h                   |    6 +-
>   include/qemu/log.h                             |    1 +
>   target/riscv/cpu.h                             |  117 +--
>   target/riscv/cpu_cfg.h                         |  136 +++
>   target/riscv/pmp.h                             |   11 +-
>   accel/tcg/cpu-exec.c                           |    3 +
>   disas/riscv.c                                  | 1194 +++++++++++++-----------
>   hw/intc/riscv_aplic.c                          |    4 +-
>   hw/riscv/numa.c                                |    6 +
>   hw/riscv/opentitan.c                           |   38 +-
>   hw/riscv/virt.c                                |   59 +-
>   target/riscv/cpu.c                             |  384 +++++---
>   target/riscv/cpu_helper.c                      |   37 +-
>   target/riscv/csr.c                             |   75 +-
>   target/riscv/pmp.c                             |  205 ++--
>   target/riscv/translate.c                       |   99 +-
>   target/riscv/vector_helper.c                   |   33 +-
>   util/log.c                                     |    2 +
>   target/riscv/insn_trans/trans_privileged.c.inc |    2 +-
>   target/riscv/insn_trans/trans_rvd.c.inc        |   12 +-
>   target/riscv/insn_trans/trans_rvf.c.inc        |   21 +-
>   target/riscv/insn_trans/trans_rvi.c.inc        |   46 +-
>   target/riscv/insn_trans/trans_rvv.c.inc        |    4 +-
>   target/riscv/insn_trans/trans_rvzawrs.c.inc    |    2 +-
>   target/riscv/insn_trans/trans_rvzce.c.inc      |   10 +-
>   target/riscv/insn_trans/trans_xthead.c.inc     |    2 +-
>   29 files changed, 1442 insertions(+), 1102 deletions(-)
>   create mode 100644 target/riscv/cpu_cfg.h
> 


