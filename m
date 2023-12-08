Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51784809948
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:34:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQh1-0000SC-Ju; Thu, 07 Dec 2023 21:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQgq-00089w-3N; Thu, 07 Dec 2023 21:34:08 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQgo-0002oS-8x; Thu, 07 Dec 2023 21:34:07 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2cb20c82a79so3860731fa.3; 
 Thu, 07 Dec 2023 18:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702002843; x=1702607643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KE00WoL8kxJ8pW7oRCni4sp/uw+yPOzo+IEwlEl9WAg=;
 b=FYHIeh/vkZaXgvw+sYPfiT6VQrdQHS7fZxWXTkVJAv/CG+ft3is7MS6it5mSxzm3np
 CDzLclGwOiBs0uhESBUTQgLuBtPepNsp3u3Y5GAZP2EyGD28e615JNE7h6upIGgueRKd
 IhH6yFI4ZkiH+tbxgt8T+ZYkg0JnKTt1Nmjt107HbgMEwoNXBJ9dOb5UcVPOGZCo604S
 DzxveMq1ukPFhDD0zEVXGCmCKCMSlI52bmYOZX//2lOPjaN05CBvoH4W1FcXgHVoyTgr
 Laqi6M9niDS1SELuY6Ga4S0ZYqgNwcfpx8fYVNQxyCGZYiJ6RaSZAHcLBt+9rdWAzCZc
 yy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702002843; x=1702607643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KE00WoL8kxJ8pW7oRCni4sp/uw+yPOzo+IEwlEl9WAg=;
 b=Qnfb2oWNF3tWxRYQzvL+1bdzs5CwVdsquG5fN8/9sH9c1jdlkr+x0LmZwt5PVMrm9u
 YO2CtIBtQYhxWE1Gg9+sBeFB9iscPbNg0EcbVQ4EFsP+YO35n8PkvEzB/IXzP23HeaeQ
 yYY1FDQ/U6aUDofQYdTdcPtSsZHtaf4KUluIzfXivYquhMaQA/DHQzVTQvLH3ptsOWqc
 a9zniTv72/PjeUE+Bed+v+3pHOqMnuU0aN8Fx+1gLab0NxOtOPxiXrjhx3s83H0tND/i
 d6+JQcSOPsm03O9gNf3i3s8O2mfiPE7uH2a6FqOedl0lRvt9gG6jw9J+T+SRg7NGQZUq
 I/UA==
X-Gm-Message-State: AOJu0YzQx+8AXYy+ETzhLLuTSx+HQ9euzqHyHNQzUa2QYFiAO6RUX6Sf
 bH5MZcoTNSwFq3044z5XdRR8GeYtIn/XOg==
X-Google-Smtp-Source: AGHT+IGp6YLuPHth9CQmRX6jfIahhlufzDccf9HovtQwovCnDLf3yP70QqNIR8uTHY1wY1y/fvnI/w==
X-Received: by 2002:a05:651c:1a0b:b0:2ca:2966:e734 with SMTP id
 by11-20020a05651c1a0b00b002ca2966e734mr1759937ljb.20.1702002842766; 
 Thu, 07 Dec 2023 18:34:02 -0800 (PST)
Received: from localhost.localdomain ([185.200.240.39])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a2e94c1000000b002c9e6cbf78esm99062ljh.19.2023.12.07.18.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 18:34:01 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v4 36/45] Add mailbox test constants
Date: Thu,  7 Dec 2023 20:31:36 -0600
Message-Id: <20231208023145.1385775-37-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=serg.oker@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mailbox.h | 139 ++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index 1d02ca9c2c..8acc4bd2ff 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -7,6 +7,145 @@
  * See the COPYING file in the top-level directory.
  */
 
+#define MBOX0_BASE 0xFE00B880
+#define MBOX1_BASE 0xFE00B8A0
+
+#define MBOX_REG_READ   0x00
+#define MBOX_REG_WRITE  0x00
+#define MBOX_REG_PEEK   0x10
+#define MBOX_REG_SENDER 0x14
+#define MBOX_REG_STATUS 0x18
+#define MBOX_REG_CONFIG 0x1C
+
+#define MBOX_READ_EMPTY 0x40000000
+
+#define MBOX_CHANNEL_ID_PROPERTY 8
+
+#define MBOX_PROCESS_REQUEST      0x00000000
+#define MBOX_SUCCESS              0x80000000
+#define MBOX_ERROR_PARSING_BUFFER 0x80000001
+
+#define TAG_END                    0x00000000
+#define TAG_GET_FIRMWARE_REVISION  0x00000001
+#define TAG_GET_FIRMWARE_VARIANT   0x00000002
+#define TAG_GET_BOARD_REVISION     0x00010002
+#define TAG_GET_ARM_MEMORY         0x00010005
+#define TAG_GET_VC_MEMORY          0x00010006
+#define TAG_SET_DEVICE_POWER_STATE 0x00028001
+#define TAG_GET_CLOCK_STATE        0x00030001
+#define TAG_GET_CLOCK_RATE         0x00030002
+#define TAG_GET_MAX_CLOCK_RATE     0x00030004
+#define TAG_GET_MIN_CLOCK_RATE     0x00030007
+#define TAG_GET_CLOCKS             0x00010007
+#define TAG_GET_TEMPERATURE        0x00030006
+#define TAG_GET_MAX_TEMPERATURE    0x0003000a
+#define TAG_ALLOCATE_BUFFER        0x00040001
+#define TAG_RELEASE_FRAMEBUFFER    0x00048001
+#define TAG_BLANK_FRAMEBUFFER      0x00040002
+#define TAG_GET_FB_PHYS_WIDTH      0x00040003
+#define TAG_TEST_FB_PHYS_WIDTH     0x00044003
+#define TAG_SET_FB_PHYS_WIDTH      0x00048003
+#define TAG_GET_FB_VIRT_WIDTH      0x00040004
+#define TAG_TEST_FB_VIRT_WIDTH     0x00044004
+#define TAG_SET_FB_VIRT_WIDTH      0x00048004
+#define TAG_GET_FB_DEPTH           0x00040005
+#define TAG_TEST_FB_DEPTH          0x00044005
+#define TAG_SET_FB_DEPTH           0x00048005
+#define TAG_GET_PIXEL_ORDER        0x00040006
+#define TAG_TEST_PIXEL_ORDER       0x00044006
+#define TAG_SET_PIXEL_ORDER        0x00048006
+#define TAG_GET_FB_ALPHA_MODE      0x00040007
+#define TAG_TEST_FB_ALPHA_MODE     0x00044007
+#define TAG_SET_FB_ALPHA_MODE      0x00048007
+#define TAG_GET_PITCH              0x00040008
+#define TAG_SET_PITCH              0x00048008
+#define TAG_GET_VIRTUAL_OFFSET     0x00040009
+#define TAG_TEST_VIRTUAL_OFFSET    0x00044009
+#define TAG_SET_VIRTUAL_OFFSET     0x00048009
+#define TAG_GET_OVERSCAN           0x0004000a
+#define TAG_TEST_OVERSCAN          0x0004400a
+#define TAG_SET_OVERSCAN           0x0004800a
+#define TAG_SET_PALETTE            0x0004800b
+#define TAG_GET_COMMANDLINE        0x00050001
+#define TAG_GET_DMA_CHANNELS       0x00060001
+#define TAG_GET_THROTTLED          0x00030046
+#define TAG_GET_NUM_DISPLAYS       0x00040013
+#define TAG_GET_DISPLAY_SETTINGS   0x00040014
+#define TAG_GET_GPIO_CONFIG        0x00030043
+#define TAG_SET_GPIO_CONFIG        0x00038043
+#define TAG_GET_GPIO_STATE         0x00030041
+#define TAG_SET_GPIO_STATE         0x00038041
+#define TAG_INITIALIZE_VCHIQ       0x00048010
+
+#define BOARD_REVISION    11546898
+#define FIRMWARE_REVISION 346337
+#define FIRMWARE_VARIANT  0x77777777 /* TODO: Find the real value */
+
+#define ARM_MEMORY_BASE 0x00000000
+#define ARM_MEMORY_SIZE 0x3c000000
+#define VC_MEMORY_BASE  0x3c000000
+#define VC_MEMORY_SIZE  0x04000000
+#define VC_FB_BASE      0x3c100000
+#define VC_FB_SIZE      0x00096000
+
+#define CLOCK_ID_ROOT      0x00000000
+#define CLOCK_ID_EMMC      0x00000001
+#define CLOCK_ID_UART      0x00000002
+#define CLOCK_ID_ARM       0x00000003
+#define CLOCK_ID_CORE      0x00000004
+#define CLOCK_ID_UNDEFINED 0x12345678
+
+#define CLOCK_RATE_EMMC 50000000
+#define CLOCK_RATE_UART 3000000
+#define CLOCK_RATE_CORE 350000000
+#define CLOCK_RATE_ANY  700000000
+
+#define DEVICE_ID_SD_CARD   0x00000000
+#define DEVICE_ID_UART0     0x00000001
+#define DEVICE_ID_UART1     0x00000002
+#define DEVICE_ID_USB HCD   0x00000003
+#define DEVICE_ID_I2C0      0x00000004
+#define DEVICE_ID_I2C1      0x00000005
+#define DEVICE_ID_I2C2      0x00000006
+#define DEVICE_ID_SPI       0x00000007
+#define DEVICE_ID_CCP2TX    0x00000008
+#define DEVICE_ID_UNKNOWN_0 0x00000009
+#define DEVICE_ID_UNKNOWN_1 0x0000000a
+
+#define TEMPERATURE_ID_SOC 0x00000000
+
+#define TEMPERATURE_SOC     25000
+#define TEMPERATURE_SOC_MAX 99000
+
+#define ALIGN_4K 4096
+
+#define PIXEL_ORDER_BGR 0
+#define PIXEL_ORDER_RGB 1
+
+#define ALPHA_MODE_ENABLED  0
+#define ALPHA_MODE_REVERSED 1
+#define ALPHA_MODE_IGNORED  2
+
+#define GPIO_MASK 0x003c
+
+#define GPIO_0 0x00000080
+
+#define GPIO_DIRECTION_IN  0
+#define GPIO_DIRECTION_OUT 1
+
+#define GPIO_TERMINATION_DISABLED 0
+#define GPIO_TERMINATION_ENABLED  1
+
+#define GPIO_TERMINATION_PULLUP_DISABLED 0
+#define GPIO_TERMINATION_PULLUP_ENABLED  1
+
+#define GPIO_POLARITY_LOW  0
+#define GPIO_POLARITY_HIGH 1
+
+#define GPIO_STATE_DOWN 0
+
+/* Used to test stubs that don't perform actual work */
+#define DUMMY_VALUE 0x12345678
 
 REG32(MBOX_WRITE_REG, 0)
 FIELD(MBOX_WRITE_REG, CHANNEL, 0, 4)
-- 
2.34.1


