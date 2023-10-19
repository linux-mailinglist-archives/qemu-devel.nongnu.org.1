Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 079CA7D028A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 21:27:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtYda-0007kp-E5; Thu, 19 Oct 2023 15:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtYdY-0007jl-Vw
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:24:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtYdX-00050A-E6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:24:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 318871FD8C;
 Thu, 19 Oct 2023 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697743490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxeOMIeKNgbJvt83tgkw1N8BzjXn1v1Itzhg/N+J3M0=;
 b=P+CuBoxRwx014G2+fzV+Lw6TKiyLLi3hkkDxQqWneVXhMe4GXZaI9WLfyrRXRltd0GBSPT
 gvpYwER4N5iCmRYZOX7ft7iGquk4rg7GFMK08keznSJ1HEbgVNbF555Zf6hDZ6EczfHI2M
 ZCLXr7buqbH6IlCVuX8vqQc2N5vjKoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697743490;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxeOMIeKNgbJvt83tgkw1N8BzjXn1v1Itzhg/N+J3M0=;
 b=CVfdD4QXwZ+ajOp1z3mUgjv9ea+rgOgBQV6Zg29j+lwK5ch6opzcN5NYzlgnfvy2aCPCTn
 SFeFWa3JjkhkJiAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0A521357F;
 Thu, 19 Oct 2023 19:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uILcGn6CMWWWEwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 19:24:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v14 14/14] migration: modify test_multifd_tcp_none() to use
 new QAPI syntax.
Date: Thu, 19 Oct 2023 16:23:53 -0300
Message-Id: <20231019192353.31500-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231019192353.31500-1-farosas@suse.de>
References: <20231019192353.31500-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -0.86
X-Spamd-Result: default: False [-0.86 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 R_RATELIMIT(0.00)[to_ip_from(RLxkmehncim7kksu5aptuhwrr5)];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[15];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.76)[93.57%]
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

modify multifd tcp common test to incorporate the new QAPI
syntax defined.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e1c110537b..76b3a472ed 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1284,7 +1284,12 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
     migrate_prepare_for_dirty_mem(from);
     qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+                             "  'arguments': { "
+                             "      'channels': [ { 'channel-type': 'main',"
+                             "      'addr': { 'transport': 'socket',"
+                             "                'type': 'inet',"
+                             "                'host': '127.0.0.1',"
+                             "                'port': '0' } } ] } }");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
-- 
2.35.3


