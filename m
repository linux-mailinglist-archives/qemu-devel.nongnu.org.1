Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1101776A4E9
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 01:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQcQ2-00004y-Rw; Mon, 31 Jul 2023 19:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQcQ0-0008WA-IK; Mon, 31 Jul 2023 19:35:16 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQcPy-0008Dz-3r; Mon, 31 Jul 2023 19:35:16 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36VKj1qQ000575; Mon, 31 Jul 2023 16:35:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=DQZl4wXBhHhW9JlHOi47OdeLZxENHw/LJljrkr
 cuCQk=; b=2IllN7FN+RfH+SptNhmdNwBIyKhLFoKaN2sR8cqzIrL8YlNJB8SaN1
 mCCdptJlTr2Cle6C9eCkcYieHJicp51V9+sIMs6VBaSYbP8yHZIPwMz5E4x+1oYv
 n1lKvelBuU44aByuRbQ7Qkl3fwCGmUVb5dYc6igvTgj1WBoY+L+DlBPWHj8FXkWL
 8ykLhjld3NW52XmmzNWqHoRsLF+amSkCYcv8D6duv3zdNrpl2oiNuzmtKFcu4M2W
 PI+8/NemXmHwiskTDzZGaG/aoHIdibadRHWUsg1cM088bRjdXkpsHIC6lAJzhqpA
 7M9hUpErW1qCywAkny4KN/1tFfgP0Cjw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s4y3rch1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 16:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRin7FrJOAwkXV8mutRACxn2NzL4RG7FadMCwlJQ6O9K6OIMGP5riW+Y0SC4jpFAPAExlRuAjrxmKuXHu7mT09+pEgOieEWzVWhED+6c9E6Xn+eiMBMsUZHUVULZs0epn1MyXnItYs9iX+PZlyu+bQdvpvt358yTCBL0GiwC0jp1u9nO2pZQNSqUjgCPAGHF3TU41ArmkVOwq8zndy8OesyVJCHoeEbeDoFkq2Ic/EahGj9bocZPuhUY722vmXeul801JI9xlMdo7yfnIIAHhWCJDcxeggviUQ35g9OBv+B5MGkfLeM3vwi5aiM80X+hsNchKerDKiD1YAU+8EDGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQZl4wXBhHhW9JlHOi47OdeLZxENHw/LJljrkrcuCQk=;
 b=lPcIDBCwF9EMQexvivwvT64v/VtqnF7i5FfnOVe5/SU+/ktqvMiIZ6w0io842li+aKOaGOxwx3Xun+Fl5RdleHQR3yKoT6crxwI9DJY0bY4tWxno6/kV8+gyodU1/wvjARXe7RxsH3s7bmwOOymQsWTAdMjYoCNZZf5hH2UJDBjVsVx4MqhBFQRK6Xbxpv4SzmoHTjfv8TdRG3NQJvGkb07MbX4ZTBdYNka+sWPBOOiJe09TacwrRLzVOMQ0e9vDdTAsIG2q5LZK+aumxDCOk7SRzTxRsnOTKZlufYnSIKLTEpFL8JKN0O4JsfGkic6KVXgDOyA4x9tPMZdpyeQu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQZl4wXBhHhW9JlHOi47OdeLZxENHw/LJljrkrcuCQk=;
 b=dlM6lXnYx65AYru9U7cCJvNA2LthPe4ln2iTan2jjolOXO5E0guW2vG6rpZdHFCkZHBrAZlarVevY1bki++fEPmb88B8tD7JdKjuiVjfxfmLa1BjshIlJnOxelmLjNUsqz5Ui84kKwTIkDCYIox+ogclg8HVK0K1Q4abz/9B//B18lkQfCebE2RUunyr4fQInY53cQ85H3Rfmg7q5tUQOjf9kDdhrErKaiaqGYZ5urWYYuMf/hj8D7bVjmWzH1X96mIssW0TAsWsZ8toDy391wf3XvU3FkofucqW5Sfs5rwM9tiHMqQf8UZPwVrEWt6U0cEiQCCREr2o5/9pIk9uDQ==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO6PR02MB8819.namprd02.prod.outlook.com (2603:10b6:303:143::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Mon, 31 Jul
 2023 23:35:03 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239%3]) with mapi id 15.20.6652.004; Mon, 31 Jul 2023
 23:35:02 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 4/5] vhost-user-scsi: support reconnect to backend
Thread-Topic: [PATCH v3 4/5] vhost-user-scsi: support reconnect to backend
Thread-Index: AQHZw6gcnY28hTTLc0Gmqx+LOs320a/Uh/AA
Date: Mon, 31 Jul 2023 23:35:02 +0000
Message-ID: <8C15909F-9F22-4C29-97DA-093474B5737D@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230731121018.2856310-1-fengli@smartx.com>
 <20230731121018.2856310-5-fengli@smartx.com>
In-Reply-To: <20230731121018.2856310-5-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO6PR02MB8819:EE_
x-ms-office365-filtering-correlation-id: 66e9a8e5-35aa-4f3d-e20b-08db921ec37b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3R1X1x8yinB8a5f2hon8zh84dSWCRPvD9OYyFWiB6ZLSR7Vu6zzGiyJXFiwpV2VAAd1xlT/OGeWw0mm6XGv2ArFz8Ba0paqTnoH5NEYe+Y0fp53sO47xSUydXKTrU5SSRhqf+X9i1wa9bIBptWP59fPGXVp5AKt1BZSDRynOcOxmTJwTsIQUbYwpU+SYY93cFXCRx64iL+tU0vvMpSYOnL1JCcnW9aA6b1TDuFy0YwYeDQWAGsokE5z8j6RGxnNiMQrOvO1ZtJmeJGPsVen+AHjp6BoloOJwAkjjrrxw6ayT8r0whEh+pOM1FiqEz1IQDyYsg5ICZn27ttsj09REUbhOBVBNX9lAK07WTZmlvLilRLlNtPdFQb7BBmZyHa99H8ur4m/tsvkdE2lQdsf7wexr1Alb2nxV+Kv+ZMBJw/v5UBlcYqmsRUGw+6amXaxSDOQbEHjHbPsAeJPeIgajFGd/bFyWXqPhnbpGPDqki4vf3XUzKuTElin3tNTTlpOYSQjf1ybfGskHycnsRduaUx+tnDmqqTpPyVU27wkiafkWmYYath3ePw6GJW5lEx5WXZdyvTYtu43+YrXOrA0pN8aGCi8j05FAI5CHu+Ibi3XBckVhSSXPcuCOSQL2+Ts6pcW+niCnivEDUteOrmztQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(71200400001)(26005)(186003)(2616005)(41300700001)(6506007)(76116006)(4326008)(66556008)(53546011)(6916009)(66446008)(64756008)(91956017)(66476007)(8936002)(83380400001)(5660300002)(7416002)(66946007)(44832011)(6486002)(6512007)(316002)(8676002)(478600001)(54906003)(2906002)(38100700002)(33656002)(36756003)(38070700005)(86362001)(122000001)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IQD+P4S1X7e1dDOso42ThKLrGQ+3SPYXQc3FIyj4osT+e9L/5IyC4NhKzt?=
 =?iso-8859-1?Q?ZAjhxVVvQ57bu13Jreg95ybTWTsb1cR+d1aKsvzpi9s648Q+pfkN4teiqs?=
 =?iso-8859-1?Q?OOPZacjR11WGxn+vT5z9jiF4q9rZXHQSihJZVZ9j0mWtjxkqU9FwLHjWrg?=
 =?iso-8859-1?Q?kp7YHQrlu+FfHb5ouFNS97xPqrLVqPm7FuiMdEhafX+WtuukBP+iKttgUB?=
 =?iso-8859-1?Q?yLP0uoz8DiCMD2SEgxozrugO5dWkldxax7tT/ofWQnx3owKGANmF7vpIG1?=
 =?iso-8859-1?Q?CI+MltyFklX1wLeSBouoIgswcDm8a6wFkNxPmVcgX7I6IJF8ATLSA5Zj8H?=
 =?iso-8859-1?Q?NqQYrDF2O7Z8N77tR4RUo+4hHNDH4e9zh4XWf8OlTgLfRrI1W+e1ohvO8g?=
 =?iso-8859-1?Q?r06fuUt57/OTA4lCdj7vjctlPsCw6Br1XwF7f6ejChcmYSzTpbt/bgs+xQ?=
 =?iso-8859-1?Q?yCzqLKzNPfhC14u/+MnqNeHjLRyxnHzpYEGYchXomjlMwgusn78cYjLLdM?=
 =?iso-8859-1?Q?f7WZzhYg/UEbFSyE+zWI19+7puQDjzFZyq+2jup2i9i+tF9RolZKwY0Loj?=
 =?iso-8859-1?Q?gQHxIBWYfCIHsljZwg2iW0Cx2Tp3l8FVTnSYCffjBAgYchDa7Bj1gnIZ4O?=
 =?iso-8859-1?Q?7ShgP7h8XbyBdn88j1uFm+yXOYRuuPvGeHE5A8WsTtJf8CXVkF7MandWto?=
 =?iso-8859-1?Q?Yi44nVngdb+ZaUbgtuUYxnv9n9LQ/OQx5LdswqhDS0rtsdoDZyytvWss0l?=
 =?iso-8859-1?Q?9dCg8pXpumTs7bRNnUvckHS2e8v+JpCV9Y6nMZSN4KMoAc//ny09M6gwp6?=
 =?iso-8859-1?Q?9KG7sCvGtKLGU0ES90Ylq+xZr90ekE2L3QJQ3vh9s7B3NWrLCsWF9/TYOj?=
 =?iso-8859-1?Q?11j/ILleSy+L7TN2nijTGvGzcHVvhou58j4Rlrpp4p66gjiSPIolj7XaZJ?=
 =?iso-8859-1?Q?0cTbxdhN+hsfzgvogFz6NnBmgIiEWdvkmryp6WpOBGWSqeM7P6UtL3twQY?=
 =?iso-8859-1?Q?sO0IrNJJjmq9uuZdsCKvlcR1/eRLCrkQsi9w+akHtjL4bTKWJuSynYyxsa?=
 =?iso-8859-1?Q?xNqGF5+FBWT/tJNvZRI6wxsnVi5d5ZgTmKjqxxYy+F/Kr6rIZeLtb6AE4l?=
 =?iso-8859-1?Q?1xly4UDQM+2sjMERB3i/evzcHhL84A8iNaVOvANe3Rk1XAosbgWdqXGsFL?=
 =?iso-8859-1?Q?rvzdOpiiHltDyxDlf6E3lk5VbOv0ll7a/bRWPJSP11fdWKnbTQuKE63JVY?=
 =?iso-8859-1?Q?EtphDY3JBwW8u7jS1hzLo/w1vbUbMYwVOWuwBG3i8Ceg16YeQXd94hZ+qi?=
 =?iso-8859-1?Q?QpfPt4ZjzmepU48uRlkCfouBmqzJ+84TUAU1kxhHMq8PyWH2cK1TOhXHO/?=
 =?iso-8859-1?Q?H34aPL0wkmeud0Q3WtXW6r65eWDvZraTh9wTdjRz+9fpKYPFwBHL8M6hi9?=
 =?iso-8859-1?Q?Xve1EPunZ1xHk2MkgUHNlP5qDpBW9tYxoGQDoZfdIJ4KUYpnJCqWsQiaKi?=
 =?iso-8859-1?Q?rhJODGx9m+MOnBIrEHBFNwmaaOX3boknHb6xy4zurBTwqMEDQoqNu4f4JP?=
 =?iso-8859-1?Q?pHuLWtjqRYpY/y9SwZjY+qrGKBaOCJVhSG7zUTj/vZ7F2twP1V4F/N/786?=
 =?iso-8859-1?Q?JSjXwygcEbcxZEFW0w9z8zQ/xXRGfZtp8nSLzk0/nJxiIm+prKeVKdZQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <FB54EA9397E1044AAEE2B76BB3253A71@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e9a8e5-35aa-4f3d-e20b-08db921ec37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 23:35:02.9238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FN22EXLx+sAcsdQt8ALzR2G8nSSZhsphIB1gaA59NADZsulEdZDsiN6ykGMy5AxU0SYDqjg3sRgmeBxrTFIJvLRMOGzdyhCoAq0cBRAn/KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8819
X-Proofpoint-ORIG-GUID: B95BnKWysOD6n2zGcIIPi8V3l8EGCKZB
X-Proofpoint-GUID: B95BnKWysOD6n2zGcIIPi8V3l8EGCKZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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



> On Jul 31, 2023, at 8:10 AM, Li Feng <fengli@smartx.com> wrote:
>=20
> If the backend crashes and restarts, the device is broken.
> This patch adds reconnect for vhost-user-scsi.
>=20
> Tested with spdk backend.
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
> hw/scsi/vhost-user-scsi.c           | 199 +++++++++++++++++++++++++---
> include/hw/virtio/vhost-user-scsi.h |   4 +
> 2 files changed, 184 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index ee99b19e7a..5bf012461b 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -43,26 +43,54 @@ enum VhostUserProtocolFeature {
>     VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
> };
>=20
> +static int vhost_user_scsi_start(VHostUserSCSI *s)
> +{
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +    int ret;
> +
> +    ret =3D vhost_scsi_common_start(vsc);
> +    s->started_vu =3D (ret < 0 ? false : true);
> +
> +    return ret;
> +}
> +
> +static void vhost_user_scsi_stop(VHostUserSCSI *s)
> +{
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +
> +    if (!s->started_vu) {
> +        return;
> +    }
> +    s->started_vu =3D false;
> +
> +    vhost_scsi_common_stop(vsc);
> +}
> +
> static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status=
)
> {
>     VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
> +    DeviceState *dev =3D &s->parent_obj.parent_obj.parent_obj.parent_obj=
;
>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> -    bool start =3D (status & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->vm_runn=
ing;
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +    bool should_start =3D virtio_device_should_start(vdev, status);
> +    int ret;
>=20
> -    if (vhost_dev_is_started(&vsc->dev) =3D=3D start) {
> +    if (!s->connected) {
>         return;
>     }
>=20
> -    if (start) {
> -        int ret;
> +    if (vhost_dev_is_started(&vsc->dev) =3D=3D should_start) {
> +        return;
> +    }
>=20
> -        ret =3D vhost_scsi_common_start(vsc);
> +    if (should_start) {
> +        ret =3D vhost_user_scsi_start(s);
>         if (ret < 0) {
>             error_report("unable to start vhost-user-scsi: %s", strerror(=
-ret));
> -            exit(1);
> +            qemu_chr_fe_disconnect(&vs->conf.chardev);
>         }
>     } else {
> -        vhost_scsi_common_stop(vsc);
> +        vhost_user_scsi_stop(s);
>     }
> }
>=20
> @@ -89,14 +117,126 @@ static void vhost_dummy_handle_output(VirtIODevice =
*vdev, VirtQueue *vq)
> {
> }
>=20
> +static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +    int ret =3D 0;
> +
> +    if (s->connected) {
> +        return 0;
> +    }
> +    s->connected =3D true;
> +
> +    vsc->dev.num_queues =3D vs->conf.num_queues;
> +    vsc->dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
> +    vsc->dev.vqs =3D s->vhost_vqs;
> +    vsc->dev.vq_index =3D 0;
> +    vsc->dev.backend_features =3D 0;
> +
> +    ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user, VHOST_BACKEND_TYPE=
_USER, 0,
> +                         errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /* restore vhost state */
> +    if (virtio_device_started(vdev, vdev->status)) {
> +        ret =3D vhost_user_scsi_start(s);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event);
> +
> +static void vhost_user_scsi_disconnect(DeviceState *dev)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +
> +    if (!s->connected) {
> +        return;
> +    }
> +    s->connected =3D false;
> +
> +    vhost_user_scsi_stop(s);
> +
> +    vhost_dev_cleanup(&vsc->dev);
> +
> +    /* Re-instate the event handler for new connections */
> +    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL,
> +                             vhost_user_scsi_event, NULL, dev, NULL, tru=
e);
> +}
> +
> +static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
> +{
> +    DeviceState *dev =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +    Error *local_err =3D NULL;
> +
> +    switch (event) {
> +    case CHR_EVENT_OPENED:
> +        if (vhost_user_scsi_connect(dev, &local_err) < 0) {
> +            error_report_err(local_err);
> +            qemu_chr_fe_disconnect(&vs->conf.chardev);
> +            return;
> +        }
> +        break;
> +    case CHR_EVENT_CLOSED:
> +        /* defer close until later to avoid circular close */
> +        vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
> +                               vhost_user_scsi_disconnect);
> +        break;
> +    case CHR_EVENT_BREAK:
> +    case CHR_EVENT_MUX_IN:
> +    case CHR_EVENT_MUX_OUT:
> +        /* Ignore */
> +        break;
> +    }
> +}
> +
> +static int vhost_user_scsi_realize_connect(VHostUserSCSI *s, Error **err=
p)
> +{
> +    DeviceState *dev =3D &s->parent_obj.parent_obj.parent_obj.parent_obj=
;
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +    int ret;
> +
> +    s->connected =3D false;
> +
> +    ret =3D qemu_chr_fe_wait_connected(&vs->conf.chardev, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret =3D vhost_user_scsi_connect(dev, errp);
> +    if (ret < 0) {
> +        qemu_chr_fe_disconnect(&vs->conf.chardev);
> +        return ret;
> +    }
> +    assert(s->connected);
> +
> +    return 0;
> +}
> +
> static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
> {
>     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>     VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> -    struct vhost_virtqueue *vqs =3D NULL;
>     Error *err =3D NULL;
>     int ret;
> +    int retries =3D VU_REALIZE_CONN_RETRIES;
>=20
>     if (!vs->conf.chardev.chr) {
>         error_setg(errp, "vhost-user-scsi: missing chardev");
> @@ -115,18 +255,28 @@ static void vhost_user_scsi_realize(DeviceState *de=
v, Error **errp)
>         goto free_virtio;
>     }
>=20
> -    vsc->dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
> -    vsc->dev.vqs =3D g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
> -    vsc->dev.vq_index =3D 0;
> -    vsc->dev.backend_features =3D 0;
> -    vqs =3D vsc->dev.vqs;
> +    vsc->inflight =3D g_new0(struct vhost_inflight, 1);
> +    s->vhost_vqs =3D g_new0(struct vhost_virtqueue,
> +                          VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues=
);
> +
> +    assert(!*errp);
> +    do {
> +        if (*errp) {
> +            error_prepend(errp, "Reconnecting after error: ");
> +            error_report_err(*errp);
> +            *errp =3D NULL;
> +        }
> +        ret =3D vhost_user_scsi_realize_connect(s, errp);
> +    } while (ret < 0 && retries--);
>=20
> -    ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user,
> -                         VHOST_BACKEND_TYPE_USER, 0, errp);
>     if (ret < 0) {
>         goto free_vhost;
>     }
>=20
> +    /* we're fully initialized, now we can operate, so add the handler *=
/
> +    qemu_chr_fe_set_handlers(&vs->conf.chardev,  NULL, NULL,
> +                             vhost_user_scsi_event, NULL, (void *)dev,
> +                             NULL, true);
>     /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
>     vsc->channel =3D 0;
>     vsc->lun =3D 0;
> @@ -135,8 +285,12 @@ static void vhost_user_scsi_realize(DeviceState *dev=
, Error **errp)
>     return;
>=20
> free_vhost:
> +    g_free(s->vhost_vqs);
> +    s->vhost_vqs =3D NULL;
> +    g_free(vsc->inflight);
> +    vsc->inflight =3D NULL;
>     vhost_user_cleanup(&s->vhost_user);
> -    g_free(vqs);
> +
> free_virtio:
>     virtio_scsi_common_unrealize(dev);
> }
> @@ -146,16 +300,23 @@ static void vhost_user_scsi_unrealize(DeviceState *=
dev)
>     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>     VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> -    struct vhost_virtqueue *vqs =3D vsc->dev.vqs;
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>=20
>     /* This will stop the vhost backend. */
>     vhost_user_scsi_set_status(vdev, 0);
> +    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL, NULL, NULL, =
NULL,
> +                             NULL, false);
>=20
>     vhost_dev_cleanup(&vsc->dev);
> -    g_free(vqs);
> +    g_free(s->vhost_vqs);
> +    s->vhost_vqs =3D NULL;
> +
> +    vhost_dev_free_inflight(vsc->inflight);
> +    g_free(vsc->inflight);
> +    vsc->inflight =3D NULL;
>=20
> -    virtio_scsi_common_unrealize(dev);
>     vhost_user_cleanup(&s->vhost_user);
> +    virtio_scsi_common_unrealize(dev);
> }
>=20
> static Property vhost_user_scsi_properties[] =3D {
> diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhos=
t-user-scsi.h
> index 521b08e559..b405ec952a 100644
> --- a/include/hw/virtio/vhost-user-scsi.h
> +++ b/include/hw/virtio/vhost-user-scsi.h
> @@ -29,6 +29,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, VHOST_USER_S=
CSI)
> struct VHostUserSCSI {
>     VHostSCSICommon parent_obj;
>     VhostUserState vhost_user;
> +    bool connected;
> +    bool started_vu;
> +
> +    struct vhost_virtqueue *vhost_vqs;
> };
>=20
> #endif /* VHOST_USER_SCSI_H */
> --=20
> 2.41.0
>=20


