Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BA78BE2BD
	for <lists+qemu-devel@lfdr.de>; Tue,  7 May 2024 14:57:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4KN6-0001Vo-Dl; Tue, 07 May 2024 08:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1s4KN3-0001UF-R3
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:56:37 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1s4KN1-0004UN-TY
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:56:37 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1s4KMw-000MDT-T4; Tue, 07 May 2024 14:56:30 +0200
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1s4KMw-000Jiz-1F; Tue, 07 May 2024 14:56:30 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 4FD81480182;
 Tue,  7 May 2024 14:56:30 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ek6Fqv7eoNyi; Tue,  7 May 2024 14:56:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id EBD5F4801C3;
 Tue,  7 May 2024 14:56:29 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ajyio7jF6cSZ; Tue,  7 May 2024 14:56:29 +0200 (CEST)
Received: from zimbra.eb.localhost (unknown [192.168.96.242])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id CC032480157;
 Tue,  7 May 2024 14:56:29 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: devel@rtems.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/intc/arm_gic: Fix set pending of PPIs
Date: Tue,  7 May 2024 14:56:23 +0200
Message-Id: <20240507125624.86731-1-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <CAFEAcA8DAt+o-XZepg8xtj4i3xLW_yChwPnDZVM0O=rW8+9qJQ@mail.gmail.com>
References: <CAFEAcA8DAt+o-XZepg8xtj4i3xLW_yChwPnDZVM0O=rW8+9qJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27268/Tue May  7 10:25:13 2024)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

According to the GICv2 specification section 4.3.7, "Interrupt Set-Pendin=
g
Registers, GICD_ISPENDRn":

"In a multiprocessor implementation, GICD_ISPENDR0 is banked for each con=
nected
processor. This register holds the Set-pending bits for interrupts 0-31."

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 hw/intc/arm_gic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 4da5326ed6..20b3f701e0 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1296,12 +1296,14 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
=20
         for (i =3D 0; i < 8; i++) {
             if (value & (1 << i)) {
+                int cm =3D (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CPU_M=
ASK;
+
                 if (s->security_extn && !attrs.secure &&
                     !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
                     continue; /* Ignore Non-secure access of Group0 IRQ =
*/
                 }
=20
-                GIC_DIST_SET_PENDING(irq + i, GIC_DIST_TARGET(irq + i));
+                GIC_DIST_SET_PENDING(irq + i, cm);
             }
         }
     } else if (offset < 0x300) {
--=20
2.35.3


