Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4899D78D46B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:55:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGvP-0002Uy-H9; Wed, 30 Aug 2023 04:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qbGvN-0002G3-8k; Wed, 30 Aug 2023 04:51:41 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qbGvJ-00089a-3r; Wed, 30 Aug 2023 04:51:40 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37U6dp9h019716; Wed, 30 Aug 2023 01:51:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=cpuj5KjYICwATaNJ+tjeXAL9FXCUhZyJctZQPF
 405IU=; b=MNdKo6lesMxJyW8hSSzB6Ue9IpHuyFK89OxyCDLmjExYDJn2RQypFE
 n9LG6i6+2x7csxCzcTCYW0dKh+Io+CC7FcEC4iyOd+W+sfXPvq4lNODpsNQZY4gd
 wNGdRtLfC8CtXziataHd881lSytMyB6Mb2ZDXGh2MttIyBKAzWJN/XooZX5GlBgc
 eFN7QgdZw/Mv6Mnywc046ZcAeH9TWc7b5GxUaxXQSacLoD3EmkE2acTdk6cA31by
 N5EwRCwtoayn4Ft3lyFrx2z2/pDQysGnm+GzsrnjUUlyFFLAZXa/88o3exkHBD12
 GagWRzxgmtvSipYzMN5Kb5jTUSETka3A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3sqda68h6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Aug 2023 01:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGVzOxKuS9yXGcPOT9PKDAiAqos65Mnva+Zsdxw+UxxaERkGR6gEZVYsECNCWT7bKy3s/Z1p2G+qhFoLvfRTYuR5PvNCG+gVarACxADtG4Y8TPKlzlhCDYdeGnM71YxoXs1FaqXqNaCr5oQnsT4teYmZDoZ+iRYR+B5Uf9yHgt7Mfre3b6yfOMex5lMn9xCGDe9NS1oeYigDn3Dz/OStgMvN3OOEDEM8qAreSQ+K3dkab4VT0du2xF/5f/stRacmJ3zVBlLYeEq4/y2WBe1K7G0GU0uduVAJqxZFiAbZJh383/p6xelZlHZofjYWy0s6Mvhz+7cf67art9R6m4wJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpuj5KjYICwATaNJ+tjeXAL9FXCUhZyJctZQPF405IU=;
 b=Xd1v3e7SWAVnMGTcZ6jCpVu3J/3P8rgsep/mSRaXjbRXHeWGWDYQ+mevVEmpQFrXuVHBbk8hWFSq3rINuIjm89deQLHWg65uMF/JEtyKVp1tapMRS64hmmllnCZPp/VGAdc+ucELY7IRqnULga6y6I6Eb1LHZ/Je1LDIbGSUn6WE+6jpp/EK6B9GmUhmn6iZtNzSAvwJcugy28pkif6zYBdl+Lg3Fbcjfsv7DuK58bWBaBkTgQMzZ2DHZheg8fNYs/kRDTW72F3u2YEigMd02NsGoBvlNbtPZTy/BZmrBkwE9NxFYWxoN/1v62Pd6hsfdGlBnePiL6omerey9v95CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpuj5KjYICwATaNJ+tjeXAL9FXCUhZyJctZQPF405IU=;
 b=JhYHMrJL28cJVstkhHrsmc51rls4gTRVSxd6+OPzx6PgUW3uT5jQi6KbQxruQNHkmokbW1uXkYJ2ngEmsbBhHoRF+6IZIPYdUbfErGcCwQZ81RcYt5enTmKwQlnHCUuUdzhT9zss1Ce0bzpPIfpjjqpAFQQcdZoc1K8hnd8o6XNSQVg6yMgAfM/q3J3Iv2HUsz0jRFRFGfXGrf3IHNWGpDGewfxKb/tGK0iRNj1BJAOeCjy+WmKQYECh7ApZnD+6QaR8U6LygXafD2s3/jLHHoPIgs7jsKwMAuCwusObg7OhjjtXerY1J60L1AC0BSNLZys6bOwbKJo4hN1d/Y3osA==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by PH7PR02MB9339.namprd02.prod.outlook.com (2603:10b6:510:277::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 08:51:19 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 08:51:19 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/2] vhost: Add Error parameter to
 vhost_scsi_common_start()
Thread-Topic: [PATCH v3 2/2] vhost: Add Error parameter to
 vhost_scsi_common_start()
Thread-Index: AQHZ2v6n6Ye7MNF+tUO1zw3Z/SJjGrACiEmA
Date: Wed, 30 Aug 2023 08:51:19 +0000
Message-ID: <DB6ED5F8-5D7E-4580-9882-407355D7CFEF@nutanix.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230830045722.611224-1-fengli@smartx.com>
 <20230830045722.611224-3-fengli@smartx.com>
In-Reply-To: <20230830045722.611224-3-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|PH7PR02MB9339:EE_
x-ms-office365-filtering-correlation-id: 7eefeb31-ae64-4166-700e-08dba936474a
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BTyPD054h4Gg5BIESlaUkLnc7wNqxrrmhml0ttf3W3dYGwUAroKyilecj97mNGZ7m4bA7MrsfkisMiSN27LEao025iSy67shqD3gpL73ch8xY38WItuTIeyBYvez8NFLMqNuAIXnvF1CftWWIOYHN7SkWKmBMpFyTnBFVhVxkqan/Lj8YZrByk3sNfMvNu2ua8aBCxiX3rbizaEtzMY9tvwF/zs77xxnvHelS4PlKEDFTaLRVJmZC4thFCWwIImjXW7pz1iRfVnBy3qxxgtDaHnLMAMqhVGBlIL4SZpia/aITyJslaAADzkIxeCmK2m5iAFtVQVyKsTx+t36fLAEFnCLIcCYomFarcrv0mmnNTQIrLM7uWL/IHrf12o/FRDdrObZuVT/4hBgrekTW6fq0TIhbD52OeNaNE+XI69mcsn9sxGMmQpFeew1yZZ4sVzJvj/GIh8GvtKK5mXXVAXJEI2TOWoWMTJFf11gUm2CExe5gTnq7rnT+3/ddDfOTm3Z6Ptz9uIU4LS8SLUR85iSI1hVsxOkfZgZPb81XJ4KcaDa0gSF/zYZlNtvgM6ke9Cgen1FTKx1eybVb29o2l6WT8tjLfPXu/QfpZ3dMaE99uH7IiBNBY8YdEm8u+73LJMrWGeQH7juTWmjcQhPQALNKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(186009)(451199024)(1800799009)(26005)(33656002)(2616005)(36756003)(71200400001)(83380400001)(478600001)(6486002)(53546011)(66556008)(6506007)(6512007)(316002)(41300700001)(64756008)(8676002)(8936002)(66946007)(91956017)(54906003)(6916009)(66476007)(76116006)(66446008)(86362001)(5660300002)(4326008)(44832011)(7416002)(2906002)(38070700005)(122000001)(38100700002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xQ3T8h8738khcIM6iYSq6DC49a8YvhoDDBq/8ShnjKzvisxhEiCkRqAsRe?=
 =?iso-8859-1?Q?PXSwXiugHDr18s+h1FylCinJ3fpDlK85CkCqFgva4w0pctJjhjkHO4VZpo?=
 =?iso-8859-1?Q?oNrSFVaVIe0YD+vBHOVXZSUmM4z6jpEc+EFuoa9dPIJWycqOT2U4wR53uc?=
 =?iso-8859-1?Q?b1GVPIBEgXAv07y4RUTIAEfCW/ZwU7hFHZSczn2kW4YjhWZGRFX8kCnWME?=
 =?iso-8859-1?Q?Ft7s7O/IVBiAlRKBej+tsBU0TGjwhAeM/7/1LScNdx91puBBkJxMKTjdYN?=
 =?iso-8859-1?Q?oVqIekcPHKi+bhM+HHJ7vOGJescnh4ktlLWPyIBzJcbeJRlG2UZ/tF26OJ?=
 =?iso-8859-1?Q?S3unN0ULjQs0HeqHmJ3IQ3ElZ+R3hdtgCqlu25nHoYDgNcTZ6PGRC6Bjcn?=
 =?iso-8859-1?Q?tHcJbspYzTMlsXEM45Q2/8x+/guFqpaROrHeFi8ziDyUvhEUrRLSXisW1X?=
 =?iso-8859-1?Q?7Ke5sDWMRl0x7EAD/voo1D8DCwdvVEc/Yczhvb6BFu2gfSDxnFx+JhvRGa?=
 =?iso-8859-1?Q?uIqM+UTn68W/Dc4cioj53W05pVortOBKeXZdx9ogrv89uf7hnOaFllP8X2?=
 =?iso-8859-1?Q?F1MBosrc1FNfcLEPDuq46EyR0UooaXNpDOk6vHcd+70G2DYSPWfZRF6U1a?=
 =?iso-8859-1?Q?/ej1iRN5m3OUVz+ojFUoJTCewAFcXAXzSM1yvvwBYsTfotIx4lsWCMG0kk?=
 =?iso-8859-1?Q?P6nQexU8jSU84deqcjfyzXH9tfbV6EVoQRqFIgnIYGBp/oc9snkPbOn+oR?=
 =?iso-8859-1?Q?F7C9UDanaoA++gX6ijrIg2Pt6MA/I2c9Mfn1azDJt+cq1w91qKtIH42+s2?=
 =?iso-8859-1?Q?nzh5MLV/JLmLFKNhWqggaZHpEipnIc4ogzVTo5aGLcGz4O83lLe9Ax8LVP?=
 =?iso-8859-1?Q?0SvET4JYxVFZ+Vf9YWZluQRe2ppzRPNJ0RLPskThT0XobSdSRuWZBIS1/V?=
 =?iso-8859-1?Q?XmLKlK/2/x9DOkOrl9uXyT4YINrz8Fn8xXHgXdzm8jphfhjGts8XYMm2Qj?=
 =?iso-8859-1?Q?HlsmIV/78l3FTO5bhCbPqtfNRVax5WYnHskJ3GKpOdNyg2RvTs37jYyWvx?=
 =?iso-8859-1?Q?eP4PyGImUNi1zMB3sgxwLPqwWhWDzMN5fCutJXucnrskIiXvycDhaoleUt?=
 =?iso-8859-1?Q?HOqCKGt7v+aM1Gyztd34LvreO75dPddZ/hMQZb5xjuLzwJnNeQcKaiVl4V?=
 =?iso-8859-1?Q?GMwGJXn71rtCZgYjpNFq74h3u7ixCokRwzCqsZU1wNzSjP/fEDomHZpqsn?=
 =?iso-8859-1?Q?HpcdjVktXFrPw3U0i+qjlAdRmmnJZqn/EFewToLn2W5PDj37QGltoZbUot?=
 =?iso-8859-1?Q?ePG9Jd0W2u2lP6l7stAzTpQ9gyvgGF4bQoqfNISYPKCB2P6v2k8CquQ8NB?=
 =?iso-8859-1?Q?PT9BE/a0nU6tITgOUoRcqpenMrGzeel6LfiLCRanwvO/xd5xd9nSX4aKk8?=
 =?iso-8859-1?Q?7m6/lD1cbM8P5eVdsD425AZfRC2zVLuDd0J/MxxlONMTLcRxdIY1vHV6LO?=
 =?iso-8859-1?Q?uGVtl0wmXHnkpFm3dmgOZnsuLz4BrBZHuNyeGKPdXnDjd+dQjTYCjKnO17?=
 =?iso-8859-1?Q?P71styd2ynVgbzJ0JWgP4ZMy5jvt1w8v/2q3HTQP8gvE9EjEzMD/5ndZ3F?=
 =?iso-8859-1?Q?1dPjj3BcMaICqeLF7c93svrnzPO5g1aoE6lQqDOb/lC2vlLq1gz7v3pw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <BF49E40A22775543ACE04FF42706AFBF@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eefeb31-ae64-4166-700e-08dba936474a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 08:51:19.1868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVkZ4o/ZydkqsmDibBGsudYOa6FQlxBsjveVgC29miTWitdIno9u3hgMo6r67iSjjrray3lsltdwO867C/y7kBOLZibjp3Nb7XdJD0AEk9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9339
X-Proofpoint-GUID: 8nCgncURNwuoBq0SAyAsTAG-zvZSFpux
X-Proofpoint-ORIG-GUID: 8nCgncURNwuoBq0SAyAsTAG-zvZSFpux
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



> On Aug 30, 2023, at 12:57 AM, Li Feng <fengli@smartx.com> wrote:
>=20
> Add a Error parameter to report the real error, like vhost-user-blk.
>=20

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> Signed-off-by: Li Feng <fengli@smartx.com>
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


