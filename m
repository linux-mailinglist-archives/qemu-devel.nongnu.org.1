Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 350997262A3
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:20:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u0q-0002sD-P4; Wed, 07 Jun 2023 10:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0p-0002rj-AF
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:47 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0m-0003Qw-J1
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5gV1SE4LsSi6EgcoPhMMnPemRAYlH4p9c99lFdvAzmc=;
 b=YkNRtkhSqnKdMytulGjCctvwj7OCt5/D9Wn1wwOf/3AO+wu00l4tM2ms
 xxKvjE2Azz0RTYQVgz27GOc+HWdwJsr7BRNL0Zk38VTKdYmT694JmbpNp
 oXEke6yqgp28rMgw0hmHLRq5d4HHcWUyK+A+SAMkZLBSPDbtS3prrF1QR 8=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 111808771
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:Fc/cyqyzlsriS80Ub7N6t+cxxirEfRIJ4+MujC+fZmUNrF6WrkVRn
 2pMWmiCa67eYWugeI8kaIy+9E5Q7cfdyoIyHVBp+SAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EsHUMja4mtC5QRgPa8T5jcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KUBB/
 tcyNSo/VBOKu8KG67PlYdZmuO12eaEHPKtH0p1h5TTQDPJgSpHfWaTao9Rf2V/chOgXQ6yYP
 ZBAL2MyMlKZOUYn1lQ/UfrSmM+hgGX/dDtJ7kqYv6Mt70DYzRBr0airO93QEjCPbZwMxxbA9
 j2ZpgwVBDlEKMzB+Aeo8UmWh9Xxvzj4fKEjTK+3o6sCbFq7mTVIVUx+uUGAieC0j1P7V99BJ
 kg8/C0ooq4vskuxQbHVRB21pmKJrzYTXtNRF6sx7wTl90bPy1/HXC5eFGcHMYF48pZsHlTGy
 2NlgfvICjdEmqCPe0ie/4u0nRizZwMqJ1ErMHpsoRQ+3/Hvp4Q6jxTqR9llEbKogtCdJQwc0
 wxmvwBl2exN0JdjO7GTuAme3mny/sShohsdvF2/Y46z0u9uiGdJjaSM4EOT0/tPJZ3xorKp7
 CldwJj2AAzj4PiweM2xrAclRunBCxWtame0bbtT834JqVyQF4aLJ9w43d2HDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPdLvU5t0l/S7RIi8PhwxUjaoSsIpHONg1Hs3DXN8Iki3yBR8+U3BE
 cnznTmQ4YYyVv08kWveqxY12r433CEurV4/triipylLJYG2PSbPIZ9caQvmUwzMxP/cyOkj2
 4oFZpTiJtQ2eLGWXxQ7BqZNdQ1bcyJmX8meRg4+XrfrHzeK0VoJU5f5qY7NsaQ/90iJvo8kJ
 k2AZ3I=
IronPort-HdrOrdr: A9a23:tZVy6qOZ3UBaU8BcTz/255DYdb4zR+YMi2TDiHoedfUFSKOlfp
 6V8MjzjSWE9Qr4WBkb6LW90dq7MA/hHP9OkMQs1NKZNjUO11HYVb2KgbGSoAEIXheOjNK1tp
 0QP5SWaueAdWSS5PySiGLUcrYdKZu8gduVbIzlvhNQpHRRGsddBnBCe2Gm+yNNNWt7LKt8MK
 DZyttMpjKmd3hSRsOnBkMdV+yGi8zXmIngaRsmAQdizAWVlzun5JPzDhDdh34lIn1y6IZn1V
 KAvx3y562lvf3+4hjA11XL55ATtMr9xsBFDMmsjNFQDjn3kA6naKloRrXHljEop+OE7kosjb
 D30lgdFvU2z0mUUnC+oBPr1QWl+i0p8WXexViRhmamidDlRRohYvAxxb5xQ1/80Q4Nrdt82K
 VE0yayrJxMFy7Nmyz7+pzhSwxqrEypunAv+NRjzEC3ELFuKoO5n7ZvuH+9I61wWx4SL7pXVt
 WGOfusocq+t2nqNkwx8FMfmOBEFU5DYStuCnJyxPB9lQIm3UxR/g8g38oYkW4H9JUhD7d5x8
 msCNUzqJh+CvYMa6RzHeEARtbyLFfsb1bjDEK+SG6XT53uHRr22sLKCXEOlbyXUY1Nw50olJ
 vbVlRE8WY0ZkL1EMWLmIZG6xbXXQyGLHzQ49Ab5YNwtaD8SLrtImmEVE0kldemrpwkc7jmsl
 mISeBr6tLYXB3T8LxyrkTDcogXLWNbXNweu949VV7LqsXXKpfyvuiedPrIPrLiHTstR2u6Wx
 I4LXLODdQF6lruVm7zgRDXVX+ockvj/YhoGKyf++QI0oACOoBFrwBQg1Wk4cOALyFEr8UNDQ
 BDCaKilrn+qXi9/G7O4WksMh1BDlxN6LGlSH9OrR9iCTKCTV/CgaTqRYl/5gr1GvYkdbKmLO
 d2nSUGxZ6K
X-Talos-CUID: =?us-ascii?q?9a23=3ATyQ6zGuE7jxlvHK3BBnMlAiL6IsEfXb25mrKEXW?=
 =?us-ascii?q?7AFpJeJaUF3Sv8p1Nxp8=3D?=
X-Talos-MUID: 9a23:jDrUHgnsppNZSQ/Y1Xygdno8KNc20pmDC3s3kK84mdKHEQ9BYyWS2WE=
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="111808771"
To: <qemu-devel@nongnu.org>
CC: Bernhard Beschow <shentey@gmail.com>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 07/12] hw/isa/piix3: Reuse piix3_realize() in
 piix3_xen_realize()
Date: Wed, 7 Jun 2023 15:18:34 +0100
Message-ID: <20230607141839.48422-8-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.153;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa2.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Bernhard Beschow <shentey@gmail.com>

This is a preparational patch for the next one to make the following
more obvious:

First, pci_bus_irqs() is now called twice in case of Xen where the
second call overrides the pci_set_irq_fn with the Xen variant.

Second, pci_bus_set_route_irq_fn() is now also called in Xen mode.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Tested-by: Chuck Zmudzinski <brchuckz@aol.com>
Message-Id: <20230312120221.99183-3-shentey@gmail.com>
Message-Id: <20230403074124.3925-4-shentey@gmail.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/isa/piix3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 6651521a46..800b80f2bb 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -409,7 +409,7 @@ static void piix3_xen_realize(PCIDevice *dev, Error **errp)
     PIIX3State *piix3 = PIIX3_PCI_DEVICE(dev);
     PCIBus *pci_bus = pci_get_bus(dev);
 
-    pci_piix3_realize(dev, errp);
+    piix3_realize(dev, errp);
     if (*errp) {
         return;
     }
-- 
Anthony PERARD


