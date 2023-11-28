Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B817FB1B0
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 06:59:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7r6l-0006gy-Tk; Tue, 28 Nov 2023 00:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1r7r6j-0006gj-Ni; Tue, 28 Nov 2023 00:58:05 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1r7r6W-0008VH-Bj; Tue, 28 Nov 2023 00:58:05 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3ARFL7xU008544; Mon, 27 Nov 2023 21:57:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=MBFBoAwv5DFgBoYDO196nw/8Uu4uu9QfabK4ox
 eSjeY=; b=fomPsMy9QWFDom7tc79BTvVLdSkUkhaW2XYZmm0ERAhaXIJsML5x/n
 qFgnIcJZPlXERxbmf/bbM1K6on+1Dbl51MWrYq1g74PulO7TinDOUtLrhtq6wqu7
 Dpr+9qeRTNu1K4xGj0XlA/OuDoCstupP6x3GMV/Ffr7viinxICJ3b0rzu2zZVlC2
 ko3LboVo61RGJCrxvRFOI7y6Nf28GuzwAT/XcffKZWfc205LJ5OUqvt64HWY6r1f
 Blne5WBIkI/aSL11dkjnNBuhtOOT9U/6SzcEdrZFuLjuluDMRbjA2KZrrjZo+/yp
 6KeAN6VBFmuBL45poI4Tb9XkEoPcowyw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3uke4vcj14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 21:57:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBH4fDb9R4wjN/LifSp3modrn4DtGa0e+EcSW0l+ay+nhg7fHTOq72q4iOa6iOzDXDr78vWbVpXFHeXRjh1II8wKNo400YGbdDjPhv4XzUBhnfwiCNUkwc3xBrPiXbcJ6HplDo0nqiReOPzwwtONoaQGch7nzsIEgbrMWgntyOnf0wXrrIzEwXJIxqrc3bIIldapJxAxH9hag8ffwRNoaWS8Jup6yxkyf2kc3S9UrN3v4btBS0YGOji50xayADHtt7P3T33+Wh+oxoqKbT63Vpf3OOSc61EdrOoJYkhCIKKeijqxHYP+ZhIBQ/GbgvLeJb/AlgiwSLVQQHOa9Tgn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBFBoAwv5DFgBoYDO196nw/8Uu4uu9QfabK4oxeSjeY=;
 b=RQQhvlaFExYwU4nhqvW0vJb7GZaUVZX8fvpvnnKhas+da+y4OjYhJh/VOSX/TNRzy/Nj0Z8o66fYaqlRXMuFY9FIkX5z35kcYpTTPwJPH5mRCumHIDiVSPMOpeqvW7ymNqY+c/ihVM2YaAJeeIY2kVVp8axRND+FcbnwwFqaXEr+5WdLFaGTQVDrp/VbHAE2FcXNqny9tabZ+SqYgpKE0tPvxfv5/mM4IKsN6S4nezHmcq/MHR5J1RoX6zg0tGxEVJwKHoV4sNLe5+QIzYzb2fbnhTfzBFx7bJFw4OR7U88rHbvy9iP+ThySNoGVO7RMqb7KJZ+MQtIwmB6laLJZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBFBoAwv5DFgBoYDO196nw/8Uu4uu9QfabK4oxeSjeY=;
 b=qSvG8RBg33esLoeJL50Zfdnikz7D+f/SQ8YrGWl+5yzFq3j3cMvPvvkHdpT0N2keTF2QqW21b870PLtsmSib4MqEMpqv8j1z3/FwhTPBQZ0Yl8/Qd98n+J8I6kRr3tUz7NCTffPoZuBmo7OazL46jFIdrC/xzzwBf//QWEpjxi5NdW/Tk/8TYLqAjOxSIzH2/Q3vXlUwbHJA/sMrnLbaAwvR3lsYJGfaGmselL0l3zdJ+oVwLYBKgjc1MTsC2kBWQ+OypAex7pJ78oFe9BzIEwLdkZ9pb3y27PGzFi+vuBexMVdqG8FA8S8fU3VtU3ARZwJk+YCBUWBC7pm+Wf/9Aw==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by LV8PR02MB10069.namprd02.prod.outlook.com (2603:10b6:408:190::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 05:57:34 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::150e:cf33:5d45:9a57]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::150e:cf33:5d45:9a57%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 05:57:34 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] vhost-user: fix the reconnect error
Thread-Topic: [PATCH 1/2] vhost-user: fix the reconnect error
Thread-Index: AQHaHdGmxJiMkSYTyUOhR9QnMBARx7CPQ+oA
Date: Tue, 28 Nov 2023 05:57:34 +0000
Message-ID: <DEC3653B-7239-4542-A1C8-407C97922061@nutanix.com>
References: <20231123055431.217792-1-fengli@smartx.com>
 <20231123055431.217792-2-fengli@smartx.com>
In-Reply-To: <20231123055431.217792-2-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|LV8PR02MB10069:EE_
x-ms-office365-filtering-correlation-id: f5bb7820-b2a6-4fa0-90b7-08dbefd6eacc
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C/hCf/WzhjljVLRCtPF4n+xALjfrqtz/lFTSRzgcitrblvV/4SGiC7dk00PB4bkAzlCxqETu+VB9qw3yS1hQkWFRVrFj8maarhQzHrPEoE+Dq9iZT00zir2n2UiO15x8/tYfXnMXlBAHZ+ADMRSFpYAQ0k0GOqnyTSby9ZKgz3BfoSMd+OiqFMT1RicSQjQZXjmHwyFK6rRYz4LSl2i0X4f+Fc6llksfCXrjK3Yfg3UVE+PabO8BQGRDZNEePxUyYD4QTaCOzACc8tCUTGCF57x/wkCk7boAyvoIYeP+skTgYeRRQ+sDzGfVP4SKfYgJNb4jMu5GYvCUPDGz4SLOhvjpqvmuaajjGCWfe8YOpwPhm7vVOYepjADV81UEOWexMF1xsB3abq60plEbInerBCn/kCKzt/5C59QDHT6JWLvt/e7k9B7VQj2642dJQ4DEbPe8E9I3lSEXrw+hLEL/4k29Sy21XAI4Uj3dTs1gacjFyCzaElzyzjjcHD2PUOPAdiNNycZwGBE3jUYSH0VO0hsGkWg00LqxewPWkJU5+wIy7xwbVO4+Qgkxh8m9EtZ4hc4UUrWEchkMzK6fpqJnb05YVBCrsfip0dWDU/KRHuS8jUYk1KSyu7PnJJZ/scoYFLkTusO8hlqgc4rH6rr1ng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7416002)(2906002)(44832011)(5660300002)(4326008)(8676002)(8936002)(41300700001)(66946007)(91956017)(6916009)(316002)(66476007)(66556008)(76116006)(64756008)(54906003)(66446008)(6512007)(86362001)(36756003)(2616005)(6486002)(478600001)(6506007)(53546011)(26005)(71200400001)(122000001)(83380400001)(33656002)(38070700009)(38100700002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ojlcSapxacvcqKLbsJjOaLSgQtckpGArk0xhN74hLTbQAM+cGwtrIR2z+G?=
 =?iso-8859-1?Q?xeIGY3Ise1+3Cbx/+A4UIPtzibv6Iyl85KTxe/yHO2DG8HPYQTYX8Hrh2c?=
 =?iso-8859-1?Q?j9aQGYsHzTOuTBR+4cu7HAH8diRx3Ukf9GIbicqCdejP7y75evxbvvzlaF?=
 =?iso-8859-1?Q?DaLo24c9PMVD2bgkDm7Yiz6iCjDb4EPXoPAdXPE+qQWNvlawnCZXJGrtzC?=
 =?iso-8859-1?Q?ZHdt95ZEzpHCnpVAlLosretQYUEMDd4OC1zSgR9s1Z4o6BkYuvLvyprUx0?=
 =?iso-8859-1?Q?Ah1z+tjmpLw8wx2ZoK28SPzVeK6ksqp0DOKdAvh2cTCi081XY8B4wg1Y5J?=
 =?iso-8859-1?Q?Br7mdGztmnvVy+A6SIWbo0d8fQr8sFyyEuvIivXCRyX8qM8UUhIvHspHMX?=
 =?iso-8859-1?Q?cZi5d7EHLftf8LD6OXnLvjhJN6HA42UGv7Psaj304JytMloK9LCM23h9M4?=
 =?iso-8859-1?Q?TZ6EDlZEcuwvVTiF89FNbifsOlnSQZOYNwR7vHO/nEQqKZ4Mribk01jqim?=
 =?iso-8859-1?Q?FWRsr65QDJPLThfF51awTzprgauAwN3o3l9fhta8UTPvIjErZil4pExcnK?=
 =?iso-8859-1?Q?MDLD09ZADFRUx8/CVx/Y3zneSOeE3ySC3svQe7Fnn4rhbB9C04RHj2yx3z?=
 =?iso-8859-1?Q?gS3s39SfjQbtoTrJEv+Vpn5jGKLPB4kIKygJ/LXz1l2y3GZkZ82sWR1lVj?=
 =?iso-8859-1?Q?MlUfIo6va6qNZjRpKrmfNFWbzi9ez9tVXYyfUHn0++M9l3Xu+hG0TQGb4f?=
 =?iso-8859-1?Q?paOiy5utcZll+tjnubE3K5RDd4vaoISgUfI256f/BHWUNuX8XucEywuL7w?=
 =?iso-8859-1?Q?1SfSYb0IpE6ob/04ZAPpw6oqqVSZtfkNEw9spJ9bz6lxyugeAk1zhhLFzv?=
 =?iso-8859-1?Q?1HjVdbV7wr56ILokouP7HJGq9MgTLYJ4WW06smgjbW4KVBGM6pl60Ql7Og?=
 =?iso-8859-1?Q?nXv1GWxQd8sbGuJYOxPGjJIsmy7VUgyr+t23Qm4JeKdjJ0W2cA5SpnQDy6?=
 =?iso-8859-1?Q?uY+KhRCKX2LyVLuwwGjmvQ/6OkXBSBLmFFg1Lo+Oja6pUqyKZMHkGFyU0H?=
 =?iso-8859-1?Q?BSGc1yJUva0R4Ydb73dRdWN+xlOEzAoAO0/wBM7FaMKOrDpRycaG0+f5Ly?=
 =?iso-8859-1?Q?1fSsKSRUr2uvYvvpXw0zYZ+dHUk0RVyraQ2YFrqAR9xR1PsEbqEPch6WJ7?=
 =?iso-8859-1?Q?wLow4g25rTUXmDHLClBKWq3Fuxqrw9Q7crX/tnss5NwcnuTjqet1azASoO?=
 =?iso-8859-1?Q?N+QvwpaGx9EmQ7SjJRfA8Ci1oZF90qmHPbsU4csLZrP/RFezNE1mF4NHV/?=
 =?iso-8859-1?Q?5vUX1Ov8UATfSSLP/EZxp5fCsujXeFGPn7/1GiPE0LxyGwmMnVBf3wI8di?=
 =?iso-8859-1?Q?RPU8Y91soa1RvJvgS4EpOwNIqeWPD1RUcw66u68wvSq1fv20KOSgtycEYB?=
 =?iso-8859-1?Q?+RPQAEAO7HLcBS4GNr7uUPEbiHDbkjZBaTpbGhLD3gnHkzZ06pMhaFtup5?=
 =?iso-8859-1?Q?ahcq6aEfKzw+SpXIYMqpYUOEBq75UThDXNB4wrpHpqbEXe2ojrvTfvIKCB?=
 =?iso-8859-1?Q?OyCggPPtAOFmDriO6+QvTCYbZYgm9Bo2NYVRZtD94gpj/Y/6+y37tCx7/1?=
 =?iso-8859-1?Q?h6LSGPHidrAb+GoPUwsU8feQAwhsUlJyZPfxQXtqtCx/qNpxueqNPwWvVl?=
 =?iso-8859-1?Q?KNXSGFR8Fv1XaCoFEDw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5D045A2DE7FF7446A1390F72169B021F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bb7820-b2a6-4fa0-90b7-08dbefd6eacc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 05:57:34.4227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiijz9ysVXO39T1KnhIaxC+5E/iAMJ0BPOxG61M9Z1brGYRKumrrsRw/ZAa6g3y8rOmF5hR7MH/RzGNlgT5ijCKALnYaDEnX/BbCSoqhkPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10069
X-Proofpoint-GUID: O7BOUQTUNWgzsWCcAFR3AqdXlWbpk0Ez
X-Proofpoint-ORIG-GUID: O7BOUQTUNWgzsWCcAFR3AqdXlWbpk0Ez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_04,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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


> On Nov 23, 2023, at 12:54 AM, Li Feng <fengli@smartx.com> wrote:
>=20
> If the error occurs in vhost_dev_init, the value of s->connected is set t=
o true
> in advance, and there is no chance to enter this function execution again
> in the future.
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
> hw/block/vhost-user-blk.c   | 8 +++-----
> hw/scsi/vhost-user-scsi.c   | 3 ++-
> hw/virtio/vhost-user-gpio.c | 3 ++-
> 3 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 818b833108..2863d80d15 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -326,7 +326,6 @@ static int vhost_user_blk_connect(DeviceState *dev, E=
rror **errp)
>     if (s->connected) {
>         return 0;
>     }
> -    s->connected =3D true;
>=20
>     s->dev.num_queues =3D s->num_queues;
>     s->dev.nvqs =3D s->num_queues;
> @@ -343,15 +342,14 @@ static int vhost_user_blk_connect(DeviceState *dev,=
 Error **errp)
>         return ret;
>     }
>=20
> +    s->connected =3D true;
> +
>     /* restore vhost state */
>     if (virtio_device_started(vdev, vdev->status)) {
>         ret =3D vhost_user_blk_start(vdev, errp);
> -        if (ret < 0) {
> -            return ret;
> -        }
>     }
>=20
> -    return 0;
> +    return ret;
> }
>=20
> static void vhost_user_blk_disconnect(DeviceState *dev)
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 4486500cac..2060f9f94b 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -147,7 +147,6 @@ static int vhost_user_scsi_connect(DeviceState *dev, =
Error **errp)
>     if (s->connected) {
>         return 0;
>     }
> -    s->connected =3D true;
>=20
>     vsc->dev.num_queues =3D vs->conf.num_queues;
>     vsc->dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
> @@ -161,6 +160,8 @@ static int vhost_user_scsi_connect(DeviceState *dev, =
Error **errp)
>         return ret;
>     }
>=20
> +    s->connected =3D true;
> +
>     /* restore vhost state */
>     if (virtio_device_started(vdev, vdev->status)) {
>         ret =3D vhost_user_scsi_start(s, errp);
> diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
> index aff2d7eff6..a83437a5da 100644
> --- a/hw/virtio/vhost-user-gpio.c
> +++ b/hw/virtio/vhost-user-gpio.c
> @@ -229,7 +229,6 @@ static int vu_gpio_connect(DeviceState *dev, Error **=
errp)
>     if (gpio->connected) {
>         return 0;
>     }
> -    gpio->connected =3D true;
>=20
>     vhost_dev_set_config_notifier(vhost_dev, &gpio_ops);
>     gpio->vhost_user.supports_config =3D true;
> @@ -243,6 +242,8 @@ static int vu_gpio_connect(DeviceState *dev, Error **=
errp)
>         return ret;
>     }
>=20
> +    gpio->connected =3D true;
> +
>     /* restore vhost state */
>     if (virtio_device_started(vdev, vdev->status)) {
>         vu_gpio_start(vdev);
> --=20
> 2.42.0
>=20


