Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C06E4762070
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 19:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOM8d-0000F1-0Z; Tue, 25 Jul 2023 13:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOM8a-0000EU-M7
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 13:47:56 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOM8Y-0006HL-O5
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 13:47:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 10856602CD;
 Tue, 25 Jul 2023 20:47:45 +0300 (MSK)
Received: from vsementsov-nix.yandex-team.ru (unknown
 [2a02:6b8:b081:1220::1:1d])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id blOfn70QkGk0-WzLvl5MB; Tue, 25 Jul 2023 20:47:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1690307264; bh=J5FpynUR7DSmxoZWu/QlftrXbv/+9iffDkfS6IKjwLg=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=BRA63aC0ieMzOREbhW7d1sKN1wlkMsMMFhnrp/gd12wgz9Vxf3MYxwvy0jWWOehSK
 arZAfKC//zkXpWXtOgOIoQ9vCOyr+Tio2mWpuJIkhUi1bF72PBZ0IklHmmX4b6EB2c
 4Rj9uSP+l/HiKK0rLCaShSfPz4eR+nkUfN0icGfo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com
Cc: yc-core@yandex-team.ru,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH] softmmu/vl: improve select_machine() function
Date: Tue, 25 Jul 2023 20:47:30 +0300
Message-Id: <20230725174730.1185838-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

 - put machine name into error message (helps debugging CI)
 - fix style (over-80 lines)
 - use g_autoptr
 - drop extra error propagation

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 softmmu/vl.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..77fe9e52ea 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1596,27 +1596,25 @@ static const QEMUOption *lookup_opt(int argc, char **argv,
 static MachineClass *select_machine(QDict *qdict, Error **errp)
 {
     const char *optarg = qdict_get_try_str(qdict, "type");
-    GSList *machines = object_class_get_list(TYPE_MACHINE, false);
+    g_autoptr(GSList) machines = object_class_get_list(TYPE_MACHINE, false);
     MachineClass *machine_class;
-    Error *local_err = NULL;
 
     if (optarg) {
         machine_class = find_machine(optarg, machines);
-        qdict_del(qdict, "type");
         if (!machine_class) {
-            error_setg(&local_err, "unsupported machine type");
+            error_setg(errp, "unsupported machine type: \"%s\"", optarg);
         }
+        qdict_del(qdict, "type");
     } else {
         machine_class = find_default_machine(machines);
         if (!machine_class) {
-            error_setg(&local_err, "No machine specified, and there is no default");
+            error_setg(errp, "No machine specified, and there is no default");
         }
     }
 
-    g_slist_free(machines);
-    if (local_err) {
-        error_append_hint(&local_err, "Use -machine help to list supported machines\n");
-        error_propagate(errp, local_err);
+    if (!machine_class) {
+        error_append_hint(errp,
+                          "Use -machine help to list supported machines\n");
     }
     return machine_class;
 }
-- 
2.34.1


