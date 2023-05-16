Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD5B7058F2
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz1NE-0006Ds-Lj; Tue, 16 May 2023 16:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3x-hjZAgKClIC68CDuzu08805y.w86Ay6E-xyFy578707E.8B0@flex--smostafa.bounces.google.com>)
 id 1pz1ND-0006Ca-Cr
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:34:19 -0400
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3x-hjZAgKClIC68CDuzu08805y.w86Ay6E-xyFy578707E.8B0@flex--smostafa.bounces.google.com>)
 id 1pz1NB-0006iz-F7
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:34:19 -0400
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-30479b764f9so5321194f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1684269255; x=1686861255;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=WGWbmO7v6vcXx/XoMWesDE1+ZZN+mE03VIOoYYtnJYY=;
 b=GOfkB8GsPL+HJOkOfNKLTDHgH85c/cbmVNJKSehYNiIy5Zzahvrh5AqOhVSR6egIGW
 BaSDE2vrzuegec+fOdt4QWUUmXtAhkI7VfEC03kXRWnhPuDyUzGPp8vevdP7+0V5OZv4
 YlOWV2pAozih9yAHtlNUjgMVS34uEMaa+cuyUGj9g08QgEl7459kDJ+MpamXJN061X5L
 U7MXd/sCysjXyBaM4m+5FDd1OiWxcD1ETx3Mr1Pz0zUPYDvxJa3BNerIt5OJJ2ZWKTws
 iakikptg6pcq5koI+xIHVkdwfBlvp0nebobqJJ5iUmg+Lo0eez4r+N2Rv/vPgYXAEQ6B
 I5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684269255; x=1686861255;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WGWbmO7v6vcXx/XoMWesDE1+ZZN+mE03VIOoYYtnJYY=;
 b=JbDE0RT4uqXco5TdgdVcL2hBJ/LajZzrR9ha0hnRV00bKxZt55FAuzB+9Z1onkwdKi
 nvh3ShHT+MU3imtAN2oS16CbWE/obG+TrjhFpgS9svrHzihVnZgrQrM/UxRo1QikFlY6
 9+FdGE3CYIPAXWOyJm+KZsu9kBtBqRA58W3knno2APb93n9qhrv+C3pdYnOrzFP8g7qw
 a8JcXo9iThMCtMvebKCJw8pfVkqOyCvTVOHE6dEWztPOnzhSNsruFTNPD/t2P5FWJCVH
 4lUlgdTBzaPJnf/LJlVarikVVdE1a8LkFqYMxUemRVZPe+tQYfcIqYjr3lMqkE1BP5KW
 6dUw==
X-Gm-Message-State: AC+VfDxLXx3Nl2FLsmmYxupytuRhrmpap5Ra1WDdYa2kN8ev/oNflWVE
 uYVBP9bLGwjT/bnbLr5cMsGCeBTLjfaQFEppUvjXsgbebtPXflfb/KVxICk3yLLYCq0CLeWnjUe
 ChmiIcros1cR9N1zfvqiY1uYwPB9zKVvqqwdNzHJ5PXeIhmnO98kDY5MvtnzJbXZH8w==
X-Google-Smtp-Source: ACHHUZ6lQU5SO1AlYhAygH8evQOhTNZmZKP8stswlWi5kyNUCG/TdBZl7E8ONdABSqKwp8HZ184dimtML/0cpA==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a5d:44cd:0:b0:2e5:756b:8e77 with SMTP id
 z13-20020a5d44cd000000b002e5756b8e77mr5088312wrr.11.1684269255749; Tue, 16
 May 2023 13:34:15 -0700 (PDT)
Date: Tue, 16 May 2023 20:33:17 +0000
In-Reply-To: <20230516203327.2051088-1-smostafa@google.com>
Mime-Version: 1.0
References: <20230516203327.2051088-1-smostafa@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516203327.2051088-11-smostafa@google.com>
Subject: [PATCH v4 10/10] hw/arm/smmuv3: Add knob to choose translation stage
 and enable stage-2
From: Mostafa Saleh <smostafa@google.com>
To: qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=3x-hjZAgKClIC68CDuzu08805y.w86Ay6E-xyFy578707E.8B0@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x449.google.com
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

As everything is in place, we can use a new system property to
advertise which stage is supported and remove bad_ste from STE
stage2 config.

The property added arm-smmuv3.stage can have 3 values:
- "1": Stage-1 only is advertised.
- "2": Stage-2 only is advertised.

If not passed or an unsupported value is passed, it will default to
stage-1.

Advertise VMID16.

Don't try to decode CD, if stage-2 is configured.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
Changes in v4:
- Collected Reviewed-by tag
- Remove references to "all" stages.
Changes in v2:
- Squash knob patch with stage-2 enable patch.
- Don't try to decode CD, if stage-2 is configured.
---
 hw/arm/smmuv3.c         | 32 ++++++++++++++++++++++----------
 include/hw/arm/smmuv3.h |  1 +
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 17e1359be4..5c598c8428 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -21,6 +21,7 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
 #include "cpu.h"
@@ -241,14 +242,17 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
 
 static void smmuv3_init_regs(SMMUv3State *s)
 {
-    /**
-     * IDR0: stage1 only, AArch64 only, coherent access, 16b ASID,
-     *       multi-level stream table
-     */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1); /* stage 1 supported */
+    /* Based on sys property, the stages supported in smmu will be advertised.*/
+    if (s->stage && !strcmp("2", s->stage)) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
+    } else {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
+    }
+
     s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TTF, 2); /* AArch64 PTW only */
     s->idr[0] = FIELD_DP32(s->idr[0], IDR0, COHACC, 1); /* IO coherent */
     s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ASID16, 1); /* 16-bit ASID */
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, VMID16, 1); /* 16-bit VMID */
     s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TTENDIAN, 2); /* little endian */
     s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STALL_MODEL, 1); /* No stall */
     /* terminated transaction will always be aborted/error returned */
@@ -451,10 +455,6 @@ static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
         goto bad_ste;
     }
 
-    /* This is still here as stage 2 has not been fully enabled yet. */
-    qemu_log_mask(LOG_UNIMP, "SMMUv3 does not support stage 2 yet\n");
-    goto bad_ste;
-
     return 0;
 
 bad_ste:
@@ -733,7 +733,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
         return ret;
     }
 
-    if (cfg->aborted || cfg->bypassed) {
+    if (cfg->aborted || cfg->bypassed || (cfg->stage == 2)) {
         return 0;
     }
 
@@ -1804,6 +1804,17 @@ static const VMStateDescription vmstate_smmuv3 = {
     }
 };
 
+static Property smmuv3_properties[] = {
+    /*
+     * Stages of translation advertised.
+     * "1": Stage 1
+     * "2": Stage 2
+     * Defaults to stage 1
+     */
+    DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void smmuv3_instance_init(Object *obj)
 {
     /* Nothing much to do here as of now */
@@ -1820,6 +1831,7 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
                                        &c->parent_phases);
     c->parent_realize = dc->realize;
     dc->realize = smmu_realize;
+    device_class_set_props(dc, smmuv3_properties);
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 6031d7d325..d183a62766 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -62,6 +62,7 @@ struct SMMUv3State {
 
     qemu_irq     irq[4];
     QemuMutex mutex;
+    char *stage;
 };
 
 typedef enum {
-- 
2.40.1.606.ga4b1b128d6-goog


