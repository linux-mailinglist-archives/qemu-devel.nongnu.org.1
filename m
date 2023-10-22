Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C2F7D25C9
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 22:14:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1queoa-0005Gb-OM; Sun, 22 Oct 2023 16:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoY-0005FW-Ld
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoX-00061t-5I
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698005563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QmqhK+JgD9oXmIthMn+SAkCj7IdZVJuTdH9Qh84fJac=;
 b=XhOhN7xV81Iwm2/VzVQBr0NL+S37b1Zu2Nkz4hksj7xvI+PpVJc9WUxRQasV72Rc4cXVhi
 nhYphMxAQR8uOe3AnqMSiGQfZNMlIzx5/zir3vjPMkpQ5XzJikteU2QMPJoQHibBGlMhz1
 Mtcrw7Fm+QsNqYTOcVHTB5eXGrQ5bQ8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-04pYdnSyMcCyKsJrlRzrlA-1; Sun, 22 Oct 2023 16:12:42 -0400
X-MC-Unique: 04pYdnSyMcCyKsJrlRzrlA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66cfa898cfeso7839796d6.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 13:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698005561; x=1698610361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QmqhK+JgD9oXmIthMn+SAkCj7IdZVJuTdH9Qh84fJac=;
 b=JTu1ToRZi+Ga4UtV9fQVTanLxRkONl6EHA1HQjdjgUW6EzHk8LGpf8LKn+cgDLj5yr
 YqwXOnzwS/6aOXd5a/Fvc6GJ/GJv5DnkVdR9znE5DgH6wpunU7f/G080B14DArS4sOgw
 Vgalc03LAXeuFtiB9xJNqCCqWI6C+FwZju7RB5jA8Ejo9YK7rC4bWotEV+g07zUGOee7
 zdYdocuUas/7Iudla5SMe2CZ73oqTEQ0QLo0DMdwHrPIqWGbWKTAZNl9vjc3W4qkPCyG
 +08GFlW3IanVHFHVdU1K6HNXq3ZSvIT0/4YFrupPA2uHc6E4z6fZ/efcjAuqllwx8/4x
 e6FA==
X-Gm-Message-State: AOJu0Yw3hmfrP4l9o10Eae6jevoKPRfMRk69JUFmnawfwy5Zj3cVIv4B
 ecKJuumgLVEgNaw+/YKw8+MlC6wLZvg9H470RfOfGZDI9Er7XNvRXLBNnXenN0N33cTSDNZMdKs
 BCLy8b3gJA6lsLNasqZZvB+3eindSyzBHDVEUikquen3Lp7WQFSqiOM3PBiQ7eQxm89+JrC2L
X-Received: by 2002:ad4:5844:0:b0:66d:169a:a661 with SMTP id
 de4-20020ad45844000000b0066d169aa661mr7492848qvb.4.1698005561755; 
 Sun, 22 Oct 2023 13:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKhfuWjZQciM3w3sDLaoO6iwhIX9y+OBqCDq0opdA/e5z4SibcHCGsmzgT5ixDH0+Jg5DY9w==
X-Received: by 2002:ad4:5844:0:b0:66d:169a:a661 with SMTP id
 de4-20020ad45844000000b0066d169aa661mr7492837qvb.4.1698005561406; 
 Sun, 22 Oct 2023 13:12:41 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a0cfe0b000000b0065af657ddf7sm2330515qvr.144.2023.10.22.13.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 13:12:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PATCH RFC 7/7] migration: Further unify paths for multifd normal or
 sync requests
Date: Sun, 22 Oct 2023 16:12:11 -0400
Message-ID: <20231022201211.452861-8-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231022201211.452861-1-peterx@redhat.com>
References: <20231022201211.452861-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Provide multifd_send_execute() for merging duplicated codes.

The trick here is multifd_send_execute() will conditionally hold the mutex
when returned, depending on the retval.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 51 ++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index fe8d746ff9..0052e5daee 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -717,6 +717,29 @@ static bool multifd_do_send(MultiFDSendParams *p, Error **errp)
     return true;
 }
 
+/*
+ * When succeed: returns true, mutex held.
+ * When failed:  returns false, mutex released.
+ */
+static bool multifd_send_execute(MultiFDSendParams *p, Error **errp)
+{
+    if (!multifd_send_prepare(p, errp)) {
+        qemu_mutex_unlock(&p->mutex);
+        assert(*errp);
+        return false;
+    }
+
+    /* Send the packets without mutex */
+    qemu_mutex_unlock(&p->mutex);
+    if (!multifd_do_send(p, errp)) {
+        assert(*errp);
+        return false;
+    }
+    qemu_mutex_lock(&p->mutex);
+
+    return true;
+}
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
@@ -746,40 +769,16 @@ static void *multifd_send_thread(void *opaque)
 
         qemu_mutex_lock(&p->mutex);
         if (p->pending_job) {
-            if (!multifd_send_prepare(p, &local_err)) {
-                assert(local_err);
-                qemu_mutex_unlock(&p->mutex);
+            if (!multifd_send_execute(p, &local_err)) {
                 goto out;
             }
-
-            /* Send the packets without mutex */
-            qemu_mutex_unlock(&p->mutex);
-            if (!multifd_do_send(p, &local_err)) {
-                assert(local_err);
-                goto out;
-            }
-            qemu_mutex_lock(&p->mutex);
-
-            /* Send successful, mark the task completed */
             p->pending_job = false;
 
         } else if (p->pending_sync) {
             p->flags |= MULTIFD_FLAG_SYNC;
-
-            if (!multifd_send_prepare(p, &local_err)) {
-                assert(local_err);
-                qemu_mutex_unlock(&p->mutex);
-                goto out;
-            }
-
-            /* Send the packets without mutex */
-            qemu_mutex_unlock(&p->mutex);
-            if (!multifd_do_send(p, &local_err)) {
-                assert(local_err);
+            if (!multifd_send_execute(p, &local_err)) {
                 goto out;
             }
-            qemu_mutex_lock(&p->mutex);
-
             qemu_sem_post(&p->sem_sync);
             p->pending_sync = false;
         }
-- 
2.41.0


