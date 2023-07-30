Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3605576890D
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 00:14:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQEfk-0001oe-KD; Sun, 30 Jul 2023 18:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQEfi-0001oL-H2; Sun, 30 Jul 2023 18:13:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQEfg-0007Vg-Si; Sun, 30 Jul 2023 18:13:54 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36ULnMIR008488; Sun, 30 Jul 2023 15:13:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=OOUZQky7zeinVpKYo1HD5A2b67r1/AzPcbZg3+
 O9j9A=; b=vtuISjDYeAn4z2qy/U/1Ls7LnW3+BxxRyOiNENeJuXjyqVh263yDRV
 IQyglnfQkBVi+BmWk8Q3QBsRjv6E4fonByCGLdQng4xf5Ws0q29CUEpDgGWjqE3j
 OVerI39IVXhTBugG6Cs65Omt4wsRgycX6+dHXBeoABEKBH1g7T9U6+p4s1zo7zrw
 CVSWYkyiYA89ES9sTd1r/yrGfLKi9KtnYDXc1tvrvvBSoqIFyy6rbQQHuPBRK3DV
 CgsBaaaHlZdPhrSicbfky31d9qcgj9rAPK6GwzY+Tx2qsOTWZa75z08sIyxiuYg9
 21BWlHKzUSWdB7tioYnRUmHErhFL+XGw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3s523cspjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Jul 2023 15:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYvCNLpg9/Sf8Fm9vvqbORFH4+ds6LH/VVEhl7EjYELcQEx/eb6uNfRUVGrlBokTURAT2GHh/1D/wL8RK87e31GTkH972XKSXxeLhf/S5hgrUkmoCkpA1ImEfz/94+iS4PoyVytW8gwdXiaIvYM31J/EJagAq1s+MjqX8VVTSltG68ZVpGquE8qQAEVr7AK/1NNkfYO5j2mdVtaIlqDjgrHwFgMmdijVXeYX8aKL8Oc/orSV9rxhZtzi3uKbf29NXwU0q3iJyze7zGd49a8tcBn1LG2BDQkfpbJ/eVkl2kYSpHKdRrxLRcHo+h1q+PPMcNStOd0NbulkXEG1Cc8ILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOUZQky7zeinVpKYo1HD5A2b67r1/AzPcbZg3+O9j9A=;
 b=Ubi8GjNStN/yz5d+o0cvk7IC7bxCMV5jgJ1/x9M58wvH72jGuVt3dUdwUZdFHZZlcU4636WiPDlXFTh/C4CaAdNK7C7m/5zYvXlhfD7Pnwndi9vfF/2wEn2Q4aWd7YrP18ArzDsKz/jjgHNXPFQB1YDdd/9ZyXoRs6NwvStulqo2jnoiHin1G3yMs2wUSi434EFb6AIJZKcX+/oBz767iDu2dTHKjyq8apvHcfkf9P1ERO0a6taLx8NhKKM0FUDSp/ZMoa8QffN9WHI96NxiNVsOav1O/zKZdRhX9QlI3i3STnw/8UyK5lAhEwR5byJHeFjtDDYSq8WYa3MFgWd/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOUZQky7zeinVpKYo1HD5A2b67r1/AzPcbZg3+O9j9A=;
 b=pe9z1TVrRsplR+CdelCaff0ehRFUkVPV93Nv5xTVyIJZ1wkWatYZ0zjXQG/jq8rkvsWwlBXCeKsDIp4PwAETSJetTQ5JCmLyAurJq1Mjtwh4GTkD+islQW4m+TL6LsHZ6yet63r4Fj8mrWO/SIJoy4q+IzVKsKqlOVzFssUn1XuFBNiv6XzfgJihhXnXXyBjTwkIqWhFVaQMQXR/TxfxznDq05E2CaYi+QVRhXflIv0Vq7GXtwqR9P2ThAm3EP6IffwhprLdWgGe3ztjAdaxWYghTZN2KF3CLFLtAvGZGE3gWGNzWLvA2yHEWzRAOhD0tTCYzjutWsIksZG3S2KQvg==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by IA1PR02MB9419.namprd02.prod.outlook.com (2603:10b6:208:3f4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Sun, 30 Jul
 2023 22:13:46 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239%3]) with mapi id 15.20.6652.004; Sun, 30 Jul 2023
 22:13:46 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 3/4] vhost: move and rename the conn retry times
Thread-Topic: [PATCH v2 3/4] vhost: move and rename the conn retry times
Thread-Index: AQHZvuThWAToTj5LNkqb8vRvTiQAxa/S6GyA
Date: Sun, 30 Jul 2023 22:13:46 +0000
Message-ID: <C0C0865E-1321-4A93-9F9C-2702631AE74A@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
 <20230725104256.4861-4-fengli@smartx.com>
In-Reply-To: <20230725104256.4861-4-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|IA1PR02MB9419:EE_
x-ms-office365-filtering-correlation-id: 414a6cad-614b-4abe-cadf-08db914a3e74
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+gInrCvkau4IX+2ebI0R2u+mGQ2pQXofn43PcY3+I8J+QbOb19iX92MCZR/jUVxa4z/fRnwydO/biLHKcQZDj/9sHS2lZzAd5960/DabTKKnAxjfg9UjW+80Rs8sIumrcn0b/8g/ET/WLx4lZeDADHaXDVPTO4nH2Z582KEFd/yQmO1JsBGJ0Up2ec/5t/fuS0qRN7GwO+Hs5Y4VIzqkkJphMHXAI3d0hWc219Rin9tfzjBXk/CkCyu+rTnphMKh4Rgaws0miDNU2Yen/CAUnEV8edNV3pHpOomNKfCFkZ+tMoJBT0SnYBCBjfh3K1aXiGIHY3sXqrI8w5MWrcY++9UPK+DK+ck3sK0zHAoIeePSbhyAT1k8h0GwfBOAp6FrVPH+gJ3LhlAq4aGEVXBXUZQJMUOeUnyra15dkhccPpzi0+IAMeHkyAKewoGrhXfBVb8xiXBLu3isXo8ffyNhNrxYZMc795e0JL4APh9f4uZbzSIdYujkHm9WyYlfwULbWeUqZ2Boe92MoOVnD+CxoY3efnAmSYi3mok9q2RzOBvqzO8GCu4SSrDHhCUpBMXQfa7SgY5GcClJVPYMYQBE8H5w2kO1bADjunrmVsZuRGgN8hIGpZRx7BxYupSaQ5V7z/k6cfMmLpCxRDun7zI1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(71200400001)(6486002)(478600001)(83380400001)(53546011)(6506007)(26005)(6512007)(64756008)(6916009)(4326008)(66476007)(66446008)(122000001)(54906003)(66556008)(66946007)(76116006)(91956017)(186003)(38100700002)(2616005)(7416002)(38070700005)(316002)(8936002)(8676002)(33656002)(2906002)(41300700001)(86362001)(44832011)(5660300002)(36756003)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z/TgXRE115/jOWUq6od3tlctcfnLPVQphtWZTCEHkErJL1gZf4K/33gV0m?=
 =?iso-8859-1?Q?7ShtHpXYQOglujOLZ6g9btVk5eVxUoRYiikqvOGymwPz/fcCXcCRNzynJC?=
 =?iso-8859-1?Q?RrKgxjGIux5g0Fe7hAtg6CWzAZNB+GoETDxnotdDOW7kauczEo8S7gszt6?=
 =?iso-8859-1?Q?wxIK+C/67S0rJQG5iVH75UM+hafgVNtSwKt7Sh1izg39RHEr7jUubJrMCA?=
 =?iso-8859-1?Q?mXVZ7f15lqlG43q1gAFk063zQoC9r6gtGtBtzPy4P70UIdCX73T7DntQGa?=
 =?iso-8859-1?Q?vxli01FIknrKXw4C0R+wz/oWNuU/v6a9hkqvm4O+7vOQ5qKGjewYc2uEq4?=
 =?iso-8859-1?Q?VxcuR0iJaeR7TWTW5S21FJv2GTeJotikjG7C6J5S3KIEXWAdfaQcS+7eui?=
 =?iso-8859-1?Q?EAd6tYOztDcmYrRkHy0r8yQ/2EnTfn6QMHSQX83YepKeOFEmubXm1ikdiS?=
 =?iso-8859-1?Q?a0FbJCJpLDwcQBgqjNW2H5Wlcgtzg39ycXeyc4VVJOT9ZeNrr6qoGGbxIv?=
 =?iso-8859-1?Q?33ADt9YD8Pfb6bkekSbycvaGebUB0TFsl0yNb266glp5oL9qzUB13nKmYq?=
 =?iso-8859-1?Q?WXAMCvijwO8c4BzcDotBGADVk8fhEFmt5ZcwienWeJaKja8l9nVWKJGzOD?=
 =?iso-8859-1?Q?fmIzBcjfA7Vjn5kMgLvKsciwQZU4+Ff+vW5NzUGxtp8EGKQM0d57aq+ij6?=
 =?iso-8859-1?Q?GkFh9yM8xPqxuryZmTq1f0veqZ4M/tqJFy5l/aIHc+TyA95SzCttn1tOsZ?=
 =?iso-8859-1?Q?OYnMhg5jLa7TTfuoIGeu24G52Yg2Ey2cuB8/I/5zBwdxMiJY3ckXIh7Toc?=
 =?iso-8859-1?Q?XloKY6jEKGPJCFsno9uvT2xLzvNtHtWdNShUslbShbMYPfdwDoiOXdanxo?=
 =?iso-8859-1?Q?7Dj2l+K3aA5Zfh9MFDcNNRozf/bexFR596BJj/8jau8gQP1ul46iyQjvtB?=
 =?iso-8859-1?Q?JtbMgSXHc/mymXMNRK40+LtIzCxIH9KA4lpPHpYLufIbhD4yE13CW4wqV0?=
 =?iso-8859-1?Q?mrinaXwh7HkwpGCqdl+uQkuRQv+8kQxHB6N2B+gLg6hL2CcxCnbP6z/FaG?=
 =?iso-8859-1?Q?7aSayt1pGkPK3eno2qOak/br1fwfPl80JfxZ3rFk4+wnvLAL7VeHSxpPSp?=
 =?iso-8859-1?Q?aI4BIbrADapNTFuDP0gKvSbUhsE5c7wuAR7TlHGA7Zj3Aq2yM9twdfbAUP?=
 =?iso-8859-1?Q?tW1r0wOyKfVfK1DH/bsiooQYA+sgQxL4Ekin5igCL3LzkRXQilQRErHWek?=
 =?iso-8859-1?Q?rsVHQ7fFJOPBKlnsUWHmjmUPm5DOcnN+D6xUMC7Y8g98SpFdhocHOp/IVz?=
 =?iso-8859-1?Q?4hqsjtQj1EcGS94esM3ZMr+ekP89DIMrgC/w3mk5nUxROj8bZnvhe3cUWA?=
 =?iso-8859-1?Q?9bK3EdwRUMJEqoR1Qwn2YWLF3c7wuY6//oTckAN83c3dW8TGPMp6C9TWaG?=
 =?iso-8859-1?Q?Z1BMyq9tmF4FUgWCRoHjvj8AzUdAIGjo8mDWUnbzkkyGxqbaZpoxEYslKp?=
 =?iso-8859-1?Q?wRqDjKqgLgKCRl1Z0fwLaNMw+8iHLGFUxGX5foWTOPlBwW0agywJU+c8tg?=
 =?iso-8859-1?Q?Gm/Z2HUGFtHzHwdZTjb+c5WmXBPjMYD+bPLNKmMou6aoqw2yEQyGYHTSVu?=
 =?iso-8859-1?Q?haEccjrRfp9h0abDHxPBQpZEV28Wxwu0AXuypSMslUWB1QD6rw+t+Imw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C317AF2E7A034945AB11E32DFD73B019@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414a6cad-614b-4abe-cadf-08db914a3e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2023 22:13:46.4092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZCr87ANsQ4/OF6siA5Uc7J6B76HAXHEsHMjvoBQQMSi61MxWIDj312DW6hZ9rMZflQo5p6RvsII9wqBMPoVluJGEqLhKezMcaAoSTTzuT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9419
X-Proofpoint-GUID: LmCylw6htiMlz1-qCSoH2KksR4gkGx4L
X-Proofpoint-ORIG-GUID: LmCylw6htiMlz1-qCSoH2KksR4gkGx4L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


> On Jul 25, 2023, at 6:42 AM, Li Feng <fengli@smartx.com> wrote:
>=20
> Multile devices need this macro, move it to a common header.
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
> hw/block/vhost-user-blk.c   | 4 +---
> hw/virtio/vhost-user-gpio.c | 3 +--
> include/hw/virtio/vhost.h   | 2 ++
> 3 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index eecf3f7a81..3c69fa47d5 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -32,8 +32,6 @@
> #include "sysemu/sysemu.h"
> #include "sysemu/runstate.h"
>=20
> -#define REALIZE_CONNECTION_RETRIES 3
> -
> static const int user_feature_bits[] =3D {
>     VIRTIO_BLK_F_SIZE_MAX,
>     VIRTIO_BLK_F_SEG_MAX,
> @@ -482,7 +480,7 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
>     s->inflight =3D g_new0(struct vhost_inflight, 1);
>     s->vhost_vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
>=20
> -    retries =3D REALIZE_CONNECTION_RETRIES;
> +    retries =3D VU_REALIZE_CONN_RETRIES;
>     assert(!*errp);
>     do {
>         if (*errp) {
> diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
> index 3b013f2d0f..d9979aa5db 100644
> --- a/hw/virtio/vhost-user-gpio.c
> +++ b/hw/virtio/vhost-user-gpio.c
> @@ -15,7 +15,6 @@
> #include "standard-headers/linux/virtio_ids.h"
> #include "trace.h"
>=20
> -#define REALIZE_CONNECTION_RETRIES 3
> #define VHOST_NVQS 2
>=20
> /* Features required from VirtIO */
> @@ -359,7 +358,7 @@ static void vu_gpio_device_realize(DeviceState *dev, =
Error **errp)
>     qemu_chr_fe_set_handlers(&gpio->chardev, NULL, NULL, vu_gpio_event, N=
ULL,
>                              dev, NULL, true);
>=20
> -    retries =3D REALIZE_CONNECTION_RETRIES;
> +    retries =3D VU_REALIZE_CONN_RETRIES;
>     g_assert(!*errp);
>     do {
>         if (*errp) {
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 6a173cb9fa..ca3131b1af 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -8,6 +8,8 @@
> #define VHOST_F_DEVICE_IOTLB 63
> #define VHOST_USER_F_PROTOCOL_FEATURES 30
>=20
> +#define VU_REALIZE_CONN_RETRIES 3
> +
> /* Generic structures common for any vhost based device. */
>=20
> struct vhost_inflight {
> --=20
> 2.41.0
>=20


