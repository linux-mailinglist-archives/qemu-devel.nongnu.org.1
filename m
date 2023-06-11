Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BD072B161
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IP9-0006U8-SI; Sun, 11 Jun 2023 06:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP2-0006T3-Nk
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:34 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP1-0008Kd-4M
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:32 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5149aafef44so4817496a12.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479669; x=1689071669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJaXJsn8bgSZh3eHb64b3RyD+YkTvrHRTHchImKqFGA=;
 b=CU+/xq+LgpBHHWV+Mczek/h5GKqDmduGuYtlMa5C3ZzZoTJOSIdDE9nF2pqOx2Zt6S
 2pDR7LUKnoar1GhqTQt88k3uTGAPmVaHVZJqPpkJMuM0hZoBcpzsGjzGd/NTc35tVKKh
 ddQlMoN+8jzwNyiZJzy0oeEbEL0eErtH8g/sK+XdrFLDT5MlGtFvFX1jfsSypa6hwIi+
 5/C6Hfw+zqU5le/pJRVOIG/0EyvFffEHm3ML+rcJEAwWkMk/1cVvjJ8jwovDZGEEVGH4
 3LWL59hOnMPeTE8nhyfIkOHZ60CnEhtUHfg3sgyShotfKzrmTKYk3qRjAXT1yJa3QdtN
 2gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479669; x=1689071669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJaXJsn8bgSZh3eHb64b3RyD+YkTvrHRTHchImKqFGA=;
 b=ZtAUaW3xR9sb9XFyrITCSwYrD2Tnrc6P52xGhKWqhyrIbyR/aUaWWoy9GjJrz4m5eu
 xuP7Cb1y18PnGuVm1THlTud8nv2s3jVJO63E5t6AvbwAGrRc2/r3VpPwwWn1M+VgBT9q
 6RKp2aBA8+v7qmkcMQ/o0i4nbiurRjApcg418QKO6sH/RAyyIf2rxPHuozgqXwYndmjL
 FRxmdzpKvbeGEDt5UaaYmJl7OwtSqIw1MQgOG2V6H3PKJXhRQ8/izGtprO8JVhvTC2UD
 drc61OMteVNPtwmHzTY7EAUabbofAaNNNPGV1HaAqrMwptqSoD2bON7NIXW/FPwYzg6e
 P9fA==
X-Gm-Message-State: AC+VfDzZR9IsprL+mbprSpvttOwaoleypyQNoQLJCx/jF6KPnZ/F1BJf
 gLWRRdmYsSMiBcN8vbdxL7X/NPlkRig=
X-Google-Smtp-Source: ACHHUZ5vFSVp3HaFzL+AB2blfM+oKa/q6x80AZIwKa3Aq4vi75t4aNt53jW71Grn/dwTuAowDz6Biw==
X-Received: by 2002:a17:907:8a1a:b0:96f:bd84:b89c with SMTP id
 sc26-20020a1709078a1a00b0096fbd84b89cmr6258129ejc.70.1686479669141; 
 Sun, 11 Jun 2023 03:34:29 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:28 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 09/15] hw/pci-host/i440fx: Move i440fx_realize() into
 PCII440FXState section
Date: Sun, 11 Jun 2023 12:34:06 +0200
Message-ID: <20230611103412.12109-10-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
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

i440fx_realize() realizes the PCI device inside the host bridge
(PCII440FXState), but is implemented between i440fx_pcihost_realize() and
i440fx_init() which deal with the host bridge itself (I440FXState). Since we
want to append i440fx_init() to i440fx_pcihost_realize() later let's move
i440fx_realize() out of the way.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/i440fx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 88beaf99c4..9df4688b2e 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -65,6 +65,15 @@ struct I440FXState {
  */
 #define I440FX_COREBOOT_RAM_SIZE 0x57
 
+static void i440fx_realize(PCIDevice *dev, Error **errp)
+{
+    dev->config[I440FX_SMRAM] = 0x02;
+
+    if (object_property_get_bool(qdev_get_machine(), "iommu", NULL)) {
+        warn_report("i440fx doesn't support emulated iommu");
+    }
+}
+
 static void i440fx_update_memory_mappings(PCII440FXState *d)
 {
     int i;
@@ -229,15 +238,6 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
     memory_region_add_coalescing(&phb->conf_mem, 0, 4);
 }
 
-static void i440fx_realize(PCIDevice *dev, Error **errp)
-{
-    dev->config[I440FX_SMRAM] = 0x02;
-
-    if (object_property_get_bool(qdev_get_machine(), "iommu", NULL)) {
-        warn_report("i440fx doesn't support emulated iommu");
-    }
-}
-
 PCIBus *i440fx_init(const char *pci_type,
                     DeviceState *dev,
                     MemoryRegion *address_space_mem,
-- 
2.41.0


