Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1697916AF
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:00:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8CD-0001XQ-9a; Mon, 04 Sep 2023 07:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Bx-0001MV-5R
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Bt-00013v-R9
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9qzmsX2T96slRBtx7orvO5yh2WcU4rUq1DSMp/9kbQ=;
 b=Q307iDhlT46w8e89nvBvczrNd/DliaBCwrBvuOzfMi3/fRBMnVe+3/eHxwfzW1i+7HHYPN
 B4j76vKYxzR4YQ0t7rmav37p0ezlol3VUDr6oEzWAvoGZ+Z6t3PQ3f9itQUc06RRnIpSeh
 /UXt3LMTdkqJ8JnekZenye7k3L1F86w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-wJxSZSs2MiqcK57oSyB7gQ-1; Mon, 04 Sep 2023 07:56:21 -0400
X-MC-Unique: wJxSZSs2MiqcK57oSyB7gQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 737AB1C2979A;
 Mon,  4 Sep 2023 11:56:21 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6DD9568FF;
 Mon,  4 Sep 2023 11:56:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Guoyi Tu <tugy@chinatelecom.cn>,
 dengpengcheng <dengpc12@chinatelecom.cn>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 51/52] ui/vdagent: Unregister input handler of mouse during
 finalization
Date: Mon,  4 Sep 2023 15:52:48 +0400
Message-ID: <20230904115251.4161397-52-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Guoyi Tu <tugy@chinatelecom.cn>

Input handler resource should be released when
VDAgentChardev object finalize

Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
Signed-off-by: dengpengcheng <dengpc12@chinatelecom.cn>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <e7f5e172abf797d454e00a4bbe53af83e4aa4497.1692281173.git.tugy@chinatelecom.cn>
---
 ui/vdagent.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 4b9a1fb7c5..00d36a8677 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -926,6 +926,9 @@ static void vdagent_chr_fini(Object *obj)
 
     migrate_del_blocker(vd->migration_blocker);
     vdagent_disconnect(vd);
+    if (vd->mouse_hs) {
+        qemu_input_handler_unregister(vd->mouse_hs);
+    }
     buffer_free(&vd->outbuf);
     error_free(vd->migration_blocker);
 }
-- 
2.41.0


