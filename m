Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DA9768903
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 00:11:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQEc3-000095-Ue; Sun, 30 Jul 2023 18:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQEc1-00008D-HO; Sun, 30 Jul 2023 18:10:05 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQEbz-0006lC-Rv; Sun, 30 Jul 2023 18:10:05 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36UL7OI8013162; Sun, 30 Jul 2023 15:09:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=BvvTXO8EQI06KffL5h8jddXXw8pHilE6WAjPMk
 BSIi4=; b=w23B8gIj3t8UEzL+kC976BG/ItgyDFKQvUy2CISx1hgdE1uMfJubE5
 HLIoG3JE08tWJ+6P7rH/Fk59PNyVBkVHVk/Wb4UwQuwx+Hwbbf3WPSyQJlXdDi8U
 M/ILEDdM4NFKh09ZoWyXFkkgI0kJExl6Af+nEDKKifZA0o6E6slRg7AyXx9Bdg1g
 JM421jwb5WO0WScjuZt3sGDxFtsY0S6jJu/KLT+JJ52DsmkInc4L8kdQFpeaHdal
 TmHACzdLMlKFzTSfbTKWY1lGLs4B61BGHxjNX+TvZA5PnmyCavxZlXEZgBIlCL35
 pqHR7o/2wtOKHP6Du+6ZZLfMoCJMeoSg==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3s529x9nrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Jul 2023 15:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAFiIjk+7dwge97v4AGMpPJ5mXikP3euB0XnuPV4mOxTmnT2+NxAzEhvNmC4RoH7lfeaOTsExVbUdXRwxlxikWE1ZDANeNmV694i9S2vfzJq/bY0b38Zodo8kSLDpV4xJw6LYIZPFLMc1loUnkgNYUsgCQTiStAqJRsBdiGcAargo28VwfZPhp4cp6oA3gJysQ1LGcXlN89AbHb1cqm0eDID65XZAxAfaKkvGmdzQKbz5p46j8vyVTJufL3SQMcTvKNr1rBtcvPKBkWYlGCTCC7SW4lUl3t92dc84V6ZBe/MHnsvuykjxe7FhJMFJAGpwpkkKitUGOkULaUFA72j7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvvTXO8EQI06KffL5h8jddXXw8pHilE6WAjPMkBSIi4=;
 b=Kv3M8iVyTtF9ZL/AArS8Cd6ns6xZTPO79q4Dm6hmfWN5n9/HMsPc2fIAvKsL05i3HPGq2ggxwXPdGEqsf1L8uBn4uBDdoaJycx+hYnbU+SAVTifGf9xzkiGsXSl/X3stM1NSmmpHSlxkT8fdXztNKnKuDwxXhQkzL2K4jRpmnav4cN4dv9IgFhmzFvF3jp86pUlqLBv4r3OH7tc8/zBSZb3u9F2p/ABsv49alAWPEtHP/7VwSEBSbA5Rh33QQRjAoWKX6D3+rXk0DdLF0wwn4ttAf+Arw3LtUHpZtb43TgNniTxL+sGp5tN/h9PsuxiB4PdgXJYuPDYm9didXHcd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvvTXO8EQI06KffL5h8jddXXw8pHilE6WAjPMkBSIi4=;
 b=rLnk2KtyjQuD4psstKmudHrHxunRSt0idl77yaRMxrHfSpOpD+MGsdNpa5IldTQ885IwqDXqDU6HUkpx80c3vPyuOmjeXVefdMDm/ktsyM8DnEhjiX24oj+80xLJEMoKT9Mh14J3Wo/y1BYI8hkNifJ5jHGFCiTfTj+qJvrB1jdEfDgSWGdn0pkAMB3TTiK7zOYa2y4cAYE7r1HIgEM59tQ0zo+osD+LNWI/SZSiNtSrib2aiS2La5ZgROnbWJgp0nl1SXgDnrGGcDMr182sLtbDrVU3IYjbvOU9BSenke56ZtVjZVeR6ygBj5YDzyxRz6jlyCoCnjLjuiFzBqChNg==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by IA1PR02MB9419.namprd02.prod.outlook.com (2603:10b6:208:3f4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Sun, 30 Jul
 2023 22:09:55 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239%3]) with mapi id 15.20.6652.004; Sun, 30 Jul 2023
 22:09:55 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/4] vhost: fix the fd leak
Thread-Topic: [PATCH v2 1/4] vhost: fix the fd leak
Thread-Index: AQHZvuTeALHNd7ZsykSFE/XXXUhknq/S51kA
Date: Sun, 30 Jul 2023 22:09:55 +0000
Message-ID: <857A7CFE-01FB-4F75-938B-85A319EF371A@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
 <20230725104256.4861-2-fengli@smartx.com>
In-Reply-To: <20230725104256.4861-2-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|IA1PR02MB9419:EE_
x-ms-office365-filtering-correlation-id: 7acd47f6-ef4a-4624-c7cf-08db9149b4bf
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nChAlUR3WxQFNir4WbXNIvPBOq6mek1f4f4srBhSjnRYR4/hI8q1RSCLOHyJ+tOf1KrOEuKyymIMo/C7GdQRFQRtfMJbrQnh+J4+C7jAY9DnxtgUn9fLvJS/8Q5T9PtBXAhWYUFcVALsW45ZHuNtTgtchlA8+V9B3ioQQUx9aK/3Z6pAYDbN30w+3eWDNCxZSWiIr1g2IJ+En05krPcRJg+J6PVrVKHbML44GmWfVAxmsvPvQwh+5VaUkmFcpRQNZfxZeDFqntNc+svgwkKfdNWTih0gLFfQ04n6FPr4CZsIa1xUtDattrVTx3FZOprru0E7OywYs6+FdGjLohxu3Lj3TVMRr9kBcJ0dQMZ1qgq32b8H0Jqyv+DirCIZ4JuXWklJMOuIPm1WrgJUS5jqQCbmujpuzobQLX0W+3S6UrTk3/2OfY4T4sDteXYxuQ45q8TDq3LaLThF56NketECTzVScCIL9yb3EzbYX00Pv4NX0YUc4VSbJ+l+s5dEvnHhE24q4WX/Oyjsfc36Q18ifg24NqdiFNSSGqVZaLZgPOi2iRRJhqRi+iK0MHrDGoHpnM0mRbr4OW/CeO0xyMwCg+0m+QikysIA7VnMn1rEYSP9S0OuavNL6ZmIgV2b4zhTCYSkM8iwVKBlf8VkynQRbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(71200400001)(6486002)(478600001)(53546011)(6506007)(26005)(6512007)(64756008)(6916009)(4326008)(66476007)(66446008)(122000001)(54906003)(66556008)(66946007)(76116006)(91956017)(186003)(38100700002)(2616005)(7416002)(38070700005)(316002)(8936002)(8676002)(33656002)(2906002)(41300700001)(4744005)(86362001)(44832011)(5660300002)(36756003)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZnWsBPB4uVrg62EmWJplGCYiITx4WA3vYer0aLtFqE5P0FjjOx7rAjzs2l?=
 =?iso-8859-1?Q?JEW27JiQNz8xYvBplwtgOx0vnlwNO5FGYAtksCl2jQ+of5LUT2h/IrPNor?=
 =?iso-8859-1?Q?6F/pczHQ3J56YvTZhn5DXSKEgMKY8j4Upfx9Mw7t/V3WImVgDafnW8ee/H?=
 =?iso-8859-1?Q?7zzt21TE4uzokxVx28auCE5wmZeYu/bJTDADy4tPlDTYwtY2/zvrUK3QKL?=
 =?iso-8859-1?Q?FvyknWd+KH5edl38+lN5QPCgL604CdDFli1btUGdwNPF6MI6lG+pL9WMuw?=
 =?iso-8859-1?Q?Ynl/1afkwFhe17r+j0yqxpYueYWGItepCHe368XhsrwS4iakPhk6jBpsvF?=
 =?iso-8859-1?Q?eVyByTWVWV9DVCNMG8LY0j7g1ynkygOC9GSq7M7U/OXEY9olvjxv5pTKyD?=
 =?iso-8859-1?Q?PMZ4inCtq0NkPNClj0U97zvGL+57vyTVcwG6xyfeLL8r2MHj/MjTp0a3TV?=
 =?iso-8859-1?Q?JeK6OhJDSrglHVwomMRgxwK9mWDOYEJeTAn31SawIZznX5sbgz7P4mnqed?=
 =?iso-8859-1?Q?1LuyQpLTMmzFjVQhtE89oC6UhXH1itPFzLlGGZ+FfpzoCcnPM1yPlw+ko+?=
 =?iso-8859-1?Q?l13p8A8FuzEi/lMe9hdjnl1QOZ6TVIinCGsPuWtWgPVGR/9aEGY3xf0HAO?=
 =?iso-8859-1?Q?J51+cXvLLZlJ6Yfw9C+3hVn5q+vlDv3vAOcEkz/WiXJi6qTm33883UbuYs?=
 =?iso-8859-1?Q?/TkQAQJx8BpmOUNQGQ7j+YdNnpn4L6S20DqnmgHUFfG8qq7K5tCYE1Ka0s?=
 =?iso-8859-1?Q?f9f2KMJRPR1S99Uk9qbV/Zc6CN3tgGLo2Qy5YJPxndgBPX3gbn5tvWTFqt?=
 =?iso-8859-1?Q?sSFC8d9VQoEdmReNF+VJZuExD19yk2/uBcglNtVOSN6zDgmckwc1HtQn9v?=
 =?iso-8859-1?Q?SjTU7gB/lHQ2pY7pfm5qNuBSAfdThTER6fIMivxI76PGe0oGCwOP2OrEk6?=
 =?iso-8859-1?Q?UqBo+W9pk2vWWs0scWQXXR6L2sBNZ+hrG0Kj4CTZn59dcZ6Xg9PF/9n8+g?=
 =?iso-8859-1?Q?GdncT1qGERaxJjDkD1PuBzLx4YezpZBJZwVQT06EOxD7Jke6h0J1JWVCL9?=
 =?iso-8859-1?Q?WOFKdOvSCFra7uWvNwizxeVACli7uEON7lCUktNXjzyEAUU5DUI8JrKaoJ?=
 =?iso-8859-1?Q?vg2+8YKAH5ObnhsZY4VgImd+trWLY+IAhtdH5y9nhC64nOiK4KYBKbXFDF?=
 =?iso-8859-1?Q?PLXeXJnO0gNHF80HQXif+Kfz7wy2OAH9KEZ3DOH+RA5Zsd9BQhxsCsDHkM?=
 =?iso-8859-1?Q?9RuHIBKRxcXfMnzaWc2Z/no1wASqAqZKTQLeRsadI7RByhUyNMNOCFdXsc?=
 =?iso-8859-1?Q?SGyLrHCYpz/hzmp+icn6ViX37tBb9iFh6wCT/c3GjJsDkY1BFk2sO77R87?=
 =?iso-8859-1?Q?QbKgnjq0YlrHv1Svb0YFXIZa+bbjzDVXXgtSNXS18Pjp923wStgBG61t7z?=
 =?iso-8859-1?Q?hfhcJPm37NgifgLX5BXYggXjODKoO9UdiiQ+DTuamxROIXxe2LPNFKSEHB?=
 =?iso-8859-1?Q?36C9uuwZEnHawXFu11U9vFGH0dzc/rKF6gA581+VGvMUimZVde0x9urrFX?=
 =?iso-8859-1?Q?+QYCTxIqalmwMYVAnm5FggA8BRxzhjQ1SzEGZbdtWZrlYnxCbq0cNRTlzz?=
 =?iso-8859-1?Q?VqWAyS6qEij+QsA6wwQrNUSqWxDl5Gw4sc0s40Ss5Y1FbJ6O5SxLp93A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B95BAC1CA6B44640A08441AE5E62345F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acd47f6-ef4a-4624-c7cf-08db9149b4bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2023 22:09:55.3623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /cQ9sX33XJkMLSfaoSDT+LTlhE2RliqJNc+/0tNW0aDGxgfAO2VUBrMVZTlMaN0U9GMDrwLpjTRerdheUiffnSRxKhtAvG7jUqVt1c0YdeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9419
X-Proofpoint-GUID: vipBSYGVWwV0UHQ2YVcNJcoftSISaUfO
X-Proofpoint-ORIG-GUID: vipBSYGVWwV0UHQ2YVcNJcoftSISaUfO
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
> When the vhost-user reconnect to the backend, the notifer should be
> cleanup. Otherwise, the fd resource will be exhausted.
>=20
> Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
> hw/virtio/vhost.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index abf0d03c8d..e2f6ffb446 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2044,6 +2044,8 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIOD=
evice *vdev, bool vrings)
>     event_notifier_test_and_clear(
>         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
>     event_notifier_test_and_clear(&vdev->config_notifier);
> +    event_notifier_cleanup(
> +        &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
>=20
>     trace_vhost_dev_stop(hdev, vdev->name, vrings);
>=20
> --=20
> 2.41.0
>=20


