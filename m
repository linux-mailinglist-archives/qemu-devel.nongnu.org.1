Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E96E718A88
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 21:50:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4RoA-00015I-Ki; Wed, 31 May 2023 15:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4Ro7-00014s-Qo
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4Ro6-0002aH-3e
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685562509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oi+seq7KnOXSMael//8077PMVV9G55+tWTDGQkzuYPg=;
 b=B/aASb5+8EBhr58nNkpHOT9FGHEbQuURp/o8JvGZ0663rPHnZDrRFQXVzFD8eE3l9PusjQ
 koyIdmEog3RSbRE5ulmXPimTWUns4io2eHPo65bUIwC4jhCVh7kmsuGYZFNHzbxIw2uw5Z
 qNW3yYU2BOdaT7g60iJ8QImavXjcLYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-XpNloWxXPs2KerJOOfxhMw-1; Wed, 31 May 2023 15:48:27 -0400
X-MC-Unique: XpNloWxXPs2KerJOOfxhMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41A6C800B35;
 Wed, 31 May 2023 19:48:26 +0000 (UTC)
Received: from localhost (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B545040CFD46;
 Wed, 31 May 2023 19:48:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, libvir-list@redhat.com,
 Greg Kurz <groug@kaod.org>, Yanan Wang <wangyanan55@huawei.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 03/11] trace: remove vcpu_id from the TraceEvent structure
Date: Wed, 31 May 2023 15:48:07 -0400
Message-Id: <20230531194815.1508961-4-stefanha@redhat.com>
In-Reply-To: <20230531194815.1508961-1-stefanha@redhat.com>
References: <20230531194815.1508961-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

This does involve temporarily stubbing out some helper functions
before we excise the rest of the code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20230526165401.574474-4-alex.bennee@linaro.org
Message-Id: <20230524133952.3971948-4-alex.bennee@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/control-internal.h      |  4 ++--
 trace/event-internal.h        |  2 --
 trace/control.c               | 10 ----------
 scripts/tracetool/format/c.py |  6 ------
 scripts/tracetool/format/h.py | 11 +----------
 5 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/trace/control-internal.h b/trace/control-internal.h
index 8b2b50a7cf..0178121720 100644
--- a/trace/control-internal.h
+++ b/trace/control-internal.h
@@ -27,12 +27,12 @@ static inline uint32_t trace_event_get_id(TraceEvent *ev)
 
 static inline uint32_t trace_event_get_vcpu_id(TraceEvent *ev)
 {
-    return ev->vcpu_id;
+    return 0;
 }
 
 static inline bool trace_event_is_vcpu(TraceEvent *ev)
 {
-    return ev->vcpu_id != TRACE_VCPU_EVENT_NONE;
+    return false;
 }
 
 static inline const char * trace_event_get_name(TraceEvent *ev)
diff --git a/trace/event-internal.h b/trace/event-internal.h
index f63500b37e..0c24e01b52 100644
--- a/trace/event-internal.h
+++ b/trace/event-internal.h
@@ -19,7 +19,6 @@
 /**
  * TraceEvent:
  * @id: Unique event identifier.
- * @vcpu_id: Unique per-vCPU event identifier.
  * @name: Event name.
  * @sstate: Static tracing state.
  * @dstate: Dynamic tracing state
@@ -33,7 +32,6 @@
  */
 typedef struct TraceEvent {
     uint32_t id;
-    uint32_t vcpu_id;
     const char * name;
     const bool sstate;
     uint16_t *dstate;
diff --git a/trace/control.c b/trace/control.c
index d24af91004..5dfb609954 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -68,16 +68,6 @@ void trace_event_register_group(TraceEvent **events)
     size_t i;
     for (i = 0; events[i] != NULL; i++) {
         events[i]->id = next_id++;
-        if (events[i]->vcpu_id == TRACE_VCPU_EVENT_NONE) {
-            continue;
-        }
-
-        if (likely(next_vcpu_id < CPU_TRACE_DSTATE_MAX_EVENTS)) {
-            events[i]->vcpu_id = next_vcpu_id++;
-        } else {
-            warn_report("too many vcpu trace events; dropping '%s'",
-                        events[i]->name);
-        }
     }
     event_groups = g_renew(TraceEventGroup, event_groups, nevent_groups + 1);
     event_groups[nevent_groups].events = events;
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index c390c1844a..69edf0d588 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -32,19 +32,13 @@ def generate(events, backend, group):
         out('uint16_t %s;' % e.api(e.QEMU_DSTATE))
 
     for e in events:
-        if "vcpu" in e.properties:
-            vcpu_id = 0
-        else:
-            vcpu_id = "TRACE_VCPU_EVENT_NONE"
         out('TraceEvent %(event)s = {',
             '    .id = 0,',
-            '    .vcpu_id = %(vcpu_id)s,',
             '    .name = \"%(name)s\",',
             '    .sstate = %(sstate)s,',
             '    .dstate = &%(dstate)s ',
             '};',
             event = e.api(e.QEMU_EVENT),
-            vcpu_id = vcpu_id,
             name = e.name,
             sstate = "TRACE_%s_ENABLED" % e.name.upper(),
             dstate = e.api(e.QEMU_DSTATE))
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index e94f0be7da..285d7b03a9 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -74,16 +74,7 @@ def generate(events, backend, group):
 
         out('}')
 
-        # tracer wrapper with checks (per-vCPU tracing)
-        if "vcpu" in e.properties:
-            trace_cpu = next(iter(e.args))[1]
-            cond = "trace_event_get_vcpu_state(%(cpu)s,"\
-                   " TRACE_%(id)s)"\
-                   % dict(
-                       cpu=trace_cpu,
-                       id=e.name.upper())
-        else:
-            cond = "true"
+        cond = "true"
 
         out('',
             'static inline void %(api)s(%(args)s)',
-- 
2.40.1


