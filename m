Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D365E81BA3A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:10:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKf9-00004r-Il; Thu, 21 Dec 2023 10:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKet-0008IS-V2; Thu, 21 Dec 2023 10:08:25 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKes-0004Qg-79; Thu, 21 Dec 2023 10:08:23 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2cc7087c6c4so10395641fa.2; 
 Thu, 21 Dec 2023 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703171297; x=1703776097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beCClsHMmqcMkMYgwQdfXIKn37AYMjOXEPxAk81UJRk=;
 b=RP1dVioZXE92LFektlr828zirS1A6m7nko5AxvynabhnhDpGdBRWhZZvvMrzeB0rbu
 vviSNX1MsYBxbkbAOYtOvnyUCIRyFdfdOq14EvnwWCuihbRQByNRods68bUBv0IptLJr
 BTz+Xg/HmR3jazxvAKVZJpAYfigYeUKtNJSlcMXwoQ/3oiJXr3VtyC0udUhrNe8gJpBu
 TiwwVe+Ml3vVDbdq0PeRnAIIj2fwleke5pxcch63i0XuDw2Pw/GeTS7bJufQy+KL1FL0
 AMf552bnv+g9aYoDcg+DsAl3X6Ib069uImVSVG1t7qTTijdJCLSRpwDMI+Tv+TevGpTd
 xyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171297; x=1703776097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beCClsHMmqcMkMYgwQdfXIKn37AYMjOXEPxAk81UJRk=;
 b=PyiKZn+hAy7JqarD3/qyisRrillM9xkliY4a6r46QZI3dxCUu7Ifvc7xBd1Sgp0/0F
 xWBPBM1hqw6X1jVQfR6O2eGgEPxFlPrkBolo5BcoGccSZG2SVw7SIkklcXrvFVa81Vf+
 BJj/ReV1Rrn74BaXJSzOK51WlDcKXzzRkHr9CMKkEeIX/ON7R8Chvl82Mu8C/QtHixhs
 60fytxozUsGDAxdFVNSaEEGmJg3TqC4wTHeIN9ekDX6UhkkaxYARlp1S5k+i94hstpj3
 XE/502QfjW+ATyd8sOZaVMR3NWuCVk7WnHJG4vTqeyUgCEz1ub2JhT2raAs33yvfy6x8
 +S0g==
X-Gm-Message-State: AOJu0YzJU1okunGNACuMZuGUYMbbbQyj+BdHlGBcH1YRgUabG2yPdWV0
 ND7QsjtAyF40czqggKjrEG/ECXW22FFi8A==
X-Google-Smtp-Source: AGHT+IEMmv25K9ZUsLFy1NWNv43RU+9liAW5zTzuXLR+LqkRFnsebJUbupQwa0hlZmO9NQ5Egzkxfw==
X-Received: by 2002:a2e:beac:0:b0:2cc:9985:462 with SMTP id
 a44-20020a2ebeac000000b002cc99850462mr890619ljr.24.1703171297629; 
 Thu, 21 Dec 2023 07:08:17 -0800 (PST)
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b00553b6b5bb44sm1264264eda.67.2023.12.21.07.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:08:17 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sergio Lopez <slp@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Hildenbrand <david@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 10/11] hw/ppc/pegasos2: Let pegasos2 machine configure
 SuperI/O functions
Date: Thu, 21 Dec 2023 16:07:49 +0100
Message-ID: <20231221150750.5435-11-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221150750.5435-1-shentey@gmail.com>
References: <20231221150750.5435-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x22b.google.com
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

This is a preparation for implementing relocation and toggling of SuperI/O
functions in the VT8231 device model. Upon reset, all SuperI/O functions will be
deactivated, so in case if no -bios is given, let the machine configure those
functions the same way Pegasos II firmware would do.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/pegasos2.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 3203a4a728..0a40ebd542 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -285,6 +285,15 @@ static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
     pegasos2_mv_reg_write(pm, pcicfg + 4, len, val);
 }
 
+static void pegasos2_superio_write(Pegasos2MachineState *pm, uint32_t addr,
+                                   uint32_t val)
+{
+    AddressSpace *as = CPU(pm->cpu)->as;
+
+    stb_phys(as, PCI1_IO_BASE + 0x3f0, addr);
+    stb_phys(as, PCI1_IO_BASE + 0x3f1, val);
+}
+
 static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
 {
     Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
@@ -310,6 +319,12 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x9);
+    pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
+                              0x50, 1, 0x6);
+    pegasos2_superio_write(pm, 0xf4, 0xbe);
+    pegasos2_superio_write(pm, 0xf6, 0xef);
+    pegasos2_superio_write(pm, 0xf7, 0xfc);
+    pegasos2_superio_write(pm, 0xf2, 0x14);
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
                               0x50, 1, 0x2);
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
-- 
2.43.0


