Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C85D7672EF
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 19:09:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPPxz-0004yo-91; Fri, 28 Jul 2023 12:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qPPxw-0004xS-S9
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:05:20 -0400
Received: from mail-40136.proton.ch ([185.70.40.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qPPxu-0004eX-B3
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:05:20 -0400
Date: Fri, 28 Jul 2023 16:04:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1690560315; x=1690819515;
 bh=8kaga0Tq1DHDgh2bcs3qrXwpLVkm/Jqm49BzCQmqlWk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=2Jo1oVGtvnE43xpCXAZ7SDPwA0zFniUbeIh8ggtQZcHHqMM4jUjAzTHDnwHqNuQOI
 LrEoNcgeB1uuZb/MdrpwTlI56qPXLCeDJkNLs6kctNBbh3oqez5+ZzSd7qGglz55Fo
 BSJN17nXfpISwsi/DGSEwF8Gr/OW/+KaHivduaRQXQLFqaXITXu8jdRydlu+TZWuIG
 KyVCu2YzqNvkD2HyxOgVR40ZB7vtFV+C5IVuaNm92ybGYra+q/4faVPTwo0ST6n8kF
 p30DrAQmGELXgv+ehIJUC7LgfetFp5xs5ECY9+RzbheaQhC9ziavEf59ulAvbbzLF/
 w6vTEGGtG1omw==
To: qemu-devel@nongnu.org
From: Chris Laplante <chris@laplante.io>
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Chris Laplante <chris@laplante.io>
Subject: [PATCH v3 3/6] qtest: implement named interception of out-GPIO
Message-ID: <20230728160324.1159090-4-chris@laplante.io>
In-Reply-To: <20230728160324.1159090-1-chris@laplante.io>
References: <20230728160324.1159090-1-chris@laplante.io>
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
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Adds qtest_irq_intercept_out_named method, which utilizes a new optional
name parameter to the irq_intercept_out qtest command.

Signed-off-by: Chris Laplante <chris@laplante.io>
---
 softmmu/qtest.c        | 18 ++++++++++--------
 tests/qtest/libqtest.c |  6 ++++++
 tests/qtest/libqtest.h | 11 +++++++++++
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 1b86489162..0f1d478bda 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -397,8 +397,10 @@ static void qtest_process_command(CharBackend *chr, gc=
har **words)
         || strcmp(words[0], "irq_intercept_in") =3D=3D 0) {
         DeviceState *dev;
         NamedGPIOList *ngl;
+        bool is_outbound;
=20
         g_assert(words[1]);
+        is_outbound =3D words[0][14] =3D=3D 'o';
         dev =3D DEVICE(object_resolve_path(words[1], NULL));
         if (!dev) {
             qtest_send_prefix(chr);
@@ -417,14 +419,14 @@ static void qtest_process_command(CharBackend *chr, g=
char **words)
         }
=20
         QLIST_FOREACH(ngl, &dev->gpios, node) {
-            /* We don't support intercept of named GPIOs yet */
-            if (ngl->name) {
-                continue;
-            }
-            if (words[0][14] =3D=3D 'o') {
-                int i;
-                for (i =3D 0; i < ngl->num_out; ++i) {
-                    qtest_install_gpio_out_intercept(dev, ngl->name, i);
+            /* We don't support inbound interception of named GPIOs yet */
+            if (is_outbound) {
+                /* NULL is valid and matchable, for "unnamed GPIO" */
+                if (g_strcmp0(ngl->name, words[2]) =3D=3D 0) {
+                    int i;
+                    for (i =3D 0; i < ngl->num_out; ++i) {
+                        qtest_install_gpio_out_intercept(dev, ngl->name, i=
);
+                    }
                 }
             } else {
                 qemu_irq_intercept_in(ngl->in, qtest_irq_handler,
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index c22dfc30d3..471529e6cc 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -993,6 +993,12 @@ void qtest_irq_intercept_out(QTestState *s, const char=
 *qom_path)
     qtest_rsp(s);
 }
=20
+void qtest_irq_intercept_out_named(QTestState *s, const char *qom_path, co=
nst char *name)
+{
+    qtest_sendf(s, "irq_intercept_out %s %s\n", qom_path, name);
+    qtest_rsp(s);
+}
+
 void qtest_irq_intercept_in(QTestState *s, const char *qom_path)
 {
     qtest_sendf(s, "irq_intercept_in %s\n", qom_path);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 3a71bc45fc..e53e350e3a 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -371,6 +371,17 @@ void qtest_irq_intercept_in(QTestState *s, const char =
*string);
  */
 void qtest_irq_intercept_out(QTestState *s, const char *string);
=20
+/**
+ * qtest_irq_intercept_out_named:
+ * @s: #QTestState instance to operate on.
+ * @qom_path: QOM path of a device.
+ * @name: Name of the GPIO out pin
+ *
+ * Associate a qtest irq with the named GPIO-out pin of the device
+ * whose path is specified by @string and whose name is @name.
+ */
+void qtest_irq_intercept_out_named(QTestState *s, const char *qom_path, co=
nst char *name);
+
 /**
  * qtest_set_irq_in:
  * @s: QTestState instance to operate on.
--=20
2.41.0



