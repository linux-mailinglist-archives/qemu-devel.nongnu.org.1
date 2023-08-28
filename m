Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B3778A57D
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 08:04:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaVLO-0000zX-F3; Mon, 28 Aug 2023 02:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qaVLH-0000z8-MC
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 02:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qaVLE-0004vG-U1
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 02:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693202591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bu/paopx584DvT4r5vPZbvNY2VdQEV/kmRsDQwn0MhQ=;
 b=CelYVnASzcDHcGs9QjIls3INKWzlt0JuL+lW2H6/tHOn2dT93WFGfcwxgyisDnFSJPP5FV
 hpUtNDF1g1qXlaXm6Ywdez/1mqAyrnCFMYKtXDKy/SDBD+zODykleYTRwfPdvVsdImOr2D
 NDDt5llrjKfrXqFQNfVBIzguawPYYfM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-2J1ck_CwM6WsEN60lBIvLg-1; Mon, 28 Aug 2023 02:03:09 -0400
X-MC-Unique: 2J1ck_CwM6WsEN60lBIvLg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a348facbbso218947766b.1
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 23:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693202588; x=1693807388;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bu/paopx584DvT4r5vPZbvNY2VdQEV/kmRsDQwn0MhQ=;
 b=fBRgXMXsQYfgwo/GcBf/JS4Rw/nzafn39eSFXOPwXeE98a9apv5WA4K6/u7juGmqtD
 JdxPFd67sljvMnMAkgZe/lDmghkeU3N1UAQPGgiwK3kn0VWNmmdLmI4WxAiRJTSopQGc
 SEdixsHgFS15Cx6fXvevnW4WIhM0OtKtSDJjUfJtPvYiV4ZCv6K7xdaoiBHb0gIVxLff
 MOD54qykzcaH9Bri6nJc9+lxGyJvzzj16CWchSJXI/S6AangDI1kd/H+6XEUmNPRnrIb
 tTDM596fmIM8L8mQDliNToRYFRbI9pembRn8ZuHfdmSoO7P158uitDCrxgnujJbjlWG7
 lC0Q==
X-Gm-Message-State: AOJu0Yz+A+EfuG1IuDLegqgjnR9LrPP4UWdzXtFth0lAcZPT7AfmaJcg
 o4Gb50elMe9Cn75f0WcsAMR0zevA497EVqnvzdgcZ2q5I3tUwGrzik8Npiz9PDw3E7xyYWJL2qG
 VhBBcNt7TyVFdFvc=
X-Received: by 2002:a17:906:ae81:b0:99d:f47b:854c with SMTP id
 md1-20020a170906ae8100b0099df47b854cmr16686212ejb.72.1693202588278; 
 Sun, 27 Aug 2023 23:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvBKCw0rqV4Sa1FTySc9Pa7m2DYXRQ1F4L7LSS3oVkvt2sWaWIyb4h/1b4s8Pse4ll/kTrMQ==
X-Received: by 2002:a17:906:ae81:b0:99d:f47b:854c with SMTP id
 md1-20020a170906ae8100b0099df47b854cmr16686196ejb.72.1693202588007; 
 Sun, 27 Aug 2023 23:03:08 -0700 (PDT)
Received: from [192.168.8.103] (tmo-098-91.customers.d1-online.com.
 [80.187.98.91]) by smtp.gmail.com with ESMTPSA id
 jj26-20020a170907985a00b00988e953a586sm4251401ejc.61.2023.08.27.23.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Aug 2023 23:03:07 -0700 (PDT)
Message-ID: <e2a8e6eb-b9fd-8011-32c0-e5c310bf1135@redhat.com>
Date: Mon, 28 Aug 2023 08:03:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org, clg@kaod.org, 
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org
Cc: qemu-arm@nongnu.org
References: <20230825203046.3692467-1-ninad@linux.ibm.com>
 <20230825203046.3692467-4-ninad@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 3/7] hw/fsi: Introduce IBM's cfam,fsi-slave
In-Reply-To: <20230825203046.3692467-4-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.414, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/08/2023 22.30, Ninad Palsule wrote:
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
> 
> The Common FRU Access Macro (CFAM), an address space containing
> various "engines" that drive accesses on busses internal and external
> to the POWER chip. Examples include the SBEFIFO and I2C masters. The
> engines hang off of an internal Local Bus (LBUS) which is described
> by the CFAM configuration block.
> 
> The FSI slave: The slave is the terminal point of the FSI bus for
> FSI symbols addressed to it. Slaves can be cascaded off of one
> another. The slave's configuration registers appear in address space
> of the CFAM to which it is attached.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
...
> diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
> new file mode 100644
> index 0000000000..19256050bd
> --- /dev/null
> +++ b/hw/fsi/cfam.c
> @@ -0,0 +1,235 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Common FRU Access Macro
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +
> +#include "hw/fsi/bits.h"
> +#include "hw/fsi/cfam.h"
> +#include "hw/fsi/engine-scratchpad.h"
> +
> +#include "hw/qdev-properties.h"
> +
> +#define TO_REG(x)                          ((x) >> 2)
> +
> +#define CFAM_ENGINE_CONFIG                  TO_REG(0x04)
> +
> +#define CFAM_CONFIG_CHIP_ID                TO_REG(0x00)
> +#define CFAM_CONFIG_CHIP_ID_P9             0xc0022d15
> +#define   CFAM_CONFIG_CHIP_ID_BREAK        0xc0de0000
> +
> +static uint64_t cfam_config_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    CFAMConfig *config;
> +    CFAMState *cfam;
> +    LBusNode *node;
> +    int i;
> +
> +    config = CFAM_CONFIG(opaque);
> +    cfam = container_of(config, CFAMState, config);
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: read @0x%" HWADDR_PRIx " size=%d\n",
> +                  __func__, addr, size);
> +
> +    assert(size == 4);
> +    assert(!(addr & 3));
> +
> +    switch (addr) {
> +    case 0x00:
> +        return CFAM_CONFIG_CHIP_ID_P9;
> +    case 0x04:
> +        return ENGINE_CONFIG_NEXT
> +            | 0x00010000                    /* slots */
> +            | 0x00001000                    /* version */
> +            | ENGINE_CONFIG_TYPE_PEEK   /* type */
> +            | 0x0000000c;                   /* crc */
> +    case 0x08:
> +        return ENGINE_CONFIG_NEXT
> +            | 0x00010000                    /* slots */
> +            | 0x00005000                    /* version */
> +            | ENGINE_CONFIG_TYPE_FSI    /* type */
> +            | 0x0000000a;                   /* crc */
> +        break;
> +    default:
> +        /* FIXME: Improve this */
> +        i = 0xc;
> +        QLIST_FOREACH(node, &cfam->lbus.devices, next) {
> +            if (i == addr) {
> +                return LBUS_DEVICE_GET_CLASS(node->ldev)->config;
> +            }
> +            i += size;
> +        }
> +
> +        if (i == addr) {
> +            return 0;
> +        }
> +
> +        return 0xc0de0000;

Can you explain the magic number at least with a comment?

Maybe it would also make sense to add a qemu_log_mask(LOG_GUEST_ERROR, ...) 
or qemu_log_mask(LOG_UNIMP, ...) statement here?

  Thomas


