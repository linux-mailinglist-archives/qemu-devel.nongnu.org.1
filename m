Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F5C827770
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:27:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIi-0002zS-1j; Mon, 08 Jan 2024 13:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIZ-0002xE-KO
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIV-0002oV-F8
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSmRA9pBj4f57U266OR+IIpTaxocC4MqzrH1Stv76pc=;
 b=AAQU6MzdP+l9OIGYNF7SnSi8szKzECDcKTKoatB4kcMrw0zqeGNpVDIHIoQ5tiWn4hUEKE
 k/xUnzItv+qnQKmAISxPNeAndQ65AmQtp9dw/jsDRg7Ys3LbL4Vliwa0xjtOQEI2SnVeVH
 nehsAeQ5BPvripvWfJ3wIfpj9sRi964=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-LiCB6YP3MsWgqPAb_Ybilg-1; Mon, 08 Jan 2024 13:24:24 -0500
X-MC-Unique: LiCB6YP3MsWgqPAb_Ybilg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1D76185A780;
 Mon,  8 Jan 2024 18:24:24 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DB8D3C2E;
 Mon,  8 Jan 2024 18:24:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 13/29] net: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:49 +0000
Message-ID: <20240108182405.1135436-14-berrange@redhat.com>
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
 net/filter-buffer.c | 2 +-
 net/filter.c        | 2 +-
 net/net-hmp-cmds.c  | 2 +-
 net/net.c           | 4 ++--
 net/slirp.c         | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 283dc9cbe6..c7672cc4ff 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -13,7 +13,7 @@
 #include "qemu/timer.h"
 #include "qemu/iov.h"
 #include "qapi/qapi-builtin-visit.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qom/object.h"
 
 #define TYPE_FILTER_BUFFER "filter-buffer"
diff --git a/net/filter.c b/net/filter.c
index 3335908771..d6330aaefc 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/error-report.h"
 
 #include "net/filter.h"
diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
index 41d326bf5f..e7c55d2787 100644
--- a/net/net-hmp-cmds.c
+++ b/net/net-hmp-cmds.c
@@ -22,7 +22,7 @@
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-commands-net.h"
 #include "qapi/qapi-visit-net.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/config-file.h"
 #include "qemu/help_option.h"
 #include "qemu/option.h"
diff --git a/net/net.c b/net/net.c
index 0520bc1681..4303e11a0f 100644
--- a/net/net.c
+++ b/net/net.c
@@ -36,8 +36,8 @@
 #include "qemu/help_option.h"
 #include "qapi/qapi-commands-net.h"
 #include "qapi/qapi-visit-net.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qdict.h"
+#include "qobject/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
diff --git a/net/slirp.c b/net/slirp.c
index 25b49c4526..4f0c23409a 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -43,7 +43,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "util.h"
 #include "migration/register.h"
 #include "migration/vmstate.h"
-- 
2.43.0


