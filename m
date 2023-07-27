Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD21765A4D
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:31:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP4SY-0000S5-Sy; Thu, 27 Jul 2023 13:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qP4SW-0000Rl-Uf
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 13:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qP4SV-0002st-5i
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 13:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690477645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hvhGvtYTYNVsf2Z9Pd8MzKhHf/9qfW2SX9JhdGD21cA=;
 b=QgzjBmzaFdYnZFJzeR9ZzQVmVBwkXt/Zyz9fit9kWWZtViIrnocviQLpm5feSZxjkLTlb/
 9oI3O06BcT1+Iz5kNR1CjUNfuOnLELwNWVuadoiXPUt0KNrQnlFzbJPKX8AwG7W0wCMoyJ
 NKR7OiprwmUAxbmPm2LyFyeUzKhaXVQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-bVkPhh7BO_OH5mfTu5nAFw-1; Thu, 27 Jul 2023 13:07:23 -0400
X-MC-Unique: bVkPhh7BO_OH5mfTu5nAFw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63cf5bb17c6so14041326d6.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 10:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690477643; x=1691082443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hvhGvtYTYNVsf2Z9Pd8MzKhHf/9qfW2SX9JhdGD21cA=;
 b=e2df0PfajK3rtyAy4gxqUHpiVxdz1453rNnCArw4sSpb0o6y1xEFNjXocl1yoiwrMR
 8LWZkl0FAcYxRAO5usngtorTYhSBPMJ8PEeiwoijGYXNYqViaKT1hXPHXQMRVUrzILwX
 ktLYN4DKskpKBVNGLeihSVVH9QoC+yYaMo/qQ0fFPKY0MakGASfI1ITJjdbbXSrRYJeS
 y1q6/zGW+AsZPLN0O53UaQBDPoyhOfuRTra9DrsG61ahvVmrxoYT1zaSxq3/yIiIqV4f
 zqg+IXz8pIoRPtRatF+8OUiezOHTNKYWZHvAQT9CIppUZ4wKSYx/mfHISQoYoTWYIpwa
 MftQ==
X-Gm-Message-State: ABy/qLbN7e+VXuYIdoFIFk68zPiltwR9PFK+3k7ZED6CYQerKdsH0D1E
 Cznack4cdGrES2pTKX8odk2hwNzv0mS2gpChBu/t7A7COIWVeBtn++pWulE3yau8ysB+L2rzhpW
 3BXRkNclDlT8lQFs=
X-Received: by 2002:ad4:4d50:0:b0:63d:2a59:e433 with SMTP id
 m16-20020ad44d50000000b0063d2a59e433mr19170qvm.25.1690477643316; 
 Thu, 27 Jul 2023 10:07:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEo3DLRt1tQDlni/FimnuvdUKaaGbyWEcXI5GbtPVrgSdUa6xk+MVnhzQYKhZ1CyhRwJSDU7Q==
X-Received: by 2002:ad4:4d50:0:b0:63d:2a59:e433 with SMTP id
 m16-20020ad44d50000000b0063d2a59e433mr19144qvm.25.1690477642857; 
 Thu, 27 Jul 2023 10:07:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 f30-20020a0caa9e000000b0063612e03433sm544449qvb.101.2023.07.27.10.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 10:07:22 -0700 (PDT)
Message-ID: <861636c9-1368-6250-ea91-db83887db32a@redhat.com>
Date: Thu, 27 Jul 2023 19:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v1 2/3] vfio/pci: enable vector on dynamic MSI-X
 allocation
To: Jing Liu <jing2.liu@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, kevin.tian@intel.com,
 reinette.chatre@intel.com
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-3-jing2.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230727072410.135743-3-jing2.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/27/23 09:24, Jing Liu wrote:
> The vector_use callback is used to enable vector that is unmasked in
> guest. The kernel used to only support static MSI-X allocation. When
> allocating a new interrupt using "static MSI-X allocation" kernels,
> Qemu first disables all previously allocated vectors and then
> re-allocates all including the new one. The nr_vectors of VFIOPCIDevice
> indicates that all vectors from 0 to nr_vectors are allocated (and may
> be enabled), which is used to to loop all the possibly used vectors
> When, e.g., disabling MSI-X interrupts.
> 
> Extend the vector_use function to support dynamic MSI-X allocation when
> host supports the capability. Qemu therefore can individually allocate
> and enable a new interrupt without affecting others or causing interrupts
> lost during runtime.
> 
> Utilize nr_vectors to calculate the upper bound of enabled vectors in
> dynamic MSI-X allocation mode since looping all msix_entries_nr is not
> efficient and unnecessary.
> 
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>   hw/vfio/pci.c | 40 +++++++++++++++++++++++++++-------------
>   1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 0c4ac0873d40..8c485636445c 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -512,12 +512,20 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>       }
>   
>       /*
> -     * We don't want to have the host allocate all possible MSI vectors
> -     * for a device if they're not in use, so we shutdown and incrementally
> -     * increase them as needed.
> +     * When dynamic allocation is not supported, we don't want to have the
> +     * host allocate all possible MSI vectors for a device if they're not
> +     * in use, so we shutdown and incrementally increase them as needed.
> +     * And nr_vectors stands for the number of vectors being allocated.
> +     *
> +     * When dynamic allocation is supported, let the host only allocate
> +     * and enable a vector when it is in use in guest. nr_vectors stands
> +     * for the upper bound of vectors being enabled (but not all of the
> +     * ranges is allocated or enabled).
>        */
> -    if (vdev->nr_vectors < nr + 1) {
> +    if ((vdev->msix->irq_info_flags & VFIO_IRQ_INFO_NORESIZE) &&

I would add a small helper for this test: vfio_msix_can_alloc_dyn(vdev)

Thanks,

C.


> +        (vdev->nr_vectors < nr + 1)) {
>           vdev->nr_vectors = nr + 1;
> +
>           if (!vdev->defer_kvm_irq_routing) {
>               vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
>               ret = vfio_enable_vectors(vdev, true);
> @@ -529,16 +537,22 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>           Error *err = NULL;
>           int32_t fd;
>   
> -        if (vector->virq >= 0) {
> -            fd = event_notifier_get_fd(&vector->kvm_interrupt);
> -        } else {
> -            fd = event_notifier_get_fd(&vector->interrupt);
> -        }
> +        if (!vdev->defer_kvm_irq_routing) {
> +            if (vector->virq >= 0) {
> +                fd = event_notifier_get_fd(&vector->kvm_interrupt);
> +            } else {
> +                fd = event_notifier_get_fd(&vector->interrupt);
> +            }
>   
> -        if (vfio_set_irq_signaling(&vdev->vbasedev,
> -                                     VFIO_PCI_MSIX_IRQ_INDEX, nr,
> -                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> -            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +            if (vfio_set_irq_signaling(&vdev->vbasedev,
> +                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
> +                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +            }
> +        }
> +        /* Increase for dynamic allocation case. */
> +        if (vdev->nr_vectors < nr + 1) {
> +            vdev->nr_vectors = nr + 1;
>           }
>       }
>   


