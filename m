Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57771737F56
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:15:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuqr-0006CT-Hf; Wed, 21 Jun 2023 06:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBuqd-0006AT-1i; Wed, 21 Jun 2023 06:14:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBuqa-0007RJ-WC; Wed, 21 Jun 2023 06:13:58 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6689430d803so1459752b3a.0; 
 Wed, 21 Jun 2023 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687342435; x=1689934435;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Esuk0ckXGn7W+ZI+ReRMcD3DyOzy36hwcRszJy2GSc=;
 b=eArc9TliOP3yF836J3vxtsT4Kop2CXiKCiBXrwceMQv8hSpxWVNP/3iQbqOdL+1jA3
 CD2s4qIOMnLIngFrz0dd80ZDk9BWgSj1VfK82klNFfIwv6Fhxhq3LWU6N+3uQCS1t2mg
 DQZ0SuOEKbmfMhix1Z4g0LQBoPmyMJV/FbXEfBdXag6Be/7x/iuhngTrKYm4ORwAmbA9
 CQG3rMEpcaJOt98aN4AwbP2/OfgV6fOQ4Rm761PgOpsOmmvJifATS36ySGtInBbpGMlH
 rEpOQKPLm/eB+iG9rxbH9oB2Q2xVinetaDoLj5D2XoWgHlRc9HCQHVSm2H9K915UIZbY
 5hqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687342435; x=1689934435;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4Esuk0ckXGn7W+ZI+ReRMcD3DyOzy36hwcRszJy2GSc=;
 b=d59rmifxsdCOAUZV2dMzdM6pPQdnAVHpxTumI03bIbNtsdJIHY1zj+5Y4H54vQwv0o
 Fd8f8b/rqDS9tUArdp5EbBW2GEmFjbyP+rbkMOMQkJUJBLht0AGdXhQHmtyxmAMN+2BV
 A8tRWBpU2tgMPHLZuxnxaWbqNtlgErQW4RBttIG69D/s0oZ1TxDNZOul1GGlqz4kNpKf
 +cVws3/pnnurZItKTBue6uoG9cHszyeONPSZTLG877tavIbJHahy/M5FxPJh1bWuc5eW
 TpYeL8Aj9Hy2usY8tbontg1zmG0SONcLCSnphxk3wWpeDPiuFoNE4HC4sgSy46Ich6li
 K78g==
X-Gm-Message-State: AC+VfDy/svnhTV/AvR/5xa9bHnlCcGIGgCXqvAksqvcxzCBzeyFvdbFu
 RdMKIcJaMXRSN9XH9BiSXpg=
X-Google-Smtp-Source: ACHHUZ64sWvm0/NDvPXvNh/ZAt3oC0EOEL7hJIhi96CeETsUL5zoAe5Eas6xYA2CKqaMq1nd4JMH3Q==
X-Received: by 2002:a05:6a21:6d96:b0:121:56aa:82d6 with SMTP id
 wl22-20020a056a216d9600b0012156aa82d6mr9606141pzb.22.1687342434799; 
 Wed, 21 Jun 2023 03:13:54 -0700 (PDT)
Received: from localhost (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 bd6-20020a170902830600b001a525705aa8sm3126039plb.136.2023.06.21.03.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 03:13:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jun 2023 20:13:49 +1000
Message-Id: <CTI8YYVN0BH5.1AEWH9GLUG3FY@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH] target/ppc: Add ISA v3.1 LEV indication in SRR1 for
 system call interrupts
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230620131321.169261-1-npiggin@gmail.com>
 <a3dce513-d55a-7116-c6f8-5d30e4f3d131@linux.ibm.com>
In-Reply-To: <a3dce513-d55a-7116-c6f8-5d30e4f3d131@linux.ibm.com>
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

On Wed Jun 21, 2023 at 6:31 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 6/20/23 18:43, Nicholas Piggin wrote:
> > System call interrupts in ISA v3.1 CPUs add a LEV indication in SRR1
> > that corresponds with the LEV field of the instruction that caused the
> > interrupt.
> >=20
>
> Did we encounter any issue without this patch leading to this fix?

No, I just noticed it.

> If so, it will be great to talk about it in short if possible.
>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > This is unchanged, just taken out of the bigger series since it is
> > independent.
> >=20
> > Thanks,
> > Nick
> >=20
> >   target/ppc/excp_helper.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >=20
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index 77bfc18734..c7550fea13 100644
> > --- a/target/ppc/excp_helper.c
> > +++ b/target/ppc/excp_helper.c
> > @@ -1591,6 +1591,10 @@ static void powerpc_excp_books(PowerPCCPU *cpu, =
int excp)
> >               vhc->hypercall(cpu->vhyp, cpu);
> >               return;
> >           }
> > +        if (env->insns_flags2 & PPC2_ISA310) {
> > +            /* ISAv3.1 puts LEV into SRR1 */
> > +            msr |=3D lev << 20;
>
> Since LEV values greater than 2 are reserved, should we do:
>                 msr |=3D (lev <=3D 2) ? lev << 20 : 0;

Oh good point. Actually I think we want this which would be a
separate patch going before this one, as it is a fix for sc
even for pre-v3.1:

Thanks
Nick

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 15a00bd4fa..297159280e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4424,7 +4424,18 @@ static void gen_sc(DisasContext *ctx)
 {
     uint32_t lev;

-    lev =3D (ctx->opcode >> 5) & 0x7F;
+    /*
+     * LEV is a 7-bit field, but the top 6 bits are treated as a reserved
+     * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but that
+     * is for Ultravisor is not not supported, so keep using 6 and 1.
+     */
+    lev =3D (ctx->opcode >> 5) & 0x1;
     gen_exception_err(ctx, POWERPC_SYSCALL, lev);
 }


