Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89738ABDA57
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 15:56:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNSB-0002lX-Ka; Tue, 20 May 2025 09:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHNRr-0002aX-Hv
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHNRh-00054z-Cu
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747749343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0UIu5cIKB7GulYb6iPgmmImVRoyi4Q98MLhZOYEe/Mk=;
 b=A0BPFhv7/N1AIERgWFWuN3QehhVnc6S6vaE130CHX7BUpglL2fKzoWAW9z59aYNMqIarDR
 5Qeo939eaYBh39L9YyJ4EV1sFu9Jm3t3jALkZiT5SWPbDLWzWK3eineP2TzfjHJZNTAiP1
 g6N50VQ02uPGCE2qNma8PWN5kfZ9OAQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-OnrrjvyMNZegrOfol9wxYg-1; Tue, 20 May 2025 09:55:42 -0400
X-MC-Unique: OnrrjvyMNZegrOfol9wxYg-1
X-Mimecast-MFC-AGG-ID: OnrrjvyMNZegrOfol9wxYg_1747749341
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a34f19c977so2708056f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 06:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747749341; x=1748354141;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UIu5cIKB7GulYb6iPgmmImVRoyi4Q98MLhZOYEe/Mk=;
 b=Jtg/rhOslgbl2szf89F7kAafI/2SvLkH0wW9IT+UiA641RS7JToTPeE06cQ/me8bCk
 CxYMUH8KgA33C1bSSN1IYY3Riqxv9YQTJfUb4IY02rLCh18PZHXGwetSqI+9i0GMvf30
 Br/QawbB51PiV6KMBaJhXaw0sVN2btbiEEQqJKrELAox54BbYKAPJhzaCbu82WJhLz5W
 dEahqhsNmG4ses8IWgaWPVNrxHhT5k9yp5PJztAQC9s/KmitZrPdi+iOdwn94S10bkwy
 n05gRZc+cEn9LGGiTRjP9s3X3D+Wa+99LIEa57GH3ifBzYOgrrAlrjQut/xAGNYg7jZc
 YnwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYEJ1hA6zvqQXSgB7Wn+knVYNdk+jFEGhr1LwCTaEahPhBYxa7CvVvgK2yHciIKs32dTjWgxXvwy89@nongnu.org
X-Gm-Message-State: AOJu0Yx454MF7cAMM6cVmK1d5FGn2iybuSterJJ8/LpnByg8fhgMqVrv
 AZg/v6I5gucq1A2CSmWPgyBAj16OcQ7gWbmHMY2aqQAsEqCoOe8+kgABH7SnWQc9FM9ALcDigkO
 MDzuxoIxHq6ClwxqUo2WSWQk/l0+nWD3tpkSB/ZNvLRopa4KCNEInlV0a
X-Gm-Gg: ASbGncuqEa12f/w7cJapYlPchdyF433L3I636L7Tkc+40HTgntb47l2zzy9k6xZIIvL
 t5KJe656F3DE9XpUM4mLfjDby1MHM0YoyEsH7PjxTxV6oCgRHYpOPTDAlQNPYZ26G5seq+IVSb0
 +2zbe32Z4zL2KtyG/wiJMLVBGxpkiOLbCe0gxOVcCxkqbEcgsN1cYodZ/8rZ5jfD4T6KmrpwcfX
 E/22v8QjWpEtoiUygNKbQAmIKbG/7IAqjL6kyYpwS+FeEt6nbUhaqBTG/JoaP8xyOgZ3tt4QNuc
 hTkIqGL+KDdWdZPmeW5es9erryZZI+QmAsp3NaU4ZIwWy+YCzg==
X-Received: by 2002:a05:6000:1886:b0:3a3:7847:8d4b with SMTP id
 ffacd0b85a97d-3a3784790f8mr3523148f8f.26.1747749340659; 
 Tue, 20 May 2025 06:55:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkL7cgaCIcZMJ0jM3IEf3mH8v7/KrU9Zk1Ch3hkoLkq0EsYk+aIRHeQWAZ3wVyc7fnub/btg==
X-Received: by 2002:a05:6000:1886:b0:3a3:7847:8d4b with SMTP id
 ffacd0b85a97d-3a3784790f8mr3523123f8f.26.1747749340217; 
 Tue, 20 May 2025 06:55:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca62b5dsm16806960f8f.55.2025.05.20.06.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 06:55:39 -0700 (PDT)
Message-ID: <c92954d8-f70b-470a-9e12-890c9bf63d4c@redhat.com>
Date: Tue, 20 May 2025 15:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 34/42] vfio/iommufd: invariant device name
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-35-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-35-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/12/25 17:32, Steve Sistare wrote:
> cpr-transfer will use the device name as a key to find the value
> of the device descriptor in new QEMU.  However, if the descriptor
> number is specified by a command-line fd parameter, then
> vfio_device_get_name creates a name that includes the fd number.
> This causes a chicken-and-egg problem: new QEMU must know the fd
> number to construct a name to find the fd number.
> 
> To fix, create an invariant name based on the id command-line
> parameter.  If id is not defined, add a CPR blocker.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/cpr.c              | 21 +++++++++++++++++++++
>   hw/vfio/device.c           | 10 ++++------
>   hw/vfio/iommufd.c          |  2 ++
>   include/hw/vfio/vfio-cpr.h |  4 ++++
>   4 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 6081a89..7609c62 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -11,6 +11,7 @@
>   #include "hw/vfio/pci.h"
>   #include "hw/pci/msix.h"
>   #include "hw/pci/msi.h"
> +#include "migration/blocker.h"
>   #include "migration/cpr.h"
>   #include "qapi/error.h"
>   #include "system/runstate.h"
> @@ -184,3 +185,23 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
>           VMSTATE_END_OF_LIST()
>       }
>   };
> +
> +bool vfio_cpr_set_device_name(VFIODevice *vbasedev, Error **errp)
> +{
> +    if (vbasedev->dev->id) {
> +        vbasedev->name = g_strdup(vbasedev->dev->id);
> +        return true;
> +    } else {
> +        /*
> +         * Assign a name so any function printing it will not break, but the
> +         * fd number changes across processes, so this cannot be used as an
> +         * invariant name for CPR.
> +         */
> +        vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);

The code above should be in vfio_device_get_name() proposed in its own path.


> +        error_setg(&vbasedev->cpr.id_blocker,
> +                   "vfio device with fd=%d needs an id property",
> +                   vbasedev->fd);
> +        return migrate_add_blocker_modes(&vbasedev->cpr.id_blocker, errp,
> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;

The cpr blocker should proposed in a second patch, maybe with a small
wrapper to set the 'Error *'.


Thanks,

C.



> +    }
> +}
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 9fba2c7..8e9de68 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -28,6 +28,7 @@
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qemu/units.h"
> +#include "migration/cpr.h"
>   #include "monitor/monitor.h"
>   #include "vfio-helpers.h"
>   
> @@ -284,6 +285,7 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>   {
>       ERRP_GUARD();
>       struct stat st;
> +    bool ret = true;
>   
>       if (vbasedev->fd < 0) {
>           if (stat(vbasedev->sysfsdev, &st) < 0) {
> @@ -300,16 +302,12 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>               error_setg(errp, "Use FD passing only with iommufd backend");
>               return false;
>           }
> -        /*
> -         * Give a name with fd so any function printing out vbasedev->name
> -         * will not break.
> -         */
>           if (!vbasedev->name) {
> -            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
> +            ret = vfio_cpr_set_device_name(vbasedev, errp);
>           }
>       }
>   
> -    return true;
> +    return ret;
>   }
>   
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 8661947..ea99b8d 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,6 +25,7 @@
>   #include "system/reset.h"
>   #include "qemu/cutils.h"
>   #include "qemu/chardev_open.h"
> +#include "migration/blocker.h"
>   #include "pci.h"
>   #include "vfio-iommufd.h"
>   #include "vfio-helpers.h"
> @@ -669,6 +670,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>       iommufd_cdev_container_destroy(container);
>       vfio_address_space_put(space);
>   
> +    migrate_del_blocker(&vbasedev->cpr.id_blocker);
>       iommufd_cdev_unbind_and_disconnect(vbasedev);
>       close(vbasedev->fd);
>   }
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 765e334..d06d117 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -23,12 +23,14 @@ typedef struct VFIOContainerCPR {
>   typedef struct VFIODeviceCPR {
>       bool reused;
>       Error *mdev_blocker;
> +    Error *id_blocker;
>   } VFIODeviceCPR;
>   
>   struct VFIOContainer;
>   struct VFIOContainerBase;
>   struct VFIOGroup;
>   struct VFIOPCIDevice;
> +struct VFIODevice;
>   
>   bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>                                           Error **errp);
> @@ -59,4 +61,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>   
>   extern const VMStateDescription vfio_cpr_pci_vmstate;
>   
> +bool vfio_cpr_set_device_name(struct VFIODevice *vbasedev, Error **errp);
> +
>   #endif /* HW_VFIO_VFIO_CPR_H */


