Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5752F7A3402
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 08:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhljk-0006uN-6Q; Sun, 17 Sep 2023 02:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljf-0006t3-Fy
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 02:58:27 -0400
Received: from mailout01.t-online.de ([194.25.134.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljd-00051C-2Y
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 02:58:26 -0400
Received: from fwd76.aul.t-online.de (fwd76.aul.t-online.de [10.223.144.102])
 by mailout01.t-online.de (Postfix) with SMTP id D395F35709;
 Sun, 17 Sep 2023 08:58:21 +0200 (CEST)
Received: from linpower.localnet ([79.208.31.89]) by fwd76.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qhljZ-3qw7mr0; Sun, 17 Sep 2023 08:58:21 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 9D61B200205; Sun, 17 Sep 2023 08:58:13 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: [PATCH 4/8] hw/audio/es1370: remove #ifdef ES1370_DEBUG to avoid bit
 rot
Date: Sun, 17 Sep 2023 08:58:09 +0200
Message-Id: <20230917065813.6692-4-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
References: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1694933901-27FFE5E3-3EE6DCB5/0/0 CLEAN NORMAL
X-TOI-MSGID: e290478b-d9c4-4b85-bb40-567dc2f93ca7
Received-SPF: none client-ip=194.25.134.80;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout01.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Replace the #ifdef ES1370_DEBUG code with code that the compiler
can optimize away to avoid bit rot. While at it, replace strcat()
with pstrcat().

Tested-by: Rene Engel <ReneEngel80@emailn.de>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/es1370.c | 135 +++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 69 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index f66feb5bb0..839689bcb3 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 
-/* #define DEBUG_ES1370 */
+#define DEBUG_ES1370 0
 /* #define VERBOSE_ES1370 */
 
 #include "qemu/osdep.h"
@@ -30,6 +30,7 @@
 #include "audio/audio.h"
 #include "hw/pci/pci_device.h"
 #include "migration/vmstate.h"
+#include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
 #include "qom/object.h"
@@ -164,82 +165,78 @@ static void es1370_dac1_callback (void *opaque, int free);
 static void es1370_dac2_callback (void *opaque, int free);
 static void es1370_adc_callback (void *opaque, int avail);
 
-#ifdef DEBUG_ES1370
-
-static void print_ctl (uint32_t val)
+static void print_ctl(uint32_t val)
 {
-    char buf[1024];
-
-    buf[0] = '\0';
-#define a(n) if (val & CTRL_##n) strcat (buf, " "#n)
-    a (ADC_STOP);
-    a (XCTL1);
-    a (OPEN);
-    a (MSFMTSEL);
-    a (M_SBB);
-    a (DAC_SYNC);
-    a (CCB_INTRM);
-    a (M_CB);
-    a (XCTL0);
-    a (BREQ);
-    a (DAC1_EN);
-    a (DAC2_EN);
-    a (ADC_EN);
-    a (UART_EN);
-    a (JYSTK_EN);
-    a (CDC_EN);
-    a (SERR_DIS);
+    if (DEBUG_ES1370) {
+        char buf[1024];
+
+        buf[0] = '\0';
+#define a(n) if (val & CTRL_##n) pstrcat(buf, sizeof(buf), " "#n)
+        a(ADC_STOP);
+        a(XCTL1);
+        a(OPEN);
+        a(MSFMTSEL);
+        a(M_SBB);
+        a(DAC_SYNC);
+        a(CCB_INTRM);
+        a(M_CB);
+        a(XCTL0);
+        a(BREQ);
+        a(DAC1_EN);
+        a(DAC2_EN);
+        a(ADC_EN);
+        a(UART_EN);
+        a(JYSTK_EN);
+        a(CDC_EN);
+        a(SERR_DIS);
 #undef a
-    AUD_log ("es1370", "ctl - PCLKDIV %d(DAC2 freq %d), freq %d,%s\n",
-             (val & CTRL_PCLKDIV) >> CTRL_SH_PCLKDIV,
-             DAC2_DIVTOSR ((val & CTRL_PCLKDIV) >> CTRL_SH_PCLKDIV),
-             dac1_samplerate[(val & CTRL_WTSRSEL) >> CTRL_SH_WTSRSEL],
-             buf);
+        AUD_log("es1370", "ctl - PCLKDIV %d(DAC2 freq %d), freq %d,%s\n",
+                (val & CTRL_PCLKDIV) >> CTRL_SH_PCLKDIV,
+                DAC2_DIVTOSR((val & CTRL_PCLKDIV) >> CTRL_SH_PCLKDIV),
+                dac1_samplerate[(val & CTRL_WTSRSEL) >> CTRL_SH_WTSRSEL],
+                buf);
+    }
 }
 
-static void print_sctl (uint32_t val)
+static void print_sctl(uint32_t val)
 {
-    static const char *fmt_names[] = {"8M", "8S", "16M", "16S"};
-    char buf[1024];
-
-    buf[0] = '\0';
-
-#define a(n) if (val & SCTRL_##n) strcat (buf, " "#n)
-#define b(n) if (!(val & SCTRL_##n)) strcat (buf, " "#n)
-    b (R1LOOPSEL);
-    b (P2LOOPSEL);
-    b (P1LOOPSEL);
-    a (P2PAUSE);
-    a (P1PAUSE);
-    a (R1INTEN);
-    a (P2INTEN);
-    a (P1INTEN);
-    a (P1SCTRLD);
-    a (P2DACSEN);
-    if (buf[0]) {
-        strcat (buf, "\n        ");
-    }
-    else {
-        buf[0] = ' ';
-        buf[1] = '\0';
-    }
+    if (DEBUG_ES1370) {
+        static const char *fmt_names[] = {"8M", "8S", "16M", "16S"};
+        char buf[1024];
+
+        buf[0] = '\0';
+
+#define a(n) if (val & SCTRL_##n) pstrcat(buf, sizeof(buf), " "#n)
+#define b(n) if (!(val & SCTRL_##n)) pstrcat(buf, sizeof(buf), " "#n)
+        b(R1LOOPSEL);
+        b(P2LOOPSEL);
+        b(P1LOOPSEL);
+        a(P2PAUSE);
+        a(P1PAUSE);
+        a(R1INTEN);
+        a(P2INTEN);
+        a(P1INTEN);
+        a(P1SCTRLD);
+        a(P2DACSEN);
+        if (buf[0]) {
+            pstrcat(buf, sizeof(buf), "\n        ");
+        } else {
+            buf[0] = ' ';
+            buf[1] = '\0';
+        }
 #undef b
 #undef a
-    AUD_log ("es1370",
-             "%s"
-             "p2_end_inc %d, p2_st_inc %d, r1_fmt %s, p2_fmt %s, p1_fmt %s\n",
-             buf,
-             (val & SCTRL_P2ENDINC) >> SCTRL_SH_P2ENDINC,
-             (val & SCTRL_P2STINC) >> SCTRL_SH_P2STINC,
-             fmt_names [(val >> SCTRL_SH_R1FMT) & 3],
-             fmt_names [(val >> SCTRL_SH_P2FMT) & 3],
-             fmt_names [(val >> SCTRL_SH_P1FMT) & 3]
-        );
+        AUD_log("es1370",
+                "%s p2_end_inc %d, p2_st_inc %d,"
+                " r1_fmt %s, p2_fmt %s, p1_fmt %s\n",
+                buf,
+                (val & SCTRL_P2ENDINC) >> SCTRL_SH_P2ENDINC,
+                (val & SCTRL_P2STINC) >> SCTRL_SH_P2STINC,
+                fmt_names[(val >> SCTRL_SH_R1FMT) & 3],
+                fmt_names[(val >> SCTRL_SH_P2FMT) & 3],
+                fmt_names[(val >> SCTRL_SH_P1FMT) & 3]);
+    }
 }
-#else
-#define print_ctl(...)
-#define print_sctl(...)
-#endif
 
 #ifdef VERBOSE_ES1370
 #define lwarn(...) AUD_log ("es1370: warning", __VA_ARGS__)
-- 
2.35.3


