Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C92B78C52D
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayhs-00071u-NW; Tue, 29 Aug 2023 09:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qayhf-0006us-HR
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qayha-00047U-Fr
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693315453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ISps5/Ls1yoNb5vmk/Pt+B6X6FX6rA+zs10US2PUej0=;
 b=QW9jjsScSzeooRKs2EbclnbKGAFSv4i/6/LqfrMuSmtSglj07z2CzrQYh4a8DBqk7XlbKl
 qGyaQD7oZltSXP/1sggANq+gkmbo2qYGT0QS5l3IQEdFzadZFAmeszbXUOjzQyZKqYpByJ
 E9/kArs+ZFpc2vdDIfzFdUG2skr7LCM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-LS8ABNbMOIOCrXrjIurrUQ-1; Tue, 29 Aug 2023 09:24:11 -0400
X-MC-Unique: LS8ABNbMOIOCrXrjIurrUQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c89a09099so1734170f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693315450; x=1693920250;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ISps5/Ls1yoNb5vmk/Pt+B6X6FX6rA+zs10US2PUej0=;
 b=FrQsy0yq5okt0VkWVwc+zHqPc5CQz415gmsh07GHMtA8B6auiAW+SOgxysDZ6e4cRu
 4VoPu0Di4bnE1fc88ayfqXxr/Tr7xHO/kv71AfhrMjeiW7FabvXflvZsYoqdP5PGHMdt
 KZ4ecd3x51FfEeXYg/y+aDo0gNiHtlVxvRvg6VIEhJ/Yqf/paUZbYhvTltMrli9Y2ToK
 q8cbseX+QuYI6J3d6JmSGsOrowyLtrVqzTdld310uam+JWjUVTVO/OxuCHokwP6K6SuO
 p97KMAOn+U3tww5NJxYB0a1fKMbNGx04ZVYOFUf3u3+ZsgT9Bkv4YXvdbOcuN5khSo+b
 /YHw==
X-Gm-Message-State: AOJu0Yz9EEqzK30uzxtYb7c0C3xF7f/u/zxxwPw99WOSJGcxr6wwTRB0
 1Rt6MUb5YtBJc0uUbHxl+Ux6235s/VoMvjQkrTIEzafCgAhIC8JVTlEHLRdi9wdGjbM9FmilHmP
 hUNHT6waBRgZD+oM=
X-Received: by 2002:a5d:61d0:0:b0:317:5182:7b55 with SMTP id
 q16-20020a5d61d0000000b0031751827b55mr20310086wrv.42.1693315450408; 
 Tue, 29 Aug 2023 06:24:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmUrSYnmClcSRwtH/4er6iyOBhu5jaGjP39+UhkVMygL4jtABfy35RR4zkuauamv1OXlmiLA==
X-Received: by 2002:a5d:61d0:0:b0:317:5182:7b55 with SMTP id
 q16-20020a5d61d0000000b0031751827b55mr20310071wrv.42.1693315450052; 
 Tue, 29 Aug 2023 06:24:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a5d664a000000b0031c79de4d8bsm13751888wrw.106.2023.08.29.06.24.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 06:24:09 -0700 (PDT)
Message-ID: <5115bdd4-c8db-4dfc-fad2-5b1d6badafba@redhat.com>
Date: Tue, 29 Aug 2023 15:24:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] vfio/migration: Add vfio_migratable_devices_num()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-4-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230828151842.11303-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 8/28/23 17:18, Avihai Horon wrote:
> Add vfio_migratable_devices_num() function, which returns the number of
> VFIO devices that are using VFIO migration, and use it in
> vfio_multiple_devices_migration_is_supported().
> 
> This is done in preparation for next patches which will block VFIO
> migration with postcopy migration or background snapshot, as they are
> not compatible together.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/common.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 237101d038..57a76feab1 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -363,6 +363,23 @@ bool vfio_mig_active(void)
>   
>   static Error *multiple_devices_migration_blocker;
>   
> +static unsigned int vfio_migratable_devices_num(void)
> +{
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +    unsigned int device_num = 0;
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if (vbasedev->migration) {
> +                device_num++;
> +            }
> +        }
> +    }
> +
> +    return device_num;
> +}
> +
>   /*
>    * Multiple devices migration is allowed only if all devices support P2P
>    * migration. Single device migration is allowed regardless of P2P migration
> @@ -372,14 +389,11 @@ static bool vfio_multiple_devices_migration_is_supported(void)
>   {
>       VFIOGroup *group;
>       VFIODevice *vbasedev;
> -    unsigned int device_num = 0;
>       bool all_support_p2p = true;
>   
>       QLIST_FOREACH(group, &vfio_group_list, next) {
>           QLIST_FOREACH(vbasedev, &group->device_list, next) {
>               if (vbasedev->migration) {
> -                device_num++;
> -
>                   if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
>                       all_support_p2p = false;
>                   }
> @@ -387,7 +401,7 @@ static bool vfio_multiple_devices_migration_is_supported(void)
>           }
>       }
>   
> -    return all_support_p2p || device_num <= 1;
> +    return all_support_p2p || vfio_migratable_devices_num() <= 1;
>   }
>   
>   int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)


