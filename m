Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1322A831DD6
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 17:51:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQVat-00037X-A8; Thu, 18 Jan 2024 11:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQVam-00036F-Rs
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:50:13 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQVaj-0000ep-Fc
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:50:10 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 120491F798;
 Thu, 18 Jan 2024 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705596605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jE3ymaqx1HnREyfSMOLFe9POSPGjHGNjBSdQAYhG/Is=;
 b=nOAjygNCADnysSq+icROcaqobfyUG9iyFsHOnkzfRmwUfbKg61rYX4lBl1x0UiBZyqPYsR
 NIPOSaA3XAkgVJnFzWGGym0Bfmb8cvGnKyjTnUfi2PEZm8MHXFxRRrJsVGDkcO2EN1A1yc
 /6MoV9aK2zeernjkTm+KkjLduzCuL3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705596605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jE3ymaqx1HnREyfSMOLFe9POSPGjHGNjBSdQAYhG/Is=;
 b=6V1UWL8zYKKbWn+/AJB371mlV7Hn3vtJxsPCpM/GqTJlG31c37OZzUZGVsyT+hb9RlP69f
 UJge2m6QakGjjoCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705596605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jE3ymaqx1HnREyfSMOLFe9POSPGjHGNjBSdQAYhG/Is=;
 b=nOAjygNCADnysSq+icROcaqobfyUG9iyFsHOnkzfRmwUfbKg61rYX4lBl1x0UiBZyqPYsR
 NIPOSaA3XAkgVJnFzWGGym0Bfmb8cvGnKyjTnUfi2PEZm8MHXFxRRrJsVGDkcO2EN1A1yc
 /6MoV9aK2zeernjkTm+KkjLduzCuL3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705596605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jE3ymaqx1HnREyfSMOLFe9POSPGjHGNjBSdQAYhG/Is=;
 b=6V1UWL8zYKKbWn+/AJB371mlV7Hn3vtJxsPCpM/GqTJlG31c37OZzUZGVsyT+hb9RlP69f
 UJge2m6QakGjjoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B375C136F5;
 Thu, 18 Jan 2024 16:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aFWxHbpWqWUdSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Jan 2024 16:50:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v4 3/3] ci: Disable migration compatibility tests for aarch64
Date: Thu, 18 Jan 2024 13:49:51 -0300
Message-Id: <20240118164951.30350-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240118164951.30350-1-farosas@suse.de>
References: <20240118164951.30350-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nOAjygNC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6V1UWL8z
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.57 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.92)[99.65%]
X-Spam-Score: 0.57
X-Rspamd-Queue-Id: 120491F798
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

Until 9.0 is out, we need to keep the aarch64 job disabled because the
tests always use the n-1 version of migration-test. That happens to be
broken for aarch64 in 8.2. Once 9.0 is out, it will become the n-1
version and it will bring the fixed tests.

We can revert this patch when 9.0 releases.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 .gitlab-ci.d/buildtest.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index f0b0edc634..b344a4685f 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -217,10 +217,14 @@ build-previous-qemu:
     - QTEST_QEMU_BINARY_DST=./qemu-system-${TARGET}
           QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
 
+# This job is disabled until we release 9.0. The existing
+# migration-test in 8.2 is broken on aarch64. The fix was already
+# commited, but it will only take effect once 9.0 is out.
 migration-compat-aarch64:
   extends: .migration-compat-common
   variables:
     TARGET: aarch64
+    QEMU_JOB_OPTIONAL: 1
 
 migration-compat-x86_64:
   extends: .migration-compat-common
-- 
2.35.3


