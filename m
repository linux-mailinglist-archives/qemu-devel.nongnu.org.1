Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B647E827EE1
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 07:48:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN5sv-0005VQ-0B; Tue, 09 Jan 2024 01:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5sq-0005VH-Ll
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:46:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5so-0005d9-Ea
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704782801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQfZfU5WzxHQckUSkxOrErhcyTpqRi01x2vFheugkn0=;
 b=aQcy7BbmUrIvkFGX6wM9XAj8T5xL9BNP15eRf9IGA7lya0KBf3ahktC7vB/BSf3FWkrHjl
 R6d0a2nxdhheNTxENCiJURjfGoK/Mn+vYyse61Qgf1G2VpA3HHeMxVZ0/czVi428owZgpn
 CYPbFbtqfcPBvgAgFgeqb1qxGqAekGI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-TV13N2g7OS2eZCMWl0nM-w-1; Tue,
 09 Jan 2024 01:46:40 -0500
X-MC-Unique: TV13N2g7OS2eZCMWl0nM-w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C49EC3806713;
 Tue,  9 Jan 2024 06:46:39 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 789EA492BC7;
 Tue,  9 Jan 2024 06:46:35 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 01/10] docs/migration: Create migration/ directory
Date: Tue,  9 Jan 2024 14:46:19 +0800
Message-ID: <20240109064628.595453-2-peterx@redhat.com>
In-Reply-To: <20240109064628.595453-1-peterx@redhat.com>
References: <20240109064628.595453-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Migration documentation is growing into a single file too large.  Create a
sub-directory for it for a split.

We also already have separate vfio/virtio documentations, move it all over
into the directory.

Note that the virtio one is still not yet converted to rST.  That is a job
for later.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/index-internals.rst                            | 2 +-
 docs/devel/{migration.rst => migration/main.rst}          | 0
 docs/devel/{vfio-migration.rst => migration/vfio.rst}     | 0
 docs/devel/{virtio-migration.txt => migration/virtio.txt} | 0
 4 files changed, 1 insertion(+), 1 deletion(-)
 rename docs/devel/{migration.rst => migration/main.rst} (100%)
 rename docs/devel/{vfio-migration.rst => migration/vfio.rst} (100%)
 rename docs/devel/{virtio-migration.txt => migration/virtio.txt} (100%)

diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index 3def4a138b..a41d62c1eb 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -11,7 +11,7 @@ Details about QEMU's various subsystems including how to add features to them.
    block-coroutine-wrapper
    clocks
    ebpf_rss
-   migration
+   migration/main
    multi-process
    reset
    s390-cpu-topology
diff --git a/docs/devel/migration.rst b/docs/devel/migration/main.rst
similarity index 100%
rename from docs/devel/migration.rst
rename to docs/devel/migration/main.rst
diff --git a/docs/devel/vfio-migration.rst b/docs/devel/migration/vfio.rst
similarity index 100%
rename from docs/devel/vfio-migration.rst
rename to docs/devel/migration/vfio.rst
diff --git a/docs/devel/virtio-migration.txt b/docs/devel/migration/virtio.txt
similarity index 100%
rename from docs/devel/virtio-migration.txt
rename to docs/devel/migration/virtio.txt
-- 
2.41.0


