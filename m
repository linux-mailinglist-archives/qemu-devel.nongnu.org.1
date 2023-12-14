Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DF8813C7F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 22:19:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDt41-0002hs-7y; Thu, 14 Dec 2023 16:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hHB7ZQwKCoUwjkrqn12nojwpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--nabihestefan.bounces.google.com>)
 id 1rDt3o-0002bh-5D
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 16:16:00 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hHB7ZQwKCoUwjkrqn12nojwpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--nabihestefan.bounces.google.com>)
 id 1rDt3e-0005xX-Kx
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 16:15:59 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5ca2e530041so101061567b3.3
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 13:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702588548; x=1703193348; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lo1vB+vQUuCSw6PYQvfs4XlI6Sw1MCeih84R5KkRUZA=;
 b=qXfEMbvL2c4lFd4kciyrxQUm4ofIr/625gjBlK6XcBMbaJc07gcOK2cL2QlmN4RPQo
 1bebAOplvjeLXPuVaesfLiTGFisEJdWpVPX2o1lbXX3xDYFzMuTiN9Z5X2qEExX8Fal0
 b/9cjMVFddhE1TLZxy1FYtUl8oejjmqMAN6vrSjAL+Dd8n/OE4IoSfIv8szkXww1kABg
 nbZlhaWDAdS3lET5c30WAcfRvNpK0DTAfO6n+fKCBEkMh/nPRueReIYimQzWhKBX718X
 nOpk+2LPrtD6RkVnuU7Xknemv9+o/tyN0mosYpCJEC4WC+6mfkdkGiPxEppELRCQIA0X
 n3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702588548; x=1703193348;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lo1vB+vQUuCSw6PYQvfs4XlI6Sw1MCeih84R5KkRUZA=;
 b=gfzu1s5Uc2C6UPVS1IF0DZhhM5kyvrqaAH+lDkzqVqIy7cTdPqX8LrjvC1BpuUvxvB
 yJBukC+iz6BA09M/OM5WwJaQ9nv9RyWuyOPjejtS/NirBJV9TwtrDYyQ+hLW6A5kq/LW
 6OoBL46kpBWtADMex4xs5ykwLOslfZYs1AjCMzmdJ3UdcX08sltYd2LvvilrFHMwyL+S
 QrKMrQU/qtA716cE0tP/zvnL0u1iieyID36YOtqN/RPHHHfyReo0uK7z5pDTP1N0JpGp
 AauQM9jRABHevj0maMAd3VfdoXByB1Q0W1iL3EJxALa4ywGU1lySV0Pk7czevln7dlLX
 iR+Q==
X-Gm-Message-State: AOJu0YzQ5NThB0JrK7pFYwrKklJO1VR2hKuiBII3xx0SIG5kJYlS+bzw
 wzYadBLUN9L+nhwNUQ6Icipg/nnzTjK6p3x3XTw=
X-Google-Smtp-Source: AGHT+IGJZOaPqLx8L5Di6IDrCmOYFo4ydHyyZzVzvM4O+lgbzBIfzd3Zhm5PJT4OyDGWBZiGk345EYdX5vwQythCNIU=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:690c:d08:b0:5cd:c47d:d89a with
 SMTP id cn8-20020a05690c0d0800b005cdc47dd89amr122164ywb.2.1702588548102; Thu,
 14 Dec 2023 13:15:48 -0800 (PST)
Date: Thu, 14 Dec 2023 21:15:27 +0000
In-Reply-To: <20231214211527.1946302-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20231214211527.1946302-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214211527.1946302-12-nabihestefan@google.com>
Subject: [PATCH v8 11/11] tests/qtest: Adding PCS Module test to GMAC Qtest
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3hHB7ZQwKCoUwjkrqn12nojwpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UPPERCASE_50_75=0.008,
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

 - Add PCS Register check to npcm_gmac-test

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 tests/qtest/npcm_gmac-test.c | 134 ++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
index 130a1599a8..0958b13814 100644
--- a/tests/qtest/npcm_gmac-test.c
+++ b/tests/qtest/npcm_gmac-test.c
@@ -20,6 +20,10 @@
 /* Name of the GMAC Device */
 #define TYPE_NPCM_GMAC "npcm-gmac"
 
+/* Address of the PCS Module */
+#define PCS_BASE_ADDRESS 0xf0780000
+#define NPCM_PCS_IND_AC_BA 0x1fe
+
 typedef struct GMACModule {
     int irq;
     uint64_t base_addr;
@@ -111,6 +115,62 @@ typedef enum NPCMRegister {
     NPCM_GMAC_PTP_STNSUR = 0x714,
     NPCM_GMAC_PTP_TAR = 0x718,
     NPCM_GMAC_PTP_TTSR = 0x71c,
+
+    /* PCS Registers */
+    NPCM_PCS_SR_CTL_ID1 = 0x3c0008,
+    NPCM_PCS_SR_CTL_ID2 = 0x3c000a,
+    NPCM_PCS_SR_CTL_STS = 0x3c0010,
+
+    NPCM_PCS_SR_MII_CTRL = 0x3e0000,
+    NPCM_PCS_SR_MII_STS = 0x3e0002,
+    NPCM_PCS_SR_MII_DEV_ID1 = 0x3e0004,
+    NPCM_PCS_SR_MII_DEV_ID2 = 0x3e0006,
+    NPCM_PCS_SR_MII_AN_ADV = 0x3e0008,
+    NPCM_PCS_SR_MII_LP_BABL = 0x3e000a,
+    NPCM_PCS_SR_MII_AN_EXPN = 0x3e000c,
+    NPCM_PCS_SR_MII_EXT_STS = 0x3e001e,
+
+    NPCM_PCS_SR_TIM_SYNC_ABL = 0x3e0e10,
+    NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_LWR = 0x3e0e12,
+    NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_UPR = 0x3e0e14,
+    NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_LWR = 0x3e0e16,
+    NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_UPR = 0x3e0e18,
+    NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_LWR = 0x3e0e1a,
+    NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_UPR = 0x3e0e1c,
+    NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_LWR = 0x3e0e1e,
+    NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_UPR = 0x3e0e20,
+
+    NPCM_PCS_VR_MII_MMD_DIG_CTRL1 = 0x3f0000,
+    NPCM_PCS_VR_MII_AN_CTRL = 0x3f0002,
+    NPCM_PCS_VR_MII_AN_INTR_STS = 0x3f0004,
+    NPCM_PCS_VR_MII_TC = 0x3f0006,
+    NPCM_PCS_VR_MII_DBG_CTRL = 0x3f000a,
+    NPCM_PCS_VR_MII_EEE_MCTRL0 = 0x3f000c,
+    NPCM_PCS_VR_MII_EEE_TXTIMER = 0x3f0010,
+    NPCM_PCS_VR_MII_EEE_RXTIMER = 0x3f0012,
+    NPCM_PCS_VR_MII_LINK_TIMER_CTRL = 0x3f0014,
+    NPCM_PCS_VR_MII_EEE_MCTRL1 = 0x3f0016,
+    NPCM_PCS_VR_MII_DIG_STS = 0x3f0020,
+    NPCM_PCS_VR_MII_ICG_ERRCNT1 = 0x3f0022,
+    NPCM_PCS_VR_MII_MISC_STS = 0x3f0030,
+    NPCM_PCS_VR_MII_RX_LSTS = 0x3f0040,
+    NPCM_PCS_VR_MII_MP_TX_BSTCTRL0 = 0x3f0070,
+    NPCM_PCS_VR_MII_MP_TX_LVLCTRL0 = 0x3f0074,
+    NPCM_PCS_VR_MII_MP_TX_GENCTRL0 = 0x3f007a,
+    NPCM_PCS_VR_MII_MP_TX_GENCTRL1 = 0x3f007c,
+    NPCM_PCS_VR_MII_MP_TX_STS = 0x3f0090,
+    NPCM_PCS_VR_MII_MP_RX_GENCTRL0 = 0x3f00b0,
+    NPCM_PCS_VR_MII_MP_RX_GENCTRL1 = 0x3f00b2,
+    NPCM_PCS_VR_MII_MP_RX_LOS_CTRL0 = 0x3f00ba,
+    NPCM_PCS_VR_MII_MP_MPLL_CTRL0 = 0x3f00f0,
+    NPCM_PCS_VR_MII_MP_MPLL_CTRL1 = 0x3f00f2,
+    NPCM_PCS_VR_MII_MP_MPLL_STS = 0x3f0110,
+    NPCM_PCS_VR_MII_MP_MISC_CTRL2 = 0x3f0126,
+    NPCM_PCS_VR_MII_MP_LVL_CTRL = 0x3f0130,
+    NPCM_PCS_VR_MII_MP_MISC_CTRL0 = 0x3f0132,
+    NPCM_PCS_VR_MII_MP_MISC_CTRL1 = 0x3f0134,
+    NPCM_PCS_VR_MII_DIG_CTRL2 = 0x3f01c2,
+    NPCM_PCS_VR_MII_DIG_ERRCNT_SEL = 0x3f01c4,
 } NPCMRegister;
 
 static uint32_t gmac_read(QTestState *qts, const GMACModule *mod,
@@ -119,6 +179,15 @@ static uint32_t gmac_read(QTestState *qts, const GMACModule *mod,
     return qtest_readl(qts, mod->base_addr + regno);
 }
 
+static uint16_t pcs_read(QTestState *qts, const GMACModule *mod,
+                          NPCMRegister regno)
+{
+    uint32_t write_value = (regno & 0x3ffe00) >> 9;
+    qtest_writel(qts, PCS_BASE_ADDRESS + NPCM_PCS_IND_AC_BA, write_value);
+    uint32_t read_offset = regno & 0x1ff;
+    return qtest_readl(qts, PCS_BASE_ADDRESS + read_offset);
+}
+
 /* Check that GMAC registers are reset to default value */
 static void test_init(gconstpointer test_data)
 {
@@ -129,7 +198,12 @@ static void test_init(gconstpointer test_data)
 #define CHECK_REG32(regno, value) \
     do { \
         g_assert_cmphex(gmac_read(qts, mod, (regno)), ==, (value)); \
-    } while (0)
+    } while (0) ;
+
+#define CHECK_REG_PCS(regno, value) \
+    do { \
+        g_assert_cmphex(pcs_read(qts, mod, (regno)), ==, (value)); \
+    } while (0) ;
 
     CHECK_REG32(NPCM_DMA_BUS_MODE, 0x00020100);
     CHECK_REG32(NPCM_DMA_XMT_POLL_DEMAND, 0);
@@ -180,6 +254,64 @@ static void test_init(gconstpointer test_data)
     CHECK_REG32(NPCM_GMAC_PTP_TAR, 0);
     CHECK_REG32(NPCM_GMAC_PTP_TTSR, 0);
 
+    /* TODO Add registers PCS */
+    if (mod->base_addr == 0xf0802000) {
+        CHECK_REG_PCS(NPCM_PCS_SR_CTL_ID1, 0x699e)
+        CHECK_REG_PCS(NPCM_PCS_SR_CTL_ID2, 0)
+        CHECK_REG_PCS(NPCM_PCS_SR_CTL_STS, 0x8000)
+
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_CTRL, 0x1140)
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_STS, 0x0109)
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_DEV_ID1, 0x699e)
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_DEV_ID2, 0x0ced0)
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_AN_ADV, 0x0020)
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_LP_BABL, 0)
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_AN_EXPN, 0)
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_EXT_STS, 0xc000)
+
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_ABL, 0x0003)
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_LWR, 0x0038)
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_UPR, 0)
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_LWR, 0x0038)
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_UPR, 0)
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_LWR, 0x0058)
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_UPR, 0)
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_LWR, 0x0048)
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_UPR, 0)
+
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MMD_DIG_CTRL1, 0x2400)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_AN_CTRL, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_AN_INTR_STS, 0x000a)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_TC, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_DBG_CTRL, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_MCTRL0, 0x899c)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_TXTIMER, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_RXTIMER, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_LINK_TIMER_CTRL, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_MCTRL1, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_STS, 0x0010)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_ICG_ERRCNT1, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MISC_STS, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_RX_LSTS, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_BSTCTRL0, 0x00a)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_LVLCTRL0, 0x007f)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_GENCTRL0, 0x0001)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_GENCTRL1, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_STS, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_GENCTRL0, 0x0100)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_GENCTRL1, 0x1100)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_LOS_CTRL0, 0x000e)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_CTRL0, 0x0100)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_CTRL1, 0x0032)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_STS, 0x0001)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL2, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_LVL_CTRL, 0x0019)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL0, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL1, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_CTRL2, 0)
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_ERRCNT_SEL, 0)
+    }
+
     qtest_quit(qts);
 }
 
-- 
2.43.0.472.g3155946c3a-goog


