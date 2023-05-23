Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB93370E785
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 23:40:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Zj4-0000a2-E1; Tue, 23 May 2023 17:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1Zj2-0000VO-0q; Tue, 23 May 2023 17:39:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1Zj0-0004fZ-I4; Tue, 23 May 2023 17:39:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 105122230F;
 Tue, 23 May 2023 21:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684877961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sE8uQW9/c5L7j6pxID4MOVzXCAwl4cvJMoDUBD3pipY=;
 b=gDYlhJ9ZGivbaxXz5WIkRag9ik3c5JTxvGPi1c3UB4TQ81/MpgUcLyYoZTebmQOhlMu6/0
 5M9K1jQS7Ttao/HKc1TGPuiL3+CKJWCs5IOiiEOjLCT9AKYG+zqU/gDNghrP0QAE+qOaUO
 uoDwmrdNKSyKj7VtUYntTCpBqf5nt3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684877961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sE8uQW9/c5L7j6pxID4MOVzXCAwl4cvJMoDUBD3pipY=;
 b=dnxYUTLsXRvyQ+yLzw9VRuYcm4cAw7gfnrgIj0rTGpiQZCEwUKZmE+Kc80gI+YguvhwocZ
 y+q1gGgeub5wzGAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76CFF13588;
 Tue, 23 May 2023 21:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CAhTEIYybWQ7CwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 23 May 2023 21:39:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: [RFC PATCH 4/6] Convert query-block/info_block to coroutine
Date: Tue, 23 May 2023 18:39:01 -0300
Message-Id: <20230523213903.18418-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230523213903.18418-1-farosas@suse.de>
References: <20230523213903.18418-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Lin Ma <lma@suse.com>

Sometimes the query-block performs time-consuming I/O(say waiting for
the fstat of NFS complete), So let's make this QMP handler runs in a
coroutine.

The following patch moves the fstat() into a thread pool.

Signed-off-by: Lin Ma <lma@suse.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 blockdev.c           | 6 +++---
 qapi/block-core.json | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 5d56b79df4..6412548662 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2804,9 +2804,9 @@ void qmp_drive_backup(DriveBackup *backup, Error **errp)
     blockdev_do_action(&action, errp);
 }
 
-BlockDeviceInfoList *qmp_query_named_block_nodes(bool has_flat,
-                                                 bool flat,
-                                                 Error **errp)
+BlockDeviceInfoList *coroutine_fn qmp_query_named_block_nodes(bool has_flat,
+                                                              bool flat,
+                                                              Error **errp)
 {
     bool return_flat = has_flat && flat;
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index da95fe456c..0559c38412 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1972,7 +1972,8 @@
 { 'command': 'query-named-block-nodes',
   'returns': [ 'BlockDeviceInfo' ],
   'data': { '*flat': 'bool' },
-  'allow-preconfig': true }
+  'allow-preconfig': true,
+  'coroutine': true}
 
 ##
 # @XDbgBlockGraphNodeType:
-- 
2.35.3


