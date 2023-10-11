Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 957D87C4AA9
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 08:33:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqSlL-00020U-TJ; Wed, 11 Oct 2023 02:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSky-0001uM-9w
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSkw-0006va-Po
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697005902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+FLYQxnmVSLsdyLhreAOGPPDup+InzDKwiOlqO6PcE=;
 b=MDe2YbcWrVugL9if2z4M9eXku/E0msycBgCTUGm0flOSUiZAhHzCMWiU20moSdvpXosbiT
 SdWmGUB069kCtNH+QEbwiNs8vjJnHRX2RyZ7nvZnkjNba8BqPuhZ09l/Jij1T9U5zqh1r9
 lyDhs4dRktSxM9hPtvifAwCaYqBdUIQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-Y3trbaSROPGJsv8G5g7xlw-1; Wed, 11 Oct 2023 02:31:28 -0400
X-MC-Unique: Y3trbaSROPGJsv8G5g7xlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 656A08007A4;
 Wed, 11 Oct 2023 06:31:28 +0000 (UTC)
Received: from localhost (unknown [10.39.208.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D8F7207526F;
 Wed, 11 Oct 2023 06:31:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	stefanha@redhat.com,
	vr_qemu@t-online.de
Subject: [PULL 5/8] hw/audio/es1370: remove #ifdef ES1370_VERBOSE to avoid bit
 rot
Date: Wed, 11 Oct 2023 10:30:58 +0400
Message-ID: <20231011063101.258955-6-marcandre.lureau@redhat.com>
In-Reply-To: <20231011063101.258955-1-marcandre.lureau@redhat.com>
References: <20231011063101.258955-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Replace the #ifdef ES1370_VERBOSE code with code that the compiler
can optimize away to avoid bit rot and fix the already rotten code.

Tested-by: Rene Engel <ReneEngel80@emailn.de>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20230917065813.6692-5-vr_qemu@t-online.de>
---
 hw/audio/es1370.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index f111206709..7c58337076 100644
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
2.41.0


