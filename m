Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F4E74248A
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:57:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpJv-0000PH-F9; Thu, 29 Jun 2023 06:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEpJt-0000Or-V0
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:56:14 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEpJs-0007wL-Cm
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:56:13 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-307d20548adso561651f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 03:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688036171; x=1690628171;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QT2BFc8i927d1TsYWok/iWivYKndiSBD9tPu5+cIlcc=;
 b=L7o7SeyYGyj366o8ocS1ihk5d3PlfOkAGTvK8vTnVt9zfJ1q0jCozJjBqRVg6pd+Zk
 eGVjQWO+onqnzZ+QpD5iFTqyWvBEUUi3+U330w+VPrYChiKeqSwvDO7KmIx8ux9giYzb
 loaeKmfMgh6HQuojk+gevyFOt2HX6hExMl0w2JWAFDL0LBWAgbpCGga319mrc2lZGORC
 vUqXJR/ZuxZGR/zk0SgevfOJjUbfbwXL1jJFnuwx2dj2bV/Z2ryeJtl4lDu1GfM+vDij
 mbrXi/ShjA7t7bZnTRJ2PEzblFlKLBUQEzL869nvDiJ4L6rJdGKkDbeDcfuNKwrRs8k1
 Vr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688036171; x=1690628171;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QT2BFc8i927d1TsYWok/iWivYKndiSBD9tPu5+cIlcc=;
 b=jknQVm7QS0VxWaS/djB03kHPP+uF+ZZL1hGq7AEBj+tRflZZkTlNhe5Vuc/wpl5r+T
 9P61csSJuoy6yhPPShBbgwH7jAh/8o1dn7Eo6PD/H8XsrN0TEwU1uuPXN3eR6uF5yzrr
 OhzrOpZIEbekctDGYh9td2FzggCsvpuINAb5MuHFvVB2JVPSX088TtJs0rhfqvO3xxF8
 CDs1iWzdmknWUDdM5c5WDIj1pu+sZ8GEJ5WGzvoNq0m7OM9/mOQyVdaMZSuWP2h8Rlbw
 xI2nHpTvHDSGlejGycSFMjqCqXf40l3Y7cCFapxC5G3DNqTAmGlnZTcK8vARPMM1IEQi
 /hOw==
X-Gm-Message-State: AC+VfDzGdv2HX2MbZj3msVPO3ztYaAbptKipiag7gB7RMXyh898mygE9
 PaerMtLcbW0CFdA6Z/RSRBQs/A==
X-Google-Smtp-Source: ACHHUZ5SOeqkuZaAZA4R6WFo4BVZIDcHra4jNr1e5VvQmsq4tSQQ+Up7FIqE8ak6aNGsVMCILEe+Xw==
X-Received: by 2002:adf:ef02:0:b0:314:77a:c2b2 with SMTP id
 e2-20020adfef02000000b00314077ac2b2mr5019865wro.32.1688036170643; 
 Thu, 29 Jun 2023 03:56:10 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 r15-20020adfe68f000000b003111025ec67sm15549405wrm.25.2023.06.29.03.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 03:56:10 -0700 (PDT)
Message-ID: <744350d6-f9f3-e8a3-51cd-5f998ee1b366@linaro.org>
Date: Thu, 29 Jun 2023 12:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 04/12] hw/ssi: Add an "addr" property to SSIPeripheral
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-5-clg@kaod.org>
 <CACPK8XencE5MMgYdQ5H6iV_rTHaynv-UJYHZy=y-DaCXYBWWXg@mail.gmail.com>
 <62e69c35-4869-8cc3-5983-9f83ff649da9@linaro.org>
 <7f37de5f-d31d-b51c-340d-a04ae99230f0@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <7f37de5f-d31d-b51c-340d-a04ae99230f0@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/6/23 16:15, Cédric Le Goater wrote:
> On 6/7/23 10:28, Philippe Mathieu-Daudé wrote:
>> On 7/6/23 10:06, Joel Stanley wrote:
>>> On Wed, 7 Jun 2023 at 04:40, Cédric Le Goater <clg@kaod.org> wrote:
>>>>
>>>> Boards will use this new property to identify the device CS line and
>>>> wire the SPI controllers accordingly.
>>>
>>> "addr" and not "cs" or even "chip-select"?
>>
>> "chip-select" is a good suggestion!
> 
> I thought of using "cs" initially as it makes more sense for SPI
> controllers, I do agree. But then, I tried to be consistent with
> what QEMU is proposing today : "bus" and "addr".

We should use a description that stays close with the terms used
by the hardware we model. In that case "cs" seems more appropriate.

