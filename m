Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87076730C78
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 03:01:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9bMf-0003Jz-6s; Wed, 14 Jun 2023 21:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9bMd-0003JF-De; Wed, 14 Jun 2023 21:01:27 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9bMb-0002I3-QK; Wed, 14 Jun 2023 21:01:27 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-544c0d768b9so5162103a12.0; 
 Wed, 14 Jun 2023 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686790883; x=1689382883;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vH/WXODOmIy98dBl2mOicoCNcX8hlv1ZCu0sK5nORK8=;
 b=gWC464gnjdE81UKPXmtzrnubmDescVYjco+hWfNaS0OTzUeIn/nDwLTTZGfWc8bXda
 JKdlRxsHteTaCKFGbge/6GRnwJheV5zfQWdSGLQIWTzRB9//NgKDCcxW5TWqEho0dWkw
 rNjA98JjN7F+f0nK9PLqmz2Cbky540ZxcTvOqYPxA8S2AVR6cubpsmxIMX7mD/P2z+E+
 E9nRlU9WSN1Bzs/8n5JggRo/XWyieD6kztN0QEdi5/4vcmKC35Rde9sc8mXMlSORs+2n
 c3XXJabI/CBfThZneSUzXUcajnKuPr+neitv6rHQdRwk8P/ctLA4K7M1XKKvsH3G6Qpc
 UTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686790883; x=1689382883;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vH/WXODOmIy98dBl2mOicoCNcX8hlv1ZCu0sK5nORK8=;
 b=EVq9JbHEdUPOnJBp7/49JdzQ851hdqhRzUREgjTvZtDb5pujK+xoYbdYxS+NuFhAgd
 nOTqLAQq1+MJlxs6+tIObWMDg2riZcyt3QqYI+rEts38g89Rd3t3yLB/AD4hupfzTh39
 RGHddkZdV1qeaEcMMRjxnKcARyDWPSHX03JXfkq7N26M+Ryr2UON1W8W6Ed8ok7TrQ6n
 v7Rf38YHY0LpQS2kpyl//wpyLZF3wgUJUloKna3Um9hWzP7A8o6EcD/ApahiJ6FaJPRZ
 p3cMl31QYUBHq/UX938UYGIdXAWkF+mKYSpIP5vtzAmMjXEHrZn2QyDpDzGmhkPKXkAP
 37pQ==
X-Gm-Message-State: AC+VfDywhYNA2+qlnctecHYW6t3HfzAHigeNy6n/fo2iOYvaMlEiO68j
 +PUlg0JHpLsqRUQGphvD52o=
X-Google-Smtp-Source: ACHHUZ5N2XrYaJde8zT85t56EznBhcPoBGQc2mMrM+i6TlabySqv/ocM9HfMtHve884s+4MeWqIdvA==
X-Received: by 2002:a17:90a:8a95:b0:25c:2dc:361f with SMTP id
 x21-20020a17090a8a9500b0025c02dc361fmr3017584pjn.31.1686790883237; 
 Wed, 14 Jun 2023 18:01:23 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 28-20020a17090a031c00b0025c02ef91f6sm4849515pje.22.2023.06.14.18.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 18:01:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 11:01:18 +1000
Message-Id: <CTCTGNU6HWW8.3G84N87G7BWUN@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, <clg@kaod.org>, "Greg
 Kurz" <groug@kaod.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 04/10] target/ppc: Use env_cpu for cpu_abort in excp_helper
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <2323bc631817a134319fc1978531160986ecbe13.1686522199.git.balaton@eik.bme.hu>
 <CTC24VY5AQCR.2VUJY58072BV9@wheely>
 <439d20a4-f436-5007-9fa5-63d4162869a7@eik.bme.hu>
In-Reply-To: <439d20a4-f436-5007-9fa5-63d4162869a7@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x531.google.com
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

On Wed Jun 14, 2023 at 8:13 PM AEST, BALATON Zoltan wrote:
> On Wed, 14 Jun 2023, Nicholas Piggin wrote:
> > On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
> >> Use the env_cpu function to get the CPUState for cpu_abort. These are
> >> only needed in case of fatal errors so this allows to avoid casting
> >> and storing CPUState in a local variable wnen not needed.
> >
> > I don't entirely mind keeping cs around as a variable...
>
> What for? This was only needed for error messages so most of the time=20
> useless and having less locals make the function a bit simpler. If this i=
s=20

Declaring cs, cpu, env, etc at the start of the function is very common
though so it doesn't take much thinking. You don't even need to look at
the declaration to know what it is.

Thanks,
Nick

> needed for something else than errors later it could be added back but=20
> then it will only be in the model specific function that needs it.
>
> What I could change is to use CPU(cpu) instead of env_cpu(env) now that=
=20
> I've dropped the rest of the series that also changed the func parameter=
=20
> to get env instead of PowerPCCPU which may avoid some line breaks but not=
=20
> sure if that's any better.
>
> Regards,
> BALATON Zoltan
>
> > Thanks,
> > Nick
> >
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >>  target/ppc/excp_helper.c | 118 +++++++++++++++++++++-----------------=
-
> >>  1 file changed, 63 insertions(+), 55 deletions(-)
> >>
> >> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> >> index e4532f5088..51202f7028 100644
> >> --- a/target/ppc/excp_helper.c
> >> +++ b/target/ppc/excp_helper.c
> >> @@ -422,7 +422,6 @@ static void powerpc_checkstop_state(CPUPPCState *e=
nv)
> >>
> >>  static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
> >>  {
> >> -    CPUState *cs =3D CPU(cpu);
> >>      CPUPPCState *env =3D &cpu->env;
> >>      target_ulong msr, new_msr, vector;
> >>      int srr0, srr1;
> >
> > [snip]
> >
> >


