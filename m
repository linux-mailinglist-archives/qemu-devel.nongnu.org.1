Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C2370783B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 04:49:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzTht-0001TZ-1B; Wed, 17 May 2023 22:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1pzThq-0001T0-Uu
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:49:30 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1pzThp-0000Vq-D7
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:49:30 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-623802d9bfdso11141336d6.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 19:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684378168; x=1686970168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBiYU3X0LxCc5gBu85kfHUp7ZMB7Axiw4k2XXatVVQY=;
 b=hcveBapPBvRI3aeYrgzC9A0qehPog5szRH0cIZ6hyDGvZWlJe6z9u9ufnvkEqZQqWI
 qRdilruTFtWn3rlYUEy57zXsGcqL35EcgjQn0WXysISY57bfW3D0VFLTFnXH4KTq75rQ
 l2ijq4Bljtzmj/fD/2KEq7zAk9eq72h4++Ew5/iXzKPPY8EBG+/S3J5svTDS/medxBR2
 GBQMGwvTaVJWIv0ibxJT3bfeTRRnzysvirH8Bu9RpNnITiF0KKCf+yyd6X8ZZZ2i87PU
 cbjQb1Skz6ASneyBW0XDg+ItvokOPLHiCtWqwjQOxRvNpi6CuRiAgIMqLcYtYt84knr9
 cixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684378168; x=1686970168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HBiYU3X0LxCc5gBu85kfHUp7ZMB7Axiw4k2XXatVVQY=;
 b=G04JMZLsIIA+O2l+/ydVjXnhSrE8xrGBXwyEP555Nu9zaHAOuRE0ZqwtqYuk9y05BM
 c90cFxBHqsqqIfYRAB/PSp0xh6Fodwz7znetdnFsWuJTEwLM41xZvyMOQVP/j1Kp+eNC
 IiXkTVjhwtXqJ1FrRMMJaGSxa2F2KN7lSPBbeoL0j2y/igEN1Jz4C+9Eg/H5Vc/t+A6V
 N9jpUvCBr2wNpO+N3uWHtm2xK+Ut+dq+DL9mNB8S5aLDFg0Ai+lgkXj64BV3PMjj+2Ko
 RZhy7cfAJPupnlQczt6JNd9gf6ZBqE2F8iI8EpXTjapzwPvO+Nb+sRIZL5evfeMo6bLM
 NNMg==
X-Gm-Message-State: AC+VfDx9VzDIwJQTUjRSMloewlWbIp5I78NYo20eoRZ+t6lgHabR77vq
 +yyEnDYjtHAkhpIPDFgFlaQsWzRNLIvm9+yNHv1Ytw==
X-Google-Smtp-Source: ACHHUZ7nC9xmUrcj3JbxM1W947C1x95JlpdnJDwlCqstb7WK43Ss5oXWv4FOHwis00JvlTGMBbJDbQCU23bIDDODcfw=
X-Received: by 2002:a05:6214:20ec:b0:621:331b:f55d with SMTP id
 12-20020a05621420ec00b00621331bf55dmr2516253qvk.19.1684378168049; Wed, 17 May
 2023 19:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230501140020.3667219-1-mchitale@ventanamicro.com>
 <20230501140020.3667219-2-mchitale@ventanamicro.com>
 <CAKmqyKN9vAAtXtRaUN3_im5k8kO+GoJ-V1mFbJPniSEdeswLnw@mail.gmail.com>
In-Reply-To: <CAKmqyKN9vAAtXtRaUN3_im5k8kO+GoJ-V1mFbJPniSEdeswLnw@mail.gmail.com>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Thu, 18 May 2023 08:18:51 +0530
Message-ID: <CAN37VV6Ms0hs_vAAr0n-P8chb-77jhQTQrv0qjBLKXiuBiDA_Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] target/riscv: smstateen check for fcsr
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 Daniel Barboza <dbarboza@ventanamicro.com>, liweiwei@iscas.ac.cn, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=mchitale@ventanamicro.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, May 17, 2023 at 8:42=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Tue, May 2, 2023 at 12:00=E2=80=AFAM Mayuresh Chitale
> <mchitale@ventanamicro.com> wrote:
> >
> > If smstateen is implemented and smtateen0.fcsr is clear and misa.F
> > is off then the floating point operations must return illegal
> > instruction exception or virtual instruction trap, if relevant.
>
> Do you mind re-wording this commit message? I can't get my head around
> it. You talk about returning an illegal instruction exception, but
> most of this patch is just adding SMSTATEEN0_FCSR to the write mask if
> floating point is disabled.
>
Sure. The generic code for access check was added in a previous patch.
> It looks to me like you are returning an exception trying to access a
> floating pointer register if FP is off and SMSTATEEN0_FCSR is not set
> (which you describe) but also then only allow changing SMSTATEEN0_FCSR
> if the RVF is not enabled, which is where I'm confused.
The smstateen0.fcsr bit is writable only when misa.F =3D=3D 0.

>
> Your patch seems to be correct, I think the commit message and title
> just needs a small tweak. Maybe something like this:
>
> ```
> target/riscv: smstateen add support for fcsr bit
>
> If smstateen is implemented and SMSTATEEN0.FCSR is zero floating point
> CSR access should raise an illegal instruction exception or virtual
> equivalent as required.
>
> We also allow the guest to set/unset the FCSR bit, but only if misa.F
> =3D=3D 0, as defined in the spec.

How about:

target/riscv: smstateen check for fcsr

Implement the s/h/mstateen.fcsr bit as as defined in the smstateen spec
and check for it when accessing the fcsr register and its fields.

> ```
>
> Alistair
>
> >
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
> > ---
> >  target/riscv/csr.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 4451bd1263..3f6b824bd2 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -82,6 +82,10 @@ static RISCVException fs(CPURISCVState *env, int csr=
no)
> >          !riscv_cpu_cfg(env)->ext_zfinx) {
> >          return RISCV_EXCP_ILLEGAL_INST;
> >      }
> > +
> > +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
> > +        return smstateen_acc_ok(env, 0, SMSTATEEN0_FCSR);
> > +    }
> >  #endif
> >      return RISCV_EXCP_NONE;
> >  }
> > @@ -2100,6 +2104,9 @@ static RISCVException write_mstateen0(CPURISCVSta=
te *env, int csrno,
> >                                        target_ulong new_val)
> >  {
> >      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
> > +    if (!riscv_has_ext(env, RVF)) {
> > +        wr_mask |=3D SMSTATEEN0_FCSR;
> > +    }
> >
> >      return write_mstateen(env, csrno, wr_mask, new_val);
> >  }
> > @@ -2173,6 +2180,10 @@ static RISCVException write_hstateen0(CPURISCVSt=
ate *env, int csrno,
> >  {
> >      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
> >
> > +    if (!riscv_has_ext(env, RVF)) {
> > +        wr_mask |=3D SMSTATEEN0_FCSR;
> > +    }
> > +
> >      return write_hstateen(env, csrno, wr_mask, new_val);
> >  }
> >
> > @@ -2259,6 +2270,10 @@ static RISCVException write_sstateen0(CPURISCVSt=
ate *env, int csrno,
> >  {
> >      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
> >
> > +    if (!riscv_has_ext(env, RVF)) {
> > +        wr_mask |=3D SMSTATEEN0_FCSR;
> > +    }
> > +
> >      return write_sstateen(env, csrno, wr_mask, new_val);
> >  }
> >
> > --
> > 2.34.1
> >

