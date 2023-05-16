Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A77D37058EE
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:35:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz1N2-00066y-Tg; Tue, 16 May 2023 16:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3tOhjZAgKCj8tnptubgbhpphmf.dpnrfnv-efwfmopohov.psh@flex--smostafa.bounces.google.com>)
 id 1pz1Mu-00066b-Ib
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:34:00 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3tOhjZAgKCj8tnptubgbhpphmf.dpnrfnv-efwfmopohov.psh@flex--smostafa.bounces.google.com>)
 id 1pz1Ms-0006gC-Qc
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:34:00 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso32785e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 13:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1684269236; x=1686861236;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=yL0acMD0mtDiWd5EDmA+JrGfGdbIFgNgTDlEp+GsxxQ=;
 b=HnxWaex8obB/qNfArh0+QokvIX7/VozOfPOH8b2dU8Hm5h345REkwEdK65p39LpBh9
 A28+EeGhhakYwZhRNY/qP6Wnn2cZU3C4YTeZ0TCog4uziZwyI6c0rdm0SpisbyWoJOd+
 I3wsCSFQK0Ns18dZAHg91ffaCSxoaLd4q0w8dYWkqMBz1UFFijYTuXI2HU8PvFiB8R4y
 yKozCr9ERU4CHTAFq3fFQkgQdrksyZiBOV6vc9zkWZsFB/d3QXL6L6z4izrRMWusbmK3
 izJVffFPxx4ggQwumWnPvT4O/09PMH1XLbcMeSA412nJw4MLZj9CktVqcdXTUZ7myJj8
 7pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684269236; x=1686861236;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yL0acMD0mtDiWd5EDmA+JrGfGdbIFgNgTDlEp+GsxxQ=;
 b=Ud7u3copgkJ5qISYmZsBuLlxS4UetRkLMLh/JyRQ5g4f13WzIt/pFu9dmGpfDVBN3Q
 jsb67urjOd4sfVwZ3A7yQE4cBsdjO+iJg3hp5qvKQKLKFN30/NuLi291Tme+JlVvOuji
 a9uyfxcOLkdg2JWwRrLHGlCFclR5puC940xQHw+5tySKCOJiExXZizSds8PuLM5eSMS1
 Fwy5BJ1xkpV/XaKWXBAwGYTJDOKvWnXrXD3eutuoNLPPaT8LSY9CEzajv7pvlnVLhtu7
 sCTFQ8DBdlwph8vd3md8e9hgwh4aiO62UAL2QqukHhYQSUJQU8jDI89tyqBXc2OmkwWg
 c9CQ==
X-Gm-Message-State: AC+VfDyBKvRicGTp1yjjEga8UlfoNpi2y1vQ5+lnooIHA1ZmpRr2pZms
 5XJNWvYPSEE42pZiIiQEeo0gPn/SXSvz6T2XHuuRNMuR+EmYgRy5yVVQNNu96qJmri2zVkQhZqS
 ETIMXrOA6E4d5JFYd3cZbss30+zjalRZrsd5/BM40nFrD3oQP4Vx0lfM2InxrONZvcg==
X-Google-Smtp-Source: ACHHUZ7UlrV0M4suEjjAj+kSt4wsMUp3gU24PPQPZ9Ui3T1MXySsoz+F7Y1sHkfis/RfBRwGgwnGpJ1X5fcTGQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a1c:4b17:0:b0:3f4:f8cc:428d with SMTP id
 y23-20020a1c4b17000000b003f4f8cc428dmr2573491wma.5.1684269236835; Tue, 16 May
 2023 13:33:56 -0700 (PDT)
Date: Tue, 16 May 2023 20:33:09 +0000
In-Reply-To: <20230516203327.2051088-1-smostafa@google.com>
Mime-Version: 1.0
References: <20230516203327.2051088-1-smostafa@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516203327.2051088-3-smostafa@google.com>
Subject: [PATCH v4 02/10] hw/arm/smmuv3: Update translation config to hold
 stage-2
From: Mostafa Saleh <smostafa@google.com>
To: qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3tOhjZAgKCj8tnptubgbhpphmf.dpnrfnv-efwfmopohov.psh@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

In preparation for adding stage-2 support, add a S2 config
struct(SMMUS2Cfg), composed of the following fields and embedded in
the main SMMUTransCfg:
 -tsz: Size of IPA input region (S2T0SZ)
 -sl0: Start level of translation (S2SL0)
 -affd: AF Fault Disable (S2AFFD)
 -record_faults: Record fault events (S2R)
 -granule_sz: Granule page shift (based on S2TG)
 -vmid: Virtual Machine ID (S2VMID)
 -vttb: Address of translation table base (S2TTB)
 -eff_ps: Effective PA output range (based on S2PS)

They will be used in the next patches in stage-2 address translation.

The fields in SMMUS2Cfg, are reordered to make the shared and stage-1
fields next to each other, this reordering didn't change the struct
size (104 bytes before and after).

Stage-1 only fields: aa64, asid, tt, ttb, tbi, record_faults, oas.
oas is stage-1 output address size. However, it is used to check
input address in case stage-1 is unimplemented or bypassed according
to SMMUv3 manual IHI0070.E "3.4. Address sizes"

Shared fields: stage, disabled, bypassed, aborted, iotlb_*.

No functional change intended.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
Changes in v4:
-Collected Reviewed-by tag
Changes in v3:
-Add record_faults for stage-2
-Reorder and document fields in SMMUTransCfg based on stage
-Rename oas in SMMUS2Cfg to eff_ps
-Improve comments in SMMUS2Cfg
Changes in v2:
-Add oas
---
 include/hw/arm/smmu-common.h | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 9fcff26357..9cf3f37929 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -58,25 +58,41 @@ typedef struct SMMUTLBEntry {
     uint8_t granule;
 } SMMUTLBEntry;
 
+/* Stage-2 configuration. */
+typedef struct SMMUS2Cfg {
+    uint8_t tsz;            /* Size of IPA input region (S2T0SZ) */
+    uint8_t sl0;            /* Start level of translation (S2SL0) */
+    bool affd;              /* AF Fault Disable (S2AFFD) */
+    bool record_faults;     /* Record fault events (S2R) */
+    uint8_t granule_sz;     /* Granule page shift (based on S2TG) */
+    uint8_t eff_ps;         /* Effective PA output range (based on S2PS) */
+    uint16_t vmid;          /* Virtual Machine ID (S2VMID) */
+    uint64_t vttb;          /* Address of translation table base (S2TTB) */
+} SMMUS2Cfg;
+
 /*
  * Generic structure populated by derived SMMU devices
  * after decoding the configuration information and used as
  * input to the page table walk
  */
 typedef struct SMMUTransCfg {
+    /* Shared fields between stage-1 and stage-2. */
     int stage;                 /* translation stage */
-    bool aa64;                 /* arch64 or aarch32 translation table */
     bool disabled;             /* smmu is disabled */
     bool bypassed;             /* translation is bypassed */
     bool aborted;              /* translation is aborted */
+    uint32_t iotlb_hits;       /* counts IOTLB hits */
+    uint32_t iotlb_misses;     /* counts IOTLB misses*/
+    /* Used by stage-1 only. */
+    bool aa64;                 /* arch64 or aarch32 translation table */
     bool record_faults;        /* record fault events */
     uint64_t ttb;              /* TT base address */
     uint8_t oas;               /* output address width */
     uint8_t tbi;               /* Top Byte Ignore */
     uint16_t asid;
     SMMUTransTableInfo tt[2];
-    uint32_t iotlb_hits;       /* counts IOTLB hits for this asid */
-    uint32_t iotlb_misses;     /* counts IOTLB misses for this asid */
+    /* Used by stage-2 only. */
+    struct SMMUS2Cfg s2cfg;
 } SMMUTransCfg;
 
 typedef struct SMMUDevice {
-- 
2.40.1.606.ga4b1b128d6-goog


