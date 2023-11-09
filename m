Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BA27E6BE4
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:01:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15a3-0005Rs-1t; Thu, 09 Nov 2023 09:00:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZP-00058Y-Si; Thu, 09 Nov 2023 08:59:44 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZM-0005Np-82; Thu, 09 Nov 2023 08:59:42 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3364A31BB8;
 Thu,  9 Nov 2023 16:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3CA1F344F1;
 Thu,  9 Nov 2023 16:59:33 +0300 (MSK)
Received: (nullmailer pid 1462760 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 02/62] host-utils: Add muldiv64_round_up
Date: Thu,  9 Nov 2023 16:58:30 +0300
Message-Id: <20231109135933.1462615-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Nicholas Piggin <npiggin@gmail.com>

This will be used for converting time intervals in different base units
to host units, for the purpose of scheduling timers to emulate target
timers. Timers typically must not fire before their requested expiry
time but may fire some time afterward, so rounding up is the right way
to implement these.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[ clg: renamed __muldiv64() to muldiv64_rounding() ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
(cherry picked from commit 47de6c4c287079744ceb96f606b3c0457addf380)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index b3434ec0bc..09daf58787 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -57,6 +57,11 @@ static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
     return (__int128_t)a * b / c;
 }
 
+static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, uint32_t c)
+{
+    return ((__int128_t)a * b + c - 1) / c;
+}
+
 static inline uint64_t divu128(uint64_t *plow, uint64_t *phigh,
                                uint64_t divisor)
 {
@@ -84,7 +89,8 @@ void mulu64(uint64_t *plow, uint64_t *phigh, uint64_t a, uint64_t b);
 uint64_t divu128(uint64_t *plow, uint64_t *phigh, uint64_t divisor);
 int64_t divs128(uint64_t *plow, int64_t *phigh, int64_t divisor);
 
-static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
+static inline uint64_t muldiv64_rounding(uint64_t a, uint32_t b, uint32_t c,
+                                  bool round_up)
 {
     union {
         uint64_t ll;
@@ -100,12 +106,25 @@ static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
 
     u.ll = a;
     rl = (uint64_t)u.l.low * (uint64_t)b;
+    if (round_up) {
+        rl += c - 1;
+    }
     rh = (uint64_t)u.l.high * (uint64_t)b;
     rh += (rl >> 32);
     res.l.high = rh / c;
     res.l.low = (((rh % c) << 32) + (rl & 0xffffffff)) / c;
     return res.ll;
 }
+
+static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
+{
+    return muldiv64_rounding(a, b, c, false);
+}
+
+static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, uint32_t c)
+{
+    return muldiv64_rounding(a, b, c, true);
+}
 #endif
 
 /**
-- 
2.39.2


