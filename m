Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6CA7B768E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 04:09:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnrIe-0001Cs-9y; Tue, 03 Oct 2023 22:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qnrIb-0001C3-JC
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 22:07:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qnrIZ-0003uX-Gz
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 22:07:41 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3940BfTC001460; Tue, 3 Oct 2023 19:07:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=LoPY9opI78qP3PJhmfVR+xU4cDFptK74sVii+q
 4XDrI=; b=vgK9DeNeVxTzP2NMnPpf4ERBTZuK6Jhh10AfjZ50k4VgWDOY+qlcor
 6t4AS5tstbktA/Zzg/gIit1r19kjXyIXhjInMFwTT90w5IvBsYba/NL3yLF/j+8f
 84GKvm9OtU0LXM1JZYRI6GKUGE1WNOLAb4mCgGtDC9zBQV/spg09f+ut9QoOa53S
 RY7EZ4ce+cCfGn0pYDPHITzXckd/oNWWqzpQqsTtunk8q2po4vJSf8oGLG485c/y
 zCUq9z6IskFPL3JvmLnmRH8KHj0d2tcO8b3j1picAFKjX1YaLjlawmSzZPypSA4u
 CmS5mfvLTqqzkfDTxP9sW7P5mHxNkSYQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3teh76ygm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 19:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0ZR9HkSMRENHBnukT8BtFg04NeXp+MUrqFiRJUpByP7kIpnSCfrlqS1zmfhvrZDF164Gx9NJCCaccgZdflJ+4a7PsviZneqGqdVELUzRtCHlDqwFBS0VQvydcJnYLvCF6BSvUYjlEeaMj6huV+3EGtVu7yCjYwNRk9kPDMG9VVAGJ02gU93y5FR30hMWRsl3pf6Xrme3L9D19UHUwsVlNGUYoIBYOBQSTP6T8WuR8o2vO9ZH1vRU+klHqs2jncEW8zN0PK8TwvdnzcAO0qxEU/pG72s3gyna1H+eEbWY5Kmd4F9ezBgHnWz/GLFqpJnjVsPAlFfDYhYp8k2L56WeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoPY9opI78qP3PJhmfVR+xU4cDFptK74sVii+q4XDrI=;
 b=HNXihYQehYkTrB9iaI+ULAbGVVpjx2kkk/DFGaYY8UWfhDoOi0JX68/0BSd6Z/7i+/s2/rSGkcaxWePOUsDsCTPJjXBPZLaR21W61SvnmKFWRTvkuJLBG5xVBZJTI/tRVnxpukp5A4dIFYKjecKb1rbfLcQ0lYOtNXhlRCNTricwcgqH9wT9V4ya329wp9tuPzzJ2NUlfLlMi66bnHv0nBFp7SrpCoX5PoksSN4zF46orLn1RpHRAFURzKPy2i3tADlc6LooZhLhSO0uoHfb5TXTLWWXfoqapAMHkUycFM56bhm0BuCCMvq1a/tPAxrXall64HwFCPPPRjEnTrG/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoPY9opI78qP3PJhmfVR+xU4cDFptK74sVii+q4XDrI=;
 b=M2qypXg0QzuXFq9DLq6EF74SDBy5l5qJsmUgDt8y95qxoqQK+CgCLq3oupM8ZVc+V08yn8MruFgUovdrxObInWkvETn0e7VrwjTCXpUvMlXMwp8f6YKLRTZDyqfRelKbZ+rFHelr7HW630ula1eFhfymJ1RsKMNnUoT31yjaovr6EN+XCX0Vonm/6kGVWi/OUH0W1DeSh3xx6KLxJhNpfldmn7dx+VNJn/XIeRBn9slu/XJGblni5EiCnnWJy47klLpJpFTKfWVjtvMtSXEEoLbEdxW3GbtWQQYkVewVkbDWCcT8UrT74lphdbjHAhRFLZIJR72HIIHPbbqW5ctSsg==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO6PR02MB7764.namprd02.prod.outlook.com (2603:10b6:303:a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Wed, 4 Oct
 2023 02:07:13 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d%7]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 02:07:13 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: "open list:All patches CC here" <qemu-devel@nongnu.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng
 <fam@euphon.net>, "hreitz@redhat.com" <hreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, Thomas
 Huth <thuth@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "eperezma@redhat.com" <eperezma@redhat.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/3] vhost: clean up device reset
Thread-Topic: [PATCH v2 0/3] vhost: clean up device reset
Thread-Index: AQHZ9mSAxrz9o3gWvkOZO0L7iEzGK7A44jAA
Date: Wed, 4 Oct 2023 02:07:13 +0000
Message-ID: <FA365206-3115-46BE-BC31-83DB8F56AC2E@nutanix.com>
References: <20231004014532.1228637-1-stefanha@redhat.com>
In-Reply-To: <20231004014532.1228637-1-stefanha@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO6PR02MB7764:EE_
x-ms-office365-filtering-correlation-id: b3e9a047-bdfa-43f7-df4f-08dbc47ea046
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mnKhpEKsEBrkWMH9aIXKeqmSW7cOnns+j7aSVWbD8+VIC0PMlaJ7114aMU2wgLgpa68G7CHpAoeGUVYqbH7wChfCh9h/uNSxcvWgbVW6auWMQ0Zfc490W1IkfM2hC1a//ZSmI2Sbcxbdvi+AxoLaFWf8YaGtSevIgYLfwEzWoO34kI9c93knDOHvq1cEEnrY+E/YfgPwtffkOP/pvg4lnBphT9hMa+nnAC2deBd37bY898GXSsdiv45BA2xInIVILwdDSkrcQ71+xAJMlZg5yHxqX0OFkXoGKy3MFEfkmI6YWrFrU8sc5zQ62OFZmrJju3onKClQOuWY3h3qRrW+ESkM1x0PgCslfTz4eGYPHqq1AoyTT3j5CkJgKskwuhNU/7QRvHmdIfuY8oyNKhO+lqz1wN3QklaA7xGsdu58G2MHs6ywVUA7l+t3jM64KNbuleiw9gqtAAfadwMHZmUltrHFl2U+V8dHSQ+uOj6Z4jef7S02px7Kb9n1QNGkFw1jQVbqBIi3gvk7SsrfcJuYhbqiRlwz9s3phS9M2ESqzd1nut6Mtw3Y3zCpm5sYLsOnzFuvhsEPuxFypxRu03iXs5B4pgOZouheLu2iFUais6Mi3ezq2WJ1AMSNq9I6hQXV63rycc9+X8gAAP8gj5JdSA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(91956017)(8676002)(76116006)(41300700001)(4326008)(66946007)(66556008)(66476007)(44832011)(66446008)(478600001)(8936002)(6506007)(7416002)(2616005)(54906003)(53546011)(26005)(6486002)(64756008)(83380400001)(2906002)(6512007)(5660300002)(122000001)(6916009)(38070700005)(38100700002)(33656002)(86362001)(316002)(36756003)(71200400001)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3p+mHBF28iG/M5gGjd2P0AsSt8wNgdnWenFUbMzxX/lbms0ULv1qPQ2TTl?=
 =?iso-8859-1?Q?8qhzfKrn9VedPaN/CJVEQpBdzahzE35f62JWatrIEqDSL2HDoaoqFKorUL?=
 =?iso-8859-1?Q?/vJUK9NUlSN2AydIMZ+HoO8M1apgzNi9zm7D5WOyoRMed8C0PjNrkF+/Ce?=
 =?iso-8859-1?Q?NfexygAGNMWdvmaoEPe+v8zNkYgF8XDVvycElia0Iwy4Q746Rm7gGA1PXj?=
 =?iso-8859-1?Q?hFEsi8j6IsC8qW/9hBjiubawszLgptcjsBlwBrNJkp7OzHjfa+KRV4TTt5?=
 =?iso-8859-1?Q?+5xakw9VcBiY7iuT2rjZhaNUe4G5X7ZUI8yqu5o0q/8S6pvHwjY+xKUlbu?=
 =?iso-8859-1?Q?LaZXqbUVMSA+uDGIABMuD8oCmweyiVeJsDjo4Vvu3LNTuyEmA1eU24RwkA?=
 =?iso-8859-1?Q?kOAFNYMLTCqJBDSC1wm6M5Ez6NjJC0I0BOsUg6M2r04GFYskJPNZb8da0d?=
 =?iso-8859-1?Q?14w7Z0PGRPFOqjfplnF8/hTa2rewcJtuSqPG+WiRgvIAnLSpgS7XS7KQyF?=
 =?iso-8859-1?Q?9D34ad3jm7zF3L83kn9YDHkQEJQIKwQKlBdk4lfeE2DoahTpBtQAIq0/re?=
 =?iso-8859-1?Q?8wUY6tjkYcv2l08W9IUUtb7EXEZe+cnsJp0ZnMthSZmxKyPzQXHYvh8Glc?=
 =?iso-8859-1?Q?RIfkR6xD0ELcsJ9o78xLGU5yWuhGkWCRXuycFX1opAYQNkfIpbaCNEsWrR?=
 =?iso-8859-1?Q?UKxZQ9TVrrxuZrC4MbTewl8F0Y1j9OjCU7d0iNWe6rmseokQJGv2CWy6rw?=
 =?iso-8859-1?Q?BpnSI6CjvqmuW9SfM035pBaCe86kao8Mw9tlBwmcu8uEABs9Mv9RNC61/h?=
 =?iso-8859-1?Q?tJK3grUoGG1POCLZMGaoBnaSF2CwLTIhhO/loiWV+uKu48GsJM8FAAIVdU?=
 =?iso-8859-1?Q?tTqpy8683DuqSg8vacFWSaUSeahwGC4FGlni3WsPz4MRQUWDlGYE8Wya+k?=
 =?iso-8859-1?Q?9Z5x5YWZWYz/ELFZh8rvb1cEDMUzcD1HZ7EoIYaC5/zlJsxoyxK8YxkGcV?=
 =?iso-8859-1?Q?cc9z1fNitGUiJKtyalGRu1qaTY7ogLBK3HwJnHryzk+y63fjenQ8AztCkA?=
 =?iso-8859-1?Q?tYEorPIiBKLkdY3Ev7h7agopw5v7UzSyeCTDI5eO3zcO/aKznDZEQHj360?=
 =?iso-8859-1?Q?WBYd5/YV6PjbmONzsuG4CkiN1ypMcqpu9QNzkVNbvyKJITffSucFI7LSah?=
 =?iso-8859-1?Q?a0u8H5mXHlp1xf1iUXfRTSNn8kRdZ4lzEww6Z8qO6EL2sTiEbi2QnOwgN1?=
 =?iso-8859-1?Q?UeojkU7hMzI4pN3O6z9jXCb9W0ZjMbaYGJRnT0xUw22f28629NAUQFbOU2?=
 =?iso-8859-1?Q?He3KwBpUmgrA+9AYXmVnTwQsbY9Ec1431GpKntut8oYlFPEvli5LBT2bCY?=
 =?iso-8859-1?Q?DNnrT3zw29zqp8anamtIwPnMlRtHRuKk0hY0wHNOSki2gHwafRwbz5Z8/f?=
 =?iso-8859-1?Q?k9/qgje/zt9Yqv0hTQVAe5igrRZR6AZI1Dd2QhPjoyW50uua6V3u5BI4MY?=
 =?iso-8859-1?Q?6xXyJiWnP6DynJA5Xz07Dk5qJhmvNF+5MksCIGnXPS7O83TaNWW7+fiAhi?=
 =?iso-8859-1?Q?QNxN9CAkM+XraHFzOZ7ZYwgyJxNIaEDQUbjm1BD8OvkHN2ReNvO6ogTu3+?=
 =?iso-8859-1?Q?6C2by9/qW7/JVjG6gaQJZt6AFgQ7xn+8CVXfcema3/Zt2I1GN4CYAiQg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D0696E083D33474FBC7FA0387E2245C7@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e9a047-bdfa-43f7-df4f-08dbc47ea046
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 02:07:13.6417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4/Fx8cAEuhby1ViV1n84VRKFVIqIc9x3kCbaanxdA22FctcKQOUW/Jwj4QQpwR/VKyJuDhl6aInSEKecSu0xc8sg18uri0OvDjO0XLjW4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7764
X-Proofpoint-ORIG-GUID: b7dVAuZkI_ARmLNBBIlMobig_GgfA3dW
X-Proofpoint-GUID: b7dVAuZkI_ARmLNBBIlMobig_GgfA3dW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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



> On Oct 3, 2023, at 9:45 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> v2:
> - Fix compilation error when vhost is not built [Michael]
>=20
> Stateful vhost devices may need to free resources or clear device state u=
pon
> device reset. The vhost-user protocol has a VHOST_USER_RESET_DEVICE messa=
ge for
> this and vDPA has SET_STATUS 0, but only QEMU's vhost-user-scsi device ac=
tually
> implements this today.
>=20
> This patch series performs device reset across all device types. When
> virtio_reset() is called, the associated vhost_dev's ->vhost_reset_device=
() is
> called. vhost-user-scsi's one-off implementation is obsoleted and removed=
.
>=20
> This patch affects behavior as follows:
> - vhost-kernel: no change in behavior. No ioctl calls are made.
> - vhost-user: back-ends that negotiate
>  VHOST_USER_PROTOCOL_F_RESET_DEVICE now receive a
>  VHOST_USER_DEVICE_RESET message upon device reset. Otherwise there is
>  no change in behavior. DPDK, SPDK, libvhost-user, and the
>  vhost-user-backend crate do not negotiate
>  VHOST_USER_PROTOCOL_F_RESET_DEVICE automatically.
> - vhost-vdpa: an extra SET_STATUS 0 call is made during device reset.
>=20
> I have tested this series with vhost-net (kernel), vhost-user-blk, and
> vhost-user-fs (both Rust and legacy C).
>=20
> Stefan Hajnoczi (3):
>  vhost-user: do not send RESET_OWNER on device reset
>  vhost-backend: remove vhost_kernel_reset_device()
>  virtio: call ->vhost_reset_device() during reset

For the series:

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

>=20
> meson.build               |  1 +
> include/hw/virtio/vhost.h | 10 ++++++++++
> hw/scsi/vhost-user-scsi.c | 20 --------------------
> hw/virtio/vhost-backend.c |  6 ------
> hw/virtio/vhost-user.c    | 13 +++++++++----
> hw/virtio/vhost.c         |  9 +++++++++
> hw/virtio/virtio.c        |  4 ++++
> 7 files changed, 33 insertions(+), 30 deletions(-)
>=20
> --=20
> 2.41.0
>=20


