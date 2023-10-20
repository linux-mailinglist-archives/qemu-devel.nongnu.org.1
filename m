Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B035C7D0E00
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 12:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtn9i-0006KS-B5; Fri, 20 Oct 2023 06:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtn9g-0006Jq-7Y
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:55:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtn9d-00055E-Jk
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:54:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso467077f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697799296; x=1698404096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbJlLlLW1QaNDW3PSqCUmUPPQHDiEzU8rlIxTu4cfAA=;
 b=Wp7Pzc0xuSyKAqIJx5QXkakteSYuC1ob2JnW6u6IYttPUMGbg81WGWu0Ta2Nn5VgYO
 IsKM0cYcaCH5NYZdJDa6QqR9CCRABjnh6R+pMg6G6LlFsdBH3TS4/jlmvDXrv72nDiaY
 L/G+/is3RG38AgsBtxsRae6ERLVgTWwiuYGmaQ6VhKyZ0SMAwkSdVczciWFFYBM3DDPG
 kjo8WMjhGfyDV7PPMZARsQFpIhNi5kmPVBZpTySzC6DFkVgC8PZ4St9Wlldnpi6urP6r
 IB2dYDrdNSCC/7Tl5W7rPRi6I34P3EzivmGnCBrMrcl8krA6/R0dEP8/yHDrP0/vKcQH
 KWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697799296; x=1698404096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbJlLlLW1QaNDW3PSqCUmUPPQHDiEzU8rlIxTu4cfAA=;
 b=Vr3rW5aUvRVo3AE57BbjPRt69CL7v070pd6XdAG2UWarCk5LXU4CpXa2IuTk/8jBrc
 W01oag3vZuZOdXXDqT9vKEKy4/9U/bdJru53uwE+egIMy0TybO1/I5+XdneSvHUv5lV/
 o5vyLXJbtL6+sB7Wlr0gyvPhwZ0UcjZePg0xeYQlVfn395lSam4fET2pABTVCo6AHuQ4
 xI+pgu15N8XhxGRmJVIJBovDVIImQ9bbX6dRTZflobSu3jGa5cVfqlblIsqg9NHT4NjR
 4JmJRhcS29FQZC830ZD70ny5K/TuEMurYegLjuJP/ZbzvtXFeobed0DyyAoZHtkOvyr2
 M4Ag==
X-Gm-Message-State: AOJu0YxHXZQ0l/92HcYNPD3m+AQLtRWIwNm6HxnXNIpRDR8IGqLaq4/y
 LoN6jMJgIyKzAdw4Ch6sA7npqiHjaGIF7T20efE=
X-Google-Smtp-Source: AGHT+IHU2HB7hud+phQvg6kUEvyyQkwQps6J7F2NOYsgV1KfVzQJFLhzh/Eh/WaASr9ZLmYBwZX8ww==
X-Received: by 2002:adf:fe02:0:b0:32d:8108:500 with SMTP id
 n2-20020adffe02000000b0032d81080500mr919974wrr.58.1697799296021; 
 Fri, 20 Oct 2023 03:54:56 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 a3-20020a5d4d43000000b003196b1bb528sm1430438wru.64.2023.10.20.03.54.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 03:54:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 1/5] hw/i386/pc: Pass Error** argument to
 pc_basic_device_init()
Date: Fri, 20 Oct 2023 12:54:42 +0200
Message-ID: <20231020105447.43482-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020105447.43482-1-philmd@linaro.org>
References: <20231020105447.43482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

pc_basic_device_init() creates devices which can fail,
allow to propagate error to caller.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 5 +++--
 hw/i386/pc.c         | 7 +++++--
 hw/i386/pc_piix.c    | 2 +-
 hw/i386/pc_q35.c     | 2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bec38cb92c..069c27368d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -174,11 +174,12 @@ void pc_memory_init(PCMachineState *pcms,
                     uint64_t pci_hole64_size);
 uint64_t pc_pci_hole64_start(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
-void pc_basic_device_init(struct PCMachineState *pcms,
+bool pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice *rtc_state,
                           bool create_fdctrl,
-                          uint32_t hpet_irqs);
+                          uint32_t hpet_irqs,
+                          Error **errp);
 void pc_cmos_init(PCMachineState *pcms,
                   BusState *ide0, BusState *ide1,
                   ISADevice *s);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb3854d1d0..c0477f0141 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1189,11 +1189,12 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     g_free(a20_line);
 }
 
-void pc_basic_device_init(struct PCMachineState *pcms,
+bool pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice *rtc_state,
                           bool create_fdctrl,
-                          uint32_t hpet_irqs)
+                          uint32_t hpet_irqs,
+                          Error **errp)
 {
     int i;
     DeviceState *hpet = NULL;
@@ -1289,6 +1290,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
                     pcms->vmport != ON_OFF_AUTO_ON);
+
+    return true;
 }
 
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e36a3262b2..0d9cdf773e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -320,7 +320,7 @@ static void pc_init1(MachineState *machine,
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
-                         0x4);
+                         0x4, &error_fatal);
 
     pc_nic_init(pcmc, isa_bus, pci_bus);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a7386f2ca2..e4b05e3139 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -301,7 +301,7 @@ static void pc_q35_init(MachineState *machine)
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, !mc->no_floppy,
-                         0xff0104);
+                         0xff0104, &error_fatal);
 
     if (pcms->sata_enabled) {
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
-- 
2.41.0


