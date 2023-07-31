Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3FF76A4EA
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 01:36:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQcQY-0002SY-0H; Mon, 31 Jul 2023 19:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQcQW-0002I6-8N; Mon, 31 Jul 2023 19:35:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQcQQ-0008Mt-UU; Mon, 31 Jul 2023 19:35:47 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36VKw1rM001915; Mon, 31 Jul 2023 16:35:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=7n0+wIimWJncZ66CJngc9Br+Qmu7aak2qGcJal
 ncUAI=; b=233YTO3MmlMztQju0Ije8AYhsqfrHxQcl6ctdu7Xt6ST6X/7S18gYF
 XV8T/NiNopyY2Z9e6won8rvtd+eAr+hfrmkDPyvp7FA1yPO/l14ri3JoOrUG/DAn
 4p1VPquz7llknie4WQUEpplPdaGfuij63na/SvWiR0Wvai7dw7HNwfGS6E6CT8Du
 Ll3UePDQTED5HGUz+F7Jlsb04MpMkMqpLi0HYdfsI4UdpNpJdo6XaT8hJLrMJR7E
 6agVR7xvqTYrlC2HYXi59twVM0bqz3l+cFjDZzuPVdE8ZjFYKR0fN9DZc5S39v5b
 3HqpE7Ioplwli/IDlbwhFn0yDfOk/Qnw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3s50vfc21h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 16:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObfN1TlMyo3sMzwTVB0Dym2JnaZ3sVLDO3grJPGE6AsiKZrp8M3OW6J9uPlBjIA7jNy4S5x2R6kih0visYpVnnrPyr2fbpMBLtHPAtR4i5EA/aQZv0GQDLD7IldB27DpQGaJG02bxL1uaHEw+klBB0+JssZHacgF0eMnD+YJnbokjoYSm8aRoUp5kToz1QBKs8ECxRyPjN7yTyPA2UVZy+vFml7SmC/sLhWWmY/MNsc8syGLmNI5RJOm0/zxVi+BIlGC8A3Ghh0D28KA3VEjagtRsWON9i0Ol4xecZ5ZwGvWAz9f6+5XiG7rbiqZpEZUybTtK11cBJMMzpDgbDP9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n0+wIimWJncZ66CJngc9Br+Qmu7aak2qGcJalncUAI=;
 b=DXIYYAMGSdNjca5Yr9fVtVDdREzhtx2cfkJ+1rzG/LS4Ds8DOrpFjqpom81ho09lcx37rVl0oQaq8Kb1uAq2bJ/AtYm6bwnM5OnQ6tOFUgvRRYBmGXh8ghXPAE18hZkTj1yUVBQcFr03AhSu71wZP93jrjNBp9zaCtZAWUSThaSrePsmzGmj2VRDQdE17MtEJ9ve+pLtxCXg6N45/vF+7WkaHRrCSHB+6FEvmPL6wnlR0ZTyaO3241UGvKEHX0BgvvN6ArM9oVTaUhsUv35DvUWDYJgVTyJBMYnguEsf5/mJATNXhNJXRtijPIW7aEfVmdBGYSthd+Lb+h1apYrn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n0+wIimWJncZ66CJngc9Br+Qmu7aak2qGcJalncUAI=;
 b=hWsCSvdT7IhUbqMMr8MX1MQi+58pyAvozJGFyP+Zc68KRBpcMhpbfoUdzj7eAurdlsNC3EH3LP75EWxs/FELHSW54h1VtO8vd4Cd7NQIYnkyBylTEIn3PLXg+awtEIh86cmEmdQ5AodnGBQXhi6TpYtT5t+kgbcbhcYo+4ka/6SQzM1QZEspoDqrheBgKysiUeroxu7Uyt17chTWqi816tyum0eoW+u/WwwKgfjGCir/q4HuBGseMBOLa6DdmddnTXzra/IfeIpBOqY3+weVmruRIcMEflg+HCIS2K6vS+iMbWa1tITqPnpK5h9PUdOR5d2xKLJaC1IMMhoUkb7o5Q==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO6PR02MB8819.namprd02.prod.outlook.com (2603:10b6:303:143::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Mon, 31 Jul
 2023 23:35:34 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239%3]) with mapi id 15.20.6652.004; Mon, 31 Jul 2023
 23:35:34 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 5/5] vhost-user-scsi: start vhost when guest kicks
Thread-Topic: [PATCH v3 5/5] vhost-user-scsi: start vhost when guest kicks
Thread-Index: AQHZw6gh/igB8/1MYUu5DMf1NKgdvK/UiBYA
Date: Mon, 31 Jul 2023 23:35:34 +0000
Message-ID: <1A8DEE66-32A3-4504-8A73-50DDD74DE2E2@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230731121018.2856310-1-fengli@smartx.com>
 <20230731121018.2856310-6-fengli@smartx.com>
In-Reply-To: <20230731121018.2856310-6-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO6PR02MB8819:EE_
x-ms-office365-filtering-correlation-id: 2ed3b62a-cdbc-41f5-a62b-08db921ed667
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1TD0Ni6ZV6PJZmQJEi7StmEWtRKKiwnXN32amKWJbNLBTT82nUji5A2zAueqFqs8sywTciQwwpd/p/3kHVY2VD7SZkQ72CRXlwKMQh5JOnYyV5LxGrpLvdsBQYgEbVy+yznbCKrCB7MksnchYRDzbLUV0f7nnNzoezeVb7sNWoCQGHffRMTB/6ph9PjrLQ4jM8Nf6QrabKiEV22SMWjoAmStHO+DODyzEuX+QWKnAYxGs/LPgQhtaJZe0REE3DWAbArGqhi/0nIE5rV5My7T0SFOpry6qF4C8kyKYaDHb4E0a7DnhcMgk6PDqyOVd+WlkwVrGXWKsH/8j60kMjvhp6on+idNLaeytS5bfgHe7JcCwysc+DL3LKW6oPI3EWJoB+gzFEqt4X2xLFtZtBbjEnWVy7QVdufIivTIHbyj4JDKwZHllIw2qzFYH1WMfJD1h36rcXf3t5XUK9PYZllP/IWtx3KacdAI1YxaMwHeBSC8VHMn8ZYBIx+qYPnGGi/R8ApwWst56kx0VFI6+uzDhVoGBYKEGrkzJwbVWzvH8y4f4QDpuh33A2WLlZXqKtx0fU/p6v6KUDBl5I60jgYGAmwj3Y7Us6euRtofr3nI+Yo3kUpoPF8wSUWnsd8rXCp2U97fzUFLGVoZxMZgWpmx9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(71200400001)(26005)(186003)(2616005)(41300700001)(6506007)(76116006)(4326008)(66556008)(53546011)(6916009)(66446008)(64756008)(91956017)(66476007)(8936002)(83380400001)(5660300002)(7416002)(66946007)(44832011)(6486002)(6512007)(316002)(8676002)(478600001)(54906003)(2906002)(38100700002)(33656002)(36756003)(38070700005)(86362001)(122000001)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aWS1WqXRfReMsL6hQuqSfbVTmcBZcCS90NNnTBYlUk7jwlOgcO7GA1OCcg?=
 =?iso-8859-1?Q?HAwAz7uvICo3QqZxTBSByaoBXpub3AA/eBJEsMrbH+8A3AR8PRu40dLlBW?=
 =?iso-8859-1?Q?ok8jiPo5PpvRT4rH8tmu2YSPMNSn2HTCg2+C4LSM0DehubqW8hRJ7cYIyu?=
 =?iso-8859-1?Q?OPTcbVNYaMJFdJPimzN1gFOCuEPPrtdfu5j6hG9enSADwAX/306G1PHbrT?=
 =?iso-8859-1?Q?0Ep/9NF6+NEGmn7Z4xfIyafXNYdeV312hXt0Iyj7yRbdqM/TeU+gRF3u8h?=
 =?iso-8859-1?Q?IfsXd8uLCXhs1bvnTCuwLmLwYf/vvtgHOggHBngDgh0bEOgphzYM4ItICW?=
 =?iso-8859-1?Q?yMVXjgVEJR94UMIStgaGgdH/nXysGn9DNv+deSfNaDR1xQWM5R7hBJEXhH?=
 =?iso-8859-1?Q?t+/6fUxxDzt8+0Pz3thyEjbrPBw9ExBmeMfSP4GWTzzaoUnJxdMbdSaCX8?=
 =?iso-8859-1?Q?iP2s6owYDqB+jEmOqCP1ZaWwGDnIA3+YZFVjYZ3hY1hSa8XChad3PARiy9?=
 =?iso-8859-1?Q?kzd+ytJmyNamNrjnMxdVf1th6Ob4krCsjEO0ClHF7xUWJ2Ay4XpeGi8EQD?=
 =?iso-8859-1?Q?BS1dFYJrJXrHgbbDN2/xJrt8y8SGBpEeUTkkxbV9XbB75Gji6uo8pa7mUX?=
 =?iso-8859-1?Q?YkNUhYG7ax4WIUkh5cIKlrl3Dfk1xa2qt4p1Gw+btFT13SzTjg4LgI8xlh?=
 =?iso-8859-1?Q?iMqlk01UKB6+hk/HA5HV+9/JNA4HcwiO1aWfULRKuN9IC1YDvkyUbEf05M?=
 =?iso-8859-1?Q?UZLRN1poMzt71LiMOUado36nOsh2dMj07tp3zOPobVE2M0Fs3J90vMF9vG?=
 =?iso-8859-1?Q?h2xcmm4b/AnSF0e5wXMI4aqZtuwLe26rV48fW20R1CYKWIq0rzxwPeacwf?=
 =?iso-8859-1?Q?sYDZZzmKLg4+mRozNtdVQacRJIhoHOe6Z1C9LBm66kEHq+ZAcC6cR79bZW?=
 =?iso-8859-1?Q?DiSGTC48qKGsWLQqvCSXkL8fWHEXyJKAq+rcDs3w8HcDunTZ8mUh160AM7?=
 =?iso-8859-1?Q?sQtg79Gcnc7oQwZ3ZiYbk43qa5ykB/HAJ71kv7fyVJwH1OYMPrPxgRCddE?=
 =?iso-8859-1?Q?T5NmC+40RtUAnJ6QGYo+QsXt0vjTWUQCWlbmWMu/Fb+zVKzmLP/SZREnzh?=
 =?iso-8859-1?Q?0HR4mhtg46MPPmgRUCB3wyqMTBZ2Dlei37JzpxxrdXjB2IkWaJOusBfUkN?=
 =?iso-8859-1?Q?OwqcqdvfbRaRff6uxejteWCQLQRzswlKLn/UX/MgdYSkWUMQAURaS0M8hU?=
 =?iso-8859-1?Q?Kadm0uHSazRbQ4vxcO/kxL3m42HBO+SQ6Az/HhU0hNOXVQhDv0HVp6RQQr?=
 =?iso-8859-1?Q?COMWr63TPOb9f365P9GkVe11paa8FaSzQSWNXlSKFVgP93Ply0N1v9jNr5?=
 =?iso-8859-1?Q?VWk7TYIM/q7SYdZFfNKdix5bxsrT5Y1RSqj9V2iCIba0XLvvwLUul+Bcoc?=
 =?iso-8859-1?Q?n+p/Cahj2UUdLGdsO9ZZIqt11BlvmmCRIWmQ62o14tYRs83R5wMoHWlc07?=
 =?iso-8859-1?Q?Z+7zlu2X/cQzBDEFykbTUQb/lWraKiP0/1YfhnXKJb2lUjYQm23LJRT1On?=
 =?iso-8859-1?Q?xfl3sSQ5SGdkj0E3XcExkKzoI9h1ME5gm1Rr3+aDtNyoo8TCWweTbQjD9P?=
 =?iso-8859-1?Q?KxJP49aXjJsxyjESFiu1w6iBtZkXwuraptVUQSlDa38QGwE0JGkOIa/w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8571951EDB0E584FB2B81E94CFD29591@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed3b62a-cdbc-41f5-a62b-08db921ed667
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 23:35:34.6815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtTd8rUpFdkXd+sPGCqkeH2GsvdlWxGPMWFNuNg6+MIt/2F3tKhR9cC2OF2TPwxZ+DLFz2NJ+a99/BTDFrzgtwaQeKa9Va1GprL7pHy6oB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8819
X-Proofpoint-GUID: aYT81DOQcuchOEMMNuYoWXvxJvyNyawc
X-Proofpoint-ORIG-GUID: aYT81DOQcuchOEMMNuYoWXvxJvyNyawc
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
> Let's keep the same behavior as vhost-user-blk.
>=20
> Some old guests kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK.
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
> hw/scsi/vhost-user-scsi.c | 48 +++++++++++++++++++++++++++++++++++----
> 1 file changed, 44 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 5bf012461b..a7fa8e8df2 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -113,8 +113,48 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev=
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
> +    ret =3D vhost_user_scsi_start(s);
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
> @@ -243,9 +283,9 @@ static void vhost_user_scsi_realize(DeviceState *dev,=
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


