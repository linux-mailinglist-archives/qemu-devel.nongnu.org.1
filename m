Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A6B741918
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:54:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDI-0004j6-Ig; Wed, 28 Jun 2023 15:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDB-0004gQ-Ce
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:21 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbD9-0005iL-P6
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:21 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b6a152a933so3318611fa.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981938; x=1690573938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rtJ3y6eIvCQ3GWIbAZbSOrnzKk4wFNnFByJB8omAiJU=;
 b=ZC/Xsx5/QQOSSWgdWPF/3jl6ZZXO7ysNyR7PaPM4w1GbIvWcUrMIxRCHMO+5aBKW1J
 IBYiKDlzY/JIsNLmsgzI10AJqUZD3xmWHnnHD1S9ag9XRKpFmmrp3/b9RQ/nUywcTdwV
 qn4agobHIYL2x2IgwyYQ59OzNiAnPLncOMnZBy9jvwnY9MxraSf9Xzj3of5tY7b2oL8v
 Q1Mu7IeD2W/rroHIsDMgOyUtSDQOEj21qeYkqcuOGhpG+jBTn21z0sw2eduQjdEJpSa6
 3EJgdahxPRgvuhydsQ2fitllyGMaVWYjxCBZbFXs39jcO0GKa7NcOkr310MGGhLYrI1C
 XpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981938; x=1690573938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rtJ3y6eIvCQ3GWIbAZbSOrnzKk4wFNnFByJB8omAiJU=;
 b=U1NbswwjaeO7Wo5olJlSuv1IL0wqarEgyIbn5lBmMEaTg7nmMRHxZcijwndBv59fjx
 3DHEahauufi+VS0TEVRJdLKzFjaFG1fyaxC/sOZvhk7bdqujta/e9gE75IsLm6sB1xlj
 rcJE1H3F11QqrEwLNdlk5+crylFK5WUC1jNuvfjAizoPVHcifJ/vSEAF9FJWWD3nChXX
 beSEj5d8y1RyxW57GPWCnnLkMsDlxx9rGqEvlyLBjV73PTzF/5ZPsDhqgS0E6lu7ACP/
 ESWQbllfpJavyuIGIm8lO7ofo0rEt7uiQFclxMMNg2RyTKpgv5x3rk40OsHkPui9vVdL
 V59A==
X-Gm-Message-State: AC+VfDwVvLyY8eRar3QaODbK7c2pl0uWGCmQaq8x9D1x79XR3xEY7ILc
 MZz7+wfdYlMAr9SEspIvIYFWEFp9/o0=
X-Google-Smtp-Source: ACHHUZ5LnvxeG3A+9dPam1D2a0NQlXIQSXqx7QKUujZZfDMC/xoKzs/pQt7SUu8aQ3nJkqH21ryphQ==
X-Received: by 2002:a2e:8443:0:b0:2b1:edfe:8171 with SMTP id
 u3-20020a2e8443000000b002b1edfe8171mr21950229ljh.36.1687981937707; 
 Wed, 28 Jun 2023 12:52:17 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:17 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/16] hw/pci-host/q35: Initialize PCI_HOST_BYPASS_IOMMU
 property from board code
Date: Wed, 28 Jun 2023 21:51:53 +0200
Message-ID: <20230628195204.1241-6-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x22c.google.com
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


