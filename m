Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC1271399D
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GKZ-0007eB-Kg; Sun, 28 May 2023 09:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKX-0007e1-6G
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKV-00087w-O7
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+83Gk38iR1YLnw0eyUn4q8QcszZ9vJaxzUVdy2DVMuc=;
 b=LzIsPj/Pkd6SF9aOT5iQY2m8HlISMRJmzorZClZMdEp939mTFBUjsixQY+suauBxYx3Ztt
 5u+UrVNdDbXOHsXbhvgT9h9Ci9mS9m0CabW5iq9x14I455n88L3SHKJaUb1V3lrxAQQFc5
 wDsY64U6DuG0TJI0Xs0wne+2AjejYNI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-dBNcUPDONoi-iv4sB2xJuw-1; Sun, 28 May 2023 09:20:59 -0400
X-MC-Unique: dBNcUPDONoi-iv4sB2xJuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE4ED101A590;
 Sun, 28 May 2023 13:20:58 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 987C953BB;
 Sun, 28 May 2023 13:20:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 09/19] ui/dbus: add a FIXME about texture/dmabuf scanout
 handling
Date: Sun, 28 May 2023 17:20:06 +0400
Message-Id: <20230528132016.3218152-10-marcandre.lureau@redhat.com>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Except SDL, display backends seem to fail at handing full scanout
geometry correctly. It would need some test/reproducer to actually check
it. In the meantime, fill some missing fields, and leave a FIXME.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230515132537.1026310-1-marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index defe2220c0..23034eebf9 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -102,6 +102,7 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
         return;
     }
 
+    /* FIXME: add missing x/y/w/h support */
     qemu_dbus_display1_listener_call_scanout_dmabuf(
         ddl->proxy,
         g_variant_new_handle(0),
@@ -129,6 +130,10 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
         .width = backing_width,
         .height = backing_height,
         .y0_top = backing_y_0_top,
+        .x = x,
+        .y = y,
+        .scanout_width = w,
+        .scanout_height = h,
     };
 
     assert(tex_id);
-- 
2.40.1


