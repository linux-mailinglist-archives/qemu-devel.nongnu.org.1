Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3D9BCA198
	for <lists+qemu-devel@lfdr.de>; Thu, 09 Oct 2025 18:17:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tJ3-000469-Up; Thu, 09 Oct 2025 12:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v6tIy-00045k-VX
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v6tIr-0000IT-Na
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760026538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WuPH5Qh6mQFk4/8uPVFWAWvAGcYGoIVKTpD4kajmpVI=;
 b=ausPbPqofU5WiY7s3kjL2pPRb+PMuLObZ15y7AIC1wWFyuNOnOXAL0b6g+D5tOLl/V7COm
 15GihTezzv4XzCbpnL2epVVI/45TOzLHSPsFJMd3InYzF/AwJeN7s7jU+PTWFFYztLmsDm
 y9t+uB0xKVmvQJ76GOgJsL8s6+7YRTM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-mQmwuwk4OcKgIIyDXfg6Og-1; Thu,
 09 Oct 2025 12:15:37 -0400
X-MC-Unique: mQmwuwk4OcKgIIyDXfg6Og-1
X-Mimecast-MFC-AGG-ID: mQmwuwk4OcKgIIyDXfg6Og_1760026535
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85417180057D; Thu,  9 Oct 2025 16:15:35 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.224.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 926F41800447; Thu,  9 Oct 2025 16:15:33 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v2 2/2] tests/qtest: Use exit-with-parent=on in qtest
 invocations
Date: Thu,  9 Oct 2025 17:12:47 +0100
Message-ID: <20251009161526.140497-3-rjones@redhat.com>
In-Reply-To: <20251009161526.140497-1-rjones@redhat.com>
References: <20251009161526.140497-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Previously libqtest.c set PR_SET_PDEATHSIG (or the equivalent on
FreeBSD) after forking the qemu subprocess.  However we can get the
same behaviour now by using the new -run-with exit-with-parent=on
flag, on platforms that support it.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 tests/qtest/libqtest.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 933d085869..622464e365 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -33,6 +33,7 @@
 #include "qemu/accel.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu/exit-with-parent.h"
 #include "qemu/sockets.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
@@ -433,24 +434,6 @@ static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args,
 #ifndef _WIN32
     pid = fork();
     if (pid == 0) {
-#ifdef __linux__
-        /*
-         * Although we register a ABRT handler to kill off QEMU
-         * when g_assert() triggers, we want an extra safety
-         * net. The QEMU process might be non-functional and
-         * thus not have responded to SIGTERM. The test script
-         * might also have crashed with SEGV, in which case the
-         * cleanup handlers won't ever run.
-         *
-         * This PR_SET_PDEATHSIG setup will ensure any remaining
-         * QEMU will get terminated with SIGKILL in these cases.
-         */
-        prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
-#endif /* __linux__ */
-#ifdef __FreeBSD__
-        int sig = SIGKILL;
-        procctl(P_PID, getpid(), PROC_PDEATHSIG_CTL, &sig);
-#endif /* __FreeBSD__ */
         execlp("/bin/sh", "sh", "-c", command->str, NULL);
         exit(1);
     }
@@ -482,12 +465,15 @@ gchar *qtest_qemu_args(const char *extra_args)
                       "-display none "
                       "-audio none "
                       "%s"
+                      "%s"
                       " -accel qtest",
 
                       tracearg,
                       socket_path,
                       getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
                       qmp_socket_path,
+                      can_exit_with_parent() ?
+                      "-run-with exit-with-parent=on " : "",
                       extra_args ?: "");
 
     return args;
-- 
2.50.1


