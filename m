Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7D67435EB
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:38:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hO-00023q-6K; Fri, 30 Jun 2023 03:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hF-000232-Co
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:38 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hD-0005Pe-LJ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:37 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-98df6bc0048so182946966b.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110653; x=1690702653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rtJ3y6eIvCQ3GWIbAZbSOrnzKk4wFNnFByJB8omAiJU=;
 b=BYXhWi7zJJ1U515ad4My5PHxjy5vmdg4AfJZS7xKk9IIU4NC3ngdxOSBkIa3FCAr7R
 sMEl/FBlnRa1WEL5DjTZyZBLct3xEB2kdjBIN3KPbfxou4dso0oOCHB+whMGHS/Q/iBJ
 U1cpLrmnZFVtngS11egm59hKRpQGoEXgVDZkTEkTT/DWU11rSJD53MWyVo8mQEzkugW7
 tU5iQd535wbWKklIMHGAjDExfIY6cqK0PUVA+3vid1LfFdn2gld1+5WiwKCc110slgsB
 wGKuK1aXU/1LINDZTt6qkjGiTVId7qkfNb+ye8DMh8L+DSDK+f1o+WaEH4kOkCU70a6V
 4fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110653; x=1690702653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rtJ3y6eIvCQ3GWIbAZbSOrnzKk4wFNnFByJB8omAiJU=;
 b=mBbW/BCN1OHDvEN6hvW2mHI2Fc6FnTRFdkvcb0AAqDhbpC6F68UGnd0/S9rFbpJ0Ko
 EaXQV42KzAy+8jT5q8udWPmUc9Ha4a+HF+9yB3kICg11hIW0z0mae68ALsydhh6NtN6I
 N0OSf3jmbrXNadx0vpH7HDOPVmPawIoNuV3WiApoFP/Y6I230sLCwBq5N2CIKI+TEiSw
 4mxsAR1NwjGZ1AAuqwzxr04T0WJQ3qe7xBcLQRhh4XBlUgVpeLekrvwlQfGezvnGulkN
 V2scSb7d7nMugkyNoAwvmtqMOVDiwvUgZvVgONZrEUixG1yBxDcV9w7ghrkv2wWOcWb8
 61aw==
X-Gm-Message-State: ABy/qLYaM+TKtZV+w4vyssegurjP3Eg0J/SPk6/x8OglqKCbiyMTz0NA
 Uh++ny1Ej2K6p2i6KY3L1L7Q/H4QV30=
X-Google-Smtp-Source: APBJJlEZVfoFTQ9m3q/vjUKcc93qZdylhN3nPdm9tbphub81EuTbE72vI8qSevpgd9GEcMometMjZA==
X-Received: by 2002:a17:906:16c9:b0:991:e12e:9855 with SMTP id
 t9-20020a17090616c900b00991e12e9855mr1213591ejd.12.1688110653503; 
 Fri, 30 Jun 2023 00:37:33 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:33 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/17] hw/pci-host/q35: Initialize PCI_HOST_BYPASS_IOMMU
 property from board code
Date: Fri, 30 Jun 2023 09:37:08 +0200
Message-ID: <20230630073720.21297-6-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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

The Q35 PCI host already has a PCI_HOST_BYPASS_IOMMU property. However, the
host initializes this property itself by accessing global machine state,
thereby assuming it to be a PC machine. Avoid this by having board code
set this property.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c  | 2 ++
 hw/pci-host/q35.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4edc0b35f4..852250e8cb 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -230,6 +230,8 @@ static void pc_q35_init(MachineState *machine)
                             x86ms->below_4g_mem_size, NULL);
     object_property_set_int(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
                             x86ms->above_4g_mem_size, NULL);
+    object_property_set_bool(phb, PCI_HOST_BYPASS_IOMMU,
+                             pcms->default_bus_bypass_iommu, NULL);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 0604464074..d2830cee34 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -66,8 +66,7 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
                                 s->mch.pci_address_space,
                                 s->mch.address_space_io,
                                 0, TYPE_PCIE_BUS);
-    pci->bypass_iommu =
-        PC_MACHINE(qdev_get_machine())->default_bus_bypass_iommu;
+
     qdev_realize(DEVICE(&s->mch), BUS(pci->bus), &error_fatal);
 }
 
-- 
2.41.0


