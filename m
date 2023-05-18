Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F00C708004
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzc31-0002ga-E5; Thu, 18 May 2023 07:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzc2z-0002eX-6E
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:43:53 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzc2x-0003XR-Eb
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:43:52 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-510ede0f20aso339377a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684410230; x=1687002230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJZg7lol9uI4nA7+TzoP5++HFha6j4j/3Bkc6g2Z5PU=;
 b=pjnwThd0pdKsuflo83JmNGVelXllgqIS5MDjj/2vKm4Fsxhxnv6LyLvB3BHucB9Dwp
 kMCOPTRofke4JdlhxqUp3cry1gtYc8S/D0oDWs93t95P50nwWIxDOtujOXMTVAwpoX9k
 24mO6lBcLbBVxt3kgQnTJMRpSpR2qMa/vwTyflXkFjv6niSLIhm/XFWKr7EeBwR7pc+F
 YCm89VZuXMgG4cZSL9Cgwu9v9N5Q9S7ZRy+QKxReSUM441xHeCTWDj2AlzxPt/MWP/VB
 ZInYFq2hJPHrfXIwPpdFCn+IcSL0P9DDVvHa2POxDtmvK0VMfp6kCTouZ2oM93ch7+bM
 +oCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684410230; x=1687002230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJZg7lol9uI4nA7+TzoP5++HFha6j4j/3Bkc6g2Z5PU=;
 b=WmukING2AKbUKlr3H/1Yoe1LVQAEfVdkzTvvBXtcAsIFf4f40c3m8P+W1HmmLCQCon
 mFCdZftmTNP7HgxhuRZ+ISLYvbJiCvrBaMOtvXaZCVZVAubFGFLn9aJWj7IRX/dnGhBY
 6gm9HLKTI1HbPLOIls96WF0aT+ndSTop0vL3nsHpZ3/SAAfyS8g0s9rjinlrvCXykm25
 ve10VaSUM/8UhBdRVvdQsASnEeYT1Ic1YgqgT5c/RldH6A/cWVWYmlDXqMIGhnrOd3JW
 OoqrTexBQgZocGxLMq1nTDeZMDN6H0Qwx1pQJ+jC2wEAZD2olgYF8JV/wTjvPHyYUK3V
 gMmg==
X-Gm-Message-State: AC+VfDz+SqrlcBwkXJucI2kdyRvqXBG7Zi36MrfbyBJUGoSDbE8DG07B
 QIKh++kEWUn4iMOw//YVDjqQjURsESjoaRKEu3IdHg==
X-Google-Smtp-Source: ACHHUZ5Ao6feoH7H1dCbS93e0AEM0/DxsoVXb0uiODPcnUcZZYwefu4Enqxuk1P+Ls1kGwLWsftZ4lLsmuxeS2/s95E=
X-Received: by 2002:aa7:c94b:0:b0:50b:f929:c6d3 with SMTP id
 h11-20020aa7c94b000000b0050bf929c6d3mr4255933edt.1.1684410229736; Thu, 18 May
 2023 04:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230516104420.407912-1-alex.bennee@linaro.org>
 <CAFEAcA8fu-+YUeuhVw8mpgYXO=ueXrCecC-LkhFwoubUkMvg4Q@mail.gmail.com>
 <87a5y1nbbv.fsf@linaro.org>
In-Reply-To: <87a5y1nbbv.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 12:43:38 +0100
Message-ID: <CAFEAcA_b8WPQe4tjeTeL2mYHH+0KYXreUhiQ_Bn9cDBne-GDnw@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: add RAZ/WI handling for DBGDTR[TX|RX]
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Anders Roxell <anders.roxell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 18 May 2023 at 12:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 16 May 2023 at 11:44, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >> The commit b3aa2f2128 (target/arm: provide stubs for more external
> >> debug registers) was added to handle HyperV's unconditional usage of
> >> Debug Communications Channel. It turns out that Linux will similarly
> >> break if you enable CONFIG_HVC_DCC "ARM JTAG DCC console".
> >>
> >> Extend the registers we RAZ/WI set to avoid this.
> >
> > Applied to target-arm.next, thanks.
> >
> > (In theory we could implement the DCC and wire it up to a
> > chardev, which might be a cute way of getting early debug.)
>
> I wondered about that - does DCC give you anything that you can't get
> with semihosting (which I think also can support earlycon)?

It gets you a debug console without having to trust the guest
not to scribble all over your host filesystem :-) I'm not sure
this really justifies the effort of the implementation, though.
(Also, as usual the awkward part is the UI and how you'd let
the user specify the chardev to connect up.)

> I found it a little unclear if this is an always available feature.
> Should you expect any modern Cortex/Arm chip to support DCC when
> attached to jtag?

My guess is if you can attach to it over jtag at all then
the DCC channel will be there.

-- PMM

