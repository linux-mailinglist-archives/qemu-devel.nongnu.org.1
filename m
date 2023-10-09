Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AE07BEF61
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 01:53:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq02l-0003bc-0m; Mon, 09 Oct 2023 19:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qq02i-0003b8-1v
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 19:52:08 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qq02g-00060R-FB
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 19:52:07 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5BCBC61333;
 Mon,  9 Oct 2023 23:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715B3C433C8;
 Mon,  9 Oct 2023 23:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696895517;
 bh=0t9mc7kq38natk9LCJNhC7Fgb6FB3ybv005st60Nd/4=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=JVXKbXRclAx2DSQwG49RBnhRaeFahGuO804b+nqtMIEcfAkfbQh2U7RKs+0YVzQOV
 XllB/ITyIKmrCKgpWv9B55cYwHc70HMZEUiXAZafo/tHTrdvARsGbvtpXmR5+MhBc4
 qCHcFK86HjIxAADfOT5CmSvVYsJZnRm9p3faACmwHmzYBh+plA5Jdoj7HObKKrE0ET
 tgo7Uj4MSzv9NnfT4c0U5ulNlEczcPLxq7tETMOTbXNszsHcyIA2ZvURpgXQTv6yAO
 P4ox/20EF65hW7zRDIztuocjMvH9y5i9YU8sQY68PsflL4/QKiKd/z8wVMAbNU/AcJ
 hYNk1tuGWksIA==
Date: Mon, 9 Oct 2023 16:51:53 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Juergen Gross <jgross@suse.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [QEMU][PATCH v1 1/7] xen: when unplugging emulated devices skip
 virtio devices
In-Reply-To: <20231005181629.4046-2-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2310091651110.3431292@ubuntu-linux-20-04-desktop>
References: <20231005181629.4046-1-vikram.garhwal@amd.com>
 <20231005181629.4046-2-vikram.garhwal@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On Thu, 5 Oct 2023, Vikram Garhwal wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> Virtio devices should never be unplugged at boot time, as they are
> similar to pci passthrough devices.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> ---
>  hw/i386/xen/xen_platform.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
> index 17457ff3de..3560eaf8c8 100644
> --- a/hw/i386/xen/xen_platform.c
> +++ b/hw/i386/xen/xen_platform.c
> @@ -28,6 +28,7 @@
>  #include "hw/ide/pci.h"
>  #include "hw/pci/pci.h"
>  #include "migration/vmstate.h"
> +#include "hw/virtio/virtio-bus.h"
>  #include "net/net.h"
>  #include "trace.h"
>  #include "sysemu/xen.h"
> @@ -132,7 +133,8 @@ static void unplug_nic(PCIBus *b, PCIDevice *d, void *o)
>      /* We have to ignore passthrough devices */
>      if (pci_get_word(d->config + PCI_CLASS_DEVICE) ==
>              PCI_CLASS_NETWORK_ETHERNET
> -            && !pci_device_is_passthrough(d)) {
> +            && !pci_device_is_passthrough(d)
> +            && !qdev_get_child_bus(&d->qdev, TYPE_VIRTIO_BUS)) {

Please update the in-code comment above to say "ignore passthrough
devices and virtio devices"


>          object_unparent(OBJECT(d));
>      }
>  }
> @@ -208,6 +210,10 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void *opaque)
>      /* We have to ignore passthrough devices */
>      if (pci_device_is_passthrough(d))
>          return;
> +    /* Ignore virtio devices */
> +    if (qdev_get_child_bus(&d->qdev, TYPE_VIRTIO_BUS)) {
> +        return;
> +    }
>  
>      switch (pci_get_word(d->config + PCI_CLASS_DEVICE)) {
>      case PCI_CLASS_STORAGE_IDE:
> -- 
> 2.17.1
> 

