Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 777548274B6
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 17:10:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMsBg-0006nj-8X; Mon, 08 Jan 2024 11:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rMsBc-0006mk-Ef
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:09:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rMsBa-0000oZ-1Y
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704730146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UMeANDd14nL6Odyxug03PTmTfnYlzkXPTCXfG6UNpQ=;
 b=WhHmASzPoo+1aaVQwHDG/tUSarVtrPgQiE4KmTUuLfU9YYkJx5KvObXEoNFn3HaGUcfzoc
 176G5pN9rZx1v75MizLk8IvVel9t2uM0DsqrJZvzbHIC4aLj+2SKV+z192d92cy3WMDQS9
 DuSoIbt4NZsnu4VmGIa8RWiy0o27qWs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-XAHmDmgONGONQOHLsiwQqw-1; Mon, 08 Jan 2024 11:09:03 -0500
X-MC-Unique: XAHmDmgONGONQOHLsiwQqw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C28E8101A49F;
 Mon,  8 Jan 2024 16:09:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A1BD492BC7;
 Mon,  8 Jan 2024 16:09:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 37B8C18009BD; Mon,  8 Jan 2024 17:09:00 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/3] hw/pflash: use ldn_{be,le}_p and stn_{be,le}_p
Date: Mon,  8 Jan 2024 17:08:58 +0100
Message-ID: <20240108160900.104835-3-kraxel@redhat.com>
In-Reply-To: <20240108160900.104835-1-kraxel@redhat.com>
References: <20240108160900.104835-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

Use the helper functions we have to read/write multi-byte values
in correct byte order.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/block/pflash_cfi01.c | 63 ++++++-----------------------------------
 1 file changed, 8 insertions(+), 55 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 67f1c9773ab3..8434a45cabb0 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -225,34 +225,10 @@ static uint32_t pflash_data_read(PFlashCFI01 *pfl, hwaddr offset,
     uint32_t ret;
 
     p = pfl->storage;
-    switch (width) {
-    case 1:
-        ret = p[offset];
-        break;
-    case 2:
-        if (be) {
-            ret = p[offset] << 8;
-            ret |= p[offset + 1];
-        } else {
-            ret = p[offset];
-            ret |= p[offset + 1] << 8;
-        }
-        break;
-    case 4:
-        if (be) {
-            ret = p[offset] << 24;
-            ret |= p[offset + 1] << 16;
-            ret |= p[offset + 2] << 8;
-            ret |= p[offset + 3];
-        } else {
-            ret = p[offset];
-            ret |= p[offset + 1] << 8;
-            ret |= p[offset + 2] << 16;
-            ret |= p[offset + 3] << 24;
-        }
-        break;
-    default:
-        abort();
+    if (be) {
+        ret = ldn_be_p(p + offset, width);
+    } else {
+        ret = ldn_le_p(p + offset, width);
     }
     trace_pflash_data_read(pfl->name, offset, width, ret);
     return ret;
@@ -408,34 +384,11 @@ static inline void pflash_data_write(PFlashCFI01 *pfl, hwaddr offset,
     trace_pflash_data_write(pfl->name, offset, width, value, pfl->counter);
     p = pfl->storage + offset;
 
-    switch (width) {
-    case 1:
-        p[0] = value;
-        break;
-    case 2:
-        if (be) {
-            p[0] = value >> 8;
-            p[1] = value;
-        } else {
-            p[0] = value;
-            p[1] = value >> 8;
-        }
-        break;
-    case 4:
-        if (be) {
-            p[0] = value >> 24;
-            p[1] = value >> 16;
-            p[2] = value >> 8;
-            p[3] = value;
-        } else {
-            p[0] = value;
-            p[1] = value >> 8;
-            p[2] = value >> 16;
-            p[3] = value >> 24;
-        }
-        break;
+    if (be) {
+        stn_be_p(p, width, value);
+    } else {
+        stn_le_p(p, width, value);
     }
-
 }
 
 static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
-- 
2.43.0


