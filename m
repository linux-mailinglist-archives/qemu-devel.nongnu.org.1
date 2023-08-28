Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE74C78B5C7
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:01:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafb4-0000Et-7p; Mon, 28 Aug 2023 13:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qafb2-0000Db-Bh
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qafay-0002w6-Va
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693242007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOfN+WOS5rN7rWs79M3bBCXxEbNFso2E85Sacm74/9c=;
 b=DoyD1lXAPUulmNlAyKqVpJt4g/bJkYw9ba+CZoMAJxatph4hEbm/l9MTc5Iwis3MfU58Ac
 4XNmrlCI9WqhC4NTgM2Pp2DYXsqvtb3Z4GYK6l/70pWHQ7W5OmkcqXM+5Ggm2fhV81g3Y0
 LYeXQpF/nXEHOgQMbFnBY747ov4QQPA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-BlX99CIpOTS5i9Xl4gZ04g-1; Mon, 28 Aug 2023 13:00:06 -0400
X-MC-Unique: BlX99CIpOTS5i9Xl4gZ04g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe5b94bd62so24815155e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693242005; x=1693846805;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zOfN+WOS5rN7rWs79M3bBCXxEbNFso2E85Sacm74/9c=;
 b=eVFJZfeusBLFc157hwtozYRcRGu5FvFbISzV366Z9ma0kU8lqAQaAW6C+9xTK4CMT9
 J/HEpmG2a1tYd6NLU7PD4iBnjsAyvGhi24peRbmOXeQI0kA0eJDNrgRQI39jyzT4thmn
 cWuQDgssiPU8WrsKBYTEWld5QbsSS8yZRtjJpgKwtLzKv/u6oyTHF+f3hDN9kZJ5hX5w
 weMkZVTL8JBwhn5QU1RDxGJSfnebXloa13DCo+6LRjxYmk9+t20B7iqTJpwaerJjGGUF
 5eYJtiUp3dkqtZSRDG+yCGuxV58/adOQ0D+qo/EtA8nFiIdDc4O0Fp4U12EFn8Az7z53
 TrgQ==
X-Gm-Message-State: AOJu0YxhdPrYpLo0b9FcXZXHc032zEFNrdCoQp5CkhRTmrAx5Zmrg3SX
 1AyozPhCOXIYFTxv08eJLtcy9Re9rASr4CzERUpAJ4JDn8OI7qFdX4RDM9zMPPHTnvCPTK3ALHO
 zaASN0yLpzhGTpCk=
X-Received: by 2002:a5d:6103:0:b0:317:6470:3271 with SMTP id
 v3-20020a5d6103000000b0031764703271mr20001531wrt.45.1693242005174; 
 Mon, 28 Aug 2023 10:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsKEFdSF4ezhldaKGlvIQX+2r8QTwuuUegIABffXHP9BQFbwJYrfGz1FtV5SBXc2FpLqoXBw==
X-Received: by 2002:a5d:6103:0:b0:317:6470:3271 with SMTP id
 v3-20020a5d6103000000b0031764703271mr20001516wrt.45.1693242004758; 
 Mon, 28 Aug 2023 10:00:04 -0700 (PDT)
Received: from [192.168.8.103] (tmo-098-91.customers.d1-online.com.
 [80.187.98.91]) by smtp.gmail.com with ESMTPSA id
 q9-20020adfea09000000b0031c5ee51638sm11061262wrm.109.2023.08.28.10.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 10:00:04 -0700 (PDT)
Message-ID: <15ba0f6c-d9a2-a351-6df5-c0b427f3066a@redhat.com>
Date: Mon, 28 Aug 2023 19:00:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230825175123.624114-1-thuth@redhat.com>
 <20230825175123.624114-2-thuth@redhat.com>
 <94cb7c35-39f7-0108-d623-78435a5e7fee@linaro.org>
 <0b618261-b056-ff46-061c-7a0845e58ea9@redhat.com>
 <665924a0-dec5-cfe1-6d97-0021036b8723@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/3] hw/mips/jazz: Remove the big_endian variable
In-Reply-To: <665924a0-dec5-cfe1-6d97-0021036b8723@linaro.org>
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

On 28/08/2023 17.48, Philippe Mathieu-Daudé wrote:
> On 28/8/23 14:41, Thomas Huth wrote:
>> On 28/08/2023 14.19, Philippe Mathieu-Daudé wrote:
>>> Hi Thomas,
>>>
>>> On 25/8/23 19:51, Thomas Huth wrote:
>>>> There is an easier way to get a value that can be used to decide
>>>> whether the target is big endian or not: Simply use the
>>>> target_words_bigendian() function instead.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   hw/mips/jazz.c | 10 ++--------
>>>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>>
>>>
>>>> @@ -157,12 +157,6 @@ static void mips_jazz_init(MachineState *machine,
>>>>           [JAZZ_PICA61] = {33333333, 4},
>>>>       };
>>>> -#if TARGET_BIG_ENDIAN
>>>> -    big_endian = 1;
>>>> -#else
>>>> -    big_endian = 0;
>>>> -#endif
>>>> -
>>>>       if (machine->ram_size > 256 * MiB) {
>>>>           error_report("RAM size more than 256Mb is not supported");
>>>>           exit(EXIT_FAILURE);
>>>> @@ -301,7 +295,7 @@ static void mips_jazz_init(MachineState *machine,
>>>>               dev = qdev_new("dp8393x");
>>>>               qdev_set_nic_properties(dev, nd);
>>>>               qdev_prop_set_uint8(dev, "it_shift", 2);
>>>> -            qdev_prop_set_bit(dev, "big_endian", big_endian > 0);
>>>> +            qdev_prop_set_bit(dev, "big_endian", 
>>>> target_words_bigendian());
>>>
>>> IIRC last time I tried that Peter pointed me at the documentation:
>>>
>>> /**
>>>   * target_words_bigendian:
>>>   * Returns true if the (default) endianness of the target is big endian,
>>>   * false otherwise. Note that in target-specific code, you can use
>>>   * TARGET_BIG_ENDIAN directly instead. On the other hand, common
>>>   * code should normally never need to know about the endianness of the
>>>   * target, so please do *not* use this function unless you know very
>>>   * well what you are doing!
>>>   */
>>>
>>> (Commit c95ac10340 "cpu: Provide a proper prototype for
>>>   target_words_bigendian() in a header")
>>>
>>> Should we update the comment?
>>
>> What would you change? My motivation here was mainly to decrease the size 
>> of the code - I think it's way more complicated via the #if + extra 
>> variable compared to simply calling target_words_bigendian(), isn't it? I 
>> think the diffstat says it all...
> 
> Is the comment misleading then? Why not decrease the code
> size using target_words_bigendian() in all the similar cases?
> 
> $ git grep -A4 'if TARGET_BIG_ENDIAN' hw/
> 
> hw/microblaze/boot.c:145:#if TARGET_BIG_ENDIAN
> hw/microblaze/boot.c-146-        big_endian = 1;
> hw/microblaze/boot.c-147-#endif
> -- 
> hw/mips/jazz.c:160:#if TARGET_BIG_ENDIAN
> hw/mips/jazz.c-161-    big_endian = 1;
> hw/mips/jazz.c-162-#else
> hw/mips/jazz.c-163-    big_endian = 0;
> hw/mips/jazz.c-164-#endif
> -- 
> hw/mips/malta.c:378:#if TARGET_BIG_ENDIAN
> hw/mips/malta.c-379-        val = 0x00000012;
> hw/mips/malta.c-380-#else
> hw/mips/malta.c-381-        val = 0x00000010;
> hw/mips/malta.c-382-#endif
> -- 
> hw/mips/malta.c:631:#if TARGET_BIG_ENDIAN
> hw/mips/malta.c-632-#define cpu_to_gt32(x) (x)
> hw/mips/malta.c-633-#else
> hw/mips/malta.c-634-#define cpu_to_gt32(x) bswap32(x)
> hw/mips/malta.c-635-#endif

If it's just about a variable that gets initialized to 0 or 1, replacing it 
with target_words_bigendian() certainly make a lot of sense. Not sure about 
this spot in malta.c, though, this is a bit different since it declares a 
macro instead.

> So within hw/ I'd restrict target_words_bigendian() use to
> MachineClass::init() handlers, and prohibit TARGET_BIG_ENDIAN
> from hw/. Only use in softmmu/, target, *-user/. If we agree
> we can rewrite the comment, removing the "do *not* use this
> function unless you know very well what you are doing!" which
> is hard to interpret IMHO.

Ok, now I got you, I think. Yes, I agree we should update the comment to say 
that it should not be used in *devices* (unless you know what you're doing, 
e.g. in virtio code). I just also found the original discussion which was 
about the same thoughts:

  https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg00939.html

  Thomas


