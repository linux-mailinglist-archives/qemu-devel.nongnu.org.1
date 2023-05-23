Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8B270E788
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 23:40:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Zj1-0000S3-RO; Tue, 23 May 2023 17:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1Ziz-0000Pi-Oi; Tue, 23 May 2023 17:39:21 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1Ziy-0004fD-6d; Tue, 23 May 2023 17:39:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1690A1FDC5;
 Tue, 23 May 2023 21:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684877958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swEfq52Qjpfe+UyjVleJjf81uw2SsrlMeRYlYVeV//M=;
 b=tSVf03BoAVCWMhz+vfPndDmzDonwkJVSs07zoCLT7SJSz6yleQHKIaV8aqmTuMkNAFP5Ew
 3paIS9uWCShcf4Hzp4R/zvP+8ofa/NVoj8z791MQNxL4R1QoLn/n1GMmIS/ub3MrH/6jv0
 x1vxcBfJLW8+65afMNwz7NfJZ5xbHhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684877958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swEfq52Qjpfe+UyjVleJjf81uw2SsrlMeRYlYVeV//M=;
 b=7Bdiu9IlU3Q2ePvZi474EBh7bnOo+h1dxEH/f/CQKQlYVXoZWERbCU0kO7SovucJ4zyC9Y
 buuTpjicrwB/LbDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A9D813588;
 Tue, 23 May 2023 21:39:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uPGkAYMybWQ7CwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 23 May 2023 21:39:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [RFC PATCH 3/6] Convert query-block/info_block to coroutine
Date: Tue, 23 May 2023 18:39:00 -0300
Message-Id: <20230523213903.18418-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230523213903.18418-1-farosas@suse.de>
References: <20230523213903.18418-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
 block/monitor/block-hmp-cmds.c | 2 +-
 block/qapi.c                   | 2 +-
 hmp-commands-info.hx           | 1 +
 include/block/block-hmp-cmds.h | 2 +-
 qapi/block-core.json           | 2 +-
 5 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index ca2599de44..4b704010bc 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -738,7 +738,7 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
     }
 }
 
-void hmp_info_block(Monitor *mon, const QDict *qdict)
+void coroutine_fn hmp_info_block(Monitor *mon, const QDict *qdict)
 {
     BlockInfoList *block_list, *info;
     BlockDeviceInfoList *blockdev_list, *blockdev;
diff --git a/block/qapi.c b/block/qapi.c
index 79bf80c503..ae6cd1c2ff 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -667,7 +667,7 @@ bdrv_query_bds_stats(BlockDriverState *bs, bool blk_level)
     return s;
 }
 
-BlockInfoList *qmp_query_block(Error **errp)
+BlockInfoList *coroutine_fn qmp_query_block(Error **errp)
 {
     BlockInfoList *head = NULL, **p_next = &head;
     BlockBackend *blk;
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 47d63d26db..996895f417 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -65,6 +65,7 @@ ERST
         .help       = "show info of one block device or all block devices "
                       "(-n: show named nodes; -v: show details)",
         .cmd        = hmp_info_block,
+        .coroutine  = true,
     },
 
 SRST
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.h
index 71113cd7ef..6d9152318f 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -48,7 +48,7 @@ void hmp_eject(Monitor *mon, const QDict *qdict);
 
 void hmp_qemu_io(Monitor *mon, const QDict *qdict);
 
-void hmp_info_block(Monitor *mon, const QDict *qdict);
+void coroutine_fn hmp_info_block(Monitor *mon, const QDict *qdict);
 void hmp_info_blockstats(Monitor *mon, const QDict *qdict);
 void hmp_info_block_jobs(Monitor *mon, const QDict *qdict);
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 98d9116dae..da95fe456c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -838,7 +838,7 @@
 #    }
 ##
 { 'command': 'query-block', 'returns': ['BlockInfo'],
-  'allow-preconfig': true }
+  'allow-preconfig': true, 'coroutine': true }
 
 ##
 # @BlockDeviceTimedStats:
-- 
2.35.3


