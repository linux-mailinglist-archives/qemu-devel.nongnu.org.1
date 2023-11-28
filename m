Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5E77FB1B1
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 06:59:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7r6g-0006g5-MI; Tue, 28 Nov 2023 00:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1r7r6e-0006fs-Ma; Tue, 28 Nov 2023 00:58:00 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1r7r6c-0008VY-UG; Tue, 28 Nov 2023 00:58:00 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AREnsTS027652; Mon, 27 Nov 2023 21:57:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=Ua/70rubjkRv9yT3TiI0OdbZEDnQz1xH4NgubD
 YhIUY=; b=k51AtjDmtMH/EsUAQSQu5vK9JOXEMPOiPFRNByULnCs8hbf/J13a+F
 6BlT7Zsd5JrMjUJdtSLUsqtS23akH6VGo7bGAHaEVavFSWABPGWvObAIEcJfnJrU
 //fOal1Qun/2Ra5ar8Pupt6qL+4/v1NWYvDt9JCtdl+E/z3sO8/wfXgbRvNJmzL5
 xdHaXknfk3ZPjQcPKWAZyVofXVv/8aaSHfY4tsDr5gX5cZayx4uTxg1lSus/gIoD
 to5o5JprAmP3o2962QQKVvQ1m9HuONq1Z+5J7F95M2NAmKkhh4mZ1bOvqTmQnt+z
 95m87z1g6wjYIW3yodcOt4E8hBzcaazQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ukgvhvcpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 21:57:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgbJHDj6a0SjgiAKggc+n3xHBf2Lps78/bYgvyyQkgbenCmXY32AKlwJwrCSgWq/x3HYLpbg0e2amsYGPyJoZsePG4NCCc0xJ1K59deyjGCHSrfCnBWSHsbBMPUtZnhrN6i3ZqtPyy1SqwLMTlZ0N4saQAXmDZteDrDmMho8Q+S6uXqYN+dsb4a9K0NpLRdjFBtC6e5zFIiL1MW9jYTNeDrUbqBtDjhSJsbGxLVNMD9S326CMAb+bkLaGzWdLzVka+6dyjlYPaQF3jO7L1PGap2CRtzRkWlJmNAllLlsaEZxT37yP50r5ho80P89oaNKJwyHKEjES5eheEWNlTi7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua/70rubjkRv9yT3TiI0OdbZEDnQz1xH4NgubDYhIUY=;
 b=GY7p00Ym1pV+P/190p6CRubXykVzz2Oqus22SelUk6QNmBzS8qG3UuiK2mzsW1+q9ZSNMPanX2wRjq545bELv5SzwEjPHErbMIGgEh+ew4CeQUwRDyNKPvGXTvxc82BIRMpXIyC6oV6UJGDlaP44e+W48HyRDJeitihHWKs58+48TMD5AYZHs8LhT9HQTO0L7QvHT2yHXS+MXPiugpEkbhWORsRSEKoz/km5/YyRjaXRO1q/iTMZlVw6+is6sdgS8OYpqfZ5mF51cJKdsfOPaH5Vd2ft9R8L48PcN6h+a6mFlZesb6d2X0dlFaVazvQwMGzwHA9DrcoLoO/yFgkOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua/70rubjkRv9yT3TiI0OdbZEDnQz1xH4NgubDYhIUY=;
 b=Nyp+pVXDhFdHJ0YPLw/DXNizxYK8OJwyNOGT0pAVc0Yknx4Ra4uEVIRDBZATjijlUfSfQKHjdyDKCWmT1L5Fdc7cgwBxpQ/exHCEG8WTYBLzP+Fkp0WMhfr/VAo7KK1FnOhbKLkbUT5Hj9jAT8uFyYO65IEzm80LIciQlXVLEMGac+Kh3H4DJb3KFzVa5hIgB6gBiX+NQyQKERz+ipi6XF8lst+G96nvGuDfa86B2HrxQbhEa4WQRqdQ9YhmSAmR8MwXdEtz8tbOjDcsxpqJOIWQ1b0kBE5jNeORIoosztJ/iWdZLPyZ2FpQcgnYaq+/Mgginp/2NxSZm/JBn4DHPw==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by LV8PR02MB10069.namprd02.prod.outlook.com (2603:10b6:408:190::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 05:57:47 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::150e:cf33:5d45:9a57]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::150e:cf33:5d45:9a57%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 05:57:47 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/2] vhost-user-scsi: free the inflight area when reset
Thread-Topic: [PATCH 2/2] vhost-user-scsi: free the inflight area when reset
Thread-Index: AQHaHdGpKuGS6/O2T0uvY5+KdpDOmbCPQ/yA
Date: Tue, 28 Nov 2023 05:57:47 +0000
Message-ID: <530BAC1B-120F-42CF-802C-6A29DCB980ED@nutanix.com>
References: <20231123055431.217792-1-fengli@smartx.com>
 <20231123055431.217792-3-fengli@smartx.com>
In-Reply-To: <20231123055431.217792-3-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|LV8PR02MB10069:EE_
x-ms-office365-filtering-correlation-id: c528ef3e-08e8-43f2-7f56-08dbefd6f2c5
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fFx/C6Sa3kb+5elwYrI5lNRSktetc+NoapZTYDeZHnl4KpzaaH1wZ/mKMtik86/aE8vx5o3q25JGHjkI1vdP6TbssmMTt3uG6UJ19INTYzV4ZEeXOK0aWu27xCGGPpRA09Emngs6F+pqOYvQ8BuzKjPHWIbiK7sMczPVNjI5mdvTEjeECEMleTDM9v6NeTjqqNTleBeDFL2BUibdvwC625ZyhDwWVmfp5u2Ccwj8qyoJ8NplBrtzDij9LUYszC3ArtCO1YUUo/ZAQ8Q4Zx7WH1dmeNEGX7QkGP39tfA9U7UNKACSSDHSgPOjGwX8u3Rz62LXOKTBXpwKz0JRYJB6xQN+5qUy4JGcj1LGOWcmzBH1icGmv4F7R3XyYX3ys86qK/nojTXrGRbB7m/nUrWnrBsqf7fKURTmWkqyq9Id3Z0boaU7C7DFnifSBlx/EN8jLPV5drH23p1ANkv9Q7ACOGjhAU1GH06fgqpJ83JqJT/KGvqyr/Ozd0W+3j7QvgJ/19V8aC/oi42UW1CezaUd/F4Sx4FOYRtzkumEzDnSVpOw0NOLBPKoOCzRbB4dJebFu/StgiibTWPUHBje82l0xlPvCGvyCkk746m7kD4etUK7wKjg8F53zNuW53UNZwkRLOjDZ3TnQpIMPQZS0UOH3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7416002)(2906002)(44832011)(5660300002)(4326008)(8676002)(8936002)(41300700001)(66946007)(91956017)(6916009)(316002)(66476007)(66556008)(76116006)(64756008)(54906003)(66446008)(6512007)(86362001)(36756003)(2616005)(6486002)(478600001)(6506007)(53546011)(26005)(71200400001)(122000001)(83380400001)(33656002)(38070700009)(38100700002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?589/vEsHMqmrILJc2mE0asgIVMyuZ5izUvT7LoVEptg3yc0Wnf/6loZksy?=
 =?iso-8859-1?Q?vcH+5I3cGk6ylLsJBN9byPYdV6VqTqUyjxcZR1c3hTA23G75clEZWRB2Jc?=
 =?iso-8859-1?Q?WwaIwTvdIMJ5zki8RhqhIIvJRuYU7lO9/DoZtoZMIbpSYSfkgSGGRUeclS?=
 =?iso-8859-1?Q?X4d3M2664paCFNGJSlOthzFqo1xq7tE+2GBrSiX6KNzKW0OJlyHFITCXoo?=
 =?iso-8859-1?Q?VPit+PsEE9fVQTA3IkUVZFfujXC0KEbZ2dDLA0VpnMGWzjR9x67sAxgQo+?=
 =?iso-8859-1?Q?fqBO/243wdtUFFp/ll7577upH2pKg1sePwJ5h0uht31XCE2XgjT8nqHrnH?=
 =?iso-8859-1?Q?cNrYWOmrYjg3dGsiSyQDCMJfk0hdND0HFJqroVql5KzIy2DUbDtaCP+6lm?=
 =?iso-8859-1?Q?buNfsNNSqFTmH+0eq/ckpdvg8C8t3nxaAxs7ZOsGRxTdI/8SBlc112ATXK?=
 =?iso-8859-1?Q?Y8ddyRWmpsP5cIq93ySOzSIW4SMbazIefKLqOMYn8VKDF/lpQfWvPtjUMI?=
 =?iso-8859-1?Q?S8tzR5F8voYUtAnyxIuVopP4tyifT1relubFZ0Bj5+LuLKjsj2M3fztIfb?=
 =?iso-8859-1?Q?71MPXLyrpXVE3rdb6fL6u6vWavZxgpvqoGF+tH8AniBeIAAUmkCV3+SBl6?=
 =?iso-8859-1?Q?Xk5jEIGQdyZzzL5H6hsj8I3x+7RUECQRnITQW2bP63aMDGkuF6qCJMle5k?=
 =?iso-8859-1?Q?dB9uczPvya0TXXOz4+RHYuw9wBBZzxDCffqaedEb7b+b0ZkFwROnkVFvwX?=
 =?iso-8859-1?Q?ep88Sww9KKaqo8+NU9YbcBkgwz4LC/7VYEb1C4Cap+1QL//TaQiSw27L0k?=
 =?iso-8859-1?Q?3y6jeWt8V6YdqXjNxfrycznFZ/gR6kKMyEb7+zG043t4+8pOKkZw/zZ3yT?=
 =?iso-8859-1?Q?27CXBStf37DnWT9c/jdizLgaBHR4/bv5Ui8mXP7ATjdFsxmdc2m3RHslri?=
 =?iso-8859-1?Q?XRk3t/k5WjkC6gjicCRbkBxLcTADN4jUcJ0HUv30N9ISiTeIKjl37ZDFCn?=
 =?iso-8859-1?Q?zUdngMjlTqwdC6XHhY4sTPkPiZnwC0/+jsZOnrbq1thqfZbzwKxOvWXsCO?=
 =?iso-8859-1?Q?2nlC96ohq4ehFSy/8A0uEVxJa9DCcAlUdouBt7kEa7J0MtKSe2IKuVfG3H?=
 =?iso-8859-1?Q?7AR2HF82QInav/nZD0otzNykHl+isa3Jq4gWEmDPBF+HjF5UHg4Eg0ikkD?=
 =?iso-8859-1?Q?vEWS0KjcWv/lMBpntvtUP3X1y2hutwYpwJX7g0sAwEJwV3Ss1Uap5Y0Ado?=
 =?iso-8859-1?Q?eQQV+MJ25789n2F4Vps2R6rXl0NDNilKbbY/HBIfqAwcZrntr9qOvrWNzD?=
 =?iso-8859-1?Q?/t4pif7V5+6hJnNzYoZcxvjB1H+9njwDR1YsxN4wNcLfD+nCnrb2SyljBG?=
 =?iso-8859-1?Q?YUf07LiMDtMkbdQzBjdILSaP3bOekmUozs7q3wpAA+nMsKpMSyaeSIVat2?=
 =?iso-8859-1?Q?3no1RkTRif7cX41gDJW6jACkgCI5xHTQ/7kGEkHQxtm1BPXQ0CmTB2/nR3?=
 =?iso-8859-1?Q?R8KlNofY8Ajc91aCAtWothkiOEEfsm/z0QSWCLLaAKSTVzhyEfr1QETzPh?=
 =?iso-8859-1?Q?waOABFYKa/mN/htrswYd1maIyfutIWv1BACOZmAh65huxbGvppt3vnx9AQ?=
 =?iso-8859-1?Q?yImDXFJaNNb0K38fGZl4d1LP+f3Jl+DqJ0lMqqxloSWt08p1tzrnuB6Qyn?=
 =?iso-8859-1?Q?ht7Sn/e50crRZoksFcA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DED35F4CE3B0314188256C0D6EFA42CA@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c528ef3e-08e8-43f2-7f56-08dbefd6f2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 05:57:47.7978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZCTNyNB0XWFMEikLTjCLI7c/tlvSQX32mxyIelNRcOyqsj0Si1ebPJeA5Rju++RfhR5T5cFPPMNBUEvuU1qsmyQyS/SMQza3NMUGdFpHdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10069
X-Proofpoint-GUID: HwCjVbTpBVTlxE_z7xPEoIpQlG-LNiX-
X-Proofpoint-ORIG-GUID: HwCjVbTpBVTlxE_z7xPEoIpQlG-LNiX-
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



> On Nov 23, 2023, at 12:54 AM, Li Feng <fengli@smartx.com> wrote:
>=20
> Keep it the same to vhost-user-blk.
> At the same time, fix the vhost_reset_device.
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
> hw/scsi/vhost-user-scsi.c | 16 ++++++++++++++++
> hw/virtio/virtio.c        |  2 +-
> 2 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 2060f9f94b..780f10559d 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -360,6 +360,20 @@ static Property vhost_user_scsi_properties[] =3D {
>     DEFINE_PROP_END_OF_LIST(),
> };
>=20
> +static void vhost_user_scsi_reset(VirtIODevice *vdev)
> +{
> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +
> +    vhost_dev_free_inflight(vsc->inflight);
> +}
> +
> +static struct vhost_dev *vhost_user_scsi_get_vhost(VirtIODevice *vdev)
> +{
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(vdev);
> +    return &vsc->dev;
> +}
> +
> static const VMStateDescription vmstate_vhost_scsi =3D {
>     .name =3D "virtio-scsi",
>     .minimum_version_id =3D 1,
> @@ -385,6 +399,8 @@ static void vhost_user_scsi_class_init(ObjectClass *k=
lass, void *data)
>     vdc->set_config =3D vhost_scsi_common_set_config;
>     vdc->set_status =3D vhost_user_scsi_set_status;
>     fwc->get_dev_path =3D vhost_scsi_common_get_fw_dev_path;
> +    vdc->reset =3D vhost_user_scsi_reset;
> +    vdc->get_vhost =3D vhost_user_scsi_get_vhost;
> }
>=20
> static void vhost_user_scsi_instance_init(Object *obj)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 4259fefeb6..d0a640af63 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2137,7 +2137,7 @@ void virtio_reset(void *opaque)
>         vdev->device_endian =3D virtio_default_endian();
>     }
>=20
> -    if (vdev->vhost_started) {
> +    if (vdev->vhost_started && k->get_vhost) {
>         vhost_reset_device(k->get_vhost(vdev));
>     }
>=20
> --=20
> 2.42.0
>=20


