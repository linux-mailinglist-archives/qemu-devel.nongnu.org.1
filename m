Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE9AB490C3
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 16:09:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvcWq-0001aD-KQ; Mon, 08 Sep 2025 10:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvcWh-0001S9-Lw
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvcWV-00079l-Nr
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757340426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5E56q+jn2RPzB8CXErjNnuAeVqNwohx4m4KK35mg6/k=;
 b=WkBCdNK2qXCrsFAY2/8Wg5ffKYzCaumr9J8a7l+IA5GlBTRiCUrdsh/3hs57SMmDTg4mDs
 2iBZiBbUpUusFHXKmDYGUcUQZFsJxIX/1U6DVq1/9+vcSJmYZtiCQmv28bXVeCUUzb1bX/
 SYtxP30FTY+EBYd5N0102M5nS6Udep0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-Kk4e_yjPNCmNPA6VPEc0SQ-1; Mon,
 08 Sep 2025 10:07:05 -0400
X-MC-Unique: Kk4e_yjPNCmNPA6VPEc0SQ-1
X-Mimecast-MFC-AGG-ID: Kk4e_yjPNCmNPA6VPEc0SQ_1757340423
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4EB51800578; Mon,  8 Sep 2025 14:07:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F20130001A4; Mon,  8 Sep 2025 14:07:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Michael Roth <michael.roth@amd.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 4/8] tracetool: include SPDX-License-Identifier in generated
 files
Date: Mon,  8 Sep 2025 10:06:48 -0400
Message-ID: <20250908140653.170707-5-stefanha@redhat.com>
In-Reply-To: <20250908140653.170707-1-stefanha@redhat.com>
References: <20250908140653.170707-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

While these files are auto-generated, a later commit will add
reference output to git, so having SPDX-License-Identifier is
desirable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20250819161053.464641-5-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/format/c.py                | 1 +
 scripts/tracetool/format/d.py                | 3 ++-
 scripts/tracetool/format/h.py                | 1 +
 scripts/tracetool/format/log_stap.py         | 1 +
 scripts/tracetool/format/simpletrace_stap.py | 1 +
 scripts/tracetool/format/stap.py             | 1 +
 scripts/tracetool/format/ust_events_c.py     | 1 +
 scripts/tracetool/format/ust_events_h.py     | 1 +
 8 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 7aa51cd41a..e473fb6c6e 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -22,6 +22,7 @@ def generate(events, backend, group):
     header = "trace-" + group + ".h"
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
+        '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '',
         '#include "qemu/osdep.h"',
         '#include "qemu/module.h"',
diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index ebfb714200..a5e096e214 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -39,7 +39,8 @@ def generate(events, backend, group):
     if not events and platform != "darwin":
         return
 
-    out('/* This file is autogenerated by tracetool, do not edit. */'
+    out('/* This file is autogenerated by tracetool, do not edit. */',
+        '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '',
         'provider qemu {')
 
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index ea126b07ea..a00ae475f7 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -19,6 +19,7 @@ def generate(events, backend, group):
     header = "trace/control.h"
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
+        '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '',
         '#ifndef TRACE_%s_GENERATED_TRACERS_H' % group.upper(),
         '#define TRACE_%s_GENERATED_TRACERS_H' % group.upper(),
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index b49afababd..710d62bffe 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -88,6 +88,7 @@ def c_fmt_to_stap(fmt):
 
 def generate(events, backend, group):
     out('/* This file is autogenerated by tracetool, do not edit. */',
+        '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '')
 
     for event_id, e in enumerate(events):
diff --git a/scripts/tracetool/format/simpletrace_stap.py b/scripts/tracetool/format/simpletrace_stap.py
index 4f4633b4e6..72971133bf 100644
--- a/scripts/tracetool/format/simpletrace_stap.py
+++ b/scripts/tracetool/format/simpletrace_stap.py
@@ -22,6 +22,7 @@ def global_var_name(name):
 
 def generate(events, backend, group):
     out('/* This file is autogenerated by tracetool, do not edit. */',
+        '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '')
 
     for event_id, e in enumerate(events):
diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
index a218b0445c..4d77fbc11a 100644
--- a/scripts/tracetool/format/stap.py
+++ b/scripts/tracetool/format/stap.py
@@ -38,6 +38,7 @@ def generate(events, backend, group):
               if "disable" not in e.properties]
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
+        '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '')
 
     for e in events:
diff --git a/scripts/tracetool/format/ust_events_c.py b/scripts/tracetool/format/ust_events_c.py
index deced9533d..569754a304 100644
--- a/scripts/tracetool/format/ust_events_c.py
+++ b/scripts/tracetool/format/ust_events_c.py
@@ -20,6 +20,7 @@ def generate(events, backend, group):
               if "disabled" not in e.properties]
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
+        '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '',
         '#include "qemu/osdep.h"',
         '',
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index b99fe6896b..2a31fefeca 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -25,6 +25,7 @@ def generate(events, backend, group):
         include = "trace-ust.h"
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
+        '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '',
         '#undef TRACEPOINT_PROVIDER',
         '#define TRACEPOINT_PROVIDER qemu',
-- 
2.51.0


