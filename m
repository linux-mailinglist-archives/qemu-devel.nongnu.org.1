Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF17B816C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:55:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2Ky-0002kN-Kv; Wed, 04 Oct 2023 09:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo2Kd-0002UA-L9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo2Kb-0002uP-V4
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696427669;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LK+zxju4RfPbiDu2DDmdG2+fKT/V8QDtEOa8g8zPjFQ=;
 b=QXzoqQfX6rujXc3f1PC14a6lw/zAJGkBG6PJrV9lXt/jt1F+ZM93TAoF1x4oB1kPHG26lI
 FQmiQvtWgVjcOrqrGOjIipzrg9XKh9BqK9Qq7kvD+6epQu/ieD5fHZe15qKMdGBZl/l1jO
 RKzQ7A1YEclaP9Sj2sYOlRSJg8TeY4c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-IGjMCOqgPIKLP_YOudatHg-1; Wed, 04 Oct 2023 09:54:28 -0400
X-MC-Unique: IGjMCOqgPIKLP_YOudatHg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77576c78c11so232522385a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696427667; x=1697032467;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LK+zxju4RfPbiDu2DDmdG2+fKT/V8QDtEOa8g8zPjFQ=;
 b=qYfKhTI1IxhwQy1tHKLxLyKlVnv1ZYq7jdZuBY+ynOVRiy4rIE63yPPEGZW54bTjdk
 7rNGtiiCTvPq/FyB1LT8hTyn+hF9RcTzHFeSwhVLNjAHEWjDS/ll1DkdwsXBNk45C+Vg
 XsftjiSxVGh7Z49G38E9uuuqddf998jpa1XcD8hwamBMAbGwcsOKG4qobFoUQNSSgLwc
 KK07z36WpqB7DCcfQWZudN3sXkFgdeq7FFNn1rDCoG2aSDo4LNCMMvks1D67WIi/tK1g
 ffH0SuQ/wLokHqDVGmbeAHD83Rmv49cU2TBdO8fY6qsnRUSta3yPdR53BrOdBRzFYO3r
 XN0g==
X-Gm-Message-State: AOJu0Yzt8+cEn63coLId3ndqgP337yt3pYvRFJoVt7qOz/79/EgU2p1R
 w6mVpKFT7aB/qJRmppU3IzfsDqOFQ2m6hyZss0aFv6yBZGKguS4igvY28prBarrvJG2NbJ5J+jL
 efOg1swm7onkwtns=
X-Received: by 2002:a05:620a:4046:b0:775:7fdc:42ac with SMTP id
 i6-20020a05620a404600b007757fdc42acmr2849357qko.7.1696427667516; 
 Wed, 04 Oct 2023 06:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqzFAAlBfDNEN70uLFPxSZ4ipSthX0rCosXHXnTtslrx/fqXBduOBd/mVOMD+LiA0R4orRsQ==
X-Received: by 2002:a05:620a:4046:b0:775:7fdc:42ac with SMTP id
 i6-20020a05620a404600b007757fdc42acmr2849337qko.7.1696427667249; 
 Wed, 04 Oct 2023 06:54:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 m22-20020ae9e016000000b0076d08d5f93asm1268386qkk.60.2023.10.04.06.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 06:54:25 -0700 (PDT)
Message-ID: <43fa4606-1d03-ff89-42e6-04d3ee4e71b9@redhat.com>
Date: Wed, 4 Oct 2023 15:54:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 14/15] vfio/common: Introduce a global VFIODevice list
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, peterx@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-15-eric.auger@redhat.com>
 <2bcff7f9-b4d0-4942-953c-1b25533217d1@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <2bcff7f9-b4d0-4942-953c-1b25533217d1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Cédric,

On 10/3/23 17:56, Cédric Le Goater wrote:
> On 10/3/23 12:14, Eric Auger wrote:
>> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>> Some functions iterate over all the VFIODevices. This is currently
>> achieved by iterating over all groups/devices. Let's
>> introduce a global list of VFIODevices simplifying that scan.
>
> Maybe we should move the qemu_register_reset() when the first device
> is added to the list, in vfio_attach_device() ?

Well at the moment this is done on the first address space addition to
vfio_address_spaces. I think it is quite similar and I would be tempted
to leave it there atm except if you or anybody has a strong opinion here.

Eric
>
> Thanks,
>
> C.
>
>>
>> This will also be useful while migrating to IOMMUFD by hiding the
>> group specificity.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  2 ++
>>   hw/vfio/common.c              | 45 +++++++++++++++--------------------
>>   2 files changed, 21 insertions(+), 26 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h
>> b/include/hw/vfio/vfio-common.h
>> index bf12e40667..54905b9dd4 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -131,6 +131,7 @@ typedef struct VFIODeviceOps VFIODeviceOps;
>>   typedef struct VFIODevice {
>>       QLIST_ENTRY(VFIODevice) next;
>>       QLIST_ENTRY(VFIODevice) container_next;
>> +    QLIST_ENTRY(VFIODevice) global_next;
>>       struct VFIOGroup *group;
>>       VFIOContainer *container;
>>       char *sysfsdev;
>> @@ -232,6 +233,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
>>     extern const MemoryRegionOps vfio_region_ops;
>>   typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>> +typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>>   extern VFIOGroupList vfio_group_list;
>>     bool vfio_mig_active(void);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 55f8a113ea..95bc50bcda 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -48,6 +48,8 @@
>>     VFIOGroupList vfio_group_list =
>>       QLIST_HEAD_INITIALIZER(vfio_group_list);
>> +static VFIODeviceList vfio_device_list =
>> +    QLIST_HEAD_INITIALIZER(vfio_device_list);
>>   static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
>>       QLIST_HEAD_INITIALIZER(vfio_address_spaces);
>>   @@ -94,18 +96,15 @@ static int vfio_get_dirty_bitmap(VFIOContainer
>> *container, uint64_t iova,
>>     bool vfio_mig_active(void)
>>   {
>> -    VFIOGroup *group;
>>       VFIODevice *vbasedev;
>>   -    if (QLIST_EMPTY(&vfio_group_list)) {
>> +    if (QLIST_EMPTY(&vfio_device_list)) {
>>           return false;
>>       }
>>   -    QLIST_FOREACH(group, &vfio_group_list, next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            if (vbasedev->migration_blocker) {
>> -                return false;
>> -            }
>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
>> +        if (vbasedev->migration_blocker) {
>> +            return false;
>>           }
>>       }
>>       return true;
>> @@ -120,19 +119,16 @@ static Error *multiple_devices_migration_blocker;
>>    */
>>   static bool vfio_multiple_devices_migration_is_supported(void)
>>   {
>> -    VFIOGroup *group;
>>       VFIODevice *vbasedev;
>>       unsigned int device_num = 0;
>>       bool all_support_p2p = true;
>>   -    QLIST_FOREACH(group, &vfio_group_list, next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            if (vbasedev->migration) {
>> -                device_num++;
>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
>> +        if (vbasedev->migration) {
>> +            device_num++;
>>   -                if (!(vbasedev->migration->mig_flags &
>> VFIO_MIGRATION_P2P)) {
>> -                    all_support_p2p = false;
>> -                }
>> +            if (!(vbasedev->migration->mig_flags &
>> VFIO_MIGRATION_P2P)) {
>> +                all_support_p2p = false;
>>               }
>>           }
>>       }
>> @@ -1777,22 +1773,17 @@ bool vfio_get_info_dma_avail(struct
>> vfio_iommu_type1_info *info,
>>     void vfio_reset_handler(void *opaque)
>>   {
>> -    VFIOGroup *group;
>>       VFIODevice *vbasedev;
>>   -    QLIST_FOREACH(group, &vfio_group_list, next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            if (vbasedev->dev->realized) {
>> -                vbasedev->ops->vfio_compute_needs_reset(vbasedev);
>> -            }
>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
>> +        if (vbasedev->dev->realized) {
>> +            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
>>           }
>>       }
>>   -    QLIST_FOREACH(group, &vfio_group_list, next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            if (vbasedev->dev->realized && vbasedev->needs_reset) {
>> -                vbasedev->ops->vfio_hot_reset_multi(vbasedev);
>> -            }
>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
>> +        if (vbasedev->dev->realized && vbasedev->needs_reset) {
>> +            vbasedev->ops->vfio_hot_reset_multi(vbasedev);
>>           }
>>       }
>>   }
>> @@ -2657,6 +2648,7 @@ int vfio_attach_device(char *name, VFIODevice
>> *vbasedev,
>>       container = group->container;
>>       vbasedev->container = container;
>>       QLIST_INSERT_HEAD(&container->device_list, vbasedev,
>> container_next);
>> +    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>>         return ret;
>>   }
>> @@ -2669,6 +2661,7 @@ void vfio_detach_device(VFIODevice *vbasedev)
>>           return;
>>       }
>>   +    QLIST_REMOVE(vbasedev, global_next);
>>       QLIST_REMOVE(vbasedev, container_next);
>>       vbasedev->container = NULL;
>>       trace_vfio_detach_device(vbasedev->name, group->groupid);
>


