Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E8797D72
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 22:36:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeLig-0008MB-7W; Thu, 07 Sep 2023 16:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeLid-0008Lv-E1; Thu, 07 Sep 2023 16:35:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeLiU-0002ab-BN; Thu, 07 Sep 2023 16:35:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 439521FE32;
 Thu,  7 Sep 2023 23:35:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 51E5E26703;
 Thu,  7 Sep 2023 23:35:01 +0300 (MSK)
Received: (nullmailer pid 257860 invoked by uid 1000);
 Thu, 07 Sep 2023 20:35:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] hw/display/xlnx_dp: update comments
Date: Thu,  7 Sep 2023 23:34:40 +0300
Message-Id: <20230907203440.257845-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Peter Maydell <peter.maydell@linaro.org>

Clarify somewhat misleading code comments.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/display/xlnx_dp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

Peter, this is the result of your suggestions in this area.
Since it's entirely your wording, can I specify your
authorship too?

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 822355ecc6..300daf9d9b 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1,4 +1,4 @@
-/*
+?*
  * Xilinx Display Port
  *
  *  Copyright (C) 2015 : GreenSocs Ltd
@@ -380,13 +380,16 @@ static inline void xlnx_dp_audio_mix_buffer(XlnxDPState *s)
 static void xlnx_dp_audio_callback(void *opaque, int avail)
 {
     /*
-     * Get some data from the DPDMA and compute these data.
-     * Then wait for QEMU's audio subsystem to call this callback.
+     * Get the individual left and right audio streams from the DPDMA,
+     * and fill the output buffer with the combined stereo audio data
+     * adjusted by the volume controls.
+     * QEMU's audio subsystem will call this callback repeatedly;
+     * we return the data from the output buffer until it is emptied,
+     * and then we will read data from the DPDMA again.
      */
     XlnxDPState *s = XLNX_DP(opaque);
     size_t written = 0;
 
-    /* If there are already some data don't get more data. */
     if (s->byte_left == 0) {
         s->audio_data_available[0] = xlnx_dpdma_start_operation(s->dpdma, 4,
                                                                   true);
-- 
2.39.2


