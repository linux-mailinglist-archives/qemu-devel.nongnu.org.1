Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4A27793C6
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUb2-0007EJ-1d; Fri, 11 Aug 2023 12:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qUUb0-000797-DX
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:02:38 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qUUay-0008PS-O3
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:02:38 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a76cbd4bbfso1964555b6e.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1691769755; x=1692374555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNkV73nBOn2NJCSOY1LvGtGzf0pJiCHbvNBgBai2cTI=;
 b=AZyLXSLaJU6r+ZOXVAhiXB8zoyRQ03yOOF1pqVYtwmTnrVZ+dNSaBKFG7DAbuiqWoc
 smToi/uV8pArTnW/cCmfGdqvuEzEMVhwtLlfKF2IWwS31UL46867Fhh9UgecbLuj0Y3I
 Kdn9D0bPMyfiGGVaG6pHHhzBAbe02S/Ll1XoDDPP/Q8r2LVMie+P8cuyGr8K6Z+HUhJ8
 klWdD3vPwda3wLkPTaqCAa0bwJ7UaaaoyGv1quLuiQrdAjcUP68F14iVAXZaFdyR0pym
 iDPnIkQMPi1ehndLQY60Zb7nKxG1h/7iWDASHdHMDp3an2u8QmKmO+3yNmhfZQeXUZZg
 R3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691769755; x=1692374555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JNkV73nBOn2NJCSOY1LvGtGzf0pJiCHbvNBgBai2cTI=;
 b=E7be0w0JmO1gPDf0lFIw8pk6/rJuOAiK2AMUv2k2myeNeURXJrqtNEcdIyWZXneevj
 QFzebCJoLziUOjXBhvyMoVTebu9rEbcmuAzOevTcUaDPUOZ2mLKcHRQ+3kaL7BiCKudw
 rjSIUTLAKjsKv6dkckEtEjgVDzIDgLT/7KukVI+pl8R1M/yxhzMMBdx+qr+tNtPicx3S
 sLVyDcycq2DDvSUamwsdYFkFV8n04E31Sk2UocvvOykQ62joq0R/c6+Za6qrellL2UGD
 56EZVVS5IjcSK0agMxAYi7H5zH1QFmNuPJBQKjj5szHYOeB5zGYlUYj9cpycT099vmTH
 zP/A==
X-Gm-Message-State: AOJu0YwjU3sGZ9iJo6RD3C0lTUNs0DotRP1nT+R+haD7qkxWxl0abU7m
 haiCkmN8Yn94al3KF0vPbdSRq9FH04sGDj+aObgGgw==
X-Google-Smtp-Source: AGHT+IGr7diEABTVhwwOzMLCTs8OwbGQTwhYHIdBd9KAvDjJcL+/KUXsZmsRlDUtCt/JWqwzEUvIhw==
X-Received: by 2002:a05:6808:144d:b0:3a7:1e3e:7f97 with SMTP id
 x13-20020a056808144d00b003a71e3e7f97mr3635255oiv.4.1691769755058; 
 Fri, 11 Aug 2023 09:02:35 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 bj32-20020a05680819a000b003a43759b9cdsm1834823oib.29.2023.08.11.09.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:02:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.1 1/1] hw/riscv/virt.c: change 'aclint' TCG check
Date: Fri, 11 Aug 2023 13:02:24 -0300
Message-ID: <20230811160224.440697-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811160224.440697-1-dbarboza@ventanamicro.com>
References: <20230811160224.440697-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The 'aclint' property is being conditioned with tcg acceleration in
virt_machine_class_init(). But acceleration code starts later than the
class init of the board, meaning that tcg_enabled() will be always be
false during class_init(), and the option is never being declared even
when declaring TCG accel:

$ ./build/qemu-system-riscv64 -M virt,accel=tcg,aclint=on
qemu-system-riscv64: Property 'virt-machine.aclint' not found

Fix it by moving the check from class_init() to machine_init(). Tune the
description to mention that the option is TCG only.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Fixes: c0716c81b ("hw/riscv/virt: Restrict ACLINT to TCG")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1823
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d90286dc46..99c4e6314b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1350,6 +1350,11 @@ static void virt_machine_init(MachineState *machine)
         exit(1);
     }
 
+    if (!tcg_enabled() && s->have_aclint) {
+        error_report("'aclint' is only available with TCG acceleration");
+        exit(1);
+    }
+
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
@@ -1683,13 +1688,14 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
 
-    if (tcg_enabled()) {
-        object_class_property_add_bool(oc, "aclint", virt_get_aclint,
-                                       virt_set_aclint);
-        object_class_property_set_description(oc, "aclint",
-                                              "Set on/off to enable/disable "
-                                              "emulating ACLINT devices");
-    }
+
+    object_class_property_add_bool(oc, "aclint", virt_get_aclint,
+                                   virt_set_aclint);
+    object_class_property_set_description(oc, "aclint",
+                                          "(TCG only) Set on/off to "
+                                          "enable/disable emulating "
+                                          "ACLINT devices");
+
     object_class_property_add_str(oc, "aia", virt_get_aia,
                                   virt_set_aia);
     object_class_property_set_description(oc, "aia",
-- 
2.41.0


