Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8508374D593
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:35:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5z-0004N9-Ia; Mon, 10 Jul 2023 08:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5q-00040G-8B
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:19 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5o-0004rF-CA
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:17 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-345f1e0abf9so15639115ab.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992454; x=1691584454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnVxlrmjfp+ZpMlMfbIQ2HaKzgvgpBLthFySyNg97oQ=;
 b=IFhhx3R5DSNuvcjpA9CJLL0DYUOVBy7F/BTDeZFO+UC8foCiQYsto+3CPBIQou3gOj
 zdBkahuiN239dXYjOGgoXNOn4Fbw9lPRZoOh5i8V32PZiasyuKSjcl6w8h94iY/RhJZn
 /s1qgyraC3PHI02yRfYCTnOFu8gpjTmawvY4cKposWrSsrMc33Y83KbA+mlgdsyFNRGE
 2tuVvPc3zxB6LDcFvmvUEm4eYaPYVSnMQ0hYvwa799UyxU6dHyOBZ756CqBO+Cjyk9Bz
 lR32ZQQO3Tr4k3l6Y1vd3/f9bKtgd7jWXZSJhMWXsbG68yCWaaVJa1JSdK4BCaKf/Iwl
 CIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992454; x=1691584454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnVxlrmjfp+ZpMlMfbIQ2HaKzgvgpBLthFySyNg97oQ=;
 b=kVG1HUuXizaOh8xwgzdFdodRS4MCj7FK9KW899KBFzS8pzAabujl9ar9t82C5kO4iu
 5vB3aRi2OZknypI/pc2Vn1g/zunVW561wgBwgkmryaxCtNJLWiPM1oaa7aRkHg4qlFuZ
 R+66SH04IeZWHpZ42r/Ed1XhjKSLrw9F9reV6TtNFk0Vu3WvjDxtUDoL0AaPryyXbmQr
 taxfFtt2YqSrGIIYBiMk6TB8fuAz2FOppGzKH76lX7OY7ha3EOAJkcCeThsw9O/G/Iws
 J70+uqzSjviScvj0sCtv+m5ljg5lSiIl+rnSDbsgQS0y9gUgwKb6e8O/88NkLDKhAf4J
 dk2g==
X-Gm-Message-State: ABy/qLaFrLFv1VrIPH/lmv0V/+du6LGWx1WS5agPDFtEJtUdo/botemP
 Tc8VBTtdD980tf+5/JCMg6ySCMv26RjZaw==
X-Google-Smtp-Source: APBJJlGO2IkN6J29vsEyW7L9AM9xS8fTSU3v5AsL209jUtUN1jy4GlliQXCD32VLWxRx92/pRefk9A==
X-Received: by 2002:a92:dccb:0:b0:345:dd77:8ab9 with SMTP id
 b11-20020a92dccb000000b00345dd778ab9mr11569030ilr.11.1688992454661; 
 Mon, 10 Jul 2023 05:34:14 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:34:14 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Guenter Roeck <linux@roeck-us.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.c>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/54] riscv: Generate devicetree only after machine
 initialization is complete
Date: Mon, 10 Jul 2023 22:31:44 +1000
Message-Id: <20230710123205.2441106-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Guenter Roeck <linux@roeck-us.net>

If the devicetree is created before machine initialization is complete,
it misses dynamic devices. Specifically, the tpm device is not added
to the devicetree file and is therefore not instantiated in Linux.
Load/create devicetree in virt_machine_done() to solve the problem.

Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.c>
Fixes: 325b7c4e75 hw/riscv: Enable TPM backends
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230706035937.1870483-1-linux@roeck-us.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cdb88a1529..96b01703a9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1249,6 +1249,17 @@ static void virt_machine_done(Notifier *notifier, void *data)
     uint64_t kernel_entry = 0;
     BlockBackend *pflash_blk0;
 
+    /* load/create device tree */
+    if (machine->dtb) {
+        machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
+        if (!machine->fdt) {
+            error_report("load_device_tree() failed");
+            exit(1);
+        }
+    } else {
+        create_fdt(s, memmap);
+    }
+
     /*
      * Only direct boot kernel is currently supported for KVM VM,
      * so the "-bios" parameter is not supported when KVM is enabled.
@@ -1509,17 +1520,6 @@ static void virt_machine_init(MachineState *machine)
     }
     virt_flash_map(s, system_memory);
 
-    /* load/create device tree */
-    if (machine->dtb) {
-        machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
-        if (!machine->fdt) {
-            error_report("load_device_tree() failed");
-            exit(1);
-        }
-    } else {
-        create_fdt(s, memmap);
-    }
-
     s->machine_done.notify = virt_machine_done;
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
-- 
2.40.1


