Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4287DCFCA
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:57:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxq9N-0006Sl-Kb; Tue, 31 Oct 2023 10:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxq9J-0006S6-LG
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:55:22 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxq9H-0004KG-1A
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:55:20 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso9036095a12.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698764116; x=1699368916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EPzPxgh4+vgatR/kHX2mvS74B1bEtBc65368Obyyd2o=;
 b=v+rzdIOtrn0KR3tK7GCHnHvwAoiXTgr4ofnNVciMv7m9wMneXd8I16fTx6fQ0JPnJE
 GbLtU06bjvaL7/PflsLH+y/NbIy8NU4xczjHTeKc0xWQgZ7uGMLv5VjvOwV7SkN4vnAJ
 9GqN6xlmx7OTRtCJNQI8M5TTPVvzyEo0E7YBS4PTJhUrag8UNhMjjt7MNBAgOuZ2Y3mn
 MbfOmjn03C/YK3d3iU1Q031U6ttp4+BbhNXwfXJkZSHKDwRB5jiTg0pHhQjnDqCEKIQ7
 Z9s9lp3ILJsYcugDaQdrVWAoRsSbbhUZ4SF4tkKOk93LPTIxlfIp6f5uTTaY+EoJCuGB
 KLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698764116; x=1699368916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EPzPxgh4+vgatR/kHX2mvS74B1bEtBc65368Obyyd2o=;
 b=Zto/+A8wMskXmtWOTtUZ0cc5w9gMgDLL+E5wKR/kc8sIMNexQ4ci7mhhfIRqr9iPR7
 K9RiyqwnVYWO2GgpCZ79+9ISv+xantR38sX1JUGsc1RVcBXQYDhlFCLkvSkVUfzy06rv
 U8gW5ZWeF8AigIpJ6Duo2vZO0+iylvIFAILOzNzSd0Nu6Jw3wj+HBoc4187VbEh+i+re
 7KoNkGB2ByEUZQv5gkIfrJyNpKiVZufEhn115XJJPVQl9bEzMIOFIbjH2uvhTSF5Hw0d
 v4eDAbr4mx6Yxf5pJfqDlo+1EW10dMB58t9PcQpKbIfRb0iDagfH53DsTY+yuKeuSaho
 rYEw==
X-Gm-Message-State: AOJu0YyhbZ2jnP4lFCKhIfW/xPu7+LwWmUR7+r2eVUs5hkvKYUcoPEzh
 71mtrrdgn3hjFHM/6jqjiVabQQ==
X-Google-Smtp-Source: AGHT+IH8LhyLOoU+UK8lFc3J+boSvk9QcR2UwwebcNaONl2usEcvmaODmOh29MVJNecKu70Jk/B1KA==
X-Received: by 2002:a50:d7dd:0:b0:543:72cd:e14c with SMTP id
 m29-20020a50d7dd000000b0054372cde14cmr1615142edj.36.1698764116289; 
 Tue, 31 Oct 2023 07:55:16 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 u9-20020aa7db89000000b005401a4184ddsm1254099edt.27.2023.10.31.07.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 07:55:15 -0700 (PDT)
Message-ID: <59d6df3c-95ee-4ac4-9ac4-3f4ed49708fa@linaro.org>
Date: Tue, 31 Oct 2023 15:55:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/6] hw/input/stellaris_input: Convert to qdev
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20231030114802.3671871-1-peter.maydell@linaro.org>
 <20231030114802.3671871-6-peter.maydell@linaro.org>
 <9ea5c9b8-d740-4cec-9896-568babeca9aa@ilande.co.uk>
 <CAFEAcA9dJnp0CVOzVWV+Q-U4ji9c8=14ggztKGktCSsDDp_F0g@mail.gmail.com>
 <CAFEAcA_4wqP7G+gXnunJx85OTvUr-3kx6HGABGb6Kt3y=b_Nvw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_4wqP7G+gXnunJx85OTvUr-3kx6HGABGb6Kt3y=b_Nvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.053,
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

On 31/10/23 15:05, Peter Maydell wrote:
> On Tue, 31 Oct 2023 at 13:55, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 30 Oct 2023 at 20:38, Mark Cave-Ayland
>> <mark.cave-ayland@ilande.co.uk> wrote:
>>>
>>> On 30/10/2023 11:48, Peter Maydell wrote:
>>> Is it worth converting this to use DEFINE_TYPES() during the conversion? I know Phil
>>> has considered some automation to remove the type_init() boilerplate for the majority
>>> of cases.
>>
>> I could, I guess. It seems a bit awkward that DEFINE_TYPES()
>> wants you to pass it an array even when you only have one type,
>> though, which is going to be a very common use case.

For single type, there is no point beside enforcing a QOM style.

I'll update docs/devel/qom.rst...

> I'm going to squash this into this patch:
> diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
> index 6ccf0e80adc..d42ba4f0582 100644
> --- a/hw/input/stellaris_gamepad.c
> +++ b/hw/input/stellaris_gamepad.c
> @@ -90,16 +90,13 @@ static void
> stellaris_gamepad_class_init(ObjectClass *klass, void *data)
>       device_class_set_props(dc, stellaris_gamepad_properties);
>   }
> 
> -static const TypeInfo stellaris_gamepad_info = {
> -    .name = TYPE_STELLARIS_GAMEPAD,
> -    .parent = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(StellarisGamepad),
> -    .class_init = stellaris_gamepad_class_init,
> +static const TypeInfo stellaris_gamepad_info[] = {
> +    {
> +        .name = TYPE_STELLARIS_GAMEPAD,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(StellarisGamepad),
> +        .class_init = stellaris_gamepad_class_init,
> +    },
>   };
> 
> -static void stellaris_gamepad_register_types(void)
> -{
> -    type_register_static(&stellaris_gamepad_info);
> -}
> -
> -type_init(stellaris_gamepad_register_types);
> +DEFINE_TYPES(stellaris_gamepad_info);
> 
> 
> The array is a bit awkward, but it's overall better than having
> to define the register-types function.

Thank you!

