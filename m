Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F84A792F46
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 21:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdc3v-0001fy-Rz; Tue, 05 Sep 2023 15:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qdc3p-0001fB-2y
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qdc3m-000748-UW
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693943401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnxMLOdkCYgopxLY1rvdP2RTgzKcmoW8syFULwN7vZ0=;
 b=Lx1CY8qHLLmLkaUFZyXLIMt+J+Je71cDn7HKT53Kf2Rbrpm9XNtLUHMplSGo6R8P+R8WsO
 d9rcl0qxJnVYkuVwdzDoe+wuxznzrtTfT6LsLvVzmJxpU85WaXocDMHHLStj7z0FjpKgZZ
 8dF6eYFsK5FdcLL4aTHvEPZDwNYulrE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-QA7NUfD3M2qUZ7gMzPtocA-1; Tue, 05 Sep 2023 15:48:51 -0400
X-MC-Unique: QA7NUfD3M2qUZ7gMzPtocA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4A808279A4
 for <qemu-devel@nongnu.org>; Tue,  5 Sep 2023 19:48:50 +0000 (UTC)
Received: from tapioca.wind3.hub (unknown [10.45.225.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB5B2C15BB8;
 Tue,  5 Sep 2023 19:48:49 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v1 2/7] qapi: fix example of get-win32-socket command
Date: Tue,  5 Sep 2023 21:48:41 +0200
Message-ID: <20230905194846.169530-3-victortoso@redhat.com>
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

Example output lacks double quotes. Fix it.

Fixes: 4cda177c60 "qmp: add 'get-win32-socket'"
Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 qapi/misc.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index cda2effa81..be302cadeb 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -290,7 +290,7 @@
 #
 # Example:
 #
-# -> { "execute": "get-win32-socket", "arguments": { "info": "abcd123..", fdname": "skclient" } }
+# -> { "execute": "get-win32-socket", "arguments": { "info": "abcd123..", "fdname": "skclient" } }
 # <- { "return": {} }
 ##
 { 'command': 'get-win32-socket', 'data': {'info': 'str', 'fdname': 'str'}, 'if': 'CONFIG_WIN32' }
-- 
2.41.0


