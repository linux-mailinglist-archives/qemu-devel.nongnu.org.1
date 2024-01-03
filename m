Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 514308229BE
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 09:50:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKwwD-0008Sm-Kr; Wed, 03 Jan 2024 03:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rKwwB-0008RH-PD
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 03:49:19 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rKwwA-0007R5-5H
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 03:49:19 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d76923ec4so40588785e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 00:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704271755; x=1704876555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pH+lQQvRFN7kY/sypIw3WKeBuPIPJhnSByp77aCKS4A=;
 b=Nn97aCXcxoDlJyD2mqdjopWOeSaMdSgND7JBP6Nl7F8GJD8R4Rv6hb89vQy5bN//dt
 ONcYvxoQnU0JngfunIknFrzq07PqHXV+3uMKkiPupvYBDOcMciTf/Uo9OiY2sPV+zL9p
 O8syc3dwT4TV2iefrjoVdNtJG2JSF5jt5+zxE1mQN57YD6vWUHzTOgPbmdxXfF9Ed1Tw
 XK6vxFG8aHuOl9tZEETyAMgrf9wN6FhmJ9hxbiShU3TKeMdg87Ann5/vDKUuDRIo4GbU
 EgIg/0G2xnDLv5VX9lg69+rHj+Z7wVytnu6ijuv8BqacoYBlmrYyePG5Xm2qg3GP9azn
 gwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704271755; x=1704876555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pH+lQQvRFN7kY/sypIw3WKeBuPIPJhnSByp77aCKS4A=;
 b=KSWGYoS7DdieOXpTTFjgQU0pZcnChk2wNLvm8ca+7ojHj838FUZLjPv86vFpqbNKGK
 SdIQYrF95E+iIC09XWZMt6zw0L8HmGZhPmEEP4/N2+sXKlems+39oAB1E+r3g8AfGfUP
 UUMH0lCRoL9RCYOt/rHI0MSEVO78mCOmD5vfPGBmJNnwpH0IbEGKX6W3TaYRwgfwmjWh
 vyEUziYh02VHjCY0oouP6KIqDNGrD1b/E4cAmlkEC2SxFfFlED308J6rV/vwGBy+cznI
 uMAKGd+nkrvxpnnrLtun2sDF6EnxR4Tl3uH0O6RkSVz/yZ3ZKUUJXZw2rkFmobOv+U1y
 31aA==
X-Gm-Message-State: AOJu0YwEDVB3aogJR3NBmRJQWbD+Lsygn/NCY3Ci9dEDH1HZ0n02jU3u
 Mqx/NISCpMSA0r/EfcmI0GZgMIdja4n4Xg==
X-Google-Smtp-Source: AGHT+IEE6ejb49cO6DZ4rj4dzszvBvFfDpMjOsaHooTnSkWJ5QZf2/3rjWf0FMnTSrdUvyTaQys87Q==
X-Received: by 2002:a05:600c:35c3:b0:40d:87cc:82a with SMTP id
 r3-20020a05600c35c300b0040d87cc082amr2006164wmq.11.1704271755138; 
 Wed, 03 Jan 2024 00:49:15 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-013-084-064.77.13.pool.telefonica.de. [77.13.84.64])
 by smtp.gmail.com with ESMTPSA id
 z16-20020adfec90000000b003366fb71297sm30063183wrn.81.2024.01.03.00.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 00:49:14 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/2] hw/i386/x86: Fix PIC interrupt handling if APIC globally
 disabled
Date: Wed,  3 Jan 2024 09:48:59 +0100
Message-ID: <20240103084900.22856-2-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103084900.22856-1-shentey@gmail.com>
References: <20240103084900.22856-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
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
hardware. Even when the APIC is globally disabled by a guest, this attribute
stays populated. This means that the APIC code paths are still used in this
case. However, chapter 10.4.3 of [1] requires that:

  When IA32_APIC_BASE[11] is 0, the processor is functionally equivalent to an
  IA-32 processor without an on-chip APIC. The CPUID feature flag for the APIC
  [...] is also set to 0.

Fix this by checking the APIC feature flag rather than apic_state when deciding
whether PIC or APIC behavior is required. This fixes some real-world BIOSes.

Notice that presence of the CPUID_APIC flag implies that apic_state is non-NULL.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual, Vol. 3A:
    System Programming Guide, Part 1

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/x86.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2b6291ad8d..a753d1aeca 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -516,10 +516,10 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
     CPU_FOREACH(cs) {
         X86CPU *cpu = X86_CPU(cs);
 
-        if (!cpu->apic_state) {
-            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
-        } else {
+        if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC) {
             apic_deliver_nmi(cpu->apic_state);
+        } else {
+            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
         }
     }
 }
@@ -551,8 +551,8 @@ static void pic_irq_request(void *opaque, int irq, int level)
     X86CPU *cpu = X86_CPU(cs);
 
     trace_x86_pic_interrupt(irq, level);
-    if (cpu->apic_state && !kvm_irqchip_in_kernel() &&
-        !whpx_apic_in_platform()) {
+    if ((cpu->env.features[FEAT_1_EDX] & CPUID_APIC) &&
+        !kvm_irqchip_in_kernel() && !whpx_apic_in_platform()) {
         CPU_FOREACH(cs) {
             cpu = X86_CPU(cs);
             if (apic_accept_pic_intr(cpu->apic_state)) {
-- 
2.43.0


