Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2539B238C
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Oct 2024 04:34:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5GUh-00087U-Oj; Sun, 27 Oct 2024 23:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t5GUU-00086A-Bj; Sun, 27 Oct 2024 23:32:27 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t5GUS-00072p-FN; Sun, 27 Oct 2024 23:32:26 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20ce65c8e13so32440605ad.1; 
 Sun, 27 Oct 2024 20:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730086342; x=1730691142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=0VdFw3Xwjuzb/a0CxZjP9sJwW63CJFpauYkt8V7/Buc=;
 b=Sun/5Chc1UZDMHzAvNh1mWNuaUaBITOx/4oAabkLmpCoiWmJGCNI5/VatRTBVyFUP0
 /RpvYFRW+bsV0GpKfecyZrb4SKL5rNTMf0Vy/s4msGwpT8EuIrb0PSXA/ilglVrLKzbP
 UpMbdFlz9zeOR8O90nCzOhxI466rfJeWEEgSrbb3SJ2rMZNCLrjROOjMeKZ2vzDJbSiQ
 ZV65CJW9lw7YiwwXdCICElcsXPDS4TwOONuAT8r4jKIJUlXHba9EOmCAiukVfDph8d0n
 fNFKw6lGaEDIK0F3tolcFDosRD8As4A22lmQj8Oyah5g2Tcrk71umYbtd7a12YgFgF0k
 k+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730086342; x=1730691142;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VdFw3Xwjuzb/a0CxZjP9sJwW63CJFpauYkt8V7/Buc=;
 b=Z/YHH64bHhhDvAWXP21z+gOmWb9Bbw0M0Gq8CQxhYUoYb0K17jpmprPjEAC7ujajjA
 UJIFtYRN1kI/UjcCLtYoEuqZ+mh2Rwdmc29ZU8d9Uu3Vpjk85PY3ze3VifjKEN0mLkT/
 vGCEKNp2yHgPpF/WHgC7/N9iSSkthWCsgELXdoXm2JaccEX+GhISaXzSuus2xxNnqdnt
 gUOUTS5rNKXnBP4oo75VfJxaS7Hb9TZmYL4JCVHt6EELLbDc5lOBCFXjUC5LHwuN6ryQ
 W30KJevps66nmGKltRXSAG6iB//UL0JBf62jAd/eT7xmBjbstUwByl0CgBNOJDHHrdbe
 Tihw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGU/37VSETmCDmDr+yKnil/hKv5X3cntiU0dZPwD6nkJMmsL/nF0DxSZGP9DtFlyqpFVnE9DbXEnSTNw==@nongnu.org,
 AJvYcCWrnwuWuclurgK12ydIKEv+ZcC8wOS87/GJ6PlTVe0f047C91aqs5wBtz/mrcHCaR08Fn0YbvAJRCJR@nongnu.org
X-Gm-Message-State: AOJu0YwsdXA2l7GGYtVRTiHTmPFurrA13AMWLcOol5SJousiMSSNMJ/i
 XrIkG4wkKmRIGgQwpgiOe8vKbwK6Lk3+/nmts2gn2BSXP7Bq6p0wIS6wWQ==
X-Google-Smtp-Source: AGHT+IGq7ChaR2Lakvq1NP9xnKYMIf/eU2mPgulfP932PZB3++AlWAVrwqdg1lY5o85xHF9IzL4Uqg==
X-Received: by 2002:a17:903:2b06:b0:20c:5ba1:e8e5 with SMTP id
 d9443c01a7336-210c6c16f09mr86196195ad.19.1730086342220; 
 Sun, 27 Oct 2024 20:32:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf44536sm41851565ad.47.2024.10.27.20.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Oct 2024 20:32:21 -0700 (PDT)
Message-ID: <4246f82b-597c-4a5d-9a55-18a584e7d8c7@roeck-us.net>
Date: Sun, 27 Oct 2024 20:32:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, qemu-block <qemu-block@nongnu.org>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <ec2cb5e8-77be-435e-8aa7-4314cf412c4d@redhat.com>
 <CAFEAcA8MY8DWABNuYuzH57k-nv3J4s0eMR=FuRt1TVd8P2GU2g@mail.gmail.com>
 <a65a224e-4f54-436d-b555-734a8926d941@roeck-us.net>
 <aa7755a2-e6fa-4d23-bcac-a630e6da98db@linaro.org>
 <d9f18091-aee1-4b32-ba72-e1028fe433c9@roeck-us.net>
 <5262a33d-d0c5-452b-9869-f8f482b1c857@linaro.org>
 <07664ec3-6b46-4b27-9d8c-9e2ff34c9dbe@kaod.org>
 <600baa43c3dd3547338934717cfb57c5e12b0d23.camel@pengutronix.de>
 <84c32f2d-7d9a-4e5a-8b67-1f954dd493f6@roeck-us.net>
 <b67f302a11a679c3fdb02318eb9ef0be559d14ce.camel@pengutronix.de>
 <53cbb597-e7f2-4742-bf85-928c704ddbcf@linaro.org>
 <443f1b0c-8184-4bf4-9f68-c23d7de3bc36@roeck-us.net>
 <1bce4c22-9281-44c5-8acb-860881dc271c@kaod.org>
 <c27fbed6-596e-4ce7-a6ca-6d12d7205e99@roeck-us.net>
 <86fa6e68-5861-4d4d-941f-95b278074eb6@kaod.org>
 <1c917e4a-de50-45b9-ac9c-eb04d51401a2@roeck-us.net>
 <00997cca-6f4a-4b99-9616-2af6a25cd4fb@kaod.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <00997cca-6f4a-4b99-9616-2af6a25cd4fb@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/27/24 15:26, Cédric Le Goater wrote:
> On 10/27/24 23:11, Guenter Roeck wrote:
>> On 10/27/24 14:13, Cédric Le Goater wrote:
>>> On 10/26/24 17:32, Guenter Roeck wrote:
>>>> On 10/26/24 03:02, Cédric Le Goater wrote:
>>>> [ ... ]
>>>>
>>>>>> I don't mind a single file. What bothers me is that the partitioning is made
>>>>>> mandatory for ast2600 even if not used.
>>>>>
>>>>> Our only use case, in 2019, was to boot QEMU ast2600 machines from an
>>>>> eMMC device using an OpenBMC FW image like the ones we find on IBM
>>>>> Power10 Rainier systems. I agree we only focused on this scenario.
>>>>> Most of the support should be there for other use cases, and it's now
>>>>> a question of finding the right tunables for the user.
>>>>>
>>>>> I did a quick experiment using 2 patches,
>>>>>
>>>>> one on hw/sd/sd.c to fix c8cb19876d3e ("hw/sd/sdcard: Support boot
>>>>> area in emmc image")
>>>>>
>>>>>      @@ -826,7 +826,9 @@ static void sd_reset(DeviceState *dev)
>>>>>               sect = 0;
>>>>>           }
>>>>>           size = sect << HWBLOCK_SHIFT;
>>>>>      -    size -= sd_bootpart_offset(sd);
>>>>>      +    if (sd_is_emmc(sd)) {
>>>>>      +        size -= sd->boot_part_size * 2;
>>>>>      +    }
>>>>>           sect = sd_addr_to_wpnum(size) + 1;
>>>>>
>>>>> and another on hw/arm/aspeed.c to remove the setting of the eMMC
>>>>> device properties when it is not bootable :
>>>>>      @@ -338,7 +338,7 @@ static void sdhci_attach_drive(SDHCIStat
>>>>>                   return;
>>>>>               }
>>>>>               card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
>>>>>      -        if (emmc) {
>>>>>      +        if (emmc && boot_emmc) {
>>>>>                   qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
>>>>>                   qdev_prop_set_uint8(card, "boot-config",
>>>>>                                       boot_emmc ? 0x1 << 3 : 0x0);
>>>>> (I am not saying this is correct)
>>>>>
>>>>
>>>> Works for me, though, and it is much better than mandating the existence
>>>> of boot partitions.
>>>
>>> Yes. However, if the emmc device was user creatable, we could use :
>>>
>>>    -blockdev node-name=emmc0,driver=file,filename=mmc-ast2600-evb-noboot.raw \
>>>    -device emmc,bus=sdhci-bus.2,drive=emmc0
>>>
>>> and with boot partitions:
>>>
>>>    -M boot-emmc=true \
>>>    -blockdev node-name=emmc0,driver=file,filename=mmc-ast2600-evb.raw \
>>>    -device emmc,bus=sdhci-bus.2,drive=emmc0,boot-partition-size=1048576,boot-config=8
>>>
>>> The above would be my preferred approach if acceptable. The "sd-bus"
>>> bus identifier should be changed in other machines tough.
>>>
>>
>> No real preference here, though my understanding is that emmc devices
>> are by definition built-in, and that is what emmc_class_init() says as well.
>> Also, there does not seem to be an sdhci-bus, only sd-bus, and that does
>> not support any index values. That may be just my lack of knowledge, though.
> 
> 
> No, you are right. On a real ast2600-evb, the eMMC device is indeed
> soldered on the board. But, for testing purposes, it is sometime
> interesting to add some flexibility in the machine definition and
> in the modeling too. This avoids "hard-coding" default devices in
> the machines and lets the user define its own variant models using
> the QEMU command line.
> 

I would agree, but I had a number of my patches rejected because while
they would be useful for testing they would not accurately reflect the
hardware. So nowadays I gave up even trying to upstream such changes.

Guenter


