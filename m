Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB0C7A3403
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 08:59:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhlji-0006tZ-0a; Sun, 17 Sep 2023 02:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljf-0006tG-P9
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 02:58:27 -0400
Received: from mailout05.t-online.de ([194.25.134.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljd-00051i-9c
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 02:58:27 -0400
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
 by mailout05.t-online.de (Postfix) with SMTP id D3D7824592;
 Sun, 17 Sep 2023 08:58:23 +0200 (CEST)
Received: from linpower.localnet ([79.208.31.89]) by fwd86.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qhljb-3yMzkv0; Sun, 17 Sep 2023 08:58:23 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id A05FB200206; Sun, 17 Sep 2023 08:58:13 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: [PATCH 5/8] hw/audio/es1370: remove #ifdef ES1370_VERBOSE to avoid
 bit rot
Date: Sun, 17 Sep 2023 08:58:10 +0200
Message-Id: <20230917065813.6692-5-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
References: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1694933903-0592EEBC-B24C16C2/0/0 CLEAN NORMAL
X-TOI-MSGID: 9609e484-8de7-44a1-8e60-a73e49094292
Received-SPF: none client-ip=194.25.134.82;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout05.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Replace the #ifdef ES1370_VERBOSE code with code that the compiler
can optimize away to avoid bit rot and fix the already rotten code.

Tested-by: Rene Engel <ReneEngel80@emailn.de>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/es1370.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 839689bcb3..e1ca6a4cd5 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -23,7 +23,7 @@
  */
 
 #define DEBUG_ES1370 0
-/* #define VERBOSE_ES1370 */
+#define VERBOSE_ES1370 0
 
 #include "qemu/osdep.h"
 #include "hw/audio/soundhw.h"
@@ -238,11 +238,12 @@ static void print_sctl(uint32_t val)
     }
 }
 
-#ifdef VERBOSE_ES1370
-#define lwarn(...) AUD_log ("es1370: warning", __VA_ARGS__)
-#else
-#define lwarn(...)
-#endif
+#define lwarn(...) \
+do { \
+    if (VERBOSE_ES1370) { \
+        AUD_log("es1370: warning", __VA_ARGS__); \
+    } \
+} while (0)
 
 #define TYPE_ES1370 "ES1370"
 OBJECT_DECLARE_SIMPLE_TYPE(ES1370State, ES1370)
@@ -504,10 +505,10 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         break;
 
     case ES1370_REG_PHANTOM_FRAMECNT:
-        lwarn ("writing to phantom frame count %#x\n", val);
+        lwarn("writing to phantom frame count 0x%" PRIx64 "\n", val);
         break;
     case ES1370_REG_PHANTOM_FRAMEADR:
-        lwarn ("writing to phantom frame address %#x\n", val);
+        lwarn("writing to phantom frame address 0x%" PRIx64 "\n", val);
         break;
 
     case ES1370_REG_ADC_FRAMECNT:
@@ -524,7 +525,7 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         break;
 
     default:
-        lwarn ("writel %#x <- %#x\n", addr, val);
+        lwarn("writel 0x%" PRIx64 " <- 0x%" PRIx64 "\n", addr, val);
         break;
     }
 }
@@ -588,16 +589,16 @@ static uint64_t es1370_read(void *opaque, hwaddr addr, unsigned size)
 
     case ES1370_REG_PHANTOM_FRAMECNT:
         val = ~0U;
-        lwarn ("reading from phantom frame count\n");
+        lwarn("reading from phantom frame count\n");
         break;
     case ES1370_REG_PHANTOM_FRAMEADR:
         val = ~0U;
-        lwarn ("reading from phantom frame address\n");
+        lwarn("reading from phantom frame address\n");
         break;
 
     default:
         val = ~0U;
-        lwarn ("readl %#x -> %#x\n", addr, val);
+        lwarn("readl 0x%" PRIx64 " -> 0x%x\n", addr, val);
         break;
     }
     return val;
-- 
2.35.3


