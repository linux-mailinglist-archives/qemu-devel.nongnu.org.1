Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5309F54F3
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Dec 2024 18:50:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbhC-0005rv-Fx; Tue, 17 Dec 2024 12:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNbh9-0005qQ-3b; Tue, 17 Dec 2024 12:49:19 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNbh5-0007f6-R7; Tue, 17 Dec 2024 12:49:18 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D7A291F399;
 Tue, 17 Dec 2024 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJQHmFS/U6T5S0zJNTcT+SuyStrXP5rx7/+8qL0mdOs=;
 b=WcofOuS0Ma5v+bLp9AlLUNzRSSOm6fcuw2grVD8uplG3KCI+ySKnr0J0WYI9slZ4ja24rZ
 Rci0JAEcQINGfRIlWrDmldtcwCea+kBzbDZoiA3DxIXdQVhZ+qy2n0FmeOISZh+wSpdSZ4
 93B7kWM5kfqj4Qhewru9R7JKaaNXQck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457752;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJQHmFS/U6T5S0zJNTcT+SuyStrXP5rx7/+8qL0mdOs=;
 b=DNh/VFosr4/0fLI4UeI4KIUg/8BoQSlKGWDRhzK3aLfYGiJvFHLjiK071iyNqP3ZWi17Wb
 TlWSYbJNSig0x/DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJQHmFS/U6T5S0zJNTcT+SuyStrXP5rx7/+8qL0mdOs=;
 b=e5MmS4rEZTnsTYuvQDp+nvg5jaQDlFjQU3asvf088jAnBVO6uh6+AZemhuStRKMsaR7BuW
 RPtzQBn2RL5Parxo3UWf50xU61GN0V02PxnbRGpWhJsfeXUZPmw3FkWJZPdfSpwidfHX5o
 2BNSDc7o0kyrH3hR7E8mqpvo7FSSC5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJQHmFS/U6T5S0zJNTcT+SuyStrXP5rx7/+8qL0mdOs=;
 b=xf4/ZFegWbACPMCNLUykjtTbATK+Eezrx43lgCtgYljWTQ2j5mN6mWYJjO+XdkIY+j67jb
 wlZOCDcyP+pRfiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A862B13A3C;
 Tue, 17 Dec 2024 17:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oKwpG5a5YWd1TwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 17:49:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	qemu-stable@nongnu.org
Subject: [PULL 09/17] migration/multifd: Fix compat with QEMU < 9.0
Date: Tue, 17 Dec 2024 14:48:47 -0300
Message-Id: <20241217174855.24971-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241217174855.24971-1-farosas@suse.de>
References: <20241217174855.24971-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Commit f5f48a7891 ("migration/multifd: Separate SYNC request with
normal jobs") changed the multifd source side to stop sending data
along with the MULTIFD_FLAG_SYNC, effectively introducing the concept
of a SYNC-only packet. Relying on that, commit d7e58f412c
("migration/multifd: Don't send ram data during SYNC") later came
along and skipped reading data from SYNC packets.

In a versions timeline like this:

  8.2 f5f48a7 9.0 9.1 d7e58f41 9.2

The issue arises that QEMUs < 9.0 still send data along with SYNC, but
QEMUs > 9.1 don't gather that data anymore. This leads to various
kinds of migration failures due to desync/missing data.

Stop checking for a SYNC packet on the destination and unconditionally
unfill the packet.

>From now on:

old -> new:
the source sends data + sync, destination reads normally

new -> new:
source sends only sync, destination reads zeros

new -> old:
source sends only sync, destination reads zeros

CC: qemu-stable@nongnu.org
Fixes: d7e58f412c ("migration/multifd: Don't send ram data during SYNC")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2720
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241213160120.23880-2-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 7ecc3964ee..e98af0f116 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -252,9 +252,8 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->packet_num = be64_to_cpu(packet->packet_num);
     p->packets_recved++;
 
-    if (!(p->flags & MULTIFD_FLAG_SYNC)) {
-        ret = multifd_ram_unfill_packet(p, errp);
-    }
+    /* Always unfill, old QEMUs (<9.0) send data along with SYNC */
+    ret = multifd_ram_unfill_packet(p, errp);
 
     trace_multifd_recv_unfill(p->id, p->packet_num, p->flags,
                               p->next_packet_size);
@@ -1156,9 +1155,13 @@ static void *multifd_recv_thread(void *opaque)
             flags = p->flags;
             /* recv methods don't know how to handle the SYNC flag */
             p->flags &= ~MULTIFD_FLAG_SYNC;
-            if (!(flags & MULTIFD_FLAG_SYNC)) {
-                has_data = p->normal_num || p->zero_num;
-            }
+
+            /*
+             * Even if it's a SYNC packet, this needs to be set
+             * because older QEMUs (<9.0) still send data along with
+             * the SYNC packet.
+             */
+            has_data = p->normal_num || p->zero_num;
             qemu_mutex_unlock(&p->mutex);
         } else {
             /*
-- 
2.35.3


