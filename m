Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F8CB039A3
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 10:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEge-0000r4-LB; Mon, 14 Jul 2025 04:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubEG5-0002Nn-BN
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubEG2-0003q8-Fe
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752480593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9iGYjvPvXxIkm+Oc4D3idBBeZ0pBOwX7LQvOgyvUxLY=;
 b=MwozkE+LOMmGHHnvH5Ozd8MTH6dYo598pJKbUZhETxSnsHDz+SL2Rfh2tvJV4YA6J0tXJt
 WPO1cLe7mJoJP2SMrGQlmxgk2uSqgFEzOcO5TVVdIZCb15rr1YnyTZYpFqFPlKxjfh/XKg
 NOX0wzL7krxCuGDEEmu/BiXSC4cysg8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-VS-xjAn9PKyoL_JzZgh4QA-1; Mon,
 14 Jul 2025 04:09:45 -0400
X-MC-Unique: VS-xjAn9PKyoL_JzZgh4QA-1
X-Mimecast-MFC-AGG-ID: VS-xjAn9PKyoL_JzZgh4QA_1752480583
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3DCA19560AD; Mon, 14 Jul 2025 08:09:43 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.221])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 711FB1977000; Mon, 14 Jul 2025 08:09:39 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v7 35/36] qtest/bios-tables-test: Generate reference blob for
 DSDT.hpoffacpiindex
Date: Mon, 14 Jul 2025 10:05:19 +0200
Message-ID: <20250714080639.2525563-36-eric.auger@redhat.com>
In-Reply-To: <20250714080639.2525563-1-eric.auger@redhat.com>
References: <20250714080639.2525563-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The disassembled DSDT table is given below

 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x000014E3 (5347)
 *     Revision         0x02
 *     Checksum         0x92
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

        Device (COM0)
        {
            Name (_HID, "ARMH0011")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09000000,         // Address Base
                    0x00001000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000021,
                }
            })
        }

        Device (FWCF)
        {
            Name (_HID, "QEMU0002")  // _HID: Hardware ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09020000,         // Address Base
                    0x00000018,         // Address Length
                    )
            })
        }

        Device (VR00)
        {
            Name (_HID, "LNRO0005")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x0A000000,         // Address Base
                    0x00000200,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000030,
                }
            })
        }

../..

        Device (L000)
        {
            Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000023,
                }
            })
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000023,
                }
            })
            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
            }
        }

../..

        Device (PCI0)
        {
            Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
            Name (_SEG, Zero)  // _SEG: PCI Segment
            Name (_BBN, Zero)  // _BBN: BIOS Bus Number
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description String
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
            {
                Package (0x04)
                {
                    0xFFFF,
                    Zero,
                    L000,
                    Zero
                },

../..

            })
            Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
            {
                Return (0x0000004010000000)
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    ,, )
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x10000000,         // Range Minimum
                    0x3EFEFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x2EFF0000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x0000FFFF,         // Range Maximum
                    0x3EFF0000,         // Translation Offset
                    0x00010000,         // Length
                    ,, , TypeStatic, DenseTranslation)
                QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x0000000000000000, // Granularity
                    0x0000008000000000, // Range Minimum
                    0x000000FFFFFFFFFF, // Range Maximum
                    0x0000000000000000, // Translation Offset
                    0x0000008000000000, // Length
                    ,, , AddressRangeMemory, TypeStatic)
            })
            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                CreateDWordField (Arg3, Zero, CDW1)
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    CreateDWordField (Arg3, 0x04, CDW2)
                    CreateDWordField (Arg3, 0x08, CDW3)
                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
                    Local0 &= 0x1F
                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != Local0))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = Local0
                }
                Else
                {
                    CDW1 |= 0x04
                }

                Return (Arg3)
            }

            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x01                                             // .
                        })
                    }
                }

                Return (Buffer (One)
                {
                     0x00                                             // .
                })
            }

            Device (RES0)
            {
                Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000004010000000, // Range Minimum
                        0x000000401FFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000000010000000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                })
            }
        }

        Device (\_SB.GED)
        {
            Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
            Name (_UID, "GED")  // _UID: Unique ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                {
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
            }
        }

        Device (PWRB)
        {
            Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
        }
    }

    Scope (\_SB.PCI0)
    {
        Method (EDSM, 5, Serialized)
        {
            If ((Arg2 == Zero))
            {
                Local0 = Buffer (One)
                    {
                         0x00                                             // .
                    }
                If ((Arg0 != ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
                {
                    Return (Local0)
                }

                If ((Arg1 < 0x02))
                {
                    Return (Local0)
                }

                Local0 [Zero] = 0x81
                Return (Local0)
            }

            If ((Arg2 == 0x07))
            {
                Local0 = Package (0x02)
                    {
                        Zero,
                        ""
                    }
                Local1 = DerefOf (Arg4 [Zero])
                Local0 [Zero] = Local1
                Return (Local0)
            }
        }

        Device (S00)
        {
            Name (_ADR, Zero)  // _ADR: Address
        }

        Device (S08)
        {
            Name (_ADR, 0x00010000)  // _ADR: Address
        }

        Device (S38)
        {
            Name (_ADR, 0x00070000)  // _ADR: Address
            Device (S00)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
                {
                    Local0 = Package (0x01)
                        {
                            0x0C
                        }
                    Return (EDSM (Arg0, Arg1, Arg2, Arg3, Local0))
                }
            }
        }
    }
}

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

---

v5 -> v6:
cropped the commit description
---
 tests/qtest/bios-tables-test-allowed-diff.h      |   1 -
 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex | Bin 0 -> 5347 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 02f4f0b29f..dc3ab24d05 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
 "tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
-"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
diff --git a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..970d43f68bca060361105f70dbb00b3a25646db4 100644
GIT binary patch
literal 5347
zcmZvgOK%!i6oAjb0K+ig;bCKAY)F$veMSTLl{8HQGuS2pn=(#ZiAY0KrHbt?kQ!A=
zqe>2yk~F*8YS&cq52@5ucinZ-Wz|jpKzF6Oa|inz<;()+KF)XVH=L0U*KwV_zj6Sf
zlg6&S?Uoy#b?tJwTvh-;+>3AX`EBKa=Qh0ls9;-`rFq*eCt0_<Ez7djLG$jl9O#d3
z*t?zSSg*5fS(QpKrg?VHO&9e1i#P~i987@kqo6340N^R~M;n{__NL^1+U(r3EUOBd
z=kC?@gyz|HU6F{io|1@Ad_IV*tM_};Ewy)gyOw3GUMzbad9k<-p<r<fBPw!riV(}b
zfe0Z)B|tR9E~*?t4{;0?F{+qRV;NzN5k-s|W~{Ibm1Ag#v4R<^EF;1(bi`Q2j5U@K
z<roHHtYOAF%ZPD|6k@Dn#s<sKIEINB8<=sOWyCo~1~IN9MkRPTXo~4N$H*bZ4a{KE
zl)fa>RG&kPk1&JJQ-j;bJYw9$3_eej9HW33A7cierzwt6M2uUQ!RP4=$5=*;PcVbe
zQ<Gzq5#u&y@Ohf%7;hm)9W(em&2Wq>h|$0dK2Nh8<0@j<h*9P9G{-UCK@0~o_&lBE
z81ErQ6EpZco#PlEAjT$U@Ohf&7}pSE3p4mUo#z-9Vr*jupQj5Pqly?U%;591z%f=3
z;|^x<dAi6k))3<^X7G7h<QN->(Z&ouPnS5x4aDdmMvc$YWsY$ZF?KM6&(jjexP=(I
z0i&h1&kLgNPS>)n&GX`;+jG+?J>l0mm;L#&h@pMCsOR=vr7uyzb_hz*2<i%hl6~i>
zJ7QPC+e1*I7{S|mn_<a5$_m~h$_i7~RfZ+|E?6gByA}Luf>pOR#4~9*L8~TezUCHa
zUZb&d{v6%CUb>_gyI?~L9zhu_D1!r!;A=R5&*2e(fcRxvx3`yVf2AL15^7>H0rA^_
zyjR+mRe_8l`t^`_Jkv(FZCN$QBvoTFQ9#60&RZg?3YnA~^W$n4O%Z7Yb3=Y)^}Hn_
zr&B{R(h4F&;73kZ3Hy=L9fbYJ>C~`{tOSu^897}=^&_V{Q2og1R8>Y!H?PXb=_(Q8
z86ln#>KT!d(^aCxGfF(8)H6ywW5hE?JY&=|Mm;s+sS!_&dTP`&PCVnpGfq9@)Ke#(
zI`P!0r%pW+#4|xW6Vx+7Jq_Y%5Kn`88q_mMJd?yTNj;O)Geta8#4|-bQ`B>Yc+L>d
z8R|JhJx$_i5>JzQn$$B*Jk!K8O+C}pGebNx#4|%ZGt@InJhQ|zOFgsHGe<mg#4|@d
zbJTN|c+L{fS?W1UJ?Dt$9Pyl^o^#YQPdxL)GfzG9)N`JA&J)jh>N!t67l`Kq@m!#u
z3)HhfJPX9LKs^i8bCGy163<2Ixkx>W#Ir~|i`277J(q~*67gK3o=enonRqS}&t>Yl
zOg&4)vqU^g)U!18%$c6usKZ%Gocf6WH?m^cj_FTcB_U*hxF+I5d6@?=#9@xO%*o_G
z@wZHjUVE7b#R$t5z{H<ExdouW>-SNNe;xZXCUO$GME_IBwPW6{Ypbu1z;^a4<DJOq
z<8)Rx`<*{)|CWlkf7*Xi|K;O9zIc74tG2UWeSM^BwzFRwijTpwfnFMn&6Cpu<y#T%
zk5$ImlT&|K_L*X2I1oKQ8?sBFDrZNz4?V~2sN+j=&EMC5``caprt?GopU%Rsc4r(v
zJ%qD#SW(0W^hX`F*K|>FWBW%~;^3>MTW^^APj@nzl*Cg;mnrVWiC81{;F>sd+iE(V
zJbRD_ZWU1^-D^3?t)@c?%CPdT3_Wi4np<E1XmMTbKTn9J-E^Dna&F0M-rtK4MPo2F
zPoE8RQJcKz?)Mt{aeuTRZscOJ)U$&k%xov*Zbbc-yBldbZYMcjJ3WM<kROZ-C;U@7
z8;oN=9_XR7!BBtxY5;IH7#B|u_1G{I2|*GD!|z^w3Gi_EP!9G-3D>eb&8s^-=#OSx
qYeO~+kw5*>id(zrh(UjJ`C@u5FMcp%m{Aqo7@UbcK0Y`+8vG9j4In)L

literal 0
HcmV?d00001

-- 
2.49.0


