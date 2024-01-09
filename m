Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 084BF827EE3
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 07:48:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN5sy-0005WR-Gq; Tue, 09 Jan 2024 01:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5sv-0005Vn-Kl
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:46:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5st-0005fv-Tx
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704782807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fyz3Wy9KB01mlZyBuHH+EwnBN2LxmLhrWyGeSsAGvvc=;
 b=iom+8I+n0ZbtDnbFxjevem9cVI0inNVqiWu+KOjsIrThIcEIm41ftoxk57F9bVl8viXDDR
 JDBnPay6SvohOlCMktPf5OjXWh0fr3UntaCAsr89aH2av4IZN8Ibfpv6Z1ALc3d181ApfZ
 R53Ir/sYgbql6AE2QedN5L4Qunvg9yo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-B8YNgsNdOnGeh6-AxxDTuw-1; Tue,
 09 Jan 2024 01:46:45 -0500
X-MC-Unique: B8YNgsNdOnGeh6-AxxDTuw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FB781C05EAB;
 Tue,  9 Jan 2024 06:46:45 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 947A6492BC7;
 Tue,  9 Jan 2024 06:46:40 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 02/10] docs/migration: Create index page
Date: Tue,  9 Jan 2024 14:46:20 +0800
Message-ID: <20240109064628.595453-3-peterx@redhat.com>
In-Reply-To: <20240109064628.595453-1-peterx@redhat.com>
References: <20240109064628.595453-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.41.0


