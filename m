Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF80D7A6C3F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 22:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qihC2-0001vE-FZ; Tue, 19 Sep 2023 16:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qihBm-0001sF-Co
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 16:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qihBk-0003ai-T5
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 16:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695154756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DaIv7QYIs85wZyypYVvtp41wiFN3jTuNPRr7lspyX94=;
 b=WHkphPcBu+Xy3hx9EljwEheEXWfP3bKdML9ftd1E40YaHp6fNNBNvinJbtOklI5uQ/RKEV
 j97KSgig7UJvCkYxTnB2S5OojFWiTnmKLpmrDajNONAbVdSAs37IPsVmSmMeuoXTY0Uvra
 sztLEbsLOmYd6t5pvDhUdbw4qsFhwq8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-4vwys81GPVq-i4JJiR8Ndg-1; Tue, 19 Sep 2023 16:19:13 -0400
X-MC-Unique: 4vwys81GPVq-i4JJiR8Ndg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 462F93812589
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 20:19:13 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.224.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0709F140E950;
 Tue, 19 Sep 2023 20:19:11 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 07/10] qapi: fix example of query-blockstats command
Date: Tue, 19 Sep 2023 22:18:54 +0200
Message-ID: <20230919201857.675913-8-victortoso@redhat.com>
In-Reply-To: <20230919201857.675913-1-victortoso@redhat.com>
References: <20230919201857.675913-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Example output has several missing commas. Add them.

Signed-off-by: Victor Toso <victortoso@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2b1d493d6e..6a81103594 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1167,10 +1167,10 @@
 #                   "wr_bytes":9786368,
 #                   "wr_operations":751,
 #                   "rd_bytes":122567168,
-#                   "rd_operations":36772
-#                   "wr_total_times_ns":313253456
-#                   "rd_total_times_ns":3465673657
-#                   "flush_total_times_ns":49653
+#                   "rd_operations":36772,
+#                   "wr_total_times_ns":313253456,
+#                   "rd_total_times_ns":3465673657,
+#                   "flush_total_times_ns":49653,
 #                   "flush_operations":61,
 #                   "rd_merged":0,
 #                   "wr_merged":0,
@@ -1184,10 +1184,10 @@
 #                "wr_bytes":9786368,
 #                "wr_operations":692,
 #                "rd_bytes":122739200,
-#                "rd_operations":36604
+#                "rd_operations":36604,
 #                "flush_operations":51,
-#                "wr_total_times_ns":313253456
-#                "rd_total_times_ns":3465673657
+#                "wr_total_times_ns":313253456,
+#                "rd_total_times_ns":3465673657,
 #                "flush_total_times_ns":49653,
 #                "rd_merged":0,
 #                "wr_merged":0,
@@ -1204,10 +1204,10 @@
 #                "wr_bytes":0,
 #                "wr_operations":0,
 #                "rd_bytes":0,
-#                "rd_operations":0
+#                "rd_operations":0,
 #                "flush_operations":0,
-#                "wr_total_times_ns":0
-#                "rd_total_times_ns":0
+#                "wr_total_times_ns":0,
+#                "rd_total_times_ns":0,
 #                "flush_total_times_ns":0,
 #                "rd_merged":0,
 #                "wr_merged":0,
@@ -1223,10 +1223,10 @@
 #                "wr_bytes":0,
 #                "wr_operations":0,
 #                "rd_bytes":0,
-#                "rd_operations":0
+#                "rd_operations":0,
 #                "flush_operations":0,
-#                "wr_total_times_ns":0
-#                "rd_total_times_ns":0
+#                "wr_total_times_ns":0,
+#                "rd_total_times_ns":0,
 #                "flush_total_times_ns":0,
 #                "rd_merged":0,
 #                "wr_merged":0,
@@ -1242,10 +1242,10 @@
 #                "wr_bytes":0,
 #                "wr_operations":0,
 #                "rd_bytes":0,
-#                "rd_operations":0
+#                "rd_operations":0,
 #                "flush_operations":0,
-#                "wr_total_times_ns":0
-#                "rd_total_times_ns":0
+#                "wr_total_times_ns":0,
+#                "rd_total_times_ns":0,
 #                "flush_total_times_ns":0,
 #                "rd_merged":0,
 #                "wr_merged":0,
-- 
2.41.0


