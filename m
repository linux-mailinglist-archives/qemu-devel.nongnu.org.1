Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6961082E831
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:22:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPa0I-0005li-O4; Mon, 15 Jan 2024 22:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa0C-0005kk-G2
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa0A-00035f-M9
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EReq4wI/bSUVOoJSjjtmfDKxcjNhlnVjkKZhvj4f0cM=;
 b=TratPdDI/luZ2GQTV+ZR8+NvG+nAjEo8bGUUnyDQyOy4CCipRkCsxvXFeDMmDU423MRF+v
 BhyRe/c4XFOZY0tTrXTzRFUkRJqJedHJ4XUUkt3mrVQFahEcZQuOCGCZknVSKaEC1orTQE
 wpnhP6P1e+oQ0DJLh87+WBk/lw5FA1o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-EMVeXCvsOUOI_V5hQdU7FA-1; Mon, 15 Jan 2024 22:20:30 -0500
X-MC-Unique: EMVeXCvsOUOI_V5hQdU7FA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0FE082DFE0;
 Tue, 16 Jan 2024 03:20:29 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9991E3C25;
 Tue, 16 Jan 2024 03:20:26 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/20] docs/migration: Create index page
Date: Tue, 16 Jan 2024 11:19:38 +0800
Message-ID: <20240116031947.69017-12-peterx@redhat.com>
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

Create an index page for migration module.  Move VFIO migration there too.
A trivial touch-up on the title to use lower case there.

Since then we'll have "migration" as the top title, make the main doc file
renamed to "migration framework".

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240109064628.595453-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/index-internals.rst |  3 +--
 docs/devel/migration/index.rst | 11 +++++++++++
 docs/devel/migration/main.rst  |  6 +++---
 docs/devel/migration/vfio.rst  |  2 +-
 4 files changed, 16 insertions(+), 6 deletions(-)
 create mode 100644 docs/devel/migration/index.rst

diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index a41d62c1eb..5636e9cf1d 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -11,13 +11,12 @@ Details about QEMU's various subsystems including how to add features to them.
    block-coroutine-wrapper
    clocks
    ebpf_rss
-   migration/main
+   migration/index
    multi-process
    reset
    s390-cpu-topology
    s390-dasd-ipl
    tracing
-   vfio-migration
    vfio-iommufd
    writing-monitor-commands
    virtio-backends
diff --git a/docs/devel/migration/index.rst b/docs/devel/migration/index.rst
new file mode 100644
index 0000000000..02cfdcc969
--- /dev/null
+++ b/docs/devel/migration/index.rst
@@ -0,0 +1,11 @@
+Migration
+=========
+
+This is the main entry for QEMU migration documentations.  It explains how
+QEMU live migration works.
+
+.. toctree::
+   :maxdepth: 2
+
+   main
+   vfio
diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 95351ba51f..62bf027fb4 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -1,6 +1,6 @@
-=========
-Migration
-=========
+===================
+Migration framework
+===================
 
 QEMU has code to load/save the state of the guest that it is running.
 These are two complementary operations.  Saving the state just does
diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 605fe60e96..c49482eab6 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -1,5 +1,5 @@
 =====================
-VFIO device Migration
+VFIO device migration
 =====================
 
 Migration of virtual machine involves saving the state for each device that
-- 
2.43.0


