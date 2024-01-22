Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69061835A1E
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 05:49:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRmDc-0001ha-4h; Sun, 21 Jan 2024 23:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rRmDW-0001hL-Kc; Sun, 21 Jan 2024 23:47:26 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rRmDU-0001fo-Qg; Sun, 21 Jan 2024 23:47:26 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9344f30caso1614984b3a.1; 
 Sun, 21 Jan 2024 20:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705898840; x=1706503640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Ca2bixCchJ316bcxVc3Ua3dMrPnwxBoPplhC5jBBQk=;
 b=YWW3iPJZZ6qkJc9BZzMho+tXXvZpBZ0sUyiiYJMxDEAt5vL1DR5vwpYQcZqDwVAOx+
 Zk5E40feKTylLjLfq1asrV2u1zXZuchaHZY/ApMSyBiun9XiiEJcWkxxZ7N3dxzcRRrD
 iWIpwg3E42RI4hOCwF1o/KMMKIa/RxJWb/RYuo33LE+0u3VWEHkaSQegwTqFtheYHqJS
 A6AJpWq/xc8WSBJy6i4MVW46qCQY/kLChiffVJY4MNTSS0yBgfbIdn1gooaE4U/xzWgf
 0yNxQJGkkHqQHLEk9LmuEWV+BycI1NrTp8Oh8ZkWk05Q7ReqTBnhgppAei4p5PTQSSz9
 FmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705898840; x=1706503640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Ca2bixCchJ316bcxVc3Ua3dMrPnwxBoPplhC5jBBQk=;
 b=vhsXkiaAdqc2ewavzAuPvTzT8p5lfARr74rEOlh24rQvaJk0703rLICkH1zrr4MING
 el+WcTPR1iknI0ik7tIhGY8XV9PNiTUMQLg/cY9PqqrWuASvbPcL5YCDp2bjyhrcUzAF
 BXnofGxMmLwCoZ8I6U1VRuASJqK2YemCQSkWpViyHhaxKiTo6A8ZDx5EXJCXLG6sH19A
 sy0yTZB/NXs17atsjyOihGqmQeIV1VBPLsfsFiDx+EmlT+3GVOQ8z4BJ/xiqEidDBQtu
 2hdZRNiFlqgWpvKQpybyTii8SFk5Gmu1Td3UDy1jVKVQMczPmyWF5QK84DjfHWAaXyU4
 02Pw==
X-Gm-Message-State: AOJu0YzbEVAJcSydVZNrEZ9FZCbQtcyNP3ky0KjyA8U9SoFIN2Ae2bZn
 SrimcWM6kq6t8AtaTfl5rwYGjMjWdGXFK2g7qVvXSmYAZ7ruciYs/6vWgDdv
X-Google-Smtp-Source: AGHT+IGCvGlZOzwD66g5oaGk9JVqNXXcz0HJiELqnXPvBK9Y0INz1pcslvsVmBfkdN+CEkqKEpjuRA==
X-Received: by 2002:a05:6a00:10cf:b0:6db:d090:69c3 with SMTP id
 d15-20020a056a0010cf00b006dbd09069c3mr3378069pfu.4.1705898840546; 
 Sun, 21 Jan 2024 20:47:20 -0800 (PST)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 b125-20020a62cf83000000b006d9bd15fd5csm9443095pfg.17.2024.01.21.20.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 20:47:20 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, jeuk20.kim@samsung.com, kwolf@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org
Subject: [PATCH] hw/ufs: Raise interrupt on UIC power mode change
Date: Mon, 22 Jan 2024 13:46:58 +0900
Message-Id: <32d8c778f8cc6b28f0eaa39809e0f0b949b2e265.1705893262.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x432.google.com
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

This patch allows the qemu ufs to raise an interrupt on
the DME_SET (PA_PWRMODE) command.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c        | 15 ++++++++++-
 include/block/ufs.h | 65 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index eccdb852a0..e95f732a9f 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -301,6 +301,19 @@ static void ufs_process_uiccmd(UfsHc *u, uint32_t val)
      * are implemented.
      */
     switch (val) {
+    case UFS_UIC_CMD_DME_SET:
+        if (FIELD_EX32(u->reg.ucmdarg1, UCMDARG1, MIBattribute) ==
+            UFS_UNIPRO_PA_PWRMODE) {
+            u->reg.hcs = FIELD_DP32(u->reg.hcs, HCS, UPMCRS, UFS_PWR_LOCAL);
+            u->reg.is = FIELD_DP32(u->reg.is, IS, UPMS, 1);
+        }
+        u->reg.ucmdarg2 = UFS_UIC_CMD_RESULT_SUCCESS;
+        break;
+    case UFS_UIC_CMD_DME_GET:
+    case UFS_UIC_CMD_DME_PEER_GET:
+    case UFS_UIC_CMD_DME_PEER_SET:
+        u->reg.ucmdarg2 = UFS_UIC_CMD_RESULT_SUCCESS;
+        break;
     case UFS_UIC_CMD_DME_LINK_STARTUP:
         u->reg.hcs = FIELD_DP32(u->reg.hcs, HCS, DP, 1);
         u->reg.hcs = FIELD_DP32(u->reg.hcs, HCS, UTRLRDY, 1);
@@ -434,7 +447,6 @@ static const MemoryRegionOps ufs_mmio_ops = {
     },
 };
 
-
 void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type, uint8_t flags,
                            uint8_t response, uint8_t scsi_status,
                            uint16_t data_segment_length)
@@ -1237,6 +1249,7 @@ static void ufs_init_hc(UfsHc *u)
     u->geometry_desc.supported_memory_types = cpu_to_be16(0x8001);
 
     memset(&u->attributes, 0, sizeof(u->attributes));
+    u->attributes.current_power_mode = 0x11; /* Active Power Mode */
     u->attributes.max_data_in_size = 0x08;
     u->attributes.max_data_out_size = 0x08;
     u->attributes.ref_clk_freq = 0x01; /* 26 MHz */
diff --git a/include/block/ufs.h b/include/block/ufs.h
index d61598b8f3..fe2f2ce944 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -125,6 +125,8 @@ REG32(UTMRLCLR, offsetof(UfsReg, utmrlclr))
 REG32(UTMRLRSR, offsetof(UfsReg, utmrlrsr))
 REG32(UICCMD, offsetof(UfsReg, uiccmd))
 REG32(UCMDARG1, offsetof(UfsReg, ucmdarg1))
+    FIELD(UCMDARG1, GenSelectorIndex, 0, 16)
+    FIELD(UCMDARG1, MIBattribute, 16, 16)
 REG32(UCMDARG2, offsetof(UfsReg, ucmdarg2))
 REG32(UCMDARG3, offsetof(UfsReg, ucmdarg3))
 REG32(CCAP, offsetof(UfsReg, ccap))
@@ -1064,6 +1066,69 @@ typedef struct QEMU_PACKED UtpUpiuRsp {
     };
 } UtpUpiuRsp;
 
+/*
+ * PHY Adapter attributes
+ */
+#define UFS_UNIPRO_PA_PHY_TYPE 0x1500
+#define UFS_UNIPRO_PA_AVAILTXDATALANES 0x1520
+#define UFS_UNIPRO_PA_MAXTXSPEEDFAST 0x1521
+#define UFS_UNIPRO_PA_MAXTXSPEEDSLOW 0x1522
+#define UFS_UNIPRO_PA_MAXRXSPEEDFAST 0x1541
+#define UFS_UNIPRO_PA_MAXRXSPEEDSLOW 0x1542
+#define UFS_UNIPRO_PA_TXLINKSTARTUPHS 0x1544
+#define UFS_UNIPRO_PA_AVAILRXDATALANES 0x1540
+#define UFS_UNIPRO_PA_MINRXTRAILINGCLOCKS 0x1543
+#define UFS_UNIPRO_PA_LOCAL_TX_LCC_ENABLE 0x155E
+#define UFS_UNIPRO_PA_ACTIVETXDATALANES 0x1560
+#define UFS_UNIPRO_PA_CONNECTEDTXDATALANES 0x1561
+#define UFS_UNIPRO_PA_TXFORCECLOCK 0x1562
+#define UFS_UNIPRO_PA_TXPWRMODE 0x1563
+#define UFS_UNIPRO_PA_TXTRAILINGCLOCKS 0x1564
+#define UFS_UNIPRO_PA_TXSPEEDFAST 0x1565
+#define UFS_UNIPRO_PA_TXSPEEDSLOW 0x1566
+#define UFS_UNIPRO_PA_TXPWRSTATUS 0x1567
+#define UFS_UNIPRO_PA_TXGEAR 0x1568
+#define UFS_UNIPRO_PA_TXTERMINATION 0x1569
+#define UFS_UNIPRO_PA_HSSERIES 0x156A
+#define UFS_UNIPRO_PA_LEGACYDPHYESCDL 0x1570
+#define UFS_UNIPRO_PA_PWRMODE 0x1571
+#define UFS_UNIPRO_PA_ACTIVERXDATALANES 0x1580
+#define UFS_UNIPRO_PA_CONNECTEDRXDATALANES 0x1581
+#define UFS_UNIPRO_PA_RXPWRSTATUS 0x1582
+#define UFS_UNIPRO_PA_RXGEAR 0x1583
+#define UFS_UNIPRO_PA_RXTERMINATION 0x1584
+#define UFS_UNIPRO_PA_MAXRXPWMGEAR 0x1586
+#define UFS_UNIPRO_PA_MAXRXHSGEAR 0x1587
+#define UFS_UNIPRO_PA_PACPREQTIMEOUT 0x1590
+#define UFS_UNIPRO_PA_PACPREQEOBTIMEOUT 0x1591
+#define UFS_UNIPRO_PA_REMOTEVERINFO 0x15A0
+#define UFS_UNIPRO_PA_LOGICALLANEMAP 0x15A1
+#define UFS_UNIPRO_PA_SLEEPNOCONFIGTIME 0x15A2
+#define UFS_UNIPRO_PA_STALLNOCONFIGTIME 0x15A3
+#define UFS_UNIPRO_PA_SAVECONFIGTIME 0x15A4
+#define UFS_UNIPRO_PA_RXHSUNTERMCAP 0x15A5
+#define UFS_UNIPRO_PA_RXLSTERMCAP 0x15A6
+#define UFS_UNIPRO_PA_HIBERN8TIME 0x15A7
+#define UFS_UNIPRO_PA_LOCALVERINFO 0x15A9
+#define UFS_UNIPRO_PA_GRANULARITY 0x15AA
+#define UFS_UNIPRO_PA_TACTIVATE 0x15A8
+#define UFS_UNIPRO_PA_PWRMODEUSERDATA0 0x15B0
+#define UFS_UNIPRO_PA_PWRMODEUSERDATA1 0x15B1
+#define UFS_UNIPRO_PA_PWRMODEUSERDATA2 0x15B2
+#define UFS_UNIPRO_PA_PWRMODEUSERDATA3 0x15B3
+#define UFS_UNIPRO_PA_PWRMODEUSERDATA4 0x15B4
+#define UFS_UNIPRO_PA_PWRMODEUSERDATA5 0x15B5
+#define UFS_UNIPRO_PA_PWRMODEUSERDATA6 0x15B6
+#define UFS_UNIPRO_PA_PWRMODEUSERDATA7 0x15B7
+#define UFS_UNIPRO_PA_PWRMODEUSERDATA8 0x15B8
+#define UFS_UNIPRO_PA_PWRMODEUSERDATA9 0x15B9
+#define UFS_UNIPRO_PA_PWRMODEUSERDATA10 0x15BA
+#define UFS_UNIPRO_PA_PWRMODEUSERDATA11 0x15BB
+#define UFS_UNIPRO_PA_PACPFRAMECOUNT 0x15C0
+#define UFS_UNIPRO_PA_PACPERRORCOUNT 0x15C1
+#define UFS_UNIPRO_PA_PHYTESTCONTROL 0x15C2
+#define UFS_UNIPRO_PA_TXHSADAPTTYPE 0x15D4
+
 static inline void _ufs_check_size(void)
 {
     QEMU_BUILD_BUG_ON(sizeof(UfsReg) != 0x104);
-- 
2.34.1


