Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7E47D3F19
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:22:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzYb-0004V0-S4; Mon, 23 Oct 2023 14:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quzYZ-0004Jl-Fm
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:21:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quzYY-0001E2-2o
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:21:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E37021FE31;
 Mon, 23 Oct 2023 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698085296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKye7Pqd1enq30MKET0u/d+kSFKEJVCSxbObdi2ofZc=;
 b=YJOVoy4Khpo7zDRiGfGzvgh4QdN8DNWqT1Q/zkbt5Y0EZ4fxz+LQbvBGiLj2ajS+1IV/Lw
 iUjNOEbr/ToOdFOycyZc+HKfFBIzBxu5TJWzGZPLCkfDngOCMHvLORjFj6Y9d+h291ZYzb
 GifYMgbBqmdfvfO7j4LtS4/FOjVrB2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698085296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKye7Pqd1enq30MKET0u/d+kSFKEJVCSxbObdi2ofZc=;
 b=f/jF1sE0JeJUZkD6VZXHPrByhBnjKgcTYt0MZwGRNeRjNMazzMGOw+zTpJh+QGWA/4HEFO
 hp5kYQ6+vkN9sEAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A811B132FD;
 Mon, 23 Oct 2023 18:21:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SMNuHK25NmX8ZwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 18:21:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v15 10/14] fixup! migration: New migrate and migrate-incoming
 argument 'channels'
Date: Mon, 23 Oct 2023 15:20:49 -0300
Message-Id: <20231023182053.8711-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023182053.8711-1-farosas@suse.de>
References: <20231023182053.8711-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -6.05
X-Spamd-Result: default: False [-6.05 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SUBJECT_HAS_EXCLAIM(0.00)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RCPT_COUNT_TWELVE(0.00)[13]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.95)[99.80%]
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/migration.json | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index fa9534a661..2cfdae894a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1666,6 +1666,14 @@
 #                                    "port": "1050" } } ] } }
 # <- { "return": {} }
 #
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "file",
+#                                    "filename": "/tmp/migfile",
+#                                    "offset": "0x1000" } } ] } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate',
   'data': {'*uri': 'str', '*channels': [ 'MigrationChannel' ],
-- 
2.35.3


