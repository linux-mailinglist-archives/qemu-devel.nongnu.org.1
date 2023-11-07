Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2E37E32EC
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:31:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bqs-0002Vj-HC; Mon, 06 Nov 2023 21:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bqq-0002VB-KA
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:00 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bqo-0002B6-JL
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:00 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc53d0030fso41385955ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324196; x=1699928996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IVzHn331g5u7RFHKqArgjXiMTEIMI1VKOcxTAZonIJQ=;
 b=O2YMZePLXemnLjDJ6FDd9aWxnSMrEPFP/kRUVqrJVAcyz2XuzwSUgunnXm6kVG83/2
 Qcdpj0eJ2PLGLnckkZGZpdXIypuFeeG8MhbClvZx7aczA0bnwo1dRePOSHnz1G2uJ7Jc
 UK8JHHH3HABGRFSYuicd19j4DNZueezY6zZ+f6skcpxDn5yWOo3ssJLXRGn156LoofUw
 Z/+yNNIpOoSCLvr0uDHrTL4STWY6zAYiCPGruVt6vR0TrBapaMhdBYQooEZZjeMCJAzy
 0UucCFNt5AGqthao2We20QXvLUUA9eprGgtYASM6Yefcug/Cw1wFLbusmbgl2igsg+LG
 /ThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324196; x=1699928996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IVzHn331g5u7RFHKqArgjXiMTEIMI1VKOcxTAZonIJQ=;
 b=VDxht6iP4Rc5WMo34sh6AwYnAI8vFdadNZKt3EFYX1W8lioKnrWorIKHZ2CPPDCqIJ
 e2YLWnHJ9InDrzkquc8RHF0QCRxZQNtrkjQYgBZt8uLIfMop7ijX2Vvge84ecQtnSATI
 Upep+jCVbjFaseQ+4SC17dH9fSflhOHsKMhZtgv21QFPFo5h6wF+dHeiHPO1LuiAWY81
 z5vtqODpziwriajBNTXPXXYKtAOw3DCozarXDO04S6rYHPDztSD6cCqvibyP4dhvgGk0
 xel2O3+St/V3hzfBX+nbxPSLoScfd0tDP46Lm+rHqejSgLe7J7PmJRul0wTW3v0SyWQd
 h5RA==
X-Gm-Message-State: AOJu0YyAj3SLxK1BT7IKPtyFfPgxvi8xlLTdhOPP7ykl9mLNvVc0AGj/
 vfdTe2KFGUodKcZk9bTDAmQUsJ2cm6hiNQ==
X-Google-Smtp-Source: AGHT+IFRuafQ/ukY1p8rlp+awChGZZeRdlNYZsLvsLb/P+vl1V/1GccHhw6BW5j//j8AG2rIcaxnfg==
X-Received: by 2002:a17:902:fb43:b0:1cb:fcfb:61af with SMTP id
 lf3-20020a170902fb4300b001cbfcfb61afmr1439550plb.30.1699324195743; 
 Mon, 06 Nov 2023 18:29:55 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:29:54 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/49] riscv-to-apply queue
Date: Tue,  7 Nov 2023 12:28:56 +1000
Message-ID: <20231107022946.1055027-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

The following changes since commit 3e01f1147a16ca566694b97eafc941d62fa1e8d8:

  Merge tag 'pull-sp-20231105' of https://gitlab.com/rth7680/qemu into staging (2023-11-06 09:34:22 +0800)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20231107

for you to fetch changes up to bc5e8445342fee35b35f2ed9a9f2249e060b8776:

  docs/about/deprecated: Document RISC-V "pmu-num" deprecation (2023-11-07 11:06:02 +1000)

----------------------------------------------------------------
Third RISC-V PR for 8.2

 * Rename ext_icboz to ext_zicboz
 * Rename ext_icbom to ext_zicbom
 * Rename ext_icsr to ext_zicsr
 * Rename ext_ifencei to ext_zifencei
 * Add RISC-V Virtual IRQs and IRQ filtering support
 * Change default linux-user cpu to 'max'
 * Update 'virt' machine core limit
 * Add query-cpu-model-expansion API
 * Rename epmp to smepmp and expose the extension
 * Clear pmp/smepmp bits on reset
 * Ignore pmp writes when RW=01
 * Support zicntr/zihpm flags and disable support
 * Correct CSR_MSECCFG operations
 * Update mail address for Weiwei Li
 * Update RISC-V vector crypto to ratified v1.0.0
 * Clear the Ibex/OpenTitan SPI interrupts even if disabled
 * Set the OpenTitan priv to 1.12.0
 * Support discontinuous PMU counters

----------------------------------------------------------------
Alistair Francis (2):
      hw/ssi: ibex_spi_host: Clear the interrupt even if disabled
      target/riscv: cpu: Set the OpenTitan priv to 1.12.0

Daniel Henrique Barboza (17):
      target/riscv: rename ext_ifencei to ext_zifencei
      target/riscv: rename ext_icsr to ext_zicsr
      target/riscv: rename ext_icbom to ext_zicbom
      target/riscv: rename ext_icboz to ext_zicboz
      linux-user/riscv: change default cpu to 'max'
      docs/system/riscv: update 'virt' machine core limit
      target/riscv/kvm/kvm-cpu.c: add missing property getters()
      qapi,risc-v: add query-cpu-model-expansion
      target/riscv/tcg: add tcg_cpu_finalize_features()
      target/riscv: handle custom props in qmp_query_cpu_model_expansion
      target/riscv: add riscv_cpu_accelerator_compatible()
      target/riscv/riscv-qmp-cmds.c: check CPU accel in query-cpu-model-expansion
      target/riscv: add zicntr extension flag for TCG
      target/riscv/kvm: add zicntr reg
      target/riscv: add zihpm extension flag for TCG
      target/riscv/kvm: add zihpm reg
      target/riscv/kvm: add zicsr, zifencei, zba, zbs, svnapot

Heinrich Schuchardt (1):
      target/riscv: correct csr_ops[CSR_MSECCFG]

Himanshu Chauhan (1):
      Add epmp to extensions list and rename it to smepmp

Max Chou (14):
      target/riscv: Add cfg property for Zvkt extension
      target/riscv: Expose Zvkt extension property
      target/riscv: Add cfg property for Zvkb extension
      target/riscv: Replace Zvbb checking by Zvkb
      target/riscv: Expose Zvkb extension property
      target/riscv: Add cfg properties for Zvkn[c|g] extensions
      target/riscv: Expose Zvkn[c|g] extnesion properties
      target/riscv: Add cfg properties for Zvks[c|g] extensions
      target/riscv: Expose Zvks[c|g] extnesion properties
      target/riscv: Move vector crypto extensions to riscv_cpu_extensions
      disas/riscv: Add rv_fmt_vd_vs2_uimm format
      disas/riscv: Add rv_codec_vror_vi for vror.vi
      disas/riscv: Add support for vector crypto extensions
      disas/riscv: Replace TABs with space

Mayuresh Chitale (2):
      target/riscv: pmp: Clear pmp/smepmp bits on reset
      target/riscv: pmp: Ignore writes when RW=01

Rajnesh Kanwal (6):
      target/riscv: Without H-mode mask all HS mode inturrupts in mie.
      target/riscv: Check for async flag in case of RISCV_EXCP_SEMIHOST.
      target/riscv: Set VS* bits to one in mideleg when H-Ext is enabled
      target/riscv: Split interrupt logic from riscv_cpu_update_mip.
      target/riscv: Add M-mode virtual interrupt and IRQ filtering support.
      target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.

Rob Bradford (5):
      target/riscv: Propagate error from PMU setup
      target/riscv: Don't assume PMU counters are continuous
      target/riscv: Use existing PMU counter mask in FDT generation
      target/riscv: Add "pmu-mask" property to replace "pmu-num"
      docs/about/deprecated: Document RISC-V "pmu-num" deprecation

Weiwei Li (1):
      MAINTAINERS: update mail address for Weiwei Li

 MAINTAINERS                                 |   2 +-
 docs/about/deprecated.rst                   |  12 +
 docs/system/riscv/virt.rst                  |   2 +-
 qapi/machine-target.json                    |   6 +-
 disas/riscv.h                               |   2 +
 linux-user/riscv/target_elf.h               |   3 +-
 target/riscv/cpu.h                          |  25 ++
 target/riscv/cpu_bits.h                     |   6 +
 target/riscv/cpu_cfg.h                      |  22 +-
 target/riscv/pmp.h                          |   2 +
 target/riscv/pmu.h                          |   5 +-
 target/riscv/tcg/tcg-cpu.h                  |   2 +
 disas/riscv.c                               | 157 ++++++++-
 hw/riscv/boot.c                             |   2 +-
 hw/riscv/virt.c                             |   6 +-
 hw/ssi/ibex_spi_host.c                      |   6 +-
 target/riscv/cpu.c                          | 199 ++++++++---
 target/riscv/cpu_helper.c                   |  99 ++++--
 target/riscv/csr.c                          | 497 +++++++++++++++++++++++++---
 target/riscv/gdbstub.c                      |   2 +-
 target/riscv/kvm/kvm-cpu.c                  |  59 +++-
 target/riscv/machine.c                      |  16 +-
 target/riscv/pmp.c                          |  27 +-
 target/riscv/pmu.c                          |  34 +-
 target/riscv/riscv-qmp-cmds.c               | 160 +++++++++
 target/riscv/tcg/tcg-cpu.c                  | 176 +++++++---
 target/riscv/insn_trans/trans_rvi.c.inc     |   2 +-
 target/riscv/insn_trans/trans_rvvk.c.inc    |  37 ++-
 target/riscv/insn_trans/trans_rvzicbo.c.inc |  16 +-
 29 files changed, 1326 insertions(+), 258 deletions(-)

