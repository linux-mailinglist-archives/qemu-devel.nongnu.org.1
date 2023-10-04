Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0B27B7A96
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxYE-0003ET-4g; Wed, 04 Oct 2023 04:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWn-0000X0-Ge
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWd-0002Z0-GE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paof42DUy5YVFM8ix/mc19HfT2JnvVvvPuSSyPQvY8Q=;
 b=Y6TOOfjENjzFMd+2AupPcUK+8kYWTPvJj/+C4cOf79adhR8CvYubjMo2U6PBznRoKrhUMZ
 3cbmMCZ44YJ/ECJ7XKdfPAhaXAQMIme0CDI8Wz1bhUnzzQFLtiBacGOBkpdfvjaMPc3dAG
 UM04R33+uqjTnHqpHnQ8Xa0WAdXHMQg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-y8YvC0pOPtKWcuOXb51yfw-1; Wed, 04 Oct 2023 04:46:04 -0400
X-MC-Unique: y8YvC0pOPtKWcuOXb51yfw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3217fdf913dso1400432f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409163; x=1697013963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paof42DUy5YVFM8ix/mc19HfT2JnvVvvPuSSyPQvY8Q=;
 b=EL7KPOjDIbsxjtau7dIuHTn3/CJgZYZfWpl3KfmshA3XqMbxBQ6ljidVpes1cI/WtE
 PAxNOzjYm1Mhu/llqVrN/m40f1onsd1WgPGE0gRFjmy1zXHie46QP6RCzKd9reii4rlr
 5ojJXBbko2ZvLirmNYYjXQdJQOZA0xSPiC7e5KC6X5Ao0ZwGmEJEJOuCaCpJgKiFziLt
 L2COZsrgfeD50eQdjzExORjfaHwkXhRpjBxa4sqfTeBGstGKffpTpQh1elVoiQKGGH/k
 VySoHmczxDr7Eki4i9RQyczoPYSwlXyQeRm7MnwKY7urXzscWJs35vlRV5GmK9tqMHbz
 uZvw==
X-Gm-Message-State: AOJu0YzhBIAHawb9yGcCbqS2wdv0siH+Qs3O0vCUrDXlLh7V3ANEmbTk
 VlQWFhE09Nbl9DF+/dfqlBT1/pSYJlxPmLo+uAvso/1flCzQImiqZAXM7VT0SuCJohRJ3dPQVQq
 i5S4CJztWQbUoFlHLn7DB/PvFOman5jrWdqwTzZKo8/46Lno+8kIUfaekufdiNVEbSawR
X-Received: by 2002:a05:6000:1b07:b0:321:6450:62ea with SMTP id
 f7-20020a0560001b0700b00321645062eamr1484562wrz.36.1696409163160; 
 Wed, 04 Oct 2023 01:46:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLUlY3j/lDgrU/XiBauRmpG1mshZAdRFfaodU44oJq5CjhHtd+v/wryhCuGiPMJ31MRZdmeA==
X-Received: by 2002:a05:6000:1b07:b0:321:6450:62ea with SMTP id
 f7-20020a0560001b0700b00321645062eamr1484545wrz.36.1696409162858; 
 Wed, 04 Oct 2023 01:46:02 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 u10-20020a05600c210a00b004063c9f68f2sm938183wml.26.2023.10.04.01.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:46:02 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:46:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 53/63] amd_iommu: Fix APIC address check
Message-ID: <ec271975abaee23d1ad06c82dbedf8642703521d.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

An MSI from I/O APIC may not exactly equal to APIC_DEFAULT_ADDRESS. In
fact, Windows 17763.3650 configures I/O APIC to set the dest_mode bit.
Cover the range assigned to APIC.

Fixes: 577c470f43 ("x86_iommu/amd: Prepare for interrupt remap support")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230921114612.40671-1-akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h | 2 --
 hw/i386/amd_iommu.c | 9 ++-------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 6da893ee57..c5065a3e27 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -210,8 +210,6 @@
 #define AMDVI_INT_ADDR_FIRST    0xfee00000
 #define AMDVI_INT_ADDR_LAST     0xfeefffff
 #define AMDVI_INT_ADDR_SIZE     (AMDVI_INT_ADDR_LAST - AMDVI_INT_ADDR_FIRST + 1)
-#define AMDVI_MSI_ADDR_HI_MASK  (0xffffffff00000000ULL)
-#define AMDVI_MSI_ADDR_LO_MASK  (0x00000000ffffffffULL)
 
 /* SB IOAPIC is always on this device in AMD systems */
 #define AMDVI_IOAPIC_SB_DEVID   PCI_BUILD_BDF(0, PCI_DEVFN(0x14, 0))
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c98a3c6e11..8d0f2f99dd 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1246,13 +1246,8 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
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
MST


