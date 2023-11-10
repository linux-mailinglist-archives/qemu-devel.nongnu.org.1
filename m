Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD00D7E8698
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 00:28:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1atr-0005sN-Rv; Fri, 10 Nov 2023 18:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r1ato-0005s0-34
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 18:26:52 -0500
Received: from rusty.tulip.relay.mailchannels.net ([23.83.218.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r1atj-0000BI-Cj
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 18:26:51 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 7BDCE3627BC;
 Fri, 10 Nov 2023 23:26:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (unknown [127.0.0.6])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 1EA6D3627EC;
 Fri, 10 Nov 2023 23:26:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1699658804; a=rsa-sha256;
 cv=none;
 b=axae0WvmcVNWPBYp0IzU254cOASIwrT1d+QUgGoqNVc4JsWqsJ/M/NyJpQ6/KWVdnJhlgW
 3dAC+PqcVZPmGLxpaasAeLg9NmX/E4BmySjiKWkzljw0aSCsJ9UEV0KlicSBwoFj3/L1wI
 H5TUKfdkUk08YdLQvPkqltfTrZIQw3osWNSeIYQML4nTurbA5LzNhyniUbBKnBkyuUgXRJ
 qgNTLFyUyUoh5S6A9AfhfYLuqkInhd5AWf7/6iW9PW1RzDxBWPd0204gbm2OSKCaI/pNyQ
 MGy0eAlRw+LkyNb/zs308WJvAyX/BfAH24uRz8L/pG5wKuh7/WiJhjVkQaRRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1699658804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=5djTN8nvvdGY4qoT4NBklw/HiGALT9CmWuR3LSa7ORw=;
 b=37+gtfWFOmTbgj212CRyzZVSvEwNwlkhA2uza3wPj5kP13UefZ3DEh/8tDRFZoj1Ix8cmC
 0gSKSrzKQ89vlyJLOlseDeMQNtRYjR7h8XaGO1lytOrC22l3Z3BJsU2h4xEfGXz80rsFGn
 ekuwSVYuNJYXs/pwFBYkARZSYG1xydZjcBnMQSUeyTdaOVl0xP4XoIFhGeqDhB4Y+JIShl
 NaE6PZyeomtR8xdJo7lz7gxqQpKpCQm9FUdmTaOgaDf0bzTTOUZSsglDPv9NGsVOwXlIqo
 zo5vQZH++J7xWzFppC5upWBAjgQzwgigfVzpv8jDdv9KtCeNAwTrf8RFBZeX7Q==
ARC-Authentication-Results: i=1; rspamd-6c48c794c6-jdrd6;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tart-Interest: 28ef6f5956d9dfa5_1699658804353_2514300046
X-MC-Loop-Signature: 1699658804353:1689754630
X-MC-Ingress-Time: 1699658804353
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.117.123.8 (trex/6.9.2); Fri, 10 Nov 2023 23:26:44 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net
 [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4SRw2C3sBGz3k; 
 Fri, 10 Nov 2023 15:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1699658803;
 bh=5djTN8nvvdGY4qoT4NBklw/HiGALT9CmWuR3LSa7ORw=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=qfkDCnSw36gisLU8aARa/+xyV0H46mIIfzg1Ig3Bel3//UaEOAZSHbXCzQv5/hrOi
 F7bdMVN4AFcdEppCRyIleurO8Nj5mo/MI/bYFawbrEDMU+/q6RaV5yCGJK19LP2tq/
 Peyqdfcec+bru+5Vn1fbATHJGLzmTwd9dLLCm4zgol3jkQ+u2wT14fjYypLd4WTEre
 vmJPh+gcnJ97BhHg2HTImoD6v106HiIE0+x1N6RBnpFP9IjmbJ4eJtGTYJsRiGuwBp
 zSmAdIORfv5UNrCslLR6+BWdTk7HZw4FagtiNti1PoBpj88ojIj31VJyl1WBNN9qca
 iSO4y/byZ8q1A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Jonathan.Cameron@huawei.com, fan.ni@samsung.com, dave@stgolabs.net
Subject: [PATCH] hw/cxl/mbox: Remove dead code
Date: Fri, 10 Nov 2023 15:26:40 -0800
Message-ID: <20231110232640.11327-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.218.252; envelope-from=dave@stgolabs.net;
 helo=rusty.tulip.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Two functions were reported to have dead code, remove the bogus
branches altogether, as well as a misplaced qemu_log call.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 43 +++++++++++++-------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b36557509710..39642ed93ee6 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1001,15 +1001,8 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
 
     cxl_dev_disable_media(&ct3d->cxl_dstate);
 
-    if (secs > 2) {
-        /* sanitize when done */
-        return CXL_MBOX_BG_STARTED;
-    } else {
-        __do_sanitization(ct3d);
-        cxl_dev_enable_media(&ct3d->cxl_dstate);
-
-        return CXL_MBOX_SUCCESS;
-    }
+    /* sanitize when done */
+    return CXL_MBOX_BG_STARTED;
 }
 
 static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
@@ -1387,27 +1380,21 @@ static void bg_timercb(void *opaque)
 
         cci->bg.complete_pct = 100;
         cci->bg.ret_code = ret;
-        if (ret == CXL_MBOX_SUCCESS) {
-            switch (cci->bg.opcode) {
-            case 0x4400: /* sanitize */
-            {
-                CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
-
-                __do_sanitization(ct3d);
-                cxl_dev_enable_media(&ct3d->cxl_dstate);
-            }
+        switch (cci->bg.opcode) {
+        case 0x4400: /* sanitize */
+        {
+            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+
+            __do_sanitization(ct3d);
+            cxl_dev_enable_media(&ct3d->cxl_dstate);
+        }
+        break;
+        case 0x4304: /* TODO: scan media */
+            break;
+        default:
+            __builtin_unreachable();
             break;
-            case 0x4304: /* TODO: scan media */
-                break;
-            default:
-                __builtin_unreachable();
-                break;
-            }
         }
-
-        qemu_log("Background command %04xh finished: %s\n",
-                 cci->bg.opcode,
-                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
     } else {
         /* estimate only */
         cci->bg.complete_pct = 100 * now / total_time;
-- 
2.42.1


