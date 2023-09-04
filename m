Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F767919D4
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:42:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAm0-0004Fx-RI; Mon, 04 Sep 2023 10:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qdAlT-0004DE-Ng
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:41:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qdAlP-0002pV-E1
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:41:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5411B1F74B;
 Mon,  4 Sep 2023 14:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693838471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wzS3yflQ+6KH2PRc4G1mv/+afZhqkS/3UCtLZehxkbM=;
 b=Zl+ewZBjhfQv3yUWlOs8nV6SOqY5wUTSo76isyffu+mbFcIa0kKKIS7GQ0uREcp0pRQM1L
 q0cGUXtbGBU5LMFmFpi7G2KQ9lDmsXHlnFjKkmbQdBQEm/WLjaeu1XMErBmWhv0aGlYTvA
 dbCeT1e0Y2P3gUxLynn82NzEFu4+aWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693838471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wzS3yflQ+6KH2PRc4G1mv/+afZhqkS/3UCtLZehxkbM=;
 b=sq0uP8ixgmyUwxv04tGzm03UWhonRqZiBzkGpdea42/6/8KkNViLlVZEBQ/GCowqRCONYC
 pslbqVvuHp+EExDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7108113425;
 Mon,  4 Sep 2023 14:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /LbJDobs9WRINQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 04 Sep 2023 14:41:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] io: Stop appending -listen to net listeners
Date: Mon,  4 Sep 2023 11:41:08 -0300
Message-Id: <20230904144108.3825-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
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

All callers of qio_net_listener_set_name() already add some sort of
"listen" or "listener" suffix.

For intance, we currently have "migration-socket-listener-listen" and
"vnc-listen-listen" as ioc names.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 io/net-listener.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/io/net-listener.c b/io/net-listener.c
index 1c984d69c6..47405965a6 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -109,9 +109,7 @@ void qio_net_listener_add(QIONetListener *listener,
                           QIOChannelSocket *sioc)
 {
     if (listener->name) {
-        char *name = g_strdup_printf("%s-listen", listener->name);
-        qio_channel_set_name(QIO_CHANNEL(sioc), name);
-        g_free(name);
+        qio_channel_set_name(QIO_CHANNEL(sioc), listener->name);
     }
 
     listener->sioc = g_renew(QIOChannelSocket *, listener->sioc,
-- 
2.35.3


