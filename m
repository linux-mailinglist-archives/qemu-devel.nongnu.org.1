Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7BD7727BA
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:29:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT1Dk-0000eh-QB; Mon, 07 Aug 2023 10:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qT1DX-0000cm-9h
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:28:21 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qT1DU-0008Ml-Nx
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691418492; x=1692023292; i=deller@gmx.de;
 bh=WleLY8uGuMYrGl8dabHk4E7xnUF5qFh/Vgwd6oO32mw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Ijc85GgHby3Dcq+LxfjEUiV2IfUfrG5PJXNc1ZcdmzFBijUT5HWJgbCYz8a7Em4R8Z2fyDy
 K2MUttiz+vScM00Ky/ocv5WEJS4UjFg+lKmiBBIrLL3gRg25kvHttgZ9BBCRdKdEZ7VRHaxGD
 MeZ+ixMLDiMvXVx/ufpdejC+H+zRFHbA90BXYwPnDfw4XeTJ7dplUK0mXDvyv5jGd2Qc/uvVU
 0/fB0nWcw/OMWdCX0uwMpQLfRp6YBkAlEDfk4+L2RwO2f1hdv3mgr3hFDiH/hM3uhfvdyXoNG
 +HAUd0PJh8QA8ohdrbbdDS3w/qieN5ZZgO9TjDxuyHHb6hjxIynA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.52]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsYx-1qbTWN1pUt-00HMZ2; Mon, 07
 Aug 2023 16:28:12 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH] tcg/i386: Check for shorter instruction sequence for ARITH_AND
Date: Mon,  7 Aug 2023 16:28:07 +0200
Message-ID: <20230807142807.60719-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o+n7dX5D3wHjEquPgPKaSBs23QsD7GeD2wSf0oT/87wTsgxQpIg
 dPJgsqjg9VuuWhKuVMibSLyEDd9g8tQyDiERTPCswOm8UcTYebKBtJLBNoQV0MN1Shr4EvV
 ukZvyGXHTZ+tcjVMvKe2t1Meq0feoiVhApDBC2sH78FnXSuUWPDkF8UPf3fvV/T7TGXjkGL
 vVcyy6FWpDLfhqBIeYdMQ==
UI-OutboundReport: notjunk:1;M01:P0:rmniLdu6LV0=;fVmfFqnePbKBDoLbcdTvR+vKlUs
 1aDw8sCEEdMpiQI6pYq1gmaZElgXq1Dc8kO31P1uMbktU8xiMVSF4X4xYFGMycLei2XXfDjbt
 +4chBhp+1jvEPVie0/paZ8f3qfUVeNIscKl7Zf5zuRLPOpYXyOcdbLqy/44k8yKEDse34qgcl
 rCNiyzerUKi7081Ocd+52lu+HxluHzO7hEWH310+iiC2AsDW0QJdmdhsunclosx5M5tm1RbxB
 YhNIW7JYabEHutZE0+VMbq6qmiSsym6yw8107W9fZJY/cHSMLVE0OusbOXt3kku84W7wxl1zK
 LYRL+aKr1/k+B/mDeDcvbi7u3vAW+vSvlP5YOfzYHiKySajTRiU/sFI3LBFYFGdwqF0ODMwzC
 tZFDHMU4wDtMPjDrqLbU8+aPRecqlOfEmfWMLYtKBdfpgjMEAPPA0v1967AA2J8sIpoBzsgxE
 2I28kMauaQ50yAehtyxdXBbUqvNU1Q4S2sErUITAAETxdCzG5ZaIH8w9oY6YV7KmF8heA5uuk
 JfyfimxGvTIJP4RTCxfVlJ3HSxIwAFv68tLpz0/dy1AmDdFeqLiIIh99W9O8+zxcBbt9YQtRU
 S3cUf0SRLH3dBnWZB+gvy2+rxlv/NFIAi+9Vd1hVd/202AC/567y3uEjrmH/A/Yq/YdtUTLMY
 gkZcme35Uw+soiYn8QR1WMd0jUSS1YUc/LJQbxIUBRrNFQ5HjlESo8jyPfcIvA7ybUGHg28RH
 cdgJajaSsamb3G3/HY+LkzPgRp1LrleX6lMZ1vnWe5g5boO7qupJQ0i3HkxVNGHOlWNJJYTAO
 /KiQkHWKlaz0zJ7jIrIQ1OdkqyyZ9hLNk02uyggtkZBD+yprmrJiYNnfN45XEUt0XJV+6UnN2
 OEUW1Of0OFO29WnJLx324nIK70uDz5UINuXeGAsAQnHH+CKvzhONodI7VJj8owK858b7/wiZO
 XGbbsfoP8h3M2yFd3InB6bO3hH0=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The tcg uses tgen_arithi(ARITH_AND) during fast CPU TLB lookups,
which e.g. translates to:

0x7ff5b011556a:  48 81 e6 00 f0 ff ff     andq     $0xfffffffffffff000, %r=
si

In case the upper 48 bits are all set, the shorter sequence to operate
on the lower 16 bits of the target reg (si) can be used, which will then
be a 2 bytes shorter instruction sequence:

0x7f4488097b31:  66 81 e6 00 f0           andw     $0xf000, %si

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 tcg/i386/tcg-target.c.inc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 77482da070..1cb9759c9e 100644
=2D-- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1342,6 +1342,13 @@ static void tgen_arithi(TCGContext *s, int c, int r=
0,
                 /* AND with no high bits set can use a 32-bit operation. =
 */
                 rexw =3D 0;
             }
+            if ((val & 0xffffffffffff0000) =3D=3D 0xffffffffffff0000) {
+                /* mask lower 16 bits on 16-bit register */
+                tcg_out8(s, 0x66);
+                tcg_out_modrm(s, OPC_ARITH_EvIz, c, r0);
+                tcg_out16(s, val);
+                return;
+            }
         }
         if (val =3D=3D 0xffu && (r0 < 4 || TCG_TARGET_REG_BITS =3D=3D 64)=
) {
             tcg_out_ext8u(s, r0, r0);
=2D-
2.41.0


