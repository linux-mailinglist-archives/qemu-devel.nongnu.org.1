Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B647F3DC9
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 06:54:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5gAy-0003SK-4R; Wed, 22 Nov 2023 00:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5gAv-0003RX-BK
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:53:25 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5gAt-0001iZ-Om
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:53:25 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4ac459d7962so314424e0c.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 21:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700632401; x=1701237201; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kGU2jaQlbXN6H8AvZLt2vy+jNCe1ZHgV38BHpigRc/c=;
 b=dg1CZgQN2o/ZiXEeHIxcFFPHHYPr1XrjSngTWaNPO6ZppcItMai9jgEUUKhA8UPxwM
 Y/RQwgDEs14hgRNfx5+0Eg+T9DfJoJgrybu6vU5Gyj4qFXXYdfTghTFzlXx4Dr3YAcwb
 BPMDNoVS4pIfD7TJ05zFQzjwNibK4J3g9pwiBfWYBAalDhCNYpg1Op6xdzUc0BZYB5Yu
 CepZxdvpeSFf6D3ypq3MN+qGEPJMMbSU7c6lUU1LiPnR29rtt6uzP7+TDKXcrl8EsqFW
 4bT330zsqdAD1GvY7JcP9PVqmz8Co1Jp+f+fcz9H5ihZ09ht48W78gs4LfX/7h/s+TTd
 vYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700632401; x=1701237201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kGU2jaQlbXN6H8AvZLt2vy+jNCe1ZHgV38BHpigRc/c=;
 b=I1PJPVcYU65BrOqmw7IjuZyPDwocULCgSwncVcSSUDJN4FhUyK0XMQ6glSVHzSh9em
 j0YcZxmnjBj+nlQ5JTpt9C672KgvQticFJ48zZ/M7VclVEVSgcymeZlvcqOaVbIW7SU8
 7jze/wBOpdCrn72UdpmHnZ0RoHlz+tcKS1s5YnwzGIEWkdzgTtO2O0gACaGdgmcM8B7t
 tjAY30eSyEbZg3VEEQKUKU+KARZIOAATbiJtfYGOVjfqjE/K4hjEFo7DgzBB6A5V5B80
 wx//1JTRXFnCDVK29Uv66s2jRAn495i2EWa9lie0+Yk9Ok1BfEWBUScEax9dKU0VNgvW
 zsHg==
X-Gm-Message-State: AOJu0YxnliI8HbG4cdPlXOMP2r3CwJZccgu4CcxawnvJZuvx9F6zUlWd
 Q5p0IK2QFBMMLDQ6EmiGcpN4e2XF+MtVeA2K9jM=
X-Google-Smtp-Source: AGHT+IGe4K2pz3U578gNGts7C1qMj0q28WGktqlF6ztZrlusigUIy497ON+uNK2l5TLf4+AGR7GVJw2jkJwWxMAycw4=
X-Received: by 2002:a1f:dd81:0:b0:49a:b9ed:8c19 with SMTP id
 u123-20020a1fdd81000000b0049ab9ed8c19mr1572493vkg.7.1700632401662; Tue, 21
 Nov 2023 21:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
 <20231107022946.1055027-47-alistair.francis@wdc.com>
 <CAFEAcA_DrOBcQytM+UkMNEFFgEhOYqbKnnSREhRY+UsEwD+RbQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_DrOBcQytM+UkMNEFFgEhOYqbKnnSREhRY+UsEwD+RbQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Nov 2023 15:52:53 +1000
Message-ID: <CAKmqyKM5KveGNhssivh73W8wRYr2j-Acx_P9+Vf1ZqMKZsakoA@mail.gmail.com>
Subject: Re: [PULL 46/49] target/riscv: Don't assume PMU counters are
 continuous
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Rob Bradford <rbradford@rivosinc.com>, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Fri, Nov 10, 2023 at 1:24=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 7 Nov 2023 at 02:36, Alistair Francis <alistair23@gmail.com> wrot=
e:
> >
> > From: Rob Bradford <rbradford@rivosinc.com>
> >
> > Check the PMU available bitmask when checking if a counter is valid
> > rather than comparing the index against the number of PMUs.
> >
> > Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> > Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> > Message-ID: <20231031154000.18134-3-rbradford@rivosinc.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/csr.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index fc26b52c88..fde7ce1a53 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -188,7 +188,8 @@ static RISCVException zcmt(CPURISCVState *env, int =
csrno)
> >  #if !defined(CONFIG_USER_ONLY)
> >  static RISCVException mctr(CPURISCVState *env, int csrno)
> >  {
> > -    int pmu_num =3D riscv_cpu_cfg(env)->pmu_num;
> > +    RISCVCPU *cpu =3D env_archcpu(env);
> > +    uint32_t pmu_avail_ctrs =3D cpu->pmu_avail_ctrs;
> >      int ctr_index;
> >      int base_csrno =3D CSR_MHPMCOUNTER3;
> >
> > @@ -197,7 +198,7 @@ static RISCVException mctr(CPURISCVState *env, int =
csrno)
> >          base_csrno +=3D 0x80;
> >      }
> >      ctr_index =3D csrno - base_csrno;
> > -    if (!pmu_num || ctr_index >=3D pmu_num) {
> > +    if ((BIT(ctr_index) & pmu_avail_ctrs >> 3) =3D=3D 0) {
> >          /* The PMU is not enabled or counter is out of range */
> >          return RISCV_EXCP_ILLEGAL_INST;
> >      }
>
> Hi; Coverity is not convinced that ctr_index is necessarily
> guaranteed to be within the valid range to be an argument
> to BIT() (eg that it won't be negative). Looking at the
> code as a human I'm pretty unsure too. Could somebody have
> a look at this and maybe improve the readability / add an
> assertion / fix a bug if any ? (CID 1523910)

The code looks ok to me. I have a patch to add an assert to keep Coverity h=
appy.

>
> More generally there are about half a dozen other riscv
> issues in Coverity at the moment, so if somebody who knows
> the riscv code could have a look at them that would be great.

I am happy to look at it. I didn't realise we could all see the
Coverity data. I just requested permission to see the results

Alistair

>
> thanks
> -- PMM

