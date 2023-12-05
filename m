Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B581F80436E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 01:31:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAJKu-0002ZK-M5; Mon, 04 Dec 2023 19:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJKr-0002UN-Tm
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:30:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJKp-0001aJ-Jt
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:30:49 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B508rpk027743; Tue, 5 Dec 2023 00:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=aZBw/Sx7FTLNwV+8en4AZ/HHit6ZoFeEA3SzBFKAZGg=;
 b=HhnHxh4gd7lrHh3EPVRuGpG2Ab0JBrEiPou7xlV5fl1CHV+AEYnQGUtH7IYuAN9Zt+s8
 1n1KfMwOvxavbGXBB85f5ulLy9kx1HyohIaiRlYKeIDO5wzdRZbZ9ExG13bw8DnlZn8O
 IoUZJ+CMPzNUg3T9rJMKqStL6jR8PGhnoBtrED4hKGusklgpiDSF+VBGZ68VBjHa6EhR
 bBVV+UO5pbxVxmFUDz0OOhlyHc8mTlH5zj0Z/XlAzfnj9W6rbkZcApYHEKVQzavj4Xdx
 tldvWyY3VHWP5yYTfR6E1oqs+mVb5xPyWK4KbDixQLqYnbSBTGTHes+iObvGz/OlWo3B Vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uss28r1eq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:30:45 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4MIXg7004891; Tue, 5 Dec 2023 00:30:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu16dgma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:30:44 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B50Ui8B024965;
 Tue, 5 Dec 2023 00:30:44 GMT
Received: from localhost.localdomain (dhcp-10-191-8-104.vpn.oracle.com
 [10.191.8.104])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3uqu16dgg5-1; Tue, 05 Dec 2023 00:30:44 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC PATCH 10/11] tests/acpi: Update FACP and DSDT tables for sleep
 button
Date: Tue,  5 Dec 2023 00:30:38 +0000
Message-Id: <20231205003038.1118-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.30.1.windows.1
In-Reply-To: <20231205002143.562-1-annie.li@oracle.com>
References: <20231205002143.562-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_23,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050003
X-Proofpoint-ORIG-GUID: eKSsQuJ6L3KLYqjuDiuWt9X45kRVpRI4
X-Proofpoint-GUID: eKSsQuJ6L3KLYqjuDiuWt9X45kRVpRI4
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Miguel Luis <miguel.luis@oracle.com>

  *
  * ACPI Data Table [FACP]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "FACP"    [Fixed ACPI Description Table (FADT)]
 [004h 0004   4]                 Table Length : 00000114
 [008h 0008   1]                     Revision : 06
-[009h 0009   1]                     Checksum : 15
+[009h 0009   1]                     Checksum : E2
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

 [024h 0036   4]                 FACS Address : 00000000
 [028h 0040   4]                 DSDT Address : 00000000
 [02Ch 0044   1]                        Model : 00
 [02Dh 0045   1]                   PM Profile : 00 [Unspecified]
 [02Eh 0046   2]                SCI Interrupt : 0000
 [030h 0048   4]             SMI Command Port : 00000000
 [034h 0052   1]            ACPI Enable Value : 00
 [035h 0053   1]           ACPI Disable Value : 00
 [036h 0054   1]               S4BIOS Command : 00
 [037h 0055   1]              P-State Control : 00
@@ -148,50 +148,50 @@
 [0DCh 0220   1]                     Space ID : 00 [SystemMemory]
 [0DDh 0221   1]                    Bit Width : 00
 [0DEh 0222   1]                   Bit Offset : 00
 [0DFh 0223   1]         Encoded Access Width : 00 [Undefined/Legacy]
 [0E0h 0224   8]                      Address : 0000000000000000

 [0E8h 0232  12]                   GPE1 Block : [Generic Address Structure]
 [0E8h 0232   1]                     Space ID : 00 [SystemMemory]
 [0E9h 0233   1]                    Bit Width : 00
 [0EAh 0234   1]                   Bit Offset : 00
 [0EBh 0235   1]         Encoded Access Width : 00 [Undefined/Legacy]
 [0ECh 0236   8]                      Address : 0000000000000000

 [0F4h 0244  12]       Sleep Control Register : [Generic Address Structure]
 [0F4h 0244   1]                     Space ID : 00 [SystemMemory]
-[0F5h 0245   1]                    Bit Width : 00
+[0F5h 0245   1]                    Bit Width : 08
 [0F6h 0246   1]                   Bit Offset : 00
 [0F7h 0247   1]         Encoded Access Width : 00 [Undefined/Legacy]
-[0F8h 0248   8]                      Address : 0000000000000000
+[0F8h 0248   8]                      Address : 0000000009080000

 [100h 0256  12]        Sleep Status Register : [Generic Address Structure]
 [100h 0256   1]                     Space ID : 00 [SystemMemory]
-[101h 0257   1]                    Bit Width : 00
+[101h 0257   1]                    Bit Width : 08
 [102h 0258   1]                   Bit Offset : 00
 [103h 0259   1]         Encoded Access Width : 00 [Undefined/Legacy]
-[104h 0260   8]                      Address : 0000000000000000
+[104h 0260   8]                      Address : 0000000009080001

 [10Ch 0268   8]                Hypervisor ID : 00000000554D4551

 Raw Table Data: Length 276 (0x114)

-    0000: 46 41 43 50 14 01 00 00 06 15 42 4F 43 48 53 20  // FACP......BOCHS
+    0000: 46 41 43 50 14 01 00 00 06 E2 42 4F 43 48 53 20  // FACP......BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
     0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0070: 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0080: 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     00A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     00B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     00C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     00D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     00E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
-    00F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
-    0100: 00 00 00 00 00 00 00 00 00 00 00 00 51 45 4D 55  // ............QEMU
+    00F0: 00 00 00 00 00 08 00 00 00 00 08 09 00 00 00 00  // ................
+    0100: 00 08 00 00 01 00 08 09 00 00 00 00 51 45 4D 55  // ............QEMU
     0110: 00 00 00 00                                      // ....

  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000144C (5196)
+ *     Length           0x0000149E (5278)
  *     Revision         0x02
- *     Checksum         0x9F
+ *     Checksum         0x2B
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1876,27 +1876,48 @@
                     0x00000029,
                 }
             })
             OperationRegion (EREG, SystemMemory, 0x09080000, 0x04)
             Field (EREG, DWordAcc, NoLock, WriteAsZeros)
             {
                 ESEL,   32
             }

             Method (_EVT, 1, Serialized)  // _EVT: Event
             {
                 Local0 = ESEL /* \_SB_.GED_.ESEL */
                 If (((Local0 & 0x02) == 0x02))
                 {
                     Notify (PWRB, 0x80) // Status Change
                 }
+
+                If (((Local0 & 0x08) == 0x08))
+                {
+                    Notify (SLPB, 0x80) // Status Change
+                }
             }
         }

         Device (PWRB)
         {
             Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }
+
+        Device (\_SB.SLPB)
+        {
+            Name (_HID, EisaId ("PNP0C0E") /* Sleep Button Device */)  // _HID: Hardware ID
+            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
+            {
+                One,
+                0x04
+            })
+            OperationRegion (\B**, SystemIO, 0x0201, One)
+            Field (\B**, ByteAcc, NoLock, WriteAsZeros)
+            {
+                SBP,    1,
+                SBW,    1
+            }
+        }
     }
 }

Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 tests/data/acpi/virt/DSDT                   | Bin 5196 -> 5278 bytes
 tests/data/acpi/virt/DSDT.acpihmatvirt      | Bin 5282 -> 5364 bytes
 tests/data/acpi/virt/DSDT.memhp             | Bin 6557 -> 6639 bytes
 tests/data/acpi/virt/DSDT.pxb               | Bin 7679 -> 7761 bytes
 tests/data/acpi/virt/DSDT.topology          | Bin 5398 -> 5480 bytes
 tests/data/acpi/virt/FACP                   | Bin 276 -> 276 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   7 -------
 7 files changed, 7 deletions(-)

diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
index c47503990715d389914fdf9c8bccb510761741ac..ca4e2949adc72f70282bd9d5d311b67ed1f5d4eb 100644
GIT binary patch
delta 146
zcmX@3F;A1rCD<ioo(Ka2llDX|X{Jv1jp{RmnVdN$9~2JO){A!y3*jtq4R-ZOSRgRD
zI)RIcfs3gvAUw#4s{taw!NA4Q7VHx+Sx-dHF}le<MlU|tDIO@`#1Ze|>B8f9frpPH
qJ|HMuh?R+vizT`t#wkBPo{^i8i7~oS5X^B5b_$4R40Z~SX9NIW&nAEX

delta 63
zcmbQIc}9cFCD<jzM}&caY5qhmX{L6kjp{RmnVi@s9~2Ijl8tu_3*jtq4R-ZOSRgRD
TI)RIcfs3gvAUtTYy@(tDF;fvg

diff --git a/tests/data/acpi/virt/DSDT.acpihmatvirt b/tests/data/acpi/virt/DSDT.acpihmatvirt
index aee6ba017cd730948bfa93e91551eb10a6809293..37f122b0425807d0e83da2a8438571f2ddf028a0 100644
GIT binary patch
delta 148
zcmZ3a`9+h<CD<k8iwFY)(~F5*(oFq68`a+lGdXii78eO-)SH|wB9ps7U~+W=7Y73u
zM_aH@fD>0kbdzL2c#soEyoaX?Z-8HbfwO@#14n$Qrwc=LlYNX{e6UkINF`VSkK+X%
sK92Z+pl~5pCPprn=!O`l{QP)EZbl}?=te;>$1&I`Af7SUDLkGL0REXLM*si-

delta 66
zcmeyOxk!`CCD<iokq83=Q_MszX{KKHjq2}&nVi@si;Dy^%1+J}k&%vWk_-qBa^i^h
W@O0q~@Cz_-HgIO(h!6F2VE_PNB@p!h

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.memhp
index bae36cdd397473afe3923c52f030641a5ab19d5d..1dc2a3b7ed6785fae1c81b57db04fb991669f35e 100644
GIT binary patch
delta 126
zcmbPh{N9+$CD<k8y(9wzQ}jeGX{N3@8`WnBGdXcjJ}4Z_<jXo)OvH<SfxzVI1TGE+
zE{?Wfp8%)LaU%Atj?qo_F?#XAPVpcij(87G7aqq8JbWDS0YTwHtW1ntEYS@yPWk!q
ZjNFV&jM0sPV2)$3Q$Rdpuv2(EBLKABA&me4

delta 44
zcmaEFJlB}ZCD<iot|S8k(}9Ux(o7xGH>%GNW^&}3d{8);$%kdKn26WrLJ?b505dcU
A*Z=?k

diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/virt/DSDT.pxb
index fbd78f44c4785d19759daea909fe6d6f9a6e6b01..785e3834f17f021ce0212c1b943f3d88aa3409d6 100644
GIT binary patch
delta 123
zcmexwebI)?CD<h-P>z9t$!j8)G*i!`jq2XAOwJsWOJsu?^(LQ?mEl_;Fu6K`i-UoS
zqb=AcVDdv*ImhTG`xw3WV5fMXfD=c&ho=jV;{_f*j`)C}a3NMEMlP1<h8U;({CGxg
XMkdDSMnN#gG1w^}o-x=dJf0B%b;u!O

delta 66
zcmca;^WU1wCD<k8zbpd-)BcHE(o9`<H>!KfGC8qNE|Cppl%0G+Rz^CyNirZj$cZD~
W!_$Q~z%RhS*}$2BBR<sAg#iG*84}|F

diff --git a/tests/data/acpi/virt/DSDT.topology b/tests/data/acpi/virt/DSDT.topology
index 501314c91be01d927fd125e0c72e919fdd85592e..fdd1e628080fbb5822bf940b173b4946dce3b7c4 100644
GIT binary patch
delta 123
zcmbQH^+JowCD<h-LzIDmNq!=iG*ffPM)f2SCTEVx-6Fw^dXw*q$nY%?m|UH}#lgVE
z(H86zF!_gwoMUv8eT-gwuv0uxz=<Q?!_$Sw@d6JYM|?m~xDYE7BNt0_LyS{?emo;L
XBNJnEqac{$80-`f&lv0!9?u8>2rM9S

delta 42
ycmaE%HBF1lCD<iIOq79vY4SuaX{JX1jp|7vOit{RyG4Q-WhdVkk(taRDh&YhehUEr

diff --git a/tests/data/acpi/virt/FACP b/tests/data/acpi/virt/FACP
index ac05c35a69451519bd1152c54d1e741af36390f5..0899918d8195f87ed060539dbdcac3380086e97f 100644
GIT binary patch
delta 50
tcmbQjG=+)F&CxkPgpq-P?a@T8*YX?;K)}HXA{l^eMkqVb)i)F*1OU>l23`OF

delta 30
kcmbQjG=+)F&CxkPgpq-PO>`pH>xl;99D%OBp$tF(0B1o49{>OV

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 83d368734c..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,8 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/virt/DSDT",
-"tests/data/acpi/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/virt/DSDT.memhp",
-"tests/data/acpi/virt/DSDT.pxb",
-"tests/data/acpi/virt/DSDT.topology",
-"tests/data/acpi/virt/FACP",
-
-- 
2.34.3


