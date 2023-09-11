Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7DC79AA89
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 19:15:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfkTq-0002oP-V9; Mon, 11 Sep 2023 13:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTp-0002nu-HG
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTn-0000Bw-D2
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4F96A1F8BB;
 Mon, 11 Sep 2023 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694452422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGGxjAB3Urj0ONFUV5hITxPJOdr38wwUKzL/jNXoWEg=;
 b=tsmb8PPjP45TPN2siHZud1J2W8QTAnW35az3StrPHvHsZNNvojVmedfwF4VksPUgZ6rxKL
 jeA9j4Tna2jczMQ7kfsvey84eZZfsOPwJDFsutevT4hwZ/Q5FGu8qHHN9zshS/Sje7NN7a
 mPYxKh9sZqIpkW3ibuRwgi+Jv+jkX3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694452422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGGxjAB3Urj0ONFUV5hITxPJOdr38wwUKzL/jNXoWEg=;
 b=Lp+y+BPmHYFuPRB52wNDlKGyaKH8tjv5HUhyYdgQEbErASLhgYpeF1PU+YbGJDc7q9LlDp
 SZS1U32U97t+KaAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7300A139CC;
 Mon, 11 Sep 2023 17:13:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2KVSDMRK/2QyIAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 11 Sep 2023 17:13:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v6 08/10] migration/yank: Use channel features
Date: Mon, 11 Sep 2023 14:13:18 -0300
Message-Id: <20230911171320.24372-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230911171320.24372-1-farosas@suse.de>
References: <20230911171320.24372-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stop using outside knowledge about the io channels when registering
yank functions. Query for features instead.

The yank method for all channels used with migration code currently is
to call the qio_channel_shutdown() function, so query for
QIO_CHANNEL_FEATURE_SHUTDOWN. We could add a separate feature in the
future for indicating whether a channel supports yanking, but that
seems overkill at the moment.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
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
2.35.3


