Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 990807916C6
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:02:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8Bd-0000sh-C7; Mon, 04 Sep 2023 07:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8BZ-0000ph-8T
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8BX-0000qq-2Z
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjGC2ML3L2cd08LhzVrXNPJbEDWvTfhWKeJntBP1e6U=;
 b=BtSFcIkV6D72tnZuWGhrHHEAFRAHIxiaTVVntT7DCzdczvhKezbMditRjiyd/iR36crUtK
 JQdVA+w8Rkmk0rb2EThcWkblLWSbiNUOQSJPBx//qTG/p6b8Ssyb1wo4dK56yKoBBzkjJN
 A8g70T13C10DAJhRj+ulWixaUJmK0JM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-NbbM8DGbNgu22cgBSfmu8Q-1; Mon, 04 Sep 2023 07:56:01 -0400
X-MC-Unique: NbbM8DGbNgu22cgBSfmu8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0427410264C1;
 Mon,  4 Sep 2023 11:56:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 318AA2013570;
 Mon,  4 Sep 2023 11:55:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 46/52] ui/vnc-enc-hextile: Use static rather than dynamic
 length stack array
Date: Mon,  4 Sep 2023 15:52:43 +0400
Message-ID: <20230904115251.4161397-47-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

From: Peter Maydell <peter.maydell@linaro.org>

In the send_hextile_tile_* function we create a variable length array
data[].  In fact we know that the client_pf.bytes_per_pixel is at
most 4 (enforced by set_pixel_format()), so we can make the array a
compile-time fixed length of 1536 bytes.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[ Marc-André - rename BPP to MAX_BYTES_PER_PIXEL ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230818151057.1541189-3-peter.maydell@linaro.org>
---
 ui/vnc-enc-hextile-template.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ui/vnc-enc-hextile-template.h b/ui/vnc-enc-hextile-template.h
index 0c56262aff..8ee92086ac 100644
--- a/ui/vnc-enc-hextile-template.h
+++ b/ui/vnc-enc-hextile-template.h
@@ -7,6 +7,8 @@
 #define NAME BPP
 #endif
 
+#define MAX_BYTES_PER_PIXEL 4
+
 static void CONCAT(send_hextile_tile_, NAME)(VncState *vs,
                                              int x, int y, int w, int h,
                                              void *last_bg_,
@@ -25,10 +27,13 @@ static void CONCAT(send_hextile_tile_, NAME)(VncState *vs,
     int bg_count = 0;
     int fg_count = 0;
     int flags = 0;
-    uint8_t data[(vs->client_pf.bytes_per_pixel + 2) * 16 * 16];
+    uint8_t data[(MAX_BYTES_PER_PIXEL + 2) * 16 * 16];
     int n_data = 0;
     int n_subtiles = 0;
 
+    /* Enforced by set_pixel_format() */
+    assert(vs->client_pf.bytes_per_pixel <= MAX_BYTES_PER_PIXEL);
+
     for (j = 0; j < h; j++) {
         for (i = 0; i < w; i++) {
             switch (n_colors) {
@@ -205,6 +210,7 @@ static void CONCAT(send_hextile_tile_, NAME)(VncState *vs,
     }
 }
 
+#undef MAX_BYTES_PER_PIXEL
 #undef NAME
 #undef pixel_t
 #undef CONCAT_I
-- 
2.41.0


