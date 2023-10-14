Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 271087C9628
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 21:58:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrkll-00041B-El; Sat, 14 Oct 2023 15:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1qrklc-0003wm-Cx; Sat, 14 Oct 2023 15:57:44 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1qrklZ-0004aR-9f; Sat, 14 Oct 2023 15:57:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id C3EAEB80881;
 Sat, 14 Oct 2023 19:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F34C433C9;
 Sat, 14 Oct 2023 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697313451;
 bh=NK+ofguQ6Y4djnizCi1xGa4bVdM+IS5OhjkD+VwgnIM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gmJZgfPjAapgXPWMdqnN5vQ3tAZfsxlv0CN2RZWkAVqbldOrbbsCXXiQc7GpNpa/Z
 rptskOogjFQzFC6KGoQ6zmbNSamsTgEFSPLLuAcFek9oPkDXwjZLv2O69qc7i8H/Yh
 KNnO5cheh7auN4COFz/pyguEefSUUPdrimOPLaKQSe0HW7feHH2SjeDB/n92AuRUr8
 UENtvvzQSQ1yrsK3/mwDbf8qkP0iUIDFzphRKdbu7h2Xfxn/98wjZMyHIGdoj4pl5z
 v70O1OYmodFLQDo5Y+Fm+QW7IG/57l1FAw+nTJOhSiMUiiAjNwhypYPTAc3t/RYwwo
 El+rpPd7I7a2A==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, qemu-stable@nongnu.org
Subject: [PATCH 05/12] lasips2: LASI PS/2 devices are not user-createable
Date: Sat, 14 Oct 2023 21:57:12 +0200
Message-ID: <20231014195719.151397-6-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014195719.151397-1-deller@kernel.org>
References: <20231014195719.151397-1-deller@kernel.org>
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
 hw/input/lasips2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
index ea7c07a2ba..93c9c887d3 100644
--- a/hw/input/lasips2.c
+++ b/hw/input/lasips2.c
@@ -351,6 +351,8 @@ static void lasips2_port_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    /* Lasi devices can not be created by users */
+    dc->user_creatable = false;
     dc->realize = lasips2_port_realize;
 }
 
@@ -397,6 +399,8 @@ static void lasips2_kbd_port_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     LASIPS2PortDeviceClass *lpdc = LASIPS2_PORT_CLASS(klass);
 
+    /* Lasi devices can not be created by users */
+    dc->user_creatable = false;
     device_class_set_parent_realize(dc, lasips2_kbd_port_realize,
                                     &lpdc->parent_realize);
 }
-- 
2.41.0


