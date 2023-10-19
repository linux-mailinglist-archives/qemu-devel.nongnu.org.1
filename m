Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 755567D0270
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 21:25:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtYct-0006Bb-Gy; Thu, 19 Oct 2023 15:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtYcr-0006A5-H4
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:24:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtYcq-0004tO-0H
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:24:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44CEF1FD7F;
 Thu, 19 Oct 2023 19:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697743446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2kZ9ZbzcFRFIHJjA/mxSzjDBoZtJEm9rryi3QlcVYg=;
 b=uoHIVl7Tbx2xGd+tYLF7SSB6JYI0ZF5x3kN44XSkF9G2xJENZY2TmxMkIekQJuKLnnThcZ
 VPNLvhyiJCldxS/RaxkXIbVkav8bsm+LSbJ80PmGtgh4AXsDFZsROlRuovEHMmLsnLcawl
 8/fZLupnd0600M9JAqdTuAdwX78fHbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697743446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2kZ9ZbzcFRFIHJjA/mxSzjDBoZtJEm9rryi3QlcVYg=;
 b=wFzs76BeF10K5wWOnPAX74jjY61AnVx6uFp+lTs50PtLPW2TSdOHZW/+d4+HAyqADTptMw
 5f5ig6yqLl9QYHAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1612B1357F;
 Thu, 19 Oct 2023 19:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2BOeNFKCMWWWEwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 19:24:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v14 02/14] fixup! migration: New QAPI type 'MigrateAddress'
Date: Thu, 19 Oct 2023 16:23:41 -0300
Message-Id: <20231019192353.31500-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231019192353.31500-1-farosas@suse.de>
References: <20231019192353.31500-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.40
X-Spamd-Result: default: False [-1.40 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SUBJECT_HAS_EXCLAIM(0.00)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RCPT_COUNT_TWELVE(0.00)[13]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.30)[96.71%]
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
---
 qapi/migration.json | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index c352c7ac52..602cb706e3 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1519,10 +1519,25 @@
 #
 # @rdma: Migrate via RDMA.
 #
+# @file: Direct the migration stream to a file.
+#
 # Since 8.2
 ##
 { 'enum': 'MigrationAddressType',
-  'data': ['socket', 'exec', 'rdma'] }
+  'data': ['socket', 'exec', 'rdma', 'file'] }
+
+##
+# @FileMigrationArgs:
+#
+# @path: file path
+#
+# @offset: initial offset for the file
+#
+# Since 8.2
+##
+{ 'struct': 'FileMigrationArgs',
+  'data': {'path': 'str',
+           'offset': 'uint64' } }
 
 ##
 # @MigrationExecCommand:
@@ -1547,7 +1562,8 @@
   'data': {
     'socket': 'SocketAddress',
     'exec': 'MigrationExecCommand',
-    'rdma': 'InetSocketAddress' } }
+    'rdma': 'InetSocketAddress',
+    'file': 'FileMigrationArgs' } }
 
 ##
 # @migrate:
-- 
2.35.3


