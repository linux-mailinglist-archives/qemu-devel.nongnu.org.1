Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 094907A92BC
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:43:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFGZ-0005IB-7z; Thu, 21 Sep 2023 04:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjFGX-0005Hx-45
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjFGV-0002Rt-Dt
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695285746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zK6eTUGXN0Lx13xkY5YAmRsfOS+pIyX7W+j4pzgroFI=;
 b=LUkdf75ii1NyUQUzUpNjly9N2YArJvdmEiYN2fiRcojkPDeBYkfxpjQ39VSbk4MQtVvx6M
 UBc5SRxWlfcR2CdMp9Gqvss06lbyx6LDylfV2wau4jO8bvp6mGwckQybpDjSQVjyLeTUqV
 pyYUtxXTjxKOCvE76esCl6B8OwXlFpM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-7KiQDQVJMUK9AsuXNN2S0Q-1; Thu, 21 Sep 2023 04:42:24 -0400
X-MC-Unique: 7KiQDQVJMUK9AsuXNN2S0Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso5401755e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 01:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695285743; x=1695890543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zK6eTUGXN0Lx13xkY5YAmRsfOS+pIyX7W+j4pzgroFI=;
 b=WZQiaEQsY9khJ6RvohagneOJzfEo2HVNzBiOGjLmZfF4uXaDX5nsyaT+l3uS9TTYFj
 SeA+XPTGzSKV0TIRIVE0CvFaoqyFH1x7XeIFu40Epm6UFvF89OLZ5jHu+Ae974crpr6+
 0w540O9ESOjng/lOH4epq1h+GuTPWQdc2IOoTgIvXEsbJdZFWa8lu+1TNFz6D7rjlmtb
 8uc3dZmpXBfFvGRyhZs3oe1lnnksfXxcj8yjHuJRL+e/lVACOvl73SrMsSqBcWP/PBzg
 O3p1kl71iR/i3kWXU9gGIsOT5jMu2DFXynEA1lTXpnO1WzKtyz5EyTnIPn4le/SxnLyr
 ZwXA==
X-Gm-Message-State: AOJu0Yx4zLk4D53WK5cdKyACBK1iICc3yKHE76rWNQUv76IInbAKg06L
 3KGpkqrUe83PmJOd49jdnhKB2X40F3p+71n/owXa4eWXfryPmw6jX1E/vVGmM5kjZ8NpzmiVC1U
 lG1ygNUNlqtJOuLY=
X-Received: by 2002:a05:600c:6021:b0:405:32e2:f8bb with SMTP id
 az33-20020a05600c602100b0040532e2f8bbmr901761wmb.31.1695285743221; 
 Thu, 21 Sep 2023 01:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvBeUBEQkWCe05H92Emm+4BJeeOuZ5s9EdzoRLK5gRwYsdexKq/TH2jxbw2XoOsvqtNJyuug==
X-Received: by 2002:a05:600c:6021:b0:405:32e2:f8bb with SMTP id
 az33-20020a05600c602100b0040532e2f8bbmr901747wmb.31.1695285742861; 
 Thu, 21 Sep 2023 01:42:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a1cf211000000b003fe2a40d287sm1295199wmc.1.2023.09.21.01.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 01:42:22 -0700 (PDT)
Message-ID: <95befe1b-efb4-82f9-3cf8-fe703378617f@redhat.com>
Date: Thu, 21 Sep 2023 10:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 05/22] vfio/common: Extract out
 vfio_kvm_device_[add/del]_fd
Content-Language: en-US
To: eric.auger@redhat.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, peterx@redhat.com, jasowang@redhat.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-6-zhenzhong.duan@intel.com>
 <127c3104-44e0-f19f-6339-43182fbf6db1@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <127c3104-44e0-f19f-6339-43182fbf6db1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/20/23 13:49, Eric Auger wrote:
> Hi Zhenzhong,
> 
> On 8/30/23 12:37, Zhenzhong Duan wrote:
>> ...which will be used by both legacy and iommufd backend.
> I prefer genuine sentences in the commit msg. Also you explain what you
> do but not why.
> 
> suggestion: Introduce two new helpers, vfio_kvm_device_[add/del]_fd
> which take as input a file descriptor which can be either a group fd or
> a cdev fd. This uses the new KVM_DEV_VFIO_FILE VFIO KVM device group,
> which aliases to the legacy KVM_DEV_VFIO_GROUP.

Ah yes. I didn't understand why the 's/GROUP/FILE/' change in the
VFIO KVM device ioctls. Thanks for clarifying.

What about pre-6.6 kernels without KVM_DEV_VFIO_FILE support ?

C.


> 
> vfio_kvm_device_add/del_group then call those new helpers.
> 
> 
> 
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/common.c              | 44 +++++++++++++++++++++++------------
>>   include/hw/vfio/vfio-common.h |  3 +++
>>   2 files changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 67150e4575..949ad6714a 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1759,17 +1759,17 @@ void vfio_reset_handler(void *opaque)
>>       }
>>   }
>>   
>> -static void vfio_kvm_device_add_group(VFIOGroup *group)
>> +int vfio_kvm_device_add_fd(int fd)
>>   {
>>   #ifdef CONFIG_KVM
>>       struct kvm_device_attr attr = {
>> -        .group = KVM_DEV_VFIO_GROUP,
>> -        .attr = KVM_DEV_VFIO_GROUP_ADD,
>> -        .addr = (uint64_t)(unsigned long)&group->fd,
>> +        .group = KVM_DEV_VFIO_FILE,
>> +        .attr = KVM_DEV_VFIO_FILE_ADD,
>> +        .addr = (uint64_t)(unsigned long)&fd,
>>       };
>>   
>>       if (!kvm_enabled()) {
>> -        return;
>> +        return 0;
>>       }
>>   
>>       if (vfio_kvm_device_fd < 0) {
>> @@ -1779,37 +1779,51 @@ static void vfio_kvm_device_add_group(VFIOGroup *group)
>>   
>>           if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
>>               error_report("Failed to create KVM VFIO device: %m");
>> -            return;
>> +            return -ENODEV;
> can't you return -errno?
>>           }
>>   
>>           vfio_kvm_device_fd = cd.fd;
>>       }
>>   
>>       if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>> -        error_report("Failed to add group %d to KVM VFIO device: %m",
>> -                     group->groupid);
>> +        error_report("Failed to add fd %d to KVM VFIO device: %m",
>> +                     fd);
>> +        return -errno;
>>       }
>>   #endif
>> +    return 0;
>>   }
>>   
>> -static void vfio_kvm_device_del_group(VFIOGroup *group)
>> +static void vfio_kvm_device_add_group(VFIOGroup *group)
>> +{
>> +    vfio_kvm_device_add_fd(group->fd);
> Since vfio_kvm_device_add_fd now returns an error value, it's a pity not
> to use it and propagate it. Also you could fill an errp with the error
> msg and use it in vfio_connect_container(). But this is a new error
> handling there.
>> +}
>> +
>> +int vfio_kvm_device_del_fd(int fd)
> not sure we want this to return an error. But if we do, I think it would
> be nicer to propagate the error up.
>>   {
>>   #ifdef CONFIG_KVM
>>       struct kvm_device_attr attr = {
>> -        .group = KVM_DEV_VFIO_GROUP,
>> -        .attr = KVM_DEV_VFIO_GROUP_DEL,
>> -        .addr = (uint64_t)(unsigned long)&group->fd,
>> +        .group = KVM_DEV_VFIO_FILE,
>> +        .attr = KVM_DEV_VFIO_FILE_DEL,
>> +        .addr = (uint64_t)(unsigned long)&fd,
>>       };
>>   
>>       if (vfio_kvm_device_fd < 0) {
>> -        return;
>> +        return -EINVAL;
>>       }
>>   
>>       if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>> -        error_report("Failed to remove group %d from KVM VFIO device: %m",
>> -                     group->groupid);
>> +        error_report("Failed to remove fd %d from KVM VFIO device: %m",
>> +                     fd);
>> +        return -EBADF;
> -errno?
>>       }
>>   #endif
>> +    return 0;
>> +}
>> +
>> +static void vfio_kvm_device_del_group(VFIOGroup *group)
>> +{
>> +    vfio_kvm_device_del_fd(group->fd);
>>   }
>>   
>>   static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 5e376c436e..598c3ce079 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -220,6 +220,9 @@ struct vfio_device_info *vfio_get_device_info(int fd);
>>   int vfio_get_device(VFIOGroup *group, const char *name,
>>                       VFIODevice *vbasedev, Error **errp);
>>   
>> +int vfio_kvm_device_add_fd(int fd);
>> +int vfio_kvm_device_del_fd(int fd);
>> +
>>   extern const MemoryRegionOps vfio_region_ops;
>>   typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>>   extern VFIOGroupList vfio_group_list;
> Thanks
> 
> Eric
> 


