Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 733157A453B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:57:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiA3q-0000jy-78; Mon, 18 Sep 2023 04:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1qiA3Z-0000cn-GS
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:56:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1qiA3W-0000Oj-2I
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:56:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so29885225ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20230601.gappssmtp.com; s=20230601; t=1695027391; x=1695632191;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o/xUus0kHZtxWIRjKdHNXc+0bS0/mlG1VYeQCBDR9g0=;
 b=Nd1b+2O/KHamYS/F2LzHQR1ru/5dzZWBw5XO5klOt8lr4So1DxUK4Ek0F3CY2V6dgr
 rKQZdB68ycB+3G0AfLFgIMdksRwHUpMibuWsa7izxbu1kpQSZoImpJclVJsVVt1QQrzD
 lgsZkUc4DD4y+tgQioDnbvjhj2jjoTdriQVX3JY1gXGoUQps8uMRW29TZb7l9AdGngB0
 IxRNp7Fa6sQHXwoIwP8QVSplaBnJjbcme7r+/j79v14XYsZ7muoveQV6OscAxNcbu3Kk
 j6Lh0CvrCCobCvfHuk25qJLqR5aaYhFSR+65itMqOb/PHjljg8Hdhed0hjdczv3MMIVC
 ym9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695027391; x=1695632191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o/xUus0kHZtxWIRjKdHNXc+0bS0/mlG1VYeQCBDR9g0=;
 b=pUvMCpb2W0tuehz8TWv6w1FF0u1oM61+q8iDayKi9Sig1fu4Z7xqTvzp+Fb/EDJusr
 SBxtL3OfBjLO6JucYcZzSS9ZlC66ofr9sUn/yt6TWJ7kBNZidtuyU/Q/CPX1yPZw1/UL
 /WbdNVgZNJiiwNRTtVjUJerqffzHDz5Nsidl5zaiVJGcb6d5uhQr+jmOgGPoPjhRjnOm
 QXOjTNWThw44R38Elb6meRS3PNrFuJ081Y4sgzNg/3aoZMRcZZnVcwJy+V+7QIdeG5Cu
 b8A2DpMwpqR6UlF+VhWiB8Cn77M7aCgK/7+UJVuqqI4wdtWvwfRxXtmPc9vad+ux17dJ
 6Z/w==
X-Gm-Message-State: AOJu0YyyQUwderpJRG488eFj0rB3vY2Iv2MydwdQdmALXn8c5Zf+SOtY
 qGqaWpY96+63D4iuU1DgVJypZg==
X-Google-Smtp-Source: AGHT+IEKm60DmWSJh6GZr90CJ14LDoKx1qS81lt1EmLjeSyflSsMhTr1nBTUQ0yitZAiNxmWzXqx0w==
X-Received: by 2002:a17:902:e550:b0:1bf:7dfd:5b05 with SMTP id
 n16-20020a170902e55000b001bf7dfd5b05mr15045453plf.27.1695027391531; 
 Mon, 18 Sep 2023 01:56:31 -0700 (PDT)
Received: from [192.168.10.153]
 (ppp118-208-171-7.cbr-trn-nor-bras39.tpg.internode.on.net. [118.208.171.7])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001b9da42cd7dsm7764273plh.279.2023.09.18.01.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 01:56:31 -0700 (PDT)
Message-ID: <ecb4be3d-1a8f-4723-a842-173678fbe858@ozlabs.ru>
Date: Mon, 18 Sep 2023 18:56:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20230915110507.194762-1-danielhb413@gmail.com>
 <CVLU9WN6M895.27GDUJQUWD3UP@wheely>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <CVLU9WN6M895.27GDUJQUWD3UP@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=aik@ozlabs.ru; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On 18/09/2023 16:45, Nicholas Piggin wrote:
> On Fri Sep 15, 2023 at 9:05 PM AEST, Daniel Henrique Barboza wrote:
>> Update all relevant PowerPC entries as follows:
>>
>> - Nick Piggin is promoted to Maintainer in all qemu-ppc subsystems.
>>    Nick has  been a solid contributor for the last couple of years and
>>    has the required knowledge and motivation to drive the boat.
>>
>> - Greg Kurz is being removed from all qemu-ppc entries. Greg has moved
>>    to other areas of interest and will retire from qemu-ppc.  Thanks Mr
>>    Kurz for all the years of service.
>>
>> - David Gibson was removed as 'Reviewer' from PowerPC TCG CPUs and PPC
>>    KVM CPUs. Change done per his request.
>>
>> - Daniel Barboza downgraded from 'Maintainer' to 'Reviewer' in sPAPR and
>>    PPC KVM CPUs. It has been a long since I last touched those areas and
>>    it's not justified to be kept as maintainer in them.
>>
>> - Cedric Le Goater and Daniel Barboza removed as 'Reviewer' in VOF. We
>>    don't have the required knowledge to justify it.
>>
>> - VOF support downgraded from 'Maintained' to 'Odd Fixes' since it
>>    better reflects the current state of the subsystem.
>>
> 
> Oh, I forgot:
> 
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
>


And you also forgot to mention where on github/gitlab the ppc-next 
branch is hosted from now on, for SLOF releases :)  Today I'll use 
qemu/master.



>> Acked-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   MAINTAINERS | 20 +++++++-------------
>>   1 file changed, 7 insertions(+), 13 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 00562f924f..c4aa1c1c9f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -298,11 +298,9 @@ F: hw/openrisc/
>>   F: tests/tcg/openrisc/
>>   
>>   PowerPC TCG CPUs
>> +M: Nicholas Piggin <npiggin@gmail.com>
>>   M: Daniel Henrique Barboza <danielhb413@gmail.com>
>>   R: Cédric Le Goater <clg@kaod.org>
>> -R: David Gibson <david@gibson.dropbear.id.au>
>> -R: Greg Kurz <groug@kaod.org>
>> -R: Nicholas Piggin <npiggin@gmail.com>
>>   L: qemu-ppc@nongnu.org
>>   S: Odd Fixes
>>   F: target/ppc/
>> @@ -438,10 +436,9 @@ F: target/mips/kvm*
>>   F: target/mips/sysemu/
>>   
>>   PPC KVM CPUs
>> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
>> +M: Nicholas Piggin <npiggin@gmail.com>
>> +R: Daniel Henrique Barboza <danielhb413@gmail.com>
>>   R: Cédric Le Goater <clg@kaod.org>
>> -R: David Gibson <david@gibson.dropbear.id.au>
>> -R: Greg Kurz <groug@kaod.org>
>>   S: Odd Fixes
>>   F: target/ppc/kvm.c
>>   
>> @@ -1430,10 +1427,10 @@ F: include/hw/rtc/m48t59.h
>>   F: tests/avocado/ppc_prep_40p.py
>>   
>>   sPAPR (pseries)
>> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
>> +M: Nicholas Piggin <npiggin@gmail.com>
>> +R: Daniel Henrique Barboza <danielhb413@gmail.com>
>>   R: Cédric Le Goater <clg@kaod.org>
>>   R: David Gibson <david@gibson.dropbear.id.au>
>> -R: Greg Kurz <groug@kaod.org>
>>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>   L: qemu-ppc@nongnu.org
>>   S: Odd Fixes
>> @@ -1452,8 +1449,8 @@ F: tests/avocado/ppc_pseries.py
>>   
>>   PowerNV (Non-Virtualized)
>>   M: Cédric Le Goater <clg@kaod.org>
>> +M: Nicholas Piggin <npiggin@gmail.com>
>>   R: Frédéric Barrat <fbarrat@linux.ibm.com>
>> -R: Nicholas Piggin <npiggin@gmail.com>
>>   L: qemu-ppc@nongnu.org
>>   S: Odd Fixes
>>   F: docs/system/ppc/powernv.rst
>> @@ -1497,12 +1494,9 @@ F: include/hw/pci-host/mv64361.h
>>   
>>   Virtual Open Firmware (VOF)
>>   M: Alexey Kardashevskiy <aik@ozlabs.ru>
>> -R: Cédric Le Goater <clg@kaod.org>
>> -R: Daniel Henrique Barboza <danielhb413@gmail.com>
>>   R: David Gibson <david@gibson.dropbear.id.au>
>> -R: Greg Kurz <groug@kaod.org>
>>   L: qemu-ppc@nongnu.org
>> -S: Maintained
>> +S: Odd Fixes
>>   F: hw/ppc/spapr_vof*
>>   F: hw/ppc/vof*
>>   F: include/hw/ppc/vof*
> 

-- 
Alexey



