Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CAF91DD76
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Jul 2024 13:06:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEqM-0003cS-Jx; Mon, 01 Jul 2024 07:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_YyCZggKClwMGIMN494AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--smostafa.bounces.google.com>)
 id 1sOEol-0002CU-FJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:34 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_YyCZggKClwMGIMN494AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--smostafa.bounces.google.com>)
 id 1sOEoj-0005IQ-5m
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:31 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-42490ae735dso27969605e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831805; x=1720436605; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=CX75BBMr16Pco/B3TBgFcZZDPnngLrDGwCyV2KD+jJ0=;
 b=kdVW+wiAjztUJI1VGNxFU85wP9zx2yUlmwuxGhA0RK3P0E0mQGGxIU8NK94SstrRiZ
 rJTKAAH/lvF9oxXefhY10uanUWxlf1ZnDxSJReIJ+V5eAw2Krk5CDUrVr718P+R6B4h5
 HvS7Us+WGVYKVjiBEWemTsHnn/TCBA8yy7AgPe72SUaCoWoCXfWqaVNLD+Cls2SsAocG
 v48zA2pO0he+1OfkUVRDhNlyGImbSTmekNiyK/XQeU6OkKSIs0tpoeqcaGvOiFtCoBJy
 P3C3yCcDeH3UwlchxpKpFl/s2amugrpN0jdSBfPHeHoy1pwTricrl2WVveth8sw7cZFb
 ehTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831805; x=1720436605;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CX75BBMr16Pco/B3TBgFcZZDPnngLrDGwCyV2KD+jJ0=;
 b=AsygAJZu9FW729r2J4AEcjDdztATYOQLLYMOLdKoSK0S+bHkbdz6aAZtlxVEzxXwzh
 ydtaDRiXGRysfinatm5VN9Pw/q7GbO3CG39rbdp+rb7uju/HZgaXAmBD4S/u/xDjrNsa
 liwraDNI5EpomF6w0H4do9PppOcusMWKa2suU/kExSMXIGiekAnGf5FFxxfflQmsVtmW
 S8m5o5g/V3MZRLaIma9q5Ulg2uhqcMUfBywsO/z8KAeMyh7dziLYx0tThBUtfKyWYjih
 VH+mBhODf1+/vpw+RODXGcVQ3o2Cu/+l7YpgHRXZyrzAeRubwitxzfBRqvMugc3eof2m
 yHnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC4IWIj2cgPVb+mSH1aZTBffZf0xaL9bamTyYMh9FO5EFClqE35gX5PpHyOYi1zsrNmQo4Qs7dgn7hHitWmGRUd4NUkwA=
X-Gm-Message-State: AOJu0YyQ+p3uNfaXyPlbdl50Ew+HTW6BsitZ4wJtTis964U/+5hmdDmE
 AtMDcNHAVM8e9x+n8UiKKwWh+fiWvidBgGUpD5dqzLxjU4J3Io5YbibRFFiQX56OmU8XTK2York
 9uTdi/H2Y5Q==
X-Google-Smtp-Source: AGHT+IHkOtQW1UdbGSx6SEkZDuB9UujL1yyijz3SygDOe2j4jqk/o4VNie7yzWDpxF9i7uoCdCgo7yQccO9Gew==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:1ca3:b0:425:671d:cef6 with SMTP
 id 5b1f17b1804b1-4257a046ccamr803115e9.4.1719831805403; Mon, 01 Jul 2024
 04:03:25 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:30 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-9-smostafa@google.com>
Subject: [PATCH v4 08/19] hw/arm/smmuv3: Translate CD and TT using stage-2
 table
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3_YyCZggKClwMGIMN494AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x34a.google.com
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

According to ARM SMMU architecture specification (ARM IHI 0070 F.b),
In "5.2 Stream Table Entry":
 [51:6] S1ContextPtr
 If Config[1] == 1 (stage 2 enabled), this pointer is an IPA translated by
 stage 2 and the programmed value must be within the range of the IAS.

In "5.4.1 CD notes":
 The translation table walks performed from TTB0 or TTB1 are always performed
 in IPA space if stage 2 translations are enabled.

This patch implements translation of the S1 context descriptor pointer and
TTBx base addresses through the S2 stage (IPA -> PA)

smmuv3_do_translate() is updated to have one arg which is translation
class, this is useful to:
 - Decide wether a translation is stage-2 only or use the STE config.
 - Populate the class in case of faults, WALK_EABT is left unchanged,
   as it is always triggered from TT access so no need to use the
   input class.

In case for stage-2 only translation, used in the context of nested
translation, the stage and asid are saved and restored before and
after calling smmu_translate().

Translating CD or TTBx can fail for the following reasons:
1) Large address size: This is described in
   (3.4.3 Address sizes of SMMU-originated accesses)
   - For CD ptr larger than IAS, for SMMUv3.1, it can trigger either
     C_BAD_STE or Translation fault, we implement the latter as it
     requires no extra code.
   - For TTBx, if larger than the effective stage 1 output address size, it
     triggers C_BAD_CD.

2) Faults from PTWs (7.3 Event records)
   - F_ADDR_SIZE: large address size after first level causes stage 2 Address
     Size fault (Also in 3.4.3 Address sizes of SMMU-originated accesses)
   - F_PERMISSION: Same as an address translation. However, when
     CLASS == CD, the access is implicitly Data and a read.
   - F_ACCESS: Same as an address translation.
   - F_TRANSLATION: Same as an address translation.
   - F_WALK_EABT: Same as an address translation.
  These are already implemented in the PTW logic, so no extra handling
  required.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c | 91 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 11 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 229b3c388c..86f95c1e40 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -337,14 +337,35 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
 
 }
 
+static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
+                                                 SMMUTransCfg *cfg,
+                                                 SMMUEventInfo *event,
+                                                 IOMMUAccessFlags flag,
+                                                 SMMUTLBEntry **out_entry,
+                                                 SMMUTranslationClass class);
 /* @ssid > 0 not supported yet */
-static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
-                       CD *buf, SMMUEventInfo *event)
+static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
+                       uint32_t ssid, CD *buf, SMMUEventInfo *event)
 {
     dma_addr_t addr = STE_CTXPTR(ste);
     int ret, i;
+    SMMUTranslationStatus status;
+    SMMUTLBEntry *entry;
 
     trace_smmuv3_get_cd(addr);
+
+    if (cfg->stage == SMMU_NESTED) {
+        status = smmuv3_do_translate(s, addr, cfg, event,
+                                     IOMMU_RO, &entry, SMMU_CLASS_CD);
+
+        /* Same PTW faults are reported but with CLASS = CD. */
+        if (status != SMMU_TRANS_SUCCESS) {
+            return -EINVAL;
+        }
+
+        addr = CACHED_ENTRY_TO_ADDR(entry, addr);
+    }
+
     /* TODO: guarantee 64-bit single-copy atomicity */
     ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
                           MEMTXATTRS_UNSPECIFIED);
@@ -659,10 +680,13 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
     return 0;
 }
 
-static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
+static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
+                     CD *cd, SMMUEventInfo *event)
 {
     int ret = -EINVAL;
     int i;
+    SMMUTranslationStatus status;
+    SMMUTLBEntry *entry;
 
     if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
         goto bad_cd;
@@ -713,9 +737,26 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
 
         tt->tsz = tsz;
         tt->ttb = CD_TTB(cd, i);
+
         if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
             goto bad_cd;
         }
+
+        /* Translate the TTBx, from IPA to PA if nesting is enabled. */
+        if (cfg->stage == SMMU_NESTED) {
+            status = smmuv3_do_translate(s, tt->ttb, cfg, event, IOMMU_RO,
+                                         &entry, SMMU_CLASS_TT);
+            /*
+             * Same PTW faults are reported but with CLASS = TT.
+             * If TTBx is larger than the effective stage 1 output addres
+             * size, it reports C_BAD_CD, which is handled by the above case.
+             */
+            if (status != SMMU_TRANS_SUCCESS) {
+                return -EINVAL;
+            }
+            tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
+        }
+
         tt->had = CD_HAD(cd, i);
         trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
     }
@@ -767,12 +808,12 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
         return 0;
     }
 
-    ret = smmu_get_cd(s, &ste, 0 /* ssid */, &cd, event);
+    ret = smmu_get_cd(s, &ste, cfg, 0 /* ssid */, &cd, event);
     if (ret) {
         return ret;
     }
 
-    return decode_cd(cfg, &cd, event);
+    return decode_cd(s, cfg, &cd, event);
 }
 
 /**
@@ -832,13 +873,40 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                                                  SMMUTransCfg *cfg,
                                                  SMMUEventInfo *event,
                                                  IOMMUAccessFlags flag,
-                                                 SMMUTLBEntry **out_entry)
+                                                 SMMUTLBEntry **out_entry,
+                                                 SMMUTranslationClass class)
 {
     SMMUPTWEventInfo ptw_info = {};
     SMMUState *bs = ARM_SMMU(s);
     SMMUTLBEntry *cached_entry = NULL;
+    int asid, stage;
+    bool S2_only = class != SMMU_CLASS_IN;
+
+    /*
+     * The function uses the argument class to indentify which stage is used:
+     * - CLASS = IN: Means an input translation, determine the stage from STE.
+     * - CLASS = CD: Means the addr is an IPA of the CD, and it would be
+     *   tranlsated using the stage-2.
+     * - CLASS = TT: Means the addr is an IPA of the stage-1 translation table
+     *   and it would be tranlsated using the stage-2.
+     * For the last 2 cases instead of having intrusive changes in the common
+     * logic, we modify the cfg to be a stage-2 translation only in case of
+     * nested, and then restore it after.
+     */
+    if (S2_only) {
+        asid = cfg->asid;
+        stage = cfg->stage;
+        cfg->asid = -1;
+        cfg->stage = SMMU_STAGE_2;
+    }
 
     cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
+
+    if (S2_only) {
+        cfg->asid = asid;
+        cfg->stage = stage;
+    }
+
     if (!cached_entry) {
         /* All faults from PTW has S2 field. */
         event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
@@ -855,7 +923,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                 event->type = SMMU_EVT_F_TRANSLATION;
                 event->u.f_translation.addr = addr;
                 event->u.f_translation.addr2 = ptw_info.addr;
-                event->u.f_translation.class = SMMU_CLASS_IN;
+                event->u.f_translation.class = class;
                 event->u.f_translation.rnw = flag & 0x1;
             }
             break;
@@ -864,7 +932,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                 event->type = SMMU_EVT_F_ADDR_SIZE;
                 event->u.f_addr_size.addr = addr;
                 event->u.f_addr_size.addr2 = ptw_info.addr;
-                event->u.f_addr_size.class = SMMU_CLASS_IN;
+                event->u.f_addr_size.class = class;
                 event->u.f_addr_size.rnw = flag & 0x1;
             }
             break;
@@ -873,7 +941,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                 event->type = SMMU_EVT_F_ACCESS;
                 event->u.f_access.addr = addr;
                 event->u.f_access.addr2 = ptw_info.addr;
-                event->u.f_access.class = SMMU_CLASS_IN;
+                event->u.f_access.class = class;
                 event->u.f_access.rnw = flag & 0x1;
             }
             break;
@@ -882,7 +950,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                 event->type = SMMU_EVT_F_PERMISSION;
                 event->u.f_permission.addr = addr;
                 event->u.f_permission.addr2 = ptw_info.addr;
-                event->u.f_permission.class = SMMU_CLASS_IN;
+                event->u.f_permission.class = class;
                 event->u.f_permission.rnw = flag & 0x1;
             }
             break;
@@ -943,7 +1011,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    status = smmuv3_do_translate(s, addr, cfg, &event, flag, &cached_entry);
+    status = smmuv3_do_translate(s, addr, cfg, &event, flag,
+                                 &cached_entry, SMMU_CLASS_IN);
 
 epilogue:
     qemu_mutex_unlock(&s->mutex);
-- 
2.45.2.803.g4e1b14247a-goog


