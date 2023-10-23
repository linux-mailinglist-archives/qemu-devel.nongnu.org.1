Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8D7D3A33
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 16:59:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwNq-0007S5-RR; Mon, 23 Oct 2023 10:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quwNo-0007RN-Qj
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:58:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quwNm-00041Y-2Y
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:58:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso4664985e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698073096; x=1698677896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e2EzXjNN5YGv8FxnzmQqH54j2ihbL0inGkzzYCdE2qs=;
 b=pZhy7/xmEq47jEG/xQh8C1tiEV0abuZPTmb2IWkticdzO4HHIpOg75jJBu65pN0upG
 uhSPMh3fai9MdgAE6EIfefUUBTDJGnEL+3GF+9PN1bkFkJmsNnOmeiPepc5P5a8KKbN/
 EIlajF7OCko4u/afIxx+Zf1bAIjKbRSUTbfRxpy+1xYm07F+p2FyorzIxOo38tN+9OPc
 SfCtk9xqj0HPUB69Ha4CRinKtghhkyDhWF3lQMOekewUdp21ja2OaMeXXKoT7LSqtzcS
 fNALDIn5y+bLZZuDb1GJ2MssyFRIXYJbdqmTkidJLuhUp8Phz1sI8IY/Lt7Nc3tdrE5/
 elWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698073096; x=1698677896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e2EzXjNN5YGv8FxnzmQqH54j2ihbL0inGkzzYCdE2qs=;
 b=IuQWj8QXsvxEckFC0zf0gWUgaeg2G3UR80AGVFJVibv7ymxrWqQhS/DSTpL3zNYpF6
 yQM5nE87NAzOvPiYYjnEOtOjj05JR9mUcDUV+5v8zbrz9+VVs87Zm6ascr/AYJCoc09Q
 qCaUeN6KpaTdPUKtMHeXigM73h64sMZIr+M6O0kB64CeQ7zWlFZI025GjGIQOXs+MtP0
 jxLKmbSa0e0ruoNGe6mwXTDLCVeVeDFdq/1FjbwTKRZ0NjqRFEX/y9uFr5QjFCUlTk1P
 RnUIYLOai5hcydnSkwFaRZMzwVB9tysTMihbHKplhuoYI9WrEa8e+fiAorGtG3ZQOOi3
 rGXA==
X-Gm-Message-State: AOJu0YzpGNwsY6KDQ8g5sAKBuQT/2ii5RXgifL4mj1jQl1euU4vJMQLQ
 xlebTxFdYIDpWSRmxBunJtlhgA==
X-Google-Smtp-Source: AGHT+IEkzpDPW1jUz3ewNunZgLyYEONPD4sVtHxPPTV5J/0eWKxJjaDBSJJg8tcgJEtHD+CWEIdxAQ==
X-Received: by 2002:a05:600c:15c1:b0:3fc:dd9:91fd with SMTP id
 v1-20020a05600c15c100b003fc0dd991fdmr6630589wmf.40.1698073096256; 
 Mon, 23 Oct 2023 07:58:16 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr. [176.170.216.159])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a5d468e000000b00323330edbc7sm7963883wrq.20.2023.10.23.07.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 07:58:15 -0700 (PDT)
Message-ID: <fee75322-5fc5-a1e8-e23c-b49c8177472d@linaro.org>
Date: Mon, 23 Oct 2023 16:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 01/10] hw/fsi: Introduce IBM's Local bus
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org, clg@kaod.org, 
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-2-ninad@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231021211720.3571082-2-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Ninad and Andrew,

On 21/10/23 23:17, Ninad Palsule wrote:
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
> 
> The LBUS is modelled to maintain the qdev bus hierarchy and to take
> advantage of the object model to automatically generate the CFAM
> configuration block. The configuration block presents engines in the
> order they are attached to the CFAM's LBUS. Engine implementations
> should subclass the LBusDevice and set the 'config' member of
> LBusDeviceClass to match the engine's type.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v2:
> - Incorporated Joel's review comments.
> v5:
> - Incorporated review comments by Cedric.
> v6:
> - Incorporated review comments by Cedric & Daniel.
> ---
>   include/hw/fsi/lbus.h | 43 ++++++++++++++++++++++++
>   hw/fsi/lbus.c         | 76 +++++++++++++++++++++++++++++++++++++++++++
>   hw/Kconfig            |  1 +
>   hw/fsi/Kconfig        |  2 ++
>   hw/fsi/meson.build    |  1 +
>   hw/meson.build        |  1 +
>   6 files changed, 124 insertions(+)
>   create mode 100644 include/hw/fsi/lbus.h
>   create mode 100644 hw/fsi/lbus.c
>   create mode 100644 hw/fsi/Kconfig
>   create mode 100644 hw/fsi/meson.build


> +#define TYPE_FSI_LBUS_DEVICE "fsi.lbus.device"
> +OBJECT_DECLARE_TYPE(FSILBusDevice, FSILBusDeviceClass, FSI_LBUS_DEVICE)
> +
> +#define FSI_LBUS_MEM_REGION_SIZE  (2 * 1024 * 1024)
> +#define FSI_LBUSDEV_IOMEM_SIZE    0x400
> +
> +typedef struct FSILBusDevice {
> +    DeviceState parent;
> +
> +    MemoryRegion iomem;
> +    uint32_t address;

[1] 32-bit address,

> +} FSILBusDevice;
> +


> diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
> new file mode 100644
> index 0000000000..50d926dbe2
> --- /dev/null
> +++ b/hw/fsi/lbus.c
> @@ -0,0 +1,76 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Local bus where FSI slaves are connected
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/fsi/lbus.h"
> +
> +#include "hw/qdev-properties.h"
> +
> +static void lbus_init(Object *o)
> +{
> +    FSILBus *lbus = FSI_LBUS(o);
> +
> +    memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_FSI_LBUS,
> +                       FSI_LBUS_MEM_REGION_SIZE - FSI_LBUSDEV_IOMEM_SIZE);
> +}
> +
> +static const TypeInfo lbus_info = {
> +    .name = TYPE_FSI_LBUS,
> +    .parent = TYPE_BUS,
> +    .instance_init = lbus_init,
> +    .instance_size = sizeof(FSILBus),
> +};
> +
> +static Property lbus_device_props[] = {
> +    DEFINE_PROP_UINT32("address", FSILBusDevice, address, 0),

[2] 32-bit address,

> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +DeviceState *lbus_create_device(FSILBus *bus, const char *type, uint32_t addr)
> +{
> +    DeviceState *ds;
> +    BusState *state = BUS(bus);
> +    FSILBusDevice *dev;
> +
> +    ds = qdev_new(type);
> +    qdev_prop_set_uint8(ds, "address", addr);

[3] set 8-bit address but [1] and [2] declare as 32-bit.

> +    qdev_realize_and_unref(ds, state, &error_fatal);

If you pass the bus as argument here, ...

> +
> +    dev = FSI_LBUS_DEVICE(ds);
> +    memory_region_add_subregion(&bus->mr, dev->address,
> +                                &dev->iomem);
> +
> +    qdev_set_parent_bus(ds, state, &error_abort);

... why do you need that call here?

> +
> +    return ds;
> +}

Thanks,

Phil.

