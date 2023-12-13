Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D914B810AB2
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 07:57:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDJAA-0005aS-NT; Wed, 13 Dec 2023 01:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1rDJA8-0005aI-9J
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 01:56:08 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1rDJA4-0001vc-Vu
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 01:56:08 -0500
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1702450558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jUYrXQsVnT3DHrGkSfktTByS7QBPCK+/1pLoOPQuBbg=;
 b=B0LNqqG7CgRdlcN9iZvwhdFyqmxrV80NJa42eVBRSwOQRb1xvCWylI2TJog27ee4QtzkNz
 2nkGGEUfJ77trbsrctkj0aAikbSnrR9Nw/KPD0s5rrqnitEDi9he38+yEmh+o0hUwDDXw0
 XklktTxEra//higjwna/1R4zUTgtPYQ=
To: kraxel@redhat.com,
	marcandre.lureau@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] ui: fix DIV_BY_ZERO in tightvnc
Date: Wed, 13 Dec 2023 09:52:02 +0300
Message-Id: <20231213065201.886391-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Division by zero may occur in rare constellation of conditions if:
1. not TrueColor mode on the client side
   tight_detect_smooth_image16() and tight_detect_smooth_image32(),
   defined by macro DEFINE_DETECT_FUNCTION()2, are affected.
2. if all pixels on the screen are equal, then pixels == stats[0]

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 ui/vnc-enc-tight.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 41f559eb83..f1249ab136 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -284,6 +284,9 @@ tight_detect_smooth_image24(VncState *vs, int w, int h)
         for (; c < 256; c++) {                                          \
             errors += stats[c] * (c * c);                               \
         }                                                               \
+        if (pixels == stats[0]) {                                       \
+            return 0;                                                   \
+        }                                                               \
         errors /= (pixels - stats[0]);                                  \
                                                                         \
         return errors;                                                  \
-- 
2.34.1


