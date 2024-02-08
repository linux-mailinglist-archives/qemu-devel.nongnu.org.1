Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7B384DDFE
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Feb 2024 11:19:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY1Td-00087u-1M; Thu, 08 Feb 2024 05:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rY1Ta-000876-Jm
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:17:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rY1TZ-0001J9-1L
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707387467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=x4nedgFi/3ORFKAr0S9dgGldN7czDX44jzpx20v/i9g=;
 b=Ram/9EnbkSSpY3pDJ0XG9iKKUaNOPTI7pI0m9LU3fJBA3Mt9tdQSwo7zcGVOtQtjTDg0YP
 A1msJdbL/sPF0bXP/YDowbe04fwKN9jFpnxDYOcpthtzlD+Q3cya4yCElePXI4KtgVNeTY
 8AhCMP7/YqNdRXQFVLeFovItB5pPGkw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-tBQ_OzrXM2KfEnfk1lxccw-1; Thu,
 08 Feb 2024 05:17:46 -0500
X-MC-Unique: tBQ_OzrXM2KfEnfk1lxccw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C18A13CBDF69;
 Thu,  8 Feb 2024 10:17:45 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AAC0492BFA;
 Thu,  8 Feb 2024 10:17:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-trivial@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH] iothread: Simplify expression in qemu_in_iothread()
Date: Thu,  8 Feb 2024 11:16:57 +0100
Message-ID: <20240208101657.15962-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

'a == b ? false : true' is a rather convoluted way of writing 'a != b'.
Use the more obvious way to write it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 iothread.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/iothread.c b/iothread.c
index 6c1fc8c856..e1e9e04736 100644
--- a/iothread.c
+++ b/iothread.c
@@ -404,6 +404,5 @@ IOThread *iothread_by_id(const char *id)
 
 bool qemu_in_iothread(void)
 {
-    return qemu_get_current_aio_context() == qemu_get_aio_context() ?
-                    false : true;
+    return qemu_get_current_aio_context() != qemu_get_aio_context();
 }
-- 
2.43.0


