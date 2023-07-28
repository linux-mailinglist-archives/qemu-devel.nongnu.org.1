Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB36767200
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 18:38:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPPxx-0004xP-AP; Fri, 28 Jul 2023 12:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>)
 id 1qPPxv-0004wm-0j; Fri, 28 Jul 2023 12:05:19 -0400
Received: from mail-4323.proton.ch ([185.70.43.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>)
 id 1qPPxt-0004eS-AZ; Fri, 28 Jul 2023 12:05:18 -0400
Date: Fri, 28 Jul 2023 16:05:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1690560315; x=1690819515;
 bh=5mJBH2avifG4/P8iPdPedQfA6UtFs96ajMwje8eMy2s=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=h4MYg/NM9tEY67P1Y6089itidh+DuArYd2t+fC23fOpIGIvEUZuaAqYBNnMRSDwqr
 SlJpZ8CqlrqdYGbdWFdwWRahCqqHNfGEZIZqrh/jzHfu9DqcuPPdTrwRhWH2tP54cz
 ur1YXdV96+nOyZ/pxRfbjJ2Vj30sABO9VOpuGHf90PkSfHx8xejNj/ziy795MSfIXT
 OWAjk2oCsUnZzXnCw1Ca/l0X+8w76DvJS23aYOx7TOrzYreIi6vGqrhlIerFjWBdZ8
 rFPL4XN8ls3mJRsvzlU4oihyN4ut3i79bBgnBQcrIan/DAxKPhgH1OThL1+06p6E9l
 cwdzu1OjL0fEA==
To: qemu-devel@nongnu.org
From: Chris Laplante <chris@laplante.io>
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Chris Laplante <chris@laplante.io>
Subject: [PATCH v3 5/6] qtest: irq_intercept_[out/in]: return FAIL if no
 intercepts are installed
Message-ID: <20230728160324.1159090-6-chris@laplante.io>
In-Reply-To: <20230728160324.1159090-1-chris@laplante.io>
References: <20230728160324.1159090-1-chris@laplante.io>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.23; envelope-from=chris@laplante.io;
 helo=mail-4323.proton.ch
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

This is much better than just silently failing with OK.

Signed-off-by: Chris Laplante <chris@laplante.io>
---
 softmmu/qtest.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 66757ba261..35b643a274 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -399,6 +399,7 @@ static void qtest_process_command(CharBackend *chr, gch=
ar **words)
         NamedGPIOList *ngl;
         bool is_named;
         bool is_outbound;
+        bool interception_succeeded =3D false;
=20
         g_assert(words[1]);
         is_named =3D words[2] !=3D NULL;
@@ -435,15 +436,22 @@ static void qtest_process_command(CharBackend *chr, g=
char **words)
                     for (i =3D 0; i < ngl->num_out; ++i) {
                         qtest_install_gpio_out_intercept(dev, ngl->name, i=
);
                     }
+                    interception_succeeded =3D true;
                 }
             } else {
                 qemu_irq_intercept_in(ngl->in, qtest_irq_handler,
                                       ngl->num_in);
+                interception_succeeded =3D true;
             }
         }
-        irq_intercept_dev =3D dev;
+
         qtest_send_prefix(chr);
-        qtest_send(chr, "OK\n");
+        if (interception_succeeded) {
+            irq_intercept_dev =3D dev;
+            qtest_send(chr, "OK\n");
+        } else {
+            qtest_send(chr, "FAIL No intercepts installed\n");
+        }
     } else if (strcmp(words[0], "set_irq_in") =3D=3D 0) {
         DeviceState *dev;
         qemu_irq irq;
--=20
2.41.0



