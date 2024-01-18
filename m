Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB2D831DD9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 17:51:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQVat-00037p-Jz; Thu, 18 Jan 2024 11:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQVam-00036D-R2
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:50:13 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQVai-0000Sm-4V
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:50:10 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 72F7D1F7A5;
 Thu, 18 Jan 2024 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705596599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+sCC+B8QDcMrKHoSD3qNEEMMX/efPzqMI5o9Yc1ySI=;
 b=PbfQc6uu4B3OF6pyTuAO5X68lyuIqqMa89CfNxEPbwQo/5SUCCrQmwcxfkm65/noBw+oEZ
 tuJhbjoXndqtYdZGKBgPaoefsyLDnS/JRnd9tSlBGZBCNWO+LqI1mzwzUxPReSyUSIW7yG
 dJE6xEnl9M/tES50PAHKeoT0d3CdUpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705596599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+sCC+B8QDcMrKHoSD3qNEEMMX/efPzqMI5o9Yc1ySI=;
 b=FPy41cKSZWDrDvChNZ3/FwVEANzwHaHr/M8+tF6gmijNQUOqzdPyqjdopgmTktIiyWtXkS
 CnViR3FjNc/E2AAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705596599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+sCC+B8QDcMrKHoSD3qNEEMMX/efPzqMI5o9Yc1ySI=;
 b=PbfQc6uu4B3OF6pyTuAO5X68lyuIqqMa89CfNxEPbwQo/5SUCCrQmwcxfkm65/noBw+oEZ
 tuJhbjoXndqtYdZGKBgPaoefsyLDnS/JRnd9tSlBGZBCNWO+LqI1mzwzUxPReSyUSIW7yG
 dJE6xEnl9M/tES50PAHKeoT0d3CdUpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705596599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+sCC+B8QDcMrKHoSD3qNEEMMX/efPzqMI5o9Yc1ySI=;
 b=FPy41cKSZWDrDvChNZ3/FwVEANzwHaHr/M8+tF6gmijNQUOqzdPyqjdopgmTktIiyWtXkS
 CnViR3FjNc/E2AAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20862136F5;
 Thu, 18 Jan 2024 16:49:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iC7wNbRWqWUdSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Jan 2024 16:49:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 1/3] tests/qtest/migration: Don't use -cpu max for aarch64
Date: Thu, 18 Jan 2024 13:49:49 -0300
Message-Id: <20240118164951.30350-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240118164951.30350-1-farosas@suse.de>
References: <20240118164951.30350-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PbfQc6uu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FPy41cKS
X-Spamd-Result: default: False [-1.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 72F7D1F7A5
X-Spam-Score: -1.81
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The 'max' cpu is not expected to be stable in terms of features across
QEMU versions, so it should not be expected to migrate.

While the tests currently all pass with -cpu max, that is only because
we're not testing across QEMU versions, which is the more common
use-case for migration.

We've recently introduced compatibility tests that use two different
QEMU versions and the tests are now failing for aarch64. The next
patch adds those tests to CI, so we cannot use the 'max' cpu
anymore. Replace it with the 'neoverse-n1', which has a fixed set of
features.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d3066e119f..b2390656f0 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -820,7 +820,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         memory_size = "150M";
         machine_alias = "virt";
         machine_opts = "gic-version=max";
-        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
+        arch_opts = g_strdup_printf("-cpu neoverse-n1 -kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
     } else {
-- 
2.35.3


