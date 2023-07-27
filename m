Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9506765B2F
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 20:09:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP4jt-0007bU-7U; Thu, 27 Jul 2023 13:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qP4ji-0007bC-BB
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 13:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qP4jc-0000AT-IM
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 13:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690478706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ap/tbzOZHSb7q8jApGyzFidDiHSo1f7zBt8xrZetVXM=;
 b=H/PrrxqCAiRDyuRwUzcjYaUKYS3zZlWL+vh438vQ6kcVHaDRETlcmjas9PC8UTPSOZ6RvR
 64A404AwRLUbg1CerO7K7w/Sn46LJoOyiFOXiA0BnLKVl9QWF+mSUurxfW2lFfU7RzGwho
 7Xr85TEuPyJwJNT0S+FQg48NVkxsXr4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-f3ugiuabPLKxYFJWcfpG-w-1; Thu, 27 Jul 2023 13:25:05 -0400
X-MC-Unique: f3ugiuabPLKxYFJWcfpG-w-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-78705f0e3feso74833139f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 10:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690478705; x=1691083505;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ap/tbzOZHSb7q8jApGyzFidDiHSo1f7zBt8xrZetVXM=;
 b=fVv5DmRlGt35cOdBeDgwVVPXMnyDyivSTGWwBc77Ulm3o5iCywUIlr5MhK36tg2pwg
 wTmMYX1icH2V2LaiqjnaLLVuwZWA6Whcxwu9Gtvhdt9MKnzTenJMOcl+f9Yre4BAPjaJ
 DbcMdR25MmgU7D5KJbour7pCPB568vxSQTZ8RnFauQyZzZR0lNiUd8AAfTGR4ztP8A46
 jcCEvfAkA7nToDn/86B7kr/ZcIXz8fjeGeEOr7fhENSut7t7/wciRDYIhsT09/iIC1rh
 z70dRHnfiS6tUrm4Gl9GFQIW0MOBE+IPj1tiB60JlU9QpZmiB0TzFQKV05vqb4uC8UGl
 oPXw==
X-Gm-Message-State: ABy/qLYCbu+n8fnjiu7NEKH4WRbjDYcBcbzRMUQnzeQJKWTggWLLdxiE
 lD94KYme9vPWxB/IFaAHf2y9Not7VaSjqQVJLKMzvGyKGuWj441Eyq8lhqfWLwdwIMPH80/4uZm
 v74dyXPvuIDrTlJY=
X-Received: by 2002:a5e:de0b:0:b0:780:bf50:32ce with SMTP id
 e11-20020a5ede0b000000b00780bf5032cemr143966iok.19.1690478704981; 
 Thu, 27 Jul 2023 10:25:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF9rT5rWbj/+sIvch3Dm/McOsGYT2pRRYiWizj0Lzu9E0NkoEaJJeROwDk/fpeewCAB9I+PqQ==
X-Received: by 2002:a5e:de0b:0:b0:780:bf50:32ce with SMTP id
 e11-20020a5ede0b000000b00780bf5032cemr143956iok.19.1690478704737; 
 Thu, 27 Jul 2023 10:25:04 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 i7-20020a02cc47000000b0042b0ce92dddsm539928jaq.161.2023.07.27.10.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 10:25:04 -0700 (PDT)
Date: Thu, 27 Jul 2023 11:25:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jing Liu <jing2.liu@intel.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com
Subject: Re: [PATCH RFC v1 2/3] vfio/pci: enable vector on dynamic MSI-X
 allocation
Message-ID: <20230727112503.4160f411.alex.williamson@redhat.com>
In-Reply-To: <20230727072410.135743-3-jing2.liu@intel.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-3-jing2.liu@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 27 Jul 2023 03:24:09 -0400
Jing Liu <jing2.liu@intel.com> wrote:

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
>  hw/vfio/pci.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 0c4ac0873d40..8c485636445c 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -512,12 +512,20 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>      }
>  
>      /*
> -     * We don't want to have the host allocate all possible MSI vectors
> -     * for a device if they're not in use, so we shutdown and incrementally
> -     * increase them as needed.
> +     * When dynamic allocation is not supported, we don't want to have the
> +     * host allocate all possible MSI vectors for a device if they're not
> +     * in use, so we shutdown and incrementally increase them as needed.
> +     * And nr_vectors stands for the number of vectors being allocated.

"nr_vectors represents the total number of vectors allocated."

> +     *
> +     * When dynamic allocation is supported, let the host only allocate
> +     * and enable a vector when it is in use in guest. nr_vectors stands
> +     * for the upper bound of vectors being enabled (but not all of the
> +     * ranges is allocated or enabled).

s/stands for/represents/

>       */
> -    if (vdev->nr_vectors < nr + 1) {
> +    if ((vdev->msix->irq_info_flags & VFIO_IRQ_INFO_NORESIZE) &&

Testing vdev->msix->noresize would be cleaner.

> +        (vdev->nr_vectors < nr + 1)) {
>          vdev->nr_vectors = nr + 1;
> +
>          if (!vdev->defer_kvm_irq_routing) {
>              vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
>              ret = vfio_enable_vectors(vdev, true);
> @@ -529,16 +537,22 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>          Error *err = NULL;
>          int32_t fd;
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
>          }

We now have two branches where the bulk of the code is skipped when
defer_kvm_irq_routing is enabled and doing effectively the same update
to nr_vectors otherwise.  This suggests we should move the
defer_kvm_irq_routing test out and create a common place to update
nr_vectors.  Thanks,

Alex


