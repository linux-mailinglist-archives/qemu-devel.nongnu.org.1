Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 001D4815B0F
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 19:29:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEZOG-0000R3-Jf; Sat, 16 Dec 2023 13:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rEZOE-0000QF-Eb; Sat, 16 Dec 2023 13:27:54 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rEZOC-0006Wo-NW; Sat, 16 Dec 2023 13:27:54 -0500
Received: from buffy.. (buffy [192.168.147.6])
 by zoidberg.rfc1149.net (Postfix) with ESMTP id 0CD1D80027;
 Sat, 16 Dec 2023 19:27:47 +0100 (CET)
Authentication-Results: zoidberg.rfc1149.net;
 dmarc=fail (p=none dis=none) header.from=rfc1149.net
Authentication-Results: zoidberg.rfc1149.net;
 spf=fail smtp.mailfrom=rfc1149.net
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Anton Kochkov <anton.kochkov@proton.me>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH 2/3] hw/arm/armv7m: alias the NVIC "num-prio-bits" property
Date: Sat, 16 Dec 2023 19:27:39 +0100
Message-ID: <20231216182740.3305724-3-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231216182740.3305724-1-sam@rfc1149.net>
References: <20231216182740.3305724-1-sam@rfc1149.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 hw/arm/armv7m.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index d10abb36a8..4fda2d1d47 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -256,6 +256,8 @@ static void armv7m_instance_init(Object *obj)
     object_initialize_child(obj, "nvic", &s->nvic, TYPE_NVIC);
     object_property_add_alias(obj, "num-irq",
                               OBJECT(&s->nvic), "num-irq");
+    object_property_add_alias(obj, "num-prio-bits",
+                              OBJECT(&s->nvic), "num-prio-bits");
 
     object_initialize_child(obj, "systick-reg-ns", &s->systick[M_REG_NS],
                             TYPE_SYSTICK);
-- 
2.42.0


