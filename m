Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B727C662C
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 09:18:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqpw5-00076S-OA; Thu, 12 Oct 2023 03:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqpvy-00071H-PL; Thu, 12 Oct 2023 03:16:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqpvw-0000tv-Iy; Thu, 12 Oct 2023 03:16:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EFB3F29AC7;
 Thu, 12 Oct 2023 10:16:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id ADA1A2E9B3;
 Thu, 12 Oct 2023 10:16:27 +0300 (MSK)
Received: (nullmailer pid 25950 invoked by uid 1000);
 Thu, 12 Oct 2023 07:16:26 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Rene Engel <ReneEngel80@emailn.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 61/61] hw/audio/es1370: reset current sample counter
Date: Thu, 12 Oct 2023 10:16:17 +0300
Message-Id: <20231012071626.25905-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231012101342@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231012101342@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Reset the current sample counter when writing the Channel Sample
Count Register. The Linux ens1370 driver and the AROS sb128
driver expect the current sample counter counts down from sample
count to 0 after a write to the Channel Sample Count Register.
Currently the current sample counter starts from 0 after a reset
or the last count when the counter was stopped.

The current sample counter is used to raise an interrupt whenever
a complete buffer was transferred. When the counter starts with a
value lower than the reload value, the interrupt triggeres before
the buffer was completly transferred. This may lead to corrupted
audio streams.

Tested-by: Rene Engel <ReneEngel80@emailn.de>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20230917065813.6692-1-vr_qemu@t-online.de>
(cherry picked from commit 00e3b29d065f3b88bb3726afbd5c73f8b2bff1b4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 4f738a0ad8..9a8e29c39c 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -502,7 +502,7 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     case ES1370_REG_DAC2_SCOUNT:
     case ES1370_REG_ADC_SCOUNT:
         d += (addr - ES1370_REG_DAC1_SCOUNT) >> 2;
-        d->scount = (val & 0xffff) | (d->scount & ~0xffff);
+        d->scount = (val & 0xffff) << 16 | (val & 0xffff);
         ldebug ("chan %td CURR_SAMP_CT %d, SAMP_CT %d\n",
                 d - &s->chan[0], val >> 16, (val & 0xffff));
         break;
-- 
2.39.2


