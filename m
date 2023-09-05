Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB447792F50
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 21:51:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdc3y-0001gQ-07; Tue, 05 Sep 2023 15:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qdc3r-0001fP-DG
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qdc3o-0007Df-7R
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693943403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XScpzLc8agw3aaYccrT5LahnsjsNTTsv3y/XOx+z70U=;
 b=Sy9ZxbhATYvGSpeJNLSQctREhvQnSj6dfE3Jtwiw45U624NBMe+bv3qrVK7GWVGarSJoTb
 elDqBOQOYZMWdtRk+xzjb0myHtUfvXYfY3wAJlm7N5QDuRtdbMcs+mdsmHn//7Qf2C1UHV
 HGA/RFm985Dbrjtu/xWBHnkSPcaP/OI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-678-D6Oacq4YNwGPScW7zFLWBQ-1; Tue, 05 Sep 2023 15:48:54 -0400
X-MC-Unique: D6Oacq4YNwGPScW7zFLWBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7B4180E99F
 for <qemu-devel@nongnu.org>; Tue,  5 Sep 2023 19:48:54 +0000 (UTC)
Received: from tapioca.wind3.hub (unknown [10.45.225.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB590C15BB8;
 Tue,  5 Sep 2023 19:48:53 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v1 5/7] qapi: fix example of set-vcpu-dirty-limit command
Date: Tue,  5 Sep 2023 21:48:44 +0200
Message-ID: <20230905194846.169530-6-victortoso@redhat.com>
In-Reply-To: <20230905194846.169530-1-victortoso@redhat.com>
References: <20230905194846.169530-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

Example output has extra end curly bracket. Remove it.

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 qapi/migration.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 9385b9f87c..2658cdbcbe 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1986,7 +1986,7 @@
 #
 # Example:
 #
-# -> {"execute": "set-vcpu-dirty-limit"}
+# -> {"execute": "set-vcpu-dirty-limit",
 #     "arguments": { "dirty-rate": 200,
 #                    "cpu-index": 1 } }
 # <- { "return": {} }
-- 
2.41.0


