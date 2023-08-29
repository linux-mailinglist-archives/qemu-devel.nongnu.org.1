Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8211878D004
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:11:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mo-0000eY-70; Tue, 29 Aug 2023 19:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qb75J-00024F-Hb; Tue, 29 Aug 2023 18:21:17 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qb75G-0007VV-68; Tue, 29 Aug 2023 18:21:17 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37TJPRO3025431; Tue, 29 Aug 2023 15:21:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=PFm6/kjB968iv6ig0KiHP5ZCAZJlgh/ioCojjY
 dvKgA=; b=BxJKwtgwp5og955Fb2Yd4ytUrjwGZbgVIF/D9CriPbmIp4PQAix/5F
 7N2FlKLLlEQp90TCKY+1qD0Sszo4zlqW4GkwJ4FkTBoqXJNO+3hqbBlxZfaPTbjX
 iNw4u2FyBA4tXJnoj4lzWfTNNgIPhjbLbvzt49zZo23n6ejlaUB17AoA4lqH/cEg
 VE2/8tz/aS4Mtnjj1+6IF6rYPsIHnOMGtlqtqWd47j703njO8pU13BbXz+zm1Iu5
 Z7AN74babMlgH10ZS7B9BIxuQHqY+f//vTtYzYxy8QozFqGY68zXQUxQcLyyi4f5
 XFUGV2rKgQfMZnsIx3mxORrogYscDCaw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3sqdqqynfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 15:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nitdTgz+M3iMl4zgOQSuspkACnuKQKWdviD+snGCEkr851vQ3B0GWsw6pZNTC08+NiFfZyhQAopoRYFS69PM2RF+zbWWJyAsWLuxetjcFW+XskFOeg4Dfoo6+68MQlhfXFIYA//uBkm40vcb5NI3mkpiC6Acbf4gofLL8wBC8CgYujeR9m6OpdsWyId7N6qh46yo9DyN+b6CoEhPa1L+v6mdw/qXo99PtmsxCtfmPyZx8yAR3qTDY6Uf9Yhb2QpYle7cHayveL7zldZzV7wV8FQVuAya4kNS1jNMf0nIydrU1DnOfXAgbRaxOfYD3Mf4Cmy9HExHem87M/QZW5WdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFm6/kjB968iv6ig0KiHP5ZCAZJlgh/ioCojjYdvKgA=;
 b=b7G9W/SHV7azMHNf4OuLOEJFdZu5XIuMLOvukzYJbw00TUdDLWyyIg+ohZP94TFCg5vW0AYHYnaXhm7eiHvnzeiesuMSHrq5TDOAvgfwh5OCizuHTR0457p6/7b8cHmW+AXV3RMV5d2S9G/kkGaot2t7mEUzWVdgVzdMQQGL4waU0HvtCWi973LIotDgFhNgPXfBGHuvCuxj/buhrRYslnDUEZZdMlajSoDN1LK33kSg6Wf1rgwQZK08qx4s9zuPnieGTEy3Q0omFhu013ecJIJCb9rHdSrCmhJOAjwL/uvtVBTvIMyeZfN5gSjXvNwHReFo/MNvh4UX7Hh1UKK5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFm6/kjB968iv6ig0KiHP5ZCAZJlgh/ioCojjYdvKgA=;
 b=frpcdi58IAm71GDL4VjIbWoUQ07IZvz4V1UAEIbm4KwCnQ0IMdQ91KxYaBv4sfaEzvJZJ2W/axgntAoTPBUUimjtwU3ZncaZ/wbTs1kJl1G9Wf2YJFBjj4a6K5I6rZeIXQornUq2yKaswhJv3FeylMkRihpxmc3enG/KRxdr99754CFd9hsiurI1ni8Xm7/W1e6Fh8mIQAqDY3/ONYeT+A5TiyuCPspzQBCUSdso5tLhdvgV/QQh7RPKOxBFu5P0xGVNeqS35QRjnDVYgOFv6yj7kBXN4XusHfLI1fnRcirIlYX7Qld8GT5UTm0tegxJrx3nwA1+mXz+nIiIr+0ZVw==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by SJ0PR02MB8611.namprd02.prod.outlook.com (2603:10b6:a03:3f7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 22:20:58 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8%3]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 22:20:58 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/2] vhost: Add Error parameter to
 vhost_scsi_common_start()
Thread-Topic: [PATCH v2 2/2] vhost: Add Error parameter to
 vhost_scsi_common_start()
Thread-Index: AQHZ1l53YqChSIV+V0m5dzWeNaNo2LAB4W4A
Date: Tue, 29 Aug 2023 22:20:58 +0000
Message-ID: <691A5901-FD0D-4B31-BE47-C7F5C3929BC5@nutanix.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230824074115.93897-1-fengli@smartx.com>
 <20230824074115.93897-3-fengli@smartx.com>
In-Reply-To: <20230824074115.93897-3-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|SJ0PR02MB8611:EE_
x-ms-office365-filtering-correlation-id: 0f1eb01d-8785-4dde-ec9c-08dba8de3859
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aY60TT0B3qxQsD8X2FbsgurUPPxWPGzJA4QZd+tmcMWDGU12E90hItE0sDofjJAK5yqSXTrIu3PbjXnPrYrE56313V0GztSTrb8DFGk2L56Iy1ztviCIPo2KvPVtJTY40meVjSCpsn0AT8MQrArjlQfsMuwtGtXNOTWzu4CqK/DqHazqbDsNA/B/Zmul/FYyAu2GyeSJBgNVEURSQ4ZxgDoEh6j59F4I6WH0hXn34gUW9CF7maExZubYlu6nIKJqswBbyhPOz1Okf57+ATTdCASoKVj9AT7PTDbcWT+/9JLOxUt+HiFlfXza5UXl/9N5lxBz43Xo8fX6Y8EZp9ykfvY5dKupiS6X6mGMkZ39nHif72Oq64+DI78sQ98TRsed4oQCucrgzuZmqk4RjVy6rI10NcNY8WPg4wu4Ov+dJNshvoyo7202ek9iSCvhJYdfjTYlj65hnIpXKKtxH+dZeDGxB8POHw6bsXEgAwhG7Yrcd/NtYCBWzx6GsPL6mlC7inbUigffaCZgmMU3r/oxuAB6nHJdwVJiA07beKUwppgzt/5jUFe6KDQqjjTX+kqUbDqcpPzd6RrkQiNS4W5gVE53N07NuuTaXevBvLA65ziYtwqfG1lTEidVqHVNeauOsGvZPs3bddZmPHvXF+rv9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199024)(1800799009)(186009)(91956017)(8936002)(36756003)(83380400001)(53546011)(6512007)(6486002)(71200400001)(6506007)(478600001)(2906002)(33656002)(26005)(66476007)(7416002)(64756008)(66556008)(6916009)(8676002)(316002)(41300700001)(54906003)(76116006)(66946007)(4326008)(44832011)(66446008)(5660300002)(2616005)(86362001)(38100700002)(38070700005)(122000001)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NHPNeV3MPRyjE7GmHucrpOIrOBJyx7aj3D0F/F8pyU5XABCwQQkvr2cdWJ?=
 =?iso-8859-1?Q?/AyWSmbaE4BTxCdbYWHBTkaioOxMUbpS4pW9xMWMvYNtuhWySRZgtyw45j?=
 =?iso-8859-1?Q?ujlqFe3+iNIS4suDJLblBV5YIb0lJGChNMXdO4cN1RB1wAEVuF214FFZ7c?=
 =?iso-8859-1?Q?u+QTYVevMryQWYpGvGd/6LZpXSZwujOkGdGsMUv2fbJ7aX79QxyRY48tK0?=
 =?iso-8859-1?Q?Vz1MFfVL/uiMUUViL6llhRFKTbSWVXG17ySD3QKfsN50D0UY4dgbIdNAXn?=
 =?iso-8859-1?Q?VXsNdTxXPwA20sMCl4kvmVeqkVtxRQP3nxaSIcDwJ4tXmd+zSGpbesq8MG?=
 =?iso-8859-1?Q?Kg5umuu9eeQto6lbNL+wuZ+8h+Y+O9LHzMI6pB2o2iYuH7lgRT7nK8BZ9v?=
 =?iso-8859-1?Q?pDlqOvFMHVzla7HnInwDPluJBFft/HRWlkZZBFg+6gnZKuabLsUan8cxzq?=
 =?iso-8859-1?Q?if5tKf0+AhmqyD2r22lw5JXh44jgUcfcehWhAbYtw7Su3opeRY3p+unT5i?=
 =?iso-8859-1?Q?xG6LlIaDP4mz8A9whFBMBrY8hmTxmeDjNC69lI5T2PjstlzC31kDbxwJAE?=
 =?iso-8859-1?Q?qme0TvpOqSqDOpgy8Bw8WxzBZ61pCh4ZzFIX7+KLHPkMaLufMZcFPk12+T?=
 =?iso-8859-1?Q?HXR0RmqN2d3oBe63hFLOhgfwSJc50/qOarDHYA2FSxtkC4ZgQtDaLjqBrF?=
 =?iso-8859-1?Q?i10N5k25s+Q4S3WQilvipekrOHW3Q3WOVU2GfyZJkWK0cdLpvqYkhqR9qV?=
 =?iso-8859-1?Q?Fny2dAygl9zWP6p7VCXJvBXFFUeaeOMA+jEDSIMqvDfPANDrl4gTW1Odie?=
 =?iso-8859-1?Q?rbatirQJFr5x/GpBeoTsSIanmaI1aGL+DcD3xploS1rCAqxGrndDIwNoBf?=
 =?iso-8859-1?Q?aKi7k2MgDm9/LlsTFVFqKtw/G0gv0RFRZf7gl7mlrmZ/RyNf/lLxyUFXZk?=
 =?iso-8859-1?Q?T3LybdG/ZAa1ljwT0TAvolniMCv3Uo0hgJPNormNy+bVnN0VL4rztzqN6+?=
 =?iso-8859-1?Q?RRiQLaOCLVJ44OO6MmJwBWd61XCXcIMZoEfbGIrGDhnjKvUMmvRqfS9WHO?=
 =?iso-8859-1?Q?FsbPUGmpsnftXeAhP1lOKi8NcZKPpO7KgG7KUSE3zAuN0Gis72g9NtGGtr?=
 =?iso-8859-1?Q?Fq9Yc8ozuugy+Kzv7QsEklEXIbvdhDpRWOQW/U9NS+MlV49GtTJEP5iAX4?=
 =?iso-8859-1?Q?rO89CDK5QM0I0MgrP/mLjly/qUg4MAFE04lE97rwkF9TQ+B4NNs5OOCuOi?=
 =?iso-8859-1?Q?QbJyXCW6tVyMSYxkh0Nf6TwbqnnJ1nQWco3bJlJNUbWjU5AzsLhxb39ih9?=
 =?iso-8859-1?Q?rrnrKeG344hr9p783UkTsV1fPcOGxKDAjKJR/hMHIwKSwuGQwaVa/t4QbI?=
 =?iso-8859-1?Q?mZkybAG0+FggFGnF84Vhc9R70VtSNd29AVRF5Gfwu67i0+6Ym/KYEX0f+M?=
 =?iso-8859-1?Q?WZkTGeRHS2ZFe5J8kh+GvY0gmdTFR6sSfHeoVar6x9yvwxuV93su5spga/?=
 =?iso-8859-1?Q?fU/lu0CXWFwaOrJ760gHVLbhKcAPjvCUQUbyNE0KeNiFxrmNt6bOm9K9wv?=
 =?iso-8859-1?Q?EpijmnHWoxkvlETiglei4z2uMIDWwjR1m2mYQRDi6ZyTMRWDEWENYgLM+K?=
 =?iso-8859-1?Q?MaYgm2+3jEdvCJhYD0xL7dYKtAvOMwdCZAHNbs+weJQ0gC0UptenRmkw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A3BB3B65A17C0445A7766A5E47BD8DEC@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1eb01d-8785-4dde-ec9c-08dba8de3859
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 22:20:58.4340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: en7lA4bdbpwPm3MgfWxReBrg61qIjrrq3wDp0BgleEueqRrH6F63m4cozZGpIfqlsa2XgTDkuSngetzScXMjtwnK/CmkGZ678n4JdTDRFs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8611
X-Proofpoint-GUID: HmIYiQ4N4oeqjlARaRK6ybX7jDPQ6Af_
X-Proofpoint-ORIG-GUID: HmIYiQ4N4oeqjlARaRK6ybX7jDPQ6Af_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On Aug 24, 2023, at 3:41 AM, Li Feng <fengli@smartx.com> wrote:
>=20
> Add a Error parameter to report the real error, like vhost-user-blk.
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
> hw/scsi/vhost-scsi-common.c           | 16 +++++++++-------
> hw/scsi/vhost-scsi.c                  |  5 +++--
> hw/scsi/vhost-user-scsi.c             | 14 ++++++++------
> include/hw/virtio/vhost-scsi-common.h |  2 +-
> 4 files changed, 21 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> index a61cd0e907..4c8637045d 100644
> --- a/hw/scsi/vhost-scsi-common.c
> +++ b/hw/scsi/vhost-scsi-common.c
> @@ -16,6 +16,7 @@
>  */
>=20
> #include "qemu/osdep.h"
> +#include "qapi/error.h"
> #include "qemu/error-report.h"
> #include "qemu/module.h"
> #include "hw/virtio/vhost.h"
> @@ -25,7 +26,7 @@
> #include "hw/virtio/virtio-access.h"
> #include "hw/fw-path-provider.h"
>=20
> -int vhost_scsi_common_start(VHostSCSICommon *vsc)
> +int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp)
> {
>     int ret, i;
>     VirtIODevice *vdev =3D VIRTIO_DEVICE(vsc);
> @@ -35,18 +36,19 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>     VirtIOSCSICommon *vs =3D (VirtIOSCSICommon *)vsc;
>=20
>     if (!k->set_guest_notifiers) {
> -        error_report("binding does not support guest notifiers");
> +        error_setg(errp, "binding does not support guest notifiers");
>         return -ENOSYS;
>     }
>=20
>     ret =3D vhost_dev_enable_notifiers(&vsc->dev, vdev);
>     if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Error enabling host notifiers");
>         return ret;
>     }
>=20
>     ret =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, true);
>     if (ret < 0) {
> -        error_report("Error binding guest notifier");
> +        error_setg_errno(errp, -ret, "Error binding guest notifier");
>         goto err_host_notifiers;
>     }
>=20
> @@ -54,7 +56,7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>=20
>     ret =3D vhost_dev_prepare_inflight(&vsc->dev, vdev);
>     if (ret < 0) {
> -        error_report("Error setting inflight format: %d", -ret);
> +        error_setg_errno(errp, -ret, "Error setting inflight format");
>         goto err_guest_notifiers;
>     }
>=20
> @@ -64,21 +66,21 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>                                         vs->conf.virtqueue_size,
>                                         vsc->inflight);
>             if (ret < 0) {
> -                error_report("Error getting inflight: %d", -ret);
> +                error_setg_errno(errp, -ret, "Error getting inflight");
>                 goto err_guest_notifiers;
>             }
>         }
>=20
>         ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
>         if (ret < 0) {
> -            error_report("Error setting inflight: %d", -ret);
> +            error_setg_errno(errp, -ret, "Error setting inflight");
>             goto err_guest_notifiers;
>         }
>     }
>=20
>     ret =3D vhost_dev_start(&vsc->dev, vdev, true);
>     if (ret < 0) {
> -        error_report("Error start vhost dev");
> +        error_setg_errno(errp, -ret, "Error starting vhost dev");
>         goto err_guest_notifiers;
>     }
>=20
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 443f67daa4..01a3ab4277 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -75,6 +75,7 @@ static int vhost_scsi_start(VHostSCSI *s)
>     int ret, abi_version;
>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>     const VhostOps *vhost_ops =3D vsc->dev.vhost_ops;
> +    Error *local_err =3D NULL;
>=20
>     ret =3D vhost_ops->vhost_scsi_get_abi_version(&vsc->dev, &abi_version=
);
>     if (ret < 0) {
> @@ -88,14 +89,14 @@ static int vhost_scsi_start(VHostSCSI *s)
>         return -ENOSYS;
>     }
>=20
> -    ret =3D vhost_scsi_common_start(vsc);
> +    ret =3D vhost_scsi_common_start(vsc, &local_err);
>     if (ret < 0) {
>         return ret;
>     }
>=20
>     ret =3D vhost_scsi_set_endpoint(s);
>     if (ret < 0) {
> -        error_report("Error setting vhost-scsi endpoint");
> +        error_reportf_err(local_err, "Error setting vhost-scsi endpoint"=
);
>         vhost_scsi_common_stop(vsc);
>     }
>=20
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index e931df9f5b..62fc98bb1c 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -43,12 +43,12 @@ enum VhostUserProtocolFeature {
>     VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
> };
>=20
> -static int vhost_user_scsi_start(VHostUserSCSI *s)
> +static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
> {
>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>     int ret;
>=20
> -    ret =3D vhost_scsi_common_start(vsc);
> +    ret =3D vhost_scsi_common_start(vsc, errp);
>     s->started_vu =3D (ret < 0 ? false : true);
>=20
>     return ret;
> @@ -73,6 +73,7 @@ static void vhost_user_scsi_set_status(VirtIODevice *vd=
ev, uint8_t status)
>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>     bool should_start =3D virtio_device_should_start(vdev, status);
> +    Error *local_err =3D NULL;
>     int ret;
>=20
>     if (!s->connected) {
> @@ -84,9 +85,10 @@ static void vhost_user_scsi_set_status(VirtIODevice *v=
dev, uint8_t status)
>     }
>=20
>     if (should_start) {
> -        ret =3D vhost_user_scsi_start(s);
> +        ret =3D vhost_user_scsi_start(s, &local_err);
>         if (ret < 0) {
> -            error_report("unable to start vhost-user-scsi: %s", strerror=
(-ret));
> +            error_reportf_err(local_err, "unable to start vhost-user-scs=
i: %s",
> +                              strerror(-ret));
>             qemu_chr_fe_disconnect(&vs->conf.chardev);
>         }
>     } else {
> @@ -139,7 +141,7 @@ static void vhost_user_scsi_handle_output(VirtIODevic=
e *vdev, VirtQueue *vq)
>      * Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
>      * vhost here instead of waiting for .set_status().
>      */
> -    ret =3D vhost_user_scsi_start(s);
> +    ret =3D vhost_user_scsi_start(s, &local_err);
>     if (ret < 0) {
>         error_reportf_err(local_err, "vhost-user-scsi: vhost start failed=
: ");
>         qemu_chr_fe_disconnect(&vs->conf.chardev);
> @@ -184,7 +186,7 @@ static int vhost_user_scsi_connect(DeviceState *dev, =
Error **errp)
>=20
>     /* restore vhost state */
>     if (virtio_device_started(vdev, vdev->status)) {
> -        ret =3D vhost_user_scsi_start(s);
> +        ret =3D vhost_user_scsi_start(s, errp);
>         if (ret < 0) {
>             return ret;
>         }
> diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vh=
ost-scsi-common.h
> index 18f115527c..c5d2c09455 100644
> --- a/include/hw/virtio/vhost-scsi-common.h
> +++ b/include/hw/virtio/vhost-scsi-common.h
> @@ -39,7 +39,7 @@ struct VHostSCSICommon {
>     struct vhost_inflight *inflight;
> };
>=20
> -int vhost_scsi_common_start(VHostSCSICommon *vsc);
> +int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
> void vhost_scsi_common_stop(VHostSCSICommon *vsc);
> char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState *bus,
>                                         DeviceState *dev);
> --=20
> 2.41.0
>=20


