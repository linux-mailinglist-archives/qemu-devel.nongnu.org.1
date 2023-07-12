Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B42750683
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 13:45:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJYHV-00069K-Dp; Wed, 12 Jul 2023 07:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qJScJ-0005Yk-DT
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 01:42:24 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com
 ([40.107.237.67] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qJScG-0006PT-7f
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 01:42:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUKqjnaS4zxP9khyuf7vkUBg9cfcumq0qu/CVqQtSeYM0/17T78kd/e3t1RrVL0eVkGtNDF9frtnkzyew5pfT7naso7mOOui8To5dj796JVBdaUcFzyHNIlq6WBiYyOYBB54ATAnfvBt1dVOMhUaa0gVBShMinFE4cJOzsA8U7seg8Kujs1aTl9hDluX9YOS90PSEC0rn+AVhHG0bO9Te1BfKi2jvdm7rrk0oG7MNd9+iYYF+NZblY8/AVWzZKHhnIMyOec4Kj4TPKgoBt1LeAbUvegfYIZWuMfqVJCH+EMCNK+ois627zFvGVsTIMNw712baPwGxvCQ0fuMxgN4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dDaIwzyqgrYO1PbCGUmjo1NFaEeWRahoPo/6POheOs=;
 b=W+uuUraFj5byb6rx3lv9s1wHsVW5f6R/56zPnjpygU3VRa4TMcIfiN9J/+2E/isSbvny2e85mXo8h08f88H9G34Z2r82jN8R2sGQkJZT2xtxJqXqUw6Lf5SDDhImwJtyatWQTojoxvzmadaxVjIojnlNnjZWPivrlAgbVK+vGytVQLR/qEeVd7zhl5tSBqG0QDv/lgrBBlDnWC4E7YInz0h/Sb0r2koaghyf4eesy5Ke84vwKFfaddAJhurmMmcXBTMK7n7HzKMjsJmwwrHFlrcuco520WKFtJUjbRAUSwZL4udy2nQLUZW05DHkVAF0H/tGggPno088QmQltGummA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dDaIwzyqgrYO1PbCGUmjo1NFaEeWRahoPo/6POheOs=;
 b=K9KTTbsb86jCDT93BpyZEKM1X+2MD1hKw9MOGgRqyCWP1w8cNZtVulqHz5MLJT4Q8jyfXS9LzhXhXMWVFop7sfCP+SXYRdILhBW/hMwKIYsfd7o3OytjGGbxMkSngvqQl17+2INQNOFxNTBqAF2qB644XmV/k2bb8s8DBJ3SbWM=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 12 Jul
 2023 05:37:14 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::ac27:c32c:82df:1e1f]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::ac27:c32c:82df:1e1f%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 05:37:13 +0000
From: "Boddu, Sai Pavan" <sai.pavan.boddu@amd.com>
To: "Iglesias, Francisco" <francisco.iglesias@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "frasse.iglesias@gmail.com" <frasse.iglesias@gmail.com>,
 "alistair@alistair23.me" <alistair@alistair23.me>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "Konrad, Frederic" <Frederic.Konrad@amd.com>,
 "Ho, Tong" <tong.ho@amd.com>, "Garhwal, Vikram" <vikram.garhwal@amd.com>
Subject: RE: [PATCH v1 1/8] hw/misc: Introduce the Xilinx CFI interface
Thread-Topic: [PATCH v1 1/8] hw/misc: Introduce the Xilinx CFI interface
Thread-Index: AQHZszc8Uf4q/NDxEUmr5NkcFUbNiq+0UiSQ
Date: Wed, 12 Jul 2023 05:37:13 +0000
Message-ID: <DS7PR12MB5741CF18949EDA878354AE8AB636A@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
 <20230710140249.56324-2-francisco.iglesias@amd.com>
In-Reply-To: <20230710140249.56324-2-francisco.iglesias@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|PH0PR12MB5645:EE_
x-ms-office365-filtering-correlation-id: 8436dbf7-d256-4a08-3760-08db829a0baf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FnppCp9sPUW8APMw9AD0E/dTJyOZGvR8Lpe6qixRP1jdclo4rOIEogdKD2C0SjTQKRnmvs8YUXL5x9Jqk+QhJmasROIm//SvEpN5XeOfIk8seWZPA692a0ooDcoGYl3UBqrmDm2UAURPrE9aTDTZqkezeuXPexIq+GwOT465v6TFyJ/ONDFhSSu8HjF4m0Wg8w90P82863uA8WAyfj9kwnJmnTcnz36K1FIsUEjfRFQsoft7LkxeI5D7w4rbwfbsNv2XZOg6/mlgvA1Oc5EPOnYhVWEO1rOGhAhcEeB3fxExdYIiJtipECsDHirVcmsZguLs4Ho4ycC1G/X9qqeMnfzM7/LWil7F07XeDeGsQnyRicLyNjP6JSGVy8tLy+Pa51A1b9afyBh3utDtoR27be5LtKOBr+TiVlNrzSPZ1qO8kj5YZWZPFRafS6cSgTYLqGnsxXujaIyGiBac/ktybxgYGLyC23OuY54/zl0XyBKmm+5GalV3LS6mnRlicNPRdANE9QSMJuXMHoYlQ6PeBI4KKKbDBJnm17oBIy2x8nyB/+lzAMqJb4S7WP3tFpBwxkh1nwC95bV29y0ON4+KNCuHrW02Efp1LZGfs/2gFPlJOEfK4Gnc/5o3m9FmBLs8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199021)(76116006)(66476007)(6506007)(66946007)(316002)(38100700002)(66446008)(122000001)(38070700005)(4326008)(64756008)(83380400001)(66556008)(9686003)(478600001)(186003)(54906003)(110136005)(2906002)(55016003)(8936002)(71200400001)(86362001)(26005)(52536014)(5660300002)(8676002)(41300700001)(7696005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IHKc+FczMIIeQBR2EaK2ZPffz/nPsTlbgZ3XxX+CFx9c1DrDGZQwNPqudbWA?=
 =?us-ascii?Q?cQIYou6SttBP+H6kAvHyACbmhUzXUeNQKeSgFY3s7+72cbZ2nwpIU4/+HjEN?=
 =?us-ascii?Q?ODT/XR+z3mAwPkNAptwPB/qBnXlqDyb8uF5RqMT5HYmyt9jt0/zs5levI0DW?=
 =?us-ascii?Q?DKjxqFLp/WcFB9lbC3o9CzuWeiGuWs7s1XMUrWpsm8v7eCBJwNqXStu1IqeW?=
 =?us-ascii?Q?nCSrZCCEc+TED0U1pxOmBoMgXwqvG2yAXg2DoePvoNGhHezhgrQwhOAdmbaS?=
 =?us-ascii?Q?/iTbfaBerAxk9At8a749u0lt6Wevbw7mLY+xE0ENllXZL6BBmOL3cjghE/rl?=
 =?us-ascii?Q?vhiyiy9IgHwckiKI9daD7TJBhYUTODN648UejfYftQPPdQu+B0yt9OqddA4k?=
 =?us-ascii?Q?IwQ1cLc0SC61W4zmtaOtWzcvrXhhyX5PclnDawFCS70+Xb7Z2IibDANt8vco?=
 =?us-ascii?Q?0/qUcSd5oO/txnsfzZZiQ8rB/D6vgNYgoZWp4KSMmqpnMtVZzVTb7p/yrgHp?=
 =?us-ascii?Q?qUTlvW9rS+zwdfO6g2BDvLcLlay2t5j2OM0F8HCClZDeO9/DRmVNHGAZaHGD?=
 =?us-ascii?Q?bVGF07uCuex7eW1IUAmx+B84leZYaeT5HCnsyexJdfjoCmbs9lqmd/Fgezvq?=
 =?us-ascii?Q?i7TDN7FiK2p0gTr0aDjpU9VuHNn+3Ywbrm/52LHXmPVqizy+DIQLNsISIYMo?=
 =?us-ascii?Q?jbITLQ2Qhp7LsSabtMPu0IPYLLTU8yCyjA1awTwfJofk7hFh1wdCqTUqNT6F?=
 =?us-ascii?Q?r3/pyWlBxPK78reRoMFZXd73/o7wW61A5Pz7UMneoIgBOaUcuQ5+XR+YFaWg?=
 =?us-ascii?Q?mZ5yxTQSt22YJCnDHfr4zlov6k/yXGDIs2ehUbfgrFlqFmx2sEyfJN7EG2K6?=
 =?us-ascii?Q?Q6BZ+hFmX2FDMhA5rqcN+KL2wg63Lu4u62v0H5FWr1gzH67iLsAW++u10c0v?=
 =?us-ascii?Q?BEavir0Etsb26gIu3ao7vcW+0OvYXzEvRb5bIDLC3TP0ZVzGOyuHodpWTBIV?=
 =?us-ascii?Q?suSzPe9FzhBrooxgJc2zx83JkvHVF67Uw3sI/E6lhLGdT7L89G9/B4pZ/idF?=
 =?us-ascii?Q?64YTRagugpT5NeICWyxP/yDZJNgArbs0CVflxE5uLh5OywnJCPC1HgUZ5Asa?=
 =?us-ascii?Q?e0iCSCmihdcNthlgLBE4O4Eubqwj8/tMGAY3TeV6PCqnBUrkj0gFs1o9YOa3?=
 =?us-ascii?Q?PikTyV1QHegt5WApwG8pww1xHzbm58BU8q5U7ygPhuJvT+Rmw58LNnFK5p+p?=
 =?us-ascii?Q?0RLLX5FABZ8SVih/EuB79WaLsi5PchGhGf10QTDS1vmsl4fC7gZtFJi+HZD2?=
 =?us-ascii?Q?P5AQZDuBQzJKVjPfRl07F/AwHe6sZIKyvMQFv3OdJWmp2kXiEAoJEs85AZzV?=
 =?us-ascii?Q?fbfu2v/4saK8EO4E8ognUDe9aE6w0MvQZg9VL3VUDmIEfi5lYWnct+qP1X3T?=
 =?us-ascii?Q?yD+hxivwvlIMxdihzvuoWCtcjyKaD4OsOBrR73zfJXZuZHDHvzqPV+gHuzYr?=
 =?us-ascii?Q?UTujPLqNrfEvs/Du1y5ia4WFiCoX0kXhLPhEJwySAClD152uUrR+xy2w5v5i?=
 =?us-ascii?Q?Ilnds328T10uzUX6duk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8436dbf7-d256-4a08-3760-08db829a0baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 05:37:13.5161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oXsdKR3oW5Ea8B9HHqLDzdqd+AlMedMZ5fkHbDFsr1Z/gwbHK6hNdvzM5titIIFR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645
Received-SPF: softfail client-ip=40.107.237.67;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 12 Jul 2023 07:45:06 -0400
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

Hi

Looks good.
Reviewed-by: sai.pavan.boddu@amd.com

Regards,
Sai Pavan

>-----Original Message-----
>From: Francisco Iglesias <francisco.iglesias@amd.com>
>Sent: Monday, July 10, 2023 7:33 PM
>To: qemu-devel@nongnu.org
>Cc: frasse.iglesias@gmail.com; alistair@alistair23.me;
>edgar.iglesias@gmail.com; peter.maydell@linaro.org; Konrad, Frederic
><Frederic.Konrad@amd.com>; Boddu, Sai Pavan
><sai.pavan.boddu@amd.com>; Ho, Tong <tong.ho@amd.com>; Garhwal,
>Vikram <vikram.garhwal@amd.com>
>Subject: [PATCH v1 1/8] hw/misc: Introduce the Xilinx CFI interface
>
>Introduce the Xilinx Configuration Frame Interface (CFI) for transmitting =
CFI
>data packets between the Xilinx Configuration Frame Unit models (CFU_APB,
>CFU_FDRO and CFU_SFR), the Xilinx CFRAME controller (CFRAME_REG) and the
>Xilinx CFRAME broadcast controller (CFRAME_BCAST_REG) models (when
>emulating bitstream programming and readback).
>
>Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
>---
> MAINTAINERS                   |  6 ++++
> hw/misc/meson.build           |  1 +
> hw/misc/xlnx-cfi-if.c         | 34 ++++++++++++++++++++
> include/hw/misc/xlnx-cfi-if.h | 59 +++++++++++++++++++++++++++++++++++
> 4 files changed, 100 insertions(+)
> create mode 100644 hw/misc/xlnx-cfi-if.c  create mode 100644
>include/hw/misc/xlnx-cfi-if.h
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 1817cfc62f..3ba115bb9b 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -1036,6 +1036,12 @@ S: Maintained
> F: hw/ssi/xlnx-versal-ospi.c
> F: include/hw/ssi/xlnx-versal-ospi.h
>
>+Xilinx Versal CFI
>+M: Francisco Iglesias <francisco.iglesias@amd.com>
>+S: Maintained
>+F: hw/misc/xlnx-cfi-if.c
>+F: include/hw/misc/xlnx-cfi-if.h
>+
> STM32F100
> M: Alexandre Iooss <erdnaxe@crans.org>
> L: qemu-arm@nongnu.org
>diff --git a/hw/misc/meson.build b/hw/misc/meson.build index
>05877f61cc..9971b1e4db 100644
>--- a/hw/misc/meson.build
>+++ b/hw/misc/meson.build
>@@ -96,6 +96,7 @@ specific_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true:
>files('xlnx-versal-crl.c'))
> system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
>   'xlnx-versal-xramc.c',
>   'xlnx-versal-pmc-iou-slcr.c',
>+  'xlnx-cfi-if.c',
> ))
> system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true:
>files('stm32f2xx_syscfg.c'))
> system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true:
>files('stm32f4xx_syscfg.c')) diff --git a/hw/misc/xlnx-cfi-if.c b/hw/misc/=
xlnx-cfi-
>if.c new file mode 100644 index 0000000000..c45f05c4aa
>--- /dev/null
>+++ b/hw/misc/xlnx-cfi-if.c
>@@ -0,0 +1,34 @@
>+/*
>+ * Xilinx CFI interface
>+ *
>+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
>+ *
>+ * Written by Francisco Iglesias <francisco.iglesias@amd.com>
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later  */ #include
>+"qemu/osdep.h"
>+#include "hw/misc/xlnx-cfi-if.h"
>+
>+void xlnx_cfi_transfer_packet(XlnxCfiIf *cfi_if, XlnxCfiPacket *pkt) {
>+    XlnxCfiIfClass *xcic =3D XLNX_CFI_IF_GET_CLASS(cfi_if);
>+
>+    if (xcic->cfi_transfer_packet) {
>+        xcic->cfi_transfer_packet(cfi_if, pkt);
>+    }
>+}
>+
>+static const TypeInfo xlnx_cfi_if_info =3D {
>+    .name          =3D TYPE_XLNX_CFI_IF,
>+    .parent        =3D TYPE_INTERFACE,
>+    .class_size =3D sizeof(XlnxCfiIfClass), };
>+
>+static void xlnx_cfi_if_register_types(void) {
>+    type_register_static(&xlnx_cfi_if_info);
>+}
>+
>+type_init(xlnx_cfi_if_register_types)
>+
>diff --git a/include/hw/misc/xlnx-cfi-if.h b/include/hw/misc/xlnx-cfi-if.h=
 new file
>mode 100644 index 0000000000..f9bd12292d
>--- /dev/null
>+++ b/include/hw/misc/xlnx-cfi-if.h
>@@ -0,0 +1,59 @@
>+/*
>+ * Xilinx CFI interface
>+ *
>+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
>+ *
>+ * Written by Francisco Iglesias <francisco.iglesias@amd.com>
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later  */ #ifndef XLNX_CFI_IF_H
>+#define XLNX_CFI_IF_H 1
>+
>+#include "qemu/help-texts.h"
>+#include "hw/hw.h"
>+#include "qom/object.h"
>+
>+#define TYPE_XLNX_CFI_IF "xlnx-cfi-if"
>+typedef struct XlnxCfiIfClass XlnxCfiIfClass;
>+DECLARE_CLASS_CHECKERS(XlnxCfiIfClass, XLNX_CFI_IF, TYPE_XLNX_CFI_IF)
>+
>+#define XLNX_CFI_IF(obj) \
>+     INTERFACE_CHECK(XlnxCfiIf, (obj), TYPE_XLNX_CFI_IF)
>+
>+typedef enum {
>+    PACKET_TYPE_CFU =3D 0x52,
>+    PACKET_TYPE_CFRAME =3D 0xA1,
>+} xlnx_cfi_packet_type;
>+
>+typedef enum {
>+    CFRAME_FAR =3D 1,
>+    CFRAME_SFR =3D 2,
>+    CFRAME_FDRI =3D 4,
>+    CFRAME_CMD =3D 6,
>+} xlnx_cfi_reg_addr;
>+
>+typedef struct XlnxCfiPacket {
>+    uint8_t reg_addr;
>+    uint32_t data[4];
>+} XlnxCfiPacket;
>+
>+typedef struct XlnxCfiIf {
>+    Object Parent;
>+} XlnxCfiIf;
>+
>+typedef struct XlnxCfiIfClass {
>+    InterfaceClass parent;
>+
>+    void (*cfi_transfer_packet)(XlnxCfiIf *cfi_if, XlnxCfiPacket *pkt);
>+} XlnxCfiIfClass;
>+
>+/**
>+ * Transfer a XlnxCfiPacket.
>+ *
>+ * @cfi_if: the object implementing this interface
>+ * @XlnxCfiPacket: a pointer to the XlnxCfiPacket to transfer  */ void
>+xlnx_cfi_transfer_packet(XlnxCfiIf *cfi_if, XlnxCfiPacket *pkt);
>+
>+#endif /* XLNX_CFI_IF_H */
>--
>2.34.1


