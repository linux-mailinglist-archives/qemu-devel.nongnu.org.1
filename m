Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE63C779716
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 20:26:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUWpF-0002No-B1; Fri, 11 Aug 2023 14:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qUWpD-0002Mj-AK
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 14:25:27 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qUWpA-0003oX-DF
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 14:25:27 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-79d8edd6d99so750703241.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691778306; x=1692383106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xNoSfbOUSMZ0uPLpFeXZj/thZpSQpdkJJbUVXjq2Rnk=;
 b=dMGlE8xjtJiwfTcstFOh5yu/NaOSNFCr6HqmuQ8Ji506BpNzleuksSmudLTtgCMzaQ
 oUp8fZXytYHYGK7Z6PmLVDV7eiQa7iEor32zuPl0/eZSGLDNBkzftA7P5U0ykpmWUhaY
 Gf71NtsIzQBFLGLQ/h/pqMg6rZxGjvum+fpDtE9OTTLKvLFEuSjpTsKHCxyhusT5cLmy
 785Eqv3CDQ40HUWSg1s/cp1ztlM6ptTxkwAI4E0HcmaJVRCpqHT1/b6kw9codWPw25YN
 Q35mmtAsNhoGmyP8M5YzwyGwW8lLYoEJrdY6V2Ff6CjtmwIUsPLLWJG9/RmrsWyPYZa3
 alkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691778306; x=1692383106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xNoSfbOUSMZ0uPLpFeXZj/thZpSQpdkJJbUVXjq2Rnk=;
 b=j+C/kmIqC93dTFqZIFVzyU+kEs3w3CfZ3XQgVTf5m6UkYSXtrDHiEvHDzS+RSRw42P
 vaEBkJuybBb68bv8iUqFcqEcimVU2h6uMuLG633khqsN8pK0/vLEg4Kola3a0J3obpXK
 b7qhLZp2Ya/Nt3oNnpN4xZG5nkigbPYDffl5Axx2s+CLr5v1DQNTwUCRGXD3RMfzAvqc
 N8WLKHHcY5C+nDuUp6aYaZQ9u9DsTyxhCnGJoZbaj597PgaPheqxBr4W+5Cytjrwe9Cr
 Eu8EDIhz/Jeg8eFPkwrw3ICEFtcfWOdYLQN3Rcpr0w/7KgPfZB+PO6Z31I9EOr2Ii/20
 vL/g==
X-Gm-Message-State: AOJu0YxdtWo2BzFLpb6EpxOXpdwDDBjWOM7IQGJw3kgoOE562Pqd1KNp
 KW6AOYL3+XvJeltiimciZMs+3IDP53dzm5bN
X-Google-Smtp-Source: AGHT+IEhu7LvbA82YYvDcAG6gHk4ENkcqJ1Kkz/QqOEwQS8Y+hscXPJJ6+hBSwC6Eildlp9Vh+rqDA==
X-Received: by 2002:a67:f80d:0:b0:443:6deb:2b4 with SMTP id
 l13-20020a67f80d000000b004436deb02b4mr2738910vso.2.1691778306537; 
 Fri, 11 Aug 2023 11:25:06 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
 by smtp.gmail.com with ESMTPSA id
 g30-20020ab016de000000b007876731f2dbsm638234uaf.22.2023.08.11.11.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 11:25:06 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 2/2] hw/riscv/virt.c: change 'aclint' TCG check
Date: Fri, 11 Aug 2023 14:24:45 -0400
Message-ID: <20230811182445.1185140-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811182445.1185140-1-alistair.francis@wdc.com>
References: <20230811182445.1185140-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230811160224.440697-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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


