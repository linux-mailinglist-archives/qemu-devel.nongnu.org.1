Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD05AC0CF7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 15:39:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI67i-0000OL-Ph; Thu, 22 May 2025 09:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI67f-0000Nl-6e
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI67c-0001Wa-7X
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747921087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhWVLbHdb3s2Yh0MlOp8ekfuP8oHxhQCIepQWCgIa5k=;
 b=bNSi5+RxN/1ecBmQ8BgpBmEgfRGY2OujkMgNt96o5e3fX5uzbhcWws7n/OLY/LNzvxh+kT
 fVRlPYa/2nNJCxJWuGnFxoNL4KefHa5wLppduPne3BBxCmeTdtAVY2gVIMjV7yB3cV1Cgr
 uAt8EV6a6q/wfAHZY2Uw8M4kdHHQm1o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-cUhIij9GMCqa5ksm4VMf2g-1; Thu,
 22 May 2025 09:38:05 -0400
X-MC-Unique: cUhIij9GMCqa5ksm4VMf2g-1
X-Mimecast-MFC-AGG-ID: cUhIij9GMCqa5ksm4VMf2g_1747921084
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C63E180045B; Thu, 22 May 2025 13:38:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D4DB30001A1; Thu, 22 May 2025 13:38:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 1/4] tests: Move the old vmstate-static-checker files to
 tests/data/
Date: Thu, 22 May 2025 15:37:53 +0200
Message-ID: <20250522133756.259194-2-thuth@redhat.com>
In-Reply-To: <20250522133756.259194-1-thuth@redhat.com>
References: <20250522133756.259194-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

All other test data resides in tests/data/, so let's move the dump
files here, too.

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


