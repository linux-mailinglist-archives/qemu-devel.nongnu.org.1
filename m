Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF78F817A24
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:54:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIiv-0006TD-6l; Mon, 18 Dec 2023 13:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIim-0006Lp-1G; Mon, 18 Dec 2023 13:52:09 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiW-0008Qi-G0; Mon, 18 Dec 2023 13:52:04 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c6736d10fso44887915e9.1; 
 Mon, 18 Dec 2023 10:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925504; x=1703530304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yF9fIF58tWpNQAnkVGixO0hH0AJ7bWtrwUxz8sAPbEk=;
 b=MQxGLMNgS5aS1hJZ2z6EWpUJaNBllV1dnT9sVTP0g2VX4Bqu3aivJKuoz9/WrBQfRv
 XjHDAg7VxCCIcKJfMN9K/VOrE5tdFoo34eRsZO1MVGzqig0+RYWVPuzFcPixilX2ilrx
 ITDk9Grp34kt/9kbkipxlGuBhEDeOWEBdsPH+D2hgbATYFF/AbJG50GEbjraTJkT7hXs
 zXuXaPcU9xo6Tsj5xsm6DO9vJRVcpW7wOzywdWZLxQ5V+6/uY9yZyql0mdYvNw0uR85m
 rG04StH1U/P+o/Yg0OUzJ1vnpKRFXYn3C4t2l6JsVeB/C1PExnoJJyw8jdN4Y+fhnKMj
 C2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925504; x=1703530304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yF9fIF58tWpNQAnkVGixO0hH0AJ7bWtrwUxz8sAPbEk=;
 b=YNisDCbWEP2FFd+ADENFcZ+79MyrlQvVkIUQDzh4tpdExwFuMzGESt0hG8r7kCg7dK
 7ba8h/y12iQ2moX1oVen/adsA5CCW8Drzj4++U6VC4aKYbD4gU+SFpEf3IM/zt1WEhK+
 r+yZvZsBTtNxutrc0K/RIrpcN6k4/2Yu6scppdNuLhmPpAwjL36bH3vGC3BhwZPgZ7lY
 DeAQbxc7TBgXRWzLzE49n6rZdtjEc8mJS1cz4j3QYgANmVKP1+q94/clT3nPNYQvfmKL
 VuldluD3VLYZVLbE3S1HH38cd80ovtp2PXjtXLVgWL7KfhwenS/vQexRDPQWHzA/Xin3
 DTUA==
X-Gm-Message-State: AOJu0YyYK/aTE6g1+ADN3Vw3K5FBKNuXIVzZkuco7j1euR8o6XMzczkl
 zB14r13xohx83n3dcIOHPUY/rjGFFMo=
X-Google-Smtp-Source: AGHT+IE1UHu2Iz6/rzw1oAQlW0RzplKbWRBVQ87OCUNMfUgJ87knUf885VMLfNmlc5kbu574qoHHrA==
X-Received: by 2002:a05:600c:3591:b0:40c:700c:82cd with SMTP id
 p17-20020a05600c359100b0040c700c82cdmr2669012wmq.70.1702925504448; 
 Mon, 18 Dec 2023 10:51:44 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:44 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 11/12] hw/ppc/pegasos2: Let pegasos2 machine configure
 SuperI/O functions
Date: Mon, 18 Dec 2023 19:51:13 +0100
Message-ID: <20231218185114.119736-12-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218185114.119736-1-shentey@gmail.com>
References: <20231218185114.119736-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
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
functions the same way pegasos2.rom would do. For now the meantime this will be
a no-op.

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


