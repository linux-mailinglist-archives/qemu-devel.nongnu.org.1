Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48F7B1103
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 05:02:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlhHK-0005CV-MS; Wed, 27 Sep 2023 23:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qlhHI-0005Bp-8m
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 23:01:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qlhHE-0004if-QT
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 23:01:23 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38S2i44q031272; Wed, 27 Sep 2023 20:01:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=yXQeLAXxU7GNUAF2BO23emVRif28VQ6iiew0dg
 GCfB4=; b=FytcYvLuVI7Cjowz+Mv/WP9C1SMFL3w965wh0KTABKe4qS9hkFAqcr
 P9mmbEXLh2arF58fJEIBIatNybvTP8SvYCL0SEHr48QmFoJ6iSPq8Z8/I6k08Hh+
 a6420581kryjZ6ixoN4eVpSY+TjdCF3+pCNOI/B621FrmYdvgQsZaomQoohH2yA/
 jWofx5142P0aJH6KOl+AsEUQJI2XjBQysknXQeC77Sz1rUSZvssT+5qaOdUInmIn
 QiHAOIHLLPVl7nree5ZHbYsix3j5SqZdhSPSwYLkbpvG/7BNEPXSUvItP8HeXBWt
 IQtZBfSHsY9XFWIueuhVgBk7uBVMvyTg==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3t9ux5gwfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 20:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKn+PsubyUXbd5PJv77gDcAkWjvg3O68bo5qLW2qebNWaqdLGySCKH8JChZ3r3BA/k/JDujkX3a3LCf/xks6uAGtLRd/I2FX6+Jr+uaLzkGwqyHJx+tV4PxTcpIuQy+khSbOTpjph/sx/Fgv1E64cEKpE13Zdxcc9YarRNUeQaOY1HIFeJ5QiBShPz7iFjv+GNan0A6VsHNzyeHZECn06hrqxLcuZKykN41vlS04Fp6oGRAq5+/k8VfZQZPsHGTHVqZRNI5WOtcNSJ29GoiHUWJyi0JhxDAQ8L/MagbebJnOm0v88K2s0+Wbk97DRm+jGXq1R9SU4/HlLRMf+jy5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXQeLAXxU7GNUAF2BO23emVRif28VQ6iiew0dgGCfB4=;
 b=k/yxnqVd1U+npR+eoNP2dcrZnZTUP9Ff/F4o49LiCwhJfxIUd8UAWrxV0RS9waWrO4ZVaEBhQaU+qblaQ0ggRw4wbNdni2kkq5W46kTDIvTQ9Yi+/99YBAFUMRYx+IV/XMXT2vAQf/t8+LKZF2K1GoXG/0UI6vHdVHoDZ27RLm/+JfiL/hqfAlPzf+aGF/vRPCE5+tJhUVWDc8oD8+yhLr0TVAV65S6jYKiZ37ieQ4+lLY7EgqZTCY7hC4WWOwMEFSm2G4K9mL5/Ta+bjqFfJU4yWg9dXtjOGk9fJAWD3UXtylUSOt8BUMR7qCqe3xOxWGImDLCTQCHq3torCvKajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXQeLAXxU7GNUAF2BO23emVRif28VQ6iiew0dgGCfB4=;
 b=dDXkjLc6S1hsdeauoLXmmE8Nd//P2JlJIfNaQMgTmqYZEJNw/3rS1l2HIdNW1XqGQ4b127ZcFcAL5RAUQhyBPUPzlZjSz46JB3UNn0k6AvF5Uty326gv4rLAUUFutD6m54juYMUtE/+ox8FwQLUlDcTcuaZI32U5XLkBbJ+Dfv5OUMEB1XupuV9lvOgI2EVdRsAqsSEPH3ZbftLD1iJJtTTsGtSmPrhmtDJRKbBGWSg8lklaCdlMhemOYnP3z+ld79d7sWuVxGzXH1/j2XWW12F8AsZwr/s5eVPPwzn04lOoxDDerkl6AFZWOJPNRpGKp1g6NoylyRYVjvvmOrfONA==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO1PR02MB8393.namprd02.prod.outlook.com (2603:10b6:303:151::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.33; Thu, 28 Sep
 2023 03:01:10 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d%6]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 03:01:10 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: "open list:All patches CC here" <qemu-devel@nongnu.org>, Hanna Reitz
 <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] vhost-backend: remove vhost_kernel_reset_device()
Thread-Topic: [PATCH 2/3] vhost-backend: remove vhost_kernel_reset_device()
Thread-Index: AQHZ8Xi146aXnY66LES3UWVcnXR1HbAvjR6A
Date: Thu, 28 Sep 2023 03:01:10 +0000
Message-ID: <053B6029-050B-41B7-8718-2DC624211C45@nutanix.com>
References: <20230927192737.528280-1-stefanha@redhat.com>
 <20230927192737.528280-3-stefanha@redhat.com>
In-Reply-To: <20230927192737.528280-3-stefanha@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO1PR02MB8393:EE_
x-ms-office365-filtering-correlation-id: c8897884-81c2-4ac4-0021-08dbbfcf2ae2
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A8qaZ7y4sYj5UyWd2a9OMhRYK5leLyAJuFxOwT4tH+VKq3vkCaUpi5F5e5MYjBVFs17tSCj8zsRYZWokD2yYLgOcQ8OEQs7ogq05vtthJIJzAzhY98qMCNZEg6fvynMmAonkAWcA1A9NA4KX+wYzAsWDt6w2dSdrj/iyYUevuKfbjqTh8jwk2lolgcIeFF8xztUfFx14t5tv5EUsJl6u5qm1FCLUG7yL0LfOB/m+CDRisQ7C/6zn8eJp2sFiPdb9QmdkqAUx63Fuztl0CbojYSCkCXQVSlsoTofsE2Yl6vmmjcAbhI6Q+I95yy0RJGxOpNYJPEZfRpN9rGsjJH9olBLNzY/PXouaVAkMd1p166gQS0XJi0zHLrFKhc7EXV/tXRRYvddn8O/bQRsy/VlA/FsJcjN77j+LWsd0Hz9Lt3SBl6WrpwG7mXETmNLMo09osrD7tB4dvbVXxCkxRFr0kH3e9D0SdDVXlRAUK7ZJG4VFNDVfSgGRJDtQW2ddJlK5pxqsHtGPyz93JrsQvud0bxmmj3XXkByfeidyMPLACwP8vvf2dLvmzr26U+YRrJTe4A3vq08EXFzpf1GtVDpp47rvHqTv1ehN/hudGjqJtXlvLrea3dWfjKcZCe5JmtpepVCH2n97F3Lbys8H13n5Qg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2906002)(6512007)(6506007)(6486002)(64756008)(2616005)(38070700005)(38100700002)(5660300002)(66556008)(66476007)(66446008)(76116006)(86362001)(71200400001)(91956017)(478600001)(6916009)(83380400001)(54906003)(122000001)(4326008)(33656002)(36756003)(44832011)(66946007)(41300700001)(316002)(8936002)(8676002)(53546011)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9LiN8mxNtZE1uNawVtKtefJoO4wNXev3inQOxijs4oPs4K4EC5ukx/tROyG6?=
 =?us-ascii?Q?/iMq4z0aKPwvp1Yi+aTfvZEMUM/dXVHFS6+TitfcDppKfKd/U20t9ii5fxml?=
 =?us-ascii?Q?djnFBmAyp0NYpAtGJqqjz/kDogfZZNhFv4+b9+L5GzLofNZK/MAWyDoz1hDu?=
 =?us-ascii?Q?G17k6qzDLICiUhfq/1akiZieWG8Oumb3v/BlaXFSaMY7ffEiz4ai8gL52PjU?=
 =?us-ascii?Q?C/AgNkzeE3to+p6wV7qkx2mpaM5oYShf6rGXhjmZeP4HagfqwMn62RgYYq/W?=
 =?us-ascii?Q?ibke6gzmYpv3D0DKYafrxNPLZ0CD7NvsDr+x7XhRDxcmVKgRujIlwmjKWH5U?=
 =?us-ascii?Q?QJMlD2vCfUFy0JJUjbPpTtd87HPZvBtp2K2dUH33uoqWZvKJ+SuwyZLpGMmF?=
 =?us-ascii?Q?45ch00z2fQkcSpOJ0Ai6d2a3mJ/nzOLjwnUylJbOYNVhKuUMiQEqv55YgPvF?=
 =?us-ascii?Q?/UYqrjTD8bFhw+0JvedTNVIT2jgzdBfmqm7NLfApc16TStYFjbaUsaY89ELA?=
 =?us-ascii?Q?nGLaQVBGMm5iTMpOCcNbN9z76VIxztDGIEWYWyBO56F7mcliMU5vBwzmS4sI?=
 =?us-ascii?Q?JibYwiwUMA27KajPaogaPkDJhY29sXvg+shSYWulNi0HC8me3wcWzNBfOOHL?=
 =?us-ascii?Q?TLG3ocmlIE5Sox6/9TeblRV7GykzzwsHKyp29P2VQmHjevnW/m21/c3XOsie?=
 =?us-ascii?Q?WYtI42Vx49ID622KAgq+Wzt7xN+T8UKbo6ltSv65BEqmJxUSll2iMIrTbf5R?=
 =?us-ascii?Q?v9ql7+hOm1bbwZ0VvjpwSHV8BmDXI0JkKCVLHgCwydD6dWgBAEnEG4PmHMQo?=
 =?us-ascii?Q?t9ewogJRBsP/UAtTsAs9KAZHUxq82obvAFVBKdaRGNfWeQGCwh1svbdiMFlH?=
 =?us-ascii?Q?okWYNMUtbO57ms5/+TIAxb++Lej4A+AnABSNQpMOesrwNXVy2YZGKvWuF2ji?=
 =?us-ascii?Q?bSVWbrRqSSnmkorzB1OdzFUxuYF6eO2zpg8H64L7PGHCtNB/3w9a9FfQ6Hzu?=
 =?us-ascii?Q?3u0FP+Oyaar/2s1clUolTMK5jggOjQDFbrD8blgY9L3n20xlwTjJdLJpCHHc?=
 =?us-ascii?Q?3OI0oxSAdZxQNV9gtqFRPYvQ7Db3yGs07E20hZyPO1sqCh67SvUziVjzT4mx?=
 =?us-ascii?Q?crVH35Kh+uG1mE17PRYj/3uLdN8bYfCLp36umRRXYsiXfa13euqiS9nbkgQS?=
 =?us-ascii?Q?gS6kcndG0bZG/A9pxlXlU97Wt3TKpK96BJDYkSKhI/uoR9qs/VXgxDfrcbzR?=
 =?us-ascii?Q?FmP6khL272DtfblHZffd5bc9HYT4OJxmuBlp9fm1SfKl3wfDCexZYlYBoo1t?=
 =?us-ascii?Q?owZ/OkpyhI5oomiB4GS6jhm0HfFdDpHasgeAgYyBByN1+GRaja4KdB7y7bVk?=
 =?us-ascii?Q?Icsa7d5PKaIwKkBCA6KijFZTy8Vy3lD0+aAZg0o05/g6v3MghLzXIRtqkw+o?=
 =?us-ascii?Q?b8XBW2gTXH8cx/2EiQ8sYDGyKQ4SIRsRtBS+dJQjUZEa24/2vq3aHlZf4tBG?=
 =?us-ascii?Q?Pe3xgeBJQD12SgWo4Y8maVm/1CvkmK2+2RTRnOlaOMzfu1qPYYi6mwnMX46i?=
 =?us-ascii?Q?c4EKRykMNuZTgvCWWvvV93qKpFxpH1c8PccLuI7RYetl5i1bBofO0oS3Fk6K?=
 =?us-ascii?Q?qSJcKuzcIzVbKiZ9YHtdSw6fTWkNgE7JBe/kDZKPACr10qzQgpJLm0CnTHrB?=
 =?us-ascii?Q?Efs1OX9vb4+uQP+8y75CklUYoeI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB33C164541B1A44B767026BA0EE390D@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8897884-81c2-4ac4-0021-08dbbfcf2ae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 03:01:10.1187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vv/YgbhdopXrqC2xP3oDiIjc3FFUhsz/xjYgNt2TrKWcv66LmU2oQrjBcpvgQmoz5wT4pEkThZBr2/mV+PsBs0eQEDIku77C6x8bCiijVb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8393
X-Proofpoint-GUID: Ygf_zYeMWaJGKFHfYeZdYck3o01JK0yL
X-Proofpoint-ORIG-GUID: Ygf_zYeMWaJGKFHfYeZdYck3o01JK0yL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
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



> On Sep 27, 2023, at 3:27 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> vhost_kernel_reset_device() invokes RESET_OWNER, which disassociates the
> owner process from the device. The device is left non-operational since
> SET_OWNER is only called once during startup in vhost_dev_init().
>=20
> vhost_kernel_reset_device() is never called so this latent bug never
> appears. Get rid of vhost_kernel_reset_device() for now. If someone
> needs it in the future they'll need to implement it correctly.
>=20

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> hw/virtio/vhost-backend.c | 6 ------
> 1 file changed, 6 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 8e581575c9..17f3fc6a08 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -197,11 +197,6 @@ static int vhost_kernel_set_owner(struct vhost_dev *=
dev)
>     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
> }
>=20
> -static int vhost_kernel_reset_device(struct vhost_dev *dev)
> -{
> -    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
> -}
> -
> static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
> {
>     assert(idx >=3D dev->vq_index && idx < dev->vq_index + dev->nvqs);
> @@ -322,7 +317,6 @@ const VhostOps kernel_ops =3D {
>         .vhost_get_features =3D vhost_kernel_get_features,
>         .vhost_set_backend_cap =3D vhost_kernel_set_backend_cap,
>         .vhost_set_owner =3D vhost_kernel_set_owner,
> -        .vhost_reset_device =3D vhost_kernel_reset_device,
>         .vhost_get_vq_index =3D vhost_kernel_get_vq_index,
>         .vhost_vsock_set_guest_cid =3D vhost_kernel_vsock_set_guest_cid,
>         .vhost_vsock_set_running =3D vhost_kernel_vsock_set_running,
> --=20
> 2.41.0
>=20


