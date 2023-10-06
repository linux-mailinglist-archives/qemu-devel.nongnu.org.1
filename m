Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D94D7BBFE4
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 21:54:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoqsc-0002er-6t; Fri, 06 Oct 2023 15:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoqsZ-0002cu-US
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 15:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoqsX-0007mh-Uu
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 15:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696621973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQDbRgjtLBWHoRHUp767G/njXezUrfB1YoZjPcQi4I4=;
 b=HFdqUzLhKMkVmLLhBENhsMWV1r37ZnwjbONGNjy+Zph5UWZLxhU/sSF2rNGneMoe0z2zDx
 6L9ZKSlGAlG+0n7NlDX+VO/YGOSj7EC1BVEo1/e4WYiGiLWyt0m9lXpVGF/aCw0+sZOhGV
 ssGSqU8ArBOUe4KBVq19zVRVg7nj2k0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-yeF4gEEmMo2AV_OlF6oj0A-1; Fri, 06 Oct 2023 15:52:46 -0400
X-MC-Unique: yeF4gEEmMo2AV_OlF6oj0A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAB94101AA42;
 Fri,  6 Oct 2023 19:52:45 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21E2C492C37;
 Fri,  6 Oct 2023 19:52:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] python/qmp: remove Server.wait_closed() call for Python
 3.12
Date: Fri,  6 Oct 2023 15:52:41 -0400
Message-ID: <20231006195243.3131140-3-jsnow@redhat.com>
In-Reply-To: <20231006195243.3131140-1-jsnow@redhat.com>
References: <20231006195243.3131140-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch is a backport from
https://gitlab.com/qemu-project/python-qemu-qmp/-/commit/e03a3334b6a477beb09b293708632f2c06fe9f61

According to Guido in https://github.com/python/cpython/issues/104344 ,
this call was never meant to wait for the server to shut down - that is
handled synchronously - but instead, this waits for all connections to
close. Or, it would have, if it wasn't broken since it was introduced.

3.12 fixes the bug, which now causes a hang in our code. The fix is just
to remove the wait.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/protocol.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 753182131f..a4ffdfad51 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -495,7 +495,6 @@ async def _stop_server(self) -> None:
         try:
             self.logger.debug("Stopping server.")
             self._server.close()
-            await self._server.wait_closed()
             self.logger.debug("Server stopped.")
         finally:
             self._server = None
-- 
2.41.0


