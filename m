Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582F89237C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Mar 2024 19:39:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqH7f-0002o6-8F; Fri, 29 Mar 2024 14:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rqH7b-0002lk-Sw; Fri, 29 Mar 2024 14:38:35 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rqH7Y-0007X0-Nz; Fri, 29 Mar 2024 14:38:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5428:0:640:7351:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 53B3660A20;
 Fri, 29 Mar 2024 21:38:29 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2cTaY94Id8c0-ERZcZxeb; Fri, 29 Mar 2024 21:38:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711737508;
 bh=dkAh7R9NLEfQKIK4Kt7lmSuiosgYWtpMTO9GN4dgGG4=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=NrEY8Gxgkk0QbJvVurYFvbe4Y44JvcPbTmVfNwAMWe/3eUZJARODPIQuX836vATKd
 RTk7JvAuDJypnnc/NW3YIN1NvxYohisWfYxN4QCAOH0sOOMdAahYMajbYq1DjKUbx5
 VrMSpAsHf64Ufm+0yHI4/o5lPDsgIZq8+oVF56vk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, armbru@redhat.com,
 dave@treblig.org, eblake@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v3 3/5] qdev-monitor: add option to report GenericError from
 find_device_state
Date: Fri, 29 Mar 2024 21:37:56 +0300
Message-Id: <20240329183758.3360733-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
References: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Here we just prepare for the following patch, making possible to report
GenericError as recommended.

This patch doesn't aim to prevent further use of DeviceNotFound by
future interfaces:

 - find_device_state() is used in blk_by_qdev_id() and qmp_get_blk()
   functions, which may lead to spread of DeviceNotFound anyway
 - also, nothing prevent simply copy-pasting find_device_state() calls
   with false argument

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 system/qdev-monitor.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 840177d19f..7e075d91c1 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -878,13 +878,20 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     object_unref(OBJECT(dev));
 }
 
-static DeviceState *find_device_state(const char *id, Error **errp)
+/*
+ * Note that creating new APIs using error classes other than GenericError is
+ * not recommended. Set use_generic_error=true for new interfaces.
+ */
+static DeviceState *find_device_state(const char *id, bool use_generic_error,
+                                      Error **errp)
 {
     Object *obj = object_resolve_path_at(qdev_get_peripheral(), id);
     DeviceState *dev;
 
     if (!obj) {
-        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+        error_set(errp,
+                  (use_generic_error ?
+                   ERROR_CLASS_GENERIC_ERROR : ERROR_CLASS_DEVICE_NOT_FOUND),
                   "Device '%s' not found", id);
         return NULL;
     }
@@ -948,7 +955,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
 
 void qmp_device_del(const char *id, Error **errp)
 {
-    DeviceState *dev = find_device_state(id, errp);
+    DeviceState *dev = find_device_state(id, false, errp);
     if (dev != NULL) {
         if (dev->pending_deleted_event &&
             (dev->pending_deleted_expires_ms == 0 ||
@@ -1068,7 +1075,7 @@ BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
 
     GLOBAL_STATE_CODE();
 
-    dev = find_device_state(id, errp);
+    dev = find_device_state(id, false, errp);
     if (dev == NULL) {
         return NULL;
     }
-- 
2.34.1


