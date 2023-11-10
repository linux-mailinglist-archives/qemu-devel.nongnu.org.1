Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 322557E78C5
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 06:23:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Jyf-0007vP-6v; Fri, 10 Nov 2023 00:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Jyc-0007s8-0b
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 00:22:42 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Jya-0007OI-6x
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 00:22:41 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50949b7d7ffso2308417e87.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 21:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699593757; x=1700198557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BDK1FRjq5ZNXq4CZ6cr4RX8iDoNrpMTmTiF4Z4SOC7M=;
 b=u8yv1mrT2Mrc+4bwH8r6vNYadROAMiCkkGfw8FTnKg95HdczZvAKWGxlSyVJdNKwnI
 bV+Hff0wZ360rrp8SKGEvPBWjn9mSHzRmJBsT/HTvEfKcLoecVgZ/TKrAHcmUwTYLqLA
 FJAlW9LpRLBUz2pSofbKzFNrGWVQP9iCZRbZrOYWnmLLd/yKd2skN5SP616fL9XbmXx1
 +5ADX5aMDTh1LTljtoRofrbSEdkX01J31KbHXSpVBCvFW1FnLE0edPyTCDrMUhWhgpSf
 bHEHPDnOQWzo8yZ0GNz2XHG5Q4DDD2W05bimFyGEO4nJ+DNiBaxnm4jum+rFDBVr2JmU
 QiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699593757; x=1700198557;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BDK1FRjq5ZNXq4CZ6cr4RX8iDoNrpMTmTiF4Z4SOC7M=;
 b=PHhg6DdBbMbM3YNl0RGaYS8vCdWhCdfLAlA2xQUIb4u0RxzJ5UdMWtrOajwv23aIka
 rTa+j3vX0vJ59VS6DbySbZ/9xmLeu5JG3Ip+oidtrgUnHKrIKbwsVfQkMS3nyMU9hpYT
 YMCHnHeYN8zLS7Nk4YlHodbityLu8+oNPldR/5E9/opPQx5ijn5l+3lAKaYc2h5xDygI
 g9Wskk+p/7ZDfPV7zfxXOpOPwdsBxiYhuTm9tZqhF3e+kwGEcErXUxUJKZTxrPlVUZQr
 6pqGgbK1wS7nN6BwDSWAuL1qCLj3tlUUMbOyBequJv9PbxSn2/U3rWHd9KtSoa+S+gR5
 itKw==
X-Gm-Message-State: AOJu0YyPc7RmfyypMbYOl6Trj1iMEoYW38aXyLyssYaj3enoYhGU3c/8
 cQ5Dc7jxX/un7Ny5YzSJeOTAgg==
X-Google-Smtp-Source: AGHT+IE5Qn+eahcBacpnPxEYYMDpbGMGR15LXTaIgX1QaWWTcueVBScoTnrsHTgVsAXbPEhOIc1UkQ==
X-Received: by 2002:a19:6402:0:b0:509:4a55:f189 with SMTP id
 y2-20020a196402000000b005094a55f189mr3101912lfb.11.1699593757580; 
 Thu, 09 Nov 2023 21:22:37 -0800 (PST)
Received: from [192.168.69.115] ([176.187.194.109])
 by smtp.gmail.com with ESMTPSA id
 fl14-20020a05600c0b8e00b004094d4292aesm4064145wmb.18.2023.11.09.21.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 21:22:37 -0800 (PST)
Message-ID: <3d9ce855-9936-4649-ac53-a03ad4c7e1d8@linaro.org>
Date: Fri, 10 Nov 2023 06:22:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/pci: bypass vfio DMA counting when using cdev
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, clg@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20231109225302.401344-1-mjrosato@linux.ibm.com>
 <20231109225302.401344-2-mjrosato@linux.ibm.com>
 <aa0536ae-d44d-44bb-a688-93393950fd76@linaro.org>
In-Reply-To: <aa0536ae-d44d-44bb-a688-93393950fd76@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

[Sent too fast by inadvertence...]

Hi Matthew,

On 10/11/23 06:21, Philippe Mathieu-Daudé wrote:
> On 9/11/23 23:53, Matthew Rosato wrote:
>> The current code assumes that there is always a vfio group, but
>> that's no longer guaranteed with the iommufd backend when using
>> cdev.  In this case, we don't need to track the vfio dma limit
>> anyway.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-vfio.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
>> index 59a2e03873..7218583883 100644
>> --- a/hw/s390x/s390-pci-vfio.c
>> +++ b/hw/s390x/s390-pci-vfio.c
>> @@ -66,7 +66,11 @@ S390PCIDMACount 
>> *s390_pci_start_dma_count(S390pciState *s,
>>       assert(vpdev);
> 
> Matter of taste, simpler as:
> 
>         if (!vpdev->vbasedev.group) {
>             return NULL;
>         }
> 
>> -    id = vpdev->vbasedev.group->container->fd;
> 
> and this line isn't changed.
> 
>> +    if (vpdev->vbasedev.group) {
>> +        id = vpdev->vbasedev.group->container->fd;
>> +    } else {
>> +        return NULL;
>> +    }
>>       if (!s390_pci_update_dma_avail(id, &avail)) {
>>           return NULL;
> 

Regards,

Phil :)

