Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA527D2E56
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:32:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurHn-0001sI-M6; Mon, 23 Oct 2023 05:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qurHh-0001qd-Pw; Mon, 23 Oct 2023 05:31:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qurHf-0004UU-8n; Mon, 23 Oct 2023 05:31:41 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39N8QgK4018728; Mon, 23 Oct 2023 02:31:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=NVSth2NMmkh+CGzWO60K104GyETlS8BzVTqdyG
 dCcTI=; b=gPWmuMCzVlMdOzk97MuQS4G8bVD6U3G2x+r1HdJELjjR6sVSm3kn0V
 0B657Izu5PFvEQ7PMNg+kVYZWJHsw+Kt0H60bV7wLBgUJH4OLyI4kecdUy29AlR4
 ZMrvC2VtSKc5AS8H0K4f5NDHXARqvLGabMzMjCmnWyWyeRu7al6TOdvm91T8UVRv
 BmTxQKlALF9BlVpsok5MxPXOnrX3jIqsJNtiqfrXhnsynK83XAJoYOcRR+yhOWhl
 CNsyKhhRbUVtt0ID0mkvSoHe2M8w1t2NIV8Fd8j3HIb8Y6UGAtqEi0VohCMjUsb7
 lZWOTJ2Qje/lAAB4HbnF5KUfxecF6jMw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tvcrejty4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Oct 2023 02:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBmvqmyyTFXtC02JwFZVkHpqHBN6QUhDN25pJDTg6cUCpkH9IcZMATC+OhkCHqosWEmWGFPlO1bZ/rG78Ku/1KPfP5M9cyWhYDxXixvNSilx6ljMxYaXQ1VEAo6X9rHCRmE363rSNiqG6e0BqrdUDNqU8uK4UmNDfx5lU1pOzBx02pQiw9orJd3/8bsDLPZhJ4srwQdRgsgD3yRL5bexhA/TNXfbbHAKqtJrqPygQZ5wEQIiPrIeLjYh6KBR0NLzLqMYpn8+M7hR8N4h2oxsqXHPKQl9wlYEKQ+eLfJPXkJqmQKZVkLJ6OByD0wOMr/oQ9uGVNsoDM+RUQg2JKlPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVSth2NMmkh+CGzWO60K104GyETlS8BzVTqdyGdCcTI=;
 b=THnfVxEz6YeRLBUudk06HH65/AfpaND81N0xjvhB/RqwIBaKo1hfEuxUYVbZu7q0wwDSuaCwxCwtbW5erYOLPcnm5sydBUslGNuOxNkHtN20XzMjvE09AdOAyNpYNJeARLWqPTvKKCmqIATRRTYiyD67mQ6JAvLLzKtPk23rROLc9yt3Acx8XobBYXU7ajTy/+pR5+E3PbybQ+ZElbjp7xPNVb43k+tHNhsyWSRw957rE7WBrQi+NviWeoWMBT2vWHBaYVIF96D4JHQ1E1aHmpL8NoHNrVqMY+A6LzCeyCmEOJ/3IdvXJRDCm2Pi0pcJxtzpCE8eFAnz3NsFSrr/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVSth2NMmkh+CGzWO60K104GyETlS8BzVTqdyGdCcTI=;
 b=Vm8QjLNuRuLvY2kC/0xeTIwCa3g071465wqs+6qzaH55ZX6RL3awzBMPoJm6U/GCt79AGOjhjyiKTrkGgvlE5ApUo+bBO7xWEH1TE3krQV0516NsjqsV1yfXM9HH+lJ2bjcnZ2fWyiKpT0vj8r+BsGnPx51S7LAHOWtMhhtb9cZgp3SLzi7vi5EifnfPXYJJiHP8CkhUfrtEyd39bzYUSQa22Ef4l2iVToDEXTwDIyxDp/Bg64q45jAZmjvjJFjSaTY9u/tmOn/EeUihh2jCynAkxswI8XlfR26QOa34H1QvklMbYjj8IT2VD8o1xaT4a85mwvulPU6m6D0n1Q4kpg==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO6PR02MB7572.namprd02.prod.outlook.com (2603:10b6:303:a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 09:31:34 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::69bc:f889:2ed:d7fd]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::69bc:f889:2ed:d7fd%6]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 09:31:34 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
CC: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 47/75] contrib/vhost-user-scsi: add fallthrough
 pseudo-keyword
Thread-Topic: [RFC PATCH 47/75] contrib/vhost-user-scsi: add fallthrough
 pseudo-keyword
Thread-Index: AQHZ/aocB7fmaSDSMUmZEeezEtcwFLBXLBeA
Date: Mon, 23 Oct 2023 09:31:34 +0000
Message-ID: <D40F00D9-DDA6-4577-A8BD-96F08F8DE034@nutanix.com>
References: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
 <b9b8043e46c25e0c209c2f96e9b8b44f40133fc1.1697034504.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <b9b8043e46c25e0c209c2f96e9b8b44f40133fc1.1697034504.git.manos.pitsidianakis@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO6PR02MB7572:EE_
x-ms-office365-filtering-correlation-id: 08ac9f53-36f4-4fa4-03ff-08dbd3aad915
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZIQDDSkR6Nb7fFt0sroJxHpLMz3CSSoVcN9n3K2G8wsWdYIwtd6mwh0K6/ZMoF2/QG3oy+jewNFRtspGrYOValOxYfwxqXBQ2wm1XkTSra5X8UMqWVoWfqwtK+5DE6mbfV90rJWgDNMjhc6GsIKS4DMGwg3RMdMCCZLqHipwie2UKVCF+aa+bPeoV77hjWefYNISiARu0QxtAmkC09PsSBH4ffvqv/Ze2x4Q/YXVpVuUV/GPqvOsUGctX09Vnqk3uOahwohel2qRvj7rOH+Z6VtSEhmwMEkGZuyFnw8B2BuXy3c994RZ+lLpp7JRLJYCAqxEauyaS5niMk2+fNaPMxvwp3UbELy6ttbn7RUuzFneSFkZqmIPcZccEaMSJgHpdIeu55peoZs541kBneb3U+LIAa0zu+oQEdDcxCmfrNDTCT+WijVx/wULzhaMCrC1L+iq0YpfLlkx9krqt5RlKiI7dHx0Si1qiMx1Yspd0RG/m0t1IaVVcgldAcAMI7srKix82/NLhcgfhM7S47VLdTeube0kPWG7wvRjPOBvUix61qOIVbKbReJi0ZJ2j9JWrmdu57htFAYVxcvLogG6zbhbcxDAhz/aalFGZ2siSmkeQm5gjfJHe+j/X3PqHeSYIYrsg5pJhbiMNvj6vqQ2jQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38070700009)(38100700002)(2906002)(4744005)(41300700001)(44832011)(86362001)(5660300002)(36756003)(8676002)(8936002)(4326008)(33656002)(2616005)(6506007)(478600001)(71200400001)(91956017)(122000001)(66946007)(76116006)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(6916009)(83380400001)(6486002)(53546011)(6512007)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?So+63OKCrAc7Y41I7/7OXqOLTNo443YIbLJitJyt03XrYkch4KQx5HbHYa0S?=
 =?us-ascii?Q?zPNJqOewVBuV3rlCyonynkkKccNYgqy5CRHr1oU0jjyNJ82EhS9BZ5gkYlIY?=
 =?us-ascii?Q?VXQW7I2wlkbVbLpEwjfNtrjNyP+fADeCk1IeTFV02/y/6Fljw3AFfvu1Lu2G?=
 =?us-ascii?Q?fPLSfqXsdU1LaB3FhG6pZYcXbKgty0gIiCqKsfgVvTcLKuYatkim+0sKKFII?=
 =?us-ascii?Q?NRuzNSyYSMrXhqZzs5L9lDEI6ladU4mbyMtJCLyXzJPs9hzjsPO6h2E4bi02?=
 =?us-ascii?Q?S/lJp3cvF3XUAZ2cmuiU/DfxDZpAAq+9vltD6MsCA9wO5v2SKlofd/0j/0ZX?=
 =?us-ascii?Q?AcMupVDTgl5bxT/0+YGi/z4eUBkye2ijb5coBz75W5Xu0nI1lTLxvvd0CZzN?=
 =?us-ascii?Q?QYwB28xRp4jZ1duRfXsrz2xaow7HGCeQTDY8kJqa4/i+GHYCpPuEyGAUo80x?=
 =?us-ascii?Q?SA5NX2SIcXO0W5ocSvIEOJWHDtVTJ6bYkddIqrqfHwG1unazgW7VbnGLi37B?=
 =?us-ascii?Q?8NjOzGAvUJY4Y9jXHEAdD5jN+UWERbe81MyY8sX2x5JxoyKsDxHBm5bwTqM1?=
 =?us-ascii?Q?q+NxAANyNLEVCShA4+U7rj0DYxYtOwLpT8N+t5rQ62TbgRQQqnHs/3fZJokz?=
 =?us-ascii?Q?iDjV85DCZR5boCjIsJEc3z+Fdw4Ic9PBJlWScAuLkM8+LuPTjEKp8RXAKHaj?=
 =?us-ascii?Q?k6zhv/ptjOJHIlDti9iuTcMIxFBshfVAt8jjeVdjGFF+21YtyTAWHeTmdiGn?=
 =?us-ascii?Q?LJptiRwrcInHwxHwFhq6pxQiICbrPObz8lSN14izbJxVjDMZsgWtJYJjbw6j?=
 =?us-ascii?Q?BwwGkyHnkPdiNeZHRobmZaGdcfcI2woBWcYiQa8DTopJVBInjrM0YO1iC457?=
 =?us-ascii?Q?B5VeqaVV9yr29z5RmZGNJZMq+fpp+l/UDf+slute8CMyIcYvdmjGVZ8K59c+?=
 =?us-ascii?Q?iaMHqGv/quEvPz19sFcEtBCAapk74eKkY8QbIxmMJfzvtOmasHsKKHumJLzb?=
 =?us-ascii?Q?sCceFRQxSVKoAw+SSxn2EWKyeX2C+j6bwvB1RGd80j4AKd4nMjNcoR8ZQmQh?=
 =?us-ascii?Q?3LnJ0+M1pvP5cGoiv3MNL9XhJGqrsiSJlajfbO4mXcloQs+yOL5PMHVozxUT?=
 =?us-ascii?Q?1vVq7B/3+CuIoP2YC62Ue7u43ZFgAU6bYVCq+XkHFye1Ae5sBYn28I/ae2Gb?=
 =?us-ascii?Q?l7h0oIoWnqAjCMlGcRm/lAgFoc/9t7rKMuRSUjHizwerFtT1u3KKr7JT5xHH?=
 =?us-ascii?Q?bj+B22YQg40yQBDduRF49ECGIlfLznE+7erZIfi8zQl3+2J5FuAFLUYobiFD?=
 =?us-ascii?Q?1+HMpc3uS1Q3jDr1HR4hxtmdpmgqZCHMJdlXWlNV1O9CJvM+aaOefPM7J13R?=
 =?us-ascii?Q?qEVoBlG1zQ/YubnarEsBLv0Tv0oUnzMYWHg0a2nacZvW2aRL1ORZR0Azy2UB?=
 =?us-ascii?Q?aow8XUQrkp48noNwN7FsgZbHaF1Q0X7LxCEFL64MLLMeBYn174FB8asb46ul?=
 =?us-ascii?Q?yQhxmTRVLbw4CKzUMl0OxMgEpAlcKaKzQUrNy/j5WtBFKbt7vEO2cTf64hs0?=
 =?us-ascii?Q?fopbYey1qD0IG8SUeJtdjcx8XbsrmfhWYODQ16CjYlwhMqgVThjHBuI+Wygp?=
 =?us-ascii?Q?YJZCTS0Baks1AKpzsi6MVgL7oMQRWHBo+WNILcr9dmu5mmgxDCCDO0+0jm7a?=
 =?us-ascii?Q?ak7lR6CdIKUn8ZZkc4XPdRPR9QY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9446855C6257344D97151CB92A4AF741@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ac9f53-36f4-4fa4-03ff-08dbd3aad915
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 09:31:34.2742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qznSuzRwo8dJCWsOf+X1cMKeHjcqFiiYQdWu7+3ZFr/9tEe3Ww6Hetg6XKe49RKUJyX9O7e3p+X7I2vq7pllsbKJtOOt6s0lfLsgdLmZ41M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7572
X-Proofpoint-ORIG-GUID: ebOQb08-OxWpsyp3_Yf_EQww5RHzKKIF
X-Proofpoint-GUID: ebOQb08-OxWpsyp3_Yf_EQww5RHzKKIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_07,2023-10-19_01,2023-05-22_02
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



> On Oct 13, 2023, at 3:48 AM, Emmanouil Pitsidianakis <manos.pitsidianakis=
@linaro.org> wrote:
>=20
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
> contrib/vhost-user-scsi/vhost-user-scsi.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
> index 9ef61cf5a7..71076f579b 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -109,14 +109,15 @@ static struct scsi_task *scsi_task_new(int cdb_len,=
 uint8_t *cdb, int dir,
> static int get_cdb_len(uint8_t *cdb)
> {
>     assert(cdb);
>=20
>     switch (cdb[0] >> 5) {
>     case 0: return 6;
> -    case 1: /* fall through */
> +    case 1:
> +            fallthrough;
>     case 2: return 10;
>     case 4: return 16;
>     case 5: return 12;
>     }
>     g_warning("Unable to determine cdb len (0x%02hhX)", (uint8_t)(cdb[0] =
>> 5));
>     return -1;
> }
> --=20
> 2.39.2
>=20


