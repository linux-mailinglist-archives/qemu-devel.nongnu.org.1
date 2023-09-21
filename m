Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4E37A9478
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:02:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJJ8-0001WJ-0l; Thu, 21 Sep 2023 09:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjJCG-00024I-Fi
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:54:28 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjJBg-0000JS-SR
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:54:14 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c364fb8a4cso7916325ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695300823; x=1695905623;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M73QSY1PwikCSPSN92JeTu5YMo9ZU9R2zii9F7rQopk=;
 b=WO9z4DQYWrqt53KA9DQoG8S67AhxSHjuBlUzLA5fkCfMguyoBrcyHuSHpKmQWHtWh2
 P8CGgLY3Hsh/075K4uaWsjCAcpX2IX5AYplHPYMOBvEm98wUpGhRhp7BmY/cHeBqk3+o
 rzRSMO5+QOM4jji1xEB3BXnyrNdo0h6RAbhy3U1k0mhdxsSOqW7cRfkkypjQhozljKjg
 DVjNwAsSDFr5uz+pyzWAqSLKBg2AccoeYM3uW90Ixmz4CtCQ5jhI1pt1Yo5h2K5hj5fz
 he66pBlURVD6ki4wpVrYL7dTE6FqNR9SPNmvV8KouyMVpVPLpgMuSFoBixTC73h1zKfi
 Raow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695300823; x=1695905623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M73QSY1PwikCSPSN92JeTu5YMo9ZU9R2zii9F7rQopk=;
 b=C7ExoJsHAAInf0+x/zq89B62ymX6eQb/dbVHL3GzU6eaXceX7E8+XD6SoQmsJhx5jv
 uKMca+l8GS2I1AbweD4rfp/+kXAfITEnoCkeUS/EDzJ+jIjbh5ID1bbYQdR4xNTGzjcp
 zN+yp29u5/HrHL4CDKgaOXq7e+KjCrgjYqcwgBxSyJbMfm+4PI2P2dfxUcwsQi0HAzfJ
 y6wL/URI19dXYfANaCtGr74TX1emJHSX1STqQKvW71ya4RK30KJL5tN07KuqMr9IzFRK
 lkfQShXqoupOxppnTQdrOsLRxiqzS9szNS5EAjefeQOc/5426cHgBG/M5IyjAXQ5nd1S
 nj4A==
X-Gm-Message-State: AOJu0YwQEzFS/Vj2G+/u9ygESVtdSTzlG2oVrwLGHRaQ1nVfVfNydnvC
 G1TZDBTQoJQBcSykivdqjc+dudfypcAt9n0uZPI=
X-Google-Smtp-Source: AGHT+IEZaRn6WpKG0UzHflIwTO2bblGFBs1goXpQU2FHIiVhUiZDcgCx13HWOhvi1JtGUaHy4KuwDQ==
X-Received: by 2002:a17:902:c94b:b0:1c5:db4e:bb2c with SMTP id
 i11-20020a170902c94b00b001c5db4ebb2cmr690620pla.64.1695296811764; 
 Thu, 21 Sep 2023 04:46:51 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a170902740500b001c55d591f07sm1257392pll.260.2023.09.21.04.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 04:46:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2] amd_iommu: Fix APIC address check
Date: Thu, 21 Sep 2023 20:46:11 +0900
Message-ID: <20230921114612.40671-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

An MSI from I/O APIC may not exactly equal to APIC_DEFAULT_ADDRESS. In
fact, Windows 17763.3650 configures I/O APIC to set the dest_mode bit.
Cover the range assigned to APIC.

Fixes: 577c470f43 ("x86_iommu/amd: Prepare for interrupt remap support")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
V1 -> V2:
  Changed to check the whole access is contained in the range.
  Removed obsolete definitions.

 hw/i386/amd_iommu.h | 2 --
 hw/i386/amd_iommu.c | 9 ++-------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 3d430434fe..73619fe9ea 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -212,8 +212,6 @@
 #define AMDVI_INT_ADDR_FIRST    0xfee00000
 #define AMDVI_INT_ADDR_LAST     0xfeefffff
 #define AMDVI_INT_ADDR_SIZE     (AMDVI_INT_ADDR_LAST - AMDVI_INT_ADDR_FIRST + 1)
-#define AMDVI_MSI_ADDR_HI_MASK  (0xffffffff00000000ULL)
-#define AMDVI_MSI_ADDR_LO_MASK  (0x00000000ffffffffULL)
 
 /* SB IOAPIC is always on this device in AMD systems */
 #define AMDVI_IOAPIC_SB_DEVID   PCI_BUILD_BDF(0, PCI_DEVFN(0x14, 0))
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4655cd801f..598223dc65 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1262,13 +1262,8 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
         return -AMDVI_IR_ERR;
     }
 
-    if (origin->address & AMDVI_MSI_ADDR_HI_MASK) {
-        trace_amdvi_err("MSI address high 32 bits non-zero when "
-                        "Interrupt Remapping enabled.");
-        return -AMDVI_IR_ERR;
-    }
-
-    if ((origin->address & AMDVI_MSI_ADDR_LO_MASK) != APIC_DEFAULT_ADDRESS) {
+    if (origin->address < AMDVI_INT_ADDR_FIRST ||
+        origin->address + sizeof(origin->data) > AMDVI_INT_ADDR_LAST + 1) {
         trace_amdvi_err("MSI is not from IOAPIC.");
         return -AMDVI_IR_ERR;
     }
-- 
2.41.0


