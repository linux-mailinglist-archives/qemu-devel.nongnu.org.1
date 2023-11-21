Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 655497F2B68
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 12:04:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5OYL-0002F9-Qn; Tue, 21 Nov 2023 06:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5OYK-0002Eh-0M
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:04:24 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5OYH-0008DS-GX
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:04:23 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-548f35e6a4bso1231587a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 03:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700564660; x=1701169460; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5PUo49XhJwT64IpjfBG60JSeS1+VM5y5JtRpnSHGV5Q=;
 b=FY9alONfwuQKlyZTewBpKrs/05+kTaJYCzzahqo0GDil9qw6i/j87NqD/2P0eoVZww
 MitlUFprujb/zZAU73LKWpgSAojoCge8mZK5bLx6UQwzymT2jdPmfeZF/7o3dJFL1bbd
 jK14qtglcqfXxx14ElYsaGR9YuiohON+R2hEsTWQXz/vp0Kiu951rw+q8H8v5U/J4cfw
 GwFhJzse0oim5NbNUr0RaL0SFpvYYs2mDLhj4O8yhw3+t+NCQm6SkGRP+2T0kbFGRxAR
 gKzJEYQVEsuoHHdgatmLrRaQ83FNF23hCkprh79rBoXAVAfuv2e7vNenLDxT1Ti+wvvB
 mvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700564660; x=1701169460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5PUo49XhJwT64IpjfBG60JSeS1+VM5y5JtRpnSHGV5Q=;
 b=F+KxNMiNtmIfN6VJB/7X2cL25S+kCo6bFg8ci57QdLtqTQZe3x3QEWg9xJWcBebx5x
 yP1aOKQWfiULli1g4LiJzk9WwUySxMgwTdTxJ4VIql7rT669E57Crthaax9vckiSzk9U
 2V0xy+dMPGmzSgMaVASE4qynqvFH0Fslp3OggzvhO9N3ywKqXBXxyOGLeX1akb+bRoX6
 5MlKnrieAo5l8w3YgONCa4pmdH7cPRhQwD8LeVANJ+sdKFjDlWXffLZePsQMH02XE8/Z
 VRZt9NHrkMdNSrtfl2+V+J7MjVfL89r2/eDp7cXwMptfRJ/MMJQ4T1Ngwp0doFieqXUi
 viEw==
X-Gm-Message-State: AOJu0Yzmpe5oq/6FZprk5CHr0B/2B5zbE7J1Q+1Qqj/ekyTuqJTgTSh1
 DHCSnsgL7pOAWJ0LUAZ+UEvgaH1euFMsbF6tnoEaLpl+HW72IYH7
X-Google-Smtp-Source: AGHT+IEiKrOX00+1udmOd9KhRhACv20rNd2TfaJMXmZUG/fSIy5q07Gbp3UKyQJYjspvfHtzaxP8EAorZCLDIQU0Tvo=
X-Received: by 2002:a05:6402:1645:b0:53e:8972:1d4f with SMTP id
 s5-20020a056402164500b0053e89721d4fmr1565492edx.5.1700564659713; Tue, 21 Nov
 2023 03:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <c4bb80e8-e985-b6b2-aac1-f6e8d446b8ea@eik.bme.hu>
 <295aec31-e9c1-49d8-9bea-edad8f7b81e4@ilande.co.uk>
 <63ff9c1a-5d05-985a-bf2f-69420b72db90@eik.bme.hu>
 <ZVtiV8XXHxS+cw8o@redhat.com>
 <fad96d99-bbdc-4330-bf40-974eb745e2d3@ilande.co.uk>
 <741ae757-f1da-586b-af97-123b0ebfbdb9@eik.bme.hu>
 <ZVx0dbWCMUbF4NVG@redhat.com>
 <a8e8043b-5442-4df1-82d1-5f6deb2a9ae2@ilande.co.uk>
In-Reply-To: <a8e8043b-5442-4df1-82d1-5f6deb2a9ae2@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2023 11:04:08 +0000
Message-ID: <CAFEAcA8jz9_CuN9Xdf+Zc3Xa_Jbo657wN4+L8im2rgX3u51hQA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ide: implement simple legacy/native mode switching
 for PCI IDE controllers
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Kevin Wolf <kwolf@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 jsnow@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 shentey@gmail.com, Rene Engel <ReneEngel80@emailn.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 21 Nov 2023 at 10:18, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> In the meantime the department of hacks has been looking at ways of trying to set BAR
> addresses during reset, and humbly submits the following for consideration:

> +static void via_ide_bar_reset(void *opaque)
> +{
> +    PCIIDEState *d = PCI_IDE(opaque);
> +    PCIDevice *pd = PCI_DEVICE(d);
> +    uint8_t *pci_conf = pd->config;
> +
> +    /*
> +     * Some OSs e.g. AmigaOS rely on the default BMDMA BAR value being present
> +     * to initialise correctly, even in legacy mode(!)
> +     */
> +    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4,
> +                 0xcc00 | PCI_BASE_ADDRESS_SPACE_IO);
> +
> +    /* Unregister reset function */
> +    qemu_unregister_reset(via_ide_bar_reset, opaque);
> +}
> +
>   static void via_ide_reset(DeviceState *dev)
>   {
>       PCIIDEState *d = PCI_IDE(dev);
> @@ -156,6 +174,9 @@ static void via_ide_reset(DeviceState *dev)
>       pci_set_long(pci_conf + 0x68, 0x00000200);
>       /* PCI PM Block */
>       pci_set_long(pci_conf + 0xc0, 0x00020001);
> +
> +    /* Register separate function to set BAR values after PCI bus reset */
> +    qemu_register_reset(via_ide_bar_reset, d);
>   }

I'm definitely not very enthusiastic about hacks which
increase the usage of qemu_register_reset() and rely
on reset-hook call order. We really need to try to have
another go at cleaning up the reset mess and this would be
yet another thing somebody's going to have to undo some day.
Unregistering your reset function in the reset function is
also rather curious...

thanks
-- PMM

