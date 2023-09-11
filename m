Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C44A79A880
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 16:08:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfhZt-00046t-0I; Mon, 11 Sep 2023 10:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qfhZr-000463-9t
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:07:47 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qfhZo-00070t-78
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:07:47 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a7781225b4so3060563b6e.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694441263; x=1695046063; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+YHH8oVcp8JOveDgYT+oREbT5/sjrdbs8OV1iRmDu+4=;
 b=AVY0JMHJHpHsuL92UtR0KrS14yZnFdUx1d+IibOA3jQQ+dkI1emTlg/Hx74yOGbyQ5
 xgoKekT538XRSvBk/TrLZRuC5CixPD40OcMory0alBaxASAuzmmaSHoQktZ3rwTQQiCG
 WliTesk0JugCxdFKpmNslbmiDqs96WKZcCe9U4BSBxIDLDi/ZV7V8f+jfAjCdCM0Ctt+
 P86cUvJAPxw3aPl5q1C0/s2UxURKjaD/uVOHB+g6ZaWZc478LyKQ3abtxpWCSkt42Xwo
 DcruGYUK9Oc7sO/0lnyw/QvWIYEmhOE/XoYg1RM86wa5+ReJ3sxtqSQLDH/vdKtIDc1U
 pqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694441263; x=1695046063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+YHH8oVcp8JOveDgYT+oREbT5/sjrdbs8OV1iRmDu+4=;
 b=nYEvFFoOuVWKPhU4tbXb4J+InstG1Ky9lapt+dKF+ZkoPir5caEH7nWl+D3pX71n62
 hwnHYobe6u3r37wSfrhVHlkG7e/gTK1mUhDzoGzlCkTw9ve9d9QuNPfv4emBwtaVgMEn
 giQf6GNaAWV4O/54RQzTEoGc6bSLUIrEaemC8G466oFSUGCTJgj+iJlBMhZUW76QfcS4
 e5GFjvF3Bl84ReKcrIDcZo6vUncH8W1xzigJgQUCJLMlqqvkvPzhhqcRIDR6z1yZTFey
 /2/N5Xb+YtULGphoWWERK355ohWwOD9mS3ofir8JoJYGlwSj8J0BDubam5wyhOVs2GB6
 KamA==
X-Gm-Message-State: AOJu0YzadkWbw+Kv9DzB8VeaGAq7ajMhkndJqyw2fCuIXFuLPlqfXybU
 NlRMkqHMUtuc0wlnvTz03KT3bMdh9YHkQia8v5c=
X-Google-Smtp-Source: AGHT+IFqVFav6HjIlrlsVljzBkBqm4RI+OAb3KlsUCZP5oa8Xeih8pKGP1HVJSR/nzKiac68GEBK5Ir3DFGkA9FTjYw=
X-Received: by 2002:a54:478a:0:b0:3a7:4914:23ce with SMTP id
 o10-20020a54478a000000b003a7491423cemr9587322oic.18.1694441262607; Mon, 11
 Sep 2023 07:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
 <CAJSP0QV=_OxEnW2-h0KWehz=fG+jVfv5v+PSmEMprwyfOxNYXQ@mail.gmail.com>
 <0623f256-11c0-3c83-2c22-49fe7d3461b4@ventanamicro.com>
In-Reply-To: <0623f256-11c0-3c83-2c22-49fe7d3461b4@ventanamicro.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 Sep 2023 10:07:30 -0400
Message-ID: <CAJSP0QW-F5g6crWfLAKwVT1sDcbi61whH27k4uq5cKHQad3fKA@mail.gmail.com>
Subject: Re: [PULL 00/65] riscv-to-apply queue
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, 11 Sept 2023 at 09:38, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi Stefan,
>
> On 9/8/23 08:06, Stefan Hajnoczi wrote:
> > Hi Alistair,
> > Please take a look at the following CI failure:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/5045998521
> >
> > /usr/bin/ld: libqemu-riscv64-softmmu.fa.p/target_riscv_cpu.c.o: in
> > function `riscv_cpu_add_kvm_properties':
> > /home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/build/../target/riscv/cpu.c:2146:
> > undefined reference to `kvm_riscv_init_user_properties'
>
> I do not have the 'ubuntu-22.04-aarch64-alldbg' runner enabled when running the gitlab CI.
> The CI on my end is all green:
>
> https://gitlab.com/danielhb/qemu/-/pipelines/999487372
>
> IIUC this runner is one of the custom runners from .gitlab-ci.d/custom-runners that aren't
> run by default. I'm not sure if it's possible to triggr it manually on my end or if it's
> triggered only when attempting a merge to master.
>
> I managed to reproduce the problem by reading the test log and copying the build opts. I
> fixed it on my machine but, to be really sure that it's indeed fixed, it would be nice
> to execute this particular runner somehow.

Hi Daniel,
I think you can reproduce this locally using "make
EXTRA_CONFIGURE_OPTS=--enable-debug vm-build-ubuntu.aarch64". It
builds QEMU in an Ubuntu 22.04 aarch64 VM. That seems to be equivalent
to the CI job.

Stefan

>
>
> Thanks,
>
> Daniel
>
> >
> > Stefan
> >
> > On Fri, 8 Sept 2023 at 03:10, Alistair Francis <alistair23@gmail.com> wrote:
> >>
> >> The following changes since commit 03a3a62fbd0aa5227e978eef3c67d3978aec9e5f:
> >>
> >>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-09-07 10:29:06 -0400)
> >>
> >> are available in the Git repository at:
> >>
> >>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20230908
> >>
> >> for you to fetch changes up to 69749970db9f1b05c8cd77a7bbb45e4e156f7d33:
> >>
> >>    target/riscv/cpu.c: consider user option with RVG (2023-09-08 15:57:39 +1000)
> >>
> >> ----------------------------------------------------------------
> >> First RISC-V PR for 8.2
> >>
> >>   * Remove 'host' CPU from TCG
> >>   * riscv_htif Fixup printing on big endian hosts
> >>   * Add zmmul isa string
> >>   * Add smepmp isa string
> >>   * Fix page_check_range use in fault-only-first
> >>   * Use existing lookup tables for MixColumns
> >>   * Add RISC-V vector cryptographic instruction set support
> >>   * Implement WARL behaviour for mcountinhibit/mcounteren
> >>   * Add Zihintntl extension ISA string to DTS
> >>   * Fix zfa fleq.d and fltq.d
> >>   * Fix upper/lower mtime write calculation
> >>   * Make rtc variable names consistent
> >>   * Use abi type for linux-user target_ucontext
> >>   * Add RISC-V KVM AIA Support
> >>   * Fix riscv,pmu DT node path in the virt machine
> >>   * Update CSR bits name for svadu extension
> >>   * Mark zicond non-experimental
> >>   * Fix satp_mode_finalize() when satp_mode.supported = 0
> >>   * Fix non-KVM --enable-debug build
> >>   * Add new extensions to hwprobe
> >>   * Use accelerated helper for AES64KS1I
> >>   * Allocate itrigger timers only once
> >>   * Respect mseccfg.RLB for pmpaddrX changes
> >>   * Align the AIA model to v1.0 ratified spec
> >>   * Don't read the CSR in riscv_csrrw_do64
> >>   * Add the 'max' CPU, detect user choice in TCG
> >>
> >> ----------------------------------------------------------------
> >> Akihiko Odaki (1):
> >>        target/riscv: Allocate itrigger timers only once
> >>
> >> Ard Biesheuvel (2):
> >>        target/riscv: Use existing lookup tables for MixColumns
> >>        target/riscv: Use accelerated helper for AES64KS1I
> >>
> >> Conor Dooley (1):
> >>        hw/riscv: virt: Fix riscv,pmu DT node path
> >>
> >> Daniel Henrique Barboza (26):
> >>        target/riscv/cpu.c: do not run 'host' CPU with TCG
> >>        target/riscv/cpu.c: add zmmul isa string
> >>        target/riscv/cpu.c: add smepmp isa string
> >>        target/riscv: fix satp_mode_finalize() when satp_mode.supported = 0
> >>        hw/riscv/virt.c: fix non-KVM --enable-debug build
> >>        hw/intc/riscv_aplic.c fix non-KVM --enable-debug build
> >>        target/riscv/cpu.c: split CPU options from riscv_cpu_extensions[]
> >>        target/riscv/cpu.c: skip 'bool' check when filtering KVM props
> >>        target/riscv/cpu.c: split kvm prop handling to its own helper
> >>        target/riscv: add DEFINE_PROP_END_OF_LIST() to riscv_cpu_options[]
> >>        target/riscv/cpu.c: split non-ratified exts from riscv_cpu_extensions[]
> >>        target/riscv/cpu.c: split vendor exts from riscv_cpu_extensions[]
> >>        target/riscv/cpu.c: add riscv_cpu_add_qdev_prop_array()
> >>        target/riscv/cpu.c: add riscv_cpu_add_kvm_unavail_prop_array()
> >>        target/riscv/cpu.c: limit cfg->vext_spec log message
> >>        target/riscv: add 'max' CPU type
> >>        avocado, risc-v: add tuxboot tests for 'max' CPU
> >>        target/riscv: deprecate the 'any' CPU type
> >>        target/riscv/cpu.c: use offset in isa_ext_is_enabled/update_enabled
> >>        target/riscv: make CPUCFG() macro public
> >>        target/riscv/cpu.c: introduce cpu_cfg_ext_auto_update()
> >>        target/riscv/cpu.c: use cpu_cfg_ext_auto_update() during realize()
> >>        target/riscv/cpu.c: introduce RISCVCPUMultiExtConfig
> >>        target/riscv: use isa_ext_update_enabled() in init_max_cpu_extensions()
> >>        target/riscv/cpu.c: honor user choice in cpu_cfg_ext_auto_update()
> >>        target/riscv/cpu.c: consider user option with RVG
> >>
> >> Dickon Hood (2):
> >>        target/riscv: Refactor translation of vector-widening instruction
> >>        target/riscv: Add Zvbb ISA extension support
> >>
> >> Jason Chien (3):
> >>        target/riscv: Add Zihintntl extension ISA string to DTS
> >>        hw/intc: Fix upper/lower mtime write calculation
> >>        hw/intc: Make rtc variable names consistent
> >>
> >> Kiran Ostrolenk (4):
> >>        target/riscv: Refactor some of the generic vector functionality
> >>        target/riscv: Refactor vector-vector translation macro
> >>        target/riscv: Refactor some of the generic vector functionality
> >>        target/riscv: Add Zvknh ISA extension support
> >>
> >> LIU Zhiwei (3):
> >>        target/riscv: Fix page_check_range use in fault-only-first
> >>        target/riscv: Fix zfa fleq.d and fltq.d
> >>        linux-user/riscv: Use abi type for target_ucontext
> >>
> >> Lawrence Hunter (2):
> >>        target/riscv: Add Zvbc ISA extension support
> >>        target/riscv: Add Zvksh ISA extension support
> >>
> >> Leon Schuermann (1):
> >>        target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes
> >>
> >> Max Chou (3):
> >>        crypto: Create sm4_subword
> >>        crypto: Add SM4 constant parameter CK
> >>        target/riscv: Add Zvksed ISA extension support
> >>
> >> Nazar Kazakov (4):
> >>        target/riscv: Remove redundant "cpu_vl == 0" checks
> >>        target/riscv: Move vector translation checks
> >>        target/riscv: Add Zvkned ISA extension support
> >>        target/riscv: Add Zvkg ISA extension support
> >>
> >> Nikita Shubin (1):
> >>        target/riscv: don't read CSR in riscv_csrrw_do64
> >>
> >> Rob Bradford (1):
> >>        target/riscv: Implement WARL behaviour for mcountinhibit/mcounteren
> >>
> >> Robbin Ehn (1):
> >>        linux-user/riscv: Add new extensions to hwprobe
> >>
> >> Thomas Huth (2):
> >>        hw/char/riscv_htif: Fix printing of console characters on big endian hosts
> >>        hw/char/riscv_htif: Fix the console syscall on big endian hosts
> >>
> >> Tommy Wu (1):
> >>        target/riscv: Align the AIA model to v1.0 ratified spec
> >>
> >> Vineet Gupta (1):
> >>        riscv: zicond: make non-experimental
> >>
> >> Weiwei Li (1):
> >>        target/riscv: Update CSR bits name for svadu extension
> >>
> >> Yong-Xuan Wang (5):
> >>        target/riscv: support the AIA device emulation with KVM enabled
> >>        target/riscv: check the in-kernel irqchip support
> >>        target/riscv: Create an KVM AIA irqchip
> >>        target/riscv: update APLIC and IMSIC to support KVM AIA
> >>        target/riscv: select KVM AIA in riscv virt machine
> >>
> >>   docs/about/deprecated.rst                 |  12 +
> >>   include/crypto/aes.h                      |   7 +
> >>   include/crypto/sm4.h                      |   9 +
> >>   target/riscv/cpu-qom.h                    |   1 +
> >>   target/riscv/cpu.h                        |   2 +
> >>   target/riscv/cpu_bits.h                   |   8 +-
> >>   target/riscv/cpu_cfg.h                    |   9 +
> >>   target/riscv/debug.h                      |   3 +-
> >>   target/riscv/helper.h                     |  98 +++
> >>   target/riscv/kvm_riscv.h                  |   5 +
> >>   target/riscv/vector_internals.h           | 228 +++++++
> >>   target/riscv/insn32.decode                |  58 ++
> >>   crypto/aes.c                              |   4 +-
> >>   crypto/sm4.c                              |  10 +
> >>   hw/char/riscv_htif.c                      |  12 +-
> >>   hw/intc/riscv_aclint.c                    |  11 +-
> >>   hw/intc/riscv_aplic.c                     |  52 +-
> >>   hw/intc/riscv_imsic.c                     |  25 +-
> >>   hw/riscv/virt.c                           | 374 ++++++------
> >>   linux-user/riscv/signal.c                 |   4 +-
> >>   linux-user/syscall.c                      |  14 +-
> >>   target/arm/tcg/crypto_helper.c            |  10 +-
> >>   target/riscv/cpu.c                        | 625 ++++++++++++++-----
> >>   target/riscv/cpu_helper.c                 |   6 +-
> >>   target/riscv/crypto_helper.c              |  51 +-
> >>   target/riscv/csr.c                        |  54 +-
> >>   target/riscv/debug.c                      |  15 +-
> >>   target/riscv/kvm.c                        | 209 ++++++-
> >>   target/riscv/pmp.c                        |   4 +
> >>   target/riscv/translate.c                  |   1 +
> >>   target/riscv/vcrypto_helper.c             | 970 ++++++++++++++++++++++++++++++
> >>   target/riscv/vector_helper.c              | 245 +-------
> >>   target/riscv/vector_internals.c           |  81 +++
> >>   target/riscv/insn_trans/trans_rvv.c.inc   | 171 +++---
> >>   target/riscv/insn_trans/trans_rvvk.c.inc  | 606 +++++++++++++++++++
> >>   target/riscv/insn_trans/trans_rvzfa.c.inc |   4 +-
> >>   target/riscv/meson.build                  |   4 +-
> >>   tests/avocado/tuxrun_baselines.py         |  32 +
> >>   38 files changed, 3224 insertions(+), 810 deletions(-)
> >>   create mode 100644 target/riscv/vector_internals.h
> >>   create mode 100644 target/riscv/vcrypto_helper.c
> >>   create mode 100644 target/riscv/vector_internals.c
> >>   create mode 100644 target/riscv/insn_trans/trans_rvvk.c.inc
> >>
> >

