Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C29B1BB47
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Aug 2025 22:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujNtC-0007Zq-T7; Tue, 05 Aug 2025 16:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujNt8-0007ZJ-8d
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujNt6-0003oB-Gn
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754424235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWpHY7mQPRkhHLYyZnowaJ8hbg6MdctAvHhf+83bi6s=;
 b=BZMDWTAKnA1UckN2tZOrSV1bbiDz39zdGZjARGfh9FzH0GvpuOxAWSElvzrCJg7BR7LKRW
 KPofz93WSYeOlRvnzV6YQYZdb46LD6lBQna3i8nh6erttUwZeEMEX1m1SZRg+apW3sepHz
 3e+xd9b2X1x9Ye+ZqmkRKiQWa8d8l/s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-d_lbubS_OF-LfrylBa6www-1; Tue,
 05 Aug 2025 16:03:53 -0400
X-MC-Unique: d_lbubS_OF-LfrylBa6www-1
X-Mimecast-MFC-AGG-ID: d_lbubS_OF-LfrylBa6www_1754424232
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A32171936D89; Tue,  5 Aug 2025 20:03:52 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.80])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1443C3000199; Tue,  5 Aug 2025 20:03:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/6] tracetool: include SPDX-License-Identifier in generated
 files
Date: Tue,  5 Aug 2025 21:03:32 +0100
Message-ID: <20250805200334.629493-5-berrange@redhat.com>
In-Reply-To: <20250805200334.629493-1-berrange@redhat.com>
References: <20250805200334.629493-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

While these files are auto-generated, a later commit will add
reference output to git, so having SPDX-License-Identifier is
desirable.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.50.1


