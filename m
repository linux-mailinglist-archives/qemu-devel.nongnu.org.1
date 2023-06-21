Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D311737F65
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:19:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuvU-0008Ew-HF; Wed, 21 Jun 2023 06:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qBuvA-0008ED-6t
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qBuv8-0000mb-Hy
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687342715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLNtr/x4PWBB8R0PBY8duz4qpkYeyDQaoYGTh+FUYAo=;
 b=PRmQq1YXnIsr+3JPHmAkDb+JaGu5V1W42GDZxdMbZt7zMUV3S7G6snzoaw9juC8WT4q1Ld
 J1GhHEC5jDYhkW5ok7Ud3pABqRaCa/J3DNyZVBogwgIX3tR0k4JbAd71NUIYuOX2hzk9VC
 l8wJoT4uBRDze4ulIbYDuEdiaqoHOKQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-HxsjePbNPnCJDFEIPQYeCA-1; Wed, 21 Jun 2023 06:18:32 -0400
X-MC-Unique: HxsjePbNPnCJDFEIPQYeCA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B004A280D58F;
 Wed, 21 Jun 2023 10:18:31 +0000 (UTC)
Received: from nuthatch.redhat.com (unknown [10.45.225.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 848B9492C13;
 Wed, 21 Jun 2023 10:18:30 +0000 (UTC)
From: Milan Zamazal <mzamazal@redhat.com>
To: qemu-devel@nongnu.org
Cc: Milan Zamazal <mzamazal@redhat.com>, mst@redhat.com, stefanha@redhat.com,
 alex.bennee@linaro.org, thuth@redhat.com, vincent.guittot@linaro.org
Subject: [PATCH v2 3/4] tests/qtest: Fix a comment typo in vhost-user-test.c
Date: Wed, 21 Jun 2023 12:17:09 +0200
Message-Id: <20230621101710.297975-4-mzamazal@redhat.com>
In-Reply-To: <20230621101710.297975-1-mzamazal@redhat.com>
References: <20230621101710.297975-1-mzamazal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/vhost-user-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index e4f95b2858..dfb8003597 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -281,7 +281,7 @@ static void read_guest_mem_server(QTestState *qts, TestServer *s)
     /* iterate all regions */
     for (i = 0; i < s->fds_num; i++) {
 
-        /* We'll check only the region statring at 0x0*/
+        /* We'll check only the region starting at 0x0 */
         if (s->memory.regions[i].guest_phys_addr != 0x0) {
             continue;
         }
-- 
2.40.1


