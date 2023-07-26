Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D576294F
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 05:33:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOVGG-0005Ou-JF; Tue, 25 Jul 2023 23:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>)
 id 1qOVG5-0005NA-Qh; Tue, 25 Jul 2023 23:32:23 -0400
Received: from mail-40136.proton.ch ([185.70.40.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>)
 id 1qOVG3-0006vQ-R3; Tue, 25 Jul 2023 23:32:17 -0400
Date: Wed, 26 Jul 2023 03:31:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1690342333; x=1690601533;
 bh=HgHvDYfqmVARdVYQabwTUqO/6ANgGN89IeXI5IaKM+I=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=MAFK/OeLLnE+b1UAHimaQKRWlnZuR82x+yOTce/CucuOEEROTpzvZ0ZuBMvqihsxP
 Q0n3aTybwSEjePB9Fal9yX2CICP5tR5K3IRebS5aDxlPQfyX+PUibhAMB1GnAaQi1q
 769yHKqsbme95DU3J0wSRdOdqy6/ndaOXIHkoofXv+GLTm3yVzIbYE9BUVmEjKWHlY
 eXmDizenh65toc1pGCwNBHYq14+r0Ewe5xeIVA33koxPddvvRfMiohYUq+flWefJxe
 hE4Oti97rxIhIqcGgRsCANufkcLkMZr1UreeAoDg5hdBmeV5pkEqCUKVx0pU2ICuxD
 JyveTLWj9Q6jQ==
To: qemu-devel@nongnu.org
From: Chris Laplante <chris@laplante.io>
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Chris Laplante <chris@laplante.io>
Subject: [PATCH v2 2/6] qtest: factor out qtest_install_gpio_out_intercept
Message-ID: <20230726030450.757462-3-chris@laplante.io>
In-Reply-To: <20230726030450.757462-1-chris@laplante.io>
References: <20230726030450.757462-1-chris@laplante.io>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.136; envelope-from=chris@laplante.io;
 helo=mail-40136.proton.ch
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

Signed-off-by: Chris Laplante <chris@laplante.io>
---
 softmmu/qtest.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index f8d764b719..1c92e5a6a3 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -365,6 +365,15 @@ void qtest_set_command_cb(bool (*pc_cb)(CharBackend *c=
hr, gchar **words))
     process_command_cb =3D pc_cb;
 }
=20
+static void qtest_install_gpio_out_intercept(DeviceState *dev, const char =
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
@@ -415,12 +424,7 @@ static void qtest_process_command(CharBackend *chr, gc=
har **words)
             if (words[0][14] =3D=3D 'o') {
                 int i;
                 for (i =3D 0; i < ngl->num_out; ++i) {
-                    qemu_irq *disconnected =3D g_new0(qemu_irq, 1);
-                    qemu_irq icpt =3D qemu_allocate_irq(qtest_irq_handler,
-                                                      disconnected, i);
-
-                    *disconnected =3D qdev_intercept_gpio_out(dev, icpt,
-                                                            ngl->name, i);
+                    qtest_install_gpio_out_intercept(dev, ngl->name, i);
                 }
             } else {
                 qemu_irq_intercept_in(ngl->in, qtest_irq_handler,
--=20
2.41.0



