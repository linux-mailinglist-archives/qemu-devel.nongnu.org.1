Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB55808FA5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:12:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBIpi-00052b-Cl; Thu, 07 Dec 2023 13:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rBIpY-00052O-Ru
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:10:37 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rBIpX-0006GE-46
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:10:36 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-54da61eb366so1620273a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 10:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701972633; x=1702577433; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AdiAVPJXMWH+yF1ClXcsdhjFNx6hpnZcaWax+on7o1A=;
 b=NL7JZtJt7JRx5Y44wE6yLOuHjDMmSAf6xQMvXxFTLCs6co8k/gMGpWak1qwwWtpeSy
 x2MI5gEFpbaKl/D6ypYeqigBfWAE9xR351Qxt9uAjw9bTTghWCL48kQTE5Bj2JrCEzMV
 EpHS6X5UpR86x1ED1jPJMZjOJ3cTkmPaTYIW7gCPupt3vEt9YZk7Vao9YZuX4Sduqo/v
 8ztnFYsh71J+8WvXfnndV/nW5+GN30RB/qpUzk/BqcQoRzHNfw5QuTsKXWevGj453eUn
 yhLuyTVJgn0UIqtjMgWS95gqTHfJVQb9Tk2sECvHYB8Ip/MyRU/MwdT8oRJhJFlCZg8M
 ogYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701972633; x=1702577433;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AdiAVPJXMWH+yF1ClXcsdhjFNx6hpnZcaWax+on7o1A=;
 b=CRlbPr3VMO8XThR4bIa7UeV7SDpyjWqnyUNNbDTb1TInWsiqcmHR5OsMhWAmGjGDMX
 acDyMxivMB0mEXK4eql7qAG3yib3+NjyKxbuJtgj8K9Owx1QIQze6A2y4443zYCHr7eq
 6zk6RRrCVb9NvY/viuZj7QN95eIjU2OxThDd6pDAOffoUwYjeWfXiRlDooRh0IbmDBNU
 SVSQJZdbradSgK17np/IBIZohkhpooBwpRST5sViZYxL0Nx9mw/1Oq3l8LOWCxfEnU4n
 7iBCiYCLib9vbKHt1Wl/A7ZCUWr5VENZP3OB4kcYIul1fL5CPCYE/tJhRMnxmfkjvSO7
 Ha0w==
X-Gm-Message-State: AOJu0YzHiCJUgLnrYMqQFWwnMHmrDUvL02Vk6pBWxiJ8snkdQcyiqQqb
 L8VggoU6RahevEPIzp71ix9UCK2nwHRUlJbCzj9aY4ZCYsuaxAz1
X-Google-Smtp-Source: AGHT+IGQPqA9D9b+bqOS5/p6YaybX+RtBc5HYeLnt3ycdyfFJZk/s0qlnnPGMbdlHC+e3dH9de2ukareyU7vnzZVhI4=
X-Received: by 2002:a50:cdc5:0:b0:54c:b6b5:66a with SMTP id
 h5-20020a50cdc5000000b0054cb6b5066amr1503687edj.15.1701972633374; Thu, 07 Dec
 2023 10:10:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHwHw5A6g428uTpMEQ=NCkXP7sXVfCWv5QSUw3pHfncmG-2gPA@mail.gmail.com>
 <5f2068a4-955a-9d16-347d-4d2771b78aa8@eik.bme.hu>
In-Reply-To: <5f2068a4-955a-9d16-347d-4d2771b78aa8@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Dec 2023 18:10:22 +0000
Message-ID: <CAFEAcA-1zqY51hLh029-n_SdArf++TEdeo82Fj6YJx7miR3Ocg@mail.gmail.com>
Subject: Re: Request for New PPC Machine Supporting Multiple SMP Cores
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: aziz tlili <aziztlili2222@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 7 Dec 2023 at 17:40, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Thu, 7 Dec 2023, aziz tlili wrote:
> > Dear QEMU Team,
> >
> > I hope this message finds you well. I've been a user of QEMU for well over
> > a year.
> >
> > I wanted to share an idea for a potential enhancement that I believe could
> > benefit many users, including myself. It would be fantastic to have a new
> > PPC machine model similar to the existing mac99, but with support for
> > multiple SMP cores for both qemu-system-ppc and qemu-system-ppc64.
>
> There are several machines in qemu-system-ppc64 that support SMP such as
> pseries and powernv I think. For qemu-system-ppc maybe only ppce500. The
> mac99 may create multiple CPUs (G4 when ron with qemu-system-ppc or G5
> with qemu-system-ppc64) but not sure if there's an OS that can actually
> use that. Linux support for mac99 may not be the best.

I think our mac99 machine refuses to create more than one CPU, because
it sets mc->max_cpus to 1 in core99_machine_class_init(). This in
turn is probably because nobody has ever implemented and tested
whatever the SMP support handling would need to be for this machine
type.

> Problem is not in understanding the potential advantages but the lack of
> people interested in working on that so progress depends on somebody doing
> it and sending patches.

Entirely agreed. This is a feature request from two years ago about
adding SMP support to the newworld machines:
 https://gitlab.com/qemu-project/qemu/-/issues/672
Nobody has done that work in two years, but anybody who has the
interest and time to do so is welcome to.

thanks
-- PMM

