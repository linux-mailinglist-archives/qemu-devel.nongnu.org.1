Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 757FB7E99F5
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 11:15:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2TxO-0002AF-HR; Mon, 13 Nov 2023 05:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2TxM-0002A3-Er
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 05:14:12 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2TxJ-0000Iy-Ku
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 05:14:11 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9e2838bcb5eso623585966b.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 02:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699870446; x=1700475246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NQMoa/G4WBTT5t5h67ExWC9OkfcXaE7vrmZtbsQUzkA=;
 b=mPECkMef3MEctut3ggSkiLcoMjsJP21rR8fypolRSCsUB3fOFSTTqrRgSJHOdBjFfB
 7ewHjwhtgKKafJkTFrYjw/EhOaI7PAyE7MNC9o6vwKrgAH4gZqU/u0ly3BAIBKjlnT7h
 8I1KBzmoPm6ZdXbILts8AZI0aaF0Dq6R8we9zdsaM2UkADpG90/3qjYB8SNwCzBxIkLY
 NNCFmtspA9k6BkbkIov05WJv4FDByemZgt1F4M3nDYqpRgeWxphm8ZPc8tv1K9+o7YqI
 XUWCn9zmXSnChtOTAP1nXMzT2IX2vLv4WUuzLkq93WeLwBkoq4GnCeWBVWNET7tbNAKt
 lzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699870446; x=1700475246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NQMoa/G4WBTT5t5h67ExWC9OkfcXaE7vrmZtbsQUzkA=;
 b=UezrRxbNp4fINAg8AfzHIdpyNNggITYY5YYWK5tO0qA794t1buGjPf8BE8ux71LuGu
 1YUzv9DglnKGvh6hWvRmVgEBVKmQywcDrsd4h2dzrtVtJn9HpX1V/5ERv3G4wjYWuUWx
 pF4kWefE4S/z1vgCY+YjSPX1H7GqTZwHQgZ4zR7IkiCycFdXT3cmrvN1VTWbqOITxrAR
 2xThm+tGZmQvnmiiAt2mbWT9nthczhpEjQI3Zv5V5YfCNenTDhGrIxqSskk6PAvWNZIt
 orGcJPaesLzQRerExCXnUHbxlhgZV78DGL4V4+Kk45/8BSF3TWyaEnnfvVHShOwd4HNf
 cuyA==
X-Gm-Message-State: AOJu0Yw70bgAHNbq7hqPtg29qt9ulQHre7KggKW3ql6kBpQCJYRB4FCP
 bbBBAABEOPj1OZkzEUrvIUC3sK5KVYOyzMoLme8=
X-Google-Smtp-Source: AGHT+IEuEA3vfjKReAOIw0XDBMguRijd+GuYMsmMEJzmk51bSmQovYudcID3P/XecarAals1bibciQ==
X-Received: by 2002:a17:907:728b:b0:9dd:30c8:6f2f with SMTP id
 dt11-20020a170907728b00b009dd30c86f2fmr6277043ejc.27.1699870446387; 
 Mon, 13 Nov 2023 02:14:06 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a1709061b0900b0099bcf9c2ec6sm3775735ejg.75.2023.11.13.02.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 02:14:06 -0800 (PST)
Message-ID: <d79587a5-ae52-4832-9859-aad3e8b7182d@linaro.org>
Date: Mon, 13 Nov 2023 11:14:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/qtest: Add an API function to capture IRQ toggling
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com
References: <20231112013801.293970-1-gustavo.romero@linaro.org>
 <ddb3f1c5-28d1-472d-b491-703a3e1c6711@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ddb3f1c5-28d1-472d-b491-703a3e1c6711@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 13/11/23 07:59, Thomas Huth wrote:
> On 12/11/2023 02.38, Gustavo Romero wrote:
>> Currently the QTest API does not provide a function to allow capturing
>> when an IRQ line is toggled (raised then lowered). Functions like
>> qtest_get_irq() read the current state of the intercepted IRQ lines,
>> which is already low when the function is called, since the line is
>> toggled.
>>
>> This commit introduces a new function, qtest_get_irq_trigger_counter(),
>> which returns the number of times a given intercepted IRQ line was
>> triggered (raised), hence allowing to capture when an IRQ line was
>> toggled.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   tests/qtest/libqtest.c | 12 ++++++++++++
>>   tests/qtest/libqtest.h |  9 +++++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index f33a210861..21891b52f1 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
>> @@ -82,6 +82,7 @@ struct QTestState
>>       int expected_status;
>>       bool big_endian;
>>       bool irq_level[MAX_IRQ];
>> +    uint64_t irq_trigger_counter[MAX_IRQ];
>>       GString *rx;
>>       QTestTransportOps ops;
>>       GList *pending_events;
>> @@ -498,6 +499,7 @@ static QTestState *qtest_init_internal(const char 
>> *qemu_bin,
>>       s->rx = g_string_new("");
>>       for (i = 0; i < MAX_IRQ; i++) {
>>           s->irq_level[i] = false;
>> +        s->irq_trigger_counter[i] = 0;
>>       }
>>       /*
>> @@ -690,6 +692,7 @@ redo:
>>           if (strcmp(words[1], "raise") == 0) {
>>               s->irq_level[irq] = true;
>> +            s->irq_trigger_counter[irq]++;

This is 'irq_raised_counter',

> Not sure whether you can get some "raise" events in a row without some 
> "lower" events in between ... but just in case, I wonder whether it 
> would make sense to check whether it is really a rising edge, i.e.:
> 
>             if (strcmp(words[1], "raise") == 0) {
>                 if (!s->irq_level[irq]) {
>                     s->irq_trigger_counter[irq]++;
>                 }
>                 s->irq_level[irq] = true;
> 
> What do you think?

This is 'irq_pulsed_counter'. 'irq_lowered_counter' could also be
useful (at least for completeness).

Per Gustavo's description, he indeed wants irq_pulsed_counter (or
irq_toggled_counter'.

> 
>>           } else {
>>               s->irq_level[irq] = false;
>>           }
> 
> Anyway:
> Acked-by: Thomas Huth <thuth@redhat.com>
> 


