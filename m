Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F35D7BCCA0
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:26:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCr-00084f-W5; Sun, 08 Oct 2023 02:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCo-000834-2B
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:58 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCl-0007je-UU
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:57 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MN4qp-1r8HdN0PG1-00IzKn; Sun, 08
 Oct 2023 08:23:52 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 01/20] q800-glue.c: convert to Resettable interface
Date: Sun,  8 Oct 2023 08:23:30 +0200
Message-ID: <20231008062349.2733552-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+lJL08/qeSbH7s6Z0vBod0TfLv6gmbLFH0LCl82OaUr1Rh6fGUg
 mDNYeB1By4DGTTSivNccVomp0iRuqB3uXXtfdcLfnL1w/zRW+iC66dTTZ1ZoM3DVZk9ouF3
 P4pKTwmGvsdBme32POg5B5nZzScKMYM9QEDqnTGW3NAPPrkxDrPh9fL/QaLAzH8YfmaKU9a
 7PEjxG78WmN1FbeGTn8yw==
UI-OutboundReport: notjunk:1;M01:P0:58aXnF3sjWo=;vBxjtR8iXKjdBezr43Qd/rm6njB
 t/Xf0l3HovAvjmE4zkoQH64Z5Bpvach1tsleAx15FhpDcUjKXv91p3Biq2gbW1U4tUIGXQmkb
 v2UFR/WukJgG+sam13VuDMrSDa0Ck+WMg6SlkiDerxmTagUMWKIDchi4T+gCwnRUejEnNLplK
 IoEsUyxzBt3QwaJJ+25au0pYAgfL0/69W7RewkqNkcSnrgA/UxgpKIAzspn0XgMJ5W+S+/0Dj
 kweQ1YSGxQ4sHOUJuKehn+PCixwM09vC9eyuv772lpsM/nZXbFecStHjO6eiTKm4PQMMSRQkU
 lL014K8rZ+HwvcIUAcuMwSUe9MkUHoBlPkx587g//sU3ACSB4JhRMg41HDe5N0Ar8MONP773P
 Qdvrt36BHKFodkN5KybrVU4SXEtiEW4pRdghHEt1bRgYMT0IJxruzDvBIayyPY6G4h6hJVtAI
 0sEoGxGObPYr1TagboeAfQMXrpvEY3h6233slc9RFd0N6SO9rVMnvDrflk37hWkmvQsNYsA/A
 2fmSIlGeFGVykVtD0YK52uz5ASt3qUquqfW8U/JMAftAmTQMBgc7wpIAcwXfHlnCJuA8qYcDe
 vXhEWfcWN/WwWqfb2Uwa9t064Zfm20zcj3fGFh0hXLc4SbOq5VrzHp8UBmCxq9/Db1KMiYwyN
 uyvoLY7u5cvA+7M8a9zxI1jqLiykGq5no0GvPdC8QEWcJosBx6IIZH5dCV8gxSWLvJ8NQXmqZ
 2JerpcBjF8F+7mJ85xFVBOGlhwr2BHMtxJDxL8kFXClSIJaiapEnyvoiIxbQ5Q2ctUA5ces8a
 /UGh5fmlqVrpoXnqtRRGD5i04ObbC8lbUewudznti6KawY5A+fa9hQ/OiOfjP6K1gMyxcw/lM
 JgKo1QBcXr29+aA==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.376, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Convert the GLUE device to 3-phase reset. The legacy method
doesn't do anything that's invalid in the hold phase, so the
conversion is simple and not a behaviour change.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800-glue.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 34c4f0e9876d..710a5c331ec9 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -166,9 +166,9 @@ static void glue_nmi_release(void *opaque)
     GLUE_set_irq(s, GLUE_IRQ_IN_NMI, 0);
 }
 
-static void glue_reset(DeviceState *dev)
+static void glue_reset_hold(Object *obj)
 {
-    GLUEState *s = GLUE(dev);
+    GLUEState *s = GLUE(obj);
 
     s->ipr = 0;
     s->auxmode = 0;
@@ -223,11 +223,12 @@ static void glue_init(Object *obj)
 static void glue_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     NMIClass *nc = NMI_CLASS(klass);
 
     dc->vmsd = &vmstate_glue;
-    dc->reset = glue_reset;
     device_class_set_props(dc, glue_properties);
+    rc->phases.hold = glue_reset_hold;
     nc->nmi_monitor_handler = glue_nmi;
 }
 
-- 
2.41.0


