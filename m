Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A161A76373A
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 15:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOdRx-0007vO-70; Wed, 26 Jul 2023 08:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOdQs-0006c3-FO
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOdQr-0004L9-1q
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690373755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoJqflG6p06UiyjXcBrP7XYz4oV4OR7b3C3zEc3gpTE=;
 b=NtuxXj2rstumkyef6Nrf7lmZ4tqYxkwDHxw1NbcqMVxsd2jzMqJeqnPXtKSML8WlSjUSz2
 iXjXFxBG+z89wD+cRNM9/5Nvo0AVz+L/htchdgHFwktKHpcvlgm1UuKKLxBJ7Sk4oTN0wB
 KNjhHCCjYv8M9PBmNf6X3AuqIPG+v4A=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-h4McekTWONubbclC4E8uxQ-1; Wed, 26 Jul 2023 08:15:54 -0400
X-MC-Unique: h4McekTWONubbclC4E8uxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 909113C0C48B
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 12:15:54 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D22DB40C2063;
 Wed, 26 Jul 2023 12:15:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 22/25] qemu_file: Make qemu_file_is_writable() static
Date: Wed, 26 Jul 2023 14:14:56 +0200
Message-Id: <20230726121459.1837-23-quintela@redhat.com>
In-Reply-To: <20230726121459.1837-1-quintela@redhat.com>
References: <20230726121459.1837-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It is not used outside of qemu_file, and it shouldn't.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230530183941.7223-19-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h | 1 -
 migration/qemu-file.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index aa6eee66da..a081ef6c3f 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -103,7 +103,6 @@ uint64_t qemu_file_transferred_noflush(QEMUFile *f);
 void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
                            bool may_free);
 bool qemu_file_mode_is_not_valid(const char *mode);
-bool qemu_file_is_writable(QEMUFile *f);
 
 #include "migration/qemu-file-types.h"
 
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index fdf115b5da..9a89e17924 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -228,7 +228,7 @@ void qemu_file_set_error(QEMUFile *f, int ret)
     qemu_file_set_error_obj(f, ret, NULL);
 }
 
-bool qemu_file_is_writable(QEMUFile *f)
+static bool qemu_file_is_writable(QEMUFile *f)
 {
     return f->is_writable;
 }
-- 
2.40.1


