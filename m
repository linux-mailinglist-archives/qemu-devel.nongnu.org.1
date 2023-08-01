Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D7576BA93
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 19:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQsmh-0005Lk-HZ; Tue, 01 Aug 2023 13:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1qQsmd-0005LW-SS; Tue, 01 Aug 2023 13:03:44 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1qQsmb-0000wW-W1; Tue, 01 Aug 2023 13:03:43 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b8ad8383faso50295595ad.0; 
 Tue, 01 Aug 2023 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690909419; x=1691514219;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nwjHOD/bDcTVCu/4XOe7iUE4KjdIb5EAC6hcQ6ZVkvk=;
 b=V5LHnRGwtJbcQnzA6DzLnYVF8fw2vvyrEO60yHsuIjcPqKn3d0OWdSUMEwGGBHDESh
 GGbkVBSYvXqRGYnGq16JUML9XvEogNijPmvXw2U/ReznwTxj5r5ljdYq6mUi5m9cdEVV
 FohzrAbrk2Diq8e+ouW/VoPV/hrj5WJKNkuZNnD+VaoZj9DWXNJGcWLI3KRtZjI11+ja
 chw22SW9JRyDbZzhXtKNckZUD7w4X3pSDXLatTeskAvUEOKKAk5EYVFesl6repnyGZMM
 y2v+O1TptgkkvopQ/HPwxWtoCy+scTdLfWOZe43DyEwCpuhL8IK2WgscSt1TyfXtbDrm
 TpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690909419; x=1691514219;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nwjHOD/bDcTVCu/4XOe7iUE4KjdIb5EAC6hcQ6ZVkvk=;
 b=eAxmOhgJyt1H/eB/5sft5PIvSKNt0RaXIXSwFyriQDhZsfSTA0KkfF0HYHKsMnAbpp
 4AeK5zegKhu8Uiw4THcZ5w6miswbMZ4j9COgksAHRgMvC9d3heIsXyuOjTNo/D+eQk5I
 oaoOXqcxrQkwQggOtJYu9OzN+G8bNWd8yR273BRUCc2bgk8ZfQMxE7K7obZLtABXqvqc
 5RgLFci9HZmQkFQ12iXDP60Z+Se+bbYVa5eum9iB1W87MLS7VriYLL19sFbQP4NCrX0Z
 96ZiuXUV512aVi4tdltg0ESb0mstA6lG+8QhCHwTZ/7GtiXVRNA4eNS4UDwhlb+20qu3
 0hbQ==
X-Gm-Message-State: ABy/qLbjhRsk9jKoReqWpV+dNdv2qo80Aj1ZPihr9QYU81sJMR/Zh4c+
 O+VzPu8Vd8PACa2UEEjoIgU=
X-Google-Smtp-Source: APBJJlFO3X8TXmLbq69bLnmVWkIIbRa4ypcX41UTW+s83odQ3Znqy36hirW83jf9vwfpvVWFycyeUg==
X-Received: by 2002:a17:902:ce86:b0:1b6:797d:33fb with SMTP id
 f6-20020a170902ce8600b001b6797d33fbmr14716501plg.64.1690909418940; 
 Tue, 01 Aug 2023 10:03:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 iw12-20020a170903044c00b001bbbc655ca1sm10740957plb.219.2023.08.01.10.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 10:03:38 -0700 (PDT)
Message-ID: <33601690-df21-55ec-bc61-c720e8861aa4@roeck-us.net>
Date: Tue, 1 Aug 2023 10:03:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qianfanguijin@163.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20230523100508.32564-1-qianfanguijin@163.com>
 <20230523100508.32564-2-qianfanguijin@163.com>
 <41e71eae-72ad-410d-9cd8-cc495c06dac4@roeck-us.net>
 <CAFEAcA8aEQWAap36CtHMrEkFQUPnDCH7=-X5+TE2GJ-qzm3Y9w@mail.gmail.com>
 <2044dc69-93de-d855-fe44-ee6f3ab3576b@roeck-us.net>
 <CAFEAcA8vtJNwbxBreDMFB6q-Z=G5FiOcWzAAz+F69A4-Er_4EA@mail.gmail.com>
 <a51c71c5-4c5e-8723-76f1-2cc9410f601b@roeck-us.net>
 <01087628-44c0-2b15-61bc-8677b7d1b459@roeck-us.net>
 <CAFEAcA_mRY3bULpX0Qst--8XkDP9DYJqFbRBPgEpvEB1QnDr_A@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 01/11] hw: arm: Add bananapi M2-Ultra and allwinner-r40
 support
In-Reply-To: <CAFEAcA_mRY3bULpX0Qst--8XkDP9DYJqFbRBPgEpvEB1QnDr_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 8/1/23 09:01, Peter Maydell wrote:
> On Sat, 24 Jun 2023 at 16:02, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 6/24/23 07:23, Guenter Roeck wrote:
>>> On 6/24/23 03:40, Peter Maydell wrote:
>>>> On Fri, 23 Jun 2023 at 20:33, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>> On 6/23/23 10:44, Peter Maydell wrote:
>>>>>> On Sat, 17 Jun 2023 at 17:29, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>>> Main problem is that the SD card gets instantiated randomly to
>>>>>>> mmc0, mmc1, or mmc2, making it all but impossible to specify a
>>>>>>> root file system device. The non-instantiated cards are always
>>>>>>> reported as non-removable, including mmc0. Example:
>>>>>>>
>>>>>>> mmc0: Failed to initialize a non-removable card
>>>>>>
>>>>>> Do you mean that QEMU randomly connects the SD card to
>>>>>> a different MMC controller each time, or that Linux is
>>>>>> randomly assigning mmc0 to a different MMC controller each
>>>>>> time ?
>>>>>>
>>>>>
>>>>> Good question. Given the workaround (fix ?) I suggested is
>>>>> in the devicetree file, I would assume it is the latter. I suspect
>>>>> that Linux assigns drive names based on hardware detection order,
>>>>> and that this is not deterministic for some reason. It is odd
>>>>> because I have never experienced that with any other emulation.
>>>>
>>>> Yeah, I don't really understand why it would be non-deterministic.
>>>> But it does make it sound like the right thing is for the
>>>> device tree file to explicitly say which MMC controller is
>>>> which -- presumably you might get unlucky with the timing
>>>> on real hardware too.
>>>>
>>>
>>> Agreed, only someone with real hardware would have to confirm
>>> that this is the case.
>>>
>>
>> Actually, the reason is quite simple. In the Linux kernel:
>>
>> static struct platform_driver sunxi_mmc_driver = {
>>           .driver = {
>>                   .name   = "sunxi-mmc",
>>                   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^
>>                   .of_match_table = sunxi_mmc_of_match,
>>                   .pm = &sunxi_mmc_pm_ops,
>>           },
>>           .probe          = sunxi_mmc_probe,
>>           .remove         = sunxi_mmc_remove,
>> };
>>
>> All mmc devices instantiate at the same time, thus the
>> device name association is random. If I drop the probe_type
>> assignment, it becomes deterministic.
>>
>> On top of that, Linux does know which drives are removable
>> from the devicetree file. However, since probe order is
>> random, the assignment of the one removable drive to device
>> names is random. Sometimes mmc0 shows up as removable,
>> sometimes it is mmc1 or mmc2.
>>
>> So my conclusion is that qemu isn't doing anything wrong,
>> it is all happening in the Linux kernel.
> 
> Hi Guenter -- do you know if this "random MMC controller"
> issue has been fixed in Linux ? If so, we might be able
> to update our test case image to avoid the slightly ugly
> "root=b300" workaround at some point.
> 

No, it has not been fixed, or at least there is nothing in linux-next.
I don't have real hardware, so I am not in a position to submit, much
less test, a patch on it. Someone had mentioned that real hardware would
handle the problem in initramfs. That seems wrong to me, but it is what
it is.

I changed my own test to use the "root=b300" hack. That seems highly kludgy,
but at least it works.

Guenter


