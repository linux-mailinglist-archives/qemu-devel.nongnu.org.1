Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E4582D08F
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:41:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzmN-0003j1-P6; Sun, 14 Jan 2024 07:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzmL-0003ZV-IX; Sun, 14 Jan 2024 07:39:53 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzmJ-0001oo-ON; Sun, 14 Jan 2024 07:39:53 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e69b3149fso19056365e9.3; 
 Sun, 14 Jan 2024 04:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705235988; x=1705840788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+Ml+Ge4Mh6egWEf/ah2KrW32CCxomhm5UQDIgErVxU=;
 b=BTFHMtTzpnFzSHh4puPmSplaj/dPfBqREzfPhcvamaCqlrJmxnTOkxUyhbvDjeKChT
 yGsT3qHUCSIpRMRJVF/C0PAehLAaxpV2gECnLOzOXMNh7yLLB2d4eLJ4DLNj8ZPcyy0b
 RHL0axe16p8KFEgeTuxS/QpILhTbNAgwDTE8qvzTvFbh9sRTSp4ymbsjLvmRR1n+Gqwo
 kemp849ihrUUHZuJPOC+rgjXFRwRc0cp3+hB+XT8bjc3Gz9bYSXmapIXeOOlqpI0+4uk
 s8RWiP/EYxlY3qriJ88K2qzSZSL1osJEyt5WNH1WsgYmPPe0iuMP1vo3M4K6qXnsP0Fl
 z1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705235988; x=1705840788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+Ml+Ge4Mh6egWEf/ah2KrW32CCxomhm5UQDIgErVxU=;
 b=aB6CuzTyCmCVNy06oAMpTSfVR/l+J+wervX64rN+rO20PjsZpfPvbv/ELWfePS2j3d
 wX5m2ZXWmh9OYnfNWdYCOsbTUh0E1Yg7ZoKRZaXbg6mGgW7GjrvbD184pCS0D4ilotS2
 Lim/tNPTpK47zOZxapPBizI0qnOVlKZTLA0oFqWKV/aCn8jlvvZCWgMWLwmdXlqReCYk
 O/xOEPyzs56a2BtvSINAvz27kWJOZkBsM54pjJ39VvqZ4eKAENnmH6WvJHAjEXU8bvYa
 STf3OH5L8cNAWufV+ljWlMFyT6g9rYJrAXIOOLqTLLGyQbpEbARrdoT7DzsA8qqwpOLF
 Cnyg==
X-Gm-Message-State: AOJu0Yy4MJgsxBCl8lBlFI8UQujMfsVbeIrIEPjWpVzp/oNrIcUCe7N+
 RHIL5iEmulPHErsgEs2OTh5TEcX4O2E=
X-Google-Smtp-Source: AGHT+IFlYoX9ml4I7bLZ+BzbDjDuVS3CtcstueG+VwbcJvrqU8pUFx92yQex4OcGk5STjE9Xb/bfew==
X-Received: by 2002:a05:600c:4fd5:b0:40d:6f89:a839 with SMTP id
 o21-20020a05600c4fd500b0040d6f89a839mr2643053wmq.30.1705235988517; 
 Sun, 14 Jan 2024 04:39:48 -0800 (PST)
Received: from archlinux.. (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 s2-20020a170906354200b00a293c6cc184sm4023734eja.24.2024.01.14.04.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 04:39:47 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 10/11] hw/ppc/pegasos2: Let pegasos2 machine configure
 SuperI/O functions
Date: Sun, 14 Jan 2024 13:39:10 +0100
Message-ID: <20240114123911.4877-11-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114123911.4877-1-shentey@gmail.com>
References: <20240114123911.4877-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
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
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index d84f3f977d..04d6decb2b 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -285,6 +285,12 @@ static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
     pegasos2_mv_reg_write(pm, pcicfg + 4, len, val);
 }
 
+static void pegasos2_superio_write(uint8_t addr, uint8_t val)
+{
+    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f0, &addr, 1);
+    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f1, &val, 1);
+}
+
 static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
 {
     Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
@@ -310,6 +316,12 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x9);
+    pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
+                              0x50, 1, 0x6);
+    pegasos2_superio_write(0xf4, 0xbe);
+    pegasos2_superio_write(0xf6, 0xef);
+    pegasos2_superio_write(0xf7, 0xfc);
+    pegasos2_superio_write(0xf2, 0x14);
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
                               0x50, 1, 0x2);
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
-- 
2.43.0


