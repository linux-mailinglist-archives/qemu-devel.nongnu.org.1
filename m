Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0771686B91E
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 21:37:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQf3-0005ME-W0; Wed, 28 Feb 2024 15:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfQeW-00055s-K6; Wed, 28 Feb 2024 15:35:45 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfQeV-0001Ia-70; Wed, 28 Feb 2024 15:35:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7D49251772;
 Wed, 28 Feb 2024 23:35:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1C17D8BA7A;
 Wed, 28 Feb 2024 23:35:22 +0300 (MSK)
Received: (nullmailer pid 267629 invoked by uid 1000);
 Wed, 28 Feb 2024 20:35:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jessica Clarke <jrtc27@jrtc27.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 40/47] pl031: Update last RTCLR value on write in case
 it's read back
Date: Wed, 28 Feb 2024 23:35:08 +0300
Message-Id: <20240228203521.267565-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240228233111@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240228233111@cover.tls.msk.ru>
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

From: Jessica Clarke <jrtc27@jrtc27.com>

The PL031 allows you to read RTCLR, which is meant to give you the last
value written. PL031State has an lr field which is used when reading
from RTCLR, and is present in the VM migration state, but we never
actually update it, so it always reads as its initial 0 value.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240222000341.1562443-1-jrtc27@jrtc27.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 4d28d57c9f2eb1cdf70b29cea6e50282e010075b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index b01d0e75d1..2f3cd04eeb 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -141,6 +141,7 @@ static void pl031_write(void * opaque, hwaddr offset,
         g_autofree const char *qom_path = object_get_canonical_path(opaque);
         struct tm tm;
 
+        s->lr = value;
         s->tick_offset += value - pl031_get_count(s);
 
         qemu_get_timedate(&tm, s->tick_offset);
-- 
2.39.2


