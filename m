Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7793C82775B
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:25:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIn-00032o-Dl; Mon, 08 Jan 2024 13:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIj-00030g-Rp
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIi-0002vM-D0
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4kcmPGu+t8UwGePkgpVon37maXV7NJDL3pFZPgDBsrc=;
 b=KzY47JBYaQjgU/mNvtn5rMJ9tK87j0/I08woeXxwKH9xYCAHaC2bdsK35IKl3xM3w+sN9B
 MBnKKIe0CIbZ7Y9L4nqU7xBi0PPg0dP9sW5xyru/QSXc8vdt+FiNm81oWm07PWeJuNeV/K
 6pZ/VAnWHiTqxhF3HBaR26FY4+kmof4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-ncVGhlC1MOKr5B2NnkwgqA-1; Mon,
 08 Jan 2024 13:24:36 -0500
X-MC-Unique: ncVGhlC1MOKr5B2NnkwgqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50A8E3C0C102;
 Mon,  8 Jan 2024 18:24:36 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47A7D3C2E;
 Mon,  8 Jan 2024 18:24:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 22/29] stubs: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:58 +0000
Message-ID: <20240108182405.1135436-23-berrange@redhat.com>
In-Reply-To: <20240108182405.1135436-1-berrange@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 stubs/qmp-command-available.c | 2 +-
 stubs/qmp-quit.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/stubs/qmp-command-available.c b/stubs/qmp-command-available.c
index 46540af7bf..8851faced1 100644
--- a/stubs/qmp-command-available.c
+++ b/stubs/qmp-command-available.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 
 bool qmp_command_available(const QmpCommand *cmd, Error **errp)
 {
diff --git a/stubs/qmp-quit.c b/stubs/qmp-quit.c
index a3ff47f7bd..8fb523e905 100644
--- a/stubs/qmp-quit.c
+++ b/stubs/qmp-quit.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/qapi-commands-control.h"
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 
 void qmp_quit(Error **errp)
 {
-- 
2.43.0


