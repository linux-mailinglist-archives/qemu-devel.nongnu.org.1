Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8977A67E3
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 17:20:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qicV0-0004cD-3w; Tue, 19 Sep 2023 11:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qicUx-0004bk-6w
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 11:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qicUv-0003dc-Gc
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 11:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695136724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bnFotR2mYg4DXQ7snKnBH/OAblQgb4TWjLBZYhHylWQ=;
 b=D9oYZ5OTJktrXunmzFy6ZH3YyHXCPYaA7R9UGVlN1Bop6ueN8iDypTv4Fs3wO8IAWBxJvK
 kX8CdOHfueihn6KysOKxEBVeDcTfitpQnuFlWbuENIzTnU+xI2NFkoMc0FLnFUvwVbvhFE
 a1u5VRQeX7qY50kDus4CQF0kTYSrJn4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-IHjWnVuLMQCoBuzJiKm18Q-1; Tue, 19 Sep 2023 11:18:42 -0400
X-MC-Unique: IHjWnVuLMQCoBuzJiKm18Q-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-773aeb22094so533172085a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 08:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695136721; x=1695741521;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bnFotR2mYg4DXQ7snKnBH/OAblQgb4TWjLBZYhHylWQ=;
 b=TaGg3VBeJo5J92s2JZ6usT4bgLV0bpQH7M5j81Lhd1WVH8bu58QRkbdsE68eYZRZ5l
 +ruItwqaMe7rdsfXci2rBxynK2+4P4Pj8R3RjycTUdBww+lS/LmVFImDoy/mWAlJ8Uk7
 bryEmNgSGeMf6Vvm4p+BTvcwpiCoYvEDtgnCOPS81ZMDhlbqwmOGvLcJYMCh6E7FMGtx
 suujzdpQ2xBQ7w+S/UnFKrx8EV+j+MuBIvzJM4+sZqbLabfX15/A5LBCVwwMv3MeQd2x
 bO5Bc+VKMkQOo8kTTbb9qw/zS+Z2dWlsFm9ZlkpR1UHKPnJGV3OLyeq+0GLFzzPEldQO
 0TzQ==
X-Gm-Message-State: AOJu0Yw6gOH6CsG9nZp62P0deMj+0A3rGO0kCObucFFA/Q//uOBl1pNr
 dFsPtG/wOv9/Gkp+M+O2QJPJPgT9stsvuBy2FTTYKdMLU0+JJxHIywl/8Y458jt7zl8DyxM9U3y
 orgamq3V/Ja2Wyw8=
X-Received: by 2002:a05:620a:4309:b0:765:aa35:f03f with SMTP id
 u9-20020a05620a430900b00765aa35f03fmr13019849qko.37.1695136721751; 
 Tue, 19 Sep 2023 08:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqZn/EaoMcYwI54ADUv7vGrVM72mEC3aSlJVLsMC+XOrUFDC/Jl6zJYnknHIxtw4+07RkfHQ==
X-Received: by 2002:a05:620a:4309:b0:765:aa35:f03f with SMTP id
 u9-20020a05620a430900b00765aa35f03fmr13019819qko.37.1695136721427; 
 Tue, 19 Sep 2023 08:18:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 i20-20020a05620a145400b0076f18be9a64sm4054637qkl.81.2023.09.19.08.18.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 08:18:41 -0700 (PDT)
Message-ID: <4ffebb9f-8453-169b-f617-05414fc717b4@redhat.com>
Date: Tue, 19 Sep 2023 17:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/4] vfio/pci: use an invalid fd to enable MSI-X
Content-Language: en-US
To: Jing Liu <jing2.liu@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, kevin.tian@intel.com,
 reinette.chatre@intel.com, jing2.liu@linux.intel.com
References: <20230918094507.409050-1-jing2.liu@intel.com>
 <20230918094507.409050-4-jing2.liu@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230918094507.409050-4-jing2.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 9/18/23 11:45, Jing Liu wrote:
> Guests typically enable MSI-X with all of the vectors masked in the MSI-X
> vector table. To match the guest state of device, QEMU enables MSI-X by
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


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
> Changes since v1:
> - Revise Qemu to QEMU. (Cédric)
> - Use g_autofree to automatically release. (Cédric)
> - Just return 'ret' and let the caller of vfio_enable_msix_no_vec()
>    report the error. (Cédric)
> 
> Changes since RFC v1:
> - A new patch. Use an invalid fd to get MSI-X enabled instead of using
>    userspace triggering. (Alex)
> ---
>   hw/vfio/pci.c | 44 ++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 84987e46fd7a..0117f230e934 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -369,6 +369,33 @@ static void vfio_msi_interrupt(void *opaque)
>       notify(&vdev->pdev, nr);
>   }
>   
> +/*
> + * Get MSI-X enabled, but no vector enabled, by setting vector 0 with an invalid
> + * fd to kernel.
> + */
> +static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
> +{
> +    g_autofree struct vfio_irq_set *irq_set = NULL;
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
> +
> +    return ret;
> +}
> +
>   static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>   {
>       struct vfio_irq_set *irq_set;
> @@ -618,6 +645,8 @@ static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>   
>   static void vfio_msix_enable(VFIOPCIDevice *vdev)
>   {
> +    int ret;
> +
>       vfio_disable_interrupts(vdev);
>   
>       vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->msix->entries);
> @@ -640,8 +669,6 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>       vfio_commit_kvm_msi_virq_batch(vdev);
>   
>       if (vdev->nr_vectors) {
> -        int ret;
> -
>           ret = vfio_enable_vectors(vdev, true);
>           if (ret) {
>               error_report("vfio: failed to enable vectors, %d", ret);
> @@ -655,13 +682,14 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
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


