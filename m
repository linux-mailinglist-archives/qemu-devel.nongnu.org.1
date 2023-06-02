Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1177F72047D
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q55m3-0000jA-4a; Fri, 02 Jun 2023 10:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q55m0-0000ir-86
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q55lx-00059o-4y
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685716135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w388yXRm1W+SGVWDcePVzw1V1b/Fupk4hRXwdoEAYts=;
 b=LMy3lPRQFNIJLiFNR578DZVue2gheRUPHRKUgdY9FhNO1I5o1m+CTJSrJHIJbcTsCASsi1
 MzIwcbYetCpJAVdgx9BzE9LZl++MRvIUvxNcxVVvguwOjQaLma/wkLtnzQ+tTXM33Hn265
 oBAidwXTMKUDdHZqtLr1PsfC6WwBGb4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-fcevGItiPiO0RtReEr7d9g-1; Fri, 02 Jun 2023 10:28:54 -0400
X-MC-Unique: fcevGItiPiO0RtReEr7d9g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-62609400a3bso31328636d6.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 07:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685716134; x=1688308134;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w388yXRm1W+SGVWDcePVzw1V1b/Fupk4hRXwdoEAYts=;
 b=LZ3fdlf9NOukJ5RRv1yeYZSbbIwY6I6I7iqCsLqb6Y7G/bmybQDoa39tW7aI8hUwU6
 3zWOm4wFUKqsxeQX0qLSgQWCERTaPJNgkE46YxgYrfIsBdvUVFMUYakGDQhkQZFf1gHA
 TP4H184xiX4T5HA2fYfmKy2H3RccxaBUQuPdIzOnrNE1DwVDEeegvWwe1sHdbq0GUVrw
 8M4iwmGybKmSnOzaCMwX24A+gjtsplr5+swjoKItJS+RxT1whVWIL0/7LuqK1stC2YnK
 1Ghs1VHRkDIW392SfSQlqrdtXd+flEwYfkwmYWxAVriuU+Pf3Ys0RCCxKQemVF3O16p0
 Ay7w==
X-Gm-Message-State: AC+VfDyTPM2+MXOcLmsYHfE4HBLG8sc7doqCX7xrWcTDNTNCTcwuO/ea
 dmlJ2QqVd4ctIeZmh2bwT167eEjbHwdPw1gweqvPItV6fSIEVXSdnVl98RRwltn6UY6c8GSwq9C
 0w5nONVyGSBnLe+o=
X-Received: by 2002:a05:6214:ca4:b0:626:1b13:34a9 with SMTP id
 s4-20020a0562140ca400b006261b1334a9mr16333961qvs.54.1685716133750; 
 Fri, 02 Jun 2023 07:28:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6g6Q60iz1XYaY9poiRONXHWuO7Mq+so59tR25k/Ri4byReHONn2SPYcq1xd0z4gSwLt7D6vA==
X-Received: by 2002:a05:6214:ca4:b0:626:1b13:34a9 with SMTP id
 s4-20020a0562140ca400b006261b1334a9mr16333941qvs.54.1685716133496; 
 Fri, 02 Jun 2023 07:28:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a0cf553000000b006262f1a7334sm855525qvm.128.2023.06.02.07.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 07:28:52 -0700 (PDT)
Message-ID: <c272e7b2-4b72-fc7f-49ed-e1fec60e1aa3@redhat.com>
Date: Fri, 2 Jun 2023 16:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] s390x/ap: Wire up the device request notifier
 interface
Content-Language: en-US
To: Tony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, fiuczy@linux.ibm.com, thuth@redhat.com,
 farman@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20230602141125.448833-1-akrowiak@linux.ibm.com>
 <20230602141125.448833-3-akrowiak@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230602141125.448833-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hello Tony,

On 6/2/23 16:11, Tony Krowiak wrote:
> Let's wire up the device request notifier interface to handle device unplug
> requests for AP.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Link: https://lore.kernel.org/qemu-devel/20230530225544.280031-1-akrowiak@linux.ibm.com/
> ---
>   hw/vfio/ap.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 113 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index e0dd561e85a3..6e21d1da5a70 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -18,6 +18,8 @@
>   #include "hw/vfio/vfio-common.h"
>   #include "hw/s390x/ap-device.h"
>   #include "qemu/error-report.h"
> +#include "qemu/event_notifier.h"
> +#include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   #include "qemu/option.h"
>   #include "qemu/config-file.h"
> @@ -33,6 +35,7 @@
>   struct VFIOAPDevice {
>       APDevice apdev;
>       VFIODevice vdev;
> +    EventNotifier req_notifier;
>   };
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
> @@ -84,10 +87,110 @@ static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
>       return vfio_get_group(groupid, &address_space_memory, errp);
>   }
>   
> +static void vfio_ap_req_notifier_handler(void *opaque)
> +{
> +    VFIOAPDevice *vapdev = opaque;
> +    Error *err = NULL;
> +
> +    if (!event_notifier_test_and_clear(&vapdev->req_notifier)) {
> +        return;
> +    }
> +
> +    qdev_unplug(DEVICE(vapdev), &err);
> +
> +    if (err) {
> +        warn_reportf_err(err, VFIO_MSG_PREFIX, vapdev->vdev.name);
> +    }
> +}
> +
> +static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
> +                                          unsigned int irq, Error **errp)
> +{
> +    int fd;
> +    size_t argsz;
> +    IOHandler *fd_read;
> +    EventNotifier *notifier;
> +    struct vfio_irq_info *irq_info;
> +    VFIODevice *vdev = &vapdev->vdev;
> +
> +    switch (irq) {

Do you have plan for more interrupts ? If not, you could convert the
'switch' statement to a simple 'if' and remove the fd_read variable.

> +    case VFIO_AP_REQ_IRQ_INDEX:
> +        notifier = &vapdev->req_notifier;
> +        fd_read = vfio_ap_req_notifier_handler;
> +        break;
> +    default:
> +        error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
> +        return;
> +    }
> +
> +    if (vdev->num_irqs < irq + 1) {
> +        error_setg(errp, "vfio: IRQ %u not available (number of irqs %u)",
> +                   irq, vdev->num_irqs);
> +        return;
> +    }
> +
> +    argsz = sizeof(*irq_info);
> +    irq_info = g_malloc0(argsz);
> +    irq_info->index = irq;
> +    irq_info->argsz = argsz;
> +
> +    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> +              irq_info) < 0 || irq_info->count < 1) {
> +        error_setg_errno(errp, errno, "vfio: Error getting irq info");
> +        goto out_free_info;
> +    }
> +
> +    if (event_notifier_init(notifier, 0)) {
> +        error_setg_errno(errp, errno,
> +                         "vfio: Unable to init event notifier for irq (%d)",
> +                         irq);
> +        goto out_free_info;
> +    }
> +
> +    fd = event_notifier_get_fd(notifier);
> +    qemu_set_fd_handler(fd, fd_read, NULL, vapdev);
> +
> +    if (vfio_set_irq_signaling(vdev, irq, 0, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
> +                               errp)) {
> +        qemu_set_fd_handler(fd, NULL, NULL, vapdev);
> +        event_notifier_cleanup(notifier);
> +    }
> +
> +out_free_info:
> +    g_free(irq_info);
> +
> +}
> +
> +static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
> +                                            unsigned int irq)
> +{
> +    Error *err = NULL;
> +    EventNotifier *notifier;
> +
> +    switch (irq) {
> +    case VFIO_AP_REQ_IRQ_INDEX:
> +        notifier = &vapdev->req_notifier;
> +        break;
> +    default:
> +        error_report("vfio: Unsupported device irq(%d)", irq);
> +        return;
> +    }
> +
> +    if (vfio_set_irq_signaling(&vapdev->vdev, irq, 0,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
> +        warn_reportf_err(err, VFIO_MSG_PREFIX, vapdev->vdev.name);
> +    }
> +
> +    qemu_set_fd_handler(event_notifier_get_fd(notifier),
> +                        NULL, NULL, vapdev);
> +    event_notifier_cleanup(notifier);
> +}
> +
>   static void vfio_ap_realize(DeviceState *dev, Error **errp)
>   {
>       int ret;
>       char *mdevid;
> +    Error *err = NULL;
>       VFIOGroup *vfio_group;
>       APDevice *apdev = AP_DEVICE(dev);
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> @@ -116,6 +219,15 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>           goto out_get_dev_err;
>       }
>   
> +    vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
> +    if (err) {
> +        /*
> +         * Report this error, but do not make it a failing condition.
> +         * Lack of this IRQ in the host does not prevent normal operation.
> +         */
> +        error_report_err(err);

May be issue a warning instead ?

Thanks,

C.

> +    }
> +
>       return;
>   
>   out_get_dev_err:
> @@ -129,6 +241,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
>       VFIOGroup *group = vapdev->vdev.group;
>   
> +    vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
>       vfio_ap_put_device(vapdev);
>       vfio_put_group(group);
>   }


