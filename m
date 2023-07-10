Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A5974D5CD
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq4t-0001db-N6; Mon, 10 Jul 2023 08:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4p-0001Qh-Pm
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:15 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4n-00040A-9p
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:15 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-66869feb7d1so2148346b3a.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992392; x=1691584392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dzraPG0Scc/In0AzV+Xrn8hx/UUTOgzx3rjw2g80Zc=;
 b=buGpR/tHVpgpM4W6QI9svv4UGgIsjiMp3sscjp+rrKGtud9Bb7x8Yy/RyMX7FStJJJ
 jzQMquwsaGNaDFm8Yb61fBjhfENwkeF1YYVJx/bDvBnwgZmLAj+NWPNVJu6xl8fFMTah
 EpsMGMefxgXcTX6DuO1H3KX5QXOxE999lHAPpDw+bHmzTl5fN5e3HqydwrtYSOIiv5YY
 Qn3E2qVOdaSV5fxBMZn6msFmavEIyBRxINvnnjSKj1EmRhk8W6aYg7tTLcadRHB4FRAg
 ogmmaeaBdud/o1zn6gaSKp4CmfKipbPi/wYD1Oj0In2tSDJaiYTVkiy7TPBhOaSvhSDb
 O19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992392; x=1691584392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5dzraPG0Scc/In0AzV+Xrn8hx/UUTOgzx3rjw2g80Zc=;
 b=ArGbkxaUM2By/xt/cKgC2ERbIlsVW4wJ6DaD4oFCz3ExaFGznssmcjN1lL2pjcu9mI
 qOLIYWDQf9Hw2Ve4UTo76NulxL2l35LR4PnxgveMug+6Cc9F0zTltCoSpoXtFr9trW/o
 hiEzJuSfrboyvLgJKjvREBAwuFCSObtoZT+6VuR1bsgGawdYsbum/b7tjHtVcRuIFMvm
 tgqLMwQJN/NZsLdjIMn63GY+P/xZJjJ1iBKpyzPHc2r9eZlocAOCrszDrkCfhSt5b0Sn
 7UvHo2D5uapW19b7G4O6pZOA+9n+b8Pe1oesDCcDvjqhqdXxSVWkWrpZf39C+/SIX5B7
 d1fA==
X-Gm-Message-State: ABy/qLYJ3NS8kEd9q8EhGBQIE4w1p44VxH8nnJR1KAlhVdS2Wl5vEKlw
 m5faQsA2EEOnZixjAe/M5rwm2q367xKk7w==
X-Google-Smtp-Source: APBJJlEa501sTkTJUCfAszEBrLJ0AGr+lIkbmQ2NWQcZ1aOs4gSPrNKDslnJ3HNpuqCWsaNMUT4KCQ==
X-Received: by 2002:a05:6a00:3a25:b0:66a:2771:6c4d with SMTP id
 fj37-20020a056a003a2500b0066a27716c4dmr12013507pfb.4.1688992391583; 
 Mon, 10 Jul 2023 05:33:11 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:11 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Bin Meng <bmeng@tinylab.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/54] roms/opensbi: Upgrade from v1.2 to v1.3
Date: Mon, 10 Jul 2023 22:31:26 +1000
Message-Id: <20230710123205.2441106-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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

From: Bin Meng <bmeng@tinylab.org>

Upgrade OpenSBI from v1.2 to v1.3 and the pre-built bios images.

The v1.3 release includes the following commits:

440fa81 treewide: Replace TRUE/FALSE with true/false
6509127 Makefile: Remove -N ldflag to prevent linker RWX warning
65638f8 lib: utils/sys: Allow custom HTIF base address for RV32
f14595a lib: sbi: Allow platform to influence cold boot HART selection
6957ae0 platform: generic: Allow platform_override to select cold boot HART
cb7e7c3 platform: generic: Allow platform_override to perform firmware init
8020df8 generic/starfive: Add Starfive JH7110 platform implementation
6997552 lib: sbi_hsm: Rename 'priv' argument to 'arg1'
9e397e3 docs: domain_support: Use capital letter for privilege modes
9e0ba09 include: sbi: Fine grain the permissions for M and SU modes
aace1e1 lib: sbi: Use finer permission semantics for address validation
22dbdb3 lib: sbi: Add permissions for the firmware start till end
1ac14f1 lib: sbi: Use finer permission sematics to decide on PMP bits
44f736c lib: sbi: Modify the boot time region flag prints
20646e0 lib: utils: Use SU-{R/W/X} flags for region permissions during parsing
3e2f573 lib: utils: Disallow non-root domains from adding M-mode regions
59a08cd lib: utils: Add M-mode {R/W} flags to the MMIO regions
001106d docs: Update domain's region permissions and requirements
da5594b platform: generic: allwinner: Fix PLIC array bounds
ce2a834 docs: generic.md: fix typo of andes-ae350
8ecbe6d lib: sbi_hsm: handle failure when hart_stop returns SBI_ENOTSUPP
b1818ee include: types: add always inline compiler attribute
9c4eb35 lib: utils: atcsmu: Add Andes System Management Unit support
787296a platform: andes/ae350: Implement hart hotplug using HSM extension
7aaeeab lib: reset/fdt_reset_atcwdt200: Use defined macros and function in atcsmu.h
a990309 lib: utils: Fix reserved memory node for firmware memory
fefa548 firmware: Split RO/RX and RW sections
2f40a99 firmware: Move dynsym and reladyn sections to RX section
c10e3fe firmware: Add RW section offset in scratch
b666760 lib: sbi: Print the RW section offset
230278d lib: sbi: Add separate entries for firmware RX and RW regions
dea0922 platform: renesas/rzfive: Configure Local memory regions as part of root domain
33bf917 lib: utils: Add fdt_add_cpu_idle_states() helper function
c45992c platform: generic: allwinner: Advertise nonretentive suspend
c8ea836 firmware: Fix fw_rw_offset computation in fw_base.S
8050081 firmware: Not to clear all the MIP
84d15f4 lib: sbi_hsm: Use csr_set to restore the MIP
199189b lib: utils: Mark only the largest region as reserved in FDT
66b0e23 lib: sbi: Ensure domidx_to_domain_table is null-terminated
642f3de Makefile: Add missing .dep files for fw_*.elf.ld
09b34d8 include: Add support for byteorder/endianness conversion
680bea0 lib: utils/fdt: Use byteorder conversion functions in libfdt_env.h
b224ddb include: types: Add typedefs for endianness
aa5dafc include: sbi: Fix BSWAPx() macros for big-endian host
e3bf1af include: Add defines for SBI debug console extension
0ee3a86 lib: sbi: Add sbi_nputs() function
4e0572f lib: sbi: Add sbi_ngets() function
eab48c3 lib: sbi: Add sbi_domain_check_addr_range() function
5a41a38 lib: sbi: Implement SBI debug console extension
c43903c lib: sbi: Add console_puts() callback in the console device
29285ae lib: utils/serial: Implement console_puts() for semihosting
65c2190 lib: sbi: Speed-up sbi_printf() and friends using nputs()
321293c lib: utils/fdt: Fix fdt_pmu.c header dependency
aafcc90 platform: generic/allwinner: Fix sun20i-d1.c header dependency
745aaec platform: generic/andes: Fix ae350.c header dependency
99d09b6 include: fdt/fdt_helper: Change fdt_get_address() to return root.next_arg1
6861ee9 lib: utils: fdt_fixup: Fix compile error
4f2be40 docs: fix typo in fw.md
30ea806 lib: sbi_hart: Enable hcontext and scontext
81adc62 lib: sbi: Align SBI vendor extension id with mvendorid CSR
31b82e0 include: sbi: Remove extid parameter from vendor_ext_provider() callback
c100951 platform: generic: renesas: rzfive: Add support to configure the PMA
2491242 platform: generic: renesas: rzfive: Configure the PMA region
67b2a40 lib: sbi: sbi_ecall: Check the range of SBI error
5a75f53 lib: sbi/sbi_domain: cosmetic style fixes
bc06ff6 lib: utils/fdt/fdt_domain: Simplify region access permission check
17b3776 docs: domain_support: Update the DT example
1364d5a lib: sbi_hsm: Factor out invalid state detection
40f16a8 lib: sbi_hsm: Don't try to restore state on failed change
c88e039 lib: sbi_hsm: Ensure errors are consistent with spec
b1ae6ef lib: sbi_hsm: Move misplaced comment
07673fc lib: sbi_hsm: Remove unnecessary include
8a40306 lib: sbi_hsm: Export some functions
73623a0 lib: sbi: Add system suspend skeleton
c9917b6 lib: sbi: Add system_suspend_allowed domain property
7c964e2 lib: sbi: Implement system suspend
37558dc docs: Correct opensbi-domain property name
5ccebf0 platform: generic: Add system suspend test
908be1b gpio/starfive: add gpio driver and support gpio reset
4b28afc make: Add a command line option for debugging OpenSBI
e9d08bd lib: utils/i2c: Add minimal StarFive jh7110 I2C driver
568ea49 platform: starfive: add PMIC power ops in JH7110 visionfive2 board
506144f lib: serial: Cadence: Enable compatibility for cdns,uart-r1p8
1fe8dc9 lib: sbi_pmu: add callback for counter width
51951d9 lib: sbi_pmu: Implement sbi_pmu_counter_fw_read_hi
60c358e lib: sbi_pmu: Reserve space for implementation specific firmware events
548e4b4 lib: sbi_pmu: Rename fw_counter_value
b51ddff lib: sbi_pmu: Update sbi_pmu dev ops
641d2e9 lib: sbi_pmu: Use dedicated event code for platform firmware events
57d3aa3 lib: sbi_pmu: Introduce fw_counter_write_value API
c631a7d lib: sbi_pmu: Add hartid parameter PMU device ops
d56049e lib: sbi: Refactor the calls to sbi_hart_switch_mode()
e8e9ed3 lib: sbi: Set the state of a hart to START_PENDING after the hart is ready
c6a092c lib: sbi: Clear IPIs before init_warm_startup in non-boot harts
ed88a63 lib: sbi_scratch: Optimize the alignment code for alloc size
73ab11d lib: sbi: Fix how to check whether the domain contains fw_region
f64dfcd lib: sbi: Introduce sbi_entry_count() function
30b9e7e lib: sbi_hsm: Fix sbi_hsm_hart_start() for platform with hart hotplug
8e90259 lib: sbi_hart: clear mip csr during hart init
45ba2b2 include: Add defines for SBI CPPC extension
33caae8 lib: sbi: Implement SBI CPPC extension
91767d0 lib: sbi: Print the CPPC device name
edc9914 lib: sbi_pmu: Align the event type offset as per SBI specification
ee016a7 docs: Correct FW_JUMP_FDT_ADDR calculation example
2868f26 lib: utils: fdt_fixup: avoid buffer overrun
66fa925 lib: sbi: Optimize sbi_tlb
24dde46 lib: sbi: Optimize sbi_ipi
80078ab sbi: tlb: Simplify to tlb_process_count/tlb_process function
bf40e07 lib: sbi: Optimize sbi_tlb queue waiting
eeab500 platform: generic: andes/renesas: Add SBI EXT to check for enabling IOCP errata
f692289 firmware: Optimize loading relocation type
e41dbb5 firmware: Change to use positive offset to access relocation entries
bdb3c42 lib: sbi: Do not clear active_events for cycle/instret when stopping
674e019 lib: sbi: Fix counter index calculation for SBI_PMU_CFG_FLAG_SKIP_MATCH
f5dfd99 lib: sbi: Don't check SBI error range for legacy console getchar
7919530 lib: sbi: Add debug print when sbi_pmu_init fails
4e33530 lib: sbi: Remove unnecessary semicolon
6bc02de lib: sbi: Simplify sbi_ipi_process remove goto
dc1c7db lib: sbi: Simplify BITS_PER_LONG definition
f58c140 lib: sbi: Introduce register_extensions extension callback
e307ba7 lib: sbi: Narrow vendor extension range
042f0c3 lib: sbi: pmu: Remove unnecessary probe function
8b952d4 lib: sbi: Only register available extensions
767b5fc lib: sbi: Optimize probe of srst/susp
c3e31cb lib: sbi: Remove 0/1 probe implementations
33f1722 lib: sbi: Document sbi_ecall_extension members
d4c46e0 Makefile: Dereference symlinks on install
8b99a7f lib: sbi: Fix return of sbi_console_init
264d0be lib: utils: Improve fdt_serial_init
9a0bdd0 lib: utils: Improve fdt_ipi
122f226 lib: utils: Improve fdt_timer
df75e09 lib: utils/ipi: buffer overrun aclint_mswi_cold_init
bdde2ec lib: sbi: Align system suspend errors with spec
aad7a37 include: sbi_scratch: Add helper macros to access data type
5cf9a54 platform: Allow platforms to specify heap size
40d36a6 lib: sbi: Introduce simple heap allocator
2a04f70 lib: sbi: Print scratch size and usage at boot time
bbff53f lib: sbi_pmu: Use heap for per-HART PMU state
ef4542d lib: sbi: Use heap for root domain creation
66daafe lib: sbi: Use scratch space to save per-HART domain pointer
fa5ad2e lib: utils/gpio: Use heap in SiFive and StartFive GPIO drivers
903e88c lib: utils/i2c: Use heap in DesignWare and SiFive I2C drivers
5a8cfcd lib: utils/ipi: Use heap in ACLINT MSWI driver
3013716 lib: utils/irqchip: Use heap in PLIC, APLIC and IMSIC drivers
7e5636a lib: utils/timer: Use heap in ACLINT MTIMER driver
3c1c972 lib: utils/fdt: Use heap in FDT domain parsing
acbd8fc lib: utils/ipi: Use scratch space to save per-HART MSWI pointer
f0516be lib: utils/timer: Use scratch space to save per-HART MTIMER pointer
b3594ac lib: utils/irqchip: Use scratch space to save per-HART PLIC pointer
1df52fa lib: utils/irqchip: Don't check hartid in imsic_update_hartid_table()
355796c lib: utils/irqchip: Use scratch space to save per-HART IMSIC pointer
524feec docs: Add OpenSBI logo and use it in the top-level README.md
932be2c README.md: Improve project copyright information
8153b26 platform/lib: Set no-map attribute on all PMP regions
d64942f firmware: Fix find hart index
27c957a lib: reset: Move fdt_reset_init into generic_early_init
8bd666a lib: sbi: check A2 register in ecall_dbcn_handler.
2552799 include: Bump-up version to 1.3

Signed-off-by: Bin Meng <bmeng@tinylab.org>
Message-Id: <20230630160717.843044-1-bmeng@tinylab.org>
Tested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 123072 -> 135344 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 121800 -> 138304 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
index 6a8425885c..7b6c67e0ae 100644
Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
index 80bdbf2170..1b831b412c 100644
Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
diff --git a/roms/opensbi b/roms/opensbi
index 6b5188ca14..2552799a1d 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 6b5188ca14e59ce7bf71afe4e7d3d557c3d31bf8
+Subproject commit 2552799a1df30a3dcd2321a8b75d61d06f5fb9fc
-- 
2.40.1


