Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59653761530
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:26:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOGAp-0008PF-Qp; Tue, 25 Jul 2023 07:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qOGAn-0008Nl-7p
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qOGAl-0005BS-QY
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690284345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fNC19noJdq623w1yRvS7RGW9t8107t5R8MmbiCxwkRw=;
 b=gI7VhwkYp6XyDHNZINxaS0d6Zk98gSkrAdzzrZO5ucGXnOcDEnCo8gDRd64UDuVXh5EOja
 3q6GuTDtDfVNzrc21ebzRtLnDg/eyPbNdgPJc19mZ4WnNx9X0GvyEWZ0jvAGXYQXj7s3Gh
 q9MwGqoEKysxE+dw+k8I1KDQCTTBues=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-4qeVL-TINMu3t4HBaH3sPA-1; Tue, 25 Jul 2023 07:25:44 -0400
X-MC-Unique: 4qeVL-TINMu3t4HBaH3sPA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFF8F1C02142
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 11:25:43 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 211C0492C13;
 Tue, 25 Jul 2023 11:25:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] ui/dbus: fix win32 compilation when !opengl
Date: Tue, 25 Jul 2023 15:25:40 +0400
Message-ID: <20230725112540.53284-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Marc-Andre Lureau <marcandre.lureau@redhat.com>

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1782

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 68ff343799..02fc6ae239 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -338,6 +338,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
     return true;
 }
 
+#ifdef CONFIG_OPENGL
 static bool
 dbus_scanout_share_d3d_texture(
     DBusDisplayListener *ddl,
@@ -399,7 +400,8 @@ dbus_scanout_share_d3d_texture(
 
     return true;
 }
-#endif
+#endif /* CONFIG_OPENGL */
+#endif /* WIN32 */
 
 #ifdef CONFIG_OPENGL
 static void dbus_scanout_texture(DisplayChangeListener *dcl,
-- 
2.41.0


