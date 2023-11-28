Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 766A67FBBCD
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:40:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yHn-0001uj-RJ; Tue, 28 Nov 2023 08:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yHl-0001u5-QU
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:37:57 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yHk-00082g-3f
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:37:57 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a02d12a2444so792151066b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701178674; x=1701783474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uzi8wIQSpfhO1cy29d4ly7tCccneF+ePwVBHrNodZ4k=;
 b=yi4mU/YYZolzk3Fv1ye/mTwybAM8I+5uvnsDdKd+Hy9l/OHZ2ip64Wru6/Si/+WdYY
 ip0Q91DlZG60w/JYIE5ZgO9dTTR2QEpfBh9bNSJl18pucLPNmsb/tJMOMfwmXnfJGXV6
 bp3IlglyghG/Znsv2wcL9x0KY83pzvTI9rZBq2DhaiqGyKaHOkAKM+N8DRoOyiB++gXc
 WOFhg6tTmWL7iCpSpny8qDa1br+3aqSPJYErum/9U3bgO/Ur8kIKqYw/MLkhw10FJu5s
 FqtkD43RMhwD/nHumBbKhQq/A3cr1aK6QaJMdNBtUgixGLCydNYiei+JzXSn56A9Rbbz
 7P4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701178674; x=1701783474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uzi8wIQSpfhO1cy29d4ly7tCccneF+ePwVBHrNodZ4k=;
 b=vozNfJnbFJml0Z1FTmwoVytRS07UzvQabnwfy9JGsh1VMrY99HhNBDet8BeVrsGi6e
 A1ZUoCa7oI3op9Uvf6zx6zhTwSKp3uK3GrHJmjAHP3F3jfpbivrpz0A4c+xnE0bZPU8H
 5jVUP5Qk53r0Cp2FyZxsZEnSZpCR+MJ0ZvAsVFgm/7A1ggnErWBuScA46BpG5kdT5B27
 x+Zphep3Y3cf7TjcS4Dn+MrBnVT5aNhUA6MJIWem1afwsWVdRwmUwuZF37i9HOXqZiZa
 CM5C2UfYF5XigG19XOMuubcxTNvuf5nbf6cjfkcXe1jp7hn3mjZOIh4U1MYIN2YRtEN7
 lxww==
X-Gm-Message-State: AOJu0Yy8YBIWHraKqIYMEnuHS2oxEn3kb3bkicXeb9+K5OOZZ+ZYzO3d
 7rTF1F3opZ1uJgZprVJLx92dqo7BkQEigDzgiMc=
X-Google-Smtp-Source: AGHT+IEomZ6jm/Ms+MNRlNuUykBCCBmr6RxvAGfR8TSUNso/QQYyu1W0Dw+RlZlkbbO7F8sMuAfVWA==
X-Received: by 2002:a17:907:9150:b0:9d5:ecf9:e6b5 with SMTP id
 l16-20020a170907915000b009d5ecf9e6b5mr8735393ejs.59.1701178674321; 
 Tue, 28 Nov 2023 05:37:54 -0800 (PST)
Received: from m1x-phil.lan (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 f11-20020a17090624cb00b009fc3f347109sm6766375ejb.156.2023.11.28.05.37.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Nov 2023 05:37:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 2/7] hw/isa/vt82c686: Bring back via_isa_set_irq()
Date: Tue, 28 Nov 2023 14:37:35 +0100
Message-ID: <20231128133740.64525-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128133740.64525-1-philmd@linaro.org>
References: <20231128133740.64525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The VIA integrated south bridge chips combine several functions and
allow routing their interrupts to any of the ISA IRQs also allowing
multiple sources to share the same ISA IRQ. E.g. pegasos2 firmware
configures everything to use IRQ 9 but amigaone routes them to
separate ISA IRQs so the current simplified routing does not work.
Bring back via_isa_set_irq() and change it to take the component that
wants to change an IRQ and keep track of interrupt status of each
source separately and do the mapping to ISA IRQ within the ISA bridge.

This may not handle cases when an ISA IRQ is controlled by devices
directly, not going through via_isa_set_irq() such as serial, parallel
or keyboard but these IRQs being conventionally fixed are not likely
to be change by guests or share with other devices so this does not
cause a problem in practice.

This reverts commit 4e5a20b6da9b1f6d2e9621ed7eb8b239560104ae.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <1c3902d4166234bef0a476026441eaac3dd6cda5.1701035944.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/isa/vt82c686.h |  2 ++
 hw/isa/vt82c686.c         | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index b6e95b2851..da1722daf2 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -34,4 +34,6 @@ struct ViaAC97State {
     uint32_t ac97_cmd;
 };
 
+void via_isa_set_irq(PCIDevice *d, int n, int level);
+
 #endif
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 57bdfb4e78..6fad8293e6 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -549,6 +549,7 @@ struct ViaISAState {
     PCIDevice dev;
     qemu_irq cpu_intr;
     qemu_irq *isa_irqs_in;
+    uint16_t irq_state[ISA_NUM_IRQS];
     ViaSuperIOState via_sio;
     MC146818RtcState rtc;
     PCIIDEState ide;
@@ -592,6 +593,46 @@ static const TypeInfo via_isa_info = {
     },
 };
 
+void via_isa_set_irq(PCIDevice *d, int pin, int level)
+{
+    ViaISAState *s = VIA_ISA(pci_get_function_0(d));
+    uint8_t irq = d->config[PCI_INTERRUPT_LINE], max_irq = 15;
+    int f = PCI_FUNC(d->devfn);
+    uint16_t mask = BIT(f);
+
+    switch (f) {
+    case 2: /* USB ports 0-1 */
+    case 3: /* USB ports 2-3 */
+        max_irq = 14;
+        break;
+    }
+
+    /* Keep track of the state of all sources */
+    if (level) {
+        s->irq_state[0] |= mask;
+    } else {
+        s->irq_state[0] &= ~mask;
+    }
+    if (irq == 0 || irq == 0xff) {
+        return; /* disabled */
+    }
+    if (unlikely(irq > max_irq || irq == 2)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid ISA IRQ routing %d for %d",
+                      irq, f);
+        return;
+    }
+    /* Record source state at mapped IRQ */
+    if (level) {
+        s->irq_state[irq] |= mask;
+    } else {
+        s->irq_state[irq] &= ~mask;
+    }
+    /* Make sure there are no stuck bits if mapping has changed */
+    s->irq_state[irq] &= s->irq_state[0];
+    /* ISA IRQ level is the OR of all sources routed to it */
+    qemu_set_irq(s->isa_irqs_in[irq], !!s->irq_state[irq]);
+}
+
 static void via_isa_request_i8259_irq(void *opaque, int irq, int level)
 {
     ViaISAState *s = opaque;
-- 
2.41.0


