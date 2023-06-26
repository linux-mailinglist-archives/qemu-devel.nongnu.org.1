Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB6573E342
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDo7M-0002VF-Nq; Mon, 26 Jun 2023 11:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qDo7K-0002Qm-6e
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qDo7H-0000Lc-R2
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687793216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Sk9qJlNDULC2dRrnZogOinB0Iq2FDPsKRmF+stZdYg=;
 b=awEVEeAr0Ti7k7gpvcOUGOJJgL4Rfc+FeU3kHOdBySQRJMJNhYV1bCc1UwazgXCm9dlpTP
 oy+BU0B9LFk4wSzH0SBl1g37rTMSjKqAMyyZEVnYkk/HZbZgI2M3lQquCp03QGBGCJhWrk
 EwaYtVs3R7ShXz6b2NCgZ0wR9hxpm9o=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-ljHa1FDXMJycy17SBFZ6NA-1; Mon, 26 Jun 2023 11:26:52 -0400
X-MC-Unique: ljHa1FDXMJycy17SBFZ6NA-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6b4732b5e83so3247624a34.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793206; x=1690385206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Sk9qJlNDULC2dRrnZogOinB0Iq2FDPsKRmF+stZdYg=;
 b=B/yeQLTu5M1WV0Bx+ptxd7vn2IT2hSDnLOOJ8oLels2To8jmAafChlzBZjPGwLtV+d
 k+Bus6j0q460/Am4bfJb5pIc21tLFwwlh17HNTMMo+QdIAuqyaRBI2NkC2R3LFFsYexU
 yEvVwmPk4ZTJnqDhXflc8MZQokk/1rC2SZmwaXEEzREwBzlcfMD1+9kBKWXQkMO0RiB4
 nfpYtoxawMNu+2j9Ku4FX1RD/eYJu06cOZT+NM0xm8F/RVUebQJS7SohFnR5PaK7Poip
 4sfQpEay8BhMI6BOuDgIvxMUMteLW2eHha6jJ+NVURYiU70mLVoTx4UfliXmwScUWH70
 HDGQ==
X-Gm-Message-State: AC+VfDxImRK4xR4YaK5wLa1m/2pfb1mE3R1RCH7oQmRuiV15kJUxC03e
 EOxM5nibO1PapdCTg+MZrMLHSQhg4KIh7TcGwF8nJ1dfmIuAoPikfd/Z2rbcf5ImN5GTloHvxKi
 2AoLG9XBvB0o08KY=
X-Received: by 2002:a05:6359:679e:b0:130:df70:b9cd with SMTP id
 sq30-20020a056359679e00b00130df70b9cdmr13308951rwb.12.1687793205863; 
 Mon, 26 Jun 2023 08:26:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5GqGMlReejp9M/XXbF/wqfvTtFJw38MKeS5V3eWT7M94MdPvzqOa4ec8PvoSdGuPT8YsKCng==
X-Received: by 2002:a05:6359:679e:b0:130:df70:b9cd with SMTP id
 sq30-20020a056359679e00b00130df70b9cdmr13308941rwb.12.1687793205507; 
 Mon, 26 Jun 2023 08:26:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 t2-20020ac865c2000000b003f6b58b986fsm3160597qto.41.2023.06.26.08.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 08:26:45 -0700 (PDT)
Message-ID: <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
Date: Mon, 26 Jun 2023 17:26:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 qemu-devel@nongnu.org
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-4-avihaih@nvidia.com>
 <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
 <62b1ce2a-8191-fc6b-c7b7-e4c787deacf5@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <62b1ce2a-8191-fc6b-c7b7-e4c787deacf5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 6/26/23 15:40, Joao Martins wrote:
> On 26/06/2023 14:20, Cédric Le Goater wrote:
>> Hello Avihai,
>>
>> On 6/26/23 10:23, Avihai Horon wrote:
>>> The major parts of VFIO migration are supported today in QEMU. This
>>> includes basic VFIO migration, device dirty page tracking and precopy
>>> support.
>>>
>>> Thus, at this point in time, it seems appropriate to make VFIO migration
>>> non-experimental: remove the x prefix from enable_migration property,
>>> change it to ON_OFF_AUTO and let the default value be AUTO.
>>>
>>> In addition, make the following adjustments:
>>> 1. Require device dirty tracking support when enable_migration is AUTO
>>>      (i.e., not explicitly enabled). This is because device dirty tracking
>>>      is currently the only method to do dirty page tracking, which is
>>>      essential for migrating in a reasonable downtime.
>>
>> hmm, I don't think QEMU should decide to disable a feature for all
>> devices supposedly because it could be slow for some. That's too
>> restrictive. What about devices with have small states ? for which
>> the downtime would be reasonable even without device dirty tracking
>> support.
>>
> 
> device dirty tracking refers to the ability to tracking dirty IOVA used by the
> device which will DMA into RAM. It is required because the
> consequence/alternative is to transfer all RAM in stop copy phase. Device state
> size at that point is the least of our problems downtime wise.

Arg. thanks for reminding me. I tend to take this for granted ...

> I can imagine that allowing without dirty tracking is useful for developer
> testing of the suspend/device-state flows, but as real default (auto) is very
> questionable to let it go through without dirty tracking. When we have IOMMUFD
> dirty tracking that's when we can relieve this restriction as a default.
>
> But then note that (...)
> 
>>
>>> Setting
>>>      enable_migration to ON will not require device dirty tracking.
> 
> (...) this lets it ignore dirty tracking as you would like.
>
> 
>>> 2. Make migration blocker messages more elaborate.
>>> 3. Remove error prints in vfio_migration_query_flags().
>>> 4. Remove a redundant assignment in vfio_migration_realize().
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> ---
>>>    include/hw/vfio/vfio-common.h |  2 +-
>>>    hw/vfio/migration.c           | 29 ++++++++++++++++-------------
>>>    hw/vfio/pci.c                 |  4 ++--
>>>    3 files changed, 19 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index b4c28f318f..387eabde60 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -139,7 +139,7 @@ typedef struct VFIODevice {
>>>        bool needs_reset;
>>>        bool no_mmap;
>>>        bool ram_block_discard_allowed;
>>> -    bool enable_migration;
>>> +    OnOffAuto enable_migration;
>>>        VFIODeviceOps *ops;
>>>        unsigned int num_irqs;
>>>        unsigned int num_regions;
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 79eb81dfd7..d8e0848635 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -731,14 +731,6 @@ static int vfio_migration_query_flags(VFIODevice
>>> *vbasedev, uint64_t *mig_flags)
>>>        feature->argsz = sizeof(buf);
>>>        feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIGRATION;
>>>        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>>> -        if (errno == ENOTTY) {
>>> -            error_report("%s: VFIO migration is not supported in kernel",
>>> -                         vbasedev->name);
>>> -        } else {
>>> -            error_report("%s: Failed to query VFIO migration support, err: %s",
>>> -                         vbasedev->name, strerror(errno));
>>> -        }
>>> -
>>>            return -errno;
>>>        }
>>>    @@ -831,14 +823,28 @@ void vfio_reset_bytes_transferred(void)
>>>      int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>>    {
>>> -    int ret = -ENOTSUP;
>>> +    int ret;
>>>    -    if (!vbasedev->enable_migration) {
>>> +    if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
>>> +        error_setg(&vbasedev->migration_blocker,
>>> +                   "%s: Migration is disabled for VFIO device", vbasedev->name);
>>>            goto add_blocker;
>>>        }
>>>          ret = vfio_migration_init(vbasedev);
>>>        if (ret) {
>>
>> It would be good to keep the message for 'errno == ENOTTY' as it was in
>> vfio_migration_query_flags(). When migration fails, it is an important
>> information to know that it is because the VFIO PCI host device driver
>> doesn't support the feature. The root cause could be deep below in FW or
>> how the VF was set up.
>>
> +1 As I have been in this rabbit hole
> 
>>> +        error_setg(&vbasedev->migration_blocker,
>>> +                   "%s: Migration couldn't be initialized for VFIO device, "
>>> +                   "err: %d (%s)",
>>> +                   vbasedev->name, ret, strerror(-ret));
>>> +        goto add_blocker;
>>> +    }
>>> +
>>> +    if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO &&
>>> +        !vbasedev->dirty_pages_supported) {
>>
>> I don't agree with this test.
>>
> 
> The alternative right now is perceptual dirty tracking. How is that OK as a
> default? It's not like we have even an option :(
> 
> Maybe perhaps you refer to avoid strongly enforcing *always* it to allow testing
> of the non dirty tracking parts? Maybe when you 'force' enabling with
> enable-migration=on is when you ignore the dirty tracking which is what this is
> doing.


I see ON_OFF_AUTO_ON as a way to abort the machine startup while
ON_OFF_AUTO_AUTO would let it run but block migration. We would
need an extra property to relax the checks, else we are hijacking
some pre-existing option to fit our need.

Since dirty tracking is a must-have to implement migration support
for any existing and future VFIO PCI variant driver, anything else
would be experimental code and we are trying to remove the flag !
Please correct me if I am wrong.

So, the case !vbasedev->dirty_pages_supported is just an extra
information to report for why migration is not supported. Does
that sound reasonable ?

Thanks,

C.



> 
>>> +        error_setg(&vbasedev->migration_blocker,
>>> +                   "%s: VFIO device doesn't support device dirty tracking",
>>> +                   vbasedev->name);
>>>            goto add_blocker;
>>>        }
>> I agree that with ON_OFF_AUTO_AUTO, errors at realize time should be recorded
>> in a migration blocker. What about the ON_OFF_AUTO_ON case ? If migration was
>> explicitly requested for the device and the conditions on the host are not met,
>> I think realize should fail and the machine abort.
>>
> +1 Good point
> 
>> Thanks,
>>
>> C.
>>
>>
>>
>>> @@ -856,9 +862,6 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error
>>> **errp)
>>>        return 0;
>>>      add_blocker:
>>> -    error_setg(&vbasedev->migration_blocker,
>>> -               "VFIO device doesn't support migration");
>>> -
>>>        ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
>>>        if (ret < 0) {
>>>            error_free(vbasedev->migration_blocker);
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 73874a94de..48584e3b01 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3347,8 +3347,8 @@ static Property vfio_pci_dev_properties[] = {
>>>                        VFIO_FEATURE_ENABLE_REQ_BIT, true),
>>>        DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>>>                        VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>> -    DEFINE_PROP_BOOL("x-enable-migration", VFIOPCIDevice,
>>> -                     vbasedev.enable_migration, false),
>>> +    DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>> +                            vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>>>        DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>>>        DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>>>                         vbasedev.ram_block_discard_allowed, false),
>>


