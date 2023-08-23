Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D47FB78542A
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:32:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkDo-0001cA-0T; Wed, 23 Aug 2023 05:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYkDY-0001Wp-Cb
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYkDW-0007W0-CS
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692783117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bGjQ4va+sX2Ui3XJ6x7VjjJZsFAHEWdQpde31c9SP0=;
 b=AbCSUm+DJzfsYPn3T/K2IkYDGx1S4ZaQ1HFqtfA8RAbxt5N4tFU5/qAvb1VheStsii8JW7
 Y61n2EU6kLZb2PhxwBV5YuZsyqi5l25Isg3whSyYMrO3l/m6yKDynox8GvL8TCtRepsn/+
 MUMzITdlqoaZxOmWRm0iIfndKCfl+sE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-6LfkbDwFPzGsElZphfwUMA-1; Wed, 23 Aug 2023 05:31:55 -0400
X-MC-Unique: 6LfkbDwFPzGsElZphfwUMA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c5cc5537dso1135327f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 02:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692783114; x=1693387914;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2bGjQ4va+sX2Ui3XJ6x7VjjJZsFAHEWdQpde31c9SP0=;
 b=ToXoH6f6thf4u02F3jXldm85HomG+xLCDTWxEMnBv84CUjfNpNTxIaVOBYNrIRZfqA
 AYcynkIBp6/+naUWD6FDBhm5F2/Gv4cst/wHlqO0Q/oGU96kc2VIWf4lGux0phVUBZRI
 otx7sx9jVG9/sp6/ElfFcaWNWTjHRADSELLGACX3OCahG0ZzSw3LD1P8iX2QBbxVvIb9
 NK8KNUR2R6yku5cbHZz0Et7mS3Xq87zjQwXviekCY6jOLx8v0xXYQnPbGUvkMg7GszGC
 Kkdr7PRmZXh4+Y8Rlmi1nDVm8mSizPRJBZAX8vPJvO//jRokmAZYwCErv/dvzpqbSt96
 Pquw==
X-Gm-Message-State: AOJu0Ywz21NWmJzeDnAH+zPqSuo3EDV3V/UQpEdZuGRx1B7VFFJM5FyO
 P16AxkTm0BmAj99DhFdg8QIV2YVGxvixYdpbQXDuVyKp/yiDcH1T1vQx6RclHKNdzGJ9rO8EXti
 PZH+dN82pyIamcuI=
X-Received: by 2002:a5d:6148:0:b0:313:e2e3:d431 with SMTP id
 y8-20020a5d6148000000b00313e2e3d431mr8694828wrt.12.1692783114640; 
 Wed, 23 Aug 2023 02:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4amnVZi2tn4TZD/i44IlCDR7pa2p/XjsejBHwYbkWiq5Yrp6A2v3DpwbUXSdFDtUtl12fVw==
X-Received: by 2002:a5d:6148:0:b0:313:e2e3:d431 with SMTP id
 y8-20020a5d6148000000b00313e2e3d431mr8694808wrt.12.1692783114277; 
 Wed, 23 Aug 2023 02:31:54 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-178.web.vodafone.de.
 [109.43.177.178]) by smtp.gmail.com with ESMTPSA id
 y26-20020a7bcd9a000000b003fef19bb55csm1095973wmj.34.2023.08.23.02.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 02:31:53 -0700 (PDT)
Message-ID: <8d63f53b-99eb-5c7a-ceae-8a5848c29753@redhat.com>
Date: Wed, 23 Aug 2023 11:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] hw/misc/i2c-echo: add copyright/license note
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20230823-i2c-echo-fixes-v2-0-ff404db1bf99@samsung.com>
 <20230823-i2c-echo-fixes-v2-1-ff404db1bf99@samsung.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230823-i2c-echo-fixes-v2-1-ff404db1bf99@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 23/08/2023 11.01, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add missing copyright and license notice. Also add a short description
> of the device.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/misc/i2c-echo.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
> index 5705ab5d7349..8ee03cb5632b 100644
> --- a/hw/misc/i2c-echo.c
> +++ b/hw/misc/i2c-echo.c
> @@ -1,3 +1,11 @@
> +/*
> + * Example I2C device using asynchronous I2C send.
> + *
> + * Copyright (C) 2023 Samsung Electronics Co., Ltd. All Rights Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
>   #include "qemu/osdep.h"
>   #include "qemu/timer.h"
>   #include "qemu/main-loop.h"
> 

Thanks!
Reviewed-by: Thomas Huth <thuth@redhat.com>


