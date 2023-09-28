Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E607B1106
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 05:02:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlhHs-0005Uy-I2; Wed, 27 Sep 2023 23:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qlhHq-0005SZ-Fb
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 23:01:58 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qlhHm-0004lu-IF
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 23:01:57 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38RNh3dd014211; Wed, 27 Sep 2023 20:01:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=6FlOl1vy7TgnJhyeIa1xyf6ktCQ11zuMl8IHtb
 rzhyA=; b=BUUOcs7l5ScNPk8R7nPfi82YHI9Dju5w9CLaUG/HjjvfqV78KpI5mM
 9X/ZkFeelh7icgx+kYTCY8iTzh3BW75g501s7PIB250177Ak1dyVGYlDiKxq+O8p
 rXw6sK6IK164iSozjvtgLEG84uQSFf3ryNGDUo22RyWsQC2KYNx20n4kdIWgEpAB
 GoIlwokkAd8BRhF/Y38v5ozIRucW9SPgPJE95SaB0S7s1biupNqaBaQLfrE5njBR
 g3zF1KsNDQWBD5UJGag77pNCgQj3gTgS8SDNv0ypKO4HD7UKfE3/9sm0mOqeBsZP
 KLbqMWGL861V4Q7VuF2pYkYRjV1glMsQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3t9ux5gwhe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 20:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR74SV+3NAF+KBtt5/xBnK6xmuYqR8bXz7+hr5faUCeb7RfaGU7JlGtc2/DCZDS2rKn6piYNxAqdF0Q1l5rVl8pujaHxfJ188lrpRM/KNWzSVszK8wyWUNRdmx5NzgbQhIwX1bkUWCsdbCyns2nEKztpWWgVhX3wYvoS7/kp2rbpQViCHC01arD1MlStJvfixVXbHP+GmhkQZN6Ow1O8HKNg2CzY1kapFfD+d5kfqxIIMj3/tE2PT4El4OrHAhpGTsiG0TXokhRQ/bWEdnJD1Nt5xSFHE2GMIVIWoY6yoBUzqN+twBXnoJ/WsWVz7vWgfw5MWpRISRismcCHRb87kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FlOl1vy7TgnJhyeIa1xyf6ktCQ11zuMl8IHtbrzhyA=;
 b=n429FiQkkMm175tao/qpn08EYRcXxeZYVAMwd0KKI3yi13mrHON4kZqmg4qpnIhK+lksr7fIAlIW2PhGcJDEOC4Ms7vck7tuOUPZzRbjmS5TKygDGzqgdCv/ncTSOHL84fwxk8U5m5G7apuvOtzdHCDsrC+rx+6BjkEWQ0vQ1lZAkxlLOXrvszt6ODd9njqvWjUfVZRGclyeD8ob7uFWHYX82Cqaa+vii24hDXGBwXlgkH1B/ZAxlpHQnIJZd+U61PPIVuAKAArAd6tmHxm6eBjAGN0EnUlhS0ocW8SACOo8ht7wqkJIDViKoLPuJHQ9mc2etaygmdMlLr/IV61wWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FlOl1vy7TgnJhyeIa1xyf6ktCQ11zuMl8IHtbrzhyA=;
 b=mbjxq+PDH64TL0GjxxYqpGqKN/4j5plJ+MvQz4NnVUeXbXM4PvOPHepeohOS/MVGmCt1qhqXK9lLuHUnDyF1VXw3A2QhdQHqYQ5TsRnfzGk6h+WSM5sHkQ9QqOu4Gy/eaCAL8NUGlaSN+ImEMD+NJcTNwIqePkOlkrbaoumEVZqcLZzPxpSvtAuqNCTXtPoBCFFCS+STraUCEYcWPPnncNGxukaryKRIdM/ANzu9MQuBo9ilKXKJWpy5MoyDq5wWcetq+h5AfiZ1WGoaFRGj9jaRWwR6c1y9IlQu7pG0P0B6Fzhd4IkSSFkf7KctvkJ7j7ihiGGtfUehg5Bzd0lYVg==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO1PR02MB8393.namprd02.prod.outlook.com (2603:10b6:303:151::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.33; Thu, 28 Sep
 2023 03:01:44 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d%6]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 03:01:44 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: "open list:All patches CC here" <qemu-devel@nongnu.org>, Hanna Reitz
 <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] virtio: call ->vhost_reset_device() during reset
Thread-Topic: [PATCH 3/3] virtio: call ->vhost_reset_device() during reset
Thread-Index: AQHZ8Xi1Hb04d9Jhx0Wq6SlTQ9uHwbAvjUcA
Date: Thu, 28 Sep 2023 03:01:44 +0000
Message-ID: <1B0232B4-9318-46E2-8AA9-54D30E6AF9CB@nutanix.com>
References: <20230927192737.528280-1-stefanha@redhat.com>
 <20230927192737.528280-4-stefanha@redhat.com>
In-Reply-To: <20230927192737.528280-4-stefanha@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO1PR02MB8393:EE_
x-ms-office365-filtering-correlation-id: a13099f5-5fe8-437a-9ecd-08dbbfcf3f7f
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ApEkhuZmryP9ePI7OM0uP28Xs19E5YZIMa0f+j53Ir+/CdBees2cAofQOuI2+qSZHFagQGsKNSirhjmArhl27/f1LgYFoDFfwhA2VGHETsCSPTLC0cHd0AVigRHjnmI1ec4xMLtYd5MqN85B40ihHplE0k0dg7GdULorZ0r7t0eeWdfVZceYiJMyvuCFiNhINlLy3NIlzXTK5RoOGQeImkVVtZI/c33TZ7Ng4SvKwACgE4ABNOXTFAsC33nYNPX5ssyw3mXQojLP/rgfi+fkNbMSy6eHJWJQus1xz6IJvXhBdvDIYNt7CX1OnG86ssikGtUqgp8k3btTPZs0t4Vx8bUyP3q6byKLyV2v1Ux4/Lz5k2NHSFspr32PfInyDXUmIhC5lspDHq92ccGaeKfVXRwlwBC+BYjClVJ8wMtiP/Z9Z0jLo0eJ77vEU1JE6NT4sqVU63Hk90VKeb+w2rqTuy0wtxiX+f8uVFquobJ9k2j/5ZKuGKGaNil7ckvigF2JJ22CArJu1AYu7C14Y/+MAv8aDoErOJ9V3LgcwZVrfCjeBfSNh4t4OPiSM1rE5O+jQzuqTfV7bFCM7TSIfKtrxZQLwK/6GgRCZw3Y4oYlvhmGXXv/Gbc42bNsVZOXEaI/ZZDiD/7y5N4kvNZI2nSJHw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2906002)(6512007)(6506007)(6486002)(64756008)(2616005)(38070700005)(38100700002)(5660300002)(66556008)(66476007)(66446008)(76116006)(86362001)(71200400001)(91956017)(478600001)(6916009)(83380400001)(54906003)(122000001)(4326008)(33656002)(36756003)(44832011)(66946007)(41300700001)(316002)(8936002)(8676002)(53546011)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JRjp50lpulsCY9oHtudGHEcbaUkO3MuZXEtes/rmiCdtfdWnJ3BvJhu98E6w?=
 =?us-ascii?Q?GeYrtJtDwrjT9+/cnAAKPo6zf06v/k92O3wvFs7qNEzP8QVV13W/fJG5JBsX?=
 =?us-ascii?Q?r2d2Yq40pdgL56trs6m2aT3+H4Gv/FVR/pEF5eKvsydeBP1xDK3HmTXuZ6sn?=
 =?us-ascii?Q?WPx4Kacdjk/6B/Kc1Es3xBk2eikfgLBgmLniHf8Sd5CPXaNM8WJ6UozV/mc+?=
 =?us-ascii?Q?7L6QSIwmvk51xLX9JysrtVbIHDnoRr8UQy0u3w5A0gk9K90uklRRjaifo25k?=
 =?us-ascii?Q?w1/g1moSTPm+KazZcf6HrBPh8ZibwK6QN6BLNZO3eOC4T4OpvStqtya7rjBK?=
 =?us-ascii?Q?SiD9iqfA6TEyNaV9Jv+ZkNPZcLo+h3+OqKHEG3zB1qS3nETx0VTyVlcvi0xu?=
 =?us-ascii?Q?WY8RPqWKYpifyAY8lh1IEX3r6Q/Jj+K6xWv7OH4TBUHAjiC56OZ7K8aLD/jG?=
 =?us-ascii?Q?4nm3sZ8xgut0QJ8wlvuyT8qAQ4xIn7d50ODoEm4W/+gSLgUJlYBRyGBarx4V?=
 =?us-ascii?Q?sQFVdXRJO0qI+CPySBW1lmtJiw4Qy2WrzSj/aN6+PH3Jb6n35Yd9tldPISAO?=
 =?us-ascii?Q?MnJMd8WCnmrzf4hrx7wpgVLGUUYY6RNPHg/g2yq0BmRcYr8J8c/rdeN/vAsk?=
 =?us-ascii?Q?R5RlQTVxzHkybQRbyNH/Padz+h0HtOLiqwLp/uivJMVJBB3As3g7N6xh4p4F?=
 =?us-ascii?Q?egmHSY8lkHcpbfVBP7vB20F2xoI936PWOLogiLuVVFVR8Z279/w3dcnrSQQs?=
 =?us-ascii?Q?9jK/sXrgnxsu/JthU7nOHc4F95yX4um4q/OEhunBMgtS6ZKOAZlPYFwwUvki?=
 =?us-ascii?Q?xuB8lZ9pq8v3k+6ysMP6TW4E34RPQ0XQqreYzRt4xav2uPte9cUgeXi51SaW?=
 =?us-ascii?Q?VQNSi8DbndRlSwSqMsagl/LXDRpwfFjA28x0O7rj7Ps8mm7ux/6A2/yAokhC?=
 =?us-ascii?Q?ydb1MbWsgxiSR2nHXzE8RE4jIHoAXM9O+oYk+bCfN259ykA/yw7XSQbUcXy/?=
 =?us-ascii?Q?F/Gy1XdPf64NFhxKyAGp/yIYplqPibXrAp1IhiMlq0pknJlBVz5TK+AVCQUA?=
 =?us-ascii?Q?tTWKBpzu9eXtOz761ohuFizquLw1YiVhA+qXdn1KSOLmEbgdq963gg/D0L9i?=
 =?us-ascii?Q?NzOpFBcBsQ1oNBNNZWHJCxcM2YeOmdkiMXYoqPTvVD/8bIvZmUmKA61LflR2?=
 =?us-ascii?Q?/mFCzRRYefOy7znjqHQHZbhnTL38DUC+KG82vkFO7vOn72512O5faI6xo+/g?=
 =?us-ascii?Q?uejB9Wl/LrreqkNFkm/yANu31k6qMhJg/mo+Y+mTdHQvVYSS2licMtq5ZtPc?=
 =?us-ascii?Q?NJUNUYf5Fj3B6mGm7Gyz7xdzgQcVxTz5uoxUGL9ozV07JarXmgrLYJ1BcEsH?=
 =?us-ascii?Q?OxGSPJSV/8zEQqanHO679F64YEwve2EJr0dcziC9d5V5x7xVEC9c56xGHaPB?=
 =?us-ascii?Q?gLIeg7uimOLUYjIP5ktlVRzfumiuenKt9qdEyHdvc04rHZzHyto/C7A9qyQA?=
 =?us-ascii?Q?faS1+wUVaNmBJA8kgyVBayXgihAhbQhAYrAE6V/6/nQW74MhyFrAGYY7UZM7?=
 =?us-ascii?Q?FSBgVWJvbVxwgGDAe+B1ZxmM+pNSIN792DYvvTWyGpAMT3ppgvjYszvUYKPG?=
 =?us-ascii?Q?Qn9kgL5xOrTm1fL7Hat7Kg55ZvG77XNR4vzfOUF+wReJxVy+temgUEmvCcqt?=
 =?us-ascii?Q?kuVqCg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3050A4BAF53D574898D3B3BCCD57799A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13099f5-5fe8-437a-9ecd-08dbbfcf3f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 03:01:44.7431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/R5vJAhrmztqN7oUxlkg9uV0YhY4fWkbPL7r1n9pj6kYL72RNZyf/QsnLvFi+rdn7LjlGFshtqmIgm5KFbFYim5i58t72gF7CqARPP2Zpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8393
X-Proofpoint-GUID: 6izBa96lhFeiiOEtnLdiqja3xHM0jgtE
X-Proofpoint-ORIG-GUID: 6izBa96lhFeiiOEtnLdiqja3xHM0jgtE
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
> vhost-user-scsi has a VirtioDeviceClass->reset() function that calls
> ->vhost_reset_device(). The other vhost devices don't notify the vhost
> device upon reset.
>=20
> Stateful vhost devices may need to handle device reset in order to free
> resources or prevent stale device state from interfering after reset.
>=20
> Call ->vhost_device_reset() from virtio_reset() so that that vhost
> devices are notified of device reset.
>=20
> This patch affects behavior as follows:
> - vhost-kernel: No change in behavior since ->vhost_reset_device() is
>  not implemented.
> - vhost-user: back-ends that negotiate
>  VHOST_USER_PROTOCOL_F_RESET_DEVICE now receive a
>  VHOST_USER_DEVICE_RESET message upon device reset. Otherwise there is
>  no change in behavior. DPDK, SPDK, libvhost-user, and the
>  vhost-user-backend crate do not negotiate
>  VHOST_USER_PROTOCOL_F_RESET_DEVICE automatically.
> - vhost-vdpa: an extra SET_STATUS 0 call is made during device reset.

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> include/hw/virtio/vhost.h |  3 +++
> hw/scsi/vhost-user-scsi.c | 11 -----------
> hw/virtio/vhost.c         |  9 +++++++++
> hw/virtio/virtio.c        |  4 ++++
> 4 files changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 6a173cb9fa..381fb51966 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -338,4 +338,7 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
> int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
>                            struct vhost_inflight *inflight);
> bool vhost_dev_has_iommu(struct vhost_dev *dev);
> +
> +int vhost_reset_device(struct vhost_dev *hdev);
> +
> #endif
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 8582b2e8ab..6917a748bb 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -66,16 +66,6 @@ static void vhost_user_scsi_set_status(VirtIODevice *v=
dev, uint8_t status)
>     }
> }
>=20
> -static void vhost_user_scsi_reset(VirtIODevice *vdev)
> -{
> -    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(vdev);
> -    struct vhost_dev *dev =3D &vsc->dev;
> -
> -    if (dev->vhost_ops->vhost_reset_device) {
> -        dev->vhost_ops->vhost_reset_device(dev);
> -    }
> -}
> -
> static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> {
> }
> @@ -195,7 +185,6 @@ static void vhost_user_scsi_class_init(ObjectClass *k=
lass, void *data)
>     vdc->get_features =3D vhost_scsi_common_get_features;
>     vdc->set_config =3D vhost_scsi_common_set_config;
>     vdc->set_status =3D vhost_user_scsi_set_status;
> -    vdc->reset =3D vhost_user_scsi_reset;
>     fwc->get_dev_path =3D vhost_scsi_common_get_fw_dev_path;
> }
>=20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e2f6ffb446..6003e50e83 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2087,3 +2087,12 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
>=20
>     return -ENOSYS;
> }
> +
> +int vhost_reset_device(struct vhost_dev *hdev)
> +{
> +    if (hdev->vhost_ops->vhost_reset_device) {
> +        return hdev->vhost_ops->vhost_reset_device(hdev);
> +    }
> +
> +    return -ENOSYS;
> +}
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 4577f3f5b3..d863ffd5d6 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2121,6 +2121,10 @@ void virtio_reset(void *opaque)
>         vdev->device_endian =3D virtio_default_endian();
>     }
>=20
> +    if (vdev->vhost_started) {
> +        vhost_reset_device(k->get_vhost(vdev));
> +    }
> +
>     if (k->reset) {
>         k->reset(vdev);
>     }
> --=20
> 2.41.0
>=20


