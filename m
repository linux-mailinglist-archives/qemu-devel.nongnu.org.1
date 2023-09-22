Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C1E7AB500
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:43:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiIp-00006Y-45; Fri, 22 Sep 2023 11:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIn-000053-Bc
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIl-0002oa-NZ
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rS1CupBJrFupvgmVw9AdBeqh97yjhKlttsdxSozUwO8=;
 b=Z4YpXsLpS+4txxwDgklNzwIDrgbsSy1ilxAgQIZXOUu++G8jXxvF0F1UgGZJE6/M2TVIWr
 xcAxuzN97QoicdtzQ0rqr7bWJNQ4XQ/1aW+jYPX0VC+HBaPE4miR2uMpv9fGMxms9oCWmb
 XRnMgtXr42iyC57eFHGazJShxrGC48w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-BNfSfsp8Mda3TB4wb_u6cA-1; Fri, 22 Sep 2023 11:42:41 -0400
X-MC-Unique: BNfSfsp8Mda3TB4wb_u6cA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4011f56165eso19426815e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397359; x=1696002159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rS1CupBJrFupvgmVw9AdBeqh97yjhKlttsdxSozUwO8=;
 b=dV7CwXLTELT7y7v7IjAuMuHKXa7xy97uI3Cj1cF3k66YGbMY+dOsKM1ug3kvqjpLJC
 AG1/JIDSLQeoMbS/n6NrZehOHwLwO2+a6BIqQTzQhoF4F/7j24gNEjvWE/pvHlI8E47m
 xnnjVKVrrKnyOJBfsD2Zv5UAwSSaGjQeHl7CR21Gsh73K/xTaN1ANvi8lzPbP9EnBJaU
 Sryf0kiG4Y/O07bjDJ7TsYKnJAZBqA9dNqsivdZ3GkG6hXJYfS2udPjLvY1wKGG/OI40
 GKwpsQbZzUneeuGX3WysyPtU+uE0c/uJq+T6ew2c/DfSJJUe1oqLrpH+qEgB2lwZxMvv
 LIUg==
X-Gm-Message-State: AOJu0YwjRhP5fIcY+vsdY3RCWEsn1KI6ryKQqnLTYj5xQ6+xEpIpsy5I
 G/0lPQtJVm02xMNmMR4lq72ueQEuudmEjtwSMLSntiOEwmG9tO1mKV91tJSVFegYIAgTYoWCaY0
 tbZttV4sCttcpQGvOu8tyTX2POt3b6KBDR/bDUXleUrLv9fvwSoSNo1+yi42fg5Z5RWe5Xplnd9
 E=
X-Received: by 2002:a05:600c:35c9:b0:401:b425:2414 with SMTP id
 r9-20020a05600c35c900b00401b4252414mr2430484wmq.18.1695397359324; 
 Fri, 22 Sep 2023 08:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeui1D0t5fQQwtvlsyZ1xzI7pb05nAJSGwOwA3OoRknWN0Au/rqloXSDdH18i/pvlfSbkZPA==
X-Received: by 2002:a05:600c:35c9:b0:401:b425:2414 with SMTP id
 r9-20020a05600c35c900b00401b4252414mr2430466wmq.18.1695397358868; 
 Fri, 22 Sep 2023 08:42:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a05600c21ca00b004051b994014sm7791320wmj.19.2023.09.22.08.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:42:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 4/9] hw/input/tsc210x: Extract common init code into new
 function
Date: Fri, 22 Sep 2023 17:42:23 +0200
Message-ID: <20230922154228.304933-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922154228.304933-1-pbonzini@redhat.com>
References: <20230922154228.304933-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Martin Kletzander <mkletzan@redhat.com>

This deduplicates several lines and will make future changes more
concise.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <1d75877cf4cc2a38f87633ff16f9fea3e1bb0c03.1650874791.git.mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/input/tsc210x.c | 68 ++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 44 deletions(-)

diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index 7eae5989f76..f568759e05a 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -30,6 +30,7 @@
 #include "hw/input/tsc2xxx.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 
 #define TSC_DATA_REGISTERS_PAGE		0x0
 #define TSC_CONTROL_REGISTERS_PAGE	0x1
@@ -1069,20 +1070,10 @@ static const VMStateDescription vmstate_tsc2301 = {
     .fields = vmstatefields_tsc210x,
 };
 
-uWireSlave *tsc2102_init(qemu_irq pint)
+static void tsc210x_init(TSC210xState *s,
+                         const char *name,
+                         const VMStateDescription *vmsd)
 {
-    TSC210xState *s;
-
-    s = g_new0(TSC210xState, 1);
-    s->x = 160;
-    s->y = 160;
-    s->pressure = 0;
-    s->precision = s->nextprecision = 0;
-    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tsc210x_timer_tick, s);
-    s->pint = pint;
-    s->model = 0x2102;
-    s->name = "tsc2102";
-
     s->tr[0] = 0;
     s->tr[1] = 1;
     s->tr[2] = 1;
@@ -1104,13 +1095,29 @@ uWireSlave *tsc2102_init(qemu_irq pint)
 
     tsc210x_reset(s);
 
-    qemu_add_mouse_event_handler(tsc210x_touchscreen_event, s, 1,
-                    "QEMU TSC2102-driven Touchscreen");
+    qemu_add_mouse_event_handler(tsc210x_touchscreen_event, s, 1, name);
 
     AUD_register_card(s->name, &s->card);
 
     qemu_register_reset((void *) tsc210x_reset, s);
-    vmstate_register(NULL, 0, &vmstate_tsc2102, s);
+    vmstate_register(NULL, 0, vmsd, s);
+}
+
+uWireSlave *tsc2102_init(qemu_irq pint)
+{
+    TSC210xState *s;
+
+    s = g_new0(TSC210xState, 1);
+    s->x = 160;
+    s->y = 160;
+    s->pressure = 0;
+    s->precision = s->nextprecision = 0;
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tsc210x_timer_tick, s);
+    s->pint = pint;
+    s->model = 0x2102;
+    s->name = "tsc2102";
+
+    tsc210x_init(s, "QEMU TSC2102-driven Touchscreen", &vmstate_tsc2102);
 
     return &s->chip;
 }
@@ -1131,34 +1138,7 @@ uWireSlave *tsc2301_init(qemu_irq penirq, qemu_irq kbirq, qemu_irq dav)
     s->model = 0x2301;
     s->name = "tsc2301";
 
-    s->tr[0] = 0;
-    s->tr[1] = 1;
-    s->tr[2] = 1;
-    s->tr[3] = 0;
-    s->tr[4] = 1;
-    s->tr[5] = 0;
-    s->tr[6] = 1;
-    s->tr[7] = 0;
-
-    s->chip.opaque = s;
-    s->chip.send = (void *) tsc210x_write;
-    s->chip.receive = (void *) tsc210x_read;
-
-    s->codec.opaque = s;
-    s->codec.tx_swallow = (void *) tsc210x_i2s_swallow;
-    s->codec.set_rate = (void *) tsc210x_i2s_set_rate;
-    s->codec.in.fifo = s->in_fifo;
-    s->codec.out.fifo = s->out_fifo;
-
-    tsc210x_reset(s);
-
-    qemu_add_mouse_event_handler(tsc210x_touchscreen_event, s, 1,
-                    "QEMU TSC2301-driven Touchscreen");
-
-    AUD_register_card(s->name, &s->card);
-
-    qemu_register_reset((void *) tsc210x_reset, s);
-    vmstate_register(NULL, 0, &vmstate_tsc2301, s);
+    tsc210x_init(s, "QEMU TSC2301-driven Touchscreen", &vmstate_tsc2301);
 
     return &s->chip;
 }
-- 
2.41.0


