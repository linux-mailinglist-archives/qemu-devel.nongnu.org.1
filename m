Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997D7398C8
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:59:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBM-00050F-4N; Thu, 22 Jun 2023 03:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAi-00047Z-EN
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-0002uf-8f
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:04 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N7hrw-1pyEbU3kUE-014iRV; Thu, 22
 Jun 2023 09:55:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 23/24] mac_via: fix rtc command decoding from PRAM addresses
 0x0 to 0xf
Date: Thu, 22 Jun 2023 09:55:43 +0200
Message-Id: <20230622075544.210899-24-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WCC7T8vamM0a2uaJmYGUKbFceEHpPDboH6flQamr6OnhGlXgQst
 ecT3kfMI46NSGnqbEcuGUlY8k/4wOZWWvF8Nks9bPQtdST/Uh5li/nTSHG3rBnOsK/3wh/t
 uBhIJJbeC73uLJj9iQnr8QF0p1RrDjvdwQv6iMK3J4uWJDSH4mHlpRkXTMnT6lUpeyDPxeh
 Q2znceowZYA3Mj0DgsVow==
UI-OutboundReport: notjunk:1;M01:P0:4GMdWnlneqs=;B9bCbCxnMmg9x4POnxRC+2eF+6m
 kFgf5CP1aMMBIMn4NYkQ+BMpB4s9231BOjUMrachs8A4Esbcv8QEtZDePMFtCfOIv2JRLY1rG
 SAKVVh/vOixoOp+tHPXpkBG7cae+Iv3PlLrF5+StvR6s9aQ9r1mF2kSLpgvG6DYdFXpCYiGvc
 bw+yes/rap0Mo+Jm4cUzvkksj0T04qQMa4NP2mYDO5fc6QENvEazTK8/f4KkglkIIwsf58S0G
 Dh01Djlwg4AELjrbZAsqq0pldQQZyGj5Hjm3YJ3Q+Y9SsIBnBZAMD2WKD37rtWZAgp4ZbsTvT
 DTlzzIkxwUDJugZ9TfkZTsQNznff+nV21XbY7Tqee17ExHN9sisWaJjU9FMrm4RbhZuIE1nIr
 a5cBwU+EpUtVTdklr1RIx9FvXiOcdE7bTR7mOVAPwIBPY9oml26O5WNyKfJ0tvt4HygefehMV
 er2Szvc56QZAbaTz0h7j/q6fX8oQ0fAxALOu3QAzjZwl8H1Kvw2HMS2Hi7RN99Ww7OV4ByXYb
 3flndNw+7zcS8IkZhUCbPR3lPNELSo+InMH1f7mJqpAh4RsKDzZT8TLfoQmIqCf6Ub13hqF0y
 hAbTCLNu4dUUclnvNzcO9FDwyhFfAMhMutjthycRwWGIW/D2bdPU1slHb7vu8v/eh7iKPHrUM
 443LqnWSPBJ2etvwZjtN4lke460xZbO9iTjDJ72Tzg==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

A comparison between the rtc command table included in the comment and the code
itself shows that the decoding for PRAM addresses 0x0 to 0xf is being done on
the raw command, and not the shifted version held in value.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-24-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 076d18e5fd9f..85c2e65856eb 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -399,7 +399,7 @@ static int via1_rtc_compact_cmd(uint8_t value)
         } else if ((value & 0x1c) == 0x08) {
             /* RAM address 0x10 to 0x13 */
             return read | (REG_PRAM_ADDR + 0x10 + (value & 0x03));
-        } else if ((value & 0x43) == 0x41) {
+        } else if ((value & 0x10) == 0x10) {
             /* RAM address 0x00 to 0x0f */
             return read | (REG_PRAM_ADDR + (value & 0x0f));
         }
-- 
2.40.1


