Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F322A95FA0F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Aug 2024 21:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sifmz-0000BE-Kg; Mon, 26 Aug 2024 15:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sifmu-0008Kv-RB
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:54:04 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sifmr-0002FZ-Q6
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:54:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C31B41F8B2;
 Mon, 26 Aug 2024 19:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724702038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2Ko9dfIYywBCHTciEx7It8uBibggU527KNYZlqsze4=;
 b=Jn2DNBJtTfRTSaMxCXVhZOytkgbrOjG5Ho+yuHCQ/78mYWOQGRaTWJbXTsklgEIXrHhygh
 o7J7591TyhgtUTB4NYa9WPf1F2OYPwpiMJH9HSCxb0Y9vsdnjp8FrRqwQmZRkXkzXk2QFa
 fyilyoH2KV1n8Dvu8wWbbQXmoYU7TI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724702038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2Ko9dfIYywBCHTciEx7It8uBibggU527KNYZlqsze4=;
 b=3BoaKMNs7LTz4qa+javSo3kGdDO1GgggDgiax6mZ+g/jMHQfM6N4aA43eaek3qwn5OaZyw
 CA6lGMn167JseiCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Jn2DNBJt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3BoaKMNs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724702038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2Ko9dfIYywBCHTciEx7It8uBibggU527KNYZlqsze4=;
 b=Jn2DNBJtTfRTSaMxCXVhZOytkgbrOjG5Ho+yuHCQ/78mYWOQGRaTWJbXTsklgEIXrHhygh
 o7J7591TyhgtUTB4NYa9WPf1F2OYPwpiMJH9HSCxb0Y9vsdnjp8FrRqwQmZRkXkzXk2QFa
 fyilyoH2KV1n8Dvu8wWbbQXmoYU7TI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724702038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2Ko9dfIYywBCHTciEx7It8uBibggU527KNYZlqsze4=;
 b=3BoaKMNs7LTz4qa+javSo3kGdDO1GgggDgiax6mZ+g/jMHQfM6N4aA43eaek3qwn5OaZyw
 CA6lGMn167JseiCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61BA41398D;
 Mon, 26 Aug 2024 19:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AE40ClXdzGY5PQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Aug 2024 19:53:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 17/18] migration/multifd: Make MultiFDMethods const
Date: Mon, 26 Aug 2024 16:53:21 -0300
Message-Id: <20240826195322.16532-18-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240826195322.16532-1-farosas@suse.de>
References: <20240826195322.16532-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C31B41F8B2
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLh86bwecppbq6yc1rdt9t5mys)];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The methods are defined at module_init time and don't ever
change. Make them const.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-nocomp.c | 2 +-
 migration/multifd-qpl.c    | 2 +-
 migration/multifd-uadk.c   | 2 +-
 migration/multifd-zlib.c   | 2 +-
 migration/multifd-zstd.c   | 2 +-
 migration/multifd.c        | 8 ++++----
 migration/multifd.h        | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 53ea9f9c83..f294d1b0b2 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -377,7 +377,7 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
     return true;
 }
 
-static MultiFDMethods multifd_nocomp_ops = {
+static const MultiFDMethods multifd_nocomp_ops = {
     .send_setup = multifd_nocomp_send_setup,
     .send_cleanup = multifd_nocomp_send_cleanup,
     .send_prepare = multifd_nocomp_send_prepare,
diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 75041a4c4d..b0f1e2ba46 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -694,7 +694,7 @@ static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
     return multifd_qpl_decompress_pages_slow_path(p, errp);
 }
 
-static MultiFDMethods multifd_qpl_ops = {
+static const MultiFDMethods multifd_qpl_ops = {
     .send_setup = multifd_qpl_send_setup,
     .send_cleanup = multifd_qpl_send_cleanup,
     .send_prepare = multifd_qpl_send_prepare,
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index db2549f59b..89f6a72f0e 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -305,7 +305,7 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
-static MultiFDMethods multifd_uadk_ops = {
+static const MultiFDMethods multifd_uadk_ops = {
     .send_setup = multifd_uadk_send_setup,
     .send_cleanup = multifd_uadk_send_cleanup,
     .send_prepare = multifd_uadk_send_prepare,
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 6787538762..8cf8a26bb4 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -277,7 +277,7 @@ static int multifd_zlib_recv(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
-static MultiFDMethods multifd_zlib_ops = {
+static const MultiFDMethods multifd_zlib_ops = {
     .send_setup = multifd_zlib_send_setup,
     .send_cleanup = multifd_zlib_send_cleanup,
     .send_prepare = multifd_zlib_send_prepare,
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 1576b1e2ad..53da33e048 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -265,7 +265,7 @@ static int multifd_zstd_recv(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
-static MultiFDMethods multifd_zstd_ops = {
+static const MultiFDMethods multifd_zstd_ops = {
     .send_setup = multifd_zstd_send_setup,
     .send_cleanup = multifd_zstd_send_cleanup,
     .send_prepare = multifd_zstd_send_prepare,
diff --git a/migration/multifd.c b/migration/multifd.c
index 0c07a2040b..b89715fdc2 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -76,7 +76,7 @@ struct {
      */
     int exiting;
     /* multifd ops */
-    MultiFDMethods *ops;
+    const MultiFDMethods *ops;
 } *multifd_send_state;
 
 struct {
@@ -93,7 +93,7 @@ struct {
     uint64_t packet_num;
     int exiting;
     /* multifd ops */
-    MultiFDMethods *ops;
+    const MultiFDMethods *ops;
 } *multifd_recv_state;
 
 MultiFDSendData *multifd_send_data_alloc(void)
@@ -128,9 +128,9 @@ void multifd_send_channel_created(void)
     qemu_sem_post(&multifd_send_state->channels_created);
 }
 
-static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {};
+static const MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {};
 
-void multifd_register_ops(int method, MultiFDMethods *ops)
+void multifd_register_ops(int method, const MultiFDMethods *ops)
 {
     assert(0 <= method && method < MULTIFD_COMPRESSION__MAX);
     assert(!multifd_ops[method]);
diff --git a/migration/multifd.h b/migration/multifd.h
index a3e35196d1..13e7a88c01 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -243,7 +243,7 @@ typedef struct {
     int (*recv)(MultiFDRecvParams *p, Error **errp);
 } MultiFDMethods;
 
-void multifd_register_ops(int method, MultiFDMethods *ops);
+void multifd_register_ops(int method, const MultiFDMethods *ops);
 void multifd_send_fill_packet(MultiFDSendParams *p);
 bool multifd_send_prepare_common(MultiFDSendParams *p);
 void multifd_send_zero_page_detect(MultiFDSendParams *p);
-- 
2.35.3


