Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61929730D23
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 04:20:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9cZE-0007Gu-4G; Wed, 14 Jun 2023 22:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9cZ5-0007GK-Pl; Wed, 14 Jun 2023 22:18:23 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9cZ3-0004Wq-Ky; Wed, 14 Jun 2023 22:18:23 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-25e89791877so446643a91.2; 
 Wed, 14 Jun 2023 19:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686795499; x=1689387499;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRqgkiTdepNvQ8Hg5bFUAeZzPlfYHzx5R+qJNPGDrQE=;
 b=POQ+anvPIiRKjbIdCrm2rx1WNTfZ7QuVfhNIIHNwFJdJi4cLy7MLTu2ShcKRz8IUyR
 pVws/tnTKi+NJEOAVJx3MlQQPo+dFC1sfVC+JkZdC85ffSDW3VDEKKvB/wUnHJ9ShZju
 1NVYRRRa6kflYVBimCzfDeSpP/XhbQVYmHF/Z+t4thJjRaB15GGS3hTenyf/SKPRLRle
 cHfUyhrwlYlmrUpzqfQCOVWGl03KtgDfcqW5bhy3Qmu6ATENcnBKtg6B5BfLqbEpFb+m
 5ypohTg54OGfHgi1S10B4vX1ICEDjSVSi+idRvoo6TtTXUUSXl6kbOvSg92RHYqyZtQc
 iUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686795499; x=1689387499;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GRqgkiTdepNvQ8Hg5bFUAeZzPlfYHzx5R+qJNPGDrQE=;
 b=Zb8NVNeSl2qzZHz0voJKKb8GHFxfKU1vZTzNdzr0yB1uQ4ykyxuksVJmAJ44jPKBxz
 fj1iKLxrhv5LrsUc5JM6NJDF3/WNKwIhhUt0qRvs2CIQ5pJx2LJKyfw3F2OuMFD04jeg
 rxxiBQ5u7nJ0sZgXkJM7406XKKeaGixpLZnjH19IZuu5y5D8OQMEoGAmqrzeuk5N4M8S
 HTJN/mJNHxCY+67kd6PIMvByIvbFniP6g/ecdGJ6fMI0CfNadGwqWyK9Jr31nva9Z4wZ
 lHieqtlQbyxEx49hVQjROP+SHVudk8Q7gF9cu0QFIrOKVzhoJzf4V3jtJ8JvI7HrN5Dn
 cDKA==
X-Gm-Message-State: AC+VfDyWthsBE83WDlnQUnSlNA+OLW1vDzEwTbbU+R4sIw7q1pm1raNh
 wHsvSxXNg/WBUcS2XKA25vE=
X-Google-Smtp-Source: ACHHUZ6pM7+OmbrMzj0XRasj/v+ygXsPOU1kNrjMfuRyJSl+kFG4CFrRl/TaiCacVFGyl3wPG9FhMg==
X-Received: by 2002:a17:90a:1002:b0:259:1812:c9f9 with SMTP id
 b2-20020a17090a100200b002591812c9f9mr2705965pja.1.1686795499462; 
 Wed, 14 Jun 2023 19:18:19 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a170902e74e00b001b39e866324sm9056875plf.306.2023.06.14.19.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 19:18:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 12:18:13 +1000
Message-Id: <CTCV3K9JWBVQ.3R7AH302X3VHQ@wheely>
Subject: Re: [PATCH 0/4] ppc/pnv: Add chiptod and core timebase state
 machine models
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "Frederic Barrat"
 <frederic.barrat@fr.ibm.com>, "Michael Neuling" <mikey@neuling.org>
X-Mailer: aerc 0.14.0
References: <20230603233612.125879-1-npiggin@gmail.com>
 <e3f591df-6569-b396-0cf7-0ea62aee9f0c@kaod.org>
 <CTC47NS1KELC.35U22YEEW26UP@wheely>
 <e2e88fc1-8099-7eab-b51b-8212063fa6a5@kaod.org>
In-Reply-To: <e2e88fc1-8099-7eab-b51b-8212063fa6a5@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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

On Wed Jun 14, 2023 at 6:54 PM AEST, C=C3=A9dric Le Goater wrote:
> On 6/14/23 07:14, Nicholas Piggin wrote:
> > On Tue Jun 6, 2023 at 11:59 PM AEST, C=C3=A9dric Le Goater wrote:
> >> On 6/4/23 01:36, Nicholas Piggin wrote:
> >>> This adds support for chiptod and core timebase state machine models =
in
> >>> the powernv POWER9 and POWER10 models.
> >>>
> >>> This does not actually change the time or the value in TB registers
> >>> (because they are alrady synced in QEMU), but it does go through the
> >>> motions. It is enough to be able to run skiboot's chiptod initialisat=
ion
> >>> code that synchronises core timebases (after a patch to prevent skibo=
ot
> >>> skipping chiptod for QEMU, posted to skiboot mailing list).
> >>>
> >>> Sorry there was some delay since the last posting. There is a bit mor=
e
> >>> interest in this recently but feedback and comments from RFC was not
> >>> forgotten and is much appreciated.
> >>>
> >>> https://lists.gnu.org/archive/html/qemu-ppc/2022-08/msg00324.html
> >>>
> >>> I think I accounted for everything except moving register defines to =
the
> >>> .h file. I'm on the fence about that but if they are only used in the=
 .c
> >>> file I think it's okay to keep them there for now. I cut out a lot of
> >>> unused ones so it's not so cluttered now.
> >>>
> >>> Lots of other changes and fixes since that RFC. Notably:
> >>> - Register names changed to match the workbook names instead of skibo=
ot.
> >>> - TFMR moved to timebase_helper.c from misc_helper.c
> >>> - More comprehensive model and error checking, particularly of TFMR.
> >>> - POWER10 with multi-chip support.
> >>> - chiptod and core timebase linked via specific state instead of TFMR=
.
> >>
> >>
> >> The chiptod units are not exposed to the OS, it is all handled at FW
> >> level AFAIK. Could the OPAL people provide some feedback on the low le=
vel
> >> models ?
> >=20
> > Well, no takers so far. I guess I'm a OPAL people :)
> >> I did some of the P10 chiptod addressing in skiboot, at least. This
> > patch does work with the skiboot chiptod driver at least.
>
> cool, with 2 chips ?

Yes it worked with 2 chips.

> > I would eventually like to add in the ability to actually change the
> > TB with it, and inject errors and generate HMIs because that's an area
> > that seem to be a bit lacking (most of such testing seemed to be done
> > on real hardware using special time facility corruption injection).
>
> The MCE injection was a nice addon
>
>    https://lore.kernel.org/qemu-devel/20200325144147.221875-1-npiggin@gma=
il.com/
>    https://lore.kernel.org/qemu-devel/20211013214042.618918-1-clg@kaod.or=
g/
>
> I hope it will get more attention if you resend.

Will take another look.

> > But yes for now it is a bit difficult to verify it does much useful
> > aside from booting skiboot (+ patch to enable chiptod on QEMU I posted
> > recently).
>
> It's difficult to review PATCH 4 without some good knowledge of HW. I kno=
w
> you do but you can not review your own patches ! That said, the impact is
> limited to PowerNV machines, I guess we are fine.

Yeah. I appreciate all the review so far. It's pretty complicated even
with the workbook. I might be able to add a simpler and higher-level
description of the basic init sequence and states. You would still have
to trust me, but it might make it easier to see what's going on.

Thanks,
Nick

