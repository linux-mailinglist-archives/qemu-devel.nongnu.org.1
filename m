Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F3C71621F
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:36:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zWb-0008L2-5M; Tue, 30 May 2023 09:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3zWJ-0008Ct-Aj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3zWH-00054m-Jd
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685453772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1bUupBl8EumGSv1kNcTiR6Awa1XiV+FCORTfFxe7wU=;
 b=ZJiLUD34w8fBikOL65HbOdt0sIXIA2j69tfTEdlqTlw3rvUc1HCAYkxLaO/hETkL9NklkY
 XNHoCxO/tH25Wn771P3akvC4MrO7uqwdF2Vhn//Kqi3jrmojADkbFFT4LjgIVwIgaH2W1I
 j3Snlw0cvIgCklvEdnq921z3OIjXJpE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-DvF1hi0nMK-RKtRry0XvNw-1; Tue, 30 May 2023 09:36:11 -0400
X-MC-Unique: DvF1hi0nMK-RKtRry0XvNw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3078b9943d6so1575458f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453770; x=1688045770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f1bUupBl8EumGSv1kNcTiR6Awa1XiV+FCORTfFxe7wU=;
 b=LLN3v/IwkIogdu6AZJKJycN4bZsIs1tp7wyNJwrFy3x2kJPozXazbOe5AZ5I4TUrdV
 eePBTSxTwwTXkGr3Xb1LUr2N++DtyUZgpqiSuUb9HF9LpaiTfHGjVnr4Uqqx/bHaPAEj
 Ql+wA0T+tTQT+rWmn7MOVj4t7lEWuvn7mVPGZmSH9HJWCliiDrkYZMbcr0883kK5Q0Sv
 rMPZH2FMD0oeI/+Fur6F3oKusl4me/5UZe0PZy31j7TOz14Fkh0s6vNNizzW3gjnvgwu
 EfL+qeC9rqGmI293SrICMikqL4vkLGyj5ElHMqFV5mKdZh1VGAwqlDfcj64N0v4f7J0q
 g3Wg==
X-Gm-Message-State: AC+VfDxnuo37x5K7sd+H8+Rw5d3Za8d0G/9As3S7EKOkSgrdKwLREU2y
 9GRjaiyQoHb50mdGScV0jgnqV5aRuAzWOmBehQA0LkO3/LJ6GOiLO8GDy39ooV+yqnF05S34mDu
 2Eai63VsdRt6LKuo=
X-Received: by 2002:adf:e94f:0:b0:30a:e165:e68e with SMTP id
 m15-20020adfe94f000000b0030ae165e68emr1652284wrn.27.1685453769881; 
 Tue, 30 May 2023 06:36:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OSVs6Zr1XTgxJYMVs4yzQo/jALcyStXObwfn926j5U1b157qGGNTeQiP0Fnyqsr085sPYzg==
X-Received: by 2002:adf:e94f:0:b0:30a:e165:e68e with SMTP id
 m15-20020adfe94f000000b0030ae165e68emr1652272wrn.27.1685453769574; 
 Tue, 30 May 2023 06:36:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a5d5273000000b0030ae09c5efdsm3375755wrc.42.2023.05.30.06.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 06:36:09 -0700 (PDT)
Message-ID: <d541e95a-3436-b794-d49b-c5053c8f23e9@redhat.com>
Date: Tue, 30 May 2023 15:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2 4/4] vfio/pci: Enable AtomicOps completers on root
 ports
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, robin@streamhpc.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
 <20230526231558.1660396-5-alex.williamson@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230526231558.1660396-5-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/27/23 01:15, Alex Williamson wrote:
> Dynamically enable Atomic Ops completer support around realize/exit of
> vfio-pci devices reporting host support for these accesses and adhering
> to a minimal configuration standard.  While the Atomic Ops completer
> bits in the root port device capabilities2 register are read-only, the
> PCIe spec does allow RO bits to change to reflect hardware state.  We
> take advantage of that here around the realize and exit functions of
> the vfio-pci device.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

LGTM. I am not sure about the single function restriction, may be that's
worth a warning ?

Thanks,

C.


> ---
>   hw/vfio/pci.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.h |  1 +
>   2 files changed, 79 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index bf27a3990564..d8a0fd595560 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1826,6 +1826,81 @@ static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
>       vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);
>   }
>   
> +static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
> +{
> +    struct vfio_device_info_cap_pci_atomic_comp *cap;
> +    g_autofree struct vfio_device_info *info = NULL;
> +    PCIBus *bus = pci_get_bus(&vdev->pdev);
> +    PCIDevice *parent = bus->parent_dev;
> +    struct vfio_info_cap_header *hdr;
> +    uint32_t mask = 0;
> +    uint8_t *pos;
> +
> +    /*
> +     * PCIe Atomic Ops completer support is only added automatically for single
> +     * function devices downstream of a root port supporting DEVCAP2.  Support
> +     * is added during realize and, if added, removed during device exit.  The
> +     * single function requirement avoids conflicting requirements should a
> +     * slot be composed of multiple devices with differing capabilities.
> +     */
> +    if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
> +        pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
> +        pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
> +        vdev->pdev.devfn ||
> +        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        return;
> +    }
> +
> +    pos = parent->config + parent->exp.exp_cap + PCI_EXP_DEVCAP2;
> +
> +    /* Abort if there'a already an Atomic Ops configuration on the root port */
> +    if (pci_get_long(pos) & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +                             PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> +                             PCI_EXP_DEVCAP2_ATOMIC_COMP128)) {
> +        return;
> +    }
> +
> +    info = vfio_get_device_info(vdev->vbasedev.fd);
> +    if (!info) {
> +        return;
> +    }
> +
> +    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP);
> +    if (!hdr) {
> +        return;
> +    }
> +
> +    cap = (void *)hdr;
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
> +        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP32;
> +    }
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
> +        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP64;
> +    }
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
> +        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> +    }
> +
> +    if (!mask) {
> +        return;
> +    }
> +
> +    pci_long_test_and_set_mask(pos, mask);
> +    vdev->clear_parent_atomics_on_exit = true;
> +}
> +
> +static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
> +{
> +    if (vdev->clear_parent_atomics_on_exit) {
> +        PCIDevice *parent = pci_get_bus(&vdev->pdev)->parent_dev;
> +        uint8_t *pos = parent->config + parent->exp.exp_cap + PCI_EXP_DEVCAP2;
> +
> +        pci_long_test_and_clear_mask(pos, PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +                                          PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> +                                          PCI_EXP_DEVCAP2_ATOMIC_COMP128);
> +    }
> +}
> +
>   static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>                                  Error **errp)
>   {
> @@ -1929,6 +2004,8 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>                              QEMU_PCI_EXP_LNKCAP_MLS(QEMU_PCI_EXP_LNK_2_5GT), ~0);
>               vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL, 0, ~0);
>           }
> +
> +        vfio_pci_enable_rp_atomics(vdev);
>       }
>   
>       /*
> @@ -3265,6 +3342,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>           timer_free(vdev->intx.mmap_timer);
>       }
>       vfio_teardown_msi(vdev);
> +    vfio_pci_disable_rp_atomics(vdev);
>       vfio_bars_exit(vdev);
>       vfio_migration_exit(&vdev->vbasedev);
>   }
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 2674476d6c77..a2771b9ff3cc 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -174,6 +174,7 @@ struct VFIOPCIDevice {
>       bool no_vfio_ioeventfd;
>       bool enable_ramfb;
>       bool defer_kvm_irq_routing;
> +    bool clear_parent_atomics_on_exit;
>       VFIODisplay *dpy;
>       Notifier irqchip_change_notifier;
>   };


