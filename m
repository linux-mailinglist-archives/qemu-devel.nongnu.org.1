Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1707974AFE1
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:33:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhZ-0002oI-Qn; Fri, 07 Jul 2023 07:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhW-0002m9-Df; Fri, 07 Jul 2023 07:32:38 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhU-0006kh-LC; Fri, 07 Jul 2023 07:32:38 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6b74791c948so1606440a34.3; 
 Fri, 07 Jul 2023 04:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729555; x=1691321555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPjUOtCD84w10qELyt0qe87fJKtpLjWmbdvyadBcP58=;
 b=izgrqKmf9/U2sSNqFy/O/XmsQPiMIGDO4OrwTg+oTdVcYWPAH2APcjx+164koeo01J
 8w+/ZozEBaNI9d2As+Hnp2z2MhwFhdF4aVEf3rTTBQjwuvAaDlNrimbibLj5UJBJLjR1
 n3hn7lqrc67HP0bWV91zSy8efjvnqACuib63nxW69+ziMHN2yKw/Ol/VyDyLyDCGHZYf
 sySspSWZMvqxQqNoIWzQznad+rfCwUW37IO6LSs02uIQ4rpjyXCk3OBy9HPavY/Sb8gt
 kmBM5M1XLDPxQJG+0TytiC/SDnVGU3k86lOsMZWS/L539uq8E0gmoM4n02MMQnbzAUX2
 RYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729555; x=1691321555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPjUOtCD84w10qELyt0qe87fJKtpLjWmbdvyadBcP58=;
 b=RLvT9ZyL+DSbldvVEnFNoHIwd+4VC4+ZrTImedUB9RiMI2DIgUGKRHVBpoHCPE+q0/
 TRKOKYpBv18eYW21UNgtyssGCRAg797h15S6+wUAk+vmxi0C2odvebuaRcUwrhwORzEd
 PPqLKLGvOMPSntCFg7X8bwp5F+Ui4THVDGccAHjBOvalY3RFF4k+gGkhwjF7BQLVQ9qN
 9CDdl37UFF8eEHnfeIkIEE5fFgUu/c4o00MXSkCeuuFEQ9eBn8unJnhunDxgsdFxsUJM
 pVpdUUBrA2+DtqMMML3gNdzLvigEfgiAyyAfmDBCBt9059Sh4eriH2lzZEm0ugI/yzIz
 01lA==
X-Gm-Message-State: ABy/qLaGUgRwrBXkHexFUj954fKevctqT/5+l5LfE79eCkphKcJAJXCn
 dDTFyrLDcrLzSFCH5GNao7h0WdGm52A=
X-Google-Smtp-Source: APBJJlFig9Ze1iAuEQBLnT2spMj6VKyilqaKwU7/8u8mL362R54HclaV0P62hE3Cu3un4bp4qJ9+HQ==
X-Received: by 2002:a9d:76c2:0:b0:6af:9f36:fae4 with SMTP id
 p2-20020a9d76c2000000b006af9f36fae4mr4861235otl.10.1688729555075; 
 Fri, 07 Jul 2023 04:32:35 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:34 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 28/60] ppc/pegasos2: Add support for -initrd command line option
Date: Fri,  7 Jul 2023 08:30:36 -0300
Message-ID: <20230707113108.7145-29-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x330.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This also changes type of sz local variable to ssize_t because it is
used to store return value of load_elf() and load_image_targphys() that
return ssize_t.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <20230704181920.27B58746335@zero.eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pegasos2.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index af5489de26..9c9944188b 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -44,6 +44,8 @@
 #define PROM_ADDR     0xfff00000
 #define PROM_SIZE     0x80000
 
+#define INITRD_MIN_ADDR 0x600000
+
 #define KVMPPC_HCALL_BASE    0xf000
 #define KVMPPC_H_RTAS        (KVMPPC_HCALL_BASE + 0x0)
 #define KVMPPC_H_VOF_CLIENT  (KVMPPC_HCALL_BASE + 0x5)
@@ -80,6 +82,8 @@ struct Pegasos2MachineState {
     uint64_t kernel_addr;
     uint64_t kernel_entry;
     uint64_t kernel_size;
+    uint64_t initrd_addr;
+    uint64_t initrd_size;
 };
 
 static void *build_fdt(MachineState *machine, int *fdt_size);
@@ -117,7 +121,8 @@ static void pegasos2_init(MachineState *machine)
     I2CBus *i2c_bus;
     const char *fwname = machine->firmware ?: PROM_FILENAME;
     char *filename;
-    int i, sz;
+    int i;
+    ssize_t sz;
     uint8_t *spd_data;
 
     /* init CPU */
@@ -213,6 +218,20 @@ static void pegasos2_init(MachineState *machine)
         warn_report("Using Virtual OpenFirmware but no -kernel option.");
     }
 
+    if (machine->initrd_filename) {
+        pm->initrd_addr = pm->kernel_addr + pm->kernel_size + 64 * KiB;
+        pm->initrd_addr = ROUND_UP(pm->initrd_addr, 4);
+        pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
+        sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
+                                 machine->ram_size - pm->initrd_addr);
+        if (sz <= 0) {
+            error_report("Could not load initrd '%s'",
+                         machine->initrd_filename);
+            exit(1);
+        }
+        pm->initrd_size = sz;
+    }
+
     if (!pm->vof && machine->kernel_cmdline && machine->kernel_cmdline[0]) {
         warn_report("Option -append may be ineffective with -bios.");
     }
@@ -335,6 +354,11 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
         error_report("Memory for kernel is in use");
         exit(1);
     }
+    if (pm->initrd_size &&
+        vof_claim(pm->vof, pm->initrd_addr, pm->initrd_size, 0) == -1) {
+        error_report("Memory for initrd is in use");
+        exit(1);
+    }
     fdt = build_fdt(machine, &sz);
     /* FIXME: VOF assumes entry is same as load address */
     d[0] = cpu_to_be64(pm->kernel_entry);
@@ -966,6 +990,12 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     qemu_fdt_setprop_string(fdt, "/memory@0", "name", "memory");
 
     qemu_fdt_add_subnode(fdt, "/chosen");
+    if (pm->initrd_addr && pm->initrd_size) {
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+                              pm->initrd_addr + pm->initrd_size);
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
+                              pm->initrd_addr);
+    }
     qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                             machine->kernel_cmdline ?: "");
     qemu_fdt_setprop_string(fdt, "/chosen", "name", "chosen");
-- 
2.41.0


