Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D4AC68BD
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 14:00:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFRp-0003iC-HN; Wed, 28 May 2025 07:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKFRl-0003hj-VH
 for qemu-devel@nongnu.org; Wed, 28 May 2025 07:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKFRi-00015e-KO
 for qemu-devel@nongnu.org; Wed, 28 May 2025 07:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748433567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6yc511EEoTcvGMY+zSYdsV78wEYFy9TZRBkl7DgybU=;
 b=HOjpHkHwCaRKzTWqQbs1OheBBUYQqlevsqVNy1aRH0qHf+sO0tRf4DsYgZTn6JbodkSTs6
 G+TIt4eiuxjR9FZhL2wxRpmUmdp+8cfaUpl3yqjtXhvmX3mvsFIP85lrBZL4XAkzNr2ULm
 vWk49dmuamUp7ZC9X9jVUZV1ZqPQYNo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-TimBXBAkMpW5a6uxYer5JA-1; Wed,
 28 May 2025 07:59:26 -0400
X-MC-Unique: TimBXBAkMpW5a6uxYer5JA-1
X-Mimecast-MFC-AGG-ID: TimBXBAkMpW5a6uxYer5JA_1748433565
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 375931800361; Wed, 28 May 2025 11:59:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98D6B180049D; Wed, 28 May 2025 11:59:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 1/4] tests: Move the old vmstate-static-checker files to
 tests/data/
Date: Wed, 28 May 2025 13:59:11 +0200
Message-ID: <20250528115914.330994-2-thuth@redhat.com>
In-Reply-To: <20250528115914.330994-1-thuth@redhat.com>
References: <20250528115914.330994-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.904, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

All other test data resides in tests/data/, so let's move the dump
files here, too.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                                     | 2 +-
 .../vmstate-static-checker}/dump1.json                          | 0
 .../vmstate-static-checker}/dump2.json                          | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/{vmstate-static-checker-data => data/vmstate-static-checker}/dump1.json (100%)
 rename tests/{vmstate-static-checker-data => data/vmstate-static-checker}/dump2.json (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7060cf49b98..55735de4e4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3546,8 +3546,8 @@ F: include/migration/
 F: include/qemu/userfaultfd.h
 F: migration/
 F: scripts/vmstate-static-checker.py
+F: tests/data/vmstate-static-checker/
 F: tests/functional/test_migration.py
-F: tests/vmstate-static-checker-data/
 F: tests/qtest/migration/
 F: tests/qtest/migration-*
 F: docs/devel/migration/
diff --git a/tests/vmstate-static-checker-data/dump1.json b/tests/data/vmstate-static-checker/dump1.json
similarity index 100%
rename from tests/vmstate-static-checker-data/dump1.json
rename to tests/data/vmstate-static-checker/dump1.json
diff --git a/tests/vmstate-static-checker-data/dump2.json b/tests/data/vmstate-static-checker/dump2.json
similarity index 100%
rename from tests/vmstate-static-checker-data/dump2.json
rename to tests/data/vmstate-static-checker/dump2.json
-- 
2.49.0


