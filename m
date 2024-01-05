Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7AD825C6B
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 23:15:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLsSh-0000Ql-VB; Fri, 05 Jan 2024 17:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rLsSY-0000Ax-2e
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 17:14:34 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rLsSW-00015m-0j
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 17:14:33 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ccec119587so237151fa.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 14:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704492870; x=1705097670;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxF5owL3IwJ4k46f1zuJ4ym/BlNvKFQiFn3rbdtrI1g=;
 b=m1qqh8Ufouy12SyGXmSUIpX7YSGC/hbD+O27UWkuaCathQafMqTyJJoWGkq4C7WU/M
 lJWm/CvYF+qnhLVfpXDGqd2QtoTJZVgDbKibm7u4kRjGjOeDihS5/RzIDWOBKTuRCQjS
 hqAoaNphNMm2xkg3UkBZH3S6G242qlD0WEGn5dVlWuTeZOce9v6oOMmNrouXY8bJdW/v
 dpbBqYPEYu/MfzzsXsO6/G0dnBhFZBzWoFZLPMETALbit94gyeGMlFwdSODYIZX0SvzE
 PBkFBr44eup3rj4j34KT3uUCsNYr9BBb1/gr7UxNs4ji/EKdlEi4Bio6JluqEPb81lpQ
 RGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704492870; x=1705097670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxF5owL3IwJ4k46f1zuJ4ym/BlNvKFQiFn3rbdtrI1g=;
 b=c8y0Fud0CvOE+CqeBIsQ9MCNx7wqRyJGrOmLEDMPjmqRDcRlWKrgTdGrBJKlBZSTrP
 C9oXtVbm6k46+EECTuxonhNaVca4C5vrIuw0G/yLUuvVV1O9mUv6jOviIx+eF+lbCrDQ
 586KXHU6biD1ROV2W7Mz7sJNLj/Zk/HwgCzYzCwK64t7iY498Hz17F8u2DqXzgkD1/wl
 O0etRNMmJbloz7gvBRX7tXfcddNQkx0UOtGgEFseOMvZH1HgdArkkDc7/jgO5fg+m5vz
 9Nh0d73gZQrDH1tanN9MDBLC64XUKdfI/rp6wFGTBbqhhVXaeqJozfoQ13CXnDxCGWSS
 o8gg==
X-Gm-Message-State: AOJu0YzTOgrEbXoElrlmay53Jdx7o5btB+5RMziEMwyVA08AnJxtKZX2
 s6ZYBS/p6SJqQ2rQoeXtfxBo4vxcveN5ErU9ZvRPf+c+V9fQNA==
X-Google-Smtp-Source: AGHT+IHT5tNOlByZEJLkSH14QSBCIUbTg7le5bGHBneJtYJsXIhH//6cUtaLo6z+TcXr8fijNCwQiLXduFrVy9k/n9U=
X-Received: by 2002:a2e:804d:0:b0:2cd:1d5d:322e with SMTP id
 p13-20020a2e804d000000b002cd1d5d322emr24071ljg.10.1704492870188; Fri, 05 Jan
 2024 14:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20231229004929.3842055-1-atishp@rivosinc.com>
 <20231229004929.3842055-4-atishp@rivosinc.com>
 <CAKmqyKP9cYeiw83qY2GbrRquDi5_rSvCKbAmoxi91MfgHCfL6Q@mail.gmail.com>
In-Reply-To: <CAKmqyKP9cYeiw83qY2GbrRquDi5_rSvCKbAmoxi91MfgHCfL6Q@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 5 Jan 2024 14:14:19 -0800
Message-ID: <CAHBxVyEGuEYh8O2EOFUy6802LSwWrW=V4agJoKYmj+fV_aVFYw@mail.gmail.com>
Subject: Re: [v2 3/5] target/riscv: Add cycle & instret privilege mode
 filtering definitions
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=atishp@rivosinc.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jan 4, 2024 at 6:46=E2=80=AFPM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Fri, Dec 29, 2023 at 12:08=E2=80=AFPM Atish Patra <atishp@rivosinc.com=
> wrote:
> >
> > From: Kaiwen Xue <kaiwenx@rivosinc.com>
> >
> > This adds the definitions for ISA extension smcntrpmf.
> >
> > Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  target/riscv/cpu.c      |  1 -
> >  target/riscv/cpu.h      |  6 ++++++
> >  target/riscv/cpu_bits.h | 29 +++++++++++++++++++++++++++++
> >  3 files changed, 35 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index da3f05cd5373..54395f95b299 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -1297,7 +1297,6 @@ const char *riscv_get_misa_ext_description(uint32=
_t bit)
> >  const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =3D {
> >      /* Defaults for standard extensions */
> >      MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
> > -    DEFINE_PROP_BOOL("smcntrpmf", RISCVCPU, cfg.ext_smcntrpmf, false),
>
> Can you explain why you are removing this in the commit message?
>

That is just a rebasing error I overlooked at first attempt. I fixed
it and sent a v3. Sorry for the confusion.

> Alistair
>
> >      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
> >      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
> >      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index d74b361be641..34617c4c4bab 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -319,6 +319,12 @@ struct CPUArchState {
> >
> >      target_ulong mcountinhibit;
> >
> > +    /* PMU cycle & instret privilege mode filtering */
> > +    target_ulong mcyclecfg;
> > +    target_ulong mcyclecfgh;
> > +    target_ulong minstretcfg;
> > +    target_ulong minstretcfgh;
> > +
> >      /* PMU counter state */
> >      PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
> >
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index ebd7917d490a..0ee91e502e8f 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -401,6 +401,10 @@
> >  /* Machine counter-inhibit register */
> >  #define CSR_MCOUNTINHIBIT   0x320
> >
> > +/* Machine counter configuration registers */
> > +#define CSR_MCYCLECFG       0x321
> > +#define CSR_MINSTRETCFG     0x322
> > +
> >  #define CSR_MHPMEVENT3      0x323
> >  #define CSR_MHPMEVENT4      0x324
> >  #define CSR_MHPMEVENT5      0x325
> > @@ -431,6 +435,9 @@
> >  #define CSR_MHPMEVENT30     0x33e
> >  #define CSR_MHPMEVENT31     0x33f
> >
> > +#define CSR_MCYCLECFGH      0x721
> > +#define CSR_MINSTRETCFGH    0x722
> > +
> >  #define CSR_MHPMEVENT3H     0x723
> >  #define CSR_MHPMEVENT4H     0x724
> >  #define CSR_MHPMEVENT5H     0x725
> > @@ -885,6 +892,28 @@ typedef enum RISCVException {
> >  /* PMU related bits */
> >  #define MIE_LCOFIE                         (1 << IRQ_PMU_OVF)
> >
> > +#define MCYCLECFG_BIT_MINH                 BIT_ULL(62)
> > +#define MCYCLECFGH_BIT_MINH                BIT(30)
> > +#define MCYCLECFG_BIT_SINH                 BIT_ULL(61)
> > +#define MCYCLECFGH_BIT_SINH                BIT(29)
> > +#define MCYCLECFG_BIT_UINH                 BIT_ULL(60)
> > +#define MCYCLECFGH_BIT_UINH                BIT(28)
> > +#define MCYCLECFG_BIT_VSINH                BIT_ULL(59)
> > +#define MCYCLECFGH_BIT_VSINH               BIT(27)
> > +#define MCYCLECFG_BIT_VUINH                BIT_ULL(58)
> > +#define MCYCLECFGH_BIT_VUINH               BIT(26)
> > +
> > +#define MINSTRETCFG_BIT_MINH               BIT_ULL(62)
> > +#define MINSTRETCFGH_BIT_MINH              BIT(30)
> > +#define MINSTRETCFG_BIT_SINH               BIT_ULL(61)
> > +#define MINSTRETCFGH_BIT_SINH              BIT(29)
> > +#define MINSTRETCFG_BIT_UINH               BIT_ULL(60)
> > +#define MINSTRETCFGH_BIT_UINH              BIT(28)
> > +#define MINSTRETCFG_BIT_VSINH              BIT_ULL(59)
> > +#define MINSTRETCFGH_BIT_VSINH             BIT(27)
> > +#define MINSTRETCFG_BIT_VUINH              BIT_ULL(58)
> > +#define MINSTRETCFGH_BIT_VUINH             BIT(26)
> > +
> >  #define MHPMEVENT_BIT_OF                   BIT_ULL(63)
> >  #define MHPMEVENTH_BIT_OF                  BIT(31)
> >  #define MHPMEVENT_BIT_MINH                 BIT_ULL(62)
> > --
> > 2.34.1
> >
> >

