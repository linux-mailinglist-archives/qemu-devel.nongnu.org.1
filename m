Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 815AE82E837
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:22:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPa0K-0005mN-T7; Mon, 15 Jan 2024 22:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa0E-0005lI-C4
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa0C-00035j-69
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLIoAj4gg4hxjQT4UcqeKcDo0V0q8ZpScX2bn5CfyKM=;
 b=HLXrFRLMH4qpkalgu4tKeGy0F/AAOit0SQ0919PmVDrZwwCXbAlL2IHvvQQnpX7rPyA4fF
 qNi4AJWryQ2ydFEwrkAeGBXzK02shF4hBjD8TWFVoaanMQ/BE8z5J/hVQIw6qcatrL4Byf
 yz6IT7q2BGTphL7s69LnX36PAjyMtZE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-VfCvbcl6Obe3zOf66Z_efA-1; Mon, 15 Jan 2024 22:20:33 -0500
X-MC-Unique: VfCvbcl6Obe3zOf66Z_efA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7436E102587D;
 Tue, 16 Jan 2024 03:20:33 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACD163C25;
 Tue, 16 Jan 2024 03:20:30 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/20] docs/migration: Convert virtio.txt into rST
Date: Tue, 16 Jan 2024 11:19:39 +0800
Message-ID: <20240116031947.69017-13-peterx@redhat.com>
In-Reply-To: <20240116031947.69017-1-peterx@redhat.com>
References: <20240116031947.69017-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240109064628.595453-4-peterx@redhat.com
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
2.43.0


