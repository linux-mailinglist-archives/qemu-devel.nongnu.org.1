Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A0DB2CDCC
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Aug 2025 22:28:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSw1-00049P-Fm; Tue, 19 Aug 2025 16:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSvz-00048m-Kz
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSvy-0006Tm-4M
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755635273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JngSOVRcj7j3a39al930RGL/WH5Ch8VPH2AvafffrI=;
 b=SdediuHbj7J7iO2UTUzwncrbQ+QNwanKL3W1yXCUT9uDQs6M/XXy5pwIhj362Mz8FCzjkC
 vIJmQ6mwoFW+VhjuqpLkCY8lfv/vRnrOAO6aEu7fSLDUu2zsL0N791ENw6TaidkAgmHDss
 UIZMn2ZMOjlpk2lPFpDzKKlEnRPT0i0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-LOfRCt73OmiFuMIQOJCVZA-1; Tue,
 19 Aug 2025 16:27:51 -0400
X-MC-Unique: LOfRCt73OmiFuMIQOJCVZA-1
X-Mimecast-MFC-AGG-ID: LOfRCt73OmiFuMIQOJCVZA_1755635270
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0BAC19560B0; Tue, 19 Aug 2025 20:27:49 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.237])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D84319560B0; Tue, 19 Aug 2025 20:27:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, devel@lists.libvirt.org,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 07/12] util: introduce common helper for error-report & log
 code
Date: Tue, 19 Aug 2025 21:27:03 +0100
Message-ID: <20250819202708.1185594-8-berrange@redhat.com>
In-Reply-To: <20250819202708.1185594-1-berrange@redhat.com>
References: <20250819202708.1185594-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The error-report and log code both have a need to add prefixes
to messages they are printing, with the current example being
a timestamp.

The format and configuration they use should be consistent, so
providing a common helper will ensure this is always the case.
Initially the helper only emits a timestamp, but future patches
will expand this.

This takes the liberty of assigning the new file to the same
maintainer as the existing error-report.c file, given it will
be extracting some functionality from the latter.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS            |  2 ++
 include/qemu/message.h | 40 ++++++++++++++++++++++++++++++++++++++++
 util/meson.build       |  1 +
 util/message.c         | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)
 create mode 100644 include/qemu/message.h
 create mode 100644 util/message.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed76..3cc6c0b409 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3169,9 +3169,11 @@ M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: include/qapi/error.h
 F: include/qemu/error-report.h
+F: include/qemu/message.h
 F: qapi/error.json
 F: util/error.c
 F: util/error-report.c
+F: util/message.c
 F: scripts/coccinelle/err-bad-newline.cocci
 F: scripts/coccinelle/error-use-after-free.cocci
 F: scripts/coccinelle/error_propagate_null.cocci
diff --git a/include/qemu/message.h b/include/qemu/message.h
new file mode 100644
index 0000000000..160bee8417
--- /dev/null
+++ b/include/qemu/message.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef QEMU_MESSAGE_H
+#define QEMU_MESSAGE_H
+
+enum QMessageFormatFlags {
+    QMESSAGE_FORMAT_TIMESTAMP = (1 << 0),
+};
+
+/*
+ * qmessage_set_format:
+ * @flags: the message information to emit
+ *
+ * Select which pieces of information to
+ * emit for messages
+ */
+void qmessage_set_format(int flags);
+
+enum QMessageContextFlags {
+    QMESSAGE_CONTEXT_SKIP_MONITOR = (1 << 0),
+};
+
+/*
+ * qmessage_context:
+ * @flags: the message formatting control flags
+ *
+ * Format a message prefix with the information
+ * previously selected by a call to
+ * qmessage_set_format.
+ *
+ * If @flags contains QMESSAGE_CONTEXT_SKIP_MONITOR
+ * an empty string will be returned if running in
+ * the context of a HMP command
+ *
+ * Returns: a formatted message prefix, or empty string;
+ * to be freed by the caller.
+ */
+char *qmessage_context(int flags);
+
+#endif /* QEMU_MESSAGE_H */
diff --git a/util/meson.build b/util/meson.build
index 35029380a3..f5365e3b4f 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -40,6 +40,7 @@ util_ss.add(files('host-utils.c'))
 util_ss.add(files('bitmap.c', 'bitops.c'))
 util_ss.add(files('fifo8.c'))
 util_ss.add(files('cacheflush.c'))
+util_ss.add(files('message.c'))
 util_ss.add(files('error.c', 'error-report.c'))
 util_ss.add(files('qemu-print.c'))
 util_ss.add(files('id.c'))
diff --git a/util/message.c b/util/message.c
new file mode 100644
index 0000000000..4c7eeb75e2
--- /dev/null
+++ b/util/message.c
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+
+#include "qemu/message.h"
+#include "monitor/monitor.h"
+
+static int message_format;
+
+void qmessage_set_format(int flags)
+{
+    message_format = flags;
+}
+
+char *qmessage_context(int flags)
+{
+    g_autofree char *timestr = NULL;
+
+    if ((flags & QMESSAGE_CONTEXT_SKIP_MONITOR) &&
+        monitor_cur()) {
+        return g_strdup("");
+    }
+
+    if (message_format & QMESSAGE_FORMAT_TIMESTAMP) {
+        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
+        timestr = g_date_time_format_iso8601(dt);
+    }
+
+    return g_strdup_printf("%s%s",
+                           timestr ? timestr : "",
+                           timestr ? " " : "");
+}
-- 
2.50.1


