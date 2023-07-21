Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BB275C5EA
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 13:34:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMoOB-0005Ot-FQ; Fri, 21 Jul 2023 07:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qMoO4-0005Jk-3V
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 07:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qMoNt-0006Ab-Q3
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 07:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689939199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bwJlr2jMfVqeziDto3ZEvvdFmjSVQrI6o0L2eW4FA8=;
 b=dqQOL8mJhbQumBOA9Sr5byId68MAW5mvBCCNMrKNGeRgNicr7HDw/n42K1G9WuNVOb/8mc
 s/gJbSzJz0be79Ny2Lm942rmdv1ZfxNSxcQLnGfR8HfdtLUFvtwarr4t1V2Lz3ibo6xqzU
 ywliI5bZRGbxAKYHyuJsIyAYwoMkehI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-78Uoy310P16jCmt1Ya32sg-1; Fri, 21 Jul 2023 07:33:17 -0400
X-MC-Unique: 78Uoy310P16jCmt1Ya32sg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31429e93f26so1068364f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 04:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689939196; x=1690543996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4bwJlr2jMfVqeziDto3ZEvvdFmjSVQrI6o0L2eW4FA8=;
 b=jFwIqwj6VDCB9uC1gjuhTWVptVopiFMxvgNHxG4uHHWQeAMUjDePg48lehk7V6S13s
 26CaSvA6M+jVkgGFjAaVjWUHdys1nM4hBEdmY9JaaO7/G0B8hdSp+TUPkf9/w1b/KwEQ
 dCoHOsTdNHtJemT3rKiy7KfVyW3qN3NBBt1nSCl1WNADxTj2XngpiZbQgGQD9GL3age+
 txp8tDVZiw5dqNhfuKOYdtpevlZA2LHayLTfGYCw896qZsX+KqqBLMwdplIUGIT4nZdw
 PpZQKZgKcuJajNEmwBJtid/ihU9peK1iVBTZIC6zGOjSxul4f4aKdQm3CbGijlTGTtoj
 qrAA==
X-Gm-Message-State: ABy/qLbMQUlhLZY2+4Lo1wlEUCCrDACdWkxlp/JKuwHDvnvdxrvuth2Y
 e0Oc92A8o6beq1QdkR3d2sX2SfkMQIvJG3p3kJ39tRfhQFr7+NakmNtOu/ZmHV6wDJxe6dV9wW3
 UAP0QiuckviCttYI=
X-Received: by 2002:adf:f04c:0:b0:314:12c:4322 with SMTP id
 t12-20020adff04c000000b00314012c4322mr1226675wro.4.1689939196465; 
 Fri, 21 Jul 2023 04:33:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE1V+gb2ahkcgzZ2gYvcUWPwwaJLbcsj4mSlyszhtQlkRCn1XwFmqdR/UbG8B2MmGcuEWkn9Q==
X-Received: by 2002:adf:f04c:0:b0:314:12c:4322 with SMTP id
 t12-20020adff04c000000b00314012c4322mr1226665wro.4.1689939196158; 
 Fri, 21 Jul 2023 04:33:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:9283:b79f:cbb3:327a?
 ([2a01:e0a:9e2:9000:9283:b79f:cbb3:327a])
 by smtp.gmail.com with ESMTPSA id
 r15-20020adff70f000000b003143ba62cf4sm3936940wrp.86.2023.07.21.04.33.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 04:33:15 -0700 (PDT)
Message-ID: <055a933f-96a1-949d-7a71-476312048f4e@redhat.com>
Date: Fri, 21 Jul 2023 13:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 4/6] vfio/migration: Refactor PRE_COPY and RUNNING
 state checks
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
 <20230716081541.27900-5-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230716081541.27900-5-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/16/23 10:15, Avihai Horon wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> Move the PRE_COPY and RUNNING state checks to helper functions.
> 
> This is in preparation for adding P2P VFIO migration support, where
> these helpers will also test for PRE_COPY_P2P and RUNNING_P2P states.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h |  2 ++
>   hw/vfio/common.c              | 22 ++++++++++++++++++----
>   hw/vfio/migration.c           | 10 ++++------
>   3 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index da43d27352..e9b8954595 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -230,6 +230,8 @@ void vfio_unblock_multiple_devices_migration(void);
>   bool vfio_viommu_preset(VFIODevice *vbasedev);
>   int64_t vfio_mig_bytes_transferred(void);
>   void vfio_reset_bytes_transferred(void);
> +bool vfio_device_state_is_running(VFIODevice *vbasedev);
> +bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>   
>   #ifdef CONFIG_LINUX
>   int vfio_get_region_info(VFIODevice *vbasedev, int index,
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 9aac21abb7..16cf79a76c 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -437,6 +437,20 @@ static void vfio_set_migration_error(int err)
>       }
>   }
>   
> +bool vfio_device_state_is_running(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return migration->device_state == VFIO_DEVICE_STATE_RUNNING;
> +}
> +
> +bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
> +}
> +
>   static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>   {
>       VFIOGroup *group;
> @@ -457,8 +471,8 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>               }
>   
>               if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
> -                (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
> -                 migration->device_state == VFIO_DEVICE_STATE_PRE_COPY)) {
> +                (vfio_device_state_is_running(vbasedev) ||
> +                 vfio_device_state_is_precopy(vbasedev))) {
>                   return false;
>               }
>           }
> @@ -503,8 +517,8 @@ static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
>                   return false;
>               }
>   
> -            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
> -                migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
> +            if (vfio_device_state_is_running(vbasedev) ||
> +                vfio_device_state_is_precopy(vbasedev)) {
>                   continue;
>               } else {
>                   return false;
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 8acd182a8b..48f9c23cbe 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -411,7 +411,7 @@ static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
>   
> -    if (migration->device_state != VFIO_DEVICE_STATE_PRE_COPY) {
> +    if (!vfio_device_state_is_precopy(vbasedev)) {
>           return;
>       }
>   
> @@ -444,7 +444,7 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>       *must_precopy += stop_copy_size;
>   
> -    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
> +    if (vfio_device_state_is_precopy(vbasedev)) {
>           vfio_query_precopy_size(migration);
>   
>           *must_precopy +=
> @@ -459,9 +459,8 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
>   static bool vfio_is_active_iterate(void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> -    VFIOMigration *migration = vbasedev->migration;
>   
> -    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
> +    return vfio_device_state_is_precopy(vbasedev);
>   }
>   
>   static int vfio_save_iterate(QEMUFile *f, void *opaque)
> @@ -656,7 +655,6 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>   static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>   {
>       VFIODevice *vbasedev = opaque;
> -    VFIOMigration *migration = vbasedev->migration;
>       enum vfio_device_mig_state new_state;
>       int ret;
>   
> @@ -664,7 +662,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>           new_state = VFIO_DEVICE_STATE_RUNNING;
>       } else {
>           new_state =
> -            (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY &&
> +            (vfio_device_state_is_precopy(vbasedev) &&
>                (state == RUN_STATE_FINISH_MIGRATE || state == RUN_STATE_PAUSED)) ?
>                   VFIO_DEVICE_STATE_STOP_COPY :
>                   VFIO_DEVICE_STATE_STOP;


