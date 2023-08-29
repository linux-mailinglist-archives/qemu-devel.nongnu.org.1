Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A378C6D3
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:06:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazKy-0007q5-Ep; Tue, 29 Aug 2023 10:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qazKv-0007l9-Vi
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qazKp-0004Qf-Gw
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693317885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hv9HTEz8lQuSWpo7FcTwNXh3SrKySFPAF9vwncfKgnU=;
 b=IszKG8ExuhTyOpENhSS/jgpyph6wnDedyCa1G/z9pjb03obYtmDJOroNaVs24JS+tTO/O+
 PnMmPROYUsYS1llHqx6RWeHNWB5zkhYCWWTdy92FBQWBb3klAn67rN4SPzmW0zjX+mbY9S
 5uZJo4Qzu6oTtm7kzFS/K9zrY9lsCOg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-dSxdcRB_OYiNhuAsGDhzuQ-1; Tue, 29 Aug 2023 10:04:43 -0400
X-MC-Unique: dSxdcRB_OYiNhuAsGDhzuQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-63faa1e03a8so47415456d6.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693317877; x=1693922677;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hv9HTEz8lQuSWpo7FcTwNXh3SrKySFPAF9vwncfKgnU=;
 b=dUfmnvXJtvNYHzERKndYm79fWevPsxKWVAnGO4w6ZXu8ehgo/fCBwcmCSVdtHO/DGg
 leo3XbomO/G5PevAAUSvuUiys828KPO2ueu4pk2SfcuFL+k714inXueV5tWVRWvk6HR0
 H1ZqZVFerJLqhKGe4Jhkct3DGKuJ9Sp7LvUbleeQLQwCJQAl5tfdnkeuyz93imfUcQUN
 dMOiPNb8uJf8tjrWEcUywSW2R3ETodCf1SwWuZHd+FWlvsfK4nrue6FMs4Y54Hldois8
 SFCelnEEUqGw518TIK3uJFzGJpsTLE3DLmIIn9on85xqjuR3TKAq7MH401RsTw//Ewe3
 XduQ==
X-Gm-Message-State: AOJu0Yx7zjEwq6XB2VzuoNDKEiIhBOy3bBtlcfOmg7OFJCb3JZFWOTQs
 vzMvCLiCPhA9639LthvyszSC2iPkgh9FOSu3J5r6lLRO+4butrrKZ3W23D6q2EWAnkzy/awinXQ
 10wIiK7d3u8W9BKU=
X-Received: by 2002:a0c:e114:0:b0:63c:efa5:2860 with SMTP id
 w20-20020a0ce114000000b0063cefa52860mr27587891qvk.25.1693317876783; 
 Tue, 29 Aug 2023 07:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIQJAfpabI2zxoo4p/c7J7QoFTI7sGKswKZxTGy2cRr11FIit2YrHzRr1l8DFwSNm10JEhHw==
X-Received: by 2002:a0c:e114:0:b0:63c:efa5:2860 with SMTP id
 w20-20020a0ce114000000b0063cefa52860mr27587871qvk.25.1693317876517; 
 Tue, 29 Aug 2023 07:04:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a0cf00a000000b0064c107c9679sm3375783qvk.125.2023.08.29.07.04.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:04:36 -0700 (PDT)
Message-ID: <3716c573-fb2e-cc26-d77e-b930353f9b8d@redhat.com>
Date: Tue, 29 Aug 2023 16:04:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 3/4] vfio/pci: use an invalid fd to enable MSI-X
Content-Language: en-US
To: Jing Liu <jing2.liu@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, kevin.tian@intel.com,
 reinette.chatre@intel.com, jing2.liu@linux.intel.com
References: <20230822072927.224803-1-jing2.liu@intel.com>
 <20230822072927.224803-4-jing2.liu@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230822072927.224803-4-jing2.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/22/23 09:29, Jing Liu wrote:
> Guests typically enable MSI-X with all of the vectors masked in the MSI-X
> vector table. To match the guest state of device, Qemu enables MSI-X by

QEMU is preferred to Qemu.

> enabling vector 0 with userspace triggering and immediately release.
> However the release function actually does not release it due to already
> using userspace mode.
> 
> It is no need to enable triggering on host and rely on the mask bit to
> avoid spurious interrupts. Use an invalid fd (i.e. fd = -1) is enough
> to get MSI-X enabled.
> 
> After dynamic MSI-X allocation is supported, the interrupt restoring
> also need use such way to enable MSI-X, therefore, create a function
> for that.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> ---
> Changes since RFC v1:
> - A new patch. Use an invalid fd to get MSI-X enabled instead of using
>    userspace triggering. (Alex)
> ---
>   hw/vfio/pci.c | 50 ++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 31f36d68bb19..e24c21241a0c 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -369,6 +369,39 @@ static void vfio_msi_interrupt(void *opaque)
>       notify(&vdev->pdev, nr);
>   }
>   
> +/*
> + * Get MSI-X enabled, but no vector enabled, by setting vector 0 with an invalid
> + * fd to kernel.
> + */
> +static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)> +{
> +    struct vfio_irq_set *irq_set;

This could be a 'g_autofree' variable.

> +    int ret = 0, argsz;
> +    int32_t *fd;
> +
> +    argsz = sizeof(*irq_set) + sizeof(*fd);
> +
> +    irq_set = g_malloc0(argsz);
> +    irq_set->argsz = argsz;
> +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> +    irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
> +    irq_set->start = 0;
> +    irq_set->count = 1;
> +    fd = (int32_t *)&irq_set->data;
> +    *fd = -1;
> +
> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> +    if (ret) {
> +        error_report("vfio: failed to enable MSI-X with vector 0 trick, %d",
> +                     ret);

The above message seems redundant. I would simply return 'ret' and let
the caller report the error. Same as vfio_enable_vectors().

Thanks,

C.


> +    }
> +
> +    g_free(irq_set);
> +
> +    return ret;
> +}
> +
>   static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>   {
>       struct vfio_irq_set *irq_set;
> @@ -618,6 +651,8 @@ static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>   
>   static void vfio_msix_enable(VFIOPCIDevice *vdev)
>   {
> +    int ret;
> +
>       vfio_disable_interrupts(vdev);
>   
>       vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->msix->entries);
> @@ -640,8 +675,6 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>       vfio_commit_kvm_msi_virq_batch(vdev);
>   
>       if (vdev->nr_vectors) {
> -        int ret;
> -
>           ret = vfio_enable_vectors(vdev, true);
>           if (ret) {
>               error_report("vfio: failed to enable vectors, %d", ret);
> @@ -655,13 +688,14 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>            * MSI-X capability, but leaves the vector table masked.  We therefore
>            * can't rely on a vector_use callback (from request_irq() in the guest)
>            * to switch the physical device into MSI-X mode because that may come a
> -         * long time after pci_enable_msix().  This code enables vector 0 with
> -         * triggering to userspace, then immediately release the vector, leaving
> -         * the physical device with no vectors enabled, but MSI-X enabled, just
> -         * like the guest view.
> +         * long time after pci_enable_msix().  This code sets vector 0 with an
> +         * invalid fd to make the physical device MSI-X enabled, but with no
> +         * vectors enabled, just like the guest view.
>            */
> -        vfio_msix_vector_do_use(&vdev->pdev, 0, NULL, NULL);
> -        vfio_msix_vector_release(&vdev->pdev, 0);
> +        ret = vfio_enable_msix_no_vec(vdev);
> +        if (ret) {
> +            error_report("vfio: failed to enable MSI-X, %d", ret);
> +        }
>       }
>   
>       trace_vfio_msix_enable(vdev->vbasedev.name);


