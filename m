Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4494C761D91
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 17:43:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOKBc-0002WR-RU; Tue, 25 Jul 2023 11:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOKBH-0002TB-IW
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 11:42:35 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOKBF-0002U4-71
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 11:42:35 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4fb96e2b573so8788015e87.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690299751; x=1690904551;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JrsDSH3aa9zj39XkrfZJulmZDM/g584Ea/mbl7e6McQ=;
 b=l/1EBNUalcmC3NBzEj0oYWAmU2/ExxAow91Yoob0u6o9PfmV9j+j0r/w+ZD1TEd25J
 c38vJxMnMJGF/0I5gvlnmVNFkI0RAWZAcF/Hrq9LQjXyD/8IvKVkFNRXL15tO2+zOnnx
 hCXag8fwZrwPd7Ltxg+voh/xSdnXj7erzrkLfHQZWzogRaGS02zXjXT+72Ml0s2fwTYB
 08e0jFOMsH2vqOs6YMu+gTpVpyVEW4uNJiFvYWJDdPxSi82ixAg7HZ9LrHP7RZsFZTS/
 bSQeX2yBtGe0CIQkgxaXA4CqSzTRXIFVCJC8dmi1Nz9zPj7aQB6r48Q7/QuWxSV8MqJS
 FEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690299751; x=1690904551;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JrsDSH3aa9zj39XkrfZJulmZDM/g584Ea/mbl7e6McQ=;
 b=PnpkhRw3N8beBYsdqBcUnsGZghxSc2KcD/eatWuFSYtQ7qOJQGcZ6nZUGiB5+3ApKP
 QukBI9ie8LbcAIsiHOCML5PPDZhJQ6LIRHuQ4a3vOwSKcVk2xYCOtobXE99n2i2UviKR
 ovB2oGkh6gCzNcn0LlwsHHmd5V4QnQg7nHNV1rDzx3NtK7F2ZddPijXjuOQmXMizCoUu
 0efMBeVlMenC0gXhpMf2MgokI7XXwwpk6b7jgsjCtKkIex+HEyMeWfz9ukdhMt+QZaO5
 qtenkTyTVlvcOb3xGXW06Dg80mLA/TnbMYvenzfcftCimMmvisxZakkUl2pZrESOGD0Y
 ua+w==
X-Gm-Message-State: ABy/qLb6cGmAvdisyErjwbwbEErzCWvZT81SwXU0jp7nuhDrEzY02XRO
 +gijMpIm5s/rNIAYu4t27kkrTcGSFmpwj8jH4ELZcYOnsb9NMaiE
X-Google-Smtp-Source: APBJJlEpHgWmuGI6UzHz/4/OaYi2jJ6nS3W88ICJVL4WNZNAbyJtnFckErlX2tMaFXfbI4e+EBxM/h3XRym/S4zxWX8=
X-Received: by 2002:a05:6512:10ca:b0:4f1:3d7d:409e with SMTP id
 k10-20020a05651210ca00b004f13d7d409emr8727427lfg.0.1690299751201; Tue, 25 Jul
 2023 08:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230724174335.2150499-1-peter.maydell@linaro.org>
In-Reply-To: <20230724174335.2150499-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2023 16:42:20 +0100
Message-ID: <CAFEAcA86jv21exu_XSBmpF5VpbTPJAfO+zuc+eVio=EYTC6fvA@mail.gmail.com>
Subject: Re: [PATCH for-8.2 0/3] arm: Use correct number of MPU regions on
 mps2-tz boards
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

On Mon, 24 Jul 2023 at 18:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchseries resolves issue
> https://gitlab.com/qemu-project/qemu/-/issues/1772
> which is a report that we don't implement the correct number of MPU
> regions on our MPS2/MPS3 boards.  Ideally guest software ought not to
> care since (a) it can find out the number of regions by looking at
> the MPU_TYPE register and (b) if it wanted 8 MPU regions it can just
> ignore the 8 extra ones.  However, Zephyr at least seems both to
> hardcode this and to care.
>
> Patch 1 cleans up a bug in target/arm code that meant that we
> were accidentally not exposing the pmsav7-dregion on v8M CPUs.
>
> Patches 2 and 3 then define properties on the armv7m object
> and the ARMSSE SoC object, and have the mps2-tz.c board code
> set the properties appropriately to match the config as
> described for those FPGA images.
>
> I have not looked at whether we also get this wrong for the
> older (M3, M4, M7) boards in hw/arm/mps2.c.

I checked up on this, and for these cores the hardware
is not configurable -- they always have 8 MPU regions,
which is the way our models of them are set up. So these
boards (mps2-an385, -an386, -an500, -an511) are fine.

thanks
-- PMM

