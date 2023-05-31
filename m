Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BBD718E82
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:29:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UJ2-0005rT-W7; Wed, 31 May 2023 18:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UJ1-0005r5-28
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:28:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UIz-0003Xt-AI
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:28:34 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f60dfc6028so1944905e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685572111; x=1688164111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7IzajN4ylAtTfGVYTugWsPyoZtm0kDNJJ8LRNpf/QvA=;
 b=D0RZ8HLWbIgbzUAGJ2dkdSx2M1uNB8L3YY/lFAZNfk0fW8E4qug/medKH3M58LDexP
 4B0PGJyCvwIr9Z8iIHPjzK5RdVDoAqWtlAti5YSrt2Nm1VJdvY1JIPxMCm/jpFuspwlQ
 uzUm5EmojpS8/ADLKC+ZU4t2IDIGmlfukV9IkHkdtK0a/cgMJH0sU2weAX7mnxlKHuFl
 mWg95A2ZP3sYTvH2EE8kyG+nvL94z2xOntiXgMtfPcs7wb07n5yA9oiJTNIpAwcqBvTR
 75HWgTpTNtJLvwOYmH36ZIrajfSl0ddwfM2cwy+JOCMakxOso+KTgYaltAJbUJwLeA5/
 qlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685572111; x=1688164111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7IzajN4ylAtTfGVYTugWsPyoZtm0kDNJJ8LRNpf/QvA=;
 b=a8HtoQ5BUa8E2xS6zMCl9an7IqpEHoafcQenuHuBlKIg06FYwkAcjjbsOdAMezuMor
 tf9+lyugfaiNciEO4gEvWNWSB2grF4ri6w46NSqt5rNKrnNLscR4ZZ+puUEXgtn3cokG
 IwzkJ+XfI8gHlq2Xd9rpraooZAIz0l2qdDe4gSKapfIccFTj6iFyTtIJHWbOYXunD/4K
 5p3ehTauylUbNYL5g9HJfWr0dZ7AW7KKwkH5QZYRtIsEOLorJXf6y5Wl7mPoeICP3sn6
 lvSWTUwUCeaoC3A5Wv612MkFj/k63uQKG8BiD5VLdt11Rf+SPX01bn/ADNsKhdrsAxlD
 D41g==
X-Gm-Message-State: AC+VfDzZjUhje1UMzDneHL5mEiP+BiZ+qWh3Vu+X4TAU2PuYIouJm6c/
 xVWUk8HPxNiYGFrW83msTBsXCw==
X-Google-Smtp-Source: ACHHUZ7BW2SHG+kvNMCzMd9od6jc9y0Jkwnx7AZEkmiBaNMEJm/7eNXTOr6G2Hhk/D4xDvCVewfesA==
X-Received: by 2002:adf:eacc:0:b0:309:3828:2bde with SMTP id
 o12-20020adfeacc000000b0030938282bdemr278354wrn.60.1685572111469; 
 Wed, 31 May 2023 15:28:31 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a5d65c1000000b00301a351a8d6sm8108157wrw.84.2023.05.31.15.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 15:28:31 -0700 (PDT)
Message-ID: <67426e91-4777-16de-2a9d-b0e3b7254210@linaro.org>
Date: Thu, 1 Jun 2023 00:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 4/4] vfio/pci: Enable AtomicOps completers on root
 ports
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, robin@streamhpc.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, clg@redhat.com
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
 <20230526231558.1660396-5-alex.williamson@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230526231558.1660396-5-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 27/5/23 01:15, Alex Williamson wrote:
> Dynamically enable Atomic Ops completer support around realize/exit of
> vfio-pci devices reporting host support for these accesses and adhering
> to a minimal configuration standard.  While the Atomic Ops completer
> bits in the root port device capabilities2 register are read-only, the
> PCIe spec does allow RO bits to change to reflect hardware state.  We
> take advantage of that here around the realize and exit functions of
> the vfio-pci device.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   hw/vfio/pci.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.h |  1 +
>   2 files changed, 79 insertions(+)


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

Optional here: trace event logging pci_get_long(pos).

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

Similarly optional, trace event logging (cap->flags, mask).

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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


