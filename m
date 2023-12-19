Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B47818972
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 15:12:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFao0-0004n0-J7; Tue, 19 Dec 2023 09:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6717fc9f42=mykyta_poturai@epam.com>)
 id 1rFans-0004jl-9K; Tue, 19 Dec 2023 09:10:39 -0500
Received: from mx0a-0039f301.pphosted.com ([148.163.133.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6717fc9f42=mykyta_poturai@epam.com>)
 id 1rFanj-0005LW-7L; Tue, 19 Dec 2023 09:10:32 -0500
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3BJCnnqL003504; Tue, 19 Dec 2023 14:10:20 GMT
Received: from eur01-db5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2050.outbound.protection.outlook.com [104.47.2.50])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3v37dpsfmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Dec 2023 14:10:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTDgVSnWqgVvArgEZDKKhAi32s7kGOkHMHZVz1sIWyysq+NqUei5TwsXi10viiuFLQCy6ce9qdtQsdZY6cz+E/WNkXZ/y7oN0PgRDXf3EQWWkdD33FFOvCc7H183pxw7fQcr27uRWa4ifXAgbqD1TU7JhkstIg02tgUKIAU25mn6jHNaSR6I462nfHtagZsA6Y7lBbfRUo1Y4WNNtn7v6Emt0VvM/sfwFgNJadOPjURcJuIcnOsEDXwkrvIx+dVjCXzhRF+BiiJgRS+MmmKJhk694vCY/K2aiV/Ak4YakVzsvMuI6XbKCLbAMkuaLWbJT6gyCOJMtn+R9EzRNOCcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a23FITDTAx1sJkgoZyW47skK1vW+hljud755Kt7J/9s=;
 b=ckZVafD9Eza4lVFSKeGutdytbdeNe6jxI/S8weXS9Qbh1rQsp2+6kRblVoYs+fNUFJt3LqzqWZ4PkjjRb5+Y6J+2A9kzfujfruQNLliyV465Kc17/fPOY1iasy3jSnLBh2GrXEblZ+difceeJz751yucXFmeZim4vTzrq/LhWcssDcMT7A5Fo4H4M9xRD6WEXRYwCcLxVgH6vACBxBLfhqysyvn7B/OgBpvWE8dRzV9INFwjeHt6Ox91Icm58AD90p+FNjf/ABQePie17LvyYZwnNUlPIYJbMjHoljavRwoV+fbPh3nFIW1z/IWGg3btV+Flk5oyTvrEAsYsorRDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a23FITDTAx1sJkgoZyW47skK1vW+hljud755Kt7J/9s=;
 b=FSqkDz8JJRLXJAtVacNQ+XaaesmT3YR0ufbYN5Ouqhc/PUaLs59hwDOsoXBpCHX17HMZzXeYU2G2e+9H1pb9cTbu6FSyrVhZCRAncJl5LHNNdPYYYGTfGPBD1oe+xQxT6tFFsY1C15aVgBpNhzn8+empH1nnktfPkf+rfxde8t6inoUoHuvkdTE2lri8u7+Impvoqr5kXGqW8Ete13HGb/jPyceT/gftmw9clilZXyCWin/SqJr49kYs6gIhZFQKUWSsDh14Xywa03sDPG3ovDebom88usp17qSMfDkAyuBtjeCv3kSlFC5JkyDZ7wth3u9iyj4Ql28MdIW15vhEuQ==
Received: from PAVPR03MB10102.eurprd03.prod.outlook.com
 (2603:10a6:102:30d::12) by PAWPR03MB8937.eurprd03.prod.outlook.com
 (2603:10a6:102:331::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 14:09:52 +0000
Received: from PAVPR03MB10102.eurprd03.prod.outlook.com
 ([fe80::3776:9f2d:8305:b645]) by PAVPR03MB10102.eurprd03.prod.outlook.com
 ([fe80::3776:9f2d:8305:b645%6]) with mapi id 15.20.7091.028; Tue, 19 Dec 2023
 14:09:52 +0000
From: Mykyta Poturai <Mykyta_Poturai@epam.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Mykyta Poturai <Mykyta_Poturai@epam.com>, Peter Maydell
 <peter.maydell@linaro.org>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: [RFC PATCH] xen_arm: its: Introduce arm_gicv3_its_xen
Thread-Topic: [RFC PATCH] xen_arm: its: Introduce arm_gicv3_its_xen
Thread-Index: AQHaMoUIMwx7bYR/c0usBD9ndQcGqQ==
Date: Tue, 19 Dec 2023 14:09:52 +0000
Message-ID: <c7a180a5874f036c246fc39f921eefafecbc8c76.1702994649.git.mykyta_poturai@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB10102:EE_|PAWPR03MB8937:EE_
x-ms-office365-filtering-correlation-id: 495bfe57-680a-461d-fa41-08dc009c2b4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PsozmHuXu0grm5s9VqIhodACTq/o5uCfUcYRnXHl+3FzvdTUzvjbcmgzgAh9U9w++LE0KZtytMpl9p90AxNwT3XdOuUAtZ73dcYZC6UZAGLYjYrVKvCXG0odFQ0oCAE/6WZlQ8WX2VM+T1bA2ZkiBZOmDkqK9iLi1Jv3o5gdeCaF+6ezrbHTLEkay+1qbUSuIyjqRPpLvtZdzIbtAyQi8dtCHkHWbwtFFWSEB1crQBPbPgltf8aRAen5YW3qHwJnr07EkERwmW6uLmGBP8/+Dmqhy75LZ7n7+rzzkr5yb9enfihhK64ALfYhOi+TzFHqp1rcSloY6nclyCBYa4WfTVPC3L1ws0nZd6aQy8IvN5i/exofsnr+AGqPtFf5nMA87pPAOsoQQIK4L/CuiWARvWhRAaaqJkKf7Zw8Gi1A3nZhSB9+gn7CE5JTNgykVB7Udq2kCtY7vRjd1EQZP35GabMxS4TIshsCp4nQnpZLn77zCcx71QsFzfSCJ2uM2UOH5n+WPyJTcrDgHS5PRjFGt2RTy/nkBzlBa6ScloDzayErx+ofsw39xOk8CkJF1wFWKNkXUh2sP/w3z8LCjTLXNHNKCbEEkXRlp4xt9XKCJhaiF+8uRY/CFpBm1RQO0N4s
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB10102.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(2906002)(5660300002)(41300700001)(38070700009)(86362001)(36756003)(122000001)(19627235002)(26005)(6486002)(966005)(83380400001)(2616005)(66556008)(66946007)(66446008)(91956017)(76116006)(64756008)(6916009)(54906003)(316002)(66476007)(6506007)(38100700002)(71200400001)(6512007)(4326008)(8676002)(8936002)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+zdW5pRqv6VgzDEd5+kLMrveFJhwWZCSaiVKfXlWQ8J8mUkqgfgzTKLqa5?=
 =?iso-8859-1?Q?/V2dWgqPmVOBUvLwOAGvNftmT4jxvFXG9hQPiVckXSvbNOoAtsn4pCQ8zv?=
 =?iso-8859-1?Q?tF1uk5LiKiBIpb/GuMAwBfDZP4lwjo/zV/4SCiWvH5PVi/46tdz1uG/1i+?=
 =?iso-8859-1?Q?n5hKK0cOk5bZU+dzcmF2pZxjDH4AsQjVyGLYGiDpCu8hUOGUdiTUxJ6AkG?=
 =?iso-8859-1?Q?kLv/5v0pRHA+TnoVy0tQ8+kOIF0QhQuIpSLtGd51HuDBRduZBwkgMaDYl2?=
 =?iso-8859-1?Q?2/O9b4Hts6ezUtqioFA+xCRe8L/2EPdTPOlx4ilBw7Jdt4DYQOLqzN7xdU?=
 =?iso-8859-1?Q?Nia+zE+CKyoMCW97VqQSir1IJJ8IgtsvIsyeXWzXriWxabpXFf86TFgW/b?=
 =?iso-8859-1?Q?YljmQkIVKwoRFj/CQRk0McJMWsM+dDbIOWpObEouLVwr0rawND1zKtdK4G?=
 =?iso-8859-1?Q?Mrp+vUsXZP3maYbiwnPXQKY9yN+ETMNxA++4V74RcIf1liyjO9Tu/r5OFq?=
 =?iso-8859-1?Q?2MC7e7rPD0xiWZfyRWkrd8HqMQA7B/QSeWjCLWnYyF341BKDmsqatJD+/I?=
 =?iso-8859-1?Q?RSJbRQva6GKAf9vZgxoK0E4r2kkx8LC1QKS1NK9nQ9VyqKEil9z4i5CamH?=
 =?iso-8859-1?Q?tu4F/zNmF9tRAnTZVScDTfjxMBmn6VKROQbskZgAOMHBqaNGnYCWn7SZ7P?=
 =?iso-8859-1?Q?GJvbt/lPh+CSMr9X6iM4BdoD9x+4vLM1fxg1E6D9z3xVLn9U0cmJzaLgK7?=
 =?iso-8859-1?Q?oHRFPOlrH/wryrTVaGtUFPFkD0wfy5pfrhli2MnWbvnqWwdeiQtaoSC5R7?=
 =?iso-8859-1?Q?Cv5b/ac3m2gzXSlehYpPQTOg+cNX4GTnik+5BcX/cNvKaRg40hKism9Sau?=
 =?iso-8859-1?Q?ZUPeh9pHV5TQXA/vMguAC5plHKW3pshutaMckknOnj9Hkvle1epp72POch?=
 =?iso-8859-1?Q?GPSSDI10PKD4H05s6aOgvVZ+HJ4ziBQd50B1g8mwItGDQJpdBeGwhIc1gB?=
 =?iso-8859-1?Q?UA6KERMuEIHZOJjhehP1WQZBKNvCyYFicG7q/wVd03BkRlsdWEvXTofUsX?=
 =?iso-8859-1?Q?8JdpP0rNajR3cJoX09eM3xcDLYGVTElAhCeTnfInGpXela+HQd7lCD5ygH?=
 =?iso-8859-1?Q?2uvfX4xZ/4A4KOCCYCkwUprts+FchEHmOhHFB4ksxLvCRqnYC9ptTc1xFc?=
 =?iso-8859-1?Q?0x+Fo0jpvm9v44zTO2Q3Atv+xwEb6tm91qQ38gT9pntE0uAunzik5Pihkc?=
 =?iso-8859-1?Q?EwM+RSCjDTdXj+HLqsKuMcAumiCsFzHulKn1c8Yj2+ASHlSRJ9xrz5QFHq?=
 =?iso-8859-1?Q?N45kMKT5qh/xx2tp9dgW1bGgx4uxkHq3aDuWg50klQs3byCcTWDN5DZgqL?=
 =?iso-8859-1?Q?lfJLUyGkyoBVqljZ7llnCY5e3+D5AgcYyODNKiXEVYLt1nzuMNt0M1yA6L?=
 =?iso-8859-1?Q?78Sw+TokfKKjNGB5JAkYftZ9J/PerxF85HRdC95WpnvIib1fqwyEggvpBC?=
 =?iso-8859-1?Q?2f/kHAg5FeLBbIFhlZ0FUWVhLtZApjJQ2x3YMEf37yo1hcbHhDvoQgvwgk?=
 =?iso-8859-1?Q?9M2dJBE1mUrDcu3WyGjt9xUs6+tRCGsnIbLqQCmKaQtjn+5e+BOIVVAZJD?=
 =?iso-8859-1?Q?YERqL8JGCXTrFqyBdhKYVCaDttuOfBZn1DN37sjYaXoglJ1JNl2rKrjQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB10102.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495bfe57-680a-461d-fa41-08dc009c2b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 14:09:52.1196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUbUSZ06SPOh6qSaSaPgHmObjf7Byg0PCDIaNRzUMtJdfiNuQvYipfowNxIaXm8ZDp92YrqBPUr8T5z6NwHFDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB8937
X-Proofpoint-GUID: GrBwZSuZecMyDmDfJbI2uilofU3I0BJJ
X-Proofpoint-ORIG-GUID: GrBwZSuZecMyDmDfJbI2uilofU3I0BJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1011 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190106
Received-SPF: pass client-ip=148.163.133.242;
 envelope-from=prvs=6717fc9f42=mykyta_poturai@epam.com;
 helo=mx0a-0039f301.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Introduce the Xen variant of Arm ITS. It is hooked into the mmio
subsystem and recieves MSI messages. Upon receiving the MSI messages it
gets transfered to the Xen hypervisor with the new device model call for
further processing.

This change will allow for virtio-pci backends to send MSI interrupts
to the Xen guests.

Change marked as RFC to get some feedback on the approach while the
relevant Xen changes are being reviewed.

Link to relevant Xen changes:
https://patchwork.kernel.org/project/xen-devel/patch/6a631756a126e73390f95b=
9e86c69e3286c92f59.1702991909.git.mykyta_poturai@epam.com

Signed-off-by: Mykyta Poturai <mykyta_poturai@epam.com>
---
 hw/arm/xen_arm.c            |   6 ++
 hw/intc/Kconfig             |   5 ++
 hw/intc/arm_gicv3_its_xen.c | 115 ++++++++++++++++++++++++++++++++++++
 hw/intc/meson.build         |   1 +
 4 files changed, 127 insertions(+)
 create mode 100644 hw/intc/arm_gicv3_its_xen.c

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 684973328a..ff7397edca 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -374,6 +374,7 @@ static void xen_enable_tpm(void)
 static void xen_arm_init(MachineState *machine)
 {
     XenArmState *xam =3D XEN_ARM(machine);
+    DeviceState *dev;
     int rc;
=20
     if (!xen_enabled()) {
@@ -405,6 +406,11 @@ static void xen_arm_init(MachineState *machine)
=20
     xen_enable_tpm();
=20
+    dev =3D qdev_new("arm-its-xen");
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GUEST_GICV3_ITS_BASE);
+    msi_nonbroken =3D true;
     return;
 }
=20
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index a7cf301eab..5bc0f5ec18 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -35,6 +35,11 @@ config ARM_GIC_KVM
     default y
     depends on ARM_GIC && KVM
=20
+config ARM_GIC_XEN
+    bool
+    default y
+    depends on ARM_GIC && XEN
+
 config XICS
     bool
=20
diff --git a/hw/intc/arm_gicv3_its_xen.c b/hw/intc/arm_gicv3_its_xen.c
new file mode 100644
index 0000000000..e05b761802
--- /dev/null
+++ b/hw/intc/arm_gicv3_its_xen.c
@@ -0,0 +1,115 @@
+/*
+ * Xen-based ITS implementation for a GICv3-based system
+ *
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd.
+ * Written by Pavel Fedin <p.fedin@samsung.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/xen/xen-hvm-common.h"
+#include "hw/qdev-properties.h"
+#include "sysemu/runstate.h"
+#include "migration/blocker.h"
+#include "qom/object.h"
+#include "hw/pci/msi.h"
+#include "qemu/log.h"
+
+#define TYPE_XEN_ARM_ITS "arm-its-xen"
+
+static MemTxResult gicv3_its_trans_read(void *opaque, hwaddr offset,
+                                        uint64_t *data, unsigned size,
+                                        MemTxAttrs attrs)
+{
+    printf("ITS read at offset 0x%"PRIx64"\n", offset);
+    *data =3D 0;
+    return MEMTX_OK;
+}
+
+static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
+                                         uint64_t value, unsigned size,
+                                         MemTxAttrs attrs)
+{
+    if (offset =3D=3D 0x0040 && ((size =3D=3D 2) || (size =3D=3D 4))) {
+        GICv3ITSState *s =3D ARM_GICV3_ITS_COMMON(opaque);
+        GICv3ITSCommonClass *c =3D ARM_GICV3_ITS_COMMON_GET_CLASS(s);
+        int ret =3D c->send_msi(s, le64_to_cpu(value), attrs.requester_id)=
;
+
+        if (ret < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "ITS: Error sending MSI: %s\n", strerror(-ret));
+        }
+    } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "ITS: Error sending MSI: %s\n", strerror(EINVAL)=
);
+    }
+    return MEMTX_OK;
+}
+static const MemoryRegionOps gicv3_its_trans_ops =3D {
+    .read_with_attrs =3D gicv3_its_trans_read,
+    .write_with_attrs =3D gicv3_its_trans_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
+static int xen_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t dev=
id)
+{
+    xendevicemodel_arm_inject_msi(xen_dmod, xen_domid, s->gits_translater_=
gpa, value, devid);
+    return 0;
+}
+
+static void xen_arm_its_realize(DeviceState *dev, Error **errp)
+{
+    GICv3ITSState *s =3D ARM_GICV3_ITS_COMMON(dev);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(s);
+
+    memory_region_init_io(&s->iomem_its_translation, OBJECT(s),
+                            &gicv3_its_trans_ops, s,
+                          "translation", ITS_TRANS_SIZE);
+
+    memory_region_init(&s->iomem_main, OBJECT(s), "gicv3_its", ITS_SIZE);
+    memory_region_add_subregion(&s->iomem_main, ITS_CONTROL_SIZE,
+                                &s->iomem_its_translation);
+    sysbus_init_mmio(sbd, &s->iomem_main);
+
+    printf("init mmio done\n");
+    msi_nonbroken =3D true;
+    return;
+}
+
+static void xen_arm_its_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    GICv3ITSCommonClass *icc =3D ARM_GICV3_ITS_COMMON_CLASS(klass);
+
+    dc->realize =3D xen_arm_its_realize;
+    icc->send_msi =3D xen_its_send_msi;
+}
+
+static const TypeInfo xen_arm_its_info =3D {
+    .name =3D TYPE_XEN_ARM_ITS,
+    .parent =3D TYPE_ARM_GICV3_ITS_COMMON,
+    .instance_size =3D sizeof(GICv3ITSState),
+    .class_init =3D xen_arm_its_class_init,
+};
+
+static void xen_arm_its_register_types(void)
+{
+    type_register_static(&xen_arm_its_info);
+}
+
+type_init(xen_arm_its_register_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index d6d012fb26..7c32c2886e 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -31,6 +31,7 @@ specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('a=
rm_gicv3_cpuif_common.c
 specific_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files('arm_gicv3_cp=
uif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'=
))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: f=
iles('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
+specific_ss.add(when: 'CONFIG_ARM_GIC_XEN', if_true: files('arm_gicv3_its_=
xen.c'))
 specific_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_vic.c'))
 specific_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_gic.c',=
 'exynos4210_combiner.c'))
--=20
2.34.1

