Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2705EAB7992
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 01:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFLj1-0001Ly-LK; Wed, 14 May 2025 19:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLiy-0001GL-7O
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLiw-00031o-AR
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2301ac32320so3627345ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 16:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747266077; x=1747870877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDGlYtC2FxMGnGIBYrCy9HdUcV5JJ+RJBA5NGrp/BIQ=;
 b=Va0t89zqwzLZYJY0BtfMW9tghtqy9oLwpBGATVkWBzHSlH2Pqi0E8QWaGrYzQQ/7Hn
 HF4VaUXJ2kgPE472gfwv22g78htDvmjwgqyfIrPB9yMAC7nRYaDL1dhfkpiqG4I5WXVQ
 qgpsDuZ37UobUiH534Y/NxB44r89yP1nw/ALSlsLsPO55oNeQMKQOuIBdWaS+9BzObkY
 +kqCL1Om+I+4ZtQ5umJNeLvmMafcIhLqlzoPFTcEHj/jBS+vOpxy/pbNu3hzb0srnwqS
 RB4QvztSEAj1Aq7idECzjawI15Pk+cInlYj8Yawq9RGutX3+mvpHmyu95n+iJXsMnqo+
 ryJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747266077; x=1747870877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDGlYtC2FxMGnGIBYrCy9HdUcV5JJ+RJBA5NGrp/BIQ=;
 b=iuurA7WEJlIMJvcZ6D6ecjGM2WNBV7EkaIQGmVC3CwqrIDP+GteFirSKBgez5LTO4B
 8qdY+WTswDHdTbK5DvpwM2ESCzsp6b2H93ycjxHkZKSkibZPWT9rnKbeQTnDoskXdFVu
 Gl8IkI4aXw6Dfmkxz6RbefNTul/LmxrYFO9l3l7aqoYnN1EadOWNpvoVxcnUa4K3PDE3
 FgtLmeXfTvBOV1XoogjX5joVz2L2wUqwCJmi/cjXxsVG8RmhH8pj5xPNj8K+65+XRdT5
 cVKGSTiensjp9OuDTINWrk7yNb19sWfN7sEqVqeWpOSLp97g771S1myOupaxCRdfhrBs
 9BjQ==
X-Gm-Message-State: AOJu0YwK6t62MYw1hHtTVWTTMgrUKEt6fjAXQW1SPPvEBMG1LnHeKc7f
 ah7JlYigursaKSRn7+k+VFlowL+IYT/IiCENfA0MoDVEFgFEzscswCVPgxzzllnmebqG+o/G8/D
 HK1Y=
X-Gm-Gg: ASbGncs2u8h6EsQLDSmDqfkyezlt46CKsXaXcMMTGaQOA2x7zAU3CaOASea1eAKKNW8
 Ulvu2Pnluu75bPouSl4506R7snQCHZLhzNFRd0U8P6Q5ux4bD8PKeX07gDLJTQaxOyPbTfWTF8q
 Z29x6Yn+xaPcoCl1s4cJyPgkorpiRFJB9ceTuk9OuBz+LhVYF3P7pVpWnmRUfIg3sX8DTqaDziG
 duIh3j5+ohKXddM5tSvWYI23Be5Apa2OwEgZwQ31RWi2wW2QhqlvBCEq7tsN562qatujm3fajQ6
 pD2qcT6+qprFidPlp03c2P0irW3QY1a9b4HvSOm/673P8QUdiME=
X-Google-Smtp-Source: AGHT+IHyM/gpJyIX3Xy/IINFbrSWWsOXxBIi3Uqtoiqmoc7IAKc/TBL8c5ArdMzpG4hXf6nOjLbXIQ==
X-Received: by 2002:a17:902:ebcd:b0:22e:634b:14ca with SMTP id
 d9443c01a7336-231981736c2mr77258405ad.50.1747266076721; 
 Wed, 14 May 2025 16:41:16 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b4e4sm104583615ad.182.2025.05.14.16.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 16:41:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/12] qapi: expose rtc-reset-reinjection command
 unconditionally
Date: Wed, 14 May 2025 16:40:57 -0700
Message-ID: <20250514234108.3746675-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-i386.json      | 24 ++++++++++++++++++++++++
 qapi/misc-target.json    | 17 -----------------
 qapi/qapi-schema.json    |  1 +
 hw/i386/monitor.c        |  2 +-
 stubs/monitor-i386-rtc.c | 14 ++++++++++++++
 qapi/meson.build         |  1 +
 stubs/meson.build        |  1 +
 7 files changed, 42 insertions(+), 18 deletions(-)
 create mode 100644 qapi/misc-i386.json
 create mode 100644 stubs/monitor-i386-rtc.c

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
new file mode 100644
index 00000000000..d5bfd91405e
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
index 42e4a7417dc..5d0ffb0164f 100644
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
index 7bc600bb768..96f6aa44133 100644
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
diff --git a/hw/i386/monitor.c b/hw/i386/monitor.c
index 1921e4d52e9..79df96562f6 100644
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
 
diff --git a/stubs/monitor-i386-rtc.c b/stubs/monitor-i386-rtc.c
new file mode 100644
index 00000000000..e78757b24f2
--- /dev/null
+++ b/stubs/monitor-i386-rtc.c
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-i386.h"
+
+void qmp_rtc_reset_reinjection(Error **errp)
+{
+    /*
+     * Use of this command is only applicable for x86 machines with an RTC,
+     * and on other machines will silently return without performing any
+     * action.
+     */
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index eadde4db307..3a9bd061047 100644
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
diff --git a/stubs/meson.build b/stubs/meson.build
index 63392f5e785..9907b54c1e6 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -77,6 +77,7 @@ if have_system
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
+  stub_ss.add(files('monitor-i386-rtc.c'))
 endif
 
 if have_system or have_user
-- 
2.47.2


