Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F08E97671A0
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 18:14:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPPxi-0004sH-8G; Fri, 28 Jul 2023 12:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qPPxf-0004ru-W3
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:05:04 -0400
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qPPxe-0004NF-Ct
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:05:03 -0400
Date: Fri, 28 Jul 2023 16:04:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1690560300; x=1690819500;
 bh=Rk0N/XPmjneuAZccDgJuKpf3b/CK7sC2+1J9idvSmWo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=OwABK5ehC1D9P2acVBNiqDjdAz9nTw1mPatjHZ0qYd8qKn3/dEGKHf9HgCSNzEccv
 vcNeA6PG4LiDDTa7fG5GpMa3uDskO9UbyBxk95OIHuIAhsNds7eRqfTVRAwapdc2IT
 +/ALjZFeGmfBy2fsYsyTLyWoL2S9zlZg5/kU4473UIsOO0Gbh/n43bQjWhHcxRvxpG
 ypME+b/8yDpSb7i/wRX2FLCXGJ1FjuZfvIOxuE6zDOWNWr8Na3Oo3r7A7nbHHBFBVg
 Y9fWBO9sV/wYBJuItB3f8q5o/903kB0C4W077AqaVvsj1ANdi9SnTdZgmBMwGIiHCw
 qPiqK9kb4UQZg==
To: qemu-devel@nongnu.org
From: Chris Laplante <chris@laplante.io>
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Chris Laplante <chris@laplante.io>
Subject: [PATCH v3 2/6] qtest: factor out qtest_install_gpio_out_intercept
Message-ID: <20230728160324.1159090-3-chris@laplante.io>
In-Reply-To: <20230728160324.1159090-1-chris@laplante.io>
References: <20230728160324.1159090-1-chris@laplante.io>
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

Signed-off-by: Chris Laplante <chris@laplante.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 softmmu/qtest.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index f8d764b719..1b86489162 100644
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
+    *disconnected =3D qdev_intercept_gpio_out(dev, icpt, name, n);
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



