Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA34744571
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 02:08:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFO8c-0000MC-2y; Fri, 30 Jun 2023 20:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFO8Z-0000Ls-2M
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 20:06:51 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFO8W-0000Da-BE
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 20:06:50 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b6a6f224a1so40483391fa.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688170006; x=1690762006;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IOg1J/H8X1Wpm7EzrWRDtG3RrM6cVwaF6EfVkJyLO+g=;
 b=W0VXiUGzvkH3H6yIHqE2VszUFhtJ/cml7o3mQCucISVcjsN5dSveHFid7mlGHEvP8r
 QOcZTYGNah3tD15YZSu0Jfg4WUUAjjpE663NOkKxU5Nwws7TGEMTsUsZzjK+YA5If8Zl
 Om0qchYqDPEQMBnuuQ4k5w841kuIk4bQf60M/CC2RCUS9w1J4tT+FbJ+26HcDDHSnRdb
 QJu6dNtmVsPejTTBCDe1xAHbIHy44MLsfZM3QDuE9veUvqKJrtTBVIPtYfG835OOQ3vz
 qFmYIzGUf7iWs0RXHjjLNIrTIvzGvNW4Y4LXY1kIhsWq2iMnUl8+Untjz4Nih6UKkmwH
 T1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688170006; x=1690762006;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IOg1J/H8X1Wpm7EzrWRDtG3RrM6cVwaF6EfVkJyLO+g=;
 b=CHqwbO3Ic7gs77h3gNH64ALHISHTAJg/cPIkJzvOpN4nos6NjimYxEWBBVisMGZYCE
 3pS4DM99KRBRI+xMh9AiGXGnYOsUQ3HPcSuRdYIzPDyKhKlMzQAIgBNXp4jfUNobIr7v
 EUggzFNOikW/WBBTU6eA9iDl1EhVlP2ydkwxGQKv6MUlrQ4wFMAdl5LepsFuRsvyNV8+
 4RFvpUl7bE7f08slBbxEmm0gxnO4qEBu9BVXfZn/iC1FbpwSTnw2JjTfdJeeX5c1zjVc
 HM9QTY2t3AHbzME7oZ0Lyim+PosCxBIX5PSI2tr8duyPGlAGaUaC+uObf0YnyVbJUVYQ
 9WXA==
X-Gm-Message-State: ABy/qLb02H/k4ShkVgDdqRbW8jmukd2DahO3QESC7ZArQkfqluZkcTYw
 6aeHiOT34mA2sOXaxAhZW8eLwA==
X-Google-Smtp-Source: APBJJlHujPT1aYYI4HN3XqovF5c1wj5b/xJ9AC4KCi3JSlJXuZU9qyy01ZVWQa3Pql3J6j3MdF7RVw==
X-Received: by 2002:a05:6512:1112:b0:4f8:7503:2041 with SMTP id
 l18-20020a056512111200b004f875032041mr3820524lfg.37.1688170006187; 
 Fri, 30 Jun 2023 17:06:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.211.104])
 by smtp.gmail.com with ESMTPSA id
 f6-20020aa7d846000000b0051df5eefa20sm799045eds.76.2023.06.30.17.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 17:06:45 -0700 (PDT)
Message-ID: <953f3b4b-fe51-ca57-9aad-b08b1af09170@linaro.org>
Date: Sat, 1 Jul 2023 02:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive2: Allow indirect TIMA accesses of all sizes
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, clg@kaod.org,
 danielhb413@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com
References: <20230626094057.1192473-1-fbarrat@linux.ibm.com>
 <b7a68894-c992-3845-754c-1fdf655ad3fe@linaro.org>
 <e808c49d-2ea0-6773-a524-1b5939fec90a@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e808c49d-2ea0-6773-a524-1b5939fec90a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

Hi Frederic,

On 26/6/23 13:25, Frederic Barrat wrote:
> On 26/06/2023 11:48, Philippe Mathieu-Daudé wrote:
>> On 26/6/23 11:40, Frederic Barrat wrote:
>>> Booting linux on the powernv10 machine logs a few errors like:
>>>
>>> Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', 
>>> reason: invalid size (min:8 max:8)
>>> Invalid write at addr 0x38, size 1, region 'xive-ic-tm-indirect', 
>>> reason: invalid size (min:8 max:8)
>>> Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', 
>>> reason: invalid size (min:8 max:8)
>>>
>>> Those errors happen when linux is resetting XIVE. We're trying to
>>> read/write the enablement bit for the hardware context and qemu
>>> doesn't allow indirect TIMA accesses of less than 8 bytes. Direct TIMA
>>> access can go through though, as well as indirect TIMA accesses on P9.
>>> So even though there are some restrictions regarding the address/size
>>> combinations for TIMA access, the example above is perfectly valid.
>>>
>>> This patch lets indirect TIMA accesses of all sizes go through. The
>>> special operations will be intercepted and the default "raw" handlers
>>> will pick up all other requests and complain about invalid sizes as
>>> appropriate.
>>>
>>> Tested-by: Nicholas Piggin <npiggin@gmail.com>
>>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>>> ---
>>>   hw/intc/pnv_xive2.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>>> index ed438a20ed..e8ab176de6 100644
>>> --- a/hw/intc/pnv_xive2.c
>>> +++ b/hw/intc/pnv_xive2.c
>>> @@ -1644,11 +1644,11 @@ static const MemoryRegionOps 
>>> pnv_xive2_ic_tm_indirect_ops = {
>>>       .write = pnv_xive2_ic_tm_indirect_write,
>>>       .endianness = DEVICE_BIG_ENDIAN,
>>>       .valid = {
>>> -        .min_access_size = 8,
>>> +        .min_access_size = 1,
>>
>> Maybe. Is there a bus involved in between?
>>
>> What about other I/O regions?
> 
> 
> XIVE is attached to the main system bus and the CPU can trigger 1, 2, 4 
> and 8-byte accesses. The TIMA is a part of XIVE which supports various 
> size of mmio operations, all the way down to byte operations. It 
> actually relies on it.
> 
> There are 2 memory regions where we want to allow byte-access. One, 
> known as TIMA direct access, already allows access with min size = 1. 
> I'm just aligning the other one, known as TIMA indirect access, to do 
> the same, since it's what the hardware allows.
> This is similar to what we had on P9 and both regions are already 
> defined with min size = 1 there. So it really looks like what I'm 
> changing here was just an oversight.

OK.

> 
>>>           .max_access_size = 8,
>>>       },
>>>       .impl = {
>>> -        .min_access_size = 8,
>>> +        .min_access_size = 1,
>>
>> Unlikely. This is for the handler implementation, not related to HW.
> 
> 
> The handlers for the TIMA regions are aware of the size of the access, 
> and behave differently based on it (see xive_tm_find_op() for example). 
> So I think this is correct. Let me know if I'm missing something here.

I guess I got confused by the "Only 4 or 8 bytes loads are allowed"
comment in xive_tm_raw_read/write(), so I was somehow expecting
min_access_size = 4. I don't object to this patch however.

Thanks,

Phil.


