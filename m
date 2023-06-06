Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A618B724348
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:56:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6WDf-0005ms-5C; Tue, 06 Jun 2023 08:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6WDb-0005hK-Os
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:55:24 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6WDY-0005e8-LX
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:55:23 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51456392cbbso14710375a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686056119; x=1688648119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85UBdEdERd4KJcJO5unaRiXp6CTnDnxCR6aFfSs5Cu0=;
 b=XPFY701dXLeyz8B17Y5CYy6jMBfAUGnPeqTw2fnNOVVCVaUITUcfy8CGQp9vjYTtBt
 AxGGImi9slDRg0j3ygXagQHssPnLvDtXMhRqwccgGJPbb84d/90RWaJ1SgjTirxy9C4E
 5p3Y4L5pxX4+hy0Xq7wY0uuI88ns7BXgC7NQBVJqYQmIA4oNfvUVUVSAmOYTg40pguB3
 W6K7XkXtJgYNAMDr/AunZhfAL8MEtCbCyyck4TN1ylX3thTyYYq7qj5pTZOENeI/bPHV
 z1tHj2Fnw4K8CZse8fkL3Hps7S3zpnZ2tb3UHFjMWcnXD1SIs6t2k5ZTQgIVg4AHNApA
 heaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686056119; x=1688648119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85UBdEdERd4KJcJO5unaRiXp6CTnDnxCR6aFfSs5Cu0=;
 b=jZakz8OCX/+jr7xtwFCkcMAUCmlMkbnuBdROc7xZmCunJIEDqt2cSHHmZGPHg9Rjzp
 60MvJ81uXvCLHT7Lc1yItRmbjqhlQVLMqsVpuSuIsGx4pdNbVmp0HTvNGX26qolDI9aa
 ZYtS6gBjjhlXQKFpEZ9TMMXx5i4fOW4vxMnZxeU+TKRN82VlxsRBgcApd2GLt4PWsU5g
 tldZaBqB52bQc6LklRD4dj3uBkhekVeUROljpdbJ1l2+J+DPAsLrKqVfayA/P3FfYDUJ
 Pw1NGVmL9KQpdhKStAeEc7Opsj9V7hIeOoAfdNadNP+XPef45IPsOjXEuGtU3LUtBm0M
 sFrA==
X-Gm-Message-State: AC+VfDxS1aOO4y0i9D53UdF2y/kDykPh8ggquPuTZRK4xXrhGy5uE1+k
 Ci9zzk11alkDwi/jNbJftZ9vOFHl5rK+nOrT32VSdg==
X-Google-Smtp-Source: ACHHUZ7DZ/xLcV099gmCAgvIXR60MrJ3l+0XVJufKhm62kTeZGxTJSSitRSfYOy6FYXgQ0e0JfkMs0utdfnFNyCE6q8=
X-Received: by 2002:a05:6402:348b:b0:513:e95c:6eb9 with SMTP id
 v11-20020a056402348b00b00513e95c6eb9mr13389507edc.14.1686056118921; Tue, 06
 Jun 2023 05:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230606104609.3692557-1-peter.maydell@linaro.org>
 <20230606104609.3692557-3-peter.maydell@linaro.org>
 <635fdcd8-23fe-c0db-c912-3aa0517dd4b7@linaro.org>
In-Reply-To: <635fdcd8-23fe-c0db-c912-3aa0517dd4b7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2023 13:55:07 +0100
Message-ID: <CAFEAcA9cObnb11cSS_StbSHdP0aB6sDeqSHfjb3-qRBfy7K9Kw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/allwinner-sdhost: Don't send non-boolean IRQ
 line levels
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Guenter Roeck <linux@roeck-us.net>, qemu-stable@nongnu.org, 
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 6 Jun 2023 at 13:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi Peter,
>
> On 6/6/23 12:46, Peter Maydell wrote:
> > QEMU allows qemu_irq lines to transfer arbitrary integers.  However
> > the convention is that for a simple IRQ line the values transferred
> > are always 0 and 1.  The A10 SD controller device instead assumes a
> > 0-vs-non-0 convention, which happens to work with the interrupt
> > controller it is wired up to.
> >
> > Coerce the value to boolean to follow our usual convention.
>
> I remember once wanting to convert qemu_set_irq() to take a boolean
> argument but someone said using integer was more useful because ...?
> I searched a bit but can't find that in my mail archives, maybe this
> was on IRC. Any clue? (I find simpler to use a boolean rather than
> having a convention of using integers restricted to [0, 1] range).

We have a lot of use cases where we just want to transfer a boolean
value between two devices. We have a few use cases where we want to
transfer an arbitrary integer across the channel between two devices.
(For instance hw/intc/etraxfs_pic.c:pic_update() sends a vector
number to the CPU via a qemu_irq -- see commit f4f643882d9dc467.)

At the moment we use qemu_irq() for both. In theory we could
construct a parallel set of machinery for wiring up and setting
values for the "want an integer" case and restrict qemu_irq() to
bool only, but the lazy path is to use the same function for both.
(If we had machinery that made it easy to construct arbitrary
strongly-typed signal connections, that might perhaps be ideal.
But it's probably not very easy especially in C.)

thanks
-- PMM

