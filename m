Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F48D83FC89
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jan 2024 04:06:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHx2-0004GJ-04; Sun, 28 Jan 2024 22:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHx0-0004Fw-37
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwy-0002d3-ET
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706497483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C4ER0TJ1Vqgpct/whtoJPyK9n6HJ6571tM7r0VERKjg=;
 b=YOJq0tjQIw2j/s1wBZ2hN5xdm0ydupBCJhPlXy2SJfddBlCJUPff2SmfN9HFmswFyQ7kYw
 aY4rRLLgWybYQUHqcPYw9ykVbJ53p09848fRjjh/R/aG+1sWyp75IWF6tpiDwnl7sKtlmg
 Hc7cK/3LVgSBSRy1+hFJsUjqiFahVuE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209--JgfVpHCNGGBHe8bEeDkZA-1; Sun, 28 Jan 2024 22:04:38 -0500
X-MC-Unique: -JgfVpHCNGGBHe8bEeDkZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E3E285A588;
 Mon, 29 Jan 2024 03:04:38 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93DA71121306;
 Mon, 29 Jan 2024 03:04:35 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/14] migration/yank: Use channel features
Date: Mon, 29 Jan 2024 11:03:59 +0800
Message-ID: <20240129030405.177100-9-peterx@redhat.com>
In-Reply-To: <20240129030405.177100-1-peterx@redhat.com>
References: <20240129030405.177100-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Fabiano Rosas <farosas@suse.de>

Stop using outside knowledge about the io channels when registering
yank functions. Query for features instead.

The yank method for all channels used with migration code currently is
to call the qio_channel_shutdown() function, so query for
QIO_CHANNEL_FEATURE_SHUTDOWN. We could add a separate feature in the
future for indicating whether a channel supports yanking, but that
seems overkill at the moment.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20230911171320.24372-9-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/yank_functions.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/migration/yank_functions.c b/migration/yank_functions.c
index d5a710a3f2..979e60c762 100644
--- a/migration/yank_functions.c
+++ b/migration/yank_functions.c
@@ -8,12 +8,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "io/channel.h"
 #include "yank_functions.h"
 #include "qemu/yank.h"
-#include "io/channel-socket.h"
-#include "io/channel-tls.h"
 #include "qemu-file.h"
 
 void migration_yank_iochannel(void *opaque)
@@ -26,8 +23,7 @@ void migration_yank_iochannel(void *opaque)
 /* Return whether yank is supported on this ioc */
 static bool migration_ioc_yank_supported(QIOChannel *ioc)
 {
-    return object_dynamic_cast(OBJECT(ioc), TYPE_QIO_CHANNEL_SOCKET) ||
-        object_dynamic_cast(OBJECT(ioc), TYPE_QIO_CHANNEL_TLS);
+    return qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
 }
 
 void migration_ioc_register_yank(QIOChannel *ioc)
-- 
2.43.0


