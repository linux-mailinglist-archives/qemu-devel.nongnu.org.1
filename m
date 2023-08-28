Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1148C78B0CC
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 14:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qabZI-0002WQ-FD; Mon, 28 Aug 2023 08:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qabZE-0002WD-5u
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qabZB-0002LZ-Td
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693226520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pxRePpGQ1ARlX4BqxUlrQGpJseW19BniOJuIvH+eqXo=;
 b=Nx9mvzyyXum17j1LrS1MI0ZfsAaPUbJN9W6obLr3Jlr7+kMYlCmF9mlqjd7ktJI4BXlv22
 ccXfUSc1z9ko/k8Y7B+hfOsxZljSNFPh/k22L90gYbTHUXS55pRp55eVq2WrbyMsu1ABts
 1K0Qpr/ar/zcKNExg0r2pWLLMZC0t0c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-sN1zioPiOOK4coAZQfXWBA-1; Mon, 28 Aug 2023 08:41:58 -0400
X-MC-Unique: sN1zioPiOOK4coAZQfXWBA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31c7bfba03dso2160777f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 05:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693226517; x=1693831317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pxRePpGQ1ARlX4BqxUlrQGpJseW19BniOJuIvH+eqXo=;
 b=BLI3rXwa74p0OKADVi8rQbsgROG1omMGD4WCyARFgJ6UARzS3zLQgitprokseytv5h
 ER5jOvTc4qJpNZu6kAGqlpU7kWvDGz0naYDLn9Qsnl45D8ODhKIjb6k+QwIE8Eb812Qu
 41ZpzCQ88Aol857Oj0I6Q+lXi1NE0sR8Ae1vK2jS5l7edBOTv0+XAVVkSUsa2nMpTck2
 0YYmEkU2iyFOLPLfxn571vOTLv+ji3lzW+YGJwB7sKvxPy/hcBs0W/zEk53JOM3ZHcGR
 1eNzDXD3f1bMXxHo4KGK9YK80AYwM69F4BYkIUw6AfVdnK67aIFKGefbJaAPTPFMjYy9
 3grQ==
X-Gm-Message-State: AOJu0YzKjBrjLsm1lYfY283h615FhdmY2taOZmITT+EtoplKL6pOP1VR
 gawp9WCkViOcJy+EEAb8ITqQEPaam/pw8HqtUEBE4XOOe9kXK4X9VxrfY8OIny4pDai9GaN+ai1
 kHFeKqJ0TtKdmDSQ=
X-Received: by 2002:adf:fc4a:0:b0:319:7656:3863 with SMTP id
 e10-20020adffc4a000000b0031976563863mr20160834wrs.47.1693226517440; 
 Mon, 28 Aug 2023 05:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5n+cGvazPIhniE9qxS0jyL8I9Id6mWs5llt1k6HAs+9cLBE6+Iqt4cApiSe1oNQvGK7mtkQ==
X-Received: by 2002:adf:fc4a:0:b0:319:7656:3863 with SMTP id
 e10-20020adffc4a000000b0031976563863mr20160822wrs.47.1693226517101; 
 Mon, 28 Aug 2023 05:41:57 -0700 (PDT)
Received: from [192.168.8.103] (tmo-098-91.customers.d1-online.com.
 [80.187.98.91]) by smtp.gmail.com with ESMTPSA id
 m5-20020adffe45000000b00319756d5b80sm10492402wrs.29.2023.08.28.05.41.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 05:41:56 -0700 (PDT)
Message-ID: <0b618261-b056-ff46-061c-7a0845e58ea9@redhat.com>
Date: Mon, 28 Aug 2023 14:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] hw/mips/jazz: Remove the big_endian variable
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230825175123.624114-1-thuth@redhat.com>
 <20230825175123.624114-2-thuth@redhat.com>
 <94cb7c35-39f7-0108-d623-78435a5e7fee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <94cb7c35-39f7-0108-d623-78435a5e7fee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.169, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 28/08/2023 14.19, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 25/8/23 19:51, Thomas Huth wrote:
>> There is an easier way to get a value that can be used to decide
>> whether the target is big endian or not: Simply use the
>> target_words_bigendian() function instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/mips/jazz.c | 10 ++--------
>>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> 
>> @@ -157,12 +157,6 @@ static void mips_jazz_init(MachineState *machine,
>>           [JAZZ_PICA61] = {33333333, 4},
>>       };
>> -#if TARGET_BIG_ENDIAN
>> -    big_endian = 1;
>> -#else
>> -    big_endian = 0;
>> -#endif
>> -
>>       if (machine->ram_size > 256 * MiB) {
>>           error_report("RAM size more than 256Mb is not supported");
>>           exit(EXIT_FAILURE);
>> @@ -301,7 +295,7 @@ static void mips_jazz_init(MachineState *machine,
>>               dev = qdev_new("dp8393x");
>>               qdev_set_nic_properties(dev, nd);
>>               qdev_prop_set_uint8(dev, "it_shift", 2);
>> -            qdev_prop_set_bit(dev, "big_endian", big_endian > 0);
>> +            qdev_prop_set_bit(dev, "big_endian", target_words_bigendian());
> 
> IIRC last time I tried that Peter pointed me at the documentation:
> 
> /**
>   * target_words_bigendian:
>   * Returns true if the (default) endianness of the target is big endian,
>   * false otherwise. Note that in target-specific code, you can use
>   * TARGET_BIG_ENDIAN directly instead. On the other hand, common
>   * code should normally never need to know about the endianness of the
>   * target, so please do *not* use this function unless you know very
>   * well what you are doing!
>   */
> 
> (Commit c95ac10340 "cpu: Provide a proper prototype for
>   target_words_bigendian() in a header")
> 
> Should we update the comment?

What would you change? My motivation here was mainly to decrease the size of 
the code - I think it's way more complicated via the #if + extra variable 
compared to simply calling target_words_bigendian(), isn't it? I think the 
diffstat says it all...

  Thomas



