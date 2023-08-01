Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F59576B453
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 14:04:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQo6X-0000RL-7u; Tue, 01 Aug 2023 08:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQo6O-0000Fw-9L
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQo6L-0007Be-GI
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690891423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ud4YNlHwrHBRQoX9e52AehuAQabVEcpCaNoAZxmkZd0=;
 b=FdBQbPGfGaXWNdjvn+J3J6WZruBfkRx0dKFHLphFTb0Ru/KQELCj2n9+7lM3FYy0P2k2Ti
 OPUwtca5xFSPPpAW8elvmtvhZUgOEbd2FZE8jkfv/GfT5aoXpni1VFU29SnolKDYj+AO0X
 R5goP5t+Qj3EA85d6eP0Pvfs98lT5Q4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-3d0SzKLPOa66yYK6oNzxwQ-1; Tue, 01 Aug 2023 08:03:42 -0400
X-MC-Unique: 3d0SzKLPOa66yYK6oNzxwQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4053d10ee39so53828101cf.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 05:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690891422; x=1691496222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ud4YNlHwrHBRQoX9e52AehuAQabVEcpCaNoAZxmkZd0=;
 b=ZZZ4l8N+mh/5i8NUjLCqSiYDWOwsgpSRl3HPJwZNKkkM7WVQ26JN4rMsGov21wWNfD
 muFnosD6qPa66N2XV2E+j63vQ7G/WUljBPY1LL0o4Pd+wAgZ3iUk1ALnoxiEmpNblENU
 fle5/aLXarcsocLi0oYnduszbbGgJF3AjBZ+BdTG9CouGml32Mx5dOHnk29o+qKeVYi4
 yqQdvJd396I2JIz5n8V2ydLlvW1fnR9EFWG2kjksuHsJvgP5dgYs0ryDKeycysaEFx+S
 RyFeN8Zv0ZmfIfJy3SPNWOQylos0TmJFXnIfAW5ALJtzzh0SR7edQkmQ0ojLvE7fEeJK
 IVAA==
X-Gm-Message-State: ABy/qLZm8X800v3buvk0M3X1UuPceST2vbF1oXDRfrxjztQ3mHzLBUP6
 ZFGKPsQeaU3/jXYkqn8mMd4jhAFAy7n6XrFOAuRhaOVrZc9X27PflhvdP0i3Sh52tUVMEtUSVa4
 b6xcvAsGq5gb8wEs=
X-Received: by 2002:ac8:7fc4:0:b0:405:50fd:fcf1 with SMTP id
 b4-20020ac87fc4000000b0040550fdfcf1mr14876924qtk.1.1690891421865; 
 Tue, 01 Aug 2023 05:03:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFnnO4z8eU0v134QOAMCY7N7S+7T+AtHaMulrB76iQiJYvyQFMgYVkdmWC/RXQCTu9y0lsOtg==
X-Received: by 2002:ac8:7fc4:0:b0:405:50fd:fcf1 with SMTP id
 b4-20020ac87fc4000000b0040550fdfcf1mr14876874qtk.1.1690891421240; 
 Tue, 01 Aug 2023 05:03:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 he35-20020a05622a602300b0040fd47985e6sm497279qtb.97.2023.08.01.05.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 05:03:40 -0700 (PDT)
Message-ID: <f5e713f1-b465-8d36-ba7b-846a8c04f600@redhat.com>
Date: Tue, 1 Aug 2023 14:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 v2 6/6] vfio/migration: Allow migration of
 multiple P2P supporting devices
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230731102521.15335-1-avihaih@nvidia.com>
 <20230731102521.15335-7-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230731102521.15335-7-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/31/23 12:25, Avihai Horon wrote:
> Now that P2P support has been added to VFIO migration, allow migration
> of multiple devices if all of them support P2P migration.
> 
> Single device migration is allowed regardless of P2P migration support.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/common.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7c3d636025..8a8d074e18 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -363,21 +363,31 @@ bool vfio_mig_active(void)
>   
>   static Error *multiple_devices_migration_blocker;
>   
> -static unsigned int vfio_migratable_device_num(void)
> +/*
> + * Multiple devices migration is allowed only if all devices support P2P
> + * migration. Single device migration is allowed regardless of P2P migration
> + * support.
> + */
> +static bool vfio_multiple_devices_migration_is_supported(void)
>   {
>       VFIOGroup *group;
>       VFIODevice *vbasedev;
>       unsigned int device_num = 0;
> +    bool all_support_p2p = true;
>   
>       QLIST_FOREACH(group, &vfio_group_list, next) {
>           QLIST_FOREACH(vbasedev, &group->device_list, next) {
>               if (vbasedev->migration) {
>                   device_num++;
> +
> +                if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
> +                    all_support_p2p = false;
> +                }
>               }
>           }
>       }
>   
> -    return device_num;
> +    return all_support_p2p || device_num <= 1;
>   }
>   
>   int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
> @@ -385,19 +395,19 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>       int ret;
>   
>       if (multiple_devices_migration_blocker ||
> -        vfio_migratable_device_num() <= 1) {
> +        vfio_multiple_devices_migration_is_supported()) {
>           return 0;
>       }
>   
>       if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
> -        error_setg(errp, "Migration is currently not supported with multiple "
> -                         "VFIO devices");
> +        error_setg(errp, "Multiple VFIO devices migration is supported only if "
> +                         "all of them support P2P migration");
>           return -EINVAL;
>       }
>   
>       error_setg(&multiple_devices_migration_blocker,
> -               "Migration is currently not supported with multiple "
> -               "VFIO devices");
> +               "Multiple VFIO devices migration is supported only if all of "
> +               "them support P2P migration");
>       ret = migrate_add_blocker(multiple_devices_migration_blocker, errp);
>       if (ret < 0) {
>           error_free(multiple_devices_migration_blocker);
> @@ -410,7 +420,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>   void vfio_unblock_multiple_devices_migration(void)
>   {
>       if (!multiple_devices_migration_blocker ||
> -        vfio_migratable_device_num() > 1) {
> +        !vfio_multiple_devices_migration_is_supported()) {
>           return;
>       }
>   


