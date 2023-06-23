Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C66E073BE07
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 19:46:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCkq6-0005YX-Jz; Fri, 23 Jun 2023 13:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCkq1-0005Y0-Ti
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 13:44:49 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCkq0-0004sk-61
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 13:44:49 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51be61663c8so936504a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687542286; x=1690134286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sNg3QTruwYDJKg3OChiofa5YfqK0hbteIfBLi6n2lJQ=;
 b=jNZjuuZj68dIy38frWrGzJ8Obicf0+BmlTSWOxRvIFoSSiDlRtfUYu95U4uG1/dUMU
 jsNODzsyAHZv5LmKwJcxsjijBYwafwYgFnBI7upDpa47vXklL6708+FB1hrvPiQ4nMuy
 zCF076t7NV/qS8ktR2Xei5AZhu8x5v4dVEDK/WL6p5O8NkdB2fQdTbJWPwTf0g426aac
 wBtc4SH8mQHPAYivvr9dvYyX3XUG6ihoY41zn8oFuxpH4dhW60qZUmydf/ZFCRCjGXH4
 tMRls7uaHPUuKZJMV+7ycmUmElc9oO9Za6d7iTUdaKt18fOv50MmJkvuMY0lvNaJ7wFL
 zqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687542286; x=1690134286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sNg3QTruwYDJKg3OChiofa5YfqK0hbteIfBLi6n2lJQ=;
 b=ZHQioemtt2aMBEK0VkabD6YosajZGUnFdNsY5GbcYpZWMWe1Ll+ROK6qZ0hSrgd9r/
 Ld/HnjNB1ObTSHEtLlMOy2oKBeAI9wvsilotyyy28+4vIaCOStlOgxGlk1KhuGYSXI+v
 JAFblGiCSleklRjGRXQ2vEu+mPivfCIu51Skb6uigmTL3KSGEuDiqCdPW5tyVXPSsQW5
 Do/QNzqDieTVe07ztxr+QBT0s1viY3mguUK4W2gFLoNHMcyvtOtkHugRAe5nXkSCpiXJ
 /XFfqynNSzxhkBgpriRKPbF7+/r1gaWcy0pfthCyOvutQx2E37LNmUfzozPUYYTN2ucS
 WSyw==
X-Gm-Message-State: AC+VfDxwT9KX0A6lI7ni842be1iYnATkG/jTnroipNko/JMBicVdRGQt
 geMIazHeRieFB3OsBaZsdUxvK2gvkEE4UuEQq1JwhQ==
X-Google-Smtp-Source: ACHHUZ5XFHy1SbZ0vBgVu6pH/BiftidAn+J3tgmhyXRqf2u9La+LnkMf+v99WXsbthLY0n533y/lBYa+WgNCsT5l9fs=
X-Received: by 2002:a05:6402:5141:b0:51b:e943:d192 with SMTP id
 n1-20020a056402514100b0051be943d192mr4262828edd.19.1687542286336; Fri, 23 Jun
 2023 10:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230523100508.32564-1-qianfanguijin@163.com>
 <20230523100508.32564-2-qianfanguijin@163.com>
 <41e71eae-72ad-410d-9cd8-cc495c06dac4@roeck-us.net>
In-Reply-To: <41e71eae-72ad-410d-9cd8-cc495c06dac4@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 18:44:35 +0100
Message-ID: <CAFEAcA8aEQWAap36CtHMrEkFQUPnDCH7=-X5+TE2GJ-qzm3Y9w@mail.gmail.com>
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

On Sat, 17 Jun 2023 at 17:29, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> On Tue, May 23, 2023 at 06:04:58PM +0800, qianfanguijin@163.com wrote:
> > From: qianfan Zhao <qianfanguijin@163.com>
> >
> > Allwinner R40 (sun8i) SoC features a Quad-Core Cortex-A7 ARM CPU,
> > and a Mali400 MP2 GPU from ARM. It's also known as the Allwinner T3
> > for In-Car Entertainment usage, A40i and A40pro are variants that
> > differ in applicable temperatures range (industrial and military).
> >
> > Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> > Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>
> I tried this in mainline linux with the following command.
>
> qemu-system-arm -M bpim2u \
>         -kernel arch/arm/boot/zImage -no-reboot \
>         -snapshot -drive file=rootfs-armv7a.ext2,format=raw,if=sd \
>         -nic user \
>         --append "root=/dev/mmcblk0 rootwait console=ttyS0,115200" \
>         -dtb arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dtb \
>         -nographic -monitor null -serial stdio
>
> Main problem is that the SD card gets instantiated randomly to
> mmc0, mmc1, or mmc2, making it all but impossible to specify a
> root file system device. The non-instantiated cards are always
> reported as non-removable, including mmc0. Example:
>
> mmc0: Failed to initialize a non-removable card

Do you mean that QEMU randomly connects the SD card to
a different MMC controller each time, or that Linux is
randomly assigning mmc0 to a different MMC controller each
time ?

thanks
-- PMM

