Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2AAA0E2B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Apr 2025 16:06:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9laZ-0002sa-74; Tue, 29 Apr 2025 10:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1u9laM-0002h5-8Y
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1u9laJ-0005s0-AX
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745935518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bb/H9vVU1cMZ8hb7U4a6OciQYW7eZ95HeN92fvbr3X0=;
 b=Twm9Wx+Zh6CnraRuKYiPvEu517Rwzw3uVEfHd5+uotYMEmt+YUWWIxKU2yPE0j1x2x734k
 O1cuOXy/6taAds3lSUzC9nJYYGkPInZcH3hm7b1OgUN7U81ShiM7J2lcQKfo8LRLv473JA
 I2UxbspwQp5k2ne5Vyowh5t2FPgTn8M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-97zJwr8fPe-BKcVtUuDZbw-1; Tue,
 29 Apr 2025 10:04:05 -0400
X-MC-Unique: 97zJwr8fPe-BKcVtUuDZbw-1
X-Mimecast-MFC-AGG-ID: 97zJwr8fPe-BKcVtUuDZbw_1745935427
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99B19180099C; Tue, 29 Apr 2025 14:03:35 +0000 (UTC)
Received: from localhost (unknown [10.45.242.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36E67180045C; Tue, 29 Apr 2025 14:03:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 4/6] qdev: make release_prop_array() free array and idempotent
Date: Tue, 29 Apr 2025 18:03:04 +0400
Message-ID: <20250429140306.190384-5-marcandre.lureau@redhat.com>
In-Reply-To: <20250429140306.190384-1-marcandre.lureau@redhat.com>
References: <20250429140306.190384-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Fix a memory leak, and allow it to be called multiple times safely.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index bad111833c..7a53c85887 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -620,15 +620,16 @@ static void release_prop_array(Object *obj, const char *name, void *opaque)
     char *elem = *arrayptr;
     int i;
 
-    if (!prop->arrayinfo->release) {
-        return;
+    if (prop->arrayinfo->release) {
+        for (i = 0; i < *alenptr; i++) {
+            Property elem_prop = array_elem_prop(obj, prop, name, elem);
+            prop->arrayinfo->release(obj, NULL, &elem_prop);
+            elem += prop->arrayfieldsize;
+        }
     }
 
-    for (i = 0; i < *alenptr; i++) {
-        Property elem_prop = array_elem_prop(obj, prop, name, elem);
-        prop->arrayinfo->release(obj, NULL, &elem_prop);
-        elem += prop->arrayfieldsize;
-    }
+    *alenptr = 0;
+    g_clear_pointer(arrayptr, g_free);
 }
 
 /*
-- 
2.49.0


