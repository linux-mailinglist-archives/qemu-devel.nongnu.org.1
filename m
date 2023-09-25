Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D057AD24F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 09:49:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkgKh-00037H-BE; Mon, 25 Sep 2023 03:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qkgKc-00036a-50
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 03:48:39 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qkgKa-0006IN-JZ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 03:48:37 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-45269fe9d6bso2443694137.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 00:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695628115; x=1696232915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ns556nGWeROzcHpNUUqxQir3WMfmjPXAuwsfnLYZEUI=;
 b=AKH2JissRmmVBv65GvV4a0BKS3AhZ1t1iJMtcurHE5elrUsl/6BTePnX1c8M8VIGdT
 elEZPUPULJmS2979WTp3d4wa7QJJoHZfdsz9vMxbYJWsMK1gLJ/bSmTiy27qei4A6BO8
 zLU6bBcksch0akbsvzdsOAqVOxdLRp2vLOLcHSSThuXU1xZOMwaZz16U5nUvKpXnqL/a
 EEw4MyH1ceXzAyWLF8MfPf47kG8Uqfq0UPsYFE70+VO4TWyPpcmHeaMA3S92f0WBj3my
 aEFK0zHCQIGS2+R7JD7R+gn2miFz+gWbhnX2XhwZAdL91k+eXAQXUUNqyM/gNN3xJppR
 03xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695628115; x=1696232915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ns556nGWeROzcHpNUUqxQir3WMfmjPXAuwsfnLYZEUI=;
 b=Ifj51pjy17BeXmhPhaWnmWTDwx10kUlM5jR0/OeSd029VHFWgb+5qpz7oJkG9J1IIj
 Ebe1G181eeaZjvhYchFET43ckVYYMXVVpLPuzND/fTL8j53GuM56WbhZswhO0v0XFPam
 5q2kwIlztBYWgCppolG+Gmu9RzRzrqbOMSy7Bi/8hDSOvK+vm0cQsYZOFV+G2LwT4hb2
 IF15uVC83HZe1EDA6iivYV/wI/oTio8/cmk/Rb0e+tofGGdBcHA61nr3C4d2Ngq9Ivli
 muLtMuLib+H1BrUGM/z/rztRRHtasYDl5camZrr1aeO/I0AR3hiKXTKHh1f6TBxj+jGf
 drhg==
X-Gm-Message-State: AOJu0YxcsgakRzKUGGXjsEYSV93fFLXCe24lyUWV9AFFrLIkOlPpZAS1
 hrN06itd9SXvYGK+iGjVFUHqUDh4hryOYDB60v0RqA==
X-Google-Smtp-Source: AGHT+IETk5McJL4iuuznvbW6ici95N5VEsFu5MdrXBmNZdzwfkrh4KoOdTgnnrkgE/hpSa6X97rNd8l+Hhyz+7nlsJQ=
X-Received: by 2002:a67:fc48:0:b0:44d:6256:ac8b with SMTP id
 p8-20020a67fc48000000b0044d6256ac8bmr3427820vsq.4.1695628115321; Mon, 25 Sep
 2023 00:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230914101751.772576-1-mchitale@ventanamicro.com>
 <CAKmqyKNv+Wk6duL4Ww1QiC30O-W7kyypdd+kh3tjKDzFOy0Ybg@mail.gmail.com>
In-Reply-To: <CAKmqyKNv+Wk6duL4Ww1QiC30O-W7kyypdd+kh3tjKDzFOy0Ybg@mail.gmail.com>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Mon, 25 Sep 2023 13:17:59 +0530
Message-ID: <CAN37VV7AvDk3JtdNDEdTStpTevGrhXYSMScvZKREdZWnKhsz+A@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: pmp: Ignore writes when RW=01
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=mchitale@ventanamicro.com; helo=mail-vs1-xe35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Sep 18, 2023 at 7:02=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Thu, Sep 14, 2023 at 10:35=E2=80=AFPM Mayuresh Chitale
> <mchitale@ventanamicro.com> wrote:
> >
> > As per the Priv spec: "The R, W, and X fields form a collective WARL
> > field for which the combinations with R=3D0 and W=3D1 are reserved."
> > However currently such writes are not ignored as ought to be. The
> > combinations with RW=3D01 are allowed only when the Smepmp extension
> > is enabled and mseccfg.MML is set.
> >
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > ---
> >  target/riscv/pmp.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index f3eb6e6585..5b430be18c 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -119,6 +119,14 @@ static bool pmp_write_cfg(CPURISCVState *env, uint=
32_t pmp_index, uint8_t val)
> >          if (locked) {
> >              qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - lo=
cked\n");
> >          } else if (env->pmp_state.pmp[pmp_index].cfg_reg !=3D val) {
> > +            /* If !mseccfg.MML then ignore writes with encoding RW=3D0=
1 */
> > +            if ((val & PMP_WRITE) && !(val & PMP_READ) &&
> > +                (!riscv_cpu_cfg(env)->ext_smepmp ||
> > +                !MSECCFG_MML_ISSET(env))) {
>
> MSECCFG_MML can only be set if ext_smepmp exists, so I don't think we
> need both checks here
Ok.
>
> > +                val &=3D ~(PMP_WRITE | PMP_READ);
> > +                val |=3D env->pmp_state.pmp[pmp_index].cfg_reg &
> > +                       (PMP_WRITE | PMP_READ);
>
> Why do we restore the previous value? It's a WARL so we should just
> guarantee a legal value (which would be 0x0 I guess)
Yes. It can be set to 0x0.
>
> Alistair
>
> > +            }
> >              env->pmp_state.pmp[pmp_index].cfg_reg =3D val;
> >              pmp_update_rule_addr(env, pmp_index);
> >              return true;
> > --
> > 2.34.1
> >
> >

