Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE86AB7F68
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 09:56:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTR4-0002Qb-12; Thu, 15 May 2025 03:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFTQm-0002Px-5M
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFTQj-0007Mk-Ne
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747295700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jNhroFD8zVIFGI6TZLUbNr939uDw8fIIVy37vbNfq5Q=;
 b=IY0bZ5PJEzQYQHQp9coGoaUZ467SPQHp9yvtKPAMjz4AaVpR8/UA3nELeWGwxfSr5MY3w5
 jaNz5bwcz3no03XEZQ6XGZ6wwdaXmtcIaM/7g8OAilwroC0j8iL225MRvR8s/iNkun/aTe
 Eo8EYKQfwTbnP+dXbGWUJj2xUDpB/xg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-2GI0GqUQP7-8Iu7oQr0G-w-1; Thu, 15 May 2025 03:54:59 -0400
X-MC-Unique: 2GI0GqUQP7-8Iu7oQr0G-w-1
X-Mimecast-MFC-AGG-ID: 2GI0GqUQP7-8Iu7oQr0G-w_1747295698
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a1fa8742a8so247193f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 00:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747295698; x=1747900498;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNhroFD8zVIFGI6TZLUbNr939uDw8fIIVy37vbNfq5Q=;
 b=ELRikANq0oUVqBHNLY0dCADMROOpffukFxTPfT9AiS5MPNSvSPfLMhrghvZIfJ2/ou
 5NhTpEfrFxgHog6/rOzT4jxPe/w51vzht1vENLFz7zNMOsRrA1ETEWEZbkGto0MLkXX6
 nIsVmPShvExfndqhtc+h6TFhtg29C7T7J/gSCb2cvf1uMJoesKK1ysoZV1LycsHaNebB
 Q16xpP765VoI00B4yCIwIdTKED4BLrXp3g+sfDmqfooE5h+wpZVHodJ4jgMJB6T3ugys
 fZnW8V7WQYqCaedCxlBnI0UD7CCz5jLIyalmQ4ThRiMCN7YXB2K7m5rWgupuXYi8OtHD
 wldQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaDyDF8OZlXjDOqsnzdIlE/wJLbUinykpU42njY+Rbs7kkDakh/KE9ZZ2s8QmOtljbKW1dRzPgzUOx@nongnu.org
X-Gm-Message-State: AOJu0Yy+uVIk9inqd27/nrb/ZljEd2YCtRTLvODh76Uy2ri/csi8pp7M
 6tf2WjBxlQhLqFxyyKI6PUz8JKhPGdQK34pbNMoudTp78ALIGfeik5l+HX2lrI3pJ2FKAkkT4lB
 wwckjz9Cqg+eLdQrYyGKG0wG2448buKCisBz3iDRCccSSALVGY66P
X-Gm-Gg: ASbGncsF11diclJiO4UH9NYPYtRJfOpymRfRlq0R6nQIQFXKedNixF8Et+s/7PqN8Gr
 gEaE0JQOgpI2G+UH6mlOIXtWZJaz5nLPDIV1Mh6hU2ZBULaXI7aZX5HATLtQ18JvGtdK1umZ7mW
 8uonKi6G7GbAUWL3jNreZGehqgDpi+QBgHpUNpv3lzd75v/kzs3e9AVMEw564EKGXpXHst3cBuu
 vTpHZJGCfxoqz3cDzGv76r9w0fa1EEQ+189Jw2jhMIbvWm4NbaCglmGkF2ZzvJzrPr3kUSw0Xu4
 5BkFeh+iCIFU7LC2MzVbNdbx1Nc6CouPtFbeYji4hAaAeYfbZQ==
X-Received: by 2002:a05:6000:2484:b0:3a1:fffe:6b6c with SMTP id
 ffacd0b85a97d-3a353749125mr1254473f8f.34.1747295697714; 
 Thu, 15 May 2025 00:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl9Y2fJPEEToyOtIeQdjraSsiCqrCRErs2T6O6db0nLtE0Fs1PPNBdDptpO/5G5PV+B5HhFQ==
X-Received: by 2002:a05:6000:2484:b0:3a1:fffe:6b6c with SMTP id
 ffacd0b85a97d-3a353749125mr1254449f8f.34.1747295697346; 
 Thu, 15 May 2025 00:54:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a3591e0c7fsm428633f8f.24.2025.05.15.00.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 00:54:56 -0700 (PDT)
Message-ID: <161947a0-f3fb-4ddb-b6c1-6e1a1e4d6849@redhat.com>
Date: Thu, 15 May 2025 09:54:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 06/42] vfio/container: register container for cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-7-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-7-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/12/25 17:32, Steve Sistare wrote:
> Register a legacy container for cpr-transfer, replacing the generic CPR
> register call with a more specific legacy container register call.  Add a
> blocker if the kernel does not support VFIO_UPDATE_VADDR or VFIO_UNMAP_ALL.
> 
> This is mostly boiler plate.  The fields to to saved and restored are added
> in subsequent patches.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/container.c              |  6 ++--
>   hw/vfio/cpr-legacy.c             | 70 ++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/cpr.c                    |  5 ++-
>   hw/vfio/meson.build              |  1 +
>   include/hw/vfio/vfio-container.h |  2 ++
>   include/hw/vfio/vfio-cpr.h       | 14 ++++++++
>   6 files changed, 92 insertions(+), 6 deletions(-)
>   create mode 100644 hw/vfio/cpr-legacy.c
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index eb56f00..85c76da 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -642,7 +642,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>       new_container = true;
>       bcontainer = &container->bcontainer;
>   
> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
> +    if (!vfio_legacy_cpr_register_container(container, errp)) {
>           goto fail;
>       }
>   
> @@ -678,7 +678,7 @@ fail:
>           vioc->release(bcontainer);
>       }
>       if (new_container) {
> -        vfio_cpr_unregister_container(bcontainer);
> +        vfio_legacy_cpr_unregister_container(container);
>           object_unref(container);
>       }
>       if (fd >= 0) {
> @@ -719,7 +719,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
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
> index 0000000..fac323c
> --- /dev/null
> +++ b/hw/vfio/cpr-legacy.c
> @@ -0,0 +1,70 @@
> +/*
> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.

Please add a SPDX-License-Identifier tag.


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
> +    .needed = cpr_needed_for_reuse,
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
> index 750ea5b..f864547 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -9,8 +9,22 @@
>   #ifndef HW_VFIO_VFIO_CPR_H
>   #define HW_VFIO_VFIO_CPR_H
>   
> +#include "migration/misc.h"
> +
> +typedef struct VFIOContainerCPR {
> +    Error *blocker;
> +} VFIOContainerCPR;
> +
> +struct VFIOContainer;
>   struct VFIOContainerBase;
>   
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

what about vfio_cpr_un/register_container ? Shouldn't we remove them ?


Thanks,

C.



