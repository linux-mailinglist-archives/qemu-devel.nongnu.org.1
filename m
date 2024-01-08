Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B78274B2
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 17:10:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMsBi-0006oP-BJ; Mon, 08 Jan 2024 11:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rMsBg-0006nz-5Y
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:09:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rMsBd-0000mw-Ag
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704730144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FAeSf6AyHlWJ1aj4AEUmp5aZamGhHrmjKFEVdVz+6yI=;
 b=VsWD730qGsSNjzlntBTn87GqgJ8rRiMybUUo032vyeRI9FG/BkYibdcYtjnMMGsoMvU+4H
 9eO+aMyrByM1y15LtJ3S6ttLcF4FCI1RFb4IoA73vb4EMzYTqADzrocElxHA02mBNS+p/0
 D3nUlV072eppkJqf73OMO0MH8PjUa6Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-7GUMMKH7ME-p_skRFJWbvw-1; Mon, 08 Jan 2024 11:09:01 -0500
X-MC-Unique: 7GUMMKH7ME-p_skRFJWbvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72FA0918569;
 Mon,  8 Jan 2024 16:09:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 418BC2166B33;
 Mon,  8 Jan 2024 16:09:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2A656180092F; Mon,  8 Jan 2024 17:09:00 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 1/3] hw/pflash: refactor pflash_data_write()
Date: Mon,  8 Jan 2024 17:08:57 +0100
Message-ID: <20240108160900.104835-2-kraxel@redhat.com>
In-Reply-To: <20240108160900.104835-1-kraxel@redhat.com>
References: <20240108160900.104835-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Move the offset calculation, do it once at the start of the function and
let the 'p' variable point directly to the memory location which should
be updated.  This makes it simpler to update other buffers than
pfl->storage in an upcoming patch.  No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/block/pflash_cfi01.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 3e2dc08bd78f..67f1c9773ab3 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -403,33 +403,35 @@ static void pflash_update(PFlashCFI01 *pfl, int offset,
 static inline void pflash_data_write(PFlashCFI01 *pfl, hwaddr offset,
                                      uint32_t value, int width, int be)
 {
-    uint8_t *p = pfl->storage;
+    uint8_t *p;
 
     trace_pflash_data_write(pfl->name, offset, width, value, pfl->counter);
+    p = pfl->storage + offset;
+
     switch (width) {
     case 1:
-        p[offset] = value;
+        p[0] = value;
         break;
     case 2:
         if (be) {
-            p[offset] = value >> 8;
-            p[offset + 1] = value;
+            p[0] = value >> 8;
+            p[1] = value;
         } else {
-            p[offset] = value;
-            p[offset + 1] = value >> 8;
+            p[0] = value;
+            p[1] = value >> 8;
         }
         break;
     case 4:
         if (be) {
-            p[offset] = value >> 24;
-            p[offset + 1] = value >> 16;
-            p[offset + 2] = value >> 8;
-            p[offset + 3] = value;
+            p[0] = value >> 24;
+            p[1] = value >> 16;
+            p[2] = value >> 8;
+            p[3] = value;
         } else {
-            p[offset] = value;
-            p[offset + 1] = value >> 8;
-            p[offset + 2] = value >> 16;
-            p[offset + 3] = value >> 24;
+            p[0] = value;
+            p[1] = value >> 8;
+            p[2] = value >> 16;
+            p[3] = value >> 24;
         }
         break;
     }
-- 
2.43.0


