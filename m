Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C78DC70F7DE
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 15:41:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1oih-0008D3-Mv; Wed, 24 May 2023 09:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oib-00083d-NP
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:39:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oiZ-0003li-SK
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:39:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f427118644so11030715e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684935594; x=1687527594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJVPWXx5AwD7VKV2U66DJQZzDYUvPoHQtuGdzv7YoHE=;
 b=pIvUDWZQ/qIiRJiIcW8j9SgR4sbdcWnkrEslmgC5waWteC/eMp3AdZOLig/iBqcQpe
 +inoKSdzEN9oak6hZUpQDZSswYcuiNZDYyDDbL33x3U7SRFwp0PD+q6dKj0oj1NzwG6d
 BJeGeUguanN1+bCmtbWtWadzlcP6gGbW1i6qzuFcKyo1cuyPOuGbuYKLp/HT6KM0H6AD
 CZkujUWV6C9g8jWR3UMceKXqXsNsTDIiakXQDF7lj7JDNk7aKsM1DrF9VyBBnlTXBC9J
 NmItsr6ztcyubTjmQrlptFu2417mZeQEMkuXOz3RiDVKXf9p/qR3RSxZHzmyq6xgZP+O
 fgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684935594; x=1687527594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJVPWXx5AwD7VKV2U66DJQZzDYUvPoHQtuGdzv7YoHE=;
 b=HQcbPL3Zp+D/KAIiVZKJ+mo5DepDHy1ZdSNizfH3t00asWpYcqKrf5WxEMdz0+MIj1
 cytyzFFts9bLRqoyaHFAXPfsW/UegdQZn4i/ChOM/FQc0EiT6eB9Zgpnk1kjgLQ4eC3y
 BPgITqx4W6YA1hqNlPn+YB3CkvqxfXAI+zJFUPdIGFp8TYHzhN/xoNG1M3761bXvp+S8
 cDyWFmrdJm/GQ90JVTXC5kwKk/5eJdS1Y4yTcRdZO0x1l8yeDFC/VzdasRCbeMmUZHXG
 EXOxylnE+5L1mtd6ziOpLe95QCzQQTXEWfNnyW1zl1nuyuGNOez/j4dvGNfU2acaleLe
 EhXQ==
X-Gm-Message-State: AC+VfDxBywnqFGWemnzILnaJ3avc1JHT2gZYjZxxHCjn7DMx/1qdlTzv
 XXRtE27LEYDg5W9KAOY81+a4oj7mxL1X7amsB2CQtw==
X-Google-Smtp-Source: ACHHUZ7xR8AK9kzUBUpi5pPTpIaSALzFsFrV4TnTNCfPqzU2O6NOMaMObrplO9N5jpIorh5pp67+xQ==
X-Received: by 2002:a05:600c:20d:b0:3f6:735:69e7 with SMTP id
 13-20020a05600c020d00b003f6073569e7mr6421168wmi.36.1684935594316; 
 Wed, 24 May 2023 06:39:54 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a05600c210200b003f42314832fsm2379125wml.18.2023.05.24.06.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 06:39:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4CC371FFBE;
 Wed, 24 May 2023 14:39:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v5 03/10] trace: remove vcpu_id from the TraceEvent structure
Date: Wed, 24 May 2023 14:39:45 +0100
Message-Id: <20230524133952.3971948-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524133952.3971948-1-alex.bennee@linaro.org>
References: <20230524133952.3971948-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This does involve temporarily stubbing out some helper functions
before we excise the rest of the code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230523125000.3674739-4-alex.bennee@linaro.org>
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
2.39.2


