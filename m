Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C775C612
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 13:50:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMocr-0001aS-R6; Fri, 21 Jul 2023 07:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qMoci-0001Wg-7I
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 07:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qMocf-0000sc-Sq
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 07:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689940116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTi34+hgCD60KlDcO20wOCI5RShsXrLZMbOxZWP3WoI=;
 b=h9WKU44151yai+cgtu82Sr6jY+6tUPKef9NxAazml29pLeCAlx2pa4PU6psdW54U33snnk
 +XgLC3bs+pK7UAdhjBNmaG4Vvku/DXmoyx+0OEkEiFa257N37QbU2vEKQUkkPJk4zi4CiQ
 z8BKJHwkbH3EolS2Kdzi6l/0SToKpI8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-bTfpAlvyPQqInHGqpwWqtg-1; Fri, 21 Jul 2023 07:48:34 -0400
X-MC-Unique: bTfpAlvyPQqInHGqpwWqtg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31432b25c2fso1083190f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 04:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689940113; x=1690544913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WTi34+hgCD60KlDcO20wOCI5RShsXrLZMbOxZWP3WoI=;
 b=ZyNC5czBY++WWM33gM9t+CmjmoxLHnI31fD8zIKBp9v1Q64Djk6mw+fAr++j0K+RJA
 C+yKRCFcDugS+bD3aGmGRpYiYaaq3RWzXAZBhBxdeskEwUZt/wcJ09NPCA+8rZcfHCiy
 sfVT8VrKy5f+9I1K2Ae0Amevh8HCiy23Nns8vorizWClDE3V4BTKmfPvsU4w4txsliVg
 /N2jb+0erDpg0WoWgnvibmhssLly8CprgAo0wI+n/HXp3ZP9Hxhj+bN5FumplW6Pah1I
 gqOYaY8nbhvt0U1HzzJZMldMqtL6CgUvktuQ6l/2u7ghGMRipVY/3tnTwDzdb32ysAde
 UtnA==
X-Gm-Message-State: ABy/qLYkZaTyclixhMVP7eTos56KaHz2GULUaJ2NxBpbHmlkGNZEbsGz
 KyJyRgf7fpjcFql5J20cfPYtwX5fCr735gEkPekCZEPCHwv/t0PZopkU8HLZY31jgzjpm6STCcx
 P3Xt3ikSZdkntG74=
X-Received: by 2002:adf:db85:0:b0:313:f6fc:1f48 with SMTP id
 u5-20020adfdb85000000b00313f6fc1f48mr1275742wri.14.1689940113624; 
 Fri, 21 Jul 2023 04:48:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHLtPIn7MVhpvHaLvUzTBWqlr22Rf5aHbDxQSelpqzxG7osXUDlIsQSnPPuEwI2myy5eZvz9g==
X-Received: by 2002:adf:db85:0:b0:313:f6fc:1f48 with SMTP id
 u5-20020adfdb85000000b00313f6fc1f48mr1275724wri.14.1689940113216; 
 Fri, 21 Jul 2023 04:48:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:9283:b79f:cbb3:327a?
 ([2a01:e0a:9e2:9000:9283:b79f:cbb3:327a])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a5d554f000000b0031417fd473csm3998634wrw.78.2023.07.21.04.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 04:48:32 -0700 (PDT)
Message-ID: <99a770f6-7f45-d7df-9555-bcc854914472@redhat.com>
Date: Fri, 21 Jul 2023 13:48:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 5/6] vfio/migration: Add P2P support for VFIO
 migration
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
 <20230716081541.27900-6-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230716081541.27900-6-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/16/23 10:15, Avihai Horon wrote:
> VFIO migration uAPI defines an optional intermediate P2P quiescent
> state. While in the P2P quiescent state, P2P DMA transactions cannot be
> initiated by the device, but the device can respond to incoming ones.
> Additionally, all outstanding P2P transactions are guaranteed to have
> been completed by the time the device enters this state.
> 
> The purpose of this state is to support migration of multiple devices
> that are doing P2P transactions between themselves.
> 
> Add support for P2P migration by transitioning all the devices to the
> P2P quiescent state before stopping or starting the devices. Use the new
> VMChangeStateHandler pre_change_cb to achieve that behavior.
> 
> This will allow migration of multiple VFIO devices if all of them
> support P2P migration.

LGTM, one small comment below
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   docs/devel/vfio-migration.rst | 93 +++++++++++++++++++++--------------
>   hw/vfio/common.c              |  6 ++-
>   hw/vfio/migration.c           | 58 +++++++++++++++++-----
>   hw/vfio/trace-events          |  2 +-
>   4 files changed, 107 insertions(+), 52 deletions(-)
> 
> diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
> index b433cb5bb2..b9c57ba651 100644
> --- a/docs/devel/vfio-migration.rst
> +++ b/docs/devel/vfio-migration.rst
> @@ -23,9 +23,21 @@ and recommends that the initial bytes are sent and loaded in the destination
>   before stopping the source VM. Enabling this migration capability will
>   guarantee that and thus, can potentially reduce downtime even further.
>   
> -Note that currently VFIO migration is supported only for a single device. This
> -is due to VFIO migration's lack of P2P support. However, P2P support is planned
> -to be added later on.
> +To support migration of multiple devices that are doing P2P transactions
> +between themselves, VFIO migration uAPI defines an intermediate P2P quiescent
> +state. While in the P2P quiescent state, P2P DMA transactions cannot be
> +initiated by the device, but the device can respond to incoming ones.
> +Additionally, all outstanding P2P transactions are guaranteed to have been
> +completed by the time the device enters this state.
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
> index 48f9c23cbe..02ee99c938 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -71,8 +71,13 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>           return "STOP_COPY";
>       case VFIO_DEVICE_STATE_RESUMING:
>           return "RESUMING";
> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
> +        return "RUNNING_P2P";
>       case VFIO_DEVICE_STATE_PRE_COPY:
>           return "PRE_COPY";
> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> +        return "PRE_COPY_P2P";
> +
>       default:
>           return "UNKNOWN STATE";
>       }
> @@ -652,20 +657,31 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>   
>   /* ---------------------------------------------------------------------- */
>   
> -static void vfio_vmstate_change(void *opaque, bool running, RunState state)
> +static void vfio_vmstate_change(VFIODevice *vbasedev, bool running,
> +                                RunState state, bool pre_state_change)

Instead of mixing both vmstate change handlers in one routine, I would prefer
a new pre_state handler to be introduced.

Thanks,

C.


>   {
> -    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       enum vfio_device_mig_state new_state;
>       int ret;
>   
> -    if (running) {
> -        new_state = VFIO_DEVICE_STATE_RUNNING;
> +    if (pre_state_change && !(migration->mig_flags & VFIO_MIGRATION_P2P)) {
> +        return;
> +    }
> +
> +    if (pre_state_change) {
> +        new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
> +                        VFIO_DEVICE_STATE_PRE_COPY_P2P :
> +                        VFIO_DEVICE_STATE_RUNNING_P2P;
>       } else {
> -        new_state =
> -            (vfio_device_state_is_precopy(vbasedev) &&
> -             (state == RUN_STATE_FINISH_MIGRATE || state == RUN_STATE_PAUSED)) ?
> -                VFIO_DEVICE_STATE_STOP_COPY :
> -                VFIO_DEVICE_STATE_STOP;
> +        if (running) {
> +            new_state = VFIO_DEVICE_STATE_RUNNING;
> +        } else {
> +            new_state = (vfio_device_state_is_precopy(vbasedev) &&
> +                         (state == RUN_STATE_FINISH_MIGRATE ||
> +                          state == RUN_STATE_PAUSED)) ?
> +                            VFIO_DEVICE_STATE_STOP_COPY :
> +                            VFIO_DEVICE_STATE_STOP;
> +        }
>       }
>   
>       /*
> @@ -685,7 +701,23 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>       }
>   
>       trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> -                              mig_state_to_str(new_state));
> +                              pre_state_change, mig_state_to_str(new_state));
> +}
> +
> +static void vfio_vmstate_pre_change_handler(void *opaque, bool running,
> +                                            RunState state)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    vfio_vmstate_change(vbasedev, running, state, true);
> +}
> +
> +static void vfio_vmstate_change_handler(void *opaque, bool running,
> +                                        RunState state)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    vfio_vmstate_change(vbasedev, running, state, false);
>   }
>   
>   static void vfio_migration_state_notifier(Notifier *notifier, void *data)
> @@ -798,9 +830,9 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>       register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
>                            vbasedev);
>   
> -    migration->vm_state = qdev_add_vm_change_state_handler(vbasedev->dev,
> -                                                           vfio_vmstate_change,
> -                                                           vbasedev);
> +    migration->vm_state = qdev_add_vm_change_state_handler_full(
> +        vbasedev->dev, vfio_vmstate_change_handler,
> +        vfio_vmstate_pre_change_handler, vbasedev);
>       migration->migration_state.notify = vfio_migration_state_notifier;
>       add_migration_state_change_notifier(&migration->migration_state);
>   
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ee7509e68e..efafe613f2 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -166,4 +166,4 @@ vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy
>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size 0x%"PRIx64
>   vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>   vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
> -vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
> +vfio_vmstate_change(const char *name, int running, const char *reason, bool pre_state_change, const char *dev_state) " (%s) running %d reason %s pre state change %d device state %s"


