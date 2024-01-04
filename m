Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A813B8243B2
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:24:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLOcI-0001jI-2Z; Thu, 04 Jan 2024 09:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLOc7-0001Ns-Q5
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:22:29 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLOc6-0008Vr-5Y
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:22:27 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A936121E1A;
 Thu,  4 Jan 2024 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704378144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deauQrXLLwb5GnQkYGueqE40cUtiEFyrySrq4KV19Ck=;
 b=hXKwn0753gQziXgwQD1AsNVhzZFFsRyR7tjD0ToSZr0ivG8fP6e0qaejqGz+aQrAFigbfY
 /S1USp2wn/vUcZRM5GoWDXnhOOJr6s52LdEpkUytjx86R+12a2q+zi4Ej0NRYzD8t2X+8l
 lS3YHtx9xEnsycHdDobaJM37hbipSxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704378144;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deauQrXLLwb5GnQkYGueqE40cUtiEFyrySrq4KV19Ck=;
 b=bYfI38xy6kItTQZZE5Y37PqCPxNbnzsZViUQcgJnraAi9xR8/2KcXmRNcKlvmJjP2vGJXs
 uJtKVFI1GFCo0uDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704378144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deauQrXLLwb5GnQkYGueqE40cUtiEFyrySrq4KV19Ck=;
 b=hXKwn0753gQziXgwQD1AsNVhzZFFsRyR7tjD0ToSZr0ivG8fP6e0qaejqGz+aQrAFigbfY
 /S1USp2wn/vUcZRM5GoWDXnhOOJr6s52LdEpkUytjx86R+12a2q+zi4Ej0NRYzD8t2X+8l
 lS3YHtx9xEnsycHdDobaJM37hbipSxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704378144;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deauQrXLLwb5GnQkYGueqE40cUtiEFyrySrq4KV19Ck=;
 b=bYfI38xy6kItTQZZE5Y37PqCPxNbnzsZViUQcgJnraAi9xR8/2KcXmRNcKlvmJjP2vGJXs
 uJtKVFI1GFCo0uDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E0C7137E8;
 Thu,  4 Jan 2024 14:22:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IABeMR6/lmUfPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 04 Jan 2024 14:22:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 5/7] tests/qtest/migration: Print migration incoming errors
Date: Thu,  4 Jan 2024 11:21:42 -0300
Message-Id: <20240104142144.9680-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240104142144.9680-1-farosas@suse.de>
References: <20240104142144.9680-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 1.24
X-Spamd-Result: default: False [1.24 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.46)[97.54%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

We're currently just asserting when incoming migration fails. Let's
print the error message from QMP as well.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 37e8e812c5..19384e3fa6 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -111,6 +111,12 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
 
     rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
                     args);
+
+    if (!qdict_haskey(rsp, "return")) {
+        g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(rsp), true);
+        g_test_message("%s", s->str);
+    }
+
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 
-- 
2.35.3


