Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A308D7435E4
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:38:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hI-000239-0p; Fri, 30 Jun 2023 03:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hD-00022O-8p
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:35 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hB-0005PB-HI
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:35 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-51d8fa4dbf9so1586616a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110651; x=1690702651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCVk7jdt1nDqHH6A+S2BbR5/KvJS5BvxayG0t6p+t7Q=;
 b=hTppHVQGOEUngTr52TFcZrzfdnuHUo0PBL4R0G9ssJqHaVsUIUJ9CtTnB9Xwwm1dWe
 Q/kuYRVZL2DpQZibwVIHn2MeZxYyfb7metyPB+YaJloiHE1llRVjXenaTjYOrL5JyV+D
 aEqPvPT5GGFr9Qz7W2y9gulQvaQp0Lj0Sie3hSnzi+DSjr2rlZFXr6drQais1xG4pA97
 o2xHyrXHIz8Q/kCiT8cbEU0+uNafRginZMvNUeGWxnzGSphj2J7MSG9SG4ZOwVIu+wkS
 KDsIDVpYuUQh3jjVyNlBcv5H+164Y3+vdmicMbtmxIj+sMUmhNIrRRMWDKngyEGlQ4vu
 LSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110651; x=1690702651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCVk7jdt1nDqHH6A+S2BbR5/KvJS5BvxayG0t6p+t7Q=;
 b=a6onf5uBcRFStDMveJ4tP7fsITRiuxynU5lLwEByLnky6fLugHH8WjoLSA8Ys09JXv
 mIEOPRgF2OiitPphvLvfx6S+p1cj54U/ggd/0QT7+ElEha+ItlH0FOtmiGKgzWGPG6Y8
 iYZAp5CaLCF4lCQhRbx3Xu+d1P2TWPsknNyWfXoLRJZ7XYEVKb2p0AnTFBTS7JXFWlIe
 iPR7qkS2dibCdBVBoZPuqiV1FfT6ynYEFg/mIMUjTEa/TdiMiZshbK5wdAWUUvhMU0Qp
 FSa5EconmikFofQsMfP/keZpea7ux1SP4T4faQ6xa832SzouUNOF1g8SxRdxe0o2ChWU
 /CnA==
X-Gm-Message-State: ABy/qLb5Vz3TXFQmmUS6kyVCcqBE2nDBc4VzNve8wwr+Z2jKYxIwQfDY
 m+adGfPlrvor5VFrl2TWtQpgHlxjIKA=
X-Google-Smtp-Source: APBJJlFEA0slv+JHK/ul+yRyGLnTlAdASNaFkBxxn3UtZmjPeJVOPlPD/yrjgVlNYRkGIt3o0fEB0A==
X-Received: by 2002:a17:906:f196:b0:96f:d345:d0f7 with SMTP id
 gs22-20020a170906f19600b0096fd345d0f7mr1045888ejb.62.1688110651565; 
 Fri, 30 Jun 2023 00:37:31 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:31 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/17] hw/pci-host/q35: Initialize PCMachineState::bus in
 board code
Date: Fri, 30 Jun 2023 09:37:06 +0200
Message-ID: <20230630073720.21297-4-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
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

The Q35 PCI host currently sets the PC machine's PCI bus attribute
through global state, thereby assuming the machine to be a PC machine.
The Q35 machine code already holds on to Q35's pci bus attribute, so can
easily set its own property while preserving encapsulation.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c  | 4 +++-
 hw/pci-host/q35.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d9f3764184..4edc0b35f4 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -230,10 +230,12 @@ static void pc_q35_init(MachineState *machine)
                             x86ms->below_4g_mem_size, NULL);
     object_property_set_int(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
                             x86ms->above_4g_mem_size, NULL);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
     host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
+    pcms->bus = host_bus;
+
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC), true,
                                 TYPE_ICH9_LPC_DEVICE);
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 84137b9ad9..0604464074 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -66,7 +66,6 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
                                 s->mch.pci_address_space,
                                 s->mch.address_space_io,
                                 0, TYPE_PCIE_BUS);
-    PC_MACHINE(qdev_get_machine())->bus = pci->bus;
     pci->bypass_iommu =
         PC_MACHINE(qdev_get_machine())->default_bus_bypass_iommu;
     qdev_realize(DEVICE(&s->mch), BUS(pci->bus), &error_fatal);
-- 
2.41.0


