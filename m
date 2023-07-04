Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94000747411
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:26:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgyI-0003Lu-2K; Tue, 04 Jul 2023 10:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGgyF-0003LB-AM
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:25:35 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGgyC-00060y-78
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:25:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3143ccb0f75so1418434f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688480727; x=1691072727;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GyE3CXPeXedQL5IGhlbGJ9w1KGn4iyl/4Ih2AUEQGDU=;
 b=u6Gt11xQ7odwivWClsNDIy2Tn4hnuxAuoEvKhVxJDUXqYakv1RyFBPz8fLT2d0qhT5
 AwgblWyoZtc3c8jLeJqZCxbm96PwlmjoZmbjQi9TNu3z4KnFA5HpOSL29jQiHcvTPljk
 hdW9zRYfCpN14eiaIsKYDN949y5kHWhILgAeiraU9lNq9QabUofRMZfvximdyNeKx2an
 EMegRm7Y84RDzEBUoayXuGx20yNH3R1/ilN7V0b4BQ6tj0H8hXiiaRhzumlpRW3PO9LW
 1APqMJkCBSDMiqD1Ame65EkoYSAMsK+VgQXZN2zgIzalpRu5w8WcGH23c3ok9VYdbMdK
 pVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688480727; x=1691072727;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GyE3CXPeXedQL5IGhlbGJ9w1KGn4iyl/4Ih2AUEQGDU=;
 b=epLDplQukDfwPxHmjWdb35ExKim6HzS+efa1pTQRqREytGUI4hLo4tph9VD4E+Wgc2
 mEJs6dVunUlNgnSBStj5DCX486peAw5kN+B17Lp+JV9Xa/HsYH8mB52UrKoDXsPlOToc
 SdbFYDeNTPrXoP5/ttWCgRpkkgMEXIaM0GxcJDWrnBU10VpNbwPhR9+B6ZGcoXpjUIcs
 Rjos+2ToqNjsoIDlEw2EUnh/PCLQpAnLxqoNJNn75iks5Jdoc3gfbqZcnkkt9jLUAnmv
 f7Ry51yrQDQnFi1HDk1V92WiPTEUIpddNweu85bSwuwWoaVpGWN0nKAgnoixkyThg2xn
 aJ2Q==
X-Gm-Message-State: ABy/qLYjhA/dwnHk5lkdYvobP0zr8yyWgfScCJT3VCKRT1IfqL5Us//Q
 /KP0Ch9i3NlIwgfSZfBwJ1VvkA==
X-Google-Smtp-Source: APBJJlGIyOyJyQR0chuqFyWoaTfT+9xNQQdC1UQyrsB9jhdRmlSM3b083nUv8Y6A/a/AtE4axFVVxA==
X-Received: by 2002:a5d:5942:0:b0:314:3c8f:d267 with SMTP id
 e2-20020a5d5942000000b003143c8fd267mr3884554wri.45.1688480727420; 
 Tue, 04 Jul 2023 07:25:27 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 r3-20020adfda43000000b0030ae3a6be4asm28615167wrl.72.2023.07.04.07.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 07:25:27 -0700 (PDT)
Message-ID: <36110549-9404-17c8-905e-46a81af4ea82@linaro.org>
Date: Tue, 4 Jul 2023 16:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 13/15] hw/timer/arm_timer: Fix misuse of SysBus IRQ in
 IcpPitState
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Sergey Kambalin <serg.oker@gmail.com>
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-14-philmd@linaro.org>
 <CAFEAcA8GTuV0AtHnFHbvii9bgDqYjhAJjsjq0CX3WRHrkkaFvw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8GTuV0AtHnFHbvii9bgDqYjhAJjsjq0CX3WRHrkkaFvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 8/6/23 17:09, Peter Maydell wrote:
> On Wed, 31 May 2023 at 21:37, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> SysBus IRQ are *output* IRQs. As some sort of simplification
>> to avoid to forward it, IcpPitState misuses it as ARM timer
>> input IRQ. Fix that by using a simple IRQ forwarder handler.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/timer/arm_timer.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)


>> +static void icp_pit_fwd_irq(void *opaque, int n, int level)
>> +{
>> +    IntegratorPitState *s = opaque;
>> +
>> +    qemu_set_irq(s->irq[n], level);
>> +}
>> +
>>   static void icp_pit_init(Object *obj)
>>   {
>>       static const uint32_t tmr_freq[] = {
>> @@ -402,9 +410,14 @@ static void icp_pit_init(Object *obj)
>>       IntegratorPitState *s = INTEGRATOR_PIT(obj);
>>       SysBusDevice *dev = SYS_BUS_DEVICE(obj);
>>
>> +    qdev_init_gpio_in_named(DEVICE(obj), icp_pit_fwd_irq,
>> +                            "timer-in", ARRAY_SIZE(s->timer));
>> +
>>       for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
>>           s->timer[i] = arm_timer_new(tmr_freq[i], s->irq_in[i]);
>> -        sysbus_init_irq(dev, &s->irq_in[i]);
>> +        sysbus_init_irq(dev, &s->irq[i]);
>> +        sysbus_connect_irq(dev, i,
>> +                           qdev_get_gpio_in_named(DEVICE(obj), "timer-in", i));
>>       }
> 
> This feels a bit clunky but I think it's what we have to do,
> since the various _pass_ APIs for forwarding GPIOs and
> IRQs from a container to an inner device only work with
> an entire set of IRQs.

Indeed. sysbus_pass_irq() could resolve the last unused IRQ index
and amend starting at that index, but this doesn't seem a lot of
need for a such use (so far). We might consider it if we ever merge
sysbus IRQ API into qdev.

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!

Phil.


