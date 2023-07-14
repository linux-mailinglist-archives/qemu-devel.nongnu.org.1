Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44290753771
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 12:05:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKFfx-0002EU-Tg; Fri, 14 Jul 2023 06:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKFfv-0002EI-VF
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 06:05:23 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKFfu-0005Iz-3L
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 06:05:23 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fb7b2e3dacso2956529e87.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689329120; x=1691921120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iGJY+snc6RpF7s9t+Bq8tTAlcDZLV9G6cAs6sBjLTC0=;
 b=TT7ji5OXCgKCLm9GF5JTgiNSOq9Td2pTIyrk7HwwXuuPoEtQMafT0PBjIi/2X5v5/4
 KEe3ypLj6QYvPULUmOhX8NT44rKeKPqDJjvA5AUaWMIcrlOBXvPZGSVJ+iWgr/k9fz+I
 MTUFTihqpomCJ/qDD2/85WHXHzsn9j4bkkGTAqrLVWezRF12vSxsAAPkkvwpZfinUJCe
 JUC3c044bRJj7PB3V0E1BWF6YeTiYwF07BDoS2C+yi+nyj88GawMlo3iPbV5YDHtyGTb
 ld+djPEb80tNBvy+I/It3ilOgklSm1PjKs3GOAKBC9csaJCIpU5WtsrxufFXbZOL97Yh
 dXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689329120; x=1691921120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iGJY+snc6RpF7s9t+Bq8tTAlcDZLV9G6cAs6sBjLTC0=;
 b=gBLNIvFMiRrSmbmDew0CtJk9fGEK0Q9xkgrBatXsdQqTWly08lG4nT0kcq3AGjDWPI
 xlh0I9laW5IuCExA3zbEQh6RGI3vD2CuzjvjY/xiOrryE4gOV1HHlKuS+sa5xV9DVjtI
 gJmnvAYDeTEC2CXvqqR7JXuPfmh6ODkdTwqOnox+47dKy4Stky7U1TitLEVNUrXoHwi4
 2srQh7aa9GRSR2qwYt3AZ5vExfOafISdputaEgJUYtNfuX/GEWVDINYa1/TpPW82h0Ea
 iSMsB6yA6VO2gkQZLa2Bjjh1wD7UY82qMPJ3zig1+7rXKy6Dmxta0JPY8v1HazBFQsRH
 d0Lw==
X-Gm-Message-State: ABy/qLZdhPWqGQAi/yRkRGIm0pMs6NoXxA9Z6K9Ag6Q8iLkx0mViVM9e
 vBZ80O6jJx5V5YcxiSQP673xUmA1Xl9YahcLml2m3w==
X-Google-Smtp-Source: APBJJlFX+VbNa1JX9BWve5obXbn+8S1lGxvpEWzac8BjFqAjI3SrlaBlhatmGfuPnCRTmtt64p4tWYWT/Qj8LBptyZ8=
X-Received: by 2002:a05:6512:3d0a:b0:4f9:58bd:9e5a with SMTP id
 d10-20020a0565123d0a00b004f958bd9e5amr3544590lfv.27.1689329119901; Fri, 14
 Jul 2023 03:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-5-j@getutm.app>
 <4a49285e-0d91-93a0-2f8e-e76c71ed89f8@linux.ibm.com>
 <CAFEAcA-r_VOc18-jm99asYQQk4TJMBW_7oJMzFQofEHqVdF50A@mail.gmail.com>
 <ab339186-1af7-171c-eb11-fe124f12b4a2@linux.ibm.com>
 <CAFEAcA9nad4H3MgitMyVsZjNZdY-n9d65Yz4Gtbz2wPYA4fbsg@mail.gmail.com>
 <e2340c41-1d77-3406-001c-4dcce544af74@linux.ibm.com>
 <CAFEAcA-WtwcckNO=kDP8HbY53qV3mTtYysH2Lw8FSJsrWO2tdQ@mail.gmail.com>
 <afb324e8-d65a-12b3-e591-65133087689b@linux.ibm.com>
 <CAFEAcA9Z5wHRuMmeogoyrN=C4OtoKObxNu58nQaOXdYwzq_gpw@mail.gmail.com>
 <c5b44af5-e737-d899-5ea1-3d7debe760a4@linux.ibm.com>
 <CAFEAcA-igpEHJOxw8mCV=em6FRUT8BuNRPCiVMvQ7moaasSmLw@mail.gmail.com>
 <de9befdf-82ea-6cff-e300-7a9edf3e867b@linux.ibm.com>
In-Reply-To: <de9befdf-82ea-6cff-e300-7a9edf3e867b@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2023 11:05:08 +0100
Message-ID: <CAFEAcA8KgSsmiCFA51vrYAFrXg6p8x=0_qM0wrZ4yHOWrQKp2A@mail.gmail.com>
Subject: Re: [PATCH 04/11] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Thu, 13 Jul 2023 at 19:43, Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>
>
> On 7/13/23 13:18, Peter Maydell wrote:
> > On Thu, 13 Jul 2023 at 18:16, Stefan Berger <stefanb@linux.ibm.com> wrote:
> >> I guess the first point would be to decide whether to support an i2c bus on the virt board and then whether we can use the aspeed bus that we know that the tpm_tis_i2c device model works with but we don't know how Windows may react to it.
> >>
> >> It seems sysbus is already supported there so ... we may have a 'match'?
> >
> > You can use sysbus devices anywhere -- they're just
>
> 'anywhere' also includes aarch64 virt board I suppose.

Yes. Literally any machine can have memory mapped devices.

> > "this is a memory mapped device". The question is whether
> > we should, or whether an i2c controller is more like
> > what the real world uses (and if so, what i2c controller).
> >
>
> > I don't want to accept changes to the virt board that are
> > hard to live with in future, because changing virt in
> > non-backward compatible ways is painful.
>
> Once we have the CRB sysbus device we would keep it around forever and it seems to
> - not require any changes to the virt board (iiuc) since sysbus is already being used
> - works already with Windows and probably also Linux

"Add a sysbus device to the virt board" is the kind of
change I mean -- once you do that it's hard to take it
out again, and if we decide in 6 months time that actually
i2c would be the better option then we end up with two
different ways to do the same thing and trying to
deprecate the other one is a pain.

-- PMM

