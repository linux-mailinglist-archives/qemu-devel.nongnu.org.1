Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2ADABA0BC
	for <lists+qemu-devel@lfdr.de>; Fri, 16 May 2025 18:22:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFxno-0006Xa-KF; Fri, 16 May 2025 12:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFxnl-0006XJ-Rb
 for qemu-devel@nongnu.org; Fri, 16 May 2025 12:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFxnj-0005y0-5O
 for qemu-devel@nongnu.org; Fri, 16 May 2025 12:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747412445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AR7M4CKyTPjakltG21LIrzf+nlTHtXjECNp9S2vw0Jg=;
 b=E/7DDz4+eHYT5InZTk81uai/2IjYTQBn/5Miq6yNx9//bPTjt3QHvtfr4q/WpjHgU/XHu0
 +dnnCZTYvA7fKBEVPuymtizFc8qUkBVBzOdmwS0OthEVrPUJ1z7eQZxNIo0ByghyKax1Em
 2kcDJw1dSbZvUorROoiMxGTIOtCnzUM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-8NrOsz9-MbKYRP-XbKkeUg-1; Fri, 16 May 2025 12:20:43 -0400
X-MC-Unique: 8NrOsz9-MbKYRP-XbKkeUg-1
X-Mimecast-MFC-AGG-ID: 8NrOsz9-MbKYRP-XbKkeUg_1747412443
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0af6219a5so1368349f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 09:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747412442; x=1748017242;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AR7M4CKyTPjakltG21LIrzf+nlTHtXjECNp9S2vw0Jg=;
 b=YJHlsjxpMvEo4jrmjM/FSaMclLVhezJtbcRyZ4Co2fv3f3khmq7Ti5Fo2mwImwqou8
 FDHFEj5qeKsAXW9+zBBW4YFVWmP+WQxGWK91zJm94sHzBcnUTZ48xt8nJ/dPaY3qJ4Sv
 dEJy48K9Tb3aalbi2IU7tcO5omNmA29ATA95sI6iMpvhZu12TpWCrruatXp5gOftbRuU
 WiV46ahr2oPZZKuKgFJ2mTWEOadKQ+5GP0fkrSvWnQoybOkdCcYP/Snw05AF/yIoIET+
 FN9QtPsS1p6aly7EJOk+/s/Tyj7lqi2p33BlEF5zeW6QAC7Lhfp8/yEjAtavRl68WMrg
 9JKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFtH2QfVtQNApPiHsWcRZ56VRjtyszxYKKaeLHnIPQq1Sic3m57E3IfSqvab7VikCjKXy6imeAxRYl@nongnu.org
X-Gm-Message-State: AOJu0YwKJoPjboBCC0IoLFWcsj1kTJkjGVVBHCP4tBQkclxCv7pAOu3+
 IZPUJjnJYLA4HxVs9B333LobSFDhGix0ai3leRwu+4l1ynPlVW5B1W3A/GFhJLwD0V21lwpgHmA
 y6bO5X8fHSKkI0MRYo0hnDOAYgE7ndOHTO+90JP71MbEtjVzRJzVdEk0F
X-Gm-Gg: ASbGncvR5VTI/F6JxtMnWEAWU0ouCqZx2eovYF3AzgpTETVK61JeC8rEMqEiOk15w5w
 YVEe3WqWFrxS9JKdqDnyyrMwkTuXA0f2PwK/6rBTH7fCsOs7kA8D/Y7qWKn8VeTxVu1QerHwOyb
 R+UXKYvvsAJlr/68qxSr/JFu7E1oA7xDly28MD0OSKNxEiO1YIBRZZzgVGwbcOVh7q1+VW0AaFd
 fX5UbKpLhPJbWJc92QI9sri2DYtLR0bAtnweOCyZGDhIWKaticMlJXaF47LayNrebYH0ut7thXp
 V2Iji56FP8fWnUoqEBIezF9eTFPq+vXd1bClFiwoZhcqexk=
X-Received: by 2002:a5d:64e6:0:b0:3a3:4ba9:73b2 with SMTP id
 ffacd0b85a97d-3a3511998b6mr7492930f8f.3.1747412442564; 
 Fri, 16 May 2025 09:20:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQrgIazV2BmuB7a1R1SmVIl6um6P5dnnDg5oWhq0riGWIA1p4XzKW5ox8fmcyJ4YAhUg99Ag==
X-Received: by 2002:a5d:64e6:0:b0:3a3:4ba9:73b2 with SMTP id
 ffacd0b85a97d-3a3511998b6mr7492901f8f.3.1747412442128; 
 Fri, 16 May 2025 09:20:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a361a81fd8sm2373535f8f.81.2025.05.16.09.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 09:20:41 -0700 (PDT)
Message-ID: <d989b8a9-16cb-4b5f-b6cb-299ce93883f5@redhat.com>
Date: Fri, 16 May 2025 18:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 06/42] vfio/container: register container for cpr
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-7-git-send-email-steven.sistare@oracle.com>
 <161947a0-f3fb-4ddb-b6c1-6e1a1e4d6849@redhat.com>
 <2f36f035-6704-4a73-a9e7-953c27fb32d2@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <2f36f035-6704-4a73-a9e7-953c27fb32d2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/15/25 21:06, Steven Sistare wrote:
> On 5/15/2025 3:54 AM, Cédric Le Goater wrote:
>> On 5/12/25 17:32, Steve Sistare wrote:
>>> Register a legacy container for cpr-transfer, replacing the generic CPR
>>> register call with a more specific legacy container register call.  Add a
>>> blocker if the kernel does not support VFIO_UPDATE_VADDR or VFIO_UNMAP_ALL.
>>>
>>> This is mostly boiler plate.  The fields to to saved and restored are added
>>> in subsequent patches.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   hw/vfio/container.c              |  6 ++--
>>>   hw/vfio/cpr-legacy.c             | 70 ++++++++++++++++++++++++++++++++++++++++
>>>   hw/vfio/cpr.c                    |  5 ++-
>>>   hw/vfio/meson.build              |  1 +
>>>   include/hw/vfio/vfio-container.h |  2 ++
>>>   include/hw/vfio/vfio-cpr.h       | 14 ++++++++
>>>   6 files changed, 92 insertions(+), 6 deletions(-)
>>>   create mode 100644 hw/vfio/cpr-legacy.c
>>>
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index eb56f00..85c76da 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -642,7 +642,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>>       new_container = true;
>>>       bcontainer = &container->bcontainer;
>>> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
>>> +    if (!vfio_legacy_cpr_register_container(container, errp)) {
>>>           goto fail;
>>>       }
>>> @@ -678,7 +678,7 @@ fail:
>>>           vioc->release(bcontainer);
>>>       }
>>>       if (new_container) {
>>> -        vfio_cpr_unregister_container(bcontainer);
>>> +        vfio_legacy_cpr_unregister_container(container);
>>>           object_unref(container);
>>>       }
>>>       if (fd >= 0) {
>>> @@ -719,7 +719,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>>>           VFIOAddressSpace *space = bcontainer->space;
>>>           trace_vfio_container_disconnect(container->fd);
>>> -        vfio_cpr_unregister_container(bcontainer);
>>> +        vfio_legacy_cpr_unregister_container(container);
>>>           close(container->fd);
>>>           object_unref(container);
>>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>>> new file mode 100644
>>> index 0000000..fac323c
>>> --- /dev/null
>>> +++ b/hw/vfio/cpr-legacy.c
>>> @@ -0,0 +1,70 @@
>>> +/*
>>> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>>> + * See the COPYING file in the top-level directory.
>>
>> Please add a SPDX-License-Identifier tag.
> 
> Sure.  I'll do the same for my other new files.

and remove the License boiler plate too please.

A newer version of checkpatch will complain with :

   ERROR: New file 'hw/vfio/cpr-legacy.c' requires 'SPDX-License-Identifier'
   ERROR: New file 'hw/vfio/cpr-legacy.c' must not have license boilerplate header text unless this file is copied from existing code with such  text already present.
   WARNING: added, moved or deleted file(s):

     hw/vfio/cpr-legacy.c

   Does MAINTAINERS need updating?

   total: 2 errors, 1 warnings, 152 lines checked


Thanks,

C.


> 
>>> + */
>>> +
>>> +#include <sys/ioctl.h>
>>> +#include <linux/vfio.h>
>>> +#include "qemu/osdep.h"
>>> +#include "hw/vfio/vfio-container.h"
>>> +#include "hw/vfio/vfio-cpr.h"
>>> +#include "migration/blocker.h"
>>> +#include "migration/cpr.h"
>>> +#include "migration/migration.h"
>>> +#include "migration/vmstate.h"
>>> +#include "qapi/error.h"
>>> +
>>> +static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>> +{
>>> +    if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
>>> +        error_setg(errp, "VFIO container does not support VFIO_UPDATE_VADDR");
>>> +        return false;
>>> +
>>> +    } else if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL)) {
>>> +        error_setg(errp, "VFIO container does not support VFIO_UNMAP_ALL");
>>> +        return false;
>>> +
>>> +    } else {
>>> +        return true;
>>> +    }
>>> +}
>>> +
>>> +static const VMStateDescription vfio_container_vmstate = {
>>> +    .name = "vfio-container",
>>> +    .version_id = 0,
>>> +    .minimum_version_id = 0,
>>> +    .needed = cpr_needed_for_reuse,
>>> +    .fields = (VMStateField[]) {
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>> +};
>>> +
>>> +bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>> +{
>>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>>> +    Error **cpr_blocker = &container->cpr.blocker;
>>> +
>>> +    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
>>> +                                vfio_cpr_reboot_notifier,
>>> +                                MIG_MODE_CPR_REBOOT);
>>> +
>>> +    if (!vfio_cpr_supported(container, cpr_blocker)) {
>>> +        return migrate_add_blocker_modes(cpr_blocker, errp,
>>> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>>> +    }
>>> +
>>> +    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>>> +{
>>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>>> +
>>> +    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>>> +    migrate_del_blocker(&container->cpr.blocker);
>>> +    vmstate_unregister(NULL, &vfio_container_vmstate, container);
>>> +}
>>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>>> index 0210e76..0e59612 100644
>>> --- a/hw/vfio/cpr.c
>>> +++ b/hw/vfio/cpr.c
>>> @@ -7,13 +7,12 @@
>>>   #include "qemu/osdep.h"
>>>   #include "hw/vfio/vfio-device.h"
>>> -#include "migration/misc.h"
>>>   #include "hw/vfio/vfio-cpr.h"
>>>   #include "qapi/error.h"
>>>   #include "system/runstate.h"
>>> -static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>>> -                                    MigrationEvent *e, Error **errp)
>>> +int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>>> +                             MigrationEvent *e, Error **errp)
>>>   {
>>>       if (e->type == MIG_EVENT_PRECOPY_SETUP &&
>>>           !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
>>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>>> index bccb050..73d29f9 100644
>>> --- a/hw/vfio/meson.build
>>> +++ b/hw/vfio/meson.build
>>> @@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>>>   system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>>>   system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>>>     'cpr.c',
>>> +  'cpr-legacy.c',
>>>     'device.c',
>>>     'migration.c',
>>>     'migration-multifd.c',
>>> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
>>> index afc498d..21e5807 100644
>>> --- a/include/hw/vfio/vfio-container.h
>>> +++ b/include/hw/vfio/vfio-container.h
>>> @@ -10,6 +10,7 @@
>>>   #define HW_VFIO_CONTAINER_H
>>>   #include "hw/vfio/vfio-container-base.h"
>>> +#include "hw/vfio/vfio-cpr.h"
>>>   typedef struct VFIOContainer VFIOContainer;
>>>   typedef struct VFIODevice VFIODevice;
>>> @@ -29,6 +30,7 @@ typedef struct VFIOContainer {
>>>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>>       unsigned iommu_type;
>>>       QLIST_HEAD(, VFIOGroup) group_list;
>>> +    VFIOContainerCPR cpr;
>>>   } VFIOContainer;
>>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
>>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>>> index 750ea5b..f864547 100644
>>> --- a/include/hw/vfio/vfio-cpr.h
>>> +++ b/include/hw/vfio/vfio-cpr.h
>>> @@ -9,8 +9,22 @@
>>>   #ifndef HW_VFIO_VFIO_CPR_H
>>>   #define HW_VFIO_VFIO_CPR_H
>>> +#include "migration/misc.h"
>>> +
>>> +typedef struct VFIOContainerCPR {
>>> +    Error *blocker;
>>> +} VFIOContainerCPR;
>>> +
>>> +struct VFIOContainer;
>>>   struct VFIOContainerBase;
>>> +bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>> +                                        Error **errp);
>>> +void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
>>> +
>>> +int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
>>> +                             Error **errp);
>>> +
>>>   bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>>>                                    Error **errp);
>>>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>>
>> what about vfio_cpr_un/register_container ? Shouldn't we remove them ?
> 
> At this patch in the series, those are still used by iommufd containers.
> Those uses are removed in "vfio/iommufd: register container for cpr", and
> vfio_cpr_un/register_container are deleted by the last patch in the series.
> 
> - Steve
> 


