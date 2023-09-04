Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F39791680
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:55:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd897-00028k-Vn; Mon, 04 Sep 2023 07:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd896-00028Z-6j
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd894-0008LC-5N
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M7pr8wNWnVKyqTb6/FonS0/BUyVU5gQwWEUhaT0ftwU=;
 b=PbT2H7UiNRgx23rC/1+c/PcCGunHZFNAOsgdGAnG5474r5KDQIFz5MEyCk7JTd0fKdxHws
 c4lqon+Y28Hcokqk2NmacozEl/ZBl8cxHfb+3FgUfXI5DbTasb/tjleApht6iZTVS1Jpnb
 TPsktsAwB4PZkKVkKERs/dZvdpa/pkk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-GFWz9JSaOHeZCFAxNB68-w-1; Mon, 04 Sep 2023 07:53:27 -0400
X-MC-Unique: GFWz9JSaOHeZCFAxNB68-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05BB01C29799
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:53:27 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1514B568FF;
 Mon,  4 Sep 2023 11:53:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 08/52] ui/console: drop have_gfx
Date: Mon,  4 Sep 2023 15:52:05 +0400
Message-ID: <20230904115251.4161397-9-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

All usages have been removed.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-9-marcandre.lureau@redhat.com>
---
 ui/console.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 2bc4c153de..fc1836782d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -132,7 +132,6 @@ struct DisplayState {
     uint64_t last_update;
     uint64_t update_interval;
     bool refreshing;
-    bool have_gfx;
 
     QLIST_HEAD(, DisplayChangeListener) listeners;
 };
@@ -183,15 +182,11 @@ static void gui_setup_refresh(DisplayState *ds)
 {
     DisplayChangeListener *dcl;
     bool need_timer = false;
-    bool have_gfx = false;
 
     QLIST_FOREACH(dcl, &ds->listeners, next) {
         if (dcl->ops->dpy_refresh != NULL) {
             need_timer = true;
         }
-        if (dcl->ops->dpy_gfx_update != NULL) {
-            have_gfx = true;
-        }
     }
 
     if (need_timer && ds->gui_timer == NULL) {
@@ -202,8 +197,6 @@ static void gui_setup_refresh(DisplayState *ds)
         timer_free(ds->gui_timer);
         ds->gui_timer = NULL;
     }
-
-    ds->have_gfx = have_gfx;
 }
 
 void graphic_hw_update_done(QemuConsole *con)
-- 
2.41.0


