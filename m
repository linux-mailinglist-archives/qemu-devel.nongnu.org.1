Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB48266EE
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 01:36:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMdbh-0004C7-9Q; Sun, 07 Jan 2024 19:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rMdbb-0004BS-LY; Sun, 07 Jan 2024 19:35:03 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rMdbS-0007qO-PI; Sun, 07 Jan 2024 19:35:03 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67f8d9fe99fso13518666d6.2; 
 Sun, 07 Jan 2024 16:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704674092; x=1705278892; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BwABrhnGAjQCRR+6x6oj+0T+DauJMqQhO4UI/GHcbw=;
 b=lo1WrRtjyQDo+9euQNQomgyz5sHZyhFdMo166yF5tX+qpDa3DvF4bXUv9PNaQRtgr3
 YCcbDJ7Wr33Kyl6ZBqvSzrRoFRZEvovZEwG1oBuDJ0Fsh/IpfFqVlHmjgae8uiDw8aGp
 YnQVN2T7zQAMiyA4ZSS4bS36lwpuA/cuasNMx5eG6PUTeHIrk/NXffvh4QdAmIj6sFLF
 MZWFtjWBQjT5O5xghCWozgRreBgpUmbDFOJgEXvN4CZV4dutn51zjgB8q+8reQX2Dkru
 3J2S2qmJb3cxWvpyvFPULNtisUTASst5gtS6qAAnM/w1VEtCGzNkU4zoYRhtmonNhzLF
 NTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704674092; x=1705278892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+BwABrhnGAjQCRR+6x6oj+0T+DauJMqQhO4UI/GHcbw=;
 b=M5Q7CTEEI6BaAtUiqNcUwv3ZJPX2gldM5Kz38usNDjCgHIUYuE19zgZVP30hJXoxDk
 pqYMJ+m0UBd3hYEGbiVhETKeYOTAffvfWHkj7Bg/8Y0gwPBv45DeCQqEzaiApDlqj0qr
 CmUHSubuAealdiqzUvnl8E8pmFcl/n4JEfeA0LqnTgBQg2LpLHjUJlMCV5QtTFrmG3D0
 Q0mqZIPD3+VKY59iSGAnSnxHepeIBY5KTvxB61LRBsqFjBufjJi4OwLWzIePiyeXt/NQ
 +1J4NWbH8uno88zCZaxVfa+fvBPapqzTbtiU8mqWNnOQrEChq5yIRgwX95TrH48DdcjF
 hZYw==
X-Gm-Message-State: AOJu0YwoNP1rtC/AoitzhdyDF8qNldigf+5iFI4/K7dkHyFZDTIcLojv
 6k5XNx8FCco1Ctd38RL5IFg3jsqlJCS6zn3owIw=
X-Google-Smtp-Source: AGHT+IHinnxaYeci4ljIJ8bBUItdUhNszEHOMo/MTSqFzIKyZaM0O8r6Kkvofyw7fkg9xootkkS1UFoZcHoWIPPLTM4=
X-Received: by 2002:a05:6214:48f:b0:680:3608:9216 with SMTP id
 pt15-20020a056214048f00b0068036089216mr4481475qvb.99.1704674092091; Sun, 07
 Jan 2024 16:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20240102151153.133896-1-bmeng@tinylab.org>
In-Reply-To: <20240102151153.133896-1-bmeng@tinylab.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jan 2024 10:34:26 +1000
Message-ID: <CAKmqyKOw0DGPs5zuBfrKZdFQKrVe6jx=Qf7BJO2MhgbXKbm2HQ@mail.gmail.com>
Subject: Re: [PATCH] roms/opensbi: Upgrade from v1.3.1 to v1.4
To: Bin Meng <bmeng@tinylab.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=alistair23@gmail.com; helo=mail-qv1-xf2f.google.com
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

On Wed, Jan 3, 2024 at 1:13=E2=80=AFAM Bin Meng <bmeng@tinylab.org> wrote:
>
> Upgrade OpenSBI from v1.3.1 to v1.4 and the pre-built bios images.
>
> The v1.4 release includes the following commits:
>
> 1a398d9 lib: sbi: Add Zicntr as a HART ISA extension
> 669089c lib: sbi: Add Zihpm as a HART ISA extension
> 72b9c8f lib: sbi: Alphabetically sort HART ISA extensions
> 5359fc6 lib: sbi: Rename hart_pmu_get_allowed_bits() function
> 976895c lib: sbi: Fix Priv spec version for [m|s]counteren and mcountinhi=
bit CSRs
> 6053917 lib: sbi: Fix how print gets flags
> 35ef182 lib: sbi: print not fill '0' when left-aligned
> 40dac06 lib: sbi: Add '+' flags for print
> 458fa74 lib: sbi: Add ' ' '\'' flags for print
> 05cbb6e lib: sbi: implifying the parameters of printi
> fe08281 lib: sbi: print add 'o' type
> c6ee5ae lib: sbi: Fix printi
> 3b6fcdd lib: sbi: Simplify prints
> cc89fa7 lib: sbi: Fix printc
> ff43168 lib: sbi: Fix timing of clearing tbuf
> a73982d lib: sbi: Fix missing '\0' when buffer szie equal 1
> ea6533a lib: utils/gpio: Fix RV32 compile error for designware GPIO drive=
r
> c3b98c6 include: sbi: Add macro definitions for mseccfg CSR
> 1c099c4 lib: sbi: Add functions to manipulate PMP entries
> 6c202c5 include: sbi: Add Smepmp specific access flags for PMP entries
> cbcfc7b lib: sbi: Add smepmp in hart extensions
> d72f5f1 lib: utils: Add detection of Smepmp from ISA string in FDT
> 4a42a23 lib: sbi: Grant SU R/W/X permissions to whole memory
> f3fdd04 lib: sbi: Change the order of PMP initialization
> 5dd8db5 lib: sbi: Add support for Smepmp
> 6e44ef6 lib: sbi: Add functions to map/unmap shared memory
> 0ad8660 lib: sbi: Map/Unmap debug console shared memory buffers
> 057eb10 lib: utils/gpio: Fix RV32 compile error for designware GPIO drive=
r
> 0e2111e libfdt: fix SPDX license identifiers
> e05a9cf lib: sbi: Update system suspend to spec
> 5e20d25 include: sbi: fix CSR define of mseccfg
> 44c5151 include: sbi_utils: Remove driver pointer from struct i2c_adapter
> 14a35b0 lib: utils/regmap: Add generic regmap access library
> 8e97275 lib: utils/regmap: Add simple FDT based regmap framework
> f21d8f7 lib: utils/regmap: Add simple FDT based syscon regmap driver
> 4a344a9 lib: utils/reset: Add syscon based reboot and poweroff
> c2e6027 lib: utils/reset: Remove SiFive Test reset driver
> f536e0b gitignore: allow gitignore to ignore most dot file
> c744ed7 lib: sbi_pmu: Enable noncontigous hpm event and counters
> 6259b2e lib: utils/fdt: Fix fdt_parse_isa_extensions() implementation
> f46a564 lib: sbi: Fix typo for finding fixed event counter
> 94197a8 fw_base.S: Fix assembler error with clang 16+
> c104c60 lib: sbi: Add support for smcntrpmf
> 7aabeee Makefile: Fix grep warning
> e7e73aa platform: generic: allwinner: correct mhpmevent count
> ee1f83c lib: sbi_pmu: remove mhpm_count field in hart feature
> a9cffd6 firmware: payload: test: Change to SBI v2.0 DBCN ecalls
> b20bd47 lib: sbi: improve the definition of SBI_IPI_EVENT_MAX
> 664692f lib: sbi_pmu: ensure update hpm counter before starting counting
> c9a296d platform: generic: allwinner: fix OF process for T-HEAD c9xx pmu
> 901d3d7 lib: sbi_pmu: keep overflow interrupt of stopped hpm counter disa=
bled
> cacfba3 platform: Allow platforms to specify the size of tlb fifo
> 5bd9694 lib: sbi: alloc tlb fifo by sbi_malloc
> 130e65d lib: sbi: Implement SET_FS_DIRTY() to make sure the mstatus FS di=
rty is set
> d1e4dff lib: sbi: Introduce HART index in sbi_scratch
> e6125c3 lib: sbi: Remove sbi_platform_hart_index/invalid() functions
> 296e70d lib: sbi: Extend sbi_hartmask to support both hartid and hartinde=
x
> e632cd7 lib: sbi: Use sbi_scratch_last_hartindex() in remote TLB managmen=
t
> 78c667b lib: sbi: Prefer hartindex over hartid in IPI framework
> 22d6ff8 lib: sbi: Remove sbi_scratch_last_hartid() macro
> 112daa2 lib: sbi: Maximize the use of HART index in sbi_domain
> 9560fb3 include: sbi: Remove sbi_hartmask_for_each_hart() macro
> b8fb96e include: sbi_domain: Fix permission test macros
> bff27c1 lib: sbi: Factor-out Smepmp configuration as separate function
> 5240d31 lib: sbi: Don't clear mseccfg.MML bit in sbi_hart_smepmp_configur=
e()
> 2b51a9d lib: sbi: Fix pmp_flags for Smepmp read-only shared region
> 73aea28 lib: sbi: Populate M-only Smepmp entries before setting mseccfg.M=
ML
> e8bc162 lib: utils/serial: Add shared regions for serial drivers
> b7e9d34 lib: utils/regmap: Mark syscon region as shared read-write
> 3669153 platform: generic: thead: fix stale TLB entries for th1520/sg2042
> de525ac firmware: Remove ALIGN in .rela.dyn in linker script
> 2a6d725 firmware: Remove handling of R_RISCV_{32,64}
> 6ed125a Makefile: Add --exclude-libs ALL to avoid .dynsym
> e21901d doc: Fix fw_payload.md
> a125423 lib: utils/serial: Ensure proper allocation of PMP entries for ua=
rt8250
> d36709f lib: utils: timer/ipi: Update memregion flags for PLMT and PLICSW
> 8197c2f lib: sbi: fix sbi_domain_get_assigned_hartmask()
> 9da30f6 lib: utils/fdt: simplify dt_parse_isa_extensions
> 942aca2 lib: utils: Simplify SET_ISA_EXT_MAP()
> f831b93 lib: sbi_pmu: check for index overflows
> d891cae gpio/starfive: redundant readl() call
> e8114c6 docs: platform: update platform_requirements.md
> 3632f2b lib: sbi: Add support for mconfigptr
> ec0559e lib: sbi_misaligned_ldst: Fix handling of C.SWSP and C.SDSP
> cbdd869 include: sbi: Change spec version to 2.0
> 5d0ed1b lib: sbi: simplify sanitize_domain()
> c1a6987 platform: generic: thead: move to thead c9xx header to vendor spe=
cific postion
> 8e941e7 platform: generic: thead: separate implement of T-HEAD c9xx pmu
> 492d9b1 platform: generic: thead: separate implement of T-HEAD c9xx errat=
a
> 3e21b96 platform: generic: thead: initialize PMU by default in thead gene=
ric platform
> a140a4e lib: sbi: Correctly limit flushes to a single ASID/VMID
> 88ae718 platform: generic: thead: improve tlb flush errata
> 52fd64b platform: Uses hart count as the default size of tlb info
> 07f2ccd lib: utils/serial: Optimize semihosting_putc implementation
> fccdf41 firmware: fw_base.S: Fix boot hart status synchronization
> d1e0f7f utils/reset: Remove fdt_reset_thead
> 896d2c9 lib: utils/timer: Allow ACLINT MTIMER driver to setup quirks
> accafb1 lib: utils/timer: mtimer: add separate T-Head C9xx CLINT mtimer c=
ompatible
> 98bc25f lib: utils/ipi: mswi: add separate T-Head C9xx CLINT mswi compati=
ble
> 5b2f55d lib: sbi: separate the swap operation of domain region
> 3b03cdd lib: sbi: Add regions merging when sanitizing domain region
> 2bfdb9e platform: generic: Add Sophgo sg2042 platform support
> 280f7ae include: sbi: macros for mseccfg.sseed and .useed
> efcac33 lib: sbi: Add Zkr in hart extensions
> 6e5b0cf lib: sbi: enable seed access in S-mode
> 6602e11 lib: sbi: change sbi_hart_features.extensions as an array
> 3aaed4f lib: sbi: Make console_puts/console_putc interchangeable
> dc0bb19 lib: utils/serial: remove semihosting_putc
> 16bb930 lib: sbi: Fix PMP granularity handling in sbi_hart_map_saddr()
> 574b9c8 lib: sbi_pmu: avoid buffer overflow
> 791704c lib: utils/irqchip: Avoid redundant writes to APLIC CLRIE registe=
r
> f520256 lib: sbi: Allow relaxed MMIO writes in device ipi_send() callback
> b70d628 lib: sbi: Allow relaxed MMIO writes in device ipi_clear() callbac=
k
> bd74931 lib: ipi: Adjust Andes PLICSW to single-bit-per-hart scheme
> 291403f sbi: sbi_pmu: Improve sbi_pmu_init() error handling
> 090fa99 lib: sbi: Add XAndesPMU in hart extensions
> a48f2cf sbi: sbi_pmu: Add hw_counter_filter_mode() to pmu device
> 51ec60c platform: include: andes45: Add PMU related CSR defines
> effd89a platform: generic: Introduce pmu_init() platform override
> 1b9e743 platform: andes: Add Andes custom PMU support
> 2e50c24 platform: andes: Enable Andes PMU for AE350
> 535c661 platform: rzfive: Enable Andes PMU for RZ/Five
> 0b3262e lib: utils: fdt_fixup: Allow preserving PMU properties
> 009ae4e platform: andes: Factor out is_andes() helper
> 0308f93 lib: utils: fdt_pmu: Make the fdt_pmu_evt_select table global var=
iable
> e19d419 lib: utils: fdt_pmu: Do not iterate over the fdt_pmu_evt_select t=
able
> d162009 docs: pmu: Add Andes PMU node example
> 6b9a849 lib: sbi: Remove xchg/cmpxchg implemented via lr/sc
> 11bf49b lib: sbi: Fix __atomic_op_bit_ord and comments
> 8839869 lib: sbi: Replace __atomic_op_bit_ord with __atomic intrinsics
> 07419ec lib: sbi: Prevent redundant sbi_ipi_process
> 93da66b lib: sbi_hart: Store PMP granularity as log base 2
> ee72517 lib: sbi_pmu: Add PMU snapshot definitions
> 11a0ba5 lib: sbi_pmu: Fix the counter info function
> 0696810 firmware: fix section types
> a25fc74 lib: sbi_hsm: Put the resume_pending hart in the interruptible ha=
rt mask
> 87aa306 platform: recalculate heap size to support new tlb entry number
> a2e254e lib: sbi: skip wait_for_coldboot when coolboot done
> 6112d58 lib: utils/fdt: Allow to use reg-names when parsing ACLINT
> 35cba92 lib: sbi_tlb: Check tlb_range_flush_limit only once per request
> a894187 lib: sbi_ipi: Do not ignore errors from sbi_ipi_send()
> 446fa65 lib: sbi_ipi: Process self-IPIs in sbi_ipi_send()
> 2707250 lib: sbi_ipi: Drop unnecessary ipi_process check
> 925ce14 lib: sbi: Simplify the initialization of root_hmask in sbi_domain=
_init
> 2c8be56 lib: sbi: Improve the code of privilege mode and extensions detec=
tion
> 056fe6f lib: sbi: Refactor the code for enable extensions in menvfg CSR
> 776770d lib: sbi: Using one array to define the name of extensions
> 3daac8f lib: sbi: Detect extensions from the ISA string in DT
> 416ceb3 lib: sbi_tlb: Reduce size of struct sbi_tlb_info
> 80169b2 platform: generic: Fine tune fw_platform_calculate_heap_size()
> cdebae2 lib: utils/irqchip: Add shared MMIO region for PLIC in root domai=
n
> 3284bea lib: sbi: Allow ecall handlers to directly update register state
> 5a57e8c lib: sbi: Remove the SBI_ETRAP error code
> 2b80b92 lib: sbi: Do not enter OpenSBI with mseccfg.MML =3D=3D 1
> 63e09ad lib: sbi: Fix shift bug in sbi_system_reset
> ba29293 lib: utils/timer: mtimer: only use regname for aclint
> bbd065d lib: sbi: Detect Zicntr extension only based on traps
> a2b255b include: Bump-up version to 1.4
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
> Please pull the complete patch from https://github.com/lbmeng/qemu
> opensbi branch.
>
>  .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 135376 -> 267416 byt=
es
>  .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 138368 -> 270808 byt=
es
>  roms/opensbi                                  |   2 +-
>  3 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/ope=
nsbi-riscv32-generic-fw_dynamic.bin
> index 9a2ba3f2a4..60ca1165c8 100644
> Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bi=
os/opensbi-riscv32-generic-fw_dynamic.bin differ
> diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/ope=
nsbi-riscv64-generic-fw_dynamic.bin
> index 5d4e812819..bae158d457 100644
> Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bi=
os/opensbi-riscv64-generic-fw_dynamic.bin differ
> diff --git a/roms/opensbi b/roms/opensbi
> index 057eb10b6d..a2b255b889 160000
> --- a/roms/opensbi
> +++ b/roms/opensbi
> @@ -1 +1 @@
> -Subproject commit 057eb10b6d523540012e6947d5c9f63e95244e94
> +Subproject commit a2b255b88918715173942f2c5e1f97ac9e90c877
> --
> 2.34.1
>
>

