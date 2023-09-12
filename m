Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2B079CECE
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:49:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0vt-00046D-I0; Tue, 12 Sep 2023 06:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vr-00045z-EB
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vp-0003Lp-65
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLQoj1vul6G8GOSg6lVTQCpllic5KWmQQLQVC+gMxaQ=;
 b=EC/zoGbT9r6Gp+VlG6xOXcNEDltjVspsdSmNYmof2uMRUqhK0B2PgCELFsYcHrmqOf8rBA
 BX/YGneTXmT3n07hxnCPDTg1NNX2uJ+hN/FWiPf6JhjT/3wBdZHCLduOirJRnosLl/SPT9
 xp8bYyvTagXRAk5n0S3uZIKVkb/Wr5o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-i6vLM9ipPRaHfOB0-FmPhw-1; Tue, 12 Sep 2023 06:47:43 -0400
X-MC-Unique: i6vLM9ipPRaHfOB0-FmPhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE7758279A5
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:47:42 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D67D163F9D;
 Tue, 12 Sep 2023 10:47:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 13/14] ui: fix crash when there are no active_console
Date: Tue, 12 Sep 2023 14:46:47 +0400
Message-ID: <20230912104649.1638640-14-marcandre.lureau@redhat.com>
In-Reply-To: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
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

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555888630 in dpy_ui_info_supported (con=0x0) at ../ui/console.c:812
812	    return con->hw_ops->ui_info != NULL;
(gdb) bt
#0  0x0000555555888630 in dpy_ui_info_supported (con=0x0) at ../ui/console.c:812
#1  0x00005555558a44b1 in protocol_client_msg (vs=0x5555578c76c0, data=0x5555581e93f0 <incomplete sequence \373>, len=24) at ../ui/vnc.c:2585
#2  0x00005555558a19ac in vnc_client_read (vs=0x5555578c76c0) at ../ui/vnc.c:1607
#3  0x00005555558a1ac2 in vnc_client_io (ioc=0x5555581eb0e0, condition=G_IO_IN, opaque=0x5555578c76c0) at ../ui/vnc.c:1635

Fixes:
https://issues.redhat.com/browse/RHEL-2600

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Albert Esteve <aesteve@redhat.com>
---
 ui/console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index da341f08da..aa1e09462c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -806,6 +806,9 @@ bool dpy_ui_info_supported(QemuConsole *con)
     if (con == NULL) {
         con = active_console;
     }
+    if (con == NULL) {
+        return false;
+    }
 
     return con->hw_ops->ui_info != NULL;
 }
-- 
2.41.0


