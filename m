Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2667060E3
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 09:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzBIb-0007wK-Ox; Wed, 17 May 2023 03:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1pzBIT-0007vx-Vw
 for qemu-devel@nongnu.org; Wed, 17 May 2023 03:10:06 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1pzBIQ-00073g-7w
 for qemu-devel@nongnu.org; Wed, 17 May 2023 03:10:05 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1E630453DA;
 Wed, 17 May 2023 09:09:48 +0200 (CEST)
Message-ID: <42862ba2-4c46-f8a7-66fb-1d56104d64af@proxmox.com>
Date: Wed, 17 May 2023 09:09:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/3] migration/doc: We broke backwards compatibility
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230515083201.55060-1-quintela@redhat.com>
 <20230515083201.55060-4-quintela@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20230515083201.55060-4-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.666,
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

Am 15.05.23 um 10:32 schrieb Juan Quintela:
> When we detect that we have broken backwards compantibility in a

compatibility

(...)

> +
> +In qemu-8.0 we got this commit: ::
> +
> +    commit 9a6ef182c03eaa138bae553f0fbb5a123bef9a53
> +    Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> +    Date:   Thu Mar 2 13:37:03 2023 +0000
> +
> +        hw/pci/aer: Add missing routing for AER errors
> +
> +The relevant bits of the commit for our example are this ones:
> +
> +    --- a/hw/pci/pcie_aer.c
> +    +++ b/hw/pci/pcie_aer.c
> +    @@ -112,6 +112,10 @@ int pcie_aer_init(PCIDevice *dev,
> +
> +         pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
> +                      PCI_ERR_UNC_SUPPORTED);
> +    +    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
> +    +                 PCI_ERR_UNC_MASK_DEFAULT);
> +    +    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
> +    +                 PCI_ERR_UNC_SUPPORTED);
> +
> +         pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
> +                     PCI_ERR_UNC_SEVERITY_DEFAULT);
> +

These changes are not part of commit
9a6ef182c0 ("hw/pci/aer: Add missing routing for AER errors")
but rather the one before it, namely
010746ae1d ("hw/pci/aer: Implement PCI_ERR_UNCOR_MASK register")

> +The patch changes how we configure pci space for AER.  But qemu fails

Should QEMU and PCI be capitalized in the text parts?

> +when the pci space configuration is different betwwen source and

between

> +destination.
> +
> +The following commit show how this got fixed:

shows

(...)

> +
> +So the normality has been restaured and everything is ok, no?

restored

> +
> +Not really, now our matrix is much bigger.  We started with the easy
> +cases, migration from the same version to the same version always
> +works:
> +
> +- $ qemu-7.2 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
> +- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
> +- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
> +
> +Now the interesting ones.  When the QEMU processes versions are
> +different.  For the 1st set, their fail and we can do nothing, both
> +versions are relased and we can't change anything.

released

> +
> +- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
> +- $ qemu-8.0 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
> +
> +This two are the ones that work. The whole point of making the
> +change in qemu-8.0.1 release was to fix this issue:
> +
> +- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
> +- $ qemu-8.0.1 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
> +
> +But now we found that qemu-8.0 neither can migrate to qemu-7.2 not
> +qemu-8.0.1.
> +
> +- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
> +- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
> +
> +So, if we start a pc-7.2 machine in qemu-8.0 we can't migrate it to
> +anything except to qemu-8.0.
> +
> +Can we do better?
> +
> +Yeap.  If we know that we are gonig to do this migration:

going

> +
> +- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
> +
> +We can launche the appropiate devices with

"launch" was already pointed out by Peter, but there's also "appropriate"

> +
> +--device...,x-pci-e-err-unc-mask=on
> +
> +And now we can receive a migration from 8.0.  And from now on, we can
> +do that migration to new machine types if we remember to enable that
> +property for pc-7.2.  Notice that we need to remember, it is not
> +enough to know that the source of the migration is qemu-8.0.  Think of this example:
> +
> +$ qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 -> qemu-8.2 -M pc-7.2
> +
> +In the second migration, the source is not qemu-8.0, but we still have
> +that "problem" and have that property enabled.  Notice that we need to
> +continue having this mark/property until we have this machine
> +rebooted.  But it is not a normal reboot (that don't reload qemu) we
> +need the mapchine to poweroff/poweron on a fixed qemu.  And from now

machine

Best Regards,
Fiona


