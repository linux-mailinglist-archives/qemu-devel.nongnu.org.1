Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C21A27C6629
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 09:17:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqpw4-00072x-3s; Thu, 12 Oct 2023 03:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqpvv-0006zK-BQ; Thu, 12 Oct 2023 03:16:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqpvt-0000tK-OJ; Thu, 12 Oct 2023 03:16:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BBE6629AC6;
 Thu, 12 Oct 2023 10:16:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6E27B2E9B2;
 Thu, 12 Oct 2023 10:16:27 +0300 (MSK)
Received: (nullmailer pid 25947 invoked by uid 1000);
 Thu, 12 Oct 2023 07:16:26 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 60/61] migration/qmp: Fix crash on setting tls-authz
 with null
Date: Thu, 12 Oct 2023 10:16:16 +0300
Message-Id: <20231012071626.25905-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231012101342@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231012101342@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

QEMU will crash if anyone tries to set tls-authz (which is a type
StrOrNull) with 'null' value.  Fix it in the easy way by converting it to
qstring just like the other two tls parameters.

Cc: qemu-stable@nongnu.org # v4.0+
Fixes: d2f1d29b95 ("migration: add support for a "tls-authz" migration parameter")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230905162335.235619-2-peterx@redhat.com>
(cherry picked from commit 86dec715a7339fc61c3bdb9715993b277b2089db)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/options.c b/migration/options.c
index 1d1e1321b0..6bbfd4853d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1408,20 +1408,25 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
 {
     MigrationParameters tmp;
 
-    /* TODO Rewrite "" to null instead */
+    /* TODO Rewrite "" to null instead for all three tls_* parameters */
     if (params->tls_creds
         && params->tls_creds->type == QTYPE_QNULL) {
         qobject_unref(params->tls_creds->u.n);
         params->tls_creds->type = QTYPE_QSTRING;
         params->tls_creds->u.s = strdup("");
     }
-    /* TODO Rewrite "" to null instead */
     if (params->tls_hostname
         && params->tls_hostname->type == QTYPE_QNULL) {
         qobject_unref(params->tls_hostname->u.n);
         params->tls_hostname->type = QTYPE_QSTRING;
         params->tls_hostname->u.s = strdup("");
     }
+    if (params->tls_authz
+        && params->tls_authz->type == QTYPE_QNULL) {
+        qobject_unref(params->tls_authz->u.n);
+        params->tls_authz->type = QTYPE_QSTRING;
+        params->tls_authz->u.s = strdup("");
+    }
 
     migrate_params_test_apply(params, &tmp);
 
-- 
2.39.2


