Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37021730D85
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 05:29:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9df5-0000pR-SX; Wed, 14 Jun 2023 23:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9df4-0000oz-77; Wed, 14 Jun 2023 23:28:38 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9df2-0001wn-C3; Wed, 14 Jun 2023 23:28:37 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-25e9e5f9e0cso968a91.0; 
 Wed, 14 Jun 2023 20:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686799714; x=1689391714;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptu40YvLwFnGnurrcY9ylqh6t+nfJdcJQjXn79Kb6Q8=;
 b=SzEZ92PRtaJqTkQq3O3aZ+rnl17BUhI6DVfv5fsAS65N2TPlB5FIU60Z+csRnwQ/Bx
 BntnnzMVHsc4YkSi2IyIRN1NHJzseKCYzuOvSkV8cxoVNAjmKowddV8OLhTu5dg0a/1s
 isF0/37dNn+wnrZNvRQx9fA90cxyZElunwv/g2vMPn/f/G76esHZ2LJmqqcIPmqUSicy
 MUMxDNclKzednuGeHox6JL08ChbsCADwf6oaHEjV/Y7g/zrLnk3XcAT9tBEj5ZtbK2tb
 pcWp3/4pR3y7UVbcMYM8Skgu4mVASvCZVTFddSxA27qTImMk+zMewXUWH8HcElvx3QsF
 4nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686799714; x=1689391714;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ptu40YvLwFnGnurrcY9ylqh6t+nfJdcJQjXn79Kb6Q8=;
 b=d0raxbvMV/j9jsUGJxu6LStOLCuxJqAKg6Eg+r7ev6V1bv6Inbpi5WEOYNDN6NVXXe
 ifoOgqAiqMz+AS6em8/dCXL2UP7xal5XTAdIsNRNPgaWjL7ggSaWfl6qecGGjnfFX0MB
 aFFqiCtRbiEhArRK4+1itp6/wO217Dra1DDwwybPffRr9PZTDtAzGnC3wHtpcuDTsc6Q
 eRSaA0at35qxhbFQ6HxDyOxicjur1nKk3zgTdIfucfVgKIbaZAK/bf/Zj67t5zpVNjt0
 iYKe5o5cBNQgaezohNKaADz8iODSBj1O/29r4Wrvamk6fGahI7vVAphtWYur25Z7RRzh
 B+Rg==
X-Gm-Message-State: AC+VfDxy7EeeyhyhBxAOMc47B8A0pU8phN4eNJULenSH/6Yqa2nL5xD5
 ihBMu8KRXw0S6z05K4f04as=
X-Google-Smtp-Source: ACHHUZ5WOmWaIR0IHWJb+nI5m2v7iRaBQV59188nIOMuK8dgDsbW3mPFMZL/SNj3UdZfFBcRWRFeew==
X-Received: by 2002:a17:90b:3616:b0:25c:17f4:2d with SMTP id
 ml22-20020a17090b361600b0025c17f4002dmr3064512pjb.45.1686799714221; 
 Wed, 14 Jun 2023 20:28:34 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 g1-20020a17090a828100b00256504e0937sm13455253pjn.34.2023.06.14.20.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 20:28:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 13:28:28 +1000
Message-Id: <CTCWLCE09SUS.1G1XXO54L2XD6@wheely>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH v2 03/10] target/ppc: Move common check in exception
 handlers to a function
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.14.0
References: <cover.1686776990.git.balaton@eik.bme.hu>
 <9cfffaa35aa894086dd092af6b0b26f2d62ff3de.1686776990.git.balaton@eik.bme.hu>
In-Reply-To: <9cfffaa35aa894086dd092af6b0b26f2d62ff3de.1686776990.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1033.google.com
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

On Thu Jun 15, 2023 at 7:34 AM AEST, BALATON Zoltan wrote:
> All powerpc exception handlers share some code when handling machine
> check exceptions. Move this to a common function.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/excp_helper.c | 114 +++++++++------------------------------
>  1 file changed, 25 insertions(+), 89 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 3783315fdb..79f5ca1034 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -403,6 +403,25 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, =
target_ulong vector,
>      env->reserve_addr =3D -1;
>  }
> =20
> +static void powerpc_mcheck_checkstop(CPUPPCState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +
> +    if (FIELD_EX64(env->msr, MSR, ME)) {
> +        return;
> +    }
> +
> +    /* Machine check exception is not enabled. Enter checkstop state. */
> +    fprintf(stderr, "Machine check while not allowed. "
> +            "Entering checkstop state\n");
> +    if (qemu_log_separate()) {
> +        qemu_log("Machine check while not allowed. "
> +                 "Entering checkstop state\n");
> +    }
> +    cs->halted =3D 1;
> +    cpu_interrupt_exittb(cs);
> +}
> +
>  static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>  {
>      CPUState *cs =3D CPU(cpu);
> @@ -445,21 +464,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int ex=
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
> +        powerpc_mcheck_checkstop(env);
>          /* machine check exceptions don't have ME set */
>          new_msr &=3D ~((target_ulong)1 << MSR_ME);
> =20
> @@ -576,21 +581,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int ex=
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
> +        powerpc_mcheck_checkstop(env);
>          /* machine check exceptions don't have ME set */
>          new_msr &=3D ~((target_ulong)1 << MSR_ME);
> =20
> @@ -749,21 +740,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int ex=
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
> +        powerpc_mcheck_checkstop(env);
>          /* machine check exceptions don't have ME set */
>          new_msr &=3D ~((target_ulong)1 << MSR_ME);
> =20
> @@ -934,21 +911,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int e=
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
> +        powerpc_mcheck_checkstop(env);
>          /* machine check exceptions don't have ME set */
>          new_msr &=3D ~((target_ulong)1 << MSR_ME);
> =20
> @@ -1129,21 +1092,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, in=
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
> +        powerpc_mcheck_checkstop(env);
>          /* machine check exceptions don't have ME set */
>          new_msr &=3D ~((target_ulong)1 << MSR_ME);
> =20
> @@ -1376,20 +1325,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, in=
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
> +        powerpc_mcheck_checkstop(env);
>          if (env->msr_mask & MSR_HVB) {
>              /*
>               * ISA specifies HV, but can be delivered to guest with HV
> --=20
> 2.30.9


