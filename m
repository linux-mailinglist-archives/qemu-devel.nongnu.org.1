Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BE27E075C
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:27:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyxw9-0001km-Lz; Fri, 03 Nov 2023 13:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6645367c8=ross.lagerwall@citrix.com>)
 id 1qyxw7-0001jG-0F
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:26:23 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6645367c8=ross.lagerwall@citrix.com>)
 id 1qyxw4-0000lI-Kt
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1699032380;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yN70GOoQktKPfAW3IF83IxnbcNK56YwJ2jVGY4KfhVk=;
 b=YAH00Q6VMP/TnieZ/S8QPzcxPNszQFfDf/kTQq8W0b+SncgnswToQ1Jj
 6+bHcnnZCVzuwMZG1byQKCSYlEy5v8+EYkqyIknPfWvVSKNniWgTtsL+V
 yJn7OxwLW1ngIu3wqLXrVMF1Vgz0QeSoUK32IFuIQhW2JowrJlif7idIP o=;
X-CSE-ConnectionGUID: 3puI7Y9fT5KL74H8rEvnbA==
X-CSE-MsgGUID: ESGCXgn2QkqXPlMKtyqIYQ==
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 127951790
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.159.70
X-Policy: $RELAYED
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:gfXooKyZ7XODwkksTO16t+cpxirEfRIJ4+MujC+fZmUNrF6WrkVWz
 TAdXzzTbPbZYmShL9tyb4q+9hxU68OByd5mHFdv+CAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjPzOHvykTrecZkidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EgHUMja4mtC5QVnPasT5jcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KTpW6
 N1HGWEDUk2go73q4OKhZ/dqjO12eaEHPKtH0p1h5TTQDPJgSpHfWaTao9Rf2V/chOgXQ6yYP
 ZBAL2MyPVKfO3WjOX9OYH46tP2vnWK5dzRXpUiKrK4zy2PS0BZwwP7mN9+9ltmiHJ8KzxvB+
 TOel4j/KjwhG/evxjzfy3G1ttfLuADnSZszJYTto5aGh3XMnzdOWXX6T2CTsfS/z0KzRd9bA
 0gV4TY167g/8lSxSdvwVAH+p2SL1jYHQMZZGeA+7ACLy4LX7hyfC2xCSSROAPQ+vdIybSwn0
 BmOhdyBLSVitaDQRX+D+7O8qzS0Ni4Ia2gYakc5oRAtuoe55ttp11SWE4clT/bdYsDJ9S/Ym
 CiXjXcP1rsv0O0viPmbrUrqnTSmj82cJuIq3Tk7Tl5J/ysgOt/0P9fwuQGLhRpTBNzHFAXf5
 hDoj+DbvLhUU8zX/MCYaLxVROnB2hqTDNHLbbeD9bEK8C6k/zaYZZpR5j5lTKuCGp1fIWCwC
 KM/VBk42XOyAJdJRfUsC25JI552pZUM7Py8PhwuUvJAY4JqaCiM9zx0aEib0gjFyRZ9wfBiY
 c/HL5jyVh727JiLKxLvGY8gPUIDn31lmws/u7igp/hY7VZuTCHMEupUWLd/Rus48LmFsG3oz
 jqrDOPTk083eLSnMkHqHXs7cQhiwY4TWcqn9KS6t4erfmJbJY3WI6WNkeJ6K9w5zv09eyWh1
 ijVZ3K0AWHX3RXvQThmoFg6AF8zdf6TdU4GABE=
IronPort-HdrOrdr: A9a23:GT6fT6D6ScllFPHlHelW55DYdb4zR+YMi2TDt3oddfWaSKylfq
 GV7ZAmPHrP4gr5N0tOpTntAse9qBDnhPtICOsqTNSftWDd0QPFEGgL1+DfKlbbak/DH4BmtJ
 uJc8JFeaDN5VoRt7eH3OFveexQv+Vu88qT9JnjJ28Gd3AMV0n5hT0JcTpyFCdNNW97LKt8Lr
 WwzOxdqQGtfHwGB/7LfEXsD4D41qT2fIuNW29/OyIa
X-Talos-CUID: 9a23:yBnY4WGGh5DFzFqzqmI87FM1RfF0fEGA71OPf2/oE0t3Tre8HAo=
X-Talos-MUID: 9a23:6ap0tQYoaHs0LOBTmgTDrwFtMp1R4L2eMEQosokXoui1DHkl
X-IronPort-AV: E=Sophos;i="6.03,273,1694750400"; d="scan'208";a="127951790"
To: <xen-devel@lists.xenproject.org>
CC: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard
 <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 <qemu-devel@nongnu.org>, Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] xen/pt: Emulate multifunction bit in header type
Date: Fri, 3 Nov 2023 17:26:01 +0000
Message-ID: <20231103172601.1319375-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.142;
 envelope-from=prvs=6645367c8=ross.lagerwall@citrix.com;
 helo=esa1.hc3370-68.iphmx.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Ross Lagerwall <ross.lagerwall@citrix.com>
From:  Ross Lagerwall via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The intention of the code appears to have been to unconditionally set
the multifunction bit but since the emulation mask is 0x00 it has no
effect. Instead, emulate the bit and set it based on the multifunction
property of the PCIDevice (which can be set using QAPI).

This allows making passthrough devices appear as functions in a Xen
guest.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 hw/xen/xen_pt_config_init.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 2b8680b112fa..e6ec32e3ccd2 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -291,7 +291,10 @@ static int xen_pt_header_type_reg_init(XenPCIPassthroughState *s,
                                        uint32_t *data)
 {
     /* read PCI_HEADER_TYPE */
-    *data = reg->init_val | 0x80;
+    *data = reg->init_val;
+    if ((PCI_DEVICE(s)->cap_present & QEMU_PCI_CAP_MULTIFUNCTION)) {
+        *data |= PCI_HEADER_TYPE_MULTI_FUNCTION;
+    }
     return 0;
 }
 
@@ -676,7 +679,7 @@ static XenPTRegInfo xen_pt_emu_reg_header0[] = {
         .size       = 1,
         .init_val   = 0x00,
         .ro_mask    = 0xFF,
-        .emu_mask   = 0x00,
+        .emu_mask   = PCI_HEADER_TYPE_MULTI_FUNCTION,
         .init       = xen_pt_header_type_reg_init,
         .u.b.read   = xen_pt_byte_reg_read,
         .u.b.write  = xen_pt_byte_reg_write,
-- 
2.41.0


