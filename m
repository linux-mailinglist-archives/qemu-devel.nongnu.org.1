Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01036811ACB
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:20:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDSt9-0005EX-Ll; Wed, 13 Dec 2023 12:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDSt6-0005EC-20
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:19:12 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDSt3-0000ZH-5P
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:19:11 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50bf37fd2bbso9704729e87.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 09:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702487947; x=1703092747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cUXbJdod+qXiv1eefPiwF2Y2tlliZuou7lqWUhtrrU8=;
 b=WDbuTEoTe76WrM6kYa3gxy9UuygKwSSzWESjlLP214owq5sAUxKItyejelSApGeoUh
 IP52iENeX4hbnp0M1yjGyl+sMyb1CBFEQcxHU0QergN0PKsCsDkD8+KDOas+XwMFkuLA
 4DMnii7DQdJwWCgGIDuTyT1meWgi19qtA9QC8y0bv6506FUKFDwFIrBEJ3h2fCgSDDSF
 S7xVGL3oTf/GQE1kDChYjQr40G1kLWZVUy4XQoZHyUv3RBmLw7MIASApzPv3Sq83bM9Y
 Uif3QZKCTKjSkzhoVsVo1vDYdRlUqJBLEiqRvSc0B6RSTYwZEetxJV5iF5kSuPoOqKf5
 I04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702487947; x=1703092747;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cUXbJdod+qXiv1eefPiwF2Y2tlliZuou7lqWUhtrrU8=;
 b=RevUNjr3J6FCLKefMK5IDIrswGeO77b/c5/2Fftvh5cffGhvK9Dy1hx3KDvRkT4ZBO
 Xq8aZgb3qr4U31IzK9OrF2DjfgdClVRbCE6Vqb2u8OQLelips7Dmj/8947PmcMzOyuT1
 5pTEk2clMdkv9X+JiyTEAQYNInzl5lljATeuKr9sZ/Hu48DKCMfZDeXPVI0vf8FLkFIT
 o3/sMOh1jA1mQtICCf9WK172FROK93/OhWyTCljHQFRQHXXHXuKm8+EoZ0zTHun8joqi
 jli3JAlhFYyAhZby+cQuADsx6zjZazEdIXhMvv/K0wQgOIriSU1Qw6qJhlOtgW6IzWIi
 vLKA==
X-Gm-Message-State: AOJu0YyPHb0jfCZjrSCUhQ2HulfvNdtPuHbvoYACE+pBZqlZM/pCBYN2
 1SLkaZzzztXNNQhMEwtf/V0dAg==
X-Google-Smtp-Source: AGHT+IGc8zUCrYg/gxXpN+6DAys4IVutjKTyYPW3ZSfPbER5ZmvnopIU1XciDmjz5In6dnHumln3xQ==
X-Received: by 2002:ac2:5fac:0:b0:50b:efe8:f5e8 with SMTP id
 s12-20020ac25fac000000b0050befe8f5e8mr3562274lfe.88.1702487946985; 
 Wed, 13 Dec 2023 09:19:06 -0800 (PST)
Received: from [192.168.79.175] ([93.23.251.22])
 by smtp.gmail.com with ESMTPSA id
 vw15-20020a170907a70f00b00a22ff4994e9sm1179986ejc.214.2023.12.13.09.19.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 09:19:06 -0800 (PST)
Message-ID: <9acdbf95-492d-4cce-98f5-d774a277d214@linaro.org>
Date: Wed, 13 Dec 2023 18:19:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/pxa2xx_mmci: Disable reentrancy detection
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231213014932.1748323-1-linux@roeck-us.net>
 <CAFEAcA9KU855jn8xDQtbf58Byg0NCq-aB3tPcf8sB6YLyLkvWQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9KU855jn8xDQtbf58Byg0NCq-aB3tPcf8sB6YLyLkvWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Guenter,

On 13/12/23 18:12, Peter Maydell wrote:
> On Wed, 13 Dec 2023 at 01:49, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> All tests using pxa2xx_mmc to access mmc cards on pxa2xx platforms
>> such as borzoi fail starting with commit a2e1753b80 ("memory: prevent
>> dma-reentracy issues"). Disable reentrancy guard to fix the problem.
>>
>> Fixes: a2e1753b80 ("memory: prevent dma-reentracy issues")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   hw/sd/pxa2xx_mmci.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
>> index 5e8ea69188..27ae8f2888 100644
>> --- a/hw/sd/pxa2xx_mmci.c
>> +++ b/hw/sd/pxa2xx_mmci.c
>> @@ -555,6 +555,8 @@ static void pxa2xx_mmci_instance_init(Object *obj)
>>       qdev_init_gpio_out_named(dev, &s->rx_dma, "rx-dma", 1);
>>       qdev_init_gpio_out_named(dev, &s->tx_dma, "tx-dma", 1);
>>
>> +    s->iomem.disable_reentrancy_guard = true;
>> +
> 
> All patches that set this flag should include a comment which
> explains what the device access path that triggers the reentrancy
> is, please.

Can we get a reproducer or backtrace please?

