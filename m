Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A557F61B6
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 15:40:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6As0-00035d-Fk; Thu, 23 Nov 2023 09:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6ArD-0002Bm-EZ
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:39:12 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6ArA-0002VT-TR
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:39:07 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40b2c8e91afso6363985e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 06:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700750343; x=1701355143; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cmHvYWoHNVTNiG5lZQEsrA19BOa1FEV3emspJjRGEo4=;
 b=uH9DpChN6Th7rEOB6feqqan9BKrrZtcI6qLo5Mrnu7O8k/H+xAVqasGNgfQe8oXKj9
 9g3tLoTVe6F7RmQa8hL1N4CLCheSon9Ltmb54C2+LUaoo9uBnalau0l2PoDhdB8lJSFL
 /SUYjUXMZcFRjeANs+8R0xFTXM6noihsurvfEmWw6Oq9mc7dP7bSAJCAntO0+hpE8NGo
 QGyKG0hGYZqLlSRqKDcq2R3D2qYFCqSOkZA2MG2jgKR5E5STDRrO9K7mwx32EVW6M2XB
 Q2dcKPXE9YvrSLtlnIMYV9dZxoq4Qzs/ch13wM6ACsD3z466DxWZ5IUcpdMx3MpNzZuR
 MhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700750343; x=1701355143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cmHvYWoHNVTNiG5lZQEsrA19BOa1FEV3emspJjRGEo4=;
 b=IE3HlblJUvsnF6H5LgSdyZXorhcmW2Vk0YePDsryXVuxRp7H0rxxGXJpyFi8qZSDhX
 mDgEtNiuI9e0TRVHcCanD2OHHaixQkazQXepXp2ViRcEZWHLb6ISAopk8B+QahhDlCag
 fkWzjeJMAPX8UfonghRbwvBmsnXKtBS1iWhgf/xR24nNGPu/W2TKY0zBcHeMipVhNi4r
 0rjhvtxkNraT4Ph9Olbl7xcwk6VfNrXyiKsgdOi9zAflIZX+7ouKivLl1Jl7ei6KK8kS
 UbOgOG1j1DbjzpwFFHC5QQH12e59RkA0i2K/EvQP0TuSrI+1s3ffb1MgQ6+L71q8wVpn
 1Jhw==
X-Gm-Message-State: AOJu0Yw3/xui9zC75su9sdSVayYB2q0qOZiXSWtjw8Es0uyraoTPQ7xl
 rQOYpZmgMmTTtNEm/x+v/Q+Du0XFyGo7tcnGCQA=
X-Google-Smtp-Source: AGHT+IG4dfJdLoso/xTHMtPDnJqvzR16cumlRyQ4BgL/35m+34EE4ThlY3vC2XZfaTjCqZHhi5mEnw==
X-Received: by 2002:a05:600c:4e89:b0:405:e492:8aef with SMTP id
 f9-20020a05600c4e8900b00405e4928aefmr3614942wmq.40.1700750343031; 
 Thu, 23 Nov 2023 06:39:03 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c220f00b003fe1fe56202sm2152160wml.33.2023.11.23.06.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 06:39:02 -0800 (PST)
Message-ID: <a9aa746c-c99c-4a76-9182-c1ebeb9e3906@linaro.org>
Date: Thu, 23 Nov 2023 15:39:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0] hw/mips/cps: Simplify access to
 'start-powered-off' property
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231122183633.17676-1-philmd@linaro.org>
 <87o7fl7yg0.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87o7fl7yg0.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 23/11/23 07:53, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Since commit c1b701587e ("target/arm: Move start-powered-off
>> property to generic CPUState"), all target CPUs have the
>> 'start-powered-off' property.
>>
>> This object_property_set_bool() call can not fail. Use &error_abort
>> to simplify.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/mips/cps.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
>> index b6612c1762..4f12e23ab5 100644
>> --- a/hw/mips/cps.c
>> +++ b/hw/mips/cps.c
>> @@ -78,10 +78,9 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
>>           CPUMIPSState *env = &cpu->env;
>>   
>>           /* All VPs are halted on reset. Leave powering up to CPC. */
>> -        if (!object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
>> -                                      errp)) {
>> -            return;
>> -        }
>> +        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
>> +                                 &error_abort);
>> +
>>           /* All cores use the same clock tree */
>>           qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
> 
> There are more:
> 
>      $ git-grep -A 1 'object_prop.*start-powered-off'
>      hw/arm/armsse.c:1025:            if (!object_property_set_bool(cpuobj, "start-powered-off", true,
>      hw/arm/armsse.c-1026-                                          errp)) {
>      --
>      hw/arm/armv7m.c:321:    if (object_property_find(OBJECT(s->cpu), "start-powered-off")) {
>      hw/arm/armv7m.c:322:        if (!object_property_set_bool(OBJECT(s->cpu), "start-powered-off",
>      hw/arm/armv7m.c-323-                                      s->start_powered_off, errp)) {
>      --
>      hw/arm/boot.c:1290:                object_property_set_bool(cpuobj, "start-powered-off", true,
>      hw/arm/boot.c-1291-                                         &error_abort);
>      --
>      hw/arm/fsl-imx6.c:131:            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powered-off",
>      hw/arm/fsl-imx6.c-132-                                     true, &error_abort);
>      --
>      hw/arm/fsl-imx7.c:195:            object_property_set_bool(o, "start-powered-off", true,
>      hw/arm/fsl-imx7.c-196-                                     &error_abort);
>      --
>      hw/arm/xlnx-versal.c:51:            object_property_set_bool(obj, "start-powered-off", true,
>      hw/arm/xlnx-versal.c-52-                                     &error_abort);
>      --
>      hw/arm/xlnx-versal.c:153:        object_property_set_bool(obj, "start-powered-off", true,
>      hw/arm/xlnx-versal.c-154-                                 &error_abort);
>      --
>      hw/mips/cps.c:81:        if (!object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
>      hw/mips/cps.c-82-                                      errp)) {
>      --
>      hw/ppc/e500.c:957:        object_property_set_bool(OBJECT(cs), "start-powered-off", i != 0,
>      hw/ppc/e500.c-958-                                 &error_fatal);
>      --
>      hw/sparc/sun4m.c:806:    object_property_set_bool(OBJECT(cpu), "start-powered-off", id != 0,
>      hw/sparc/sun4m.c-807-                             &error_fatal);
> 
> We also set the property with qdev_prop_set_bit() in places, which is a
> trivial wrapper around object_property_set_bool() that passes
> &error_abort.  Either is fine, I think.

Addressed on
https://lore.kernel.org/qemu-devel/20231123143813.42632-1-philmd@linaro.org


