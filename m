Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006372F31B
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 05:36:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9HI8-0004Yj-6M; Tue, 13 Jun 2023 23:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9HI6-0004YV-JQ; Tue, 13 Jun 2023 23:35:26 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9HI4-0004rz-R2; Tue, 13 Jun 2023 23:35:26 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-55b069a7cf4so236137eaf.3; 
 Tue, 13 Jun 2023 20:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686713723; x=1689305723;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJwax5Y3r67QiwX4MO1XlLD/fPiW1nZPWexX6r9O3KI=;
 b=ddQ+ZhTFtSTIiih6t86imbwHf+W/jn0CjojMs6UDV9IM5CqJecIBXm6Wtgf4YVt7Z3
 Kq3g9DMKrx5xxkYq3eBOeoR5xt7BF/G9a6m+eSjOAAfRJc9UsK+pIXrMJTCZRoJdgRYa
 3RgZ6929gfktZQ/xGULd/q9jsxWPcMTvvILBChYvVP2IwnKGwSo4F9FLh5bYZAE5XRqf
 gsuJXRt4MyyrK50YYQo+k9eo7Nm2b9mw7KNe/stihcO3Q71KuThCnhuWWCs+n3bhFaWR
 NEz04eJszYppl5IvLE1taJzAeA/ad8aiCPEg8OfYCuSFs8ECSUyc3M/AuHxx5z6muGpJ
 jtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686713723; x=1689305723;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mJwax5Y3r67QiwX4MO1XlLD/fPiW1nZPWexX6r9O3KI=;
 b=blflitpGbYEdVSN1NjgqvWsJYv24mwciK+5t48FCBYqFoUdC9xIxkKeGHcwo+zR95U
 YuyGl3vQ/ukQiEdbKubraTP8XYYZqU0vJBJQBl9bqGsWMLrVy3M03Q0HonVuyOIEG8Lq
 rT+Qyc5hQSMiSsC/qmYFAiRsCXHPuPQiOc+ceH9sQZt1ilqW3HssD0qp8kdUqz0sZTZQ
 CBVa45t69H9DTjvQcebavhkdHwuyB1YQ9viwykSyT6y0J3MlqISturCgqlnaPji4JEpl
 eZeDP8Fa809LBgMgTdx4qxvAPnESGgrzD0MGJJ8FoGcF8jbxHRWm0FMJLCpXv1VRR16e
 Znqw==
X-Gm-Message-State: AC+VfDxIjDn9knrxBbzyGA8tdeAvknaCOzoaLC8o8Ia4zmHiaidqcK/D
 xy1so32h9vTgW+vS8QafTgE=
X-Google-Smtp-Source: ACHHUZ7UCF1WiyGIrnAw0JqYZxG5b4Xj++iW51L316oBnCU4aTFSw563mRnDGdusvjfl4Dm+HS2IgA==
X-Received: by 2002:a05:6808:2019:b0:39c:870a:cc07 with SMTP id
 q25-20020a056808201900b0039c870acc07mr11740474oiw.32.1686713722704; 
 Tue, 13 Jun 2023 20:35:22 -0700 (PDT)
Received: from localhost ([1.146.66.73]) by smtp.gmail.com with ESMTPSA id
 x35-20020a17090a6c2600b0025bdaaf0cfesm5372000pjj.28.2023.06.13.20.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 20:35:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 13:35:12 +1000
Message-Id: <CTC23Y9FHUQ9.2CDYVQ4WJ58L0@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH 03/10] target/ppc: Move common check in exception
 handlers to a function
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <e7c1a61de1efdee932b71fada93dd58a3ce951cb.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <e7c1a61de1efdee932b71fada93dd58a3ce951cb.1686522199.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc31.google.com
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

On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
> All powerpc exception handlers share some code when handling machine
> check exceptions. Move this to a common function.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Hah, I just did very similar to improve some checkstop code (but I can
rebase my patches on yours).

This is specifically to test checkstop due to machine check with
MSR[ME]=3D0 (other things can potentially case a checkstop). So
maybe rename it powerpc_mcheck_test_checkstop or something like
that?

Mechanically looks okay though, so other than the name,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


> ---
>  target/ppc/excp_helper.c | 112 ++++++++-------------------------------
>  1 file changed, 23 insertions(+), 89 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 3783315fdb..e4532f5088 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -403,6 +403,23 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, =
target_ulong vector,
>      env->reserve_addr =3D -1;
>  }
> =20
> +static void powerpc_checkstop_state(CPUPPCState *env)
> +{
> +    if (!FIELD_EX64(env->msr, MSR, ME)) {
> +        CPUState *cs =3D env_cpu(env);
> +
> +        /* Machine check exception is not enabled. Enter checkstop state=
. */
> +        fprintf(stderr, "Machine check while not allowed. "
> +                "Entering checkstop state\n");
> +        if (qemu_log_separate()) {
> +            qemu_log("Machine check while not allowed. "
> +                     "Entering checkstop state\n");
> +        }
> +        cs->halted =3D 1;
> +        cpu_interrupt_exittb(cs);
> +    }
> +}
> +
>  static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>  {
>      CPUState *cs =3D CPU(cpu);
> @@ -445,21 +462,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int ex=
cp)
>          srr1 =3D SPR_40x_SRR3;
>          break;
>      case POWERPC_EXCP_MCHECK:    /* Machine check exception             =
     */
> -        if (!FIELD_EX64(env->msr, MSR, ME)) {
> -            /*
> -             * Machine check exception is not enabled.  Enter
> -             * checkstop state.
> -             */
> -            fprintf(stderr, "Machine check while not allowed. "
> -                    "Entering checkstop state\n");
> -            if (qemu_log_separate()) {
> -                qemu_log("Machine check while not allowed. "
> -                        "Entering checkstop state\n");
> -            }
> -            cs->halted =3D 1;
> -            cpu_interrupt_exittb(cs);
> -        }
> -
> +        powerpc_checkstop_state(env);
>          /* machine check exceptions don't have ME set */
>          new_msr &=3D ~((target_ulong)1 << MSR_ME);
> =20
> @@ -576,21 +579,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int ex=
cp)
>      case POWERPC_EXCP_CRITICAL:    /* Critical input                    =
     */
>          break;
>      case POWERPC_EXCP_MCHECK:    /* Machine check exception             =
     */
> -        if (!FIELD_EX64(env->msr, MSR, ME)) {
> -            /*
> -             * Machine check exception is not enabled.  Enter
> -             * checkstop state.
> -             */
> -            fprintf(stderr, "Machine check while not allowed. "
> -                    "Entering checkstop state\n");
> -            if (qemu_log_separate()) {
> -                qemu_log("Machine check while not allowed. "
> -                        "Entering checkstop state\n");
> -            }
> -            cs->halted =3D 1;
> -            cpu_interrupt_exittb(cs);
> -        }
> -
> +        powerpc_checkstop_state(env);
>          /* machine check exceptions don't have ME set */
>          new_msr &=3D ~((target_ulong)1 << MSR_ME);
> =20
> @@ -749,21 +738,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int ex=
cp)
> =20
>      switch (excp) {
>      case POWERPC_EXCP_MCHECK:    /* Machine check exception             =
     */
> -        if (!FIELD_EX64(env->msr, MSR, ME)) {
> -            /*
> -             * Machine check exception is not enabled.  Enter
> -             * checkstop state.
> -             */
> -            fprintf(stderr, "Machine check while not allowed. "
> -                    "Entering checkstop state\n");
> -            if (qemu_log_separate()) {
> -                qemu_log("Machine check while not allowed. "
> -                        "Entering checkstop state\n");
> -            }
> -            cs->halted =3D 1;
> -            cpu_interrupt_exittb(cs);
> -        }
> -
> +        powerpc_checkstop_state(env);
>          /* machine check exceptions don't have ME set */
>          new_msr &=3D ~((target_ulong)1 << MSR_ME);
> =20
> @@ -934,21 +909,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int e=
xcp)
> =20
>      switch (excp) {
>      case POWERPC_EXCP_MCHECK:    /* Machine check exception             =
     */
> -        if (!FIELD_EX64(env->msr, MSR, ME)) {
> -            /*
> -             * Machine check exception is not enabled.  Enter
> -             * checkstop state.
> -             */
> -            fprintf(stderr, "Machine check while not allowed. "
> -                    "Entering checkstop state\n");
> -            if (qemu_log_separate()) {
> -                qemu_log("Machine check while not allowed. "
> -                        "Entering checkstop state\n");
> -            }
> -            cs->halted =3D 1;
> -            cpu_interrupt_exittb(cs);
> -        }
> -
> +        powerpc_checkstop_state(env);
>          /* machine check exceptions don't have ME set */
>          new_msr &=3D ~((target_ulong)1 << MSR_ME);
> =20
> @@ -1129,21 +1090,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, in=
t excp)
>          srr1 =3D SPR_BOOKE_CSRR1;
>          break;
>      case POWERPC_EXCP_MCHECK:    /* Machine check exception             =
     */
> -        if (!FIELD_EX64(env->msr, MSR, ME)) {
> -            /*
> -             * Machine check exception is not enabled.  Enter
> -             * checkstop state.
> -             */
> -            fprintf(stderr, "Machine check while not allowed. "
> -                    "Entering checkstop state\n");
> -            if (qemu_log_separate()) {
> -                qemu_log("Machine check while not allowed. "
> -                        "Entering checkstop state\n");
> -            }
> -            cs->halted =3D 1;
> -            cpu_interrupt_exittb(cs);
> -        }
> -
> +        powerpc_checkstop_state(env);
>          /* machine check exceptions don't have ME set */
>          new_msr &=3D ~((target_ulong)1 << MSR_ME);
> =20
> @@ -1376,20 +1323,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, in=
t excp)
> =20
>      switch (excp) {
>      case POWERPC_EXCP_MCHECK:    /* Machine check exception             =
     */
> -        if (!FIELD_EX64(env->msr, MSR, ME)) {
> -            /*
> -             * Machine check exception is not enabled.  Enter
> -             * checkstop state.
> -             */
> -            fprintf(stderr, "Machine check while not allowed. "
> -                    "Entering checkstop state\n");
> -            if (qemu_log_separate()) {
> -                qemu_log("Machine check while not allowed. "
> -                        "Entering checkstop state\n");
> -            }
> -            cs->halted =3D 1;
> -            cpu_interrupt_exittb(cs);
> -        }
> +        powerpc_checkstop_state(env);
>          if (env->msr_mask & MSR_HVB) {
>              /*
>               * ISA specifies HV, but can be delivered to guest with HV
> --=20
> 2.30.9


