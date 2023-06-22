Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC3F739577
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 04:18:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC9rO-0001ug-Qe; Wed, 21 Jun 2023 22:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9ql-0008MF-FX
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qj-0005Eu-IX
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687400104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvznSVvrLqLSpbAniNlQaSrKd09QwBSoD5r3kvK3Uhk=;
 b=EFdf3p0hwElly4fIsRAdx6p4lg5j9Qwdms3SPTmjtmSjt1Lou75JMhFB9JoFuLaQJlIYcG
 eHMCbjPDC0g9oxErxu3N1i9vzPpXC0ZoVXfKlxd6tPfwaaIxcokke9tDgEOOwWDz5Oi8Fy
 s28lABZVmn+SCR7fz8r94F0XeV13bb8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-hFHSjvcyNLS11vOSDHQ3yQ-1; Wed, 21 Jun 2023 22:15:02 -0400
X-MC-Unique: hFHSjvcyNLS11vOSDHQ3yQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 156A33806720;
 Thu, 22 Jun 2023 02:15:02 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.193.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91EAB112132C;
 Thu, 22 Jun 2023 02:14:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 29/30] qemu-file: Make qemu_file_get_error_obj() static
Date: Thu, 22 Jun 2023 04:13:19 +0200
Message-Id: <20230622021320.66124-30-quintela@redhat.com>
In-Reply-To: <20230622021320.66124-1-quintela@redhat.com>
References: <20230622021320.66124-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

It was not used outside of qemu_file.c anyways.

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20230530183941.7223-21-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h | 1 -
 migration/qemu-file.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index a081ef6c3f..8b8b7d27fe 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -128,7 +128,6 @@ void qemu_file_skip(QEMUFile *f, int size);
  * accounting information tracks the total migration traffic.
  */
 void qemu_file_credit_transfer(QEMUFile *f, size_t size);
-int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
 int qemu_file_get_error_obj_any(QEMUFile *f1, QEMUFile *f2, Error **errp);
 void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
 void qemu_file_set_error(QEMUFile *f, int ret);
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 4c577bdff8..d30bf3c377 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -158,7 +158,7 @@ void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks)
  * is not 0.
  *
  */
-int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
+static int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
 {
     if (errp) {
         *errp = f->last_error_obj ? error_copy(f->last_error_obj) : NULL;
-- 
2.40.1


