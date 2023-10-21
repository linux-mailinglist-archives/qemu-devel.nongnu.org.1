Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DF87D1D06
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 14:08:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quAjt-00036x-DX; Sat, 21 Oct 2023 08:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1quAjk-00035N-JT; Sat, 21 Oct 2023 08:05:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1quAji-00011g-IL; Sat, 21 Oct 2023 08:05:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0A6FE2C336;
 Sat, 21 Oct 2023 15:05:53 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EB8CE30684;
 Sat, 21 Oct 2023 15:05:27 +0300 (MSK)
Received: (nullmailer pid 220799 invoked by uid 1000);
 Sat, 21 Oct 2023 12:05:25 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-trivial@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 08/17] ppc/{bamboo,
 virtex_ml507}: Remove useless dependency on ppc405.h header
Date: Sat, 21 Oct 2023 15:05:10 +0300
Message-Id: <20231021120519.220720-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021120519.220720-1-mjt@tls.msk.ru>
References: <20231021120519.220720-1-mjt@tls.msk.ru>
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

From: Cédric Le Goater <clg@kaod.org>

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com> (odd fixer:virtex_ml507)
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/ppc/ppc440_bamboo.c | 1 -
 hw/ppc/virtex_ml507.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 45f409c838..a189942de4 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -24,7 +24,6 @@
 #include "elf.h"
 #include "hw/char/serial.h"
 #include "hw/ppc/ppc.h"
-#include "ppc405.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
 #include "hw/sysbus.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index f2f81bd425..d02f330650 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -43,7 +43,6 @@
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/qdev-properties.h"
-#include "ppc405.h"
 
 #include <libfdt.h>
 
-- 
2.39.2


