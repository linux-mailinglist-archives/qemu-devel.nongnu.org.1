Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAE874ACDA
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:26:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgmS-0006ps-HF; Fri, 07 Jul 2023 04:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgmR-0006pN-05
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:25:31 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgmP-0007at-74
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:25:30 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-992af8b3b1bso196325366b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688718327; x=1691310327;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EfyzPHgaOSVc2aQcmqkNekTVaxbi48vtjbsDnnElRt8=;
 b=RUTaaeTU/bRgba/1nkqxTsAHeE4cT8Kjx7JrWASql40dq3twb3wWoaABxCKi3x4kgH
 Pa6hdPq6POwoAmqBzyTVcY7qyrb7UcVa1iZ0WrVuOzFN7TOS7eAthlkhOVc8Vjy4IiVJ
 n7QLHUqldpoXSkwUuI1bHc43BVpZk/pfNiWDyph1PXLHeF4YTv2RojbICF19BJnJ6cO4
 2KgaB85NbUp0tlEsMYaiDVoFWBq/kOqAzloS6MLcUFcZcOqlIkZAyzeKqpEUucWMJtCQ
 1X0WpTujELoVOTYIHdP1WNlQwwMQhAqPNEwUjgr3cuEwAmTKDF+/xl3kpq6VVNE3luOj
 /JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688718327; x=1691310327;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EfyzPHgaOSVc2aQcmqkNekTVaxbi48vtjbsDnnElRt8=;
 b=gb8syAlIdBhd1IpmOaJ6Vx8vltRayqpAPCcC5iSjd6pzgZJeM875vfAMYaGjg5pFFU
 Tp1N1PpAYaG5WFfEmEU6Sc3PQ2G5srvndYEMh5tiorvNF7O0BhNzBLWOvr9yniGib2Hq
 ujRhYKUo3gy+9l/cTplnhhGa1sWrIkEv0ny6oEETACQkkFY3yI+rXKjppMLLyFyKa6TV
 Z7eUepRPJXYtm637hbTlljVDii4/ahguPuF5V4TsV7Hbuz3QneeAAp+rd9MXc2ZqXXtZ
 dFRFeCcWDH/JoSbHLFSnNMyq+hrNVMv5oABFHOuPa07gvpKqyWb0COXmGfC92GlLyPsg
 aB7Q==
X-Gm-Message-State: ABy/qLYVRfe9Yk9Jg/bwLrpBls+7Tsl29E7+iy/6QdF31UlAkThlnK1t
 n2dPDWYgPxm2ayWOXcUYjhbW1Q==
X-Google-Smtp-Source: APBJJlEJmwC9gpA3QbpuqcTyIKBuxTGQgDyD4xC1C+L9tbEszSzZQZ1dP39gQeYsGKeKstM9BPU+bw==
X-Received: by 2002:a17:907:3da4:b0:990:8807:8f88 with SMTP id
 he36-20020a1709073da400b0099088078f88mr4548795ejc.55.1688718327347; 
 Fri, 07 Jul 2023 01:25:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a17090638cb00b00993a508b818sm1872354ejd.1.2023.07.07.01.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:25:26 -0700 (PDT)
Message-ID: <5eebfd86-e888-5c7b-803c-d4c5f9c7b080@linaro.org>
Date: Fri, 7 Jul 2023 10:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 05/21] q800: add IOSB subsystem
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230702154838.722809-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 2/7/23 17:48, Mark Cave-Ayland wrote:
> It is needed because it defines the BIOSConfig area.
> 
> Co-developed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   MAINTAINERS            |   2 +
>   hw/m68k/Kconfig        |   1 +
>   hw/m68k/q800.c         |   9 +++
>   hw/misc/Kconfig        |   3 +
>   hw/misc/iosb.c         | 137 +++++++++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build    |   1 +
>   hw/misc/trace-events   |   4 ++
>   include/hw/m68k/q800.h |   2 +
>   include/hw/misc/iosb.h |  25 ++++++++
>   9 files changed, 184 insertions(+)
>   create mode 100644 hw/misc/iosb.c
>   create mode 100644 include/hw/misc/iosb.h


> diff --git a/hw/misc/iosb.c b/hw/misc/iosb.c
> new file mode 100644
> index 0000000000..4fc10bcf9f
> --- /dev/null
> +++ b/hw/misc/iosb.c
> @@ -0,0 +1,137 @@
> +/*
> + * QEMU IOSB emulation
> + *
> + * Copyright (c) 2019 Laurent Vivier
> + * Copyright (c) 2022 Mark Cave-Ayland
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "migration/vmstate.h"
> +#include "hw/sysbus.h"
> +#include "hw/misc/iosb.h"
> +#include "trace.h"
> +
> +#define IOSB_SIZE          0x2000
> +
> +#define IOSB_CONFIG        0x0
> +#define IOSB_CONFIG2       0x100
> +#define IOSB_SONIC_SCSI    0x200
> +#define IOSB_REVISION      0x300
> +#define IOSB_SCSI_RESID    0x400
> +#define IOSB_BRIGHTNESS    0x500
> +#define IOSB_TIMEOUT       0x600
> +
> +
> +static uint64_t iosb_read(void *opaque, hwaddr addr,
> +                          unsigned size)
> +{
> +    IOSBState *s = IOSB(opaque);
> +    uint64_t val = 0;
> +
> +    switch (addr) {
> +    case IOSB_CONFIG:
> +    case IOSB_CONFIG2:
> +    case IOSB_SONIC_SCSI:
> +    case IOSB_REVISION:
> +    case IOSB_SCSI_RESID:
> +    case IOSB_BRIGHTNESS:
> +    case IOSB_TIMEOUT:
> +        val = s->regs[addr >> 8];
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "IOSB: unimplemented read addr=0x%"PRIx64
> +                                 " val=0x%"PRIx64 " size=%d\n",
> +                                 addr, val, size);
> +    }
> +
> +    trace_iosb_read(addr, val, size);
> +    return val;
> +}
> +
> +static void iosb_write(void *opaque, hwaddr addr, uint64_t val,
> +                       unsigned size)
> +{
> +    IOSBState *s = IOSB(opaque);
> +
> +    switch (addr) {
> +    case IOSB_CONFIG:
> +    case IOSB_CONFIG2:
> +    case IOSB_SONIC_SCSI:
> +    case IOSB_REVISION:
> +    case IOSB_SCSI_RESID:
> +    case IOSB_BRIGHTNESS:
> +    case IOSB_TIMEOUT:
> +        s->regs[addr >> 8] = val;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "IOSB: unimplemented write addr=0x%"PRIx64
> +                                 " val=0x%"PRIx64 " size=%d\n",
> +                                 addr, val, size);
> +    }
> +
> +    trace_iosb_write(addr, val, size);
> +}
> +
> +static const MemoryRegionOps iosb_mmio_ops = {
> +    .read = iosb_read,
> +    .write = iosb_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +    .impl = {
> +        .min_access_size = 1,

IIUC .impl.min_access_size = 4.

Do you mean .valid.min_access_size = 1?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        .max_access_size = 4,
> +    },
> +};


