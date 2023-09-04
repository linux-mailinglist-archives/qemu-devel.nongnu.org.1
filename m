Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F39979168F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:56:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8Ba-0000pn-Lc; Mon, 04 Sep 2023 07:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8BQ-0000ZA-8W
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8BO-0000oP-1a
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tZfSsnhfezWbR25O9bGbK3oCf6AjZ5e+y9iHI+/Jts=;
 b=S374vXqeh41dRfqu100DJdgn6n9uKLMXR5gmhJFjsNGytyNtsT256Hn9Z+giBn9TP18JLz
 lVQ607IV3nhlbsw8hklTVJZD2A+/nZoZr0IBB9ttkNkfMmaghweAm8a2NCVK5hWCa36xG5
 2K5N678PnfaAR3Dp9onPAn44fMDNmX4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-rYUzNEOlPr-rtncGciB39A-1; Mon, 04 Sep 2023 07:55:51 -0400
X-MC-Unique: rYUzNEOlPr-rtncGciB39A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7981184AF9D;
 Mon,  4 Sep 2023 11:55:51 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E186493110;
 Mon,  4 Sep 2023 11:55:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 45/52] ui/spice-display: Avoid dynamic stack allocation
Date: Mon,  4 Sep 2023 15:52:42 +0400
Message-ID: <20230904115251.4161397-46-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
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

Use an autofree heap allocation instead of a variable-length
array on the stack in qemu_spice_create_update().

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230818151057.1541189-2-peter.maydell@linaro.org>
---
 ui/spice-display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 3f3f8013d8..0e2fbfb17c 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -189,7 +189,7 @@ static void qemu_spice_create_update(SimpleSpiceDisplay *ssd)
 {
     static const int blksize = 32;
     int blocks = DIV_ROUND_UP(surface_width(ssd->ds), blksize);
-    int dirty_top[blocks];
+    g_autofree int *dirty_top = NULL;
     int y, yoff1, yoff2, x, xoff, blk, bw;
     int bpp = surface_bytes_per_pixel(ssd->ds);
     uint8_t *guest, *mirror;
@@ -198,6 +198,7 @@ static void qemu_spice_create_update(SimpleSpiceDisplay *ssd)
         return;
     };
 
+    dirty_top = g_new(int, blocks);
     for (blk = 0; blk < blocks; blk++) {
         dirty_top[blk] = -1;
     }
-- 
2.41.0


