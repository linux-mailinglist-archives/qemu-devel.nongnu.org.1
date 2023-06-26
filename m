Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC973EF53
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 01:30:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDvdl-0002OE-CL; Mon, 26 Jun 2023 19:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDvdf-0002NL-NT; Mon, 26 Jun 2023 19:28:56 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDvdd-0001ms-VY; Mon, 26 Jun 2023 19:28:55 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b80b514fb7so8137305ad.0; 
 Mon, 26 Jun 2023 16:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687822132; x=1690414132;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVqZVh7oGLJ0/nTdJdAjE8VOoAjq2hwvklvpQQpM3M0=;
 b=b3btBxo8csd0k+HKLzgyQ79+nHRzWoP+wLlYlrsUiU5/8WeR5J4ZpeN6e3ygX5GxuU
 lw/mlYvbWBK+HG+RsD+AJ9ghUmXksFEZrPD3D0MJXR9JwwUPnCAvthF+U7J3jSU8pmLB
 zOmb711ocr/h4P2mjIqEXOSE7RB95WymwAQ8plYgu82vODtYw4IFATqFqYxJ/wZc3Rup
 mu4zVmrYWna0WpEI4Ng4vD7botuL7hq3bOe2R/xZ2kisaX7/YMBnU2+dqPLKRRSue4RQ
 xulH9KRxIX3vJA6SCbwicC1U1G1+bKm7oWyNoV/La7TVwEpEcOJjwvlskeSPHMAcgQzQ
 kVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687822132; x=1690414132;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uVqZVh7oGLJ0/nTdJdAjE8VOoAjq2hwvklvpQQpM3M0=;
 b=NPOsHE9Q3rmRleh1Uwsb9vBKrs/lszI9hAeFcfKg1u7AtMrooOpJKor6k7r172MS3m
 j+zIeGeip9z49hJEUVgpsHKERiFRI+QrW1h/GQwRP0lOiLPo9a8pXQNe2yD6PkhK7J02
 wpjiPekh1/q19sqja+CY1VgNrnQGdrNA1fmDBeoNtxC59JTpA9MHOSYSwQNB3mJz/Sgb
 DSSJf5CIcO33noUNeryzVlkg6Tinis74SPxqdQQYduBY167NoBEbVVC1Hyt1aKaJGKFn
 MUo0pFs7RenQhXXPsniyI1qX8BJAcBYK3ccHS7puS6/VHswTWzae3+xrtRjLpdn9rIf2
 OWVQ==
X-Gm-Message-State: AC+VfDyenBZf2gFer9Ky5M127kxIvaVCK26uPtW7hrZmTGuZ4khwe7LN
 iL5XWZcp9nrrndKPKs1RPgpnzhb/eN4=
X-Google-Smtp-Source: ACHHUZ5Cin19Uj9qR4l8NFtbX8Aarr2JsbHeHAipik34oJcUItqFI5q5HyeHdIq5pPQC/l95eWMsIg==
X-Received: by 2002:a17:902:e5c3:b0:1b6:bced:1dd6 with SMTP id
 u3-20020a170902e5c300b001b6bced1dd6mr6544104plf.35.1687822132197; 
 Mon, 26 Jun 2023 16:28:52 -0700 (PDT)
Received: from localhost (14-200-238-131.tpgi.com.au. [14.200.238.131])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a170902b49100b001b54dcd84e2sm4654424plr.240.2023.06.26.16.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 16:28:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jun 2023 09:28:44 +1000
Message-Id: <CTMZ0C10RKTF.3SZX1ZENHXLGY@wheely>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "BALATON Zoltan" <balaton@eik.bme.hu>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "David Gibson" <david@gibson.dropbear.id.au>,
 "Greg Kurz" <groug@kaod.org>, "Mark Cave-Ayland"
 <mark.cave-ayland@ilande.co.uk>, "Frederic Barrat"
 <frederic.barrat@fr.ibm.com>
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>, "Peter Maydell"
 <peter.maydell@linaro.org>
X-Mailer: aerc 0.15.2
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
In-Reply-To: <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

On Mon Jun 26, 2023 at 11:35 PM AEST, C=C3=A9dric Le Goater wrote:
> On 6/23/23 14:37, C=C3=A9dric Le Goater wrote:
> > On 6/23/23 11:10, Peter Maydell wrote:
> >> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com> wrot=
e:
> >>>
> >>> ppc has always silently ignored access to real (physical) addresses
> >>> with nothing behind it, which can make debugging difficult at times.
> >>>
> >>> It looks like the way to handle this is implement the transaction
> >>> failed call, which most target architectures do. Notably not x86
> >>> though, I wonder why?
> >>
> >> Much of this is historical legacy. QEMU originally had no
> >> concept of "the system outside the CPU returns some kind
> >> of bus error and the CPU raises an exception for it".
> >> This is turn is (I think) because the x86 PC doesn't do
> >> that: you always get back some kind of response, I think
> >> -1 on reads and writes ignored. We added the do_transaction_failed
> >> hook largely because we wanted it to give more accurate
> >> emulation of this kind of thing on Arm, but as usual with new
> >> facilities we left the other architectures to do it themselves
> >> if they wanted -- by default the behaviour remained the same.
> >> Some architectures have picked it up; some haven't.
> >>
> >> The main reason it's a bit of a pain to turn the correct
> >> handling on is because often boards don't actually implement
> >> all the devices they're supposed to. For a pile of legacy Arm
> >> boards, especially where we didn't have good test images,
> >> we use the machine flag ignore_memory_transaction_failures to
> >> retain the legacy behaviour. (This isn't great because it's
> >> pretty much going to mean we have that flag set on those
> >> boards forever because nobody is going to care enough to
> >> investigate and test.)
> >>
> >>> Other question is, sometimes I guess it's nice to avoid crashing in
> >>> order to try to quickly get past some unimplemented MMIO. Maybe a
> >>> command line option or something could turn it off? It should
> >>> probably be a QEMU-wide option if so, so that shouldn't hold this
> >>> series up, I can propose a option for that if anybody is worried
> >>> about it.
> >>
> >> I would not recommend going any further than maybe setting the
> >> ignore_memory_transaction_failures flag for boards you don't
> >> care about. (But in an ideal world, don't set it and deal with
> >> any bug reports by implementing stub versions of missing devices.
> >> Depends how confident you are in your test coverage.)
> >=20
> > It seems it broke the "mac99" and=C2=A0 powernv10 machines, using the
> > qemu-ppc-boot images which are mostly buildroot. See below for logs.
> >=20
> > Adding Mark for further testing on Mac OS.
>  =20
>
> Mac OS 9.2 fails to boot with a popup saying :
>        =20
>          Sorry, a system error occured.
>          "Sound Manager"
>            address error
>          To temporarily turn off extensions, restart and
>          hold down the shift key
>
>
> Darwin and Mac OSX look OK.

Might have to to restrict it to POWER machines for now then. Seems like
it will break working systems.

We could just log a guest error for the others.

Thanks,
Nick

