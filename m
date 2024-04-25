Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 293888B22F3
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Apr 2024 15:38:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzzIu-0003Fr-CO; Thu, 25 Apr 2024 09:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1rzzIp-0003Fg-Fh
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 09:38:19 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1rzzIm-00007j-K5
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 09:38:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id DCBC660AB8;
 Thu, 25 Apr 2024 16:38:07 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:8928::1:1e])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1cMZOS3IdeA0-CEog7zTA; Thu, 25 Apr 2024 16:38:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714052287;
 bh=QcXoRXBIeDEitezOvzR9Z/eG00TJczRwkbAOh24raWY=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=vdbm9nvq1oy+Hj+tkOKm+LpA5l8F2P1PiX48RilvY3IAAwe+xolc0sRx/UTLOEhcA
 gLmOcridXuTrEbe0wjenus9EMaMoqaCiOgACPI0Be5aDZOCFFhbTkasfcUJy9KqX2J
 16QdhAHdy1m5QDkMKFZxwT4viBN9McVLTNqFiLJw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] mc146818rtc: add a way to generate RTC interrupts via QMP
Date: Thu, 25 Apr 2024 16:37:45 +0300
Message-Id: <20240425133745.464091-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This can be used to force-synchronize the time in guest after a long
stop-cont pause, which can be useful for serverless-type workload.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/rtc/mc146818rtc.c         | 15 +++++++++++++++
 include/hw/rtc/mc146818rtc.h |  1 +
 qapi/misc-target.json        | 16 ++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index f4c1869232..6980a78d5f 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -116,6 +116,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
     }
 }
 
+void qmp_rtc_notify(Error **errp)
+{
+    MC146818RtcState *s;
+
+    /*
+     * See:
+     * https://www.kernel.org/doc/Documentation/virtual/kvm/timekeeping.txt
+     */
+    QLIST_FOREACH(s, &rtc_devices, link) {
+        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
+        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
+        qemu_irq_raise(s->irq);
+    }
+}
+
 static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
 {
     kvm_reset_irq_delivered();
diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
index 97cec0b3e8..5229dffbbd 100644
--- a/include/hw/rtc/mc146818rtc.h
+++ b/include/hw/rtc/mc146818rtc.h
@@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
 void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val);
 int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
 void qmp_rtc_reset_reinjection(Error **errp);
+void qmp_rtc_notify(Error **errp);
 
 #endif /* HW_RTC_MC146818RTC_H */
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 4e0a6492a9..20457b0acc 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -19,6 +19,22 @@
 { 'command': 'rtc-reset-reinjection',
   'if': 'TARGET_I386' }
 
+##
+# @rtc-notify:
+#
+# Generate an RTC interrupt.
+#
+# Since: 9.1
+#
+# Example:
+#
+#     -> { "execute": "rtc-notify" }
+#     <- { "return": {} }
+#
+##
+{ 'command': 'rtc-notify',
+  'if': 'TARGET_I386' }
+
 ##
 # @SevState:
 #
-- 
2.34.1


