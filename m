Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FFD76B950
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 18:04:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrp4-00083B-Pd; Tue, 01 Aug 2023 12:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQroF-0007fz-Tf
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:01:24 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQroC-0004Ug-Nw
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:01:18 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-522bc9556f5so4322746a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690905675; x=1691510475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uHSqRcpiT02GTGeITNtnXVMmijcnbe/B+zmv+9E7TDA=;
 b=cL+52DR25DTAZOR/t9BTofYZaSBMrN5BwC3FrqfrsqJCHWp0X4RDZHtmU7z4e0Uo4b
 mFZ9WHCnEQzFEhOYIEsOD+jag5hnRi5pNrD3d0BDbrTbK6+XSkC58xTVV7fIdUagNKao
 eJE/ZYgzjbPtpF4IfBp4E9oTJHABFzI5M+Z111Hmnyq7RvL+zdY3mr+xKsqZITH8WdrG
 mfFMh9dXxfL3Luw+GVBy6wDWbF0TezWt35lF35KeslYpwHLjYP074YYlK3Z4gu0EX7Ih
 MhvnTjt98tOgz2erNF8tmfSGTBsPjuBCZnVc9cVgibnkPB+CtARUky5Uu4l9GMkgZibF
 G89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690905675; x=1691510475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uHSqRcpiT02GTGeITNtnXVMmijcnbe/B+zmv+9E7TDA=;
 b=JeupJIehRGpcLT/EFrTAeJ1m+tAyaHkP1DVcTNM84LvWM0EJi8UkDL7usqcNWJm0ZO
 VQHu+57G9i0QR7ixWYWwIZFOjrDGnoVWWg/KAQNl1YPe9XoE1up7h3iqa2E29kTbWWfa
 TP+aV2vJlR17z3Tm8RDIOEzLop8Wg3ZEfjVbrnLvly78AkrF712tjeSzUnNYis2FkdP4
 SPGZ5L/a0M2vPKA9Q0QppXKvMDj/uxbCuEf4MJz3VHNDywrgZN7GOd3tvXTPGQ+yGeLL
 Dxa0GyA1l7c8jkqzBBR3x0qLzaglndY3EpCd2L7bCVRuudRIu6vUVADWnFZOnF1AuYSt
 MPyA==
X-Gm-Message-State: ABy/qLaGDWfSn5YAg0CJE5zK2haUzu/lLu8qR6n4TIKxQFwWzddiYt0Z
 1QuymHjsfWXTB0ILHZvRiu67yCRp/lsBowV5dFHSrw==
X-Google-Smtp-Source: APBJJlE6bOFcMrDYHotDjjyVRGfibX1jiHOTiv6+AS9UYSyUYmmStTtWuApeRoQ7f68QE1VxqslMmilkQjoV+LX8x1k=
X-Received: by 2002:a05:6402:702:b0:522:ae79:3ede with SMTP id
 w2-20020a056402070200b00522ae793edemr2618952edx.11.1690905674975; Tue, 01 Aug
 2023 09:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230523100508.32564-1-qianfanguijin@163.com>
 <20230523100508.32564-2-qianfanguijin@163.com>
 <41e71eae-72ad-410d-9cd8-cc495c06dac4@roeck-us.net>
 <CAFEAcA8aEQWAap36CtHMrEkFQUPnDCH7=-X5+TE2GJ-qzm3Y9w@mail.gmail.com>
 <2044dc69-93de-d855-fe44-ee6f3ab3576b@roeck-us.net>
 <CAFEAcA8vtJNwbxBreDMFB6q-Z=G5FiOcWzAAz+F69A4-Er_4EA@mail.gmail.com>
 <a51c71c5-4c5e-8723-76f1-2cc9410f601b@roeck-us.net>
 <01087628-44c0-2b15-61bc-8677b7d1b459@roeck-us.net>
In-Reply-To: <01087628-44c0-2b15-61bc-8677b7d1b459@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2023 17:01:03 +0100
Message-ID: <CAFEAcA_mRY3bULpX0Qst--8XkDP9DYJqFbRBPgEpvEB1QnDr_A@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] hw: arm: Add bananapi M2-Ultra and allwinner-r40
 support
To: Guenter Roeck <linux@roeck-us.net>
Cc: qianfanguijin@163.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Sat, 24 Jun 2023 at 16:02, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 6/24/23 07:23, Guenter Roeck wrote:
> > On 6/24/23 03:40, Peter Maydell wrote:
> >> On Fri, 23 Jun 2023 at 20:33, Guenter Roeck <linux@roeck-us.net> wrote:
> >>>
> >>> On 6/23/23 10:44, Peter Maydell wrote:
> >>>> On Sat, 17 Jun 2023 at 17:29, Guenter Roeck <linux@roeck-us.net> wrote:
> >>>>> Main problem is that the SD card gets instantiated randomly to
> >>>>> mmc0, mmc1, or mmc2, making it all but impossible to specify a
> >>>>> root file system device. The non-instantiated cards are always
> >>>>> reported as non-removable, including mmc0. Example:
> >>>>>
> >>>>> mmc0: Failed to initialize a non-removable card
> >>>>
> >>>> Do you mean that QEMU randomly connects the SD card to
> >>>> a different MMC controller each time, or that Linux is
> >>>> randomly assigning mmc0 to a different MMC controller each
> >>>> time ?
> >>>>
> >>>
> >>> Good question. Given the workaround (fix ?) I suggested is
> >>> in the devicetree file, I would assume it is the latter. I suspect
> >>> that Linux assigns drive names based on hardware detection order,
> >>> and that this is not deterministic for some reason. It is odd
> >>> because I have never experienced that with any other emulation.
> >>
> >> Yeah, I don't really understand why it would be non-deterministic.
> >> But it does make it sound like the right thing is for the
> >> device tree file to explicitly say which MMC controller is
> >> which -- presumably you might get unlucky with the timing
> >> on real hardware too.
> >>
> >
> > Agreed, only someone with real hardware would have to confirm
> > that this is the case.
> >
>
> Actually, the reason is quite simple. In the Linux kernel:
>
> static struct platform_driver sunxi_mmc_driver = {
>          .driver = {
>                  .name   = "sunxi-mmc",
>                  .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>                                ^^^^^^^^^^^^^^^^^^^^^^^^^
>                  .of_match_table = sunxi_mmc_of_match,
>                  .pm = &sunxi_mmc_pm_ops,
>          },
>          .probe          = sunxi_mmc_probe,
>          .remove         = sunxi_mmc_remove,
> };
>
> All mmc devices instantiate at the same time, thus the
> device name association is random. If I drop the probe_type
> assignment, it becomes deterministic.
>
> On top of that, Linux does know which drives are removable
> from the devicetree file. However, since probe order is
> random, the assignment of the one removable drive to device
> names is random. Sometimes mmc0 shows up as removable,
> sometimes it is mmc1 or mmc2.
>
> So my conclusion is that qemu isn't doing anything wrong,
> it is all happening in the Linux kernel.

Hi Guenter -- do you know if this "random MMC controller"
issue has been fixed in Linux ? If so, we might be able
to update our test case image to avoid the slightly ugly
"root=b300" workaround at some point.

thanks
-- PMM

