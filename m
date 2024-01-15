Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F0582DC34
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 16:18:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPOiX-0003L0-Lj; Mon, 15 Jan 2024 10:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOiQ-0003K8-1k
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:17:30 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOiN-0002T7-U7
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:17:29 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5592d1bc4fbso1397971a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 07:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705331846; x=1705936646; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AUrxafxKLR5/wvtuGfFq/JdvphF/czh2i03dDEKIHnk=;
 b=eDGh7IgTaXJYr1+2oSyGdLNhqVU2/QdxCw8LlHrCmfdHijr/LJnSUoYMS0MWJ9Q/rv
 +wTWr6m/UONOcKb2pwM6eHTD9HlkEWXIH8ROFuH9yRAd2KAxHjvoHSPtrvjHzVZtKKT8
 77FCwHchOc2oxQ2xvtPbmn8pWXwt8p3C293t5oRfvgRxfy9qBK7hKXksfXZxPL/pct/j
 pZdYBaQUSUyQ+mygUr7bquuciOxFZz3EDP5lC9UL9ZxPQsVyzbnLc9XHRv2aTr2gF9oR
 FS3oA7inwHDaFVjqhndQQ6v4AGMXyFmGfnJ49J5U0B9frlgVuru5O8h2jR/pNd2prWgd
 UBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705331846; x=1705936646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AUrxafxKLR5/wvtuGfFq/JdvphF/czh2i03dDEKIHnk=;
 b=mXtbkILLqs2BElveZhJJ7zThKsOj4aDTmP+DweiYUaMBgXwVqO+HIlC0PUKN4/murK
 a59t4uRk72k2n7hC3LQQBx2dUmtCGUHbOSnSFccd1CqrlGZpCMRxtfXrvS/eA47b1Jw0
 V29lmkUDXXHG3DzG0XokMt17HRQvsjnPQ3JqIxAvYEl5pEBqRWCaq4mKvYjD29GvuBGk
 kaKV0RKIGD4Sl8fJj81nnHX/mHvjL/9gSeb9ocr4qjyhK3nBCz0I1ZS/cA/0pUv+QlZu
 MO+y2Ml4wNp4cfyjBhWZaFHmkiY4Zq5P9YaPDY3TjsBAWj39RJ3lp9C8V/aKAmNUavn3
 WgBA==
X-Gm-Message-State: AOJu0YznaU2YY+S+VHHhhRq2czlAwxA8oNhqFVR8Ws3PrH56+ERkR9wH
 9MiXo/OFanfN3ls+W1pAQmYqESjxNo1tpSXH9tHhBCwaF/DEWA==
X-Google-Smtp-Source: AGHT+IGWhF3RFaiKzMTA5c7hMhvWxU67SMu0havr0Z4ICHJeTHy28xUfD3X+dLzwrzBt1dhgT8lfDDZaROmo13/DuOk=
X-Received: by 2002:a05:6402:f8b:b0:557:40ff:b3bb with SMTP id
 eh11-20020a0564020f8b00b0055740ffb3bbmr2699890edb.38.1705331846441; Mon, 15
 Jan 2024 07:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <CAFEAcA_9yO8kY=fnT8+vn2AFtjyoJN25B4o2tcegaOxS41qhmg@mail.gmail.com>
In-Reply-To: <CAFEAcA_9yO8kY=fnT8+vn2AFtjyoJN25B4o2tcegaOxS41qhmg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 15:17:15 +0000
Message-ID: <CAFEAcA-fc_E7s9aV7VxgMdYAUzsbXo7XosuSK2hLPt2W+QD+-w@mail.gmail.com>
Subject: Re: [PATCH v4 00/45] Raspberry Pi 4B machine
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 19 Dec 2023 at 16:11, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 8 Dec 2023 at 02:32, Sergey Kambalin <serg.oker@gmail.com> wrote:
> >
> > Introducing Raspberry Pi 4B model.
> > It contains new BCM2838 SoC, PCIE subsystem,
> > RNG200, Thermal sensor and Genet network controller.
> >
> > It can work with recent linux kernels 6.x.x.
> > Two avocado tests was added to check that.
> >
> > Unit tests has been made as read/write operations
> > via mailbox properties.
> >
> > Genet integration test is under development.
> >
> > Every single commit
> > 1) builds without errors
> > 2) passes regression tests
> > 3) passes style check*
> > *the only exception is bcm2838-mbox-property-test.c file
> > containing heavy macros usage which cause a lot of
> > false-positives of checkpatch.pl.
> >
> > I did my best to keep the commits less than 200 changes,
> > but had to make some of them a bit more in order to
> > keep their integrity.
> >
> > This is v2 patchset with the most of v1 remarks fixed.
> > I named it as 'v4' because of mistakes while attempts to send previous patchsets
> > Please ignore all other v1...v3 patchsets except the very first one.
>
> Thanks for the rework and resending these patches. As
> you've probably seen, I've reviewed patches 1-10, but
> I won't have time to do more than that before I break
> for the holiday season now; I will get back to the
> rest of the series in January.

I'm now done with my review of this v4. I haven't left
comments on every patch, but I have read through the others
(including the ethernet controller ones) and I didn't see
anything obviously wrong beyond what we've already
discussed in this thread. I'll do a more full review
for v5.

thanks
-- PMM

