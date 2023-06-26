Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC8573E077
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:20:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDm8h-0007UY-Lo; Mon, 26 Jun 2023 09:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qDm8d-0007Ts-E5
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qDm8b-0006eI-Gy
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687785611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SIHcRSu5RS08qxVIJkI2u2EDrCC22Bh55Dd5dt/Czw=;
 b=GVP0iDVz6HgxeCN2BLbShTjkuIvBT7BEeHKKbquV7PPnE3jG+32YJpA8jde59fxrTzJm81
 /WGgMO4tORFzfWVclhRLwjylngoruXkAaaHEmbofWvxhzQEsZ3RTjW74RA40ptghSjMqZL
 +tG/EGh2/gzmFLypqFcr5QyKcgMTSkU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-28H_1zcdNaSiwL-9pOFFXA-1; Mon, 26 Jun 2023 09:20:09 -0400
X-MC-Unique: 28H_1zcdNaSiwL-9pOFFXA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-39eced1ce28so2858009b6e.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687785609; x=1690377609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5SIHcRSu5RS08qxVIJkI2u2EDrCC22Bh55Dd5dt/Czw=;
 b=RzXRCQlns8JMTul9x5Z0dVb0aD8ImfEU5oYGTGdM/9vy8zEM9zqMY1NG0O1XCGhIEq
 QrOP0kWjn8Njwz7DmVbtElfTL8vXvlyAuxbl5IPcsNqpwpStd77ZmTgcjaFQd9YsSteA
 OhzGWbRFm3kdtQV1lVI+N9XJgQnCnmiPfniO+YdjKEbjpwyORRknUErLkYJdSJ9Z4RWT
 uKZZel+eg/2h6yWP9ZbbEvW5EsmCOpSLLnOZieCOJLvM1Aa4epOEcJ2pYv1IMz9kkdZS
 0Kdwskht6lOs6pF0LznMm1Vy3ldJ1JFxWyQB8z4fuxd7V4kLcvBHz240sGoI1gl9PNzp
 wMzA==
X-Gm-Message-State: AC+VfDzOvYGeKjrT2nGGwxijEep2EOBEPR7ZQccF3Jp3bYXSoYH3pgXE
 zo3+IxbzhtnuFhWZi/7crqXwPBtID5Qg959+Chkm5QLFFa3Zk+wJteCMWu2oLk5RK1wP84OE8RH
 89lc6d45JjxcUsFT6+1/4MJ8=
X-Received: by 2002:a05:6808:f12:b0:399:169:75d4 with SMTP id
 m18-20020a0568080f1200b00399016975d4mr30096083oiw.36.1687785608870; 
 Mon, 26 Jun 2023 06:20:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hibKouGLVQB3koiCawODqYIm2rOjTmxf04RwHxU/zSQdZysFWy4Mf821oqgqkThFAZk9MgA==
X-Received: by 2002:a05:6808:f12:b0:399:169:75d4 with SMTP id
 m18-20020a0568080f1200b00399016975d4mr30096060oiw.36.1687785608631; 
 Mon, 26 Jun 2023 06:20:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 fa14-20020a05622a4cce00b003ff1f891206sm3025259qtb.61.2023.06.26.06.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 06:20:08 -0700 (PDT)
Message-ID: <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
Date: Mon, 26 Jun 2023 15:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-4-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230626082353.18535-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Avihai,

On 6/26/23 10:23, Avihai Horon wrote:
> The major parts of VFIO migration are supported today in QEMU. This
> includes basic VFIO migration, device dirty page tracking and precopy
> support.
> 
> Thus, at this point in time, it seems appropriate to make VFIO migration
> non-experimental: remove the x prefix from enable_migration property,
> change it to ON_OFF_AUTO and let the default value be AUTO.
> 
> In addition, make the following adjustments:
> 1. Require device dirty tracking support when enable_migration is AUTO
>     (i.e., not explicitly enabled). This is because device dirty tracking
>     is currently the only method to do dirty page tracking, which is
>     essential for migrating in a reasonable downtime. 

hmm, I don't think QEMU should decide to disable a feature for all
devices supposedly because it could be slow for some. That's too
restrictive. What about devices with have small states ? for which
the downtime would be reasonable even without device dirty tracking
support.


> Setting
>     enable_migration to ON will not require device dirty tracking.
> 2. Make migration blocker messages more elaborate.
> 3. Remove error prints in vfio_migration_query_flags().
> 4. Remove a redundant assignment in vfio_migration_realize().
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   include/hw/vfio/vfio-common.h |  2 +-
>   hw/vfio/migration.c           | 29 ++++++++++++++++-------------
>   hw/vfio/pci.c                 |  4 ++--
>   3 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b4c28f318f..387eabde60 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -139,7 +139,7 @@ typedef struct VFIODevice {
>       bool needs_reset;
>       bool no_mmap;
>       bool ram_block_discard_allowed;
> -    bool enable_migration;
> +    OnOffAuto enable_migration;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
>       unsigned int num_regions;
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 79eb81dfd7..d8e0848635 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -731,14 +731,6 @@ static int vfio_migration_query_flags(VFIODevice *vbasedev, uint64_t *mig_flags)
>       feature->argsz = sizeof(buf);
>       feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIGRATION;
>       if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> -        if (errno == ENOTTY) {
> -            error_report("%s: VFIO migration is not supported in kernel",
> -                         vbasedev->name);
> -        } else {
> -            error_report("%s: Failed to query VFIO migration support, err: %s",
> -                         vbasedev->name, strerror(errno));
> -        }
> -
>           return -errno;
>       }
>   
> @@ -831,14 +823,28 @@ void vfio_reset_bytes_transferred(void)
>   
>   int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>   {
> -    int ret = -ENOTSUP;
> +    int ret;
>   
> -    if (!vbasedev->enable_migration) {
> +    if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
> +        error_setg(&vbasedev->migration_blocker,
> +                   "%s: Migration is disabled for VFIO device", vbasedev->name);
>           goto add_blocker;
>       }
>   
>       ret = vfio_migration_init(vbasedev);
>       if (ret) {

It would be good to keep the message for 'errno == ENOTTY' as it was in
vfio_migration_query_flags(). When migration fails, it is an important
information to know that it is because the VFIO PCI host device driver
doesn't support the feature. The root cause could be deep below in FW or
how the VF was set up.

> +        error_setg(&vbasedev->migration_blocker,
> +                   "%s: Migration couldn't be initialized for VFIO device, "
> +                   "err: %d (%s)",
> +                   vbasedev->name, ret, strerror(-ret));
> +        goto add_blocker;
> +    }
> +
> +    if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO &&
> +        !vbasedev->dirty_pages_supported) {

I don't agree with this test.

> +        error_setg(&vbasedev->migration_blocker,
> +                   "%s: VFIO device doesn't support device dirty tracking",
> +                   vbasedev->name);
>           goto add_blocker;
>       }
I agree that with ON_OFF_AUTO_AUTO, errors at realize time should be recorded
in a migration blocker. What about the ON_OFF_AUTO_ON case ? If migration was
explicitly requested for the device and the conditions on the host are not met,
I think realize should fail and the machine abort.

Thanks,

C.



> @@ -856,9 +862,6 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>       return 0;
>   
>   add_blocker:
> -    error_setg(&vbasedev->migration_blocker,
> -               "VFIO device doesn't support migration");
> -
>       ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
>       if (ret < 0) {
>           error_free(vbasedev->migration_blocker);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 73874a94de..48584e3b01 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3347,8 +3347,8 @@ static Property vfio_pci_dev_properties[] = {
>                       VFIO_FEATURE_ENABLE_REQ_BIT, true),
>       DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
> -    DEFINE_PROP_BOOL("x-enable-migration", VFIOPCIDevice,
> -                     vbasedev.enable_migration, false),
> +    DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
> +                            vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>       DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>                        vbasedev.ram_block_discard_allowed, false),


