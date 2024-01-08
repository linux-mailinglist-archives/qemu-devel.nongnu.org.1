Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE8D82775C
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:25:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuId-0002xf-Tw; Mon, 08 Jan 2024 13:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIW-0002vQ-9w
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIU-0002oO-P7
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fp482xqDk5BVfbU/+2icy8xz0xAfTqfg+Mjcr9pPtU0=;
 b=HPUhYgeKILHQ9cM5meiD1NSFzWOh489m1OMmttVTFDqIMKsVMQcEMqBPMNre/7ozxDrsqU
 WOcbq/T/RLQfAg8Act64A2C4AlcuKzzQCcNOU+vYv2TtLfPUIOxKeSUSHLA10Vf4uxg/NT
 4VKUD+kG3RKiOCqbLr0t6RK/4cbIDwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-OvudDtHPPTu9fRhxvWSu0g-1; Mon, 08 Jan 2024 13:24:18 -0500
X-MC-Unique: OvudDtHPPTu9fRhxvWSu0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BA95101A555;
 Mon,  8 Jan 2024 18:24:18 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BD613C2E;
 Mon,  8 Jan 2024 18:24:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 08/29] dump: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:44 +0000
Message-ID: <20240108182405.1135436-9-berrange@redhat.com>
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
 dump/dump-hmp-cmds.c | 2 +-
 dump/dump.c          | 2 +-
 dump/win_dump.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
index b428ec33df..68ab383ece 100644
--- a/dump/dump-hmp-cmds.c
+++ b/dump/dump-hmp-cmds.c
@@ -10,7 +10,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-dump.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
 {
diff --git a/dump/dump.c b/dump/dump.c
index 4819050764..237ec0d56d 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -23,7 +23,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-dump.h"
 #include "qapi/qapi-events-dump.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "hw/misc/vmcoreinfo.h"
diff --git a/dump/win_dump.c b/dump/win_dump.c
index b7bfaff379..ad45312b6d 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -12,7 +12,7 @@
 #include "sysemu/dump.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "exec/cpu-defs.h"
 #include "hw/core/cpu.h"
 #include "qemu/win_dump_defs.h"
-- 
2.43.0


