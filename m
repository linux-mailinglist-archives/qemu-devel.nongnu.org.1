Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 193CA78BB34
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:53:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qal6T-0002Hy-Ol; Mon, 28 Aug 2023 18:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qal6R-0002Hb-5A
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:52:59 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qal6O-0003Ef-CA
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:52:58 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-57359e85e9bso1406082eaf.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693263175; x=1693867975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUi1sXceNWvI3Ht4iuKxgYxTeCZgYIf+Eqq+iVoSdwg=;
 b=VLygqxfm2quQDkOKbRyzFBrv3wNXL+KSaQolPVaWr48T4DKgiPCfFwfJPVXMg8UWIf
 +0A5XjZghWGKt+MboQHpiQuOnNnD0mxRgC5WOwEBjj97C464BoY16CtXLqdm1igzYQ/E
 0htNrwI9+2CzO5NV5kTrOUB4k61ksUr7VszyEnRRwjQzKZHbf5DdYiTVLVpQwWwZH0SG
 aVDO0fiKVsru1m3Wfn9xwbCfWDPY51IYvOrXiUwLJIw0k+xgAD+P7ZKcWi1ujRiKswTU
 Wpun+cLENEzP/ndVm6QAW8tx7PFW4va/T3EAHaDYbF38XLhnVGdcV+cutBGBXdV8gTDu
 zgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693263175; x=1693867975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUi1sXceNWvI3Ht4iuKxgYxTeCZgYIf+Eqq+iVoSdwg=;
 b=Yqj2JIjr4Db+IO5xCT0kAlJ4gIQcItde5d/lN6c04Nbzs8UoG8+527s7qqfomFnxIF
 r7t1TzQSO6Anfs+dBqs0FbizbK+gqsd2I1MbF2n68OE2LQIrl2e2tCpurrKpIp6vWYCX
 QIi93aCXVkuonhnX0+GwK5+7hQGrNhNlnqtO/63TJk2jILFP+FKrRInQ3oAXxY4NKre1
 lgv9AtxQGtjKWMtmidJ9rVMDtgiObeGxYsDXi4+MpZpsSKCequit1ivUMBZ5crwnzUMR
 4rfUhDhCZCIVMgGqykZMXJApTwSJaYxVX+7JAZXsbrDDfjkn3loScR4HjsEJ7fU9U4Ih
 +oDQ==
X-Gm-Message-State: AOJu0YwvfyWbia6Bu903XaCGlSvi+kyO9NoF59UNj4mn6uPu7dbYhpNY
 rMwfNhH4P1VdsgwFrT9MvblTLqdCVw/n+TpoeOc=
X-Google-Smtp-Source: AGHT+IGGGOV3CydkOWW8DGAsdmAudgR/dAxxVFYtuMBRRm013s36ch+jS/7zEiaQPxDUtS07CYiu4rg/Trf2RqxmTCo=
X-Received: by 2002:a4a:d216:0:b0:56c:cd04:9083 with SMTP id
 c22-20020a4ad216000000b0056ccd049083mr13193736oos.1.1693263174926; Mon, 28
 Aug 2023 15:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230824182854.1572951-1-richard.henderson@linaro.org>
In-Reply-To: <20230824182854.1572951-1-richard.henderson@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 28 Aug 2023 18:52:42 -0400
Message-ID: <CAJSP0QVY=bC3i+-20ek5q5KnQPgRVavFq0DK1+4m+fhpAO5fQw@mail.gmail.com>
Subject: Re: [PATCH v2 00/48] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc35.google.com
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

On Thu, 24 Aug 2023 at 14:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 50e7a40af372ee5931c99ef7390f5d3d6fbf6e=
c4:
>
>   Merge tag 'pull-target-arm-20230824' of https://git.linaro.org/people/p=
maydell/qemu-arm into staging (2023-08-24 10:08:33 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230823-2
>
> for you to fetch changes up to 4daad8d9d6b9d426beb8ce505d2164ba36ea3168:
>
>   tcg: spelling fixes (2023-08-24 11:22:42 -0700)
>
> ----------------------------------------------------------------
> accel/*: Widen pc/saved_insn for *_sw_breakpoint
> accel/tcg: Replace remaining target_ulong in system-mode accel
> tcg: spelling fixes
> tcg: Document bswap, hswap, wswap byte patterns
> tcg: Introduce negsetcond opcodes
> tcg: Fold deposit with zero to and
> tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
> tcg/i386: Drop BYTEH deposits for 64-bit
> tcg/i386: Allow immediate as input to deposit
> target/*: Use tcg_gen_negsetcond_*

Hi Richard,
I'm seeing a segfault in "make docker-test-tcg@debian-tricore-cross"
after this pull request.

Note that it has already been merged into qemu.git/master. CI actually
caught it but I accidentally pushed staging to master.

Stefan

>
> ----------------------------------------------------------------
> Anton Johansson (9):
>       accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
>       accel/hvf: Widen pc/saved_insn for hvf_sw_breakpoint
>       sysemu/kvm: Use vaddr for kvm_arch_[insert|remove]_hw_breakpoint
>       sysemu/hvf: Use vaddr for hvf_arch_[insert|remove]_hw_breakpoint
>       include/exec: Replace target_ulong with abi_ptr in cpu_[st|ld]*()
>       include/exec: typedef abi_ptr to vaddr in softmmu
>       include/exec: Widen tlb_hit/tlb_hit_page()
>       accel/tcg: Widen address arg in tlb_compare_set()
>       accel/tcg: Update run_on_cpu_data static assert
>
> Mark Cave-Ayland (1):
>       docs/devel/tcg-ops: fix missing newlines in "Host vector operations=
"
>
> Michael Tokarev (1):
>       tcg: spelling fixes
>
> Philippe Mathieu-Daud=C3=A9 (9):
>       docs/devel/tcg-ops: Bury mentions of trunc_shr_i64_i32()
>       tcg/tcg-op: Document bswap16_i32() byte pattern
>       tcg/tcg-op: Document bswap16_i64() byte pattern
>       tcg/tcg-op: Document bswap32_i32() byte pattern
>       tcg/tcg-op: Document bswap32_i64() byte pattern
>       tcg/tcg-op: Document bswap64_i64() byte pattern
>       tcg/tcg-op: Document hswap_i32/64() byte pattern
>       tcg/tcg-op: Document wswap_i64() byte pattern
>       target/cris: Fix a typo in gen_swapr()
>
> Richard Henderson (28):
>       target/m68k: Use tcg_gen_deposit_i32 in gen_partset_reg
>       tcg/i386: Drop BYTEH deposits for 64-bit
>       tcg: Fold deposit with zero to and
>       tcg/i386: Allow immediate as input to deposit_*
>       tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
>       tcg: Introduce negsetcond opcodes
>       tcg: Use tcg_gen_negsetcond_*
>       target/alpha: Use tcg_gen_movcond_i64 in gen_fold_mzero
>       target/arm: Use tcg_gen_negsetcond_*
>       target/m68k: Use tcg_gen_negsetcond_*
>       target/openrisc: Use tcg_gen_negsetcond_*
>       target/ppc: Use tcg_gen_negsetcond_*
>       target/sparc: Use tcg_gen_movcond_i64 in gen_edge
>       target/tricore: Replace gen_cond_w with tcg_gen_negsetcond_tl
>       tcg/ppc: Implement negsetcond_*
>       tcg/ppc: Use the Set Boolean Extension
>       tcg/aarch64: Implement negsetcond_*
>       tcg/arm: Implement negsetcond_i32
>       tcg/riscv: Implement negsetcond_*
>       tcg/s390x: Implement negsetcond_*
>       tcg/sparc64: Implement negsetcond_*
>       tcg/i386: Merge tcg_out_brcond{32,64}
>       tcg/i386: Merge tcg_out_setcond{32,64}
>       tcg/i386: Merge tcg_out_movcond{32,64}
>       tcg/i386: Use CMP+SBB in tcg_out_setcond
>       tcg/i386: Clear dest first in tcg_out_setcond if possible
>       tcg/i386: Use shift in tcg_out_setcond
>       tcg/i386: Implement negsetcond_*
>
>  docs/devel/tcg-ops.rst                     |  15 +-
>  accel/tcg/atomic_template.h                |  16 +-
>  include/exec/cpu-all.h                     |   4 +-
>  include/exec/cpu_ldst.h                    |  28 +--
>  include/sysemu/hvf.h                       |  12 +-
>  include/sysemu/kvm.h                       |  12 +-
>  include/tcg/tcg-op-common.h                |   4 +
>  include/tcg/tcg-op.h                       |   2 +
>  include/tcg/tcg-opc.h                      |   6 +-
>  include/tcg/tcg.h                          |   4 +-
>  tcg/aarch64/tcg-target.h                   |   5 +-
>  tcg/arm/tcg-target.h                       |   1 +
>  tcg/i386/tcg-target-con-set.h              |   2 +-
>  tcg/i386/tcg-target-con-str.h              |   1 -
>  tcg/i386/tcg-target.h                      |   9 +-
>  tcg/loongarch64/tcg-target.h               |   6 +-
>  tcg/mips/tcg-target.h                      |   5 +-
>  tcg/ppc/tcg-target.h                       |   5 +-
>  tcg/riscv/tcg-target.h                     |   5 +-
>  tcg/s390x/tcg-target.h                     |   5 +-
>  tcg/sparc64/tcg-target.h                   |   5 +-
>  tcg/tci/tcg-target.h                       |   5 +-
>  accel/hvf/hvf-accel-ops.c                  |   4 +-
>  accel/hvf/hvf-all.c                        |   2 +-
>  accel/kvm/kvm-all.c                        |   3 +-
>  accel/tcg/cputlb.c                         |  17 +-
>  target/alpha/translate.c                   |   7 +-
>  target/arm/hvf/hvf.c                       |   4 +-
>  target/arm/kvm64.c                         |   6 +-
>  target/arm/tcg/translate-a64.c             |  22 +--
>  target/arm/tcg/translate.c                 |  12 +-
>  target/cris/translate.c                    |  20 +-
>  target/i386/hvf/hvf.c                      |   4 +-
>  target/i386/kvm/kvm.c                      |   8 +-
>  target/m68k/translate.c                    |  35 ++--
>  target/openrisc/translate.c                |   6 +-
>  target/ppc/kvm.c                           |  13 +-
>  target/riscv/vector_helper.c               |   2 +-
>  target/rx/op_helper.c                      |   6 +-
>  target/s390x/kvm/kvm.c                     |   6 +-
>  target/sparc/translate.c                   |  17 +-
>  target/tricore/translate.c                 |  16 +-
>  tcg/optimize.c                             |  78 +++++++-
>  tcg/tcg-op-gvec.c                          |   6 +-
>  tcg/tcg-op.c                               | 151 ++++++++++++---
>  tcg/tcg.c                                  |   9 +-
>  target/ppc/translate/fixedpoint-impl.c.inc |   6 +-
>  target/ppc/translate/vmx-impl.c.inc        |   8 +-
>  tcg/aarch64/tcg-target.c.inc               |  14 +-
>  tcg/arm/tcg-target.c.inc                   |  19 +-
>  tcg/i386/tcg-target.c.inc                  | 291 ++++++++++++++++++-----=
------
>  tcg/ppc/tcg-target.c.inc                   | 149 ++++++++++-----
>  tcg/riscv/tcg-target.c.inc                 |  49 ++++-
>  tcg/s390x/tcg-target.c.inc                 |  78 +++++---
>  tcg/sparc64/tcg-target.c.inc               |  40 +++-
>  55 files changed, 832 insertions(+), 433 deletions(-)
>

