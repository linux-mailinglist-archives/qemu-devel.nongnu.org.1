Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4477CC74A
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:20:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qslqp-0007Bx-DZ; Tue, 17 Oct 2023 11:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qslqf-00079s-1P
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qslqc-0004zp-T4
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697555945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsDyP3bjVDufyj1Yccu7//r98/nze+r+4nQe9OuDOjE=;
 b=SuDbB/RGb1MdfCvnYC57DiknX7+1dRlhzreRh8fOZmPpH7/lMQdQvkXEywO/eFedDHGJci
 gTSVEttrvxQfsMMLkGCq61E4ZdUqRw0rMtncl1cVUA+6mJHs5GYnVK3llUPp5tqEDrNHJK
 kaR1CXY2xTCQtC7rTD4y8K5Hesm3JH0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-78tBjFKwPaGT4cXLehLBcw-1; Tue, 17 Oct 2023 11:19:03 -0400
X-MC-Unique: 78tBjFKwPaGT4cXLehLBcw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A98781D9ED;
 Tue, 17 Oct 2023 15:19:03 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5439B8B1;
 Tue, 17 Oct 2023 15:19:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 3/3] migration/doc: We broke backwards compatibility
Date: Tue, 17 Oct 2023 17:18:57 +0200
Message-ID: <20231017151857.21328-4-quintela@redhat.com>
In-Reply-To: <20231017151857.21328-1-quintela@redhat.com>
References: <20231017151857.21328-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When we detect that we have broken backwards compatibility in a
released version, we can't do anything for that version.  But once we
fix that bug on the next released version, we can "mitigate" that
problem when migrating to new versions to give a way out of that
machine until it does a hard reboot.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration.rst | 216 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 209 insertions(+), 7 deletions(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index e671df729e..6146f95a8b 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -455,11 +455,213 @@ binary in both sides of the migration.  If we use different QEMU
 versions process, then we need to have into account all other
 differences and the examples become even more complicated.
 
+How to mitigate when we have a backward compatibility error
+-----------------------------------------------------------
+
+We broke migration for old machine types continuously during
+development.  But as soon as we find that there is a problem, we fix
+it.  The problem is what happens when we detect after we have done a
+release that something has gone wrong.
+
+Let see how it worked with one example.
+
+After the release of qemu-8.0 we found a problem when doing migration
+of the machine type pc-7.2.
+
+- $ qemu-7.2 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
+
+  This migration works
+
+- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
+
+  This migration works
+
+- $ qemu-8.0 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
+
+  This migration fails
+
+- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
+
+  This migration fails
+
+So clearly something fails when migration between qemu-7.2 and
+qemu-8.0 with machine type pc-7.2.  The error messages, and git bisect
+pointed to this commit.
+
+In qemu-8.0 we got this commit: ::
+
+    commit 010746ae1db7f52700cb2e2c46eb94f299cfa0d2
+    Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
+    Date:   Thu Mar 2 13:37:02 2023 +0000
+
+    hw/pci/aer: Implement PCI_ERR_UNCOR_MASK register
+
+
+The relevant bits of the commit for our example are this ones:
+
+    --- a/hw/pci/pcie_aer.c
+    +++ b/hw/pci/pcie_aer.c
+    @@ -112,6 +112,10 @@ int pcie_aer_init(PCIDevice *dev,
+
+         pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
+                      PCI_ERR_UNC_SUPPORTED);
+    +    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
+    +                 PCI_ERR_UNC_MASK_DEFAULT);
+    +    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
+    +                 PCI_ERR_UNC_SUPPORTED);
+
+         pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
+                     PCI_ERR_UNC_SEVERITY_DEFAULT);
+
+The patch changes how we configure PCI space for AER.  But QEMU fails
+when the PCI space configuration is different between source and
+destination.
+
+The following commit shows how this got fixed:
+
+    commit 5ed3dabe57dd9f4c007404345e5f5bf0e347317f
+    Author: Leonardo Bras <leobras@redhat.com>
+    Date:   Tue May 2 21:27:02 2023 -0300
+
+    hw/pci: Disable PCI_ERR_UNCOR_MASK register for machine type < 8.0
+
+    [...]
+
+The relevant parts of the fix in QEMU are as follow:
+
+First, we create a new property for the device to be able to configure
+the old behaviour or the new behaviour. ::
+
+    diff --git a/hw/pci/pci.c b/hw/pci/pci.c
+    index 8a87ccc8b0..5153ad63d6 100644
+    --- a/hw/pci/pci.c
+    +++ b/hw/pci/pci.c
+    @@ -79,6 +79,8 @@ static Property pci_props[] = {
+         DEFINE_PROP_STRING("failover_pair_id", PCIDevice,
+                            failover_pair_id),
+         DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
+    +    DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
+    +                    QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
+         DEFINE_PROP_END_OF_LIST()
+     };
+
+Notice that we enable the feature for new machine types.
+
+Now we see how the fix is done.  This is going to depend on what kind
+of breakage happens, but in this case it is quite simple. ::
+
+    diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
+    index 103667c368..374d593ead 100644
+    --- a/hw/pci/pcie_aer.c
+    +++ b/hw/pci/pcie_aer.c
+    @@ -112,10 +112,13 @@ int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver,
+    uint16_t offset,
+
+         pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
+                      PCI_ERR_UNC_SUPPORTED);
+    -    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
+    -                 PCI_ERR_UNC_MASK_DEFAULT);
+    -    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
+    -                 PCI_ERR_UNC_SUPPORTED);
+    +
+    +    if (dev->cap_present & QEMU_PCIE_ERR_UNC_MASK) {
+    +        pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
+    +                     PCI_ERR_UNC_MASK_DEFAULT);
+    +        pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
+    +                     PCI_ERR_UNC_SUPPORTED);
+    +    }
+
+         pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
+                      PCI_ERR_UNC_SEVERITY_DEFAULT);
+
+I.e. If the property bit is enabled, we configure it as we did for
+qemu-8.0.  If the property bit is not set, we configure it as it was in 7.2.
+
+And now, everything that is missing is disabling the feature for old
+machine types: ::
+
+    diff --git a/hw/core/machine.c b/hw/core/machine.c
+    index 47a34841a5..07f763eb2e 100644
+    --- a/hw/core/machine.c
+    +++ b/hw/core/machine.c
+    @@ -48,6 +48,7 @@ GlobalProperty hw_compat_7_2[] = {
+         { "e1000e", "migrate-timadj", "off" },
+         { "virtio-mem", "x-early-migration", "false" },
+         { "migration", "x-preempt-pre-7-2", "true" },
+    +    { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
+     };
+     const size_t hw_compat_7_2_len = G_N_ELEMENTS(hw_compat_7_2);
+
+And now, when qemu-8.0.1 is released with this fix, all combinations
+are going to work as supposed.
+
+- $ qemu-7.2 -M pc-7.2  ->  qemu-7.2 -M pc-7.2 (works)
+- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2 (works)
+- $ qemu-8.0.1 -M pc-7.2  ->  qemu-7.2 -M pc-7.2 (works)
+- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2 (works)
+
+So the normality has been restored and everything is ok, no?
+
+Not really, now our matrix is much bigger.  We started with the easy
+cases, migration from the same version to the same version always
+works:
+
+- $ qemu-7.2 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
+- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
+- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
+
+Now the interesting ones.  When the QEMU processes versions are
+different.  For the 1st set, their fail and we can do nothing, both
+versions are released and we can't change anything.
+
+- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
+- $ qemu-8.0 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
+
+This two are the ones that work. The whole point of making the
+change in qemu-8.0.1 release was to fix this issue:
+
+- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
+- $ qemu-8.0.1 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
+
+But now we found that qemu-8.0 neither can migrate to qemu-7.2 not
+qemu-8.0.1.
+
+- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
+- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
+
+So, if we start a pc-7.2 machine in qemu-8.0 we can't migrate it to
+anything except to qemu-8.0.
+
+Can we do better?
+
+Yeap.  If we know that we are going to do this migration:
+
+- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
+
+We can launch the appropriate devices with
+
+--device...,x-pci-e-err-unc-mask=on
+
+And now we can receive a migration from 8.0.  And from now on, we can
+do that migration to new machine types if we remember to enable that
+property for pc-7.2.  Notice that we need to remember, it is not
+enough to know that the source of the migration is qemu-8.0.  Think of
+this example:
+
+$ qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 -> qemu-8.2 -M pc-7.2
+
+In the second migration, the source is not qemu-8.0, but we still have
+that "problem" and have that property enabled.  Notice that we need to
+continue having this mark/property until we have this machine
+rebooted.  But it is not a normal reboot (that don't reload QEMU) we
+need the machine to poweroff/poweron on a fixed QEMU.  And from now
+on we can use the proper real machine.
+
 VMState
 -------
 
-Most device data can be described using the ``VMSTATE`` macros (mostly defined
-in ``include/migration/vmstate.h``).
+Most device data can be described using the ``VMSTATE`` macros (mostly
+defined in ``include/migration/vmstate.h``).
 
 An example (from hw/input/pckbd.c)
 
@@ -478,16 +680,16 @@ An example (from hw/input/pckbd.c)
       }
   };
 
-We are declaring the state with name "pckbd".
-The ``version_id`` is 3, and the fields are 4 uint8_t in a KBDState structure.
-We registered this with:
+We are declaring the state with name "pckbd".  The ``version_id`` is
+3, and the fields are 4 uint8_t in a KBDState structure.  We
+registered this with:
 
 .. code:: c
 
     vmstate_register(NULL, 0, &vmstate_kbd, s);
 
-For devices that are ``qdev`` based, we can register the device in the class
-init function:
+For devices that are ``qdev`` based, we can register the device in the
+class init function:
 
 .. code:: c
 
-- 
2.41.0


