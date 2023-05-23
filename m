Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B4570DCFD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:50:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RTS-0007hn-MC; Tue, 23 May 2023 08:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RTJ-0007ax-V0
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:38 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RT9-0005LK-P6
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-309d3e8777cso2544030f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684846204; x=1687438204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K01VdPgPYNekowAJXeG2Q1UEkTaMboRdvQpIKYeYNGo=;
 b=BvVvpGYUHIhKyhaoahKO8dY/q9m04n9ZLTMDQabZX/cHAeOStO+OLvCsQF64+aKN2L
 55UVHv9gwmG135gVmPHwc32YaFKzC8pgk/w4PU627gRcNjE+9DJjekwKE+WvFt6395K9
 gNl6jtoxOBGXNH0k80bty7ACRokZdluMxl4ydPCy98BbzjSXg5kaIk+arPeskrQ34ACv
 Ctx3AS1Kt6puc1KIvOCWJSXI0btOPxjbYI9+hG9vD2o8ihdXNIhF9HtX6jyLA0z6c+tC
 sUirQ7WDgwcIFGh99Iw3o6moFU3A/qN0/sZGVD+utIdSKun+BGYwzlb37nR9aG174QSZ
 1v+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846204; x=1687438204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K01VdPgPYNekowAJXeG2Q1UEkTaMboRdvQpIKYeYNGo=;
 b=b9TbbPkPZsmtKDgkEUBZs056GFl6W4lzDOFaPotUfAL0qxk6nQGIKhVrgREMhbMN52
 CKoe5PRZ0e2WVgz+9ryCt0rl1BnMreGkkye2+sQh1yV+WNmaVdmb0hrLCzjM9e8BxIsh
 wxMbZfb3NG7kAX76E6bqa0tR+lc4LI2qBkBkR3n+5BQxZlWY/4CDmZxI3qycA0XrKuYP
 hjvAvrPtycBTlPZWi4AvReRuSREx+SLeaRpNiZVn0kN2nw917XywH28f32z73k5vR375
 8dWZy2y8Wlp2Z7cYk0ebx+zjsMklm0x50tlsiJT43w1OnHHEJcLPkG/pn4Va+rIZwkjS
 jw7Q==
X-Gm-Message-State: AC+VfDyBddOvuyUearhKq136BTx6oTdO5qqUOqJ2unMolP0+p+B1xNLS
 nWRXQ86oa+NLyMHLeTLFumFa8A==
X-Google-Smtp-Source: ACHHUZ710PVnIQzWn0bKv4BfhMNSTFs+B2uATZKKtcyifek24dgl4yDvXtWCc8K78t/p/RVDqLcKYQ==
X-Received: by 2002:a5d:4585:0:b0:30a:a165:f95 with SMTP id
 p5-20020a5d4585000000b0030aa1650f95mr1450124wrq.19.1684846204645; 
 Tue, 23 May 2023 05:50:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a5d4d10000000b002f6176cc6desm11008898wrt.110.2023.05.23.05.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:50:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C8D6C1FFBB;
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
Subject: [PATCH v4 07/10] trace: remove control-vcpu.h
Date: Tue, 23 May 2023 13:49:57 +0100
Message-Id: <20230523125000.3674739-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523125000.3674739-1-alex.bennee@linaro.org>
References: <20230523125000.3674739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Now we no longer have vcpu controlled trace events we can excise the
code that allows us to query its status.

Message-Id: <20230420150009.1675181-8-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230503091756.1453057-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230505155336.137393-8-alex.bennee@linaro.org>
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
2.39.2


