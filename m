Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B149F7CAA07
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:43:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsNs3-0001LA-Rf; Mon, 16 Oct 2023 09:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsNry-0001Gy-DL
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsNrw-0003It-R6
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697463772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CdWmlM8n5hBHntCqcgaGLFEBRBK7ue5xEwrnyEeO4ko=;
 b=Qtrx+ewsAZ4Yoc0HIFO+IafqpJ14tPYelRXD07U13sS6u4oUgOnW2tI1P98tq983CQL4NR
 0iCKqMHVAcP2ljoD8mMhT5w29B52FjCX7SrUHCNAIXH5rHuCW7YBbvlI8aeq4+J01/0elu
 RoyN864IzPfNw1pb7MU3ZCP/PD0nWgo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-9R-C5jVRNeCpWPaInwyHGQ-1; Mon, 16 Oct 2023 09:42:48 -0400
X-MC-Unique: 9R-C5jVRNeCpWPaInwyHGQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DF0D1C0BB4F;
 Mon, 16 Oct 2023 13:42:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.211])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3110492BEF;
 Mon, 16 Oct 2023 13:42:47 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: [PATCH v5 1/7] vhost-user.rst: Improve [GS]ET_VRING_BASE doc
Date: Mon, 16 Oct 2023 15:42:37 +0200
Message-ID: <20231016134243.68248-2-hreitz@redhat.com>
In-Reply-To: <20231016134243.68248-1-hreitz@redhat.com>
References: <20231016134243.68248-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

GET_VRING_BASE does not mention that it stops the respective ring.  Fix
that.

Furthermore, it is not fully clear what the "base offset" these
commands' documentation refers to is; an offset could be many things.
Be more precise and verbose about it, especially given that these
commands use different payload structures depending on whether the vring
is split or packed.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 docs/interop/vhost-user.rst | 77 +++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 768fb5c28c..9202b167dd 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -108,6 +108,43 @@ A vring state description
 
 :num: a 32-bit number
 
+A vring descriptor index for split virtqueues
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
++-------------+---------------------+
+| vring index | index in avail ring |
++-------------+---------------------+
+
+:vring index: 32-bit index of the respective virtqueue
+
+:index in avail ring: 32-bit value, of which currently only the lower 16
+  bits are used:
+
+  - Bits 0–15: Index of the next *Available Ring* descriptor that the
+    back-end will process.  This is a free-running index that is not
+    wrapped by the ring size.
+  - Bits 16–31: Reserved (set to zero)
+
+Vring descriptor indices for packed virtqueues
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
++-------------+--------------------+
+| vring index | descriptor indices |
++-------------+--------------------+
+
+:vring index: 32-bit index of the respective virtqueue
+
+:descriptor indices: 32-bit value:
+
+  - Bits 0–14: Index of the next *Available Ring* descriptor that the
+    back-end will process.  This is a free-running index that is not
+    wrapped by the ring size.
+  - Bit 15: Driver (Available) Ring Wrap Counter
+  - Bits 16–30: Index of the entry in the *Used Ring* where the back-end
+    will place the next descriptor.  This is a free-running index that
+    is not wrapped by the ring size.
+  - Bit 31: Device (Used) Ring Wrap Counter
+
 A vring address description
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -1042,18 +1079,50 @@ Front-end message types
 ``VHOST_USER_SET_VRING_BASE``
   :id: 10
   :equivalent ioctl: ``VHOST_SET_VRING_BASE``
-  :request payload: vring state description
+  :request payload: vring descriptor index/indices
   :reply payload: N/A
 
-  Sets the base offset in the available vring.
+  Sets the next index to use for descriptors in this vring:
+
+  * For a split virtqueue, sets only the next descriptor index to
+    process in the *Available Ring*.  The device is supposed to read the
+    next index in the *Used Ring* from the respective vring structure in
+    guest memory.
+
+  * For a packed virtqueue, both indices are supplied, as they are not
+    explicitly available in memory.
+
+  Consequently, the payload type is specific to the type of virt queue
+  (*a vring descriptor index for split virtqueues* vs. *vring descriptor
+  indices for packed virtqueues*).
 
 ``VHOST_USER_GET_VRING_BASE``
   :id: 11
   :equivalent ioctl: ``VHOST_USER_GET_VRING_BASE``
   :request payload: vring state description
-  :reply payload: vring state description
+  :reply payload: vring descriptor index/indices
+
+  Stops the vring and returns the current descriptor index or indices:
+
+    * For a split virtqueue, returns only the 16-bit next descriptor
+      index to process in the *Available Ring*.  Note that this may
+      differ from the available ring index in the vring structure in
+      memory, which points to where the driver will put new available
+      descriptors.  For the *Used Ring*, the device only needs the next
+      descriptor index at which to put new descriptors, which is the
+      value in the vring structure in memory, so this value is not
+      covered by this message.
+
+    * For a packed virtqueue, neither index is explicitly available to
+      read from memory, so both indices (as maintained by the device) are
+      returned.
+
+  Consequently, the payload type is specific to the type of virt queue
+  (*a vring descriptor index for split virtqueues* vs. *vring descriptor
+  indices for packed virtqueues*).
 
-  Get the available vring base offset.
+  The request payload’s *num* field is currently reserved and must be
+  set to 0.
 
 ``VHOST_USER_SET_VRING_KICK``
   :id: 12
-- 
2.41.0


