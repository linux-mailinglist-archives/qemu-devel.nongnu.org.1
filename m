Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3798B7D1D0D
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 14:09:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quAjo-00032O-3x; Sat, 21 Oct 2023 08:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1quAjY-00030F-UI; Sat, 21 Oct 2023 08:05:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1quAjX-0000zV-2A; Sat, 21 Oct 2023 08:05:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 94A012C330;
 Sat, 21 Oct 2023 15:05:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3AA3F3067E;
 Sat, 21 Oct 2023 15:05:26 +0300 (MSK)
Received: (nullmailer pid 220781 invoked by uid 1000);
 Sat, 21 Oct 2023 12:05:25 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 02/17] hw/ppc/ppc440_uc: Remove dead l2sram_update_mappings()
Date: Sat, 21 Oct 2023 15:05:04 +0300
Message-Id: <20231021120519.220720-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021120519.220720-1-mjt@tls.msk.ru>
References: <20231021120519.220720-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Apparently l2sram_update_mappings() bit-rotted over time,
when defining MAP_L2SRAM we get:

  hw/ppc/ppc440_uc.c:83:17: error: no member named 'isarc' in 'struct ppc4xx_l2sram_t'
      if (l2sram->isarc != isarc ||
          ~~~~~~  ^
  hw/ppc/ppc440_uc.c:84:18: error: no member named 'isacntl' in 'struct ppc4xx_l2sram_t'
          (l2sram->isacntl & 0x80000000) != (isacntl & 0x80000000)) {
           ~~~~~~  ^
  hw/ppc/ppc440_uc.c:85:21: error: no member named 'isacntl' in 'struct ppc4xx_l2sram_t'
          if (l2sram->isacntl & 0x80000000) {
              ~~~~~~  ^
  hw/ppc/ppc440_uc.c:88:50: error: no member named 'isarc_ram' in 'struct ppc4xx_l2sram_t'
                                          &l2sram->isarc_ram);
                                           ~~~~~~  ^
  hw/ppc/ppc440_uc.c:93:50: error: no member named 'isarc_ram' in 'struct ppc4xx_l2sram_t'
                                          &l2sram->isarc_ram);
                                           ~~~~~~  ^
  hw/ppc/ppc440_uc.c:96:17: error: no member named 'dsarc' in 'struct ppc4xx_l2sram_t'
      if (l2sram->dsarc != dsarc ||
          ~~~~~~  ^
  hw/ppc/ppc440_uc.c:97:18: error: no member named 'dsacntl' in 'struct ppc4xx_l2sram_t'
          (l2sram->dsacntl & 0x80000000) != (dsacntl & 0x80000000)) {
           ~~~~~~  ^
  hw/ppc/ppc440_uc.c:98:21: error: no member named 'dsacntl' in 'struct ppc4xx_l2sram_t'
          if (l2sram->dsacntl & 0x80000000) {
              ~~~~~~  ^
  hw/ppc/ppc440_uc.c:100:52: error: no member named 'dsarc' in 'struct ppc4xx_l2sram_t'
              if (!(isacntl & 0x80000000) || l2sram->dsarc != isarc) {
                                             ~~~~~~  ^
  hw/ppc/ppc440_uc.c:103:54: error: no member named 'dsarc_ram' in 'struct ppc4xx_l2sram_t'
                                              &l2sram->dsarc_ram);
                                               ~~~~~~  ^
  hw/ppc/ppc440_uc.c:111:54: error: no member named 'dsarc_ram' in 'struct ppc4xx_l2sram_t'
                                              &l2sram->dsarc_ram);
                                               ~~~~~~  ^

Remove that dead code.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/ppc/ppc440_uc.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 4181c843a8..7d6ca70387 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -73,46 +73,6 @@ typedef struct ppc4xx_l2sram_t {
     uint32_t isram0[11];
 } ppc4xx_l2sram_t;
 
-#ifdef MAP_L2SRAM
-static void l2sram_update_mappings(ppc4xx_l2sram_t *l2sram,
-                                   uint32_t isarc, uint32_t isacntl,
-                                   uint32_t dsarc, uint32_t dsacntl)
-{
-    if (l2sram->isarc != isarc ||
-        (l2sram->isacntl & 0x80000000) != (isacntl & 0x80000000)) {
-        if (l2sram->isacntl & 0x80000000) {
-            /* Unmap previously assigned memory region */
-            memory_region_del_subregion(get_system_memory(),
-                                        &l2sram->isarc_ram);
-        }
-        if (isacntl & 0x80000000) {
-            /* Map new instruction memory region */
-            memory_region_add_subregion(get_system_memory(), isarc,
-                                        &l2sram->isarc_ram);
-        }
-    }
-    if (l2sram->dsarc != dsarc ||
-        (l2sram->dsacntl & 0x80000000) != (dsacntl & 0x80000000)) {
-        if (l2sram->dsacntl & 0x80000000) {
-            /* Beware not to unmap the region we just mapped */
-            if (!(isacntl & 0x80000000) || l2sram->dsarc != isarc) {
-                /* Unmap previously assigned memory region */
-                memory_region_del_subregion(get_system_memory(),
-                                            &l2sram->dsarc_ram);
-            }
-        }
-        if (dsacntl & 0x80000000) {
-            /* Beware not to remap the region we just mapped */
-            if (!(isacntl & 0x80000000) || dsarc != isarc) {
-                /* Map new data memory region */
-                memory_region_add_subregion(get_system_memory(), dsarc,
-                                            &l2sram->dsarc_ram);
-            }
-        }
-    }
-}
-#endif
-
 static uint32_t dcr_read_l2sram(void *opaque, int dcrn)
 {
     ppc4xx_l2sram_t *l2sram = opaque;
@@ -193,7 +153,6 @@ static void dcr_write_l2sram(void *opaque, int dcrn, uint32_t val)
         /*l2sram->isram1[dcrn - DCR_L2CACHE_BASE] = val;*/
         break;
     }
-    /*l2sram_update_mappings(l2sram, isarc, isacntl, dsarc, dsacntl);*/
 }
 
 static void l2sram_reset(void *opaque)
@@ -203,7 +162,6 @@ static void l2sram_reset(void *opaque)
     memset(l2sram->l2cache, 0, sizeof(l2sram->l2cache));
     l2sram->l2cache[DCR_L2CACHE_STAT - DCR_L2CACHE_BASE] = 0x80000000;
     memset(l2sram->isram0, 0, sizeof(l2sram->isram0));
-    /*l2sram_update_mappings(l2sram, isarc, isacntl, dsarc, dsacntl);*/
 }
 
 void ppc4xx_l2sram_init(CPUPPCState *env)
-- 
2.39.2


