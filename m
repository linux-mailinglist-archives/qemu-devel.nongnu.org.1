Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CA67435F0
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:39:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hb-0002Bn-7f; Fri, 30 Jun 2023 03:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hQ-000273-Af
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:48 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hO-0005Rh-6g
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:47 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51dd0205b2cso2647758a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110664; x=1690702664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndPA1FIUJEV2rWOOZalHB3l5NHORSS3qaQKhdqZ2P3s=;
 b=Osc1Rjku8di3S6eH3U6TYvT3wOqmtSPOx85N1xociVpClwwsn6uIKZ84d+MqbcFfLK
 NU59oVunwKgGZuHu+dEyl30pStC64yIaFL+M991u4rZIkQqzummmoGQ9Y52cx28QPaIx
 hRr58C8zIUOUGR7yuy+iORBubZhQQUqX2hj4AJAGXACV+n7pGpTlDuGtXqHetoiqwhG9
 x8EdI30t+m5o0e61VVmbfyC0KVXCa9T9B0YbdyAXV1ZuBRhmJAqk3ZCctclTzEht2VrP
 EV4bo6KOGWV0b7tMsMGqVrG8U5WtRCvtkd2cVUo99m9U7PezEJo3sAaUAKvcYjPjNB/X
 CicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110664; x=1690702664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndPA1FIUJEV2rWOOZalHB3l5NHORSS3qaQKhdqZ2P3s=;
 b=cjxL7Vgjj3eWZCv65qU14vlHMZxLI6MWATZCefVy2k5IAfR1u4Okk8jPs/hSqQvL1U
 I2Xz+GflihvsW5/LkCoBrhY6fv0KtA3faZA6+sI+ZWhW+wp4vNaB4pJ326i3KaJE8oBB
 F26moHGwYn56z37osVMnh1lPEdN31qaS27IFJ4bA3cXzgraHQVs/heIbBQlWvszMHlxV
 A5Ho434mTXLLifZdSraNxpEQG4WXFOuqaVUHyjDKudi1C+EcJKZTMhgZjGily2Ctfqfj
 qDbD9o57jxOK+RSe34dKT5cLuuzQFWnc1OSNmQB1O2oEX+8lIgIb8XIwfs5w2WhWSxwu
 sC7A==
X-Gm-Message-State: ABy/qLabw50JhkoFRYzRGmxUPpCPd6VRZYNsyexBkeiKAizXvhqFyNNg
 g396wh4VlXm6OxedWvhIaJk0b3zDHEM=
X-Google-Smtp-Source: APBJJlF6bN/mchyT4AQ3+4fnOVb62EQgIQXK0g8A3tUXvRt4GS9UvngsU+626N59vrcW3A3J6oJ2kQ==
X-Received: by 2002:a17:906:10d9:b0:988:b61e:4219 with SMTP id
 v25-20020a17090610d900b00988b61e4219mr2267805ejv.29.1688110664299; 
 Fri, 30 Jun 2023 00:37:44 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:43 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 15/17] hw/pci-host/i440fx: Add I440FX_HOST_PROP_PCI_TYPE
 property
Date: Fri, 30 Jun 2023 09:37:18 +0200
Message-ID: <20230630073720.21297-16-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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

I440FX needs a different PCI device model if the "igd-passthru" property is
enabled. The type name is currently passed as a parameter to i440fx_init(). This
parameter will be replaced by a property assignment once i440fx_init() gets
resolved.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/pci-host/i440fx.h | 2 ++
 hw/pci-host/i440fx.c         | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
index 7e38456ebb..2d7bae5a45 100644
--- a/include/hw/pci-host/i440fx.h
+++ b/include/hw/pci-host/i440fx.h
@@ -15,6 +15,8 @@
 #include "hw/pci-host/pam.h"
 #include "qom/object.h"
 
+#define I440FX_HOST_PROP_PCI_TYPE "pci-type"
+
 #define TYPE_I440FX_PCI_HOST_BRIDGE "i440FX-pcihost"
 #define TYPE_I440FX_PCI_DEVICE "i440FX"
 
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 8731740a1b..c458987405 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -57,6 +57,8 @@ struct I440FXState {
     uint64_t pci_hole64_size;
     bool pci_hole64_fix;
     uint32_t short_root_bus;
+
+    char *pci_type;
 };
 
 #define I440FX_PAM      0x59
@@ -284,13 +286,14 @@ PCIBus *i440fx_init(const char *pci_type,
     s->ram_memory = ram_memory;
     s->below_4g_mem_size = below_4g_mem_size;
     s->above_4g_mem_size = above_4g_mem_size;
+    s->pci_type = (char *)pci_type;
 
     b = pci_root_bus_new(dev, NULL, s->pci_address_space,
                          s->io_memory, 0, TYPE_PCI_BUS);
     phb->bus = b;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    d = pci_create_simple(b, 0, pci_type);
+    d = pci_create_simple(b, 0, s->pci_type);
     f = I440FX_PCI_DEVICE(d);
 
     range_set_bounds(&s->pci_hole, s->below_4g_mem_size,
@@ -389,6 +392,7 @@ static Property i440fx_props[] = {
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, I440FXState,
                      above_4g_mem_size, 0),
     DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
+    DEFINE_PROP_STRING(I440FX_HOST_PROP_PCI_TYPE, I440FXState, pci_type),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


