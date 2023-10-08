Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1347BCC9F
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:25:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCz-00089J-0i; Sun, 08 Oct 2023 02:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCw-000882-OG
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:06 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCv-0007oD-6m
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:06 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N7yuz-1rbc5Q0ct9-0151C7; Sun, 08
 Oct 2023 08:24:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 16/20] mac_via: implement ADB_STATE_IDLE state if shift
 register in input mode
Date: Sun,  8 Oct 2023 08:23:45 +0200
Message-ID: <20231008062349.2733552-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qF0L7i4wM1AvWGjYWZcBEbtH6ZZI79csFVpFJXbWrWjpKtsWYq8
 7D6dKBugAPDdPjqdeMAGaigp+G7dZhGdfhlxwie1gs6h5EppA9BjUHUhLNfwN0sbe3MEvi+
 oGnGtEpivLM69GDGr30FFjqxxoGieiJ4TfYeWBvBkOeMWGVJbUEmQQ7CjoBgTz3NhMe89mM
 DrKMiTTMdeOOCZyEwSKbQ==
UI-OutboundReport: notjunk:1;M01:P0:EP++qngpSiU=;x+42k7SvSYhcywH/DpVOtBv8kb5
 jMpgkvr2EqFa5HxbeTlKGXdG13GqJNZPpiXbMbNUdltTCUbWljkwyCgyUqWyyRLuCMLYA2Cr9
 3uHcApMRNTsprPU1SXWgaJEnwQIynHsiC5D+8l139zC4LoXprTYLa0YiAfyX5SztnF2s6g1Z5
 lwiV1AA3WDO7yAcBpO+IHVtmwqwc+920ULqspT+NailSkicjBc5gXxOQqTifGvmZiAkQRNbYr
 SNTIt/TbKfrtBNVVhKAqP1sLdOkWKIQeOncCMqgXONfdWAwWy0uIbIwmGHUH5BvRczDr/JHwo
 alKe/Ny2/HPlYH3tzjNj1FYrQHLyKxQAl0IxQMs5RonITHo7L9n3S386L1pa8nSkkxBK9M+DO
 mTQp/FN/ChqTycGzQ3N/C6gXCwo1Ex7JwVUiqA4bYjuTOt9TvyWPoTSyQM+fNh4szcGF1Cbeh
 Zwy/Cbhr/vwqfB3cqHM0NR5TRdAc1GqrYw1dLtmovaJ4cBgvleI6+fFpw7ygsqGUaat230BID
 6zUPbwLkHhZHVtkoVafn7admRfbgZYMCKbKKRW5diWu6AEZvmKtMjXdlffd0WnpNRtyMDlTkK
 APhIYtfd9khIcZTWeT/vITvC248kJdIQ3xvwq8zYyVCcRL2DahA3Y63WhXojRQSwMMfC6dgHa
 aF4aMmHP4CjpBVO7JUVPpL5jH8hf6LiaeD9DTI07EMfnFxNxeZEtXx+f5iBmALqqsKgqVsnP3
 Wq+imCote+NGfxiVm9h16H4Yz9F7c18at/hgIeQhT128AlUVxaU9ZHktXY6oyXsX6P9+uQNgN
 mH5aFQy9kHsiYdGvmR3iisI9N+nHZUmENlADLfKYQol9HixKCT56pgWw0LCTF1UmUGIBprDoP
 BIIoOLmwdFT0eiw==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

NetBSD switches directly to IDLE state without switching the shift register to
input mode. Duplicate the existing ADB_STATE_IDLE logic in input mode from when
the shift register is in output mode which allows the ADB autopoll handler to
handle the response.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-17-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 9f9c2815d0e9..3c41d6263d45 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -702,6 +702,12 @@ static void adb_via_send(MOS6522Q800VIA1State *v1s, int state, uint8_t data)
         break;
 
     case ADB_STATE_IDLE:
+        ms->b |= VIA1B_vADBInt;
+        adb_autopoll_unblock(adb_bus);
+
+        trace_via1_adb_send("IDLE", data,
+                            (ms->b & VIA1B_vADBInt) ? "+" : "-");
+
         return;
     }
 
-- 
2.41.0


