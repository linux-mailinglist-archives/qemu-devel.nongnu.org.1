Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E097B1104
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 05:02:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlhHK-0005CG-71; Wed, 27 Sep 2023 23:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qlhHH-0005Bg-A2
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 23:01:23 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qlhHE-0004iN-P0
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 23:01:23 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38RNf8vL000720; Wed, 27 Sep 2023 20:01:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=wYiQJy8vJo51elntt34zpAB36c4775DzaYhhTo
 mLRNU=; b=NWBKdhffCZCbRyScLJULKI3R21zPQdwqLNqfTn7rxu8yrFVm7in8zX
 tM6wQ0iPTqXjbcJOUiLg3HipNP2pkHdZ+iwKOt7rKn5xBqJYKTKmUZ2kWRb6LuhX
 NQfqiWt79A4PA07TudigXtGZetgYxFd+LQBJ/eYx2G5RbZgnhpa9RUkGoFspV78g
 q0Y+6PmmZr9pWeabFRH6BjOY7XiJvZvu9fJDCtyEVtcv/sEQz12O3njO+fb5ryv4
 HhAXZh+nTb5EKX2tUcHmioSN4AL4AhC9VK6DmOVmqkrkWnSjumpV3LdViS2UlyK1
 +AwcUwmjN6gGFm1QVJrix9Y6Xe4ctGWw==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3t9vbr0tsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 20:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEq+WtowuVq18cZHnzZkHiWRx/14Bo//4NJE8RC0oemoHkzZqMK3RoevmQwDOjIbCK64D/GoC9LDPs38UUMsxV7PmkRpqEMOyuvoUAakP/eGW3L0fuZdqHuwl7PYQO1pXS5id3qype8GxEsJV2RZISfpJ7/SkLCpxQIF53HvkvWkyr7u86zkNbNcGjMoUu0fVBueGtp5LrKJ2vXD9gortCNDqZP8jijHkFFA1Q1Qnoa86Y0FD3eg85TrEK6HNiCCv/Z4jEtsQefB/aYG8T/l8EzdEuJ+CzX3NgOeduvYRZa1bWtRDWzAtyZqrETuyoqFe+2d2eQlC2UCtC5uPYIN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYiQJy8vJo51elntt34zpAB36c4775DzaYhhTomLRNU=;
 b=FueRGsk/1ppTtUx8eRtxTE36oMddoUMDdwGqFPZrBJKlZKAUEyLM3KG65AxqIe4nXk3rkC0J6VvTzjbtQdTh1uibfEFQmE1fQGvzHMeoBnvQC6vokmPyG+LwnT13jf3SuaD3DRrtO9iT4wa51OVVo0tDRANydYdKPXysbwtrj1mINrtyp+VyaaIb5mdelmKAj5xnAEXwNqkQ6oVQTe/43NlB6aR12G1OTr9Y147nTtbGPhiquFlFLnXEOYmK9T0WaFT8bXxaeBaFVn3LN9tx6j6JOAa3bLfmAPFoFjj6NiQpYAXUr1DxMNDfAHskzK4EWbbiHDdXyXOykXK76BnE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYiQJy8vJo51elntt34zpAB36c4775DzaYhhTomLRNU=;
 b=NW4IVBjzE4duf9QNfBIpO6n+wJ1WtIwcbtaoLjn+lWxCFZctgo0TvPh7bW7KUKNBbLp8O51XyWLXP4dpaUYqI48Qx9aSfejffV6CrIYvrqDS9Djb6/DsjENzw0XMbSrPgrDJ6JRyDLEUjgdHuu4dyw0lAwyE2/i2fNTN++nk1rfkVwSC1vjy3+XpE07U9DyFzRg9dsY3dOw9VzlzRtmKV/c2SRY/7G1oMTnTvryIWpAJoV34kD787DBBDF5Cxmxl49z3ngIwwDct/xyT886fbzsDX/TRfVtoExbg9xkpz8G8Wk6EXvoKkUNg0GvxRndY/rE5CukQ7wg9jPDyGLsqqA==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO1PR02MB8393.namprd02.prod.outlook.com (2603:10b6:303:151::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.33; Thu, 28 Sep
 2023 03:01:02 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d%6]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 03:01:01 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: "open list:All patches CC here" <qemu-devel@nongnu.org>, Hanna Reitz
 <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] vhost-user: do not send RESET_OWNER on device reset
Thread-Topic: [PATCH 1/3] vhost-user: do not send RESET_OWNER on device reset
Thread-Index: AQHZ8Xi1gtPdDL7kq06abC1E2V1OOLAvjRMA
Date: Thu, 28 Sep 2023 03:01:01 +0000
Message-ID: <A7731EA0-18F9-4712-AA06-C8474104F8F5@nutanix.com>
References: <20230927192737.528280-1-stefanha@redhat.com>
 <20230927192737.528280-2-stefanha@redhat.com>
In-Reply-To: <20230927192737.528280-2-stefanha@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO1PR02MB8393:EE_
x-ms-office365-filtering-correlation-id: 730750c1-674c-4799-3db7-08dbbfcf25d1
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LMSGInTGNA7bvMeEA4BW/p/+10XscZsQJpf2s8OG5vSY1iZm3y9QctDtYzZWN0AugxHAieAQppOc1GLbkcKIapjHUK1vc7YuQPRULwL+NjPfRgX5HbXcSiTDNyf441S7aSRYF5DgTb9qqCFn2gAWtwKiUydHF2wd8C7keUUEp6CvEMiXmCk3U6cFHfK6fDY8d4EOyE20unAnd5UT6ZydcIEYNlfaHbYumIcqjA1K4VMj044FVQ0RoJX0YX9GgHQqIdbQk8V0ni1/9OxNTbNNIOfqLPUggUy/f7jLpChV+HwcHWKy/vyJ54NlEaM8iCh8B0MJAHKhwdaoHrjsxwKmjhVUBOXfAiG7bjSWAy5E5gzBgmAkoOILVrsEm0zQgMl4F+/RM9or/k+sohP15hEVbgc/SleWrazInaUN8kDdFmqrGJOZDbu8ByL1mCq0mVlWDD+LOReuqYso3w03fpkZavM1ODhCjTawJLDzhK3xu+j45+RTaPA1gcfTki4cLaV2gXCIxteY4ZLlscBHuhbf7SJl/7zsG6jlHv1G/2ryYQTKS5Y/NVbAbToOAkCVuVkvOlwB5Ypskt67UNCIRiWNqgQ4k12fXxH11+iaKf90SRAYPpRuWcBg0xXrHNWvo7L11Kru6EC8lSj/DVi6IlUYgQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2906002)(6512007)(6506007)(6486002)(64756008)(2616005)(38070700005)(38100700002)(5660300002)(66556008)(66476007)(66446008)(76116006)(86362001)(71200400001)(91956017)(478600001)(6916009)(83380400001)(54906003)(122000001)(4326008)(33656002)(36756003)(44832011)(66946007)(41300700001)(316002)(8936002)(8676002)(53546011)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3TRZ1NrL1eLMkKfZyDd3eN1jffH8FAwEQp4mpw4DD2d9tUa3vk1pilqp3r+N?=
 =?us-ascii?Q?Y9wi9ztMBFIRbjav0mdlkhR4MiOOeXWwZGzkslHHsU5LzdFI2P1ftM58HRg3?=
 =?us-ascii?Q?S7VrJrsebh8uRfeLGvXLxYgHxUaJzmIVKElpplTt4YsUBc2Sj4UO8SUM6qzi?=
 =?us-ascii?Q?wfYcn/YYHLo9wpfWZYXDtji9l2aXdRnkn/hHwbTgEvif1ucVExZ2XESg+bP/?=
 =?us-ascii?Q?3TIK4BmhwGr0iCtMNwGOtOPMotR36l33uVBsAQuz6V9BblKtz+NCi682maCt?=
 =?us-ascii?Q?TPXDUNmW86WA0rLOeL/1NMsmI1BvrQPGoeEhieOHlMLZ8YGtIK0Byemj3iAO?=
 =?us-ascii?Q?XvBHkFH8ngt+Ly2IcOxAwUaHctoL+30dBLw4Gap9s5T2IOsTZVPmYV1NpstF?=
 =?us-ascii?Q?U9sEr60/Ba992//o+2e111YQ1loZ6keNTf7J5U3MtCtAB9hcvDwemc4SPi0G?=
 =?us-ascii?Q?RKDsvNHkRj8TWlACUA0JNvC8/Mrg3wHGLn+hxHkF4BCjJHA4/dEabcQbPCKC?=
 =?us-ascii?Q?XQrmULEyFC0c5Hze9b1bMF5KEDdoYxZEUXPce1X05fgLjIWOrxBbJp1ZD+nw?=
 =?us-ascii?Q?1P50zxslzXwRaZRENOu7D6lTuteSVSaYIz6UHHPHKXrpos0XBC0O/KcOYzHN?=
 =?us-ascii?Q?63oEDasPUp65h8YOeAI21CwpH5EUGTXkwepY7HMsTezaqs1uwg3VjbvJllSv?=
 =?us-ascii?Q?BZFedlYdZ74JMYe5yqsGIV8pyvWBTzUNmzSVUX+hNiWsZ0CbFGJpx6DMR/gM?=
 =?us-ascii?Q?hTQ1zWNKFXQCxzPVEXzAlcnhe39PG1bH62JQhrRbQFiMoYg8rvUswWI3hkF3?=
 =?us-ascii?Q?MJMh0tnftDIS5MiuSheGvLjy5t00Q4WpVS43kxfNzJGl6j2H1fAOcP4ackfx?=
 =?us-ascii?Q?at6D+ByqV/LeCbsj9o9T4Al4bI8k9GwNTd5qgQUvk1Iqx788yLnXqs1C29Cc?=
 =?us-ascii?Q?jOqFXsZKJP1JfKpcw6PRQaSh1JL11dixZy9cvvw2X63edk1rlF3VUp7MDvtw?=
 =?us-ascii?Q?TWBjhtKuoiRvirrTjT77SxvBAbv0yjs7O99i5+UuskwpLoyUaLp4WE+0u/on?=
 =?us-ascii?Q?jP4v6v1YM4SHqNj8BOMdmoYTuWUAxDic/jRxPjfhOPP2M4bu2fCRHr0ZCvDf?=
 =?us-ascii?Q?ABQBHPcKQEqh6PZ6jNysQdJOuxcAGNudcpGhPZc2RdS39QtOY503QY9KO/cF?=
 =?us-ascii?Q?OAnaek02rVw/6baAE4XfyyVoa0AgM7Kam2ThSWUml83K1Oh+2jnTQnxGkTUA?=
 =?us-ascii?Q?AT5jhkM7VBuTSyZvEJeUO81gbfkC6WBbeP9srEULfKdyHRvAC9Ya/HBc3NXp?=
 =?us-ascii?Q?DxrWCxJPQsGNzhZV7q24g9E0tTT2aBvCswbcVKXlj2+tD9Y0q75V4tWybgut?=
 =?us-ascii?Q?dBSzo4itIYI7KVKa8NWJTu0q2YS1kaSV5nb0TB4CNVdxPjZ6DkZSkAA/7R7c?=
 =?us-ascii?Q?8oe7ifANA8qXNgO6QoxnLTJzDIrWyqsa+TNlt4FSvgQZZ0D+Bh3mF+LJvlDt?=
 =?us-ascii?Q?cQucksAiLAjUAOyTHw+KsdPuvITvZzOCiAcuWtamhuRHprJ0/rT+DiRcwdbn?=
 =?us-ascii?Q?AR6pEgmlHdNmFEAZcARbrAX1KJIUmIgkGsCKDgapRyOaNU6uuHWv7d3NkvA+?=
 =?us-ascii?Q?V74xC8pUWrjDGGKRGF9JeChv8ziJHqShytjF6HVPX0D/zmNM0YqBwaVkOfyV?=
 =?us-ascii?Q?kldTxhp0z4hGmxpgMx+GfKH/O+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11F5B7322ED10D48850EE4E6154CCD76@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730750c1-674c-4799-3db7-08dbbfcf25d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 03:01:01.6151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /86qH8zUrjlVc8AcEvTbgJVUReyRQ7e3QH90Jt8otNR8UYiAikbWSYEWX758kkNY66nrp2OQRJdq9HYW/HCRmedDZLQZK2ChIZ5Y04kSfJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8393
X-Proofpoint-ORIG-GUID: CQH5OTRsXT9yK0x_uh0jLknkCu_I11kt
X-Proofpoint-GUID: CQH5OTRsXT9yK0x_uh0jLknkCu_I11kt
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
> The VHOST_USER_RESET_OWNER message is deprecated in the spec:
>=20
>   This is no longer used. Used to be sent to request disabling all
>   rings, but some back-ends interpreted it to also discard connection
>   state (this interpretation would lead to bugs).  It is recommended
>   that back-ends either ignore this message, or use it to disable all
>   rings.
>=20
> The only caller of vhost_user_reset_device() is vhost_user_scsi_reset().
> It checks that F_RESET_DEVICE was negotiated before calling it:
>=20
>  static void vhost_user_scsi_reset(VirtIODevice *vdev)
>  {
>      VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(vdev);
>      struct vhost_dev *dev =3D &vsc->dev;
>=20
>      /*
>       * Historically, reset was not implemented so only reset devices
>       * that are expecting it.
>       */
>      if (!virtio_has_feature(dev->protocol_features,
>                              VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
>          return;
>      }
>=20
>      if (dev->vhost_ops->vhost_reset_device) {
>          dev->vhost_ops->vhost_reset_device(dev);
>      }
>  }
>=20
> Therefore VHOST_USER_RESET_OWNER is actually never sent by
> vhost_user_reset_device(). Remove the dead code. This effectively moves
> the vhost-user protocol specific code from vhost-user-scsi.c into
> vhost-user.c where it belongs.

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> hw/scsi/vhost-user-scsi.c |  9 ---------
> hw/virtio/vhost-user.c    | 13 +++++++++----
> 2 files changed, 9 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index ee99b19e7a..8582b2e8ab 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -71,15 +71,6 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev)
>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(vdev);
>     struct vhost_dev *dev =3D &vsc->dev;
>=20
> -    /*
> -     * Historically, reset was not implemented so only reset devices
> -     * that are expecting it.
> -     */
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
> -        return;
> -    }
> -
>     if (dev->vhost_ops->vhost_reset_device) {
>         dev->vhost_ops->vhost_reset_device(dev);
>     }
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 8dcf049d42..7bed9ad7d5 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1492,12 +1492,17 @@ static int vhost_user_reset_device(struct vhost_d=
ev *dev)
> {
>     VhostUserMsg msg =3D {
>         .hdr.flags =3D VHOST_USER_VERSION,
> +        .hdr.request =3D VHOST_USER_RESET_DEVICE,
>     };
>=20
> -    msg.hdr.request =3D virtio_has_feature(dev->protocol_features,
> -                                         VHOST_USER_PROTOCOL_F_RESET_DEV=
ICE)
> -        ? VHOST_USER_RESET_DEVICE
> -        : VHOST_USER_RESET_OWNER;
> +    /*
> +     * Historically, reset was not implemented so only reset devices
> +     * that are expecting it.
> +     */
> +    if (!virtio_has_feature(dev->protocol_features,
> +                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
> +        return -ENOSYS;
> +    }
>=20
>     return vhost_user_write(dev, &msg, NULL, 0);
> }
> --=20
> 2.41.0
>=20


