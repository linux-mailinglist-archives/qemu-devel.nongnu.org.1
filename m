Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8526961AEA
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Aug 2024 02:03:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj69c-0004lU-7b; Tue, 27 Aug 2024 20:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj69Y-0004Wc-1p; Tue, 27 Aug 2024 20:03:12 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj69W-0005lL-1a; Tue, 27 Aug 2024 20:03:11 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3de13126957so887439b6e.0; 
 Tue, 27 Aug 2024 17:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724803388; x=1725408188; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hu80teFx06w9n+ht9hQfpmWDUCQjZDmvnAqW/7OTc7o=;
 b=GB1pPnZ6enz0jToVDejYxCExaOgbaCm8BOvvbDvBTLQZs0LKM4LcmItrkTkFgyMTWn
 47IQPZ0P7/Snr9q54UkGG7B/KPPiz+pwA1xfhDiI6onH0H4zkeXC1JTZU4/z2gCDObXj
 kCpguI2QY8nuUydneYknP51BTGxx8uVdjBoA+DlJ4CGv53pa7vrBPIzcOkaJdtHO9Znc
 WsN861EFoBX+Wc13xv+tW9yihlKK++1bBtA/j+DHKLMfx6hVvnyGbucZJUDWfkBgvyP2
 IwjkeOL21Z4iN7Cm0mLrrY2QExsgLiUK0vaWt+TpaLETx0PhPUe6GyxT3Pz9wY2shrOz
 6IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724803388; x=1725408188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hu80teFx06w9n+ht9hQfpmWDUCQjZDmvnAqW/7OTc7o=;
 b=ikOmcQVurwdHJfLxPmP8Im+ybcyI2MSNrquI5EpCsxjTSEgTVQ6hRC7xhf8hNxCoeI
 dvMfW8tZOGwBqZ78oP8IgiszUXb3yK7Pys1aa6xxWYWxls1+z0lSxfcNGvCOJl7LbeDY
 Y0d+ZPbUgwQuDWugQdNb8lcGLSYQ/liXAhVbuq50pjjVirVhy3/lKdEe3Ja2hXPG6t97
 5kzar735cjICBDsIywz+zJUM+a3x7Pij/Qmfl995fB4UdSzjbbOo8BMca3aYExqMn4fG
 Z1Y67Sq5QKy5YFMaC8QttKd4Bbs84U3ZzF+13sgZHXNV1taZf1FZrbq8u/JtlKo/7lYt
 SySw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwOntEjW9k8ZMyTEOT44yJWo8blsB1lsWhwkSVFphhOXLIM5iH0foA1uFjDt93S2JZ3e/b4FGOy9QR@nongnu.org
X-Gm-Message-State: AOJu0YwdYQS3ryo5XXWc9mDTL4jAU1j8BBaux+ddzWfBHQUeZjuXAehf
 Y9HAqJG4Mru0Zwk5Of19C7fmQ7WXakvWfYQgK9sgVv5Ks2oOBDXqPIjmhEx+5BcN+lynELTG39n
 QQOexC77YfgeyZnOTqxZ0b4ueYto=
X-Google-Smtp-Source: AGHT+IGt8qA6VU//t+ATvTE7fLds6LUix+F/Y0GCbC8OwC9BLbSTYSvo6J0xQzwtT0uKojwRMRLZI1C+KoxoejPo5pg=
X-Received: by 2002:a05:6358:1c1:b0:1ac:ed54:224d with SMTP id
 e5c5f4694b2df-1b5c2140db7mr1769581855d.11.1724803388334; Tue, 27 Aug 2024
 17:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240827231906.553327-1-debug@rivosinc.com>
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Aug 2024 10:02:42 +1000
Message-ID: <CAKmqyKPukMM7Q2o01c2Vmmqqhc2+f49FS=wM1oxRQ5mQaq2jAw@mail.gmail.com>
Subject: Re: [PATCH v10 00/21] riscv support for control flow integrity
 extensions
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22b.google.com
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

On Wed, Aug 28, 2024 at 9:21=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> v10 for riscv zicfilp and zicfiss extensions support in qemu.

Please specify the exact version of the spec you used

Alistair

>
> Links for previous versions
> [1] - v1 https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg0601=
7.html
> [2] - v2 https://lore.kernel.org/all/ed23bcbc-fdc4-4492-803c-daa95880375a=
@linaro.org/T/
> [3] - v3 https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg0100=
5.html
> [4] - v4 https://lore.kernel.org/all/20240816010711.3055425-6-debug@rivos=
inc.com/T/
> [5] - v5
> +https://lore.kernel.org/all/20240820000129.3522346-1-debug@rivosinc.com/=
T/#m7b9cc847e739ec86f9569a3ca9f3d9377b01e21
> [6] - v6 https://mail.gnu.org/archive/html/qemu-riscv/2024-08/msg00418.ht=
ml
> [7] - v7 https://lore.kernel.org/all/20240822082504.3979610-1-debug@rivos=
inc.com/
> [8] - v8 https://lore.kernel.org/all/20240823190140.4156920-1-debug@rivos=
inc.com/T/
> [9] - v9 https://lore.kernel.org/all/20240826152949.294506-1-debug@rivosi=
nc.com/
>
> ---
> v10:
>    - Exposed *envcfg CSR and priv to qemu-user as well and removed specia=
l
>      state management for *envcfg related feature enabling for qemu-user
>    - Exposing zicfilp and zicfiss as different patch
> v9:
>    - fix switch case fallthrough for sw_check excp in patch 4
> v8:
>    - fixed up `gen_cmpxchg` to store extra word2 during compile to raise =
storeAMO always
> v7:
>    - Updated decode_save_opc to take extra argument of excp_uw2 and
>      updated callsites
>    - added a helper for promoting load faults to store faults
>    - Removed stale comments and edited existed comments
> v6:
>    - Added support extra store word 2 for tcg compile and extraction duri=
ng unwind
>    - Using extra word, AMO instructions and shadow stack instructions can=
 raise store fault
>    - some alignment and cosmetic changes
>    - added vmstate migration support for elp and ssp cpu state
> v5:
>    - Simplified elp tracking and lpad implementation as per suggestion by=
 richard
>    - Simplified shadow stack mmu checks as per suggestion by richard
>    - Converged zicfiss compressed and non-comressed instructions to same =
translation
>    - Removed trace hooks. Don't need for upstream.
>
> v4:
>    - elp state in cpu is true/false instead of enum and elp cleared
>      unconditionally on trap entry. elp in *status cleared unconditionall=
y on
>      trap return.
>    - Moved logic for branch tracking in instruction translation from tb_s=
tart.
>    - fixed zicfiss dependency on 'A'
>    - `cpu_get_fcfien/bcfien` helpers checks fixed to check for extension =
first.
>    - removed trace hook enums. Instead added dedicated trace helpers wher=
ever needed.
>    - fixed/simplified instruction format in decoder for lpad, sspush, ssp=
opchk
>    - simplified tlb index logic for shadow stack instructions. Removed SU=
M TB_FLAG
>    - access to ssp CSR is gated on `cpu_get_bcfien` instead of duplicated=
 logic
>    - removed vDSO related changes for now.
> v3:
>    - Removed prctl specific patches because they need to be upstream
>      in kernel first.
>    - As suggested by Richard, added TB flag if fcfi enabled
>    - Re-worked translation for landing pad and shadow stack instructions
>      to not require helper.
>    - tcg helpers only for cfi violation cases so that trace hooks can be
>      placed.
>    - Style changes.
>    - fixes assert condition in accel/tcg
>
> v2:
>    - added missed file (in v1) for shadow stack instructions implementati=
on.
>
> Deepak Gupta (21):
>   target/riscv: expose *envcfg csr and priv to qemu-user as well
>   linux-user/riscv: set priv for qemu-user and defaults for *envcfg
>   target/riscv: Add zicfilp extension
>   target/riscv: Introduce elp state and enabling controls for zicfilp
>   target/riscv: save and restore elp state on priv transitions
>   target/riscv: additional code information for sw check
>   target/riscv: tracking indirect branches (fcfi) for zicfilp
>   target/riscv: zicfilp `lpad` impl and branch tracking
>   disas/riscv: enable `lpad` disassembly
>   target/riscv: Expose zicfilp extension as a cpu property
>   target/riscv: Add zicfiss extension
>   target/riscv: introduce ssp and enabling controls for zicfiss
>   target/riscv: tb flag for shadow stack  instructions
>   target/riscv: mmu changes for zicfiss shadow stack protection
>   target/riscv: AMO operations always raise store/AMO fault
>   target/riscv: update `decode_save_opc` to store extra word2
>   target/riscv: implement zicfiss instructions
>   target/riscv: compressed encodings for sspush and sspopchk
>   disas/riscv: enable disassembly for zicfiss instructions
>   disas/riscv: enable disassembly for compressed sspush/sspopchk
>   target/riscv: Expose zicfiss extension as a cpu property
>
>  disas/riscv.c                                 |  77 ++++++++-
>  disas/riscv.h                                 |   4 +
>  linux-user/riscv/cpu_loop.c                   |   4 +
>  target/riscv/cpu.c                            |  10 ++
>  target/riscv/cpu.h                            |  31 +++-
>  target/riscv/cpu_bits.h                       |  17 ++
>  target/riscv/cpu_cfg.h                        |   2 +
>  target/riscv/cpu_helper.c                     | 155 +++++++++++++++++-
>  target/riscv/cpu_user.h                       |   1 +
>  target/riscv/csr.c                            |  84 ++++++++++
>  target/riscv/insn16.decode                    |   4 +
>  target/riscv/insn32.decode                    |  26 ++-
>  .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
>  target/riscv/insn_trans/trans_rva.c.inc       |  43 ++++-
>  target/riscv/insn_trans/trans_rvd.c.inc       |   4 +-
>  target/riscv/insn_trans/trans_rvf.c.inc       |   4 +-
>  target/riscv/insn_trans/trans_rvh.c.inc       |   8 +-
>  target/riscv/insn_trans/trans_rvi.c.inc       |  61 ++++++-
>  target/riscv/insn_trans/trans_rvvk.c.inc      |  10 +-
>  target/riscv/insn_trans/trans_rvzacas.c.inc   |   4 +-
>  target/riscv/insn_trans/trans_rvzfh.c.inc     |   4 +-
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  75 +++++++++
>  target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
>  target/riscv/internals.h                      |   3 +
>  target/riscv/machine.c                        |  38 +++++
>  target/riscv/op_helper.c                      |  18 ++
>  target/riscv/pmp.c                            |   5 +
>  target/riscv/pmp.h                            |   3 +-
>  target/riscv/tcg/tcg-cpu.c                    |  25 +++
>  target/riscv/translate.c                      |  45 ++++-
>  30 files changed, 726 insertions(+), 53 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc
>
> --
> 2.44.0
>
>

