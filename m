Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0D7745F3D
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 16:59:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGL0k-0000ir-H4; Mon, 03 Jul 2023 10:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGL0f-0000ib-C0
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGL0d-00026i-OI
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688396315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2B6JrWop4ALPKBcxZO89zS9woHR7gO1WSUvKPwZDiaY=;
 b=bPfgdh5YEZYFld1YBKHT4b6pKKsXuckX2zQtMC5cWJ9wof72UZK5YC4Wcy9YpOLPIpkJ4s
 l5BJHJik6ZJNt/Fo3gtFyxrSpnR2rTZX7w7QS2D0CQ8L3moos4si+SpRzSx4MQDpMPhLAA
 JV9y/1AKj222Drol/DW4KOl4I5ElW8s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-ixEK9soAM9G-EMuyUgbfNQ-1; Mon, 03 Jul 2023 10:58:33 -0400
X-MC-Unique: ixEK9soAM9G-EMuyUgbfNQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-763a36c3447so389436185a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 07:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688396313; x=1690988313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2B6JrWop4ALPKBcxZO89zS9woHR7gO1WSUvKPwZDiaY=;
 b=LpRZVy66QSkkzozCSxjGOyZGlUZYQYSTq9Yk+xM7yvmIm9bKNu3FT2Je5BiT6Ql3fE
 HYR+bK9C0ZhtfCFpFZYXiHf6Ycf+b2cfE7MGWDXhUXGLDFSTjkY+1lQKvx0mzuJ4z+y/
 +Vd8GNRgEwYlvthe/XFk2n+pnjC2gf2Gm56J8OTnqfWmE3VMHO2HLUVrZtCKUrpqw8Bk
 M6OZXySvm5RsyzKRjMoRvnU4jLCwFCDnKfFTRiCxFLrl+tnH7nBAvCQkCdocdQbJ5C1X
 XiRmPGoUyAIhyZql9walDicZElRQIurkG8y8ilUOPRuu5cik9CwoptvmXwvVt/yYKtjt
 QXMA==
X-Gm-Message-State: ABy/qLbCXKpLh7D1fytjhyg6nWZmZT7XvnMj5Ck4IrXk/5OxbHuzDnxW
 zbzyIYVu2NGgKSmwQ/hbEU1kJi6KAjGN7YqJ1+ockLCujIobhcTNxdtJtidMXaSHpxIeK6WhmLJ
 p+kHnCg5hddfDj3HwT7PjOG4=
X-Received: by 2002:a05:620a:2983:b0:767:5558:f21d with SMTP id
 r3-20020a05620a298300b007675558f21dmr8894641qkp.38.1688396313046; 
 Mon, 03 Jul 2023 07:58:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF5mM9JswfAVPXrtpr3XTihjhFnrAq/TOqvXY9z18SHPu2h8WtMsk5BFyEjgqVn8Qj1mWXwGQ==
X-Received: by 2002:a05:620a:2983:b0:767:5558:f21d with SMTP id
 r3-20020a05620a298300b007675558f21dmr8894622qkp.38.1688396312768; 
 Mon, 03 Jul 2023 07:58:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 h18-20020a05620a10b200b00763a3e5f80dsm8666537qkk.15.2023.07.03.07.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 07:58:32 -0700 (PDT)
Message-ID: <971304fa-325a-7b3f-fec8-c53db0df78e8@redhat.com>
Date: Mon, 3 Jul 2023 16:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 7/7] vfio/migration: Return bool type for
 vfio_migration_realize()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
 <20230703071510.160712-6-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230703071510.160712-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/3/23 09:15, Zhenzhong Duan wrote:
> Make vfio_migration_realize() adhere to the convention of other realize()
> callbacks(like qdev_realize) by returning bool instead of int.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration.c           | 15 ++++++++++-----
>   hw/vfio/pci.c                 |  3 +--
>   include/hw/vfio/vfio-common.h |  2 +-
>   3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index e3954570c853..2674f4bc472d 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -846,7 +846,12 @@ void vfio_reset_bytes_transferred(void)
>       bytes_transferred = 0;
>   }
>   
> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
> +/*
> + * Return true when either migration initialized or blocker registered.
> + * Currently only return false when adding blocker fails which will
> + * de-register vfio device.
> + */
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>   {
>       Error *err = NULL;
>       int ret;
> @@ -854,7 +859,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>       if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
>           error_setg(&err, "%s: Migration is disabled for VFIO device",
>                      vbasedev->name);
> -        return vfio_block_migration(vbasedev, err, errp);
> +        return !vfio_block_migration(vbasedev, err, errp);
>       }
>   
>       ret = vfio_migration_init(vbasedev);
> @@ -869,7 +874,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>                          vbasedev->name, ret, strerror(-ret));
>           }
>   
> -        return vfio_block_migration(vbasedev, err, errp);
> +        return !vfio_block_migration(vbasedev, err, errp);
>       }
>   
>       if (!vbasedev->dirty_pages_supported) {
> @@ -896,7 +901,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>       }
>   
>       trace_vfio_migration_realize(vbasedev->name);
> -    return 0;
> +    return true;
>   
>   add_blocker:
>       ret = vfio_block_migration(vbasedev, err, errp);
> @@ -904,7 +909,7 @@ out_deinit:
>       if (ret) {
>           vfio_migration_deinit(vbasedev);
>       }
> -    return ret;
> +    return !ret;
>   }
>   
>   void vfio_migration_exit(VFIODevice *vbasedev)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index eefd4ec330d9..68dd99283620 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3207,8 +3207,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       }
>   
>       if (!pdev->failover_pair_id) {
> -        ret = vfio_migration_realize(vbasedev, errp);
> -        if (ret) {
> +        if (!vfio_migration_realize(vbasedev, errp)) {
>               goto out_deregister;
>           }
>       }
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 45167c8a8a54..da43d273524e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -252,7 +252,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>   int vfio_spapr_remove_window(VFIOContainer *container,
>                                hwaddr offset_within_address_space);
>   
> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>   void vfio_migration_exit(VFIODevice *vbasedev);
>   
>   #endif /* HW_VFIO_VFIO_COMMON_H */


