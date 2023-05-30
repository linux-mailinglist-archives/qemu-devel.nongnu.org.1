Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D877A716213
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:35:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNR-00079Y-MB; Tue, 30 May 2023 09:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMy-0005hk-BV
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMq-0001Ps-L6
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f6e4554453so30796465e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453187; x=1688045187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S1CgxGo4x8qwCMDd8qkLOC5DRK58TslRZNOPgt4QJAQ=;
 b=Xc+1DmB/U07d2qARa+/y8BTcsRgc+FlJk1a8quX3Jm+cvZ5vlVo9YeTJuEH8OEISMS
 Oqn/AXJ85uk/tbA6ajvcdqT+myrViJVNT6S9m8yq2QinT3rh6E9Ps0tEIhCFCiXOwT64
 +x3kufl5+HOV6LxUh0eDMH4l1dtxbGax/kzHwao1VGO250jczDqKKAQWYFxlcGvGmpqr
 zD629RQ0gz82LvlexspAzb6gymEGaJU8KXQHqlyF4LrIqjNN5A1t3VX1wN6EF9zWJ0nx
 q72vov5DIdIEaBZMmKbV/w5yAHt80MoccoRXOtHp4KhGJ+tuAYBcgUMoYNyDyn5x53au
 Vwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453187; x=1688045187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1CgxGo4x8qwCMDd8qkLOC5DRK58TslRZNOPgt4QJAQ=;
 b=gjh6oD5oUPLDSDDmT5y58wYXPP0aZkW29kz47pOwoVH26wle6+TlT/LLZCuuxMA7no
 6aTxkyyWrstA9nzvgJK5fy9CSD4SsfNgYh867aPnNxYljo9Nroaxo+YQLnbgck6+rIFX
 HhGbMFK1wYSc8qQITKeu/+CPd/sB/3n/UB7jDnlpJKULAHGabHqO2eHesNkSUhS9seU3
 8FNv2GXtWfdRg/EIMSrdSsxkvE+n0Fen7fV264yQvCNynytGDTFcHXywL4ZrCwu+Gduq
 PomNuLpfJuakSzK4xrenqnSy6i/yv13COH9B47kf2xOzusO0xeil2YEkf3yLRGzzA7cJ
 foYQ==
X-Gm-Message-State: AC+VfDzH0Xq51oYgcD6mcNprvK9xxeYD3GCbXORAb1EictDMNnJ+Veqs
 tuiIX8oewS8UKVhJJhQvIAczuJIZpXTrf2sGyDk=
X-Google-Smtp-Source: ACHHUZ41nDzDlcBu3vtBkSO78zTgP5+ZuKdVbZjxY4TWQiC9nVe/E5cT0DqcgFOy6i7pLfLy4nZ+cg==
X-Received: by 2002:a05:600c:cd:b0:3f1:6fea:790a with SMTP id
 u13-20020a05600c00cd00b003f16fea790amr1649298wmm.30.1685453187080; 
 Tue, 30 May 2023 06:26:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/21] hw/arm/smmuv3: Add knob to choose translation stage and
 enable stage-2
Date: Tue, 30 May 2023 14:26:10 +0100
Message-Id: <20230530132620.1583658-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-id: 20230516203327.2051088-11-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmuv3.h |  1 +
 hw/arm/smmuv3.c         | 32 ++++++++++++++++++++++----------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 6031d7d325f..d183a627669 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -62,6 +62,7 @@ struct SMMUv3State {
 
     qemu_irq     irq[4];
     QemuMutex mutex;
+    char *stage;
 };
 
 typedef enum {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 17e1359be47..5c598c84285 100644
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
-- 
2.34.1


