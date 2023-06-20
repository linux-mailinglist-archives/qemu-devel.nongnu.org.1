Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 166C4737228
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:56:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBedB-0007w0-UF; Tue, 20 Jun 2023 12:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBed7-0007uv-F4; Tue, 20 Jun 2023 12:54:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBed5-00069s-OZ; Tue, 20 Jun 2023 12:54:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b50d7b4aaaso21519355ad.3; 
 Tue, 20 Jun 2023 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687280093; x=1689872093;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QP1abaxkkYbrV6B8GhKmCODns4qIHDBEp80+ZYA6tU=;
 b=IcalvPFLl0SdcCd+TP7nPLh7W1qTMJx4AEQaMhU6udTNVtWbVtlP3b9vdfRdBP7MGv
 yndzhsgOGWqBxegQyzfKMn3yBLFg4W74J+FBMYJ5dW2PnzE/Lu8cKIc042HfdvC9T0MQ
 kO58zAw2mis+50xd5xMzzjlzNKZXFOL3IEDkfh3x5pBwAGT7Ojnojw/u6SMtTxKO+8Bf
 0jciSkE/HjFY9m8T9J854X+PFITsJj54n8M8IbcIjFcegc8tzzuQW8UV5bErLD9+nFlO
 8UlmSem4VsxA1KGrZtLsop2dW6N3Pk2A7qSnp+i/0cd4BRrjsixh9AhpyTF6+nkQEiL9
 mDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687280093; x=1689872093;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4QP1abaxkkYbrV6B8GhKmCODns4qIHDBEp80+ZYA6tU=;
 b=IX8CyxTyR/8n6P4pop0HEhbl2xZAs89RgPabe3WtD6mV363Pis5TnNPyRAHzY1prkL
 Wd7qy0sL0WLkCL2dgyAIlhHKhXiurdFklLjLQ3sjGc5FUP3hMe/oMKOqMbx1aAAjNbkz
 Tf/aBd9XFGGak56DgktfdiLiTCf19dcHrsKmCF2ciE/oDW79t1aVAMqpTUOfo2LrEatl
 t2/Na/uXx2xkxPZmyRt7XIty5VsCPNWMaBUNSHaer2kctk7eIm8Bx7iDB8M9ni7xgRGb
 kd5xBG8mMiKTs77DVuqaoRc8+cilynkBjUePPWNB1uhcMK2ZYGnStokqlrlwPLsp6wcl
 VGww==
X-Gm-Message-State: AC+VfDxaKO3KisRMqj6WZS4nRTsj3InudTfI1LZ3WsUfPWk+j6aK6ZjF
 MaSI/FVFa1uQus8IUWY0/As=
X-Google-Smtp-Source: ACHHUZ4pxcPBfBdYz1Via7MELhyvTSETbXM+kPMvzwD0GdCEeP/4XqYGv3V7FXCtnCcnrJftjeQOtw==
X-Received: by 2002:a17:903:25cf:b0:1b0:499f:7a8d with SMTP id
 jc15-20020a17090325cf00b001b0499f7a8dmr7718715plb.9.1687280093425; 
 Tue, 20 Jun 2023 09:54:53 -0700 (PDT)
Received: from localhost ([124.170.190.103]) by smtp.gmail.com with ESMTPSA id
 u14-20020a170902e80e00b001a95f632340sm1884726plg.46.2023.06.20.09.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 09:54:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jun 2023 02:54:47 +1000
Message-Id: <CTHMVFHEA2B4.3968LCTW14GHR@wheely>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 "Anushree Mathur" <anushree.mathur@linux.vnet.ibm.com>, "Fabiano Rosas"
 <farosas@suse.de>
Subject: Re: [PATCH 1/4] target/ppc: Fix instruction loading endianness in
 alignment interrupt
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.14.0
References: <20230620131044.169110-1-npiggin@gmail.com>
 <20230620131044.169110-2-npiggin@gmail.com>
 <393305f2-e785-c3f6-523f-6826b3511cc4@eik.bme.hu>
In-Reply-To: <393305f2-e785-c3f6-523f-6826b3511cc4@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

On Wed Jun 21, 2023 at 12:26 AM AEST, BALATON Zoltan wrote:
> On Tue, 20 Jun 2023, Nicholas Piggin wrote:
> > powerpc ifetch endianness depends on MSR[LE] so it has to byteswap
> > after cpu_ldl_code(). This corrects DSISR bits in alignment
> > interrupts when running in little endian mode.
> >
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > target/ppc/excp_helper.c | 22 +++++++++++++++++++++-
> > 1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index 12d8a7257b..a2801f6e6b 100644
> > --- a/target/ppc/excp_helper.c
> > +++ b/target/ppc/excp_helper.c
> > @@ -133,6 +133,26 @@ static void dump_hcall(CPUPPCState *env)
> >                   env->nip);
> > }
> >
> > +#ifdef CONFIG_TCG
> > +/* Return true iff byteswap is needed to load instruction */
> > +static inline bool insn_need_byteswap(CPUArchState *env)
> > +{
> > +    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is s=
et */
> > +    return !!(env->msr & ((target_ulong)1 << MSR_LE));
> > +}
>
> Don't other places typically use FIELD_EX64 to test for msr bits now? If=
=20

Yeah I should use that, good point. There's at least another case in
that file that doesn't use it but I probably added that too :/

> this really only tests for the LE bit and used only once do we need a new=
=20
> function for that? I don't quite like trivial one line functions unless i=
t=20
> does something more complex Because if just makes code harder to read as =
I=20
> have to look up what these do when I could just see it right away where i=
t=20
> used without these functions.

It's based on mem_helper.c, which is familiar pattern/name so I=20
might keep it. Maybe not, I'll check. I'm on the fence.

> > +
> > +static uint32_t ppc_ldl_code(CPUArchState *env, hwaddr addr)
> > +{
> > +    uint32_t insn =3D cpu_ldl_code(env, addr);
> > +
> > +    if (insn_need_byteswap(env)) {
> > +        insn =3D bswap32(insn);
> > +    }
> > +
> > +    return insn;
> > +}
> > +#endif
>
> Along the same lines I'm not sure this wrapper is needed unless this is a=
=20
> recurring operation. Otherwise you could just add the if and the comment=
=20
> below at the single place where this is needed. If this will be needed at=
=20
> more places later then adding a function may make sense but otherwise I'd=
=20
> avoid making code tangled with single line functions defined away from=20
> where they are used as it's simpler to just have the if and swap at the=
=20
> single place where it's needed than adding two new functions that I'd had=
=20
> to look up and comprehend first to see what's happening. (It also would b=
e=20
> just 3 lines instead of 20 that way.)

It does get used in a couple more places later. Few-line
"abstraction" used once isn't necessarily wrong though.

Thanks,
Nick

