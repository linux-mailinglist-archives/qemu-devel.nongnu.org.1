Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9DD7CA1B0
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:33:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJ1U-0000eX-7A; Mon, 16 Oct 2023 04:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsJ1P-0000e0-QC
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsJ1O-00075D-5d
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697445137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JhNvW0VWbcJQBW89wqQkcrpUb76oHLlCCtm/yDr8Aec=;
 b=O5jBshX5Za3aok7B7jYn3K/FYwhTWe2q5EjUOM/uCMyhy622ahrNkLZHgD+CemCyco4x87
 ekagU5V4S8KtHLk7SuKyRFtJ/ugSdcAfp0jU1ZctaNtBJ6VksghVThwlOViddWuhM9lEIt
 /lJoWaP5kuFJFhutygfGjdKL/dnEZlo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-7NHyWEToOsiWLnxg0oLTMQ-1; Mon, 16 Oct 2023 04:32:03 -0400
X-MC-Unique: 7NHyWEToOsiWLnxg0oLTMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A2CD3C28647;
 Mon, 16 Oct 2023 08:32:03 +0000 (UTC)
Received: from localhost (unknown [10.39.192.211])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A150963F45;
 Mon, 16 Oct 2023 08:32:02 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] vhost-user: Fix protocol feature bit conflict
Date: Mon, 16 Oct 2023 10:32:01 +0200
Message-ID: <20231016083201.23736-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

The VHOST_USER_PROTOCOL_F_XEN_MMAP feature bit was defined in
f21e95ee97d, which has been part of qemu's 8.1.0 release.  However, it
seems it was never added to qemu's code, but it is well possible that it
is already used by different front-ends outside of qemu (i.e., Xen).

VHOST_USER_PROTOCOL_F_SHARED_OBJECT in contrast was added to qemu's code
in 16094766627, but never defined in the vhost-user specification.  As a
consequence, both bits were defined to be 17, which cannot work.

Regardless of whether actual code or the specification should take
precedence, F_XEN_MMAP is already part of a qemu release, while
F_SHARED_OBJECT is not.  Therefore, bump the latter to take number 18
instead of 17, and add this to the specification.

Take the opportunity to add at least a little note on the
VhostUserShared structure to the specification.  This structure is
referenced by the new commands introduced in 16094766627, but was not
defined.

Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
       ("vhost-user: add shared_object msg")
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 docs/interop/vhost-user.rst               | 11 +++++++++++
 include/hw/virtio/vhost-user.h            |  3 ++-
 subprojects/libvhost-user/libvhost-user.h |  3 ++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 415bb47a19..768fb5c28c 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -275,6 +275,16 @@ Inflight description
 
 :queue size: a 16-bit size of virtqueues
 
+VhostUserShared
+^^^^^^^^^^^^^^^
+
++------+
+| UUID |
++------+
+
+:UUID: 16 bytes UUID, whose first three components (a 32-bit value, then
+  two 16-bit values) are stored in big endian.
+
 C structure
 -----------
 
@@ -885,6 +895,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
   #define VHOST_USER_PROTOCOL_F_STATUS               16
   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
+  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
 
 Front-end message types
 -----------------------
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 9f9ddf878d..1d4121431b 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -29,7 +29,8 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
     VHOST_USER_PROTOCOL_F_STATUS = 16,
-    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
+    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
+    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index b36a42a7ca..c2352904f0 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -65,7 +65,8 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
     /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
-    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
+    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
+    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
-- 
2.41.0


