Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717A7498FD
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:06:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHLsI-0001fr-8W; Thu, 06 Jul 2023 06:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHLsD-0001fa-Rh
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:06:05 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHLs9-0000ab-Vx
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:06:04 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51e34ad47eeso310770a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688637958; x=1691229958;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z+LOGXrw28q+YSxjbNiiMXh6ynA1dFpztCSQnfvIabs=;
 b=JVVZ7n43mmMJuBatMwyEX1lhu9ccDo3v+4SZQxsldKDgSFpAQIfd+dhE36zk3yy/fs
 REbUWw25TEno8STsT5BMiEbS090gD4+MrAP92XKiRdELmUKCal7KOf0TiSHekNOoKgA8
 825TASm2JRuUSrvQM4j2eJkzJnVM0mZyBnVPi8gA8WVpMCVGt4DEYtC7dTge/x2pIiG4
 5IWf7Z/Tl4CeTP7/oifu42rcsrtWxsdNs2FzJM7Wf5fFMTqmGfmywxyGPP/lGnjdOWRc
 Sy96q6t01bK4nUhWtgIKkDmCWk/7tqKV9dVSZ25UYVVZiqMYNV9dfrQ6vASydWAL55tr
 3WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688637958; x=1691229958;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+LOGXrw28q+YSxjbNiiMXh6ynA1dFpztCSQnfvIabs=;
 b=BsTgNVajK0UKhdJ6r4IpypntqCIt1SGcfx5pnyup/nDEzQwvSj0P2v2rMY6AKH9k5o
 Dc3lfGhab7MN3jFY7IZpWbFpHVKWE0Xe/ThC+gswixbU8HNFW7XjJ0AuIuc65wEHk2wi
 Dg2HIpwNV7SJmDgtwmqnTNkBnnedE7UVd1z2ue2NzeK9TSmh9wIMdtjMYypKnM00K5S5
 i682rXIGTJe5vC6hlwPMUWC+je3gngvmebeWwcsMnIkFflXk4v5ZJrQTtj/mMe71wSXZ
 WJu6O/TBcbFIYERAD4vdwcl3a5R3KdtJep6bYHJr8fRj9dIYFwL8HlTseaWaSLk9WGaV
 EPMQ==
X-Gm-Message-State: ABy/qLahY6LAFQQ3EA6piv9vDYuybN7K1IJBnwlXBD2futQ7yZVHbiJ2
 7ktLNDakt1oYaIRFfi3e2XH9UA==
X-Google-Smtp-Source: APBJJlG4Tz8s3vXXl59ZwfuCGHb92NswRx7XBspqI4WI+AbHkxMFVdfmGS+9wLO2ZycPPm6O3Z0/AA==
X-Received: by 2002:a17:906:14:b0:992:9005:5ed5 with SMTP id
 20-20020a170906001400b0099290055ed5mr914759eja.32.1688637958147; 
 Thu, 06 Jul 2023 03:05:58 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a17090608d200b009829dc0f2a0sm600161eje.111.2023.07.06.03.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 03:05:57 -0700 (PDT)
Message-ID: <21441b66-95b8-f602-a123-902b6be2119b@linaro.org>
Date: Thu, 6 Jul 2023 12:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 11/21] swim: add trace events for IWM and ISM registers
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-12-mark.cave-ayland@ilande.co.uk>
 <575796cd-6460-b9ea-bfcf-8f27fadf0920@linaro.org>
 <979bbe89-b673-1782-ccde-8fe5f364cda1@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <979bbe89-b673-1782-ccde-8fe5f364cda1@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/7/23 21:40, Mark Cave-Ayland wrote:
> On 03/07/2023 09:26, Philippe Mathieu-Daudé wrote:
> 
>> On 2/7/23 17:48, Mark Cave-Ayland wrote:
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/block/swim.c       | 14 ++++++++++++++
>>>   hw/block/trace-events |  7 +++++++
>>>   2 files changed, 21 insertions(+)


>>> @@ -312,6 +322,7 @@ static uint64_t iwmctrl_read(void *opaque, hwaddr 
>>> reg, unsigned size)
>>>       swimctrl->regs[reg >> 1] = reg & 1;
>>> +    trace_swim_iwmctrl_read((reg >> 1), size, (reg & 1));
>>>       return 0;
>>>   }
>>
>>
>>> +swim_swimctrl_read(int reg, const char *name, unsigned size, 
>>> uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
>>> +swim_swimctrl_write(int reg, const char *name, unsigned size, 
>>> uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
>>> +swim_iwmctrl_read(int reg, unsigned size, uint64_t value) "reg=%d 
>>> size=%u value=0x%"PRIx64
>>> +swim_iwmctrl_write(int reg, unsigned size, uint64_t value) "reg=%d 
>>> size=%u value=0x%"PRIx64
>>
>> For these 2 functions, 'value' is 1 bit so could be 'unsigned' ;)
> 
> Indeed. In fact I'd be inclined to make them "unsigned int" just to be 
> sure there is no confusion :)

I thought the style was to just use "unsigned" but per
docs/devel/style.rst we indeed recommend "unsigned int". TIL.

