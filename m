Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACA576A4E7
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 01:35:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQcPJ-0007xM-8h; Mon, 31 Jul 2023 19:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQcPG-0007wO-Kv; Mon, 31 Jul 2023 19:34:30 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQcPE-000734-1t; Mon, 31 Jul 2023 19:34:30 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36VKjmLP019320; Mon, 31 Jul 2023 16:34:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=Mer+/dF1VcmJK0g4AByk1ttcrPhzEtT36jimEq
 cm5iI=; b=YA03w0Ctoq/CkqOY0lkYcOf718EJF8WXklhIgc3+sTBgHQ1WhMP+U3
 4n1vmqKaul5h2vIkroe91iQqDgermG2KLrW7526t6ytXf8Y6u8Cc/nLI2DsdjUAD
 ZYt6dqbbIqrr6K3DH37SspVbEXoG5tPfG3OUNI6cVbDsYMk8VNu95m1Kc4UvrBll
 7GxSrhiuplFdEAFxMQvJkZ5Y3yg5XivZABnvCUybzDP6aw6NBsBWPEIqqEvunwlI
 tQMQnSL2q70Zret8FNkvKixGISbY8C04woo1cBV+EZS0TmqDzvpTuUiOoW4CPF7Z
 ZzrdzBcokrGWkDpEuRBQ1AajH0VYKnuA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3s50a642hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 16:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfDQqVXjr3+PNOQc4cSDyHMbmOYZG24pvoWAqPOts2hks3kLWuu9/EMNutcpRaqw0Z+uU/FovnlrYudCFJNof1BK6drUbQ/HvOa+V1uriOp3WnonDp1dWAel6dGnY3rnZlVPmBt2HHVDgLyCEmEN+GDo2g6djVHu9/DckZFvWdxKHMtftaK7RAaFOLW2N9JREG/UpXyDrcb44fMMdtFr/Hnx/gzJuSCF9ZTLRFwSMKA6RRgqlNbSoHJ4d9ZwYF2uawHUZykRAANJLiWyRyQOseAM6xQxrX/Kc9Zfb55xaR5P/4d9r9tOSO4vX286HwQabaxbl8jwtoYXvYheT48VVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mer+/dF1VcmJK0g4AByk1ttcrPhzEtT36jimEqcm5iI=;
 b=iQ0B7nqxI++yn2d9LE6c4WydSJbNdb0igrukY8/Kt4MxPDIIZ4U2oxCCj8Z8nUVz9SEJQSsCN/vUhF0AwlOVVF4/4E4qznfCqDBYiCxfmHlc3+c5X6uS+A/ABTQoWARr53WIgp5R4JivNuhlPZL1dSa7bzi31NI1tkBd0GLnA7Fw7dA+7pSI0qWth9ikkXg6TM5mIZTZ96donpjacOBpkN8NRqWxHIR4eqT9YR3j2IE8Ge/BTrsgWOfND9tLZ0lqupSPUwhJkUiOG5qBEuGuRmI6QOX8aREmBEClSk8ku3CbqsEgBJR8WKtKTdQN4D4GS6tZl38ndPZI6pl71RFdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mer+/dF1VcmJK0g4AByk1ttcrPhzEtT36jimEqcm5iI=;
 b=taBbhQ32py6P1lse3IEFsC72kRU2jsZFzEosikKxCAWB1NfG6jbX6UEs8qi/xdZiv5tV3qliVA5nlRZnfHoZEXrJ+j7OcBSVGa6gObG0R9HUE7zZ6evSTsjB996OL0Y/8a/XxLLy5UeVlXJr/6RONOIeBTYdnhQzOHl3NaN6Jk3bUJa0pUFYxGs1GCseBxTaOAiP6kDp3pqKFYmjdVD4NvtGl/xs+opCHGi6e4JwtpM35s1UNmYRcRFfsPfiPfG9WglZ/pf2XTA5fwbJos335qjiLuPtV2eA/qZ6UeeuWcE0z9XKVZlQ7P6dOnRoWWUTr6n1+sewyfEKD5co5dlgvg==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO6PR02MB8819.namprd02.prod.outlook.com (2603:10b6:303:143::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Mon, 31 Jul
 2023 23:34:15 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239%3]) with mapi id 15.20.6652.004; Mon, 31 Jul 2023
 23:34:15 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/5] vhost-user-common: send get_inflight_fd once
Thread-Topic: [PATCH v3 2/5] vhost-user-common: send get_inflight_fd once
Thread-Index: AQHZw6gaTo6YA4BL8kK6GH8x7X84nK/Uh7aA
Date: Mon, 31 Jul 2023 23:34:15 +0000
Message-ID: <116EBF5B-915F-4237-A832-F9F93BF97D00@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230731121018.2856310-1-fengli@smartx.com>
 <20230731121018.2856310-3-fengli@smartx.com>
In-Reply-To: <20230731121018.2856310-3-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO6PR02MB8819:EE_
x-ms-office365-filtering-correlation-id: fa4273f0-e1d1-40cd-345e-08db921ea758
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: InT4uWSRL+DXWU4L4/w11IOn1yo0ZHhiAHJJ/ro3kX2r36rdPWkrC/Fxu7Dr2X0eJgyYOq8n9QGWKgUm+f5RvGW93XrqaGUymRk1YOE8/0RVz2u2I++4ElxjfkjmWo4hKcwoWLXgPO1FWSl1E6zU3UP1Gw83W0ktQu4QlpGkle4SgGAipjn/+BcTKdAWl8HsFeAbZsj0sB9b8AIPkphhEsLp4qOPvbKuwujyRD8F8LbA/9KBgxxUxk9YYFG1NdrFyrzdHc3kn7Cj2x0R+qAy78gdkZVY2sBjQIHLY5gJIkEWLY2kRNWzdYxSFTi7H47O2PzHvhcoJGyrbERhDThTEAyvcuz1+qWWNOXGCKhNxlWS7MDL2B7fV2tMoma3aUAqASXIImNVwxGkIulHMFBXZS8Ab7lmEGoaFAGFCFs7FVCey+inrfMpQvUujvs0S50brEXmjWNLqNFmCJmg1RkP1kv2GYue/VLDkzeXvry/RK/eHry2TYWV0lOIllJIzBbVbtDPvIGCQSCzNzEsNMlLOVCRd9ZBIp00UGR3MJvOJFb2qWrR2fneKsOwxayMCuU+iaRXq41J4kjXwI6gSyn3MBBmFeoi7Ge4+KNsr8cIK2Kw1i+dN5b9NHzqie0PGOo7iYSJVDveAoeoIyYOFURf+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(71200400001)(26005)(186003)(2616005)(41300700001)(6506007)(76116006)(4326008)(66556008)(53546011)(6916009)(66446008)(64756008)(91956017)(66476007)(8936002)(83380400001)(5660300002)(7416002)(66946007)(44832011)(6486002)(6512007)(316002)(8676002)(478600001)(54906003)(2906002)(38100700002)(33656002)(36756003)(38070700005)(86362001)(122000001)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yincxEIZyEpAKi6Kjuxy4JO8oWIHwiODur3zuvoRTwwi+ddsPQ/5C5Qiaw?=
 =?iso-8859-1?Q?hmc8O1cniyI6jr1a+oY2fKH/qMbp1uZTu6+0NznneBHDSHqyrEALCTnpyG?=
 =?iso-8859-1?Q?FXgS4qUtAXgYkf2elw3OEArF/YuoEhWfxHdOJV69QJ/tL3rBfGWggAWgUW?=
 =?iso-8859-1?Q?6Ca4noI4gmqOd9sh91dpz+7mbmtXGUryitsJHMLZMHfbnvrhlqf/YZCdgv?=
 =?iso-8859-1?Q?vtG0zaLzv+q1PzOFznuAPuxEsXIBxUlPdYvMx9zVMAlmMnPwonEoJLOEn2?=
 =?iso-8859-1?Q?0Uw+sstw/wFFbUHpRSoTy/8j1KELsG5wMkIsdV/YnS6aHUTNChaBIebO5L?=
 =?iso-8859-1?Q?A97vLw7jehQMqIqDvLmWcajMn97ufaHvLUdiLQ9w+NTFjf5EBMIvHamCs3?=
 =?iso-8859-1?Q?USJc8s6ju6gx8Ns2q2SKAItWzoHYw+gqfTOQ4y9QzlCHD1qVgbQHkK8dG0?=
 =?iso-8859-1?Q?bnaAB3428ET7JM9FbDYmk4OUPt//Ih1Se+HVbzU3iPnK2poOBXkWFtjxVk?=
 =?iso-8859-1?Q?T6uqsbxVJlw5/qWxHJX+9x8ktpTCqB6P2O1PNV++IBkwpr6Hz1Rf85HRgw?=
 =?iso-8859-1?Q?L4y5ZlbgYqRSVjsDI0dpBl/OXg1mJ524mTyNHP7RKDsJxUxwmfTGRmRih8?=
 =?iso-8859-1?Q?XQ4Q1QUHZWRsIUx0PWJZejMkhUMQFKSbyPZgJU0i+sWD3Tc4oJWMIzE2Nh?=
 =?iso-8859-1?Q?6B+Yg/BsNLe+2VHN9giL5A0T2WvSgNXkngpvTGDmd3RJ0NkAFrL4Z9U5dB?=
 =?iso-8859-1?Q?lna6fjLMRT314UItdO955KSAuk7RQv0+xXyc3YFbtbthI3DY2klasF5Mqb?=
 =?iso-8859-1?Q?LOfSTtVRtzU7qmdvO7jgtQogs05P/LeGTrxwQ8nt717ms5bqAaeBZGdSL0?=
 =?iso-8859-1?Q?fTTkxkR8TpdEnbpbE6reHwFt05mO22/WJeHQKsRe9z6zfU9a7OxB52S84e?=
 =?iso-8859-1?Q?nv15TZ5OG3pyggEkHktX9soIhUmwF3z5xzGqXvmw2SrG194GxQdFnDJNsU?=
 =?iso-8859-1?Q?glC05k995o/nJ30vCtFVpfNDqE9k4MwaGs4f9NCbTcbfynvJHxE75+EJey?=
 =?iso-8859-1?Q?SrpAuaZ/sjQdQDCgLh3PWAlgW/YQQTAB+7zu/hCfHhe+wiDlg+0WCKPtyK?=
 =?iso-8859-1?Q?PoNi+Dhi5mg9C4Gl+pn/QXJPSUxaSm39EqH52Gm9QRg1c2g/5EJ+Vj3MIZ?=
 =?iso-8859-1?Q?8/HBqR6d6f6NVDNU5Du9C4hQMIoO63+WFsUkujOuSEBwVlSK5LSPsAmrkn?=
 =?iso-8859-1?Q?7sPzm1E5pTtlTgxsDoTGEXSPD6wR/oydoDfZYbS/W5V33D+xQt/Z5t6pA2?=
 =?iso-8859-1?Q?+5t+GBOrKrra8BZuo46O89nHnvJ+UBUm0mRt4X0jqwzvxCtWVr9phjjMUa?=
 =?iso-8859-1?Q?7DCSdnM9kwMZxp9jpOiEo/aJ/qKS88jVGib+YpFZbcaganeMba7MhwE+2m?=
 =?iso-8859-1?Q?sfVYTm03gq6yNJVmGjTyTgwlZMpcBY/GvxldBRJmZQ3GyHPB4d+9CMEocs?=
 =?iso-8859-1?Q?ZI5q0B7XagLdKAJNylVCi1UJVQsQ0Z/ScHG72OE59XG6EToYQTh2TwNvG5?=
 =?iso-8859-1?Q?xL+zTFdDotmd0JyPi1RNHtCYHWqbYVl8Siu/EauzHrBm3FkkeknFGV7EyD?=
 =?iso-8859-1?Q?ECYMwQy87KpqlsGz1m270k+YReDzVTO3mn/72UE3CttrzVVZMqEPCXXA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <ACA9761E659EE84EBE8726A88ADB215A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4273f0-e1d1-40cd-345e-08db921ea758
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 23:34:15.6835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fy2189rzLUUhKcf+7qR5jXPEHYmuwaoCGcap8ZghbvpPEJ/ZxlUdcvQ2CQRTDtYWVAlIGXuAyaJPn9yeuB3BM4d4eK8Ini83WJIcoD5pcjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8819
X-Proofpoint-ORIG-GUID: -dFH6k3K0D1KuntvyMeqoZ3SOMAeDe1V
X-Proofpoint-GUID: -dFH6k3K0D1KuntvyMeqoZ3SOMAeDe1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_16,2023-07-31_02,2023-05-22_02
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



> On Jul 31, 2023, at 8:10 AM, Li Feng <fengli@smartx.com> wrote:
>=20
> Currently the get_inflight_fd will be sent every time the device is start=
ed, and
> the backend will allocate shared memory to save the inflight state. If th=
e
> backend finds that it receives the second get_inflight_fd, it will releas=
e the
> previous shared memory, which breaks inflight working logic.
>=20
> This patch is a preparation for the following patches.
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
> hw/scsi/vhost-scsi-common.c | 37 ++++++++++++++++++-------------------
> 1 file changed, 18 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> index a06f01af26..a61cd0e907 100644
> --- a/hw/scsi/vhost-scsi-common.c
> +++ b/hw/scsi/vhost-scsi-common.c
> @@ -52,20 +52,28 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>=20
>     vsc->dev.acked_features =3D vdev->guest_features;
>=20
> -    assert(vsc->inflight =3D=3D NULL);
> -    vsc->inflight =3D g_new0(struct vhost_inflight, 1);
> -    ret =3D vhost_dev_get_inflight(&vsc->dev,
> -                                 vs->conf.virtqueue_size,
> -                                 vsc->inflight);
> +    ret =3D vhost_dev_prepare_inflight(&vsc->dev, vdev);
>     if (ret < 0) {
> -        error_report("Error get inflight: %d", -ret);
> +        error_report("Error setting inflight format: %d", -ret);
>         goto err_guest_notifiers;
>     }
>=20
> -    ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
> -    if (ret < 0) {
> -        error_report("Error set inflight: %d", -ret);
> -        goto err_guest_notifiers;
> +    if (vsc->inflight) {
> +        if (!vsc->inflight->addr) {
> +            ret =3D vhost_dev_get_inflight(&vsc->dev,
> +                                        vs->conf.virtqueue_size,
> +                                        vsc->inflight);
> +            if (ret < 0) {
> +                error_report("Error getting inflight: %d", -ret);
> +                goto err_guest_notifiers;
> +            }
> +        }
> +
> +        ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
> +        if (ret < 0) {
> +            error_report("Error setting inflight: %d", -ret);
> +            goto err_guest_notifiers;
> +        }
>     }
>=20
>     ret =3D vhost_dev_start(&vsc->dev, vdev, true);
> @@ -85,9 +93,6 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>     return ret;
>=20
> err_guest_notifiers:
> -    g_free(vsc->inflight);
> -    vsc->inflight =3D NULL;
> -
>     k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
> err_host_notifiers:
>     vhost_dev_disable_notifiers(&vsc->dev, vdev);
> @@ -111,12 +116,6 @@ void vhost_scsi_common_stop(VHostSCSICommon *vsc)
>     }
>     assert(ret >=3D 0);
>=20
> -    if (vsc->inflight) {
> -        vhost_dev_free_inflight(vsc->inflight);
> -        g_free(vsc->inflight);
> -        vsc->inflight =3D NULL;
> -    }
> -
>     vhost_dev_disable_notifiers(&vsc->dev, vdev);
> }
>=20
> --=20
> 2.41.0
>=20


