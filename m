Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 235EB7B2A05
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 02:56:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm1n5-00023d-RM; Thu, 28 Sep 2023 20:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qm1n3-00023M-H3; Thu, 28 Sep 2023 20:55:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qm1n1-0001vV-D9; Thu, 28 Sep 2023 20:55:33 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38SCnhBg029270; Thu, 28 Sep 2023 17:55:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=+kDl38RogCnkZM2eHhsTZQsFzOGZh7Y7C5ddR7
 Q1ILo=; b=EtlgsOEmBI2NdniVZ2EgAvfGFSvnTbOFAgn9kerHLEuYWB5P6HXEO/
 WQHxhF8d2p0h3AaRBiYOAXmB6i+s0drFhF4F3srTeytYpCMy7/6pwUttQKejYNIg
 nbc7rgU2kdZ4Rw9Jk40+q3BsBNvOBTKBvAzkYYReSWwAAOgh+tYMNrRZW/MrdaEk
 EVX2EWPJML7QcJAYHPMqjhg+tXhT2N8nqnptweMdMNS/mP9SwSqac82H4yGFxZl+
 MGs0QXtxi9j2Rkbe7znqDtkyW2GCeT3X556jUT7ezWKk/FosoIbJlE5F/MirFg+V
 bV7Ybq6ziHcHoKTEKdEIdwJAygkd/rHw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3t9ux5k2ue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Sep 2023 17:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LF/DQMFMIfqHq5oD02Ye2FU6RvZbrr/cBtqShRUhXY8qks7p3rBKvjZaVjvkBKvhSO86YBUliQmaRi1CPetbu/QGLVbA6JNb4sqYICO128VW0AbUfsVduB8x+/q2R9ywaophNi9C6RjCQn8p3ypdTb/QPR/a4rM709giZAAmQ1NKvx0d/W5IWY3y7zgkKjzu545kFhqWxpYACbVfeXmxqHz7PqZoa2Fvy4FGUq5Uv58eDuYnBpI3xGr9E2G7SEhfpai44CcmZPmJwNjS81d/3u88bLJQQhYxlow76EPPShnzJqU0svlPzZfkEgD77BYPmog3jyMwA4u2ZCwqpLdh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kDl38RogCnkZM2eHhsTZQsFzOGZh7Y7C5ddR7Q1ILo=;
 b=nMQ9vUhg06jl7OXQ3/bpg86uW2Rn1hXZG/57k0Gw1KKDfzGpHNE38vlNSY4B7WCOa+QjwFdvlbFeQFWGsy5GuQYhhpD06vdoOuBqGyiULjZErezyXeWoLADiF/Kh9IXnt3r4j7ERUIwH9hFpTXME6IfuiJue85d5tS28I4EwjMGrV8n2bUpbDE8lMGaUGh2yrEgkvUKXmDrNr4vAejD9xscj6Lf6mLty1Cy5jCICcDpd99E9s1OxlpgbSl1dDD0DVunUGJZ+pGgmw4dEsNdp4r4Wja/lRFgKIPOou26qtFwtdEoHUzDXl5nliqVNdiV78rPVB94noyHUNxII0n47AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kDl38RogCnkZM2eHhsTZQsFzOGZh7Y7C5ddR7Q1ILo=;
 b=EtitRg1bVLIEAu4/rQ9OmwtR1EV2pt5+PC21DZlDliYz2okzO/giqsbTquFhzk6i2/6KmR98D+bRqHp61H6fdPMg7y/jHHXZjzwFsFTrWzxZyud2SOQqNxaiEyVJVlVMQA0dxsnM7F2glPQgJSKrnGCEORah9OsCJZVtEOcCVfc+PKwAVLtSrNGavk+2oqrzX5vL+I5g8Hbp5O6A5BKO92KJp2F/DbciVszVQvxvYD815vTblsZI6w5KwJE/6HaRLfbMtjIj4utlaG7VhOYV8KxD25vaWAFsNPPpKI0f8po+fA+XdVswf0vKEN7OIhnGyLKIVtx5u1BuMkSNG5EdUg==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO1PR02MB8348.namprd02.prod.outlook.com (2603:10b6:303:163::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 29 Sep
 2023 00:55:21 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d%7]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 00:55:21 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng
 <fam@euphon.net>, =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, "open list:Block layer core"
 <qemu-block@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 4/5] vhost-user-scsi: start vhost when guest kicks
Thread-Topic: [PATCH v6 4/5] vhost-user-scsi: start vhost when guest kicks
Thread-Index: AQHZ7UqSHKTbX+MQTUyGV0VyaKbkj7AxBKgA
Date: Fri, 29 Sep 2023 00:55:20 +0000
Message-ID: <7F20D9AB-E95B-4AA9-9B75-BC36F913B681@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230922114625.5786-1-fengli@smartx.com>
 <20230922114625.5786-5-fengli@smartx.com>
In-Reply-To: <20230922114625.5786-5-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO1PR02MB8348:EE_
x-ms-office365-filtering-correlation-id: 9cff95cf-83ec-4a85-5d71-08dbc086c1ab
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2mtKM+Hdb+IZFp5/C3cmZTg8Jo9q/F5VwTeaKM5OAQ9WhI7OZR77A3Pfk5E1QFg1fMM2qnyIdDnodIVAi6x9JC4MiGbFLxVibC7vW+MOiKSbc4QXrTbxaISEGRJZxGFnvRHb/EOloywmAZGJE+flJU6Sf8zSgpg0P7f9J5U1PhKkA1Dg4Vj0ZJIRBY7OJIWUPjzhPUcA578EYG6UpgiGDQB33HED2JMd87clnL/zCLfBlJPC7RsZm150879sIFhvMwoU4CfBeP62BEuHDZ0jRuQWn+0lrO6HUCOm3bWrcnvZwfUgajQ3OqIae5/zsBUbCfFsMKTUgFAVoxzo01d+9SXa1h9t2xuHALw9fM2WiICiEkkayTyqhaeL2T6cOxI+Q+o/Q0e05bYEHqLGbZMo9C1T1vrCqSyWG7W+pU73n0hrA8dy7DIaJMEHjDP74sS73AZeHhu+IsmfmMAxvrm3QiE4Sa/txtOfE/bLqfI5tWYfxXi9g/8p82lonFE1WJKI/Y86cp0ruMlV7WLft2TwPeZFShe/Fin63ls/DBCn1VkaYre2T0WiM9VKbm24C4ImnC+U8m9+It+FhQpZfh/GohX6BoDwg0lAtfVKoOV82R4kIfLLL5qcYAfsbxhxkAPbCFsJjzqJrAGsXYF57w3RQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(71200400001)(53546011)(6512007)(6506007)(6486002)(8676002)(86362001)(36756003)(2906002)(76116006)(38070700005)(64756008)(33656002)(38100700002)(4326008)(83380400001)(8936002)(478600001)(5660300002)(316002)(122000001)(66946007)(26005)(6916009)(91956017)(41300700001)(44832011)(2616005)(54906003)(66556008)(7416002)(66446008)(66476007)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6saIEPyjmjzd+9PMvH1/tFC9Wd4prycQxMYdf8sPYBnTC3dT54FuuFQLKQ?=
 =?iso-8859-1?Q?v4IXC9JUM/wHoRBqOzlMgTAW1mRcA/DpeTZ+MvUp1eeseWgc5cMwHaYOzA?=
 =?iso-8859-1?Q?CAqHDo63NnXDViMa2Wl78SyrebjE/7z7koACgPJY6jcLa3CAzxF3zqPrN9?=
 =?iso-8859-1?Q?ilPjHxjCrqh4znSW3FkvACkP9JlaZVHXmJ9U64e4Ee3q3kBCT4w7CY8T6I?=
 =?iso-8859-1?Q?DWOAX3SCp314h5xmdMSP3g0ZVMzFFRPvh5LtviVhPfqK9Mqd8oFC3GT3ZS?=
 =?iso-8859-1?Q?2rtfBCC/+ZFCY0HdFCgVIw0Gl0mXb5ZQ8s6jv8AdYrrmH0HjByAIyuZuGH?=
 =?iso-8859-1?Q?h0QJLGjOeMPENkg4PLE79sy7IxDVM/RVj5a779arLcJKpFImzMDhUZS9VF?=
 =?iso-8859-1?Q?AK2wsOhX5CQmbWsqdX1IYWFw6P5RHqELmaFkj+eEs7KcUZvYVib1bu8285?=
 =?iso-8859-1?Q?KN8yUpcxmPRvCm38KUg06FsaNiS6bdwOwA+SoRdFNHwsoWCoq1W+jftlUW?=
 =?iso-8859-1?Q?hIP4Aco5aBTy1zcLTcw3gJNaKKxQ4x2cmAkbVT12GTStSZ/1KeUQtEOZE8?=
 =?iso-8859-1?Q?QoYy5CweoJcGhLBdCJLBwQR15D+Mg38hX7TeQ2f81/dShgWPiIHw6/bvoL?=
 =?iso-8859-1?Q?CbnAUzj/ulnKqDdUhFnhTv75wQ6h3C4AeEkyNnjVDCvSxzNt4MFOoim5tl?=
 =?iso-8859-1?Q?lScXIM1/nc18gC7/OadTWBHiSJ3idWziKooeBg3T/FcufAX+tbftX/4Zwa?=
 =?iso-8859-1?Q?A4P7lBFj3/i+76eR9UudAM5Mo9akq3rBnENUcwdlfaAc4PJNz/MSNT5JKD?=
 =?iso-8859-1?Q?kGg3onoZCTwWBveN8YozRGQ5BC7m+Fr921UYM5xzjpIjIndBlwGoly5w1d?=
 =?iso-8859-1?Q?58+Tdwx4cg2CVs2rh9nuElPIeq3+SbhFwYp65CzxrjjnTw7WlZBVSNv7Kz?=
 =?iso-8859-1?Q?EazJRH10RaXIgZAEGa3feRD31/kado8RKakdjcWmz4fffmZSBMmagmO0QM?=
 =?iso-8859-1?Q?1nYRhPIIwXqkFAIvRy4kOb+iSvRhc9KNM+cxk/Ej/V5o6610SY6v9Px15U?=
 =?iso-8859-1?Q?7rmFu7NXJHxzR5chEz2uNi11oYJELZ4KgfJEbd4oMG5cLZxDuGqrVBK2la?=
 =?iso-8859-1?Q?MUE/wrjrUicMs9KTWlafj6BQbT+o3KfPDznqW7i9bEURo5WUCDypRtpVVR?=
 =?iso-8859-1?Q?v5actTyJ1cd5VTKm1jWR9hDSMapEA4UADtTHf/9gYMqizDYvUxjeXyW3a1?=
 =?iso-8859-1?Q?wrTa5tIx+cPO5R5beq0H36quEgDEInODnWxNel7fKunN6Fr9zSPsymDLkq?=
 =?iso-8859-1?Q?P/mUTYS5W1nQMD9yXg32KV0UrcOQ6ZacYhnKYzHYSmKQ+PxRfCFbJyzMW5?=
 =?iso-8859-1?Q?IPuGdKm7/RvWKGfrrU/W7hl3IFuCWpMPnacr6z3WPfuKiSmZQWtG3K/gmU?=
 =?iso-8859-1?Q?6g5P5GiwOlZ/F4Les0pDBW7NsQROW4X2VG+/7F2g9yQIxMgKX7lInqC9jq?=
 =?iso-8859-1?Q?zbjtEUCr/uYpUjCFtkR8276qj3YfWquB9wFZFcUvE9ytsrhue6HtiX+fkW?=
 =?iso-8859-1?Q?KdCXT6FT6H7/vSgzv3gqxOH7VWVZaJG05ae7v5XfD96TP+SzVFEFcwSvDb?=
 =?iso-8859-1?Q?AqKOGmLAa1Mldg4IvYiwsYEgQLF5fAVDIqDyyVtkOMLZSgHfHUQ9Adiw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <EB15C766DD8E1443AA9E381BDA576435@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cff95cf-83ec-4a85-5d71-08dbc086c1ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 00:55:20.9920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yHWId5E8NEAxdSTcJKWQQkAYMOhJWfJ2zCNugjE3pgeq9wlZvERzkUWQELrLYJIOVEBholEmEGF9X7B/35MN8dV+X5ZBhbZdlAAmKPZ6cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8348
X-Proofpoint-GUID: MniRK0XsjDFMESYJwWQdExm1Zyg3o_2E
X-Proofpoint-ORIG-GUID: MniRK0XsjDFMESYJwWQdExm1Zyg3o_2E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_24,2023-09-28_03,2023-05-22_02
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



> On Sep 22, 2023, at 7:46 AM, Li Feng <fengli@smartx.com> wrote:
>=20
> Let's keep the same behavior as vhost-user-blk.
>=20
> Some old guests kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK.
>=20

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
> hw/scsi/vhost-user-scsi.c | 48 +++++++++++++++++++++++++++++++++++----
> 1 file changed, 44 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index dc109154ad..53a62c3170 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -115,8 +115,48 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev=
)
>     }
> }
>=20
> -static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> +static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue =
*vq)
> {
> +    VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
> +    DeviceState *dev =3D &s->parent_obj.parent_obj.parent_obj.parent_obj=
;
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +
> +    Error *local_err =3D NULL;
> +    int i, ret;
> +
> +    if (!vdev->start_on_kick) {
> +        return;
> +    }
> +
> +    if (!s->connected) {
> +        return;
> +    }
> +
> +    if (vhost_dev_is_started(&vsc->dev)) {
> +        return;
> +    }
> +
> +    /*
> +     * Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so star=
t
> +     * vhost here instead of waiting for .set_status().
> +     */
> +    ret =3D vhost_user_scsi_start(s, &local_err);
> +    if (ret < 0) {
> +        error_reportf_err(local_err, "vhost-user-scsi: vhost start faile=
d: ");
> +        qemu_chr_fe_disconnect(&vs->conf.chardev);
> +        return;
> +    }
> +
> +    /* Kick right away to begin processing requests already in vring */
> +    for (i =3D 0; i < vsc->dev.nvqs; i++) {
> +        VirtQueue *kick_vq =3D virtio_get_queue(vdev, i);
> +
> +        if (!virtio_queue_get_desc_addr(vdev, i)) {
> +            continue;
> +        }
> +        event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
> +    }
> }
>=20
> static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
> @@ -246,9 +286,9 @@ static void vhost_user_scsi_realize(DeviceState *dev,=
 Error **errp)
>         return;
>     }
>=20
> -    virtio_scsi_common_realize(dev, vhost_dummy_handle_output,
> -                               vhost_dummy_handle_output,
> -                               vhost_dummy_handle_output, &err);
> +    virtio_scsi_common_realize(dev, vhost_user_scsi_handle_output,
> +                               vhost_user_scsi_handle_output,
> +                               vhost_user_scsi_handle_output, &err);
>     if (err !=3D NULL) {
>         error_propagate(errp, err);
>         return;
> --=20
> 2.41.0
>=20


