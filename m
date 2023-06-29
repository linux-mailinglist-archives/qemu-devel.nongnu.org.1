Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEF7742936
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:15:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtLj-0006Zz-OW; Thu, 29 Jun 2023 11:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEtLU-0006Y4-GH
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEtLP-0003zr-7b
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688051639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQAGqFOeNUnpnFBv4J6jPJY0M06+gyrB70lE1rOOIsg=;
 b=iU/2k4PUYQaSGaNm3TJ+Jq9ZcYnJNY4Jb4IRf6GRmM2BIRZH3QFx7vxNWlqaEsvlHyNM8+
 hO0Nlm6GDbxN1HKpnDbRrpsuiPmdJwmutLUz51nOPm64AGd6YQtciyAllOSfgazwKPaLEu
 spBFPof4Bny7OtPUiXln10ZD2b8zxS4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-WzZyu04tP-ueR8pg9GAXsg-1; Thu, 29 Jun 2023 11:13:41 -0400
X-MC-Unique: WzZyu04tP-ueR8pg9GAXsg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-635984f84a9so9957776d6.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 08:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688051616; x=1690643616;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FQAGqFOeNUnpnFBv4J6jPJY0M06+gyrB70lE1rOOIsg=;
 b=DZIkPXKP+DRifzn9lujEViTcrXKAFfUA+sO+TO8iRKXnvFoTrh2K+VI6mbUOKEBQLO
 fgItAKK7B0+rzoAG4JSBNWPw6vmyp+T9hxfffN4Z5jdfUNHIRbBtb9IyqhCh98MNwIAl
 g8Xklm69O0dGmioM2aVFdsHdSNuywTOZkhf/KnXIPMsuCgZdd/q7rMHWrQzqwpC5qa63
 MfFXgrH+dCnGJ8vV9XV7wDYo0me/LBJYtubF5kq8NU6gkd0TBPVW71uoe5/ekmWVUgMB
 J1DQyPW5XxnuWQFWIxpzzH70EiPt7vtF3IFabbfP2Au9pch+6fhuIPBgBN3UJZal6NPe
 aP7g==
X-Gm-Message-State: AC+VfDxmIyHfwh+p9TUtFguBhPaYy8X3ueK/ltk8aAIQXHgw7A/51SOH
 BxnNK0DifkEkWkSFlEcm3qwLROYnd5Q6066duGJ0wM97XAASP4/5zI0DQRbAHt7/jVMspO7En0z
 O5Tqdp0dO3miPZB4=
X-Received: by 2002:ad4:5aee:0:b0:62f:1f41:c6f0 with SMTP id
 c14-20020ad45aee000000b0062f1f41c6f0mr46315098qvh.42.1688051616638; 
 Thu, 29 Jun 2023 08:13:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WOTQmvWp7GSadfooXYx8S5sLz1TBBCjkvG0vO23UJ6DWJPE25imOtq59DgUYvLmm3uAz/jA==
X-Received: by 2002:ad4:5aee:0:b0:62f:1f41:c6f0 with SMTP id
 c14-20020ad45aee000000b0062f1f41c6f0mr46315083qvh.42.1688051616328; 
 Thu, 29 Jun 2023 08:13:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ec17-20020ad44e71000000b00632191a70a2sm6999289qvb.103.2023.06.29.08.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 08:13:35 -0700 (PDT)
Message-ID: <393d930c-da04-4c86-0f77-615c511df77b@redhat.com>
Date: Thu, 29 Jun 2023 17:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/5] vfio/pci: Disable INTx in vfio_realize error path
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-4-zhenzhong.duan@intel.com>
 <29b6ecd3-d0a1-c914-9bba-cb99d95acd8d@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <29b6ecd3-d0a1-c914-9bba-cb99d95acd8d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/29/23 13:24, Joao Martins wrote:
> On 29/06/2023 09:40, Zhenzhong Duan wrote:
>> When vfio realize fails, INTx isn't disabled if it has been enabled.
>> This may confuse host side with unhandled interrupt report.
>>
>> Add a new label to be used for vfio_intx_enable() failed case.
>>
>> Fixes: a9994687cb9b ("vfio/display: core & wireup")
>> Fixes: b290659fc3dd ("hw/vfio/display: add ramfb support")
>> Fixes: c62a0c7ce34e ("vfio/display: add xres + yres properties")
> 
> Sounds to me the correct Fixes tag is the same as first patch i.e.:
> 
> Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")
> 
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Looks good, but see some clarifications below.
> 
>> ---
>>   hw/vfio/pci.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index ab6645ba60af..54a8179d1c64 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3167,7 +3167,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>           kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
>>           ret = vfio_intx_enable(vdev, errp);
>>           if (ret) {
>> -            goto out_deregister;
>> +            goto out_intx_disable;
>>           }
>>       }
>>   
>> @@ -3220,6 +3220,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>       return;
>>   
>>   out_deregister:
>> +    vfio_disable_interrupts(vdev);
> 
> You are calling vfio_disable_interrupts() when what you want is
> vfio_intx_disable() ? But I guess your thinking was to call
> vfio_disable_interrupt() which eventually calls vfio_intx_disable() in case INTx
> was really setup, thus saving the duplicated check. The MSIx/MSI in realize() I
> don't think they will be enabled at this point. Let me know if I misunderstood.
> 
>> +out_intx_disable:
> 
> Maybe 'out_intx_teardown' or 'out_intx_deregister' because you are not really
> disabling INTx.

or simply extract from vfio_disable_interrupts() :
  
     if (vdev->interrupt == VFIO_INT_INTx) {
         vfio_intx_disable(vdev);
     }

and add the above code before cleaning up the intx routing
notifier without any new goto labels.

Thanks,

C.


> 
>>       pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>>       if (vdev->irqchip_change_notifier.notify) {
>>           kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> 


