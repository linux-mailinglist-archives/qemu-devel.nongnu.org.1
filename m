Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7346C827EE2
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 07:48:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN5tN-0005a4-Cx; Tue, 09 Jan 2024 01:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5tF-0005ZT-Bf
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:47:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5tA-0005kZ-GN
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704782823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfoPB+V4tsazOFYlr69fRC3SndE/Er42hA9fLw0jsGg=;
 b=Xq0shkLi3FB7tMqLvAkAPH1vkczWWWD6gWFfkbD+Mo/b1YB++3+ROGWgH1kY9maT6hIB/b
 sWat9HdpNtkaNTfFFLWCsEUopBKG1obG/T8llh7TkdXqc0CALQJEXUlRKpnRwSqA0mPf7P
 jLI/0yAg67M6BgppK6qzx0ow9P4CLYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-muaAIfqfMOSi5H9N3yeOOA-1; Tue, 09 Jan 2024 01:46:56 -0500
X-MC-Unique: muaAIfqfMOSi5H9N3yeOOA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D760685A588;
 Tue,  9 Jan 2024 06:46:55 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2635B492BCA;
 Tue,  9 Jan 2024 06:46:50 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 04/10] docs/migration: Split "Backwards compatibility"
 separately
Date: Tue,  9 Jan 2024 14:46:22 +0800
Message-ID: <20240109064628.595453-5-peterx@redhat.com>
In-Reply-To: <20240109064628.595453-1-peterx@redhat.com>
References: <20240109064628.595453-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

From: Peter Xu <peterx@redhat.com>

Split the section from main.rst into a separate file.  Reference it in the
index.rst.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/compatibility.rst | 517 ++++++++++++++++++++++++
 docs/devel/migration/index.rst         |   1 +
 docs/devel/migration/main.rst          | 519 -------------------------
 3 files changed, 518 insertions(+), 519 deletions(-)
 create mode 100644 docs/devel/migration/compatibility.rst

diff --git a/docs/devel/migration/compatibility.rst b/docs/devel/migration/compatibility.rst
new file mode 100644
index 0000000000..5a5417ef06
--- /dev/null
+++ b/docs/devel/migration/compatibility.rst
@@ -0,0 +1,517 @@
+Backwards compatibility
+=======================
+
+How backwards compatibility works
+---------------------------------
+
+When we do migration, we have two QEMU processes: the source and the
+target.  There are two cases, they are the same version or they are
+different versions.  The easy case is when they are the same version.
+The difficult one is when they are different versions.
+
+There are two things that are different, but they have very similar
+names and sometimes get confused:
+
+- QEMU version
+- machine type version
+
+Let's start with a practical example, we start with:
+
+- qemu-system-x86_64 (v5.2), from now on qemu-5.2.
+- qemu-system-x86_64 (v5.1), from now on qemu-5.1.
+
+Related to this are the "latest" machine types defined on each of
+them:
+
+- pc-q35-5.2 (newer one in qemu-5.2) from now on pc-5.2
+- pc-q35-5.1 (newer one in qemu-5.1) from now on pc-5.1
+
+First of all, migration is only supposed to work if you use the same
+machine type in both source and destination. The QEMU hardware
+configuration needs to be the same also on source and destination.
+Most aspects of the backend configuration can be changed at will,
+except for a few cases where the backend features influence frontend
+device feature exposure.  But that is not relevant for this section.
+
+I am going to list the number of combinations that we can have.  Let's
+start with the trivial ones, QEMU is the same on source and
+destination:
+
+1 - qemu-5.2 -M pc-5.2  -> migrates to -> qemu-5.2 -M pc-5.2
+
+  This is the latest QEMU with the latest machine type.
+  This have to work, and if it doesn't work it is a bug.
+
+2 - qemu-5.1 -M pc-5.1  -> migrates to -> qemu-5.1 -M pc-5.1
+
+  Exactly the same case than the previous one, but for 5.1.
+  Nothing to see here either.
+
+This are the easiest ones, we will not talk more about them in this
+section.
+
+Now we start with the more interesting cases.  Consider the case where
+we have the same QEMU version in both sides (qemu-5.2) but we are using
+the latest machine type for that version (pc-5.2) but one of an older
+QEMU version, in this case pc-5.1.
+
+3 - qemu-5.2 -M pc-5.1  -> migrates to -> qemu-5.2 -M pc-5.1
+
+  It needs to use the definition of pc-5.1 and the devices as they
+  were configured on 5.1, but this should be easy in the sense that
+  both sides are the same QEMU and both sides have exactly the same
+  idea of what the pc-5.1 machine is.
+
+4 - qemu-5.1 -M pc-5.2  -> migrates to -> qemu-5.1 -M pc-5.2
+
+  This combination is not possible as the qemu-5.1 doesn't understand
+  pc-5.2 machine type.  So nothing to worry here.
+
+Now it comes the interesting ones, when both QEMU processes are
+different.  Notice also that the machine type needs to be pc-5.1,
+because we have the limitation than qemu-5.1 doesn't know pc-5.2.  So
+the possible cases are:
+
+5 - qemu-5.2 -M pc-5.1  -> migrates to -> qemu-5.1 -M pc-5.1
+
+  This migration is known as newer to older.  We need to make sure
+  when we are developing 5.2 we need to take care about not to break
+  migration to qemu-5.1.  Notice that we can't make updates to
+  qemu-5.1 to understand whatever qemu-5.2 decides to change, so it is
+  in qemu-5.2 side to make the relevant changes.
+
+6 - qemu-5.1 -M pc-5.1  -> migrates to -> qemu-5.2 -M pc-5.1
+
+  This migration is known as older to newer.  We need to make sure
+  than we are able to receive migrations from qemu-5.1. The problem is
+  similar to the previous one.
+
+If qemu-5.1 and qemu-5.2 were the same, there will not be any
+compatibility problems.  But the reason that we create qemu-5.2 is to
+get new features, devices, defaults, etc.
+
+If we get a device that has a new feature, or change a default value,
+we have a problem when we try to migrate between different QEMU
+versions.
+
+So we need a way to tell qemu-5.2 that when we are using machine type
+pc-5.1, it needs to **not** use the feature, to be able to migrate to
+real qemu-5.1.
+
+And the equivalent part when migrating from qemu-5.1 to qemu-5.2.
+qemu-5.2 has to expect that it is not going to get data for the new
+feature, because qemu-5.1 doesn't know about it.
+
+How do we tell QEMU about these device feature changes?  In
+hw/core/machine.c:hw_compat_X_Y arrays.
+
+If we change a default value, we need to put back the old value on
+that array.  And the device, during initialization needs to look at
+that array to see what value it needs to get for that feature.  And
+what are we going to put in that array, the value of a property.
+
+To create a property for a device, we need to use one of the
+DEFINE_PROP_*() macros. See include/hw/qdev-properties.h to find the
+macros that exist.  With it, we set the default value for that
+property, and that is what it is going to get in the latest released
+version.  But if we want a different value for a previous version, we
+can change that in the hw_compat_X_Y arrays.
+
+hw_compat_X_Y is an array of registers that have the format:
+
+- name_device
+- name_property
+- value
+
+Let's see a practical example.
+
+In qemu-5.2 virtio-blk-device got multi queue support.  This is a
+change that is not backward compatible.  In qemu-5.1 it has one
+queue. In qemu-5.2 it has the same number of queues as the number of
+cpus in the system.
+
+When we are doing migration, if we migrate from a device that has 4
+queues to a device that have only one queue, we don't know where to
+put the extra information for the other 3 queues, and we fail
+migration.
+
+Similar problem when we migrate from qemu-5.1 that has only one queue
+to qemu-5.2, we only sent information for one queue, but destination
+has 4, and we have 3 queues that are not properly initialized and
+anything can happen.
+
+So, how can we address this problem.  Easy, just convince qemu-5.2
+that when it is running pc-5.1, it needs to set the number of queues
+for virtio-blk-devices to 1.
+
+That way we fix the cases 5 and 6.
+
+5 - qemu-5.2 -M pc-5.1  -> migrates to -> qemu-5.1 -M pc-5.1
+
+    qemu-5.2 -M pc-5.1 sets number of queues to be 1.
+    qemu-5.1 -M pc-5.1 expects number of queues to be 1.
+
+    correct.  migration works.
+
+6 - qemu-5.1 -M pc-5.1  -> migrates to -> qemu-5.2 -M pc-5.1
+
+    qemu-5.1 -M pc-5.1 sets number of queues to be 1.
+    qemu-5.2 -M pc-5.1 expects number of queues to be 1.
+
+    correct.  migration works.
+
+And now the other interesting case, case 3.  In this case we have:
+
+3 - qemu-5.2 -M pc-5.1  -> migrates to -> qemu-5.2 -M pc-5.1
+
+    Here we have the same QEMU in both sides.  So it doesn't matter a
+    lot if we have set the number of queues to 1 or not, because
+    they are the same.
+
+    WRONG!
+
+    Think what happens if we do one of this double migrations:
+
+    A -> migrates -> B -> migrates -> C
+
+    where:
+
+    A: qemu-5.1 -M pc-5.1
+    B: qemu-5.2 -M pc-5.1
+    C: qemu-5.2 -M pc-5.1
+
+    migration A -> B is case 6, so number of queues needs to be 1.
+
+    migration B -> C is case 3, so we don't care.  But actually we
+    care because we haven't started the guest in qemu-5.2, it came
+    migrated from qemu-5.1.  So to be in the safe place, we need to
+    always use number of queues 1 when we are using pc-5.1.
+
+Now, how was this done in reality?  The following commit shows how it
+was done::
+
+  commit 9445e1e15e66c19e42bea942ba810db28052cd05
+  Author: Stefan Hajnoczi <stefanha@redhat.com>
+  Date:   Tue Aug 18 15:33:47 2020 +0100
+
+  virtio-blk-pci: default num_queues to -smp N
+
+The relevant parts for migration are::
+
+    @@ -1281,7 +1284,8 @@ static Property virtio_blk_properties[] = {
+     #endif
+         DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
+                         true),
+    -    DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
+    +    DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues,
+    +                       VIRTIO_BLK_AUTO_NUM_QUEUES),
+         DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 256),
+
+It changes the default value of num_queues.  But it fishes it for old
+machine types to have the right value::
+
+    @@ -31,6 +31,7 @@
+     GlobalProperty hw_compat_5_1[] = {
+         ...
+    +    { "virtio-blk-device", "num-queues", "1"},
+         ...
+     };
+
+A device with different features on both sides
+----------------------------------------------
+
+Let's assume that we are using the same QEMU binary on both sides,
+just to make the things easier.  But we have a device that has
+different features on both sides of the migration.  That can be
+because the devices are different, because the kernel driver of both
+devices have different features, whatever.
+
+How can we get this to work with migration.  The way to do that is
+"theoretically" easy.  You have to get the features that the device
+has in the source of the migration.  The features that the device has
+on the target of the migration, you get the intersection of the
+features of both sides, and that is the way that you should launch
+QEMU.
+
+Notice that this is not completely related to QEMU.  The most
+important thing here is that this should be handled by the managing
+application that launches QEMU.  If QEMU is configured correctly, the
+migration will succeed.
+
+That said, actually doing it is complicated.  Almost all devices are
+bad at being able to be launched with only some features enabled.
+With one big exception: cpus.
+
+You can read the documentation for QEMU x86 cpu models here:
+
+https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html
+
+See when they talk about migration they recommend that one chooses the
+newest cpu model that is supported for all cpus.
+
+Let's say that we have:
+
+Host A:
+
+Device X has the feature Y
+
+Host B:
+
+Device X has not the feature Y
+
+If we try to migrate without any care from host A to host B, it will
+fail because when migration tries to load the feature Y on
+destination, it will find that the hardware is not there.
+
+Doing this would be the equivalent of doing with cpus:
+
+Host A:
+
+$ qemu-system-x86_64 -cpu host
+
+Host B:
+
+$ qemu-system-x86_64 -cpu host
+
+When both hosts have different cpu features this is guaranteed to
+fail.  Especially if Host B has less features than host A.  If host A
+has less features than host B, sometimes it works.  Important word of
+last sentence is "sometimes".
+
+So, forgetting about cpu models and continuing with the -cpu host
+example, let's see that the differences of the cpus is that Host A and
+B have the following features:
+
+Features:   'pcid'  'stibp' 'taa-no'
+Host A:        X       X
+Host B:                        X
+
+And we want to migrate between them, the way configure both QEMU cpu
+will be:
+
+Host A:
+
+$ qemu-system-x86_64 -cpu host,pcid=off,stibp=off
+
+Host B:
+
+$ qemu-system-x86_64 -cpu host,taa-no=off
+
+And you would be able to migrate between them.  It is responsibility
+of the management application or of the user to make sure that the
+configuration is correct.  QEMU doesn't know how to look at this kind
+of features in general.
+
+Notice that we don't recommend to use -cpu host for migration.  It is
+used in this example because it makes the example simpler.
+
+Other devices have worse control about individual features.  If they
+want to be able to migrate between hosts that show different features,
+the device needs a way to configure which ones it is going to use.
+
+In this section we have considered that we are using the same QEMU
+binary in both sides of the migration.  If we use different QEMU
+versions process, then we need to have into account all other
+differences and the examples become even more complicated.
+
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
+In qemu-8.0 we got this commit::
+
+    commit 010746ae1db7f52700cb2e2c46eb94f299cfa0d2
+    Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
+    Date:   Thu Mar 2 13:37:02 2023 +0000
+
+    hw/pci/aer: Implement PCI_ERR_UNCOR_MASK register
+
+
+The relevant bits of the commit for our example are this ones::
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
+The following commit shows how this got fixed::
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
+the old behaviour or the new behaviour::
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
+of breakage happens, but in this case it is quite simple::
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
+machine types::
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
+We can launch the appropriate devices with::
+
+  --device...,x-pci-e-err-unc-mask=on
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
diff --git a/docs/devel/migration/index.rst b/docs/devel/migration/index.rst
index 2cb701c77c..7fc02b9520 100644
--- a/docs/devel/migration/index.rst
+++ b/docs/devel/migration/index.rst
@@ -8,5 +8,6 @@ QEMU live migration works.
    :maxdepth: 2
 
    main
+   compatibility
    vfio
    virtio
diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 62bf027fb4..b3e31bb52f 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -993,522 +993,3 @@ In some cases it may be best to tie specific firmware versions to specific
 versioned machine types to cut down on the combinations that will need
 support.  This is also useful when newer versions of firmware outgrow
 the padding.
-
-
-Backwards compatibility
-=======================
-
-How backwards compatibility works
----------------------------------
-
-When we do migration, we have two QEMU processes: the source and the
-target.  There are two cases, they are the same version or they are
-different versions.  The easy case is when they are the same version.
-The difficult one is when they are different versions.
-
-There are two things that are different, but they have very similar
-names and sometimes get confused:
-
-- QEMU version
-- machine type version
-
-Let's start with a practical example, we start with:
-
-- qemu-system-x86_64 (v5.2), from now on qemu-5.2.
-- qemu-system-x86_64 (v5.1), from now on qemu-5.1.
-
-Related to this are the "latest" machine types defined on each of
-them:
-
-- pc-q35-5.2 (newer one in qemu-5.2) from now on pc-5.2
-- pc-q35-5.1 (newer one in qemu-5.1) from now on pc-5.1
-
-First of all, migration is only supposed to work if you use the same
-machine type in both source and destination. The QEMU hardware
-configuration needs to be the same also on source and destination.
-Most aspects of the backend configuration can be changed at will,
-except for a few cases where the backend features influence frontend
-device feature exposure.  But that is not relevant for this section.
-
-I am going to list the number of combinations that we can have.  Let's
-start with the trivial ones, QEMU is the same on source and
-destination:
-
-1 - qemu-5.2 -M pc-5.2  -> migrates to -> qemu-5.2 -M pc-5.2
-
-  This is the latest QEMU with the latest machine type.
-  This have to work, and if it doesn't work it is a bug.
-
-2 - qemu-5.1 -M pc-5.1  -> migrates to -> qemu-5.1 -M pc-5.1
-
-  Exactly the same case than the previous one, but for 5.1.
-  Nothing to see here either.
-
-This are the easiest ones, we will not talk more about them in this
-section.
-
-Now we start with the more interesting cases.  Consider the case where
-we have the same QEMU version in both sides (qemu-5.2) but we are using
-the latest machine type for that version (pc-5.2) but one of an older
-QEMU version, in this case pc-5.1.
-
-3 - qemu-5.2 -M pc-5.1  -> migrates to -> qemu-5.2 -M pc-5.1
-
-  It needs to use the definition of pc-5.1 and the devices as they
-  were configured on 5.1, but this should be easy in the sense that
-  both sides are the same QEMU and both sides have exactly the same
-  idea of what the pc-5.1 machine is.
-
-4 - qemu-5.1 -M pc-5.2  -> migrates to -> qemu-5.1 -M pc-5.2
-
-  This combination is not possible as the qemu-5.1 doesn't understand
-  pc-5.2 machine type.  So nothing to worry here.
-
-Now it comes the interesting ones, when both QEMU processes are
-different.  Notice also that the machine type needs to be pc-5.1,
-because we have the limitation than qemu-5.1 doesn't know pc-5.2.  So
-the possible cases are:
-
-5 - qemu-5.2 -M pc-5.1  -> migrates to -> qemu-5.1 -M pc-5.1
-
-  This migration is known as newer to older.  We need to make sure
-  when we are developing 5.2 we need to take care about not to break
-  migration to qemu-5.1.  Notice that we can't make updates to
-  qemu-5.1 to understand whatever qemu-5.2 decides to change, so it is
-  in qemu-5.2 side to make the relevant changes.
-
-6 - qemu-5.1 -M pc-5.1  -> migrates to -> qemu-5.2 -M pc-5.1
-
-  This migration is known as older to newer.  We need to make sure
-  than we are able to receive migrations from qemu-5.1. The problem is
-  similar to the previous one.
-
-If qemu-5.1 and qemu-5.2 were the same, there will not be any
-compatibility problems.  But the reason that we create qemu-5.2 is to
-get new features, devices, defaults, etc.
-
-If we get a device that has a new feature, or change a default value,
-we have a problem when we try to migrate between different QEMU
-versions.
-
-So we need a way to tell qemu-5.2 that when we are using machine type
-pc-5.1, it needs to **not** use the feature, to be able to migrate to
-real qemu-5.1.
-
-And the equivalent part when migrating from qemu-5.1 to qemu-5.2.
-qemu-5.2 has to expect that it is not going to get data for the new
-feature, because qemu-5.1 doesn't know about it.
-
-How do we tell QEMU about these device feature changes?  In
-hw/core/machine.c:hw_compat_X_Y arrays.
-
-If we change a default value, we need to put back the old value on
-that array.  And the device, during initialization needs to look at
-that array to see what value it needs to get for that feature.  And
-what are we going to put in that array, the value of a property.
-
-To create a property for a device, we need to use one of the
-DEFINE_PROP_*() macros. See include/hw/qdev-properties.h to find the
-macros that exist.  With it, we set the default value for that
-property, and that is what it is going to get in the latest released
-version.  But if we want a different value for a previous version, we
-can change that in the hw_compat_X_Y arrays.
-
-hw_compat_X_Y is an array of registers that have the format:
-
-- name_device
-- name_property
-- value
-
-Let's see a practical example.
-
-In qemu-5.2 virtio-blk-device got multi queue support.  This is a
-change that is not backward compatible.  In qemu-5.1 it has one
-queue. In qemu-5.2 it has the same number of queues as the number of
-cpus in the system.
-
-When we are doing migration, if we migrate from a device that has 4
-queues to a device that have only one queue, we don't know where to
-put the extra information for the other 3 queues, and we fail
-migration.
-
-Similar problem when we migrate from qemu-5.1 that has only one queue
-to qemu-5.2, we only sent information for one queue, but destination
-has 4, and we have 3 queues that are not properly initialized and
-anything can happen.
-
-So, how can we address this problem.  Easy, just convince qemu-5.2
-that when it is running pc-5.1, it needs to set the number of queues
-for virtio-blk-devices to 1.
-
-That way we fix the cases 5 and 6.
-
-5 - qemu-5.2 -M pc-5.1  -> migrates to -> qemu-5.1 -M pc-5.1
-
-    qemu-5.2 -M pc-5.1 sets number of queues to be 1.
-    qemu-5.1 -M pc-5.1 expects number of queues to be 1.
-
-    correct.  migration works.
-
-6 - qemu-5.1 -M pc-5.1  -> migrates to -> qemu-5.2 -M pc-5.1
-
-    qemu-5.1 -M pc-5.1 sets number of queues to be 1.
-    qemu-5.2 -M pc-5.1 expects number of queues to be 1.
-
-    correct.  migration works.
-
-And now the other interesting case, case 3.  In this case we have:
-
-3 - qemu-5.2 -M pc-5.1  -> migrates to -> qemu-5.2 -M pc-5.1
-
-    Here we have the same QEMU in both sides.  So it doesn't matter a
-    lot if we have set the number of queues to 1 or not, because
-    they are the same.
-
-    WRONG!
-
-    Think what happens if we do one of this double migrations:
-
-    A -> migrates -> B -> migrates -> C
-
-    where:
-
-    A: qemu-5.1 -M pc-5.1
-    B: qemu-5.2 -M pc-5.1
-    C: qemu-5.2 -M pc-5.1
-
-    migration A -> B is case 6, so number of queues needs to be 1.
-
-    migration B -> C is case 3, so we don't care.  But actually we
-    care because we haven't started the guest in qemu-5.2, it came
-    migrated from qemu-5.1.  So to be in the safe place, we need to
-    always use number of queues 1 when we are using pc-5.1.
-
-Now, how was this done in reality?  The following commit shows how it
-was done::
-
-  commit 9445e1e15e66c19e42bea942ba810db28052cd05
-  Author: Stefan Hajnoczi <stefanha@redhat.com>
-  Date:   Tue Aug 18 15:33:47 2020 +0100
-
-  virtio-blk-pci: default num_queues to -smp N
-
-The relevant parts for migration are::
-
-    @@ -1281,7 +1284,8 @@ static Property virtio_blk_properties[] = {
-     #endif
-         DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
-                         true),
-    -    DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
-    +    DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues,
-    +                       VIRTIO_BLK_AUTO_NUM_QUEUES),
-         DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 256),
-
-It changes the default value of num_queues.  But it fishes it for old
-machine types to have the right value::
-
-    @@ -31,6 +31,7 @@
-     GlobalProperty hw_compat_5_1[] = {
-         ...
-    +    { "virtio-blk-device", "num-queues", "1"},
-         ...
-     };
-
-A device with different features on both sides
-----------------------------------------------
-
-Let's assume that we are using the same QEMU binary on both sides,
-just to make the things easier.  But we have a device that has
-different features on both sides of the migration.  That can be
-because the devices are different, because the kernel driver of both
-devices have different features, whatever.
-
-How can we get this to work with migration.  The way to do that is
-"theoretically" easy.  You have to get the features that the device
-has in the source of the migration.  The features that the device has
-on the target of the migration, you get the intersection of the
-features of both sides, and that is the way that you should launch
-QEMU.
-
-Notice that this is not completely related to QEMU.  The most
-important thing here is that this should be handled by the managing
-application that launches QEMU.  If QEMU is configured correctly, the
-migration will succeed.
-
-That said, actually doing it is complicated.  Almost all devices are
-bad at being able to be launched with only some features enabled.
-With one big exception: cpus.
-
-You can read the documentation for QEMU x86 cpu models here:
-
-https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html
-
-See when they talk about migration they recommend that one chooses the
-newest cpu model that is supported for all cpus.
-
-Let's say that we have:
-
-Host A:
-
-Device X has the feature Y
-
-Host B:
-
-Device X has not the feature Y
-
-If we try to migrate without any care from host A to host B, it will
-fail because when migration tries to load the feature Y on
-destination, it will find that the hardware is not there.
-
-Doing this would be the equivalent of doing with cpus:
-
-Host A:
-
-$ qemu-system-x86_64 -cpu host
-
-Host B:
-
-$ qemu-system-x86_64 -cpu host
-
-When both hosts have different cpu features this is guaranteed to
-fail.  Especially if Host B has less features than host A.  If host A
-has less features than host B, sometimes it works.  Important word of
-last sentence is "sometimes".
-
-So, forgetting about cpu models and continuing with the -cpu host
-example, let's see that the differences of the cpus is that Host A and
-B have the following features:
-
-Features:   'pcid'  'stibp' 'taa-no'
-Host A:        X       X
-Host B:                        X
-
-And we want to migrate between them, the way configure both QEMU cpu
-will be:
-
-Host A:
-
-$ qemu-system-x86_64 -cpu host,pcid=off,stibp=off
-
-Host B:
-
-$ qemu-system-x86_64 -cpu host,taa-no=off
-
-And you would be able to migrate between them.  It is responsibility
-of the management application or of the user to make sure that the
-configuration is correct.  QEMU doesn't know how to look at this kind
-of features in general.
-
-Notice that we don't recommend to use -cpu host for migration.  It is
-used in this example because it makes the example simpler.
-
-Other devices have worse control about individual features.  If they
-want to be able to migrate between hosts that show different features,
-the device needs a way to configure which ones it is going to use.
-
-In this section we have considered that we are using the same QEMU
-binary in both sides of the migration.  If we use different QEMU
-versions process, then we need to have into account all other
-differences and the examples become even more complicated.
-
-How to mitigate when we have a backward compatibility error
------------------------------------------------------------
-
-We broke migration for old machine types continuously during
-development.  But as soon as we find that there is a problem, we fix
-it.  The problem is what happens when we detect after we have done a
-release that something has gone wrong.
-
-Let see how it worked with one example.
-
-After the release of qemu-8.0 we found a problem when doing migration
-of the machine type pc-7.2.
-
-- $ qemu-7.2 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
-
-  This migration works
-
-- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
-
-  This migration works
-
-- $ qemu-8.0 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
-
-  This migration fails
-
-- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
-
-  This migration fails
-
-So clearly something fails when migration between qemu-7.2 and
-qemu-8.0 with machine type pc-7.2.  The error messages, and git bisect
-pointed to this commit.
-
-In qemu-8.0 we got this commit::
-
-    commit 010746ae1db7f52700cb2e2c46eb94f299cfa0d2
-    Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
-    Date:   Thu Mar 2 13:37:02 2023 +0000
-
-    hw/pci/aer: Implement PCI_ERR_UNCOR_MASK register
-
-
-The relevant bits of the commit for our example are this ones::
-
-    --- a/hw/pci/pcie_aer.c
-    +++ b/hw/pci/pcie_aer.c
-    @@ -112,6 +112,10 @@ int pcie_aer_init(PCIDevice *dev,
-
-         pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
-                      PCI_ERR_UNC_SUPPORTED);
-    +    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
-    +                 PCI_ERR_UNC_MASK_DEFAULT);
-    +    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
-    +                 PCI_ERR_UNC_SUPPORTED);
-
-         pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
-                     PCI_ERR_UNC_SEVERITY_DEFAULT);
-
-The patch changes how we configure PCI space for AER.  But QEMU fails
-when the PCI space configuration is different between source and
-destination.
-
-The following commit shows how this got fixed::
-
-    commit 5ed3dabe57dd9f4c007404345e5f5bf0e347317f
-    Author: Leonardo Bras <leobras@redhat.com>
-    Date:   Tue May 2 21:27:02 2023 -0300
-
-    hw/pci: Disable PCI_ERR_UNCOR_MASK register for machine type < 8.0
-
-    [...]
-
-The relevant parts of the fix in QEMU are as follow:
-
-First, we create a new property for the device to be able to configure
-the old behaviour or the new behaviour::
-
-    diff --git a/hw/pci/pci.c b/hw/pci/pci.c
-    index 8a87ccc8b0..5153ad63d6 100644
-    --- a/hw/pci/pci.c
-    +++ b/hw/pci/pci.c
-    @@ -79,6 +79,8 @@ static Property pci_props[] = {
-         DEFINE_PROP_STRING("failover_pair_id", PCIDevice,
-                            failover_pair_id),
-         DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
-    +    DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
-    +                    QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
-         DEFINE_PROP_END_OF_LIST()
-     };
-
-Notice that we enable the feature for new machine types.
-
-Now we see how the fix is done.  This is going to depend on what kind
-of breakage happens, but in this case it is quite simple::
-
-    diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
-    index 103667c368..374d593ead 100644
-    --- a/hw/pci/pcie_aer.c
-    +++ b/hw/pci/pcie_aer.c
-    @@ -112,10 +112,13 @@ int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver,
-    uint16_t offset,
-
-         pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
-                      PCI_ERR_UNC_SUPPORTED);
-    -    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
-    -                 PCI_ERR_UNC_MASK_DEFAULT);
-    -    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
-    -                 PCI_ERR_UNC_SUPPORTED);
-    +
-    +    if (dev->cap_present & QEMU_PCIE_ERR_UNC_MASK) {
-    +        pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
-    +                     PCI_ERR_UNC_MASK_DEFAULT);
-    +        pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
-    +                     PCI_ERR_UNC_SUPPORTED);
-    +    }
-
-         pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
-                      PCI_ERR_UNC_SEVERITY_DEFAULT);
-
-I.e. If the property bit is enabled, we configure it as we did for
-qemu-8.0.  If the property bit is not set, we configure it as it was in 7.2.
-
-And now, everything that is missing is disabling the feature for old
-machine types::
-
-    diff --git a/hw/core/machine.c b/hw/core/machine.c
-    index 47a34841a5..07f763eb2e 100644
-    --- a/hw/core/machine.c
-    +++ b/hw/core/machine.c
-    @@ -48,6 +48,7 @@ GlobalProperty hw_compat_7_2[] = {
-         { "e1000e", "migrate-timadj", "off" },
-         { "virtio-mem", "x-early-migration", "false" },
-         { "migration", "x-preempt-pre-7-2", "true" },
-    +    { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
-     };
-     const size_t hw_compat_7_2_len = G_N_ELEMENTS(hw_compat_7_2);
-
-And now, when qemu-8.0.1 is released with this fix, all combinations
-are going to work as supposed.
-
-- $ qemu-7.2 -M pc-7.2  ->  qemu-7.2 -M pc-7.2 (works)
-- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2 (works)
-- $ qemu-8.0.1 -M pc-7.2  ->  qemu-7.2 -M pc-7.2 (works)
-- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2 (works)
-
-So the normality has been restored and everything is ok, no?
-
-Not really, now our matrix is much bigger.  We started with the easy
-cases, migration from the same version to the same version always
-works:
-
-- $ qemu-7.2 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
-- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
-- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
-
-Now the interesting ones.  When the QEMU processes versions are
-different.  For the 1st set, their fail and we can do nothing, both
-versions are released and we can't change anything.
-
-- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
-- $ qemu-8.0 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
-
-This two are the ones that work. The whole point of making the
-change in qemu-8.0.1 release was to fix this issue:
-
-- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
-- $ qemu-8.0.1 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
-
-But now we found that qemu-8.0 neither can migrate to qemu-7.2 not
-qemu-8.0.1.
-
-- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
-- $ qemu-8.0.1 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
-
-So, if we start a pc-7.2 machine in qemu-8.0 we can't migrate it to
-anything except to qemu-8.0.
-
-Can we do better?
-
-Yeap.  If we know that we are going to do this migration:
-
-- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
-
-We can launch the appropriate devices with::
-
-  --device...,x-pci-e-err-unc-mask=on
-
-And now we can receive a migration from 8.0.  And from now on, we can
-do that migration to new machine types if we remember to enable that
-property for pc-7.2.  Notice that we need to remember, it is not
-enough to know that the source of the migration is qemu-8.0.  Think of
-this example:
-
-$ qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 -> qemu-8.2 -M pc-7.2
-
-In the second migration, the source is not qemu-8.0, but we still have
-that "problem" and have that property enabled.  Notice that we need to
-continue having this mark/property until we have this machine
-rebooted.  But it is not a normal reboot (that don't reload QEMU) we
-need the machine to poweroff/poweron on a fixed QEMU.  And from now
-on we can use the proper real machine.
-- 
2.41.0


