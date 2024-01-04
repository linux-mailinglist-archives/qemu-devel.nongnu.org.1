Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E31823B81
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:36:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFRI-0004ry-CK; Wed, 03 Jan 2024 23:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQw-0004ew-SW
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:34:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQv-0006kK-81
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=npgsv/Aqt/+Dln7YULjrFDqK7akW53zfrukoD4RwOAU=;
 b=dySepsfzUpqFYwKP/EVVxKiWsAksVUmF/iH1T93Uc0PIHbB8VVoz6XGAq9eAct74cGQZzO
 hGc2yawChqIrf++75X73gpnMaj77wYw5I8niwCdCsOXG6Pz9wclCrB/KPFYDPX0EeZV/tA
 hjavzDSLi5rykkCblWC5pwhbfUGKf54=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-7DFXF-ZYN-OuZTHSL7RvZw-1; Wed, 03 Jan 2024 23:34:13 -0500
X-MC-Unique: 7DFXF-ZYN-OuZTHSL7RvZw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D947685A589;
 Thu,  4 Jan 2024 04:34:12 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 727C7C159B0;
 Thu,  4 Jan 2024 04:34:08 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/26] migration: Fix migration_channel_read_peek() error path
Date: Thu,  4 Jan 2024 12:32:08 +0800
Message-ID: <20240104043213.431566-24-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

migration_channel_read_peek() calls qio_channel_readv_full() and handles
both cases of return value == 0 and return value < 0 the same way, by
calling error_setg() with errp. However, if return value < 0, errp is
already set, so calling error_setg() with errp will lead to an assert.

Fix it by handling these cases separately, calling error_setg() with
errp only in return value == 0 case.

Fixes: 6720c2b32725 ("migration: check magic value for deciding the mapping of channels")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20231231093016.14204-10-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index ca3319a309..f9de064f3b 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -117,9 +117,12 @@ int migration_channel_read_peek(QIOChannel *ioc,
         len = qio_channel_readv_full(ioc, &iov, 1, NULL, NULL,
                                      QIO_CHANNEL_READ_FLAG_MSG_PEEK, errp);
 
-        if (len <= 0 && len != QIO_CHANNEL_ERR_BLOCK) {
-            error_setg(errp,
-                       "Failed to peek at channel");
+        if (len < 0 && len != QIO_CHANNEL_ERR_BLOCK) {
+            return -1;
+        }
+
+        if (len == 0) {
+            error_setg(errp, "Failed to peek at channel");
             return -1;
         }
 
-- 
2.41.0


