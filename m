Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DDC73CA7D
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 12:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD0hd-0002SL-Oy; Sat, 24 Jun 2023 06:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qD0hZ-0002S0-UQ
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 06:41:09 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qD0hW-0001Eb-T0
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 06:41:09 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51be881b425so1619932a12.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687603264; x=1690195264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jZEIAMNBiMn3g9tw5GHYioaVxbMWGakucfs09cO0ZZI=;
 b=tY43Wg/fLDAqVFp3jcZf9k55hHU/ZEy+r3vzEzj8fsLARdpSwwgaAmfFFI4CFaQWnj
 x+HFy6yq0n8cjHDY1ttxRlUvr2xpjII/x975+NqcFRWoFByxPSbHIl7UsjCrREckg9v8
 am09mp9DWn+ebi6uPl05hsqQLzleTQ7+nwQrGX+IyEsok5iGSvWK0XKTvlIMLFCvswET
 XR2xCGcj/PMCeow31be9b5wHouypHrhoyZPFNy3Rqj+hQ9gb0KrJRo+jo4faXDjT+RUu
 /XiRppkjeoyPhoIPU4Ol2VwMS2sZIo+nR4/rAxqpOaYuxcTUBmL0BDeRR/klZByOtQKT
 7Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687603264; x=1690195264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jZEIAMNBiMn3g9tw5GHYioaVxbMWGakucfs09cO0ZZI=;
 b=Xf9WoihCF1SZ3ZLzwMS6pTFXonFdp6nugGPF1iwQ1c7uS46eCRYB3kbUrNO4aMMLWs
 bno2QnJb+DxxTFOcE4EeMsPySyGsx2XFJBYuXfgT7rJSHxFhM3i5FfpM+lJTTYKQYvsG
 lDgB8s5ihnwbf+/KGGmzXhCVuhwJy7jyT15RqlZ86Voc2UVaGShVumsXJ4HDYxOnCqsm
 Q2P62a4V5ZV7NCysu+U1Hx9ovg0ifh27yPsZE57H1yHg46X2/gZyaoKTMk1chr9RWUNf
 /C6pb9Ctsn9mHmzodtp95r7lODBdA3RHIVvvTCnONEx3plb7SgmA2m3Yfz6xgYspMDKU
 ZM9g==
X-Gm-Message-State: AC+VfDzM/MnqfIwFBETLm6qGV8UbezAUo3fRWXRLtsy1ByPh8xUhFebB
 7VUj6Lpd21+E5AV/xBtD+xvPxsI8dZ5OSGPcZaffrA==
X-Google-Smtp-Source: ACHHUZ6ChzEmSnqgsU4GAXy+jJ2pQrjpGBNA63RHIgRwzxEfxhsaI6BZROPkWwGWbZH2+idQx/J8AQc5G0z0GTHZ2Nk=
X-Received: by 2002:aa7:c40b:0:b0:51b:fa48:a3f3 with SMTP id
 j11-20020aa7c40b000000b0051bfa48a3f3mr2422687edq.18.1687603264300; Sat, 24
 Jun 2023 03:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230523100508.32564-1-qianfanguijin@163.com>
 <20230523100508.32564-2-qianfanguijin@163.com>
 <41e71eae-72ad-410d-9cd8-cc495c06dac4@roeck-us.net>
 <CAFEAcA8aEQWAap36CtHMrEkFQUPnDCH7=-X5+TE2GJ-qzm3Y9w@mail.gmail.com>
 <2044dc69-93de-d855-fe44-ee6f3ab3576b@roeck-us.net>
In-Reply-To: <2044dc69-93de-d855-fe44-ee6f3ab3576b@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 24 Jun 2023 11:40:53 +0100
Message-ID: <CAFEAcA8vtJNwbxBreDMFB6q-Z=G5FiOcWzAAz+F69A4-Er_4EA@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] hw: arm: Add bananapi M2-Ultra and allwinner-r40
 support
To: Guenter Roeck <linux@roeck-us.net>
Cc: qianfanguijin@163.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 23 Jun 2023 at 20:33, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 6/23/23 10:44, Peter Maydell wrote:
> > On Sat, 17 Jun 2023 at 17:29, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> Hi,
> >>
> >> On Tue, May 23, 2023 at 06:04:58PM +0800, qianfanguijin@163.com wrote:
> >>> From: qianfan Zhao <qianfanguijin@163.com>
> >>>
> >>> Allwinner R40 (sun8i) SoC features a Quad-Core Cortex-A7 ARM CPU,
> >>> and a Mali400 MP2 GPU from ARM. It's also known as the Allwinner T3
> >>> for In-Car Entertainment usage, A40i and A40pro are variants that
> >>> differ in applicable temperatures range (industrial and military).
> >>>
> >>> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> >>> Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> >>
> >> I tried this in mainline linux with the following command.
> >>
> >> qemu-system-arm -M bpim2u \
> >>          -kernel arch/arm/boot/zImage -no-reboot \
> >>          -snapshot -drive file=rootfs-armv7a.ext2,format=raw,if=sd \
> >>          -nic user \
> >>          --append "root=/dev/mmcblk0 rootwait console=ttyS0,115200" \
> >>          -dtb arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dtb \
> >>          -nographic -monitor null -serial stdio
> >>
> >> Main problem is that the SD card gets instantiated randomly to
> >> mmc0, mmc1, or mmc2, making it all but impossible to specify a
> >> root file system device. The non-instantiated cards are always
> >> reported as non-removable, including mmc0. Example:
> >>
> >> mmc0: Failed to initialize a non-removable card
> >
> > Do you mean that QEMU randomly connects the SD card to
> > a different MMC controller each time, or that Linux is
> > randomly assigning mmc0 to a different MMC controller each
> > time ?
> >
>
> Good question. Given the workaround (fix ?) I suggested is
> in the devicetree file, I would assume it is the latter. I suspect
> that Linux assigns drive names based on hardware detection order,
> and that this is not deterministic for some reason. It is odd
> because I have never experienced that with any other emulation.

Yeah, I don't really understand why it would be non-deterministic.
But it does make it sound like the right thing is for the
device tree file to explicitly say which MMC controller is
which -- presumably you might get unlucky with the timing
on real hardware too.

> A secondary problem may be that Linux thinks that the first
> drive is not removable, even though it is a SD drive. I  think
> that is a problem with qemu, but I don't understand the qemu
> code well enough to understand why. It seems that the mmc
> capability register always has bit 8 set, even for the first
> drive, but I don't know where/how that is set and how to
> change it. SDHCI has the capareg property, but that isn't
> used here (or I don't know how to use/set it).

Yeah, this seems likely to be something we're getting wrong.
I assume on other QEMU boards the SD card appears as
removeable ?

thanks
-- PMM

