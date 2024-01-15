Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6907282D65C
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:52:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJd1-0006Ds-F7; Mon, 15 Jan 2024 04:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rPJcx-00069C-Kd
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:51:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rPJcw-0002qx-06
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705312288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DvwmNHCQyt34NpybuLwlaeryZi7wm7zvb0vdyD5HB74=;
 b=FoARwMRqZY27B5qFdZSqL38I7ch9bdQ8qRq0IUhyiIDLRZ3DuTl5Z5ZRXqmwZIS+0Ldv0N
 0O+kcz2ADTN62fDVriwp4lNdGjHyoeEyu6QdQH41PwfKGUg1ticZz80+cd6oC5uDSM7DhX
 0StjSyPrKH+OtZwBOvO2lDw9i5vC2tc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-uIPGQWqGMHCiuI-ekJBkJw-1; Mon, 15 Jan 2024 04:51:21 -0500
X-MC-Unique: uIPGQWqGMHCiuI-ekJBkJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C73E8371C8;
 Mon, 15 Jan 2024 09:51:21 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF7BD1C060B2;
 Mon, 15 Jan 2024 09:51:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>, Markus Frank <m.frank@proxmox.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] ui: reject extended clipboard message if not activated
Date: Mon, 15 Jan 2024 09:51:19 +0000
Message-ID: <20240115095119.654271-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

The extended clipboard message protocol requires that the client
activate the extension by requesting a psuedo encoding. If this
is not done, then any extended clipboard messages from the client
should be considered invalid and the client dropped.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

The need for fix was identified as part of investigation for
CVE-2023-6683. This does NOT, however, fix that CVE as it only
addresses one of the problem codepaths that can trigger that
CVE.

 ui/vnc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 4f23a0fa79..3b2c71e653 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2445,6 +2445,11 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
         }
 
         if (read_s32(data, 4) < 0) {
+            if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_EXT)) {
+                error_report("vnc: extended clipboard message while disabled");
+                vnc_client_error(vs);
+                break;
+            }
             if (dlen < 4) {
                 error_report("vnc: malformed payload (header less than 4 bytes)"
                              " in extended clipboard pseudo-encoding.");
-- 
2.43.0


