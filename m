Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D5E7E71BF
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 19:52:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1A7v-0007GS-Lf; Thu, 09 Nov 2023 13:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1A7t-0007Fb-LU
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:51:37 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1A7r-0005Ej-BR
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:51:37 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9d216597f64so210059266b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 10:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699555893; x=1700160693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ae7t7ezmyIDAPmpBQ9pJmgCBGpUwlFMWGMyUb3NrLGc=;
 b=TB9NSaoMwceMtG5urW3UIxpWh2AXdq/kNnCOP0Fqp4+1VzQr2mKJMzVE93d4T7onW5
 sVF1FSjuzA7wIREf+a06ai74enKgwFN0CFOcqECo6nGRJz6t+tq/RMvXmBK3dQ8ixFmx
 sPhoJ/VR31WPsGMTOGsAS6WBJHm5AWLp//9t9sX5IEtojaBfT8bjSnOoIFa3ebCYLign
 zhlxYtCJP71WRp9HYRE8FMRX+xPpJzxuhCjKfLZGODpM4R7vnJWgRgd+9rzgDTV9yQMF
 N6f+ro3h6t00Uxhe9icHQlLUtQbuiqb4DqfX0HbrOaoWZGHIt9CBSSmeaAnhzlZNTasy
 tBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699555893; x=1700160693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ae7t7ezmyIDAPmpBQ9pJmgCBGpUwlFMWGMyUb3NrLGc=;
 b=f6feupe6uJD+CFeqpGpT7ZC1LD08tzIu68rLXiR9WrfntRzxCcAfO0KlGljcKH0+AM
 ffgABrn8TShAPZd916idZSWGb1Dnz7qwduyaFHJ3P+g01k5H04o1b/kbeMG7/FOgiX0O
 OnjM1SKc6jTLts8cwjtemWpxNX8V042HKj8ew5hyH+dWrlIWQi7f7jCyHR4BgQgwxILC
 0BGO68/WzR+rwzuMLcaUAaH6COn1+H4nEtyxuGJEFc53d1c0//Ak5KigK3viGyIWqdy9
 iV0u/ItIWI+dBK3XsTLG1vB+YmHrcFIKEnRaTufMkFPkc/XGX/3i7sQ3RiPMZr9jsEfU
 jbZQ==
X-Gm-Message-State: AOJu0YyF7b8QnGPyqExJ3KvXrymKLZ6LvFazP+vWYYdQLLQZDLoF917m
 H5U8CG8wWN8GTDgtX0T3fWGwCA==
X-Google-Smtp-Source: AGHT+IE74t0exS/UsUSvy1kEB8H+a6A6M4CLbVJ/sJeFtBH35+AQlsqfnRCDtS52HDLQrhgbX2OcCQ==
X-Received: by 2002:a17:906:c4c7:b0:9e4:6500:7540 with SMTP id
 cl7-20020a170906c4c700b009e465007540mr2721112ejb.58.1699555893266; 
 Thu, 09 Nov 2023 10:51:33 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a170906139700b0099bcb44493fsm2930816ejc.147.2023.11.09.10.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 10:51:32 -0800 (PST)
Message-ID: <35e9990e-41da-4702-8163-62e2b282ffb0@linaro.org>
Date: Thu, 9 Nov 2023 19:51:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Fix potential overflow in I2C model
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.vnet.ibm.com>
References: <20231109080536.1005500-1-clg@kaod.org>
 <CAFEAcA_vs==UgZGkuW96wY=tdHXxk8cu1O7HRGKAoAj=Ltyv1A@mail.gmail.com>
 <de9177ea-c444-4710-8eda-7cecaef06eb7@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <de9177ea-c444-4710-8eda-7cecaef06eb7@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 9/11/23 16:54, Cédric Le Goater wrote:
> On 11/9/23 16:02, Peter Maydell wrote:
>> On Thu, 9 Nov 2023 at 08:06, Cédric Le Goater <clg@kaod.org> wrote:
>>>
>>> Coverity warns that "i2c_bus_busy(i2c->busses[i]) << i" might overflow
>>> because the expression is evaluated using 32-bit arithmetic and then
>>> used in a context expecting a uint64_t.
>>>
>>> Fixes: Coverity CID 1523918
>>> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>   hw/ppc/pnv_i2c.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
>>> index f75e59e70977..ab73c59f7704 100644
>>> --- a/hw/ppc/pnv_i2c.c
>>> +++ b/hw/ppc/pnv_i2c.c
>>> @@ -437,7 +437,7 @@ static uint64_t pnv_i2c_xscom_read(void *opaque, 
>>> hwaddr addr,
>>>       case I2C_PORT_BUSY_REG: /* compute busy bit for each port  */
>>>           val = 0;
>>>           for (i = 0; i < i2c->num_busses; i++) {
>>> -            val |= i2c_bus_busy(i2c->busses[i]) << i;
>>> +            val |= (uint64_t) i2c_bus_busy(i2c->busses[i]) << i;
>>>           }
>>>           break;
>>
>> Should the device's realize function also impose a max
>> limit on the num-busses property? There doesn't seem to be
>> anything preventing a caller from setting it to a big
>> number like 128, which would then be UB here.
> 
> yes. I will add an assert(i2c->num_busses < 64). The current max
> is 16 for POWER10.
> 
>> Style nit: casts shouldn't have a space after them before
>> the thing they're casting.
> 
> yep.
> 
> I prefer the cast method than the deposit call. Philippe, I hope you
> don't mind ?

Matter of taste, I don't mind ¯\_(ツ)_/¯


