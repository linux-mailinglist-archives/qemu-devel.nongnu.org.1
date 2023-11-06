Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5A47E27A4
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:50:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00l2-000060-Oe; Mon, 06 Nov 2023 09:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r00kv-0008MY-Bb
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:39:12 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r00ko-0001GO-EN
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:39:08 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5446c9f3a77so2819936a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699281535; x=1699886335; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GfLDD7eeNsgvbeeft6a1k752KeP3+lJ050siu+ConOY=;
 b=xURYVgyzghUDMs3S8S1umGoLtDRZNx8jlSAr7Xw8ZRVyGyaE6mrhzbxzZ0zyuT+O4o
 osYrc94VxtiF4Z7IUbJalOze8qizoffz1AcLxXoWCCs+/Ov0sa9wt7sL49yQsDksp3A6
 PQ/buvyFrg4fkr8FWUF6LZYxX7d/dHBvICJK8SR26BIqG26JZEWBd0YPq7fziMGfDTQ6
 aGDtR7BDC7FHtip2IWLpLtEdhFLeHpBIfVS9Tn9aMKxN2/RZQfJg3oGFtUNR0iPfMg2L
 racKyYiKbYB541e9XSbZv2dQmzpPGfYyex4n3rX+IfMPiT97/qDMH3JKcMvCkT7eoSRs
 Rnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699281535; x=1699886335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GfLDD7eeNsgvbeeft6a1k752KeP3+lJ050siu+ConOY=;
 b=SZeEF4aIhVn8EmeyG2laA+617g5oOS8BsnDUHGrnmb2FaFuTs6j68Kc29yKyHHa3g8
 v0+5vYP1YmwfHk2Dqf1JBmvH9/bsiXuF8EHk++CGsVUvOQzcI/FV1U4li9jXPoqodHhq
 54De+U6BKEAvLCRLSZL2HStkWWRUHEps0HxGGph1AmO2yeT48RfB22UjXpVZZ8kQRXCv
 ikBZgATDe0Quj9pIA/q6mWMUGv8N3RVz5jRnDwgbsY1jlY5kFR8dHfOK8YFH+V8oeTYY
 OUyV0oKaVoMfuIFMW2gwkFHNQ45uGgWGY/XyJnBJftgusgN3GFmRT79b1r4E20cQHaAv
 7YKA==
X-Gm-Message-State: AOJu0YxVJdxyOAMp0MSZ72o8H+quGm3Us2wlm4RyvYls+mtIMZFC4IsR
 ZSX5/HuEyPTvr8QGy3JiP8Pp7vxYVB/00yYFo3aEYA==
X-Google-Smtp-Source: AGHT+IEcgqkgnvw7WO/WxA3eTezuarL2Nphn76bQR1Pwd6kR8bZyvO8S0BZ+XWUN9cFtc6Jn5NX+HDkhLl3wCpEzQaE=
X-Received: by 2002:a50:d495:0:b0:543:580e:b28c with SMTP id
 s21-20020a50d495000000b00543580eb28cmr15775731edi.35.1699281535694; Mon, 06
 Nov 2023 06:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20231103152120.829962-1-peter.maydell@linaro.org>
 <20231103152120.829962-3-peter.maydell@linaro.org>
 <CAFEAcA-iSvg0r7-pRbv07p80Fy4ZEii0Md2DnuGs_=djdBe-HA@mail.gmail.com>
 <20231106150533.1b166fb5@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231106150533.1b166fb5@imammedo.users.ipa.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2023 14:38:44 +0000
Message-ID: <CAFEAcA-6Sn=bYOo4Q+TwCzpLEOWA56VN2iW8CycTG70CtpkJeg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hw/arm/virt: Report correct register sizes in ACPI
 DBG2/SPCR tables.
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Udo Steinberg <udo@hypervisor.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 6 Nov 2023 at 14:05, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Fri, 3 Nov 2023 15:26:22 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Fri, 3 Nov 2023 at 15:21, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > From: Udo Steinberg <udo@hypervisor.org>
> > >
> > > Documentation for using the GAS in ACPI tables to report debug UART addresses at
> > > https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table
> > > states the following:
> > >
> > > - The Register Bit Width field contains the register stride and must be a
> > >   power of 2 that is at least as large as the access size.  On 32-bit
> > >   platforms this value cannot exceed 32.  On 64-bit platforms this value
> > >   cannot exceed 64.
> > > - The Access Size field is used to determine whether byte, WORD, DWORD, or
> > >   QWORD accesses are to be used.  QWORD accesses are only valid on 64-bit
> > >   architectures.
> > >
> > > Documentation for the ARM PL011 at
> > > https://developer.arm.com/documentation/ddi0183/latest/
> > > states that the registers are:
> > >
> > > - spaced 4 bytes apart (see Table 3-2), so register stride must be 32.
> > > - 16 bits in size in some cases (see individual registers), so access
> > >   size must be at least 2.
>
> it might be worth mentioning that QEMU impl. uses 32 bit registers and
> can correctly handle 32 bit access only, while 16 (or any other) bit access
> to 32 bit registers won't actually work.
>
> ex:
> pl011_write()
>    ...
>    switch (offset >> 2)
>
> essentially only 1st byte will be accessed correctly,
> the rest will be misplaced as read/write handlers do not account
> for split access possibility.

No, 16 bit accesses should work OK -- we set our .impl.min_access_size
and .impl.max_access_size to 4, so the memory subsystem should
implement 8 and 16 bit accesses for us by converting them to
32 bit accesses.

thanks
-- PMM

