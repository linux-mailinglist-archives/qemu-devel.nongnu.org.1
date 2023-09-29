Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB667B2C8A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:43:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm7Bp-0006bF-Pe; Fri, 29 Sep 2023 02:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qm7BZ-0005wI-H7
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:41:14 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qm7B6-0007RP-LL
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GJUUz6ypE37ZZ+pKcZRzPE2uN3aYWV4eSuPVA+KIBDw=; b=Dlm8rPVXDoa5cDZ2l90VuirHA4
 18/zBvgS1LV+J6P9lq0cddJi0rSi/q3zZ/IOWWiB1OBSfPUoTJlFR4qRc1pubvdOk9b5RN8M7g6kd
 laqndppFSJeI3t3qzCjnNWYVWEs3EAGwqum6BXRLUe6O3CBn1k9mdSJKkhl+Q43gGotw=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PULL v3 13/16] hw/tricore: Log failing test in testdevice
Date: Fri, 29 Sep 2023 08:39:57 +0200
Message-ID: <20230929064000.536923-14-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
References: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.29.63017, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.29.602000
X-Sophos-SenderHistory: ip=79.202.213.239, fs=162277, da=183578706, mc=64, sc=0,
 hc=64, sp=0, fso=162277, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <20230913105326.40832-3-kbastian@mail.uni-paderborn.de>
---
 hw/tricore/tricore_testdevice.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/tricore/tricore_testdevice.c b/hw/tricore/tricore_testdevice.c
index a1563aa568..9028d970b0 100644
--- a/hw/tricore/tricore_testdevice.c
+++ b/hw/tricore/tricore_testdevice.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
 #include "hw/tricore/tricore_testdevice.h"
@@ -23,6 +24,9 @@
 static void tricore_testdevice_write(void *opaque, hwaddr offset,
                                       uint64_t value, unsigned size)
 {
+    if (value != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Test %" PRIu64 " failed!\n", value);
+    }
     exit(value);
 }
 
-- 
2.42.0


