Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DDF7F2A4D
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:25:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Nw7-0004MI-GN; Tue, 21 Nov 2023 05:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nw2-0004Jk-UR
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:50 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nw0-0007FJ-FP
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:50 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso20301475e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 02:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700562287; x=1701167087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fwjCpEg7CxgIC61BgitQvtOo2gBc/4p1x2tjHLKtQjw=;
 b=CmYlSFp++lMA0x15vbqc9mWYeKDmgQs+BgJwf+XhTA3g5D3rrCgcAk8SHTbpOxFR7S
 eYwABQLGyha6vSVLz61kVhYI3faIudkvYLSrISJ95wSB+7AUThgaYQNQs9GAmxB4hg0a
 qnVxqwZQUg86OMEK2Ggsz81fokRM1k1D85s1oq+YwcefDce9hGjkq2tuJN1KKbSKGjTZ
 y7lS9xBBDgPhvsrmeRfOd3CNH7epiPAcDimxH3rNiESSUyQDkVtnMUw3NZoPQjDqWMMj
 S6OIpXZUCv3gi1TNmauZNafM6JCEc3Yz99p5W/avsVfkFBAxhY3TM7VyN+84shzOpCpu
 MtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562287; x=1701167087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwjCpEg7CxgIC61BgitQvtOo2gBc/4p1x2tjHLKtQjw=;
 b=N4HGpXi0CJSUfEGVAscqjQHeSaabglt1M33V5nNIGk75mWfCUyMTvSX/9tipfOrdSt
 ar2Or2mZS0U1uVZCwgFr9C67gAk52xv6PT74GwwdiAmrhebZLW71hL3TJb4gDKfLk4MX
 WDVdQbwItSD8ZkAWyhGdsI3yEib4LijeJfLC/tevQFvxKC4y7joN9LwV4ptqmBq9ygR5
 jYs0QTlnANkzpOd48NFfY4hW8f3QKX0MloPywyIW+K3gqIDwPccEafSOHFv3JajGc91L
 q70qP8PlPudbQ9WA0MdaMFYlHUk4+7vDH/FWumjRrduYicMZosZPQKbfTOisDbrZOsPG
 l3sQ==
X-Gm-Message-State: AOJu0YwWctFWvYUqapw0hhwrunaMML7NsvKX6K7SnXmvEaWByQBLijWR
 psd/4vf++1hd+FlS9SVQLECciAqHILj51FH+fjg=
X-Google-Smtp-Source: AGHT+IG8iFFMOe6HPUsEOmnw52AXUg8wZ65gsfaIuH5vtX1PwziiJPlqDvFOj6eHvHe86soLjl042A==
X-Received: by 2002:a05:600c:154a:b0:401:bdd7:49ae with SMTP id
 f10-20020a05600c154a00b00401bdd749aemr8289510wmg.18.1700562286702; 
 Tue, 21 Nov 2023 02:24:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a05600c181900b00405442edc69sm20450835wmp.14.2023.11.21.02.24.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:24:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] hw/arm/stm32f100: Report error when incorrect CPU is used
Date: Tue, 21 Nov 2023 10:24:40 +0000
Message-Id: <20231121102441.3872902-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121102441.3872902-1-peter.maydell@linaro.org>
References: <20231121102441.3872902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The 'stm32vldiscovery' machine ignores the CPU type requested by
the command line. This might confuse users, since the following
will create a machine with a Cortex-M3 CPU:

  $ qemu-system-aarch64 -M stm32vldiscovery -cpu neoverse-n1

Set the MachineClass::valid_cpu_types field (introduced in commit
c9cf636d48 "machine: Add a valid_cpu_types property").
Remove the now unused MachineClass::default_cpu_type field.

We now get:

  $ qemu-system-aarch64 -M stm32vldiscovery -cpu neoverse-n1
  qemu-system-aarch64: Invalid CPU type: neoverse-n1-arm-cpu
  The valid types are: cortex-m3-arm-cpu

Since the SoC family can only use Cortex-M3 CPUs, hard-code the
CPU type name at the SoC level, removing the QOM property
entirely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20231117071704.35040-5-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/stm32f100_soc.h | 4 ----
 hw/arm/stm32f100_soc.c         | 9 ++-------
 hw/arm/stm32vldiscovery.c      | 7 ++++++-
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/stm32f100_soc.h b/include/hw/arm/stm32f100_soc.h
index 40cd415b284..a74d7b369c1 100644
--- a/include/hw/arm/stm32f100_soc.h
+++ b/include/hw/arm/stm32f100_soc.h
@@ -43,12 +43,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(STM32F100State, STM32F100_SOC)
 #define SRAM_SIZE (8 * 1024)
 
 struct STM32F100State {
-    /*< private >*/
     SysBusDevice parent_obj;
 
-    /*< public >*/
-    char *cpu_type;
-
     ARMv7MState armv7m;
 
     STM32F2XXUsartState usart[STM_NUM_USARTS];
diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
index f7b344ba9fb..b90d440d7aa 100644
--- a/hw/arm/stm32f100_soc.c
+++ b/hw/arm/stm32f100_soc.c
@@ -115,7 +115,7 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
     /* Init ARMv7m */
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 61);
-    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
     qdev_connect_clock_in(armv7m, "refclk", s->refclk);
@@ -180,17 +180,12 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("CRC",       0x40023000, 0x400);
 }
 
-static Property stm32f100_soc_properties[] = {
-    DEFINE_PROP_STRING("cpu-type", STM32F100State, cpu_type),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void stm32f100_soc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = stm32f100_soc_realize;
-    device_class_set_props(dc, stm32f100_soc_properties);
+    /* No vmstate or reset required: device has no internal state */
 }
 
 static const TypeInfo stm32f100_soc_info = {
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 67675e952fc..190db6118b9 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -47,7 +47,6 @@ static void stm32vldiscovery_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F100_SOC);
-    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -58,8 +57,14 @@ static void stm32vldiscovery_init(MachineState *machine)
 
 static void stm32vldiscovery_machine_init(MachineClass *mc)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m3"),
+        NULL
+    };
+
     mc->desc = "ST STM32VLDISCOVERY (Cortex-M3)";
     mc->init = stm32vldiscovery_init;
+    mc->valid_cpu_types = valid_cpu_types;
 }
 
 DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
-- 
2.34.1


