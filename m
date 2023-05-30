Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62009715AE3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3w7q-00035x-Gz; Tue, 30 May 2023 05:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3w7o-00035k-Qe
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3w7m-0005d8-Lz
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685440721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EhYUXgIymTmL+j0YD1YHBDo0tqrQE3RzLvzPPiNNWvU=;
 b=dxy85VBUILmOKENok0wlJ1Wr92RqIHAnzGEeveTip59r9ob3iQcemHEibUaHobTR3fur1j
 HlnINAk0rDLh8Tfm9Z+VEBJc96WZIw0Q/8pZXhk7s/+Q6AjxWD65RBcXBRM3G5oWtZGEAZ
 Uql5iBJpX1BgtA3beZGH9yVlNe24Vcg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-i-GeYDQWMiKbpUgsuMeL3Q-1; Tue, 30 May 2023 05:58:40 -0400
X-MC-Unique: i-GeYDQWMiKbpUgsuMeL3Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f60f085cd2so15921965e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 02:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685440719; x=1688032719;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EhYUXgIymTmL+j0YD1YHBDo0tqrQE3RzLvzPPiNNWvU=;
 b=ivzIxKjdFnYnRgr6OCApJhuyIook4ct53ditipVAiHGatbdE75IreXXpWX3GkUx03F
 yzYpQyV0qBqKKUQOkVx/VktmWYI8Kx6Em/drpLHfHmfLCIimWj0aF1hEQRx6zHFU5m87
 qAH3Zic0eKZUAKhRVSSrmc4UiqBmimMwdx691uNPhEdVjn2G7bH+2SSVpyin8NcPZY/Z
 yjjGAmNkCvzEtgoqABDobxG+Xc5b9awPZLrRwd/zvFh4FIOCgbT9185CguX2ePewX/3g
 W2h2ytJmZyvWMq8xIyBQIpit3XO9zwTyybws9FzApgiXDkBp0796IvArXb9TqWu2c1yn
 QD9g==
X-Gm-Message-State: AC+VfDzwdWVmSW1ye7BQt4HtOhF82tdeRQSvLRQW+Cx3ilOHMbeKsyQT
 mIxTTM+/Uxayd6+jC0noTZNT2zs0i4AXsgH9bECPWTjXTFBf7SbjFWBD92+Dy96fHtjczVrNNjL
 rQ1r38js84AaaHME=
X-Received: by 2002:a05:600c:2252:b0:3f6:8af:414 with SMTP id
 a18-20020a05600c225200b003f608af0414mr1267906wmm.30.1685440718916; 
 Tue, 30 May 2023 02:58:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7WXNH2PhbAuUeDJax0Xq580LD278vETEQ+F0J9mMf9oFyJLPpFTeDMMtkFb5Va6J2lR2NGzQ==
X-Received: by 2002:a05:600c:2252:b0:3f6:8af:414 with SMTP id
 a18-20020a05600c225200b003f608af0414mr1267884wmm.30.1685440718594; 
 Tue, 30 May 2023 02:58:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a05600c378b00b003f195d540d9sm20553665wmr.14.2023.05.30.02.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 02:58:38 -0700 (PDT)
Message-ID: <b3da19aa-37d0-16f2-4094-d1931dfa7601@redhat.com>
Date: Tue, 30 May 2023 11:58:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 9/9] vfio/migration: Add support for switchover ack
 capability
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
 <20230528140652.8693-10-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230528140652.8693-10-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Loading of a VFIO device's data can take a substantial amount of time as
> the device may need to allocate resources, prepare internal data
> structures, etc. This can increase migration downtime, especially for
> VFIO devices with a lot of resources.
> 
> To solve this, VFIO migration uAPI defines "initial bytes" as part of
> its precopy data stream. Initial bytes can be used in various ways to
> improve VFIO migration performance. For example, it can be used to
> transfer device metadata to pre-allocate resources in the destination.
> However, for this to work we need to make sure that all initial bytes
> are sent and loaded in the destination before the source VM is stopped.
> 
> Use migration switchover ack capability to make sure a VFIO device's
> initial bytes are sent and loaded in the destination before the source
> stops the VM and attempts to complete the migration.
> This can significantly reduce migration downtime for some devices.
> 
> As precopy support and precopy initial bytes support come together in
> VFIO migration, use x-allow-pre-copy device property to control usage of
> this feature as well.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   docs/devel/vfio-migration.rst | 10 ++++++++
>   include/hw/vfio/vfio-common.h |  2 ++
>   hw/vfio/migration.c           | 48 ++++++++++++++++++++++++++++++++++-
>   3 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
> index e896b2a673..b433cb5bb2 100644
> --- a/docs/devel/vfio-migration.rst
> +++ b/docs/devel/vfio-migration.rst
> @@ -16,6 +16,13 @@ helps to reduce the total downtime of the VM. VFIO devices opt-in to pre-copy
>   support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
>   VFIO_DEVICE_FEATURE_MIGRATION ioctl.
>   
> +When pre-copy is supported, it's possible to further reduce downtime by
> +enabling "switchover-ack" migration capability.
> +VFIO migration uAPI defines "initial bytes" as part of its pre-copy data stream
> +and recommends that the initial bytes are sent and loaded in the destination
> +before stopping the source VM. Enabling this migration capability will
> +guarantee that and thus, can potentially reduce downtime even further.
> +
>   Note that currently VFIO migration is supported only for a single device. This
>   is due to VFIO migration's lack of P2P support. However, P2P support is planned
>   to be added later on.
> @@ -45,6 +52,9 @@ VFIO implements the device hooks for the iterative approach as follows:
>   * A ``save_live_iterate`` function that reads the VFIO device's data from the
>     vendor driver during iterative pre-copy phase.
>   
> +* A ``switchover_ack_needed`` function that checks if the VFIO device uses
> +  "switchover-ack" migration capability when this capability is enabled.
> +
>   * A ``save_state`` function to save the device config space if it is present.
>   
>   * A ``save_live_complete_precopy`` function that sets the VFIO device in
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index a53ecbe2e0..ad0562c8b7 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -69,6 +69,8 @@ typedef struct VFIOMigration {
>       uint64_t mig_flags;
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
> +    bool switchover_ack_needed;

Do we really need the 'switchover_ack_needed' bool ?

It seems that each time it is used in a routine it could be computed
locally with migrate_switchover_ack() and vfio_precopy_supported().
This would simplify the code a bit more.

Thanks,

C.


  
> +    bool initial_data_sent;
>   } VFIOMigration;
>   
>   typedef struct VFIOAddressSpace {
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index cb6923ed3f..ede29ffb5c 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -18,6 +18,8 @@
>   #include "sysemu/runstate.h"
>   #include "hw/vfio/vfio-common.h"
>   #include "migration/migration.h"
> +#include "migration/options.h"
> +#include "migration/savevm.h"
>   #include "migration/vmstate.h"
>   #include "migration/qemu-file.h"
>   #include "migration/register.h"
> @@ -45,6 +47,7 @@
>   #define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
>   #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>   #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> +#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
>   
>   /*
>    * This is an arbitrary size based on migration of mlx5 devices, where typically
> @@ -218,6 +221,7 @@ static void vfio_migration_cleanup(VFIODevice *vbasedev)
>   
>       close(migration->data_fd);
>       migration->data_fd = -1;
> +    migration->switchover_ack_needed = false;
>   }
>   
>   static int vfio_query_stop_copy_size(VFIODevice *vbasedev,
> @@ -350,6 +354,10 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>       if (vfio_precopy_supported(vbasedev)) {
>           int ret;
>   
> +        if (migrate_switchover_ack()) {
> +            migration->switchover_ack_needed = true;
> +        }
> +
>           switch (migration->device_state) {
>           case VFIO_DEVICE_STATE_RUNNING:
>               ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
> @@ -385,6 +393,7 @@ static void vfio_save_cleanup(void *opaque)
>       migration->data_buffer = NULL;
>       migration->precopy_init_size = 0;
>       migration->precopy_dirty_size = 0;
> +    migration->initial_data_sent = false;
>       vfio_migration_cleanup(vbasedev);
>       trace_vfio_save_cleanup(vbasedev->name);
>   }
> @@ -458,10 +467,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>       if (data_size < 0) {
>           return data_size;
>       }
> -    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>   
>       vfio_update_estimated_pending_data(migration, data_size);
>   
> +    if (migration->switchover_ack_needed && !migration->precopy_init_size &&
> +        !migration->initial_data_sent) {
> +        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
> +        migration->initial_data_sent = true;
> +    } else {
> +        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +    }
> +
>       trace_vfio_save_iterate(vbasedev->name, migration->precopy_init_size,
>                               migration->precopy_dirty_size);
>   
> @@ -526,6 +542,10 @@ static int vfio_load_setup(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
>   
> +    if (migrate_switchover_ack() && vfio_precopy_supported(vbasedev)) {
> +        vbasedev->migration->switchover_ack_needed = true;
> +    }
> +
>       return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>                                      vbasedev->migration->device_state);
>   }
> @@ -580,6 +600,23 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>               }
>               break;
>           }
> +        case VFIO_MIG_FLAG_DEV_INIT_DATA_SENT:
> +        {
> +            if (!vbasedev->migration->switchover_ack_needed) {
> +                error_report("%s: Received INIT_DATA_SENT but switchover ack "
> +                             "is not needed", vbasedev->name);
> +                return -EINVAL;
> +            }
> +
> +            ret = qemu_loadvm_approve_switchover();
> +            if (ret) {
> +                error_report(
> +                    "%s: qemu_loadvm_approve_switchover failed, err=%d (%s)",
> +                    vbasedev->name, ret, strerror(-ret));
> +            }
> +
> +            return ret;
> +        }
>           default:
>               error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
>               return -EINVAL;
> @@ -594,6 +631,14 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>       return ret;
>   }
>   
> +static bool vfio_switchover_ack_needed(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return migration->switchover_ack_needed;
> +}
> +
>   static const SaveVMHandlers savevm_vfio_handlers = {
>       .save_setup = vfio_save_setup,
>       .save_cleanup = vfio_save_cleanup,
> @@ -606,6 +651,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
>       .load_state = vfio_load_state,
> +    .switchover_ack_needed = vfio_switchover_ack_needed,
>   };
>   
>   /* ---------------------------------------------------------------------- */


