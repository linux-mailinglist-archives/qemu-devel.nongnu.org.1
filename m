Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DBBAAFC32
	for <lists+qemu-devel@lfdr.de>; Thu,  8 May 2025 15:58:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1lw-0002Rn-BR; Thu, 08 May 2025 09:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD1lh-0002DD-HS
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD1lf-00078W-E2
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746712709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/KLw9xGQVavDs7QJT9J6x4l2ZQNPRDznbfV58MS2nr8=;
 b=MBGvf9H9Q4uQ0ERnPQG6Uhrt4baOSJut/mUrGdRGhcwWMD76uvjUphxC8lwyB2PISLsMlE
 KmyH4sdQgfX4vUlqzDwmI/EeZ7Ho8fsp7gjfApYMWclB2jZhEcBCGANnmSxloqjfgf9Qyz
 ozUu25J30TtX0cNu8MKJQwMmz1Cer4A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-Es3T5H0-NCujf65Qq34Gsw-1; Thu,
 08 May 2025 09:58:26 -0400
X-MC-Unique: Es3T5H0-NCujf65Qq34Gsw-1
X-Mimecast-MFC-AGG-ID: Es3T5H0-NCujf65Qq34Gsw_1746712705
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36CCD1800360; Thu,  8 May 2025 13:58:25 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58CFE180049D; Thu,  8 May 2025 13:58:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/10] qapi: expose rtc-reset-reinjection command
 unconditionally
Date: Thu,  8 May 2025 14:58:07 +0100
Message-ID: <20250508135816.673087-2-berrange@redhat.com>
In-Reply-To: <20250508135816.673087-1-berrange@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This removes the TARGET_I386 condition from the rtc-reset-reinjection
command. This requires providing a QMP command stub for non-i386 target.
This in turn requires moving the command out of misc-target.json, since
that will trigger symbol poisoning errors when built from target
independent code.

Rather than putting the command into misc.json, it is proposed to create
misc-$TARGET.json files to hold commands whose impl is conceptually
only applicable to a single target. This gives an obvious docs hint to
consumers that the command is only useful in relation a specific target,
while misc.json is for commands applicable to 2 or more targets.

The current impl of qmp_rtc_reset_reinject() is a no-op if the i386
RTC is disabled in Kconfig, or if the running machine type lack any
RTC device. Thus the stub impl for non-i386 targets retains this
no-op behaviour, instead of reporting a Error which is the more usual
choice for commands invoked against unsupported configurations.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/monitor.c        |  2 +-
 qapi/meson.build         |  1 +
 qapi/misc-i386.json      | 24 ++++++++++++++++++++++++
 qapi/misc-target.json    | 17 -----------------
 qapi/qapi-schema.json    |  1 +
 stubs/meson.build        |  1 +
 stubs/monitor-i386-rtc.c | 10 ++++++++++
 7 files changed, 38 insertions(+), 18 deletions(-)
 create mode 100644 qapi/misc-i386.json
 create mode 100644 stubs/monitor-i386-rtc.c

diff --git a/hw/i386/monitor.c b/hw/i386/monitor.c
index 1921e4d52e..79df96562f 100644
--- a/hw/i386/monitor.c
+++ b/hw/i386/monitor.c
@@ -26,7 +26,7 @@
 #include "monitor/monitor.h"
 #include "qobject/qdict.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc-target.h"
+#include "qapi/qapi-commands-misc-i386.h"
 #include "hw/i386/x86.h"
 #include "hw/rtc/mc146818rtc.h"
 
diff --git a/qapi/meson.build b/qapi/meson.build
index eadde4db30..3a9bd06104 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -64,6 +64,7 @@ if have_system
     'qdev',
     'pci',
     'rocker',
+    'misc-i386',
     'tpm',
     'uefi',
   ]
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
new file mode 100644
index 0000000000..d5bfd91405
--- /dev/null
+++ b/qapi/misc-i386.json
@@ -0,0 +1,24 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+##
+# @rtc-reset-reinjection:
+#
+# This command will reset the RTC interrupt reinjection backlog.  Can
+# be used if another mechanism to synchronize guest time is in effect,
+# for example QEMU guest agent's guest-set-time command.
+#
+# Use of this command is only applicable for x86 machines with an RTC,
+# and on other machines will silently return without performing any
+# action.
+#
+# Since: 2.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "rtc-reset-reinjection" }
+#     <- { "return": {} }
+##
+{ 'command': 'rtc-reset-reinjection' }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 42e4a7417d..5d0ffb0164 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -2,23 +2,6 @@
 # vim: filetype=python
 #
 
-##
-# @rtc-reset-reinjection:
-#
-# This command will reset the RTC interrupt reinjection backlog.  Can
-# be used if another mechanism to synchronize guest time is in effect,
-# for example QEMU guest agent's guest-set-time command.
-#
-# Since: 2.1
-#
-# .. qmp-example::
-#
-#     -> { "execute": "rtc-reset-reinjection" }
-#     <- { "return": {} }
-##
-{ 'command': 'rtc-reset-reinjection',
-  'if': 'TARGET_I386' }
-
 ##
 # @SevState:
 #
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 7bc600bb76..96f6aa4413 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -61,6 +61,7 @@
 { 'include': 'replay.json' }
 { 'include': 'yank.json' }
 { 'include': 'misc.json' }
+{ 'include': 'misc-i386.json' }
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
diff --git a/stubs/meson.build b/stubs/meson.build
index 63392f5e78..9907b54c1e 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -77,6 +77,7 @@ if have_system
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
+  stub_ss.add(files('monitor-i386-rtc.c'))
 endif
 
 if have_system or have_user
diff --git a/stubs/monitor-i386-rtc.c b/stubs/monitor-i386-rtc.c
new file mode 100644
index 0000000000..ee2e60d95b
--- /dev/null
+++ b/stubs/monitor-i386-rtc.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-i386.h"
+
+void qmp_rtc_reset_reinjection(Error **errp)
+{
+    /* Nothing to do since non-x86 machines lack an RTC */
+}
-- 
2.49.0


