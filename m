Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B65FB7CCABB
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:35:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsou4-00025v-K0; Tue, 17 Oct 2023 14:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1qsou1-00024L-7o; Tue, 17 Oct 2023 14:34:49 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1qsoty-0002tY-2a; Tue, 17 Oct 2023 14:34:48 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 8E12EB81EE0;
 Tue, 17 Oct 2023 18:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB102C433C9;
 Tue, 17 Oct 2023 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697567683;
 bh=+cGRsxoDX1k/ZPmo4qvdvzE7cOh1iCnqTIS6yKrOfbU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jUKBUh15Hc032ZerUO9Ng/10t1N1vHF7w+3jcyH6zZkRSxyN27lLi/0lQDlr8xlre
 Kg0jIvJChwjlwmwqWY9gT0jBqB+APKEGKA2vCBsLAjeOfCJBEPxt7Fc/A6eFZQff8R
 IJkxMVmzfTAdkcBC5z4LIh4dGshWMqo/g8BXo/y8a/MZv7otQ5GHjZaU6UUCw/+0N3
 i/xONUvVM2Kg/+CO2dS5KY5N7cuqv3BeUhbS4WxDcKXxlh0YRttQCH+R1GrTv+3R5J
 y0L7JMeKXcGK7OICt4Q+KKa3JbpNrUCjrzDcHA+Uvs0HcS0q8AMvdm7O3qvpp06cfx
 KPFLUfziDHi3A==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Subject: [PATCH v3 04/11] lasips2: LASI PS/2 devices are not user-createable
Date: Tue, 17 Oct 2023 20:34:25 +0200
Message-ID: <20231017183432.117243-5-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017183432.117243-1-deller@kernel.org>
References: <20231017183432.117243-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.68.75; envelope-from=deller@kernel.org;
 helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Those PS/2 ports are created with the LASI controller when
a 32-bit PA-RISC machine is created.

Mark them not user-createable to avoid showing them in
the qemu device list.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: qemu-stable@nongnu.org
---
 hw/input/lasips2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
index ea7c07a2ba..6075121b72 100644
--- a/hw/input/lasips2.c
+++ b/hw/input/lasips2.c
@@ -351,6 +351,11 @@ static void lasips2_port_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    /*
+     * The PS/2 mouse port is integreal part of LASI and can not be
+     * created by users without LASI.
+     */
+    dc->user_creatable = false;
     dc->realize = lasips2_port_realize;
 }
 
@@ -397,6 +402,11 @@ static void lasips2_kbd_port_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     LASIPS2PortDeviceClass *lpdc = LASIPS2_PORT_CLASS(klass);
 
+    /*
+     * The PS/2 keyboard port is integreal part of LASI and can not be
+     * created by users without LASI.
+     */
+    dc->user_creatable = false;
     device_class_set_parent_realize(dc, lasips2_kbd_port_realize,
                                     &lpdc->parent_realize);
 }
-- 
2.41.0


