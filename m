Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C99579A174
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 04:39:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfWok-0000nr-IT; Sun, 10 Sep 2023 22:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfWoh-0000ne-35
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 22:38:23 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfWoe-0004ZF-KZ
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 22:38:22 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-44ee7688829so1022044137.2
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 19:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694399899; x=1695004699; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLHtj5vxq1csxzgxaV8qxqWoBPIAtIPg2FAwyhuQnmw=;
 b=QSfSNpNMN9URcnguDhFgW7VxqrhEAaxS0zTnM/iQR9Rz11Fmyak8yfnA+rYoSg4tRf
 TJOZWS5df7NcKqjjCVXv8ZMCP2rNL7gSStNCLir0nDkQ2vSFQTbDG7RWVz+cKBDoDAU8
 Ohqr76VSXkRSe7A8PZWNz6l61oXGIdov0NM/L357xaNORDv735Z1bzhJBO7cSrggZ31n
 oeiFYk4+tg6VisXIuNfnNA+cKiIEKo82pMzCJsOqs74b1YItFHkDa5pTdq3bGU1RNCP0
 4W9b98m/8KsUSgFV+HIz+wJuxDZ3vKXztZxUu7yudQ8CzSXTDrS8lzOKLKyZzP32LZF0
 Kekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694399899; x=1695004699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLHtj5vxq1csxzgxaV8qxqWoBPIAtIPg2FAwyhuQnmw=;
 b=gR6EdXecp63F1ttfx/mf4Ov3cCCK9ZzRH9txTzSQwY6jWLx4PdwNHRPhChwyUFzlgC
 chPLfCcxAtm2APojNpTTYjgw5724rgWSYhufPj2htyh5/RCodICpp4hl+3I93yTl9fs+
 mh+e+8lBXL64JEFKCt+MKcY3waNb9uvV8zS0JqXXW7eQHETwxiF4Pmkjnd9uWVsqRq5J
 a4ygXaia5f8QU5CKNVQe4QS+XnYYKO6Edau6fAZJau+AOTyMHyJplihKITHf9rVgIzoS
 IOpobNSIV6PD0R3N2OPClmWE2cAaz1ACZh5XQoSKPyPOgaWZa7CZPeqq5PFOeou85XmL
 eUqA==
X-Gm-Message-State: AOJu0YzLKXABK5GZPJzZAzec7VMomFDJ8JiT6aFoN5Rkqo4TljFCnYNK
 teG+bFTo8KNQSF5BxGxHQqylI9Vyt7uf/E+DccFNP/npoKPVrg==
X-Google-Smtp-Source: AGHT+IElce4V1tzBrM5kp29WcWfpSfvHMsg3/IqTZx1IzoTxP6VvgIumnU/I3k1hCUKAZXKAY5vhx9Ia8OeTF0RkTpI=
X-Received: by 2002:a67:ff87:0:b0:44e:9a71:27a1 with SMTP id
 v7-20020a67ff87000000b0044e9a7127a1mr4410727vsq.17.1694399899384; Sun, 10 Sep
 2023 19:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
 <f47bf3d0-8856-1c15-9534-8f4be297d7c2@tls.msk.ru>
In-Reply-To: <f47bf3d0-8856-1c15-9534-8f4be297d7c2@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 11 Sep 2023 12:37:52 +1000
Message-ID: <CAKmqyKM2shwk=rK4dWr4j=yeNxwuQ8mwDtqzRAgrCVB6iiohVA@mail.gmail.com>
Subject: Re: [PULL 00/65] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Sep 8, 2023 at 4:38=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 08.09.2023 09:03, Alistair Francis wrote:
>
> > Akihiko Odaki (1):
> >        target/riscv: Allocate itrigger timers only once
> >
> > Ard Biesheuvel (2):
> >        target/riscv: Use existing lookup tables for MixColumns
> >        target/riscv: Use accelerated helper for AES64KS1I
> >
> > Conor Dooley (1):
> >        hw/riscv: virt: Fix riscv,pmu DT node path
> >
> > Daniel Henrique Barboza (26):
> >        target/riscv/cpu.c: do not run 'host' CPU with TCG
> >        target/riscv/cpu.c: add zmmul isa string
> >        target/riscv/cpu.c: add smepmp isa string
> >        target/riscv: fix satp_mode_finalize() when satp_mode.supported =
=3D 0
> >        hw/riscv/virt.c: fix non-KVM --enable-debug build
> >        hw/intc/riscv_aplic.c fix non-KVM --enable-debug build
> >        target/riscv/cpu.c: split CPU options from riscv_cpu_extensions[=
]
> >        target/riscv/cpu.c: skip 'bool' check when filtering KVM props
> >        target/riscv/cpu.c: split kvm prop handling to its own helper
> >        target/riscv: add DEFINE_PROP_END_OF_LIST() to riscv_cpu_options=
[]
> >        target/riscv/cpu.c: split non-ratified exts from riscv_cpu_exten=
sions[]
> >        target/riscv/cpu.c: split vendor exts from riscv_cpu_extensions[=
]
> >        target/riscv/cpu.c: add riscv_cpu_add_qdev_prop_array()
> >        target/riscv/cpu.c: add riscv_cpu_add_kvm_unavail_prop_array()
> >        target/riscv/cpu.c: limit cfg->vext_spec log message
> >        target/riscv: add 'max' CPU type
> >        avocado, risc-v: add tuxboot tests for 'max' CPU
> >        target/riscv: deprecate the 'any' CPU type
> >        target/riscv/cpu.c: use offset in isa_ext_is_enabled/update_enab=
led
> >        target/riscv: make CPUCFG() macro public
> >        target/riscv/cpu.c: introduce cpu_cfg_ext_auto_update()
> >        target/riscv/cpu.c: use cpu_cfg_ext_auto_update() during realize=
()
> >        target/riscv/cpu.c: introduce RISCVCPUMultiExtConfig
> >        target/riscv: use isa_ext_update_enabled() in init_max_cpu_exten=
sions()
> >        target/riscv/cpu.c: honor user choice in cpu_cfg_ext_auto_update=
()
> >        target/riscv/cpu.c: consider user option with RVG
> >
> > Dickon Hood (2):
> >        target/riscv: Refactor translation of vector-widening instructio=
n
> >        target/riscv: Add Zvbb ISA extension support
> >
> > Jason Chien (3):
> >        target/riscv: Add Zihintntl extension ISA string to DTS
> >        hw/intc: Fix upper/lower mtime write calculation
> >        hw/intc: Make rtc variable names consistent
> >
> > Kiran Ostrolenk (4):
> >        target/riscv: Refactor some of the generic vector functionality
> >        target/riscv: Refactor vector-vector translation macro
> >        target/riscv: Refactor some of the generic vector functionality
> >        target/riscv: Add Zvknh ISA extension support
> >
> > LIU Zhiwei (3):
> >        target/riscv: Fix page_check_range use in fault-only-first
> >        target/riscv: Fix zfa fleq.d and fltq.d
> >        linux-user/riscv: Use abi type for target_ucontext
> >
> > Lawrence Hunter (2):
> >        target/riscv: Add Zvbc ISA extension support
> >        target/riscv: Add Zvksh ISA extension support
> >
> > Leon Schuermann (1):
> >        target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes
> >
> > Max Chou (3):
> >        crypto: Create sm4_subword
> >        crypto: Add SM4 constant parameter CK
> >        target/riscv: Add Zvksed ISA extension support
> >
> > Nazar Kazakov (4):
> >        target/riscv: Remove redundant "cpu_vl =3D=3D 0" checks
> >        target/riscv: Move vector translation checks
> >        target/riscv: Add Zvkned ISA extension support
> >        target/riscv: Add Zvkg ISA extension support
> >
> > Nikita Shubin (1):
> >        target/riscv: don't read CSR in riscv_csrrw_do64
> >
> > Rob Bradford (1):
> >        target/riscv: Implement WARL behaviour for mcountinhibit/mcounte=
ren
> >
> > Robbin Ehn (1):
> >        linux-user/riscv: Add new extensions to hwprobe
> >
> > Thomas Huth (2):
> >        hw/char/riscv_htif: Fix printing of console characters on big en=
dian hosts
> >        hw/char/riscv_htif: Fix the console syscall on big endian hosts
> >
> > Tommy Wu (1):
> >        target/riscv: Align the AIA model to v1.0 ratified spec
> >
> > Vineet Gupta (1):
> >        riscv: zicond: make non-experimental
> >
> > Weiwei Li (1):
> >        target/riscv: Update CSR bits name for svadu extension
> >
> > Yong-Xuan Wang (5):
> >        target/riscv: support the AIA device emulation with KVM enabled
> >        target/riscv: check the in-kernel irqchip support
> >        target/riscv: Create an KVM AIA irqchip
> >        target/riscv: update APLIC and IMSIC to support KVM AIA
> >        target/riscv: select KVM AIA in riscv virt machine
>
>  From the above, it looks like the following are candidates for -stable:
>
>   02/65 hw/char/riscv_htif: Fix printing of console characters on big end=
ian hosts
>   06/65 target/riscv: Fix page_check_range use in fault-only-first
>   25/65 target/riscv: Fix zfa fleq.d and fltq.d
>   26/65 hw/intc: Fix upper/lower mtime write calculation
>   27/65 hw/intc: Make rtc variable names consistent
>     (not really necessary but completes the previous change)
>   28/65 linux-user/riscv: Use abi type for target_ucontext
>   34/65 hw/riscv: virt: Fix riscv,pmu DT node path
>   36/65 target/riscv: fix satp_mode_finalize() when satp_mode.supported =
=3D 0
>
> Also maybe:
>
>   38/65 hw/riscv/virt.c: fix non-KVM --enable-debug build
>   39/65 hw/intc/riscv_aplic.c fix non-KVM --enable-debug build
>
> Please let me know if either something from the above list should not
> be pickled up for stable, or something else should be added there.

I think those are all good candidates for including. I would also add:

  target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes

Alistair

>
> Thank you!
>
> /mjt

