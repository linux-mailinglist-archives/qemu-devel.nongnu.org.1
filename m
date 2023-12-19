Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9BD818399
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 09:39:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFVby-0004wt-Jn; Tue, 19 Dec 2023 03:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1rFVbu-0004wV-O1; Tue, 19 Dec 2023 03:37:55 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1rFVbr-0000zV-QF; Tue, 19 Dec 2023 03:37:53 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b9efed2e6fso3352097b6e.0; 
 Tue, 19 Dec 2023 00:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702975069; x=1703579869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zbj4ronYSEvO0ITXIItXyNLPNqESAnkyoVvCs+QC0bw=;
 b=H4qu9NaG63EzTzJ9237770ZuIrQ8j86hF/J2Y8IPwEa6iNprNTZjtAfp+EnRvewVlf
 HECtP43/MOQzN8UAC9BsJoxSFey9g+A6SLsk2D5SiedyUxb6oH5NMVfXGcJ7wSmpPYox
 TGczJjP5wycwhJGriByyg3XfT5caOyginkThlDokaINK9l9eFTlW483lvgtbpq9XbO2q
 nckOr47rFMLdBN7PBreGW/907mO77i39T3z3PK2ybAGpZRAAA2qM0W1z/xTrbBw26VK4
 r+XdZHm14OohEpSuW49MGRNsi9vaHFoonW2ML03QsJofOHXQ2ntWUBzponYCmkmVmDDv
 SasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702975069; x=1703579869;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zbj4ronYSEvO0ITXIItXyNLPNqESAnkyoVvCs+QC0bw=;
 b=kHA/O0SRMv75ZVtK474wz8OqkCT7aSwi/wPhFVr4XPGJXdygA/YwTPqL32EvNECZEP
 b+E3h/5MjB1JKKaeBySZ+Gk2zN/U4SJo1hsu+eazP0zmqRe98Ec/o/G0rQP99IZhjkVO
 /NyWsQQh3IWwCxeJurE/UslzZXNKNFQZPdFOBCn6ohP/Ob0HEWYeyZlmePVtR2fqxxVz
 Qqio4/RksQTd1dmBe+hRrv8Sgl0ar0/r3S30qW3vnUXNap2sPLNKBgZxAEaFfBMQfro4
 A0bqIWoLwaDzqIBp35EZou/AHCIIWnziPNMZTWtFUdsf8UOCT2pPlMerAyfTMulYRDqf
 uOHA==
X-Gm-Message-State: AOJu0YwiBpu3UwrUEz+O/d6F6OmBnF20mSvq3uJbWHyQBzQkAkeJsumk
 8h9xvWzvo8w9Qsb1/MvIi2Y=
X-Google-Smtp-Source: AGHT+IFrOWLX+rwLqJo238aqhlYcD/LqATHOX0uvKrye0j3AhEKMtrKwmMxHQakzMset2YSwbClMAw==
X-Received: by 2002:a05:6808:bce:b0:3ba:845:93d5 with SMTP id
 o14-20020a0568080bce00b003ba084593d5mr19039198oik.79.1702975069290; 
 Tue, 19 Dec 2023 00:37:49 -0800 (PST)
Received: from ?IPV6:240b:10:b280:d600:5c34:360a:3c5f:8c45?
 ([240b:10:b280:d600:5c34:360a:3c5f:8c45])
 by smtp.gmail.com with ESMTPSA id
 n40-20020a056a000d6800b006d8fb8c396bsm1670338pfv.30.2023.12.19.00.37.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 00:37:48 -0800 (PST)
Message-ID: <432f9b3b-2d91-4bc8-aca4-0ef3569a622e@gmail.com>
Date: Tue, 19 Dec 2023 17:37:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/12] virtio-net: add support for SR-IOV emulation
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
From: Yui Washizu <yui.washidu@gmail.com>
In-Reply-To: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=yui.washidu@gmail.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 2023/12/10 13:05, Akihiko Odaki wrote:
> Introduction
> ------------
>
> This series is based on the RFC series submitted by Yui Washizu[1].
> See also [2] for the context.
>
> This series enables SR-IOV emulation for virtio-net. It is useful
> to test SR-IOV support on the guest, or to expose several vDPA devices
> in a VM. vDPA devices can also provide L2 switching feature for
> offloading though it is out of scope to allow the guest to configure
> such a feature.
>
> The PF side code resides in virtio-pci. The VF side code resides in
> the PCI common infrastructure, but it is restricted to work only for
> virtio-net-pci because of lack of validation.
>
> User Interface
> --------------
>
> A user can configure a SR-IOV capable virtio-net device by adding
> virtio-net-pci functions to a bus. Below is a command line example:
>    -netdev user,id=n -netdev user,id=o
>    -netdev user,id=p -netdev user,id=q
>    -device pcie-root-port,id=b
>    -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
>    -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
>    -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
>    -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
>
> The VFs specify the paired PF with "sriov-pf" property. The PF must be
> added after all VFs. It is user's responsibility to ensure that VFs have
> function numbers larger than one of the PF, and the function numbers
> have a consistent stride.


I attempted to create a VF on a VM using your patches and
tested the creation of one VF on the VM.
I initiated QEMU with the following commands:
-netdev tap,id=n,vhost=on -netdev tap,id=o,vhost=on
-device pcie-root-port,id=b
-device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
-device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f

However, when creating just one VF,
QEMU crashed at hw/pci/pci.c:1443.
---
uint32_t vf_num = (d->devfn - (pf->devfn + vf_offset)) / vf_stride;
---
The error output was:
'CPU 1/KVM trap divide error ip:... sp:... error:0 in kvm-qemu.'

Interestingly, when creating two VFs, QEMU did not crash.

>
> Keeping VF instances
> --------------------
>
> A problem with SR-IOV emulation is that it needs to hotplug the VFs as
> the guest requests. Previously, this behavior was implemented by
> realizing and unrealizing VFs at runtime. However, this strategy does
> not work well for the proposed virtio-net emulation; in this proposal,
> device options passed in the command line must be maintained as VFs
> are hotplugged, but they are consumed when the machine starts and not
> available after that, which makes realizing VFs at runtime impossible.
>
> As an strategy alternative to runtime realization/unrealization, this
> series proposes to reuse the code to power down PCI Express devices.
> When a PCI Express device is powered down, it will be hidden from the
> guest but will be kept realized. This effectively implements the
> behavior we need for the SR-IOV emulation.
>
> Summary
> -------
>
> Patch [1, 5] refactors the PCI infrastructure code.
> Patch [6, 10] adds user-created SR-IOV VF infrastructure.
> Patch 11 makes virtio-pci work as SR-IOV PF for user-created VFs.
> Patch 12 allows user to create SR-IOV VFs with virtio-net-pci.
>
> [1] https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu@gmail.com/
> [2] https://lore.kernel.org/all/5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com/
>
> Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Changed to keep VF instances.
> - Link to v1: https://lore.kernel.org/r/20231202-sriov-v1-0-32b3570f7bd6@daynix.com
>
> ---
> Akihiko Odaki (12):
>        hw/pci: Initialize PCI multifunction after realization
>        hw/pci: Determine if rombar is explicitly enabled
>        hw/pci: Do not add ROM BAR for SR-IOV VF
>        vfio: Avoid inspecting option QDict for rombar
>        hw/qdev: Remove opts member
>        pcie_sriov: Reuse SR-IOV VF device instances
>        pcie_sriov: Release VFs failed to realize
>        pcie_sriov: Ensure PF and VF are mutually exclusive
>        pcie_sriov: Check PCI Express for SR-IOV PF
>        pcie_sriov: Allow user to create SR-IOV device
>        virtio-pci: Implement SR-IOV PF
>        virtio-net: Implement SR-IOV VF
>
>   docs/pcie_sriov.txt         |   8 +-
>   include/hw/pci/pci.h        |   2 +-
>   include/hw/pci/pci_device.h |  13 +-
>   include/hw/pci/pcie_sriov.h |  25 ++-
>   include/hw/qdev-core.h      |   4 -
>   hw/core/qdev.c              |   1 -
>   hw/net/igb.c                |   3 +-
>   hw/nvme/ctrl.c              |   3 +-
>   hw/pci/pci.c                |  98 +++++++-----
>   hw/pci/pci_host.c           |   4 +-
>   hw/pci/pcie.c               |   4 +-
>   hw/pci/pcie_sriov.c         | 360 +++++++++++++++++++++++++++++++++-----------
>   hw/vfio/pci.c               |   3 +-
>   hw/virtio/virtio-net-pci.c  |   1 +
>   hw/virtio/virtio-pci.c      |   7 +
>   system/qdev-monitor.c       |  12 +-
>   16 files changed, 395 insertions(+), 153 deletions(-)
> ---
> base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
> change-id: 20231202-sriov-9402fb262be8
>
> Best regards,

