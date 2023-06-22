Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B507398C7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:59:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBL-0004y7-9d; Thu, 22 Jun 2023 03:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAj-00048b-98
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:05 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-0002uo-DW
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:04 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N8XDT-1pyVqw1PIv-014RC6; Thu, 22
 Jun 2023 09:55:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 24/24] mac_via: fix rtc command decoding for the PRAM seconds
 registers
Date: Thu, 22 Jun 2023 09:55:44 +0200
Message-Id: <20230622075544.210899-25-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4BncvCbkfznm9DbU91w+DqND9gdV6sjJwgfy6YGgWVzQ66x+xtx
 aaZUGRxU28NiosMeDBqPQrGjqIJhfJFT5ezipfbH5puOlL6nBRVb7YB8lAON0beg7EOyyR3
 Mxr5PA0un4u5ZNhiQ+D196gwRmSAYFGY7v4KeCR3ZxsxFdP0vW+Uhct71OW54oGt/ouSgGx
 Ycz/eRdTTIeswh9vmEhOA==
UI-OutboundReport: notjunk:1;M01:P0:UybWCMW1myU=;N/I7K0LaYolsmpx6m7VfWc8asFZ
 pAVqMJOvG+5qBCb9XyU1Z543QFaYCPtG+h7MKqlNPd808mPPfZqrWlNj7hbt8+4YuEW86pkU5
 qgfBlqNhR1GzWe+0WQ/RqOs3TCfpPgp0+oK9o9YGfsSCiceymqqGY7jeEjBxXoy7ua7VTIsBG
 pGrO92u8uASDtiuvDFtrxeBam8zIR/YD6CaXIA38qskJecXsH3ylRF7g18ppImv4j3g/FNDK0
 RJGPu37ofa7hboN4rjFpZLGyeq0k1ijQAhykHmj8fu/amj3QOy7qQIOpUs58Xag2BZLRVZiap
 s//oENkJSzFz1+nhaMZ1SeM6lKx45c/ufwAgCjRhGD9iGS1r4thT8GXXBxFz/1ktxJo/QmsGH
 /Bv0dK4HQVPmhrFvB67aL/JBnSLQCJc6l8aOOGTezaQpIUF5e+EuOQdQE3MS1E2nnoKkJRp+n
 S2P260cPqgGhvQCw68WOSJzBXhyCSk9SNwGcKtGOXr6el+PHndqMWv0dl9dVpct/R8grpmY5f
 6oSzwfsv80qXJBUrGQgkQtvU9wxpsOszOyh9+QRRBa+G4GNFrgZn0CWTo752c/IBI2mwcBEou
 8xcFK/VeG46t8pyfwaCGO2m/KDZJmcGYNNbKenXrWdjFMwqU1DeqtS7/QtS9yuvmLOU3xVmGO
 PDalvAlAaX0SyEgId0zwGWFHav36vUvO8NQP2XroHg==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Analysis of the MacOS toolbox ROM code shows that on startup it attempts 2
separate reads of the seconds registers with commands 0x9d...0x91 followed by
0x8d..0x81 without resetting the command to its initial value. The PRAM seconds
value is only accepted when the values of the 2 separate reads match.

From this we conclude that bit 4 of the rtc command is not decoded or we don't
care about its value when reading the PRAM seconds registers. Implement this
decoding change so that both reads return successfully which allows the MacOS
toolbox ROM to correctly set the date/time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-25-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 85c2e65856eb..0787a0268d17 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -362,10 +362,10 @@ static void pram_update(MOS6522Q800VIA1State *v1s)
  *
  * Command byte    Register addressed by the command
  *
- * z0000001        Seconds register 0 (lowest-order byte)
- * z0000101        Seconds register 1
- * z0001001        Seconds register 2
- * z0001101        Seconds register 3 (highest-order byte)
+ * z00x0001        Seconds register 0 (lowest-order byte)
+ * z00x0101        Seconds register 1
+ * z00x1001        Seconds register 2
+ * z00x1101        Seconds register 3 (highest-order byte)
  * 00110001        Test register (write-only)
  * 00110101        Write-Protect Register (write-only)
  * z010aa01        RAM address 100aa ($10-$13) (first 20 bytes only)
@@ -373,6 +373,7 @@ static void pram_update(MOS6522Q800VIA1State *v1s)
  * z0111aaa        Extended memory designator and sector number
  *
  * For a read request, z=1, for a write z=0
+ * The letter x indicates don't care
  * The letter a indicates bits whose value depend on what parameter
  * RAM byte you want to address
  */
@@ -389,7 +390,7 @@ static int via1_rtc_compact_cmd(uint8_t value)
     }
     if ((value & 0x03) == 0x01) {
         value >>= 2;
-        if ((value & 0x1c) == 0) {
+        if ((value & 0x18) == 0) {
             /* seconds registers */
             return read | (REG_0 + (value & 0x03));
         } else if ((value == 0x0c) && !read) {
-- 
2.40.1


