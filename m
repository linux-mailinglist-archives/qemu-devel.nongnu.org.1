Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB457D9BC4
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:42:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0t-0000fb-R5; Fri, 27 Oct 2023 10:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0P-0007Os-4u
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:10 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0H-0008Bk-R1
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:07 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50802148be9so2733617e87.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417599; x=1699022399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DJmspu/+77H0X0YJS0Z6KrXg04AH+KSa/AXo9P61hHk=;
 b=Pozm1nFCRmyJB7CFMBzQs7DlUW46T3U4pUimj2O48IR5EAksnDTZ6PXf/9r9QQXMnk
 vOjA0qFLaEVICutaDSY4kAwtPfMcm26MDdjcF9+qMDu3B4E0Y0E65BGrCFR81sUOmRvH
 lWotHKSNcu/hjkpQTCi4Dqh/MyxIv89BqkjQiyQWJoLnb8oOluYiKpuPC9YYS3kWvzk4
 i7KhnbECs5c4/ClsEab4dORLFPuoxs4NZKc9md64Jy5t4gpCKrSykn/PJ9MY4acr8l8i
 1/vaQNQFnLtds9HasBvSrEvNAcMZON8wMvpGuUuclFNfUVRL0SrOVjAjEzpsoMEJwEhz
 /aXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417599; x=1699022399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJmspu/+77H0X0YJS0Z6KrXg04AH+KSa/AXo9P61hHk=;
 b=G/jwEizmNLhOfhhkILt4kIiD8kUO5UjnkBJUB9zHqXmZRxvEFALfOU33l1OkA2ZRtG
 Eai/NugaqWTwtCAoBdryebwU8n18IptTYK9P7ZFKeCrxgokn5oGclkKMDmpWMxdyljcG
 pnUDE9gUOmvQb4rTZ+Agu2ZuzR+Mh8kT0Fc8p5a76wyRN1Fw0Wjt5yLXD0WNMkNFDKD1
 RrzDBcfFaatWd1hO/tmWDqjoqM20D4oTunSrHw86EeHygznb2PaGFpi1CkdT31eIoSiG
 8aSVT0IKh5IMfE/cCgisipnq5FWTkQEKjitKyx8zAmEonZJ3g+pZw0PT/yezkpp5cV8M
 hoTA==
X-Gm-Message-State: AOJu0YxFT5//ezBv/Bmn3u/scIzwy55ZncL/lyuYS1/zQWBRR6xgo1tB
 tp4ggq3ED5+cPxi/1kz4vYf5p9Oi/joxyphfhkU=
X-Google-Smtp-Source: AGHT+IGSr1NYiRxysIzzSi4vrHJPmqe5nnlYYoLt2vdpeFysisPC+WRnD68SQkaWHcaC3Bgn3wWXVQ==
X-Received: by 2002:a05:6512:15a:b0:507:a701:3206 with SMTP id
 m26-20020a056512015a00b00507a7013206mr1949519lfo.49.1698417599455; 
 Fri, 27 Oct 2023 07:39:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/41] hw/net/cadence_gem: use REG32 macro for register
 definitions
Date: Fri, 27 Oct 2023 15:39:32 +0100
Message-Id: <20231027143942.3413881-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

From: Luc Michel <luc.michel@amd.com>

Replace register defines with the REG32 macro from registerfields.h in
the Cadence GEM device.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: sai.pavan.boddu@amd.com
Message-id: 20231017194422.4124691-2-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 527 +++++++++++++++++++++----------------------
 1 file changed, 261 insertions(+), 266 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 37e209cda69..bea2224dd8d 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -28,6 +28,7 @@
 #include "hw/irq.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/qdev-properties.h"
+#include "hw/registerfields.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
@@ -44,136 +45,131 @@
     } \
 } while (0)
 
-#define GEM_NWCTRL        (0x00000000 / 4) /* Network Control reg */
-#define GEM_NWCFG         (0x00000004 / 4) /* Network Config reg */
-#define GEM_NWSTATUS      (0x00000008 / 4) /* Network Status reg */
-#define GEM_USERIO        (0x0000000C / 4) /* User IO reg */
-#define GEM_DMACFG        (0x00000010 / 4) /* DMA Control reg */
-#define GEM_TXSTATUS      (0x00000014 / 4) /* TX Status reg */
-#define GEM_RXQBASE       (0x00000018 / 4) /* RX Q Base address reg */
-#define GEM_TXQBASE       (0x0000001C / 4) /* TX Q Base address reg */
-#define GEM_RXSTATUS      (0x00000020 / 4) /* RX Status reg */
-#define GEM_ISR           (0x00000024 / 4) /* Interrupt Status reg */
-#define GEM_IER           (0x00000028 / 4) /* Interrupt Enable reg */
-#define GEM_IDR           (0x0000002C / 4) /* Interrupt Disable reg */
-#define GEM_IMR           (0x00000030 / 4) /* Interrupt Mask reg */
-#define GEM_PHYMNTNC      (0x00000034 / 4) /* Phy Maintenance reg */
-#define GEM_RXPAUSE       (0x00000038 / 4) /* RX Pause Time reg */
-#define GEM_TXPAUSE       (0x0000003C / 4) /* TX Pause Time reg */
-#define GEM_TXPARTIALSF   (0x00000040 / 4) /* TX Partial Store and Forward */
-#define GEM_RXPARTIALSF   (0x00000044 / 4) /* RX Partial Store and Forward */
-#define GEM_JUMBO_MAX_LEN (0x00000048 / 4) /* Max Jumbo Frame Size */
-#define GEM_HASHLO        (0x00000080 / 4) /* Hash Low address reg */
-#define GEM_HASHHI        (0x00000084 / 4) /* Hash High address reg */
-#define GEM_SPADDR1LO     (0x00000088 / 4) /* Specific addr 1 low reg */
-#define GEM_SPADDR1HI     (0x0000008C / 4) /* Specific addr 1 high reg */
-#define GEM_SPADDR2LO     (0x00000090 / 4) /* Specific addr 2 low reg */
-#define GEM_SPADDR2HI     (0x00000094 / 4) /* Specific addr 2 high reg */
-#define GEM_SPADDR3LO     (0x00000098 / 4) /* Specific addr 3 low reg */
-#define GEM_SPADDR3HI     (0x0000009C / 4) /* Specific addr 3 high reg */
-#define GEM_SPADDR4LO     (0x000000A0 / 4) /* Specific addr 4 low reg */
-#define GEM_SPADDR4HI     (0x000000A4 / 4) /* Specific addr 4 high reg */
-#define GEM_TIDMATCH1     (0x000000A8 / 4) /* Type ID1 Match reg */
-#define GEM_TIDMATCH2     (0x000000AC / 4) /* Type ID2 Match reg */
-#define GEM_TIDMATCH3     (0x000000B0 / 4) /* Type ID3 Match reg */
-#define GEM_TIDMATCH4     (0x000000B4 / 4) /* Type ID4 Match reg */
-#define GEM_WOLAN         (0x000000B8 / 4) /* Wake on LAN reg */
-#define GEM_IPGSTRETCH    (0x000000BC / 4) /* IPG Stretch reg */
-#define GEM_SVLAN         (0x000000C0 / 4) /* Stacked VLAN reg */
-#define GEM_MODID         (0x000000FC / 4) /* Module ID reg */
-#define GEM_OCTTXLO       (0x00000100 / 4) /* Octets transmitted Low reg */
-#define GEM_OCTTXHI       (0x00000104 / 4) /* Octets transmitted High reg */
-#define GEM_TXCNT         (0x00000108 / 4) /* Error-free Frames transmitted */
-#define GEM_TXBCNT        (0x0000010C / 4) /* Error-free Broadcast Frames */
-#define GEM_TXMCNT        (0x00000110 / 4) /* Error-free Multicast Frame */
-#define GEM_TXPAUSECNT    (0x00000114 / 4) /* Pause Frames Transmitted */
-#define GEM_TX64CNT       (0x00000118 / 4) /* Error-free 64 TX */
-#define GEM_TX65CNT       (0x0000011C / 4) /* Error-free 65-127 TX */
-#define GEM_TX128CNT      (0x00000120 / 4) /* Error-free 128-255 TX */
-#define GEM_TX256CNT      (0x00000124 / 4) /* Error-free 256-511 */
-#define GEM_TX512CNT      (0x00000128 / 4) /* Error-free 512-1023 TX */
-#define GEM_TX1024CNT     (0x0000012C / 4) /* Error-free 1024-1518 TX */
-#define GEM_TX1519CNT     (0x00000130 / 4) /* Error-free larger than 1519 TX */
-#define GEM_TXURUNCNT     (0x00000134 / 4) /* TX under run error counter */
-#define GEM_SINGLECOLLCNT (0x00000138 / 4) /* Single Collision Frames */
-#define GEM_MULTCOLLCNT   (0x0000013C / 4) /* Multiple Collision Frames */
-#define GEM_EXCESSCOLLCNT (0x00000140 / 4) /* Excessive Collision Frames */
-#define GEM_LATECOLLCNT   (0x00000144 / 4) /* Late Collision Frames */
-#define GEM_DEFERTXCNT    (0x00000148 / 4) /* Deferred Transmission Frames */
-#define GEM_CSENSECNT     (0x0000014C / 4) /* Carrier Sense Error Counter */
-#define GEM_OCTRXLO       (0x00000150 / 4) /* Octets Received register Low */
-#define GEM_OCTRXHI       (0x00000154 / 4) /* Octets Received register High */
-#define GEM_RXCNT         (0x00000158 / 4) /* Error-free Frames Received */
-#define GEM_RXBROADCNT    (0x0000015C / 4) /* Error-free Broadcast Frames RX */
-#define GEM_RXMULTICNT    (0x00000160 / 4) /* Error-free Multicast Frames RX */
-#define GEM_RXPAUSECNT    (0x00000164 / 4) /* Pause Frames Received Counter */
-#define GEM_RX64CNT       (0x00000168 / 4) /* Error-free 64 byte Frames RX */
-#define GEM_RX65CNT       (0x0000016C / 4) /* Error-free 65-127B Frames RX */
-#define GEM_RX128CNT      (0x00000170 / 4) /* Error-free 128-255B Frames RX */
-#define GEM_RX256CNT      (0x00000174 / 4) /* Error-free 256-512B Frames RX */
-#define GEM_RX512CNT      (0x00000178 / 4) /* Error-free 512-1023B Frames RX */
-#define GEM_RX1024CNT     (0x0000017C / 4) /* Error-free 1024-1518B Frames RX */
-#define GEM_RX1519CNT     (0x00000180 / 4) /* Error-free 1519-max Frames RX */
-#define GEM_RXUNDERCNT    (0x00000184 / 4) /* Undersize Frames Received */
-#define GEM_RXOVERCNT     (0x00000188 / 4) /* Oversize Frames Received */
-#define GEM_RXJABCNT      (0x0000018C / 4) /* Jabbers Received Counter */
-#define GEM_RXFCSCNT      (0x00000190 / 4) /* Frame Check seq. Error Counter */
-#define GEM_RXLENERRCNT   (0x00000194 / 4) /* Length Field Error Counter */
-#define GEM_RXSYMERRCNT   (0x00000198 / 4) /* Symbol Error Counter */
-#define GEM_RXALIGNERRCNT (0x0000019C / 4) /* Alignment Error Counter */
-#define GEM_RXRSCERRCNT   (0x000001A0 / 4) /* Receive Resource Error Counter */
-#define GEM_RXORUNCNT     (0x000001A4 / 4) /* Receive Overrun Counter */
-#define GEM_RXIPCSERRCNT  (0x000001A8 / 4) /* IP header Checksum Err Counter */
-#define GEM_RXTCPCCNT     (0x000001AC / 4) /* TCP Checksum Error Counter */
-#define GEM_RXUDPCCNT     (0x000001B0 / 4) /* UDP Checksum Error Counter */
+REG32(NWCTRL, 0x0) /* Network Control reg */
+REG32(NWCFG, 0x4) /* Network Config reg */
+REG32(NWSTATUS, 0x8) /* Network Status reg */
+REG32(USERIO, 0xc) /* User IO reg */
+REG32(DMACFG, 0x10) /* DMA Control reg */
+REG32(TXSTATUS, 0x14) /* TX Status reg */
+REG32(RXQBASE, 0x18) /* RX Q Base address reg */
+REG32(TXQBASE, 0x1c) /* TX Q Base address reg */
+REG32(RXSTATUS, 0x20) /* RX Status reg */
+REG32(ISR, 0x24) /* Interrupt Status reg */
+REG32(IER, 0x28) /* Interrupt Enable reg */
+REG32(IDR, 0x2c) /* Interrupt Disable reg */
+REG32(IMR, 0x30) /* Interrupt Mask reg */
+REG32(PHYMNTNC, 0x34) /* Phy Maintenance reg */
+REG32(RXPAUSE, 0x38) /* RX Pause Time reg */
+REG32(TXPAUSE, 0x3c) /* TX Pause Time reg */
+REG32(TXPARTIALSF, 0x40) /* TX Partial Store and Forward */
+REG32(RXPARTIALSF, 0x44) /* RX Partial Store and Forward */
+REG32(JUMBO_MAX_LEN, 0x48) /* Max Jumbo Frame Size */
+REG32(HASHLO, 0x80) /* Hash Low address reg */
+REG32(HASHHI, 0x84) /* Hash High address reg */
+REG32(SPADDR1LO, 0x88) /* Specific addr 1 low reg */
+REG32(SPADDR1HI, 0x8c) /* Specific addr 1 high reg */
+REG32(SPADDR2LO, 0x90) /* Specific addr 2 low reg */
+REG32(SPADDR2HI, 0x94) /* Specific addr 2 high reg */
+REG32(SPADDR3LO, 0x98) /* Specific addr 3 low reg */
+REG32(SPADDR3HI, 0x9c) /* Specific addr 3 high reg */
+REG32(SPADDR4LO, 0xa0) /* Specific addr 4 low reg */
+REG32(SPADDR4HI, 0xa4) /* Specific addr 4 high reg */
+REG32(TIDMATCH1, 0xa8) /* Type ID1 Match reg */
+REG32(TIDMATCH2, 0xac) /* Type ID2 Match reg */
+REG32(TIDMATCH3, 0xb0) /* Type ID3 Match reg */
+REG32(TIDMATCH4, 0xb4) /* Type ID4 Match reg */
+REG32(WOLAN, 0xb8) /* Wake on LAN reg */
+REG32(IPGSTRETCH, 0xbc) /* IPG Stretch reg */
+REG32(SVLAN, 0xc0) /* Stacked VLAN reg */
+REG32(MODID, 0xfc) /* Module ID reg */
+REG32(OCTTXLO, 0x100) /* Octects transmitted Low reg */
+REG32(OCTTXHI, 0x104) /* Octects transmitted High reg */
+REG32(TXCNT, 0x108) /* Error-free Frames transmitted */
+REG32(TXBCNT, 0x10c) /* Error-free Broadcast Frames */
+REG32(TXMCNT, 0x110) /* Error-free Multicast Frame */
+REG32(TXPAUSECNT, 0x114) /* Pause Frames Transmitted */
+REG32(TX64CNT, 0x118) /* Error-free 64 TX */
+REG32(TX65CNT, 0x11c) /* Error-free 65-127 TX */
+REG32(TX128CNT, 0x120) /* Error-free 128-255 TX */
+REG32(TX256CNT, 0x124) /* Error-free 256-511 */
+REG32(TX512CNT, 0x128) /* Error-free 512-1023 TX */
+REG32(TX1024CNT, 0x12c) /* Error-free 1024-1518 TX */
+REG32(TX1519CNT, 0x130) /* Error-free larger than 1519 TX */
+REG32(TXURUNCNT, 0x134) /* TX under run error counter */
+REG32(SINGLECOLLCNT, 0x138) /* Single Collision Frames */
+REG32(MULTCOLLCNT, 0x13c) /* Multiple Collision Frames */
+REG32(EXCESSCOLLCNT, 0x140) /* Excessive Collision Frames */
+REG32(LATECOLLCNT, 0x144) /* Late Collision Frames */
+REG32(DEFERTXCNT, 0x148) /* Deferred Transmission Frames */
+REG32(CSENSECNT, 0x14c) /* Carrier Sense Error Counter */
+REG32(OCTRXLO, 0x150) /* Octects Received register Low */
+REG32(OCTRXHI, 0x154) /* Octects Received register High */
+REG32(RXCNT, 0x158) /* Error-free Frames Received */
+REG32(RXBROADCNT, 0x15c) /* Error-free Broadcast Frames RX */
+REG32(RXMULTICNT, 0x160) /* Error-free Multicast Frames RX */
+REG32(RXPAUSECNT, 0x164) /* Pause Frames Received Counter */
+REG32(RX64CNT, 0x168) /* Error-free 64 byte Frames RX */
+REG32(RX65CNT, 0x16c) /* Error-free 65-127B Frames RX */
+REG32(RX128CNT, 0x170) /* Error-free 128-255B Frames RX */
+REG32(RX256CNT, 0x174) /* Error-free 256-512B Frames RX */
+REG32(RX512CNT, 0x178) /* Error-free 512-1023B Frames RX */
+REG32(RX1024CNT, 0x17c) /* Error-free 1024-1518B Frames RX */
+REG32(RX1519CNT, 0x180) /* Error-free 1519-max Frames RX */
+REG32(RXUNDERCNT, 0x184) /* Undersize Frames Received */
+REG32(RXOVERCNT, 0x188) /* Oversize Frames Received */
+REG32(RXJABCNT, 0x18c) /* Jabbers Received Counter */
+REG32(RXFCSCNT, 0x190) /* Frame Check seq. Error Counter */
+REG32(RXLENERRCNT, 0x194) /* Length Field Error Counter */
+REG32(RXSYMERRCNT, 0x198) /* Symbol Error Counter */
+REG32(RXALIGNERRCNT, 0x19c) /* Alignment Error Counter */
+REG32(RXRSCERRCNT, 0x1a0) /* Receive Resource Error Counter */
+REG32(RXORUNCNT, 0x1a4) /* Receive Overrun Counter */
+REG32(RXIPCSERRCNT, 0x1a8) /* IP header Checksum Err Counter */
+REG32(RXTCPCCNT, 0x1ac) /* TCP Checksum Error Counter */
+REG32(RXUDPCCNT, 0x1b0) /* UDP Checksum Error Counter */
 
-#define GEM_1588S         (0x000001D0 / 4) /* 1588 Timer Seconds */
-#define GEM_1588NS        (0x000001D4 / 4) /* 1588 Timer Nanoseconds */
-#define GEM_1588ADJ       (0x000001D8 / 4) /* 1588 Timer Adjust */
-#define GEM_1588INC       (0x000001DC / 4) /* 1588 Timer Increment */
-#define GEM_PTPETXS       (0x000001E0 / 4) /* PTP Event Frame Transmitted (s) */
-#define GEM_PTPETXNS      (0x000001E4 / 4) /*
-                                            * PTP Event Frame Transmitted (ns)
-                                            */
-#define GEM_PTPERXS       (0x000001E8 / 4) /* PTP Event Frame Received (s) */
-#define GEM_PTPERXNS      (0x000001EC / 4) /* PTP Event Frame Received (ns) */
-#define GEM_PTPPTXS       (0x000001E0 / 4) /* PTP Peer Frame Transmitted (s) */
-#define GEM_PTPPTXNS      (0x000001E4 / 4) /* PTP Peer Frame Transmitted (ns) */
-#define GEM_PTPPRXS       (0x000001E8 / 4) /* PTP Peer Frame Received (s) */
-#define GEM_PTPPRXNS      (0x000001EC / 4) /* PTP Peer Frame Received (ns) */
+REG32(1588S, 0x1d0) /* 1588 Timer Seconds */
+REG32(1588NS, 0x1d4) /* 1588 Timer Nanoseconds */
+REG32(1588ADJ, 0x1d8) /* 1588 Timer Adjust */
+REG32(1588INC, 0x1dc) /* 1588 Timer Increment */
+REG32(PTPETXS, 0x1e0) /* PTP Event Frame Transmitted (s) */
+REG32(PTPETXNS, 0x1e4) /* PTP Event Frame Transmitted (ns) */
+REG32(PTPERXS, 0x1e8) /* PTP Event Frame Received (s) */
+REG32(PTPERXNS, 0x1ec) /* PTP Event Frame Received (ns) */
+REG32(PTPPTXS, 0x1e0) /* PTP Peer Frame Transmitted (s) */
+REG32(PTPPTXNS, 0x1e4) /* PTP Peer Frame Transmitted (ns) */
+REG32(PTPPRXS, 0x1e8) /* PTP Peer Frame Received (s) */
+REG32(PTPPRXNS, 0x1ec) /* PTP Peer Frame Received (ns) */
 
 /* Design Configuration Registers */
-#define GEM_DESCONF       (0x00000280 / 4)
-#define GEM_DESCONF2      (0x00000284 / 4)
-#define GEM_DESCONF3      (0x00000288 / 4)
-#define GEM_DESCONF4      (0x0000028C / 4)
-#define GEM_DESCONF5      (0x00000290 / 4)
-#define GEM_DESCONF6      (0x00000294 / 4)
+REG32(DESCONF, 0x280)
+REG32(DESCONF2, 0x284)
+REG32(DESCONF3, 0x288)
+REG32(DESCONF4, 0x28c)
+REG32(DESCONF5, 0x290)
+REG32(DESCONF6, 0x294)
 #define GEM_DESCONF6_64B_MASK (1U << 23)
-#define GEM_DESCONF7      (0x00000298 / 4)
+REG32(DESCONF7, 0x298)
 
-#define GEM_INT_Q1_STATUS               (0x00000400 / 4)
-#define GEM_INT_Q1_MASK                 (0x00000640 / 4)
+REG32(INT_Q1_STATUS, 0x400)
+REG32(INT_Q1_MASK, 0x640)
 
-#define GEM_TRANSMIT_Q1_PTR             (0x00000440 / 4)
-#define GEM_TRANSMIT_Q7_PTR             (GEM_TRANSMIT_Q1_PTR + 6)
+REG32(TRANSMIT_Q1_PTR, 0x440)
+REG32(TRANSMIT_Q7_PTR, 0x458)
 
-#define GEM_RECEIVE_Q1_PTR              (0x00000480 / 4)
-#define GEM_RECEIVE_Q7_PTR              (GEM_RECEIVE_Q1_PTR + 6)
+REG32(RECEIVE_Q1_PTR, 0x480)
+REG32(RECEIVE_Q7_PTR, 0x498)
 
-#define GEM_TBQPH                       (0x000004C8 / 4)
-#define GEM_RBQPH                       (0x000004D4 / 4)
+REG32(TBQPH, 0x4c8)
+REG32(RBQPH, 0x4d4)
 
-#define GEM_INT_Q1_ENABLE               (0x00000600 / 4)
-#define GEM_INT_Q7_ENABLE               (GEM_INT_Q1_ENABLE + 6)
+REG32(INT_Q1_ENABLE, 0x600)
+REG32(INT_Q7_ENABLE, 0x618)
 
-#define GEM_INT_Q1_DISABLE              (0x00000620 / 4)
-#define GEM_INT_Q7_DISABLE              (GEM_INT_Q1_DISABLE + 6)
+REG32(INT_Q1_DISABLE, 0x620)
+REG32(INT_Q7_DISABLE, 0x638)
 
-#define GEM_INT_Q1_MASK                 (0x00000640 / 4)
-#define GEM_INT_Q7_MASK                 (GEM_INT_Q1_MASK + 6)
-
-#define GEM_SCREENING_TYPE1_REGISTER_0  (0x00000500 / 4)
+REG32(SCREENING_TYPE1_REG0, 0x500)
 
 #define GEM_ST1R_UDP_PORT_MATCH_ENABLE  (1 << 29)
 #define GEM_ST1R_DSTC_ENABLE            (1 << 28)
@@ -184,7 +180,7 @@
 #define GEM_ST1R_QUEUE_SHIFT            (0)
 #define GEM_ST1R_QUEUE_WIDTH            (3 - GEM_ST1R_QUEUE_SHIFT + 1)
 
-#define GEM_SCREENING_TYPE2_REGISTER_0  (0x00000540 / 4)
+REG32(SCREENING_TYPE2_REG0, 0x540)
 
 #define GEM_ST2R_COMPARE_A_ENABLE       (1 << 18)
 #define GEM_ST2R_COMPARE_A_SHIFT        (13)
@@ -196,8 +192,8 @@
 #define GEM_ST2R_QUEUE_SHIFT            (0)
 #define GEM_ST2R_QUEUE_WIDTH            (3 - GEM_ST2R_QUEUE_SHIFT + 1)
 
-#define GEM_SCREENING_TYPE2_ETHERTYPE_REG_0     (0x000006e0 / 4)
-#define GEM_TYPE2_COMPARE_0_WORD_0              (0x00000700 / 4)
+REG32(SCREENING_TYPE2_ETHERTYPE_REG0, 0x6e0)
+REG32(TYPE2_COMPARE_0_WORD_0, 0x700)
 
 #define GEM_T2CW1_COMPARE_OFFSET_SHIFT  (7)
 #define GEM_T2CW1_COMPARE_OFFSET_WIDTH  (8 - GEM_T2CW1_COMPARE_OFFSET_SHIFT + 1)
@@ -325,7 +321,7 @@ static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
     uint64_t ret = desc[0];
 
-    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
         ret |= (uint64_t)desc[2] << 32;
     }
     return ret;
@@ -370,7 +366,7 @@ static inline uint64_t rx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
     uint64_t ret = desc[0] & ~0x3UL;
 
-    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
         ret |= (uint64_t)desc[2] << 32;
     }
     return ret;
@@ -380,10 +376,10 @@ static inline int gem_get_desc_len(CadenceGEMState *s, bool rx_n_tx)
 {
     int ret = 2;
 
-    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
         ret += 2;
     }
-    if (s->regs[GEM_DMACFG] & (rx_n_tx ? GEM_DMACFG_RX_BD_EXT
+    if (s->regs[R_DMACFG] & (rx_n_tx ? GEM_DMACFG_RX_BD_EXT
                                        : GEM_DMACFG_TX_BD_EXT)) {
         ret += 2;
     }
@@ -456,8 +452,8 @@ static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 static uint32_t gem_get_max_buf_len(CadenceGEMState *s, bool tx)
 {
     uint32_t size;
-    if (s->regs[GEM_NWCFG] & GEM_NWCFG_JUMBO_FRAME) {
-        size = s->regs[GEM_JUMBO_MAX_LEN];
+    if (s->regs[R_NWCFG] & GEM_NWCFG_JUMBO_FRAME) {
+        size = s->regs[R_JUMBO_MAX_LEN];
         if (size > s->jumbo_max_len) {
             size = s->jumbo_max_len;
             qemu_log_mask(LOG_GUEST_ERROR, "GEM_JUMBO_MAX_LEN reg cannot be"
@@ -466,7 +462,7 @@ static uint32_t gem_get_max_buf_len(CadenceGEMState *s, bool tx)
     } else if (tx) {
         size = 1518;
     } else {
-        size = s->regs[GEM_NWCFG] & GEM_NWCFG_RCV_1538 ? 1538 : 1518;
+        size = s->regs[R_NWCFG] & GEM_NWCFG_RCV_1538 ? 1538 : 1518;
     }
     return size;
 }
@@ -474,10 +470,10 @@ static uint32_t gem_get_max_buf_len(CadenceGEMState *s, bool tx)
 static void gem_set_isr(CadenceGEMState *s, int q, uint32_t flag)
 {
     if (q == 0) {
-        s->regs[GEM_ISR] |= flag & ~(s->regs[GEM_IMR]);
+        s->regs[R_ISR] |= flag & ~(s->regs[R_IMR]);
     } else {
-        s->regs[GEM_INT_Q1_STATUS + q - 1] |= flag &
-                                      ~(s->regs[GEM_INT_Q1_MASK + q - 1]);
+        s->regs[R_INT_Q1_STATUS + q - 1] |= flag &
+                                      ~(s->regs[R_INT_Q1_MASK + q - 1]);
     }
 }
 
@@ -491,43 +487,43 @@ static void gem_init_register_masks(CadenceGEMState *s)
     unsigned int i;
     /* Mask of register bits which are read only */
     memset(&s->regs_ro[0], 0, sizeof(s->regs_ro));
-    s->regs_ro[GEM_NWCTRL]   = 0xFFF80000;
-    s->regs_ro[GEM_NWSTATUS] = 0xFFFFFFFF;
-    s->regs_ro[GEM_DMACFG]   = 0x8E00F000;
-    s->regs_ro[GEM_TXSTATUS] = 0xFFFFFE08;
-    s->regs_ro[GEM_RXQBASE]  = 0x00000003;
-    s->regs_ro[GEM_TXQBASE]  = 0x00000003;
-    s->regs_ro[GEM_RXSTATUS] = 0xFFFFFFF0;
-    s->regs_ro[GEM_ISR]      = 0xFFFFFFFF;
-    s->regs_ro[GEM_IMR]      = 0xFFFFFFFF;
-    s->regs_ro[GEM_MODID]    = 0xFFFFFFFF;
+    s->regs_ro[R_NWCTRL]   = 0xFFF80000;
+    s->regs_ro[R_NWSTATUS] = 0xFFFFFFFF;
+    s->regs_ro[R_DMACFG]   = 0x8E00F000;
+    s->regs_ro[R_TXSTATUS] = 0xFFFFFE08;
+    s->regs_ro[R_RXQBASE]  = 0x00000003;
+    s->regs_ro[R_TXQBASE]  = 0x00000003;
+    s->regs_ro[R_RXSTATUS] = 0xFFFFFFF0;
+    s->regs_ro[R_ISR]      = 0xFFFFFFFF;
+    s->regs_ro[R_IMR]      = 0xFFFFFFFF;
+    s->regs_ro[R_MODID]    = 0xFFFFFFFF;
     for (i = 0; i < s->num_priority_queues; i++) {
-        s->regs_ro[GEM_INT_Q1_STATUS + i] = 0xFFFFFFFF;
-        s->regs_ro[GEM_INT_Q1_ENABLE + i] = 0xFFFFF319;
-        s->regs_ro[GEM_INT_Q1_DISABLE + i] = 0xFFFFF319;
-        s->regs_ro[GEM_INT_Q1_MASK + i] = 0xFFFFFFFF;
+        s->regs_ro[R_INT_Q1_STATUS + i] = 0xFFFFFFFF;
+        s->regs_ro[R_INT_Q1_ENABLE + i] = 0xFFFFF319;
+        s->regs_ro[R_INT_Q1_DISABLE + i] = 0xFFFFF319;
+        s->regs_ro[R_INT_Q1_MASK + i] = 0xFFFFFFFF;
     }
 
     /* Mask of register bits which are clear on read */
     memset(&s->regs_rtc[0], 0, sizeof(s->regs_rtc));
-    s->regs_rtc[GEM_ISR]      = 0xFFFFFFFF;
+    s->regs_rtc[R_ISR]      = 0xFFFFFFFF;
     for (i = 0; i < s->num_priority_queues; i++) {
-        s->regs_rtc[GEM_INT_Q1_STATUS + i] = 0x00000CE6;
+        s->regs_rtc[R_INT_Q1_STATUS + i] = 0x00000CE6;
     }
 
     /* Mask of register bits which are write 1 to clear */
     memset(&s->regs_w1c[0], 0, sizeof(s->regs_w1c));
-    s->regs_w1c[GEM_TXSTATUS] = 0x000001F7;
-    s->regs_w1c[GEM_RXSTATUS] = 0x0000000F;
+    s->regs_w1c[R_TXSTATUS] = 0x000001F7;
+    s->regs_w1c[R_RXSTATUS] = 0x0000000F;
 
     /* Mask of register bits which are write only */
     memset(&s->regs_wo[0], 0, sizeof(s->regs_wo));
-    s->regs_wo[GEM_NWCTRL]   = 0x00073E60;
-    s->regs_wo[GEM_IER]      = 0x07FFFFFF;
-    s->regs_wo[GEM_IDR]      = 0x07FFFFFF;
+    s->regs_wo[R_NWCTRL]   = 0x00073E60;
+    s->regs_wo[R_IER]      = 0x07FFFFFF;
+    s->regs_wo[R_IDR]      = 0x07FFFFFF;
     for (i = 0; i < s->num_priority_queues; i++) {
-        s->regs_wo[GEM_INT_Q1_ENABLE + i] = 0x00000CE6;
-        s->regs_wo[GEM_INT_Q1_DISABLE + i] = 0x00000CE6;
+        s->regs_wo[R_INT_Q1_ENABLE + i] = 0x00000CE6;
+        s->regs_wo[R_INT_Q1_DISABLE + i] = 0x00000CE6;
     }
 }
 
@@ -561,7 +557,7 @@ static bool gem_can_receive(NetClientState *nc)
     s = qemu_get_nic_opaque(nc);
 
     /* Do nothing if receive is not enabled. */
-    if (!(s->regs[GEM_NWCTRL] & GEM_NWCTRL_RXENA)) {
+    if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_RXENA)) {
         if (s->can_rx_state != 1) {
             s->can_rx_state = 1;
             DB_PRINT("can't receive - no enable\n");
@@ -598,10 +594,10 @@ static void gem_update_int_status(CadenceGEMState *s)
 {
     int i;
 
-    qemu_set_irq(s->irq[0], !!s->regs[GEM_ISR]);
+    qemu_set_irq(s->irq[0], !!s->regs[R_ISR]);
 
     for (i = 1; i < s->num_priority_queues; ++i) {
-        qemu_set_irq(s->irq[i], !!s->regs[GEM_INT_Q1_STATUS + i - 1]);
+        qemu_set_irq(s->irq[i], !!s->regs[R_INT_Q1_STATUS + i - 1]);
     }
 }
 
@@ -615,39 +611,39 @@ static void gem_receive_updatestats(CadenceGEMState *s, const uint8_t *packet,
     uint64_t octets;
 
     /* Total octets (bytes) received */
-    octets = ((uint64_t)(s->regs[GEM_OCTRXLO]) << 32) |
-             s->regs[GEM_OCTRXHI];
+    octets = ((uint64_t)(s->regs[R_OCTRXLO]) << 32) |
+             s->regs[R_OCTRXHI];
     octets += bytes;
-    s->regs[GEM_OCTRXLO] = octets >> 32;
-    s->regs[GEM_OCTRXHI] = octets;
+    s->regs[R_OCTRXLO] = octets >> 32;
+    s->regs[R_OCTRXHI] = octets;
 
     /* Error-free Frames received */
-    s->regs[GEM_RXCNT]++;
+    s->regs[R_RXCNT]++;
 
     /* Error-free Broadcast Frames counter */
     if (!memcmp(packet, broadcast_addr, 6)) {
-        s->regs[GEM_RXBROADCNT]++;
+        s->regs[R_RXBROADCNT]++;
     }
 
     /* Error-free Multicast Frames counter */
     if (packet[0] == 0x01) {
-        s->regs[GEM_RXMULTICNT]++;
+        s->regs[R_RXMULTICNT]++;
     }
 
     if (bytes <= 64) {
-        s->regs[GEM_RX64CNT]++;
+        s->regs[R_RX64CNT]++;
     } else if (bytes <= 127) {
-        s->regs[GEM_RX65CNT]++;
+        s->regs[R_RX65CNT]++;
     } else if (bytes <= 255) {
-        s->regs[GEM_RX128CNT]++;
+        s->regs[R_RX128CNT]++;
     } else if (bytes <= 511) {
-        s->regs[GEM_RX256CNT]++;
+        s->regs[R_RX256CNT]++;
     } else if (bytes <= 1023) {
-        s->regs[GEM_RX512CNT]++;
+        s->regs[R_RX512CNT]++;
     } else if (bytes <= 1518) {
-        s->regs[GEM_RX1024CNT]++;
+        s->regs[R_RX1024CNT]++;
     } else {
-        s->regs[GEM_RX1519CNT]++;
+        s->regs[R_RX1519CNT]++;
     }
 }
 
@@ -706,13 +702,13 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
     int i, is_mc;
 
     /* Promiscuous mode? */
-    if (s->regs[GEM_NWCFG] & GEM_NWCFG_PROMISC) {
+    if (s->regs[R_NWCFG] & GEM_NWCFG_PROMISC) {
         return GEM_RX_PROMISCUOUS_ACCEPT;
     }
 
     if (!memcmp(packet, broadcast_addr, 6)) {
         /* Reject broadcast packets? */
-        if (s->regs[GEM_NWCFG] & GEM_NWCFG_BCAST_REJ) {
+        if (s->regs[R_NWCFG] & GEM_NWCFG_BCAST_REJ) {
             return GEM_RX_REJECT;
         }
         return GEM_RX_BROADCAST_ACCEPT;
@@ -720,13 +716,13 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
 
     /* Accept packets -w- hash match? */
     is_mc = is_multicast_ether_addr(packet);
-    if ((is_mc && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
-        (!is_mc && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
+    if ((is_mc && (s->regs[R_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
+        (!is_mc && (s->regs[R_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
         uint64_t buckets;
         unsigned hash_index;
 
         hash_index = calc_mac_hash(packet);
-        buckets = ((uint64_t)s->regs[GEM_HASHHI] << 32) | s->regs[GEM_HASHLO];
+        buckets = ((uint64_t)s->regs[R_HASHHI] << 32) | s->regs[R_HASHLO];
         if ((buckets >> hash_index) & 1) {
             return is_mc ? GEM_RX_MULTICAST_HASH_ACCEPT
                          : GEM_RX_UNICAST_HASH_ACCEPT;
@@ -734,7 +730,7 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
     }
 
     /* Check all 4 specific addresses */
-    gem_spaddr = (uint8_t *)&(s->regs[GEM_SPADDR1LO]);
+    gem_spaddr = (uint8_t *)&(s->regs[R_SPADDR1LO]);
     for (i = 3; i >= 0; i--) {
         if (s->sar_active[i] && !memcmp(packet, gem_spaddr + 8 * i, 6)) {
             return GEM_RX_SAR_ACCEPT + i;
@@ -754,7 +750,7 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
     int i, j;
 
     for (i = 0; i < s->num_type1_screeners; i++) {
-        reg = s->regs[GEM_SCREENING_TYPE1_REGISTER_0 + i];
+        reg = s->regs[R_SCREENING_TYPE1_REG0 + i];
         matched = false;
         mismatched = false;
 
@@ -786,7 +782,7 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
     }
 
     for (i = 0; i < s->num_type2_screeners; i++) {
-        reg = s->regs[GEM_SCREENING_TYPE2_REGISTER_0 + i];
+        reg = s->regs[R_SCREENING_TYPE2_REG0 + i];
         matched = false;
         mismatched = false;
 
@@ -799,7 +795,7 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
                 qemu_log_mask(LOG_GUEST_ERROR, "Out of range ethertype "
                               "register index: %d\n", et_idx);
             }
-            if (type == s->regs[GEM_SCREENING_TYPE2_ETHERTYPE_REG_0 +
+            if (type == s->regs[R_SCREENING_TYPE2_ETHERTYPE_REG0 +
                                 et_idx]) {
                 matched = true;
             } else {
@@ -823,8 +819,8 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
                               "register index: %d\n", cr_idx);
             }
 
-            cr0 = s->regs[GEM_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2];
-            cr1 = s->regs[GEM_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2 + 1];
+            cr0 = s->regs[R_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2];
+            cr1 = s->regs[R_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2 + 1];
             offset = extract32(cr1, GEM_T2CW1_OFFSET_VALUE_SHIFT,
                                     GEM_T2CW1_OFFSET_VALUE_WIDTH);
 
@@ -871,11 +867,11 @@ static uint32_t gem_get_queue_base_addr(CadenceGEMState *s, bool tx, int q)
 
     switch (q) {
     case 0:
-        base_addr = s->regs[tx ? GEM_TXQBASE : GEM_RXQBASE];
+        base_addr = s->regs[tx ? R_TXQBASE : R_RXQBASE];
         break;
     case 1 ... (MAX_PRIORITY_QUEUES - 1):
-        base_addr = s->regs[(tx ? GEM_TRANSMIT_Q1_PTR :
-                                 GEM_RECEIVE_Q1_PTR) + q - 1];
+        base_addr = s->regs[(tx ? R_TRANSMIT_Q1_PTR :
+                                 R_RECEIVE_Q1_PTR) + q - 1];
         break;
     default:
         g_assert_not_reached();
@@ -898,8 +894,8 @@ static hwaddr gem_get_desc_addr(CadenceGEMState *s, bool tx, int q)
 {
     hwaddr desc_addr = 0;
 
-    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
-        desc_addr = s->regs[tx ? GEM_TBQPH : GEM_RBQPH];
+    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+        desc_addr = s->regs[tx ? R_TBQPH : R_RBQPH];
     }
     desc_addr <<= 32;
     desc_addr |= tx ? s->tx_desc_addr[q] : s->rx_desc_addr[q];
@@ -930,7 +926,7 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
     /* Descriptor owned by software ? */
     if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
         DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n", desc_addr);
-        s->regs[GEM_RXSTATUS] |= GEM_RXSTATUS_NOBUF;
+        s->regs[R_RXSTATUS] |= GEM_RXSTATUS_NOBUF;
         gem_set_isr(s, q, GEM_INT_RXUSED);
         /* Handle interrupt consequences */
         gem_update_int_status(s);
@@ -958,7 +954,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     }
 
     /* Discard packets with receive length error enabled ? */
-    if (s->regs[GEM_NWCFG] & GEM_NWCFG_LERR_DISC) {
+    if (s->regs[R_NWCFG] & GEM_NWCFG_LERR_DISC) {
         unsigned type_len;
 
         /* Fish the ethertype / length field out of the RX packet */
@@ -975,13 +971,13 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     /*
      * Determine configured receive buffer offset (probably 0)
      */
-    rxbuf_offset = (s->regs[GEM_NWCFG] & GEM_NWCFG_BUFF_OFST_M) >>
+    rxbuf_offset = (s->regs[R_NWCFG] & GEM_NWCFG_BUFF_OFST_M) >>
                    GEM_NWCFG_BUFF_OFST_S;
 
     /* The configure size of each receive buffer.  Determines how many
      * buffers needed to hold this packet.
      */
-    rxbufsize = ((s->regs[GEM_DMACFG] & GEM_DMACFG_RBUFSZ_M) >>
+    rxbufsize = ((s->regs[R_DMACFG] & GEM_DMACFG_RBUFSZ_M) >>
                  GEM_DMACFG_RBUFSZ_S) * GEM_DMACFG_RBUFSZ_MUL;
     bytes_to_copy = size;
 
@@ -1001,7 +997,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     }
 
     /* Strip of FCS field ? (usually yes) */
-    if (s->regs[GEM_NWCFG] & GEM_NWCFG_STRIP_FCS) {
+    if (s->regs[R_NWCFG] & GEM_NWCFG_STRIP_FCS) {
         rxbuf_ptr = (void *)buf;
     } else {
         unsigned crc_val;
@@ -1107,7 +1103,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     /* Count it */
     gem_receive_updatestats(s, buf, size);
 
-    s->regs[GEM_RXSTATUS] |= GEM_RXSTATUS_FRMRCVD;
+    s->regs[R_RXSTATUS] |= GEM_RXSTATUS_FRMRCVD;
     gem_set_isr(s, q, GEM_INT_RXCMPL);
 
     /* Handle interrupt consequences */
@@ -1126,39 +1122,39 @@ static void gem_transmit_updatestats(CadenceGEMState *s, const uint8_t *packet,
     uint64_t octets;
 
     /* Total octets (bytes) transmitted */
-    octets = ((uint64_t)(s->regs[GEM_OCTTXLO]) << 32) |
-             s->regs[GEM_OCTTXHI];
+    octets = ((uint64_t)(s->regs[R_OCTTXLO]) << 32) |
+             s->regs[R_OCTTXHI];
     octets += bytes;
-    s->regs[GEM_OCTTXLO] = octets >> 32;
-    s->regs[GEM_OCTTXHI] = octets;
+    s->regs[R_OCTTXLO] = octets >> 32;
+    s->regs[R_OCTTXHI] = octets;
 
     /* Error-free Frames transmitted */
-    s->regs[GEM_TXCNT]++;
+    s->regs[R_TXCNT]++;
 
     /* Error-free Broadcast Frames counter */
     if (!memcmp(packet, broadcast_addr, 6)) {
-        s->regs[GEM_TXBCNT]++;
+        s->regs[R_TXBCNT]++;
     }
 
     /* Error-free Multicast Frames counter */
     if (packet[0] == 0x01) {
-        s->regs[GEM_TXMCNT]++;
+        s->regs[R_TXMCNT]++;
     }
 
     if (bytes <= 64) {
-        s->regs[GEM_TX64CNT]++;
+        s->regs[R_TX64CNT]++;
     } else if (bytes <= 127) {
-        s->regs[GEM_TX65CNT]++;
+        s->regs[R_TX65CNT]++;
     } else if (bytes <= 255) {
-        s->regs[GEM_TX128CNT]++;
+        s->regs[R_TX128CNT]++;
     } else if (bytes <= 511) {
-        s->regs[GEM_TX256CNT]++;
+        s->regs[R_TX256CNT]++;
     } else if (bytes <= 1023) {
-        s->regs[GEM_TX512CNT]++;
+        s->regs[R_TX512CNT]++;
     } else if (bytes <= 1518) {
-        s->regs[GEM_TX1024CNT]++;
+        s->regs[R_TX1024CNT]++;
     } else {
-        s->regs[GEM_TX1519CNT]++;
+        s->regs[R_TX1519CNT]++;
     }
 }
 
@@ -1175,7 +1171,7 @@ static void gem_transmit(CadenceGEMState *s)
     int q = 0;
 
     /* Do nothing if transmit is not enabled. */
-    if (!(s->regs[GEM_NWCTRL] & GEM_NWCTRL_TXENA)) {
+    if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_TXENA)) {
         return;
     }
 
@@ -1200,7 +1196,7 @@ static void gem_transmit(CadenceGEMState *s)
         while (tx_desc_get_used(desc) == 0) {
 
             /* Do nothing if transmit is not enabled. */
-            if (!(s->regs[GEM_NWCTRL] & GEM_NWCTRL_TXENA)) {
+            if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_TXENA)) {
                 return;
             }
             print_gem_tx_desc(desc, q);
@@ -1258,14 +1254,14 @@ static void gem_transmit(CadenceGEMState *s)
                 }
                 DB_PRINT("TX descriptor next: 0x%08x\n", s->tx_desc_addr[q]);
 
-                s->regs[GEM_TXSTATUS] |= GEM_TXSTATUS_TXCMPL;
+                s->regs[R_TXSTATUS] |= GEM_TXSTATUS_TXCMPL;
                 gem_set_isr(s, q, GEM_INT_TXCMPL);
 
                 /* Handle interrupt consequences */
                 gem_update_int_status(s);
 
                 /* Is checksum offload enabled? */
-                if (s->regs[GEM_DMACFG] & GEM_DMACFG_TXCSUM_OFFL) {
+                if (s->regs[R_DMACFG] & GEM_DMACFG_TXCSUM_OFFL) {
                     net_checksum_calculate(s->tx_packet, total_bytes, CSUM_ALL);
                 }
 
@@ -1273,7 +1269,7 @@ static void gem_transmit(CadenceGEMState *s)
                 gem_transmit_updatestats(s, s->tx_packet, total_bytes);
 
                 /* Send the packet somewhere */
-                if (s->phy_loop || (s->regs[GEM_NWCTRL] &
+                if (s->phy_loop || (s->regs[R_NWCTRL] &
                                     GEM_NWCTRL_LOCALLOOP)) {
                     qemu_receive_packet(qemu_get_queue(s->nic), s->tx_packet,
                                         total_bytes);
@@ -1289,9 +1285,8 @@ static void gem_transmit(CadenceGEMState *s)
 
             /* read next descriptor */
             if (tx_desc_get_wrap(desc)) {
-
-                if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
-                    packet_desc_addr = s->regs[GEM_TBQPH];
+                if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+                    packet_desc_addr = s->regs[R_TBQPH];
                     packet_desc_addr <<= 32;
                 } else {
                     packet_desc_addr = 0;
@@ -1307,7 +1302,7 @@ static void gem_transmit(CadenceGEMState *s)
         }
 
         if (tx_desc_get_used(desc)) {
-            s->regs[GEM_TXSTATUS] |= GEM_TXSTATUS_USED;
+            s->regs[R_TXSTATUS] |= GEM_TXSTATUS_USED;
             /* IRQ TXUSED is defined only for queue 0 */
             if (q == 0) {
                 gem_set_isr(s, 0, GEM_INT_TXUSED);
@@ -1353,30 +1348,30 @@ static void gem_reset(DeviceState *d)
 
     /* Set post reset register values */
     memset(&s->regs[0], 0, sizeof(s->regs));
-    s->regs[GEM_NWCFG] = 0x00080000;
-    s->regs[GEM_NWSTATUS] = 0x00000006;
-    s->regs[GEM_DMACFG] = 0x00020784;
-    s->regs[GEM_IMR] = 0x07ffffff;
-    s->regs[GEM_TXPAUSE] = 0x0000ffff;
-    s->regs[GEM_TXPARTIALSF] = 0x000003ff;
-    s->regs[GEM_RXPARTIALSF] = 0x000003ff;
-    s->regs[GEM_MODID] = s->revision;
-    s->regs[GEM_DESCONF] = 0x02D00111;
-    s->regs[GEM_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
-    s->regs[GEM_DESCONF5] = 0x002f2045;
-    s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
-    s->regs[GEM_INT_Q1_MASK] = 0x00000CE6;
-    s->regs[GEM_JUMBO_MAX_LEN] = s->jumbo_max_len;
+    s->regs[R_NWCFG] = 0x00080000;
+    s->regs[R_NWSTATUS] = 0x00000006;
+    s->regs[R_DMACFG] = 0x00020784;
+    s->regs[R_IMR] = 0x07ffffff;
+    s->regs[R_TXPAUSE] = 0x0000ffff;
+    s->regs[R_TXPARTIALSF] = 0x000003ff;
+    s->regs[R_RXPARTIALSF] = 0x000003ff;
+    s->regs[R_MODID] = s->revision;
+    s->regs[R_DESCONF] = 0x02D00111;
+    s->regs[R_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
+    s->regs[R_DESCONF5] = 0x002f2045;
+    s->regs[R_DESCONF6] = GEM_DESCONF6_64B_MASK;
+    s->regs[R_INT_Q1_MASK] = 0x00000CE6;
+    s->regs[R_JUMBO_MAX_LEN] = s->jumbo_max_len;
 
     if (s->num_priority_queues > 1) {
         queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
-        s->regs[GEM_DESCONF6] |= queues_mask;
+        s->regs[R_DESCONF6] |= queues_mask;
     }
 
     /* Set MAC address */
     a = &s->conf.macaddr.a[0];
-    s->regs[GEM_SPADDR1LO] = a[0] | (a[1] << 8) | (a[2] << 16) | (a[3] << 24);
-    s->regs[GEM_SPADDR1HI] = a[4] | (a[5] << 8);
+    s->regs[R_SPADDR1LO] = a[0] | (a[1] << 8) | (a[2] << 16) | (a[3] << 24);
+    s->regs[R_SPADDR1HI] = a[4] | (a[5] << 8);
 
     for (i = 0; i < 4; i++) {
         s->sar_active[i] = false;
@@ -1437,11 +1432,11 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
     DB_PRINT("offset: 0x%04x read: 0x%08x\n", (unsigned)offset*4, retval);
 
     switch (offset) {
-    case GEM_ISR:
+    case R_ISR:
         DB_PRINT("lowering irqs on ISR read\n");
         /* The interrupts get updated at the end of the function. */
         break;
-    case GEM_PHYMNTNC:
+    case R_PHYMNTNC:
         if (retval & GEM_PHYMNTNC_OP_R) {
             uint32_t phy_addr, reg_num;
 
@@ -1495,7 +1490,7 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
 
     /* Handle register write side effects */
     switch (offset) {
-    case GEM_NWCTRL:
+    case R_NWCTRL:
         if (val & GEM_NWCTRL_RXENA) {
             for (i = 0; i < s->num_priority_queues; ++i) {
                 gem_get_rx_desc(s, i);
@@ -1515,56 +1510,56 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         }
         break;
 
-    case GEM_TXSTATUS:
+    case R_TXSTATUS:
         gem_update_int_status(s);
         break;
-    case GEM_RXQBASE:
+    case R_RXQBASE:
         s->rx_desc_addr[0] = val;
         break;
-    case GEM_RECEIVE_Q1_PTR ... GEM_RECEIVE_Q7_PTR:
-        s->rx_desc_addr[offset - GEM_RECEIVE_Q1_PTR + 1] = val;
+    case R_RECEIVE_Q1_PTR ... R_RECEIVE_Q7_PTR:
+        s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1] = val;
         break;
-    case GEM_TXQBASE:
+    case R_TXQBASE:
         s->tx_desc_addr[0] = val;
         break;
-    case GEM_TRANSMIT_Q1_PTR ... GEM_TRANSMIT_Q7_PTR:
-        s->tx_desc_addr[offset - GEM_TRANSMIT_Q1_PTR + 1] = val;
+    case R_TRANSMIT_Q1_PTR ... R_TRANSMIT_Q7_PTR:
+        s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1] = val;
         break;
-    case GEM_RXSTATUS:
+    case R_RXSTATUS:
         gem_update_int_status(s);
         break;
-    case GEM_IER:
-        s->regs[GEM_IMR] &= ~val;
+    case R_IER:
+        s->regs[R_IMR] &= ~val;
         gem_update_int_status(s);
         break;
-    case GEM_JUMBO_MAX_LEN:
-        s->regs[GEM_JUMBO_MAX_LEN] = val & MAX_JUMBO_FRAME_SIZE_MASK;
+    case R_JUMBO_MAX_LEN:
+        s->regs[R_JUMBO_MAX_LEN] = val & MAX_JUMBO_FRAME_SIZE_MASK;
         break;
-    case GEM_INT_Q1_ENABLE ... GEM_INT_Q7_ENABLE:
-        s->regs[GEM_INT_Q1_MASK + offset - GEM_INT_Q1_ENABLE] &= ~val;
+    case R_INT_Q1_ENABLE ... R_INT_Q7_ENABLE:
+        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_ENABLE] &= ~val;
         gem_update_int_status(s);
         break;
-    case GEM_IDR:
-        s->regs[GEM_IMR] |= val;
+    case R_IDR:
+        s->regs[R_IMR] |= val;
         gem_update_int_status(s);
         break;
-    case GEM_INT_Q1_DISABLE ... GEM_INT_Q7_DISABLE:
-        s->regs[GEM_INT_Q1_MASK + offset - GEM_INT_Q1_DISABLE] |= val;
+    case R_INT_Q1_DISABLE ... R_INT_Q7_DISABLE:
+        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_DISABLE] |= val;
         gem_update_int_status(s);
         break;
-    case GEM_SPADDR1LO:
-    case GEM_SPADDR2LO:
-    case GEM_SPADDR3LO:
-    case GEM_SPADDR4LO:
-        s->sar_active[(offset - GEM_SPADDR1LO) / 2] = false;
+    case R_SPADDR1LO:
+    case R_SPADDR2LO:
+    case R_SPADDR3LO:
+    case R_SPADDR4LO:
+        s->sar_active[(offset - R_SPADDR1LO) / 2] = false;
         break;
-    case GEM_SPADDR1HI:
-    case GEM_SPADDR2HI:
-    case GEM_SPADDR3HI:
-    case GEM_SPADDR4HI:
-        s->sar_active[(offset - GEM_SPADDR1HI) / 2] = true;
+    case R_SPADDR1HI:
+    case R_SPADDR2HI:
+    case R_SPADDR3HI:
+    case R_SPADDR4HI:
+        s->sar_active[(offset - R_SPADDR1HI) / 2] = true;
         break;
-    case GEM_PHYMNTNC:
+    case R_PHYMNTNC:
         if (val & GEM_PHYMNTNC_OP_W) {
             uint32_t phy_addr, reg_num;
 
-- 
2.34.1


