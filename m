Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4570A7D4A19
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:31:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCnx-0001VT-Aa; Tue, 24 Oct 2023 04:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCnv-0001VD-23
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:23 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCns-00015B-Jc
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:22 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so62613171fa.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 01:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698136219; x=1698741019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vC64LeuneUdaH4mj/GrbtRZwgLrjLcB406B+2MzVdU=;
 b=HXI4gD47UN2ShfjMt0beOaog4cxPfuMDvMJIxAEmDxo6p7PxYAJZvQXR8vMP1L9x21
 EASMMEPCDmX1mDme3sKoD2WszzB/msvS6yMcNW9Z2eAJD0tvws+v0pM6csY3ifSl2z6O
 /7bQ/FwqM+QuaLCYvJukx8pP57D5y0d3rv1R+Y/7mrG50qs5fNaBmafLttAVFPJCtrs1
 SghSkXRLD1ZSmQyJ1N4ej7okQAgC/7ua9fefzlywP1uCurN7ta2ICHP1pF1nmHasu9Ki
 ZX3b2avbCXK/7tONwuqr/Ev1kkFWGrQyybVx0Bz34HMJiTVEjoi+j+3u2N8WwQoYKW5t
 /FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136219; x=1698741019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1vC64LeuneUdaH4mj/GrbtRZwgLrjLcB406B+2MzVdU=;
 b=mZhMTRVgLFJQve8D/18ubyOxY93TRJnFta52FCgpk47mF+CfDXYYEYMjcmRAhWuXp/
 0DRBtHJDOgr+9ab+G+EOT1fnzi6vULmQR135NGcY29NEQ9yiCdpGUvPMvZWs64ch8z8M
 yKIg+bt9ZUsMwN6s4Oqq23UqFUBQMskBkF/098fANcl8ZdCPDeSuN0p2xHuCTgmlDmic
 Di3wU6r4ayzGvbsuGOcplJua/VpcuR57cjtNA53CTJQ422+53qC7NrMLEpS5JKnS7zZD
 9JEIUEmeaqUCh0sG7Om5M30ApgkD83jdJvDbIv/Dtvh4SAVQE0J1fzv+1LXS0WtltHX+
 yOaw==
X-Gm-Message-State: AOJu0Yw/oQHiOhQDaKe3F0SaxiltDSCuOEOJA2Ha9U4iwXK2P680ycMp
 Kd427Db99Ya97fAwm3T3pcBq+R/eUMwhFCBjX8E=
X-Google-Smtp-Source: AGHT+IHmlGU+qeCdWYGN67XtG5SQf9tGvY6lIlENhTGmX+NAL2PKYqAOfqcBrkbrPoZunMbDAYsyPw==
X-Received: by 2002:a05:651c:a12:b0:2bc:ff80:f639 with SMTP id
 k18-20020a05651c0a1200b002bcff80f639mr10864680ljq.7.1698136218691; 
 Tue, 24 Oct 2023 01:30:18 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 g38-20020a05600c4ca600b004078d71be9csm15935123wmp.13.2023.10.24.01.30.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 01:30:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/6] hw/m68k/irqc: Pass CPU using QOM link property
Date: Tue, 24 Oct 2023 10:30:04 +0200
Message-ID: <20231024083010.12453-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024083010.12453-1-philmd@linaro.org>
References: <20231024083010.12453-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Avoid the interrupt controller directly access the 'first_cpu'
global. Pass 'cpu' from the board code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/m68k_irqc.h |  1 +
 hw/intc/m68k_irqc.c         | 10 +++++++++-
 hw/m68k/virt.c              |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/hw/intc/m68k_irqc.h b/include/hw/intc/m68k_irqc.h
index ef91f21812..693e33b0aa 100644
--- a/include/hw/intc/m68k_irqc.h
+++ b/include/hw/intc/m68k_irqc.h
@@ -33,6 +33,7 @@ typedef struct M68KIRQCState {
     SysBusDevice parent_obj;
 
     uint8_t ipr;
+    ArchCPU *cpu;
 
     /* statistics */
     uint64_t stats_irq_count[M68K_IRQC_LEVEL_NUM];
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index 0c515e4ecb..e09705eeaf 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -11,6 +11,7 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
+#include "hw/qdev-properties.h"
 #include "hw/nmi.h"
 #include "hw/intc/intc.h"
 #include "hw/intc/m68k_irqc.h"
@@ -35,7 +36,7 @@ static void m68k_irqc_print_info(InterruptStatsProvider *obj, Monitor *mon)
 static void m68k_set_irq(void *opaque, int irq, int level)
 {
     M68KIRQCState *s = opaque;
-    M68kCPU *cpu = M68K_CPU(first_cpu);
+    M68kCPU *cpu = M68K_CPU(s->cpu);
     int i;
 
     if (level) {
@@ -85,12 +86,19 @@ static const VMStateDescription vmstate_m68k_irqc = {
     }
 };
 
+static Property m68k_irqc_properties[] = {
+    DEFINE_PROP_LINK("m68k-cpu", M68KIRQCState, cpu,
+                     TYPE_M68K_CPU, ArchCPU *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void m68k_irqc_class_init(ObjectClass *oc, void *data)
  {
     DeviceClass *dc = DEVICE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(oc);
 
+    device_class_set_props(dc, m68k_irqc_properties);
     nc->nmi_monitor_handler = m68k_nmi;
     dc->reset = m68k_irqc_reset;
     dc->vmsd = &vmstate_m68k_irqc;
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 2dd3c99894..e7dc188855 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -155,6 +155,8 @@ static void virt_init(MachineState *machine)
     /* IRQ Controller */
 
     irqc_dev = qdev_new(TYPE_M68K_IRQC);
+    object_property_set_link(OBJECT(irqc_dev), "m68k-cpu",
+                             OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqc_dev), &error_fatal);
 
     /*
-- 
2.41.0


