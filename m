Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60190AA9A16
	for <lists+qemu-devel@lfdr.de>; Mon,  5 May 2025 19:06:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzF5-0005hz-HI; Mon, 05 May 2025 13:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzDw-0005He-Ja
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:28 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzDu-0003X2-DK
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:24 -0400
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2241053582dso70180585ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746464600; x=1747069400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znP4FxPlENxD30Bf7nTorAy2uIRHmCnpyNNFGgKW14I=;
 b=QApI7MJC5q71dH166YSlMY3xBSpyaifMkVHfOjswag7kVCvmoilti1JV+QPheOw4xD
 FxW3Naf2iaz13jpcXSVXVeYSOOwpVIZomR4kZyUyP7Z/REYv3hJBjQIN2DRyt4jRGwEx
 H2LZLFXMGIbXbWOGxIgnY6TqScu2TwbsaleVpt3/kbLZzAy7sBq3ocVIHxACzPCfE4OE
 wqkY3A9ZSqCuu53VoxSTOZSSreKy52p7GohZiZ+/HWdF+PUspsoLyL5VWWLBl3iTmlEb
 A9kctcR0gcWrM/8RN0x8IsFH1Gts1LCW7NfZZHj6AEQux78yIjZ6F2HQNnXfuYb1abOV
 LLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464600; x=1747069400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znP4FxPlENxD30Bf7nTorAy2uIRHmCnpyNNFGgKW14I=;
 b=be/w53Rzcel8sXSyCsWGyl8Raw0JrJxpLDAPTTTZlKkKGbolPExE0E6GcViNVa0siW
 fjQEOsX2Kzok6p9jbXunapG70npz7/GTenPzwb71hVWXo4UeSMHUS2sByzzZZ3Ae5ize
 bSoLfGkIDELxm746WRPQSnSa48KSSjWbhdLTtbcoBp8oQ+JheAsMCOmfkDRJ9SVwG93N
 HJ2DxWK2MwoynOOSi+A/xC76Q4ICINEn873xgPXysIiQ5uo2pgSDdN2k+kQL2AUqq79o
 vWF0WffZk7cPZzZBOZFIQhDpmVSelV7BO+9We51n2rAOWUf7R0te2AtuxwWz8/UFFBC+
 tk6A==
X-Gm-Message-State: AOJu0YysXlmMEdd5slOHZkmVXs1k/Lo5Zg6AnBKNsW2YKQD8t/SnQblm
 m6nTir58eG1ScPRN4eDJuOdCWlrARyoottYxckM6741lCNvB5ZaH8rj4YF3iGa+O
X-Gm-Gg: ASbGncuAVRPTaTYXAbu8NhlvzsX6db2iPRAiFDGS5ycKzK8/+KWkC0DiRy3qllY7WBX
 Rzlsz3QuKNDTbLhXsg7aWC1hnNmA15I/3w/SxAQFaVAWRPNVN/k7X8AcM37V01JHC9RGEoGiMT4
 FYDfxLcC3P8zVjoTxH+IXf0hJLrCzR9UEhRJF/Qqb7tXHtNiArJm2W/TLXPt2SyND3grE5qiXcS
 jSlGl7JQrQs8dU0WOzn0daurK/+iWSEAbr79fYdITdD8muNXDPjSh5hxlbdw1Q1i5tZYi09/w3J
 +rGnf83TbRZeUDY8w3jdBk5LvFRQTE9Uz7auWTVbbZLHwv6KEKm6p3cc
X-Google-Smtp-Source: AGHT+IEDpVHaar2T4k/78sSrhiYMDhVVUdA5PkwJmGCsYalCDdJhIUY1TERxFW6wXJfbo9KGnvVG5A==
X-Received: by 2002:a17:903:1d1:b0:22d:b305:e082 with SMTP id
 d9443c01a7336-22e3311e8c8mr1274905ad.47.1746464600136; 
 Mon, 05 May 2025 10:03:20 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e9e9dsm57335135ad.83.2025.05.05.10.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 10:03:19 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH v3 1/9] vfio/igd: Restrict legacy mode to Gen6-9 devices
Date: Tue,  6 May 2025 01:02:57 +0800
Message-ID: <20250505170305.23622-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505170305.23622-1-tomitamoeko@gmail.com>
References: <20250505170305.23622-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x642.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Intel only provides legacy VBIOS for IGD up to Gen9, and there is no
CSM support on later devices. Additionally, Seabios can only handle
32-bit BDSM register used until Gen9. Since legacy mode requires VGA
capability, restrict it to Gen6 through Gen9 devices.

Link: https://lore.kernel.org/qemu-devel/20250325172239.27926-1-tomitamoeko@gmail.com/T/
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 docs/igd-assign.txt | 1 +
 hw/vfio/igd.c       | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index 3aed7956d5..95beb76812 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -47,6 +47,7 @@ Intel document [1] shows how to dump VBIOS to file. For UEFI Option ROM, see
 
 QEMU also provides a "Legacy" mode that implicitly enables full functionality
 on IGD, it is automatically enabled when
+* IGD generation is 6 to 9 (Sandy Bridge to Comet Lake)
 * Machine type is i440fx
 * IGD is assigned to guest BDF 00:02.0
 * ROM BAR or romfile is present
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index d7e4728fdc..e06484c911 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -517,11 +517,13 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
     /*
      * For backward compatibility, enable legacy mode when
+     * - Device geneation is 6 to 9 (including both)
      * - Machine type is i440fx (pc_piix)
      * - IGD device is at guest BDF 00:02.0
      * - Not manually disabled by x-igd-legacy-mode=off
      */
     if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
+        (gen >= 6 && gen <= 9) &&
         !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
         (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
         0, PCI_DEVFN(0x2, 0)))) {
@@ -566,7 +568,9 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         vdev->features |= VFIO_FEATURE_ENABLE_IGD_LPC;
     } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
         error_setg(&err,
-                   "Machine is not i440fx or assigned BDF is not 00:02.0");
+                   "Machine is not i440fx, assigned BDF is not 00:02.0, "
+                   "or device %04x (gen %d) doesn't support legacy mode",
+                   vdev->device_id, gen);
         goto error;
     }
 
-- 
2.47.2


