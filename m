Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F177916CF
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:04:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8Bh-0000yI-DK; Mon, 04 Sep 2023 07:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Bd-0000vt-Ub
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Bb-0000sE-IY
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:56:09 -0400
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-pR113HOoPLmulbZKm60KnQ-1; Mon, 04 Sep 2023 07:56:05 -0400
X-MC-Unique: pR113HOoPLmulbZKm60KnQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 459752999B2D;
 Mon,  4 Sep 2023 11:56:05 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30BB4493110;
 Mon,  4 Sep 2023 11:56:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 47/52] ui/vnc-enc-tight: Avoid dynamic stack allocation
Date: Mon,  4 Sep 2023 15:52:44 +0400
Message-ID: <20230904115251.4161397-48-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Use autofree heap allocation instead of variable-length
array on the stack.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[PMM: expanded commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230818151057.1541189-4-peter.maydell@linaro.org>
---
 ui/vnc-enc-tight.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index ee853dcfcb..41f559eb83 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -1097,13 +1097,13 @@ static int send_palette_rect(VncState *vs, int x, int y,
     switch (vs->client_pf.bytes_per_pixel) {
     case 4:
     {
-        size_t old_offset, offset;
-        uint32_t header[palette_size(palette)];
+        size_t old_offset, offset, palette_sz = palette_size(palette);
+        g_autofree uint32_t *header = g_new(uint32_t, palette_sz);
         struct palette_cb_priv priv = { vs, (uint8_t *)header };
 
         old_offset = vs->output.offset;
         palette_iter(palette, write_palette, &priv);
-        vnc_write(vs, header, sizeof(header));
+        vnc_write(vs, header, palette_sz * sizeof(uint32_t));
 
         if (vs->tight->pixel24) {
             tight_pack24(vs, vs->output.buffer + old_offset, colors, &offset);
@@ -1115,11 +1115,12 @@ static int send_palette_rect(VncState *vs, int x, int y,
     }
     case 2:
     {
-        uint16_t header[palette_size(palette)];
+        size_t palette_sz = palette_size(palette);
+        g_autofree uint16_t *header = g_new(uint16_t, palette_sz);
         struct palette_cb_priv priv = { vs, (uint8_t *)header };
 
         palette_iter(palette, write_palette, &priv);
-        vnc_write(vs, header, sizeof(header));
+        vnc_write(vs, header, palette_sz * sizeof(uint16_t));
         tight_encode_indexed_rect16(vs->tight->tight.buffer, w * h, palette);
         break;
     }
-- 
2.41.0


