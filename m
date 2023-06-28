Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50955740753
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 02:56:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEJSk-0005cT-VM; Tue, 27 Jun 2023 20:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEJSi-0005bi-L3; Tue, 27 Jun 2023 20:55:12 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEJSg-0004h5-Vu; Tue, 27 Jun 2023 20:55:12 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-55b1238cab4so656177a12.2; 
 Tue, 27 Jun 2023 17:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687913709; x=1690505709;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPDkjCM1PkCzHhOgYy1PKpCQYJBrRHjNwIPY8nun7RE=;
 b=BnAGqbJ4CRHIM2dDa7Lw247lD1+XTtQPUdCV9v5Zib0Qbh0KsZGGSYlRVi393Fw2vk
 LT3vD4zbc33fdBuecN/oQlcMGdHH8Sv4WzeZILJCuUouWlJNbrguZ1dQQayZVUJEgiDi
 027LZmXi5rjnKw7C0j+uK580GcuEQ1d4BghNR9Swm4vEvJs2W+4Msjgnv1wBwpO8FtCE
 kxbU7OSwRA5F9gEECWTWAGpa5oiKNpDVXsTrqnYh0zE8If3TUVwVjN323uDIZUFrS0vM
 PKk7zLAYAWmSlR94iJ3NoEiyz6EuqghdvmQaL1h7d0eZfTB2DlueJ7MLBq+qZCakWg1Z
 73rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687913709; x=1690505709;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zPDkjCM1PkCzHhOgYy1PKpCQYJBrRHjNwIPY8nun7RE=;
 b=QxyA2Z32VRr4skF8JTy51oP1Amd4IeBGL1q20mlAo7NVvR9I8P5sli4t9LH/xHrQpc
 k9df/wkOkcpYidVDRc/aIzv+vEsdfQsijQ4zJa0rkDbJ10TjJoOF96wV2pZq3Xi7MFKC
 ZoEeK+JV0gGx/NRntjWLfGwRm3oRQwv6uct6qVTstZuvvg9PNHcdvgvMoaCWKfInwSej
 GFONmwGXDLRgcnwJ939DuaD4aVl+eytqOw1Mb9+xzK4lUwutJO+7IkGStGw3wIRCuEEM
 592FFK11dU+iMdRRAySKxYE7QtdpY9e+7DOZ7HAlVyndhlidBN61xriy2BH0JSwftlZN
 Tuig==
X-Gm-Message-State: AC+VfDxILBRwo0Xc1QyQz7kgOG9s/AAB4lMUJVhkFCstgxKRFCBKoQKU
 OY2y6Hr8EPvBAXboGODau90=
X-Google-Smtp-Source: ACHHUZ4yrikoHtIjb2pFWRyuYOrunafLI+Hn4WWFXEibyLsndUPFSnuipzdG9HQnDcozubioAv1uYA==
X-Received: by 2002:a05:6a20:3d26:b0:10b:8698:2097 with SMTP id
 y38-20020a056a203d2600b0010b86982097mr31753892pzi.0.1687913708816; 
 Tue, 27 Jun 2023 17:55:08 -0700 (PDT)
Received: from localhost (193-116-109-121.tpgi.com.au. [193.116.109.121])
 by smtp.gmail.com with ESMTPSA id
 6-20020aa79146000000b00659edece5dasm5907948pfi.49.2023.06.27.17.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 17:55:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jun 2023 10:55:02 +1000
Message-Id: <CTNVGY00BO7S.35I04KZ8AFLL4@wheely>
Subject: Re: [PATCH v2 3/4] target/ppc: Make checkstop actually stop the system
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz"
 <groug@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>
X-Mailer: aerc 0.15.2
References: <20230627134644.260663-1-npiggin@gmail.com>
 <20230627134644.260663-4-npiggin@gmail.com>
 <5b90ae62-f279-1d07-1098-39a4f450bb99@eik.bme.hu>
In-Reply-To: <5b90ae62-f279-1d07-1098-39a4f450bb99@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52b.google.com
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

On Wed Jun 28, 2023 at 3:38 AM AEST, BALATON Zoltan wrote:
> On Tue, 27 Jun 2023, Nicholas Piggin wrote:
> > checkstop state does not halt the system, interrupts continue to be
> > serviced, and other CPUs run.
> >
> > Stop the machine with vm_stop(), and print a register dump too.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > Since v1:
> > - Fix loop exit so it stops on the attn instruction, rather than
> >  after it.
> >
> > target/ppc/excp_helper.c | 34 ++++++++++++++++++++--------------
> > 1 file changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index 5beda973ce..28d8a9b212 100644
> > --- a/target/ppc/excp_helper.c
> > +++ b/target/ppc/excp_helper.c
> > @@ -19,6 +19,7 @@
> > #include "qemu/osdep.h"
> > #include "qemu/main-loop.h"
> > #include "qemu/log.h"
> > +#include "sysemu/runstate.h"
> > #include "cpu.h"
> > #include "exec/exec-all.h"
> > #include "internal.h"
> > @@ -186,19 +187,24 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *en=
v, int excp)
> >              env->error_code);
> > }
> >
> > -static void powerpc_checkstop(CPUPPCState *env)
> > +static void powerpc_checkstop(CPUPPCState *env, const char *reason)
> > {
> >     CPUState *cs =3D env_cpu(env);
> >
> > -    /* Machine check exception is not enabled. Enter checkstop state. =
*/
> > -    fprintf(stderr, "Machine check while not allowed. "
> > -            "Entering checkstop state\n");
> > +    vm_stop(RUN_STATE_GUEST_PANICKED);
> > +
> > +    fprintf(stderr, "Entering checkstop state: %s\n", reason);
> > +    cpu_dump_state(cs, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
> >     if (qemu_log_separate()) {
> > -        qemu_log("Machine check while not allowed. "
> > -                 "Entering checkstop state\n");
> > +        FILE *logfile =3D qemu_log_trylock();
> > +        if (logfile) {
> > +            fprintf(logfile, "Entering checkstop state: %s\n", reason)=
;
>
> I don't think you should have fprintfs here. Is this remnants of debug=20
> code left here by mistake? The fprintf that was there before may also nee=
d=20
> to be converted to some qemI_log or error_report but I did not know what=
=20
> these are for and did not address that. But if you want to add more then=
=20
> it may need to be solved first.

I just followed existing fprintf use. Changing that should be separate
patch indeed.

> > +            cpu_dump_state(cs, logfile, CPU_DUMP_FPU | CPU_DUMP_CCOP);
> > +            qemu_log_unlock(logfile);
> > +        }
> >     }
> > -    cs->halted =3D 1;
> > -    cpu_interrupt_exittb(cs);
> > +
>
> Excess blank line?

No, it separates the logging block from function.

>
> > +    cpu_loop_exit_noexc(cs);
> > }
> >
> > #if defined(TARGET_PPC64)
> > @@ -483,7 +489,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int e=
xcp)
> >         break;
> >     case POWERPC_EXCP_MCHECK:    /* Machine check exception            =
      */
> >         if (!FIELD_EX64(env->msr, MSR, ME)) {
> > -            powerpc_checkstop(env);
> > +            powerpc_checkstop(env, "machine check with MSR[ME]=3D0");
>
> If the message is always the same why pass it from here If the only other=
=20
> option not used yet would be MSR[ME]=3D1 then that could also be checked =
in=20
> the func so no need to pass the message. So is there any other possible=
=20
> reason here?

To make the checkstop function more general (e.g., used by the next patch).

Thanks,
Nick

