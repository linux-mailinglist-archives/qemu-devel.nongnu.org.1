Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7397D666C
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:14:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZvy-0003Sk-Kc; Wed, 25 Oct 2023 05:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZvS-00025s-NQ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZvI-0006tQ-QO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698225092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ThKsMZT95Vsxl1B5wwParcPMKw3NxOA5/mR1LbiHBn0=;
 b=B5ARiMqsk6cOt9iz/+2ive7mqgo6j44Am1MFUB2pzIUFmTPx8b5rJOX3VDmQltLK4nOsGe
 otL3jYkNYexf6YIlZYiHMvUykDei25jG2Rr7YOvZqmOqtndPg1uxnvwl2IfNUxJIOXGFKe
 SO8X79CdZhx7XntqHs64TeeMLKRcSVw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-PVS0TptQPb6cHR6-x0apBQ-1; Wed, 25 Oct 2023 05:11:30 -0400
X-MC-Unique: PVS0TptQPb6cHR6-x0apBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D9EE8678A0;
 Wed, 25 Oct 2023 09:11:30 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9243A503B;
 Wed, 25 Oct 2023 09:11:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fabiano Rosas <farosas@suse.de>, Li Zhijian <lizhijian@fujitsu.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 05/12] qemu_file: Remove unused qemu_file_transferred()
Date: Wed, 25 Oct 2023 11:11:10 +0200
Message-ID: <20231025091117.6342-6-quintela@redhat.com>
In-Reply-To: <20231025091117.6342-1-quintela@redhat.com>
References: <20231025091117.6342-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
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


