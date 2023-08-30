Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A75E78D435
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:49:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGrY-0007Mq-MH; Wed, 30 Aug 2023 04:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qbGrM-0007La-4Y; Wed, 30 Aug 2023 04:47:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qbGrF-0007G1-VC; Wed, 30 Aug 2023 04:47:30 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37U5lhNR022199; Wed, 30 Aug 2023 01:47:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=rJWTY43xAOmpAYB9ENgpQjf3yT8yQ7Zf20XQa7
 xV5Iw=; b=SQn6tldaWRuvdo/6+GfijaUDxjaEeUEdBTclfmwUcAqLN7mDhTI7N3
 3FFkNaGkHQ6+y8nYt64DV7+JmW+dInZuoagAHUdyddX80mtSN//GLPMd/Zx1sH5o
 j2npMWz8LrwsSsV6z5YqitGTfFm//mzrQ/OOU9K2it120gCcqMOLzTZhJjoqQ7ya
 ZS2zEKTGFfbgH3hMzPEzolVXUmWqOzT63l/b2N82GK/3KkCSBOkUOv1lw6/d9tTQ
 DaRTCsD7m+8jkkrRcSsX+UGEGe0HJmfGAsqE+KNdz0WBhksob8e21DdRWp1AEmvw
 ekUlnM2XFiSCmq59zMzSYFF7DzLcG8MQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3sqgwxs1h3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Aug 2023 01:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya51xF3TqJNPcCTgiH4IXGVOjHoqkkjmfMzVO1wo1ntFjfnaIhg6GdouCPFEjJbpyVgv1iRpIoc1IbFCQU5vGRP7E5RYlrrEun4cWHWk72a+qxdNjUg0WKEisM6X8LgpoG4LXw5M5udRkCmbVO5SFPe95JCCvAtQ7nd0SnbBXal8zjPjYbAXlo4JNz9Er9G2wFjxeVpyZOJ6mRjfr7rG3V5+MCieocUdAdFe4Cv5xwUk5O2t71a6CAcvC65HHdj9XQp70WvdYWCYSH4O9aIh6V3eayHc13T5tKVJ8M+yOTSiqfjxDp4lt8w2VPUOSBFgmZdlqoF6Xh30GRDdJ/DAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJWTY43xAOmpAYB9ENgpQjf3yT8yQ7Zf20XQa7xV5Iw=;
 b=SJ3B4iOH11Ky7b3qA4CTzOukAU75SOQFdenCzRGK5kBYm7LVnitMe9sbAHlj9fGcPFVwiN38hSz6ey8O93+gx5c3m/3hVJ3a5ZsU9PAjg/p8y0eNzE+aZDmxB/RIlnaAFQLr1jnkd2SC3wndn94l1IpETz6wleIBzWFp6TorkBWZY2j3x+CX5yIfmkYIu7q1mdEFK3OcG0KeFXLyz5djOCUmjFKq9NTuVflbF+xNiS2EFL7PN3oOtBOOm3RljLzQhHCwqpf6fPbwpR8YQnrS96eI5irc6SNvMze8Ezurm5yvAQhtetp2we7/aA1AM9Cn3yCymAoh2Vcho1ojM3VG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJWTY43xAOmpAYB9ENgpQjf3yT8yQ7Zf20XQa7xV5Iw=;
 b=bkCdTOohIImpQpyVbBeB/mAxRTIWjNJoU10MCJfEr6R22GP75XbtC2unKJsDI06mx56E9INp4RnuNXy299swGbP60MuIT7mS/SZrpuEwTI9lo4S0SPo9Yy+Ya7llpHueOT9Ocj5Bh526qHG8I59ije4gdJrL/ZnSS1ISvBxAJDyVfXJN4SAYnsC+88ao8L2eCO89CW3htUE25IFzY2AB8ImEFHqyXPJhSwBDdCF/9Vp6bSDeq4f/tWgrwUNPKHY0bKKkTv84gRQH9VBx3RFAQwRpfTTpyfN/78HRzqIsEoYDdUgtdDuTUoceSVRT3VyshFXBA+J+YTr6GeAUMaY+9w==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CH2PR02MB6887.namprd02.prod.outlook.com (2603:10b6:610:8d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 08:47:06 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 08:47:06 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 1/2] vhost-user: Fix lost reconnect
Thread-Topic: [PATCH v3 1/2] vhost-user: Fix lost reconnect
Thread-Index: AQHZ2v7+SZFOqUnfLEa6jG7xKLvfp7AChxsA
Date: Wed, 30 Aug 2023 08:47:06 +0000
Message-ID: <360FC016-2E52-4331-B060-FF4FB7FA447C@nutanix.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230830045722.611224-1-fengli@smartx.com>
 <20230830045722.611224-2-fengli@smartx.com>
In-Reply-To: <20230830045722.611224-2-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CH2PR02MB6887:EE_
x-ms-office365-filtering-correlation-id: 518c7ff7-c635-4ea7-37a6-08dba935b079
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IPPUXVL2/5d18sb9efiAoRHXZIgxmZkrZzDyjaLAS22RfICbq/14N34tYdMCJnHs/TE+M2rbT2iu9AJbhnLHxGElTsbXIpTUyX1uygNrXP39Jkyohdjvqww/I3NqQztiiFXpSHB3SRMM9NDDmewKl7H0hvy4Eg9FY4tWDoXRUb5riRkoryLW1FATzPZwJP7IMR2BMNfsFqz0jxNgcnqEfSUDJOY1u6EK216DiB5+DBSajSZAw9i0YNupCgtE8JSgy5fID9L1R5KpAvEXeczc4Q+H8TXpv21PwfGzEk17yZbeUVum0qirQ9qGZpQ5doWRdt5im+iWc01ELI0BRdageFvGnC7WoGssuUfDalultwrTsV5fZn7ZMlFwx2FQAVFHIJduEvLNvT86V9OsqA4r1eZQWzMxxgUf4FdY6klzB4YpYiFD6xBkJjy7z7unUzLTOXZ9bDsRUL5zESYOhEaeAxYDNqOoZMazKNfyMw6IMdVEUUhMYn/Vgl/no3Rudy72Sx53ybkFXPlQg73VBh61uC5lmXxZWJ3/N2Smg2fCSoky7O41jqN7KvHVLYJXkMOFKjVMTiX9cV1yGg0N1eRmVA7xMqxejC0Ds+gnSyRrZBNxdqAgm0J2eQOhEsTdOUSSTBt2Mot5FYYiazYiF8P5iA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199024)(186009)(1800799009)(76116006)(64756008)(66556008)(91956017)(54906003)(66946007)(6916009)(66446008)(316002)(8676002)(8936002)(66476007)(4326008)(41300700001)(83380400001)(5660300002)(44832011)(6512007)(26005)(2616005)(2906002)(478600001)(33656002)(36756003)(7416002)(71200400001)(122000001)(38100700002)(53546011)(86362001)(6486002)(6506007)(38070700005)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l+5kwbi3XKeM7Jcjh13pZGVJQpAgeSyhd2v3lsNQz3VWRb8U0296pMu5uW?=
 =?iso-8859-1?Q?vUhUatmt2+0OLU7nmDEh4DUjBodIzV0oYJF8D/TDkpr4yMNquXqXBpOvTg?=
 =?iso-8859-1?Q?aHoZpr2SqFQ58CwUhx2QmAxyxsILwM23p1ls7EzYiK4qGZZyDKwFovoETL?=
 =?iso-8859-1?Q?F9p4HnheuK7lAJIaz+AxDoaA9r+giKFogArJcMt48arXhAXQJ0759P8CUg?=
 =?iso-8859-1?Q?QrbdNFOyHBH1WaZXF5N+j0MEe7p5hAobJMznaqfbZkqlatc9iEyoYKNKMP?=
 =?iso-8859-1?Q?KwqkbfZYIug5ZFjT+cny3i7ZH5NTKIGV6Z9nfXveIVyqWInL9jj4Z6UB2c?=
 =?iso-8859-1?Q?nG/2L6IWzmDsAG9eicAH/4qpcx4oqLDYP0D7qvKYPYfiqryAy6bvYRUaOU?=
 =?iso-8859-1?Q?LSFdnqNu366rPnlqlsrHM2NnhfxxxcFpU9RiekFtVXkWTnTUSWyRvsLwLB?=
 =?iso-8859-1?Q?P+IJ8OXr8g4u0Srok6U+MHvYuGhmUJJ/o4525xoSydCP9C/Tp83jtJ484u?=
 =?iso-8859-1?Q?t+PftLMsAkmVH4Y3ukLiz6S9+5eLHkNA6Zahg7CUagNvFBXznq92zAgdr1?=
 =?iso-8859-1?Q?Qeod8Jstso4zB71ejrF5y7yhDcBnhWZduMcah29j+q+X6ysMrUCtS9l3K7?=
 =?iso-8859-1?Q?DWbZkDmc7OhHAY+F0tgK1isA+IYpwyu7OpxPr7YIkKEHVphWua2N74Er6V?=
 =?iso-8859-1?Q?713/ytUlK0M2m1YvbfeqpRoXb66owFU1pBuw2SiLx/I6ysnp1CXGRXE3b8?=
 =?iso-8859-1?Q?4EcX3DYKbHZGq+HJC0S9oUvBVmv52KKzALHRQSdQZlXpiwmU+D+4Zy2c7m?=
 =?iso-8859-1?Q?xDnlKvL9q020jL8tJwqRq2v2vBiej7jq6zK512TcnoXZWtJshXSUlalshC?=
 =?iso-8859-1?Q?GGFlp8WI3qvKDNhHdIkYfqZPGBH6D9b7lffI4Vm6odyV9OCHrkVY2LmGTM?=
 =?iso-8859-1?Q?y6sVgFCFwsIzQdYfp/EC5IUq5YAAgFq/5iauWHjDleXIaq0AuFkMS9UxhP?=
 =?iso-8859-1?Q?QcipYa2TWa1h/c5VUoq+P26U/MiKblMKG3Sh2c8QoVSso6ifTlifMNH9tv?=
 =?iso-8859-1?Q?kMGjRCTBTNf+uKmMupdHYLGLYTPoSAPmZJZiEtrLa44dDP9c310pE2yU4n?=
 =?iso-8859-1?Q?NBjo5/0dSVb318LcvCDU2ViKy7e/mmil7MW8Zqztng74b7FmUIn55JBqDX?=
 =?iso-8859-1?Q?vniPr7pd9g2gSyP8ZbBQ+yseygldz+47/tllYbGH6SKLP97QR/WpsMiRE7?=
 =?iso-8859-1?Q?9xf9YqdKhBlZ9STd8NvEGC3ZtjCS0kem/oyehr5qsALbjitg1EI4eNBrXG?=
 =?iso-8859-1?Q?/CSVEg+4mT5OXCXLClGlAthJIEFOFWuzuVNZzTRs+FTBIZcf9/upRNYgsI?=
 =?iso-8859-1?Q?13Zzzq6ipSbgl+rt8OEsyXsI2g5uwRYokNprukAAUFZ6Y1zck+gl2/2OjG?=
 =?iso-8859-1?Q?SgUrkmK5p3+ZRQOABuK+tlNnw05BMXfsIf/cFMYOK4YxYLazZbxJhXhOsS?=
 =?iso-8859-1?Q?O686RvRoIWQOqbUmiEXeGKQ9xdPaFtm7p+n/oJrC8VmT8a8HZZ+ev31iUW?=
 =?iso-8859-1?Q?63Hl6+zCpP+ODfBc2X83oPG8ArPu+5gmkugNAnxWw8zJ+qC7mfsMc1pbHZ?=
 =?iso-8859-1?Q?Kdykl0NV/i0FXQFY4O1w4SJNMNdLwMwaFW1PqSF1n+TeN8XGwrg7vKTYHc?=
 =?iso-8859-1?Q?zpyamkwJt///UvemaxI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E57BDF08B1459C4FAA72CA9C6CA660F5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518c7ff7-c635-4ea7-37a6-08dba935b079
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 08:47:06.1955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1f1cIP5mUkDvskVa6ZPwoZzV8xcxR1d4ZYht2jq+I8ut1TidXKha49b430eHl0v7jbO72Qr/oNoI9UXvdwP54UE1kTOMmmY9118nbz1ERs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6887
X-Proofpoint-GUID: ZAXP5hUlV5H6tyH_yiTMOZ7oLmbu7F9R
X-Proofpoint-ORIG-GUID: ZAXP5hUlV5H6tyH_yiTMOZ7oLmbu7F9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
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



> On Aug 30, 2023, at 12:57 AM, Li Feng <fengli@smartx.com> wrote:
>=20
> When the vhost-user is reconnecting to the backend, and if the vhost-user=
 fails
> at the get_features in vhost_dev_init(), then the reconnect will fail
> and it will not be retriggered forever.
>=20
> The reason is:
> When the vhost-user fails at get_features, the vhost_dev_cleanup will be =
called
> immediately.
>=20
> vhost_dev_cleanup calls 'memset(hdev, 0, sizeof(struct vhost_dev))'.
>=20
> The reconnect path is:
> vhost_user_blk_event
>   vhost_user_async_close(.. vhost_user_blk_disconnect ..)
>     qemu_chr_fe_set_handlers <----- clear the notifier callback
>       schedule vhost_user_async_close_bh
>=20
> The vhost->vdev is null, so the vhost_user_blk_disconnect will not be
> called, then the event fd callback will not be reinstalled.
>=20
> All vhost-user devices have this issue, including vhost-user-blk/scsi.
>=20
> With this patch, if the vdev->vdev is null, the fd callback will still
> be reinstalled.
>=20
> Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")
>=20

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
> hw/block/vhost-user-blk.c      | 2 +-
> hw/scsi/vhost-user-scsi.c      | 3 ++-
> hw/virtio/vhost-user-gpio.c    | 2 +-
> hw/virtio/vhost-user.c         | 9 +++++++--
> include/hw/virtio/vhost-user.h | 3 ++-
> 5 files changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 3c69fa47d5..95c758200d 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -391,7 +391,7 @@ static void vhost_user_blk_event(void *opaque, QEMUCh=
rEvent event)
>     case CHR_EVENT_CLOSED:
>         /* defer close until later to avoid circular close */
>         vhost_user_async_close(dev, &s->chardev, &s->dev,
> -                               vhost_user_blk_disconnect);
> +                               vhost_user_blk_disconnect, vhost_user_blk=
_event);
>         break;
>     case CHR_EVENT_BREAK:
>     case CHR_EVENT_MUX_IN:
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index a7fa8e8df2..e931df9f5b 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -236,7 +236,8 @@ static void vhost_user_scsi_event(void *opaque, QEMUC=
hrEvent event)
>     case CHR_EVENT_CLOSED:
>         /* defer close until later to avoid circular close */
>         vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
> -                               vhost_user_scsi_disconnect);
> +                               vhost_user_scsi_disconnect,
> +                               vhost_user_scsi_event);
>         break;
>     case CHR_EVENT_BREAK:
>     case CHR_EVENT_MUX_IN:
> diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
> index d9979aa5db..04c2cc79f4 100644
> --- a/hw/virtio/vhost-user-gpio.c
> +++ b/hw/virtio/vhost-user-gpio.c
> @@ -283,7 +283,7 @@ static void vu_gpio_event(void *opaque, QEMUChrEvent =
event)
>     case CHR_EVENT_CLOSED:
>         /* defer close until later to avoid circular close */
>         vhost_user_async_close(dev, &gpio->chardev, &gpio->vhost_dev,
> -                               vu_gpio_disconnect);
> +                               vu_gpio_disconnect, vu_gpio_event);
>         break;
>     case CHR_EVENT_BREAK:
>     case CHR_EVENT_MUX_IN:
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 8dcf049d42..12c4a41f30 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2643,6 +2643,7 @@ typedef struct {
>     DeviceState *dev;
>     CharBackend *cd;
>     struct vhost_dev *vhost;
> +    IOEventHandler *event_cb;
> } VhostAsyncCallback;
>=20
> static void vhost_user_async_close_bh(void *opaque)
> @@ -2657,7 +2658,10 @@ static void vhost_user_async_close_bh(void *opaque=
)
>      */
>     if (vhost->vdev) {
>         data->cb(data->dev);
> -    }
> +    } else if (data->event_cb) {
> +        qemu_chr_fe_set_handlers(data->cd, NULL, NULL, data->event_cb,
> +                                 NULL, data->dev, NULL, true);
> +   }
>=20
>     g_free(data);
> }
> @@ -2669,7 +2673,8 @@ static void vhost_user_async_close_bh(void *opaque)
>  */
> void vhost_user_async_close(DeviceState *d,
>                             CharBackend *chardev, struct vhost_dev *vhost=
,
> -                            vu_async_close_fn cb)
> +                            vu_async_close_fn cb,
> +                            IOEventHandler *event_cb)
> {
>     if (!runstate_check(RUN_STATE_SHUTDOWN)) {
>         /*
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
> index 191216a74f..649e9dd54f 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -84,6 +84,7 @@ typedef void (*vu_async_close_fn)(DeviceState *cb);
>=20
> void vhost_user_async_close(DeviceState *d,
>                             CharBackend *chardev, struct vhost_dev *vhost=
,
> -                            vu_async_close_fn cb);
> +                            vu_async_close_fn cb,
> +                            IOEventHandler *event_cb);
>=20
> #endif
> --=20
> 2.41.0
>=20
>=20


