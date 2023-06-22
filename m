Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D93407398C2
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:58:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBL-0004yh-FI; Thu, 22 Jun 2023 03:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAh-00046c-Vf
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:04 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAe-0002uZ-Q7
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:03 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mduym-1pdS3941Ze-00b6Dd; Thu, 22
 Jun 2023 09:55:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/24] q800: don't access Nubus bus directly from the
 mac-nubus-bridge device
Date: Thu, 22 Jun 2023 09:55:41 +0200
Message-Id: <20230622075544.210899-22-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xKDB1N2Vb5k8Q0aeD3s/Fhreig6jvObF6SMwOyfWR9SUtrEwYzx
 6awIEwnLarCs3Tx/79Er0Vgdw1sWVSvMnWIiUqcD0QwN0Tl+RABHzPbf+MxTVVCcax+Omm6
 buK8Ym70Wq0yaxjUO7fk3V/PF0nnf7VseasP+Fii9cc7SDJjdhtUSXQKSQpxj26TMnnwy/j
 1TXZT8visCBuhrmbzAmSQ==
UI-OutboundReport: notjunk:1;M01:P0:2LHCEWTXjI8=;9adtCI2hNubtSsgYhDUqUNivMkX
 tnpAatcccT8ooxZ9/L7NJ+nny7uWJEagQdF8oRkwKvXkVhmCGo6K6IJag8gLJaEdOFXERF+QR
 cUvuRd8iFI2KdHSI6Fluxe1a6IXLamzCKkYB9dsuQhNcRd6GMN36ERr1G4F6nGukBBAVjTy5E
 6AyTmBpVpS0UpBCaf13b5X5C1zgcoEkjYBN7aDdELnsrmdD+HV27u52pIL+RcwmO5ACPmWabr
 hbCSAIpPN0xsERS1GLzofdX0uniqo0b0EJb6n/tccxBz8060YHDs7C6R3oH5zKm9ijC1QZnol
 I/aeDimy+iiiK5qPUvQMgbFOP/A5COPvhEHAPTMepyRommarY8NdMySZgyINzbfdKxjIAEEuB
 ssSf6RlWO9/wtM/SD5K8pUJ54UJlJf2FxnvYb9olSKip/rdzaCsNoPC6Ds/7GEHnvfZK7w3RF
 SG70A7TXoFp4IWMs+p4ze7Cl3ICZU8RIAVafS4U59BLptHcqh056hzzd8xQaoZFkqS0n8itX8
 kChoqgQp4W4Y8aN10Z2BOSk59w6itp0tqL4CEv317/zbTXgSiRMXD2pcAsIGvKB2it4lghdnQ
 aAHvEkrMfMT+av9hNE7LkGlsVOEnVzV/RtKhCGL0o3v+LggcSajINLiQfNGMz4mo5RRBAVMbT
 D6ua9kK9YGXuqiy4QEBtaJt1jJ5DQxlgzVD7wFHuKA==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Instead use the qdev_get_child_bus() function which is intended for this exact
purpose.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230621085353.113233-22-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index b22651931a22..a32e6fbf8dec 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -448,7 +448,7 @@ static void q800_machine_init(MachineState *machine)
                           qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
                                                  VIA2_NUBUS_IRQ_9));
 
-    nubus = &NUBUS_BRIDGE(dev)->bus;
+    nubus = NUBUS_BUS(qdev_get_child_bus(dev, "nubus-bus.0"));
 
     /* framebuffer in nubus slot #9 */
 
-- 
2.40.1


