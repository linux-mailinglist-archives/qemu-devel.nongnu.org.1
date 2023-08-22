Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BCE784852
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:21:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYV3j-0001FC-TX; Tue, 22 Aug 2023 13:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYV3T-0001Ep-UE
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYV3R-0006ED-Io
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692724832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8afEd5C1wgR4Lu4+Ci5CU0dZZuQix37S+BkjDEwqtTo=;
 b=UdssgtLBpg8hS/qr4OGhGV+yzzHdbjHzYA70NrIB8TUVb4WFAgqpTEoOp6iCHSHbw2W43v
 ZUR5yvSfQgzvgwljAkeEbPjpRsVSD2ITaCH1V6jcFqjChPCsOd7/6e6zc7Jp72tULeLC69
 1O3ad1nGCkdayAFs90/09zuLrEG4wCE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-TzIbDolpMvGQpSfuN9UoIw-1; Tue, 22 Aug 2023 13:20:31 -0400
X-MC-Unique: TzIbDolpMvGQpSfuN9UoIw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so31764415e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 10:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692724830; x=1693329630;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8afEd5C1wgR4Lu4+Ci5CU0dZZuQix37S+BkjDEwqtTo=;
 b=RqId8DsxKkb3P9WTrTYIymD+OiQoRUX/MkbGVipsH6yrP/OsaAATMjP/PIoA8jCwrm
 LJHD1JiJwb/mWZGl5VJ59tyWm6qh7ZjbQaIw3ksD59VMXJk6ssT2ZGp249fdOD2lqN8s
 5/oyLT3koMw2Y1iMlQKb0tkZ4hUzcx/s1c+qVbFtvo2TWtqrv0Ntop8dFocx2bsCU08R
 KT0FTw7iPYHkuuL3Ut/rOQFm7UpPGGBdhQQN12HXcw1wdJV/wftmRsaOI7wxIHJKHhx/
 a9d3C33paNJRAhcrZyDB78y+XxuA9ya99i79SMxMcJZHkiLospi2ttlzYhDB1xwz3R3j
 G0hA==
X-Gm-Message-State: AOJu0YxjcynUrGOHaJqSIRw9P/9PlN7kkHaYiwxtHfwegNbmgsJj0FG+
 aWqkr0IHaA5j/kfWEYpWTaK3lLWijvp05sWa1tFFa7G62IS3Wm4j+2jeRwrhgs5RWMf/yC9+ey1
 bWC12fw4lqSvgaiw=
X-Received: by 2002:a5d:5702:0:b0:319:6e58:7095 with SMTP id
 a2-20020a5d5702000000b003196e587095mr8019264wrv.66.1692724830313; 
 Tue, 22 Aug 2023 10:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6N+6uHeQrMxXpooqx7lA+5bWvilQxppJKnRaYoW7SC6u3JN6BRbL7hB6NVvGSFtwCHJ/92w==
X-Received: by 2002:a5d:5702:0:b0:319:6e58:7095 with SMTP id
 a2-20020a5d5702000000b003196e587095mr8019246wrv.66.1692724829978; 
 Tue, 22 Aug 2023 10:20:29 -0700 (PDT)
Received: from [192.168.8.100] (tmo-099-195.customers.d1-online.com.
 [80.187.99.195]) by smtp.gmail.com with ESMTPSA id
 m2-20020a05600c280200b003fe3674bb39sm3490780wmb.2.2023.08.22.10.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 10:20:29 -0700 (PDT)
Message-ID: <ad8588fd-7839-2fdc-45c7-bb2b5917ea65@redhat.com>
Date: Tue, 22 Aug 2023 19:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 03/11] hw/misc: add a toy i2c echo device
Content-Language: en-US
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230301165619.2171090-1-clg@kaod.org>
 <20230301165619.2171090-4-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230301165619.2171090-4-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 01/03/2023 17.56, Cédric Le Goater wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add an example I2C device to demonstrate how a slave may master the bus
> and send data asynchronously to another slave.
> 
> The device will echo whatever it is sent to the device identified by the
> first byte received.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> [ clg: integrated fixes :
>    https://lore.kernel.org/qemu-devel/Y3yMKAhOkYGtnkOp@cormorant.local/ ]
> Message-Id: <20220601210831.67259-7-its@irrelevant.dk>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/misc/i2c-echo.c  | 156 ++++++++++++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build |   2 +
>   2 files changed, 158 insertions(+)
>   create mode 100644 hw/misc/i2c-echo.c
> 
> diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
> new file mode 100644
> index 0000000000..5705ab5d73
> --- /dev/null
> +++ b/hw/misc/i2c-echo.c
> @@ -0,0 +1,156 @@
> +#include "qemu/osdep.h"
> +#include "qemu/timer.h"
> +#include "qemu/main-loop.h"
> +#include "block/aio.h"
> +#include "hw/i2c/i2c.h"

  Hi Klaus,

I've got two questions with regards to this new devices:

1) The file lacks a license statement (and a short comment at the beginning 
what it is all about). Could you maybe provide a follow up patch with a 
proper header comment that includes a license and a short description about 
the device?

2) Why is it in hw/misc/ and not in hw/i2c/ ?

I think we should also have a proper Kconfig switch for this device, so we 
can disable it with --without-default-devices, what do you think?

  Thomas


