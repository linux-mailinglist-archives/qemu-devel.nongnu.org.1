Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDB47D3F11
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:22:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzY5-0003uR-43; Mon, 23 Oct 2023 14:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quzY2-0003sI-LG
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:21:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quzY0-0001A6-VQ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:21:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 429521FE2D;
 Mon, 23 Oct 2023 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698085263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWg1Jhd+A5ApoooDn6635fYMYZlwnfnLNm6k6rQi7PI=;
 b=OrdOZZUJgqUaMX+Yl1VgqQa6YA527M/mZpG1AvhOPihZaKe/MnRAewEVXZ4429GcUryxtr
 7fcgOK5rGbBxWIWh4n+TrW2gsJYX3Bxy/iQ5E6rIGobw1BqSbORHxourTN3+DhUcX3dSj8
 EBhFp4L8/HDCNQx0fWdiCT90UilHjZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698085263;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWg1Jhd+A5ApoooDn6635fYMYZlwnfnLNm6k6rQi7PI=;
 b=pXnIg9aiMWoKdbo+J/bEDKD8+5IvsfWkZs8gv5vgu0dk+Y2SP9HhAaEHZwJZIwiVEetC63
 Iwo7wnvRvivNClDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A928F132FD;
 Mon, 23 Oct 2023 18:20:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4PSuHIu5NmX8ZwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 18:20:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v15 01/14] migration: New QAPI type 'MigrateAddress'
Date: Mon, 23 Oct 2023 15:20:40 -0300
Message-Id: <20231023182053.8711-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023182053.8711-1-farosas@suse.de>
References: <20231023182053.8711-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -6.10
X-Spamd-Result: default: False [-6.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[13];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[99.98%]
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

From: Het Gala <het.gala@nutanix.com>

This patch introduces well defined MigrateAddress struct
and its related child objects.

The existing argument of 'migrate' and 'migrate-incoming' QAPI
- 'uri' is of type string. The current implementation follows
double encoding scheme for fetching migration parameters like
'uri' and this is not an ideal design.

Motive for intoducing struct level design is to prevent double
encoding of QAPI arguments, as Qemu should be able to directly
use the QAPI arguments without any level of encoding.

Note: this commit only adds the type, and actual uses comes
in later commits.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index db3df12d6c..c352c7ac52 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1508,6 +1508,47 @@
 ##
 { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
 
+##
+# @MigrationAddressType:
+#
+# The migration stream transport mechanisms.
+#
+# @socket: Migrate via socket.
+#
+# @exec: Direct the migration stream to another process.
+#
+# @rdma: Migrate via RDMA.
+#
+# Since 8.2
+##
+{ 'enum': 'MigrationAddressType',
+  'data': ['socket', 'exec', 'rdma'] }
+
+##
+# @MigrationExecCommand:
+#
+# @args: command (list head) and arguments to execute.
+#
+# Since 8.2
+##
+{ 'struct': 'MigrationExecCommand',
+  'data': {'args': [ 'str' ] } }
+
+##
+# @MigrationAddress:
+#
+# Migration endpoint configuration.
+#
+# Since 8.2
+##
+{ 'union': 'MigrationAddress',
+  'base': { 'transport' : 'MigrationAddressType'},
+  'discriminator': 'transport',
+  'data': {
+    'socket': 'SocketAddress',
+    'exec': 'MigrationExecCommand',
+    'rdma': 'InetSocketAddress' } }
+
 ##
 # @migrate:
 #
-- 
2.35.3


