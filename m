Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 778FA82775A
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:25:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIs-00034g-VT; Mon, 08 Jan 2024 13:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIr-000349-5j
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIp-00031E-MM
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bi/j8zKxb2IuhApQ+mlreZKxH3d/9Gonn4GiSg2hfSo=;
 b=NcQ4ViDaPoaQUrYKEJ/AZYfOUqu/e+LVuOQhTZQPPzRe7+cu/KERSYWAunIJ6YfZF6ATeC
 jF/surUGMrgglPHjYwmYOU/lrv9xn+pzxcRTs70cBuARY6rHPX8CNj7FTWAdGoKcU/WLvH
 xER9g6g5ydZEo9TDE4khlZMzDHAnxEs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-Ws0txIhKOrac0DsIpFWEoA-1; Mon,
 08 Jan 2024 13:24:44 -0500
X-MC-Unique: Ws0txIhKOrac0DsIpFWEoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF0393C0C119;
 Mon,  8 Jan 2024 18:24:42 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E713C3C2E;
 Mon,  8 Jan 2024 18:24:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 27/29] ui: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:24:03 +0000
Message-ID: <20240108182405.1135436-28-berrange@redhat.com>
In-Reply-To: <20240108182405.1135436-1-berrange@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/input-barrier.c | 2 +-
 ui/ui-hmp-cmds.c   | 2 +-
 ui/ui-qmp-cmds.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 2d57ca7079..713392170c 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -21,7 +21,7 @@
 #include "qom/object.h"
 #include "ui/vnc_keysym.h" /* use name2keysym from VNC as we use X11 values */
 #include "qemu/cutils.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "input-barrier.h"
 
 #define TYPE_INPUT_BARRIER "input-barrier"
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 26c8ced1f2..980a8bbc51 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -21,7 +21,7 @@
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/cutils.h"
 #include "ui/console.h"
 #include "ui/input.h"
diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index 74fa6c6ec5..97baf2166d 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -18,7 +18,7 @@
 #include "io/channel-file.h"
 #include "monitor/qmp-helpers.h"
 #include "qapi/qapi-commands-ui.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/coroutine.h"
 #include "qemu/cutils.h"
 #include "trace.h"
-- 
2.43.0


