Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B05476C891
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:43:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR7Rs-0002xL-6X; Wed, 02 Aug 2023 04:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qR7Rp-0002wg-R4
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qR7Rn-0003ve-Rg
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690965790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VutIrUCxEmXyTYVKQP67UzH52LLWEzgj+Ab9s4lxue4=;
 b=Wl4Wq2T09oR5a9gaSDi1W4y9cQrs5HPeY4Ryq1da0a9XZQmOh0Kg+A+Yib78enWf6AEg8e
 95CO2GST2iqrdH492+G+5zrzMcL1SDh/8XOzT/xJE8dU2d0eiH35zSLUgc2XIN57KaqWy7
 FzTTk86+kNwGmmjkr38jSsVTEyUAL1U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-w2OPS99uNT-cJATh_wVy0Q-1; Wed, 02 Aug 2023 04:43:07 -0400
X-MC-Unique: w2OPS99uNT-cJATh_wVy0Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-5eee6742285so81151026d6.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 01:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690965787; x=1691570587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VutIrUCxEmXyTYVKQP67UzH52LLWEzgj+Ab9s4lxue4=;
 b=DfH6L3qgP1AE1mDcVIVpvA/xA4dyXRuhhxaewRTgo8fcUjpZXnZw9lNwArg23fUoEs
 Ww/g0BectPdhExbJFSWWWbGiW/KJiCIwSsj4KMYL/l50WKDF9lTyFlxqY7RtDef8DCk5
 Tb1rLPnsoP4JavGqMWxHEM9VByF1X6IJU2F6BW/Ay+89f/p0YzVqEJjADtqQ0ZQewLic
 3hDgV0rIxLwIbDM7bxduJHUnMKZslsQfuFv8gP5qKuAUFLTXIZrjNSpM4pL7K6Fxs2xo
 TwXWZfa4vayq49SNR+sfqAZ7FabNHi0S/bCs3ygWDGHC7ZareodNMg+ctFo/vSe2bWAr
 IthQ==
X-Gm-Message-State: ABy/qLZCuz7SBEwn2XSqxOvF2zu5209x4rphhSq+dT7XlDhEjegLWpKx
 pv/KwEZc2NqqzMeGQBDt34SXW5NCpuNj6yB9+zH8KVLlK7nWyAHCRVH8OxG6YMNWt/l0pM9aK02
 voaPSNFoza816QQs=
X-Received: by 2002:a0c:b447:0:b0:63d:7863:47d with SMTP id
 e7-20020a0cb447000000b0063d7863047dmr5505996qvf.64.1690965787042; 
 Wed, 02 Aug 2023 01:43:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH47RvthSUTP/Vvg4pEiojb25IRyzhf78sfCRv+zqEH9nZbHae+sQNRluWYTV5Bs0Lu2DHkKw==
X-Received: by 2002:a0c:b447:0:b0:63d:7863:47d with SMTP id
 e7-20020a0cb447000000b0063d7863047dmr5505982qvf.64.1690965786729; 
 Wed, 02 Aug 2023 01:43:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 z14-20020ae9c10e000000b00765a7843382sm4814772qki.74.2023.08.02.01.43.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 01:43:06 -0700 (PDT)
Message-ID: <70d4e9ec-f2f1-ccf0-4391-1f16fb15c641@redhat.com>
Date: Wed, 2 Aug 2023 10:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 v3 5/6] vfio/migration: Add P2P support for VFIO
 migration
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230802081449.2528-1-avihaih@nvidia.com>
 <20230802081449.2528-6-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230802081449.2528-6-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 8/2/23 10:14, Avihai Horon wrote:
> VFIO migration uAPI defines an optional intermediate P2P quiescent
> state. While in the P2P quiescent state, P2P DMA transactions cannot be
> initiated by the device, but the device can respond to incoming ones.
> Additionally, all outstanding P2P transactions are guaranteed to have
> been completed by the time the device enters this state.
> 
> The purpose of this state is to support migration of multiple devices
> that might do P2P transactions between themselves.
> 
> Add support for P2P migration by transitioning all the devices to the
> P2P quiescent state before stopping or starting the devices. Use the new
> VMChangeStateHandler prepare_cb to achieve that behavior.
> 
> This will allow migration of multiple VFIO devices if all of them
> support P2P migration.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/devel/vfio-migration.rst | 93 +++++++++++++++++++++--------------
>   hw/vfio/common.c              |  6 ++-
>   hw/vfio/migration.c           | 46 +++++++++++++++--
>   hw/vfio/trace-events          |  1 +
>   4 files changed, 105 insertions(+), 41 deletions(-)
> 
> diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
> index b433cb5bb2..605fe60e96 100644
> --- a/docs/devel/vfio-migration.rst
> +++ b/docs/devel/vfio-migration.rst
> @@ -23,9 +23,21 @@ and recommends that the initial bytes are sent and loaded in the destination
>   before stopping the source VM. Enabling this migration capability will
>   guarantee that and thus, can potentially reduce downtime even further.
>   
> -Note that currently VFIO migration is supported only for a single device. This
> -is due to VFIO migration's lack of P2P support. However, P2P support is planned
> -to be added later on.
> +To support migration of multiple devices that might do P2P transactions between
> +themselves, VFIO migration uAPI defines an intermediate P2P quiescent state.
> +While in the P2P quiescent state, P2P DMA transactions cannot be initiated by
> +the device, but the device can respond to incoming ones. Additionally, all
> +outstanding P2P transactions are guaranteed to have been completed by the time
> +the device enters this state.
> +
> +All the devices that support P2P migration are first transitioned to the P2P
> +quiescent state and only then are they stopped or started. This makes migration
> +safe P2P-wise, since starting and stopping the devices is not done atomically
> +for all the devices together.
> +
> +Thus, multiple VFIO devices migration is allowed only if all the devices
> +support P2P migration. Single VFIO device migration is allowed regardless of
> +P2P migration support.
>   
>   A detailed description of the UAPI for VFIO device migration can be found in
>   the comment for the ``vfio_device_mig_state`` structure in the header file
> @@ -132,54 +144,63 @@ will be blocked.
>   Flow of state changes during Live migration
>   ===========================================
>   
> -Below is the flow of state change during live migration.
> +Below is the state change flow during live migration for a VFIO device that
> +supports both precopy and P2P migration. The flow for devices that don't
> +support it is similar, except that the relevant states for precopy and P2P are
> +skipped.
>   The values in the parentheses represent the VM state, the migration state, and
>   the VFIO device state, respectively.
> -The text in the square brackets represents the flow if the VFIO device supports
> -pre-copy.
>   
>   Live migration save path
>   ------------------------
>   
>   ::
>   
> -                        QEMU normal running state
> -                        (RUNNING, _NONE, _RUNNING)
> -                                  |
> +                           QEMU normal running state
> +                           (RUNNING, _NONE, _RUNNING)
> +                                      |
>                        migrate_init spawns migration_thread
> -                Migration thread then calls each device's .save_setup()
> -                  (RUNNING, _SETUP, _RUNNING [_PRE_COPY])
> -                                  |
> -                  (RUNNING, _ACTIVE, _RUNNING [_PRE_COPY])
> -      If device is active, get pending_bytes by .state_pending_{estimate,exact}()
> -          If total pending_bytes >= threshold_size, call .save_live_iterate()
> -                  [Data of VFIO device for pre-copy phase is copied]
> -        Iterate till total pending bytes converge and are less than threshold
> -                                  |
> -  On migration completion, vCPU stops and calls .save_live_complete_precopy for
> -  each active device. The VFIO device is then transitioned into _STOP_COPY state
> -                  (FINISH_MIGRATE, _DEVICE, _STOP_COPY)
> -                                  |
> -     For the VFIO device, iterate in .save_live_complete_precopy until
> -                         pending data is 0
> -                   (FINISH_MIGRATE, _DEVICE, _STOP)
> -                                  |
> -                 (FINISH_MIGRATE, _COMPLETED, _STOP)
> -             Migraton thread schedules cleanup bottom half and exits
> +            Migration thread then calls each device's .save_setup()
> +                          (RUNNING, _SETUP, _PRE_COPY)
> +                                      |
> +                         (RUNNING, _ACTIVE, _PRE_COPY)
> +  If device is active, get pending_bytes by .state_pending_{estimate,exact}()
> +       If total pending_bytes >= threshold_size, call .save_live_iterate()
> +                Data of VFIO device for pre-copy phase is copied
> +      Iterate till total pending bytes converge and are less than threshold
> +                                      |
> +       On migration completion, the vCPUs and the VFIO device are stopped
> +              The VFIO device is first put in P2P quiescent state
> +                    (FINISH_MIGRATE, _ACTIVE, _PRE_COPY_P2P)
> +                                      |
> +                Then the VFIO device is put in _STOP_COPY state
> +                     (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
> +         .save_live_complete_precopy() is called for each active device
> +      For the VFIO device, iterate in .save_live_complete_precopy() until
> +                               pending data is 0
> +                                      |
> +                     (POSTMIGRATE, _COMPLETED, _STOP_COPY)
> +            Migraton thread schedules cleanup bottom half and exits
> +                                      |
> +                           .save_cleanup() is called
> +                        (POSTMIGRATE, _COMPLETED, _STOP)
>   
>   Live migration resume path
>   --------------------------
>   
>   ::
>   
> -              Incoming migration calls .load_setup for each device
> -                       (RESTORE_VM, _ACTIVE, _STOP)
> -                                 |
> -       For each device, .load_state is called for that device section data
> -                       (RESTORE_VM, _ACTIVE, _RESUMING)
> -                                 |
> -    At the end, .load_cleanup is called for each device and vCPUs are started
> -                       (RUNNING, _NONE, _RUNNING)
> +             Incoming migration calls .load_setup() for each device
> +                          (RESTORE_VM, _ACTIVE, _STOP)
> +                                      |
> +     For each device, .load_state() is called for that device section data
> +                        (RESTORE_VM, _ACTIVE, _RESUMING)
> +                                      |
> +  At the end, .load_cleanup() is called for each device and vCPUs are started
> +              The VFIO device is first put in P2P quiescent state
> +                        (RUNNING, _ACTIVE, _RUNNING_P2P)
> +                                      |
> +                           (RUNNING, _NONE, _RUNNING)
>   
>   Postcopy
>   ========
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 16cf79a76c..7c3d636025 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -441,14 +441,16 @@ bool vfio_device_state_is_running(VFIODevice *vbasedev)
>   {
>       VFIOMigration *migration = vbasedev->migration;
>   
> -    return migration->device_state == VFIO_DEVICE_STATE_RUNNING;
> +    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
> +           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
>   }
>   
>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>   {
>       VFIOMigration *migration = vbasedev->migration;
>   
> -    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
> +    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
> +           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>   }
>   
>   static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 48f9c23cbe..71855468fe 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -71,8 +71,12 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>           return "STOP_COPY";
>       case VFIO_DEVICE_STATE_RESUMING:
>           return "RESUMING";
> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
> +        return "RUNNING_P2P";
>       case VFIO_DEVICE_STATE_PRE_COPY:
>           return "PRE_COPY";
> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> +        return "PRE_COPY_P2P";
>       default:
>           return "UNKNOWN STATE";
>       }
> @@ -652,6 +656,39 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>   
>   /* ---------------------------------------------------------------------- */
>   
> +static void vfio_vmstate_change_prepare(void *opaque, bool running,
> +                                        RunState state)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    enum vfio_device_mig_state new_state;
> +    int ret;
> +
> +    new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
> +                    VFIO_DEVICE_STATE_PRE_COPY_P2P :
> +                    VFIO_DEVICE_STATE_RUNNING_P2P;
> +
> +    /*
> +     * If setting the device in new_state fails, the device should be reset.
> +     * To do so, use ERROR state as a recover state.
> +     */
> +    ret = vfio_migration_set_state(vbasedev, new_state,
> +                                   VFIO_DEVICE_STATE_ERROR);
> +    if (ret) {
> +        /*
> +         * Migration should be aborted in this case, but vm_state_notify()
> +         * currently does not support reporting failures.
> +         */
> +        if (migrate_get_current()->to_dst_file) {
> +            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
> +        }
> +    }
> +
> +    trace_vfio_vmstate_change_prepare(vbasedev->name, running,
> +                                      RunState_str(state),
> +                                      mig_state_to_str(new_state));
> +}
> +
>   static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>   {
>       VFIODevice *vbasedev = opaque;
> @@ -758,6 +795,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>       char id[256] = "";
>       g_autofree char *path = NULL, *oid = NULL;
>       uint64_t mig_flags = 0;
> +    VMChangeStateHandler *prepare_cb;
>   
>       if (!vbasedev->ops->vfio_get_object) {
>           return -EINVAL;
> @@ -798,9 +836,11 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>       register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
>                            vbasedev);
>   
> -    migration->vm_state = qdev_add_vm_change_state_handler(vbasedev->dev,
> -                                                           vfio_vmstate_change,
> -                                                           vbasedev);
> +    prepare_cb = migration->mig_flags & VFIO_MIGRATION_P2P ?
> +                     vfio_vmstate_change_prepare :
> +                     NULL;
> +    migration->vm_state = qdev_add_vm_change_state_handler_full(
> +        vbasedev->dev, vfio_vmstate_change, prepare_cb, vbasedev);
>       migration->migration_state.notify = vfio_migration_state_notifier;
>       add_migration_state_change_notifier(&migration->migration_state);
>   
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ee7509e68e..329736a738 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -167,3 +167,4 @@ vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer
>   vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>   vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>   vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
> +vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"


