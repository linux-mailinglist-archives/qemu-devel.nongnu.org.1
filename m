Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5696798281
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:40:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeV8y-00081a-Vj; Fri, 08 Sep 2023 02:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qeV8p-00081N-0V
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:38:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qeV8k-000862-HH
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:38:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3A99E1FF8F;
 Fri,  8 Sep 2023 09:39:35 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6ADF0267EB;
 Fri,  8 Sep 2023 09:38:46 +0300 (MSK)
Message-ID: <f47bf3d0-8856-1c15-9534-8f4be297d7c2@tls.msk.ru>
Date: Fri, 8 Sep 2023 09:38:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL 00/65] riscv-to-apply queue
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

08.09.2023 09:03, Alistair Francis wrote:

> Akihiko Odaki (1):
>        target/riscv: Allocate itrigger timers only once
> 
> Ard Biesheuvel (2):
>        target/riscv: Use existing lookup tables for MixColumns
>        target/riscv: Use accelerated helper for AES64KS1I
> 
> Conor Dooley (1):
>        hw/riscv: virt: Fix riscv,pmu DT node path
> 
> Daniel Henrique Barboza (26):
>        target/riscv/cpu.c: do not run 'host' CPU with TCG
>        target/riscv/cpu.c: add zmmul isa string
>        target/riscv/cpu.c: add smepmp isa string
>        target/riscv: fix satp_mode_finalize() when satp_mode.supported = 0
>        hw/riscv/virt.c: fix non-KVM --enable-debug build
>        hw/intc/riscv_aplic.c fix non-KVM --enable-debug build
>        target/riscv/cpu.c: split CPU options from riscv_cpu_extensions[]
>        target/riscv/cpu.c: skip 'bool' check when filtering KVM props
>        target/riscv/cpu.c: split kvm prop handling to its own helper
>        target/riscv: add DEFINE_PROP_END_OF_LIST() to riscv_cpu_options[]
>        target/riscv/cpu.c: split non-ratified exts from riscv_cpu_extensions[]
>        target/riscv/cpu.c: split vendor exts from riscv_cpu_extensions[]
>        target/riscv/cpu.c: add riscv_cpu_add_qdev_prop_array()
>        target/riscv/cpu.c: add riscv_cpu_add_kvm_unavail_prop_array()
>        target/riscv/cpu.c: limit cfg->vext_spec log message
>        target/riscv: add 'max' CPU type
>        avocado, risc-v: add tuxboot tests for 'max' CPU
>        target/riscv: deprecate the 'any' CPU type
>        target/riscv/cpu.c: use offset in isa_ext_is_enabled/update_enabled
>        target/riscv: make CPUCFG() macro public
>        target/riscv/cpu.c: introduce cpu_cfg_ext_auto_update()
>        target/riscv/cpu.c: use cpu_cfg_ext_auto_update() during realize()
>        target/riscv/cpu.c: introduce RISCVCPUMultiExtConfig
>        target/riscv: use isa_ext_update_enabled() in init_max_cpu_extensions()
>        target/riscv/cpu.c: honor user choice in cpu_cfg_ext_auto_update()
>        target/riscv/cpu.c: consider user option with RVG
> 
> Dickon Hood (2):
>        target/riscv: Refactor translation of vector-widening instruction
>        target/riscv: Add Zvbb ISA extension support
> 
> Jason Chien (3):
>        target/riscv: Add Zihintntl extension ISA string to DTS
>        hw/intc: Fix upper/lower mtime write calculation
>        hw/intc: Make rtc variable names consistent
> 
> Kiran Ostrolenk (4):
>        target/riscv: Refactor some of the generic vector functionality
>        target/riscv: Refactor vector-vector translation macro
>        target/riscv: Refactor some of the generic vector functionality
>        target/riscv: Add Zvknh ISA extension support
> 
> LIU Zhiwei (3):
>        target/riscv: Fix page_check_range use in fault-only-first
>        target/riscv: Fix zfa fleq.d and fltq.d
>        linux-user/riscv: Use abi type for target_ucontext
> 
> Lawrence Hunter (2):
>        target/riscv: Add Zvbc ISA extension support
>        target/riscv: Add Zvksh ISA extension support
> 
> Leon Schuermann (1):
>        target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes
> 
> Max Chou (3):
>        crypto: Create sm4_subword
>        crypto: Add SM4 constant parameter CK
>        target/riscv: Add Zvksed ISA extension support
> 
> Nazar Kazakov (4):
>        target/riscv: Remove redundant "cpu_vl == 0" checks
>        target/riscv: Move vector translation checks
>        target/riscv: Add Zvkned ISA extension support
>        target/riscv: Add Zvkg ISA extension support
> 
> Nikita Shubin (1):
>        target/riscv: don't read CSR in riscv_csrrw_do64
> 
> Rob Bradford (1):
>        target/riscv: Implement WARL behaviour for mcountinhibit/mcounteren
> 
> Robbin Ehn (1):
>        linux-user/riscv: Add new extensions to hwprobe
> 
> Thomas Huth (2):
>        hw/char/riscv_htif: Fix printing of console characters on big endian hosts
>        hw/char/riscv_htif: Fix the console syscall on big endian hosts
> 
> Tommy Wu (1):
>        target/riscv: Align the AIA model to v1.0 ratified spec
> 
> Vineet Gupta (1):
>        riscv: zicond: make non-experimental
> 
> Weiwei Li (1):
>        target/riscv: Update CSR bits name for svadu extension
> 
> Yong-Xuan Wang (5):
>        target/riscv: support the AIA device emulation with KVM enabled
>        target/riscv: check the in-kernel irqchip support
>        target/riscv: Create an KVM AIA irqchip
>        target/riscv: update APLIC and IMSIC to support KVM AIA
>        target/riscv: select KVM AIA in riscv virt machine

 From the above, it looks like the following are candidates for -stable:

  02/65 hw/char/riscv_htif: Fix printing of console characters on big endian hosts
  06/65 target/riscv: Fix page_check_range use in fault-only-first
  25/65 target/riscv: Fix zfa fleq.d and fltq.d
  26/65 hw/intc: Fix upper/lower mtime write calculation
  27/65 hw/intc: Make rtc variable names consistent
    (not really necessary but completes the previous change)
  28/65 linux-user/riscv: Use abi type for target_ucontext
  34/65 hw/riscv: virt: Fix riscv,pmu DT node path
  36/65 target/riscv: fix satp_mode_finalize() when satp_mode.supported = 0

Also maybe:

  38/65 hw/riscv/virt.c: fix non-KVM --enable-debug build
  39/65 hw/intc/riscv_aplic.c fix non-KVM --enable-debug build

Please let me know if either something from the above list should not
be pickled up for stable, or something else should be added there.

Thank you!

/mjt

