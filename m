Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4725A7B802F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:04:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1Xe-0001Ek-0l; Wed, 04 Oct 2023 09:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo1XS-0001CU-Nk
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo1XP-0004tY-Tc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696424618;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gOuptJIvqKcGX6qUJ15EFP95BUh8z4+leGsmCY5MAsE=;
 b=TKvBeYQVyYaTFlviwTOye3j6e8Fv2Hn7gAUs3T8MwEz9QBtz6MfNTnP6qntEkGelKuUEzC
 sCTG8RkUgEpJ8VN4pCkqE3IKqIMLdFmAVhksDho5JQgIjAhSL0PSGa3Il2W7JxbCt48YXM
 EgJodogiEy77YqvvuBSqoRiy0VFysjU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-EW18TAcZMf2iYwN7qSSL-A-1; Wed, 04 Oct 2023 09:03:37 -0400
X-MC-Unique: EW18TAcZMf2iYwN7qSSL-A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-774086da4dbso245485785a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696424616; x=1697029416;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gOuptJIvqKcGX6qUJ15EFP95BUh8z4+leGsmCY5MAsE=;
 b=DhHS2ighs0caIohmpn0oNLrCldqoyHpzSGeMMP1i8XixwklaBoPwBxxej+IEk49RGK
 IiGNc8tl/889DAfDduviniOEET/N03BTE+d0AYzFu1gBWL5xHjM8vZGmG/eUJiYok1Kr
 cfOfdRe0uanoo5KvjbW0Li9zXl5AVe77Y/jvv1Hn9rCz+j5HJklMSzoc4j2WKlmdC4y+
 BrCM1GKMhtQ05tgjOQS3fD7/8d5XIsgN4QWiIilyuMZxCXBqNbz5YTINDBMKue0kgikf
 s8a3tfzIzGFijBWp2YPK1Le2huMOdAbROSgEb0FAG2/svOHUkK+tdh0P8bKZqDNldI2B
 KfPw==
X-Gm-Message-State: AOJu0Yy1fRqFLQ0rVE/C/KPDsJCc0NewYRyRcdD94He0ZFXlkCXnOuVl
 DizfC+iXjjfAl1qqlvZqxxDS9VGdM3MTYk/k6Fq85ucLWo6qPL8uz28jiYLqzuy8QfzjbnzbdUv
 XwqHyCsL4sAuJM94=
X-Received: by 2002:a05:620a:2ac5:b0:775:69b4:b4e6 with SMTP id
 bn5-20020a05620a2ac500b0077569b4b4e6mr2436938qkb.7.1696424616292; 
 Wed, 04 Oct 2023 06:03:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSYfXmu+9v+NgC9cjt1J9SHXt6clcIRYDWpYDt0TK/og8yxenANwg6gTbaQq9yV7kFsR3Vrw==
X-Received: by 2002:a05:620a:2ac5:b0:775:69b4:b4e6 with SMTP id
 bn5-20020a05620a2ac500b0077569b4b4e6mr2436915qkb.7.1696424616024; 
 Wed, 04 Oct 2023 06:03:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 b10-20020ac86bca000000b00417fa7d33dbsm1193749qtt.93.2023.10.04.06.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 06:03:34 -0700 (PDT)
Message-ID: <4098f81f-bb7c-bbcb-4d73-04e3981a08f5@redhat.com>
Date: Wed, 4 Oct 2023 15:03:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 13/15] vfio/common: Store the parent container in
 VFIODevice
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, peterx@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-14-eric.auger@redhat.com>
 <79fb6650-783c-f9d7-4294-668bebe23fe0@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <79fb6650-783c-f9d7-4294-668bebe23fe0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Cédric,

On 10/3/23 17:59, Cédric Le Goater wrote:
> On 10/3/23 12:14, Eric Auger wrote:
>> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>> let's store the parent contaienr within the VFIODevice.
>> This simplifies the logic in vfio_viommu_preset() and
>> brings the benefice to hide the group specificity which
>> is useful for IOMMUFD migration.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/hw/vfio/vfio-common.h | 1 +
>>   hw/vfio/common.c              | 8 +++++++-
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h
>> b/include/hw/vfio/vfio-common.h
>> index 8ca70dd821..bf12e40667 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -132,6 +132,7 @@ typedef struct VFIODevice {
>>       QLIST_ENTRY(VFIODevice) next;
>>       QLIST_ENTRY(VFIODevice) container_next;
>>       struct VFIOGroup *group;
>> +    VFIOContainer *container;
>>       char *sysfsdev;
>>       char *name;
>>       DeviceState *dev;
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index ef9dc7c747..55f8a113ea 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -184,7 +184,7 @@ void vfio_unblock_multiple_devices_migration(void)
>>     bool vfio_viommu_preset(VFIODevice *vbasedev)
>>   {
>> -    return vbasedev->group->container->space->as !=
>> &address_space_memory;
>> +    return vbasedev->container->space->as != &address_space_memory;
>>   }
>>     static void vfio_set_migration_error(int err)
>> @@ -2655,6 +2655,7 @@ int vfio_attach_device(char *name, VFIODevice
>> *vbasedev,
>>       }
>>         container = group->container;
>> +    vbasedev->container = container;
>>       QLIST_INSERT_HEAD(&container->device_list, vbasedev,
>> container_next);
>>         return ret;
>> @@ -2664,7 +2665,12 @@ void vfio_detach_device(VFIODevice *vbasedev)
>>   {
>>       VFIOGroup *group = vbasedev->group;
>>   +    if (!vbasedev->container) {
>> +        return;
>> +    }
>
> Can this happen ? Should it be an assert ?
I don't think so. Let me simply drop the check.

Thanks

Eric
>
> Thanks,
>
> C.
>
>
>> +
>>       QLIST_REMOVE(vbasedev, container_next);
>> +    vbasedev->container = NULL;
>>       trace_vfio_detach_device(vbasedev->name, group->groupid);
>>       vfio_put_base_device(vbasedev);
>>       vfio_put_group(group);
>


