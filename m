Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E67B2A08
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 02:56:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm1nP-0002C6-G4; Thu, 28 Sep 2023 20:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qm1nH-00027M-JJ; Thu, 28 Sep 2023 20:55:47 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qm1nF-000213-Q9; Thu, 28 Sep 2023 20:55:47 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38SM8i8V011269; Thu, 28 Sep 2023 17:55:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=R2wd3JOIe6vMB++Nt4uvRJTxcBhqRpx9XTTMLV
 DKMfk=; b=YyKarK9qmcj6iLyDG8FyzAFJIz0mwtQhWUiSRigBhMjEP3CJjtZkZH
 rujuH0UJJewGwB1PFE1mzvev4wj6MBjFR7+tV1e2Y6JiHZ228VBfbjq4F3HiS9Hr
 blApGggx5/DuZDtYY4DD3KT00IzcTriSPQBJXppLJg6XrkWD/vLUo2S2P6CCt92Z
 2d4VYvGCcwxDR1LF9ETj/fH4Xomyk2e61WA7hI8xO3/tIPDOlorHL8AWTL1i/oUK
 5UHZxOxCFOaWMoE9aXajbjl0KVkgty691f2OIivxEf/twDlXhvQVZzMNgjhwjU00
 3CL6s6A4BQL+1c6I95QilcMd/W9RE7bg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3t9yhxn7e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Sep 2023 17:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+mUuWr3yB7LI3hHw2VaKQmXPSMvxbV0PDJfVizgIGopBtsl9odb1IpFeBb5L7ATQRHk7y3Ud5oHpDbkuLG8usdNikjYPeF43b/khy22oZr8NkvO9evOOB/6WeDZXEUGs2kA3OzfYwPXVWmYyDoU0jdTvQ4GEz2f6qlpBoIAJ6CiMdBATut2phpGfsQn/Tidnx25CLkh0L5wNW4dme9DAPgkg2BPXOYhc3NFPMrXj9zPbT4nH/DdXFJmi3HkTEDNbmpAZUlonYc/iTxvxePhjJ7a5JtXQcfowkmjuB6O44JvCbwtGNPO+JqWuKde76Xbq/uKxKKqHWjUGOmO1YBZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2wd3JOIe6vMB++Nt4uvRJTxcBhqRpx9XTTMLVDKMfk=;
 b=Zz4ufmIbcdQb+MV96JsjcSGP/2N1T9Im6Ov+u5INvgke1hPsAlvDUJlT/G3BMiV1eu+ZHPEJmiRPYyF/ntGnfO10Lkj+yHPKyrCzt09JcMYj3qfCuhq/eBjxUnFPE2j72fDcSfNTIbNXhUBA9ZEh0sMWGWr8uvH3aKe0pha7x6zffihp5ZuH36uB0O9R8QVXL0NG3H05AupO0hUcYCQ9Q0yWwc28FxGXHeVUXDA40EQyVo4cuwgJBK6fuLUGXqqHLzJIGOwM6JVk3VrN24rDjACNZ1CJF14CnY8Zf9QrBkjdwNEU9Kc2bNUu0QfATDt+oU6n0CnJH7wawYy/pmxRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2wd3JOIe6vMB++Nt4uvRJTxcBhqRpx9XTTMLVDKMfk=;
 b=sFafaWIEoj0xycS8dF8ltpcex9OCXbyJkX8l8B1wsXevD4yYxdSHrx/kx7TBh2cSg7h7Y7ETMWok1dgew7djbpNISGcy7rL4d3u3aA1jIkFGqpqbATPvuVTzkqqIUvu1hAJXZ+/M3odYjvZ8VirdukfBHcw09kLz4expMcn2sdizZcVQF8zQ/MXPCyOcB/RRnBEVS2qmoG5ykssdxWoVmBSwh4ezy53iu1vQCKkUBSgIkNja3nuv975BoPVwdVMPnB6wYdCxNNF+HdRn39a0xbaYb8anuGnjmxdpXH62x6DKOPdqOmiRFrq+kEB04/NQrJOMIqCqCeLuvFHz6zvi8Q==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO1PR02MB8348.namprd02.prod.outlook.com (2603:10b6:303:163::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 29 Sep
 2023 00:55:36 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d%7]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 00:55:36 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng
 <fam@euphon.net>, =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, "open list:Block layer core"
 <qemu-block@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 5/5] vhost-user: fix lost reconnect
Thread-Topic: [PATCH v6 5/5] vhost-user: fix lost reconnect
Thread-Index: AQHZ7UqPvbnY1efp90W7Jzm40mKygbAxBLmA
Date: Fri, 29 Sep 2023 00:55:36 +0000
Message-ID: <DE82E808-A9BB-472F-9EDE-123E67BC3529@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230922114625.5786-1-fengli@smartx.com>
 <20230922114625.5786-6-fengli@smartx.com>
In-Reply-To: <20230922114625.5786-6-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO1PR02MB8348:EE_
x-ms-office365-filtering-correlation-id: 4a81d815-5d22-416e-cbea-08dbc086cacd
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a/NPvuyNEIeLy09ymJEootD2KYBxCFPEYb83/G7mp2j9SEaDKO7no2hHApXD+re15w1QGmrE9bxz5ar3g5MBu4KySJUy2sREPGjy2xbQyUby57KeJvLwWU5WqnoGzJ/aDH/ITjm7LAyy/1IoLWrU/qzY+PbhiJURdOSTnNnHpidr+/qrV09iQ7RNr/oTJhPAKEsS4yR+po+yi4L92xIep7ZKznvE7c3TrvFJRHWvFmzU3RrgIwPQQjqXNlr1zT+7YHVkBbZT8yKbMJQ1mYy1qzB5PHaQ4KdXl1MuIObeqg3LCT7R6U3hSBN6IXk8hi3pVnxL01+KIamnV6Fw8iLmZcFcVxYlqzHQW4/HxOcyFMqFhxb+grPCJ5gTNcV4Ff5kqRIN9oWrfh6LGuVci3nRvhFM6qpAY35NPVKa5GYyzaRiu1u3UxdgQulVN3gbPVtFTTWHUoItDLjypETeiObe3kbfcdU7dEKYQ+YGOLfyrKq3CwavYPttVlS3MDz6bRO8AbBLIoxM7hDgSJkdLNhERdlU/IRqT3G5fNSkzV0vSfibrF2nU7qzJuVTbtiVygepF/eST3ifXIsvaODMQORa178JC7jiYbWtAPaFVV1K9o3GK1c4fA83Knr3cSLtbHShWg7WEhXUDKV8c52iAMHwnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(71200400001)(53546011)(6512007)(6506007)(6486002)(8676002)(86362001)(36756003)(2906002)(76116006)(38070700005)(64756008)(33656002)(38100700002)(4326008)(83380400001)(8936002)(478600001)(5660300002)(316002)(122000001)(66946007)(26005)(6916009)(91956017)(41300700001)(44832011)(2616005)(54906003)(66556008)(7416002)(66446008)(66476007)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FRmdD2/S1Ol1k1NXmlU6801D4b79EW9nkLCxe4cJAttNJVB3ecWsURjAHZ?=
 =?iso-8859-1?Q?A5Ad3JmEbnwJ7JrBOHcSDzS5MvXR/3YkmLDO+piWdUkVAIL8LSLzb9FC3V?=
 =?iso-8859-1?Q?pHHsB8Q/9rfdJo2vGqtPbaDMYOnfjUj2PqHoNxx2sRDcQmf8a/hTtXaxWq?=
 =?iso-8859-1?Q?Qo70+6uD+3JfYUjccMrDVOY5sxqQKGVSAqYPCf6lyH4MLyV2Y5MdPXQSXY?=
 =?iso-8859-1?Q?755KnsUW8AS/klY24+VpqSgd2rSKSFMHC21/srj2sirGQ2sxI+f6QE1tom?=
 =?iso-8859-1?Q?mXsdku7mN4SId1LvOjc4s4jTVbO/fhNClTVMg+EQMSLtpORBBnY6/ZAq6T?=
 =?iso-8859-1?Q?YHB7JomA3PDoOvgr3JKxVelkOYfJ+RGWmQzRUMtHIuREkZdiDJrI0S7DyG?=
 =?iso-8859-1?Q?KrqvwkgEDrdTOyPd0tewBOs1iXL+WlvuTCGZlN/m6Q/kb1PhGvx97VIkTN?=
 =?iso-8859-1?Q?5iwFjNRfNZ5y2bL7nE5SDxLDJG0Y0abaJWqKR08MSqrr/XIZ2cHR6IJQNz?=
 =?iso-8859-1?Q?2FFkauq5QrX7O4yGOt3Ak9mg71Kscl3L66DQBf74R4HvVwBwiV8GgUJGOk?=
 =?iso-8859-1?Q?aVqZzjN8BIjkvmj84t0WbiA8unv2kknJORv/9jPSww2zyO2GlHvx4xAFn3?=
 =?iso-8859-1?Q?GZCmC7w5MNiuXczB0ZSAtDrzDmInFc9g4Hd8vUr6U6KS8dXbc0cr24Pllu?=
 =?iso-8859-1?Q?4kaxZ/G3xArBRBMdbwlCKPL9BTwqo2ucPB7JnBvNi1ULdQusxHwq8Z83dR?=
 =?iso-8859-1?Q?YsA3YAYir2X2luvKTPlcHBDHhrDQP3TSRgYZDCpT15f8pDBeorXNYd9LOz?=
 =?iso-8859-1?Q?AYs51EGK3z9BiYB0VKf2m0HFqGfwfPXroDQvM5JJzesOLggmq7+rEfDp+o?=
 =?iso-8859-1?Q?3e3l4DMMYwHO08mnS9hFHBbixxKNHosefAow3Y0JSlpzKbUWjePqJffVHi?=
 =?iso-8859-1?Q?9x/JOg2x41reKw64bOnCKGdvgNvVuGZxZCqdbrYvdteWO9uZEdW+hkl+uu?=
 =?iso-8859-1?Q?hRXp7w4Jt+0t2H1OV4yZqoKwFptJEWQm01Bzkhrm0ij3WFzdGqxcU3LZtD?=
 =?iso-8859-1?Q?zOlugplgJIE8BS1e5fvRFR2y26uJ8Bdyght1ZsUXdKw6lUYH3MMxJkTtvX?=
 =?iso-8859-1?Q?OTOfJ/XkCBLMUU3ILQ6Ven4jM0SVRFV7Vyto8ZLRp/ubyMqVQA8OLqMNcG?=
 =?iso-8859-1?Q?K1QgST9FF2wEVbZ4jUQ6CIAni/3ZEt1R1//SoPWoUtfU0vqncSDhKDC4/6?=
 =?iso-8859-1?Q?wm+LV/RBk5THSRsxS0tCYXG6V1uiFrCE8r4jk/KfFP9Adp6eIlFeBucZoG?=
 =?iso-8859-1?Q?eM3t2J/WaZuWpaNeSNHz4RXAkdSW3b6Rz98drAxKK+V2sDPaIvW01nQhuh?=
 =?iso-8859-1?Q?yycgWS4IgXr52zLsCx9tSs+xABCZhZ4xdLp9ZyQY278Bh7C2hau2bAvu6Z?=
 =?iso-8859-1?Q?s7/banTwexYHH2ZVEniO7Eb2OqmIN2VH9t5Ia92gj9YD7YzswN/ClTO1ns?=
 =?iso-8859-1?Q?zdHPUGOX5G9Rz54a1Zn6n/h9ZppUsJoz1TPctlWaopBg4RFEPcHY4KWEDe?=
 =?iso-8859-1?Q?gLr6FtsaQe+ipFUXB6xh3H/awCOTnV4oBq+vYO2JxmduSKUi/VW5SHkIFO?=
 =?iso-8859-1?Q?gt9u3ComEfifCCRZ/21ee3pN8tbWlmMe5sBMlR4C75EltC9I6kMkms9w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A6644185D3E58640A1BCFFAC1BC577F8@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a81d815-5d22-416e-cbea-08dbc086cacd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 00:55:36.3558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKHf4zZtuNrM69BpflKBzdUh0cJylzCBfEh1+0fZdDAS9gqeNnxOo+Aoz6ZB4smqX0TcuNCYbPLCZrSh2UKnQGKWeoN5XiYX+k2pKn++CmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8348
X-Proofpoint-ORIG-GUID: 1_mSnIfo5jayvPV7SlyI7KbqIrNNmz1J
X-Proofpoint-GUID: 1_mSnIfo5jayvPV7SlyI7KbqIrNNmz1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_24,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On Sep 22, 2023, at 7:46 AM, Li Feng <fengli@smartx.com> wrote:
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
> hw/block/vhost-user-blk.c      |  2 +-
> hw/scsi/vhost-user-scsi.c      |  3 ++-
> hw/virtio/vhost-user-gpio.c    |  2 +-
> hw/virtio/vhost-user.c         | 10 ++++++++--
> include/hw/virtio/vhost-user.h |  3 ++-
> 5 files changed, 14 insertions(+), 6 deletions(-)
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
> index 53a62c3170..0effbb4787 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -238,7 +238,8 @@ static void vhost_user_scsi_event(void *opaque, QEMUC=
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
> index 8dcf049d42..7344f57ba7 100644
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
> @@ -2685,6 +2690,7 @@ void vhost_user_async_close(DeviceState *d,
>         data->dev =3D d;
>         data->cd =3D chardev;
>         data->vhost =3D vhost;
> +        data->event_cb =3D event_cb;
>=20
>         /* Disable any further notifications on the chardev */
>         qemu_chr_fe_set_handlers(chardev,
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


