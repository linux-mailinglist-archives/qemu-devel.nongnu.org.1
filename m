Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E080F331
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:36:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5hK-0002Uh-Ic; Tue, 12 Dec 2023 11:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5hI-0002MY-QW
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:28 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5hG-00081R-At
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:28 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c3ceded81so33411585e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398803; x=1703003603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9op8cKrG0JyypF+RCA+q2X8QDxEkarjB/JQ0egU7oTo=;
 b=J57JOCFK0cch4fxeSps1aO/M06dC9nhPOyLiCO7wqAYyfP2B6Rs+pz1mZrYZPj4Z0n
 RrFAHRwMcroWs2S18vPVPHruaUZwTkesC3holntJR7Z0+xvTgRRsLDTajUkSRa9Bm6r5
 ibfEiS+AiZiZAmvkIJhfGvpsoXzq8FXxXPJAK7n5ZB5U+CO7dgXUWkxXHX2E5DCnLwpR
 UjHJ+KaYNLU5jr5K2+l1aahehRLm3cnFd1Dj6aV/4QP8UlrzMYPX97Ejt4taxXTt69o8
 e3mu41Ngcm3phqA7yMZIOhTy9tXlZ11bxII6etj+JZJx5GCU1P5w1l5T1+pJ2IF6sJwi
 TNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398803; x=1703003603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9op8cKrG0JyypF+RCA+q2X8QDxEkarjB/JQ0egU7oTo=;
 b=fDUp9bt+3wQKWoKfanw4Ia+ZTAFFr0Igm2T26PQ5ZROB77Z/UOzVDMOrAOiZgUz57I
 PnsVNX0dBy32gpjw8e+eWBuPaTJRlZUL3uIWE4G24QPX1ngxLBEGhvujAHErJrE+5yr/
 r8vRQ8XD4y3no0LHYUjdmiy5dNa0rLucNsf5kwkJ+jfrnOR7iyfYWPCF4l7xhUtwY8gS
 AgghzB3HshVEUsIdmSmAcw4y8ZV0+2mWHMWtDK5lpQ62KRksYjo+OQl6PsjspfaEgvPL
 EgT/Fbi1sz7SKP0T6LsM1gaaQ59Axo288I836h6OlxjFvuY4LDHO/nHvbNsqoNNMtXGd
 zuhQ==
X-Gm-Message-State: AOJu0YyytlAdn/jmg2bWbga1regZ4jReVCQkJpA8Tq1EimpvDct2n9kq
 DKbdMhV4l3WOrJ5hE7TN0Z9mZFp/qI09+4dWC3M=
X-Google-Smtp-Source: AGHT+IFM8sVIxOwsMQed6dWF7GPucchYQXs6EPCRdxoPwVV305JmnfVXkblCQVtRYW4o2yBOYddirg==
X-Received: by 2002:a7b:c5cc:0:b0:40c:53d1:4c6 with SMTP id
 n12-20020a7bc5cc000000b0040c53d104c6mr474119wmk.166.1702398803479; 
 Tue, 12 Dec 2023 08:33:23 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a5d46cc000000b003335c061a2asm11202196wrs.33.2023.12.12.08.33.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:33:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 31/33] hw/cpu/a9mpcore: Remove legacy code
Date: Tue, 12 Dec 2023 17:29:31 +0100
Message-ID: <20231212162935.42910-32-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Now that all boards set the "cpu-type" property,
the legacy code can be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cpu/a9mpcore.c      | 8 +++-----
 hw/cpu/cortex_mpcore.c | 8 +++++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index ffdaf392fc..4e2fdb8321 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -41,12 +41,10 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *scudev, *gtimerdev, *mptimerdev, *wdtdev;
     SysBusDevice *scubusdev, *gtimerbusdev, *mptimerbusdev, *wdtbusdev;
     Error *local_err = NULL;
-    CPUState *cpu0;
-    Object *cpuobj;
 
-    cpu0 = qemu_get_cpu(0);
-    cpuobj = OBJECT(cpu0);
-    if (strcmp(object_get_typename(cpuobj), ARM_CPU_TYPE_NAME("cortex-a9"))) {
+    if (!c->cpu_type) {
+        qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-a9"));
+    } else if (strcmp(c->cpu_type, ARM_CPU_TYPE_NAME("cortex-a9"))) {
         /* We might allow Cortex-A5 once we model it */
         error_setg(errp,
                    "Cortex-A9MPCore peripheral can only use Cortex-A9 CPU");
diff --git a/hw/cpu/cortex_mpcore.c b/hw/cpu/cortex_mpcore.c
index 65309636d7..c5de6c3ae4 100644
--- a/hw/cpu/cortex_mpcore.c
+++ b/hw/cpu/cortex_mpcore.c
@@ -57,6 +57,11 @@ static void cortex_mpcore_priv_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!s->cpu_type) {
+        error_setg(errp, "'cpu-type' property is not set");
+        return;
+    }
+
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cores);
     qdev_prop_set_uint32(gicdev, "num-irq", s->gic_spi_num);
     if (k->gic_priority_bits) {
@@ -85,9 +90,6 @@ static void cortex_mpcore_priv_realize(DeviceState *dev, Error **errp)
 
 
     /* CPU */
-    if (!s->cpu_type) {
-        return;
-    }
     for (int i = 0; i < s->num_cores; i++) {
         Object *cpuobj;
 
-- 
2.41.0


