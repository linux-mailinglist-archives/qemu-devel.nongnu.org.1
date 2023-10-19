Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9367CFB3E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCS-0002Qz-0w; Thu, 19 Oct 2023 09:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBn-0001rO-H1
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBf-0001CW-GC
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32da4ffd7e5so493703f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722541; x=1698327341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wgV06AYPc/Ma/kmEzls3TmWz3gALsYetmR08HC+n1XI=;
 b=XtrOpMPIKI7giLqs6A7XAHALfPPXxzjf1HgI2jwXegLrkSjYspOr4/QnNOiy9SE0VP
 +6Y+jtlV5DVIPaSiExS9tuPS8tdS2DxD6C37USiy+DjeRy8FHK3x1LCCwG5uoQjyjcRh
 +kVtrevCBy1R6lFUNJ/++Z5ODVp1mUBay3dHYmIaAcXY4O7CI+cp0xhWOWZpxIs5sDbt
 B6G4dmgbAiHOppfHxDfK35yTbqLFbvmfSpGDTsVnVfoQt3gydJE+wZIDYiWG8D0/sHV9
 jldaoJOrLpb9ioUBHVXXEPUtWc6gP8b8qvEE8ujGm+1lCGzVmAU9JZdOodPtreHy5wVO
 ltjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722541; x=1698327341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgV06AYPc/Ma/kmEzls3TmWz3gALsYetmR08HC+n1XI=;
 b=wfcRKA4RA0sPquQu5jUI4/ycPEnWp3RvlMM8vKi4I4QHW66KTYgQu2ufmklR6yRyK1
 0fDUtd5MrzRY5XjJxNW+S3642ue/TwmRSzT1R/15INsap/tJcECF+gcSFxSciV6eNKoH
 MH14OCCQXG2C1N8oIG99ex33PYh1jBYhdvDvlwZuG2BiFCve/k9KehZhL3bi8sIvUrxL
 2UMlKuHiyp+c6edvP+XkqzoOr746sWtzw+PXyzoRvpAG7aPK/KYAnE9UqTuGuNhho3KR
 gCF6ANJOl+cdwvtlUSBKAumoht1uSzOVRzbZZJvc4tyK9G9aGbc+9MlMM+kLnKOdxKk6
 coWw==
X-Gm-Message-State: AOJu0YzhDlCzyp1uB5gUdhJUAMO0eJSalTA57Ru7gZdK+obT5bBvWeLN
 ZZSG5mcblQI/tnlShLOfMYZgf0wx6sjtTiZ8dB8=
X-Google-Smtp-Source: AGHT+IHQTqwbSqatmdamSnYmFtYYPTrdxkRA8j18RHPDbztkCpCCTeEYcC68Dwic8wtf9YjJeUVY8A==
X-Received: by 2002:a5d:46c5:0:b0:32d:a129:3b6e with SMTP id
 g5-20020a5d46c5000000b0032da1293b6emr2144344wrs.14.1697722541547; 
 Thu, 19 Oct 2023 06:35:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/24] xlnx-versal-efuse: hw/nvram: Remove deprecated device
 reset
Date: Thu, 19 Oct 2023 14:35:18 +0100
Message-Id: <20231019133537.2114929-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tong Ho <tong.ho@amd.com>

This change implements the ResettableClass interface for the device.

Signed-off-by: Tong Ho <tong.ho@amd.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: 20231004055339.323833-1-tong.ho@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvram/xlnx-versal-efuse-ctrl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index b35ba65ab57..beb5661c35f 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -2,6 +2,7 @@
  * QEMU model of the Versal eFuse controller
  *
  * Copyright (c) 2020 Xilinx Inc.
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -657,9 +658,9 @@ static void efuse_ctrl_register_reset(RegisterInfo *reg)
     register_reset(reg);
 }
 
-static void efuse_ctrl_reset(DeviceState *dev)
+static void efuse_ctrl_reset_hold(Object *obj)
 {
-    XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(dev);
+    XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
     unsigned int i;
 
     for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
@@ -749,8 +750,9 @@ static Property efuse_ctrl_props[] = {
 static void efuse_ctrl_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    dc->reset = efuse_ctrl_reset;
+    rc->phases.hold = efuse_ctrl_reset_hold;
     dc->realize = efuse_ctrl_realize;
     dc->vmsd = &vmstate_efuse_ctrl;
     device_class_set_props(dc, efuse_ctrl_props);
-- 
2.34.1


