Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CD17CC747
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:19:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qslqu-0007FA-3i; Tue, 17 Oct 2023 11:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qslqs-0007EA-0F
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qslqn-00051G-3O
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697555956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUkchR/FZWmmFG0YFePEDDod861HaR5AvExXdTH8fkw=;
 b=bG2txsu+3ZQgSc5r+giuZ7O3onThbvCMrQB9gn/eg7uejCTsNknBtqz6SQalGdh+erQsGC
 ImzgR4Xe1nBfmc6eOnHPY+vUBDGqdcHdkzg6G86Qsz1kQqSzUhkHG6NF6zY4nH/s3lSbIO
 Q0Zpge0ZX4MUBxFU+7LZIwkG7C05mN8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-urMB14bkM_i3u6dk_c8uHA-1; Tue, 17 Oct 2023 11:19:10 -0400
X-MC-Unique: urMB14bkM_i3u6dk_c8uHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D17871029F4C;
 Tue, 17 Oct 2023 15:19:00 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88F1A150;
 Tue, 17 Oct 2023 15:18:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 1/3] migration/doc: Add documentation for backwards
 compatiblity
Date: Tue, 17 Oct 2023 17:18:55 +0200
Message-ID: <20231017151857.21328-2-quintela@redhat.com>
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

State what are the requeriments to get migration working between qemu
versions.  And once there explain how one is supposed to implement a
new feature/default value and not break migration.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/devel/migration.rst | 217 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index c3e1400c0c..5ef2b36e9e 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -142,6 +142,223 @@ General advice for device developers
   may be different on the destination.  This can result in the
   device state being loaded into the wrong device.
 
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
+  This combination is not possible as the qemu-5.1 doen't understand
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
+was done.
+
+commit 9445e1e15e66c19e42bea942ba810db28052cd05
+Author: Stefan Hajnoczi <stefanha@redhat.com>
+Date:   Tue Aug 18 15:33:47 2020 +0100
+
+    virtio-blk-pci: default num_queues to -smp N
+
+The relevant parts for migration are: ::
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
+machine types to have the right value: ::
+
+    @@ -31,6 +31,7 @@
+     GlobalProperty hw_compat_5_1[] = {
+         ...
+    +    { "virtio-blk-device", "num-queues", "1"},
+         ...
+     };
+
+
 VMState
 -------
 
-- 
2.41.0


