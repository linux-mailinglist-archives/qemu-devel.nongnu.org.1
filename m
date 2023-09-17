Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA097A3401
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 08:58:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhlja-0006qB-AG; Sun, 17 Sep 2023 02:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljX-0006ph-Uu; Sun, 17 Sep 2023 02:58:19 -0400
Received: from mailout05.t-online.de ([194.25.134.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljW-0004y4-9i; Sun, 17 Sep 2023 02:58:19 -0400
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
 by mailout05.t-online.de (Postfix) with SMTP id 7A5204338;
 Sun, 17 Sep 2023 08:58:14 +0200 (CEST)
Received: from linpower.localnet ([79.208.31.89]) by fwd86.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qhljR-2zr8Sn0; Sun, 17 Sep 2023 08:58:14 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 9512020027A; Sun, 17 Sep 2023 08:58:13 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH 1/8] hw/audio/es1370: reset current sample counter
Date: Sun, 17 Sep 2023 08:58:06 +0200
Message-Id: <20230917065813.6692-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
References: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1694933894-0592EEBC-39B5DE82/0/0 CLEAN NORMAL
X-TOI-MSGID: 906388a9-a312-4720-b4b8-98d2ef9832a8
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
---
 hw/audio/es1370.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.35.3


