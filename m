Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 423BD7A3408
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 08:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhljj-0006tu-Le; Sun, 17 Sep 2023 02:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljf-0006t4-Gv
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 02:58:27 -0400
Received: from mailout01.t-online.de ([194.25.134.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljc-00051J-CL
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 02:58:26 -0400
Received: from fwd82.aul.t-online.de (fwd82.aul.t-online.de [10.223.144.108])
 by mailout01.t-online.de (Postfix) with SMTP id E1F39173A0;
 Sun, 17 Sep 2023 08:58:21 +0200 (CEST)
Received: from linpower.localnet ([79.208.31.89]) by fwd82.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qhljW-1XNDhh0; Sun, 17 Sep 2023 08:58:18 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 9A3E02002DE; Sun, 17 Sep 2023 08:58:13 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: [PATCH 3/8] hw/audio/es1370: remove unused dolog macro
Date: Sun, 17 Sep 2023 08:58:08 +0200
Message-Id: <20230917065813.6692-3-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
References: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1694933898-39D2CD37-D2638B6E/0/0 CLEAN NORMAL
X-TOI-MSGID: a893b9f3-15d1-4dad-9947-88f108abcb73
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

The dolog macro is unused. Remove the macro and use the now unused
ES1370_VERBOSE macro to replace its inverse ES1370_SILENT macro.

Tested-by: Rene Engel <ReneEngel80@emailn.de>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/es1370.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 0b9fdc8f41..f66feb5bb0 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -24,7 +24,6 @@
 
 /* #define DEBUG_ES1370 */
 /* #define VERBOSE_ES1370 */
-#define SILENT_ES1370
 
 #include "qemu/osdep.h"
 #include "hw/audio/soundhw.h"
@@ -243,12 +242,6 @@ static void print_sctl (uint32_t val)
 #endif
 
 #ifdef VERBOSE_ES1370
-#define dolog(...) AUD_log ("es1370", __VA_ARGS__)
-#else
-#define dolog(...)
-#endif
-
-#ifndef SILENT_ES1370
 #define lwarn(...) AUD_log ("es1370: warning", __VA_ARGS__)
 #else
 #define lwarn(...)
-- 
2.35.3


