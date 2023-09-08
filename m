Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D48A798B40
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeew7-0005Vn-5T; Fri, 08 Sep 2023 13:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeew3-0005Tt-Fq
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:23 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevo-00018q-QC
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401da71b83cso25613255e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192767; x=1694797567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SePOo3iDImtb0ZSZJBrNFKJU+w3LKBvacaGB3SVzjwY=;
 b=WJDvOsb02r4LYt/rHjEKp7It0yiq1YLRyR5Zjs2iovPxb/EqedM61rdPwSoy/98+zw
 XH1gYFdZMWsb06lqTZ+w4Wc4pezCvN3uQTfk6LpwJuEtqu0YHVkAMw3JovriQfktlfvp
 KS3DicsBuB9ETrNW6+m9UkjnQXP/mp7Fg/ZN8f4y/W9ml6BafBhfeOeqSTzlVxBB1JI0
 YbT5C26EIYHuMqNsXsdHMJmEUa/DqRlAq56+A6LPfnexCsdR4RaUtppL3XhX050lf05p
 JTfWVyto6jRY9PXo7+BHw2BiOff30CGS7SeNMs4a3/r1dEyRpsbnoCPpR0mwTmUV+C4r
 /NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192767; x=1694797567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SePOo3iDImtb0ZSZJBrNFKJU+w3LKBvacaGB3SVzjwY=;
 b=XDNpsxwFpMAz9fgZtDU9uSPMuSMZ+aPDAu8IzMD1Cnl6Qx4pI2wCxstNxWyRttrZPz
 2Mp+haASZXUyOf987DDOafPOQicp00CFc1QpbEVuQqTK5Li2K80VIb1m4fTtOu3SQih0
 RcUkA/nK6cDgIu4/03tUd9IV52etO9+f3VeVdg8X2qeBDnoVaayYGGOHWFxJQ2EUCgXk
 i+RWXPNBvAln4nJxdSs3eXXuukRc8fyHxoWK5B/K86N+QJF95q5qWW7CLjp3qSjoMH84
 +X4NtCv0mJdOhNVV6LoEa7t3HfwgYVjxB8pyMToZvDEfB/zDqooAI7XPzVugxO8qqEiD
 WM/A==
X-Gm-Message-State: AOJu0Yw8uOL8GPcxXceg8l2lynp7RjpJXnNtQcpcuDyPwWdF/Z3h1Rx/
 Rxeefj4bSuexR3u+9buT9fnPF4M3Y6wzFDJYIIU=
X-Google-Smtp-Source: AGHT+IFN37aEK+/rOxbTO6Zm8oyHW5mOWGsmTZZdPGcmWymfbVqCCBlxN3DVO/u4SoWZf5zOK0Ysww==
X-Received: by 2002:a7b:c7c9:0:b0:401:bf56:8ba6 with SMTP id
 z9-20020a7bc7c9000000b00401bf568ba6mr2515222wmk.28.1694192767210; 
 Fri, 08 Sep 2023 10:06:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/26] hw/misc: Introduce a model of Xilinx Versal's CFRAME_REG
Date: Fri,  8 Sep 2023 18:05:46 +0100
Message-Id: <20230908170557.773048-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Francisco Iglesias <francisco.iglesias@amd.com>

Introduce a model of Xilinx Versal's Configuration Frame controller
(CFRAME_REG).

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20230831165701.2016397-6-francisco.iglesias@amd.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                              |   2 +
 include/hw/misc/xlnx-versal-cframe-reg.h | 286 ++++++++++
 hw/misc/xlnx-versal-cframe-reg.c         | 697 +++++++++++++++++++++++
 hw/misc/meson.build                      |   1 +
 4 files changed, 986 insertions(+)
 create mode 100644 include/hw/misc/xlnx-versal-cframe-reg.h
 create mode 100644 hw/misc/xlnx-versal-cframe-reg.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b01fbe065e..57c5533dcfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1033,6 +1033,8 @@ F: hw/misc/xlnx-cfi-if.c
 F: include/hw/misc/xlnx-cfi-if.h
 F: hw/misc/xlnx-versal-cfu.c
 F: include/hw/misc/xlnx-versal-cfu.h
+F: hw/misc/xlnx-versal-cframe-reg.c
+F: include/hw/misc/xlnx-versal-cframe-reg.h
 
 STM32F100
 M: Alexandre Iooss <erdnaxe@crans.org>
diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/xlnx-versal-cframe-reg.h
new file mode 100644
index 00000000000..f286d973bf1
--- /dev/null
+++ b/include/hw/misc/xlnx-versal-cframe-reg.h
@@ -0,0 +1,286 @@
+/*
+ * QEMU model of the Configuration Frame Control module
+ *
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ *
+ * Written by Francisco Iglesias <francisco.iglesias@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * References:
+ * [1] Versal ACAP Technical Reference Manual,
+ *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
+ *
+ * [2] Versal ACAP Register Reference,
+ *     https://www.xilinx.com/htmldocs/registers/am012/am012-versal-register-reference.html
+ */
+#ifndef HW_MISC_XLNX_VERSAL_CFRAME_REG_H
+#define HW_MISC_XLNX_VERSAL_CFRAME_REG_H
+
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "hw/misc/xlnx-cfi-if.h"
+#include "hw/misc/xlnx-versal-cfu.h"
+#include "qemu/fifo32.h"
+
+#define TYPE_XLNX_VERSAL_CFRAME_REG "xlnx,cframe-reg"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFrameReg, XLNX_VERSAL_CFRAME_REG)
+
+/*
+ * The registers in this module are 128 bits wide but it is ok to write
+ * and read them through 4 sequential 32 bit accesses (address[3:2] = 0,
+ * 1, 2, 3).
+ */
+REG32(CRC0, 0x0)
+    FIELD(CRC, CRC, 0, 32)
+REG32(CRC1, 0x4)
+REG32(CRC2, 0x8)
+REG32(CRC3, 0xc)
+REG32(FAR0, 0x10)
+    FIELD(FAR0, SEGMENT, 23, 2)
+    FIELD(FAR0, BLOCKTYPE, 20, 3)
+    FIELD(FAR0, FRAME_ADDR, 0, 20)
+REG32(FAR1, 0x14)
+REG32(FAR2, 0x18)
+REG32(FAR3, 0x1c)
+REG32(FAR_SFR0, 0x20)
+    FIELD(FAR_SFR0, BLOCKTYPE, 20, 3)
+    FIELD(FAR_SFR0, FRAME_ADDR, 0, 20)
+REG32(FAR_SFR1, 0x24)
+REG32(FAR_SFR2, 0x28)
+REG32(FAR_SFR3, 0x2c)
+REG32(FDRI0, 0x40)
+REG32(FDRI1, 0x44)
+REG32(FDRI2, 0x48)
+REG32(FDRI3, 0x4c)
+REG32(FRCNT0, 0x50)
+    FIELD(FRCNT0, FRCNT, 0, 32)
+REG32(FRCNT1, 0x54)
+REG32(FRCNT2, 0x58)
+REG32(FRCNT3, 0x5c)
+REG32(CMD0, 0x60)
+    FIELD(CMD0, CMD, 0, 5)
+REG32(CMD1, 0x64)
+REG32(CMD2, 0x68)
+REG32(CMD3, 0x6c)
+REG32(CR_MASK0, 0x70)
+REG32(CR_MASK1, 0x74)
+REG32(CR_MASK2, 0x78)
+REG32(CR_MASK3, 0x7c)
+REG32(CTL0, 0x80)
+    FIELD(CTL, PER_FRAME_CRC, 0, 1)
+REG32(CTL1, 0x84)
+REG32(CTL2, 0x88)
+REG32(CTL3, 0x8c)
+REG32(CFRM_ISR0, 0x150)
+    FIELD(CFRM_ISR0, READ_BROADCAST_ERROR, 21, 1)
+    FIELD(CFRM_ISR0, CMD_MISSING_ERROR, 20, 1)
+    FIELD(CFRM_ISR0, RW_ROWOFF_ERROR, 19, 1)
+    FIELD(CFRM_ISR0, READ_REG_ADDR_ERROR, 18, 1)
+    FIELD(CFRM_ISR0, READ_BLK_TYPE_ERROR, 17, 1)
+    FIELD(CFRM_ISR0, READ_FRAME_ADDR_ERROR, 16, 1)
+    FIELD(CFRM_ISR0, WRITE_REG_ADDR_ERROR, 15, 1)
+    FIELD(CFRM_ISR0, WRITE_BLK_TYPE_ERROR, 13, 1)
+    FIELD(CFRM_ISR0, WRITE_FRAME_ADDR_ERROR, 12, 1)
+    FIELD(CFRM_ISR0, MFW_OVERRUN_ERROR, 11, 1)
+    FIELD(CFRM_ISR0, FAR_FIFO_UNDERFLOW, 10, 1)
+    FIELD(CFRM_ISR0, FAR_FIFO_OVERFLOW, 9, 1)
+    FIELD(CFRM_ISR0, PER_FRAME_SEQ_ERROR, 8, 1)
+    FIELD(CFRM_ISR0, CRC_ERROR, 7, 1)
+    FIELD(CFRM_ISR0, WRITE_OVERRUN_ERROR, 6, 1)
+    FIELD(CFRM_ISR0, READ_OVERRUN_ERROR, 5, 1)
+    FIELD(CFRM_ISR0, CMD_INTERRUPT_ERROR, 4, 1)
+    FIELD(CFRM_ISR0, WRITE_INTERRUPT_ERROR, 3, 1)
+    FIELD(CFRM_ISR0, READ_INTERRUPT_ERROR, 2, 1)
+    FIELD(CFRM_ISR0, SEU_CRC_ERROR, 1, 1)
+    FIELD(CFRM_ISR0, SEU_ECC_ERROR, 0, 1)
+REG32(CFRM_ISR1, 0x154)
+REG32(CFRM_ISR2, 0x158)
+REG32(CFRM_ISR3, 0x15c)
+REG32(CFRM_IMR0, 0x160)
+    FIELD(CFRM_IMR0, READ_BROADCAST_ERROR, 21, 1)
+    FIELD(CFRM_IMR0, CMD_MISSING_ERROR, 20, 1)
+    FIELD(CFRM_IMR0, RW_ROWOFF_ERROR, 19, 1)
+    FIELD(CFRM_IMR0, READ_REG_ADDR_ERROR, 18, 1)
+    FIELD(CFRM_IMR0, READ_BLK_TYPE_ERROR, 17, 1)
+    FIELD(CFRM_IMR0, READ_FRAME_ADDR_ERROR, 16, 1)
+    FIELD(CFRM_IMR0, WRITE_REG_ADDR_ERROR, 15, 1)
+    FIELD(CFRM_IMR0, WRITE_BLK_TYPE_ERROR, 13, 1)
+    FIELD(CFRM_IMR0, WRITE_FRAME_ADDR_ERROR, 12, 1)
+    FIELD(CFRM_IMR0, MFW_OVERRUN_ERROR, 11, 1)
+    FIELD(CFRM_IMR0, FAR_FIFO_UNDERFLOW, 10, 1)
+    FIELD(CFRM_IMR0, FAR_FIFO_OVERFLOW, 9, 1)
+    FIELD(CFRM_IMR0, PER_FRAME_SEQ_ERROR, 8, 1)
+    FIELD(CFRM_IMR0, CRC_ERROR, 7, 1)
+    FIELD(CFRM_IMR0, WRITE_OVERRUN_ERROR, 6, 1)
+    FIELD(CFRM_IMR0, READ_OVERRUN_ERROR, 5, 1)
+    FIELD(CFRM_IMR0, CMD_INTERRUPT_ERROR, 4, 1)
+    FIELD(CFRM_IMR0, WRITE_INTERRUPT_ERROR, 3, 1)
+    FIELD(CFRM_IMR0, READ_INTERRUPT_ERROR, 2, 1)
+    FIELD(CFRM_IMR0, SEU_CRC_ERROR, 1, 1)
+    FIELD(CFRM_IMR0, SEU_ECC_ERROR, 0, 1)
+REG32(CFRM_IMR1, 0x164)
+REG32(CFRM_IMR2, 0x168)
+REG32(CFRM_IMR3, 0x16c)
+REG32(CFRM_IER0, 0x170)
+    FIELD(CFRM_IER0, READ_BROADCAST_ERROR, 21, 1)
+    FIELD(CFRM_IER0, CMD_MISSING_ERROR, 20, 1)
+    FIELD(CFRM_IER0, RW_ROWOFF_ERROR, 19, 1)
+    FIELD(CFRM_IER0, READ_REG_ADDR_ERROR, 18, 1)
+    FIELD(CFRM_IER0, READ_BLK_TYPE_ERROR, 17, 1)
+    FIELD(CFRM_IER0, READ_FRAME_ADDR_ERROR, 16, 1)
+    FIELD(CFRM_IER0, WRITE_REG_ADDR_ERROR, 15, 1)
+    FIELD(CFRM_IER0, WRITE_BLK_TYPE_ERROR, 13, 1)
+    FIELD(CFRM_IER0, WRITE_FRAME_ADDR_ERROR, 12, 1)
+    FIELD(CFRM_IER0, MFW_OVERRUN_ERROR, 11, 1)
+    FIELD(CFRM_IER0, FAR_FIFO_UNDERFLOW, 10, 1)
+    FIELD(CFRM_IER0, FAR_FIFO_OVERFLOW, 9, 1)
+    FIELD(CFRM_IER0, PER_FRAME_SEQ_ERROR, 8, 1)
+    FIELD(CFRM_IER0, CRC_ERROR, 7, 1)
+    FIELD(CFRM_IER0, WRITE_OVERRUN_ERROR, 6, 1)
+    FIELD(CFRM_IER0, READ_OVERRUN_ERROR, 5, 1)
+    FIELD(CFRM_IER0, CMD_INTERRUPT_ERROR, 4, 1)
+    FIELD(CFRM_IER0, WRITE_INTERRUPT_ERROR, 3, 1)
+    FIELD(CFRM_IER0, READ_INTERRUPT_ERROR, 2, 1)
+    FIELD(CFRM_IER0, SEU_CRC_ERROR, 1, 1)
+    FIELD(CFRM_IER0, SEU_ECC_ERROR, 0, 1)
+REG32(CFRM_IER1, 0x174)
+REG32(CFRM_IER2, 0x178)
+REG32(CFRM_IER3, 0x17c)
+REG32(CFRM_IDR0, 0x180)
+    FIELD(CFRM_IDR0, READ_BROADCAST_ERROR, 21, 1)
+    FIELD(CFRM_IDR0, CMD_MISSING_ERROR, 20, 1)
+    FIELD(CFRM_IDR0, RW_ROWOFF_ERROR, 19, 1)
+    FIELD(CFRM_IDR0, READ_REG_ADDR_ERROR, 18, 1)
+    FIELD(CFRM_IDR0, READ_BLK_TYPE_ERROR, 17, 1)
+    FIELD(CFRM_IDR0, READ_FRAME_ADDR_ERROR, 16, 1)
+    FIELD(CFRM_IDR0, WRITE_REG_ADDR_ERROR, 15, 1)
+    FIELD(CFRM_IDR0, WRITE_BLK_TYPE_ERROR, 13, 1)
+    FIELD(CFRM_IDR0, WRITE_FRAME_ADDR_ERROR, 12, 1)
+    FIELD(CFRM_IDR0, MFW_OVERRUN_ERROR, 11, 1)
+    FIELD(CFRM_IDR0, FAR_FIFO_UNDERFLOW, 10, 1)
+    FIELD(CFRM_IDR0, FAR_FIFO_OVERFLOW, 9, 1)
+    FIELD(CFRM_IDR0, PER_FRAME_SEQ_ERROR, 8, 1)
+    FIELD(CFRM_IDR0, CRC_ERROR, 7, 1)
+    FIELD(CFRM_IDR0, WRITE_OVERRUN_ERROR, 6, 1)
+    FIELD(CFRM_IDR0, READ_OVERRUN_ERROR, 5, 1)
+    FIELD(CFRM_IDR0, CMD_INTERRUPT_ERROR, 4, 1)
+    FIELD(CFRM_IDR0, WRITE_INTERRUPT_ERROR, 3, 1)
+    FIELD(CFRM_IDR0, READ_INTERRUPT_ERROR, 2, 1)
+    FIELD(CFRM_IDR0, SEU_CRC_ERROR, 1, 1)
+    FIELD(CFRM_IDR0, SEU_ECC_ERROR, 0, 1)
+REG32(CFRM_IDR1, 0x184)
+REG32(CFRM_IDR2, 0x188)
+REG32(CFRM_IDR3, 0x18c)
+REG32(CFRM_ITR0, 0x190)
+    FIELD(CFRM_ITR0, READ_BROADCAST_ERROR, 21, 1)
+    FIELD(CFRM_ITR0, CMD_MISSING_ERROR, 20, 1)
+    FIELD(CFRM_ITR0, RW_ROWOFF_ERROR, 19, 1)
+    FIELD(CFRM_ITR0, READ_REG_ADDR_ERROR, 18, 1)
+    FIELD(CFRM_ITR0, READ_BLK_TYPE_ERROR, 17, 1)
+    FIELD(CFRM_ITR0, READ_FRAME_ADDR_ERROR, 16, 1)
+    FIELD(CFRM_ITR0, WRITE_REG_ADDR_ERROR, 15, 1)
+    FIELD(CFRM_ITR0, WRITE_BLK_TYPE_ERROR, 13, 1)
+    FIELD(CFRM_ITR0, WRITE_FRAME_ADDR_ERROR, 12, 1)
+    FIELD(CFRM_ITR0, MFW_OVERRUN_ERROR, 11, 1)
+    FIELD(CFRM_ITR0, FAR_FIFO_UNDERFLOW, 10, 1)
+    FIELD(CFRM_ITR0, FAR_FIFO_OVERFLOW, 9, 1)
+    FIELD(CFRM_ITR0, PER_FRAME_SEQ_ERROR, 8, 1)
+    FIELD(CFRM_ITR0, CRC_ERROR, 7, 1)
+    FIELD(CFRM_ITR0, WRITE_OVERRUN_ERROR, 6, 1)
+    FIELD(CFRM_ITR0, READ_OVERRUN_ERROR, 5, 1)
+    FIELD(CFRM_ITR0, CMD_INTERRUPT_ERROR, 4, 1)
+    FIELD(CFRM_ITR0, WRITE_INTERRUPT_ERROR, 3, 1)
+    FIELD(CFRM_ITR0, READ_INTERRUPT_ERROR, 2, 1)
+    FIELD(CFRM_ITR0, SEU_CRC_ERROR, 1, 1)
+    FIELD(CFRM_ITR0, SEU_ECC_ERROR, 0, 1)
+REG32(CFRM_ITR1, 0x194)
+REG32(CFRM_ITR2, 0x198)
+REG32(CFRM_ITR3, 0x19c)
+REG32(SEU_SYNDRM00, 0x1a0)
+REG32(SEU_SYNDRM01, 0x1a4)
+REG32(SEU_SYNDRM02, 0x1a8)
+REG32(SEU_SYNDRM03, 0x1ac)
+REG32(SEU_SYNDRM10, 0x1b0)
+REG32(SEU_SYNDRM11, 0x1b4)
+REG32(SEU_SYNDRM12, 0x1b8)
+REG32(SEU_SYNDRM13, 0x1bc)
+REG32(SEU_SYNDRM20, 0x1c0)
+REG32(SEU_SYNDRM21, 0x1c4)
+REG32(SEU_SYNDRM22, 0x1c8)
+REG32(SEU_SYNDRM23, 0x1cc)
+REG32(SEU_SYNDRM30, 0x1d0)
+REG32(SEU_SYNDRM31, 0x1d4)
+REG32(SEU_SYNDRM32, 0x1d8)
+REG32(SEU_SYNDRM33, 0x1dc)
+REG32(SEU_VIRTUAL_SYNDRM0, 0x1e0)
+REG32(SEU_VIRTUAL_SYNDRM1, 0x1e4)
+REG32(SEU_VIRTUAL_SYNDRM2, 0x1e8)
+REG32(SEU_VIRTUAL_SYNDRM3, 0x1ec)
+REG32(SEU_CRC0, 0x1f0)
+REG32(SEU_CRC1, 0x1f4)
+REG32(SEU_CRC2, 0x1f8)
+REG32(SEU_CRC3, 0x1fc)
+REG32(CFRAME_FAR_BOT0, 0x200)
+REG32(CFRAME_FAR_BOT1, 0x204)
+REG32(CFRAME_FAR_BOT2, 0x208)
+REG32(CFRAME_FAR_BOT3, 0x20c)
+REG32(CFRAME_FAR_TOP0, 0x210)
+REG32(CFRAME_FAR_TOP1, 0x214)
+REG32(CFRAME_FAR_TOP2, 0x218)
+REG32(CFRAME_FAR_TOP3, 0x21c)
+REG32(LAST_FRAME_BOT0, 0x220)
+    FIELD(LAST_FRAME_BOT0, BLOCKTYPE1_LAST_FRAME_LSB, 20, 12)
+    FIELD(LAST_FRAME_BOT0, BLOCKTYPE0_LAST_FRAME, 0, 20)
+REG32(LAST_FRAME_BOT1, 0x224)
+    FIELD(LAST_FRAME_BOT1, BLOCKTYPE3_LAST_FRAME_LSB, 28, 4)
+    FIELD(LAST_FRAME_BOT1, BLOCKTYPE2_LAST_FRAME, 8, 20)
+    FIELD(LAST_FRAME_BOT1, BLOCKTYPE1_LAST_FRAME_MSB, 0, 8)
+REG32(LAST_FRAME_BOT2, 0x228)
+    FIELD(LAST_FRAME_BOT2, BLOCKTYPE3_LAST_FRAME_MSB, 0, 16)
+REG32(LAST_FRAME_BOT3, 0x22c)
+REG32(LAST_FRAME_TOP0, 0x230)
+    FIELD(LAST_FRAME_TOP0, BLOCKTYPE5_LAST_FRAME_LSB, 20, 12)
+    FIELD(LAST_FRAME_TOP0, BLOCKTYPE4_LAST_FRAME, 0, 20)
+REG32(LAST_FRAME_TOP1, 0x234)
+    FIELD(LAST_FRAME_TOP1, BLOCKTYPE6_LAST_FRAME, 8, 20)
+    FIELD(LAST_FRAME_TOP1, BLOCKTYPE5_LAST_FRAME_MSB, 0, 8)
+REG32(LAST_FRAME_TOP2, 0x238)
+REG32(LAST_FRAME_TOP3, 0x23c)
+
+#define CFRAME_REG_R_MAX (R_LAST_FRAME_TOP3 + 1)
+
+#define FRAME_NUM_QWORDS 25
+#define FRAME_NUM_WORDS (FRAME_NUM_QWORDS * 4) /* 25 * 128 bits */
+
+typedef struct XlnxCFrame {
+    uint32_t data[FRAME_NUM_WORDS];
+} XlnxCFrame;
+
+struct XlnxVersalCFrameReg {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    MemoryRegion iomem_fdri;
+    qemu_irq irq_cfrm_imr;
+
+    /* 128-bit wfifo.  */
+    uint32_t wfifo[WFIFO_SZ];
+
+    uint32_t regs[CFRAME_REG_R_MAX];
+    RegisterInfo regs_info[CFRAME_REG_R_MAX];
+
+    bool rowon;
+    bool wcfg;
+    bool rcfg;
+
+    GTree *cframes;
+    Fifo32 new_f_data;
+
+    struct {
+        XlnxCfiIf *cfu_fdro;
+        uint32_t blktype_num_frames[7];
+    } cfg;
+    bool row_configured;
+};
+
+#endif
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
new file mode 100644
index 00000000000..78db68f10c2
--- /dev/null
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -0,0 +1,697 @@
+/*
+ * QEMU model of the Configuration Frame Control module
+ *
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ *
+ * Written by Francisco Iglesias <francisco.iglesias@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "hw/registerfields.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "hw/misc/xlnx-versal-cframe-reg.h"
+
+#ifndef XLNX_VERSAL_CFRAME_REG_ERR_DEBUG
+#define XLNX_VERSAL_CFRAME_REG_ERR_DEBUG 0
+#endif
+
+#define KEYHOLE_STREAM_4K (4 * KiB)
+#define N_WORDS_128BIT 4
+
+#define MAX_BLOCKTYPE 6
+#define MAX_BLOCKTYPE_FRAMES 0xFFFFF
+
+enum {
+    CFRAME_CMD_WCFG = 1,
+    CFRAME_CMD_ROWON = 2,
+    CFRAME_CMD_ROWOFF = 3,
+    CFRAME_CMD_RCFG = 4,
+    CFRAME_CMD_DLPARK = 5,
+};
+
+static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
+{
+    guint ua = GPOINTER_TO_UINT(a);
+    guint ub = GPOINTER_TO_UINT(b);
+    return (ua > ub) - (ua < ub);
+}
+
+static void cfrm_imr_update_irq(XlnxVersalCFrameReg *s)
+{
+    bool pending = s->regs[R_CFRM_ISR0] & ~s->regs[R_CFRM_IMR0];
+    qemu_set_irq(s->irq_cfrm_imr, pending);
+}
+
+static void cfrm_isr_postw(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+    cfrm_imr_update_irq(s);
+}
+
+static uint64_t cfrm_ier_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    s->regs[R_CFRM_IMR0] &= ~s->regs[R_CFRM_IER0];
+    s->regs[R_CFRM_IER0] = 0;
+    cfrm_imr_update_irq(s);
+    return 0;
+}
+
+static uint64_t cfrm_idr_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    s->regs[R_CFRM_IMR0] |= s->regs[R_CFRM_IDR0];
+    s->regs[R_CFRM_IDR0] = 0;
+    cfrm_imr_update_irq(s);
+    return 0;
+}
+
+static uint64_t cfrm_itr_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    s->regs[R_CFRM_ISR0] |= s->regs[R_CFRM_ITR0];
+    s->regs[R_CFRM_ITR0] = 0;
+    cfrm_imr_update_irq(s);
+    return 0;
+}
+
+static void cframe_incr_far(XlnxVersalCFrameReg *s)
+{
+    uint32_t faddr = ARRAY_FIELD_EX32(s->regs, FAR0, FRAME_ADDR);
+    uint32_t blktype = ARRAY_FIELD_EX32(s->regs, FAR0, BLOCKTYPE);
+
+    assert(blktype <= MAX_BLOCKTYPE);
+
+    faddr++;
+    if (faddr > s->cfg.blktype_num_frames[blktype]) {
+        /* Restart from 0 and increment block type */
+        faddr = 0;
+        blktype++;
+
+        assert(blktype <= MAX_BLOCKTYPE);
+
+        ARRAY_FIELD_DP32(s->regs, FAR0, BLOCKTYPE, blktype);
+    }
+
+    ARRAY_FIELD_DP32(s->regs, FAR0, FRAME_ADDR, faddr);
+}
+
+static void cfrm_fdri_post_write(RegisterInfo *reg, uint64_t val)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    if (s->row_configured && s->rowon && s->wcfg) {
+
+        if (fifo32_num_free(&s->new_f_data) >= N_WORDS_128BIT) {
+            fifo32_push(&s->new_f_data, s->regs[R_FDRI0]);
+            fifo32_push(&s->new_f_data, s->regs[R_FDRI1]);
+            fifo32_push(&s->new_f_data, s->regs[R_FDRI2]);
+            fifo32_push(&s->new_f_data, s->regs[R_FDRI3]);
+        }
+
+        if (fifo32_is_full(&s->new_f_data)) {
+            uint32_t addr = extract32(s->regs[R_FAR0], 0, 23);
+            XlnxCFrame *f = g_new(XlnxCFrame, 1);
+
+            for (int i = 0; i < FRAME_NUM_WORDS; i++) {
+                f->data[i] = fifo32_pop(&s->new_f_data);
+            }
+
+            g_tree_replace(s->cframes, GUINT_TO_POINTER(addr), f);
+
+            cframe_incr_far(s);
+
+            fifo32_reset(&s->new_f_data);
+        }
+    }
+}
+
+static void cfrm_readout_frames(XlnxVersalCFrameReg *s, uint32_t start_addr,
+                                uint32_t end_addr)
+{
+    /*
+     * NB: when our minimum glib version is at least 2.68 we can improve the
+     * performance of the cframe traversal by using g_tree_lookup_node and
+     * g_tree_node_next (instead of calling g_tree_lookup for finding each
+     * cframe).
+     */
+    for (uint32_t addr = start_addr; addr < end_addr; addr++) {
+        XlnxCFrame *f = g_tree_lookup(s->cframes, GUINT_TO_POINTER(addr));
+
+        /* Transmit the data if a frame was found */
+        if (f) {
+            for (int i = 0; i < FRAME_NUM_WORDS; i += 4) {
+                XlnxCfiPacket pkt = {};
+
+                pkt.data[0] = f->data[i];
+                pkt.data[1] = f->data[i + 1];
+                pkt.data[2] = f->data[i + 2];
+                pkt.data[3] = f->data[i + 3];
+
+                if (s->cfg.cfu_fdro) {
+                    xlnx_cfi_transfer_packet(s->cfg.cfu_fdro, &pkt);
+                }
+            }
+        }
+    }
+}
+
+static void cfrm_frcnt_post_write(RegisterInfo *reg, uint64_t val)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    if (s->row_configured && s->rowon && s->rcfg) {
+        uint32_t start_addr = extract32(s->regs[R_FAR0], 0, 23);
+        uint32_t end_addr = start_addr + s->regs[R_FRCNT0] / FRAME_NUM_QWORDS;
+
+        cfrm_readout_frames(s, start_addr, end_addr);
+    }
+}
+
+static void cfrm_cmd_post_write(RegisterInfo *reg, uint64_t val)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    if (s->row_configured) {
+        uint8_t cmd = ARRAY_FIELD_EX32(s->regs, CMD0, CMD);
+
+        switch (cmd) {
+        case CFRAME_CMD_WCFG:
+            s->wcfg = true;
+            break;
+        case CFRAME_CMD_ROWON:
+            s->rowon = true;
+            break;
+        case CFRAME_CMD_ROWOFF:
+            s->rowon = false;
+            break;
+        case CFRAME_CMD_RCFG:
+            s->rcfg = true;
+            break;
+        case CFRAME_CMD_DLPARK:
+            s->wcfg = false;
+            s->rcfg = false;
+            break;
+        default:
+            break;
+        };
+    }
+}
+
+static uint64_t cfrm_last_frame_bot_post_read(RegisterInfo *reg,
+                                              uint64_t val64)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+    uint64_t val = 0;
+
+    switch (reg->access->addr) {
+    case A_LAST_FRAME_BOT0:
+        val = FIELD_DP32(val, LAST_FRAME_BOT0, BLOCKTYPE1_LAST_FRAME_LSB,
+                         s->cfg.blktype_num_frames[1]);
+        val = FIELD_DP32(val, LAST_FRAME_BOT0, BLOCKTYPE0_LAST_FRAME,
+                         s->cfg.blktype_num_frames[0]);
+        break;
+    case A_LAST_FRAME_BOT1:
+        val = FIELD_DP32(val, LAST_FRAME_BOT1, BLOCKTYPE3_LAST_FRAME_LSB,
+                         s->cfg.blktype_num_frames[3]);
+        val = FIELD_DP32(val, LAST_FRAME_BOT1, BLOCKTYPE2_LAST_FRAME,
+                         s->cfg.blktype_num_frames[2]);
+        val = FIELD_DP32(val, LAST_FRAME_BOT1, BLOCKTYPE1_LAST_FRAME_MSB,
+                         (s->cfg.blktype_num_frames[1] >> 12));
+        break;
+    case A_LAST_FRAME_BOT2:
+        val = FIELD_DP32(val, LAST_FRAME_BOT2, BLOCKTYPE3_LAST_FRAME_MSB,
+                         (s->cfg.blktype_num_frames[3] >> 4));
+        break;
+    case A_LAST_FRAME_BOT3:
+    default:
+        break;
+    }
+
+    return val;
+}
+
+static uint64_t cfrm_last_frame_top_post_read(RegisterInfo *reg,
+                                              uint64_t val64)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+    uint64_t val = 0;
+
+    switch (reg->access->addr) {
+    case A_LAST_FRAME_TOP0:
+        val = FIELD_DP32(val, LAST_FRAME_TOP0, BLOCKTYPE5_LAST_FRAME_LSB,
+                         s->cfg.blktype_num_frames[5]);
+        val = FIELD_DP32(val, LAST_FRAME_TOP0, BLOCKTYPE4_LAST_FRAME,
+                         s->cfg.blktype_num_frames[4]);
+        break;
+    case A_LAST_FRAME_TOP1:
+        val = FIELD_DP32(val, LAST_FRAME_TOP1, BLOCKTYPE6_LAST_FRAME,
+                         s->cfg.blktype_num_frames[6]);
+        val = FIELD_DP32(val, LAST_FRAME_TOP1, BLOCKTYPE5_LAST_FRAME_MSB,
+                         (s->cfg.blktype_num_frames[5] >> 12));
+        break;
+    case A_LAST_FRAME_TOP2:
+    case A_LAST_FRAME_BOT3:
+    default:
+        break;
+    }
+
+    return val;
+}
+
+static void cfrm_far_sfr_post_write(RegisterInfo *reg, uint64_t val)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    if (s->row_configured && s->rowon && s->rcfg) {
+        uint32_t start_addr = extract32(s->regs[R_FAR_SFR0], 0, 23);
+
+        /* Readback 1 frame */
+        cfrm_readout_frames(s, start_addr, start_addr + 1);
+    }
+}
+
+static const RegisterAccessInfo cframe_reg_regs_info[] = {
+    {   .name = "CRC0",  .addr = A_CRC0,
+        .rsvd = 0x00000000,
+    },{ .name = "CRC1",  .addr = A_CRC0,
+        .rsvd = 0xffffffff,
+    },{ .name = "CRC2",  .addr = A_CRC0,
+        .rsvd = 0xffffffff,
+    },{ .name = "CRC3",  .addr = A_CRC0,
+        .rsvd = 0xffffffff,
+    },{ .name = "FAR0",  .addr = A_FAR0,
+        .rsvd = 0xfe000000,
+    },{ .name = "FAR1",  .addr = A_FAR1,
+        .rsvd = 0xffffffff,
+    },{ .name = "FAR2",  .addr = A_FAR2,
+        .rsvd = 0xffffffff,
+    },{ .name = "FAR3",  .addr = A_FAR3,
+        .rsvd = 0xffffffff,
+    },{ .name = "FAR_SFR0",  .addr = A_FAR_SFR0,
+        .rsvd = 0xff800000,
+    },{ .name = "FAR_SFR1",  .addr = A_FAR_SFR1,
+        .rsvd = 0xffffffff,
+    },{ .name = "FAR_SFR2",  .addr = A_FAR_SFR2,
+        .rsvd = 0xffffffff,
+    },{ .name = "FAR_SFR3",  .addr = A_FAR_SFR3,
+        .rsvd = 0xffffffff,
+        .post_write = cfrm_far_sfr_post_write,
+    },{ .name = "FDRI0",  .addr = A_FDRI0,
+    },{ .name = "FDRI1",  .addr = A_FDRI1,
+    },{ .name = "FDRI2",  .addr = A_FDRI2,
+    },{ .name = "FDRI3",  .addr = A_FDRI3,
+        .post_write = cfrm_fdri_post_write,
+    },{ .name = "FRCNT0",  .addr = A_FRCNT0,
+        .rsvd = 0x00000000,
+    },{ .name = "FRCNT1",  .addr = A_FRCNT1,
+        .rsvd = 0xffffffff,
+    },{ .name = "FRCNT2",  .addr = A_FRCNT2,
+        .rsvd = 0xffffffff,
+    },{ .name = "FRCNT3",  .addr = A_FRCNT3,
+        .rsvd = 0xffffffff,
+        .post_write = cfrm_frcnt_post_write
+    },{ .name = "CMD0",  .addr = A_CMD0,
+        .rsvd = 0xffffffe0,
+    },{ .name = "CMD1",  .addr = A_CMD1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CMD2",  .addr = A_CMD2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CMD3",  .addr = A_CMD3,
+        .rsvd = 0xffffffff,
+        .post_write = cfrm_cmd_post_write
+    },{ .name = "CR_MASK0",  .addr = A_CR_MASK0,
+        .rsvd = 0x00000000,
+    },{ .name = "CR_MASK1",  .addr = A_CR_MASK1,
+        .rsvd = 0x00000000,
+    },{ .name = "CR_MASK2",  .addr = A_CR_MASK2,
+        .rsvd = 0x00000000,
+    },{ .name = "CR_MASK3",  .addr = A_CR_MASK3,
+        .rsvd = 0xffffffff,
+    },{ .name = "CTL0",  .addr = A_CTL0,
+        .rsvd = 0xfffffff8,
+    },{ .name = "CTL1",  .addr = A_CTL1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CTL2",  .addr = A_CTL2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CTL3",  .addr = A_CTL3,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_ISR0",  .addr = A_CFRM_ISR0,
+        .rsvd = 0xffc04000,
+        .w1c = 0x3bfff,
+    },{ .name = "CFRM_ISR1",  .addr = A_CFRM_ISR1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_ISR2",  .addr = A_CFRM_ISR2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_ISR3",  .addr = A_CFRM_ISR3,
+        .rsvd = 0xffffffff,
+        .post_write = cfrm_isr_postw,
+    },{ .name = "CFRM_IMR0",  .addr = A_CFRM_IMR0,
+        .rsvd = 0xffc04000,
+        .ro = 0xfffff,
+        .reset = 0x3bfff,
+    },{ .name = "CFRM_IMR1",  .addr = A_CFRM_IMR1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IMR2",  .addr = A_CFRM_IMR2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IMR3",  .addr = A_CFRM_IMR3,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IER0",  .addr = A_CFRM_IER0,
+        .rsvd = 0xffc04000,
+    },{ .name = "CFRM_IER1",  .addr = A_CFRM_IER1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IER2",  .addr = A_CFRM_IER2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IER3",  .addr = A_CFRM_IER3,
+        .rsvd = 0xffffffff,
+        .pre_write = cfrm_ier_prew,
+    },{ .name = "CFRM_IDR0",  .addr = A_CFRM_IDR0,
+        .rsvd = 0xffc04000,
+    },{ .name = "CFRM_IDR1",  .addr = A_CFRM_IDR1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IDR2",  .addr = A_CFRM_IDR2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IDR3",  .addr = A_CFRM_IDR3,
+        .rsvd = 0xffffffff,
+        .pre_write = cfrm_idr_prew,
+    },{ .name = "CFRM_ITR0",  .addr = A_CFRM_ITR0,
+        .rsvd = 0xffc04000,
+    },{ .name = "CFRM_ITR1",  .addr = A_CFRM_ITR1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_ITR2",  .addr = A_CFRM_ITR2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_ITR3",  .addr = A_CFRM_ITR3,
+        .rsvd = 0xffffffff,
+        .pre_write = cfrm_itr_prew,
+    },{ .name = "SEU_SYNDRM00",  .addr = A_SEU_SYNDRM00,
+    },{ .name = "SEU_SYNDRM01",  .addr = A_SEU_SYNDRM01,
+    },{ .name = "SEU_SYNDRM02",  .addr = A_SEU_SYNDRM02,
+    },{ .name = "SEU_SYNDRM03",  .addr = A_SEU_SYNDRM03,
+    },{ .name = "SEU_SYNDRM10",  .addr = A_SEU_SYNDRM10,
+    },{ .name = "SEU_SYNDRM11",  .addr = A_SEU_SYNDRM11,
+    },{ .name = "SEU_SYNDRM12",  .addr = A_SEU_SYNDRM12,
+    },{ .name = "SEU_SYNDRM13",  .addr = A_SEU_SYNDRM13,
+    },{ .name = "SEU_SYNDRM20",  .addr = A_SEU_SYNDRM20,
+    },{ .name = "SEU_SYNDRM21",  .addr = A_SEU_SYNDRM21,
+    },{ .name = "SEU_SYNDRM22",  .addr = A_SEU_SYNDRM22,
+    },{ .name = "SEU_SYNDRM23",  .addr = A_SEU_SYNDRM23,
+    },{ .name = "SEU_SYNDRM30",  .addr = A_SEU_SYNDRM30,
+    },{ .name = "SEU_SYNDRM31",  .addr = A_SEU_SYNDRM31,
+    },{ .name = "SEU_SYNDRM32",  .addr = A_SEU_SYNDRM32,
+    },{ .name = "SEU_SYNDRM33",  .addr = A_SEU_SYNDRM33,
+    },{ .name = "SEU_VIRTUAL_SYNDRM0",  .addr = A_SEU_VIRTUAL_SYNDRM0,
+    },{ .name = "SEU_VIRTUAL_SYNDRM1",  .addr = A_SEU_VIRTUAL_SYNDRM1,
+    },{ .name = "SEU_VIRTUAL_SYNDRM2",  .addr = A_SEU_VIRTUAL_SYNDRM2,
+    },{ .name = "SEU_VIRTUAL_SYNDRM3",  .addr = A_SEU_VIRTUAL_SYNDRM3,
+    },{ .name = "SEU_CRC0",  .addr = A_SEU_CRC0,
+    },{ .name = "SEU_CRC1",  .addr = A_SEU_CRC1,
+    },{ .name = "SEU_CRC2",  .addr = A_SEU_CRC2,
+    },{ .name = "SEU_CRC3",  .addr = A_SEU_CRC3,
+    },{ .name = "CFRAME_FAR_BOT0",  .addr = A_CFRAME_FAR_BOT0,
+    },{ .name = "CFRAME_FAR_BOT1",  .addr = A_CFRAME_FAR_BOT1,
+    },{ .name = "CFRAME_FAR_BOT2",  .addr = A_CFRAME_FAR_BOT2,
+    },{ .name = "CFRAME_FAR_BOT3",  .addr = A_CFRAME_FAR_BOT3,
+    },{ .name = "CFRAME_FAR_TOP0",  .addr = A_CFRAME_FAR_TOP0,
+    },{ .name = "CFRAME_FAR_TOP1",  .addr = A_CFRAME_FAR_TOP1,
+    },{ .name = "CFRAME_FAR_TOP2",  .addr = A_CFRAME_FAR_TOP2,
+    },{ .name = "CFRAME_FAR_TOP3",  .addr = A_CFRAME_FAR_TOP3,
+    },{ .name = "LAST_FRAME_BOT0",  .addr = A_LAST_FRAME_BOT0,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_bot_post_read,
+    },{ .name = "LAST_FRAME_BOT1",  .addr = A_LAST_FRAME_BOT1,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_bot_post_read,
+    },{ .name = "LAST_FRAME_BOT2",  .addr = A_LAST_FRAME_BOT2,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_bot_post_read,
+    },{ .name = "LAST_FRAME_BOT3",  .addr = A_LAST_FRAME_BOT3,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_bot_post_read,
+    },{ .name = "LAST_FRAME_TOP0",  .addr = A_LAST_FRAME_TOP0,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_top_post_read,
+    },{ .name = "LAST_FRAME_TOP1",  .addr = A_LAST_FRAME_TOP1,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_top_post_read,
+    },{ .name = "LAST_FRAME_TOP2",  .addr = A_LAST_FRAME_TOP2,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_top_post_read,
+    },{ .name = "LAST_FRAME_TOP3",  .addr = A_LAST_FRAME_TOP3,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_top_post_read,
+    }
+};
+
+static void cframe_reg_cfi_transfer_packet(XlnxCfiIf *cfi_if,
+                                           XlnxCfiPacket *pkt)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(cfi_if);
+    uint64_t we = MAKE_64BIT_MASK(0, 4 * 8);
+
+    if (!s->row_configured) {
+        return;
+    }
+
+    switch (pkt->reg_addr) {
+    case CFRAME_FAR:
+        s->regs[R_FAR0] = pkt->data[0];
+        break;
+    case CFRAME_SFR:
+        s->regs[R_FAR_SFR0] = pkt->data[0];
+        register_write(&s->regs_info[R_FAR_SFR3], 0,
+                       we, object_get_typename(OBJECT(s)),
+                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
+        break;
+    case CFRAME_FDRI:
+        s->regs[R_FDRI0] = pkt->data[0];
+        s->regs[R_FDRI1] = pkt->data[1];
+        s->regs[R_FDRI2] = pkt->data[2];
+        register_write(&s->regs_info[R_FDRI3], pkt->data[3],
+                       we, object_get_typename(OBJECT(s)),
+                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
+        break;
+    case CFRAME_CMD:
+        ARRAY_FIELD_DP32(s->regs, CMD0, CMD, pkt->data[0]);
+
+        register_write(&s->regs_info[R_CMD3], 0,
+                       we, object_get_typename(OBJECT(s)),
+                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
+        break;
+    default:
+        break;
+    }
+}
+
+static uint64_t cframe_reg_fdri_read(void *opaque, hwaddr addr, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported read from addr=%"
+                  HWADDR_PRIx "\n", __func__, addr);
+    return 0;
+}
+
+static void cframe_reg_fdri_write(void *opaque, hwaddr addr, uint64_t value,
+                      unsigned size)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(opaque);
+    uint32_t wfifo[WFIFO_SZ];
+
+    if (update_wfifo(addr, value, s->wfifo, wfifo)) {
+        uint64_t we = MAKE_64BIT_MASK(0, 4 * 8);
+
+        s->regs[R_FDRI0] = wfifo[0];
+        s->regs[R_FDRI1] = wfifo[1];
+        s->regs[R_FDRI2] = wfifo[2];
+        register_write(&s->regs_info[R_FDRI3], wfifo[3],
+                       we, object_get_typename(OBJECT(s)),
+                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
+    }
+}
+
+static void cframe_reg_reset_enter(Object *obj, ResetType type)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
+    unsigned int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
+        register_reset(&s->regs_info[i]);
+    }
+    memset(s->wfifo, 0, WFIFO_SZ * sizeof(uint32_t));
+    fifo32_reset(&s->new_f_data);
+
+    if (g_tree_nnodes(s->cframes)) {
+        /*
+         * Take a reference so when g_tree_destroy() unrefs it we keep the
+         * GTree and only destroy its contents. NB: when our minimum
+         * glib version is at least 2.70 we could use g_tree_remove_all().
+         */
+        g_tree_ref(s->cframes);
+        g_tree_destroy(s->cframes);
+    }
+}
+
+static void cframe_reg_reset_hold(Object *obj)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
+
+    cfrm_imr_update_irq(s);
+}
+
+static const MemoryRegionOps cframe_reg_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps cframe_reg_fdri_ops = {
+    .read = cframe_reg_fdri_read,
+    .write = cframe_reg_fdri_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void cframe_reg_realize(DeviceState *dev, Error **errp)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(dev);
+
+    for (int i = 0; i < ARRAY_SIZE(s->cfg.blktype_num_frames); i++) {
+        if (s->cfg.blktype_num_frames[i] > MAX_BLOCKTYPE_FRAMES) {
+            error_setg(errp,
+                       "blktype-frames%d > 0xFFFFF (max frame per block)",
+                       i);
+            return;
+        }
+        if (s->cfg.blktype_num_frames[i]) {
+            s->row_configured = true;
+        }
+    }
+}
+
+static void cframe_reg_init(Object *obj)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
+
+    memory_region_init(&s->iomem, obj, TYPE_XLNX_VERSAL_CFRAME_REG,
+                       CFRAME_REG_R_MAX * 4);
+    reg_array =
+        register_init_block32(DEVICE(obj), cframe_reg_regs_info,
+                              ARRAY_SIZE(cframe_reg_regs_info),
+                              s->regs_info, s->regs,
+                              &cframe_reg_ops,
+                              XLNX_VERSAL_CFRAME_REG_ERR_DEBUG,
+                              CFRAME_REG_R_MAX * 4);
+    memory_region_add_subregion(&s->iomem,
+                                0x0,
+                                &reg_array->mem);
+    sysbus_init_mmio(sbd, &s->iomem);
+    memory_region_init_io(&s->iomem_fdri, obj, &cframe_reg_fdri_ops, s,
+                          TYPE_XLNX_VERSAL_CFRAME_REG "-fdri",
+                          KEYHOLE_STREAM_4K);
+    sysbus_init_mmio(sbd, &s->iomem_fdri);
+    sysbus_init_irq(sbd, &s->irq_cfrm_imr);
+
+    s->cframes = g_tree_new_full((GCompareDataFunc)int_cmp, NULL,
+                                  NULL, (GDestroyNotify)g_free);
+    fifo32_create(&s->new_f_data, FRAME_NUM_WORDS);
+}
+
+static const VMStateDescription vmstate_cframe = {
+    .name = "cframe",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(data, XlnxCFrame, FRAME_NUM_WORDS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_cframe_reg = {
+    .name = TYPE_XLNX_VERSAL_CFRAME_REG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFrameReg, 4),
+        VMSTATE_UINT32_ARRAY(regs, XlnxVersalCFrameReg, CFRAME_REG_R_MAX),
+        VMSTATE_BOOL(rowon, XlnxVersalCFrameReg),
+        VMSTATE_BOOL(wcfg, XlnxVersalCFrameReg),
+        VMSTATE_BOOL(rcfg, XlnxVersalCFrameReg),
+        VMSTATE_GTREE_DIRECT_KEY_V(cframes, XlnxVersalCFrameReg, 1,
+                                   &vmstate_cframe, XlnxCFrame),
+        VMSTATE_FIFO32(new_f_data, XlnxVersalCFrameReg),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static Property cframe_regs_props[] = {
+    DEFINE_PROP_LINK("cfu-fdro", XlnxVersalCFrameReg, cfg.cfu_fdro,
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_UINT32("blktype0-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[0], 0),
+    DEFINE_PROP_UINT32("blktype1-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[1], 0),
+    DEFINE_PROP_UINT32("blktype2-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[2], 0),
+    DEFINE_PROP_UINT32("blktype3-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[3], 0),
+    DEFINE_PROP_UINT32("blktype4-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[4], 0),
+    DEFINE_PROP_UINT32("blktype5-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[5], 0),
+    DEFINE_PROP_UINT32("blktype6-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[6], 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void cframe_reg_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    XlnxCfiIfClass *xcic = XLNX_CFI_IF_CLASS(klass);
+
+    dc->vmsd = &vmstate_cframe_reg;
+    dc->realize = cframe_reg_realize;
+    rc->phases.enter = cframe_reg_reset_enter;
+    rc->phases.hold = cframe_reg_reset_hold;
+    device_class_set_props(dc, cframe_regs_props);
+    xcic->cfi_transfer_packet = cframe_reg_cfi_transfer_packet;
+}
+
+static const TypeInfo cframe_reg_info = {
+    .name          = TYPE_XLNX_VERSAL_CFRAME_REG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxVersalCFrameReg),
+    .class_init    = cframe_reg_class_init,
+    .instance_init = cframe_reg_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_XLNX_CFI_IF },
+        { }
+    }
+};
+
+static void cframe_reg_register_types(void)
+{
+    type_register_static(&cframe_reg_info);
+}
+
+type_init(cframe_reg_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 3135697d742..88ecab83923 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -100,6 +100,7 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
   'xlnx-versal-pmc-iou-slcr.c',
   'xlnx-versal-cfu.c',
   'xlnx-cfi-if.c',
+  'xlnx-versal-cframe-reg.c',
 ))
 system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
-- 
2.34.1


