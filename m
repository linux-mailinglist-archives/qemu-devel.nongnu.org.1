Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 464CE7CC7F2
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:49:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmHh-0005za-Qo; Tue, 17 Oct 2023 11:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1qsmHf-0005wq-Ae; Tue, 17 Oct 2023 11:47:03 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1qsmHd-00033D-RR; Tue, 17 Oct 2023 11:47:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1D1B361574;
 Tue, 17 Oct 2023 15:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D600C433C7;
 Tue, 17 Oct 2023 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697557619;
 bh=Q/McPD1jCWCA/VbO3er7PXH6YurHonX1T5ShKcxZ9YQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OGaaj0Cl+4vTnMiRj8e52oFy9RNZxVjb736Ivsniubl1loo1RY7XT4iSfoTtjTy2u
 /NTWo1xE+nUa91hJl0KmnPs4zloTMWgzZEILaqALQ85s6uPgkYatVWz0x5m2J65tq/
 RO6i+Fdtr7f73bEF/feAE4mlvJXAHmkPwupijvmInPfZoNIHT7K9R4Sd6elWF4JjCp
 7iL/ZXxZc9Ef9gx6d8GkjmculjDWjHS8hSovJ9w80V/SgeORPGohcWIlZY+7/6FrmU
 qLC0Gt2FU3DMFY9jF/nEK48jvwp05x+WF6VzCqEj7+vZa37PebEGvyPCfqQqS2XY2A
 yKaXRq1LS2A4w==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@gmx.de>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 05/11] lasips2: LASI PS/2 devices are not user-createable
Date: Tue, 17 Oct 2023 17:46:39 +0200
Message-ID: <20231017154645.95844-6-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017154645.95844-1-deller@kernel.org>
References: <20231017154645.95844-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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
 hw/input/lasips2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
index ea7c07a2ba..18b94fa060 100644
--- a/hw/input/lasips2.c
+++ b/hw/input/lasips2.c
@@ -351,6 +351,7 @@ static void lasips2_port_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->user_creatable = false;
     dc->realize = lasips2_port_realize;
 }
 
@@ -397,6 +398,7 @@ static void lasips2_kbd_port_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     LASIPS2PortDeviceClass *lpdc = LASIPS2_PORT_CLASS(klass);
 
+    dc->user_creatable = false;
     device_class_set_parent_realize(dc, lasips2_kbd_port_realize,
                                     &lpdc->parent_realize);
 }
-- 
2.41.0


