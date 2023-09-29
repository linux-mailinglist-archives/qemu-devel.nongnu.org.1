Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C08EA7B2A09
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 02:56:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm1nP-00029O-Aj; Thu, 28 Sep 2023 20:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qm1nH-00027A-8V; Thu, 28 Sep 2023 20:55:47 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qm1nF-00020q-6p; Thu, 28 Sep 2023 20:55:47 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38SM8i8W011269; Thu, 28 Sep 2023 17:55:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=R2wd3JOIe6vMB++Nt4uvRJTxcBhqRpx9XTTMLV
 DKMfk=; b=ves/17BhBaQcBxmPQ4qZeogc3xoN/lNfumVp41HgoGeeOKARfwHjGX
 uMAnyDCZryy4/UWPWpUzy/eej3wqSUvUTPU1Z8aBoSLRORzqU5/PrEqXcOP4kLit
 0BSnuIhQUzhrui0aZ7y1tTbYdvqI11jI7ECjEaWRX8zOOqZmxPANFcFNO+7Pn2Bk
 i8vLpa4YLKCGc4xbcGZDGonGhiM/sieGvuoeIwNi2YtDAKWUcAI+wmqEmnqTfa05
 S39iC84ZJgiI7Vb8Lvwi2CcaNmDA9OD1zlxvwNGiUoJO1AgKQ6LEoYPmpZtK1ryw
 AJmnECH8getv1vcqgMmSrMzDr8ahzEBQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3t9yhxn7e5-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Sep 2023 17:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5va9z4hqWWWfQFFHTHEb1ZNQhIcIuwL6K3/ISQ+2Gwfl1vHkbZ1InJm/84kWspssM0iyKP+vgIZGZ8AWxpvMy4moLuNO5TiVh46S21UfeKXj9ad++MRZ5XIlaI6aWH10dPOndSrCXl5oL5evfDWgU9jMVwW9SMdZMXwyBw09zVhYc0kAmw8ZQOe9k9JOXTfjpYekgAxM9z/qODeVF23cwZMkCd1zlsku7gmUftBDI9vUuU8/WUT6YEETCh6lYsuIgDpPZVMnsp2Xhhs88pjyME5Q5mq6trsar4vce/9JPnH9eWePpHlVPlIw+PIn1dqaC+UXwQ/UQveTW8wi6mQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2wd3JOIe6vMB++Nt4uvRJTxcBhqRpx9XTTMLVDKMfk=;
 b=CEeqFCzqQO8C9lF1o1bVVlInhQnoyEv0mCMSXYD4D1mkxqlci/7HXiJwrBMD0cWTx4cSF2aKosN5731HV5NJSLoN8h6bf029EmvYxA8h2M/nPawKCdtoCX1sjlKIihvAvlsL4UXFxPAm0JlYqSnHkSsBAHxnKuHv60ipEPAX6xD47jPrZPvjFz93bHRs8+x0cnyqBSomBsK/qu7oxGyUv3K8WiJycKqZMuImOOX4dEmbicf7J7IC09SPPAffpupM2A/vlURh+8n5+jkpKVitvXkOa3LKue6Y48jScLbhoOLnuJClAYeqa52f4nsRWqsa+F76uf3QzXKeFP8n36B9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2wd3JOIe6vMB++Nt4uvRJTxcBhqRpx9XTTMLVDKMfk=;
 b=IF6rssTIpm9hSr4HYYUX/9u0UQVbW3pJz84gkAqF7JSBOPtvWuwRs9dBauGAFZ9Alnj1nMrurQsWbsmAFFg//WNlrCqWr5rtSy3m5U1z8dDl7ztDXrBg8UMo4EzcnDXHqn85wrB+BGpassKzmMddGPms+DVZ+mwWYTKix+ZVrYqvnZ4a6KVaRHxI29lBKVhjhFKT4kAneREGR/GdImBMz3LaZtjcTd9wBoUt7Om/ZVm3BsMaPRS7CfLuAlHt3lhfzmnY/WDhqv/w3EFmgOSF0b6lpn6Joc8/jEGi7ZDjHx+B8dpDi4KRQMBf0DioWlYr7IdYjjDt7dk8HBlSqTh8rw==
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
Thread-Index: AQHZ7UqPvbnY1efp90W7Jzm40mKygbAxBLsA
Date: Fri, 29 Sep 2023 00:55:36 +0000
Message-ID: <518611C7-4A67-4F37-8725-D38D9EE7FA57@nutanix.com>
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
x-ms-office365-filtering-correlation-id: 5c42d528-6249-4f19-ec71-08dbc086cb12
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ig2Zj9TF3xTdgiJdj6jPzZhLjDAhZEWop+BoeoAMXo0yuFQMFqac5Kwekiz3m9q+iO9tokbMol8j44IwOp/ePud+MyOB/jMZ68PbeJk7+mN+yR/kWZKDbFa7v1gL6z131faMecb2u0iRJkv6cOxJzpPTQt+Pfz/RL3v7LC5eQVUvUStDf4brPfpC/uSXn14xx/3cESued3rNEA2f6kR9q8QuwrMVl48FBSZAkinfu/bmEYFrDc98q0UCSbYQop6WMkx/LamXIXvIDf34tO6Jc9tzvCAPSbdKWvBXPqjLPFwz79uoYvA/R6FqaacjGYaOcT5qHYulrdMJY1JSWalOaBwaKpeSh71R1bq2+vuVctsjZdDou1KsOyoYR1aBSg/wzrMVWYWliMTBfciuEKeaN/S5J/qqXv5D/1JRSZZjIT0ta79wKNFUq9QEzygDNZuSQJuiujsMDQ+HuszNm8skqUjVzLudU8B6Gx0KseUTLOX4YLf/MeVYU9xoTHheXucva6gO7mD8jEvTpkhVypgLgAQy7kskruDCljkCh3UAwvudPpn+VVXUDh23AOmUI5xNKBVNnVXn9zhdQWHDz3JAIs1kL+Q65yNfr8MqbgrlEQIRUjsZjYMCt0hviUvt0bNfJi5Zouk938npAkinBb9r1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(71200400001)(53546011)(6512007)(6506007)(6486002)(8676002)(86362001)(36756003)(2906002)(76116006)(38070700005)(64756008)(33656002)(38100700002)(4326008)(83380400001)(8936002)(478600001)(5660300002)(316002)(122000001)(66946007)(26005)(6916009)(91956017)(41300700001)(44832011)(2616005)(54906003)(66556008)(7416002)(66446008)(66476007)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jAyrrru0fHbRDeTPvafeQKrxZvwgSGlLHBa+b8bcM0NMpjnkIHIET7gpV1?=
 =?iso-8859-1?Q?zAaheM68lPGNtCAuvNjl+xGioYro76l/4wTyL0L6T2etXcatuEW4hzG2RO?=
 =?iso-8859-1?Q?bicJIcMCx/C4tD1tR4Qx5gBDdHO7LQbHSy2jDUr5/Pi+eKB812I7CZzKBU?=
 =?iso-8859-1?Q?iIKVDEa95HuJ15parDFBcxuDzxRc7cHo/tqpRd9hbB7C9yeUEJmqRf2hBf?=
 =?iso-8859-1?Q?vfWEfZJu7yVRZnDUYk7NVyFP7wfMpFMHrj9ag1rfAaxZzgZ3TnxiZNjbkm?=
 =?iso-8859-1?Q?cumZovseSe/GJA9KCrksQDd9/wyrS5xaj83broRtrcpkjSacyopt0wl2YF?=
 =?iso-8859-1?Q?BxtE9KGM6uzvAHtqmnx+7CoDQW3Iowd3VJhkOXz+wljp9mgtkWkh5wbo97?=
 =?iso-8859-1?Q?ALZKrHk4pTRirrsBRIsKHPvwdcOYRPc0Ui+s5Juwnk5hUJ9+lbeAq9UJM1?=
 =?iso-8859-1?Q?agR9FPlNQh/NPmwYIgTnFQkYZRSsPvY6+8GFGr+gXVk34IRgZT29Ahi23o?=
 =?iso-8859-1?Q?fU0CCYbc8iA0Ux/ZjJiXgmIfJFGDG5EHlhsLZGSgjAH2TRfKhJQ1DdHaF0?=
 =?iso-8859-1?Q?VM3o7+RyD4RJzA2FnVaCyJiC8UpTqTBGAwtZwEKFzGwR4QR89BqdZGLBUD?=
 =?iso-8859-1?Q?fzxwNBZ9KGkxvGQe+T2WE5mqtcXo57suqvUlDojjkIo8yCuts0ICIumr6+?=
 =?iso-8859-1?Q?SURQLMFztrGSvf+NIVNL5KJKwbcEC/02JxsKrdCRLqdYUxGjBSc4XrLSqg?=
 =?iso-8859-1?Q?Sd0bHre0O57FlAb6oSFouLQgIPCzOPvfBFThcUuMIaGenl7sH2w9QQVyfV?=
 =?iso-8859-1?Q?ZIBErAJMNIi21S4P/QAsAZjIsRpm4bOrf6wX3g6O7pOEUyeETH6svvTcMm?=
 =?iso-8859-1?Q?a5OJtHrM1bwrszvl7YFvLjyA5sdagjb7Rdy0UQpJq+zc+VF5+2Tyk+nslO?=
 =?iso-8859-1?Q?pyOs1ZPMY0cj+hJMISsMeRc1vwJlfKeQa77aU6sgmDG9u6QJkHNvt6CeyQ?=
 =?iso-8859-1?Q?xRGC10e/j6iMAjXCATYr/6HWdA4Qus4De7mBzNB059D+ZbacEp6w8tAP+v?=
 =?iso-8859-1?Q?XKjvCYPytwsylDfoMBO/Y+MoNLOIxwqSfny0KHOtARj3/0rV68tI4QFFWD?=
 =?iso-8859-1?Q?y9QjOXOTfDViTbfYXbsQqVHi4kyJoS6OXiNTV6Ts2EcsGIRhsG6JseIl6O?=
 =?iso-8859-1?Q?IJskuJ438pRnBrZoSB5Zw3C9yfvEcvww1kViKWJ6o8IpGvcsmJfV6FUZLM?=
 =?iso-8859-1?Q?cD/gbAaevskeiUDGTzYDgrwFHHTineDQt+631jiS2PeV6chIVNVUYMhcVV?=
 =?iso-8859-1?Q?+JJZB1nebei3/RXoP63dRrmRvisXiW8qgFT6aFL2Wo3ZaAfylXC4IbPR/U?=
 =?iso-8859-1?Q?ch5BwoC6GP0FLMr/vLpwxEiRowcIJ0SRuZ1/YLqJHqgZhwqbC/3Dp7Pj+8?=
 =?iso-8859-1?Q?dqpVSwBJSc6jpyeFlWg0cqSo0Jh9nMZ7NBi/FQSdw0YAP/dtfioXS5SI/v?=
 =?iso-8859-1?Q?IzB0BekgPMPGQVnAelwLl1R3QEmcDKlWB3fSL8RpFVJnOqqMsgv6psnZQa?=
 =?iso-8859-1?Q?c35w+Tq5hFs9pX1VDNNf1xjQKOp9PB6QY86vppZXU0N/E1TNNoc4tHfnsN?=
 =?iso-8859-1?Q?6A6k6yXT8PFne6asdvxx+cLFJx3pTVkbJRPJfPZJel8WyWArHzqfnMgQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <40813F418EF1CA4B9C885FA80A508F05@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c42d528-6249-4f19-ec71-08dbc086cb12
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 00:55:36.7945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iehf2C8iAY56OTOVOUV93k2M85tOrgfaNmlEV63Ugx2EoVvNfz/RKB3TllrEPxzRS8wtJQg8TE5SKbv5QzKo4OQVHavIw7UURWGtkYvmfDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8348
X-Proofpoint-ORIG-GUID: y2yjvuiv_xoD8-4INTK-Q-BBn9zN8eZZ
X-Proofpoint-GUID: y2yjvuiv_xoD8-4INTK-Q-BBn9zN8eZZ
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


