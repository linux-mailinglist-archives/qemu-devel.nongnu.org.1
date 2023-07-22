Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6D75D82E
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 02:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qN0RH-0008EG-RQ; Fri, 21 Jul 2023 20:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaiwenx@rivosinc.com>)
 id 1qN0RB-0008DQ-E6
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 20:25:34 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kaiwenx@rivosinc.com>)
 id 1qN0R8-0004zU-Mu
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 20:25:33 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-48138ef0c3eso923738e0c.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 17:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689985529; x=1690590329; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QPSb4CWTRfIADpPzZqK7YEyQnKkR9xmef6Q52DYxH8=;
 b=nSeTNsirYIYN/8rWwsMQPc+QQHNBE/eBSdOrrZyqZlfmF9DnHunfV/GZC1sc3OmaWe
 FxEjy0hcaTjT5MPbhs4BSOtwRajKPJK8pwn3B81lLQ7azMWYI7cJ+ppKwZ3hVT0H65Eo
 cnsAVQ4z0+81xMjmhI0cuDDgXliUd2AGVQMfx77bgNV9yvoGG2y85+krqkLGCV2A5N0G
 WTFKBMOJz1Ke2rrjwdV/Hi8BPPRr8Vul+GnFtrGNIaUciRVpiuj68c5kgoyo+c353R9F
 G240q7KWLjl7cnCSx3uYCJ4mhG2rCAF9/VJuMMLXIVbgbxi61N6Qw64rSALVZzfw7fPr
 If/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689985529; x=1690590329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QPSb4CWTRfIADpPzZqK7YEyQnKkR9xmef6Q52DYxH8=;
 b=Z0WQPHvRy7TZov0JjcZbLx+fgyHNIgp0snpzb/Yn41S+dsfu2bGMB92RCkEOjhymco
 vHOq4RqufnRrefMmQbp6bFaTlTxcIazjufIQS8fOVJBdkUj7Nct6OR0up5A7D/n84lX9
 WnTaqLYlcI2hKbS+jmhUosWXbEt7RuT7ZQmNicrukGfwdsTb42WWe+MRGYTPKw5U+vDI
 OBIedOTWnqGPCNf4kkBNxFfdL9dIzMAfIqvRktN+kzVRecvg4LaCxisJZXvfBEEH0NKd
 CWlhKjMURGfO3mbGzkgk8V3vTcKrs8h89AnTmwiSMxtHRqZUD4Ob8TAJnb0407UvznNf
 K86w==
X-Gm-Message-State: ABy/qLbOrg1H85Jrj8tcy/0XNTcp9z6s8W1sErTsZh8+3Gq5+wrNwYEA
 GE1p8efqDQL49tLjhfaLKhYmWiHXpvO1pU831YF7AQ==
X-Google-Smtp-Source: APBJJlHNd67StYXhjudvlPQPRdNV6Ho3s+552V4ruiqZvmzyfISBdTy+3tV4D1UiG8NaFhj9Q9RTxcLW5/NAVMLlJIk=
X-Received: by 2002:a1f:d945:0:b0:46e:7158:1cf0 with SMTP id
 q66-20020a1fd945000000b0046e71581cf0mr2082017vkg.10.1689985529206; Fri, 21
 Jul 2023 17:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689631639.git.kaiwenx@rivosinc.com>
 <3ed71e9812a806b98dd519594af52b9525ec459c.1689631639.git.kaiwenx@rivosinc.com>
 <a3ce50f7-0ff7-a646-06ac-36b26e96547c@iscas.ac.cn>
In-Reply-To: <a3ce50f7-0ff7-a646-06ac-36b26e96547c@iscas.ac.cn>
From: Kevin Xue <kaiwenx@rivosinc.com>
Date: Fri, 21 Jul 2023 17:25:18 -0700
Message-ID: <CAOkKhRQk_yso1a1mtFaXBOjOzJtFWnO9Xiq7xNk9Grt+xx4ZXw@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/riscv: Add cycle & instret privilege mode
 filtering support
To: Weiwei Li <liweiwei@iscas.ac.cn>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Atish Kumar Patra <atishp@atishpatra.org>, Kaiwen Xue <kaiwenx@andrew.cmu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=kaiwenx@rivosinc.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 18, 2023 at 6:25=E2=80=AFPM Weiwei Li <liweiwei@iscas.ac.cn> wr=
ote:
>
>
> On 2023/7/19 06:47, Kaiwen Xue wrote:
> > QEMU only calculates dummy cycles and instructions, so there is no
> > actual means to stop the icount in QEMU. Hence this patch merely adds
> > the functionality of accessing the cfg registers, and cause no actual
> > effects on the counting of cycle and instret counters.
> Maybe you can record/accumulate them when privilege mode changes/switchs.

Good idea. Will do in the next version as well.

- Kevin

> >
> > Signed-off-by: Kaiwen Xue <kaiwenx@andrew.cmu.edu>
> > Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> > ---
> >   target/riscv/csr.c | 73 +++++++++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 73 insertions(+)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index ea7585329e..b1d5e85a79 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -218,6 +218,17 @@ static RISCVException sscofpmf(CPURISCVState *env,=
 int csrno)
> >       return RISCV_EXCP_NONE;
> >   }
> >
> > +static RISCVException smcntrpmf(CPURISCVState *env, int csrno)
> > +{
> > +    RISCVCPU *cpu =3D env_archcpu(env);
> > +
> > +    if (!cpu->cfg.ext_smcntrpmf) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> >   static RISCVException any(CPURISCVState *env, int csrno)
> >   {
> >       return RISCV_EXCP_NONE;
> > @@ -800,6 +811,54 @@ static int read_hpmcounterh(CPURISCVState *env, in=
t csrno, target_ulong *val)
> >
> >   #else /* CONFIG_USER_ONLY */
> >
> > +static int read_mcyclecfg(CPURISCVState *env, int csrno, target_ulong =
*val)
> > +{
> > +    *val =3D env->mcyclecfg;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static int write_mcyclecfg(CPURISCVState *env, int csrno, target_ulong=
 val)
> > +{
> > +    env->mcyclecfg =3D val;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static int read_mcyclecfgh(CPURISCVState *env, int csrno, target_ulong=
 *val)
> > +{
> > +    *val =3D env->mcyclecfgh;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static int write_mcyclecfgh(CPURISCVState *env, int csrno, target_ulon=
g val)
> > +{
> > +    env->mcyclecfgh =3D val;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static int read_minstretcfg(CPURISCVState *env, int csrno, target_ulon=
g *val)
> > +{
> > +    *val =3D env->minstretcfg;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static int write_minstretcfg(CPURISCVState *env, int csrno, target_ulo=
ng val)
> > +{
> > +    env->minstretcfg =3D val;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static int read_minstretcfgh(CPURISCVState *env, int csrno, target_ulo=
ng *val)
> > +{
> > +    *val =3D env->minstretcfgh;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static int write_minstretcfgh(CPURISCVState *env, int csrno, target_ul=
ong val)
> > +{
> > +    env->minstretcfgh =3D val;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> >   static int read_mhpmevent(CPURISCVState *env, int csrno, target_ulong=
 *val)
> >   {
> >       int evt_index =3D csrno - CSR_MCOUNTINHIBIT;
> > @@ -4506,6 +4565,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >                                write_mcountinhibit,
> >                                .min_priv_ver =3D PRIV_VERSION_1_11_0   =
    },
> >
> > +    [CSR_MCYCLECFG]      =3D { "mcyclecfg",   smcntrpmf, read_mcyclecf=
g,
> > +                             write_mcyclecfg,
> > +                             .min_priv_ver =3D PRIV_VERSION_1_12_0    =
   },
> > +    [CSR_MINSTRETCFG]    =3D { "minstretcfg", smcntrpmf, read_minstret=
cfg,
> > +                             write_minstretcfg,
> > +                             .min_priv_ver =3D PRIV_VERSION_1_12_0    =
   },
> > +
> >       [CSR_MHPMEVENT3]     =3D { "mhpmevent3",     any,    read_mhpmeve=
nt,
> >                                write_mhpmevent                         =
  },
> >       [CSR_MHPMEVENT4]     =3D { "mhpmevent4",     any,    read_mhpmeve=
nt,
> > @@ -4565,6 +4631,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >       [CSR_MHPMEVENT31]    =3D { "mhpmevent31",    any,    read_mhpmeve=
nt,
> >                                write_mhpmevent                         =
  },
> >
> > +    [CSR_MCYCLECFGH]     =3D { "mcyclecfgh",   smcntrpmf, read_mcyclec=
fgh,
> > +                             write_mcyclecfgh,
> > +                             .min_priv_ver =3D PRIV_VERSION_1_12_0    =
    },
> > +    [CSR_MINSTRETCFGH]   =3D { "minstretcfgh", smcntrpmf, read_minstre=
tcfgh,
> > +                             write_minstretcfgh,
> > +                             .min_priv_ver =3D PRIV_VERSION_1_12_0    =
    },
>
> This two CSRs are RV32-only, they cannot directly share the same
> predicate as MCYCLECFG/MINSTRETCFG.
>
> Regards,
>
> Weiwei Li

Thanks for catching this! Seems sscofpmf also reused the sscofpmf()
predicate for scountovf
and mhpmeventXh. I'll probably turn in another patch for that later on.

- Kevin

>
> > +
> >       [CSR_MHPMEVENT3H]    =3D { "mhpmevent3h",    sscofpmf,  read_mhpm=
eventh,
> >                                write_mhpmeventh,
> >                                .min_priv_ver =3D PRIV_VERSION_1_12_0   =
     },
>

