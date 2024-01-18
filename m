Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF89831DF2
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 17:57:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQVgu-0006MM-EB; Thu, 18 Jan 2024 11:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQVgr-0006Lr-TQ
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:56:30 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQVgq-0002Kd-B7
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:56:29 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e958cd226so5574955e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 08:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705596986; x=1706201786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JRiAuIR7NslMCDA6HVVrOEfiS5lwAHj4frCfOgvKbvA=;
 b=Xr5oKpz6j5z++Glzi91TIYqtHYWKfZRXqZAMogpU/ygju09LVuIB0r+YIC1qE8l9J3
 KJ37I6A/X4b1BKEmy1jEE0xXGuTHxrXsYK9SK2m9VTSV2kNLYVo9Fw6IaWzHNmq2+8zA
 SyDBEKoNdE/t8zvQDOM/3k0VsWjDNvRmBtCuDLuD+fOnCKkE6v9loWCgaCW5an+9mG3n
 0KBoC8CaJssLtWBYPxjgYcAMHvkDzXHYHznmszku9LvlN3QvjVndwoz1g/JE4eDjVAkw
 79+nJNcqyKQrEoaue7dEjvHB6nrIIlEmrJUntPteL/9uz8ehOeCC0DPJPpP7jt2Wl8xe
 9BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705596986; x=1706201786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JRiAuIR7NslMCDA6HVVrOEfiS5lwAHj4frCfOgvKbvA=;
 b=TUUzvNge1x9W5IVYk+Vnu/LVX6O8AhE91m7NaSyGq6NcXM6HBk98AlQMVTDWcvf2nI
 nFyEXd1gm7TUcUWQCenfBt77vkcMZoszfJuKbag+WRNC8PJq/mBt2VTHJhFoFSuoT+Un
 xY+VhpkFLMj572LztFnX/shn8SX6v6lAV52MIyJT4tP/7SDOxoVHjG40u7hNwvKa7Qs/
 RcjU9hDa6YawLRTLxg+/mTzFBK8dEz0llaAZPliEJCXSf2EmlaZa6Z7M/XQGU8kfu7KH
 FhJzA3kowr5Plej0sZxB197VDtrAt+dZBZOFDaFD+US1bysCUifaIOrFhx2ukBxOOf88
 pyHw==
X-Gm-Message-State: AOJu0YwvG7j3Uc7HIlYp1pWFJYsTJcArzt4urnp0vAiEKCuYDJ4Zg2B6
 zaw0JorCaIIaW7XmRqgzS4Fy1sFRuMu4dQvBVAdMdu3UWk1dmNvSmKEgwuCnQSo=
X-Google-Smtp-Source: AGHT+IGkGlsZM2o/2MILFi8ImEAVlInhnyIhIF3IsWfY8Ba4QR2uERQ1JybXztSkMPuNFLEIvbCkOw==
X-Received: by 2002:a05:600c:46cf:b0:40e:5118:5046 with SMTP id
 q15-20020a05600c46cf00b0040e51185046mr703538wmo.21.1705596986462; 
 Thu, 18 Jan 2024 08:56:26 -0800 (PST)
Received: from [192.168.76.175] ([92.88.170.175])
 by smtp.gmail.com with ESMTPSA id
 l34-20020a05600c1d2200b0040e89ade84bsm5893971wms.4.2024.01.18.08.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 08:56:25 -0800 (PST)
Message-ID: <f134d01c-603a-4edf-ad47-f6f2d5a7bc57@linaro.org>
Date: Thu, 18 Jan 2024 17:56:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt.c: Remove newline from error_report() string
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240118131649.2726375-1-peter.maydell@linaro.org>
 <1f34e941-5b0a-4091-95f9-0d0c8e302aa9@linaro.org>
 <5531b75e-86ef-4543-b62a-1457666d9585@linaro.org>
 <CAFEAcA8hfdZAkCodJZHxuOF2YAnKp=XR2_SeezJkcyaCAHOMaw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8hfdZAkCodJZHxuOF2YAnKp=XR2_SeezJkcyaCAHOMaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 18/1/24 17:09, Peter Maydell wrote:
> On Thu, 18 Jan 2024 at 15:30, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 18/1/24 16:17, Philippe Mathieu-Daudé wrote:
>>> On 18/1/24 14:16, Peter Maydell wrote:
>>>> error_report() strings should not include trailing newlines; remove
>>>> the newline from the error we print when devices won't fit into the
>>>> address space of the CPU.
>>>>
>>>> This commit also fixes the accidental hardcoded tabs that were in
>>>> this line, since we have to touch the line anyway.
>>>>
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>>    hw/arm/virt.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> BTW there is another case:
>>
>> $ spatch \
>>     --macro-file scripts/cocci-macro-file.h \
>>     --sp-file scripts/coccinelle/err-bad-newline.cocci \
>>     --keep-comments --use-gitgrep --dir .
>> ./hw/arm/virt.c:1775:38:"Addressing limited to %d bits, but memory
>> exceeds it by %llu bytes\n"
>> ./ui/gtk.c:1094:56:"gtk: unexpected touch event type\n"
>>
>> We could run this some of these coccinelle scripts on CI,
>> as a new job in .gitlab-ci.d/static_checks.yml or extending
>> the check-patch job...
> 
> checkpatch catches it, if you read the output, which is
> how I noticed this in the first place (I was originally
> touching the line to fix the tab damage).

Ah, no need to waste more CI minutes then :)

Thanks!

