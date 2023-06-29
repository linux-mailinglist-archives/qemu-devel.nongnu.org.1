Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 903B774298A
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:25:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtV7-0000Jr-Nj; Thu, 29 Jun 2023 11:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEtUx-0000Jg-Bh
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEtUu-0006hw-Nl
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688052230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pcS2z9nid1fQLYJGUdDnzas2hvGoFSpL666HWkL5B1Y=;
 b=HDcrussUr3fUuvWktc/MsS1LYojHgv38p/G0BSUvbOydAK/pd98g3/OlB/2rVFWQUD8roi
 RC9c5stf2DPKt+5j4up7HbHL9NnF+rR5eLhkhGcE/LEzTh0/ZbkayVfNE6Batk/vUgHVPo
 JN+8R/omjYu7pcwhGuBH4ZHJ8iXL7N4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-Z8Qe6mZrNsKvMQafRNz9Bw-1; Thu, 29 Jun 2023 11:23:48 -0400
X-MC-Unique: Z8Qe6mZrNsKvMQafRNz9Bw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7656c94fc4eso93136485a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 08:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688052227; x=1690644227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pcS2z9nid1fQLYJGUdDnzas2hvGoFSpL666HWkL5B1Y=;
 b=LbXaJq+5PZUVsnwAyj6uM8r2zUHfp7EeWwGw3Uko/gFE9EQfXC2UbAFAlyl4TFmU7d
 7uwJigmXQjHCMHLdMhARNhYWkw/lOYd8meOVKTQUzZHWC8YtsrX7t/8MewRcNh7/UW+T
 pHKvPLnNqmvImDo1M4LDUPVt41XYg9YEu/baIf11GjJUOAQxvbraY4GgOVw0yw7NWnz5
 Cg1p/b1TQ5cvBcbAfFZR4r1gkJ4Ku5cQwxGZIzcHpbHb0l1+rcn6lJXung+Z53g0KNEg
 H5u1kKrFFX5ZxOSKXPD1xz8rZ7qWvaPBq0ubeNziM05Vwv56rMi2dTJeupl2jFLa94X3
 eZsg==
X-Gm-Message-State: AC+VfDx3h28s6leDaN5kvHI3GuoJqQCg7vrVGMCs+grnsWRsPwGBbbkp
 1ZzIERyeheURb4QsoPrpWinNmN+qBIOMw2ai44buXVhYCRqHRQt1sNojRPJT6NKP5h8ZEUyl4NU
 qhnLHm5iBvTbSWhOnwlU2bhw=
X-Received: by 2002:a05:620a:ed3:b0:75d:4de8:aec0 with SMTP id
 x19-20020a05620a0ed300b0075d4de8aec0mr32289808qkm.3.1688052227667; 
 Thu, 29 Jun 2023 08:23:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ggByXUrA2/Q0p8t3KJyLchHfMFfVGXLWpLqs0GysXN0fuswyqbeKf3zVv1Fq9gTRCQgP9nA==
X-Received: by 2002:a05:620a:ed3:b0:75d:4de8:aec0 with SMTP id
 x19-20020a05620a0ed300b0075d4de8aec0mr32289790qkm.3.1688052227428; 
 Thu, 29 Jun 2023 08:23:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 v20-20020a05620a123400b0075b2809ee8csm6191664qkj.136.2023.06.29.08.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 08:23:47 -0700 (PDT)
Message-ID: <553e8105-2b44-e16b-8630-26678dddecd8@redhat.com>
Date: Thu, 29 Jun 2023 17:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 4/5] vfio/pci: Free resources when
 vfio_migration_realize fails
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-5-zhenzhong.duan@intel.com>
 <346b1c73-0efb-e339-dbbf-c4ae41e85861@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <346b1c73-0efb-e339-dbbf-c4ae41e85861@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 6/29/23 13:45, Joao Martins wrote:
> On 29/06/2023 09:40, Zhenzhong Duan wrote:
>> When vfio_realize() succeeds, hot unplug will call vfio_exitfn()
>> to free resources allocated in vfio_realize(); when vfio_realize()
>> fails, vfio_exitfn() is never called and we need to free resources
>> in vfio_realize().
>>
>> In the case that vfio_migration_realize() fails,
>> e.g: with -only-migratable & enable-migration=off, we see below:
>>
>> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
>> 0000:81:11.1: Migration disabled
>> Error: disallowing migration blocker (--only-migratable) for: 0000:81:11.1: Migration is disabled for VFIO device
>>
>> If we hotplug again we should see same log as above, but we see:
>> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
>> Error: vfio 0000:81:11.1: device is already attached
>>
>> That's because some references to VFIO device isn't released,
>> we should check return value of vfio_migration_realize() and
>> release the references, then VFIO device will be truely
>> released when hotplug fails.
>>
>> Fixes: a22651053b59 ("vfio: Make vfio-pci device migration capable")
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/pci.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 54a8179d1c64..dc69d3031b24 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3210,6 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>           ret = vfio_migration_realize(vbasedev, errp);
>>           if (ret) {
>>               error_report("%s: Migration disabled", vbasedev->name);
>> +            goto out_vfio_migration;
>>           }
>>       }
>>   
>> @@ -3219,6 +3220,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>   
>>       return;
>>   
>> +out_vfio_migration:
>> +    vfio_migration_exit(vbasedev);
>>   out_deregister:
>>       vfio_disable_interrupts(vdev);
>>   out_intx_disable:
> 
> I agree with the general sentiment behind the change.
> Clearly vfio::migration and vfio::migration_blocker are leaking from inside the
> migration_realize() function.
> 
> But it is kinda awkward semantic that vfio_migration_realize() (or any realize)
> failures need to be accompanied with a vfio_migration_exit() that tears down
> state *leaked* by its realize() failure.
> 
> It sounds to me that this should be inside the vfio_migration_realize() not on
> the caller? Unless QEMU ::realize() is expected to do this.
> 

I agree. vfio_migration_realize() should handle the cleanup of the resources
it allocated if there is a failure.

Thanks

C.


