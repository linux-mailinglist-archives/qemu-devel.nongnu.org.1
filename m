Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ECC7BD407
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:07:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpkLu-0004k1-Qa; Mon, 09 Oct 2023 03:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.frank@proxmox.com>)
 id 1qpkLr-0004jT-Vy
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:06:52 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.frank@proxmox.com>)
 id 1qpkLq-0001bj-41
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:06:51 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0C7F8421EC
 for <qemu-devel@nongnu.org>; Mon,  9 Oct 2023 09:06:39 +0200 (CEST)
Message-ID: <d969606d-79bf-4ba1-849a-f2e819aaf274@proxmox.com>
Date: Mon, 9 Oct 2023 09:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Markus Frank <m.frank@proxmox.com>
Subject: vIOMMU - PCI pass through to Layer 2 VMs (Nested Virtualization)
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=m.frank@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hello,

I have already sent this email to qemu-discuss but I did not get a reply.
https://lists.nongnu.org/archive/html/qemu-discuss/2023-09/msg00034.html
Maybe someone here could help me and reply to this email or the one on qemu-discuss?

I would like to pass through PCI devices to Layer-2 VMs via Nested Virtualization.

Is there current documentation for this topic somewhere?

I used these parameters:
-machine ...,kernel-irqchip=split
-device intel-iommu

With these parameters PCI pass through to L2-VMs worked fine.


Now I come to the part where I get confused.

https://wiki.qemu.org/Features/VT-d#With_Virtio_Devices
Is this documentation relevant for PCI pass through? Do I need DMAR for virtio devices?

And there is also the virtio-iommu device where I also could use the i440fx chipset.
https://michael2012z.medium.com/virtio-iommu-789369049443

When adding "-device virtio-iommu-pci" pci pass through also works
but I get "kvm: virtio_iommu_translate no mapping for 0x1002030f000 for sid=240"
when starting qemu. What could that mean?

What do these parameters "disable-legacy=on,disable-modern=off,iommu_platform=on,ats=on"
actually do? When do I need them and on which virtio devices?

And which device should I rather use: virtio-iommu or intel-iommu?

Thanks in advance,
Markus


