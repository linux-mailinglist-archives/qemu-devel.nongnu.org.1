Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE147D3A39
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:01:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwQ0-0008L1-3J; Mon, 23 Oct 2023 11:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quwPy-0008KR-BU
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:00:34 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quwPw-0004YI-Kb
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:00:34 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32da7ac5c4fso2369389f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698073231; x=1698678031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kicTszKU+ggVTH3JEPr92mkhctMS2m9aLuv4e/r5iC4=;
 b=SdOL/NnaNS7kEQJMNMuw1SMzFXtlxf/WP5rfccKP+oiljfL/RIYCHJYMnePnTz5oD4
 EuSUZyHEdnErjpG5m8C0g/MoW6BtVw8ECenmYxfC02cQctrzx+6TkkG/J7K8uHFZAXDF
 NQ8eAFFnMm2a4BMF4ngon1eOiksGmG5EkJQ95SOIwH1/EJIoGjc+JAKNB3SGM76qN3KN
 J0kbEmqWcMlMauFvxOaIYNxxsznmOMsq9WRvQmDSHKfXcX9wUK/qPzOhMfTiFnUUEW11
 6CKzsI9SZsDX4Cm5u/JsptIUgURqUZpbz7fqGlu1DyGldWjJ2TziHuHx36j7uawTb0Jz
 TKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698073231; x=1698678031;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kicTszKU+ggVTH3JEPr92mkhctMS2m9aLuv4e/r5iC4=;
 b=p/YFTI+9jBwuE8rUUSrPzV83eA1DHt/KdSUrxYl1rWcTO/GbORB/MkMi/YnVdIs1lj
 JS2nbYvWqvDXUKdrTUPN744Srl4juOemt+u/blNm18wfPuB8KjIRhVKeI1HWZ+bZRdhN
 qbTVOle8BRmeEjAQ+sWDbbLVYAULiZd/GFYcpT4ccMH5jghsHJ9BWVRc2W+HFw0ZNc3y
 +qRNYr8kfkDxASwRSudhjheq87sdvJxrkWwzzNSUfzF6HoSolWUvLd+wX2rA/XHSGyZi
 6ueB6TzXm3ytqMq6fmyKs8h0CVifU1Bi1mBWj0XMS2KTq7NYvHkqOHwareWVOznLYX1Q
 /oDA==
X-Gm-Message-State: AOJu0YzMM8ftj2uwXVsS+g6aiWXLP3kYwkXH9i3heq1704RCTefB+B9q
 85Zohgn59X9HbjnyGbL6bFKyOA==
X-Google-Smtp-Source: AGHT+IHUVac4hEFBrF8IFgcx9OETiDoulltMpm3q4qCoq8SuxGZlo48bOu6ZJGc2+8SPyMscF1h0Pw==
X-Received: by 2002:adf:f50d:0:b0:31f:afeb:4e7e with SMTP id
 q13-20020adff50d000000b0031fafeb4e7emr5917857wro.37.1698073230074; 
 Mon, 23 Oct 2023 08:00:30 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr. [176.170.216.159])
 by smtp.gmail.com with ESMTPSA id
 m10-20020adffe4a000000b0032ddc3b88e9sm8010070wrs.0.2023.10.23.08.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 08:00:29 -0700 (PDT)
Message-ID: <957bc5db-53aa-6946-edf3-3b728a52b660@linaro.org>
Date: Mon, 23 Oct 2023 17:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 02/10] hw/fsi: Introduce IBM's scratchpad
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org, clg@kaod.org, 
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-3-ninad@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231021211720.3571082-3-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 21/10/23 23:17, Ninad Palsule wrote:
> This is a part of patchset where scratchpad is introduced.
> 
> The scratchpad provides a set of non-functional registers. The firmware
> is free to use them, hardware does not support any special management
> support. The scratchpad registers can be read or written from LBUS
> slave.
> 
> In this model, The LBUS device is parent for the scratchpad.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v2:
> - Incorporated Joel's review comments.
> v5:
> - Incorporated review comments by Cedric.
> v6:
> - Incorporated review comments by Daniel.
> ---
>   meson.build                        |  1 +
>   hw/fsi/trace.h                     |  1 +
>   include/hw/fsi/engine-scratchpad.h | 32 ++++++++++
>   include/hw/fsi/fsi.h               | 16 +++++
>   hw/fsi/engine-scratchpad.c         | 93 ++++++++++++++++++++++++++++++
>   hw/fsi/Kconfig                     |  4 ++
>   hw/fsi/meson.build                 |  1 +
>   hw/fsi/trace-events                |  2 +
>   8 files changed, 150 insertions(+)
>   create mode 100644 hw/fsi/trace.h
>   create mode 100644 include/hw/fsi/engine-scratchpad.h
>   create mode 100644 include/hw/fsi/fsi.h
>   create mode 100644 hw/fsi/engine-scratchpad.c
>   create mode 100644 hw/fsi/trace-events


> diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
> new file mode 100644
> index 0000000000..e65f26f17b
> --- /dev/null
> +++ b/include/hw/fsi/fsi.h
> @@ -0,0 +1,16 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Flexible Service Interface
> + */
> +#ifndef FSI_FSI_H
> +#define FSI_FSI_H
> +
> +/* Bitwise operations at the word level. */
> +#define BE_BIT(x)                          BIT(31 - (x))
> +#define GENMASK(t, b) \
> +    (((1ULL << ((t) + 1)) - 1) & ~((1ULL << (b)) - 1))

Please use MAKE_64BIT_MASK() from "qemu/bitops.h".

> +#define BE_GENMASK(t, b)                   GENMASK(BE_BIT(t), BE_BIT(b))
> +
> +#endif


