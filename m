Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC19AC9EFC
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Jun 2025 17:23:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkVv-0000zH-5P; Sun, 01 Jun 2025 11:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLkVM-0000xt-QW
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLkVK-0004IB-9W
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vvOr2JqV64zoJ5HFHvmLgU2DAnQILOVX54/ayG1fFmk=;
 b=d7Mq+kilrXKqbaRTiq5WdH/aysSmVnrxJPfAO5o1kGFaMdGvcbL7MaKuumrAWI9YvrGHPW
 IMpMYie33Ou4uc/LeZunDb660hE1Wgymf5jy4ZEaxeMGeedlNkYJ7AheVYONUdXtSo717S
 UnZRmilfwChXgPTsw10PCe+DONy4tBY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-5fV3VqCqNo6Al77DWo8ibQ-1; Sun, 01 Jun 2025 11:21:36 -0400
X-MC-Unique: 5fV3VqCqNo6Al77DWo8ibQ-1
X-Mimecast-MFC-AGG-ID: 5fV3VqCqNo6Al77DWo8ibQ_1748791296
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so2318215e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791295; x=1749396095;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvOr2JqV64zoJ5HFHvmLgU2DAnQILOVX54/ayG1fFmk=;
 b=vmfL9wG3xMkqj7JfYEb9nBV+fEX2VpdO2P2suxF9lR3D61xvyuj29XnxCtajogyME4
 LNk17AZhRO+l1KONqIughbzTMzVXoqVXpqogroD1/KpzsqTXLXwJwC4Ku/RfNiaI+hL4
 YhOU7+dcfDp5T8BabDt/sAoVoceNWxYMwusOKuXsp3YGvfw6hjJJ2Rw7l4MireRCt5kc
 x8ALh9kLxzBjJRfeP3J56Qpg7Gc9jGObwX6fp86BpyPlXvmYZokiojj43CMcWHzfyO2f
 Hr1cO3eVVoQpKhAQh+PCMOqd2BTkwhEOdI6DTATAvCEnS6VRtG+UB+1ZP11q4ycZ91Lh
 n17w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg9reaMVLJV0a2NSuK8o8KEmyizyFR43/WPY7go5apfA7KxiftbaAWJ0lnfhDruS+Be8RYWMUNDMvb@nongnu.org
X-Gm-Message-State: AOJu0YysrqvmdCOM+ePhb7Yo7PrrUof5MwPCRZROs1VojqjSOCdpgE4w
 K0m2qfxCqlAmSC1As75RHKky6hII8YnNaCVhyZ2IGgN3iIvxlPG9esTS64leb1if1ZFVDEq/SLZ
 vcz4vIzD4syLIj6FzVewMTxiprVzkRiBZzwoc4WM17/dMDOLOCt4lDwgi
X-Gm-Gg: ASbGncu8rmDvbTGPK+VlHPdSV9PDCl18TI8Mzi9JE2zTXTAo+zpxuhWpvQ0Zw8OW+TU
 mj0PF4Cy+6Ctx5MSil1tilarjH0Dlp7Ieak/NU/UISwDuoKTOyWhttNo2B6nbEMAaAcVtSRfwvP
 BgkCyUJ3AFs/EL2d+p6BraD4MIFTD04V5cQAvlVSbLUOtTvs+W7MO8Axybix60Lwgdu7rM0BLS+
 4zjUWF43wCiFrgamDWJTs2Z1kgY4yV58DkEQLSWX8rJ/1YpmKXpZEQRM5+tzQFofayzM/VERJl+
 smWyiyl6uEd146Wqm9CseqPfHlhvlAtAD56PQwG9dQIec3kFnw==
X-Received: by 2002:a05:6000:2886:b0:3a3:67bb:8f46 with SMTP id
 ffacd0b85a97d-3a4f89eadcemr7465234f8f.57.1748791295460; 
 Sun, 01 Jun 2025 08:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYKMQj3w6SUk9vXEgHxhyIJUssYicyIPR2LtWlLPmtoyBNkvD8lna2chOkjRmqWcbNHaJMMA==
X-Received: by 2002:a05:6000:2886:b0:3a3:67bb:8f46 with SMTP id
 ffacd0b85a97d-3a4f89eadcemr7465208f8f.57.1748791295016; 
 Sun, 01 Jun 2025 08:21:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm11573252f8f.42.2025.06.01.08.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 08:21:33 -0700 (PDT)
Message-ID: <bc043fc9-6bc7-4954-a514-8665dd7c7c31@redhat.com>
Date: Sun, 1 Jun 2025 17:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 09/43] vfio/container: register container for cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-10-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-10-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/29/25 21:24, Steve Sistare wrote:
> Register a legacy container for cpr-transfer, replacing the generic CPR
> register call with a more specific legacy container register call.  Add a
> blocker if the kernel does not support VFIO_UPDATE_VADDR or VFIO_UNMAP_ALL.
> 
> This is mostly boiler plate.  The fields to to saved and restored are added
> in subsequent patches.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-container.h |  2 ++
>   include/hw/vfio/vfio-cpr.h       | 15 +++++++++
>   hw/vfio/container.c              |  6 ++--
>   hw/vfio/cpr-legacy.c             | 69 ++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/cpr.c                    |  5 ++-
>   hw/vfio/meson.build              |  1 +
>   6 files changed, 92 insertions(+), 6 deletions(-)
>   create mode 100644 hw/vfio/cpr-legacy.c
> 
> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
> index afc498d..21e5807 100644
> --- a/include/hw/vfio/vfio-container.h
> +++ b/include/hw/vfio/vfio-container.h
> @@ -10,6 +10,7 @@
>   #define HW_VFIO_CONTAINER_H
>   
>   #include "hw/vfio/vfio-container-base.h"
> +#include "hw/vfio/vfio-cpr.h"
>   
>   typedef struct VFIOContainer VFIOContainer;
>   typedef struct VFIODevice VFIODevice;
> @@ -29,6 +30,7 @@ typedef struct VFIOContainer {
>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>       unsigned iommu_type;
>       QLIST_HEAD(, VFIOGroup) group_list;
> +    VFIOContainerCPR cpr;
>   } VFIOContainer;
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 750ea5b..d4e0bd5 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -9,8 +9,23 @@
>   #ifndef HW_VFIO_VFIO_CPR_H
>   #define HW_VFIO_VFIO_CPR_H
>   
> +#include "migration/misc.h"
> +
> +struct VFIOContainer;
>   struct VFIOContainerBase;
>   
> +typedef struct VFIOContainerCPR {
> +    Error *blocker;
> +} VFIOContainerCPR;
> +
> +
> +bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
> +                                        Error **errp);
> +void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
> +
> +int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
> +                             Error **errp);
> +
>   bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>                                    Error **errp);
>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 0f948d0..7d2035c 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -643,7 +643,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>       new_container = true;
>       bcontainer = &container->bcontainer;
>   
> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
> +    if (!vfio_legacy_cpr_register_container(container, errp)) {
>           goto fail;
>       }
>   
> @@ -679,7 +679,7 @@ fail:
>           vioc->release(bcontainer);
>       }
>       if (new_container) {
> -        vfio_cpr_unregister_container(bcontainer);
> +        vfio_legacy_cpr_unregister_container(container);
>           object_unref(container);
>       }
>       if (fd >= 0) {
> @@ -720,7 +720,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>           VFIOAddressSpace *space = bcontainer->space;
>   
>           trace_vfio_container_disconnect(container->fd);
> -        vfio_cpr_unregister_container(bcontainer);
> +        vfio_legacy_cpr_unregister_container(container);
>           close(container->fd);
>           object_unref(container);
>   
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> new file mode 100644
> index 0000000..419b9fb
> --- /dev/null
> +++ b/hw/vfio/cpr-legacy.c
> @@ -0,0 +1,69 @@
> +/*
> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <sys/ioctl.h>
> +#include <linux/vfio.h>
> +#include "qemu/osdep.h"
> +#include "hw/vfio/vfio-container.h"
> +#include "hw/vfio/vfio-cpr.h"
> +#include "migration/blocker.h"
> +#include "migration/cpr.h"
> +#include "migration/migration.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +
> +static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
> +{
> +    if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
> +        error_setg(errp, "VFIO container does not support VFIO_UPDATE_VADDR");
> +        return false;
> +
> +    } else if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL)) {
> +        error_setg(errp, "VFIO container does not support VFIO_UNMAP_ALL");
> +        return false;
> +
> +    } else {
> +        return true;
> +    }
> +}
> +
> +static const VMStateDescription vfio_container_vmstate = {
> +    .name = "vfio-container",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .needed = cpr_incoming_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    Error **cpr_blocker = &container->cpr.blocker;
> +
> +    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
> +                                vfio_cpr_reboot_notifier,
> +                                MIG_MODE_CPR_REBOOT);
> +
> +    if (!vfio_cpr_supported(container, cpr_blocker)) {
> +        return migrate_add_blocker_modes(cpr_blocker, errp,
> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
> +    }
> +
> +    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
> +
> +    return true;
> +}
> +
> +void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +
> +    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
> +    migrate_del_blocker(&container->cpr.blocker);
> +    vmstate_unregister(NULL, &vfio_container_vmstate, container);
> +}
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 0210e76..0e59612 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -7,13 +7,12 @@
>   
>   #include "qemu/osdep.h"
>   #include "hw/vfio/vfio-device.h"
> -#include "migration/misc.h"
>   #include "hw/vfio/vfio-cpr.h"
>   #include "qapi/error.h"
>   #include "system/runstate.h"
>   
> -static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
> -                                    MigrationEvent *e, Error **errp)
> +int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
> +                             MigrationEvent *e, Error **errp)
>   {
>       if (e->type == MIG_EVENT_PRECOPY_SETUP &&
>           !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index bccb050..73d29f9 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>   system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>   system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>     'cpr.c',
> +  'cpr-legacy.c',
>     'device.c',
>     'migration.c',
>     'migration-multifd.c',


