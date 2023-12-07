Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7988808CD2
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 17:00:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBGlv-0000EI-Uj; Thu, 07 Dec 2023 10:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rBGln-0000Cx-6D
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:58:35 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rBGli-0007PW-C5
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:58:31 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD806220B8;
 Thu,  7 Dec 2023 15:58:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6420D13B6A;
 Thu,  7 Dec 2023 15:58:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IFARC6LrcWXDVgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 07 Dec 2023 15:58:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 5/5] [NOT FOR MERGE] compat hack until 8.2 is out
Date: Thu,  7 Dec 2023 12:58:09 -0300
Message-Id: <20231207155809.25673-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231207155809.25673-1-farosas@suse.de>
References: <20231207155809.25673-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [11.78 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 R_SPF_SOFTFAIL(4.60)[~all:c]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[9];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.01)[45.04%];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spamd-Bar: +++++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: DD806220B8
X-Spam-Score: 11.78
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In the 8.2 development cycle we added a new '-audio' command line
option to QEMU which breaks the migration compatibility tests because
older QEMUs don't know the option.

Since we're just testing n vs. n-1 migration, it's easier if we just
wait until 8.2 is released and it will become our n-1 and the problem
will go away on its own.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7cee68a834..031316390e 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -497,7 +497,6 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
                          "-chardev socket,path=%s,id=char0 "
                          "-mon chardev=char0,mode=control "
                          "-display none "
-                         "-audio none "
                          "%s"
                          " -accel qtest",
                          socket_path,
-- 
2.35.3


