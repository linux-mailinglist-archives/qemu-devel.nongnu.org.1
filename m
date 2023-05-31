Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AA47176B9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 08:18:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4F9X-0000ZN-Hb; Wed, 31 May 2023 02:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4F9A-0000I8-4e
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:17:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4F98-00083g-9F
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:17:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f611ccd06eso39699865e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 23:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685513839; x=1688105839;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=58LCf2t6sXVtAGSisX4WsJKmdVzbSq6fC7hBy7R1rUU=;
 b=AoPa4ZqLEHjKpD8q/Trh4MBVJKpcvDHLmL4n2ryABlyE3GyPK3epUulLJNkhpszHsR
 AGEwrnASpICAInptclI2ATUl0dNOR7YMfeHvFzkAmtkQd0aBz/yl88a/oicLIMhc2SDw
 QysGwSKaSS3v0llBETQunz2YmGbBx8P8HiyEmPsD1SvgsRCVzKMMXEyx6RD2UvNOvtf/
 MVP5l/OURtjzeidhDVoFIwXAi5NG0gREYWU8SEXGcr1TIFWnu5vLPXvs4ltlbc4QJnBw
 b/u7cdo6rHN7fyRqP7kBWwUKlIfBZ9SC784om6S5yHXq+9TxxQvWtROTZgHDvhUMDPvh
 AmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685513839; x=1688105839;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=58LCf2t6sXVtAGSisX4WsJKmdVzbSq6fC7hBy7R1rUU=;
 b=TtIIdd81O52pq91qKOfJ6xA2629DIZPJmaivVp8HmNST/xVlzpSypSRgHid4Yu4l4q
 P2izUgfYDHMVTy8abOB+M0K1SlMPLP+APwuHW/b43b4Chz/DhGk7o2lsz7CiMCsFnXCN
 jvyOW8Y08ZbMkzyGgA9X5uBtIcK183GqAUSu5YzJ//1dTDpxKlLUnS9ncfmA+X2iTHOf
 8qvdtLj2t7goddhWWzbu+Ej2QCJPay3e7+18DJ3CWppw9vene5J5vQ2zUWvlDxWFKQ1D
 gF7g7z/HNm2isiR7wLaX8mUGoq8frIuUMk8cx7CROY85bC33/wI4BDiS2xw4J8QbEBLu
 5itw==
X-Gm-Message-State: AC+VfDwhEK1SwmvYDBMiylD3FRTgcCK/9NOQqdrWX4KwNuwhNJ7IYIG7
 hAJFBFqJ7VmOohb/exjyrH3F0Q==
X-Google-Smtp-Source: ACHHUZ6ZJ7UmJeKFOT2INI7f+NnzXXe6xUJN+DV7zwun6HuKUtkZ7QDxNBkMULkSvngBy4BACUdaww==
X-Received: by 2002:a7b:c3d4:0:b0:3f6:787:4a84 with SMTP id
 t20-20020a7bc3d4000000b003f607874a84mr3601123wmj.7.1685513839715; 
 Tue, 30 May 2023 23:17:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 bg22-20020a05600c3c9600b003f4283f5c1bsm1734857wmb.2.2023.05.30.23.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 23:17:19 -0700 (PDT)
Message-ID: <6bfba08e-ce3e-539b-952d-697c8791fab2@linaro.org>
Date: Wed, 31 May 2023 08:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 05/12] hw/ssi: Introduce a ssi_get_cs() helper
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-6-clg@kaod.org>
 <40c8647d-201e-3ceb-97ca-ec98bdc84e88@linaro.org>
 <0d11b78e-56f7-553a-3e85-0edef9b649ac@linaro.org>
 <523179dd-7842-7f03-14d6-678ed680a017@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <523179dd-7842-7f03-14d6-678ed680a017@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

+QOM tinkerers

On 31/5/23 07:59, Cédric Le Goater wrote:
> On 5/30/23 23:15, Philippe Mathieu-Daudé wrote:
>> On 30/5/23 22:34, Philippe Mathieu-Daudé wrote:
>>> On 8/5/23 09:58, Cédric Le Goater wrote:
>>>> Simple routine to retrieve a DeviceState object on a SPI bus using its
>>>> address/cs. It will be useful for the board to wire the CS lines.
>>>>
>>>> Cc: Alistair Francis <alistair@alistair23.me>
>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>> ---
>>>>   include/hw/ssi/ssi.h |  2 ++
>>>>   hw/ssi/ssi.c         | 15 +++++++++++++++
>>>>   2 files changed, 17 insertions(+)
>>>>
>>>> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
>>>> index ffd3a34ba4..c7beabdb09 100644
>>>> --- a/include/hw/ssi/ssi.h
>>>> +++ b/include/hw/ssi/ssi.h
>>>> @@ -112,4 +112,6 @@ SSIBus *ssi_create_bus(DeviceState *parent, 
>>>> const char *name);
>>>>   uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
>>>> +DeviceState *ssi_get_cs(SSIBus *bus, int addr);
>>
>> Also, this helper should (preferably) return a SSIPeripheral type.
> 
> Well, having a DeviceState is handy for the callers (today) and
> ssi_create_peripheral() returns a DeviceState. Let's keep it that
> way.

Yes I know it is handy :) I'm not against your patch; besides other
APIs do that. I'm wondering about QOM design here. Having Foo device,
should FOO API return the common qdev abstract type (DeviceState) or
a Foo type? Either ways we keep QOM-casting around, but I still tend
to consider FOO API returning Foo pointer provides some type check
safety, and also provides the API user hints about what is used.
Need more coffee.

