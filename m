Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA0A7398C6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFAj-00047q-Pk; Thu, 22 Jun 2023 03:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00040a-4D
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002sS-89
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:00 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MMX9b-1qU2ld1R3f-00JbmL; Thu, 22
 Jun 2023 09:55:50 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/24] q800-glue.c: switch TypeInfo registration to use
 DEFINE_TYPES() macro
Date: Thu, 22 Jun 2023 09:55:28 +0200
Message-Id: <20230622075544.210899-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9N/NQmf2WWvqvbqNf01BXOYYLqsY2uavhlIrVnaPUL6HkequFdM
 4Iok9Bl0A+oFCFtDFBrUe+1YcZI+5UEC9aMli8q7wdNJH8MCY8KV2+wZ5NXX90D/zDNHNCN
 2valk7vT8nzbw14LJtU+30sspHP6sN9JNwiIz37/j8wsP5AXCaC8RRUYDI2yWpA66FZBHml
 oL6di+zu92+sZgqHB6pHw==
UI-OutboundReport: notjunk:1;M01:P0:Rrfnv/fOYPE=;/6ceZQu61dYnn6UgHHmfTU1R1PH
 vZ95eHhqgEqEp27zkPgpGA9xNhzBtUjeTZsZZZ8SsFUxAMfe3XkisQ+SB44jWAQTWeYoutsVc
 bgIA1OMbVA/a1simlMsW6jd9hcKbXgTcbfC4IAEEYSeyKz0KVz2idJaFPSCkvzuTkkval5Tpf
 LchW/XDBp1VOYJjaxChjvXbLuUPBg8zBrsDIK2LcZpEJeBUtKFEgbwx1+C28DD4jPL1I299Tv
 Pd96vw3GxjkBN2OjDIlZHgMpeHhZq/Xt3JPYD+d4YC9zaqnS4j3EaubJRdonMc6MzkgjDPxOj
 EicpgaZ2rnGdudnRIjYxG6zpAhgdVnu9lf6EVGXvvUJ5bU9oOLoQzY5WNbEu4VA+iiCo3EzpY
 cgB2OQm8S/9d9nFYEKR1CJ35bSwahZI6FHNZbZFh6Or7GTJjdk8ptIfFveSPV0Xam0QkZh4EO
 RR+NVToNwRXXPl8yHxxVzu14BsOsZFgfxXjRi3TObWdePFGUFLk3jAR1/7UqbGtuXTiTznwyf
 Q2q194puE6yRpIO8MjXKpXDGGik7ZXyMDVRmcDHLstR2QSUpGmOMp6rcnxLRdcsfiwEbBNj45
 80h25V1BS4Y1sW6rxYnYRpwcQHN7ARfr3esftvWgLhtcotHBzaOE3Fj9D7thzeX/zbNfjpNMS
 RP8i+KjSLdVIjUt8wXxvEAGGwJM+C7bsHHzb/DtRjA==
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

The use of the DEFINE_TYPES() macro will soon be recommended over the use of
calling type_init() directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230621085353.113233-9-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800-glue.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index e81f9438f116..34c4f0e9876d 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -231,22 +231,19 @@ static void glue_class_init(ObjectClass *klass, void *data)
     nc->nmi_monitor_handler = glue_nmi;
 }
 
-static const TypeInfo glue_info = {
-    .name = TYPE_GLUE,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(GLUEState),
-    .instance_init = glue_init,
-    .instance_finalize = glue_finalize,
-    .class_init = glue_class_init,
-    .interfaces = (InterfaceInfo[]) {
-         { TYPE_NMI },
-         { }
+static const TypeInfo glue_info_types[] = {
+    {
+        .name = TYPE_GLUE,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(GLUEState),
+        .instance_init = glue_init,
+        .instance_finalize = glue_finalize,
+        .class_init = glue_class_init,
+        .interfaces = (InterfaceInfo[]) {
+             { TYPE_NMI },
+             { }
+        },
     },
 };
 
-static void glue_register_types(void)
-{
-    type_register_static(&glue_info);
-}
-
-type_init(glue_register_types)
+DEFINE_TYPES(glue_info_types)
-- 
2.40.1


