Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D347CD034
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 01:05:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qst6h-0006Ny-SX; Tue, 17 Oct 2023 19:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <35RIvZQwKCvYlYZgfcqrcdYlemmejc.amkocks-bctcjlmlels.mpe@flex--nabihestefan.bounces.google.com>)
 id 1qst6e-0006MN-K0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 19:04:08 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <35RIvZQwKCvYlYZgfcqrcdYlemmejc.amkocks-bctcjlmlels.mpe@flex--nabihestefan.bounces.google.com>)
 id 1qst6c-0002L0-9r
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 19:04:08 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-d9a3a98b34dso8630310276.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697583845; x=1698188645; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=E8ToDeX/5FCM1y7oICGBWNE+v+YC+LclVIb2f1hpmV4=;
 b=1YwZEh7H9t/Pn7/mK1QC46Z5/koSudg2dFlBHPsaQCiIv4frRe9zB1ie2gOjAxJFDG
 BnsnxPKuam8TyNXjPs/R5aD6F4WiDVJytbM0WczFDSJnqgeAabI0fkx35efgi+9lOLlq
 rjcfnXPothTNRapzMxwizpiu/lhUqRjQMZVpqD9UzrO17qzWLbssRCFLLQeiZhmAJp+e
 SERv+dAISlNQW7Xqav18eumGZQCuNny7IRLUfNGYdPfxwkYEE7CSvK90NFfAb9vwLv/H
 yXpdepf2T8WBaWDG1uxpoYwqEYWYVTdpc10T+ABN/KduqlznrrS+tiYJGYQhv7mcgYAs
 C1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697583845; x=1698188645;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E8ToDeX/5FCM1y7oICGBWNE+v+YC+LclVIb2f1hpmV4=;
 b=nB1N6FSejr1W5U0rCCnO7WknsXM2tCujjNOqY7ihMFEr1ctX82QsccS2K5seZNszE0
 YiZQAtUA+QMk9wvahdjswsPcrZa5KgKjYeFVHnZFS/E0imH28DccJ6KSuQnaccO3k60X
 oBRhn+MZfzw9ZUi36oEWEsTBgCCARH55s4dGvr3hmfQL6AC2DYGrPyA192vN6SbQ26fw
 qpZQhycNOzc0CY1EnKuFw1/r0UkizzyAcK3l90PHY0RzCC+aXaw+E53RVZRlvSO/Dg0+
 I32PqWUYF25ttdJc5ZGEmpyQ14JN+9wnz1dwbRICNrMHhsjaGXuKnt2LcTKmoTzYqL49
 l/Cg==
X-Gm-Message-State: AOJu0YzER7XsrZIzZ8Xo4wpOf2E+OwLn3iGmyO1il1iGWGEsgTkeIjs/
 //+Gx+Vug290itQw5pJTOc275FrZXL8WnRFQlaI=
X-Google-Smtp-Source: AGHT+IEsIyjK3y9xe+OGM8FD9RFpdcA4zos83YoirYfMkEVjYI04h12QdAmgePCpQDCKTSrty57ZD9NE4IOOgQTUqiA=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:102d:b0:d9c:2a58:b905 with
 SMTP id x13-20020a056902102d00b00d9c2a58b905mr100860ybt.9.1697583845007; Tue,
 17 Oct 2023 16:04:05 -0700 (PDT)
Date: Tue, 17 Oct 2023 23:03:39 +0000
In-Reply-To: <20231017230342.311227-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20231017230342.311227-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017230342.311227-9-nabihestefan@google.com>
Subject: [PATCH v3 08/11] hw/net: General GMAC Implementation
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 Nabih Estefan Diaz <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=35RIvZQwKCvYlYZgfcqrcdYlemmejc.amkocks-bctcjlmlels.mpe@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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

From: Nabih Estefan Diaz <nabihestefan@google.com>

- General GMAC Register handling
- GMAC IRQ Handling
- Added traces in some methods for debugging
- Lots of declarations for accessing information on GMAC Descriptors (npcm_gmac.h file)

NOTE: With code on this state, the GMAC can boot-up properly and will show up in the ifconfig command on the BMC

Google-Rebase-Count: 1
Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>
Google-Bug-Id: 237557100
Change-Id: I3a4332ee5bab31b919782031a77c5b943f45ca2f
---
 include/hw/net/npcm_gmac.h | 198 ++++++++++++++++++++++++++++++++++---
 1 file changed, 184 insertions(+), 14 deletions(-)

diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
index e5729e83ea..c97eb6fe6e 100644
--- a/include/hw/net/npcm_gmac.h
+++ b/include/hw/net/npcm_gmac.h
@@ -34,13 +34,15 @@ struct NPCMGMACRxDesc {
 };
 
 /* NPCMGMACRxDesc.flags values */
-/* RDES2 and RDES3 are buffer address pointers */
-/* Owner: 0 = software, 1 = gmac */
-#define RX_DESC_RDES0_OWNER_MASK BIT(31)
+/* RDES2 and RDES3 are buffer addresses */
+/* Owner: 0 = software, 1 = dma */
+#define RX_DESC_RDES0_OWN BIT(31)
 /* Destination Address Filter Fail */
-#define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL_MASK BIT(30)
-/* Frame length*/
-#define RX_DESC_RDES0_FRAME_LEN_MASK(word) extract32(word, 16, 29)
+#define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL BIT(30)
+/* Frame length */
+#define RX_DESC_RDES0_FRAME_LEN_MASK(word) extract32(word, 16, 14)
+/* Frame length Shift*/
+#define RX_DESC_RDES0_FRAME_LEN_SHIFT 16
 /* Error Summary */
 #define RX_DESC_RDES0_ERR_SUMM_MASK BIT(15)
 /* Descriptor Error */
@@ -83,9 +85,9 @@ struct NPCMGMACRxDesc {
 /* Receive Buffer 2 Size */
 #define RX_DESC_RDES1_BFFR2_SZ_SHIFT 11
 #define RX_DESC_RDES1_BFFR2_SZ_MASK(word) extract32(word, \
-    RX_DESC_RDES1_BFFR2_SZ_SHIFT, 10 + RX_DESC_RDES1_BFFR2_SZ_SHIFT)
+    RX_DESC_RDES1_BFFR2_SZ_SHIFT, 11)
 /* Receive Buffer 1 Size */
-#define RX_DESC_RDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 10)
+#define RX_DESC_RDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 11)
 
 
 struct NPCMGMACTxDesc {
@@ -96,9 +98,9 @@ struct NPCMGMACTxDesc {
 };
 
 /* NPCMGMACTxDesc.flags values */
-/* TDES2 and TDES3 are buffer address pointers */
+/* TDES2 and TDES3 are buffer addresses */
 /* Owner: 0 = software, 1 = gmac */
-#define TX_DESC_TDES0_OWNER_MASK BIT(31)
+#define TX_DESC_TDES0_OWN BIT(31)
 /* Tx Time Stamp Status */
 #define TX_DESC_TDES0_TTSS_MASK BIT(17)
 /* IP Header Error */
@@ -122,7 +124,7 @@ struct NPCMGMACTxDesc {
 /* VLAN Frame */
 #define TX_DESC_TDES0_VLAN_FRM_MASK BIT(7)
 /* Collision Count */
-#define TX_DESC_TDES0_COLL_CNT_MASK(word) extract32(word, 3, 6)
+#define TX_DESC_TDES0_COLL_CNT_MASK(word) extract32(word, 3, 4)
 /* Excessive Deferral */
 #define TX_DESC_TDES0_EXCS_DEF_MASK BIT(2)
 /* Underflow Error */
@@ -137,7 +139,7 @@ struct NPCMGMACTxDesc {
 /* Last Segment */
 #define TX_DESC_TDES1_FIRST_SEG_MASK BIT(29)
 /* Checksum Insertion Control */
-#define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(word) extract32(word, 27, 28)
+#define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(word) extract32(word, 27, 2)
 /* Disable Cyclic Redundancy Check */
 #define TX_DESC_TDES1_DIS_CDC_MASK BIT(26)
 /* Transmit End of Ring */
@@ -145,9 +147,9 @@ struct NPCMGMACTxDesc {
 /* Secondary Address Chained */
 #define TX_DESC_TDES1_SEC_ADDR_CHND_MASK BIT(24)
 /* Transmit Buffer 2 Size */
-#define TX_DESC_TDES1_BFFR2_SZ_MASK(word) extract32(word, 11, 21)
+#define TX_DESC_TDES1_BFFR2_SZ_MASK(word) extract32(word, 11, 11)
 /* Transmit Buffer 1 Size */
-#define TX_DESC_TDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 10)
+#define TX_DESC_TDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 11)
 
 typedef struct NPCMGMACState {
     SysBusDevice parent;
@@ -165,4 +167,172 @@ typedef struct NPCMGMACState {
 #define TYPE_NPCM_GMAC "npcm-gmac"
 OBJECT_DECLARE_SIMPLE_TYPE(NPCMGMACState, NPCM_GMAC)
 
+/* Mask for RO bits in Status */
+#define NPCM_DMA_STATUS_RO_MASK(word) (word & 0xfffe0000)
+/* Mask for RO bits in Status */
+#define NPCM_DMA_STATUS_W1C_MASK(word) (word & 0x1e7ff)
+
+/* Transmit Process State */
+#define NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT 20
+/* Transmit States */
+#define NPCM_DMA_STATUS_TX_STOPPED_STATE \
+    (0b000 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
+#define NPCM_DMA_STATUS_TX_RUNNING_FETCHING_STATE \
+    (0b001 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
+#define NPCM_DMA_STATUS_TX_RUNNING_WAITING_STATE \
+    (0b010 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
+#define NPCM_DMA_STATUS_TX_RUNNING_READ_STATE \
+    (0b011 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
+#define NPCM_DMA_STATUS_TX_SUSPENDED_STATE \
+    (0b110 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
+#define NPCM_DMA_STATUS_TX_RUNNING_CLOSING_STATE \
+    (0b111 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
+/* Transmit Process State */
+#define NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT 17
+/* Receive States */
+#define NPCM_DMA_STATUS_RX_STOPPED_STATE \
+    (0b000 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
+#define NPCM_DMA_STATUS_RX_RUNNING_FETCHING_STATE \
+    (0b001 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
+#define NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE \
+    (0b011 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
+#define NPCM_DMA_STATUS_RX_SUSPENDED_STATE \
+    (0b100 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
+#define NPCM_DMA_STATUS_RX_RUNNING_CLOSING_STATE \
+    (0b101 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
+#define NPCM_DMA_STATUS_RX_RUNNING_TRANSFERRING_STATE \
+    (0b111 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
+
+
+/* Early Receive Interrupt */
+#define NPCM_DMA_STATUS_ERI BIT(14)
+/* Fatal Bus Error Interrupt */
+#define NPCM_DMA_STATUS_FBI BIT(13)
+/* Early transmit Interrupt */
+#define NPCM_DMA_STATUS_ETI BIT(10)
+/* Receive Watchdog Timout */
+#define NPCM_DMA_STATUS_RWT BIT(9)
+/* Receive Process Stopped */
+#define NPCM_DMA_STATUS_RPS BIT(8)
+/* Receive Buffer Unavailable */
+#define NPCM_DMA_STATUS_RU BIT(7)
+/* Receive Interrupt */
+#define NPCM_DMA_STATUS_RI BIT(6)
+/* Transmit Underflow */
+#define NPCM_DMA_STATUS_UNF BIT(5)
+/* Receive Overflow */
+#define NPCM_DMA_STATUS_OVF BIT(4)
+/* Transmit Jabber Timeout */
+#define NPCM_DMA_STATUS_TJT BIT(3)
+/* Transmit Buffer Unavailable */
+#define NPCM_DMA_STATUS_TU BIT(2)
+/* Transmit Process Stopped */
+#define NPCM_DMA_STATUS_TPS BIT(1)
+/* Transmit Interrupt */
+#define NPCM_DMA_STATUS_TI BIT(0)
+
+/* Normal Interrupt Summary */
+#define NPCM_DMA_STATUS_NIS BIT(16)
+/* Interrupts enabled by NIE */
+#define NPCM_DMA_STATUS_NIS_BITS (NPCM_DMA_STATUS_TI | \
+                                  NPCM_DMA_STATUS_TU | \
+                                  NPCM_DMA_STATUS_RI | \
+                                  NPCM_DMA_STATUS_ERI)
+/* Abnormal Interrupt Summary */
+#define NPCM_DMA_STATUS_AIS BIT(15)
+/* Interrupts enabled by AIE */
+#define NPCM_DMA_STATUS_AIS_BITS (NPCM_DMA_STATUS_TPS | \
+                                  NPCM_DMA_STATUS_TJT | \
+                                  NPCM_DMA_STATUS_OVF | \
+                                  NPCM_DMA_STATUS_UNF | \
+                                  NPCM_DMA_STATUS_RU  | \
+                                  NPCM_DMA_STATUS_RPS | \
+                                  NPCM_DMA_STATUS_RWT | \
+                                  NPCM_DMA_STATUS_ETI | \
+                                  NPCM_DMA_STATUS_FBI)
+
+/* Early Receive Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_ERE BIT(14)
+/* Fatal Bus Error Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_FBE BIT(13)
+/* Early transmit Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_ETE BIT(10)
+/* Receive Watchdog Timout Enable */
+#define NPCM_DMA_INTR_ENAB_RWE BIT(9)
+/* Receive Process Stopped Enable */
+#define NPCM_DMA_INTR_ENAB_RSE BIT(8)
+/* Receive Buffer Unavailable Enable */
+#define NPCM_DMA_INTR_ENAB_RUE BIT(7)
+/* Receive Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_RIE BIT(6)
+/* Transmit Underflow Enable */
+#define NPCM_DMA_INTR_ENAB_UNE BIT(5)
+/* Receive Overflow Enable */
+#define NPCM_DMA_INTR_ENAB_OVE BIT(4)
+/* Transmit Jabber Timeout Enable */
+#define NPCM_DMA_INTR_ENAB_TJE BIT(3)
+/* Transmit Buffer Unavailable Enable */
+#define NPCM_DMA_INTR_ENAB_TUE BIT(2)
+/* Transmit Process Stopped Enable */
+#define NPCM_DMA_INTR_ENAB_TSE BIT(1)
+/* Transmit Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_TIE BIT(0)
+
+/* Normal Interrupt Summary Enable */
+#define NPCM_DMA_INTR_ENAB_NIE BIT(16)
+/* Interrupts enabled by NIE Enable */
+#define NPCM_DMA_INTR_ENAB_NIE_BITS (NPCM_DMA_INTR_ENAB_TIE | \
+                                     NPCM_DMA_INTR_ENAB_TUE | \
+                                     NPCM_DMA_INTR_ENAB_RIE | \
+                                     NPCM_DMA_INTR_ENAB_ERE)
+/* Abnormal Interrupt Summary Enable */
+#define NPCM_DMA_INTR_ENAB_AIE BIT(15)
+/* Interrupts enabled by AIE Enable */
+#define NPCM_DMA_INTR_ENAB_AIE_BITS (NPCM_DMA_INTR_ENAB_TSE | \
+                                     NPCM_DMA_INTR_ENAB_TJE | \
+                                     NPCM_DMA_INTR_ENAB_OVE | \
+                                     NPCM_DMA_INTR_ENAB_UNE | \
+                                     NPCM_DMA_INTR_ENAB_RUE | \
+                                     NPCM_DMA_INTR_ENAB_RSE | \
+                                     NPCM_DMA_INTR_ENAB_RWE | \
+                                     NPCM_DMA_INTR_ENAB_ETE | \
+                                     NPCM_DMA_INTR_ENAB_FBE)
+
+/* Flushing Disabled */
+#define NPCM_DMA_CONTROL_FLUSH_MASK BIT(24)
+/* Start/stop Transmit */
+#define NPCM_DMA_CONTROL_START_STOP_TX BIT(13)
+/* Next receive descriptor start address */
+#define NPCM_DMA_HOST_RX_DESC_MASK(word) ((uint32_t) (word) & ~3u)
+/* Next transmit descriptor start address */
+#define NPCM_DMA_HOST_TX_DESC_MASK(word) ((uint32_t) (word) & ~3u)
+
+/* Receive enable */
+#define NPCM_GMAC_MAC_CONFIG_RX_EN BIT(2)
+/* Transmit enable */
+#define NPCM_GMAC_MAC_CONFIG_TX_EN BIT(3)
+
+/* Frame Receive All */
+#define NPCM_GMAC_FRAME_FILTER_REC_ALL_MASK BIT(31)
+/* Frame HPF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_HPF_MASK BIT(10)
+/* Frame SAF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_SAF_MASK BIT(9)
+/* Frame SAIF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_SAIF_MASK BIT(8)
+/* Frame PCF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_PCF_MASK BIT(word) extract32((word), 6, 2)
+/* Frame DBF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_DBF_MASK BIT(5)
+/* Frame PM Filter*/
+#define NPCM_GMAC_FRAME_FILTER_PM_MASK BIT(4)
+/* Frame DAIF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_DAIF_MASK BIT(3)
+/* Frame HMC Filter*/
+#define NPCM_GMAC_FRAME_FILTER_HMC_MASK BIT(2)
+/* Frame HUC Filter*/
+#define NPCM_GMAC_FRAME_FILTER_HUC_MASK BIT(1)
+/* Frame PR Filter*/
+#define NPCM_GMAC_FRAME_FILTER_PR_MASK BIT(0)
+
 #endif /* NPCM_GMAC_H */
-- 
2.42.0.655.g421f12c284-goog


