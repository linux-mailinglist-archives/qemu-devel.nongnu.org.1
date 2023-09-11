Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE29279A847
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 15:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfgvU-00013M-KC; Mon, 11 Sep 2023 09:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qfgvR-000139-Sz
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qfgvP-0005YI-Ey
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694438758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XukD7WQAWxcB/4IriCwKEFniwBQUmNqGAd/3RMX+aWs=;
 b=X+IKKZWvVDvq6fZIzQLXf3XLj4j98MU/4G3VHHCC7gXOI1akCokXyUd4PInbPV+C41PrpB
 r86Yp810crFfi5TDqfE8VnP+slIm17mR5pZcIBPc6ukdfFBcQeU1BnAI0BjP1Gy3pJ9a6Z
 2oGr45L16IqiGbqDJo1Y7qHHTwp9v8Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-689-j-rxe8ioMp6BmlHHjxCGUQ-1; Mon, 11 Sep 2023 09:25:55 -0400
X-MC-Unique: j-rxe8ioMp6BmlHHjxCGUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5E363810D3F;
 Mon, 11 Sep 2023 13:25:54 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A5DB10F1BE8;
 Mon, 11 Sep 2023 13:25:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2] tpm: fix crash when FD >= 1024
Date: Mon, 11 Sep 2023 17:25:51 +0400
Message-ID: <20230911132551.1421276-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Replace select() with poll() to fix a crash when QEMU has a large number
of FDs.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=2020133

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_util.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index a6e6d3e72f..1856589c3b 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -112,12 +112,8 @@ static int tpm_util_request(int fd,
                             void *response,
                             size_t responselen)
 {
-    fd_set readfds;
+    GPollFD fds[1] = { {.fd = fd, .events = G_IO_IN } };
     int n;
-    struct timeval tv = {
-        .tv_sec = 1,
-        .tv_usec = 0,
-    };
 
     n = write(fd, request, requestlen);
     if (n < 0) {
@@ -127,11 +123,8 @@ static int tpm_util_request(int fd,
         return -EFAULT;
     }
 
-    FD_ZERO(&readfds);
-    FD_SET(fd, &readfds);
-
     /* wait for a second */
-    n = select(fd + 1, &readfds, NULL, NULL, &tv);
+    n = RETRY_ON_EINTR(g_poll(fds, 1, 1000));
     if (n != 1) {
         return -errno;
     }
-- 
2.41.0


