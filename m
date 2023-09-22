Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7862E7AAE16
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcVz-0004oE-Jo; Fri, 22 Sep 2023 05:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVi-0004iq-08
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVg-0003N2-Gs
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rS1CupBJrFupvgmVw9AdBeqh97yjhKlttsdxSozUwO8=;
 b=AdylmApO93cso2m0Pl35sdEWq1AD1aFxFMD5+nEUKG7cO5Rv1Ed3B+8GX1DPTfYj3aPdgK
 tQmxQGD4iZiMER9HH7+0pLICFA5DEAZO4YooZCp79h8ka6/fwiXTB+YVlzc4jVS43P1+dC
 TzayAV2l/Y8CYS0lru1naZ2T32pot38=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-rlh1Ib8NOg2P1CJOya55vA-1; Fri, 22 Sep 2023 05:31:38 -0400
X-MC-Unique: rlh1Ib8NOg2P1CJOya55vA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-503555a717fso2350624e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375096; x=1695979896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rS1CupBJrFupvgmVw9AdBeqh97yjhKlttsdxSozUwO8=;
 b=ikXq4H1oXOqxvH2CE/hz1BtOGdu55uePTw+ExYFY5o4ELOfinLyfjRr7paPEybuxrF
 4RjHWTMYKW9fMBX5vd42SYUGUk0xrLbt/oTcWIsp8NnGb3GwGm26AqRt1aZ+3KpNd6m+
 //0muahx1GMKuMOYNFRRHs7971pgCa4zk1eWG9IWwHsFT8XFajKrPd6Bx64qs5e6sd1D
 mG5EkvGHC+ROzrUAytGrDrILsz7Nq2NIb8u3/MDI8LF1BNM+kIFB6hbwVDQ3BJmJL2bX
 TJb0ihg50wV4nkcG9MvRMKf8KugS02S6iRActYPLgyZPqBheJhQdCsnM5YW6rGGkik+p
 XTew==
X-Gm-Message-State: AOJu0YzbRo9SPr1aLQEkuyYSsl12SVDMPbFg39l6OzF0Qw66oTdIVvLZ
 KlN8D5cUrz+gIaEdcigvhk37vclb5swAhd+NB3TDfIxtdI+jYjP6CpQGLiCcGbha8pD9rNcURgA
 lZZnghc0bz8yrrZLSGdS7jdnYk3+30o9Uw3Xe2c2pgLBZ+FDcuC/50AUZ/DueDnJvqz7VZ8V0u4
 E=
X-Received: by 2002:a05:6512:360a:b0:503:385c:4319 with SMTP id
 f10-20020a056512360a00b00503385c4319mr7388948lfs.19.1695375095967; 
 Fri, 22 Sep 2023 02:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJoDhGrq6QIjhXA0ZbpSvui1ZKAHRX3LFqgR1bpEGAc+VLFiHFYhEkapEm1pNpusXgoaKPGQ==
X-Received: by 2002:a05:6512:360a:b0:503:385c:4319 with SMTP id
 f10-20020a056512360a00b00503385c4319mr7388930lfs.19.1695375095567; 
 Fri, 22 Sep 2023 02:31:35 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 c23-20020a7bc857000000b003fefca26c72sm4160670wml.23.2023.09.22.02.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/12] hw/input/tsc210x: Extract common init code into new
 function
Date: Fri, 22 Sep 2023 11:31:18 +0200
Message-ID: <20230922093126.264016-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922093126.264016-1-pbonzini@redhat.com>
References: <20230922093126.264016-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


