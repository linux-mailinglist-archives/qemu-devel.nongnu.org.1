Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A98C7AD405
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 11:01:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkhTJ-0002Tv-4A; Mon, 25 Sep 2023 05:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkhSs-00026r-By
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkhSq-0002aq-V2
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695632471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdzTnFO+kiRG6HD6kNM9fZRiuFTjsqCmUDwA2ZI9yO0=;
 b=bQinq8RaoJc8tmudBEnRnMlAokzlm0PGCwDRGQ+KwEEpjV0hQC9NucPsLQYc0pk8QWQ5Sr
 /GHkRQJWT14K2MHHQ/R/ZLee9TQFnJ1Grm0yKvTjFFD+gOOy+xVLBXyNBmgG27d3UXbYJX
 nxsmK+CXxgp3aSRpUhbENCLk3dsc6f4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169--7v--3OcO1ez7TfMihtnzw-1; Mon, 25 Sep 2023 05:01:09 -0400
X-MC-Unique: -7v--3OcO1ez7TfMihtnzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EC51803D69
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 09:01:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B460C140E965;
 Mon, 25 Sep 2023 09:01:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 7/7] tests/avocado: fix waiting for vm shutdown in replay_linux
Date: Mon, 25 Sep 2023 11:01:00 +0200
Message-ID: <20230925090100.45632-8-thuth@redhat.com>
In-Reply-To: <20230925090100.45632-1-thuth@redhat.com>
References: <20230925090100.45632-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

This patch fixes the race condition in waiting for shutdown
of the replay linux test.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Suggested-by: John Snow <jsnow@redhat.com>
Message-ID: <20230811070608.3383343-4-pavel.dovgalyuk@ispras.ru>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/replay_linux.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index a76dd507fc..270ccc1eae 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -93,7 +93,7 @@ def launch_and_wait(self, record, args, shift):
                 % os.path.getsize(replay_path))
         else:
             vm.event_wait('SHUTDOWN', self.timeout)
-            vm.shutdown(True)
+            vm.wait()
             logger.info('successfully fihished the replay')
         elapsed = time.time() - start_time
         logger.info('elapsed time %.2f sec' % elapsed)
-- 
2.41.0


