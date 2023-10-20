Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E07D14BC
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 19:19:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtt9j-0007xy-8q; Fri, 20 Oct 2023 13:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qtt9h-0007xh-3S
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qtt9f-00053l-74
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697822361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I63ZPD2OD4MIX1foxuPklxGcyHXQI8FEP2t1Eha9erc=;
 b=HcSI1UbpC9IK4Bl73vVWrVfDqi74vvjxJCtXxEJAxuIttYOTj4SvFvOqTU8d0Ja4VZbeNa
 mL6AyIyZSWLMBWWBxTWTrCwVhQAeo8oCpq0OFp8YGHiJqyceIguoJoAjckJKLHzg5ltlrI
 SVhc76D2GQkQSGBRpzNx/j5Qp6kWoMM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-PXQnww4hNPyWr7UupXmUGw-1; Fri, 20 Oct 2023 13:19:14 -0400
X-MC-Unique: PXQnww4hNPyWr7UupXmUGw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66d08175882so10001376d6.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 10:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697822354; x=1698427154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I63ZPD2OD4MIX1foxuPklxGcyHXQI8FEP2t1Eha9erc=;
 b=sJ/BrB/9y9VecjuMBjZDaJN1wECSTRTyEwssW1Y18mBg+1IQX43WvKKPDYUGHUn8k+
 bBOW7pg2tnKDc/kGRSTgjQVRvsNpemq8pQg8VacCVZjszTcCHMZjZqqGBI8UaR0Nuobg
 tDqOC6ID5vwISH7EWuuFPYkzuhwEBjNc+tG1WfwHN6T/wOhwk1CTOVByB1iSAvwPmc1C
 UazyN4LDAg6GNW4TMqFxbWhjQvObWRZSJgA93dQuBFs6Yez9Bqg2FIlov2Y59NjiUSct
 l61PbIFthHd/srWi5UA1Eu+AOpXAOqByYmcQmhsQ0e39z4BkqRCMebQevMjb6xKs12Jh
 70TQ==
X-Gm-Message-State: AOJu0YwtQkm/w90zMwjrQAFX+gpPsdMBpILuJVUt7B38RchcOcPLP8BX
 aMB7xsiqMHHj3Rvpxrruffct1Uk+aQKfpb4+UMP6RSu+wtcLHLeBBzX9o1kiK9rPupgew+J9LPM
 Xmy3Xpkrh8LAbEe8=
X-Received: by 2002:a05:6214:230e:b0:66d:9d28:3686 with SMTP id
 gc14-20020a056214230e00b0066d9d283686mr1745459qvb.53.1697822354225; 
 Fri, 20 Oct 2023 10:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDMmqUryfkOrkL4USI2ughj72auywsNMLd6nV8UASBAjBWYPth6Hw9onENaEqxeV8YkjlJ/Q==
X-Received: by 2002:a05:6214:230e:b0:66d:9d28:3686 with SMTP id
 gc14-20020a056214230e00b0066d9d283686mr1745438qvb.53.1697822353919; 
 Fri, 20 Oct 2023 10:19:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bt12-20020ad455cc000000b00655e428604esm827405qvb.137.2023.10.20.10.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 10:19:13 -0700 (PDT)
Message-ID: <54f3c17b-c176-480a-a094-b1b8c11fe5bb@redhat.com>
Date: Fri, 20 Oct 2023 19:19:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/3] vfio/pci: add support for VF token
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Minwoo Im <minwoo.im@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20230509215923.3186420-1-alex.williamson@redhat.com>
 <20230509215923.3186420-2-alex.williamson@redhat.com>
 <CAFEAcA_-gJ4pvP3vkdU0C5TbSiDrRjbVpU5eOmgYAasYCiRTJQ@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <CAFEAcA_-gJ4pvP3vkdU0C5TbSiDrRjbVpU5eOmgYAasYCiRTJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/20/23 15:32, Peter Maydell wrote:
> On Tue, 9 May 2023 at 23:01, Alex Williamson <alex.williamson@redhat.com> wrote:
>>
>> From: Minwoo Im <minwoo.im@samsung.com>
>>
>> VF token was introduced [1] to kernel vfio-pci along with SR-IOV
>> support [2].  This patch adds support VF token among PF and VF(s). To
>> passthu PCIe VF to a VM, kernel >= v5.7 needs this.
>>
>> It can be configured with UUID like:
>>
>>    -device vfio-pci,host=DDDD:BB:DD:F,vf-token=<uuid>,...
>>
>> [1] https://lore.kernel.org/linux-pci/158396393244.5601.10297430724964025753.stgit@gimli.home/
>> [2] https://lore.kernel.org/linux-pci/158396044753.5601.14804870681174789709.stgit@gimli.home/
>>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
>> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>> Link: https://lore.kernel.org/r/20230320073522epcms2p48f682ecdb73e0ae1a4850ad0712fd780@epcms2p4
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> 
> Hi; Coverity points out that this change introduces a buffer
> overrun (CID 1522913). I dunno why it's taken it so long
> to notice...
> 
>> ---
>>   hw/vfio/pci.c | 13 ++++++++++++-
>>   hw/vfio/pci.h |  1 +
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index ec9a854361ac..cf27f28936cb 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2856,6 +2856,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>       int groupid;
>>       int i, ret;
>>       bool is_mdev;
>> +    char uuid[UUID_FMT_LEN];
> 
> We define the array uuid[] as UUID_FMT_LEN bytes long...
> 
>> +    char *name;
>>
>>       if (!vbasedev->sysfsdev) {
>>           if (!(~vdev->host.domain || ~vdev->host.bus ||
>> @@ -2936,7 +2938,15 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>           goto error;
>>       }
>>
>> -    ret = vfio_get_device(group, vbasedev->name, vbasedev, errp);
>> +    if (!qemu_uuid_is_null(&vdev->vf_token)) {
>> +        qemu_uuid_unparse(&vdev->vf_token, uuid);
> 
> ...but qemu_uuid_unparse() writes UUID_FMT_LEN + 1 bytes,
> including a trailing NUL.
> 
> Every other use of UUID_FMT_LEN to declare an array
> uses "UUID_FMT_LEN + 1" to avoid this.

We also have :

     char uuidstr[37];

in vdi_header_print() and other places like test-uuid.


> (In fact, every use of UUID_FMT_LEN at all uses "+ 1",
> which suggests that perhaps defining it differently (and
> perhaps with a different name) would reduce the risk of
> this particular bug...)

libuuid defines :

   #define UUID_STR_LEN	37

QEMU could do the same ?

Thanks,

C.

> 
> thanks
> -- PMM
> 


