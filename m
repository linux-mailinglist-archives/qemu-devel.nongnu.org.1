Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC26B7D54FC
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:13:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJ4D-000537-MF; Tue, 24 Oct 2023 11:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvJ3s-0004tm-ES
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvJ3n-0000oH-VU
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698160259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZ/VjHOP/PyVqJEIGBBTGuG7TzORdq63EbvxixC0XZ4=;
 b=aGEsj5TbDjOtS+9R7zCvixk4YZej75q+RgswexE1LGnBjzrokhPqCEKnwYf3QB8HLLUqJo
 YR8PoI0oipKz2SeU7GVXtiMyvlVBuiIXdQrT3hJCgdLiLsvIQiZpFdJf5eV0k4gPoosPNN
 LG/+omMxNRTxQUhxhaY/9lx5eLbJcZo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-7zZM94qMP5OXX5EJgpFX3A-1; Tue,
 24 Oct 2023 11:10:56 -0400
X-MC-Unique: 7zZM94qMP5OXX5EJgpFX3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C790C1C29EBE;
 Tue, 24 Oct 2023 15:10:55 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D18C2026D4C;
 Tue, 24 Oct 2023 15:10:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 05/12] qemu_file: Remove unused qemu_file_transferred()
Date: Tue, 24 Oct 2023 17:10:35 +0200
Message-ID: <20231024151042.90349-6-quintela@redhat.com>
In-Reply-To: <20231024151042.90349-1-quintela@redhat.com>
References: <20231024151042.90349-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h | 18 ------------------
 migration/qemu-file.c |  7 -------
 2 files changed, 25 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index a29c37b0d0..8b71152754 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -33,24 +33,6 @@ QEMUFile *qemu_file_new_input(QIOChannel *ioc);
 QEMUFile *qemu_file_new_output(QIOChannel *ioc);
 int qemu_fclose(QEMUFile *f);
 
-/*
- * qemu_file_transferred:
- *
- * Report the total number of bytes transferred with
- * this file.
- *
- * For writable files, any pending buffers will be
- * flushed, so the reported value will be equal to
- * the number of bytes transferred on the wire.
- *
- * For readable files, the reported value will be
- * equal to the number of bytes transferred on the
- * wire.
- *
- * Returns: the total bytes transferred
- */
-uint64_t qemu_file_transferred(QEMUFile *f);
-
 /*
  * qemu_file_transferred_noflush:
  *
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 641ab703cc..efa5f11033 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -632,13 +632,6 @@ uint64_t qemu_file_transferred_noflush(QEMUFile *f)
     return ret;
 }
 
-uint64_t qemu_file_transferred(QEMUFile *f)
-{
-    g_assert(qemu_file_is_writable(f));
-    qemu_fflush(f);
-    return stat64_get(&mig_stats.qemu_file_transferred);
-}
-
 void qemu_put_be16(QEMUFile *f, unsigned int v)
 {
     qemu_put_byte(f, v >> 8);
-- 
2.41.0


