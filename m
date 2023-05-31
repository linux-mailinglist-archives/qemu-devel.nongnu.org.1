Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D193718A8A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 21:51:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4RoO-000193-EU; Wed, 31 May 2023 15:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4RoM-00018r-E9
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4RoK-0002dU-2B
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685562523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65mEc0ocrW5/8QQ1+7JK5LehvTYH7uTMyUHkd4H2rps=;
 b=C4uH0B4f+RXwcWpDSWkGguse1sxL5bDwPy5GtkemxXlrdf0bcmt1q1ge9Pv1z4CXTkJQ81
 2bL7CAPzhUA5u0TcGJp7+LEpDi30RdvDvTz2yA6p/+Uqbzd+LxEr12gTEsN1byYSFtVc7n
 XVTSXnXRr11cW4/O5qHG9NL3jat6bk8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-IJEWhl8jOAK1sneFFQ2Q9w-1; Wed, 31 May 2023 15:48:37 -0400
X-MC-Unique: IJEWhl8jOAK1sneFFQ2Q9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9980B811E7F;
 Wed, 31 May 2023 19:48:36 +0000 (UTC)
Received: from localhost (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDAE92166B25;
 Wed, 31 May 2023 19:48:35 +0000 (UTC)
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
Subject: [PULL 07/11] trace: remove code that depends on setting vcpu
Date: Wed, 31 May 2023 15:48:11 -0400
Message-Id: <20230531194815.1508961-8-stefanha@redhat.com>
In-Reply-To: <20230531194815.1508961-1-stefanha@redhat.com>
References: <20230531194815.1508961-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Now we no longer have any events that are for vcpus we can start
excising the code from the trace control. As the vcpu parameter is
encoded as part of QMP we just stub out the has_vcpu/vcpu parameters
rather than alter the API.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20230526165401.574474-8-alex.bennee@linaro.org
Message-Id: <20230524133952.3971948-7-alex.bennee@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/control-internal.h |  10 ----
 trace/control-vcpu.h     |  16 ------
 trace/control.h          |  48 -----------------
 hw/core/cpu-common.c     |   2 -
 stubs/trace-control.c    |  13 -----
 trace/control-target.c   | 108 ++++-----------------------------------
 trace/control.c          |  16 ------
 trace/qmp.c              |  74 +++------------------------
 trace/trace-hmp-cmds.c   |  18 ++-----
 9 files changed, 20 insertions(+), 285 deletions(-)

diff --git a/trace/control-internal.h b/trace/control-internal.h
index 0178121720..8d818d359b 100644
--- a/trace/control-internal.h
+++ b/trace/control-internal.h
@@ -25,16 +25,6 @@ static inline uint32_t trace_event_get_id(TraceEvent *ev)
     return ev->id;
 }
 
-static inline uint32_t trace_event_get_vcpu_id(TraceEvent *ev)
-{
-    return 0;
-}
-
-static inline bool trace_event_is_vcpu(TraceEvent *ev)
-{
-    return false;
-}
-
 static inline const char * trace_event_get_name(TraceEvent *ev)
 {
     assert(ev != NULL);
diff --git a/trace/control-vcpu.h b/trace/control-vcpu.h
index 0f98ebe7b5..800fc5a219 100644
--- a/trace/control-vcpu.h
+++ b/trace/control-vcpu.h
@@ -30,13 +30,6 @@
      trace_event_get_vcpu_state_dynamic_by_vcpu_id(                     \
          vcpu, _ ## id ## _EVENT.vcpu_id))
 
-/**
- * trace_event_get_vcpu_state_dynamic:
- *
- * Get the dynamic tracing state of an event for the given vCPU.
- */
-static bool trace_event_get_vcpu_state_dynamic(CPUState *vcpu, TraceEvent *ev);
-
 #include "control-internal.h"
 
 static inline bool
@@ -51,13 +44,4 @@ trace_event_get_vcpu_state_dynamic_by_vcpu_id(CPUState *vcpu,
     }
 }
 
-static inline bool trace_event_get_vcpu_state_dynamic(CPUState *vcpu,
-                                                      TraceEvent *ev)
-{
-    uint32_t vcpu_id;
-    assert(trace_event_is_vcpu(ev));
-    vcpu_id = trace_event_get_vcpu_id(ev);
-    return trace_event_get_vcpu_state_dynamic_by_vcpu_id(vcpu, vcpu_id);
-}
-
 #endif
diff --git a/trace/control.h b/trace/control.h
index 23b8393b29..dfd209edd8 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -89,23 +89,6 @@ static bool trace_event_is_pattern(const char *str);
  */
 static uint32_t trace_event_get_id(TraceEvent *ev);
 
-/**
- * trace_event_get_vcpu_id:
- *
- * Get the per-vCPU identifier of an event.
- *
- * Special value #TRACE_VCPU_EVENT_NONE means the event is not vCPU-specific
- * (does not have the "vcpu" property).
- */
-static uint32_t trace_event_get_vcpu_id(TraceEvent *ev);
-
-/**
- * trace_event_is_vcpu:
- *
- * Whether this is a per-vCPU event.
- */
-static bool trace_event_is_vcpu(TraceEvent *ev);
-
 /**
  * trace_event_get_name:
  *
@@ -172,21 +155,6 @@ static bool trace_event_get_state_dynamic(TraceEvent *ev);
  */
 void trace_event_set_state_dynamic(TraceEvent *ev, bool state);
 
-/**
- * trace_event_set_vcpu_state_dynamic:
- *
- * Set the dynamic tracing state of an event for the given vCPU.
- *
- * Pre-condition: trace_event_get_vcpu_state_static(ev) == true
- *
- * Note: Changes for execution-time events with the 'tcg' property will not be
- *       propagated until the next TB is executed (iff executing in TCG mode).
- */
-void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
-                                        TraceEvent *ev, bool state);
-
-
-
 /**
  * trace_init_backends:
  *
@@ -205,22 +173,6 @@ bool trace_init_backends(void);
  */
 void trace_init_file(void);
 
-/**
- * trace_init_vcpu:
- * @vcpu: Added vCPU.
- *
- * Set initial dynamic event state for a hot-plugged vCPU.
- */
-void trace_init_vcpu(CPUState *vcpu);
-
-/**
- * trace_fini_vcpu:
- * @vcpu: Removed vCPU.
- *
- * Disable dynamic event state for a hot-unplugged vCPU.
- */
-void trace_fini_vcpu(CPUState *vcpu);
-
 /**
  * trace_list_events:
  * @f: Where to send output.
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 951477a7fd..f4e51c8a1b 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -211,7 +211,6 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
     }
 
     /* NOTE: latest generic point where the cpu is fully realized */
-    trace_init_vcpu(cpu);
 }
 
 static void cpu_common_unrealizefn(DeviceState *dev)
@@ -219,7 +218,6 @@ static void cpu_common_unrealizefn(DeviceState *dev)
     CPUState *cpu = CPU(dev);
 
     /* NOTE: latest generic point before the cpu is fully unrealized */
-    trace_fini_vcpu(cpu);
     cpu_exec_unrealizefn(cpu);
 }
 
diff --git a/stubs/trace-control.c b/stubs/trace-control.c
index 7f856e5c24..b428f34c87 100644
--- a/stubs/trace-control.c
+++ b/stubs/trace-control.c
@@ -36,16 +36,3 @@ void trace_event_set_state_dynamic(TraceEvent *ev, bool state)
         }
     }
 }
-
-void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
-                                        TraceEvent *ev, bool state)
-{
-    /* should never be called on non-target binaries */
-    abort();
-}
-
-void trace_init_vcpu(CPUState *vcpu)
-{
-    /* should never be called on non-target binaries */
-    abort();
-}
diff --git a/trace/control-target.c b/trace/control-target.c
index a10752924b..97f21e476d 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -36,112 +36,22 @@ void trace_event_set_state_dynamic_init(TraceEvent *ev, bool state)
 
 void trace_event_set_state_dynamic(TraceEvent *ev, bool state)
 {
-    CPUState *vcpu;
     assert(trace_event_get_state_static(ev));
-    if (trace_event_is_vcpu(ev) && likely(first_cpu != NULL)) {
-        CPU_FOREACH(vcpu) {
-            trace_event_set_vcpu_state_dynamic(vcpu, ev, state);
-        }
-    } else {
-        /*
-         * Without the "vcpu" property, dstate can only be 1 or 0. With it, we
-         * haven't instantiated any vCPU yet, so we will set a global state
-         * instead, and trace_init_vcpu will reconcile it afterwards.
-         */
-        bool state_pre = *ev->dstate;
-        if (state_pre != state) {
-            if (state) {
-                trace_events_enabled_count++;
-                *ev->dstate = 1;
-            } else {
-                trace_events_enabled_count--;
-                *ev->dstate = 0;
-            }
-        }
-    }
-}
 
-static void trace_event_synchronize_vcpu_state_dynamic(
-    CPUState *vcpu, run_on_cpu_data ignored)
-{
-    bitmap_copy(vcpu->trace_dstate, vcpu->trace_dstate_delayed,
-                CPU_TRACE_DSTATE_MAX_EVENTS);
-    tcg_flush_jmp_cache(vcpu);
-}
-
-void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
-                                        TraceEvent *ev, bool state)
-{
-    uint32_t vcpu_id;
-    bool state_pre;
-    assert(trace_event_get_state_static(ev));
-    assert(trace_event_is_vcpu(ev));
-    vcpu_id = trace_event_get_vcpu_id(ev);
-    state_pre = test_bit(vcpu_id, vcpu->trace_dstate);
+    /*
+     * There is no longer a "vcpu" property, dstate can only be 1 or
+     * 0. With it, we haven't instantiated any vCPU yet, so we will
+     * set a global state instead, and trace_init_vcpu will reconcile
+     * it afterwards.
+     */
+    bool state_pre = *ev->dstate;
     if (state_pre != state) {
         if (state) {
             trace_events_enabled_count++;
-            set_bit(vcpu_id, vcpu->trace_dstate_delayed);
-            (*ev->dstate)++;
+            *ev->dstate = 1;
         } else {
             trace_events_enabled_count--;
-            clear_bit(vcpu_id, vcpu->trace_dstate_delayed);
-            (*ev->dstate)--;
-        }
-        if (vcpu->created) {
-            /*
-             * Delay changes until next TB; we want all TBs to be built from a
-             * single set of dstate values to ensure consistency of generated
-             * tracing code.
-             */
-            async_run_on_cpu(vcpu, trace_event_synchronize_vcpu_state_dynamic,
-                             RUN_ON_CPU_NULL);
-        } else {
-            trace_event_synchronize_vcpu_state_dynamic(vcpu, RUN_ON_CPU_NULL);
-        }
-    }
-}
-
-static bool adding_first_cpu1(void)
-{
-    CPUState *cpu;
-    size_t count = 0;
-    CPU_FOREACH(cpu) {
-        count++;
-        if (count > 1) {
-            return false;
-        }
-    }
-    return true;
-}
-
-static bool adding_first_cpu(void)
-{
-    QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
-
-    return adding_first_cpu1();
-}
-
-void trace_init_vcpu(CPUState *vcpu)
-{
-    TraceEventIter iter;
-    TraceEvent *ev;
-    trace_event_iter_init_all(&iter);
-    while ((ev = trace_event_iter_next(&iter)) != NULL) {
-        if (trace_event_is_vcpu(ev) &&
-            trace_event_get_state_static(ev) &&
-            trace_event_get_state_dynamic(ev)) {
-            if (adding_first_cpu()) {
-                /* check preconditions */
-                assert(*ev->dstate == 1);
-                /* disable early-init state ... */
-                *ev->dstate = 0;
-                trace_events_enabled_count--;
-                /* ... and properly re-enable */
-                trace_event_set_vcpu_state_dynamic(vcpu, ev, true);
-            } else {
-                trace_event_set_vcpu_state_dynamic(vcpu, ev, true);
-            }
+            *ev->dstate = 0;
         }
     }
 }
diff --git a/trace/control.c b/trace/control.c
index 5dfb609954..1a48a7e266 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -262,22 +262,6 @@ void trace_init_file(void)
 #endif
 }
 
-void trace_fini_vcpu(CPUState *vcpu)
-{
-    TraceEventIter iter;
-    TraceEvent *ev;
-
-    trace_event_iter_init_all(&iter);
-    while ((ev = trace_event_iter_next(&iter)) != NULL) {
-        if (trace_event_is_vcpu(ev) &&
-            trace_event_get_state_static(ev) &&
-            trace_event_get_vcpu_state_dynamic(vcpu, ev)) {
-            /* must disable to affect the global counter */
-            trace_event_set_vcpu_state_dynamic(vcpu, ev, false);
-        }
-    }
-}
-
 bool trace_init_backends(void)
 {
 #ifdef CONFIG_TRACE_SIMPLE
diff --git a/trace/qmp.c b/trace/qmp.c
index 3b4f4702b4..aa760f1fc4 100644
--- a/trace/qmp.c
+++ b/trace/qmp.c
@@ -13,20 +13,7 @@
 #include "control-vcpu.h"
 
 
-static CPUState *get_cpu(bool has_vcpu, int vcpu, Error **errp)
-{
-    if (has_vcpu) {
-        CPUState *cpu = qemu_get_cpu(vcpu);
-        if (cpu == NULL) {
-            error_setg(errp, "invalid vCPU index %u", vcpu);
-        }
-        return cpu;
-    } else {
-        return NULL;
-    }
-}
-
-static bool check_events(bool has_vcpu, bool ignore_unavailable, bool is_pattern,
+static bool check_events(bool ignore_unavailable, bool is_pattern,
                          const char *name, Error **errp)
 {
     if (!is_pattern) {
@@ -38,12 +25,6 @@ static bool check_events(bool has_vcpu, bool ignore_unavailable, bool is_pattern
             return false;
         }
 
-        /* error for non-vcpu event */
-        if (has_vcpu && !trace_event_is_vcpu(ev)) {
-            error_setg(errp, "event \"%s\" is not vCPU-specific", name);
-            return false;
-        }
-
         /* error for unavailable event */
         if (!ignore_unavailable && !trace_event_get_state_static(ev)) {
             error_setg(errp, "event \"%s\" is disabled", name);
@@ -70,22 +51,13 @@ TraceEventInfoList *qmp_trace_event_get_state(const char *name,
                                               bool has_vcpu, int64_t vcpu,
                                               Error **errp)
 {
-    Error *err = NULL;
     TraceEventInfoList *events = NULL;
     TraceEventIter iter;
     TraceEvent *ev;
     bool is_pattern = trace_event_is_pattern(name);
-    CPUState *cpu;
-
-    /* Check provided vcpu */
-    cpu = get_cpu(has_vcpu, vcpu, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return NULL;
-    }
 
     /* Check events */
-    if (!check_events(has_vcpu, true, is_pattern, name, errp)) {
+    if (!check_events(true, is_pattern, name, errp)) {
         return NULL;
     }
 
@@ -93,33 +65,17 @@ TraceEventInfoList *qmp_trace_event_get_state(const char *name,
     trace_event_iter_init_pattern(&iter, name);
     while ((ev = trace_event_iter_next(&iter)) != NULL) {
         TraceEventInfo *value;
-        bool is_vcpu = trace_event_is_vcpu(ev);
-        if (has_vcpu && !is_vcpu) {
-            continue;
-        }
 
         value = g_new(TraceEventInfo, 1);
-        value->vcpu = is_vcpu;
         value->name = g_strdup(trace_event_get_name(ev));
 
         if (!trace_event_get_state_static(ev)) {
             value->state = TRACE_EVENT_STATE_UNAVAILABLE;
         } else {
-            if (has_vcpu) {
-                if (is_vcpu) {
-                    if (trace_event_get_vcpu_state_dynamic(cpu, ev)) {
-                        value->state = TRACE_EVENT_STATE_ENABLED;
-                    } else {
-                        value->state = TRACE_EVENT_STATE_DISABLED;
-                    }
-                }
-                /* else: already skipped above */
+            if (trace_event_get_state_dynamic(ev)) {
+                value->state = TRACE_EVENT_STATE_ENABLED;
             } else {
-                if (trace_event_get_state_dynamic(ev)) {
-                    value->state = TRACE_EVENT_STATE_ENABLED;
-                } else {
-                    value->state = TRACE_EVENT_STATE_DISABLED;
-                }
+                value->state = TRACE_EVENT_STATE_DISABLED;
             }
         }
         QAPI_LIST_PREPEND(events, value);
@@ -133,21 +89,12 @@ void qmp_trace_event_set_state(const char *name, bool enable,
                                bool has_vcpu, int64_t vcpu,
                                Error **errp)
 {
-    Error *err = NULL;
     TraceEventIter iter;
     TraceEvent *ev;
     bool is_pattern = trace_event_is_pattern(name);
-    CPUState *cpu;
-
-    /* Check provided vcpu */
-    cpu = get_cpu(has_vcpu, vcpu, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
 
     /* Check events */
-    if (!check_events(has_vcpu, has_ignore_unavailable && ignore_unavailable,
+    if (!check_events(has_ignore_unavailable && ignore_unavailable,
                       is_pattern, name, errp)) {
         return;
     }
@@ -155,14 +102,9 @@ void qmp_trace_event_set_state(const char *name, bool enable,
     /* Apply changes (all errors checked above) */
     trace_event_iter_init_pattern(&iter, name);
     while ((ev = trace_event_iter_next(&iter)) != NULL) {
-        if (!trace_event_get_state_static(ev) ||
-            (has_vcpu && !trace_event_is_vcpu(ev))) {
+        if (!trace_event_get_state_static(ev)) {
             continue;
         }
-        if (has_vcpu) {
-            trace_event_set_vcpu_state_dynamic(cpu, ev, enable);
-        } else {
-            trace_event_set_state_dynamic(ev, enable);
-        }
+        trace_event_set_state_dynamic(ev, enable);
     }
 }
diff --git a/trace/trace-hmp-cmds.c b/trace/trace-hmp-cmds.c
index 792876c34a..86211fce27 100644
--- a/trace/trace-hmp-cmds.c
+++ b/trace/trace-hmp-cmds.c
@@ -37,16 +37,10 @@ void hmp_trace_event(Monitor *mon, const QDict *qdict)
 {
     const char *tp_name = qdict_get_str(qdict, "name");
     bool new_state = qdict_get_bool(qdict, "option");
-    bool has_vcpu = qdict_haskey(qdict, "vcpu");
-    int vcpu = qdict_get_try_int(qdict, "vcpu", 0);
     Error *local_err = NULL;
 
-    if (vcpu < 0) {
-        monitor_printf(mon, "argument vcpu must be positive");
-        return;
-    }
-
-    qmp_trace_event_set_state(tp_name, new_state, true, true, has_vcpu, vcpu, &local_err);
+    qmp_trace_event_set_state(tp_name, new_state,
+                              true, true, false, 0, &local_err);
     if (local_err) {
         error_report_err(local_err);
     }
@@ -80,8 +74,6 @@ void hmp_trace_file(Monitor *mon, const QDict *qdict)
 void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
 {
     const char *name = qdict_get_try_str(qdict, "name");
-    bool has_vcpu = qdict_haskey(qdict, "vcpu");
-    int vcpu = qdict_get_try_int(qdict, "vcpu", 0);
     TraceEventInfoList *events;
     TraceEventInfoList *elem;
     Error *local_err = NULL;
@@ -89,12 +81,8 @@ void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
     if (name == NULL) {
         name = "*";
     }
-    if (vcpu < 0) {
-        monitor_printf(mon, "argument vcpu must be positive");
-        return;
-    }
 
-    events = qmp_trace_event_get_state(name, has_vcpu, vcpu, &local_err);
+    events = qmp_trace_event_get_state(name, false, 0, &local_err);
     if (local_err) {
         error_report_err(local_err);
         return;
-- 
2.40.1


