Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43951737AAC
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 07:44:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBqcI-0006bH-GE; Wed, 21 Jun 2023 01:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBqcE-0006ad-Jb; Wed, 21 Jun 2023 01:42:51 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBqcD-00079r-2O; Wed, 21 Jun 2023 01:42:50 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-3ff22072856so25387311cf.3; 
 Tue, 20 Jun 2023 22:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687326165; x=1689918165;
 h=in-reply-to:references:message-id:to:from:subject:cc:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIMYrDqJWebxm9R1xnKcJDFQnFugU/m3Z6y9mYIO2kI=;
 b=qfnK18ehPgbVYgNGQcwoTONQtCdhdF3P70yOubkhj9bipAvs2bKN1LJqSe6CHXZaPE
 6ZpK1zQKm442/sCPcpQUEm8TskjzfgZPNiOwV6ch6IzoBMC/RQktIgJ5YZujg0tJ51Pk
 c/pjFED6TWqsmmOVVOZHQgVLw+B1rqHTnKp/rMu9vxaeTY++Qvm0gNlAC6jcQxH8LdyG
 6T7QQYIt8uZm06QVpav/Z51JdwKVvpJ6XarVYntZi3jDJIyz+Rm1B7arift/Rg+6cDtm
 QK0p/iXegyviE3ZUz9DdHNDGTYqsQhtiyZ8kJ/umhv2/Stl0i/QGuOOJu1jHiP+3VVaV
 J3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687326165; x=1689918165;
 h=in-reply-to:references:message-id:to:from:subject:cc:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wIMYrDqJWebxm9R1xnKcJDFQnFugU/m3Z6y9mYIO2kI=;
 b=hric8eLNh0Pc5fF4X1AxYy3xx+HqxObpOP1Vo7fkw0/CgCl732e7hillruS74l4Xip
 tM1hd0uc3YLFtacZUendNkgpe3nGHb2kJpkBFa+cq8k3h1JAjSA/L5Bm4QK/+b4DpMEE
 wAXRTdOrnNxXEizDJoXpCTo61j5TAN18w3FG8pHE1W+ZsahaV2pGEk9VVThtdzGCOrE+
 E3s5aws038lXS+52/2Fust6pGZzSu4hfSOLru42kGkcjqv/VFI6V+Odjuo8ZgUKyFVPp
 RCu8SzpaX/ou+0DZ48nIfKpRsJN47tkJ+9lmdufI1j5nWwRRHRQXuso0CJeSWyvoW++X
 +fBg==
X-Gm-Message-State: AC+VfDyFV3O4X8q7V1X78q6n0nNP6ozwosoOG7tRXaz4wsZy1uxvjfAh
 E9X6ExZcaTK9TKkrgY4yn8Y=
X-Google-Smtp-Source: ACHHUZ6LZPRktygpvsLkP+qxLmhfrXO+kJ9etTHc96doDCRudfFePTb9qkkJqTyBsxwRuOojUuEDpg==
X-Received: by 2002:ac8:5b91:0:b0:3ff:2cc2:3f54 with SMTP id
 a17-20020ac85b91000000b003ff2cc23f54mr5009933qta.9.1687326165442; 
 Tue, 20 Jun 2023 22:42:45 -0700 (PDT)
Received: from localhost ([1.145.207.60]) by smtp.gmail.com with ESMTPSA id
 j10-20020a17090a2a8a00b0025e2358f146sm8711817pjd.13.2023.06.20.22.42.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 22:42:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jun 2023 15:41:54 +1000
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 "Anushree Mathur" <anushree.mathur@linux.vnet.ibm.com>, "Fabiano Rosas"
 <farosas@suse.de>
Subject: Re: [PATCH 1/4] target/ppc: Fix instruction loading endianness in
 alignment interrupt
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, "BALATON Zoltan"
 <balaton@eik.bme.hu>
Message-Id: <CTI332CVP3JK.3AG3PF04TUWGH@wheely>
X-Mailer: aerc 0.14.0
References: <20230620131044.169110-1-npiggin@gmail.com>
 <20230620131044.169110-2-npiggin@gmail.com>
 <393305f2-e785-c3f6-523f-6826b3511cc4@eik.bme.hu>
 <CTHMVFHEA2B4.3968LCTW14GHR@wheely>
In-Reply-To: <CTHMVFHEA2B4.3968LCTW14GHR@wheely>
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=npiggin@gmail.com; helo=mail-qt1-x830.google.com
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

On Wed Jun 21, 2023 at 2:54 AM AEST, Nicholas Piggin wrote:
> On Wed Jun 21, 2023 at 12:26 AM AEST, BALATON Zoltan wrote:
> > On Tue, 20 Jun 2023, Nicholas Piggin wrote:
> > > powerpc ifetch endianness depends on MSR[LE] so it has to byteswap
> > > after cpu_ldl_code(). This corrects DSISR bits in alignment
> > > interrupts when running in little endian mode.
> > >
> > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > > target/ppc/excp_helper.c | 22 +++++++++++++++++++++-
> > > 1 file changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > > index 12d8a7257b..a2801f6e6b 100644
> > > --- a/target/ppc/excp_helper.c
> > > +++ b/target/ppc/excp_helper.c
> > > @@ -133,6 +133,26 @@ static void dump_hcall(CPUPPCState *env)
> > >                   env->nip);
> > > }
> > >
> > > +#ifdef CONFIG_TCG
> > > +/* Return true iff byteswap is needed to load instruction */
> > > +static inline bool insn_need_byteswap(CPUArchState *env)
> > > +{
> > > +    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is=
 set */
> > > +    return !!(env->msr & ((target_ulong)1 << MSR_LE));
> > > +}
> >
> > Don't other places typically use FIELD_EX64 to test for msr bits now? I=
f=20
>
> Yeah I should use that, good point. There's at least another case in
> that file that doesn't use it but I probably added that too :/

This incremental patch fixes it:

Thanks,
Nick

---
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index ff7166adf9..cfdbeb0da5 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -138,7 +138,7 @@ static void dump_hcall(CPUPPCState *env)
 static inline bool insn_need_byteswap(CPUArchState *env)
 {
     /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set *=
/
-    return !!(env->msr & ((target_ulong)1 << MSR_LE));
+    return FIELD_EX64(env->msr, MSR, LE);
 }
=20
 static uint32_t ppc_ldl_code(CPUArchState *env, hwaddr addr)

