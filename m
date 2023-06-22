Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D439C73A6C9
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:58:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNc2-0008Vx-8l; Thu, 22 Jun 2023 12:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbw-0008Ru-Hb
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbu-00013w-Uy
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687453002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0gMyyCvbpsUehX6Zf+T7AT27ZzZCy47tR02v1S53cos=;
 b=BTZSEciD231xvx+G3FxejT/uetpGM/HqUXzCiDE3T4cSy25p/LXRABF5Gycyu3XpuCfHcP
 nw6jxoSOFrF9V2KBieripmc3+EKwBDAGRttSPJH2GKpKXrKicm0M4eIipItTDNbeNcizhT
 B4T3HZel4Lo0BNP9r/+SmIcorgllYJw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-8B9k0geFN16RE5wQzpKDeA-1; Thu, 22 Jun 2023 12:56:32 -0400
X-MC-Unique: 8B9k0geFN16RE5wQzpKDeA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5AC18A2E28;
 Thu, 22 Jun 2023 16:56:25 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 847D6C478C6;
 Thu, 22 Jun 2023 16:56:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Wei Wang <wei.w.wang@intel.com>
Subject: [PULL 22/30] migration: enforce multifd and postcopy preempt to be
 set before incoming
Date: Thu, 22 Jun 2023 18:55:19 +0200
Message-Id: <20230622165527.2417-23-quintela@redhat.com>
In-Reply-To: <20230622165527.2417-1-quintela@redhat.com>
References: <20230622165527.2417-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Wei Wang <wei.w.wang@intel.com>

qemu_start_incoming_migration needs to check the number of multifd
channels or postcopy ram channels to configure the backlog parameter (i.e.
the maximum length to which the queue of pending connections for sockfd
may grow) of listen(). So enforce the usage of postcopy-preempt and
multifd as below:
- need to use "-incoming defer" on the destination; and
- set_capability and set_parameter need to be done before migrate_incoming

Otherwise, disable the use of the features and report error messages to
remind users to adjust the commands.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230606101910.20456-2-wei.w.wang@intel.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Acked-by: Juan Quintela <quintela@redhat.com>
---
 migration/options.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index ba1010e08b..c072c2fab7 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -433,6 +433,11 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
     MIGRATION_CAPABILITY_VALIDATE_UUID,
     MIGRATION_CAPABILITY_ZERO_COPY_SEND);
 
+static bool migrate_incoming_started(void)
+{
+    return !!migration_incoming_get_current()->transport_data;
+}
+
 /**
  * @migration_caps_check - check capability compatibility
  *
@@ -556,6 +561,12 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Postcopy preempt not compatible with compress");
             return false;
         }
+
+        if (migrate_incoming_started()) {
+            error_setg(errp,
+                       "Postcopy preempt must be set before incoming starts");
+            return false;
+        }
     }
 
     if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
@@ -563,6 +574,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Multifd is not compatible with compress");
             return false;
         }
+        if (migrate_incoming_started()) {
+            error_setg(errp, "Multifd must be set before incoming starts");
+            return false;
+        }
     }
 
     if (new_caps[MIGRATION_CAPABILITY_DIRTY_LIMIT]) {
-- 
2.40.1


