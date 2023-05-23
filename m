Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 675B870DD02
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RTc-0007kQ-6K; Tue, 23 May 2023 08:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RTJ-0007aw-Uu
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RT9-0005LU-M2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f60e730bf2so3197025e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684846205; x=1687438205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfEBcaH7nHVbR9/kVEtwz57fQNKQfXGJzuARtAmZ4qk=;
 b=m2Ay31MkZ89gbFGEDNbljK85TztuW4/742lD0QhZHKfW01CEFVzipl5Ic9Bk2GZJEB
 3O+DLIiL4l10b3P5OElsAY7LUtTBvO+BuQ6xM+HvVVV7Nqe+uBTgvkDR1r+Qm1RZ/fiH
 7pRyi53M/wm8UOyL8QmBzSdF/o0s3nAxJT7A2822rnPNU/ThPeOgsS/k3xxnZfk1EQ0f
 NiVttzJJj9PRn50xK/DWBXH/VLs+KeHXjaBucGWpHI1/HsHRm/7qshig/KCUywZmH9CH
 8/2l/TDLOgEHWnlQug2zytCcFYugCwY0/K+G5Ud8pjxpna6hpiYoky/zxlRAgMeA65o7
 c0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846205; x=1687438205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfEBcaH7nHVbR9/kVEtwz57fQNKQfXGJzuARtAmZ4qk=;
 b=IIeY9j+4+O5M/DQldE7/XuZqzqU4BaWGVXtteTpOrjFZCRNyO/epd8LZrpBrUyc2Fn
 SOiYfGQ3VPIfg4U61+Lp2aEj36jjH/0//6Lc/b0EqLo4Js/J1Mp0NXjAhWiJVPdX4Axs
 f9GtHlrBnuSGRR0OTOthPGQKubQeVlxVs9FeFC8E1wIK+p398k5jldDddh6ZzTzxIm3F
 6rk5Gv+Y5D4+jSH+HAlG2MEjC/JQpFpearGC8I7YrbHBxPxmSa10GwhLvdrqx8r0UC+l
 upZW9n9X5U6cMYr2lD/PmT5LSb0J29KW2qQwxXa5E1/XHl0FyLmKfx3rJe6/Z97E+p0x
 wWpA==
X-Gm-Message-State: AC+VfDwZJHAoj6t63BRv6J/lfuafvEMKGOX3RHgXECvGMbbwRuL+Eylv
 YjUunoqnJH0q6uSPQ1ajFT3kHA==
X-Google-Smtp-Source: ACHHUZ7Nj+w3cMgsojQP5Z7Kt2KMD55dA68Zm5YROk8ajtscJHDy7wX3ZKapxPjljcWZT/6tbvgYuA==
X-Received: by 2002:adf:df81:0:b0:306:2f91:302e with SMTP id
 z1-20020adfdf81000000b003062f91302emr12455082wrl.21.1684846204835; 
 Tue, 23 May 2023 05:50:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y11-20020adfd08b000000b002fae7408544sm8875672wrh.108.2023.05.23.05.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:50:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AC99B1FFC1;
 Tue, 23 May 2023 13:50:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Eric Blake <eblake@redhat.com>,
 libvir-list@redhat.com, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 06/10] trace: remove code that depends on setting vcpu
Date: Tue, 23 May 2023 13:49:56 +0100
Message-Id: <20230523125000.3674739-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523125000.3674739-1-alex.bennee@linaro.org>
References: <20230523125000.3674739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Now we no longer have any events that are for vcpus we can start
excising the code from the trace control. As the vcpu parameter is
encoded as part of QMP we just stub out the has_vcpu/vcpu parameters
rather than alter the API.

Message-Id: <20230420150009.1675181-7-alex.bennee@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230503091756.1453057-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230505155336.137393-7-alex.bennee@linaro.org>
---
 trace/control-internal.h |  10 ----
 trace/control-vcpu.h     |  16 ------
 trace/control.h          |  48 -----------------
 hw/core/cpu-common.c     |   2 -
 stubs/trace-control.c    |  13 -----
 trace/control-target.c   | 108 ++++-----------------------------------
 trace/control.c          |  16 ------
 trace/qmp.c              |  74 +++------------------------
 trace/trace-hmp-cmds.c   |  17 +-----
 9 files changed, 19 insertions(+), 285 deletions(-)

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
index 792876c34a..1d07672cb2 100644
--- a/trace/trace-hmp-cmds.c
+++ b/trace/trace-hmp-cmds.c
@@ -37,16 +37,9 @@ void hmp_trace_event(Monitor *mon, const QDict *qdict)
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
+    qmp_trace_event_set_state(tp_name, new_state, true, true, false, 0, &local_err);
     if (local_err) {
         error_report_err(local_err);
     }
@@ -80,8 +73,6 @@ void hmp_trace_file(Monitor *mon, const QDict *qdict)
 void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
 {
     const char *name = qdict_get_try_str(qdict, "name");
-    bool has_vcpu = qdict_haskey(qdict, "vcpu");
-    int vcpu = qdict_get_try_int(qdict, "vcpu", 0);
     TraceEventInfoList *events;
     TraceEventInfoList *elem;
     Error *local_err = NULL;
@@ -89,12 +80,8 @@ void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
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
2.39.2


