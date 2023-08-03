Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BC176F5A2
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRghW-0004UQ-AZ; Thu, 03 Aug 2023 18:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghV-0004U3-3J
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghT-0000YW-8w
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aDw+xuFXwgPlXVT00FhXsKo7gpeTtfswMTTY64LM71Q=;
 b=RztnKXn3isATuRbxeSCUkZ23bDISrLSkwm5mcIiIWNYwO7BB/+TtdDxlAfYyabvOkjA22Z
 +6jm8TQzNNAK1CHSoGUarof4mZJ6JoCVZ7bruhcHpLGb3NM9O3WPjnhiY5G8gVYFDOJXJX
 +MCYglhDA9IPyvos9B2qgtoN1lLjVl0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-UJSc9T_OPJeHKzjjUr885Q-1; Thu, 03 Aug 2023 18:21:41 -0400
X-MC-Unique: UJSc9T_OPJeHKzjjUr885Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-522abbc863fso960869a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101300; x=1691706100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDw+xuFXwgPlXVT00FhXsKo7gpeTtfswMTTY64LM71Q=;
 b=AYXt1vS6SkF9ROI9FWfdaEva2GgZZZhhKi/MlTBecIikSdpgo+jP66pWoTStwJEnnr
 554oeS3kP7NEXNtZmth68CcsJrUMZciT+Ui53NhSu5DENeNGaGx3Kw1tdRDK2S4PtU/O
 bbmQyIC4eWw5EPjTgDqw3Mplco5dDu4qDfaVFh8yL5WGFS8jUeKBxl+0a4GTWy1W3qdU
 XRB2MWvb6Et4BvkESVaLn6omTSk/TINk0QQgOQpsb8XiTlsT2xUEzp4VReZ7jPv4w1r5
 kVJTs2af3LliTomtfNR22ekJMgInCChtSgFxZ6EiEmgGii84b89QvvLgCNUor7U0StqO
 R86g==
X-Gm-Message-State: AOJu0YzZEmgQQAXQMIylL4NHQKpM+WyXYpQ+3Oop4G32tdeigqjMLkg0
 XrUj3WRjgDiEqLKsHLFnGckKPOO+BJXHwZcGU6mY+m+nIbuFJ/8KH6Zq2MK4ly4TYcpS1jMiLF2
 1gwff2MmJ7yJSi9KVyb7ZcaaHs7fzJWLYSOHhKEvtZ3w5k1L1R9XSRDKyBDW/rCK+F3s5
X-Received: by 2002:aa7:dc12:0:b0:522:cb97:f198 with SMTP id
 b18-20020aa7dc12000000b00522cb97f198mr77406edu.38.1691101299995; 
 Thu, 03 Aug 2023 15:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXo4iTsPyeaMetia1z6TwV2wS9TAA2HLeQaJQ1gSmg5J46O5RkbikDfGT1A3ihVrOwJdo2dQ==
X-Received: by 2002:aa7:dc12:0:b0:522:cb97:f198 with SMTP id
 b18-20020aa7dc12000000b00522cb97f198mr77393edu.38.1691101299785; 
 Thu, 03 Aug 2023 15:21:39 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 p12-20020aa7d30c000000b00522ce914f51sm348389edq.67.2023.08.03.15.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:39 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 16/22] hw/i386/intel_iommu: Fix endianness problems related to
 VTD_IR_TableEntry
Message-ID: <642ba89672279fbdd14016a90da239c85e845d18.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
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

From: Thomas Huth <thuth@redhat.com>

The code already tries to do some endianness handling here, but
currently fails badly:
- While it already swaps the data when logging errors / tracing, it fails
  to byteswap the value before e.g. accessing entry->irte.present
- entry->irte.source_id is swapped with le32_to_cpu(), though this is
  a 16-bit value
- The whole union is apparently supposed to be swapped via the 64-bit
  data[2] array, but the struct is a mixture between 32 bit values
  (the first 8 bytes) and 64 bit values (the second 8 bytes), so this
  cannot work as expected.

Fix it by converting the struct to two proper 64-bit bitfields, and
by swapping the values only once for everybody right after reading
the data from memory.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230802135723.178083-3-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/hw/i386/intel_iommu.h | 50 ++++++++++++++++++-----------------
 hw/i386/intel_iommu.c         | 16 +++++------
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 89dcbc5e1e..7fa0a695c8 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -178,37 +178,39 @@ enum {
 union VTD_IR_TableEntry {
     struct {
 #if HOST_BIG_ENDIAN
-        uint32_t __reserved_1:8;     /* Reserved 1 */
-        uint32_t vector:8;           /* Interrupt Vector */
-        uint32_t irte_mode:1;        /* IRTE Mode */
-        uint32_t __reserved_0:3;     /* Reserved 0 */
-        uint32_t __avail:4;          /* Available spaces for software */
-        uint32_t delivery_mode:3;    /* Delivery Mode */
-        uint32_t trigger_mode:1;     /* Trigger Mode */
-        uint32_t redir_hint:1;       /* Redirection Hint */
-        uint32_t dest_mode:1;        /* Destination Mode */
-        uint32_t fault_disable:1;    /* Fault Processing Disable */
-        uint32_t present:1;          /* Whether entry present/available */
+        uint64_t dest_id:32;         /* Destination ID */
+        uint64_t __reserved_1:8;     /* Reserved 1 */
+        uint64_t vector:8;           /* Interrupt Vector */
+        uint64_t irte_mode:1;        /* IRTE Mode */
+        uint64_t __reserved_0:3;     /* Reserved 0 */
+        uint64_t __avail:4;          /* Available spaces for software */
+        uint64_t delivery_mode:3;    /* Delivery Mode */
+        uint64_t trigger_mode:1;     /* Trigger Mode */
+        uint64_t redir_hint:1;       /* Redirection Hint */
+        uint64_t dest_mode:1;        /* Destination Mode */
+        uint64_t fault_disable:1;    /* Fault Processing Disable */
+        uint64_t present:1;          /* Whether entry present/available */
 #else
-        uint32_t present:1;          /* Whether entry present/available */
-        uint32_t fault_disable:1;    /* Fault Processing Disable */
-        uint32_t dest_mode:1;        /* Destination Mode */
-        uint32_t redir_hint:1;       /* Redirection Hint */
-        uint32_t trigger_mode:1;     /* Trigger Mode */
-        uint32_t delivery_mode:3;    /* Delivery Mode */
-        uint32_t __avail:4;          /* Available spaces for software */
-        uint32_t __reserved_0:3;     /* Reserved 0 */
-        uint32_t irte_mode:1;        /* IRTE Mode */
-        uint32_t vector:8;           /* Interrupt Vector */
-        uint32_t __reserved_1:8;     /* Reserved 1 */
+        uint64_t present:1;          /* Whether entry present/available */
+        uint64_t fault_disable:1;    /* Fault Processing Disable */
+        uint64_t dest_mode:1;        /* Destination Mode */
+        uint64_t redir_hint:1;       /* Redirection Hint */
+        uint64_t trigger_mode:1;     /* Trigger Mode */
+        uint64_t delivery_mode:3;    /* Delivery Mode */
+        uint64_t __avail:4;          /* Available spaces for software */
+        uint64_t __reserved_0:3;     /* Reserved 0 */
+        uint64_t irte_mode:1;        /* IRTE Mode */
+        uint64_t vector:8;           /* Interrupt Vector */
+        uint64_t __reserved_1:8;     /* Reserved 1 */
+        uint64_t dest_id:32;         /* Destination ID */
 #endif
-        uint32_t dest_id;            /* Destination ID */
-        uint16_t source_id;          /* Source-ID */
 #if HOST_BIG_ENDIAN
         uint64_t __reserved_2:44;    /* Reserved 2 */
         uint64_t sid_vtype:2;        /* Source-ID Validation Type */
         uint64_t sid_q:2;            /* Source-ID Qualifier */
+        uint64_t source_id:16;       /* Source-ID */
 #else
+        uint64_t source_id:16;       /* Source-ID */
         uint64_t sid_q:2;            /* Source-ID Qualifier */
         uint64_t sid_vtype:2;        /* Source-ID Validation Type */
         uint64_t __reserved_2:44;    /* Reserved 2 */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 13fcde8e91..4028e32701 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3328,14 +3328,15 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
         return -VTD_FR_IR_ROOT_INVAL;
     }
 
-    trace_vtd_ir_irte_get(index, le64_to_cpu(entry->data[1]),
-                          le64_to_cpu(entry->data[0]));
+    entry->data[0] = le64_to_cpu(entry->data[0]);
+    entry->data[1] = le64_to_cpu(entry->data[1]);
+
+    trace_vtd_ir_irte_get(index, entry->data[1], entry->data[0]);
 
     if (!entry->irte.present) {
         error_report_once("%s: detected non-present IRTE "
                           "(index=%u, high=0x%" PRIx64 ", low=0x%" PRIx64 ")",
-                          __func__, index, le64_to_cpu(entry->data[1]),
-                          le64_to_cpu(entry->data[0]));
+                          __func__, index, entry->data[1], entry->data[0]);
         return -VTD_FR_IR_ENTRY_P;
     }
 
@@ -3343,14 +3344,13 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
         entry->irte.__reserved_2) {
         error_report_once("%s: detected non-zero reserved IRTE "
                           "(index=%u, high=0x%" PRIx64 ", low=0x%" PRIx64 ")",
-                          __func__, index, le64_to_cpu(entry->data[1]),
-                          le64_to_cpu(entry->data[0]));
+                          __func__, index, entry->data[1], entry->data[0]);
         return -VTD_FR_IR_IRTE_RSVD;
     }
 
     if (sid != X86_IOMMU_SID_INVALID) {
         /* Validate IRTE SID */
-        source_id = le32_to_cpu(entry->irte.source_id);
+        source_id = entry->irte.source_id;
         switch (entry->irte.sid_vtype) {
         case VTD_SVT_NONE:
             break;
@@ -3404,7 +3404,7 @@ static int vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
     irq->trigger_mode = irte.irte.trigger_mode;
     irq->vector = irte.irte.vector;
     irq->delivery_mode = irte.irte.delivery_mode;
-    irq->dest = le32_to_cpu(irte.irte.dest_id);
+    irq->dest = irte.irte.dest_id;
     if (!iommu->intr_eime) {
 #define  VTD_IR_APIC_DEST_MASK         (0xff00ULL)
 #define  VTD_IR_APIC_DEST_SHIFT        (8)
-- 
MST


