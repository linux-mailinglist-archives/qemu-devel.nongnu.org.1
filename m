Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 026357C4AA3
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 08:32:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqSlK-0001vx-A0; Wed, 11 Oct 2023 02:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSkt-0001tg-Cj
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSkr-0006tX-Dl
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697005896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLJnKgNtxYx5qH6WK1NFc/hsEV6CbfDgzhHL3lI4hFY=;
 b=h44Ig2ecQ0iWIvagEJPsfssZImcEKpcAcRdnassBqqi1kFepAkTCvfehEErlVMdeevZyQK
 edrkkRRrLIYVIQGqLPeGP9x43J/qBRi5l5cJtO7OOoS1E22JxoguS4BXD/cjh5ZClEcwbY
 wzMj2Ym5L8b4CSzRjBYxVc7qcGb6Thw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-Z7BOjUvEP3aT4WfjQ2DtgA-1; Wed, 11 Oct 2023 02:31:23 -0400
X-MC-Unique: Z7BOjUvEP3aT4WfjQ2DtgA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F5522825E95;
 Wed, 11 Oct 2023 06:31:23 +0000 (UTC)
Received: from localhost (unknown [10.39.208.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DB041C060DF;
 Wed, 11 Oct 2023 06:31:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	stefanha@redhat.com,
	vr_qemu@t-online.de
Subject: [PULL 4/8] hw/audio/es1370: remove #ifdef ES1370_DEBUG to avoid bit
 rot
Date: Wed, 11 Oct 2023 10:30:57 +0400
Message-ID: <20231011063101.258955-5-marcandre.lureau@redhat.com>
In-Reply-To: <20231011063101.258955-1-marcandre.lureau@redhat.com>
References: <20231011063101.258955-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Volker Rümelin <vr_qemu@t-online.de>

Replace the #ifdef ES1370_DEBUG code with code that the compiler
can optimize away to avoid bit rot. While at it, replace strcat()
with pstrcat().

Tested-by: Rene Engel <ReneEngel80@emailn.de>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20230917065813.6692-4-vr_qemu@t-online.de>
---
 hw/audio/es1370.c | 135 +++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 69 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index dd09fd59e1..f111206709 100644
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
2.41.0


