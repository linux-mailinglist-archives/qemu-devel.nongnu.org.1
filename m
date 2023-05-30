Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5C2715F67
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yT4-0001ZE-Rp; Tue, 30 May 2023 08:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3ySy-0001SS-2I
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3ySv-0000iZ-CZ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685449715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jsu5TgJNVrUJXO0bXsXrpThzVU0kVpMTORXps14yM+g=;
 b=JvFv7D5aNZ4ropO08kgSi7I8yFCNT3t/RsAQ9lP94slF1/o7eYNZAeqeMgILw+DD6g2Zof
 7ICnXaAsjCr6VUoeKlwFrRtqojLo5fI9pknPsetK0TlLHql+iSmP7Sl0CfWekLMOcwJAxq
 cPTvVfUN0k7oYksNOrs35WfpVgEdYK0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-Q3Z7xb8kOtiC73yEpIWwUQ-1; Tue, 30 May 2023 08:28:32 -0400
X-MC-Unique: Q3Z7xb8kOtiC73yEpIWwUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C44A185A793;
 Tue, 30 May 2023 12:28:32 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B95340CFD45;
 Tue, 30 May 2023 12:28:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 09/16] qemu_file: Remove unused qemu_file_transferred()
Date: Tue, 30 May 2023 14:28:06 +0200
Message-Id: <20230530122813.2674-10-quintela@redhat.com>
In-Reply-To: <20230530122813.2674-1-quintela@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 21c3f34b84..b4fb872018 100644
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
index a8420dd734..2da092ab77 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -637,13 +637,6 @@ uint64_t qemu_file_transferred_noflush(QEMUFile *f)
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
2.40.1


