Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 783E173E066
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:19:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlML-0004WL-KV; Mon, 26 Jun 2023 08:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLU-0002ud-Rx
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLS-00036X-CP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/UK6aQi1zp/6MKRVyY3fLV1bQBOfN+OI1GJ+WI2VHU=;
 b=UbiQM+Nz+RZnYjyib34D1jANsJ8L46RWWhTmQrXkG43vjtyBMsZ+majZGqpTn3a6p+b4Ue
 dc/lE49StefqX5HIj1XeEOdr5eNSzGIfT9x9f8IjCyMD3OPMMb43oNKaqREc51sWZmoJON
 Pn/TlkShDZrLl8+2I+g3m35a2o4Xv7I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-XH8wV9X0NXSD-jPqPVMDiQ-1; Mon, 26 Jun 2023 08:29:24 -0400
X-MC-Unique: XH8wV9X0NXSD-jPqPVMDiQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4ecb00906d0so2231990e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782563; x=1690374563;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/UK6aQi1zp/6MKRVyY3fLV1bQBOfN+OI1GJ+WI2VHU=;
 b=aue3879HYlogO9sR3eX1AfIV+SHP32vh2nRNmP3D0cN8IuxQ/WlEPSPDbZIUEH/8u/
 UUJqYJCP56h25mxAlAeuuR0mdX4u6ILcgLyYBqfLmiLc1iax8kUcW8NI0A2xo9seBLz7
 BjsWiOfvKF2WuVzo/81n7XFEzjCPiLOfnbrERHl3NJhjYojF+a2cNL5Ia3MQVDGWQgPU
 5bH2XYYiA7aKVGYiu76U9j8m8Pe4Xf9X9j4SNQoBV3rEoREefkBtnQOKQ1ozhKfu+2L0
 ztqSwAvw97DLsOItUTcnerJiaRTEsK0kKN/BClxF351orB+FXlBPm9x+nGN8RK87DANI
 8FWA==
X-Gm-Message-State: AC+VfDznnjgoIA0oE8vrFXLmfDRctUHWWcSdF4pjVxBgj7cwdY3YUhJW
 cMSYwhpoVGMOPuihNncRBko/BJi/GL+1vDvLFe1CbOSZGTtxfLlgHuoczIhIdpuKZquLi1KjsQo
 xaKZ8V5LfY2fgO0rmXe5rO7eTIqpc7EGo2++avmEckvQPSNpqBjdZ2pxvHqR2DB6vyNsZ
X-Received: by 2002:a05:6512:39cc:b0:4f9:652d:e839 with SMTP id
 k12-20020a05651239cc00b004f9652de839mr8404629lfu.50.1687782562724; 
 Mon, 26 Jun 2023 05:29:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6JYEqCW8s6dsRVRA89s0FV/LBfa6EoiScvesSPBx1SSIjHaFAakeJgH6TR41K73XcLUeRq3w==
X-Received: by 2002:a05:6512:39cc:b0:4f9:652d:e839 with SMTP id
 k12-20020a05651239cc00b004f9652de839mr8404614lfu.50.1687782562361; 
 Mon, 26 Jun 2023 05:29:22 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 v14-20020a1cf70e000000b003f9b2c602c0sm10542462wmh.37.2023.06.26.05.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:21 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 30/53] hw/acpi: Fix PM control register access
Message-ID: <3d563fc68732179b86eff2b87f2d7dbef150315f.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On pegasos2 which has ACPI as part of VT8231 south bridge the board
firmware writes PM control register by accessing the second byte so
addr will be 1. This wasn't handled correctly and the write went to
addr 0 instead. Remove the acpi_pm1_cnt_write() function which is used
only once and does not take addr into account and handle non-zero
address in acpi_pm_cnt_{read|write}. This fixes ACPI shutdown with
pegasos2 firmware.

The issue below is possibly related to the same memory core bug.

Link: https://gitlab.com/qemu-project/qemu/-/issues/360
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20230607200125.A9988746377@zero.eik.bme.hu>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/core.c | 56 +++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 6da275c599..00b1e79a30 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -551,8 +551,35 @@ void acpi_pm_tmr_reset(ACPIREGS *ar)
 }
 
 /* ACPI PM1aCNT */
-static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
+void acpi_pm1_cnt_update(ACPIREGS *ar,
+                         bool sci_enable, bool sci_disable)
 {
+    /* ACPI specs 3.0, 4.7.2.5 */
+    if (ar->pm1.cnt.acpi_only) {
+        return;
+    }
+
+    if (sci_enable) {
+        ar->pm1.cnt.cnt |= ACPI_BITMASK_SCI_ENABLE;
+    } else if (sci_disable) {
+        ar->pm1.cnt.cnt &= ~ACPI_BITMASK_SCI_ENABLE;
+    }
+}
+
+static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
+{
+    ACPIREGS *ar = opaque;
+    return ar->pm1.cnt.cnt >> addr * 8;
+}
+
+static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned width)
+{
+    ACPIREGS *ar = opaque;
+
+    if (addr == 1) {
+        val = val << 8 | (ar->pm1.cnt.cnt & 0xff);
+    }
     ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
 
     if (val & ACPI_BITMASK_SLEEP_ENABLE) {
@@ -575,33 +602,6 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
     }
 }
 
-void acpi_pm1_cnt_update(ACPIREGS *ar,
-                         bool sci_enable, bool sci_disable)
-{
-    /* ACPI specs 3.0, 4.7.2.5 */
-    if (ar->pm1.cnt.acpi_only) {
-        return;
-    }
-
-    if (sci_enable) {
-        ar->pm1.cnt.cnt |= ACPI_BITMASK_SCI_ENABLE;
-    } else if (sci_disable) {
-        ar->pm1.cnt.cnt &= ~ACPI_BITMASK_SCI_ENABLE;
-    }
-}
-
-static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
-{
-    ACPIREGS *ar = opaque;
-    return ar->pm1.cnt.cnt;
-}
-
-static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
-                              unsigned width)
-{
-    acpi_pm1_cnt_write(opaque, val);
-}
-
 static const MemoryRegionOps acpi_pm_cnt_ops = {
     .read = acpi_pm_cnt_read,
     .write = acpi_pm_cnt_write,
-- 
MST


