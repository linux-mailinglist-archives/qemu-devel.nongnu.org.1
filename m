Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B49802960
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 01:28:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9woJ-0005zD-23; Sun, 03 Dec 2023 19:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnq-0004qO-9g; Sun, 03 Dec 2023 19:27:14 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnn-0000IV-FI; Sun, 03 Dec 2023 19:27:13 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5d226f51f71so42973607b3.3; 
 Sun, 03 Dec 2023 16:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701649630; x=1702254430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KE00WoL8kxJ8pW7oRCni4sp/uw+yPOzo+IEwlEl9WAg=;
 b=Rf/kJkD+WtG7rzFz/3Rd6oMe5GcJJE4iJAEvYxmNW0IY7SehmHy1msq6pntEQW+NZp
 4TMZZy2HzZ+SunBjEm0gGOYqHzQ2qb4vxNJv5SERzM25N33btTQUx+3tXUncO+4og2oy
 J92eL7UV/s6otOvk5p5L0VoBjNkLptJFY354iIxOudYLq9704Fgp/+kanE4cjDyt7fkc
 RvBweutB/G1Lhk2P8QZ4sqyWbDf0lmjJ0WXipjn+2W1ZGz8oSQFKuOSLjrjha+SHFxrF
 cI/6IED6QGj9OcyKFbD5BzY4mgSO3GxO4Oa6x00fuP3rtY8XEng0mJFLLw8lyfdLguNt
 f8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649630; x=1702254430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KE00WoL8kxJ8pW7oRCni4sp/uw+yPOzo+IEwlEl9WAg=;
 b=UMw+YQb0piM5RAdrARoLJ9t7oFbPr1C4DbPYONapKXPlfUW/901YhQiA18V7hC6MuP
 1SwZfoE5rIRySAu6xPcdfJbJe1ioMg37t/Ie4adnVpbwrlQTvrut1HD1F1NPeWqohsc0
 dclXXNhVUm223CbYuv1IDGoXnphVug9U/HvJgkGD7QZ+LqqkrDjNBap1OScE39fROtqB
 cDgWVcj/+cTF4EZzQFrsWo0/hyOcRfx77TEOXDnWu9+j0859M1vPbcdG35ZLs1NUOkoT
 jGkB4ijEhtRwD4Is2vc5FABoMShILrLkXfqGaVq7mxkm+CoIfyU0h/IF989NEGuIK0jB
 lcQg==
X-Gm-Message-State: AOJu0Yw9GHNmgGXVZPOlzyC+DM9ghkYDWmtWe0tkBzgIDcPtjv8BiK7i
 wLK3F+uDsIPy2bMUe9joj7rToByfomUdtw==
X-Google-Smtp-Source: AGHT+IH2ljzA0Cr58RazkjcTu9aTY7vYSw/e8q6s1zqtf7NG/9JWXlIOs6qeqPEPhiAzV1tta190wg==
X-Received: by 2002:a0d:dfc4:0:b0:5d7:1940:dd93 with SMTP id
 i187-20020a0ddfc4000000b005d71940dd93mr1961095ywe.105.1701649629779; 
 Sun, 03 Dec 2023 16:27:09 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 l63-20020a0de242000000b005d3e6ce07e7sm2443187ywe.6.2023.12.03.16.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:09 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 36/45] Add mailbox test constants
Date: Sun,  3 Dec 2023 18:26:10 -0600
Message-Id: <20231204002619.1367044-37-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112b.google.com
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


