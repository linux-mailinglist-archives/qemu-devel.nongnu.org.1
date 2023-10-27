Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6089C7D8DF7
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 07:06:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwF2u-0004f6-0e; Fri, 27 Oct 2023 01:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwF2r-0004e5-Mz
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 01:06:05 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwF2p-0006vk-RC
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 01:06:05 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c501bd6ff1so23576771fa.3
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 22:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698383161; x=1698987961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TXUSomEWbEcOaPkhsIU+lDCvGM7PDobbEw2nkC8uckk=;
 b=veM9Kznhd5nr6SyuJ367Q8O9yyUqUCJllEdjTd8bHCKDaouDazDOirlbNAFFbyw8V0
 IURow+S4psJJ5kearLKPUd/Wqw7WYo0BiVuNgUPk5P7f6b3iwJTzjA+ytd6TmW2ACQwC
 2bm7u9H74oAe7N6NtZ777BMuCuxG0qW8o1SUHY3KSkyG8oGciq6685HOKPxoMt4MrpWl
 27niDFVxEjTDVSpRj4lnf1yC5dXynIuTXzoNZCc1XIfLwSkfsZRzoc6pC3/DBN0XFNBn
 rK6CEV1HTzre4C7hDNJD40RJkm3vbMJJHMJa67REDZZo52k89VVyh/N0jAZ/JCyBTn8/
 xcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698383161; x=1698987961;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TXUSomEWbEcOaPkhsIU+lDCvGM7PDobbEw2nkC8uckk=;
 b=n7ka7oK8dAM9EjZcSDs9W2yLjj8MdDiFYGptssqWRZNF70hf3jLTztPoRl0p/6zoEx
 nDOwITB9FHc8FvDUQ7TunevmxFscB7SVEeaoZQS58/b1qusqDSytnElhQ3WsL5FwkSdk
 ytqVAaVcxrnYYf8kNIVA/Rcq2f51vd1dfBoS/5QknfdribnVt+6W5Sc+pT4ogSX2SAmi
 IIdwQGrSSwU9V252okWHX1vg69OQFupvHXOsrqqx8DMMpuvyMJlp5KOBcWoIV5WVjx7N
 jRBV6UBMT4sJ7DPYl8qpWMEUHFUFZI8rTe8DuyQWInKc4CF7CDhZe1g462bMQbLOFDji
 kWtA==
X-Gm-Message-State: AOJu0YwS4u9GV+HAGriHDeiOpQ9nVve44nPpKULtUtNF/nb5gtWBXZf2
 oS1YVskflZztYcbJBbuaik53tg==
X-Google-Smtp-Source: AGHT+IG84fQUbUuBLXKxfg7/tEYyJjGJakeuGOc2IXGuI2FJ8aABDoxSQzZuiLDLuGuvvVBFUFTfXw==
X-Received: by 2002:a2e:b90f:0:b0:2c5:3a9:7467 with SMTP id
 b15-20020a2eb90f000000b002c503a97467mr1096705ljb.8.1698383161006; 
 Thu, 26 Oct 2023 22:06:01 -0700 (PDT)
Received: from [192.168.69.115] ([176.171.220.131])
 by smtp.gmail.com with ESMTPSA id
 q3-20020adff503000000b0032d09f7a713sm909264wro.18.2023.10.26.22.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 22:06:00 -0700 (PDT)
Message-ID: <7f6df257-21d2-531a-3bdd-684336200698@linaro.org>
Date: Fri, 27 Oct 2023 07:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 RESEND] ppc/pnv: Fix number of I2C engines and ports
 for power9/10
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com
References: <20231024212944.34043-1-milesg@linux.vnet.ibm.com>
 <8400292d-0098-432a-a49b-ac658264c3ff@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <8400292d-0098-432a-a49b-ac658264c3ff@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 25/10/23 08:56, Cédric Le Goater wrote:
> On 10/24/23 23:29, Glenn Miles wrote:
>> Power9 is supposed to have 4 PIB-connected I2C engines with the
>> following number of ports on each engine:
>>
>>      0: 2
>>      1: 13
>>      2: 2
>>      3: 2
>>
>> Power10 also has 4 engines but has the following number of ports
>> on each engine:
>>
>>      0: 14
>>      1: 14
>>      2: 2
>>      3: 16
>>
>> Current code assumes that they all have the same (maximum) number.
>> This can be a problem if software expects to see a certain number
>> of ports present (Power Hypervisor seems to care).
>>
>> Fixed this by adding separate tables for power9 and power10 that
>> map the I2C controller number to the number of I2C buses that should
>> be attached for that engine.
>>
>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> 
> you could have kept :
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> one comment below,
> 
>> ---
>> Based-on: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
>> ([PATCH] ppc/pnv: Connect PNV I2C controller to powernv10)
>>
>> Changes from v1:
>>      - Added i2c_ports_per_engine to PnvChipClass
>>      - replaced the word "ctlr" with "engine"
>>
>>   hw/ppc/pnv.c              | 14 ++++++++++----
>>   include/hw/ppc/pnv_chip.h |  6 ++----
>>   2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 2655b6e506..f6dc84b869 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1507,6 +1507,8 @@ static void pnv_chip_power9_pec_realize(PnvChip 
>> *chip, Error **errp)
>>       }
>>   }
>> +static int pnv_power9_i2c_ports_per_engine[PNV9_CHIP_MAX_I2C] = {2, 
>> 13, 2, 2};
>> +
> 
> Generally, these class constants are located close to the class definitions
> in the file.

Either keep them close by for comparison, or, since there
is a single use, declare it in the function using it here 
pnv_chip_power9_class_init().

> 
> Thanks,
> 
> C.


