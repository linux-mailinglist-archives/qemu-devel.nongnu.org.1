Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDF570E1D1
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:32:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Uvk-0002q4-UO; Tue, 23 May 2023 12:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q1Uvh-0002pe-Fx
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:32:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q1Uvf-0000QF-Om
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684859526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EET2Da+kTu3BqzjQiQx4jbxb1dx6dRVpwsShZHnt/l0=;
 b=ZzRFOqc8RujfKKcGEAGYlqOKjvn2TxolfKSZcXRJ/pqPP/O6ESus62yNuhG/poMLzPtZcB
 dX7sIQnLkYzpFf2Vi6uUfd2ClaM3jajW7/h3LzRujFj6S31p6CZjn3P/6nCHHKOyb/vINK
 iqGf1CWJtgu9tOQadcnREjJ1EOZ8efg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-E0Z7ADgPPeWJlP_Io0iPyA-1; Tue, 23 May 2023 12:31:58 -0400
X-MC-Unique: E0Z7ADgPPeWJlP_Io0iPyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C14A92999B2C;
 Tue, 23 May 2023 16:31:45 +0000 (UTC)
Received: from f38-work.redhat.com (unknown [10.39.193.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 251DF200B673;
 Tue, 23 May 2023 16:31:44 +0000 (UTC)
From: Mauro Matteo Cascella <mcascell@redhat.com>
To: qemu-devel@nongnu.org
Cc: mcascell@redhat.com, kraxel@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, philmd@linaro.org, richard.henderson@linaro.org,
 jacek.halon@gmail.com, yairh33@gmail.com, e.elrefaei99@gmail.com
Subject: [PATCH v2] ui/cursor: make width/height unsigned 16-bit integer
Date: Tue, 23 May 2023 18:30:23 +0200
Message-Id: <20230523163023.608121-1-mcascell@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Although not actually exploitable at the moment, a negative width/height
could make datasize wrap around and potentially lead to buffer overflow.
Since there is no reason a negative width/height is ever appropriate,
modify QEMUCursor struct and cursor_alloc prototype to accept uint16_t.
This protects us against accidentally introducing future bugs.

Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
Reported-by: Jacek Halon <jacek.halon@gmail.com>
Reported-by: Yair Mizrahi <yairh33@gmail.com>
Reported-by: Elsayed El-Refa'ei <e.elrefaei99@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
v2:
- update commit summary/description
- add Reported-by/Reviewed-by
- use uint16_t instead of uint32_t
- add comment in cursor_alloc

 include/ui/console.h | 4 ++--
 ui/cursor.c          | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 2a8fab091f..ae5ec466c1 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -144,13 +144,13 @@ typedef struct QemuUIInfo {
 
 /* cursor data format is 32bit RGBA */
 typedef struct QEMUCursor {
-    int                 width, height;
+    uint16_t            width, height;
     int                 hot_x, hot_y;
     int                 refcount;
     uint32_t            data[];
 } QEMUCursor;
 
-QEMUCursor *cursor_alloc(int width, int height);
+QEMUCursor *cursor_alloc(uint16_t width, uint16_t height);
 QEMUCursor *cursor_ref(QEMUCursor *c);
 void cursor_unref(QEMUCursor *c);
 QEMUCursor *cursor_builtin_hidden(void);
diff --git a/ui/cursor.c b/ui/cursor.c
index 6fe67990e2..29717b3ecb 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -90,11 +90,12 @@ QEMUCursor *cursor_builtin_left_ptr(void)
     return cursor_parse_xpm(cursor_left_ptr_xpm);
 }
 
-QEMUCursor *cursor_alloc(int width, int height)
+QEMUCursor *cursor_alloc(uint16_t width, uint16_t height)
 {
     QEMUCursor *c;
     size_t datasize = width * height * sizeof(uint32_t);
 
+    /* Modern physical hardware typically uses 512x512 sprites */
     if (width > 512 || height > 512) {
         return NULL;
     }
-- 
2.40.1


