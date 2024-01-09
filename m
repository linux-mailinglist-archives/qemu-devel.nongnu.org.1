Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7C827EDF
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 07:48:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN5tJ-0005Zn-9x; Tue, 09 Jan 2024 01:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5tE-0005ZL-94
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5tB-0005kg-KF
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704782824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96YAYkzCmw+333bP8g14STs8JeS9JNUdfxB9SYEWUPY=;
 b=UdeNLRZmz8A4guNugWTqcCFpc6HicfqPl8E/2imThKBTKP12qP+E6xFnGvT7+iEANwSVx2
 0gJfa2bLWs61IUIX4PN2EIsor5GDtSuzqs+Pyvm+9+jIYTzxK5niBQ9eA++4eH5EpcNCIw
 WXrFBVRd+BFr0oCZcXCt9AksfKPSyVk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-_DjTqGUpPxC3EoHNRrSkEQ-1; Tue,
 09 Jan 2024 01:47:01 -0500
X-MC-Unique: _DjTqGUpPxC3EoHNRrSkEQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 189E338149BC;
 Tue,  9 Jan 2024 06:47:01 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A744D492BC7;
 Tue,  9 Jan 2024 06:46:56 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 05/10] docs/migration: Split "Debugging" and "Firmware"
Date: Tue,  9 Jan 2024 14:46:23 +0800
Message-ID: <20240109064628.595453-6-peterx@redhat.com>
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

Move the two sections into a separate file called "best-practises.rst".
Add the entry into index.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/best-practises.rst | 48 +++++++++++++++++++++++++
 docs/devel/migration/index.rst          |  1 +
 docs/devel/migration/main.rst           | 44 -----------------------
 3 files changed, 49 insertions(+), 44 deletions(-)
 create mode 100644 docs/devel/migration/best-practises.rst

diff --git a/docs/devel/migration/best-practises.rst b/docs/devel/migration/best-practises.rst
new file mode 100644
index 0000000000..ba122ae417
--- /dev/null
+++ b/docs/devel/migration/best-practises.rst
@@ -0,0 +1,48 @@
+==============
+Best practises
+==============
+
+Debugging
+=========
+
+The migration stream can be analyzed thanks to ``scripts/analyze-migration.py``.
+
+Example usage:
+
+.. code-block:: shell
+
+  $ qemu-system-x86_64 -display none -monitor stdio
+  (qemu) migrate "exec:cat > mig"
+  (qemu) q
+  $ ./scripts/analyze-migration.py -f mig
+  {
+    "ram (3)": {
+        "section sizes": {
+            "pc.ram": "0x0000000008000000",
+  ...
+
+See also ``analyze-migration.py -h`` help for more options.
+
+Firmware
+========
+
+Migration migrates the copies of RAM and ROM, and thus when running
+on the destination it includes the firmware from the source. Even after
+resetting a VM, the old firmware is used.  Only once QEMU has been restarted
+is the new firmware in use.
+
+- Changes in firmware size can cause changes in the required RAMBlock size
+  to hold the firmware and thus migration can fail.  In practice it's best
+  to pad firmware images to convenient powers of 2 with plenty of space
+  for growth.
+
+- Care should be taken with device emulation code so that newer
+  emulation code can work with older firmware to allow forward migration.
+
+- Care should be taken with newer firmware so that backward migration
+  to older systems with older device emulation code will work.
+
+In some cases it may be best to tie specific firmware versions to specific
+versioned machine types to cut down on the combinations that will need
+support.  This is also useful when newer versions of firmware outgrow
+the padding.
diff --git a/docs/devel/migration/index.rst b/docs/devel/migration/index.rst
index 7fc02b9520..c09623b38f 100644
--- a/docs/devel/migration/index.rst
+++ b/docs/devel/migration/index.rst
@@ -11,3 +11,4 @@ QEMU live migration works.
    compatibility
    vfio
    virtio
+   best-practises
diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index b3e31bb52f..97811ce371 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -52,27 +52,6 @@ All these migration protocols use the same infrastructure to
 save/restore state devices.  This infrastructure is shared with the
 savevm/loadvm functionality.
 
-Debugging
-=========
-
-The migration stream can be analyzed thanks to ``scripts/analyze-migration.py``.
-
-Example usage:
-
-.. code-block:: shell
-
-  $ qemu-system-x86_64 -display none -monitor stdio
-  (qemu) migrate "exec:cat > mig"
-  (qemu) q
-  $ ./scripts/analyze-migration.py -f mig
-  {
-    "ram (3)": {
-        "section sizes": {
-            "pc.ram": "0x0000000008000000",
-  ...
-
-See also ``analyze-migration.py -h`` help for more options.
-
 Common infrastructure
 =====================
 
@@ -970,26 +949,3 @@ the background migration channel.  Anyone who cares about latencies of page
 faults during a postcopy migration should enable this feature.  By default,
 it's not enabled.
 
-Firmware
-========
-
-Migration migrates the copies of RAM and ROM, and thus when running
-on the destination it includes the firmware from the source. Even after
-resetting a VM, the old firmware is used.  Only once QEMU has been restarted
-is the new firmware in use.
-
-- Changes in firmware size can cause changes in the required RAMBlock size
-  to hold the firmware and thus migration can fail.  In practice it's best
-  to pad firmware images to convenient powers of 2 with plenty of space
-  for growth.
-
-- Care should be taken with device emulation code so that newer
-  emulation code can work with older firmware to allow forward migration.
-
-- Care should be taken with newer firmware so that backward migration
-  to older systems with older device emulation code will work.
-
-In some cases it may be best to tie specific firmware versions to specific
-versioned machine types to cut down on the combinations that will need
-support.  This is also useful when newer versions of firmware outgrow
-the padding.
-- 
2.41.0


