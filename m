Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F52572D46D
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 00:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8q40-0000cj-QD; Mon, 12 Jun 2023 18:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8q3v-0000bz-5Z
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:31:00 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8q3s-0007DY-JC
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:30:58 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-97458c97333so801268966b.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686609055; x=1689201055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tr/KRiX+6SzDsT1HgRQhYPL6bZhcCPkCG5AWun5VaoM=;
 b=KHL7v8xRJE90HXXASdyOxJIVSXJ6PXsxC0Mip80YOsmQnCYhKSi0bWNl2qD5X5RFU/
 9PDZpwHKbEVU46yKVz91GmQ9e3mc37fs3uOV2L2yS9tgooUKzNztYTKqL4PXsEVVTiOo
 fIb4EAvITid4isL/e4dt0TDyxQNZYWxM9t5ve25GSWETz2lV6FfWVZIcgoQO++AYnOY3
 wIe8wFRLTFiolcr/nXlLuIm67KXSgWv67x7DH2YzQapSX/K7qYAhaqJwcCBsCrmtX6K/
 k37vla+jMDugehiPD01oBaaolPDfEKiRU27DN95uPquxdZlT3/JYBstBe6V8afKsxpWd
 TM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686609055; x=1689201055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tr/KRiX+6SzDsT1HgRQhYPL6bZhcCPkCG5AWun5VaoM=;
 b=XdzTsSKHshTE7W1CVhuN5vRJpUAULWMf/xztuZj/tX1bc2Ax9TKgEVRSs8b8vWcXIR
 FY+mLNgPQFlGdUnqdd3UyuzupJZ4KCF6DN4OXodBxhtKX56Qv2ErrILW2kc2GhkLYz6W
 TYbRaMrsVe3oENHv+TKi6bhX3AjigedmrWN2jBOt1Wm6kr/JgVQtwJivqg3v7ZIUkdTX
 IP43H8gaGt5mNS2ZS6c5W56VUp8SIX1hABeUKs8WdFIexDiGdVBnyfkNbdwRfIEnrTeU
 NxnADutVn3w34lXGbEXuHB7ZZsw/ISDnsAze96LqWuOh3ajwfIblXr8MUnSUCZKDoamf
 iepA==
X-Gm-Message-State: AC+VfDwqWbnlStBDh4gMRB9im9r2TSpBiD2SUXyNVd/xRWXoAXYWj7kw
 9BcP4AGi8P7CbtzjTirj1S+dGh80BEkUdJcs1oqLkw==
X-Google-Smtp-Source: ACHHUZ7jF44vFCSB2rT7aN7EADolC6vgZFAAWqO34v39RQ7+BLkkDXm5ZX/TERPDhbrIxD5Ox2JAIw==
X-Received: by 2002:a17:906:99c1:b0:973:ca9c:3e43 with SMTP id
 s1-20020a17090699c100b00973ca9c3e43mr11771630ejn.45.1686609054558; 
 Mon, 12 Jun 2023 15:30:54 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a170906710f00b009745bac0567sm5675048ejj.126.2023.06.12.15.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 15:30:54 -0700 (PDT)
Message-ID: <6fe833be-d884-663d-a58e-d3716e52e3d9@linaro.org>
Date: Tue, 13 Jun 2023 00:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2] Use named constants in BCM props
Content-Language: en-US
To: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>
References: <5b407848-2a4c-6447-6726-cf85f278f3e7@linaro.org>
 <20230612115950.5002-1-sergey.kambalin@auriga.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230612115950.5002-1-sergey.kambalin@auriga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 12/6/23 13:59, Sergey Kambalin wrote:
> ping
> 
> - PI_FIRMWARE_*_RATE constsnts were moved to raspberrypi-fw-defs.h
>    (seems more suitable place for them)
> - inclusion of "qemu/osdep.h" has been removed
> - year in copyright header has been updated
> 
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>   hw/misc/bcm2835_property.c            | 120 ++++++++++---------
>   include/hw/arm/raspi_platform.h       |   6 +
>   include/hw/misc/raspberrypi-fw-defs.h | 163 ++++++++++++++++++++++++++
>   3 files changed, 236 insertions(+), 53 deletions(-)
>   create mode 100644 include/hw/misc/raspberrypi-fw-defs.h


> diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
> index 4a56dd4b89..92a317950a 100644
> --- a/include/hw/arm/raspi_platform.h
> +++ b/include/hw/arm/raspi_platform.h
> @@ -170,4 +170,10 @@
>   #define INTERRUPT_ILLEGAL_TYPE0        6
>   #define INTERRUPT_ILLEGAL_TYPE1        7
>   
> +/* Clock rates */
> +#define RPI_FIRMWARE_EMMC_CLK_RATE    50000000

OK.

> +#define RPI_FIRMWARE_UART_CLK_RATE    3000000

OK.

> +#define RPI_FIRMWARE_CORE_CLK_RATE    350000000

Seems VC4 frequency range, adapted for raspi3 (BCM2837).

IIUC the VC6 (raspi4) is clocked at 500MHz.

> +#define RPI_FIRMWARE_DEFAULT_CLK_RATE 700000000

Seems VC4 freq for raspi1 (BCM2835)

Likely we don't want to use a default, but the correct per-soc
value...

