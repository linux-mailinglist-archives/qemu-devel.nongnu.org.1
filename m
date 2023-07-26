Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3038276294E
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 05:33:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOVGV-0005VJ-8n; Tue, 25 Jul 2023 23:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>)
 id 1qOVGS-0005UZ-I5; Tue, 25 Jul 2023 23:32:40 -0400
Received: from mail-4323.proton.ch ([185.70.43.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>)
 id 1qOVGQ-0007el-Mg; Tue, 25 Jul 2023 23:32:40 -0400
Date: Wed, 26 Jul 2023 03:32:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1690342356; x=1690601556;
 bh=+u4hReE1HgN+L3e9IZjGDlx7yBSheJRATufqrFnZkUo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Lb9zVSPlbAfonms12OjHRKO9w1+s48tJzsOFNGYs5zx+kLSpkNSLDd/XFRL4S6H/8
 IU/7P5uAGOeIxwSgcUz/AXiiASlxRkPSWUsfPHxXZLKjN1OpCpiwzIXQys9emLWUR3
 hb29xnFBveA03ghqPXVmqvScTauRLuMMo3xqTO4ueq/gEy67pC9YdxtXHPBOlZa+tS
 /FrnfU2aoRHZGBc07z5men9ypjkBIqF9L86VOUCh78Q1tVozRe3Tb7XQjo1+rCrEo3
 2/aJJOCby2NAPiqvFX0PMGcRd/Xpy+DOkx6UHwUzz0lf6cKAku5eYOw52EgFsuVzmS
 wtCUc/p6BIZeg==
To: qemu-devel@nongnu.org
From: Chris Laplante <chris@laplante.io>
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Chris Laplante <chris@laplante.io>
Subject: [PATCH v2 4/6] qtest: bail from irq_intercept_in if name is specified
Message-ID: <20230726030450.757462-5-chris@laplante.io>
In-Reply-To: <20230726030450.757462-1-chris@laplante.io>
References: <20230726030450.757462-1-chris@laplante.io>
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

Named interception of in-GPIOs is not supported yet.

Signed-off-by: Chris Laplante <chris@laplante.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 softmmu/qtest.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 7fd8546ed2..1719bbddc3 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -410,6 +410,12 @@ static void qtest_process_command(CharBackend *chr, gc=
har **words)
             return;
         }
=20
+        if (is_named && !is_outbound) {
+            qtest_send_prefix(chr);
+            qtest_send(chr, "FAIL Interception of named in-GPIOs not yet s=
upported\n");
+            return;
+        }
+
         if (irq_intercept_dev) {
             qtest_send_prefix(chr);
             if (irq_intercept_dev !=3D dev) {
@@ -421,7 +427,6 @@ static void qtest_process_command(CharBackend *chr, gch=
ar **words)
         }
=20
         QLIST_FOREACH(ngl, &dev->gpios, node) {
-            /* We don't support inbound interception of named GPIOs yet */
             if (is_outbound) {
                 if (is_named) {
                     if (ngl->name && strcmp(ngl->name, words[2]) =3D=3D 0)=
 {
--=20
2.41.0



