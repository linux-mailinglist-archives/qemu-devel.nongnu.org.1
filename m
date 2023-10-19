Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7227CFB63
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:40:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCr-0003tk-S5; Thu, 19 Oct 2023 09:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBm-0001rK-DD
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:54 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBf-0001CR-Fv
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32caaa1c493so6148779f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722541; x=1698327341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ICHuBkhBDHp2nAsvOB6Lae37rGAGJ+oc5E/gIMwOSBg=;
 b=i27D//zsxYExSx7mlnFqX3k2e5rbrBcwCqXwrAtnXmIu6Bw4v5QZ1f3zHMb06o8nTE
 FHAC+E0/kZBe/Y8CO43qxJfKA0OsfjCoUstKlHgvTTJhXzLsNxoAqzWPjrtLXZMt68gi
 M2qM4WPoNM2pNh0DGrJMwb5gLHnh3Ru0M0ESqzYEBFSayMmPLN6Z+pwLM1SKGqORtLfm
 7g34dG5++O+vEhDV3nOJwmWU+6swV+gF8Gj+NItbruAf/Q6tvz0MdT4EHoppSUKz5mvI
 91sBPvK1x2DO3HLIP5SBtZfk1v8l4ucWVR1UdNr2Tu63tSYyn5womnmh7+V3f2WeIC1/
 h2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722541; x=1698327341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICHuBkhBDHp2nAsvOB6Lae37rGAGJ+oc5E/gIMwOSBg=;
 b=u54DsRgRHJ2ZQoqkl2z8+b5ay2SWxa4od9Klbp+iL9IhUyprTeS9LuD6EjkN9ApGQK
 9CfaYwJK7n1XYw6CEVlecSwOfBPVwuSYIdQTtznmLu7Tx9BwaSzYa5tiKGMZbvKJtwaa
 zAk+qEk8gNvWjPCOIVS9BOsqyyCiSZZRO/MXiuFt3n55FXyeADcf4zIT/gUFibtyi/Yx
 V9vk3qHlk1OUcjxqAmeLiDWkLG0ThfwnGWjSiG9lHE7hsaSX10UzFarVN6jGt4TPLdNp
 0Psar8c3muc8NQkMSD42qI+vvsJ45Zo7s/zFvzIsHpA0PQN9rrZj1ln0LHcNpSdHtGtr
 7y+w==
X-Gm-Message-State: AOJu0YxNolh+RwxyCx1yaVXFWjfVUaL65s5mtiyX2HV3gyORmLsnF7tp
 Pl79lxj4nkAwVl/xrk9rvXOJwf19ZPHRtjSk8Ys=
X-Google-Smtp-Source: AGHT+IFwezIUbI3wEYe4Qz9v/rY9s7KwxVPkHUraChP8r3uXmQvf/ItbbU0ABgwoX2u+wUWN+OKATw==
X-Received: by 2002:adf:e387:0:b0:32d:a686:dedf with SMTP id
 e7-20020adfe387000000b0032da686dedfmr1661786wrm.57.1697722541149; 
 Thu, 19 Oct 2023 06:35:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/24] xlnx-zynqmp-efuse: hw/nvram: Remove deprecated device
 reset
Date: Thu, 19 Oct 2023 14:35:17 +0100
Message-Id: <20231019133537.2114929-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
Message-id: 20231004055713.324009-1-tong.ho@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvram/xlnx-zynqmp-efuse.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index 228ba0bbfaf..3db5f98ec1a 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -2,6 +2,7 @@
  * QEMU model of the ZynqMP eFuse
  *
  * Copyright (c) 2015 Xilinx Inc.
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
  *
  * Written by Edgar E. Iglesias <edgari@xilinx.com>
  *
@@ -769,9 +770,9 @@ static void zynqmp_efuse_register_reset(RegisterInfo *reg)
     register_reset(reg);
 }
 
-static void zynqmp_efuse_reset(DeviceState *dev)
+static void zynqmp_efuse_reset_hold(Object *obj)
 {
-    XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(dev);
+    XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(obj);
     unsigned int i;
 
     for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
@@ -837,8 +838,9 @@ static Property zynqmp_efuse_props[] = {
 static void zynqmp_efuse_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    dc->reset = zynqmp_efuse_reset;
+    rc->phases.hold = zynqmp_efuse_reset_hold;
     dc->realize = zynqmp_efuse_realize;
     dc->vmsd = &vmstate_efuse;
     device_class_set_props(dc, zynqmp_efuse_props);
-- 
2.34.1


