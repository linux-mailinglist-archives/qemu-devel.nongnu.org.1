Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F76D931068
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jul 2024 10:47:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHL5-0004Lt-SB; Mon, 15 Jul 2024 04:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3seGUZggKCgQwqswxejeksskpi.gsquiqy-hiziprsrkry.svk@flex--smostafa.bounces.google.com>)
 id 1sTHL3-0004Fl-VK
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:42 -0400
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3seGUZggKCgQwqswxejeksskpi.gsquiqy-hiziprsrkry.svk@flex--smostafa.bounces.google.com>)
 id 1sTHL1-00042U-Vo
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:41 -0400
Received: by mail-ej1-x649.google.com with SMTP id
 a640c23a62f3a-a77c5255b1eso290046666b.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033137; x=1721637937; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=SVPZB22kCrKx2AdRCWQ3FSMGJhTkZ9LbBIl248AKLWw=;
 b=E6VEXTPALwaqklGD29oK19GL9Xgpm0zEFrNmnT8kliLWKrlJ7JBCgtH/6QbAhJf1w7
 n7tBx/szpbkWbGmhHUsFZCvUQXx2k9Clxq9G8ZpWAqrPT50jiQvG1VSj+XKVl9RVwQ24
 qUR2BCWP1+Rj5R6elMI7JSKAx4jCotsDKyk1W/6p/wjDuYXNsi6sL+AV9NQSYasB2c/v
 ZmpL7sk4HTgMEoS1coqczV0r5EXqccohFNP4InUIq2KlJbaFmIwm/v6QykimmGT0paJw
 gVZp8Uif309MOSz/4pBOmoI/GACNZ7QVuSCWV+AnTPsoAiJWu0YSNvO9C5w8o0SimOHC
 wKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033137; x=1721637937;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SVPZB22kCrKx2AdRCWQ3FSMGJhTkZ9LbBIl248AKLWw=;
 b=QkEGzWyHXbMH/giO87qU7aBMgNtpVD/jsI275dgHzFLzVqt8qQEWcxW60QRW96UhQJ
 LFe6YqLkgfcguCO83Kspp9EAnMEX1sNOVed4+qCWwrBRub2ezu1vcsCJCGHHFIrHWLvU
 qGWaAc9L+NrLAeufOlYwYDFwz9GqtqBghPgPp7AYsYZgRgOK3g8fIcIc0JEITxrrtEer
 W1slOLkJ96gPndrpxaJfSpdyRV0yF0y1sYh/5tIyowiWlYod9UwhIOyeTBJunH9tpBXQ
 FlDXfc/zR26r3axquufZfs1+B0zTHo3JrC1FA2zSewuz9vzJlxqngbx26UU00GN0AJdT
 wwoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeAl/V1sTza9/d3uxgVyf2y+IargIwULQgWMvnFjb3rYAFfmyMlJxE+B2NPnaT4ya2D/eJhFWbxH02TZ4nOPOtVZHnzCA=
X-Gm-Message-State: AOJu0YxWKcaG953kC7eTbiF0WA5Wr33gSU0cmEQUSn4eWc7F5nUcyi+W
 4ji70cKET7+7erhIE7sTkqLoyPYg2HGSeGKqDD6vRxedFR4Zu9TPHsPV7kfKaNF/XR7lqxj3xrP
 KTVRSVyjepQ==
X-Google-Smtp-Source: AGHT+IE5ECiOnrT/u4mYwzfIOpSZ9V55eNVdD1UiJEiZKuGy45698rMF2mqET9lETGqmi7WjMP8q5N118n91MQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a17:906:3402:b0:a78:65b:e275 with SMTP id
 a640c23a62f3a-a780b68751fmr1135266b.2.1721033137156; Mon, 15 Jul 2024
 01:45:37 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:04 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-5-smostafa@google.com>
Subject: [PATCH v5 04/18] hw/arm/smmu: Use enum for SMMU stage
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::649;
 envelope-from=3seGUZggKCgQwqswxejeksskpi.gsquiqy-hiziprsrkry.svk@flex--smostafa.bounces.google.com;
 helo=mail-ej1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Currently, translation stage is represented as an int, where 1 is stage-1 a=
nd
2 is stage-2, when nested is added, 3 would be confusing to represent nesti=
ng,
so we use an enum instead.

While keeping the same values, this is useful for:
 - Doing tricks with bit masks, where BIT(0) is stage-1 and BIT(1) is
   stage-2 and both is nested.
 - Tracing, as stage is printed as int.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 14 +++++++-------
 hw/arm/smmuv3.c              | 17 +++++++++--------
 include/hw/arm/smmu-common.h | 11 +++++++++--
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8a8c718e6b..8a5858f69f 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -304,7 +304,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                           SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
     dma_addr_t baseaddr, indexmask;
-    int stage =3D cfg->stage;
+    SMMUStage stage =3D cfg->stage;
     SMMUTransTableInfo *tt =3D select_tt(cfg, iova);
     uint8_t level, granule_sz, inputsize, stride;
=20
@@ -402,7 +402,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
     info->type =3D SMMU_PTW_ERR_TRANSLATION;
=20
 error:
-    info->stage =3D 1;
+    info->stage =3D SMMU_STAGE_1;
     tlbe->entry.perm =3D IOMMU_NONE;
     return -EINVAL;
 }
@@ -425,7 +425,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
                           dma_addr_t ipa, IOMMUAccessFlags perm,
                           SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
-    const int stage =3D 2;
+    const SMMUStage stage =3D SMMU_STAGE_2;
     int granule_sz =3D cfg->s2cfg.granule_sz;
     /* ARM DDI0487I.a: Table D8-7. */
     int inputsize =3D 64 - cfg->s2cfg.tsz;
@@ -525,7 +525,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
 error_ipa:
     info->addr =3D ipa;
 error:
-    info->stage =3D 2;
+    info->stage =3D SMMU_STAGE_2;
     tlbe->entry.perm =3D IOMMU_NONE;
     return -EINVAL;
 }
@@ -544,9 +544,9 @@ error:
 int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
              SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
-    if (cfg->stage =3D=3D 1) {
+    if (cfg->stage =3D=3D SMMU_STAGE_1) {
         return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
-    } else if (cfg->stage =3D=3D 2) {
+    } else if (cfg->stage =3D=3D SMMU_STAGE_2) {
         /*
          * If bypassing stage 1(or unimplemented), the input address is pa=
ssed
          * directly to stage 2 as IPA. If the input address of a transacti=
on
@@ -555,7 +555,7 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUA=
ccessFlags perm,
          */
         if (iova >=3D (1ULL << cfg->oas)) {
             info->type =3D SMMU_PTW_ERR_ADDR_SIZE;
-            info->stage =3D 1;
+            info->stage =3D SMMU_STAGE_1;
             tlbe->entry.perm =3D IOMMU_NONE;
             return -EINVAL;
         }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 3d214c9f57..7e9874b4a6 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -34,7 +34,8 @@
 #include "smmuv3-internal.h"
 #include "smmu-internal.h"
=20
-#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage =3D=3D 1) ? (cfg)->record_f=
aults : \
+#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage =3D=3D SMMU_STAGE_1) ? \
+                                 (cfg)->record_faults : \
                                  (cfg)->s2cfg.record_faults)
=20
 /**
@@ -402,7 +403,7 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_=
t t0sz, uint8_t gran)
=20
 static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
 {
-    cfg->stage =3D 2;
+    cfg->stage =3D SMMU_STAGE_2;
=20
     if (STE_S2AA64(ste) =3D=3D 0x0) {
         qemu_log_mask(LOG_UNIMP,
@@ -678,7 +679,7 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEve=
ntInfo *event)
=20
     /* we support only those at the moment */
     cfg->aa64 =3D true;
-    cfg->stage =3D 1;
+    cfg->stage =3D SMMU_STAGE_1;
=20
     cfg->oas =3D oas2bits(CD_IPS(cd));
     cfg->oas =3D MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
@@ -762,7 +763,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, =
SMMUTransCfg *cfg,
         return ret;
     }
=20
-    if (cfg->aborted || cfg->bypassed || (cfg->stage =3D=3D 2)) {
+    if (cfg->aborted || cfg->bypassed || (cfg->stage =3D=3D SMMU_STAGE_2))=
 {
         return 0;
     }
=20
@@ -882,7 +883,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
         goto epilogue;
     }
=20
-    if (cfg->stage =3D=3D 1) {
+    if (cfg->stage =3D=3D SMMU_STAGE_1) {
         /* Select stage1 translation table. */
         tt =3D select_tt(cfg, addr);
         if (!tt) {
@@ -919,7 +920,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
              * nesting is not supported. So it is sufficient to check the
              * translation stage to know the TLB stage for now.
              */
-            event.u.f_walk_eabt.s2 =3D (cfg->stage =3D=3D 2);
+            event.u.f_walk_eabt.s2 =3D (cfg->stage =3D=3D SMMU_STAGE_2);
             if (PTW_RECORD_FAULT(cfg)) {
                 event.type =3D SMMU_EVT_F_PERMISSION;
                 event.u.f_permission.addr =3D addr;
@@ -935,7 +936,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
=20
     if (smmu_ptw(cfg, aligned_addr, flag, cached_entry, &ptw_info)) {
         /* All faults from PTW has S2 field. */
-        event.u.f_walk_eabt.s2 =3D (ptw_info.stage =3D=3D 2);
+        event.u.f_walk_eabt.s2 =3D (ptw_info.stage =3D=3D SMMU_STAGE_2);
         g_free(cached_entry);
         switch (ptw_info.type) {
         case SMMU_PTW_ERR_WALK_EABT:
@@ -943,7 +944,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
             event.u.f_walk_eabt.addr =3D addr;
             event.u.f_walk_eabt.rnw =3D flag & 0x1;
             /* Stage-2 (only) is class IN while stage-1 is class TT */
-            event.u.f_walk_eabt.class =3D (ptw_info.stage =3D=3D 2) ?
+            event.u.f_walk_eabt.class =3D (ptw_info.stage =3D=3D SMMU_STAG=
E_2) ?
                                          SMMU_CLASS_IN : SMMU_CLASS_TT;
             event.u.f_walk_eabt.addr2 =3D ptw_info.addr;
             break;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 5ec2e6c1a4..b3c881f0ee 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -49,8 +49,15 @@ typedef enum {
     SMMU_PTW_ERR_PERMISSION,  /* Permission fault */
 } SMMUPTWEventType;
=20
+/* SMMU Stage */
+typedef enum {
+    SMMU_STAGE_1 =3D 1,
+    SMMU_STAGE_2,
+    SMMU_NESTED,
+} SMMUStage;
+
 typedef struct SMMUPTWEventInfo {
-    int stage;
+    SMMUStage stage;
     SMMUPTWEventType type;
     dma_addr_t addr; /* fetched address that induced an abort, if any */
 } SMMUPTWEventInfo;
@@ -88,7 +95,7 @@ typedef struct SMMUS2Cfg {
  */
 typedef struct SMMUTransCfg {
     /* Shared fields between stage-1 and stage-2. */
-    int stage;                 /* translation stage */
+    SMMUStage stage;           /* translation stage */
     bool disabled;             /* smmu is disabled */
     bool bypassed;             /* translation is bypassed */
     bool aborted;              /* translation is aborted */
--=20
2.45.2.993.g49e7a77208-goog


