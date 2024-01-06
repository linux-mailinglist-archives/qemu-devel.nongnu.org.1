Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D177826198
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 22:08:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMDrv-0005kH-8y; Sat, 06 Jan 2024 16:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrr-0005hh-E4; Sat, 06 Jan 2024 16:06:07 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrp-0001BU-NZ; Sat, 06 Jan 2024 16:06:07 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-555e07761acso716881a12.0; 
 Sat, 06 Jan 2024 13:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704575163; x=1705179963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beCClsHMmqcMkMYgwQdfXIKn37AYMjOXEPxAk81UJRk=;
 b=DgPDNcF8drqPgAcBBrzGxS/dfz5BBaz1q9H35ny5BTx2wS283LHzK+xjX0pCRqa7Pp
 0dRt9+4mSiDvWIft7HAJmIbJ3VeqOiT6XaJ7ZsRQH1s7RDnVHsLqlFhftFItELV2NqHl
 tkZF42/1HiKn8nwbvcxln1dvX1u0RcFHAsYARVq6/Lmld2Q0PbVywcr3bNYduhgsE8JH
 3EE6CvBQRuHKm0u7KofGET4gCkWJ+BuueVoSCYnhXRoKw63z5Bri1M3tujEqn43ZlH+v
 YcQyGgfRJK/8U0rzdaY5uXUeR4PDuU3HUWrfWqfm6XcrELbXkmxD/bQy2lTAOah2F7lD
 MmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704575163; x=1705179963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beCClsHMmqcMkMYgwQdfXIKn37AYMjOXEPxAk81UJRk=;
 b=O9sP9I5ykDPHLSez4kWQKo2bMTvjtf9H4i4EuYcIzE77GbjTV5DRIhjFNEvcnKj8HS
 DjlXug4NK0ks3G0z8SEwZem6jqp63wrV94rPhYgZbwu5LKWYlrjT9cZDsNMtJHoakYJ2
 lkvBbNiPJLW+CwktDqQ3+OQsWKclUZ9FrMYkLBxBGxppbnu2XvIzo3cyEJl7xhaTP0tR
 2vyw6NJJ1ojQEBUJHnBJFLoOfcgA/uGGkyLPsWli4z3Td69XJsaRM8yNxvxEbRCzn1J8
 qCrqHGZsuBK6a6bSe/gZUvysIBz3PiBC7TSQSrlUojcGwNWn5rtX2UOgyW4HXb0QjyxE
 czPQ==
X-Gm-Message-State: AOJu0YxNHaW+1zrZuIu5LHDWuzMVK+c0KOHR9ezqM1gJ5cVhLwbwRki+
 76XgUnRCwQOXzQn3Xx+ZrvkIymlRlSM=
X-Google-Smtp-Source: AGHT+IFMwTHj4D+JHoC4lxMaM3UMO8U5yzCZNNCv0vBsKo6BEwB7nI6hVlmYOq3JaNqbyow8FiTg+A==
X-Received: by 2002:a05:6402:1cab:b0:556:9ccb:33c9 with SMTP id
 cz11-20020a0564021cab00b005569ccb33c9mr480617edb.111.1704575163282; 
 Sat, 06 Jan 2024 13:06:03 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-174-094.77.11.pool.telefonica.de.
 [77.11.174.94]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056402195400b005576f4471besm624922edz.42.2024.01.06.13.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 13:06:02 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Xu <peterx@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v4 10/11] hw/ppc/pegasos2: Let pegasos2 machine configure
 SuperI/O functions
Date: Sat,  6 Jan 2024 22:05:30 +0100
Message-ID: <20240106210531.140542-11-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106210531.140542-1-shentey@gmail.com>
References: <20240106210531.140542-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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


