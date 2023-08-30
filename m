Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC46A78D78C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNst-0005eg-CP; Wed, 30 Aug 2023 12:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbNsg-0005D5-Td
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:17:23 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbNse-0004Mq-NP
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:17:22 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c09673b006so31343135ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693412239; x=1694017039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/S9pN+pggNlxItZ/6Sz9/Co+NbI9U4om/ySGOtIMA4I=;
 b=NRNMDbEIji0c+UZmKIBtzu8NZNgTWjjerw49KPjMIIVA27/rwXOzDRcw/vPqZjESOP
 A44uXu5bR/I612hzoGPyeu/P/RAWeuYQsM4qqwMRBNz5nGKOdi4fQCpAprqoI3WGvpLl
 fyMk1Zo0J7B2P2PaHyH4MzBXvTe2iZH2RkMoLeNLEPsYbujlxtWnsLFQ/ja0Y/NT+BxZ
 z+DHvQSlQi2OFZfU04w7QcCTSmkWW5kx3LW/VK/KJNb/Vc926NJIgMDoSWKvc9P0onZI
 ntzB+WH6T63Xas7VyNEayM30BTBaWP3uJlYpZM1NX6Vk4R24Mul/SuVL9qTN23rxSuI5
 dwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693412239; x=1694017039;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/S9pN+pggNlxItZ/6Sz9/Co+NbI9U4om/ySGOtIMA4I=;
 b=Qv2CvXUzyXQljx/n8ZK29WEnUqFtMKFyIVk9jvX28DCymUAf5bEnm+8s20jZ0XeP0F
 Bze9XeAIh9sSUSep1+fNWXaaES/ST+JpAeiJSOEk+xounEAH9COiLo6qbT54hq0heoSL
 Sxo/G/RgzbG5lirIp+MiLREeT6cP3aTp8hIYn74XoJblKEW2VAdWS+6eQWOrMQgqMcUP
 Yc0q9MichMh6WH8KpUaW2YG9YJtPPieXY7WxYYQizPk+hleNHeo5cIR4e+ReSHuovHfr
 cH2RghLrIT3QsR51/Db3UmTkQFcA6ItJy4uPRReUr1ptZidUkKFScZnDEZvWYmQfwaFt
 b5zw==
X-Gm-Message-State: AOJu0YzsCuFZPKktjd0+d0kz1HQ4zsQmiBrWv5iir7HXCHkmW0haIfgg
 nQCfnnU3ykv8JDLekDWPfWzu+g==
X-Google-Smtp-Source: AGHT+IFeQ9HdKJJec/FSracIxDbSw9C4r0vwfZgZdmydHgemyBP0S1LYIg+uVXj19M0RY1j+ygLoSw==
X-Received: by 2002:a17:902:eccf:b0:1be:ff74:ec21 with SMTP id
 a15-20020a170902eccf00b001beff74ec21mr2877409plh.27.1693412238992; 
 Wed, 30 Aug 2023 09:17:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 ji18-20020a170903325200b001b9d8688956sm11312837plb.144.2023.08.30.09.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 09:17:18 -0700 (PDT)
Message-ID: <e5685d29-bb2a-f0c2-5030-453dae529c03@linaro.org>
Date: Wed, 30 Aug 2023 09:17:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 08/20] linux-user: Load vdso image if available
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-9-richard.henderson@linaro.org>
 <d703be2d-8131-58d4-2ed8-7104316a8e21@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d703be2d-8131-58d4-2ed8-7104316a8e21@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 07:22, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 30/8/23 00:02, Richard Henderson wrote:
>> The vdso image will be pre-processed into a C data array, with
>> a simple list of relocations to perform, and identifying the
>> location of signal trampolines.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/elfload.c | 87 +++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 78 insertions(+), 9 deletions(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index f34fb64c0c..2a6adebb4a 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -33,6 +33,19 @@
>>   #undef ELF_ARCH
>>   #endif
>> +#ifndef TARGET_ARCH_HAS_SIGTRAMP_PAGE
>> +#define TARGET_ARCH_HAS_SIGTRAMP_PAGE 0
> 
> I'd rather #error here so new targets are added with
> a clearly defined TARGET_ARCH_HAS_SIGTRAMP_PAGE.

The next step after adding vdso's is to remove TARGET_ARCH_HAS_SIGTRAMP_PAGE.

>> +    for (unsigned i = 0, n = vdso->reloc_count; i < n; i++) {
> 
> Do we really need 'n'?

You should always have an loop invariant condition if possible.


r~

