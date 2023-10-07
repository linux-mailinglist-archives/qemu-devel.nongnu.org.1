Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF517BC7A2
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:41:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aC-0002pE-R3; Sat, 07 Oct 2023 08:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6a9-0002nx-6f
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:38:57 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6a7-0002jM-J7
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:38:56 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9ae7383b7ecso911886166b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682332; x=1697287132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P285wl7tofy1lIjcvNIZ65kpg20VmShLy89nxVn9z+4=;
 b=YYINf02B636QamHnOzDY9D2oIRG6ISx4iOgSjKkGGn7AagnlITi2gS5MNr0jGflwZd
 1P2V+PapZk1Qpt1SD9y8cHy7RUkXbMWipJhj6oKkPe209x/lSd9QFL8r7+olD4liVNcs
 +HH5NUHoczL7+tVwYJBUCPgNo/uuSdAMJi0Y6JjnSPysC6ugHOUtwmGGtUhrmanV9Z1F
 pV1+CgZ5nf2blw/o4BLH7n2hybfC0XSbExTK9i3kYRzlBdOsccDJfqCYTDYpmyynrwzn
 6bd/yyvPZa6yaTexm8K9I6Xe7fT8SaK7EEUZO4FQ6iDeChAn9O39QImcgjOBx7zb2KXp
 AvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682332; x=1697287132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P285wl7tofy1lIjcvNIZ65kpg20VmShLy89nxVn9z+4=;
 b=wDIrQ+qstcPwrapCn5KG2zl3nUzqzYlpslW5lLmOJg1NptmqQsiq2hZf6GrqtJ3N/B
 jAL5pn8Aq/xiVOa06fGz2JM3mG5x3lF6YEgAX4siZIlTYdgE23Ia6i/3+mcKXKkIjkBH
 ACVb7opkuZWsQBcDsuIdchqmjR8doasqCyaYLOA3CTrnt1Dv10ONMhntHldZG+G62dLw
 ghjqR1PtmeQAssMx0XyusiZC4lNG+28MIzL/+ZpEUmGUDwyhlfnn78mRo6sO/qqMzM4P
 xJRe7QciBR+e4rGQDRC/otNs2WbLMLv98SrpUMvobDSw+9ZW8iWBPpIhRGoM3AauEHjE
 V70Q==
X-Gm-Message-State: AOJu0YxQLzEZU99k28xgJM8iH5MkK5bsO76gfIlZn5XaeyvIlg4M5t8N
 lEjwN5lA79yqh1TaDXI537ZO30C9+Vk=
X-Google-Smtp-Source: AGHT+IGbeg0EzjU9T4sZsvSgHjPKvTMZpKY49VjLkoaFW0YU+wNB0zO0ACq6N2g3ETOBCXUXH52uEg==
X-Received: by 2002:a17:906:6a28:b0:9ad:cbc0:9f47 with SMTP id
 qw40-20020a1709066a2800b009adcbc09f47mr6353637ejc.12.1696682332349; 
 Sat, 07 Oct 2023 05:38:52 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:38:51 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v8 01/29] hw/i386/pc: Merge two if statements into one
Date: Sat,  7 Oct 2023 14:38:09 +0200
Message-ID: <20231007123843.127151-2-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

By being the only entity assigning a non-NULL value to "rtc_irq", the first if
statement determines whether the second if statement is executed. So merge the
two statements into one.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index aad7e8ccd1..2fbdff89e0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1200,7 +1200,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     DeviceState *hpet = NULL;
     int pit_isa_irq = 0;
     qemu_irq pit_alt_irq = NULL;
-    qemu_irq rtc_irq = NULL;
     ISADevice *pit = NULL;
     MemoryRegion *ioport80_io = g_new(MemoryRegion, 1);
     MemoryRegion *ioportF0_io = g_new(MemoryRegion, 1);
@@ -1220,6 +1219,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
      */
     if (pcms->hpet_enabled && (!kvm_irqchip_in_kernel() ||
                                kvm_has_pit_state2())) {
+        qemu_irq rtc_irq;
+
         hpet = qdev_try_new(TYPE_HPET);
         if (!hpet) {
             error_report("couldn't create HPET device");
@@ -1244,9 +1245,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         pit_isa_irq = -1;
         pit_alt_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_PIT_INT);
         rtc_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_RTC_INT);
-    }
-
-    if (rtc_irq) {
         qdev_connect_gpio_out(DEVICE(rtc_state), 0, rtc_irq);
     } else {
         uint32_t irq = object_property_get_uint(OBJECT(rtc_state),
@@ -1254,6 +1252,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
                                                 &error_fatal);
         isa_connect_gpio_out(rtc_state, 0, irq);
     }
+
     object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state),
                               "date");
 
-- 
2.42.0


