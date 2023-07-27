Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DF2765A53
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:33:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP4jZ-0007R4-7l; Thu, 27 Jul 2023 13:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qP4jR-0007OY-H3
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 13:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qP4jP-0008OA-Rv
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 13:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690478693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcG8beHzZDHXqkSM7Vc7O5vqjWiuycgGz4tYMmyyhfU=;
 b=CSeDYqZ+8F/yLhspR+A3NwfktGNgmWzd1h26bNJ7wgoyLuo+cytp1C6+xTlpQEvyy1dwiE
 TWGWZXQsgQ8fhX4khsxVQw1AZWAFTgNhfZPbEs//cg6IB2iQ35/aanlomh1pYsuCsgw152
 VqZXYsxYblaQLn9Qz3CxayXxM/93nsc=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-Wgy9Ca85Ms2bdPiGoyglgQ-1; Thu, 27 Jul 2023 13:24:51 -0400
X-MC-Unique: Wgy9Ca85Ms2bdPiGoyglgQ-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-786a6443490so75498539f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 10:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690478690; x=1691083490;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gcG8beHzZDHXqkSM7Vc7O5vqjWiuycgGz4tYMmyyhfU=;
 b=Hs+BG5YJRZ3LYbm0YXfVFRw3bKfH45WoDBedUOirl2yyxwURCscyrh5hfMA/xIAA4A
 tsAUuBXlOGfN8Cb4X8ca9mIkbn9S5G2u97K01VhV2OTmtAb3Yh3UVzeXXOT0/DY8UXfF
 uJFrkQS5QfeOTGxs/6LUvdQlcg7l56x4SFn7KVXRXtYUcN/FAmYqNo9biK1xfR9aH42a
 l0mwko7C6CAeBJfniHkaeqF2LVRgPK93IctHGErzcnHo/GL4mZbcv2DhW0LmaB+Vt8I3
 /Xt2YXu2K9OFmNOwmJ8ZhrbtEA8rtWmrCieA/IQcIw4rBl4vQGiJ6jOFKdR6Gq02DSx9
 5DQA==
X-Gm-Message-State: ABy/qLb8gsZXhdAojVQ+0F/Shcj1dbvPWMPIDME9/kLIXDy/6NlLDGIL
 Cl89HFe0DbchtwRpCDQ/Zre1WlsxmHFpdf0Z7ZLMEBOzp5azcR/GVbvNjlLc3Qt0VqiEpYnU/Fb
 moyPZ5SzA9fpdBcw=
X-Received: by 2002:a6b:e213:0:b0:785:ccfe:b68f with SMTP id
 z19-20020a6be213000000b00785ccfeb68fmr141753ioc.4.1690478690498; 
 Thu, 27 Jul 2023 10:24:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGRhJo5AEEbzkTL/Vu/kLbfiWEUu/qg3DZFwsiu5v08JW9m1iRGmps+Ne2mRgJ2/uMiqvLoZA==
X-Received: by 2002:a6b:e213:0:b0:785:ccfe:b68f with SMTP id
 z19-20020a6be213000000b00785ccfeb68fmr141742ioc.4.1690478690242; 
 Thu, 27 Jul 2023 10:24:50 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 t1-20020a02cca1000000b0042b1061c6a8sm557168jap.84.2023.07.27.10.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 10:24:49 -0700 (PDT)
Date: Thu, 27 Jul 2023 11:24:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jing Liu <jing2.liu@intel.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com
Subject: Re: [PATCH RFC v1 3/3] vfio/pci: dynamic MSI-X allocation in
 interrupt restoring
Message-ID: <20230727112447.4f9e5bc8.alex.williamson@redhat.com>
In-Reply-To: <20230727072410.135743-4-jing2.liu@intel.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-4-jing2.liu@intel.com>
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

On Thu, 27 Jul 2023 03:24:10 -0400
Jing Liu <jing2.liu@intel.com> wrote:

> During migration restoring, vfio_enable_vectors() is called to restore
> enabling MSI-X interrupts for assigned devices. It sets the range from 0
> to nr_vectors to kernel to enable MSI-X and the vectors unmasked in
> guest. During the MSI-X enabling, all the vectors within the range are
> allocated according to the ioctl().
> 
> When dynamic MSI-X allocation is supported, we only want the guest
> unmasked vectors being allocated and enabled. Therefore, Qemu can first
> set vector 0 to enable MSI-X and after that, all the vectors can be
> allocated in need.
> 
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> ---
>  hw/vfio/pci.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8c485636445c..43ffacd5b36a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -375,6 +375,38 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>      int ret = 0, i, argsz;
>      int32_t *fds;
>  
> +    /*
> +     * If dynamic MSI-X allocation is supported, the vectors to be allocated
> +     * and enabled can be scattered. Before kernel enabling MSI-X, setting
> +     * nr_vectors causes all these vectors being allocated on host.

s/being/to be/

> +     *
> +     * To keep allocation as needed, first setup vector 0 with an invalid
> +     * fd to make MSI-X enabled, then enable vectors by setting all so that
> +     * kernel allocates and enables interrupts only when enabled in guest.
> +     */
> +    if (msix && !(vdev->msix->irq_info_flags & VFIO_IRQ_INFO_NORESIZE)) {

!vdev->msix->noresize again seems cleaner.

> +        argsz = sizeof(*irq_set) + sizeof(*fds);
> +
> +        irq_set = g_malloc0(argsz);
> +        irq_set->argsz = argsz;
> +        irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> +                         VFIO_IRQ_SET_ACTION_TRIGGER;
> +        irq_set->index = msix ? VFIO_PCI_MSIX_IRQ_INDEX :
> +                         VFIO_PCI_MSI_IRQ_INDEX;

Why are we testing msix again within a branch that requires msix?

> +        irq_set->start = 0;
> +        irq_set->count = 1;
> +        fds = (int32_t *)&irq_set->data;
> +        fds[0] = -1;
> +
> +        ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> +
> +        g_free(irq_set);
> +
> +        if (ret) {
> +            return ret;
> +        }
> +    }

So your goal here is simply to get the kernel to call vfio_msi_enable()
with nvec = 1 to get MSI-X enabled on the device, which then allows the
kernel to use the dynamic expansion when we call SET_IRQS again with a
potentially sparse set of eventfds to vector mappings.  This seems very
similar to the nr_vectors == 0 branch of vfio_msix_enable() where it
uses a do_use and release call to accomplish getting MSI-X enabled.  We
should consolidate, probably by pulling this out into a function since
it seems cleaner to use the fd = -1 trick than to setup userspace
triggering and immediately release.  Thanks,

Alex

> +
>      argsz = sizeof(*irq_set) + (vdev->nr_vectors * sizeof(*fds));
>  
>      irq_set = g_malloc0(argsz);


