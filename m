Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB187BCC9A
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:25:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCq-00083w-Cu; Sun, 08 Oct 2023 02:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCn-000831-Tk
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:57 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCm-0007kC-9D
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:57 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N5W4y-1rdWpn39Wk-016w4I; Sun, 08
 Oct 2023 08:23:53 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/20] q800: implement additional machine id bits on VIA1 port A
Date: Sun,  8 Oct 2023 08:23:33 +0200
Message-ID: <20231008062349.2733552-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4fwlCJcpo+YxeP1TmhOVT7uT5s5OUex8INj15TnlpJbbpyhvwnP
 ATO8e0StciARnF65AmV3CXA7AptkyNeE7hb18nh7kuPz3heaW66vrQILdjl7bRI4erAmflr
 jIhCQoMbqNpyVNPGIgmDvPfKJEIHvPawGmtS+DxG72r41TcdXNqTRa+UzbVWak3Uo2rEB8A
 DMljmUO0G4sLNoZjio47Q==
UI-OutboundReport: notjunk:1;M01:P0:Ee3DbdwXLlI=;c67e8BYwp4wZbsG+yMJjqL3UHs7
 FerB1MNQ0cKeIPyIi2EJ+F5NwuaLORh9pEkb31Rsunzpd/96R/xXy8r79XUFk9QkgdjqbWQ4S
 0JlnretVYDnljF8SZlYw0I9JQRrpHibAP4QehMIsiGVY0l62Tzt5tN5tsAdycEI/Mx0rfHOtL
 SVD2DXAJpFlPLSSh+SCN/dF28Ofx4otViEj0rae6FPBMvQREcQ8uQ4HuIoEiYwTik8mdiuRnp
 oedkNybsfOJwikO3rDMfjVQX50EB1Xubrpw5jnfbBbEFW3GCyAj7LQb5Xwqsu9nPoBiBaKT6o
 b/7CDFi/S1W0GxBxyoAhcq7CIyWCRl8ML3au6ChG35n9fr0oNyKtudNoCPwinWdkAQ4KUMn3v
 0V5BJn4Zv7RgRELtQT7cYeNFkD3ZuyoTwSYkUH0GD2lyUpq4K5iN23F1yQaNh4HQ4wummosYs
 /3JYpESDOjkftaB7+Or9Z76ZpM6rJgHBosX/4QsOKHv0rdJF596BDXNCmMwtdrS5Aw1BIT5lY
 eQ5zHf9QFOlneCKykF0JssCenrFiaNRouxO7gtbR38si23sHpdC1eFgsLPqSr8JcBlqF2xCkk
 /wpxjyMo6GtWvlNForFp3UTqhOmLrq2zpoh08heMqXIJvGrry2cMhvzj+gUhqX1mXxB+ISda2
 bq6Kuqx67zCjUAxjabTK9F9jZS8D+1G9MIRaW77ldo9usNUvVvGeAbhnGTtwuxuPJaIImg9K+
 e4Gvh5tdkFcUsn9SihtVHNR6ADO/Nv4vEmMrXkcrrRKXVEnzlP3+vma1wIXq+P1eHc0OyDKef
 h8bbDI4xZ+UffWbXhjhkVKmrX8Gpl7ZX3fvMQDro/EUhcMpMFGwlH7UGW+pF7KxbF/fgjXwth
 aYa6WvyvgP7DQMQ==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Co-developed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004083806.757242-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index f84cc68849ab..e87a1b82d8c5 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -114,6 +114,9 @@
 #define VIA1A_CPUID1    0x04    /* CPU id bit 0 on RBV, others */
 #define VIA1A_CPUID2    0x10    /* CPU id bit 0 on RBV, others */
 #define VIA1A_CPUID3    0x40    /* CPU id bit 0 on RBV, others */
+#define VIA1A_CPUID_MASK (VIA1A_CPUID0 | VIA1A_CPUID1 | \
+                          VIA1A_CPUID2 | VIA1A_CPUID3)
+#define VIA1A_CPUID_Q800 (VIA1A_CPUID0 | VIA1A_CPUID2)
 
 /*
  * Info on VIA1B is from Macintosh Family Hardware & MkLinux.
@@ -872,9 +875,18 @@ static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
 {
     MOS6522Q800VIA1State *s = MOS6522_Q800_VIA1(opaque);
     MOS6522State *ms = MOS6522(s);
+    uint64_t ret;
 
     addr = (addr >> 9) & 0xf;
-    return mos6522_read(ms, addr, size);
+    ret = mos6522_read(ms, addr, size);
+    switch (addr) {
+    case VIA_REG_A:
+    case VIA_REG_ANH:
+        /* Quadra 800 Id */
+        ret = (ret & ~VIA1A_CPUID_MASK) | VIA1A_CPUID_Q800;
+        break;
+    }
+    return ret;
 }
 
 static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
-- 
2.41.0


