Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E23792F4A
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 21:51:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdc45-0001gj-JL; Tue, 05 Sep 2023 15:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qdc3r-0001fS-Qz
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qdc3p-0007Go-GU
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693943404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MatSUmxYr5DoLotV5qoZ7llEGcu3HutS02vkRhckVus=;
 b=f5THNKGSJbX6g/ZxLSjXVNQ1FoxCwlPaJntizHgKYQocL5R513Tj1dcRtOYifFeHM0Td8z
 dVWwSTEWGj0iafJK8p2K3lybw4Dk8SmioLT6B5EeRFMDkNPbdhYBv+7ItIZejwZUUn4/ZX
 V+r0B40qjCZ+29fMg8YmJu0Y+TvsVWQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-4lFSqYUSNGixRteTb39nmQ-1; Tue, 05 Sep 2023 15:48:53 -0400
X-MC-Unique: 4lFSqYUSNGixRteTb39nmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 690178A4362
 for <qemu-devel@nongnu.org>; Tue,  5 Sep 2023 19:48:53 +0000 (UTC)
Received: from tapioca.wind3.hub (unknown [10.45.225.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DBCBC15BB8;
 Tue,  5 Sep 2023 19:48:52 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v1 4/7] qapi: fix example of cancel-vcpu-dirty-limit command
Date: Tue,  5 Sep 2023 21:48:43 +0200
Message-ID: <20230905194846.169530-5-victortoso@redhat.com>
In-Reply-To: <20230905194846.169530-1-victortoso@redhat.com>
References: <20230905194846.169530-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
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
index 8843e74b59..9385b9f87c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2010,7 +2010,7 @@
 #
 # Example:
 #
-# -> {"execute": "cancel-vcpu-dirty-limit"},
+# -> {"execute": "cancel-vcpu-dirty-limit",
 #     "arguments": { "cpu-index": 1 } }
 # <- { "return": {} }
 ##
-- 
2.41.0


