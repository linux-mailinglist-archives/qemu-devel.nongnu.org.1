Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2149A7317D3
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 13:48:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9lRG-0007sl-NE; Thu, 15 Jun 2023 07:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9lRB-0007qX-Ts; Thu, 15 Jun 2023 07:46:52 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9lRA-0003D0-4c; Thu, 15 Jun 2023 07:46:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-666a25afc81so308343b3a.0; 
 Thu, 15 Jun 2023 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686829606; x=1689421606;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTJaDWOcrTuX1zHVov/IkVj0GdyViFROt2dezE21VvM=;
 b=D0jXdE97B/bbqI61bYa8gBPWFZ3FyPw8ZG2w5aAUzbqsMerV3UlIoEnOBF5Q8ZN9hH
 dYHJGvu1fWJT7k3JUjGCbo320R+gWSX7k/Iq5yewK4uOnOf6kwrhEDEZLOaIPetHY/8s
 RMSROJOjVtyy2CJIwbXY0Bz+eI1kofgH5LdPqAgkvtE/OeYTs6k5DCn4kvJH3Fs+NGbH
 pa8xCZZ/tp+uzlJb/2r+nxjZvOmrLy08qgXV9AsMqMdRX1roMK3QweiJDnI3xWa0jPeS
 XVUw4FIn7VsYT1fEyfIe4OZLML5353ux/m9k0+Fzz5ysT+MsBEhiZlGvKjsFxlUVLYlQ
 3oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686829606; x=1689421606;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XTJaDWOcrTuX1zHVov/IkVj0GdyViFROt2dezE21VvM=;
 b=F6+GOo+0kbIGDmwdOHO3lC5V7IFrln6hms/w1sz4SfcRXi84d1izPv4YwkFG/Ya50u
 obmUMTxCHyaLTFsXmxGypzyZG9LMFQib9gNRHy31hoX8HTxusY/vK29PPMqs1cc4fFy1
 LBA/zZO79taWIlHXcMmOKS4ajacHQf4UO8K6C5qT1R3k8/8zUrMnUjfRhlFDF4LcTIWM
 pOHAU0LdZUhCVPDRGUvqb38/9k5Sew78rT6cc2BZvNNrohAWrARQ+HWQJfREarwDfh53
 j+pr5XoF1NgD64q6eZlny0a2JP1qH4i77ifWq4a6/Uu7G+3KnEohgbV1o++2DG0t7gv6
 MKkQ==
X-Gm-Message-State: AC+VfDx35HQxJP6tc5H9BBnUoHtqw6z6IakYpCxSwUOwlPx0JMkPVSp4
 P7zp66yty1ycTnAcrzS7p/I=
X-Google-Smtp-Source: ACHHUZ6Jg8ozhEpjSKSYFl80cr1OQx8ar/1bvYqAWjmOD2cJS8g6+gNkD/4dt8uGyQxFRVuLfIGT8g==
X-Received: by 2002:a05:6a20:12ca:b0:118:dfc1:4f90 with SMTP id
 v10-20020a056a2012ca00b00118dfc14f90mr5993738pzg.26.1686829606256; 
 Thu, 15 Jun 2023 04:46:46 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a63180a000000b0052c3f0ae381sm2886839pgl.78.2023.06.15.04.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 04:46:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 21:46:41 +1000
Message-Id: <CTD76STWP0IB.11UB5PDLZYKUP@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, <clg@kaod.org>, "Greg
 Kurz" <groug@kaod.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 09/10] target/ppc: Simplify syscall exception handlers
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.14.0
References: <cover.1686776990.git.balaton@eik.bme.hu>
 <ee7c07146e8e2e5a3d1d52aaf5a4eeef695c359d.1686776990.git.balaton@eik.bme.hu>
 <CTCWPOXSQZLU.275T4DDJIY90X@wheely>
 <6550e18f-b03d-134b-bc45-a947a25cf5de@eik.bme.hu>
In-Reply-To: <6550e18f-b03d-134b-bc45-a947a25cf5de@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

On Thu Jun 15, 2023 at 7:25 PM AEST, BALATON Zoltan wrote:
> On Thu, 15 Jun 2023, Nicholas Piggin wrote:
> > On Thu Jun 15, 2023 at 7:34 AM AEST, BALATON Zoltan wrote:
> >> After previous changes the hypercall handling in 7xx and 74xx
> >> exception handlers can be folded into one if statement to simpilfy
> >> this code.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >>  target/ppc/excp_helper.c | 26 ++++++++++----------------
> >>  1 file changed, 10 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> >> index 1682b988ba..662457f342 100644
> >> --- a/target/ppc/excp_helper.c
> >> +++ b/target/ppc/excp_helper.c
> >> @@ -740,26 +740,23 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, in=
t excp)
> >>          break;
> >>      case POWERPC_EXCP_SYSCALL:   /* System call exception            =
        */
> >>      {
> >> -        int lev =3D env->error_code;
> >
> > I would still keep lev. Self documenting and consistent with books
> > handler.
>
> lev is still there in the books version, but probably not really needed i=
n=20
> these 7xx versions which does not really have level parameter. This hack=
=20
> should likely go away and replaced with something else on the long run as=
=20
> this won't work with KVM but that needs some support from VOF or compilin=
g=20
> a different version for pegasos2 which wasn't considered so far. I can ad=
d=20
> the local back if you really insist but I don't think it really makes muc=
h=20
> sense in these cases for 7xx and 74xx.

It is using the sc 1 instruction which does have a lev field though? The
hardware might not have such a thing but what is being emulatd here
does, so I think lev makes sense.

Removing this would be fine, but while you have it yes please just leave
it as lev.

> >> +        PowerPCCPU *cpu =3D env_archcpu(env);
> >
> > Is this necessary?
>
> Yes, for cpu->vhyp below.

cpu->vhyp was there before your patch...

Thanks,
Nick

