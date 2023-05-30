Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 090277166CF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:17:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q414t-0000Qg-VU; Tue, 30 May 2023 11:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q414r-0000Kk-RH
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q414n-0006o2-Pn
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685459756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FS8Ey6PVLBucvG0vpdH9OMYB/bCF0IpCLYIIRFnEPOw=;
 b=hV50TpnHAkeMVsE7j1/OXic9AAyqd+UEA9C0u77m4zzDjPLQvmw5jaUUl0YMmQHsnAeARf
 lz8stG7c8zZpgBW2uSiknUvRiaPlU07uNTOQ2R0GL0yHcgBrOpi9U+lYSRmfzIX9NATdjp
 Ho6PM4epkWsDVrhvbZQOJtWCmw0meXU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-a7OyyQMZPNW1cPLOVVuKpg-1; Tue, 30 May 2023 11:15:55 -0400
X-MC-Unique: a7OyyQMZPNW1cPLOVVuKpg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so17516045e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 08:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685459754; x=1688051754;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FS8Ey6PVLBucvG0vpdH9OMYB/bCF0IpCLYIIRFnEPOw=;
 b=QKMWKRY9JAbFPY7Q1E3GjidtiwdQqNAzE9r3SZBgynxT/Qr3i2Uy4mILK+K5lOyVrP
 wqS7FWtktErjVcRXWJtP6cCYBZgy+je9yCi1yAkB6AXsijaEc0jV1LRbWeESR8XFh3S/
 6KVTSD5AW/Lj278E6YB0gCW8TKd4hSGkp6O5czXcrfgcRcqmlohx+Sdg+J4owg5ULy+s
 8Grnj6WvlfB6yYPQ1M/w+dVraxI9zVoAbhAFXteaNrZxOakUCILo4du8q90VY87qSH8E
 oH1sk53bVwfTu2fyud+Q0GkPv1QDOCvoHADtzBFU5a6sxDbFGdmNv1g93dKbPsqDlVkF
 fPIQ==
X-Gm-Message-State: AC+VfDzaGUmqrkj36cbbzoiCpjFV4sa0/y+bvzbpK0r2jzXoizA+9zsw
 EeCLEUWIYWwjY+8oONf1K6rbkbUMv13LwLiIuAkzur08tAnmMlgfPl2Sus0qEjQ26zqUVeeoSZ3
 9IK2W+VWm+JMeX7Q=
X-Received: by 2002:a05:600c:2187:b0:3f5:1240:ace4 with SMTP id
 e7-20020a05600c218700b003f51240ace4mr2027269wme.25.1685459753956; 
 Tue, 30 May 2023 08:15:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/j/8j8iMRiAWI3vNAXjyCsipNKg3hSa8K68mnrVlTPCPhnzlXzlIeVFivSeutkiWbBvs1Mw==
X-Received: by 2002:a05:600c:2187:b0:3f5:1240:ace4 with SMTP id
 e7-20020a05600c218700b003f51240ace4mr2027253wme.25.1685459753653; 
 Tue, 30 May 2023 08:15:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a7bc405000000b003f31cb7a203sm17685449wmi.14.2023.05.30.08.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 08:15:52 -0700 (PDT)
Message-ID: <8ca99fcc-af76-eb33-549e-e69e876ae8b9@redhat.com>
Date: Tue, 30 May 2023 17:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 9/9] vfio/migration: Add support for switchover ack
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
References: <20230530144821.1557-1-avihaih@nvidia.com>
 <20230530144821.1557-10-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230530144821.1557-10-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/30/23 16:48, Avihai Horon wrote:
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


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/devel/vfio-migration.rst | 10 +++++++++
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/migration.c           | 39 ++++++++++++++++++++++++++++++++++-
>   3 files changed, 49 insertions(+), 1 deletion(-)
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
> index a53ecbe2e0..3677aba4f4 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -69,6 +69,7 @@ typedef struct VFIOMigration {
>       uint64_t mig_flags;
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
> +    bool initial_data_sent;
>   } VFIOMigration;
>   
>   typedef struct VFIOAddressSpace {
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index cb6923ed3f..53f5787f0e 100644
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
> @@ -385,6 +388,7 @@ static void vfio_save_cleanup(void *opaque)
>       migration->data_buffer = NULL;
>       migration->precopy_init_size = 0;
>       migration->precopy_dirty_size = 0;
> +    migration->initial_data_sent = false;
>       vfio_migration_cleanup(vbasedev);
>       trace_vfio_save_cleanup(vbasedev->name);
>   }
> @@ -458,10 +462,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>       if (data_size < 0) {
>           return data_size;
>       }
> -    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>   
>       vfio_update_estimated_pending_data(migration, data_size);
>   
> +    if (migrate_switchover_ack() && !migration->precopy_init_size &&
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
> @@ -580,6 +591,24 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>               }
>               break;
>           }
> +        case VFIO_MIG_FLAG_DEV_INIT_DATA_SENT:
> +        {
> +            if (!vfio_precopy_supported(vbasedev) ||
> +                !migrate_switchover_ack()) {
> +                error_report("%s: Received INIT_DATA_SENT but switchover ack "
> +                             "is not used", vbasedev->name);
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
> @@ -594,6 +623,13 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>       return ret;
>   }
>   
> +static bool vfio_switchover_ack_needed(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    return vfio_precopy_supported(vbasedev);
> +}
> +
>   static const SaveVMHandlers savevm_vfio_handlers = {
>       .save_setup = vfio_save_setup,
>       .save_cleanup = vfio_save_cleanup,
> @@ -606,6 +642,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
>       .load_state = vfio_load_state,
> +    .switchover_ack_needed = vfio_switchover_ack_needed,
>   };
>   
>   /* ---------------------------------------------------------------------- */


