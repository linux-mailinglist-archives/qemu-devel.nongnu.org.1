Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F0174076D
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 03:05:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEJbM-0007fw-Tk; Tue, 27 Jun 2023 21:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEJbI-0007fJ-A2; Tue, 27 Jun 2023 21:04:04 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEJbG-0007SZ-Jc; Tue, 27 Jun 2023 21:04:04 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-553a998bca3so3920523a12.2; 
 Tue, 27 Jun 2023 18:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687914241; x=1690506241;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhZBOHesEoI4xRftBeYUk6t9VDR5W/80wDcDAni4Gyo=;
 b=Hxjur7lfpuNR3RN3zc/N80rAi49Tq6+Tyj8BkCWziuueG1Flp/jlo3HS2TrG4d/se7
 tEz09mHRtRPu3j3hTwxOg0q3gtmhzHN/i4OILapPcqQ6Dy6WS7IIm+3i7FRdRDfVHifI
 zpxZUfeARONfJv+OfRlg3CtWC6zCUh+G3IERAMT3Dc8XtffcFcX+cO+6rqNBaG+jzMom
 x6WXuuY0vOsKfSANmm1BMQhYuT5YjHBFodctbTyfQ5aqJRb9xkqwP2+q/1piewYJFICq
 YmLky32jfpSLEJx7EcWUbmexGujInA0vgO57Yj2ENE98KtmsSNc32IDAZjgmT1x+HYP3
 To0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687914241; x=1690506241;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nhZBOHesEoI4xRftBeYUk6t9VDR5W/80wDcDAni4Gyo=;
 b=dq8lZfj//rKcd1GeZKgp24Jz+1f+jp5M3RaFAtm6mSorc1CBkMS2lgGl62E+Bcpssk
 cC8qxDUbdd7Rqbb8HacBSWnfMIwq1KPD9jFLDgnsoiNswTpU4VDQqnqWFLLFZivJzCI9
 sDxZRvFXolOGSrJxfeuq5Uq9up/VNcMTTjbOvvAhp0VJDbmuB4hMR5T2g+O7xcE9nebH
 SxLnYhJfzY0y9x9w1KsSqMTPT7sJyoD+yMf1oIOKQc+yqaCGaRmwZ08M8sOoQ8rjCVva
 lPWJtXD/obmjSIMrwnhpHSltmzkdPghNpaWYKAEu0oKYyWOjxJzf5wNBRVjj0QkFBQKR
 93zg==
X-Gm-Message-State: AC+VfDzCs6C34y/5ZLUxr7ddX/vIn4+mfBgIX5U4TSLYbNkKylViJmq2
 naQIRc7KIGNoLOYTdmmpiyY=
X-Google-Smtp-Source: ACHHUZ5oDoGrw/SVKY1L6orUxyxfMy+CSbCqG/jxl5VKoLC9uTJ/7kzkqIdX+Et8olXXmDODnEavuw==
X-Received: by 2002:a17:90a:49c6:b0:263:11f8:a132 with SMTP id
 l6-20020a17090a49c600b0026311f8a132mr3928118pjm.36.1687914240549; 
 Tue, 27 Jun 2023 18:04:00 -0700 (PDT)
Received: from localhost (193-116-109-121.tpgi.com.au. [193.116.109.121])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a17090a658700b00262eccfa29fsm4508910pjj.33.2023.06.27.18.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 18:04:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jun 2023 11:03:55 +1000
Message-Id: <CTNVNQVXBXXU.L2P609T3RN13@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, <clg@kaod.org>, "Greg
 Kurz" <groug@kaod.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 09/14] target/ppc: Move patching nip from exception
 handler to helper_scv
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.15.2
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <b7317331ebccb0209fd0b12687945af6f626b0eb.1686868895.git.balaton@eik.bme.hu>
 <CTH6LN434MCH.2IK0QCFPCBW6F@wheely>
 <cd15856c-a664-66e6-cd27-65247784b3fe@eik.bme.hu>
 <CTMJMWCPZQX7.LVCEBEI5KXOE@wheely>
 <434967dc-b631-f1d2-0267-93695c1e806b@eik.bme.hu>
In-Reply-To: <434967dc-b631-f1d2-0267-93695c1e806b@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
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

On Wed Jun 28, 2023 at 3:40 AM AEST, BALATON Zoltan wrote:
> On Mon, 26 Jun 2023, Nicholas Piggin wrote:
> > On Tue Jun 20, 2023 at 8:47 PM AEST, BALATON Zoltan wrote:
> >> On Tue, 20 Jun 2023, Nicholas Piggin wrote:
> >>> On Fri Jun 16, 2023 at 9:03 AM AEST, BALATON Zoltan wrote:
> >>>> From: Nicholas Piggin <npiggin@gmail.com>
> >>>>
> >>>> Unlike sc, for scv a facility unavailable interrupt must be generate=
d
> >>>> if FSCR[SCV]=3D0 so we can't raise the exception with nip set to nex=
t
> >>>> instruction but we can move advancing nip if the FSCR check passes t=
o
> >>>> helper_scv so the exception handler does not need to change it.
> >>>>
> >>>> [balaton: added commit message]
> >>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>>
> >>> Ah you sent it, fine, thank you. But actually now I look again,
> >>> now we're off by one in the other direction for the dumps.
> >>
> >> This is mentioned in the commit message for the patch changing sc. I t=
hink
> >> we should not patch nip in the dump so we actually dump what the CPU
> >> should have and match the ISA docs.
> >>
> >>> So... probably your way is still better because it matches the
> >>> interrupt semantics of the ISA when executing the instruction,
> >>> but it needs this patch:
> >>
> >> OK so then I'm confused why we need nip - 4 in dumps?
> >
> > Sorry I missed your reply here. We want nip - 4 in dumps so the
> > address of the syscall is the sc instruction itself, not the
> > random one after it.
>
> Although that's how it was in QEMU before

Current upstream QEMU dumps syscall address of sc instruction. After
patch 8 and 9, it will dump the address of the instruction after it.

> that's not how it is on real=20
> hardware so I don't think we should keep this and just log what a real CP=
U=20
> would have and people should know how to interpret that after consulting=
=20
> the ISA docs.

I did get the feeling it was nicer your way, OTOH there really is not
anything in the ISA that requires a particular implementation. QEMU is
a real implementation of the ISA anyway. You could argue it's more
consistent for QEMU to keep env->nip as the address of instruction that
caused the interrupt, and then the sc fixup is restricted to setting
SRR0. I'm on the fence about it now.

Thanks,
Nick

