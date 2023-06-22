Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D6B739897
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:56:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFAl-0004DC-7p; Thu, 22 Jun 2023 03:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00040r-8U
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002rc-95
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:00 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MA7b8-1qMeEw0j1u-00BaNI; Thu, 22
 Jun 2023 09:55:48 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/24] q800: rename q800_init() to q800_machine_init()
Date: Thu, 22 Jun 2023 09:55:24 +0200
Message-Id: <20230622075544.210899-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e2khBa/uvB5RS0TqFzxpxE+Lq/QC44XzgMLdrVhVGkQ3vJO/zGs
 vQzZyRyAJpx0hRb0lOW/1YhMjTfdGbULIfykyOF7NH71UAT2YuES9aGsHwpv5I+dMnJsVf6
 fhsh8NeSIznwon6ee6VTum4qP63ti6vzSQI8kX6TL+ha1XLOn0mEvUoRamphyCwjRMgdg5F
 ktNrqlGgiYlUk/S+WCZhw==
UI-OutboundReport: notjunk:1;M01:P0:YTjOggislO0=;Rjgkiv7hnho2NMOnniM0Zfiu+C8
 Oe5L5euBEYLZVVH4qLxVUdQwK81vUvKQCufOBCy9bJvQtzTsIBuSIrBoWUDeIu3h/CXpncuNt
 cEOyNlP1Jove3JlQO0OnMeMAiRrY1r1RnhBIheNSJXWuzdamXSlCPr5LmNEBaCk0NX1pXTQ2k
 OeStYcpu3xs0ixal9J/11fGiXa9lbpp+fNc/UkYoRWSEBxcqhxoS42JX4tYu1k0grrBNoH69T
 XMAlvaFkbrpy/YrzdNhPU77Yt1fPaBV2gsS9Iz405yC2yQcMgZdKo0pulWXHyzB0alq97tedi
 Oi30MVhJBzFtLRoXqBxrH9vb26N+YsVXp18AYbtN0qpTxQEIvFDKwR5V8LJZ+kY+b9FxIiA6M
 92E0ZmlOLrCDBtIGwbwhVC/xjNhDyOQfoiH4gu6VmAsWbEs/wmM9Hcp/ZZNAkOlxmsEyggbwi
 zUBUTCdy+224wC6bvASfJjfBzk6ANfUMtCa9cdA/OkJn/PzfNrZyxvWEc2x0i6iC8zsFvrUqA
 VHu+kMU8pYXrWxgoEJSREK9gsTCjjyePaplxMnFyzMrCC8y5oNpE5niuJGk6rqiVJWR1cwozx
 72iUUe3U7YB0Gv/er1ewovgiDv1vDt5jo3STpxjr7Ec5az+ILQCT05tuNxb5aqvTNrq5uGOX2
 198YMk4lwq5KDdzYIuw3ZZsaTbpQc0NBgernkzJx2g==
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This will enable us later to distinguish between QOM initialisation and machine
initialisation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230621085353.113233-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index c0256c8a904c..062a3c6c7614 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -362,7 +362,7 @@ static uint8_t fake_mac_rom[] = {
     0x60, 0xFE                          /* bras [self] */
 };
 
-static void q800_init(MachineState *machine)
+static void q800_machine_init(MachineState *machine)
 {
     M68kCPU *cpu = NULL;
     int linux_boot;
@@ -738,8 +738,9 @@ static const size_t hw_compat_q800_len = G_N_ELEMENTS(hw_compat_q800);
 static void q800_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Macintosh Quadra 800";
-    mc->init = q800_init;
+    mc->init = q800_machine_init;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
     mc->max_cpus = 1;
     mc->block_default_type = IF_SCSI;
-- 
2.40.1


