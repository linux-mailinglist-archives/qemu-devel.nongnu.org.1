Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C62B803E40
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 20:21:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAEVW-0000E5-UR; Mon, 04 Dec 2023 14:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAEVK-0000Cm-Us
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 14:21:18 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAEVI-0000QN-VT
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 14:21:18 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c08af319cso20175315e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 11:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701717675; x=1702322475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3K/U+JD4ImiFJaCFjnxh0fAVGR6LL6OMJRLgu24pJPg=;
 b=k9agstqViAD1Wgx4pRVKJWKN5zTVqp+fCV0deOn4dPsMgtK8SpaN3sX1o7T4AKIg5j
 hzIyUZqFvhvjQhe0bjSHrXvKY52Qtbm5woyauQWKSyjVSrclv2cjWSAvLwbcLanbmTlf
 t/q5fw280UBR07SbN6laCD8llElzrHo/S2Y6jXkU5y7X6F3gOqmyRXfK9ZEpmB+/PPM4
 Heczdv0Jis4OhDOIHFQ+gFQDI2YxwYLSsN1dMm2gNFupDI96yW54X7wrHv80OH2eMJUl
 0txxxIeQ1KLAg0CXTia0taYX8MYmxP0s22TQq5ICtIJAGHw4rZFSWyT2dGysp9FHOmLj
 cGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701717675; x=1702322475;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3K/U+JD4ImiFJaCFjnxh0fAVGR6LL6OMJRLgu24pJPg=;
 b=gZQorqVLjDXsHOHkbeVHe7xnfV/q3IFkck2//ZpUT32WhLDBkVXBHddnJSKRJcQpIA
 LYXCfHs/g3arU3Lj2RCe8xwujtH1aoqgmE6q8XxhNqGQTx0fwG6YVx8uE2iC2MT6232p
 +JyU0p6O9gIJ1POsIKfOSoBoFOINPOdCUBIJzBoMMa5qR8s2TdgN32uqNx77q40cvSbS
 brN6KFOig+mm4Lhh5qfqyUVS0qn0+5Hu5jAaLodLYYCd2a/vEObt5enqS+EJwATG5/WO
 KSxqNm4aMol1w2om/IWAu1J1JPiyqqqw+Q9/iNxNaEjXvhLdwoGHDRVHu0uMo+s6syef
 rCvQ==
X-Gm-Message-State: AOJu0YwfDiuT0Je0MPspPiTL995mZh9s8ePpMlVvNq2JEOm6SCaW6031
 Ov8LbRLiM7vmjJsjQhw7CAD09ne8r0ArG6fIYZo=
X-Google-Smtp-Source: AGHT+IG1hFIYsvYPdiT3Mz7DFwzBAjpZtxUN/DEBvvbdBmqnvLKs8muREdRIsHtv42dVlQzJM5/KRw==
X-Received: by 2002:a05:600c:3510:b0:40b:4e35:d1d9 with SMTP id
 h16-20020a05600c351000b0040b4e35d1d9mr2671938wmq.14.1701717674804; 
 Mon, 04 Dec 2023 11:21:14 -0800 (PST)
Received: from [192.168.69.100] ([176.176.140.35])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a05600c4f0f00b0040b33222a39sm19896197wmq.45.2023.12.04.11.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 11:21:14 -0800 (PST)
Message-ID: <9112b12a-0a11-43c8-aa7d-77ca5b957428@linaro.org>
Date: Mon, 4 Dec 2023 20:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2?] hw/ufs: avoid generating the same ID string for
 different LU devices
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Akinobu Mita <akinobu.mita@gmail.com>, qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block <qemu-block@nongnu.org>
References: <20231204150543.48252-1-akinobu.mita@gmail.com>
 <1f537ae8-c3e6-4213-b2c7-b9398b8e1f64@linaro.org>
In-Reply-To: <1f537ae8-c3e6-4213-b2c7-b9398b8e1f64@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Jeuk,

On 4/12/23 17:50, Philippe Mathieu-Daudé wrote:
> On 4/12/23 16:05, Akinobu Mita wrote:
>> QEMU would not start when trying to create two UFS host controllers and
>> a UFS logical unit for each with the following options:
>>
>> -device ufs,id=bus0 \
>> -device ufs-lu,drive=drive1,bus=bus0,lun=0 \
>> -device ufs,id=bus1 \
>> -device ufs-lu,drive=drive2,bus=bus1,lun=0 \
>>
>> This is because the same ID string ("0:0:0/scsi-disk") is generated
>> for both UFS logical units.
>>
>> To fix this issue, prepend the parent pci device's path to make
>> the ID string unique.
>> ("0000:00:03.0/0:0:0/scsi-disk" and "0000:00:04.0/0:0:0/scsi-disk")
>>
>> Fixes: 096434fea13a ("hw/ufs: Modify lu.c to share codes with SCSI 
>> subsystem")

If you think this must be fixed for the 8.2 release, please assign
a release blocker issues to the GitLab 8.2 milestone here:
https://gitlab.com/qemu-project/qemu/-/milestones/10

>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> ---
>>   hw/ufs/ufs.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
>> index 68c5f1f6c9..eccdb852a0 100644
>> --- a/hw/ufs/ufs.c
>> +++ b/hw/ufs/ufs.c
>> @@ -1323,9 +1323,17 @@ static bool ufs_bus_check_address(BusState 
>> *qbus, DeviceState *qdev,
>>       return true;
>>   }
>> +static char *ufs_bus_get_dev_path(DeviceState *dev)
>> +{
>> +    BusState *bus = qdev_get_parent_bus(dev);
>> +
>> +    return qdev_get_dev_path(bus->parent);
>> +}
>> +
>>   static void ufs_bus_class_init(ObjectClass *class, void *data)
>>   {
>>       BusClass *bc = BUS_CLASS(class);
>> +    bc->get_dev_path = ufs_bus_get_dev_path;
>>       bc->check_address = ufs_bus_check_address;
>>   }
> 


