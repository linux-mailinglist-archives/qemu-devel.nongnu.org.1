Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A12770045
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 14:31:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRtxU-0003JW-Oh; Fri, 04 Aug 2023 08:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRtxE-0002VC-05
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:31:02 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRtxA-0001Ha-Vm
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:30:51 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-523225dd110so220229a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691152247; x=1691757047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e7e//X0qElnMjAaBtivMTTkIxlU6UVNq5a0mOLXxlNI=;
 b=DmsilKL14v4OBmM23PftkpTmQ8dYIUPdoMEeDE2nf8cXMCQpU34ZUN9vUOWscX3eYR
 bOslX2QgcRWrbD/tuvhzSc+9FWRZKOUzfpYQmBdzARrElgK+BrigMkVuh+npeBKdcFAG
 lIIgF362iUcSuB/z/egBfKI1Hk+6Osn5D7LFc8mHKs6I3Ky4xByXlDdf3cH48SQHMOVm
 JhPx0G0kyM0kGs3mcnsj8dozHahj6zwvqdFUUviSHKR+hCaYWl2FxOKvO3YYNehcGsVn
 J2ymdPJM88QdDsNNB+5ElHxJo2vx8Z21yvWqLR2ARKDco0hy2mUeL5ICM85vLkpEN9Rc
 8q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691152247; x=1691757047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e7e//X0qElnMjAaBtivMTTkIxlU6UVNq5a0mOLXxlNI=;
 b=d/YBkxlLSjWFrj61oqDsTf5Hxq+E2xQ8FXyvslIJFbkcO1mN04CCfipBEUqUEG7xy/
 ng85m9nuOzV8ZbdsgcicEvGnCognNmUn5IAY17w7bcCdBKoSnV9Xw4up/62RBZGwV6kF
 +9/RPsH6OpphdUcVv2MjBBArcswhpTbYUuZZh4C+JGqPFvutgN6cvvc6t7B/cEUPmHOp
 0NyDIDY0YvuM3C3JUqFz/CO4lwb5aydbf3hOrHcgUuTdjniErUTkRgX8bcw/lXRU1w6r
 o3QanKB54hNlEWLY3jqt9O9KRNNaOvlvSnPkBmcY5buS3SGeMTxppphlw2hsn7W29AJe
 19eQ==
X-Gm-Message-State: AOJu0YyP9dMoWIZ43UKCSoV84SqMGaPDK4t1K4uHlgU11+yCGCZDUQby
 KcXo3AZY6g8H/g5zDv1TqbQFDqzQ8Am+/XXazDFkBA==
X-Google-Smtp-Source: AGHT+IHmCXj+wb0dfu1VT3pGUhDtO6I96DOMA+G+TqVE09xBNZD2u7sP7/5lrv4r+A7+6vuVXkU4MPviAe7ApPx1WS4=
X-Received: by 2002:aa7:dc12:0:b0:522:cb97:f198 with SMTP id
 b18-20020aa7dc12000000b00522cb97f198mr1327319edu.38.1691152247283; Fri, 04
 Aug 2023 05:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-11-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-11-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 13:30:36 +0100
Message-ID: <CAFEAcA9Zo7LcPTmBNrtCs2931EEDkqd-WSpYW-By=tuo=8bijw@mail.gmail.com>
Subject: Re: [PATCH 10/44] Add BCM2838 checkpoint support
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 26 Jul 2023 at 14:26, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/gpio/bcm2838_gpio.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
> index 7291e473dc..f1121f9c58 100644
> --- a/hw/gpio/bcm2838_gpio.c
> +++ b/hw/gpio/bcm2838_gpio.c
> @@ -17,6 +17,7 @@
>  #include "qemu/timer.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
> +#include "migration/vmstate.h"
>  #include "hw/sd/sd.h"
>  #include "hw/gpio/bcm2838_gpio.h"
>  #include "hw/irq.h"
> @@ -324,6 +325,21 @@ static const MemoryRegionOps bcm2838_gpio_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>
> +static const VMStateDescription vmstate_bcm2838_gpio = {
> +    .name = "bcm2838_gpio",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(fsel, BCM2838GpioState, BCM2838_GPIO_NUM),
> +        VMSTATE_UINT32(lev0, BCM2838GpioState),
> +        VMSTATE_UINT32(lev1, BCM2838GpioState),
> +        VMSTATE_UINT8(sd_fsel, BCM2838GpioState),
> +        VMSTATE_UINT32_ARRAY(pup_cntrl_reg, BCM2838GpioState,
> +                             GPIO_PUP_PDN_CNTRL_NUM),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void bcm2838_gpio_init(Object *obj)
>  {
>      BCM2838GpioState *s = BCM2838_GPIO(obj);
> @@ -355,6 +371,7 @@ static void bcm2838_gpio_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>
> +    dc->vmsd = &vmstate_bcm2838_gpio;
>      dc->realize = &bcm2838_gpio_realize;
>      dc->reset = &bcm2838_gpio_reset;

Oh, this is where the vmstate struct ended up. I think
I would suggest putting this in patch 6, since that's
where you add the struct fields. (Define the sd_fsel
field there too.)

thanks
-- PMM

