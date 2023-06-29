Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9E7742137
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 09:43:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmIa-0001bI-1w; Thu, 29 Jun 2023 03:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEmIR-0001Yc-JL; Thu, 29 Jun 2023 03:42:31 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEmIP-0005yY-ID; Thu, 29 Jun 2023 03:42:31 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7659cb9c42aso36163185a.3; 
 Thu, 29 Jun 2023 00:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688024548; x=1690616548;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hENbJN+5D57rjjW7QYoX5iqYqGP/u+O6RqjjBRku6sQ=;
 b=Evbprto3HXkqhcv5Jtb1HUVKsWXjFlMJfKfT7oOhmFdUpF4GkFKPZ0MHl129+J/3xe
 pAhAoNLKUzCZRp9kLjnjOcZWWwm/uFzyPNyWPmg2M5kqojPTCbAy6QJMEn5DSa+D8jnF
 u13wzTKLBFBF/bn1S9v1K4dVwtW3Mrp5Uews8BqZCEqjZRcDiUDbowSrz1LgyYtw0jBa
 i9IZ8ZaVTtCJoyDX18Yt6V2esE4D3bh2DdQPMINu0DAq1Obb4CDmabIVDhYcwpjFRL/C
 T3jTd/kke/whrj1ZK5uun7v3lTP7WlhTboSFfZ4ysde3aI+jgvk1FHdq+nvA11/02TEQ
 yRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688024548; x=1690616548;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hENbJN+5D57rjjW7QYoX5iqYqGP/u+O6RqjjBRku6sQ=;
 b=loazbN+OLUQ3MGqK/SwpfVVSs7/ZpGoUxKToLimekiYnwSAcXT4hNEMmqin05vvqkN
 O7/PxbMLn/a04mJWrXLI/cGpdh/vxl7tV+wHWE82yL7bjQcajawBv6yjk5T4wOlBwn+F
 RqdPDP9qqBY1vcBVPwWLIQmArPaKRqKXsN+Ma0pvvncRlnKhdnOe7HO0SIEfjAXA1Dw6
 UCHhoHmYVATe1uFp/qyTEpvaPhCUTtF6Yl5D142mx3VzAVXYk37KujfzgXot7ciDSuTo
 rNrsCNVsFXMWAP/6Y/gld75F5svjccx2843vEYiWf0awVRIytboaD+tnaAnMIPtHoMRY
 zuAQ==
X-Gm-Message-State: AC+VfDxBvMl0gG6GzGJrpNza43RwXkA8d9XDd8iB5DO9YJRzXvu4n+fN
 jcvxClVc5Rx+7L/nk2tCbjM=
X-Google-Smtp-Source: ACHHUZ54FXFJ1Y1iPprpZUD96sOhLlahuq9GbhC9GCpXQFMBFquczJ2NaRHFlukwy9YZfMB9a+zJ4Q==
X-Received: by 2002:a05:620a:d4c:b0:765:4878:9d20 with SMTP id
 o12-20020a05620a0d4c00b0076548789d20mr15297690qkl.61.1688024547799; 
 Thu, 29 Jun 2023 00:42:27 -0700 (PDT)
Received: from localhost ([1.146.16.117]) by smtp.gmail.com with ESMTPSA id
 w2-20020a636202000000b005439aaf0301sm8317795pgb.64.2023.06.29.00.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 00:42:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Jun 2023 17:42:21 +1000
Message-Id: <CTOYRCVTQAH9.18ULQ36NU1IAI@wheely>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "David Gibson" <david@gibson.dropbear.id.au>,
 "Greg Kurz" <groug@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Subject: Re: [PATCH] hw/ppc: Simplify clock update arithmetic
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230625122012.15503-1-npiggin@gmail.com>
 <8ba47cb9-00a8-8c22-ccda-b7dc1fefc5af@kaod.org>
In-Reply-To: <8ba47cb9-00a8-8c22-ccda-b7dc1fefc5af@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=npiggin@gmail.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Jun 29, 2023 at 3:28 PM AEST, C=C3=A9dric Le Goater wrote:
> On 6/25/23 14:20, Nicholas Piggin wrote:
> > The clock update logic reads the clock twice to compute the new clock
> > value, with a value derived from the later time subtracted from a value
> > derived from the earlier time. This can lead to an underflow in
> > subtractions in bits that are intended to cancel exactly. This might
> > not cause any real problem, but it is more complicated than necessary
> > to reason about.
> >=20
> > Simplify this by reading the clock once.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> This patch has ben superseded by
>
>   https://patchwork.ozlabs.org/project/qemu-ppc/patch/20230629020713.3277=
45-1-npiggin@gmail.com/
>
> It is nice to add a v2 prefix, even if you change the change the subject.

Oh yes, I actually forgot I sent that one, I did a bit more testing and
decided it actually was causing the problem. Hence subject and changelog
rewrite.

Thanks,
Nick

>
> Thanks,
>
> C.
>
>
> > ---
> >   hw/ppc/ppc.c | 33 +++++++++++++++++----------------
> >   1 file changed, 17 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > index f4fe1767d6..5d0a09eb5e 100644
> > --- a/hw/ppc/ppc.c
> > +++ b/hw/ppc/ppc.c
> > @@ -536,23 +536,24 @@ static inline void cpu_ppc_store_tb(ppc_tb_t *tb_=
env, uint64_t vmclk,
> >   void cpu_ppc_store_tbl (CPUPPCState *env, uint32_t value)
> >   {
> >       ppc_tb_t *tb_env =3D env->tb_env;
> > +    int64_t clock =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >       uint64_t tb;
> >  =20
> > -    tb =3D cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
), tb_env->tb_offset);
> > +    tb =3D cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
> >       tb &=3D 0xFFFFFFFF00000000ULL;
> > -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > -                     &tb_env->tb_offset, tb | (uint64_t)value);
> > +    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset, tb | (uint64_t=
)value);
> >   }
> >  =20
> >   static inline void _cpu_ppc_store_tbu(CPUPPCState *env, uint32_t valu=
e)
> >   {
> >       ppc_tb_t *tb_env =3D env->tb_env;
> > +    int64_t clock =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >       uint64_t tb;
> >  =20
> > -    tb =3D cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
), tb_env->tb_offset);
> > +    tb =3D cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
> >       tb &=3D 0x00000000FFFFFFFFULL;
> > -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > -                     &tb_env->tb_offset, ((uint64_t)value << 32) | tb)=
;
> > +    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset,
> > +                     ((uint64_t)value << 32) | tb);
> >   }
> >  =20
> >   void cpu_ppc_store_tbu (CPUPPCState *env, uint32_t value)
> > @@ -585,23 +586,24 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState *env)
> >   void cpu_ppc_store_atbl (CPUPPCState *env, uint32_t value)
> >   {
> >       ppc_tb_t *tb_env =3D env->tb_env;
> > +    int64_t clock =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >       uint64_t tb;
> >  =20
> > -    tb =3D cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
), tb_env->atb_offset);
> > +    tb =3D cpu_ppc_get_tb(tb_env, clock, tb_env->atb_offset);
> >       tb &=3D 0xFFFFFFFF00000000ULL;
> > -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > -                     &tb_env->atb_offset, tb | (uint64_t)value);
> > +    cpu_ppc_store_tb(tb_env, clock, &tb_env->atb_offset, tb | (uint64_=
t)value);
> >   }
> >  =20
> >   void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value)
> >   {
> >       ppc_tb_t *tb_env =3D env->tb_env;
> > +    int64_t clock =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >       uint64_t tb;
> >  =20
> > -    tb =3D cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
), tb_env->atb_offset);
> > +    tb =3D cpu_ppc_get_tb(tb_env, clock, tb_env->atb_offset);
> >       tb &=3D 0x00000000FFFFFFFFULL;
> > -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > -                     &tb_env->atb_offset, ((uint64_t)value << 32) | tb=
);
> > +    cpu_ppc_store_tb(tb_env, clock, &tb_env->atb_offset,
> > +                     ((uint64_t)value << 32) | tb);
> >   }
> >  =20
> >   uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
> > @@ -623,14 +625,13 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t=
 value)
> >   void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value)
> >   {
> >       ppc_tb_t *tb_env =3D env->tb_env;
> > +    int64_t clock =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >       uint64_t tb;
> >  =20
> > -    tb =3D cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
),
> > -                        tb_env->tb_offset);
> > +    tb =3D cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
> >       tb &=3D 0xFFFFFFUL;
> >       tb |=3D (value & ~0xFFFFFFUL);
> > -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > -                     &tb_env->tb_offset, tb);
> > +    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset, tb);
> >   }
> >  =20
> >   static void cpu_ppc_tb_stop (CPUPPCState *env)


