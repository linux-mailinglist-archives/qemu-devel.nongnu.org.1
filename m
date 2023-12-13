Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F99810D1F
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 10:15:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDLJ2-0002rE-7g; Wed, 13 Dec 2023 04:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDLIz-0002qT-TZ
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 04:13:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDLIw-0005jL-HO
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 04:13:25 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c29f7b068so62598865e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 01:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702458800; x=1703063600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3vCRBepvGDIF+h/atkNkxz5l7o+29hEqO81znVRZd54=;
 b=dQSCjjpAwj4eoiF0kKWS3fOpQmgKOjFKyyd66btMp6g2SoKu2YkinRoahe19KvglfU
 zi4qxLBO9uoF+UwocEscMrS3JHoacnpGFaeW+QgIixgRHHHkFqRuFzLsmjGgLXXqRbMX
 22Mzo93TLwDsQmEWQ3yeYiTGl+CTWAdflCCnmefIwOeB1yd8aQ2UIECCIAbu2HpESrMb
 K1SedZgAPOby3wAL2vimMBlwjA+wFKzibXXY9eew2JcZ9ufU6YqS41RTOTHbzluSl5Qs
 h7u6TYC6w9O7WazTw6EyldXIFr+SuidWkdtjh5MUHKjBwT9znnKczGiwL0OdT6buydXD
 xKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702458800; x=1703063600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3vCRBepvGDIF+h/atkNkxz5l7o+29hEqO81znVRZd54=;
 b=YDkO3MAEKki0yqPjwlOiLG5D3oXk/4qHMn+wtt/wjxPLh+G3fWWxnK+VcOvDlI36tV
 0cjkPrFyOSFUlYo0GXSBgO+pinc439fs5+Wt6rQ25tgPsPF81S13XZoK2c7aJqs9RWNC
 MndzoV7/vOHqA3tfaQfh8xAX8H/M8IrYcowqMIY5RdCt/KOLoJJbZ984LjmY4Phe6LHI
 lCqSAQkIOVg238WdyPcyQ3EOlryLPE6bLuVgFpnrR7PxVMoQPauiGaci9nImulYUhBpp
 qnvoScGrHG0G3cGxKYUj4DVDQJryunzFEHSGOYY77UaQ4X8Dp+SkmyrJyn75EOW8DwNt
 vjhQ==
X-Gm-Message-State: AOJu0YzIueeA3NcMoJMU9ANq2C8FdlWpaFBh28L77Oiuytn4o2t7GINb
 LtfvRqBGZ/ZMyM8/v2I1w6fm8g==
X-Google-Smtp-Source: AGHT+IE9xay8x/YNBjFbm+6BzCl5z3RD+Pky9tTfGzbEVRlsBLYbIRZLUEOA+vH420pZ2xd+I5XBfw==
X-Received: by 2002:a1c:7919:0:b0:40c:311d:c677 with SMTP id
 l25-20020a1c7919000000b0040c311dc677mr4091566wme.165.1702458800305; 
 Wed, 13 Dec 2023 01:13:20 -0800 (PST)
Received: from [192.168.50.175] (109.red-88-28-22.dynamicip.rima-tde.net.
 [88.28.22.109]) by smtp.gmail.com with ESMTPSA id
 jb4-20020a05600c54e400b0040c5cf930e6sm1139226wmb.19.2023.12.13.01.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 01:13:19 -0800 (PST)
Message-ID: <ffc9c69b-f66b-4520-81a3-a2f125a7b7ea@linaro.org>
Date: Wed, 13 Dec 2023 10:13:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 v4 04/10] hw/char/pl011: Extract
 pl011_write_txdata() from pl011_write()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org
References: <20231109192814.95977-1-philmd@linaro.org>
 <20231109192814.95977-5-philmd@linaro.org>
 <e499f176-d882-4727-8caf-268d72e06606@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e499f176-d882-4727-8caf-268d72e06606@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/11/23 00:17, Richard Henderson wrote:
> On 11/9/23 11:28, Philippe Mathieu-Daudé wrote:
>> When implementing FIFO, this code will become more complex.
>> Start by factoring it out to a new pl011_write_txdata() function.
>> No functional change intended.
> 
> ...
>> @@ -262,19 +273,13 @@ static void pl011_write(void *opaque, hwaddr 
>> offset,
>>                           uint64_t value, unsigned size)
>>   {
>>       PL011State *s = (PL011State *)opaque;
>> -    unsigned char ch;
>>       trace_pl011_write(offset, value, pl011_regname(offset));
>>       switch (offset >> 2) {
>>       case 0: /* UARTDR */
>> -        /* ??? Check if transmitter is enabled.  */
>> -        ch = value;
>> -        /* XXX this blocks entire thread. Rewrite to use
>> -         * qemu_chr_fe_write and background I/O callbacks */
>> -        qemu_chr_fe_write_all(&s->chr, &ch, 1);
>> -        s->int_level |= INT_TX;
>> -        pl011_update(s);
>> +        s->readbuff = value;
> 
> Why the write to readbuff?

I think I wanted to use it when FIFO is disabled due to:

https://developer.arm.com/documentation/ddi0183/g/programmers-model/register-descriptions/line-control-register--uartlcr-h?lang=en

UARTLCR_H.FEN:

   Enable FIFOs:

   0 = FIFOs are disabled (character mode) that is, the FIFOs become
       1-byte-deep holding registers

   1 = transmit and receive FIFO buffers are enabled (FIFO mode).

and we don't have a fifo8_change_capacity() method.

Otherwise, not sure what for is this field... I'll see if we can
just remove it.


