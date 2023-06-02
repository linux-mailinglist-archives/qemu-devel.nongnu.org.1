Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB13771FA65
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 08:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4yiK-0008O6-Fz; Fri, 02 Jun 2023 02:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4yiI-0008Ma-8F; Fri, 02 Jun 2023 02:56:42 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4yiG-00042P-J5; Fri, 02 Jun 2023 02:56:42 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-39a523e8209so1164945b6e.0; 
 Thu, 01 Jun 2023 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685688999; x=1688280999;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BssOITr/RZ0nrm7d0WqGL+8ATaMqZUE2V2wM8kNVZvg=;
 b=O+kdxt6JxWAOO6DaUXL2CujDtiumwKNcr8/j9IN2fkNdqy+aSsAsfHiePROh6jZqA1
 8FYfwyHswKUyYP6PexAGhJbfRhcfnul2n/dsWBEyKJC75p5nZMdmEtV4OLY/CxZaE+0y
 Rmno9Ph3sDsM2D9tYClOF/dzQuPT2AWrLpWuMuZGfOktIKj+qsyqk7W/vtx6sTHwQCMI
 w7NIuLvvpf3yS3ZUu47RQS5+fR7qi9fMyYSP3+8rKmeiltc7DmZbXKonIejTUxEx7Ksg
 vMXO0mArka56jwyZTUXU/OcX9lBpo1pVaZ/B/u08TF/aYRj9BwqAxkDPKnlNSml39lkS
 wbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685688999; x=1688280999;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BssOITr/RZ0nrm7d0WqGL+8ATaMqZUE2V2wM8kNVZvg=;
 b=CxJpvJbU7pOY7krtHQcY6mCw22v79BOpBKLo3KnfNGFF4AcYIRrvE3X2zPc4oMXxey
 y55qVOHdrQfYnImjBlwfKAh0cxo7on8glsP7pvCdkWJA9j4a25rCtFk352FfOfpBaZN3
 ojpO7AG/EJOMpC7K2cSPVNhIgeTa9QK2qhKRBOHG/kordSiNp1KD+P5Lq/IRj7cD2hmx
 RntWnsyXCqTI+Gz/s4v014P1VBrH5yENqwSWeLZ1YGlgzfngPp/ELs6TIE5M459WvmZT
 hJ6TZp+u62ksed8FM/t7zUMKCZvxaEEVh15B8gO73VfiIIZJedQn4Tny3j9nzPk0qWsq
 ohtg==
X-Gm-Message-State: AC+VfDw0E/JEPFjt+IYZHBBP0brsTeBssglbKa9g/OOHWh0oBW9eQSI9
 SgqSqBNBh00XWQ/Jp/5vSYM=
X-Google-Smtp-Source: ACHHUZ6yAyhJojngDmelAgMoWfUG2/5zYnuw+KRe2KjAQp/1UqR1Vj1UcfAy+Qfvd3q4kkEcZTfHiQ==
X-Received: by 2002:aca:1b18:0:b0:395:dd8c:f852 with SMTP id
 b24-20020aca1b18000000b00395dd8cf852mr1177906oib.42.1685688999029; 
 Thu, 01 Jun 2023 23:56:39 -0700 (PDT)
Received: from localhost ([1.146.22.171]) by smtp.gmail.com with ESMTPSA id
 u4-20020aa78484000000b0064381853bfcsm361687pfn.89.2023.06.01.23.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 23:56:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Jun 2023 16:56:31 +1000
Message-Id: <CT1YVK35L3UT.2CY7LU5L7GDG4@wheely>
Subject: Re: [RFC PATCH 4/5] target/ppc: Add msgsnd/p and DPDES SMT support
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
X-Mailer: aerc 0.14.0
References: <20230531012313.19891-1-npiggin@gmail.com>
 <20230531012313.19891-5-npiggin@gmail.com>
 <60f0d393-f0b5-cc06-feff-a8f00e5a32b3@kaod.org>
In-Reply-To: <60f0d393-f0b5-cc06-feff-a8f00e5a32b3@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x230.google.com
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

On Thu Jun 1, 2023 at 5:13 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/31/23 03:23, Nicholas Piggin wrote:
> > Doorbells in SMT need to coordinate msgsnd/msgclr and DPDES access from
> > multiple threads that affect the same state.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/ppc.c                                  |  6 ++
> >   include/hw/ppc/ppc.h                          |  1 +
> >   target/ppc/cpu.h                              |  7 +-
> >   target/ppc/excp_helper.c                      | 86 +++++++++++++-----=
-
> >   target/ppc/gdbstub.c                          |  2 +-
> >   target/ppc/helper.h                           |  2 +-
> >   target/ppc/misc_helper.c                      | 60 +++++++++++--
> >   target/ppc/translate.c                        |  8 ++
> >   .../ppc/translate/processor-ctrl-impl.c.inc   |  2 +-
> >   9 files changed, 140 insertions(+), 34 deletions(-)
> >=20
> > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > index 80b4706db2..e30853413b 100644
> > --- a/hw/ppc/ppc.c
> > +++ b/hw/ppc/ppc.c
> > @@ -1434,6 +1434,12 @@ int ppc_cpu_pir(PowerPCCPU *cpu)
> >       return env->spr_cb[SPR_PIR].default_value;
> >   }
> >  =20
> > +int ppc_cpu_tir(PowerPCCPU *cpu)
> > +{
> > +    CPUPPCState *env =3D &cpu->env;
> > +    return env->spr_cb[SPR_PIR].default_value;
>
> PIR or TIR ?

Good catch, I think I "tidied" that up before sending it :\

> > @@ -3154,22 +3172,42 @@ void helper_book3s_msgclrp(CPUPPCState *env, ta=
rget_ulong rb)
> >   }
> >  =20
> >   /*
> > - * sends a message to other threads that are on the same
> > + * sends a message to another thread  on the same
> >    * multi-threaded processor
> >    */
> >   void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
> >   {
> > -    int pir =3D env->spr_cb[SPR_PIR].default_value;
> > +    CPUState *cs =3D env_cpu(env);
> > +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > +    CPUState *ccs;
> > +    uint32_t nr_threads =3D cs->nr_threads;
> > +    int ttir =3D rb & PPC_BITMASK(57, 63);
> >  =20
> >       helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_=
MSGP);
> >  =20
> > -    if (!dbell_type_server(rb)) {
> > +    if (!dbell_type_server(rb) || ttir >=3D nr_threads) {
>
> may be log bad ttir values ? even if the insn is a no-op in that case,
> telling the user would be good since it should be a guest os issue

Yeah. We don't seem to do that on a systematic basis in PPC but we
probably should. It's certainly helped me before when I've got
something wrong. Good idea.

> > @@ -192,14 +192,38 @@ void helper_store_pcr(CPUPPCState *env, target_ul=
ong value)
> >    */
> >   target_ulong helper_load_dpdes(CPUPPCState *env)
> >   {
> > +    CPUState *cs =3D env_cpu(env);
> > +    CPUState *ccs;
> > +    uint32_t nr_threads =3D cs->nr_threads;
> > +    uint32_t core_id =3D env->spr[SPR_PIR] & ~(nr_threads - 1);
>
> you could add an helper for the above.

Yes.

Thanks,
Nick

