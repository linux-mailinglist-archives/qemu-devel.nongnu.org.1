Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D76745465
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 06:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGAqv-0003j8-1p; Mon, 03 Jul 2023 00:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qGAqR-0003cI-M0; Mon, 03 Jul 2023 00:07:23 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qGAqQ-0002xP-3C; Mon, 03 Jul 2023 00:07:23 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-460eb67244eso1317087e0c.1; 
 Sun, 02 Jul 2023 21:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688357240; x=1690949240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zggpSKb8QJ1LKxFl5cc74TRt3PJdpXQ19gbD3ICxNSM=;
 b=IIvph13z4bDe7N3Itoy/Tbr0xY2/P9YTdcl46flfU7y09VxzNk0b+3gGbYy5tzlV8b
 7D5T2CbPJkScL4FMi2ogkUQVV6EgrMnwVAu8xGbV0gbHe5Lp8Kw8iPfDk08hzHsAsEa8
 deUiETwjqaUaUNmjFsqOHqsv7eVAYqymWZViAzqPUj0GhSrA6VT6XazGr/lmvNZa4IQ2
 0Cpjv1LIrVdSTLl6QI2I7oMKlWjJ5N0aEZRD06l2I3KL0AtPebE70lNU/irkerrmsUY1
 gHkxCX4Mz2PI2LuvUdkhTWDuGMCA6pkYOXS1Mfe9E72MlZ7yEKHf8jM8PwQirCX9e0Nd
 mnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688357240; x=1690949240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zggpSKb8QJ1LKxFl5cc74TRt3PJdpXQ19gbD3ICxNSM=;
 b=SRXE9c7P0aiYIhYse6OKXsSa4oKrcQ++l7hN9LD33gmUxPE+0Jwck94jt3NIr50EoM
 +ZqT5orHsX+QCNBVoOZl8XrC3xEVEwm4fQkvbmiI3zCM8hu9pvGj2XqL2zdmVs5PPJ1S
 1K+pO7hgyemGZEsDRpmUaH2tRL9rUimY5/wdpj7Z8suyWRSXoiLD2dypdMux3aWKHQcG
 MPw05LsIdAzqSvU9dgdK79xlupSi0N1Tt5yl+6L/8A8oIokyFP6wBWGFY6eeNb6GifFH
 /EBxUBhKIgmhYrp4xyoI+lmb90XYZyvdI8ijpBEq4XcosSse5P9k5Wc5Iz/4p21YpnUm
 Bcfg==
X-Gm-Message-State: ABy/qLZEjrVJfacYJ6yvCcuP0s4tvetZcahkrUaySUE3CfDhRJbifTxa
 tzMKTPj2OmDlbCjSRAFznDk7uL+CzFoClRJcXGc=
X-Google-Smtp-Source: APBJJlHE8TTT+ag1HqFqGouzJHWpt+brju0hoqA8pYpRupzw9CfJ+jSxWsdKThIsuJfYW+Cnj1Sm4u6oD878lkbHC44=
X-Received: by 2002:ac5:c957:0:b0:471:7996:228f with SMTP id
 s23-20020ac5c957000000b004717996228fmr4088313vkm.7.1688357240624; Sun, 02 Jul
 2023 21:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230619221819.6882-1-lucas@osdyne.com>
 <6fa294a1-1f1f-7f30-add0-bb49f7d04a65@crans.org>
In-Reply-To: <6fa294a1-1f1f-7f30-add0-bb49f7d04a65@crans.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Jul 2023 14:06:54 +1000
Message-ID: <CAKmqyKOJ1Tq7Dwce=82tbCE2v60U=2k_gpeA7Zojt-co2h694Q@mail.gmail.com>
Subject: Re: [PATCH] STM32F100: support different density lines
To: Alexandre IOOSS <erdnaxe@crans.org>
Cc: Lucas Villa Real <lucas@osdyne.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Jun 26, 2023 at 4:24=E2=80=AFPM Alexandre IOOSS <erdnaxe@crans.org>=
 wrote:
>
> On 6/20/23 00:18, Lucas Villa Real wrote:
> > This patch adds support for the emulation of different density lines
> > (low, medium, and high). A new class property stm32f100-soc.density=3D
> > has been introduced to allow users to state the desired configuration.
> > That property is recognized by a new machine, stm32f1-generic. The SOC
> > is configured according to the following:
> >
> >     density=3Dlow       32 KB FLASH, 2 SPIs
> >     density=3Dmedium   128 KB FLASH, 2 SPIs
> >     density=3Dhigh     512 KB FLASH, 3 SPIs
> >
> > With this code change we should be able to introduce richer features
> > to STM32F100, such as support for FSMC (so that a machine with more
> > RAM capacity can be properly emulated). FSMC is supported on high
> > density line devices only.
>
> Thanks a lot for the patches!
>
> STM32 families look very similar to each other, it makes great sense to
> take a generic approach rather than bloating QEMU with many machines.
>
> You patch proposes to create a "stm32f1-generic" machine. I believe we
> should rather name this machine "stm32f100-generic":
>    - STM32F101 has a XL-density line, STM32F100 does not have a
> XL-density line.
>    - STM32F100 high density line does not have the same maximum SRAM
> size, timers, USART numbers, clock frequencies and CEC peripherals as
> the STM32F101 high density line.
>
> Regarding the stm32vldiscovery machine, I am not against deprecating it
> if we warn users to use stm32f100-generic with density=3Dmedium. This
> makes sense as the development board does not add anything more than
> just some buttons and LED.
> Maybe "stm32vldiscovery" could become an alias for stm32f100-generic
> machine ?
> @Alistair: Do you have an opinion on aliasing the old machine? Is this
> something common in QEMU?

I don't think we have any aliased machines. I think we could do
something like that as well. So the "aliased" machines end up just
being pre-configured generic machines. We just want to do it in a way
to avoid code duplication where we can.

>
> In the long run, we should maybe rename "stm32f100-soc.c" to
> "stm32f1-soc.c" and add another class property to choose the sub-family.
> This would highly reduce potential code duplication.
> STM32F1 machines could take this structure:
>   - stm32f100-generic machine
>     - stm32f1-soc.family=3Df100 stm32f1-soc.density=3Dlow
>     - stm32f1-soc.family=3Df100 stm32f1-soc.density=3Dmedium
>       (alias stm32vldiscovery)
>     - stm32f1-soc.family=3Df100 stm32f1-soc.density=3Dhigh
>   - stm32f101-generic machine
>     - stm32f1-soc.family=3Df101 stm32f1-soc.density=3Dlow
>     - stm32f1-soc.family=3Df101 stm32f1-soc.density=3Dmedium
>     - stm32f1-soc.family=3Df101 stm32f1-soc.density=3Dhigh
>     - stm32f1-soc.family=3Df101 stm32f1-soc.density=3Dxl
>   - stm32f102-generic machine
>     - stm32f1-soc.family=3Df102 stm32f1-soc.density=3Dlow
>     - stm32f1-soc.family=3Df102 stm32f1-soc.density=3Dmedium
>   - stm32f103-generic machine
>     - stm32f1-soc.family=3Df103 stm32f1-soc.density=3Dlow
>     - stm32f1-soc.family=3Df103 stm32f1-soc.density=3Dmedium
>       (alias stm32-nucleo-f103rb)
>     - stm32f1-soc.family=3Df103 stm32f1-soc.density=3Dhigh
>     - stm32f1-soc.family=3Df103 stm32f1-soc.density=3Dxl
> @Alistair: Would such modification make also sense regarding stm32f2 and
> stm32f4 families?

I think that's also ok, but it really only makes sense to do when we
have differentiating features implemented in QEMU.

Alistair

>
> Thanks,
> --
> Alexandre

