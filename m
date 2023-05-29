Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B14FE7144E9
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 08:32:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3WPJ-0006kr-1E; Mon, 29 May 2023 02:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3WPD-0006kI-Jl; Mon, 29 May 2023 02:30:59 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3WPB-0006ZZ-9a; Mon, 29 May 2023 02:30:59 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d4e45971bso1971581b3a.2; 
 Sun, 28 May 2023 23:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685341855; x=1687933855;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1s/uConlmnFem6z2Xa9tS8z6dYfu6pAXtraClLNc9dA=;
 b=rCmW6KMC4zPRBwQSYXwXEokz+T4EdJ2Qkora2c1MQ3WkriZLdOs8CEvqtP4DGdKK9q
 Aqupe5Y/+hJrbV1JL89mqMY02AmJja56KZF8dJHfc7Y5lOZGYFd4X+bROpdxBqpuAaLa
 NW+bOAeJy/IO7WffNbRuX3XDoWWSHQIvXILivqQSc0eRvmrdHMGp5iFF/egKe0Vwct3c
 4E6QdW6jdGMyjIYzD3zDqBISgbeNaEwUHbdQXDKZm0SJOI+E8bZEwq5sLH8SIkc9yj77
 hRcM6k4wjOoslR1erVcu72SPtbtXeSmpQvX1xO2P7tF4OfChu+Lz+iRgDhZMaxoxavRE
 74uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685341855; x=1687933855;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1s/uConlmnFem6z2Xa9tS8z6dYfu6pAXtraClLNc9dA=;
 b=hUAXd1ERKSkLVUsJapSFZJY/J9XEgVNNH2a8/XBHIZZ+y4fr/kgq/2ln8SIMiGEemd
 z21I+jJbeDjGrRLzAiWnmIo8dIgMJ11Hs0Gh8GMq8fOGtExtgcF3y4KZVTtvH+pKgfql
 q8rb/E6HEAP01cKLMlzujaUHBL7PGis6YzMPB7FmZ8vveGTHM4/XgbRIuEGmsRfVlc5J
 DaYOyfDDjIzMnNKr8d48oEJqTY9gfkzarEc+XWk4A5tuEl8v0oiwuXgCxZpVgPsb+hRQ
 zQ0H7j1YrtVnsXUbzPmkilnxyFmWx1pzEGE7h3PXORKC0nyCyEm6SE/MP2fKjEtJxs0f
 V7Qg==
X-Gm-Message-State: AC+VfDwRfebFbumjWI3wnV9dMBP0HYgJmHvUVoQMA1I+1vxF9eBZ1Ok+
 Q/KwKC6POMKgz+gEZuOfeaw=
X-Google-Smtp-Source: ACHHUZ49KMVv63OZdRuDG/9iP03V5VC75wRGiR3gqY8ChGX7YQhnpnO401uT3liNl2ywgBv5jW8Mtg==
X-Received: by 2002:a05:6a20:12c2:b0:10b:9dc1:c5e5 with SMTP id
 v2-20020a056a2012c200b0010b9dc1c5e5mr8896699pzg.34.1685341854894; 
 Sun, 28 May 2023 23:30:54 -0700 (PDT)
Received: from localhost ([1.146.31.106]) by smtp.gmail.com with ESMTPSA id
 l64-20020a633e43000000b0053ef188c90bsm6431470pga.89.2023.05.28.23.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 23:30:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 May 2023 16:30:47 +1000
Message-Id: <CSYJTOIIC83Z.2KLRXWGXHXCW5@wheely>
Cc: <qemu-ppc@nongnu.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, "Richard Purdie"
 <richard.purdie@linuxfoundation.org>, "Bernhard Beschow"
 <shentey@gmail.com>
Subject: Re: [PULL 00/10] ppc queue
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230528164922.20364-1-danielhb413@gmail.com>
 <2ccafb44-d09a-e71c-005b-9a36f128b275@tls.msk.ru>
 <CSYEG7TJD7S7.IYIJXRKLWCZA@wheely>
 <c66df357-d647-1335-7a7e-70e602dd44bb@tls.msk.ru>
In-Reply-To: <c66df357-d647-1335-7a7e-70e602dd44bb@tls.msk.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

On Mon May 29, 2023 at 4:01 PM AEST, Michael Tokarev wrote:
> 29.05.2023 05:18, Nicholas Piggin wrote:
> ..
>
> >> 01/10 target/ppc: Fix fallback to MFSS for MFFS* instructions on pre 3=
.0 ISAs
> >> 02/10 target/ppc: Fix width of some 32-bit SPRs
> >> 03/10 target/ppc: Alignment faults do not set DSISR in ISA v3.0 onward
> >> 05/10 hw/ppc/prep: Fix wiring of PIC -> CPU interrupt
> >>
> >> Or are these not important for -stable?  Or maybe there are other chan=
ges
> >> which should be picked too?
> >=20
> > They certainly fix some parts of target emulation, but what is the
> > guidance for backporting those type of fixes? Most of the patches I sen=
t
> > including 2,3 were just found from inspection or new test code and not
> > real software failing.
> >=20
> > Should just simple ones go in? 32-bit SPRs do not fix entirely the
> > behaviour of all SPRs, just one aspect. In another fix I had (that
> > didn't make it in this merge), was a bit more complicated and the
> > first iteration caused a deadlock that didn't show up in basic test
> > like booting Linux.
> >=20
> > My guess is that fixes that correct an issue with real software running
> > on the target should be ported to stable. Perhaps "obviously correct"
> > small fixes as well. But not sure about larger changes.
>
> This is exactly why I asked, - because I don't clearly understand how
> important these to have in -stable. And also to remind that -stable
> exist, just in case.. ;)

Ah okay, makes sense. I was just clarifying myself since I wasn't
too sure.

> So be it, no actual issue so not applying to -stable.

I will think about it and try to keep -stable in mind. Of my patches
there are one or two coming up that could probably go in there, if
not these ones.

Thanks,
Nick

