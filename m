Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0CF78FDAE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 14:47:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc3Wq-00040L-7k; Fri, 01 Sep 2023 08:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qc3WU-0003pQ-Pw
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qc3WS-0003kx-Lx
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693572310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GzYgxymq3LMm6ch9lbw7P8Hvlt9C11Xga5pTDlRqe5k=;
 b=gxJch8bOhpQwTWTLMUQ2v7pLJy/2tvKmqS4YkzQiQlfXD1slG761mztAf+6C76/sTOuuhx
 wfuhWwWMyuqADvb3PnydSjgZ1XMCVfRuhSFg/6wgwUm2eRI3Gi9TXEDS+ibclWVdpEBKi7
 fFePstb5vdXOVTIIO0ZGqja+UbKHx10=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-XdWgEgCvNdmbA_a5GutTeQ-1; Fri, 01 Sep 2023 08:45:09 -0400
X-MC-Unique: XdWgEgCvNdmbA_a5GutTeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28B91380673A
 for <qemu-devel@nongnu.org>; Fri,  1 Sep 2023 12:45:09 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.225.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53B3463F7A;
 Fri,  1 Sep 2023 12:45:08 +0000 (UTC)
From: Bilal Elmoussaoui <belmouss@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Bilal Elmoussaoui <belmouss@redhat.com>
Subject: [PATCH v2] dbus: Properly dispose touch/mouse dbus objects
Date: Fri,  1 Sep 2023 14:45:07 +0200
Message-ID: <20230901124507.94087-1-belmouss@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Signed-off-by: Bilal Elmoussaoui <belmouss@redhat.com>
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


