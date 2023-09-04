Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A033791698
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:57:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8BS-0000ZY-VZ; Mon, 04 Sep 2023 07:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8BA-0008Eu-OS
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8B8-0000jG-FX
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxMIBQi7PlqW3/xdFHAfeW/CZD2xQBgZSMYVWBTn90A=;
 b=i9rqGr6rvAq4d9f/G0BYlapk93Nj7mMYUZBmwD45WB1b+rOc/AB/+8lVqqIlHXgD7fDUmt
 oihQBgPJJQ7V8DJ7mYu7j52Qeo+KFKcHv2KNzY3oKp81JCtbQuI92aN71+PdhpLFwIL8Bd
 kEdd/Q72sWY0uOEtcA29uNpchDdmdcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-sEfLxxIuPL-HAh7-n9c4QA-1; Mon, 04 Sep 2023 07:55:36 -0400
X-MC-Unique: sEfLxxIuPL-HAh7-n9c4QA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 217D9803E2E
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:55:36 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77E6D493114;
 Mon,  4 Sep 2023 11:55:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 41/52] ui/console: minor stylistic changes
Date: Mon,  4 Sep 2023 15:52:38 +0400
Message-ID: <20230904115251.4161397-42-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-42-marcandre.lureau@redhat.com>
---
 ui/console.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 4ee3b77568..b1d375ecb4 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -427,20 +427,18 @@ static void text_console_resize(QemuTextConsole *t)
     t->width = w;
     t->height = h;
 
-    w1 = last_width;
-    if (t->width < w1)
-        w1 = t->width;
+    w1 = MIN(t->width, last_width);
 
     cells = g_new(TextCell, t->width * t->total_height + 1);
-    for(y = 0; y < t->total_height; y++) {
+    for (y = 0; y < t->total_height; y++) {
         c = &cells[y * t->width];
         if (w1 > 0) {
             c1 = &t->cells[y * last_width];
-            for(x = 0; x < w1; x++) {
+            for (x = 0; x < w1; x++) {
                 *c++ = *c1++;
             }
         }
-        for(x = w1; x < t->width; x++) {
+        for (x = w1; x < t->width; x++) {
             c->ch = ' ';
             c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             c++;
-- 
2.41.0


