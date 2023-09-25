Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A87B7AD404
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 11:01:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkhT1-0002DL-Sh; Mon, 25 Sep 2023 05:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkhSo-00025A-Jh
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkhSl-0002Zv-Gv
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695632466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMH6LT8UbAY0xVZ6P5tVjLEizp8UwFrpI9CyGxulhp4=;
 b=cSWQL16zZrvEbxzptssHhmsehoJszBfkWg6W99ZlqcHT/TmSUjOgAWgW0QmeVK5OH/RT7C
 uo3MKUnWQkRAl+Dij2/RZv2hWKLg3tsd+K+Ph10UGrOWcjc/6UMUWtPs2f5b9D0VkyKFZ0
 nU14RgUP6bf7vwzX+wwYQwUuds0wDfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-686-t7y1ZDvrNve_vqfkp54gLQ-1; Mon, 25 Sep 2023 05:01:04 -0400
X-MC-Unique: t7y1ZDvrNve_vqfkp54gLQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 315768007A4
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 09:01:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D10F140E962;
 Mon, 25 Sep 2023 09:01:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 2/7] tests/qtest/netdev-socket: Raise connection timeout to 120
 seconds
Date: Mon, 25 Sep 2023 11:00:55 +0200
Message-ID: <20230925090100.45632-3-thuth@redhat.com>
In-Reply-To: <20230925090100.45632-1-thuth@redhat.com>
References: <20230925090100.45632-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The test still fails intermittently with a 60 second timeout in the
GitLab CI environment. Raise the timeout to 120 seconds.

  576/839 ERROR:../tests/qtest/netdev-socket.c:293:test_stream_unix:
   assertion failed (resp == expect):
   ("st0: index=0,type=stream,connection error\r\n" == "st0: index=0,type=stream,unix:/tmp/netdev-socket.UW5IA2/stream_unix\r\n") ERROR
  576/839 qemu:qtest+qtest-sh4 / qtest-sh4/netdev-socket
                              ERROR          62.85s   killed by signal 6 SIGABRT
  >>> MALLOC_PERTURB_=249 QTEST_QEMU_BINARY=./qemu-system-sh4
   QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon
   G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh
   QTEST_QEMU_IMG=./qemu-img /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/tests/qtest/netdev-socket --tap -k
  ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
  stderr:
  **
  ERROR:../tests/qtest/netdev-socket.c:293:test_stream_unix: assertion failed (resp == expect): ("st0: index=0,type=stream,connection error\r\n" == "st0: index=0,type=stream,unix:/tmp/netdev-socket.UW5IA2/stream_unix\r\n")
  (test program exited with status code -6)

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1881
Fixes: 417296c8d858 ("tests/qtest/netdev-socket: Raise connection timeout to 60 seconds")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Message-ID: <20230912133310.60583-1-stefanha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/netdev-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
index 8eed54801f..b2501d72a1 100644
--- a/tests/qtest/netdev-socket.c
+++ b/tests/qtest/netdev-socket.c
@@ -16,7 +16,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
 
-#define CONNECTION_TIMEOUT    60
+#define CONNECTION_TIMEOUT    120
 
 #define EXPECT_STATE(q, e, t)                             \
 do {                                                      \
-- 
2.41.0


