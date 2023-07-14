Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF72B754565
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 01:29:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKSCc-0000qs-7a; Fri, 14 Jul 2023 19:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qKSCZ-0000oc-NP
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 19:27:56 -0400
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qKSCY-000417-4y
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 19:27:55 -0400
Date: Fri, 14 Jul 2023 23:27:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1689377271; x=1689636471;
 bh=rYex7wocRTZGMfRvcRZxojizl1kEh3Iuu8cjifrFqzQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=mqu2TzygWc2rF5jtfcV0lwJ/yKDEcSdLDU1yPwOU+mke/yAgzIlvxidTOvoeTk5T1
 QcjuktGSYHfRh74wNBuaJp9+2Zg/QNNDS6aktbG30CjtUBL7gU3swjsuup1QluiH1y
 76OCTZQoB/yOmQXRFVYPT3FoR0XCOguoTysLZzIeydG42pZGs/d7lU1cE1+GmV5HVk
 eeYRgEq+ees5tkiqIcWnQawkbXo0TaGwY7/YYChgcorSWmO13f9QGKrmUCxXh9zVbV
 0FvSH0MKxIZvWyFCCHCwQqTKgspTXcYB4CU8ybmTy0f0jdIbmXYBn63zbQ0UhciK1S
 nlR9+TeB61bDg==
To: qemu-devel@nongnu.org
From: Chris Laplante <chris@laplante.io>
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Chris Laplante <chris@laplante.io>
Subject: [PATCH 4/6] qtest: factor out qtest_install_gpio_out_intercepts
Message-ID: <20230714232659.76434-5-chris@laplante.io>
In-Reply-To: <20230714232659.76434-1-chris@laplante.io>
References: <20230714232659.76434-1-chris@laplante.io>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.18; envelope-from=chris@laplante.io;
 helo=mail-4018.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Simplify the code a bit.

Signed-off-by: Chris Laplante <chris@laplante.io>
---
 softmmu/qtest.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 74482ce3cd..051bbf4177 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -365,6 +365,15 @@ void qtest_set_command_cb(bool (*pc_cb)(CharBackend *c=
hr, gchar **words))
     process_command_cb =3D pc_cb;
 }
=20
+static void qtest_install_gpio_out_intercepts(DeviceState *dev, const char=
 *name, int n)
+{
+    qemu_irq *disconnected =3D g_new0(qemu_irq, 1);
+    qemu_irq icpt =3D qemu_allocate_irq(qtest_irq_handler,
+                                      disconnected, n);
+
+    *disconnected =3D qdev_intercept_gpio_out(dev, icpt,name, n);
+}
+
 static void qtest_process_command(CharBackend *chr, gchar **words)
 {
     const gchar *command;
@@ -421,23 +430,13 @@ static void qtest_process_command(CharBackend *chr, g=
char **words)
             if (is_outbound) {
                 if (is_named) {
                     if (ngl->name && strcmp(ngl->name, words[2]) =3D=3D 0)=
 {
-                        qemu_irq *disconnected =3D g_new0(qemu_irq, 1);
-                        qemu_irq icpt =3D qemu_allocate_irq(qtest_irq_hand=
ler,
-                                                          disconnected, 0)=
;
-
-                        *disconnected =3D qdev_intercept_gpio_out(dev, icp=
t,
-                                                                ngl->name,=
 0);
+                        qtest_install_gpio_out_intercepts(dev, ngl->name, =
0);
                         break;
                     }
                 } else if (!ngl->name) {
                     int i;
                     for (i =3D 0; i < ngl->num_out; ++i) {
-                        qemu_irq *disconnected =3D g_new0(qemu_irq, 1);
-                        qemu_irq icpt =3D qemu_allocate_irq(qtest_irq_hand=
ler,
-                                                          disconnected, i)=
;
-
-                        *disconnected =3D qdev_intercept_gpio_out(dev, icp=
t,
-                                                                ngl->name,=
 i);
+                        qtest_install_gpio_out_intercepts(dev, ngl->name, =
i);
                     }
                 }
             } else {
--=20
2.39.2



