Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11615ADB7B3
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Jun 2025 19:23:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRDWl-0003Wz-Cx; Mon, 16 Jun 2025 13:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRDWj-0003WH-QU
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRDWh-0001t5-11
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750094500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YekXUZ6PIrxV6qVfkSxaz6wtrvKYkehDskjORYVyUug=;
 b=DW/O+RqJV52nUz2b8Y7yw7g5Y6olD3GFZEItpu54wHEVLTUEeq1TwsRCCUng/LTlVO4zPa
 0AnjDOsAUfTWdztvz9nJP7zKJ+MP88SQcr8aeIvRBrAT3dkAfcGcl72NymMYiUzX/MUUbo
 w/uDtPSGNIi4JX7dJblZSi5kqn4+Epk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-U8Q7EVuTPt-P809iHQhs0Q-1; Mon,
 16 Jun 2025 13:21:19 -0400
X-MC-Unique: U8Q7EVuTPt-P809iHQhs0Q-1
X-Mimecast-MFC-AGG-ID: U8Q7EVuTPt-P809iHQhs0Q_1750094477
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FE8318002EC; Mon, 16 Jun 2025 17:21:17 +0000 (UTC)
Received: from localhost (unknown [10.2.16.89])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26364180035C; Mon, 16 Jun 2025 17:21:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 oltolm <oleg.tolmatcev@gmail.com>
Subject: [PULL v3 1/1] meson: fix Windows build
Date: Mon, 16 Jun 2025 13:21:12 -0400
Message-ID: <20250616172112.428142-2-stefanha@redhat.com>
In-Reply-To: <20250616172112.428142-1-stefanha@redhat.com>
References: <20250616172112.428142-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: oltolm <oleg.tolmatcev@gmail.com>

The build fails on Windows. Replace calls to Unix programs like ´cat´,
´sed´ and ´true´ with calls to ´python´ and wrap calls to
´os.path.relpath´ in try-except because it can fail when the two paths
are on different drives. Make sure to convert the Windows paths to Unix
paths to prevent warnings in generated files.

Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
Message-id: 20250612221521.1109-2-oleg.tolmatcev@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/plugins/meson.build         |  2 +-
 plugins/meson.build                 |  2 +-
 scripts/tracetool/__init__.py       | 15 ++++++++++++---
 scripts/tracetool/backend/ftrace.py |  4 +---
 scripts/tracetool/backend/log.py    |  4 +---
 scripts/tracetool/backend/syslog.py |  4 +---
 tests/functional/meson.build        |  2 +-
 tests/include/meson.build           |  2 +-
 tests/tcg/plugins/meson.build       |  2 +-
 trace/meson.build                   |  5 +++--
 10 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index fa8a426c8b..1876bc7843 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -24,7 +24,7 @@ endif
 if t.length() > 0
   alias_target('contrib-plugins', t)
 else
-  run_target('contrib-plugins', command: find_program('true'))
+  run_target('contrib-plugins', command: [python, '-c', ''])
 endif
 
 plugin_modules += t
diff --git a/plugins/meson.build b/plugins/meson.build
index b20edfbabc..62c991d87f 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -33,7 +33,7 @@ if host_os == 'windows'
     input: qemu_plugin_symbols,
     output: 'qemu_plugin_api.def',
     capture: true,
-    command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
+    command: [python, '-c', 'import fileinput, re; print("EXPORTS", end=""); [print(re.sub(r"[{};]", "", line), end="") for line in fileinput.input()]', '@INPUT@'])
 
   # then use dlltool to assemble a delaylib.
   # The delaylib will have an "imaginary" name (qemu.exe), that is used by the
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index bc03238c0f..6dfcbf71e1 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -12,12 +12,14 @@
 __email__      = "stefanha@redhat.com"
 
 
+import os
 import re
 import sys
 import weakref
+from pathlib import PurePath
 
-import tracetool.format
 import tracetool.backend
+import tracetool.format
 
 
 def error_write(*lines):
@@ -36,7 +38,7 @@ def error(*lines):
 
 def out_open(filename):
     global out_filename, out_fobj
-    out_filename = filename
+    out_filename = posix_relpath(filename)
     out_fobj = open(filename, 'wt')
 
 def out(*lines, **kwargs):
@@ -308,7 +310,7 @@ def build(line_str, lineno, filename):
             fmt = [fmt_trans, fmt]
         args = Arguments.build(groups["args"])
 
-        return Event(name, props, fmt, args, lineno, filename)
+        return Event(name, props, fmt, args, lineno, posix_relpath(filename))
 
     def __repr__(self):
         """Evaluable string representation for this object."""
@@ -447,3 +449,10 @@ def generate(events, group, format, backends,
     tracetool.backend.dtrace.PROBEPREFIX = probe_prefix
 
     tracetool.format.generate(events, format, backend, group)
+
+def posix_relpath(path, start=None):
+    try:
+        path = os.path.relpath(path, start)
+    except ValueError:
+        pass
+    return PurePath(path).as_posix()
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index baed2ae61c..5fa30ccc08 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -12,8 +12,6 @@
 __email__      = "stefanha@redhat.com"
 
 
-import os.path
-
 from tracetool import out
 
 
@@ -47,7 +45,7 @@ def generate_h(event, group):
         args=event.args,
         event_id="TRACE_" + event.name.upper(),
         event_lineno=event.lineno,
-        event_filename=os.path.relpath(event.filename),
+        event_filename=event.filename,
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
 
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index de27b7e62e..17ba1cd90e 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -12,8 +12,6 @@
 __email__      = "stefanha@redhat.com"
 
 
-import os.path
-
 from tracetool import out
 
 
@@ -55,7 +53,7 @@ def generate_h(event, group):
         '    }',
         cond=cond,
         event_lineno=event.lineno,
-        event_filename=os.path.relpath(event.filename),
+        event_filename=event.filename,
         name=event.name,
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 012970f6cc..5a3a00fe31 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -12,8 +12,6 @@
 __email__      = "stefanha@redhat.com"
 
 
-import os.path
-
 from tracetool import out
 
 
@@ -43,7 +41,7 @@ def generate_h(event, group):
         '    }',
         cond=cond,
         event_lineno=event.lineno,
-        event_filename=os.path.relpath(event.filename),
+        event_filename=event.filename,
         name=event.name,
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 7faa2b6e3c..158a473c15 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -416,4 +416,4 @@ endforeach
 
 run_target('precache-functional',
            depends: precache_all,
-           command: ['true'])
+           command: [python, '-c', ''])
diff --git a/tests/include/meson.build b/tests/include/meson.build
index 9abba308fa..8e8d1ec4e6 100644
--- a/tests/include/meson.build
+++ b/tests/include/meson.build
@@ -13,4 +13,4 @@ test_qapi_outputs_extra = [
 test_qapi_files_extra = custom_target('QAPI test (include)',
                                       output: test_qapi_outputs_extra,
                                       input: test_qapi_files,
-                                      command: 'true')
+                                      command: [python, '-c', ''])
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 41f02f2c7f..029342282a 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -17,7 +17,7 @@ endif
 if t.length() > 0
   alias_target('test-plugins', t)
 else
-  run_target('test-plugins', command: find_program('true'))
+  run_target('test-plugins', command: [python, '-c', ''])
 endif
 
 plugin_modules += t
diff --git a/trace/meson.build b/trace/meson.build
index 3df4549355..9c42a57a05 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -4,7 +4,7 @@ trace_events_files = []
 foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
   if item in qapi_trace_events
     trace_events_file = item
-    group_name = item.full_path().split('/')[-1].underscorify()
+    group_name = fs.name(item).underscorify()
   else
     trace_events_file = meson.project_source_root() / item / 'trace-events'
     group_name = item == '.' ? 'root' : item.underscorify()
@@ -57,10 +57,11 @@ foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
   endif
 endforeach
 
+cat = [ python, '-c', 'import fileinput; [print(line, end="") for line in fileinput.input()]', '@INPUT@' ]
 trace_events_all = custom_target('trace-events-all',
                                  output: 'trace-events-all',
                                  input: trace_events_files,
-                                 command: [ 'cat', '@INPUT@' ],
+                                 command: cat,
                                  capture: true,
                                  install: get_option('trace_backends') != [ 'nop' ],
                                  install_dir: qemu_datadir)
-- 
2.49.0


