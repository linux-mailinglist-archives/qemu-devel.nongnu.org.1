Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E757161C0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNP-0006zG-Vw; Tue, 30 May 2023 09:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMq-0005cE-Hu
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMo-0001Oc-1K
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:28 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f70fc4682aso4422785e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453183; x=1688045183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NFC85aWPmpGiH1IeRFf6uphswI09B7v+WsN92P6q3Y0=;
 b=VWPhIz5o81UGZ5MB8ND6+7oJAwmZ1MdroDzLdw/vh/IJ8pMrv7PgMIjw6j05ZY+7h6
 tzY1vD9MSv/X1bNlyaneNRboCm1kEX8RnVaSk4vcCK/mBPfiZEvUWj/6Z/xCBoGpOYEh
 b+zAb0vcIc2mSOoT9/T5AoDMljAvXiq9IuGyiwGbB73gVWXFWVp7rdgnhne2kqD1b3Gn
 7NR3w8nrkit1UoVUM9hDpb9b69Na7+r9fOQ50spr9DiUY8O3bsHi0Ij7mVrMA/bWEkf5
 dcR4ZrjBN1vNEAMVgxdSsacWU6Lz3Ph6zcsJH/Wvz8WIVkoNNDjN7EcG82psnMexiTQR
 uBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453183; x=1688045183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NFC85aWPmpGiH1IeRFf6uphswI09B7v+WsN92P6q3Y0=;
 b=CL7VHa/kd7OZ3GsWi93KIuJAg68bnnlrCuLGSG3F4egi4cCb7o3TWgnAfSlihX1+C2
 +S/lvwOaVRrbyMOmmohxPEpA1qR2VGA5+80oUjEKQRZCpEvyUOubsncmVoMogvg2SQZV
 XKTiI2wOxWyFCIeRj18RlfXE2/4S1X9g5mbD11l3Nv1HDLckImMbnU/Jqp+YE4ZkGhO7
 YHQ37h5ZUjR3Z+qVU1TGNiM34yrKlIJvChp3whh+ymAvT9uMcKxlGyzMVkIN3dKMZ5t9
 d7X76ZRnR/2qqyzQSF1kAbKlxHsseFF1HGqWA8Gs417fG2nkwFssz0+Yq6Ho3Mgm4awh
 J+Fw==
X-Gm-Message-State: AC+VfDxfPtPGkSJmlS9mgzd4uJRDQ6xAdkI86TCMJoDaxFNThRNOoL+a
 7p2uVZRetAk08/Ose1SHvybGekKKqK1UG4vB1ag=
X-Google-Smtp-Source: ACHHUZ4G7W3Qbr9ultFmTrffnzwcWHQO0dcDC5Hb/W9K4shNhPHDM0SEyYg7qoseZvmuOyYwhLo8KA==
X-Received: by 2002:a7b:cd13:0:b0:3f6:f7c:b3fa with SMTP id
 f19-20020a7bcd13000000b003f60f7cb3famr1621686wmj.31.1685453183351; 
 Tue, 30 May 2023 06:26:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/21] hw/arm/smmuv3: Update translation config to hold stage-2
Date: Tue, 30 May 2023 14:26:02 +0100
Message-Id: <20230530132620.1583658-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Mostafa Saleh <smostafa@google.com>

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
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-id: 20230516203327.2051088-3-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 9fcff26357f..9cf3f37929a 100644
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
2.34.1


