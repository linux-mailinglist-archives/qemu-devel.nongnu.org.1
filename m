Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21960B0CAC2
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Jul 2025 20:58:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udvhC-00019p-E0; Mon, 21 Jul 2025 14:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udvfI-0008Uz-Pq
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udvfG-0001QP-GB
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753124104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mnOnAh6e29Z6Rpm7WVvEcJlMExGHcMCYmqWbz5RxB+4=;
 b=FjCF5IVxOuWJ0rRun7FbAQby2O+V+bzWj/3LJutpUckJHq0Fe1HxFNG0509VYkMJQ0mF+q
 KWd9LLjLQzKF5Bri8Jnz1Z9bGOR4reVsuoKv/dZ9DSpS6aeZGPo1Z4ttPYCgTZtqmoHlI3
 F5WjjNVMshX9dA6A1o+GwaYF5fmIaNU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-qZrK4HeqPm-8pI-BbQMSaw-1; Mon,
 21 Jul 2025 14:54:56 -0400
X-MC-Unique: qZrK4HeqPm-8pI-BbQMSaw-1
X-Mimecast-MFC-AGG-ID: qZrK4HeqPm-8pI-BbQMSaw_1753124095
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C66C21956089; Mon, 21 Jul 2025 18:54:55 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.213])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 628761956094; Mon, 21 Jul 2025 18:54:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] log: make '-msg timestamp=on' apply to all qemu_log usage
Date: Mon, 21 Jul 2025 19:54:52 +0100
Message-ID: <20250721185452.3016488-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Currently the tracing 'log' back emits special code to add timestamps
to trace points sent via qemu_log(). This current impl is a bad design
for a number of reasons.

 * It changes the QEMU headers, such that 'error-report.h' content
   is visible to all files using tracing, but only when the 'log'
   backend is enabled. This has led to build failure bugs as devs
   rarely test without the (default) 'log' backend enabled, and
   CI can't cover every scenario for every trace backend.

 * It bloats the trace points definitions which are inlined into
   every probe location due to repeated inlining of timestamp
   formatting code, adding MBs of overhead to QEMU.

 * The tracing subsystem should not be treated any differently
   from other users of qemu_log. They all would benefit from
   having timestamps present.

 * The timestamp emitted with the tracepoints is in a needlessly
   different format to that used by error_report() in response
   to '-msg timestamp=on'.

This fixes all these issues simply by moving timestamp formatting
into qemu_log, using the same approach as for error_report.

The code before:

  static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * creds, const char * filename, const char * path)
  {
      if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu_loglevel_mask(LOG_TRACE)) {
          if (message_with_timestamp) {
              struct timeval _now;
              gettimeofday(&_now, NULL);
              qemu_log("%d@%zu.%06zu:qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n",
                       qemu_get_thread_id(),
                       (size_t)_now.tv_sec, (size_t)_now.tv_usec
                       , creds, filename, path);
          } else {
              qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n", creds, filename, path);
          }
      }
  }

and after:

  static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * creds, const char * filename, const char * path)
  {
      if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu_loglevel_mask(LOG_TRACE)) {
          qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n", creds, filename, path);
      }
  }

The log and error messages before:

  $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=tls0,dir=$HOME/tls -msg timestamp=on
  2986097@1753122905.917608:qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55d925bd9490 dir=/var/home/berrange/tls
  2986097@1753122905.917621:qcrypto_tls_creds_get_path TLS creds path creds=0x55d925bd9490 filename=ca-cert.pem path=<none>
  2025-07-21T18:35:05.917626Z qemu-system-x86_64: Unable to access credentials /var/home/berrange/tls/ca-cert.pem: No such file or directory

and after:

  $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=tls0,dir=$HOME/tls -msg timestamp=on
  2025-07-21T18:43:28.089797Z qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55bf5bf12380 dir=/var/home/berrange/tls
  2025-07-21T18:43:28.089815Z qcrypto_tls_creds_get_path TLS creds path creds=0x55bf5bf12380 filename=ca-cert.pem path=<none>
  2025-07-21T18:43:28.089819Z qemu-system-x86_64: Unable to access credentials /var/home/berrange/tls/ca-cert.pem: No such file or directory

The binary size before:

  $ ls -alh qemu-system-x86_64
  -rwxr-xr-x. 1 berrange berrange 87M Jul 21 19:39 qemu-system-x86_64
  $ strip qemu-system-x86_64
  $ ls -alh qemu-system-x86_64
  -rwxr-xr-x. 1 berrange berrange 30M Jul 21 19:39 qemu-system-x86_64

and after:

  $ ls -alh qemu-system-x86_64
  -rwxr-xr-x. 1 berrange berrange 85M Jul 21 19:41 qemu-system-x86_64
  $ strip qemu-system-x86_64
  $ ls -alh qemu-system-x86_64
  -rwxr-xr-x. 1 berrange berrange 29M Jul 21 19:41 qemu-system-x86_64

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/tracetool/backend/log.py | 14 +-------------
 util/log.c                       | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 17ba1cd90e..bd6739ae41 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -20,7 +20,6 @@
 
 def generate_h_begin(events, group):
     out('#include "qemu/log-for-trace.h"',
-        '#include "qemu/error-report.h"',
         '')
 
 
@@ -36,20 +35,9 @@ def generate_h(event, group):
         cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
     out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
-        '        if (message_with_timestamp) {',
-        '            struct timeval _now;',
-        '            gettimeofday(&_now, NULL);',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
-        '                     qemu_get_thread_id(),',
-        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec',
-        '                     %(argnames)s);',
+        '        qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '        } else {',
-        '#line %(event_lineno)d "%(event_filename)s"',
-        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
-        '#line %(out_next_lineno)d "%(out_filename)s"',
-        '        }',
         '    }',
         cond=cond,
         event_lineno=event.lineno,
diff --git a/util/log.c b/util/log.c
index 58d24de48a..abdcb6b311 100644
--- a/util/log.c
+++ b/util/log.c
@@ -145,10 +145,28 @@ void qemu_log_unlock(FILE *logfile)
 
 void qemu_log(const char *fmt, ...)
 {
-    FILE *f = qemu_log_trylock();
+    FILE *f;
+    g_autofree const char *timestr = NULL;
+
+    /*
+     * Prepare the timestamp *outside* the logging
+     * lock so it better reflects when the message
+     * was emitted if we are delayed acquiring the
+     * mutex
+     */
+    if (message_with_timestamp) {
+        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
+        timestr = g_date_time_format_iso8601(dt);
+    }
+
+    f = qemu_log_trylock();
     if (f) {
         va_list ap;
 
+        if (timestr) {
+            fprintf(f, "%s ", timestr);
+        }
+
         va_start(ap, fmt);
         vfprintf(f, fmt, ap);
         va_end(ap);
-- 
2.50.1


