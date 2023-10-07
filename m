Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 428537BC799
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aS-0002rX-UB; Sat, 07 Oct 2023 08:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aL-0002rG-SF
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:11 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aG-0002ky-57
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:05 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9a645e54806so532301866b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682342; x=1697287142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1U0rpwfNfAiROhYspUeK0AyPW0J23oC+jmzPCGq+Ueo=;
 b=LuOGozLeTBPkww9cI6umaHncfI6SfHrhjvrbK/Vj4sWjTuK8zechCM8r1fL4sKxt7+
 x9Cd8h4AZ6iPumyaJ0F7rforAnK3TfzUej6fITFEpLMhwE4diC8RJLjNMe0kcmbBUhUs
 4Dve4I8G3AKSxxhvvIEq95Wj34NjoXqA28e+EvqeKxjCtLmtcTrcFeUmBVLdqe6fwjp4
 vsEP4ff//4M6Ndrvuh5So+aUVNi/2No1Cvt1iGbdZvR3GhIa+ZK586PRd3f3h1/hXRLU
 p2siM9zeGz2FEWDXruOEa4Rlqed+ZC1fBKLIxTzp89Z0AH5CoXmH3NMbWt3jnz6QyJKE
 bhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682342; x=1697287142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1U0rpwfNfAiROhYspUeK0AyPW0J23oC+jmzPCGq+Ueo=;
 b=bh5Hfgy4i6sw2h+iPpLYkMREH3WerrmSMf4olwyGfmjeLVGEUZJykpk/7c/p0uF/nX
 OPPADNjbe5xPJS8QcBZ/rytqMtsE7LpoIC1svL0IpV35NdDHVEtaaEwQdbEQsp6eu8Zi
 WSmqKaPqsFSrMctBlY9Z81DqeQKrpER8Kco460hcm6bTis9yGIkF3p4dWOYbEfAgijJt
 N2u2fD8YfBR9g2mA5lFJieYPfWX60HE5jJzIhYOqQ6jeLrilhEWtAz2hBlEJDJ5jB8Uv
 a98OQsXIDv9jX1XObwkaLAVHkvZ5zDTe3wiVbin6ec+NqeqRIz4fkTfPYDsjy5swpwg+
 LNmg==
X-Gm-Message-State: AOJu0YxxjGVKMz5lSEsV4Vnlb0FOC2jPulHyoI6hyjHVf5895qvUgQYo
 fdjmVKuSjYDErgJ6iZQuqgL1F4QnZKM=
X-Google-Smtp-Source: AGHT+IGn2PEM5CJFgeqrUUYE6I7EBx350Hl7Wc+KwT6JofFsS7k7RmzzFxcLxYdtOpD9XhrutdB9eA==
X-Received: by 2002:a17:906:32c8:b0:9a1:abae:8d30 with SMTP id
 k8-20020a17090632c800b009a1abae8d30mr8869366ejk.47.1696682342269; 
 Sat, 07 Oct 2023 05:39:02 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:01 -0700 (PDT)
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
Subject: [PATCH v8 09/29] hw/isa/piix3: Wire PIC IRQs to ISA bus in host device
Date: Sat,  7 Oct 2023 14:38:17 +0200
Message-ID: <20231007123843.127151-10-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

Thie PIIX3 south bridge implements both the PIC and the ISA bus, so wiring the
interrupts there makes the device model more self-contained. Furthermore, this
allows the ISA interrupts to be wired to internal child devices in
pci_piix3_realize() which will be performed in subsequent patches.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_piix.c | 2 +-
 hw/isa/piix3.c    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index cd6c00c0b3..5988656279 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -293,6 +293,7 @@ static void pc_init1(MachineState *machine,
     } else {
         isa_bus = isa_bus_new(NULL, system_memory, system_io,
                               &error_abort);
+        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
         rtc_state = isa_new(TYPE_MC146818_RTC);
         qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
@@ -301,7 +302,6 @@ static void pc_init1(MachineState *machine,
         i8257_dma_init(isa_bus, 0);
         pcms->hpet_enabled = false;
     }
-    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 616f5418fa..3e7c42fa68 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -278,6 +278,8 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
     memory_region_add_subregion_overlap(pci_address_space_io(dev),
                                         PIIX_RCR_IOPORT, &d->rcr_mem, 1);
 
+    isa_bus_register_input_irqs(isa_bus, d->isa_irqs_in);
+
     i8257_dma_init(isa_bus, 0);
 
     /* RTC */
-- 
2.42.0


