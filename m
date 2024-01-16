Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD182E823
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:21:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPa0B-0005k0-OC; Mon, 15 Jan 2024 22:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa07-0005hO-6d
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa05-00033w-FD
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZsZWSUdsS/SNanf1F3uVMexB59A3J31sjL5vpGtd4U=;
 b=PbCJYZ0/mqPYSKBxEQcSMU037U9Z0WrhfR/xpmIzZWP5gTrWb/6pKm7OJ0IR8eQXJ9KHqn
 7vvcM9eYWm4elBWFEfklXViKlT+maigj+GLQqboGtSW2oxrTakH+pdjGgvknodAIQstv6u
 tn0VrU5q8Rv7MZGGF9Ord9++O233cS0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-V47N_fSFN4SCniHmZUSrPw-1; Mon,
 15 Jan 2024 22:20:26 -0500
X-MC-Unique: V47N_fSFN4SCniHmZUSrPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA0431C05ABC;
 Tue, 16 Jan 2024 03:20:25 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0AA33C25;
 Tue, 16 Jan 2024 03:20:21 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/20] docs/migration: Create migration/ directory
Date: Tue, 16 Jan 2024 11:19:37 +0800
Message-ID: <20240116031947.69017-11-peterx@redhat.com>
In-Reply-To: <20240116031947.69017-1-peterx@redhat.com>
References: <20240116031947.69017-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

Migration documentation is growing into a single file too large.  Create a
sub-directory for it for a split.

We also already have separate vfio/virtio documentations, move it all over
into the directory.

Note that the virtio one is still not yet converted to rST.  That is a job
for later.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240109064628.595453-2-peterx@redhat.com
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
2.43.0


