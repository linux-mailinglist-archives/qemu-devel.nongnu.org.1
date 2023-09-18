Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8697A4715
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:32:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBY7-0006Mg-EO; Mon, 18 Sep 2023 06:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qiBY5-0006Kt-BV; Mon, 18 Sep 2023 06:32:13 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qiBXz-0001Ml-8Q; Mon, 18 Sep 2023 06:32:13 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3adc9770737so1054021b6e.3; 
 Mon, 18 Sep 2023 03:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695033123; x=1695637923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u2XoQccHPeet8oQfGABnvQ1Ju9kKPmHInWspEt1ZrsE=;
 b=hUMe3vgtuEP2Nadlv7Vn1K2f99u10897KeB0Ct0g+qqX5Dp3CHaA/EnvipnAHv7iGv
 4sfY5z4rcJX7p8pCCVld/+g/03Z2J0GuYh1R37LPBXNe2pdf9YgqXyuNiGYJMafdDwSr
 yU4yEPLKN7O+HSPs5iXAlp/FZSt5olnPHyQKGvWnXGWCP+d4AhT0ydtJArx0dlvCQEH9
 AQ8YRezYSAjJzEem8gDdSn7EZ7NJpTbTo+ujeqAhy4mnOMFeRYbuxEfQmJI0Z1L0kcbC
 nvtLbrLmCAAJl/UxV84/mC4qwCM856h9fi4BegA646v2YZlN2XOcuTLRC31eBn1CW7Ej
 sOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695033123; x=1695637923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u2XoQccHPeet8oQfGABnvQ1Ju9kKPmHInWspEt1ZrsE=;
 b=LT+BcXzQ8STYXqJw1LWN6TWYvgI0hFygeBS9wqocRXxzLTVpKNTumb4ThB9OYY6tcZ
 hpEn3fFT8M7fH/N+FeMEf4Hqcp558/bGY2PicEM1UZvfrnW69kBs2nwdQcfJbo34y2hM
 315mfkT8wlsjDwJM5ECgYVtlefUtM3VXbUwEYg4xef2B2z1CAhKD33HTX3xtiI3ib+FK
 Hut4pYMuh/P/XpgaTxcii4lPVrmb4CnK+/F2mF3WU5EIJc3g8QqswVNweo0y+7DG/R5f
 zQzSRyxCly6G+uaK1zpJBx3+aW101B46iIG2X1fvKedtst4DypU8VtGpMAcKNEyIPYi/
 tXiw==
X-Gm-Message-State: AOJu0YxKL8OZIbRl0xqAoKS9hvVQP8+DNCuzMps+N5H1XxsLlJ8HRKHh
 4VtjpiKo+SiCxd775sRL3h4=
X-Google-Smtp-Source: AGHT+IGAx3qXMgerXBnaTd7TMSHrlAiN8OHZsA7I5BIe8+eFT77+DfHdXt+Qpr10ep/FebwKJw4CXA==
X-Received: by 2002:a05:6870:95aa:b0:1d5:aed5:65a1 with SMTP id
 k42-20020a05687095aa00b001d5aed565a1mr10826216oao.33.1695033123420; 
 Mon, 18 Sep 2023 03:32:03 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.127.211])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a056870349400b001bbeef974aesm4808777oah.20.2023.09.18.03.32.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 03:32:03 -0700 (PDT)
Message-ID: <b86077f1-7078-722d-50e2-d1f97951ba83@gmail.com>
Date: Mon, 18 Sep 2023 07:31:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org,
 aik@ozlabs.ru, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230915110507.194762-1-danielhb413@gmail.com>
 <CVLS27TKE0YM.3DW0F4YAP5BFA@wheely>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <CVLS27TKE0YM.3DW0F4YAP5BFA@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 9/18/23 02:01, Nicholas Piggin wrote:
> Hi Daniel,
> 
> Thank you for your stwardship of ppc, I might hope to do half as good a
> job with it as you have. And to Greg and David for all the work over the
> years.

I'm pretty sure you'll be great :D and both Cedric and I will be around if
you need assistance.


Thanks,

Daniel

> 
> Thanks,
> Nick
> 
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

