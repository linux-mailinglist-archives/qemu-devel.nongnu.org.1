Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE12C82AC02
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 11:31:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNsKI-0005dF-F7; Thu, 11 Jan 2024 05:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNsKF-0005co-VO
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:30:16 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNsKE-00045E-IU
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AJVj+dGVOWjfOsHi2P2lw5i/HN7Src1AeYHqnhIAdLU=; b=KnWL5hjKG6FuP/7plLex97mlP4
 k48nFqQEPC/xmF52E8o8EE6BH91c1RANvGHV1EPmrxpFn7hQTe4j0XhDdg2ESaFi434/RC9s1Zwzq
 ctyrHilZ/iND7rO4jYvzJUChvwcbb08PDMj6gE3KBEpFq4ghJUbrebbOPtY2v1PkUGwGc5feD0jPe
 E9jtRuiZEltUBZmk+WTh0orlH0RkAgWZ1lUV55yGlJGWCEFnX3IAshYLWP2+3lNUmv0FMTUPcvi2/
 S3EprHcv+uJEMdhX/MXa4idSaXZTo6FYtq1ofFDf59UBjhTAleeDmwHb6If8PbUBrg7hPKKWFmokz
 DPrToksoDo8E/j0ZOx7NBrsJ/calLCY/oLQEDNAftthmDYMp5o0aNKJRJUjkeVcanDCncQrmK5X/n
 9u+2W/N/pnTveSWW5wKf6VD2bbmevjv6TuugYHHAQoSmzfqqBJnnN60LL3ItWvgG778inkSJIFfvf
 tl0Kd+A4hna4fu8J9t5/M1yUsvWkRVCz1ZIE3vqPqEBd8g2VWSkfFyIKtOO+K8D1cL6V6B9YgsedP
 V8xjIgnLWbdKAyq2R6yh+79EN9lt1TUxsxmoDD/AUoeCQ9ET10NIt/AiIhQKbuELzXmr8d6QeZdEX
 pFmbT6UJ9Vp3Ph4fsjYKviC6DbIUMtNIp9AIQKYco=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNsJe-000CMC-Uf; Thu, 11 Jan 2024 10:29:43 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org,
	elliotnunn@fastmail.com
Date: Thu, 11 Jan 2024 10:29:53 +0000
Message-Id: <20240111102954.449462-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
References: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 2/3] nubus.h: increase maximum Declaration ROM size from
 128k to 1Mb
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

Whilst 128k is more than enough for a typical Declaration ROM, a C compiler
configured to produce an unstripped debug binary can generate a ROM image that
exceeds this limit. Increase the maximum size to 1Mb to help make life easier
for developers.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/hw/nubus/nubus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/nubus/nubus.h b/include/hw/nubus/nubus.h
index b3b4d2eadb..fee79b71d1 100644
--- a/include/hw/nubus/nubus.h
+++ b/include/hw/nubus/nubus.h
@@ -51,7 +51,7 @@ struct NubusBus {
     qemu_irq irqs[NUBUS_IRQS];
 };
 
-#define NUBUS_DECL_ROM_MAX_SIZE    (128 * KiB)
+#define NUBUS_DECL_ROM_MAX_SIZE    (1 * MiB)
 
 struct NubusDevice {
     DeviceState qdev;
-- 
2.39.2


