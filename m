Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE82825FAC
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 14:27:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rM6gk-0000au-Ip; Sat, 06 Jan 2024 08:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rM6gc-0000Z7-0X
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 08:26:02 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rM6ga-0005y6-8N
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 08:26:01 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-557642101d2so309813a12.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jan 2024 05:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704547557; x=1705152357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngDy4AuSjsLm+pNaNgB5RjRDQ+EvhkuQYpdltE6Gki0=;
 b=GjFIpenonGSoZb2huSa28e0jcFs/Q9NWS76uZfi4euIAjC1SePH2ngfeC5nlQ+HMd/
 3o1WZT5lweApex9q0IqS+cQdpnvDp0j+5q5dC3bNgZtwjBFhDcvgA0vxK4VJHvyr3+Ec
 Vu2TvuTUbFja+9oqfKGMnevCVKZg0t5BhxX4wWI+0DYnyAID3937NztFyPDXmidK3UH9
 YEL+C8ujEOWHOrXGwDzR/tOsIl4Z9HHibLo3O1OXYituN4nYtcekZHm+UAbowVfSUM7/
 vqhEz8XTxGifwMqhEH86/4mL05KB+I/vIBIsQzyRwwP8NwsFuY2ypHMh/87O1USBDF9S
 3vsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704547557; x=1705152357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngDy4AuSjsLm+pNaNgB5RjRDQ+EvhkuQYpdltE6Gki0=;
 b=lzU1qBdLy6Ld2/yhjiWvWaRnTb6tFx5ZK3nRhnhIXG9qZZcr0PWz/vV/mgf/5R9BAU
 /h+umjoOYizSG2ThM0RGjuiWAcyqudt5NSiAeCitvI5e8swuxBCLv7zNAsLhAfLOgUgm
 EcrFVZwtI+jOQJEA5BKy5W3ZB8THXCSfvcNP/rtK5id6YrQ973soHzJxD7hR1DqQzFne
 XECjPnh930f9nyWvp6osqLOmsXdSPgDR0xiMF8BtymYAOQJynxoH3tUSZuvI/73LUpu6
 zzMwPe6T7ySROLxYM1KM5LhqX2QQM4fS1qpipyhTfWpAeji7RxRi06vsgBisdXx3gI9e
 tSig==
X-Gm-Message-State: AOJu0Yzk2jgvQFH+VZQL3gY/ym3NZ+JpWu0Xw+XbwOsnLkF2jwGeixku
 UUs/+FI+4PiS1qK0uAOPaRLTHnFq9tg=
X-Google-Smtp-Source: AGHT+IF9ou1qSybLYQD6QdjwW6u7eVqOieqxHm52cgPxaf4xRcabHETmDORd9n00fwTDXwO9AnBoqA==
X-Received: by 2002:aa7:d814:0:b0:557:4f8b:ed9 with SMTP id
 v20-20020aa7d814000000b005574f8b0ed9mr513039edq.4.1704547557559; 
 Sat, 06 Jan 2024 05:25:57 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-174-094.77.11.pool.telefonica.de. [77.11.174.94])
 by smtp.gmail.com with ESMTPSA id
 3-20020a508e03000000b0055515b40464sm2159752edw.81.2024.01.06.05.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 05:25:56 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 2/3] hw/i386/x86: Fix PIC interrupt handling if APIC is
 globally disabled
Date: Sat,  6 Jan 2024 14:25:45 +0100
Message-ID: <20240106132546.21248-3-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106132546.21248-1-shentey@gmail.com>
References: <20240106132546.21248-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

QEMU populates the apic_state attribute of x86 CPUs if supported by real
hardware or if SMP is active. When handling interrupts, it just checks whether
apic_state is populated to route the interrupt to the PIC or to the APIC.
However, chapter 10.4.3 of [1] requires that:

  When IA32_APIC_BASE[11] is 0, the processor is functionally equivalent to an
  IA-32 processor without an on-chip APIC.

This means that when apic_state is populated, QEMU needs to check for the
MSR_IA32_APICBASE_ENABLE flag in addition. Implement this which fixes some
real-world BIOSes.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual, Vol. 3A:
    System Programming Guide, Part 1

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/apic.h |  1 +
 hw/i386/x86.c          |  4 ++--
 hw/intc/apic_common.c  | 13 +++++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index bdc15a7a73..b2907c7179 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -11,6 +11,7 @@ void apic_deliver_nmi(DeviceState *d);
 int apic_get_interrupt(DeviceState *s);
 void cpu_set_apic_base(DeviceState *s, uint64_t val);
 uint64_t cpu_get_apic_base(DeviceState *s);
+bool cpu_is_apic_enabled(DeviceState *s);
 void cpu_set_apic_tpr(DeviceState *s, uint8_t val);
 uint8_t cpu_get_apic_tpr(DeviceState *s);
 void apic_init_reset(DeviceState *s);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 61af705e90..16cd06c594 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -516,7 +516,7 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
     CPU_FOREACH(cs) {
         X86CPU *cpu = X86_CPU(cs);
 
-        if (cpu->apic_state) {
+        if (cpu_is_apic_enabled(cpu->apic_state)) {
             apic_deliver_nmi(cpu->apic_state);
         } else {
             cpu_interrupt(cs, CPU_INTERRUPT_NMI);
@@ -551,7 +551,7 @@ static void pic_irq_request(void *opaque, int irq, int level)
     X86CPU *cpu = X86_CPU(cs);
 
     trace_x86_pic_interrupt(irq, level);
-    if (cpu->apic_state && !kvm_irqchip_in_kernel() &&
+    if (cpu_is_apic_enabled(cpu->apic_state) && !kvm_irqchip_in_kernel() &&
         !whpx_apic_in_platform()) {
         CPU_FOREACH(cs) {
             cpu = X86_CPU(cs);
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 6c100b48d6..bb5e916e9d 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -63,6 +63,19 @@ uint64_t cpu_get_apic_base(DeviceState *dev)
     }
 }
 
+bool cpu_is_apic_enabled(DeviceState *dev)
+{
+    APICCommonState *s;
+
+    if (!dev) {
+        return false;
+    }
+
+    s = APIC_COMMON(dev);
+
+    return s->apicbase & MSR_IA32_APICBASE_ENABLE;
+}
+
 void cpu_set_apic_tpr(DeviceState *dev, uint8_t val)
 {
     APICCommonState *s;
-- 
2.43.0


