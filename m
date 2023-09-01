Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D7B78FBC3
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:30:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc1Q6-0001LO-UI; Fri, 01 Sep 2023 06:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qc1Q5-0001K3-0E
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qc1Q1-0006Gt-Kp
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693564224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ugDC0xtnMbVYga+N/Kv+ZNa2a18RQ0yQE1zQz3sQp0Y=;
 b=UuA62pkSB+uuV6X7tDBmCD37PRnFH3MAR44QO95T71nS8R0zr3UKuKEbnoJ3mADwNLxBB9
 rySJCUzh1usmPKLp2mwjqh4P8jvALdD0lqGKs8sQSp2C6JMsQL3rnA1bD1xXkIGR0YGDfS
 TDPXGEt6qSdt5ef9ZsOnVYMExwmFq5I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-UaHJ0RmgOc-OvWIqs98Lng-1; Fri, 01 Sep 2023 06:30:23 -0400
X-MC-Unique: UaHJ0RmgOc-OvWIqs98Lng-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFA9C10264F4
 for <qemu-devel@nongnu.org>; Fri,  1 Sep 2023 10:30:21 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.224.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3664493112;
 Fri,  1 Sep 2023 10:30:20 +0000 (UTC)
From: Bilal Elmoussaoui <belmouss@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Bilal Elmoussaoui <belmouss@redhat.com>
Subject: [PATCH] dbus: Properly dispose touch/mouse dbus objects
Date: Fri,  1 Sep 2023 12:30:20 +0200
Message-ID: <20230901103020.86915-1-belmouss@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=belmouss@redhat.com;
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

---
 ui/dbus-console.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index e19774f985..36f7349585 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -150,6 +150,8 @@ dbus_display_console_dispose(GObject *object)
     DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
 
     unregister_displaychangelistener(&ddc->dcl);
+    g_clear_object(&ddc->iface_touch);
+    g_clear_object(&ddc->iface_mouse);
     g_clear_object(&ddc->iface_kbd);
     g_clear_object(&ddc->iface);
     g_clear_pointer(&ddc->listeners, g_hash_table_unref);
-- 
2.41.0


