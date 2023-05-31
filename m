Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E73718A82
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 21:50:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4RoL-00018p-FB; Wed, 31 May 2023 15:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4RoJ-00017t-Ed
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4RoH-0002ct-QC
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685562521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0mUomyf/Ox+xXMSaQ9IpuFfwKhp3csXMu7acYo6q+8=;
 b=iRTSQQXfVgcj6473Rng5N9vaBGBT1fABnQWaF4Ko2EjWC5Nre8vYOstV1Xo0VCgSCOssqD
 F/tBk9Bs2xWyIrpsmlFfZQXmGttJoZs3et1yRBE2TC7IK251FDDMKEcDADXuBm6jWqK1SJ
 XETmZHfrU1QH9UgyFScEPRsfl5rkf7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-xfG0Js8yMQ6x_Aw3akkcEw-1; Wed, 31 May 2023 15:48:39 -0400
X-MC-Unique: xfG0Js8yMQ6x_Aw3akkcEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBFA3101A55C;
 Wed, 31 May 2023 19:48:38 +0000 (UTC)
Received: from localhost (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52B6840CFD46;
 Wed, 31 May 2023 19:48:38 +0000 (UTC)
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
Subject: [PULL 08/11] trace: remove control-vcpu.h
Date: Wed, 31 May 2023 15:48:12 -0400
Message-Id: <20230531194815.1508961-9-stefanha@redhat.com>
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

Now we no longer have vcpu controlled trace events we can excise the
code that allows us to query its status.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20230526165401.574474-9-alex.bennee@linaro.org
Message-Id: <20230524133952.3971948-8-alex.bennee@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/control-vcpu.h          | 47 -----------------------------------
 trace/qmp.c                   |  2 +-
 scripts/tracetool/format/h.py |  5 +---
 3 files changed, 2 insertions(+), 52 deletions(-)
 delete mode 100644 trace/control-vcpu.h

diff --git a/trace/control-vcpu.h b/trace/control-vcpu.h
deleted file mode 100644
index 800fc5a219..0000000000
--- a/trace/control-vcpu.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * Interface for configuring and controlling the state of tracing events.
- *
- * Copyright (C) 2011-2016 Lluís Vilanova <vilanova@ac.upc.edu>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef TRACE__CONTROL_VCPU_H
-#define TRACE__CONTROL_VCPU_H
-
-#include "control.h"
-#include "event-internal.h"
-#include "hw/core/cpu.h"
-
-/**
- * trace_event_get_vcpu_state:
- * @vcpu: Target vCPU.
- * @id: Event identifier name.
- *
- * Get the tracing state of an event (both static and dynamic) for the given
- * vCPU.
- *
- * If the event has the disabled property, the check will have no performance
- * impact.
- */
-#define trace_event_get_vcpu_state(vcpu, id)                            \
-    ((id ##_ENABLED) &&                                                 \
-     trace_event_get_vcpu_state_dynamic_by_vcpu_id(                     \
-         vcpu, _ ## id ## _EVENT.vcpu_id))
-
-#include "control-internal.h"
-
-static inline bool
-trace_event_get_vcpu_state_dynamic_by_vcpu_id(CPUState *vcpu,
-                                              uint32_t vcpu_id)
-{
-    /* it's on fast path, avoid consistency checks (asserts) */
-    if (unlikely(trace_events_enabled_count)) {
-        return test_bit(vcpu_id, vcpu->trace_dstate);
-    } else {
-        return false;
-    }
-}
-
-#endif
diff --git a/trace/qmp.c b/trace/qmp.c
index aa760f1fc4..3e3971c6a8 100644
--- a/trace/qmp.c
+++ b/trace/qmp.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-trace.h"
-#include "control-vcpu.h"
+#include "control.h"
 
 
 static bool check_events(bool ignore_unavailable, bool is_pattern,
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 285d7b03a9..ea126b07ea 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -16,10 +16,7 @@
 
 
 def generate(events, backend, group):
-    if group == "root":
-        header = "trace/control-vcpu.h"
-    else:
-        header = "trace/control.h"
+    header = "trace/control.h"
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '',
-- 
2.40.1


