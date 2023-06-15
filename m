Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FED730DEA
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 06:05:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9eDa-0003EQ-Ko; Thu, 15 Jun 2023 00:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9eDX-0003EA-N7
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 00:04:15 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9eDU-0000Qg-OL
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 00:04:15 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-461b408594fso285263e0c.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 21:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686801850; x=1689393850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1HZwrFf3voSnysZsa0bhIQUou0YLCFC2RKzS5Ca/lU=;
 b=PioIcaO1Dg36ioiPlORpXFTxpdRPPwRC1FvCBvFRlXlnb8hc7/jYWtBSzap1UuooIr
 TiMeHoeLOtk3xW0PdzhPKAXaXISc32De8HfRZJoOx7THo8SKkEbDoWgPeleMgQqXa1AG
 Ty5DJdzNLwWSSUxtKXs37XZ1r4yughoectes2wrpZa/1qMy3iy0ohXyERfJNEi5rqPoS
 lZyyEVxkA8Q+6poq+gn3WKXnphd3whrp0VVnXcbkn97MpV16LO0hA34wa4i2p22Q8Jqk
 q2xPNa3UfnWMQXvsg7sCZY+zbT49xvoVkD3mZqug/K2GAjFwjQHtXQY9InerE5o/AlLl
 n5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686801850; x=1689393850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1HZwrFf3voSnysZsa0bhIQUou0YLCFC2RKzS5Ca/lU=;
 b=etQ4ydnddtVRyueWJvTB0bDboptI3/FZZnRWltSpSP2IixePSd+UeJ1zMrlqAdpQED
 4w74BNIEJn+u1vNAP6MS1kSRN7S4FkdW2gN7aIVer1TsECiivnz6EN2ltIypqpo6yQze
 s80edZRynLqppamL5DVqY3L/FbVqKfCDDUFnOzTb9cc/tbERPNziRpqno+1icgvsFndy
 XW2wcx8rFlL/lcWGNwGWlM6Q55cqvyptdMOSzJlxZvsTINzr1FzydSxIecNTqLDt3Bge
 MXpeRDp+UKCCcmyd6gxsPu+g42vvVpWNVJfELJ2XjMnUOLvO0jv0gaB/huvJI4DuULCJ
 xN2A==
X-Gm-Message-State: AC+VfDznTmNhBdYtN9/e1Bx4qE1k1yXIMQN5ZlvXnaQoaCWx5bLjo+pb
 v1BTe+JXTgLwQjJVURJ1mvXhXtgU3fIitQnJw3djA66G3/4=
X-Google-Smtp-Source: ACHHUZ5c6B9CS2qGkXHTaJOlcbQ5PpHc4IS0bLv21J/8pnLXLxRAODPo3NnfKguvdLaN3tfuSfgQgKI8d06w4Se9ESk=
X-Received: by 2002:a1f:2612:0:b0:45c:b73b:ed25 with SMTP id
 m18-20020a1f2612000000b0045cb73bed25mr1194259vkm.3.1686801850414; Wed, 14 Jun
 2023 21:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
 <6693132a-c820-5d04-6f9f-ac38d067e935@tls.msk.ru>
In-Reply-To: <6693132a-c820-5d04-6f9f-ac38d067e935@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Jun 2023 14:03:44 +1000
Message-ID: <CAKmqyKPT9-Ru+AHhQR-N+2EctyWCdDY5nErT5Z0GbJ+zJfEcYw@mail.gmail.com>
Subject: Re: [PULL 00/60] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Wed, Jun 14, 2023 at 10:17=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>
> 14.06.2023 04:19, Alistair Francis wrote:
> > The following changes since commit fdd0df5340a8ebc8de88078387ebc85c5af7=
b40f:
> >
> >    Merge tag 'pull-ppc-20230610' of https://gitlab.com/danielhb/qemu in=
to staging (2023-06-10 07:25:00 -0700)
> >
> > are available in the Git repository at:
> >
> >    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-2023=
0614
> >
> > for you to fetch changes up to 860029321d9ebdff47e89561de61e9441fead70a=
:
> >
> >    hw/intc: If mmsiaddrcfgh.L =3D=3D 1, smsiaddrcfg and smsiaddrcfgh ar=
e read-only. (2023-06-14 10:04:30 +1000)
>
> Is anything there worth to apply to -stable?
>
> I picked this one:
>          hw/riscv: qemu crash when NUMA nodes exceed available CPUs

Thanks for that!

>
> Anything else?

I don't think there is anything else, the other fixes are mostly for
experimental features, so I don't think we need to backport them.

Alistair

>
> Thanks!
>
> /mjt
>
> > Daniel Henrique Barboza (10):
> >        target/riscv/vector_helper.c: skip set tail when vta is zero
> >        target/riscv/cpu.c: add riscv_cpu_validate_v()
> >        target/riscv/cpu.c: remove set_vext_version()
> >        target/riscv/cpu.c: remove set_priv_version()
> >        target/riscv: add PRIV_VERSION_LATEST
> >        target/riscv/cpu.c: add priv_spec validate/disable_exts helpers
> >        target/riscv/cpu.c: add riscv_cpu_validate_misa_mxl()
> >        target/riscv/cpu.c: validate extensions before riscv_timer_init(=
)
> >        target/riscv/cpu.c: remove cfg setup from riscv_cpu_init()
> >        target/riscv: rework write_misa()
> >
> > Himanshu Chauhan (1):
> >        target/riscv: Smepmp: Return error when access permission not al=
lowed in PMP
> >
> > Ivan Klokov (1):
> >        util/log: Add vector registers to log
> >
> > Mayuresh Chitale (3):
> >        target/riscv: smstateen check for fcsr
> >        target/riscv: Reuse tb->flags.FS
> >        target/riscv: smstateen knobs
> >
> > Philippe Mathieu-Daud=C3=A9 (5):
> >        hw/riscv/opentitan: Rename machine_[class]_init() functions
> >        hw/riscv/opentitan: Declare QOM types using DEFINE_TYPES() macro
> >        hw/riscv/opentitan: Add TYPE_OPENTITAN_MACHINE definition
> >        hw/riscv/opentitan: Explicit machine type definition
> >        hw/riscv/opentitan: Correct OpenTitanState parent type/size
> >
> > Sunil V L (3):
> >        hw/riscv: virt: Assume M-mode FW in pflash0 only when "-bios non=
e"
> >        riscv/virt: Support using pflash via -blockdev option
> >        docs/system: riscv: Add pflash usage details
> >
> > Tommy Wu (1):
> >        hw/intc: If mmsiaddrcfgh.L =3D=3D 1, smsiaddrcfg and smsiaddrcfg=
h are read-only.
> >
> > Weiwei Li (33):
> >        target/riscv: Move zc* out of the experimental properties
> >        target/riscv: Mask the implicitly enabled extensions in isa_stri=
ng based on priv version
> >        target/riscv: Update check for Zca/Zcf/Zcd
> >        target/riscv: Update pmp_get_tlb_size()
> >        target/riscv: Move pmp_get_tlb_size apart from get_physical_addr=
ess_pmp
> >        target/riscv: Make the short cut really work in pmp_hart_has_pri=
vs
> >        target/riscv: Change the return type of pmp_hart_has_privs() to =
bool
> >        target/riscv: Make RLB/MML/MMWP bits writable only when Smepmp i=
s enabled
> >        target/riscv: Remove unused paramters in pmp_hart_has_privs_defa=
ult()
> >        target/riscv: Flush TLB when MMWP or MML bits are changed
> >        target/riscv: Update the next rule addr in pmpaddr_csr_write()
> >        target/riscv: Flush TLB when pmpaddr is updated
> >        target/riscv: Flush TLB only when pmpcfg/pmpaddr really changes
> >        target/riscv: Separate pmp_update_rule() in pmpcfg_csr_write
> >        target/riscv: Deny access if access is partially inside the PMP =
entry
> >        target/riscv: Fix pointer mask transformation for vector address
> >        target/riscv: Update cur_pmmask/base when xl changes
> >        disas: Change type of disassemble_info.target_info to pointer
> >        target/riscv: Split RISCVCPUConfig declarations from cpu.h into =
cpu_cfg.h
> >        target/riscv: Pass RISCVCPUConfig as target_info to disassemble_=
info
> >        disas/riscv.c: Support disas for Zcm* extensions
> >        disas/riscv.c: Support disas for Z*inx extensions
> >        disas/riscv.c: Remove unused decomp_rv32/64 value for vector ins=
tructions
> >        disas/riscv.c: Fix lines with over 80 characters
> >        disas/riscv.c: Remove redundant parentheses
> >        target/riscv: Fix target address to update badaddr
> >        target/riscv: Introduce cur_insn_len into DisasContext
> >        target/riscv: Change gen_goto_tb to work on displacements
> >        target/riscv: Change gen_set_pc_imm to gen_update_pc
> >        target/riscv: Use true diff for gen_pc_plus_diff
> >        target/riscv: Enable PC-relative translation
> >        target/riscv: Remove pc_succ_insn from DisasContext
> >        target/riscv: Fix initialized value for cur_pmmask
> >
> > Xiao Wang (2):
> >        target/riscv/vector_helper.c: clean up reference of MTYPE
> >        target/riscv/vector_helper.c: Remove the check for extra tail el=
ements
> >
> > Yin Wang (1):
> >        hw/riscv: qemu crash when NUMA nodes exceed available CPUs
> >
> >   docs/system/riscv/virt.rst                     |   31 +
> >   include/disas/dis-asm.h                        |    2 +-
> >   include/hw/core/cpu.h                          |    2 +
> >   include/hw/riscv/opentitan.h                   |    6 +-
> >   include/qemu/log.h                             |    1 +
> >   target/riscv/cpu.h                             |  117 +--
> >   target/riscv/cpu_cfg.h                         |  136 +++
> >   target/riscv/pmp.h                             |   11 +-
> >   accel/tcg/cpu-exec.c                           |    3 +
> >   disas/riscv.c                                  | 1194 +++++++++++++--=
---------
> >   hw/intc/riscv_aplic.c                          |    4 +-
> >   hw/riscv/numa.c                                |    6 +
> >   hw/riscv/opentitan.c                           |   38 +-
> >   hw/riscv/virt.c                                |   59 +-
> >   target/riscv/cpu.c                             |  384 +++++---
> >   target/riscv/cpu_helper.c                      |   37 +-
> >   target/riscv/csr.c                             |   75 +-
> >   target/riscv/pmp.c                             |  205 ++--
> >   target/riscv/translate.c                       |   99 +-
> >   target/riscv/vector_helper.c                   |   33 +-
> >   util/log.c                                     |    2 +
> >   target/riscv/insn_trans/trans_privileged.c.inc |    2 +-
> >   target/riscv/insn_trans/trans_rvd.c.inc        |   12 +-
> >   target/riscv/insn_trans/trans_rvf.c.inc        |   21 +-
> >   target/riscv/insn_trans/trans_rvi.c.inc        |   46 +-
> >   target/riscv/insn_trans/trans_rvv.c.inc        |    4 +-
> >   target/riscv/insn_trans/trans_rvzawrs.c.inc    |    2 +-
> >   target/riscv/insn_trans/trans_rvzce.c.inc      |   10 +-
> >   target/riscv/insn_trans/trans_xthead.c.inc     |    2 +-
> >   29 files changed, 1442 insertions(+), 1102 deletions(-)
> >   create mode 100644 target/riscv/cpu_cfg.h
> >
>

