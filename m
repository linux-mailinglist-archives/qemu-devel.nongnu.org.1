Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58262747BA6
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 05:01:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGskJ-0006cF-R1; Tue, 04 Jul 2023 22:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGskI-0006bn-3d; Tue, 04 Jul 2023 22:59:58 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGskG-0002Bq-7s; Tue, 04 Jul 2023 22:59:57 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-66c729f5618so5017531b3a.1; 
 Tue, 04 Jul 2023 19:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688525994; x=1691117994;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CfDg5Fz86hVEB5Ibq54FaNsAwLvu/rJB6uS0nhLKwU=;
 b=AGbr3mEi4btaWWcKWblUKlNgDNFXbhDu3o6VUr5sIMAjCSW1AC+2RGe9DJkijq3VLj
 qNCfBLk3VBzQMGEqiRDoztntpYM5AxwlBxlpJYA4E0vr74QUq61s8OtAN3p5Gz7HfQJe
 BekTKzmtOSUC7Xb8TxIqSvHuAl4LQSvFiAlrZVDfmcGG+xRSeWiuEio+LR73M2uYSuUH
 xkiOliSEOFJNt1sVJb2OD0HiIGxKqsouGUADUbsHNq3SbxH9XlPWvPdez92TI9mSkVAZ
 ZWbyuNN1MuHGzixm6miRdKyncRkRjT+GOXShDIes4iddz7MhqAYQQi8IknMiU8dDErh5
 JO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688525994; x=1691117994;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2CfDg5Fz86hVEB5Ibq54FaNsAwLvu/rJB6uS0nhLKwU=;
 b=GxBVqtCeB1FoDgH8q0dlBQDMgbtA19myTxx3fAd1IsnTbU647s2OHWuVqX8x3WYzcu
 9uZibjpUAEFGRnI5GUtSjPGKECD9ptAVGLyKWM7CBIaD8+jFJBsOPXI51bEimIicSYF6
 TKtBTbTK3bsGH9gbcjpJlZba7/+7dfI0kONe6TxHJBKTQHVuINtN4j3NaI5C24TQOqVy
 nK9w50v9QDt27ldG4IXQYvZhZPhVh2CTkrBoTejYBkyuX9fx8IF8ZBwR3TCY7z3uPS9j
 toJBnco6cY1I0p9qmfQ3XMO24oIVU6ToyEc/PPpilTNlhPhOiWEzLvnDENua9YLlfNk2
 lvMw==
X-Gm-Message-State: ABy/qLbHqp9mc7UavrXHEZFra2QyPbpEaAtKzvxTN7kxvA6Zr+IiZ7Gj
 POQlfq8wLVn7VjMW18c51WY=
X-Google-Smtp-Source: APBJJlHe3F947KyGOVrrlGYv8dDzZ34/SxMgNy2gvDKOYf+1iMYd5vG3g8kojHnC2tFFfZuSPn7wsQ==
X-Received: by 2002:a05:6a00:cd6:b0:67b:2eba:bed4 with SMTP id
 b22-20020a056a000cd600b0067b2ebabed4mr19679617pfv.14.1688525994355; 
 Tue, 04 Jul 2023 19:59:54 -0700 (PDT)
Received: from localhost ([61.68.2.145]) by smtp.gmail.com with ESMTPSA id
 y10-20020aa7804a000000b00669c99d05fasm16289274pfm.150.2023.07.04.19.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 19:59:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jul 2023 12:59:48 +1000
Message-Id: <CTTWIA9IFYYP.24I02IOSLH97T@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz"
 <groug@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Richard
 Henderson" <richard.henderson@linaro.org>
Subject: Re: [PATCH v3] target/ppc: Make checkstop actually stop the system
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.15.2
References: <20230703120340.45349-1-npiggin@gmail.com>
 <68789d6e-5bf8-88d6-2bd5-405339500f44@eik.bme.hu>
 <CTSK657Y1RRB.3919QR3A490A5@wheely>
 <93da1b1b-aabc-aba1-0706-16b3513ad0e9@eik.bme.hu>
In-Reply-To: <93da1b1b-aabc-aba1-0706-16b3513ad0e9@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

On Tue Jul 4, 2023 at 1:06 AM AEST, BALATON Zoltan wrote:
> On Mon, 3 Jul 2023, Nicholas Piggin wrote:
> > On Mon Jul 3, 2023 at 10:26 PM AEST, BALATON Zoltan wrote:
> >> On Mon, 3 Jul 2023, Nicholas Piggin wrote:
> >>> checkstop state does not halt the system, interrupts continue to be
> >>> serviced, and other CPUs run. Stop the machine with
> >>> qemu_system_guest_panicked.
> >>>
> >>> Change the logging not to print separately to stderr because a
> >>> checkstop is a guest error (or perhaps a simulated machine error)
> >>> rather than a QEMU error. CPU registers are dumped.
> >>>
> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>>
> >>> Since v1:
> >>> - Fix loop exit so it stops on the checkstop-causing instruction, rat=
her than
> >>>  after it.
> >>>
> >>> Since v2:
> >>> - Rebase on ppc-next.
> >>
> >> Is this really based on ppc-next or on my series or another patch from
> >> you? I think the patch from my series that introduces the checksrop
> >> function that this patch is changing is not yet in ppc-next so this ma=
y
> >> not apply there.
> >
> > It is based on ppc-next unless I've done something silly. Is this
> > the patch you were talking about?
> >
> > https://gitlab.com/danielhb/qemu/-/commit/26d089ac20080066061ed61fb58a5=
411e275e191
> >
> >> I think you've posted an alternative to the patch moving
> >> checkstop handling to a function and the sc patch which may clash with=
 the
> >> not yet merged parts in my series but i could not follow all these
> >> patches. I'm not sure Daniel could so maybe you could send it as a ser=
ies
> >> to include all patches you want to add or state what it's based on.
> >
> > Things are getting a little confusing, but I think what Daniel has
> > is okay. Were were talking about changing checkstop with my patch,
> > but no big deal to take yours first, I've reworked things.
>
> Sorry my bad. Yes it's getting confusing to me and missed that Daniel=20
> already merged that patch on ppc-next, I thought it was one of the patche=
s=20
> not yet merged. So this can go on top then.
>
> There was another change for fixing sc that may clash that I'm not sure=
=20
> if I need to do anything about.

The sc patches still had the problem of changing the syscall dump to
the instruction after syscall IIRC. So that would need to be fixed.
But that does make me a bit less happy about them too... Anyway
resend with fix and rebase if you want  them.

Thanks,
Nick

