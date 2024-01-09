Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14157827EEA
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 07:48:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN5t8-0005Z8-5B; Tue, 09 Jan 2024 01:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5t5-0005Yd-7d
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5t2-0005iw-It
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704782815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0+vVPo3IzPTLXKpb+CcLMcaXEPLesV+xiOPtUsE7sQ=;
 b=T5aWKJxJx5qqF8EY/WarykVDUtnK/BWMu5O0RPG+J+2FC70/1ng2AkxooOCplmccm/MY6G
 kx/sSq+90OE4GkfIeG6Dg/qk0WADy3AUykQzC4BLclb0AEA0IL0F/nSRRTqkdXyj1/jxhH
 Q3F5i6ONsbKNUFe0LdRB1hPvMtnkxmA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-9aC89D7fOb-y2_df57OIAQ-1; Tue,
 09 Jan 2024 01:46:50 -0500
X-MC-Unique: 9aC89D7fOb-y2_df57OIAQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56BD91C05EA2;
 Tue,  9 Jan 2024 06:46:50 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAF77492BC7;
 Tue,  9 Jan 2024 06:46:45 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 03/10] docs/migration: Convert virtio.txt into rST
Date: Tue,  9 Jan 2024 14:46:21 +0800
Message-ID: <20240109064628.595453-4-peterx@redhat.com>
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

Convert the plain old .txt into .rst, add it into migration/index.rst.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/index.rst  |   1 +
 docs/devel/migration/virtio.rst | 115 ++++++++++++++++++++++++++++++++
 docs/devel/migration/virtio.txt | 108 ------------------------------
 3 files changed, 116 insertions(+), 108 deletions(-)
 create mode 100644 docs/devel/migration/virtio.rst
 delete mode 100644 docs/devel/migration/virtio.txt

diff --git a/docs/devel/migration/index.rst b/docs/devel/migration/index.rst
index 02cfdcc969..2cb701c77c 100644
--- a/docs/devel/migration/index.rst
+++ b/docs/devel/migration/index.rst
@@ -9,3 +9,4 @@ QEMU live migration works.
 
    main
    vfio
+   virtio
diff --git a/docs/devel/migration/virtio.rst b/docs/devel/migration/virtio.rst
new file mode 100644
index 0000000000..611a18b821
--- /dev/null
+++ b/docs/devel/migration/virtio.rst
@@ -0,0 +1,115 @@
+=======================
+Virtio device migration
+=======================
+
+Copyright 2015 IBM Corp.
+
+This work is licensed under the terms of the GNU GPL, version 2 or later.  See
+the COPYING file in the top-level directory.
+
+Saving and restoring the state of virtio devices is a bit of a twisty maze,
+for several reasons:
+
+- state is distributed between several parts:
+
+  - virtio core, for common fields like features, number of queues, ...
+
+  - virtio transport (pci, ccw, ...), for the different proxy devices and
+    transport specific state (msix vectors, indicators, ...)
+
+  - virtio device (net, blk, ...), for the different device types and their
+    state (mac address, request queue, ...)
+
+- most fields are saved via the stream interface; subsequently, subsections
+  have been added to make cross-version migration possible
+
+This file attempts to document the current procedure and point out some
+caveats.
+
+Save state procedure
+====================
+
+::
+
+  virtio core               virtio transport          virtio device
+  -----------               ----------------          -------------
+
+                                                      save() function registered
+                                                      via VMState wrapper on
+                                                      device class
+  virtio_save()                                       <----------
+               ------>      save_config()
+                            - save proxy device
+                            - save transport-specific
+                              device fields
+  - save common device
+    fields
+  - save common virtqueue
+    fields
+               ------>      save_queue()
+                            - save transport-specific
+                              virtqueue fields
+               ------>                               save_device()
+                                                     - save device-specific
+                                                       fields
+  - save subsections
+    - device endianness,
+      if changed from
+      default endianness
+    - 64 bit features, if
+      any high feature bit
+      is set
+    - virtio-1 virtqueue
+      fields, if VERSION_1
+      is set
+
+Load state procedure
+====================
+
+::
+
+  virtio core               virtio transport          virtio device
+  -----------               ----------------          -------------
+
+                                                      load() function registered
+                                                      via VMState wrapper on
+                                                      device class
+  virtio_load()                                       <----------
+               ------>      load_config()
+                            - load proxy device
+                            - load transport-specific
+                              device fields
+  - load common device
+    fields
+  - load common virtqueue
+    fields
+               ------>      load_queue()
+                            - load transport-specific
+                              virtqueue fields
+  - notify guest
+               ------>                               load_device()
+                                                     - load device-specific
+                                                       fields
+  - load subsections
+    - device endianness
+    - 64 bit features
+    - virtio-1 virtqueue
+      fields
+  - sanitize endianness
+  - sanitize features
+  - virtqueue index sanity
+    check
+                                                     - feature-dependent setup
+
+Implications of this setup
+==========================
+
+Devices need to be careful in their state processing during load: The
+load_device() procedure is invoked by the core before subsections have
+been loaded. Any code that depends on information transmitted in subsections
+therefore has to be invoked in the device's load() function _after_
+virtio_load() returned (like e.g. code depending on features).
+
+Any extension of the state being migrated should be done in subsections
+added to the core for compatibility reasons. If transport or device specific
+state is added, core needs to invoke a callback from the new subsection.
diff --git a/docs/devel/migration/virtio.txt b/docs/devel/migration/virtio.txt
deleted file mode 100644
index 98a6b0ffb5..0000000000
--- a/docs/devel/migration/virtio.txt
+++ /dev/null
@@ -1,108 +0,0 @@
-Virtio devices and migration
-============================
-
-Copyright 2015 IBM Corp.
-
-This work is licensed under the terms of the GNU GPL, version 2 or later.  See
-the COPYING file in the top-level directory.
-
-Saving and restoring the state of virtio devices is a bit of a twisty maze,
-for several reasons:
-- state is distributed between several parts:
-  - virtio core, for common fields like features, number of queues, ...
-  - virtio transport (pci, ccw, ...), for the different proxy devices and
-    transport specific state (msix vectors, indicators, ...)
-  - virtio device (net, blk, ...), for the different device types and their
-    state (mac address, request queue, ...)
-- most fields are saved via the stream interface; subsequently, subsections
-  have been added to make cross-version migration possible
-
-This file attempts to document the current procedure and point out some
-caveats.
-
-
-Save state procedure
-====================
-
-virtio core               virtio transport          virtio device
------------               ----------------          -------------
-
-                                                    save() function registered
-                                                    via VMState wrapper on
-                                                    device class
-virtio_save()                                       <----------
-             ------>      save_config()
-                          - save proxy device
-                          - save transport-specific
-                            device fields
-- save common device
-  fields
-- save common virtqueue
-  fields
-             ------>      save_queue()
-                          - save transport-specific
-                            virtqueue fields
-             ------>                               save_device()
-                                                   - save device-specific
-                                                     fields
-- save subsections
-  - device endianness,
-    if changed from
-    default endianness
-  - 64 bit features, if
-    any high feature bit
-    is set
-  - virtio-1 virtqueue
-    fields, if VERSION_1
-    is set
-
-
-Load state procedure
-====================
-
-virtio core               virtio transport          virtio device
------------               ----------------          -------------
-
-                                                    load() function registered
-                                                    via VMState wrapper on
-                                                    device class
-virtio_load()                                       <----------
-             ------>      load_config()
-                          - load proxy device
-                          - load transport-specific
-                            device fields
-- load common device
-  fields
-- load common virtqueue
-  fields
-             ------>      load_queue()
-                          - load transport-specific
-                            virtqueue fields
-- notify guest
-             ------>                               load_device()
-                                                   - load device-specific
-                                                     fields
-- load subsections
-  - device endianness
-  - 64 bit features
-  - virtio-1 virtqueue
-    fields
-- sanitize endianness
-- sanitize features
-- virtqueue index sanity
-  check
-                                                   - feature-dependent setup
-
-
-Implications of this setup
-==========================
-
-Devices need to be careful in their state processing during load: The
-load_device() procedure is invoked by the core before subsections have
-been loaded. Any code that depends on information transmitted in subsections
-therefore has to be invoked in the device's load() function _after_
-virtio_load() returned (like e.g. code depending on features).
-
-Any extension of the state being migrated should be done in subsections
-added to the core for compatibility reasons. If transport or device specific
-state is added, core needs to invoke a callback from the new subsection.
-- 
2.41.0


