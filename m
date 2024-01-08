Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1684827763
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:25:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIY-0002wI-AV; Mon, 08 Jan 2024 13:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIT-0002uW-70
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIO-0002lj-Lx
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fETAYc4DYUmwh2NhyKGIK3+72EFckTovEikvtxcD/o=;
 b=ZOxPhF0eNw/eFGMQiO8GAuNhj5taS6nDEZskC8huLrSD81MfP997wKDPKgDJ3Ww/qfsWGg
 pr1UAHPu/ubsKafCnMJTsvG2DawWuUaRLRJC6FXKnqYki6//DNcSwQT7YRHYzeVC2st9t4
 eH0EHMS9LHuAQXHCn987yeoOtpq7RrU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-jfQTz4DhPNGOXQuL00b3eA-1; Mon, 08 Jan 2024 13:24:16 -0500
X-MC-Unique: jfQTz4DhPNGOXQuL00b3eA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BB008996E5;
 Mon,  8 Jan 2024 18:24:16 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5E173C2E;
 Mon,  8 Jan 2024 18:24:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 06/29] chardev: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:42 +0000
Message-ID: <20240108182405.1135436-7-berrange@redhat.com>
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
 chardev/char-fe.c       | 2 +-
 chardev/char-hmp-cmds.c | 2 +-
 chardev/char.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 7789f7be9c..6eb1a0e67e 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "sysemu/replay.h"
 
 #include "chardev/char-fe.h"
diff --git a/chardev/char-hmp-cmds.c b/chardev/char-hmp-cmds.c
index 287c2b1bcd..8e9e1c1c02 100644
--- a/chardev/char-hmp-cmds.c
+++ b/chardev/char-hmp-cmds.c
@@ -19,7 +19,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 
diff --git a/chardev/char.c b/chardev/char.c
index 996a024c7a..f9c96e7ff7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -32,7 +32,7 @@
 #include "chardev/char.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
 #include "qemu/module.h"
-- 
2.43.0


