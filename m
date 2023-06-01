Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 998C171F3ED
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 22:35:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ozw-0003i8-L2; Thu, 01 Jun 2023 16:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ozn-0003ga-Th
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:34:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ozm-0002ln-BZ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:34:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f623adec61so13880995e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685651644; x=1688243644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+JAka0+tEHpDMSyk+O+xQR7Yhske2YdqVaIN/w1k4wU=;
 b=PXyD/cFN7q9Apt/IR/diU11MArJVf3BsZWzWERCCM/M7cdkxfmRvWr75rhkbO9snqp
 XOqtep3+xjPHkS/+V0AVDVY108QD30yQ47/dxKOgRGkx66kmPCks4/rMx4aqt6B6cIlc
 G3hgCWXr62VE1wz5bi7FIfXVC8Gi5WAFNQcqNaYEYx7FutQ5Zbs9znA6ZDEx9kYIJYl5
 gbbzEpdvvGf5C1LWQV5H1AN5jmECqwQjIr1xfLJxchYLAaxU+PkYrETNPW2iDHfignhf
 i8YiDIJj4wiI/gRk6OLoYgEOSJvuv221Ge8oK370chhIh5Q8Xm/496Irfzzz0aOI5PFo
 EaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685651644; x=1688243644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+JAka0+tEHpDMSyk+O+xQR7Yhske2YdqVaIN/w1k4wU=;
 b=MB94VctXfwVujXD9rg7kMEub7L0jeliik2W/FF1SxDEiWYsiK11HDGQ4hQFVOR+EuH
 GcaDGe/ixVIuKEOdssN6+aqfUMz2hVekb6vKsIohWkB7kSTk8ndW6eokiHsZzSCwxdJE
 ATam9yL9ggRZJCpMTuE/ZZ3GFKNsWi4JcDpIA3Jkacn0uqt47GNwzqpFX4hJue9UIlsW
 trjGv2WpmxEpuHfbmrVYkG97BIAsAhGDr1FUF+XAlw9oED+h3Kq20zFr6di4p5NV1YrP
 C0pE5OejTbR8RKC+38UWzylHor/kOBBfjQ1R7sLiCxsoBONN3o24taYi/9JshE4fECCe
 Ox5A==
X-Gm-Message-State: AC+VfDy5eiNmxn8ZchE7A7ELaLbEsy0xQNLKako8bPMsWq0ts7A08ynt
 WPD8+27VRrT8SwlqzM7C+stLGw==
X-Google-Smtp-Source: ACHHUZ6NrL3rnGBxRAGack5ThemG8fzk7gKw0/hc+SlchVF5lgx9Hiuq2Z4Brl6PqP6FBHDt46br+Q==
X-Received: by 2002:a1c:7208:0:b0:3f6:7f0:c9a9 with SMTP id
 n8-20020a1c7208000000b003f607f0c9a9mr382524wmc.33.1685651644731; 
 Thu, 01 Jun 2023 13:34:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c230800b003f6cf9afc25sm3410029wmo.40.2023.06.01.13.34.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 13:34:04 -0700 (PDT)
Message-ID: <c2ed4756-1a5e-88b4-b02b-21660c041f7c@linaro.org>
Date: Thu, 1 Jun 2023 22:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/3] hw/i2c: add smbus pec utility function
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>, Keith Busch <kbusch@kernel.org>,
 Jason Wang <jasowang@redhat.com>, Lior Weintraub <liorw@pliops.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 qemu-arm@nongnu.org, Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Klaus Jensen <k.jensen@samsung.com>, Peter Maydell
 <peter.maydell@linaro.org>, gost.dev@samsung.com
References: <20230531114744.9946-1-its@irrelevant.dk>
 <20230531114744.9946-2-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531114744.9946-2-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/5/23 13:47, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add i2c_smbus_pec() to calculate the SMBus Packet Error Code for a
> message.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/i2c/smbus_master.c         | 28 ++++++++++++++++++++++++++++
>   include/hw/i2c/smbus_master.h |  2 ++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/hw/i2c/smbus_master.c b/hw/i2c/smbus_master.c
> index 6a53c34e70b7..47f9eb24e033 100644
> --- a/hw/i2c/smbus_master.c
> +++ b/hw/i2c/smbus_master.c
> @@ -15,6 +15,34 @@
>   #include "hw/i2c/i2c.h"
>   #include "hw/i2c/smbus_master.h"
>   
> +static uint8_t crc8(uint16_t data)
> +{
> +#define POLY (0x1070U << 3)

static const unsigned crc8_poly = ..., but why not inline the single use?
   data ^= 0x1070U << 3;
and
   data <<= 1;

> +    int i;
> +
> +    for (i = 0; i < 8; i++) {
> +        if (data & 0x8000) {
> +            data = data ^ POLY;
> +        }
> +
> +        data = data << 1;
> +    }
> +
> +    return (uint8_t)(data >> 8);
> +#undef POLY
> +}

We have "qemu/crc32c.h", maybe we could have a similar crc8.h. Just 
wondering...

