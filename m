Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D2798646
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:07:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZKi-0004bI-QR; Fri, 08 Sep 2023 07:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeZKY-0004Zo-OG
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:07:19 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeZKN-0003rh-An
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:07:18 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5736caaf151so1103816eaf.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694171222; x=1694776022; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wtIfGIotQNLLu9LTrgP5jXj/UcV5/SXWFfJCDwcSth4=;
 b=qsf7kLTdWzH3gMBF3boL16xYaFOe1B8M/5lrG3t3KZXoKPzIfFlePw6kEWU+3X+KG0
 ViH3Ey0sgfVSNveNQjXMKtW1tQQJRYyGyg4FjzozM4acJpctj0rrttHgwF43qTmqcLT/
 zHYj7VQ3x9nLo68cTwMkF+6UdBcoSQ8soKpDCSZ+djT0lQk8zVq90EpdhjwFYkK4sUhM
 +V6jNORMNSkxf1hdSu0ELzF2jUlenNKgIKKkFjCqJtkCg+s0sAh19BoQL1RGL/Deu4tB
 FYKaRxvOcUV4SSbUsF1Uw3cPWR+4aXZK64IdTWysUooZw85Upfaq6HqOl77pfXUza6RF
 OY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694171222; x=1694776022;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wtIfGIotQNLLu9LTrgP5jXj/UcV5/SXWFfJCDwcSth4=;
 b=AvnW7yNirWNWZIYhjbrtDVa/qLi5toaZp4g7i38bL76sRN1a73R7Zi/MutJTmeifBA
 Gp6XVLXFvs7/jauGPL7GXDOgYPlWWPPHm6gfpn2wgIDA1ItuM683L6tnwj1TLRO+rAET
 1wdMvI2tPClutkYqCAV/rNuijWucePnonAYD676OJcUQe2SJ80syQ4whKBPMltGbTTUW
 HZBuONns6NGLiZxhTBbzDW/3yzxp9BAA2F1cpPAZ9Xsb5FeQZf4YKiTzZ5fkGV1sIF0Y
 dhnG6xg+Ve0xIj6nr2O/daxbGC5m6WkNNWGZmzXHMeGl1YLhplhHudxo8vWWtp7fGjq4
 m8wQ==
X-Gm-Message-State: AOJu0YwfN6Po1aJkU/4xX82esHzR6wp/wRfwtZJzwlqgPq6QzSr8recH
 zg3HEWVk7koWP1aqHveGrxO9wCzldGcLfkbPhs07yIu5h0A=
X-Google-Smtp-Source: AGHT+IEA1M2v+2qPoKkzVMzBGDuB5oQeixEY28niOG6jTj53DhBfD7X78qBZjQI25uyIFkLDOFdxRUFDX6MsO9XfqJk=
X-Received: by 2002:a4a:3056:0:b0:571:260e:ab69 with SMTP id
 z22-20020a4a3056000000b00571260eab69mr2042886ooz.2.1694171222525; Fri, 08 Sep
 2023 04:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 8 Sep 2023 07:06:50 -0400
Message-ID: <CAJSP0QV=_OxEnW2-h0KWehz=fG+jVfv5v+PSmEMprwyfOxNYXQ@mail.gmail.com>
Subject: Re: [PULL 00/65] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Alistair,
Please take a look at the following CI failure:

https://gitlab.com/qemu-project/qemu/-/jobs/5045998521

/usr/bin/ld: libqemu-riscv64-softmmu.fa.p/target_riscv_cpu.c.o: in
function `riscv_cpu_add_kvm_properties':
/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/build/../target/riscv/cpu.c:2146:
undefined reference to `kvm_riscv_init_user_properties'

Stefan

On Fri, 8 Sept 2023 at 03:10, Alistair Francis <alistair23@gmail.com> wrote:
>
> The following changes since commit 03a3a62fbd0aa5227e978eef3c67d3978aec9e5f:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-09-07 10:29:06 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20230908
>
> for you to fetch changes up to 69749970db9f1b05c8cd77a7bbb45e4e156f7d33:
>
>   target/riscv/cpu.c: consider user option with RVG (2023-09-08 15:57:39 +1000)
>
> ----------------------------------------------------------------
> First RISC-V PR for 8.2
>
>  * Remove 'host' CPU from TCG
>  * riscv_htif Fixup printing on big endian hosts
>  * Add zmmul isa string
>  * Add smepmp isa string
>  * Fix page_check_range use in fault-only-first
>  * Use existing lookup tables for MixColumns
>  * Add RISC-V vector cryptographic instruction set support
>  * Implement WARL behaviour for mcountinhibit/mcounteren
>  * Add Zihintntl extension ISA string to DTS
>  * Fix zfa fleq.d and fltq.d
>  * Fix upper/lower mtime write calculation
>  * Make rtc variable names consistent
>  * Use abi type for linux-user target_ucontext
>  * Add RISC-V KVM AIA Support
>  * Fix riscv,pmu DT node path in the virt machine
>  * Update CSR bits name for svadu extension
>  * Mark zicond non-experimental
>  * Fix satp_mode_finalize() when satp_mode.supported = 0
>  * Fix non-KVM --enable-debug build
>  * Add new extensions to hwprobe
>  * Use accelerated helper for AES64KS1I
>  * Allocate itrigger timers only once
>  * Respect mseccfg.RLB for pmpaddrX changes
>  * Align the AIA model to v1.0 ratified spec
>  * Don't read the CSR in riscv_csrrw_do64
>  * Add the 'max' CPU, detect user choice in TCG
>
> ----------------------------------------------------------------
> Akihiko Odaki (1):
>       target/riscv: Allocate itrigger timers only once
>
> Ard Biesheuvel (2):
>       target/riscv: Use existing lookup tables for MixColumns
>       target/riscv: Use accelerated helper for AES64KS1I
>
> Conor Dooley (1):
>       hw/riscv: virt: Fix riscv,pmu DT node path
>
> Daniel Henrique Barboza (26):
>       target/riscv/cpu.c: do not run 'host' CPU with TCG
>       target/riscv/cpu.c: add zmmul isa string
>       target/riscv/cpu.c: add smepmp isa string
>       target/riscv: fix satp_mode_finalize() when satp_mode.supported = 0
>       hw/riscv/virt.c: fix non-KVM --enable-debug build
>       hw/intc/riscv_aplic.c fix non-KVM --enable-debug build
>       target/riscv/cpu.c: split CPU options from riscv_cpu_extensions[]
>       target/riscv/cpu.c: skip 'bool' check when filtering KVM props
>       target/riscv/cpu.c: split kvm prop handling to its own helper
>       target/riscv: add DEFINE_PROP_END_OF_LIST() to riscv_cpu_options[]
>       target/riscv/cpu.c: split non-ratified exts from riscv_cpu_extensions[]
>       target/riscv/cpu.c: split vendor exts from riscv_cpu_extensions[]
>       target/riscv/cpu.c: add riscv_cpu_add_qdev_prop_array()
>       target/riscv/cpu.c: add riscv_cpu_add_kvm_unavail_prop_array()
>       target/riscv/cpu.c: limit cfg->vext_spec log message
>       target/riscv: add 'max' CPU type
>       avocado, risc-v: add tuxboot tests for 'max' CPU
>       target/riscv: deprecate the 'any' CPU type
>       target/riscv/cpu.c: use offset in isa_ext_is_enabled/update_enabled
>       target/riscv: make CPUCFG() macro public
>       target/riscv/cpu.c: introduce cpu_cfg_ext_auto_update()
>       target/riscv/cpu.c: use cpu_cfg_ext_auto_update() during realize()
>       target/riscv/cpu.c: introduce RISCVCPUMultiExtConfig
>       target/riscv: use isa_ext_update_enabled() in init_max_cpu_extensions()
>       target/riscv/cpu.c: honor user choice in cpu_cfg_ext_auto_update()
>       target/riscv/cpu.c: consider user option with RVG
>
> Dickon Hood (2):
>       target/riscv: Refactor translation of vector-widening instruction
>       target/riscv: Add Zvbb ISA extension support
>
> Jason Chien (3):
>       target/riscv: Add Zihintntl extension ISA string to DTS
>       hw/intc: Fix upper/lower mtime write calculation
>       hw/intc: Make rtc variable names consistent
>
> Kiran Ostrolenk (4):
>       target/riscv: Refactor some of the generic vector functionality
>       target/riscv: Refactor vector-vector translation macro
>       target/riscv: Refactor some of the generic vector functionality
>       target/riscv: Add Zvknh ISA extension support
>
> LIU Zhiwei (3):
>       target/riscv: Fix page_check_range use in fault-only-first
>       target/riscv: Fix zfa fleq.d and fltq.d
>       linux-user/riscv: Use abi type for target_ucontext
>
> Lawrence Hunter (2):
>       target/riscv: Add Zvbc ISA extension support
>       target/riscv: Add Zvksh ISA extension support
>
> Leon Schuermann (1):
>       target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes
>
> Max Chou (3):
>       crypto: Create sm4_subword
>       crypto: Add SM4 constant parameter CK
>       target/riscv: Add Zvksed ISA extension support
>
> Nazar Kazakov (4):
>       target/riscv: Remove redundant "cpu_vl == 0" checks
>       target/riscv: Move vector translation checks
>       target/riscv: Add Zvkned ISA extension support
>       target/riscv: Add Zvkg ISA extension support
>
> Nikita Shubin (1):
>       target/riscv: don't read CSR in riscv_csrrw_do64
>
> Rob Bradford (1):
>       target/riscv: Implement WARL behaviour for mcountinhibit/mcounteren
>
> Robbin Ehn (1):
>       linux-user/riscv: Add new extensions to hwprobe
>
> Thomas Huth (2):
>       hw/char/riscv_htif: Fix printing of console characters on big endian hosts
>       hw/char/riscv_htif: Fix the console syscall on big endian hosts
>
> Tommy Wu (1):
>       target/riscv: Align the AIA model to v1.0 ratified spec
>
> Vineet Gupta (1):
>       riscv: zicond: make non-experimental
>
> Weiwei Li (1):
>       target/riscv: Update CSR bits name for svadu extension
>
> Yong-Xuan Wang (5):
>       target/riscv: support the AIA device emulation with KVM enabled
>       target/riscv: check the in-kernel irqchip support
>       target/riscv: Create an KVM AIA irqchip
>       target/riscv: update APLIC and IMSIC to support KVM AIA
>       target/riscv: select KVM AIA in riscv virt machine
>
>  docs/about/deprecated.rst                 |  12 +
>  include/crypto/aes.h                      |   7 +
>  include/crypto/sm4.h                      |   9 +
>  target/riscv/cpu-qom.h                    |   1 +
>  target/riscv/cpu.h                        |   2 +
>  target/riscv/cpu_bits.h                   |   8 +-
>  target/riscv/cpu_cfg.h                    |   9 +
>  target/riscv/debug.h                      |   3 +-
>  target/riscv/helper.h                     |  98 +++
>  target/riscv/kvm_riscv.h                  |   5 +
>  target/riscv/vector_internals.h           | 228 +++++++
>  target/riscv/insn32.decode                |  58 ++
>  crypto/aes.c                              |   4 +-
>  crypto/sm4.c                              |  10 +
>  hw/char/riscv_htif.c                      |  12 +-
>  hw/intc/riscv_aclint.c                    |  11 +-
>  hw/intc/riscv_aplic.c                     |  52 +-
>  hw/intc/riscv_imsic.c                     |  25 +-
>  hw/riscv/virt.c                           | 374 ++++++------
>  linux-user/riscv/signal.c                 |   4 +-
>  linux-user/syscall.c                      |  14 +-
>  target/arm/tcg/crypto_helper.c            |  10 +-
>  target/riscv/cpu.c                        | 625 ++++++++++++++-----
>  target/riscv/cpu_helper.c                 |   6 +-
>  target/riscv/crypto_helper.c              |  51 +-
>  target/riscv/csr.c                        |  54 +-
>  target/riscv/debug.c                      |  15 +-
>  target/riscv/kvm.c                        | 209 ++++++-
>  target/riscv/pmp.c                        |   4 +
>  target/riscv/translate.c                  |   1 +
>  target/riscv/vcrypto_helper.c             | 970 ++++++++++++++++++++++++++++++
>  target/riscv/vector_helper.c              | 245 +-------
>  target/riscv/vector_internals.c           |  81 +++
>  target/riscv/insn_trans/trans_rvv.c.inc   | 171 +++---
>  target/riscv/insn_trans/trans_rvvk.c.inc  | 606 +++++++++++++++++++
>  target/riscv/insn_trans/trans_rvzfa.c.inc |   4 +-
>  target/riscv/meson.build                  |   4 +-
>  tests/avocado/tuxrun_baselines.py         |  32 +
>  38 files changed, 3224 insertions(+), 810 deletions(-)
>  create mode 100644 target/riscv/vector_internals.h
>  create mode 100644 target/riscv/vcrypto_helper.c
>  create mode 100644 target/riscv/vector_internals.c
>  create mode 100644 target/riscv/insn_trans/trans_rvvk.c.inc
>

