Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0F671789C
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 09:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4GZ3-0000oE-37; Wed, 31 May 2023 03:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4GYj-0000jB-35
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:47:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4GYh-0001ij-F7
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:47:52 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30aeee7c8a0so498720f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 00:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685519270; x=1688111270;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vhp1eH68oQGsqdwowJaDRJJqZ0y6oVu12E49kh7J3pY=;
 b=GbdZPB9P4I35lBa4K4cMz7jZk8jakR3wwymwzWthhstDs+zcojrouVs5zGaThCwwPe
 k6BFlGRKQoXtQWNn2Av+W9o+wzR2lD5LcR9xPKQ2hVDg+MPXHvWa3fpjBNe8do6+0Rfj
 9n6J7CmAlMCFZ6AghZisQtm33sehls+XfaPvbg0ukDONLn9aL7Ssy/UTdO0Boerq9Urs
 L/5nywCPkv5n/w5/JbKgRQ7LVs0i/4i73ddBMJfkd1euQJ8kpM8XMaWVKD6/jsJXYiJL
 4yf1/lnlL9p2z++B+82D+JhCZyb54ONjM9lMKl1Qj16R06ugbtkY5938G5AVOmHmrPNA
 yCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685519270; x=1688111270;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhp1eH68oQGsqdwowJaDRJJqZ0y6oVu12E49kh7J3pY=;
 b=S4UtPAvpNOK/8z+1k1rgr8Ss7GKsHloW4xThHqc96NL26PE/nqTszzX+wgmFQe6jHY
 0u+ZsB+knovH+0hI49EU+pabRo+qfc2oXbRoDtjd6HeTvfSmSfPnsmHvXwc0yMmXAMdk
 urxd1c4s8/ERgmrGVfuhx1IQyN/tcHK35xJBeIbaN+KVCyD0hBnwpNdE4/VcE4XGSJJF
 mgaj2c37flE78ttspF/3aC+bOnE4a8VfHGQUtzHeq/4/ZW6rTZv7VFqAQVJQrgw7Vodz
 kF/ubpVPwRUBNW9x9nG2PVbUQWhu9tSTqYAC4FFXt6sbrqV4bFPCSesy4ZsOK2LHtagW
 gCaw==
X-Gm-Message-State: AC+VfDxgWaFs7CShIIQXt3a6/yXyzy4DCP/+z3vCupkrKZyKLXB7CVsw
 KI6iOE8fYqvNxHAJgz5U6QNjAg==
X-Google-Smtp-Source: ACHHUZ5pNezXA3+NYZdB6FeVSuKE/kW+viED3SNrdMVusD7C33U2nDQ3lCC96XWNnJvMeI2y7iJsEA==
X-Received: by 2002:a05:6000:11ce:b0:307:869c:99ce with SMTP id
 i14-20020a05600011ce00b00307869c99cemr4056530wrx.21.1685519269817; 
 Wed, 31 May 2023 00:47:49 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a5d638d000000b0030ae3a6be5bsm5766684wru.78.2023.05.31.00.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 00:47:49 -0700 (PDT)
Message-ID: <f29df320-5392-b6c0-9bb4-c5f0330fe91c@linaro.org>
Date: Wed, 31 May 2023 09:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 09/12] m25p80: Introduce an helper to retrieve the
 BlockBackend of a device
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-10-clg@kaod.org>
 <5587a39e-1c17-2997-f679-d43a023149c6@linaro.org>
 <516d4f95-a070-a03c-317c-2276cd42e871@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <516d4f95-a070-a03c-317c-2276cd42e871@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 31/5/23 08:48, Cédric Le Goater wrote:
> On 5/30/23 23:14, Philippe Mathieu-Daudé wrote:
>> On 8/5/23 09:58, Cédric Le Goater wrote:
>>> It will help in getting rid of some drive_get(IF_MTD) calls by
>>> retrieving the BlockBackend directly from the m25p80 device.
>>>
>>> Cc: Alistair Francis <alistair@alistair23.me>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>   include/hw/block/flash.h | 4 ++++
>>>   hw/block/m25p80.c        | 6 ++++++
>>>   2 files changed, 10 insertions(+)
>>>
>>> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
>>> index 7198953702..de93756cbe 100644
>>> --- a/include/hw/block/flash.h
>>> +++ b/include/hw/block/flash.h
>>> @@ -76,4 +76,8 @@ uint8_t ecc_digest(ECCState *s, uint8_t sample);
>>>   void ecc_reset(ECCState *s);
>>>   extern const VMStateDescription vmstate_ecc_state;
>>> +/* m25p80.c */
>>> +
>>> +BlockBackend *m25p80_get_blk(DeviceState *dev);
>>
>> - Option 1, declare QOM typedef and use proper type:
>>
>>    #define TYPE_M25P80 "m25p80-generic"
>>    OBJECT_DECLARE_TYPE(Flash, M25P80Class, M25P80)
>>
>>    BlockBackend *m25p80_get_blk(Flash *dev);
>>
>> - Option 2, preliminary patch renaming 'Flash' type to
>> 'M25P80' then option 1 again
> 
> That's a large change

Yes, it can be done later if you rather.

> and we would need to introduce a m25p80.h with
> these definitions.

FlashPartInfo is used as pointer so can be forward-declared.
Then we only need to move M25P80_INTERNAL_DATA_BUFFER_SZ.
For 5 lines, "hw/block/flash.h" is good enough IMO, keeping
all the rest to m25p80.c.

> Given that the caller needs a DeviceState in the
> end, may be not worth the extra hassle.
> 
> How would you rename 'Flash' ? 'SpiFlash' ?

Since you ask, my preference is SpiNorFlash :)

But again, this can be done later on top.

Thanks,

Phil.


