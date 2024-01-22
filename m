Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636B835B60
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 08:06:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRoNs-0008Ff-OC; Mon, 22 Jan 2024 02:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rRoNo-0008FP-E1
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 02:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rRoNm-0003Wg-6Q
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 02:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705907169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GO+wQaBQS8+w2ZAwVLW3/M2i3NJOkciOSJkzcI73pgs=;
 b=OCsvV2VxKad6oxrRnPf0DmnhTTmFY8e0RRffOTERAwCFhaVJTRY/RXiiqlIIvkOsiAXs4u
 I6U9cMtW3kUxUgej1G0GEiUmWi4CFq+z48nYsPx1C3+hWgy76mzrGM4cBfLWi234LSmUfK
 o3vfbtvaaJ5BZyB8p3cSTlC4+cNmYM0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-t4ouGvrRPNeAcYi2Vez-3A-1; Mon, 22 Jan 2024 02:06:04 -0500
X-MC-Unique: t4ouGvrRPNeAcYi2Vez-3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E04A1013661;
 Mon, 22 Jan 2024 07:06:04 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 431A72166B31;
 Mon, 22 Jan 2024 07:06:01 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 peterx@redhat.com
Subject: [PATCH] migration/docs: Explain two solutions for VMSD compatibility
Date: Mon, 22 Jan 2024 15:06:00 +0800
Message-ID: <20240122070600.16681-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The current article is not extremely easy to follow, and may contain too
much information for someone looking for solutions on VMSD compatibility
issues.  Meanwhile, VMSD versioning is not discussed.

I'm not yet sure whether we should just obsolete VMSD versioning; it's
still used quite a lot.  And I had a feeling that for simple use cases
where backward migration is not strongly required, device developers can
still consider using it.  So in this patch I decided to keep it (anyway, we
can't drop it in the near future because of massive existing users), and we
can still allow user to use it in contexts where forward-only migration
might be enough.

This doc patch does below changes:

  - Rename the page from "Backward compatibility" to "Migration
  compatibility", to avoid using "backward" as a word (because we'll want
  to identify "forward" / "backward" migrations in the new doc)

  - Add a TOC for this page for better indexing

  - A new section to explain what is forward/backward migration

  - A new small section for VMSD just to make things complete

  - Explain the two ways to make VMSD compatible with old qemu binaries

    For this one, I added a small section on how to use VMSD versioning for
    new fields just to start such documents.  Rename the old "How backwards
    compatibility works" section to "machine type based (forward+backward
    migration)" to be the 2nd solution (I called it machine type based
    solution). When at it, I provided a summary and a TODO for the 2nd
    solution.

  - A new section to explain which solution to choose

  - Moved the other two existing sections into "Extended readings", because
  they can be even further away to most device developers

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/compatibility.rst | 140 ++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 3 deletions(-)

diff --git a/docs/devel/migration/compatibility.rst b/docs/devel/migration/compatibility.rst
index 5a5417ef06..ea9da201ef 100644
--- a/docs/devel/migration/compatibility.rst
+++ b/docs/devel/migration/compatibility.rst
@@ -1,8 +1,139 @@
-Backwards compatibility
 =======================
+Migration compatibility
+=======================
+
+Migration is a hard topic sometimes.  One of the major reason is that it
+has a strict compatibility requirement - a migration (live or not) can
+happen between two different versions of QEMUs, so QEMU needs to make sure
+the migration can work across different versions of QEMU binaries.
+
+This document majorly discusses the compatibility requirement of forward /
+backward migrations that QEMU need to maintain, and what QEMU developers
+should do to achieve such compatibility requirements across different QEMU
+versions.
+
+.. contents::
+
+Types of migrations (forward / backward)
+========================================
+
+Let's firstly define the terms **forward migration** and **backward
+migration**.
+
+.. note::
+
+    To simplify the use case, we always discuss between two consecutive
+    versions of QEMU major releases (between QEMU version *N* and QEMU
+    version *N-1*).  But logically it applies to the case where the two
+    QEMU binaries involved contains more than one major version difference.
+
+.. _forward_migration:
+
+**Forward migration**: can be seen as the use case where a VM cluster can
+upgrade its nodes to a newer version of QEMU (version *N*) from an older
+version of QEMU (version *N-1*).
+
+.. _backward_migration:
+
+**Backward migration**: can be seen as the use case where a VM cluster
+would like to migrate from a newer version of QEMU (version *N*) back to an
+even older version of QEMU (version *N-1*).
+
+A forward migration is more common, where system upgrades are needed.  In
+this case, the upgrade can be done seamlessly by live migrating the old VMs
+to the new VMs with the new binaries.
+
+A backward migration can be less common OTOH, because downgrade is less
+common than upgrade for whatever reasons.  However for a production level
+system setup, this should also be allowed, because a cluster can contain
+different versions of QEMU binary.  It should be always allowed to migrate
+between old and new hosts as long as the machine type is supported across
+all the relevant hosts / nodes.
+
+VMState description data structure (VMSD)
+=========================================
+
+VMSD (or in the complete form, **VMStateDescription**) is the data
+structure that QEMU uses to describe data to be migrated for devices.
+Each device should provide its own VMSD structure to describe what it needs
+to be migrated when a VM live migration is requested.
+
+Device VMSD compatibility
+=========================
+
+Then if the VMSD structures need changing, how does the device maintain
+compatibilty?
 
-How backwards compatibility works
----------------------------------
+Here we only discuss VMSD-based migrations.  If one device is not using
+VMSD to migrate its device data, it's considered part of "advanced users",
+then this document may not apply anymore.  If you're writting a new device,
+please always consider starting with VMSD-based migration model.
+
+Consider the case where a device can start to support a new feature in the
+current release, where it wasn't supported before.  The new feature may
+require some new device states to be migrated (which can be new VMSD fields
+to be added, or new subsections).  The same question needs to be answered
+when one would like to modify an existing VMSD fields / layouts to fix a
+bug, and so on.
+
+Depending on the goal, the solution to this problem may vary.
+
+If one would like to provide a full support of migration between whatever
+versions, one can try to implement it using :ref:`machine_type_compat`
+solution.  If one would like to provide a fundamental upgrade-only
+compatibility, one could consider to use the simpler
+:ref:`vmsd_versioning_compat` solution.
+
+Solutions
+=========
+
+.. _vmsd_versioning_compat:
+
+VMSD versioning (forward migration only)
+----------------------------------------
+
+This is normally the simplest way to support cross-version QEMU live
+migration. The trade-off is backward migration will not be supported. It
+means migrations from new QEMU binaries to old QEMU binaries can fail. It's
+because even if the new QEMU can understand the old version of VMSD by
+proper versioning of the VMSD fields, the old QEMU will not be able to
+understand the new version of VMSD layout.  Then when someone migrates a VM
+using the new VMSD to an older version of QEMU, the old QEMU will not
+accept the new migration stream, reporting that the VSMD version too new.
+
+Please have a look at **include/migration/vmstate.h** for more information
+on how to use VMSD versioning.
+
+Taking an example of adding a new field for migration.  The change will
+need to at least contain two parts:
+
+  - Boost existing VMSD version.
+
+  - Add the new VMSD field with the boosted version, with specific
+    **VMSTATE_\*_V()** macros.  For example, **VMSTATE_UINT8_V()** will
+    define an uint8 typed VMSD field with version specified.
+
+.. _machine_type_compat:
+
+Machine type based (forward+backward migration)
+-----------------------------------------------
+
+QEMU developers can leverage machine type compatibile properties to provide
+a fully migratable device / protocol, so the migration behavior will be
+defined by the machine type, no matter which QEMU binary will be used.  One
+can reference the entries defined in **hw_compat_\*** global properties for
+examples.
+
+Comparing to VMSD versioning approach above, this may require more code
+changes, but provide a higher level of compatibility that is bound to the
+machine type being used.  To be explicit, since the migration behavior is
+bound to machine type, it will support both forward migration and backward
+migration as long as the machine type is supported.
+
+.. note::
+
+   Currently this section is pretty long.  TODO: rewrite this section to
+   make it easier for QEMU developers to understand.
 
 When we do migration, we have two QEMU processes: the source and the
 target.  There are two cases, they are the same version or they are
@@ -217,6 +348,9 @@ machine types to have the right value::
          ...
      };
 
+Extended readings
+=================
+
 A device with different features on both sides
 ----------------------------------------------
 
-- 
2.43.0


