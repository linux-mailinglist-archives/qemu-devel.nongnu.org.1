Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8095D82E832
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:22:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPa0N-0005rD-0x; Mon, 15 Jan 2024 22:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa0K-0005mO-MC
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa0I-00036C-Lb
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zaWAr7R+o0BFfn2GI+58asPDPgLyrb90Op/REHjc/j8=;
 b=cS5Sb544mXhnmUw4dOCdpkqSglC6cPFyEwgeTpfVh2YKJnyW9ZnILBM+ok7E1/IZVPxVjk
 90lzMAOR94Evpo290elY+TNCxTzI/1NysHguFYw7aHKv21alKYETZf0j2y5s7S+hdYT4bu
 +NXlVCGPkliuF+YulVwbX4OWbnir0ic=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-G9pww0BRNneadZRs_kGSBQ-1; Mon, 15 Jan 2024 22:20:40 -0500
X-MC-Unique: G9pww0BRNneadZRs_kGSBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA179185A780;
 Tue, 16 Jan 2024 03:20:39 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CB153C25;
 Tue, 16 Jan 2024 03:20:37 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/20] docs/migration: Split "Debugging" and "Firmware"
Date: Tue, 16 Jan 2024 11:19:41 +0800
Message-ID: <20240116031947.69017-15-peterx@redhat.com>
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

Move the two sections into a separate file called "best-practices.rst".
Add the entry into index.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240109064628.595453-6-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/best-practices.rst | 48 +++++++++++++++++++++++++
 docs/devel/migration/index.rst          |  1 +
 docs/devel/migration/main.rst           | 44 -----------------------
 3 files changed, 49 insertions(+), 44 deletions(-)
 create mode 100644 docs/devel/migration/best-practices.rst

diff --git a/docs/devel/migration/best-practices.rst b/docs/devel/migration/best-practices.rst
new file mode 100644
index 0000000000..d7c34a3014
--- /dev/null
+++ b/docs/devel/migration/best-practices.rst
@@ -0,0 +1,48 @@
+==============
+Best practices
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
index 7fc02b9520..9a8fd1ead7 100644
--- a/docs/devel/migration/index.rst
+++ b/docs/devel/migration/index.rst
@@ -11,3 +11,4 @@ QEMU live migration works.
    compatibility
    vfio
    virtio
+   best-practices
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
2.43.0


