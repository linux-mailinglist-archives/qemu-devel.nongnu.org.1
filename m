Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AC2745690
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEQx-0001Rr-19; Mon, 03 Jul 2023 03:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGEQY-0001RU-Nk
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGEQX-0001BU-9c
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688371012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iuXf9Pot7qbYdSTiSonken0CccC9+gy5177FsvzHD2A=;
 b=JBhWtD1ovxXCrGAXha/0lAAk45l8PAT4Mwf+j8T6hVy+P1sSOeqcf4GVnBV7Qtwz6Ozexe
 +jjoB4mXeNDbAs25IFiI4J8tyaVYsH9h8OAisKy+QOe+n82sfTf9jCyl/t046f2sMR37zE
 7/k8pLnUXRZ1HGL06TOL7Cz9j/tFWfM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-DAsFUQ2XPtyouq1-9Kxx4g-1; Mon, 03 Jul 2023 03:56:50 -0400
X-MC-Unique: DAsFUQ2XPtyouq1-9Kxx4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24EA338294A2;
 Mon,  3 Jul 2023 07:56:50 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE6EF4087C6B;
 Mon,  3 Jul 2023 07:56:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] qemu-options.hx: Fix indentation of some option descriptions
Date: Mon,  3 Jul 2023 09:56:46 +0200
Message-Id: <20230703075646.18354-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The description of the options starts at column 16, so fix
this in some runaway lines for a more uniform output.

While we're at it, replace the capital "NOTE" with "Note"
since this seems to be the more common capitalization in
qemu-options.hx.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-options.hx | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index f49d4c0e3c..c714b3981a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -652,7 +652,7 @@ DEF("m", HAS_ARG, QEMU_OPTION_m,
     "                size: initial amount of guest memory\n"
     "                slots: number of hotplug slots (default: none)\n"
     "                maxmem: maximum amount of guest memory (default: none)\n"
-    "NOTE: Some architectures might enforce a specific granularity\n",
+    "                Note: Some architectures might enforce a specific granularity\n",
     QEMU_ARCH_ALL)
 SRST
 ``-m [size=]megs[,slots=n,maxmem=size]``
@@ -2210,8 +2210,8 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
     "       [,disable-agent-file-xfer=on|off][,agent-mouse=[on|off]]\n"
     "       [,playback-compression=[on|off]][,seamless-migration=[on|off]]\n"
     "       [,gl=[on|off]][,rendernode=<file>]\n"
-    "   enable spice\n"
-    "   at least one of {port, tls-port} is mandatory\n",
+    "                enable spice\n"
+    "                at least one of {port, tls-port} is mandatory\n",
     QEMU_ARCH_ALL)
 #endif
 SRST
-- 
2.39.3


