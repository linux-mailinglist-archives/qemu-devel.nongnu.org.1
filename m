Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D3C715A25
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:29:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vet-0002J9-8w; Tue, 30 May 2023 05:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3ver-0002IW-Nh
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3vep-0006vE-DO
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685438926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTpb8Xq/JfVKOWB7ZfD4rHuvVvaEDz5SbTpGP1fCtVI=;
 b=DTJX5QgCql3ZbZ6qyJ4fKLJQcA1Mh4jj8p2SjPfdm0W/p4R9TQ39MoaqcEyLaEqGnGm9oD
 VHEWitdB1AbVobVff/lskvM4G2Z9U2awA4mNQKsdltbUxGRRSHM4EnUKX+bfSvn60wOtxh
 3SsVRhvV4G5fWYCit+52O6jVwDWbNGo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-Fnr_z1MdNiO6k1LmSv3Nng-1; Tue, 30 May 2023 05:28:45 -0400
X-MC-Unique: Fnr_z1MdNiO6k1LmSv3Nng-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f70f9995aeso1500845e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 02:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685438924; x=1688030924;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rTpb8Xq/JfVKOWB7ZfD4rHuvVvaEDz5SbTpGP1fCtVI=;
 b=BI41LoJYn4LJZcSNfsU0bwDaYrQvxrMfluGCggoYR4/yz2KRjPFg44G0tr593lS0Dt
 JT7PXfy9nypFVrmH1IcF3GAWgPGbXqhcfDO0thPWkj7m5h2kAs65xZuwmuSHrpigKMJ2
 BD2SfgBR8NJQwZ5R8wkwtG1XBK/3CoDTgwGGATEGh4A5lom0SGxn6hZf60tPsb9bbDBb
 lUDrCXMYRxd9+aE/1WYIsRJZwumjnLXnPH80bprro6nCyuLj8P87s8jGYRx/tKz4YM1q
 IdvIqLNDqGyQUXzlzCe4i+8zJ8Mg3+KA8x2xPQaVk5XCelbRgMszFEdfyIKV9cC1KQPs
 mBsg==
X-Gm-Message-State: AC+VfDwx6xFG/SiylysbFvc8NHfQzd3g4CE9lJ2UnarvaJHzOxMHtK0H
 UF/EC+DB5PNNbptQCy0JP62t2/5wzpwaFl1xoeyfFPjF4vpszlWcisTXIg4Sp15mul1+sgeq5Vy
 XcqQLu/ELxUu7EOE=
X-Received: by 2002:adf:e6cd:0:b0:2cb:2775:6e6 with SMTP id
 y13-20020adfe6cd000000b002cb277506e6mr1163129wrm.45.1685438923817; 
 Tue, 30 May 2023 02:28:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4vmIGFbq0J3CKV7tr9sZjyvlyReUEiDvoHkUANbhDo63b+ZsS/cP4zxNsal3CkoXJWrzpMuw==
X-Received: by 2002:adf:e6cd:0:b0:2cb:2775:6e6 with SMTP id
 y13-20020adfe6cd000000b002cb277506e6mr1163096wrm.45.1685438923454; 
 Tue, 30 May 2023 02:28:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 v11-20020adfedcb000000b0030ae87bd3e3sm2603854wro.18.2023.05.30.02.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 02:28:42 -0700 (PDT)
Message-ID: <f18c4598-a1c7-ba45-5885-e14b833f2fde@redhat.com>
Date: Tue, 30 May 2023 11:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 7/9] vfio/migration: Add VFIO migration pre-copy support
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
 <20230528140652.8693-8-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230528140652.8693-8-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/28/23 16:06, Avihai Horon wrote:
> Pre-copy support allows the VFIO device data to be transferred while the
> VM is running. This helps to accommodate VFIO devices that have a large
> amount of data that needs to be transferred, and it can reduce migration
> downtime.
> 
> Pre-copy support is optional in VFIO migration protocol v2.
> Implement pre-copy of VFIO migration protocol v2 and use it for devices
> that support it. Full description of it can be found in the following
> Linux commit: 4db52602a607 ("vfio: Extend the device migration protocol
> with PRE_COPY").
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

LGTM,
  
Reviewed-by: Cédric Le Goater <clg@redhat.com>

one minor issue below,

> ---
>   docs/devel/vfio-migration.rst |  35 +++++---
>   include/hw/vfio/vfio-common.h |   2 +
>   hw/vfio/common.c              |   6 +-
>   hw/vfio/migration.c           | 165 ++++++++++++++++++++++++++++++++--
>   hw/vfio/trace-events          |   4 +-
>   5 files changed, 190 insertions(+), 22 deletions(-)
> 
> diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
> index 1b68ccf115..e896b2a673 100644
> --- a/docs/devel/vfio-migration.rst
> +++ b/docs/devel/vfio-migration.rst
> @@ -7,12 +7,14 @@ the guest is running on source host and restoring this saved state on the
>   destination host. This document details how saving and restoring of VFIO
>   devices is done in QEMU.
>   
> -Migration of VFIO devices currently consists of a single stop-and-copy phase.
> -During the stop-and-copy phase the guest is stopped and the entire VFIO device
> -data is transferred to the destination.
> -
> -The pre-copy phase of migration is currently not supported for VFIO devices.
> -Support for VFIO pre-copy will be added later on.
> +Migration of VFIO devices consists of two phases: the optional pre-copy phase,
> +and the stop-and-copy phase. The pre-copy phase is iterative and allows to
> +accommodate VFIO devices that have a large amount of data that needs to be
> +transferred. The iterative pre-copy phase of migration allows for the guest to
> +continue whilst the VFIO device state is transferred to the destination, this
> +helps to reduce the total downtime of the VM. VFIO devices opt-in to pre-copy
> +support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
> +VFIO_DEVICE_FEATURE_MIGRATION ioctl.
>   
>   Note that currently VFIO migration is supported only for a single device. This
>   is due to VFIO migration's lack of P2P support. However, P2P support is planned
> @@ -29,10 +31,20 @@ VFIO implements the device hooks for the iterative approach as follows:
>   * A ``load_setup`` function that sets the VFIO device on the destination in
>     _RESUMING state.
>   
> +* A ``state_pending_estimate`` function that reports an estimate of the
> +  remaining pre-copy data that the vendor driver has yet to save for the VFIO
> +  device.
> +
>   * A ``state_pending_exact`` function that reads pending_bytes from the vendor
>     driver, which indicates the amount of data that the vendor driver has yet to
>     save for the VFIO device.
>   
> +* An ``is_active_iterate`` function that indicates ``save_live_iterate`` is
> +  active only when the VFIO device is in pre-copy states.
> +
> +* A ``save_live_iterate`` function that reads the VFIO device's data from the
> +  vendor driver during iterative pre-copy phase.
> +
>   * A ``save_state`` function to save the device config space if it is present.
>   
>   * A ``save_live_complete_precopy`` function that sets the VFIO device in
> @@ -111,8 +123,10 @@ Flow of state changes during Live migration
>   ===========================================
>   
>   Below is the flow of state change during live migration.
> -The values in the brackets represent the VM state, the migration state, and
> +The values in the parentheses represent the VM state, the migration state, and
>   the VFIO device state, respectively.
> +The text in the square brackets represents the flow if the VFIO device supports
> +pre-copy.
>   
>   Live migration save path
>   ------------------------
> @@ -124,11 +138,12 @@ Live migration save path
>                                     |
>                        migrate_init spawns migration_thread
>                   Migration thread then calls each device's .save_setup()
> -                       (RUNNING, _SETUP, _RUNNING)
> +                  (RUNNING, _SETUP, _RUNNING [_PRE_COPY])
>                                     |
> -                      (RUNNING, _ACTIVE, _RUNNING)
> -             If device is active, get pending_bytes by .state_pending_exact()
> +                  (RUNNING, _ACTIVE, _RUNNING [_PRE_COPY])
> +      If device is active, get pending_bytes by .state_pending_{estimate,exact}()
>             If total pending_bytes >= threshold_size, call .save_live_iterate()
> +                  [Data of VFIO device for pre-copy phase is copied]
>           Iterate till total pending bytes converge and are less than threshold
>                                     |
>     On migration completion, vCPU stops and calls .save_live_complete_precopy for
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 5f29dab839..1db901c194 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -67,6 +67,8 @@ typedef struct VFIOMigration {
>       void *data_buffer;
>       size_t data_buffer_size;
>       uint64_t mig_flags;
> +    uint64_t precopy_init_size;
> +    uint64_t precopy_dirty_size;
>   } VFIOMigration;
>   
>   typedef struct VFIOAddressSpace {
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 78358ede27..b73086e17a 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -492,7 +492,8 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>               }
>   
>               if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
> -                migration->device_state == VFIO_DEVICE_STATE_RUNNING) {
> +                (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
> +                 migration->device_state == VFIO_DEVICE_STATE_PRE_COPY)) {
>                   return false;
>               }
>           }
> @@ -537,7 +538,8 @@ static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
>                   return false;
>               }
>   
> -            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING) {
> +            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
> +                migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
>                   continue;
>               } else {
>                   return false;
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 8d33414379..d8f6a22ae1 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -68,6 +68,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>           return "STOP_COPY";
>       case VFIO_DEVICE_STATE_RESUMING:
>           return "RESUMING";
> +    case VFIO_DEVICE_STATE_PRE_COPY:
> +        return "PRE_COPY";
>       default:
>           return "UNKNOWN STATE";
>       }
> @@ -241,6 +243,25 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev,
>       return 0;
>   }
>   
> +static int vfio_query_precopy_size(VFIOMigration *migration)
> +{
> +    struct vfio_precopy_info precopy = {
> +        .argsz = sizeof(precopy),
> +    };
> +
> +    migration->precopy_init_size = 0;
> +    migration->precopy_dirty_size = 0;
> +
> +    if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
> +        return -errno;
> +    }
> +
> +    migration->precopy_init_size = precopy.initial_bytes;
> +    migration->precopy_dirty_size = precopy.dirty_bytes;
> +
> +    return 0;
> +}
> +
>   /* Returns the size of saved data on success and -errno on error */
>   static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>   {
> @@ -249,6 +270,14 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>       data_size = read(migration->data_fd, migration->data_buffer,
>                        migration->data_buffer_size);
>       if (data_size < 0) {
> +        /*
> +         * Pre-copy emptied all the device state for now. For more information,
> +         * please refer to the Linux kernel VFIO uAPI.
> +         */
> +        if (errno == ENOMSG) {
> +            return 0;
> +        }
> +
>           return -errno;
>       }
>       if (data_size == 0) {
> @@ -265,6 +294,38 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>       return qemu_file_get_error(f) ?: data_size;
>   }
>   
> +static void vfio_update_estimated_pending_data(VFIOMigration *migration,
> +                                               uint64_t data_size)
> +{
> +    if (!data_size) {
> +        /*
> +         * Pre-copy emptied all the device state for now, update estimated sizes
> +         * accordingly.
> +         */
> +        migration->precopy_init_size = 0;
> +        migration->precopy_dirty_size = 0;
> +
> +        return;
> +    }
> +
> +    if (migration->precopy_init_size) {
> +        uint64_t init_size = MIN(migration->precopy_init_size, data_size);
> +
> +        migration->precopy_init_size -= init_size;
> +        data_size -= init_size;
> +    }
> +
> +    migration->precopy_dirty_size -= MIN(migration->precopy_dirty_size,
> +                                         data_size);
> +}
> +
> +static bool vfio_precopy_supported(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
> +}
> +
>   /* ---------------------------------------------------------------------- */
>   
>   static int vfio_save_setup(QEMUFile *f, void *opaque)
> @@ -285,6 +346,28 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>           return -ENOMEM;
>       }
>   
> +    if (vfio_precopy_supported(vbasedev)) {
> +        int ret;
> +
> +        switch (migration->device_state) {
> +        case VFIO_DEVICE_STATE_RUNNING:
> +            ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
> +                                           VFIO_DEVICE_STATE_RUNNING);
> +            if (ret) {
> +                return ret;
> +            }
> +
> +            vfio_query_precopy_size(migration);
> +
> +            break;
> +        case VFIO_DEVICE_STATE_STOP:
> +            /* vfio_save_complete_precopy() will go to STOP_COPY */
> +            break;
> +        default:
> +            return -EINVAL;
> +        }
> +    }
> +
>       trace_vfio_save_setup(vbasedev->name, migration->data_buffer_size);
>   
>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> @@ -299,26 +382,42 @@ static void vfio_save_cleanup(void *opaque)
>   
>       g_free(migration->data_buffer);
>       migration->data_buffer = NULL;
> +    migration->precopy_init_size = 0;
> +    migration->precopy_dirty_size = 0;
>       vfio_migration_cleanup(vbasedev);
>       trace_vfio_save_cleanup(vbasedev->name);
>   }
>   
> +static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
> +                                        uint64_t *can_postcopy)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (migration->device_state != VFIO_DEVICE_STATE_PRE_COPY) {
> +        return;
> +    }
> +
> +    *must_precopy +=
> +        migration->precopy_init_size + migration->precopy_dirty_size;
> +
> +    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
> +                                      *can_postcopy,
> +                                      migration->precopy_init_size,
> +                                      migration->precopy_dirty_size);
> +}
> +
>   /*
>    * Migration size of VFIO devices can be as little as a few KBs or as big as
>    * many GBs. This value should be big enough to cover the worst case.
>    */
>   #define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
>   
> -/*
> - * Only exact function is implemented and not estimate function. The reason is
> - * that during pre-copy phase of migration the estimate function is called
> - * repeatedly while pending RAM size is over the threshold, thus migration
> - * can't converge and querying the VFIO device pending data size is useless.
> - */
>   static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
>                                        uint64_t *can_postcopy)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
>   
>       /*
> @@ -328,8 +427,48 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>       *must_precopy += stop_copy_size;
>   
> +    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
> +        vfio_query_precopy_size(migration);
> +
> +        *must_precopy +=
> +            migration->precopy_init_size + migration->precopy_dirty_size;
> +    }
> +
>       trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
> -                                   stop_copy_size);
> +                                   stop_copy_size, migration->precopy_init_size,
> +                                   migration->precopy_dirty_size);
> +}
> +
> +static bool vfio_is_active_iterate(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
> +}
> +
> +static int vfio_save_iterate(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    ssize_t data_size;
> +
> +    data_size = vfio_save_block(f, migration);
> +    if (data_size < 0) {
> +        return data_size;
> +    }
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    vfio_update_estimated_pending_data(migration, data_size);
> +
> +    trace_vfio_save_iterate(vbasedev->name, migration->precopy_init_size,
> +                            migration->precopy_dirty_size);
> +
> +    /*
> +     * A VFIO device's pre-copy dirty_bytes is not guaranteed to reach zero.
> +     * Return 1 so following handlers will not be potentially blocked.
> +     */
> +    return 1;
>   }
>   
>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> @@ -338,7 +477,7 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       ssize_t data_size;
>       int ret;
>   
> -    /* We reach here with device state STOP only */
> +    /* We reach here with device state STOP or STOP_COPY only */
>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
>                                      VFIO_DEVICE_STATE_STOP);
>       if (ret) {
> @@ -457,7 +596,10 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>   static const SaveVMHandlers savevm_vfio_handlers = {
>       .save_setup = vfio_save_setup,
>       .save_cleanup = vfio_save_cleanup,
> +    .state_pending_estimate = vfio_state_pending_estimate,
>       .state_pending_exact = vfio_state_pending_exact,
> +    .is_active_iterate = vfio_is_active_iterate,
> +    .save_live_iterate = vfio_save_iterate,
>       .save_live_complete_precopy = vfio_save_complete_precopy,
>       .save_state = vfio_save_state,
>       .load_setup = vfio_load_setup,
> @@ -470,13 +612,18 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>   static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       enum vfio_device_mig_state new_state;
>       int ret;
>   
>       if (running) {
>           new_state = VFIO_DEVICE_STATE_RUNNING;
>       } else {
> -        new_state = VFIO_DEVICE_STATE_STOP;
> +        new_state =
> +            (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY &&
> +             (state == RUN_STATE_FINISH_MIGRATE || state == RUN_STATE_PAUSED)) ?
> +                VFIO_DEVICE_STATE_STOP_COPY :
> +                VFIO_DEVICE_STATE_STOP;
>       }
>   
>       /*
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 646e42fd27..548f9488a7 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -162,6 +162,8 @@ vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
>   vfio_save_cleanup(const char *name) " (%s)"
>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>   vfio_save_device_config_state(const char *name) " (%s)"
> +vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64"

the extra '"' at the end breaks compile. No need to resend just for that.
It can be fixed.

Thanks,

C.

>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size 0x%"PRIx64
> -vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64
> +vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
> +vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>   vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"


