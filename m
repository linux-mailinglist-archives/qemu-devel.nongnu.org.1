Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F313F7ABAB5
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 22:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjnB4-00042T-0D; Fri, 22 Sep 2023 16:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qjnB1-00041y-BO
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 16:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qjnAv-0004YZ-Nz
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 16:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695416096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfBJXDbgrMm59C75CjqUcq4ggIu3/f2P9NktPmxnUeU=;
 b=gA67zh9hoLKKC8s61LTgEMcNwzfH6totcjOAYmcgXgIvO1r4BMraE/9SyRPXCkFGfyRlfg
 Teh/Wjp3mp3Za/FGPnA6OSJkmg79XDTgs/FmmwqsjmHZzKZopFV1PgG/07XEi6ovuNsqeJ
 CgCfNw2i3qFeDJzLSLA6iNNGVG+bvNo=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-p_hv1HNuOpCnt17ch0gHLg-1; Fri, 22 Sep 2023 16:54:54 -0400
X-MC-Unique: p_hv1HNuOpCnt17ch0gHLg-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-57b6cd1a584so2553165eaf.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 13:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695416093; x=1696020893;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UfBJXDbgrMm59C75CjqUcq4ggIu3/f2P9NktPmxnUeU=;
 b=IC/GFHLZBHJbbYnydVY0nK7TB8Nwmu4qAvZpuSZq1WWgS3Rc3s58/BKYOtvo76eZZ5
 CkBWe8CgQPjDxE5ZpP5l4kEc7NK/atE/r6C7+KbUAbJ/cNFRiNf5TyrvvJnLRoHtJstr
 1wFhPk0Dc4cDe8r4ECqxg7IvLwg8DYwH+uiutWV0ZkDLOJhe7QtIweJYe4vhfv29pIDQ
 IfX7Gu3E3B0RExN//YaxdSBFB/easDbL5BZ9QrRCp8sLO+ZHXUvah5dlCD04uBjeakwC
 2D8Ptbm9E/KiM5t2n0Ps/Hs0ZUBsFx9nm+aJgk5Z7ZVL/AGxsLPbr1/FcpgZq0jyEKzL
 r6tg==
X-Gm-Message-State: AOJu0YybZ2cTf/iPE421wEPSIGAd4EZWTbr+t5cFU2oWhjH45EgtgPFG
 9yLAsHEBZ+3LknJFHRYBIb8gG2nYUySxUvmb/PAB6+nhAyRYam0vfemgv+ljOzE8RmGAogsygHv
 g4An/0ur02BvCT1Q=
X-Received: by 2002:a05:6870:f28b:b0:1d5:f22f:7a00 with SMTP id
 u11-20020a056870f28b00b001d5f22f7a00mr585657oap.27.1695416093558; 
 Fri, 22 Sep 2023 13:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGug8E+su8J0T3CGkhlk334APU6XR/uaRCpeBkfDbYYv0QrxjHkGsLlGFaDxlm9qY2wEYVpLw==
X-Received: by 2002:a05:6870:f28b:b0:1d5:f22f:7a00 with SMTP id
 u11-20020a056870f28b00b001d5f22f7a00mr585645oap.27.1695416093237; 
 Fri, 22 Sep 2023 13:54:53 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 v26-20020a02b91a000000b0042b37dda71asm1160942jan.136.2023.09.22.13.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 13:54:52 -0700 (PDT)
Date: Fri, 22 Sep 2023 14:54:50 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jing Liu <jing2.liu@intel.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@linux.intel.com
Subject: Re: [PATCH v2 2/4] vfio/pci: enable vector on dynamic MSI-X allocation
Message-ID: <20230922145450.22e5b08f.alex.williamson@redhat.com>
In-Reply-To: <20230918094507.409050-3-jing2.liu@intel.com>
References: <20230918094507.409050-1-jing2.liu@intel.com>
 <20230918094507.409050-3-jing2.liu@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 18 Sep 2023 05:45:05 -0400
Jing Liu <jing2.liu@intel.com> wrote:

> The vector_use callback is used to enable vector that is unmasked in
> guest. The kernel used to only support static MSI-X allocation. When
> allocating a new interrupt using "static MSI-X allocation" kernels,
> QEMU first disables all previously allocated vectors and then
> re-allocates all including the new one. The nr_vectors of VFIOPCIDevice
> indicates that all vectors from 0 to nr_vectors are allocated (and may
> be enabled), which is used to to loop all the possibly used vectors
                             ^^ ^^

s/to to/to/

> When, e.g., disabling MSI-X interrupts.
> 
> Extend the vector_use function to support dynamic MSI-X allocation when
> host supports the capability. QEMU therefore can individually allocate
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
> Changes since v1:
> - Revise Qemu to QEMU.
> 
> Changes since RFC v1:
> - Test vdev->msix->noresize to identify the allocation mode. (Alex)
> - Move defer_kvm_irq_routing test out and update nr_vectors in a
>   common place before vfio_enable_vectors(). (Alex)
> - Revise the comments. (Alex)
> ---
>  hw/vfio/pci.c | 44 +++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 60654ca28ab8..84987e46fd7a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -470,6 +470,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>      VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>      VFIOMSIVector *vector;
>      int ret;
> +    int old_nr_vecs = vdev->nr_vectors;

Minor suggestion, it reads slightly better below if this were something
like:

    bool resizing = !!(vdev->nr_vectors < nr + 1);

Then use the bool in place of the nr+1 tests below.  Thanks,

Alex

>  
>      trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
>  
> @@ -512,33 +513,42 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>      }
>  
>      /*
> -     * We don't want to have the host allocate all possible MSI vectors
> -     * for a device if they're not in use, so we shutdown and incrementally
> -     * increase them as needed.
> +     * When dynamic allocation is not supported, we don't want to have the
> +     * host allocate all possible MSI vectors for a device if they're not
> +     * in use, so we shutdown and incrementally increase them as needed.
> +     * nr_vectors represents the total number of vectors allocated.
> +     *
> +     * When dynamic allocation is supported, let the host only allocate
> +     * and enable a vector when it is in use in guest. nr_vectors represents
> +     * the upper bound of vectors being enabled (but not all of the ranges
> +     * is allocated or enabled).
>       */
>      if (vdev->nr_vectors < nr + 1) {
>          vdev->nr_vectors = nr + 1;
> -        if (!vdev->defer_kvm_irq_routing) {
> +    }
> +
> +    if (!vdev->defer_kvm_irq_routing) {
> +        if (vdev->msix->noresize && (old_nr_vecs < nr + 1)) {
>              vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
>              ret = vfio_enable_vectors(vdev, true);
>              if (ret) {
>                  error_report("vfio: failed to enable vectors, %d", ret);
>              }
> -        }
> -    } else {
> -        Error *err = NULL;
> -        int32_t fd;
> -
> -        if (vector->virq >= 0) {
> -            fd = event_notifier_get_fd(&vector->kvm_interrupt);
>          } else {
> -            fd = event_notifier_get_fd(&vector->interrupt);
> -        }
> +            Error *err = NULL;
> +            int32_t fd;
>  
> -        if (vfio_set_irq_signaling(&vdev->vbasedev,
> -                                     VFIO_PCI_MSIX_IRQ_INDEX, nr,
> -                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> -            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +            if (vector->virq >= 0) {
> +                fd = event_notifier_get_fd(&vector->kvm_interrupt);
> +            } else {
> +                fd = event_notifier_get_fd(&vector->interrupt);
> +            }
> +
> +            if (vfio_set_irq_signaling(&vdev->vbasedev,
> +                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
> +                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +            }
>          }
>      }
>  


