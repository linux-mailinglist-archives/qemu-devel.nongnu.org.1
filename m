Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 675BAB0767D
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Jul 2025 15:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1jk-0005gy-Ts; Wed, 16 Jul 2025 08:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uc1dp-0001KT-BN
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uc1dh-0002De-7w
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752670414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7GbuHen0ahmWkk9wYJ3FI9bpzuqmSwErxKurt4cZvz0=;
 b=IQ1s9WYA1829qHEvk91qreJdbYV/ZeyX5u5XWuIlhUJxZmQBFQaHkQGxPvVUtlXgL5D/0w
 NCkwNa64waH7cpOKzsj83xLMjwovf2xNIchp2BaynjLqztkh9sbebGPAHo0XJeGWYcy911
 cxQo+s3kX+u1qMaXNW3OfGNovJ01UWg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-hj7fnxalMEKwyScXe_7oaA-1; Wed, 16 Jul 2025 08:53:32 -0400
X-MC-Unique: hj7fnxalMEKwyScXe_7oaA-1
X-Mimecast-MFC-AGG-ID: hj7fnxalMEKwyScXe_7oaA_1752670411
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4560a30a793so18172615e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 05:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752670411; x=1753275211;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7GbuHen0ahmWkk9wYJ3FI9bpzuqmSwErxKurt4cZvz0=;
 b=ToFu8q/idDy1BRbKMoiWCnZzrRke0ttYzMr3LjtGaMWRsXjgeVkGNsaHE3XEtm4MWZ
 tdAxxP2P1KZXCKMy8dMrxnMRX8p6YStcjkgXycFrqaBOojktLH+4leVdXqFgNBSPfCKY
 e8k6NSRdHfavWbMsD7B7Enz8o4bXEYbCJFPhGemNsov/EIwH0driXZgA14SAY7QAtgAt
 NjEkDgqeqsGxEgXoOlvZONnroaPu8O+7HEVC7lJXpw+9M58jW80hBjORshEEZmh23BL0
 BKLfjHQD6qkSeeDIAQXcGHdIPpqEADpBXKuiUi8rli4XNy1PwdIGypVvmo9IMrT7JtlK
 5AtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5ZLppqqfRbJJx3aLEHpZ4e6bI5lYLo6pJki7oppSNKyYj6C/VItN9VkxGtxXo8OloAk3h9ercyzT5@nongnu.org
X-Gm-Message-State: AOJu0YzQis8e9lGUE65kLHykRS35/ycXU70PGYP1HN2O3kptCNDP33WC
 wxu2kuG+/xRksbky+tBnqGni+GzcsvN+iS0iI2XaqyahNma4vAnxyJlhLxWBhsP98nyKsg0wXmT
 IY21fSPg8CeympDSyIE7zy9K757wWbX7LsIaFQZ/pDT1IO/Q1dwimnyL8
X-Gm-Gg: ASbGncslvjyt/cC+crRgxSw1kx2LUq5dYKmZ0Tye1WmGIOlGlfjagITOeEDqljkCDF3
 HDypDQvTXKZhy+txcLOIIi9ku09B1doNAT43SPha8DNQs74rY0/aN8nuUWmiQ+fR4rvejxVuNJG
 8SZBnNeyqMKNmGd/dJyYlUqKgj8BMgMHSe15da8Eamlo7HXEtRlh4ktM8I0xdEghZXUMTeu4PU0
 D6yn7NBO1BvGX7zu6IbsPmrynq4BD6h7qL8BfKEk8iLJFyEDfqW9xorGrf9hZKlnnlXkybR92zG
 hNC5wmeSp/2RVlH/aZZcaYJHv4ICvbgn9BWaMuiDolIAzRwdjC5Wq+ghmPRg53F9sEhJmB9rFd0
 =
X-Received: by 2002:a05:600c:c0d2:10b0:456:23aa:8c8 with SMTP id
 5b1f17b1804b1-4562e3548d6mr16821415e9.13.1752670411011; 
 Wed, 16 Jul 2025 05:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUm5brW90t7OhwYNjQYtyLM67VbagdoCG7ncEWpgiJf0eL/cOYyhXsu19bXUbK1QfPiTIpnA==
X-Received: by 2002:a05:600c:c0d2:10b0:456:23aa:8c8 with SMTP id
 5b1f17b1804b1-4562e3548d6mr16821265e9.13.1752670410556; 
 Wed, 16 Jul 2025 05:53:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e285sm17554358f8f.76.2025.07.16.05.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 05:53:29 -0700 (PDT)
Message-ID: <9ad2be7c-5399-4a7e-98c2-badb44f64145@redhat.com>
Date: Wed, 16 Jul 2025 14:53:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/2] vfio/pci: preserve pending interrupts
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, 'Peter Xu' <peterx@redhat.com>
References: <1752503222-222669-1-git-send-email-steven.sistare@oracle.com>
 <1752503222-222669-3-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1752503222-222669-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+Peter, for info.

On 7/14/25 16:27, Steve Sistare wrote:
> cpr-transfer may lose a VFIO interrupt because the KVM instance is
> destroyed and recreated.  If an interrupt arrives in the middle, it is
> dropped.  To fix, disable pended interrupts during cpr save, and pick
> up the pieces.  In more detail:
> 
> Stop the VCPUs. Call kvm_irqchip_remove_irqfd_notifier_gsi --> KVM_IRQFD to
> deassign the irqfd gsi that routes interrupts directly to the VCPU and KVM.
> After this call, interrupts fall back to the kernel vfio_msihandler, which
> writes to QEMU's kvm_interrupt eventfd.  CPR already preserves that
> eventfd.  When the route is re-established in new QEMU, the kernel tests
> the eventfd and pends an interrupt to KVM if necessary.
> 
> Deassign INTx in a similar manner.  For both MSI and INTx, remove the
> eventfd handler so old QEMU does not consume an event.
> 
> If an interrupt was already pended to KVM prior to the completion of
> kvm_irqchip_remove_irqfd_notifier_gsi, it will be recovered by the
> subsequent call to cpu_synchronize_all_states, which pulls KVM interrupt
> state to userland prior to saving it in vmstate.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/cpr.c              | 90 ++++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.c              |  2 +
>   hw/vfio/pci.h              |  1 +
>   include/hw/vfio/vfio-cpr.h |  6 +++
>   4 files changed, 99 insertions(+)
> 
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 2a244fc4b6..ae2a6b7acd 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -198,3 +198,93 @@ void vfio_cpr_add_kvm_notifier(void)
>                                       MIG_MODE_CPR_TRANSFER);
>       }
>   }
> +
> +static int set_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
> +                                  EventNotifier *rn, int virq, bool enable)
> +{
> +    if (enable) {
> +        return kvm_irqchip_add_irqfd_notifier_gsi(s, n, rn, virq);
> +    } else {
> +        return kvm_irqchip_remove_irqfd_notifier_gsi(s, n, virq);
> +    }
> +}
> +
> +static int vfio_cpr_set_msi_virq(VFIOPCIDevice *vdev, Error **errp, bool enable)
> +{
> +    const char *op = (enable ? "enable" : "disable");
> +    PCIDevice *pdev = &vdev->pdev;
> +    int i, nr_vectors, ret = 0;
> +
> +    if (msix_enabled(pdev)) {
> +        nr_vectors = vdev->msix->entries;
> +
> +    } else if (msi_enabled(pdev)) {
> +        nr_vectors = msi_nr_vectors_allocated(pdev);
> +
> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
> +        ret = set_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
> +                                     &vdev->intx.unmask, vdev->intx.route.irq,
> +                                     enable);
> +        if (ret) {
> +            error_setg(errp, "failed to %s INTx irq %d: error %d",
> +                       op, vdev->intx.route.irq, ret);
> +        } else {
> +            vfio_pci_intx_set_handler(vdev, enable);
> +        }
> +        return ret;
> +
> +    } else {
> +        nr_vectors = 0;
> +    }
> +
> +    for (i = 0; i < nr_vectors; i++) {
> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
> +        if (vector->use) {
> +            ret = set_irqfd_notifier_gsi(kvm_state, &vector->kvm_interrupt,
> +                                         NULL, vector->virq, enable);
> +            if (ret) {
> +                error_setg(errp, "failed to %s msi vector %d virq %d: error %d",
> +                           op, i, vector->virq, ret);
> +            } else {
> +                vfio_pci_msi_set_handler(vdev, i, enable);
> +            }
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +/*
> + * When CPR starts, detach IRQs from the VFIO device so future interrupts
> + * are posted to kvm_interrupt, which is preserved in new QEMU.  Interrupts
> + * that were already posted to the old KVM instance, but not delivered to the
> + * VCPU, are recovered via KVM_GET_LAPIC and pushed to the new KVM instance
> + * in new QEMU.
> + *
> + * If CPR fails, reattach the IRQs.
> + */
> +static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
> +                                 MigrationEvent *e, Error **errp)
> +{
> +    VFIOPCIDevice *vdev =
> +        container_of(notifier, VFIOPCIDevice, cpr.transfer_notifier);
> +
> +    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
> +        return vfio_cpr_set_msi_virq(vdev, errp, false);
> +    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> +        return vfio_cpr_set_msi_virq(vdev, errp, true);
> +    }
> +    return 0;
> +}
> +
> +void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
> +{
> +    migration_add_notifier_mode(&vdev->cpr.transfer_notifier,
> +                                vfio_cpr_pci_notifier,
> +                                MIG_MODE_CPR_TRANSFER);
> +}
> +
> +void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)
> +{
> +    migration_remove_notifier(&vdev->cpr.transfer_notifier);
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8b471c054a..22a4125131 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2993,6 +2993,7 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>   {
>       vfio_display_finalize(vdev);
>       vfio_bars_finalize(vdev);
> +    vfio_cpr_pci_unregister_device(vdev);
>       g_free(vdev->emulated_config_bits);
>       g_free(vdev->rom);
>       /*
> @@ -3442,6 +3443,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>       vfio_pci_register_err_notifier(vdev);
>       vfio_pci_register_req_notifier(vdev);
>       vfio_setup_resetfn_quirk(vdev);
> +    vfio_cpr_pci_register_device(vdev);
>   
>       return;
>   
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 80c8fcfa07..7989b94eb3 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -194,6 +194,7 @@ struct VFIOPCIDevice {
>       bool skip_vsc_check;
>       VFIODisplay *dpy;
>       Notifier irqchip_change_notifier;
> +    VFIOPCICPR cpr;
>   };
>   
>   /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 80ad20d216..d37daffbc5 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -38,6 +38,10 @@ typedef struct VFIODeviceCPR {
>       uint32_t ioas_id;
>   } VFIODeviceCPR;
>   
> +typedef struct VFIOPCICPR {
> +    NotifierWithReturn transfer_notifier;
> +} VFIOPCICPR;
> +
>   bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>                                           Error **errp);
>   void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
> @@ -77,5 +81,7 @@ extern const VMStateDescription vfio_cpr_pci_vmstate;
>   extern const VMStateDescription vmstate_cpr_vfio_devices;
>   
>   void vfio_cpr_add_kvm_notifier(void);
> +void vfio_cpr_pci_register_device(struct VFIOPCIDevice *vdev);
> +void vfio_cpr_pci_unregister_device(struct VFIOPCIDevice *vdev);
>   
>   #endif /* HW_VFIO_VFIO_CPR_H */


