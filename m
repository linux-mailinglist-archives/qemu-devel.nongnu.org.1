Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4E974A493
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 21:53:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHV1R-0003y6-5Y; Thu, 06 Jul 2023 15:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHV1P-0003xh-3N
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:52:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHV1N-0005fb-F0
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:52:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B8A71F74C;
 Thu,  6 Jul 2023 19:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688673128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gJqi1oRjZvpUbuazL8Ej7T24yxxWSK+l7ukealgRP6U=;
 b=NHO7HjvNMlAiuO3m1IrVSSSLVphGe8thhd54OF822PMcYpGNX7NY11nwLNUr8CTba7GMSa
 Y88rU2V+tASivnppJnha44MT4jgUfoZa6qpCqBVeN9w3TA1Z4Y90MKWc4TDvf2KnJkJ/pr
 puKID/6zB3s9WqvGKiZ9iXFHu6LzdHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688673128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gJqi1oRjZvpUbuazL8Ej7T24yxxWSK+l7ukealgRP6U=;
 b=xkWKRDReVxF7Hr0VL+Ac30Bho3hDYHYkITUPJb4w6+SoykkCr2TpYbQHgyev6slHvkKj1o
 gBO2Xu+xNyiGbqDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 124F7138FC;
 Thu,  6 Jul 2023 19:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MAyVM2Ybp2STDQAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 06 Jul 2023 19:52:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 2/2] migration: Make it clear that qemu_file_set_error() needs
 a negative value
Date: Thu,  6 Jul 2023 16:52:01 -0300
Message-Id: <20230706195201.18595-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230706195201.18595-1-farosas@suse.de>
References: <20230706195201.18595-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

The convention in qemu-file.c is to return a negative value on
error.

The only place that could use qemu_file_set_error() to store a
positive value to f->last_error was vmstate_save() which has been
fixed in the previous patch.

bdrv_inactivate_all() already returns a negative value on error.

Document that qemu_file_set_error() needs -errno and alter the callers
to check ret < 0.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/qemu-file.c | 2 ++
 migration/savevm.c    | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index acc282654a..8276bac248 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -222,6 +222,8 @@ int qemu_file_get_error(QEMUFile *f)
 
 /*
  * Set the last error for stream f
+ *
+ * The error ('ret') should be in -errno format.
  */
 void qemu_file_set_error(QEMUFile *f, int ret)
 {
diff --git a/migration/savevm.c b/migration/savevm.c
index 95c2abf47c..f3c303ab74 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1249,7 +1249,7 @@ void qemu_savevm_state_setup(QEMUFile *f)
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
             ret = vmstate_save(f, se, ms->vmdesc);
-            if (ret) {
+            if (ret < 0) {
                 qemu_file_set_error(f, ret);
                 break;
             }
@@ -1464,7 +1464,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         }
 
         ret = vmstate_save(f, se, vmdesc);
-        if (ret) {
+        if (ret < 0) {
             qemu_file_set_error(f, ret);
             return ret;
         }
@@ -1474,7 +1474,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         /* Inactivate before sending QEMU_VM_EOF so that the
          * bdrv_activate_all() on the other end won't fail. */
         ret = bdrv_inactivate_all();
-        if (ret) {
+        if (ret < 0) {
             error_report("%s: bdrv_inactivate_all() failed (%d)",
                          __func__, ret);
             qemu_file_set_error(f, ret);
-- 
2.35.3


