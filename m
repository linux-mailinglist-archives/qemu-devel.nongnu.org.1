Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ECFA9964F
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 19:17:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7diD-00077S-Pn; Wed, 23 Apr 2025 13:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7di8-00076d-So
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7di5-0000Gk-Tv
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745428593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ElgkcRxoWXg3CjHzL899LzZU7II8t21vGz3HvyEuQWY=;
 b=Fzx1gMnuqYHe2ykNG6D50+oNKrj1zY3Etep+FuPEbp3fsKZW6VYXF8qFu43i1YBerRxS2K
 m17NG849usWg/1/BSJtB7ZYewQ7f03rUYq73ag869BPkOEPQ85yEfyudkIBl+luSLfrT+j
 J0lRVfa8VlCiTMxCps/d3TSvVA3ya+8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-t0u4G0eFNWyLUelfrh76iQ-1; Wed, 23 Apr 2025 13:16:31 -0400
X-MC-Unique: t0u4G0eFNWyLUelfrh76iQ-1
X-Mimecast-MFC-AGG-ID: t0u4G0eFNWyLUelfrh76iQ_1745428586
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39135d31ca4so41354f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 10:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745428586; x=1746033386;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElgkcRxoWXg3CjHzL899LzZU7II8t21vGz3HvyEuQWY=;
 b=I7DU0fa60NZKaNwKMwWX1DSohMqriYWoDDOog3+hOwS1zUHLqzQ3l9QfFUDvBoYdtc
 E8NF5azjk512GViu6jwG/SSMKtVRktW/vXbMoJGxiF7l1FlHNq3tU0esAxGMMiPIZrEy
 YFGrfILvLNIOm6HRniZt1JOhjrAbvWVk6pqBt24Vl+jOIkrFy87i7KITtFiDSLu9hLcu
 5Gaj0k+4ZRd7e8AIBNMhJYYjw1JBdD4QNj9yEfPZ0Jo0PnIegvfn6YPxOU2kV7QSYrjY
 9VQ1FMVwM5Rh4spIblYdlNJozO5q0vXIuhDs+A5wcoTSpiTwoVwsuH/TRlPww0qZqMgc
 Xsqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPJqZzMQwRgRMpsaSb+XD/NFqGK0lzSbmaCcy5ix7VaobZi1jcDUNAi+BcUB3k3XQVY7KU9PAXpzYb@nongnu.org
X-Gm-Message-State: AOJu0YzLuGL8rZa0KPV7InVVN/3xXp3XAsmX/zHvnTDGVWGPa0bYpUl/
 QZyR8Kg/Q6QRnLi3cKOS5JwbFSj5EEa8mKK8pQ88lBwVbpu1aba4MC1YRe3SXfqBEi/xCS23QIi
 Yc7LqDNy+1HvEYwmjTt8kvBdUJlImzkq4G1te8mpSsk9MR6E0B7Xr
X-Gm-Gg: ASbGnctd3/RYhU3GqzC2+aho7zdFxxMdOsgdd/NtoneAM18lYWyrC4SzbHgcC7gK36V
 qSFFzd8x9eSXnKjUUVljQfLw3JxNYzYK4okZlkICOSptWjic+ad7Ae8QZX7/sh+PbD/OzOxFZMF
 /ux5cFO+/BnrTwWVNmsxhMAnTmMdsOOep/AK+oPdtwefVP0vTF1cab/fSdgRcKA4dC5h4//QAqk
 sqVWUb5q124kGMGZ3eY0AqhxpR4iW+4h/rkW3bfrbkrvFxVFbos7HKQaIVofyQvJvdhVwjKVtSt
 WFjKaE2LXU2XWe8KfoDCCMw+OckWL8ixEMuaPgcXGBtfyx0=
X-Received: by 2002:a5d:5f42:0:b0:39c:1f02:44d8 with SMTP id
 ffacd0b85a97d-3a06c6b960fmr7581f8f.4.1745428586051; 
 Wed, 23 Apr 2025 10:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzhuBVGpak7EoWVTuP7grthUTlRT5jUI7SDbVBofU0TxhfjcFU1ELxSvRskuOcPrXgJPX99g==
X-Received: by 2002:a5d:5f42:0:b0:39c:1f02:44d8 with SMTP id
 ffacd0b85a97d-3a06c6b960fmr7544f8f.4.1745428585490; 
 Wed, 23 Apr 2025 10:16:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa5a2300sm19152490f8f.101.2025.04.23.10.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 10:16:24 -0700 (PDT)
Message-ID: <8f579c9b-ab98-406e-bc53-b729f9c48c09@redhat.com>
Date: Wed, 23 Apr 2025 19:16:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] vfio: add vfio_device_get_irq_info() helper
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-10-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250409134814.478903-10-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/9/25 15:48, John Levon wrote:
> Add a helper similar to vfio_device_get_region_info() and use it
> everywhere.
> 
> Replace a couple of needless allocations with stack variables.
> 
> As a side-effect, this fixes a minor error reporting issue in the call
> from vfio_msix_early_setup().
>
> Signed-off-by: John Levon <john.levon@nutanix.com>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Some comments below,


> --->   hw/vfio/ap.c                  | 19 ++++++++++---------
>   hw/vfio/ccw.c                 | 20 +++++++++++---------
>   hw/vfio/device.c              | 15 +++++++++++++++
>   hw/vfio/pci.c                 | 23 +++++++++++------------
>   hw/vfio/platform.c            |  6 +++---
>   include/hw/vfio/vfio-device.h |  3 +++
>   6 files changed, 53 insertions(+), 33 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 4af7379d4f..f311bca5b6 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -74,10 +74,10 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
>       int fd;
> -    size_t argsz;
> +    int ret;
>       IOHandler *fd_read;
>       EventNotifier *notifier;
> -    g_autofree struct vfio_irq_info *irq_info = NULL;
> +    struct vfio_irq_info irq_info;
>       VFIODevice *vdev = &vapdev->vdev;
>   
>       switch (irq) {
> @@ -96,14 +96,15 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>           return false;
>       }
>   
> -    argsz = sizeof(*irq_info);
> -    irq_info = g_malloc0(argsz);
> -    irq_info->index = irq;
> -    irq_info->argsz = argsz;
> +    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
> +
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
> +        return false;
> +    }
>   
> -    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> -              irq_info) < 0 || irq_info->count < 1) {
> -        error_setg_errno(errp, errno, "vfio: Error getting irq info");
> +    if (irq_info.count < 1) {
> +        error_setg_errno(errp, EINVAL, "vfio: Error getting irq info, count=0");

I am not sure using error_setg_errno() is interesting in that case. May be simply
use error_setg(). Same below.


Thanks,

C.



>           return false;
>       }
>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 98aa0000da..dac8769925 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -376,8 +376,8 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>                                              Error **errp)
>   {
>       VFIODevice *vdev = &vcdev->vdev;
> -    g_autofree struct vfio_irq_info *irq_info = NULL;
> -    size_t argsz;
> +    struct vfio_irq_info irq_info;
> +    int ret;
>       int fd;
>       EventNotifier *notifier;
>       IOHandler *fd_read;
> @@ -406,13 +406,15 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>           return false;
>       }
>   
> -    argsz = sizeof(*irq_info);
> -    irq_info = g_malloc0(argsz);
> -    irq_info->index = irq;
> -    irq_info->argsz = argsz;
> -    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> -              irq_info) < 0 || irq_info->count < 1) {
> -        error_setg_errno(errp, errno, "vfio: Error getting irq info");
> +    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
> +
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
> +        return false;
> +    }
> +
> +    if (irq_info.count < 1) {
> +        error_setg_errno(errp, EINVAL, "vfio: Error getting irq info, count=0");
>           return false;
>       }
>   
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index b9473878fc..2966171118 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -185,6 +185,21 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>       return false;
>   }
>   
> +int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> +                             struct vfio_irq_info *info)
> +{
> +    int ret;
> +
> +    memset(info, 0, sizeof(*info));
> +
> +    info->argsz = sizeof(*info);
> +    info->index = index;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
>   int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info)
>   {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 090b2f2ef0..ac53c43f2b 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1555,8 +1555,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       uint16_t ctrl;
>       uint32_t table, pba;
>       int ret, fd = vdev->vbasedev.fd;
> -    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> -                                      .index = VFIO_PCI_MSIX_IRQ_INDEX };
> +    struct vfio_irq_info irq_info;
>       VFIOMSIXInfo *msix;
>   
>       pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
> @@ -1593,7 +1592,8 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
>       msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
>   
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
> +                                   &irq_info);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
>           g_free(msix);
> @@ -2737,7 +2737,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       g_autofree struct vfio_region_info *reg_info = NULL;
> -    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
> +    struct vfio_irq_info irq_info;
>       int i, ret = -1;
>   
>       /* Sanity check device */
> @@ -2798,12 +2798,10 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>           }
>       }
>   
> -    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
> -
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
>       if (ret) {
>           /* This can fail for an old kernel or legacy PCI dev */
> -        trace_vfio_populate_device_get_irq_info_failure(strerror(errno));
> +        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
>       } else if (irq_info.count == 1) {
>           vdev->pci_aer = true;
>       } else {
> @@ -2912,17 +2910,18 @@ static void vfio_req_notifier_handler(void *opaque)
>   
>   static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>   {
> -    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> -                                      .index = VFIO_PCI_REQ_IRQ_INDEX };
> +    struct vfio_irq_info irq_info;
>       Error *err = NULL;
>       int32_t fd;
> +    int ret;
>   
>       if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
>           return;
>       }
>   
> -    if (ioctl(vdev->vbasedev.fd,
> -              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
> +    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX,
> +                                   &irq_info);
> +    if (ret < 0 || irq_info.count < 1) {
>           return;
>       }
>   
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 877d69b7aa..fd176c18a4 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -475,10 +475,10 @@ static bool vfio_populate_device(VFIODevice *vbasedev, Error **errp)
>       QSIMPLEQ_INIT(&vdev->pending_intp_queue);
>   
>       for (i = 0; i < vbasedev->num_irqs; i++) {
> -        struct vfio_irq_info irq = { .argsz = sizeof(irq) };
> +        struct vfio_irq_info irq;
> +
> +        ret = vfio_device_get_irq_info(vbasedev, i, &irq);
>   
> -        irq.index = i;
> -        ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, &irq);
>           if (ret) {
>               error_setg_errno(errp, -ret, "failed to get device irq info");
>               goto irq_err;
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 3563a82ede..9522a09c48 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -144,6 +144,9 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>   int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>                                        uint32_t subtype, struct vfio_region_info **info);
>   bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
> +
> +int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> +                                struct vfio_irq_info *info);
>   #endif
>   
>   /* Returns 0 on success, or a negative errno. */


