Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D4382D463
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 08:02:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGyU-0003qU-6s; Mon, 15 Jan 2024 02:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivam.kumar1@nutanix.com>)
 id 1rPGyO-0003iy-3K
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:01:29 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivam.kumar1@nutanix.com>)
 id 1rPGyM-0003BW-1a
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:01:27 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40EKxHI1020534; Sun, 14 Jan 2024 23:01:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=7pNK3FOnJWA3TfvzXY+F1bnuDVLECmep2uZGkg
 buikw=; b=shBXbDwb2qp9o8yh/1RG1QtwyT/UW8PjMHBP+v1p6ikiKaWJlwJPWh
 xdsUkuNoO9CSXTZo/7my/6v1abXCl9Uk96QGJvB6qftKp2UaIZaWqq0gL50Tsh/S
 RkIF0ukOO/YtpjGa7eiIQaz2l/po20GNpE06M5+K+6MiPzNHXVi/aIbu6Q/+DMWv
 Jdu18pfJP7C42zE/LJPwpMN4RV+kDH0jQtmGEcb7ak5M19ax8xkOq0lpStQbqSRS
 VCD2aiLBxQWTDSVnrgdUArmcEKbBflAb6HMOUsR/n24YKzkBVfiP7C4g3IBxN8e4
 8u2+zZDFGU5fxj9eqabOpbOArS2sYljg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3vksgnjbsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 14 Jan 2024 23:01:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIs/A6QRQ/b8+WcSc6TMMQs0CPNb23T9VL/rkcn9jT7MY/DTjVfik9avADSl114Rqc9Iv0PfxXy8En4MQxm6Z/xNeQ1hdecQSKRlwck/TaFkytwxCLBDUyEuBUOT76OD5N8M8vU9n+JpSok1iOe32KyLZbhWVId2JCec942KvCzAHY6COqr7boPicWoNORcXacIV5z4Rrh1B1Kbe7TQNjYF4HPBA6N9rAdsQpSfxQ7wJaiNiyIeULY+dwN+2T5kbildOjrd8+iEPUK9vlOELgFPmBF9AS1JsJqGkAviejPFWrhNcVsF1rqDuBhpAYyCywvTVkkLMKojQUtikTkBI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pNK3FOnJWA3TfvzXY+F1bnuDVLECmep2uZGkgbuikw=;
 b=hZ3mTn7myJSSbGGE44WXHrg5Y44Nw3WvAPc8Oj15hwWYFuYfkXdZ1QWimhta1r8/vaA2WmuvwZKVspQpUO2LMgm69yLStaUkqK2LqILoQRg7kM8zy6sA7Ku+zqiKT4D2aauuzFq4TjNxFw/zYopMB0/yyhBUC4rXVLJfZlPrzhQqU0ZOnvPSVZogn0UB6NfBzk290KrKEBXEKxbOhjNv2FWnwwjhoBQ6VIpm9aQxRHn1xJHY3xKAEfj7NlVTIdT7CJgl8BWxxC7EVX8gGqAHKZnZryfCyYQIndUGvL4+MVeXcmJhTNgxc605Nowj9CpsRaSbkn4/QfPHSmsjVNgUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pNK3FOnJWA3TfvzXY+F1bnuDVLECmep2uZGkgbuikw=;
 b=egzvOfy3o0ZkMHPGXU738v6+0rC4YGdELDFhQXJVs5BcC3V99Kl29g2Az+qvIovOLerPHLgO5kEmDTiYpNdGQlVD7gtaVuwREY+30YW4bUGvV9xFiCXtxdwflyJG/sPvb794v+Ibc5vZYCnRqMig1ou365MLqE+Hfmiy7Gn01cCw0UDNmhwRBvudplPLQDT6seGIQLqeo1fDW9jWAS9q/YL8WlrVVdMCc1gvlw+P3gTsc6swwcSUOOgodJKIBDgGwFke0D2fAnttE8o7yrMGSBS3MJbL5ad2VFX+hksnYQYqwWtMsqW3r1N2FbB3EKgQ2Akle+Kc8sRzU9fNPFrkNQ==
Received: from CO6PR02MB7555.namprd02.prod.outlook.com (2603:10b6:303:b3::20)
 by SJ0PR02MB7744.namprd02.prod.outlook.com (2603:10b6:a03:31b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 07:01:10 +0000
Received: from CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::4a9b:daa2:2dff:4a60]) by CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::4a9b:daa2:2dff:4a60%3]) with mapi id 15.20.7181.019; Mon, 15 Jan 2024
 07:01:10 +0000
From: Shivam Kumar <shivam.kumar1@nutanix.com>
To: Hao Xiang <hao.xiang@bytedance.com>
CC: "farosas@suse.de" <farosas@suse.de>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "peterx@redhat.com" <peterx@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela
 <quintela@redhat.com>
Subject: Re: [PATCH v3 03/20] multifd: Zero pages transmission
Thread-Topic: [PATCH v3 03/20] multifd: Zero pages transmission
Thread-Index: AQHaR4Ce8Lei12ypW0q47JLgxG4F4A==
Date: Mon, 15 Jan 2024 07:01:10 +0000
Message-ID: <2EA69F35-5AEB-4A0B-B7AC-7D650C1CFC1E@nutanix.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-4-hao.xiang@bytedance.com>
In-Reply-To: <20240104004452.324068-4-hao.xiang@bytedance.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR02MB7555:EE_|SJ0PR02MB7744:EE_
x-ms-office365-filtering-correlation-id: 5a6fce4d-3f3f-4b99-c615-08dc1597c12c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QgdIMw7sDJCd3GjamFmEUQMIG6GkMCRKITf/mkrYREE5ORradfjG5n97WQyQQqPcuQD1CmW/ne+eUBopbohVLdmyRyyZrk4kzOPv2Fjs79TyJ+3Q9qHaxLBMZ6YL7FXddaXLTUpxrUFDhiBK+WbVvYQqhVfWqcoPAH97QDoY8mZdBp+v6mEOVjI5ysrBbhvNcRBttcCpdoZ3waxVX0r9fq9qq4uad5MKQWcmHNaBDXpZmlmycJWLm647tRwj5dX/cDe2nNmCbIVqpfL0yc8MuHY0os7FOw93X0nuIuN3z4+rupENyB1CQZvvAXVXzqJWcPBIEqyUyonIXndnY+dKHRL3GAp/7fG3SeqQh6SNT4ZMu0YynmET6M30rxI61cd920fLZ8KH8aeXzBY9BkZAQJt03ZWDpauB26fTCw7gOUGtjdI047FlqAh39cJ9pT52uuAnq9tzdJCODKoxPF2d6L92A+jobxHDXByHyfrBCzox+jn97ub+zVD6rR5kXHbGi5wnASSaulRddvSsRGtJo1TYUMADzp94rrBVt1bigNEj3LEiIuP+KNnWDOyBYlPQNC7RcIdXntKv4a6BLJYM9Nr2ve7RoW3hp5JMeUbalpgm/ssS6o9CJjtpFIkT2To5FjO5fplBrPpfmwmsoEP59g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR02MB7555.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(71200400001)(478600001)(6486002)(86362001)(83380400001)(122000001)(33656002)(8936002)(54906003)(66946007)(4326008)(6916009)(36756003)(66476007)(316002)(76116006)(66556008)(64756008)(6512007)(8676002)(6506007)(2616005)(53546011)(66446008)(5660300002)(2906002)(41300700001)(38070700009)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9doabQEuiTchvRACTl25zMGTjBvampmEgZ+5lSlOsNE553O6sgkwPuCgmRah?=
 =?us-ascii?Q?de+goqJdBNqDq+vA5mjHQtE+0EnrR00GuhxL1yRSe7vuWC1oDTHzLJg4DLWk?=
 =?us-ascii?Q?Tk1Ye8bTkcjq9w3FOSx9LU5FzKEdLVr7tZU7s5IHbCrqpl9gAwxIHlszVILH?=
 =?us-ascii?Q?mjMLF4Dl09njroQlDjWGPLYmjmBxw5W3WzmngCQ/LnwfT3oKAw+plG5rEnfw?=
 =?us-ascii?Q?5fVHBLX5WbJpkM3ynQEJPhpisQGsKJS6pQPSSCCGSVwBMRlMi9F65BwQmCp3?=
 =?us-ascii?Q?UUHLTToEfFIf+RiU8FBDrPJr8WGcAMibke/aGiQ1qR1Wq2yzxWFLVW2K6Mdg?=
 =?us-ascii?Q?CfroN2T9be5lDxirqBtttFYN96jwuav8lWvJefhytN9mZvqHo9NDTGg03sYy?=
 =?us-ascii?Q?InlGKdVJ4WGg/Yd77exEKH69+hLxFGDKKfBtDGbBWhzH3LBvVTfIvQ7XE/Of?=
 =?us-ascii?Q?g2q+pErjsDiHIrUsSYIcVZtvNXtg2GoOVnuJOEzYFxLEa71LqnK3EPv/dmFu?=
 =?us-ascii?Q?wpP+4AQFuznmx/ar30boz6JLTu2nQsMOLz9hR75MBpw4UjtL4H0aKlfaB3qp?=
 =?us-ascii?Q?00QCVXi5EtxymVM4t0fbG2UCU1uuXm5Erom3EzqNYI4GL7IfvwPo1mt6MlLF?=
 =?us-ascii?Q?iE2hkQpW1XBd5Lo8dc2gAAlwDVdciFd8Jo79H3bxDuqxew+XqfgJgqUh0r9u?=
 =?us-ascii?Q?hOCtqu4QPy9zMWCMxOaxYFysZpXd1pe+3+cHpstwS207TiV0qAGxRKYwGRid?=
 =?us-ascii?Q?ZcOML1yPrOSekTzKQpNKWH2nQAxEzoxTJyL0hEheWYadUXE8uftFl3cUkny2?=
 =?us-ascii?Q?/+aZJCIyT7qqgtedqmUQlvXFG9hxS07oax72H1VjjjYdT/KhdWeGPfK0DBz+?=
 =?us-ascii?Q?B5+6q7ZbTOYK6TzqTf++BeOiXy+cuziCPPTovxEUeE7rvNbQjN2e3/oJtwFr?=
 =?us-ascii?Q?EbsAORYi+24VzUUFBEV8cGQK5YZoxh19nv0Ef4sL1BV8yoYaVUCvuDTwuxmR?=
 =?us-ascii?Q?6JAHJ9bQ8KaBepuC7feXIFWQLWlmOTaoXawvxMiuwYUseulMM6/uevJqPUJx?=
 =?us-ascii?Q?2qngarG7jQhFEn3ZvC6IYONn7sRP/Q+HWZpR5iCFqWL4x142brLdfv9lXszK?=
 =?us-ascii?Q?1LuzCKsYHQpgr6UDCKETQXAhSEvJy0Ma9PEqu5u4juntqG/BeUppKMm3E8G/?=
 =?us-ascii?Q?QxSTB0sv2kic6pYZFCFdDLyTcgx9WRCcPoFYgMqjKzsNHE67devBB8t1HT5t?=
 =?us-ascii?Q?6cWFPlfHirRT2tzOQMrPtYZsr69yXkPfHGTkylRC5emgc/Ygmj+Ugndq3kBD?=
 =?us-ascii?Q?evEwNCnaliDeIkRJy0t5Jz+WX43nPEREvky1s6a0zBNhxTZk8qNtQbTaPkX3?=
 =?us-ascii?Q?lwYd6Y0FehZBT1T5ZetkEu2I5kZ+OcZgUyn2ygxiAntw7nxX/e/XUOBmBlTe?=
 =?us-ascii?Q?zDS/j2h/CsOIrwDt+tCcCXKRWKL4rTjnaaDiFx1SGkas+e5rh4pwWkkA2v2W?=
 =?us-ascii?Q?YNSZk1wk45kNhpRGD+1uOLZ+9MCK71L5q1Fx6fKrvF0O4ftaFlCvhJcBvLtf?=
 =?us-ascii?Q?oL/17RT70fIy8b6DmnjswLx5zpp2rmFwJ4eK/nMjlEEQvOsiDa6IWhOjxXd7?=
 =?us-ascii?Q?yjAoRmZs81O45t853ABJ9iBlOzJOifkeDIm56120xItBwen7SU8VUjAKPynb?=
 =?us-ascii?Q?PEqvbA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EAF2A36B82BCC040AC23AC181D3EC902@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR02MB7555.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6fce4d-3f3f-4b99-c615-08dc1597c12c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 07:01:10.4768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQNPanN3J5XZFUQSTAYO6JQ94CBnOr6U7W6NIwQ3tD7y98Ic6zA0ZtshEWYHFBxykrHm2HU6r6PQG5H8SHLx1xkzL4XZ68X+10xSfixJnm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7744
X-Proofpoint-GUID: lkBi0B1UO2cVwMENMhmH3FnwYVtxeOoh
X-Proofpoint-ORIG-GUID: lkBi0B1UO2cVwMENMhmH3FnwYVtxeOoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=shivam.kumar1@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> On 04-Jan-2024, at 6:14 AM, Hao Xiang <hao.xiang@bytedance.com> wrote:
>=20
> From: Juan Quintela <quintela@redhat.com>
>=20
> This implements the zero page dection and handling.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
> migration/multifd.c | 41 +++++++++++++++++++++++++++++++++++++++--
> migration/multifd.h |  5 +++++
> 2 files changed, 44 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 5a1f50c7e8..756673029d 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -11,6 +11,7 @@
>  */
>=20
> #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> #include "qemu/rcu.h"
> #include "exec/target_page.h"
> #include "sysemu/sysemu.h"
> @@ -279,6 +280,12 @@ static void multifd_send_fill_packet(MultiFDSendPara=
ms *p)
>=20
>         packet->offset[i] =3D cpu_to_be64(temp);
>     }
> +    for (i =3D 0; i < p->zero_num; i++) {
> +        /* there are architectures where ram_addr_t is 32 bit */
> +        uint64_t temp =3D p->zero[i];
> +
> +        packet->offset[p->normal_num + i] =3D cpu_to_be64(temp);
> +    }
> }
>=20
> static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> @@ -361,6 +368,18 @@ static int multifd_recv_unfill_packet(MultiFDRecvPar=
ams *p, Error **errp)
>         p->normal[i] =3D offset;
>     }
>=20
> +    for (i =3D 0; i < p->zero_num; i++) {
> +        uint64_t offset =3D be64_to_cpu(packet->offset[p->normal_num + i=
]);
> +
> +        if (offset > (p->block->used_length - p->page_size)) {
> +            error_setg(errp, "multifd: offset too long %" PRIu64
> +                       " (max " RAM_ADDR_FMT ")",
> +                       offset, p->block->used_length);
> +            return -1;
> +        }
> +        p->zero[i] =3D offset;
> +    }
> +
>     return 0;
> }
>=20
> @@ -664,6 +683,8 @@ static void *multifd_send_thread(void *opaque)
>     MultiFDSendParams *p =3D opaque;
>     MigrationThread *thread =3D NULL;
>     Error *local_err =3D NULL;
> +    /* qemu older than 8.2 don't understand zero page on multifd channel=
 */
> +    bool use_zero_page =3D !migrate_use_main_zero_page();
>     int ret =3D 0;
>     bool use_zero_copy_send =3D migrate_zero_copy_send();
>=20
> @@ -689,6 +710,7 @@ static void *multifd_send_thread(void *opaque)
>         qemu_mutex_lock(&p->mutex);
>=20
>         if (p->pending_job) {
> +            RAMBlock *rb =3D p->pages->block;
>             uint64_t packet_num =3D p->packet_num;
>             uint32_t flags;
>             p->normal_num =3D 0;
> @@ -701,8 +723,16 @@ static void *multifd_send_thread(void *opaque)
>             }
>=20
>             for (int i =3D 0; i < p->pages->num; i++) {
> -                p->normal[p->normal_num] =3D p->pages->offset[i];
> -                p->normal_num++;
> +                uint64_t offset =3D p->pages->offset[i];
> +                if (use_zero_page &&
> +                    buffer_is_zero(rb->host + offset, p->page_size)) {
> +                    p->zero[p->zero_num] =3D offset;
> +                    p->zero_num++;
> +                    ram_release_page(rb->idstr, offset);
> +                } else {
> +                    p->normal[p->normal_num] =3D offset;
> +                    p->normal_num++;
> +                }
>             }
>=20
>             if (p->normal_num) {
> @@ -1155,6 +1185,13 @@ static void *multifd_recv_thread(void *opaque)
>             }
>         }
>=20
> +        for (int i =3D 0; i < p->zero_num; i++) {
> +            void *page =3D p->host + p->zero[i];
> +            if (!buffer_is_zero(page, p->page_size)) {
> +                memset(page, 0, p->page_size);
> +            }
> +        }
> +
I am wondering if zeroing the zero page on the destination can also be offl=
oaded to DSA. Can it help in reducing cpu consumption on the destination in=
 case of multifd-based migration?
>         if (flags & MULTIFD_FLAG_SYNC) {
>             qemu_sem_post(&multifd_recv_state->sem_sync);
>             qemu_sem_wait(&p->sem_sync);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index d587b0e19c..13762900d4 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -53,6 +53,11 @@ typedef struct {
>     uint32_t unused32[1];    /* Reserved for future use */
>     uint64_t unused64[3];    /* Reserved for future use */
>     char ramblock[256];
> +    /*
> +     * This array contains the pointers to:
> +     *  - normal pages (initial normal_pages entries)
> +     *  - zero pages (following zero_pages entries)
> +     */
>     uint64_t offset[];
> } __attribute__((packed)) MultiFDPacket_t;
>=20
> --=20
> 2.30.2
>=20
>=20
>=20


