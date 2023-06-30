Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD83E743BC5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFD3r-0000uK-VV; Fri, 30 Jun 2023 08:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qFD3Q-0000li-Rl
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:16:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qFD3C-0002SD-QR
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:16:37 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UB94va007361; Fri, 30 Jun 2023 05:16:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=45aHc52ZeuIVlF/MbPAnc1qWdfW90KHzJoRyYETg35s=;
 b=by/pzHmahTHMO+QUjr1zg0FNE05WyrUIxdLnsKG7tIASn9nvzuI+yTsyrdDFMr3hE69i
 OC4uK+Ldqs8SWJfNisJZBP15Xhj574xQzsgRgZKn14Yw+/2IqmsKXyFEXIDWHWk3UfpT
 FFe/gwQPLDBcShb4vr5aSQyFnniKK/wnBQUvxb8nEYOyqXZT7iagtA0fnT9h08wWbTxe
 ygb0pA/a5//gCrBlljzRp6uiATa0UFlfLbxRh7m6VwFnOUDACd1uaBEiUDdHqyrN6Hu/
 h1FOFGvrlC4MaCf+gT+h9ki/k7U6jBLIzP1so3I63/RN3T/8bMFu6EP/6e7vxwBVXyEk SA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rhfs91fca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 05:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wf4wvKgRPdfjbxJAdWdxkpNNTaaGSvrUOcposcO3I2vx7QSOFVoZIzWnKFS2JyJHv3S7TvI6ZVy0Vrjw8hzUUx6wmGUZSE3Gbu7MFhuL3IUUSjrsij8pDcBbgPfC5mQz4Rch6gGltGHmJIk78VEDEoxfjard9hjnziaFz0mqyT7DBmQYnR4WJ6wufwVhbfT9+CWW5+NYNjKQBn/jDQoLSnFWfr4TbC9qI1sftogI426h7d3UnD5VEyoqhZSjoAGH5rPMBAte3mzkpbFJOApRQIJMmtdTcYYVOynfvVuEWwE7nhLdyUg+FiQXWmHC8489Og+0MuvznDG5YA6Hg+DG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45aHc52ZeuIVlF/MbPAnc1qWdfW90KHzJoRyYETg35s=;
 b=nTpBy8mkjHvzXOgIpNxS2lBF9WOcJPSFWH5R4Pau56wbF9dYzALWQEJigPAI5AN83mGznLVPJ+YzmqeMqLWW4kurX5JlMjrhz3Bw/0dqpRwiIxf9WEakXarNvdrPGHWa2KcLY8BFWPvLJORFhynU91C7gPoT/xdhTs3eBK9PtFGiPk29FZTZ4f5OzdH5RuW3vjL3zE5zx1VBcmfzp3ap09zP1x7m4bWrJKdVDNdoL2Mp1bGMpnTdQbTNz4ADr8lGU0bhABOgv8STSghL6bAQz8buEdLdykCKkGmi8bGWDeZkAXU1F1XOzS5RRn6JmYAypB7/QfmZ/kG3gfOSLv+rcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45aHc52ZeuIVlF/MbPAnc1qWdfW90KHzJoRyYETg35s=;
 b=APDN7gPLdZjX3a8jm/5sQKjToWAP/JHycE+J0eVF94NAl/dWyNyG0SZy16be0FeNn040UH8v33WpjWGcjTr6DjEwQD2M1nff3I9Xpnv+B6X5AvMfOCWBY0vDAB7vg39+tzkPrXcw2c101H2Rvaf1tE0bWhDZvSXBeCZvjydVCL6OZtKxiH2P+8DkLomfHfyxMaXU2V5IGis1ifbAlAR+YJep9LGlBhRL+eswsU4dkqeLw2iEjmP4e2yu2hR6qpOUwk18ZC/VuNCq3g42c/vE7mICoIvckOimD46DrAx//BrwEa57zWTR47UyzxR0qXXZq85C06h5jGbeinLPBVHQZw==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.11; Fri, 30 Jun
 2023 12:15:56 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::a769:9be9:a331:6d6d]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::a769:9be9:a331:6d6d%4]) with mapi id 15.20.6565.007; Fri, 30 Jun 2023
 12:15:56 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Tom Lonergan <tom.lonergan@nutanix.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Minghao Yuan <yuanmh12@chinatelecom.cn>
Subject: Re: [PATCH 1/2] vhost-user: Change one_time to per_device request
Thread-Topic: [PATCH 1/2] vhost-user: Change one_time to per_device request
Thread-Index: AQHZqd8lGH2I8yhdUUOg9chHSkn6Kq+jRX6A
Date: Fri, 30 Jun 2023 12:15:56 +0000
Message-ID: <47890F87-A752-4B72-88EE-676FFE52904E@nutanix.com>
References: <20230628163927.108171-1-tom.lonergan@nutanix.com>
 <20230628163927.108171-2-tom.lonergan@nutanix.com>
In-Reply-To: <20230628163927.108171-2-tom.lonergan@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|PH0PR02MB9383:EE_
x-ms-office365-filtering-correlation-id: 646cd403-7d70-402c-1d16-08db7963c1b7
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DGTOZeSwnTsq0w//kESliTxStgslSW1Kw0Ft/2w6Vyh9g1S5GVOKk52liGscgjLk2rPnHQGMEQ2jTj0ZvibYYcOtroctiN5j38P5mTLcslpDgHpFc2n1R/uM1dQbrVT+nBQY7HByfasIqXqBXfhZYsighYGz3YvBSuf3M1ONzwd/McEoa1EHTQQAUksEYdvKh8s//kUjv1QPEst6Nb5dAX6z5LNo1bVCOJeUkA7OxABsy9iXI4gHBF152W0EJ6WYPsxtBAKe/y0Hpk/A5JPHO02ycRH7kKncpr7m33vvegJAk9jFZ/1Kb2D9kPbDo/C2l2ocgup5UDSKrOy2Z92VnliBhuoHMH/n4wYEl04ihdePC/YgnsWriXkRN5YBPAcgLoabHEf4iwAK72TC2RxcE9G+8exZcCqEMy3ih3VAot73mGcwaFSs6WZVfzpPPZNGwdX5L7SxqnHGUwe60vuqGy6btZsCgCRb7sBOjQn8EpoY0kmvRlo9Zvaj2xu2mcf9htomk6V78yjoc7ljivFidVK5j1JKc4Fc5K0qv6lWz9MfHDh2VbPIH878tnZCJaimiGD1HjtR42aQmXzVDqzUhUUCE66WRr5hT0LH2Iv0lSNJ1vHyBiqX1gf5xX7WDJTsXttuMb9GGydFrcsQc2DeDqdHy4iyemeoZdhHfNFE+E4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(8936002)(8676002)(41300700001)(6862004)(5660300002)(44832011)(2906002)(66446008)(66476007)(64756008)(6636002)(66556008)(76116006)(4326008)(91956017)(66946007)(478600001)(37006003)(316002)(54906003)(966005)(83380400001)(71200400001)(122000001)(26005)(6506007)(186003)(6486002)(6512007)(53546011)(36756003)(33656002)(38070700005)(2616005)(38100700002)(86362001)(4444003)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l2xK32ZVwGhU0rocK3CYjdPBG8nKaz+WN+9syPX4rMiXHlnLELc8xuZaV0w7?=
 =?us-ascii?Q?cjQr/8ehQ6ju/ZJbYI5pqaYfljsw19RGb48aa1BdmYGE8o4AhEiq7OsV9NWC?=
 =?us-ascii?Q?oZ1F/NPhtoFXotYHQD7Vdf41TUmU6EnNJp7DVnlyQ7eb4J1rMQOZ5ddnOyLA?=
 =?us-ascii?Q?o4+/uVUoQYtJPmBAl6QmvgP3VIiXBWkIL6tiL5MX10nmgOsRIAoH+YZSeCRE?=
 =?us-ascii?Q?UwrrSxmsxin7WFpiwCXC7CulXVNVF2HbcuTBlrMyF8TmzQCusJbjGqvkEnkb?=
 =?us-ascii?Q?iW+FsnHf1OJQl2h6bIahiD8IstSk+KKYrk8QJ8zwNxcQrZwAAOgrUF6lZ09Q?=
 =?us-ascii?Q?yZNzTQWDk3k6uWu/t+gYxsnn6884+TSLz6G3BUqdjJo8BUws3506NY0+m1dB?=
 =?us-ascii?Q?2PmYGV/ThH3Z4xXULryenLv0721oJNUB/qKiTJowPNkc4j2i1BF9/gq8Pfmh?=
 =?us-ascii?Q?gOJ0+oHNowq9rdQ6jronX9wR51VSfcTdQxzc9u8j1qKZPMCSPZyS1T/N+Nyo?=
 =?us-ascii?Q?BOWM/HoAPAC9CaZj/w6QQCRmrLxl6UkO7V6gF9x/XNF6SRoiRuB1p5/wWn0O?=
 =?us-ascii?Q?sRdumTpIyFF36m9BHyiLat9M9OIRlhnlsfUc5Toc2YLipx/pJhFoa8aYzxlR?=
 =?us-ascii?Q?XgCslGCx+zbkujpM8fLLGq3JKKRrZsQ7grV/fCVH4+IhReAZ8t4wfrRVQ43Q?=
 =?us-ascii?Q?uhLUKOQj4gzWrfMTA9MEurjvZT01QJv2jLfvyJOKZxVSQFjv0dkg+t5n7DsV?=
 =?us-ascii?Q?f4qE8Y+qJEGT31QxS89cUkb0RLZD180pDDfYrs5vVJFShp2mKX5/wJyDVWAK?=
 =?us-ascii?Q?2T8J/q4rihm95FLtcpiErno/zn6z87RZqW4Q/TeIrqE1xS6+mXNqqMoyuKyt?=
 =?us-ascii?Q?Uggtx2M5nHbJgi3/hdcCVM5uUOCG6a//d8QcLPh29mrgaEAVW2MX91bdliZ8?=
 =?us-ascii?Q?Lxo4miUMh2oPl+PO4oerZOaYmW56g/QjrIc+H7LoAN+7cEo6f/NHYpVdRirp?=
 =?us-ascii?Q?SrXFc5GF2WM7ggLtawgzfro1VAVWgGy6oUVZXZZ6GCxSERs/wGQAlPtr3wfP?=
 =?us-ascii?Q?XeVF4tazA9e4404f25H92kbxKcSQVkRkuFzLPrxMif5KDWNhShADmt8l26um?=
 =?us-ascii?Q?rQUK+ty3jPK8gIxLm4nan9I2fRMebbv6YwBk+qpHNKL2oP9KB6D9yGVEVpeR?=
 =?us-ascii?Q?BV1jcJ9MluJSU3WXIyOAAA4yDf6xgiIiTzY/djN/zd+1Y5aHxNnyXFgi8mtq?=
 =?us-ascii?Q?G8yr/7Vv0MI6bo6zsGCTGyt213Pfz0qShVLP+8jrsRU1IuywCbQBpnDgv7TC?=
 =?us-ascii?Q?fJv9jglPiLqly4ObGxRFDKk+AVrI4fHRqdpGSaTejpp9fvOuaMW7HjIvsZBl?=
 =?us-ascii?Q?rYR7mAXoUaKmkCvnnq5NbAcwS7wyNFRg+OMuX1uQCQVx20lcUGIISxaRx3oK?=
 =?us-ascii?Q?EHemFYOx5pZ8VFgWVv0d9fjuaEGQMm+7KQ/oq4m0J0d7sZvkJXKbC/pCnbtm?=
 =?us-ascii?Q?rYTo4yTNIwdnJpd9nu1W/3jbna7m1iLbKz7COQFJLBL0Lo9ondpP25QQ6yR2?=
 =?us-ascii?Q?K9E4h9TY9oGvq3eDhNJknT1WaURyh/AHxh6+H/m9qSCQ79kCNzbB05hy/RHv?=
 =?us-ascii?Q?Bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98ED1891BD47784785C6A2EEDAA1BA55@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646cd403-7d70-402c-1d16-08db7963c1b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 12:15:56.1762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnU9oc61yKHiRpHKzRlhuhJJfyi88hAUKdXNZRdOeKhwedL4+BjnxWg1PXyJjPD3QjIz521xq/srFVou06hEa+GSVMEQevIKt/XV/5mStms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-ORIG-GUID: PCtmtJ-jfuSVHjlmX28NDe92JIlDADty
X-Proofpoint-GUID: PCtmtJ-jfuSVHjlmX28NDe92JIlDADty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
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


> On Jun 28, 2023, at 5:39 PM, Tom Lonergan <tom.lonergan@nutanix.com> wrot=
e:
>=20
> Some devices, like virtio-scsi, consist of one vhost_dev, while others, l=
ike
> virtio-net, contain multiple vhost_devs. The QEMU vhost-user code has a
> concept of one-time messages which is misleading. One-time messages are s=
ent
> once per operation on the device, not once for the lifetime of the device=
.
> Therefore, as discussed in [1], vhost_user_one_time_request should be
> renamed to vhost_user_per_device_request and the relevant comments update=
d
> to match the real functionality.
>=20
> [1] https://lore.kernel.org/qemu-devel/20230127083027-mutt-send-email-mst=
@kernel.org/
>=20

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> Signed-off-by: Tom Lonergan <tom.lonergan@nutanix.com>
> ---
> hw/virtio/vhost-user.c | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index c4e0cbd702..65d6299343 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -367,7 +367,7 @@ static int process_message_reply(struct vhost_dev *de=
v,
>     return msg_reply.payload.u64 ? -EIO : 0;
> }
>=20
> -static bool vhost_user_one_time_request(VhostUserRequest request)
> +static bool vhost_user_per_device_request(VhostUserRequest request)
> {
>     switch (request) {
>     case VHOST_USER_SET_OWNER:
> @@ -392,11 +392,17 @@ static int vhost_user_write(struct vhost_dev *dev, =
VhostUserMsg *msg,
>     int ret, size =3D VHOST_USER_HDR_SIZE + msg->hdr.size;
>=20
>     /*
> -     * For non-vring specific requests, like VHOST_USER_SET_MEM_TABLE,
> -     * we just need send it once in the first time. For later such
> -     * request, we just ignore it.
> +     * Some devices, like virtio-scsi, are implemented as a single vhost=
_dev,
> +     * while others, like virtio-net, contain multiple vhost_devs. For
> +     * operations such as configuring device memory mappings or issuing =
device
> +     * resets, which affect the whole device instead of individual VQs,
> +     * vhost-user messages should only be sent once.
> +     *=20
> +     * Devices with multiple vhost_devs are given an associated dev->vq_=
index
> +     * so per_device requests are only sent if vq_index is 0.
>      */
> -    if (vhost_user_one_time_request(msg->hdr.request) && dev->vq_index !=
=3D 0) {
> +    if (vhost_user_per_device_request(msg->hdr.request)
> +        && dev->vq_index !=3D 0) {
>         msg->hdr.flags &=3D ~VHOST_USER_NEED_REPLY_MASK;
>         return 0;
>     }
> @@ -1256,7 +1262,7 @@ static int vhost_user_get_u64(struct vhost_dev *dev=
, int request, uint64_t *u64)
>         .hdr.flags =3D VHOST_USER_VERSION,
>     };
>=20
> -    if (vhost_user_one_time_request(request) && dev->vq_index !=3D 0) {
> +    if (vhost_user_per_device_request(request) && dev->vq_index !=3D 0) =
{
>         return 0;
>     }
>=20
> --=20
> 2.22.3
>=20


