Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF65BB747F
	for <lists+qemu-devel@lfdr.de>; Fri, 03 Oct 2025 17:05:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hJf-00022F-2w; Fri, 03 Oct 2025 11:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v4hJV-0001zq-3W
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v4hJJ-0006Fy-45
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759503778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ys43BDMeRa4lZ4I8tvZjJZS+liCw/3NI7My0+q1Ro0k=;
 b=C/i0eBdJXew1gDfP6S3Z2xUi2QSE5k74SEYZo05yadFGg52tMLbK4uMCQwzxGcJEEZ/YVi
 ZAPJB9eDa2FamUnxoV9DOQczjepD1xeBKk63VR1b/OXZZ96Tj/iuNz1SmvH5wmTxe8SrWI
 Yk2zw3Je2RJm/nNk262FG3A5sjggcKA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-ibRvl2X_Oj6gygz32B9ZIw-1; Fri,
 03 Oct 2025 11:02:53 -0400
X-MC-Unique: ibRvl2X_Oj6gygz32B9ZIw-1
X-Mimecast-MFC-AGG-ID: ibRvl2X_Oj6gygz32B9ZIw_1759503772
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF3B219560AE; Fri,  3 Oct 2025 15:02:51 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.145])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F14818004D8; Fri,  3 Oct 2025 15:02:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Grant Millar | Cylo <rid@cylo.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH v2 1/3] io: release active GSource in TLS channel finalizer
Date: Fri,  3 Oct 2025 16:02:43 +0100
Message-ID: <20251003150245.3510069-2-berrange@redhat.com>
In-Reply-To: <20251003150245.3510069-1-berrange@redhat.com>
References: <20251003150245.3510069-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

While code is supposed to call qio_channel_close() before releasing the
last reference on an QIOChannel, this is not guaranteed. QIOChannelFile
and QIOChannelSocket both cleanup resources in their finalizer if the
close operation was missed.

This ensures the TLS channel will do the same failsafe cleanup.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-tls.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 7135896f79..bb460ca7e9 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -342,6 +342,16 @@ static void qio_channel_tls_finalize(Object *obj)
 {
     QIOChannelTLS *ioc = QIO_CHANNEL_TLS(obj);
 
+    if (ioc->hs_ioc_tag) {
+        trace_qio_channel_tls_handshake_cancel(ioc);
+        g_clear_handle_id(&ioc->hs_ioc_tag, g_source_remove);
+    }
+
+    if (ioc->bye_ioc_tag) {
+        trace_qio_channel_tls_bye_cancel(ioc);
+        g_clear_handle_id(&ioc->bye_ioc_tag, g_source_remove);
+    }
+
     object_unref(OBJECT(ioc->master));
     qcrypto_tls_session_free(ioc->session);
 }
-- 
2.50.1


