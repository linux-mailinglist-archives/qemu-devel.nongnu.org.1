Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FE777C0DB
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 21:34:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVdJv-0003JI-10; Mon, 14 Aug 2023 15:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qVdJs-0003J8-DM
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 15:33:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qVdJq-0000HU-Tj
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 15:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692041616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xwgU3hSII4zKNB+SJ+1RcqXNHgEGvWowB8r9pmpt1Ho=;
 b=NwXNOCZNRJPKeYZamZoaSS/nS+Xtr8Dn+MCfUX0/RnvBpZq/PRvc75RSrOSm25myCwDCfY
 H32A4LWtMeoezsh4M7VZMsoV2a4Pc+gw+AdatK7JrYeSFEboC0OieFiryt2XC9X3XU7maU
 +OoYKZq/o4eLULQbBX7ThSp5DuwXUu8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-msJp0hXqN8O75rZ42mwGgw-1; Mon, 14 Aug 2023 15:33:34 -0400
X-MC-Unique: msJp0hXqN8O75rZ42mwGgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A80143800520
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 19:33:34 +0000 (UTC)
Received: from localhost (unknown [10.39.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC4F61121314;
 Mon, 14 Aug 2023 19:33:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] qxl: don't assert() if device isn't yet initialized
Date: Mon, 14 Aug 2023 23:33:30 +0400
Message-ID: <20230814193331.375778-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

If the PCI BAR isn't yet mapped or was unmapped, QXL_IO_SET_MODE will
assert(). Instead, report a guest bug and keep going.

This can be reproduced with:

cat << EOF | ./qemu-system-x86_64 -vga qxl -m 2048 -nodefaults -qtest stdio
outl 0xcf8 0x8000101c
outl 0xcfc 0xc000
outl 0xcf8 0x80001001
outl 0xcfc 0x01000000
outl 0xc006 0x00
EOF

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1829

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/qxl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index f1c0eb7dfc..70b73820b2 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1591,7 +1591,10 @@ static void qxl_set_mode(PCIQXLDevice *d, unsigned int modenr, int loadvm)
     }
 
     d->guest_slots[0].slot = slot;
-    assert(qxl_add_memslot(d, 0, devmem, QXL_SYNC) == 0);
+    if (qxl_add_memslot(d, 0, devmem, QXL_SYNC) != 0) {
+        qxl_set_guest_bug(d, "device isn't initialized yet");
+        return;
+    }
 
     d->guest_primary.surface = surface;
     qxl_create_guest_primary(d, 0, QXL_SYNC);
-- 
2.41.0


