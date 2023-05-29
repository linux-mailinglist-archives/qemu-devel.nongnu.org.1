Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39088714522
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 09:02:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Ws2-0001fq-0O; Mon, 29 May 2023 03:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1q3WrV-0001dP-II
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:00:15 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1q3WrT-0007jI-DT
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:00:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f6e1393f13so18934435e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 00:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1685343608; x=1687935608;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LnaYCOMQqiE7G8OhJz2yhJFowz0h16734vhii+mfv+Y=;
 b=MqaiYxnCzrdiV7Xi01FNR45AA9HlQmj5YbXq/U5nRwyYe4TJS990CZn16Ujtbnqk8N
 SJs4o1wrL1+RvlbXXy3voioLIjsqBj5IQj+jwjorE0JHS5kklqyWuXbZR6l22ah++IDe
 geGDbzEKvdRkW9BsDLjp43mwj85n6OIdROhFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685343608; x=1687935608;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LnaYCOMQqiE7G8OhJz2yhJFowz0h16734vhii+mfv+Y=;
 b=eM+Kyod7HqGx3Y78K24koCbq3dnTza2OPuHsB8HpDQP5mcA71C0PSd/QtTmkPQag75
 Bs+WY9dQ2zWP3/mi+Tx1L7Bv9swIdoIzeMJ784qpFSN6L5cu2mQmNpJO+rLyTJdpoKrK
 bAPBjZhQbxVN5pIsv7uaEa02AdjzIhgiJaVDkuM4bZ8+/D1/sJjFYNrkx4qSrIFrYtRt
 9iSLAwvHYC+65z7ysfJEQyDRXTR0HeHd8ghWLX3d+EuJvNfuzRXGHzCmq4u+h7ZL/LyO
 5GFBwqKQRB+lI647JObbCnkI9CZiiLHDc3CQS69yVr03j5Io+8zSR8ly4L+baRPrdZe0
 qEbw==
X-Gm-Message-State: AC+VfDxAhj5VnW8eDJ9y7UIzeNctD6WxILuNTr/Ybl4EwxRzzYFF0x8Y
 I2SMdvD3yOvTLqo1iG1FL6KXkQ==
X-Google-Smtp-Source: ACHHUZ54iWEsLTmHwzxtYNhr8U6OgExZ2LTTTqkEU0rQ3lZMxorrXg1VrOY7ikmoBh5eUphP2meOKA==
X-Received: by 2002:a05:600c:2055:b0:3f6:456:1d2c with SMTP id
 p21-20020a05600c205500b003f604561d2cmr7905816wmg.10.1685343608564; 
 Mon, 29 May 2023 00:00:08 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ec8d:e49e:8d5e:e7d5?
 ([2001:8b0:aba:5f3c:ec8d:e49e:8d5e:e7d5])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a7bcd0d000000b003f60d0eef36sm16848993wmj.48.2023.05.29.00.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 00:00:08 -0700 (PDT)
Message-ID: <f779810abd84d1aae7789f93518f1ac4d1662f4d.camel@linuxfoundation.org>
Subject: Re: [PULL 00/10] ppc queue
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org,  Bernhard Beschow <shentey@gmail.com>
Date: Mon, 29 May 2023 08:00:07 +0100
In-Reply-To: <CSYJTOIIC83Z.2KLRXWGXHXCW5@wheely>
References: <20230528164922.20364-1-danielhb413@gmail.com>
 <2ccafb44-d09a-e71c-005b-9a36f128b275@tls.msk.ru>
 <CSYEG7TJD7S7.IYIJXRKLWCZA@wheely>
 <c66df357-d647-1335-7a7e-70e602dd44bb@tls.msk.ru>
 <CSYJTOIIC83Z.2KLRXWGXHXCW5@wheely>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.purdie@linuxfoundation.org;
 helo=mail-wm1-x333.google.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 2023-05-29 at 16:30 +1000, Nicholas Piggin wrote:
> On Mon May 29, 2023 at 4:01 PM AEST, Michael Tokarev wrote:
> > 29.05.2023 05:18, Nicholas Piggin wrote:
> > ..
> >=20
> > > > 01/10 target/ppc: Fix fallback to MFSS for MFFS* instructions on pr=
e 3.0 ISAs
> > > > 02/10 target/ppc: Fix width of some 32-bit SPRs
> > > > 03/10 target/ppc: Alignment faults do not set DSISR in ISA v3.0 onw=
ard
> > > > 05/10 hw/ppc/prep: Fix wiring of PIC -> CPU interrupt
> > > >=20
> > > > Or are these not important for -stable?  Or maybe there are other c=
hanges
> > > > which should be picked too?
> > >=20
> > > They certainly fix some parts of target emulation, but what is the
> > > guidance for backporting those type of fixes? Most of the patches I s=
ent
> > > including 2,3 were just found from inspection or new test code and no=
t
> > > real software failing.
> > >=20
> > > Should just simple ones go in? 32-bit SPRs do not fix entirely the
> > > behaviour of all SPRs, just one aspect. In another fix I had (that
> > > didn't make it in this merge), was a bit more complicated and the
> > > first iteration caused a deadlock that didn't show up in basic test
> > > like booting Linux.
> > >=20
> > > My guess is that fixes that correct an issue with real software runni=
ng
> > > on the target should be ported to stable. Perhaps "obviously correct"
> > > small fixes as well. But not sure about larger changes.
> >=20
> > This is exactly why I asked, - because I don't clearly understand how
> > important these to have in -stable. And also to remind that -stable
> > exist, just in case.. ;)
>=20
> Ah okay, makes sense. I was just clarifying myself since I wasn't
> too sure.
>=20
> > So be it, no actual issue so not applying to -stable.
>=20
> I will think about it and try to keep -stable in mind. Of my patches
> there are one or two coming up that could probably go in there, if
> not these ones.

1/10 from me (fallback to MFSS) did fix software failures for Yocto
Project so might be a good candidate for stable. We're carrying that
patch against the last release for now.

Cheers,

Richard



