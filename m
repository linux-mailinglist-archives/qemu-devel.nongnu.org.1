Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 359A074D5E2
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5W-000348-S7; Mon, 10 Jul 2023 08:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5I-0002kP-6W
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:46 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5G-0004ie-E7
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-666edfc50deso2797803b3a.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992419; x=1691584419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXe+2KFOeGwtoQqJS3myvFCpkWAdqzvjnCRCxb1hkgM=;
 b=E1VHk0zsk/FZc9qJGUdDEMrR8aBPoWTHLeyc9fTB1KkJfR/CehsgIf+iKSZKEghV3K
 r8miGqpzL8/AMj4KGtHLADjGI7IqLUNyC/830JmwDvRNFEyuiZTxanAooi/GVNu/LnGt
 O/KU9V4R3uklKFpt9Pxmr6RsxVXc9V6xwdyySoyOPUyL8mNiwf8qGMSBojX4D2XS02fa
 1dCQFsXFVCxZ3UcpqeFWadzgz+DJCx3N3M24aF2lduF4z4/bQOpLktnuGJw7Uc6kgHFt
 NetaZtVXtMuMP7Qs5oL6o99YdQ+ikO97LTLT9vKCLWlTj1baJDeV/DVdTEbajkGMIY7G
 04zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992419; x=1691584419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXe+2KFOeGwtoQqJS3myvFCpkWAdqzvjnCRCxb1hkgM=;
 b=bNV4Z+b6NZdR4q5kkWxJMqWFRPyiGz/s2GYMrXxw2jRHWT/i37RL1v5CqpvgOFF/RO
 IQY+F70T1jBtZQc1iup7dJQOrF+wYlnaAKh5GK380XjbrUpOAyuZOh6M47SRpF5lJzCd
 wkrYWOEp/Mbi0FzMGfu3+Ea27qesXAort2VSOXhCdM6quW40E4oppwh0+g3bqU2Cw1J7
 xUFhN7z/26ywP2RUgCRsJ0xrKhwkqdhTnNFAzxwOZBviXzaUnFKgSmfMzp99QKvI+JJu
 tJT1TWJRkXL5OvyVTbDGMuP1aXtWSKBat7abadIERJhhOHdPW7M80uqzBpuMA5vTKI4t
 lhOA==
X-Gm-Message-State: ABy/qLYai668KLKccp3vmd8nESzrSWpmq0MeaQ1VfCemvdP8SQSbN/24
 qE+cuQwpfi/Om9gN1qqwx9+Sn6/4uOM16Q==
X-Google-Smtp-Source: APBJJlFv0x5YgUo9TMyKZ6+/jwedEQLv2yDFy1Fu727j8gkjW3SS4SmzLVP40tgAR1AQC2jL0ksUCw==
X-Received: by 2002:a05:6a20:4325:b0:117:3c00:77ea with SMTP id
 h37-20020a056a20432500b001173c0077eamr18849681pzk.0.1688992419287; 
 Mon, 10 Jul 2023 05:33:39 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:38 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/54] hw/riscv/virt: Restrict ACLINT to TCG
Date: Mon, 10 Jul 2023 22:31:34 +1000
Message-Id: <20230710123205.2441106-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The Advanced Core Local Interruptor (ACLINT) device can
only be used with TCG. Check for TCG enabled instead of
KVM being not. Only add the property when TCG is used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230629121103.87733-3-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/virt.rst |  1 +
 hw/riscv/virt.c            | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index b33f45e5b3..f9a2eac544 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -93,6 +93,7 @@ The following machine-specific options are supported:
 
   When this option is "on", ACLINT devices will be emulated instead of
   SiFive CLINT. When not specified, this option is assumed to be "off".
+  This option is restricted to the TCG accelerator.
 
 - aia=[none|aplic|aplic-imsic]
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 68ccd0bde1..cdb88a1529 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -44,6 +44,7 @@
 #include "chardev/char.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tpm.h"
 #include "hw/pci/pci.h"
@@ -776,7 +777,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
 
         g_free(clust_name);
 
-        if (!kvm_enabled()) {
+        if (tcg_enabled()) {
             if (s->have_aclint) {
                 create_fdt_socket_aclint(s, memmap, socket,
                     &intc_phandles[phandle_pos]);
@@ -1370,7 +1371,7 @@ static void virt_machine_init(MachineState *machine)
                                 hart_count, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
 
-        if (!kvm_enabled()) {
+        if (tcg_enabled()) {
             if (s->have_aclint) {
                 if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
                     /* Per-socket ACLINT MTIMER */
@@ -1682,12 +1683,13 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
 
-    object_class_property_add_bool(oc, "aclint", virt_get_aclint,
-                                   virt_set_aclint);
-    object_class_property_set_description(oc, "aclint",
-                                          "Set on/off to enable/disable "
-                                          "emulating ACLINT devices");
-
+    if (tcg_enabled()) {
+        object_class_property_add_bool(oc, "aclint", virt_get_aclint,
+                                       virt_set_aclint);
+        object_class_property_set_description(oc, "aclint",
+                                              "Set on/off to enable/disable "
+                                              "emulating ACLINT devices");
+    }
     object_class_property_add_str(oc, "aia", virt_get_aia,
                                   virt_set_aia);
     object_class_property_set_description(oc, "aia",
-- 
2.40.1


