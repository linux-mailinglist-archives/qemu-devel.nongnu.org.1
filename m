Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD07373CFA7
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 11:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDLqa-0002IX-Hf; Sun, 25 Jun 2023 05:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDLqY-0002IC-Ia; Sun, 25 Jun 2023 05:15:50 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDLqW-0003gi-Pa; Sun, 25 Jun 2023 05:15:50 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-53482b44007so1079530a12.2; 
 Sun, 25 Jun 2023 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687684547; x=1690276547;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEG2OQ80o93SsHtSA5RPxXfNx+Eiy3DeNaRQ6sgfWg4=;
 b=RCqyv8iz77PWppsBHhcGoDHok9BWY7DJpJ5WKn03nb5xEC6age1AYfHf2Fk3N0sP0F
 4zlcskfcYTRs4MNdVAiIhDgEKNxxHQdaceRYBXhjSFF4wCOXuvijsLJz0LvO78dPkLpn
 ovh4EdL5AXqhHvqX3sR2t1QjzBro3MQPWsWzk2ZxCL6BauvOH8Q1IViWb2mPC+zFdVSf
 36kBFFQjs8VIdibs+NjBx2bWl/G7vOFfZwOv/glVuu9DZkddwRyBQSaq+F4b2g95WZK6
 Y5mH7C2smfpU4ItN32yIz3NmR7cYETA3e6AtwQoJdBLPOcRaDbMEaYxOZU1qfCcB3U53
 1UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687684547; x=1690276547;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dEG2OQ80o93SsHtSA5RPxXfNx+Eiy3DeNaRQ6sgfWg4=;
 b=hPGaz8onnowbvcOJrdtzS0/P1sHHu1VDb6kmh1sukSOjb6cz8Wz84uVYYoFdpQJKH/
 h0NbTYLf5nyQytJCK1lIpKZDQGNSjb0Nbz+DiJXLpOqwP0/UzuXBy/X90z2zxZUr22Vd
 I2UYOe1MBKJl3aqmKa8q6FAhaO9cJPIqiX2Pk08ql57RhrTUsuVFf7lZ1xIFzQNalRnX
 Kay9Cuorl5yzwqBP/qnX3dtW2mtCoqsm2gFXbDRiTj42AxbIR8/53sz83Bgw0lKZk48D
 wxKgKCb7oQaAtgwNdfQ1VR1rvlB2bEKF6BqPZcFoQW242XANhGS2RrNui2quZUVvsmvz
 7C8A==
X-Gm-Message-State: AC+VfDz9w9OyXO5cA7gFPRq7l7nvGjni0UAsIMAF6c16cYhIlcbe7cYa
 KKhMr7StBsaFQxPGqQQ2+eA=
X-Google-Smtp-Source: ACHHUZ6kmGl73pzEjuv2I7hkTpNHzQTNDqhf0TizcJIaUNefF4C/sPx3z3TPg/N0v3SEWTROAgOogg==
X-Received: by 2002:a17:902:d2c1:b0:1b1:e6a4:2797 with SMTP id
 n1-20020a170902d2c100b001b1e6a42797mr1484462plc.45.1687684546947; 
 Sun, 25 Jun 2023 02:15:46 -0700 (PDT)
Received: from localhost (193-116-198-102.tpgi.com.au. [193.116.198.102])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a170902ea0e00b001b55fe1b471sm2192995plg.302.2023.06.25.02.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 02:15:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Jun 2023 19:15:40 +1000
Message-Id: <CTLM8MKHV82Y.234W43DPGDJMA@wheely>
Subject: Re: [PATCH 4/4] target/ppc: Make checkstop stop the system
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>
X-Mailer: aerc 0.15.2
References: <20230623081953.290875-1-npiggin@gmail.com>
 <20230623081953.290875-5-npiggin@gmail.com>
 <04636e8a-de3f-d963-b64e-07cc60bc2538@eik.bme.hu>
In-Reply-To: <04636e8a-de3f-d963-b64e-07cc60bc2538@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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

On Fri Jun 23, 2023 at 9:51 PM AEST, BALATON Zoltan wrote:
> On Fri, 23 Jun 2023, Nicholas Piggin wrote:
> > checkstop state does not halt the system, interrupts continue to be
> > serviced, and other CPUs run.
> >
> > Stop the machine with vm_stop(), and print a register dump too.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > target/ppc/excp_helper.c | 35 +++++++++++++++++++++--------------
> > 1 file changed, 21 insertions(+), 14 deletions(-)
> >
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index 4bfcfc3c3d..51e83d7f07 100644
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
> > @@ -165,6 +166,24 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *env=
, int excp)
> >              env->error_code);
> > }
> >
> > +static void powerpc_checkstop(PowerPCCPU *cpu, const char *reason)
> > +{
> > +    CPUState *cs =3D CPU(cpu);
> > +
> > +    vm_stop(RUN_STATE_GUEST_PANICKED);
> > +
> > +    fprintf(stderr, "Entering checkstop state: %s\n", reason);
> > +    cpu_dump_state(cs, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
> > +    if (qemu_log_separate()) {
> > +        FILE *logfile =3D qemu_log_trylock();
> > +        if (logfile) {
> > +            fprintf(logfile, "Entering checkstop state: %s\n", reason)=
;
> > +            cpu_dump_state(cs, logfile, CPU_DUMP_FPU | CPU_DUMP_CCOP);
> > +            qemu_log_unlock(logfile);
> > +        }
> > +    }
> > +}
> > +
> > #if defined(TARGET_PPC64)
> > static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int exc=
p,
> >                                 target_ulong *msr)
> > @@ -406,21 +425,9 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu=
, target_ulong vector,
> >
> > static void powerpc_mcheck_test_and_checkstop(CPUPPCState *env)
> > {
> > -    CPUState *cs =3D env_cpu(env);
> > -
> > -    if (FIELD_EX64(env->msr, MSR, ME)) {
> > -        return;
> > -    }
> > -
> > -    /* Machine check exception is not enabled. Enter checkstop state. =
*/
> > -    fprintf(stderr, "Machine check while not allowed. "
> > -            "Entering checkstop state\n");
> > -    if (qemu_log_separate()) {
> > -        qemu_log("Machine check while not allowed. "
> > -                 "Entering checkstop state\n");
> > +    if (!FIELD_EX64(env->msr, MSR, ME)) {
> > +        powerpc_checkstop(env_archcpu(env), "machine check with MSR[ME=
]=3D0");
>
> I don't mind you twaeking the patch and renaming the function but now thi=
s=20
> has become another one line function which just clutters code. Either kee=
p=20
> this together in one function or inline the if at callers, otherwise this=
=20
> will start to look like Forth where every simple operation gets a new=20
> name. :-)

Yeah good point. I did want to have a powerpc_checkstop function with a
reason because other places might start to also call it in future.

As far as the machine check ME test goes... we could re-inline that I
suppose.

Thanks,
Nick

