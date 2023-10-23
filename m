Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 114087D2E55
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:32:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurHp-0001ti-Vx; Mon, 23 Oct 2023 05:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qurHl-0001sr-B9; Mon, 23 Oct 2023 05:31:47 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qurHj-0004VG-Dm; Mon, 23 Oct 2023 05:31:44 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39N4WbRp018308; Mon, 23 Oct 2023 02:31:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=onjMknpyKfg/bSYVtyB2vr3aXw5+DwR0wJntMN
 OZ98Q=; b=GIJwgUhnAwcid3YPRXxwa02ItRcSYFp9TNaKbGzfHJix6ajfYZMyYl
 woxzTQq1tyGTql3PUXR6Tb71p01bcw2d6o1HOMH62YU0EKniAEu85QWr+YYOIEsG
 IVaeCsFi+wnI1XspfxZGDF1fjMDjQDStlhvCrEBvNGKmyOM//andkP8qwsxGSq1W
 L32svP68oneJOSVrXuOHwF89B21wTIorJFbXKPsPIWvWSs/Q5nJ/dQdpFEDgBCfk
 kAKX68PGBDWbuWLM2RKYvj4N49BM7DL6/a2GzPt9zy5Sjz21EdyLTC0xtdxqO9YW
 j7uc2OzKST2IrPtK7Xuo8drdBW+wMswQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tvayqtf9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Oct 2023 02:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNWUv8p52YNfrdkD/usH8r2dfSvQ3sXeIx+grdZpWW/Cdj2njHdaGCvJwKaDqvsIMqZrvNRKGC868LX8lYaM7dws8yVdJpStjI4aJ7Ln5SZPx+xnUjh7v8m0tl7zHhWa2dBImD3s1bgX5IhdT462E7KgEyrpF6L8DNcFMyMnFSTCWHsQj5/tbtNHXm41pfqTN4bOf1ThrkoqAzL3Y8M54LSl9/1nqGG78s0grfwlwtWoYN2bwpCiFyqvEt76m660qpfdzSsIHzQidhNaU65O64uY3SekfbCmqJ6FSP/4slo8T86Yh6vZie2bqeVIaVabor3zQlQZC0N0FB9lI3JnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onjMknpyKfg/bSYVtyB2vr3aXw5+DwR0wJntMNOZ98Q=;
 b=HzeUso3al4UBza9Kb0mcRiBMDssqgWY8Dt19UBReN4ZAykO7ufbUyyhJBkdLrv0OCZ5fEDlgsdwJ5wyAjrbleUH/9lZLSNS8fOpmF9eF3bGsceg2sGV6DGGuUAnk0Uw5tUnaILA4Ta2NUQ2Zjx3UBcoRqe9NXhz1Gu3Cis3UCRRCobPL4LA3KVBNwie2asE9mtxFDAgzuY+7u4QuZFsiJBtPPnPJ2M6s9zcbO48AlTTSu6YJVD53EtsuzqabXQxNbuPu/AqYn9nXwY+unqMp5kxyETggc6pTNvRKnIXyKY4J3q29sNjQ6wK6BETXeV9sxoJP3ORgFqGSbIeiBBvdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onjMknpyKfg/bSYVtyB2vr3aXw5+DwR0wJntMNOZ98Q=;
 b=oX7C1HLIZDbV43/rn+iiS/j08vPuQfNfu2L46NmlO9+I2bJ4sK2me4Ero6leHtXbrfwdMkdQHJbLiqqQdrrGlhAwnbD92g7pcar99yVBrSIVH7Bs3WJTf84Ddz5T6O/2fQI8MwCmqZ80+dmLVcMzbu2IPE8mRY4xhCqobETfN0QjtORGRdc1dciNuqAWt+u9UrGQuk0Q19AzLsi8zriNx/tmJ7iznvvwqWYGeMHzFdI9w8lhtO/a5w/s8mOp0ba+Rw7iJ/0jbFdpznvU4w0QXHN/rT5Y3Q42rCnyK14+jQUKU5mDz1+/Wf++iM3QreoBFAJYmuKno1PURnNz2+UwTg==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO6PR02MB7572.namprd02.prod.outlook.com (2603:10b6:303:a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 09:31:38 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::69bc:f889:2ed:d7fd]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::69bc:f889:2ed:d7fd%6]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 09:31:38 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
CC: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 48/78] contrib/vhost-user-scsi: add fallthrough
 pseudo-keyword
Thread-Topic: [RFC PATCH 48/78] contrib/vhost-user-scsi: add fallthrough
 pseudo-keyword
Thread-Index: AQHZ/aoeA1AiWMOu/kKLZ7xsiQyhRLBXLByA
Date: Mon, 23 Oct 2023 09:31:38 +0000
Message-ID: <1FA8832F-16F6-4917-B380-6D16A6086280@nutanix.com>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <f5ba45aeb80d3f41af2a5e2c87e8b212a7435670.1697183082.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <f5ba45aeb80d3f41af2a5e2c87e8b212a7435670.1697183082.git.manos.pitsidianakis@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO6PR02MB7572:EE_
x-ms-office365-filtering-correlation-id: 901da9c7-e4b0-403d-23eb-08dbd3aadb7c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qslOlJO6TorSI5RiETJnf52v5CSYILjpvtxidz707wNrzyLPItqFwZ/Q5GhDK4szUyUiSCUgmLuhm/B2V6xfSLzgAWSNPaZvQKH+Ng7u7kgFB1FPIaU61sQ87qcht5T5/Ams7ZCT+bk7D/7pmdiHeXZLtMXhfVMd9wjSGU+LIekTtVCkzGkm7C/0GUc7fH65IsCmSq/T/dVUfbk2QgVWS7nz8Xk0mpA7hF305mBHfXsKZOXgO+mhHWo/1M3P3lj5FeJOW1A+xHSCjJ6elft0sZuuMLPOp5wwHCA8+FhJcvz1jQ+mhkdy40mTqznrqtFk/iEy+GenNfBmkGoDFt69UrfB/cQnGAVPJryvgBVZivuMU6Cx6xQYebmq3vMPk+xXPd/49QzyZpZ6qo8a8ua5U5O3gjf6bbSGr3wQxuQp+QbuVbPX8pBiHM+/vC8rErF81vRkNBt1CYyOTSAuWuQQs6GuMzl40478niZaeYYn9n6j4tKsPALDe+0/VIqMTji05xItG9KvoYhG5pg7HZjObFmEang1K0i56Ujm15+aOV09aJjuLKwbTbaCnlcnCIdJWiCRuAsXM+dpvxCI6OVAbFx01hGE2KYj5szjlAWjbZZsceECXETxYVT+1CgHGV6RfUlB6yqtu86Y0pBmfGbPQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38070700009)(38100700002)(2906002)(41300700001)(44832011)(86362001)(5660300002)(36756003)(8676002)(8936002)(4326008)(33656002)(2616005)(6506007)(478600001)(71200400001)(91956017)(122000001)(66946007)(76116006)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(6916009)(83380400001)(6486002)(53546011)(6512007)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wyqPYuqbakpX/Ni0qedrwIcj1QbCre1pK/alGFP5dNiT5mmbdQAqvvhoncJZ?=
 =?us-ascii?Q?Xwst/bYNk6aGhtv57Yc8vQhGa4nFX6NA1vad7Wnungm00SoYNryvjLFHGGob?=
 =?us-ascii?Q?u0t1aAfA7DwvkLT5Ug7DpSsRumTgWVCCET9lUXOUgnhNBcp76xCJ1v/RVcYl?=
 =?us-ascii?Q?KF6akDQKddGHH3iLyYUvoUIKVtkNpFGChUiF7Xz0y9UXZyO7UJv5g3aBXqYs?=
 =?us-ascii?Q?nt1hcxAejVSuARDzh10m0Briu33mmhYBQXvG75ymaXEwwuC04inxgFCqrLkX?=
 =?us-ascii?Q?9Az0bsABJQLcs3JuL+u6245k9FPtUh8LLqCliWWeQ5wdPYyBcxiWIKoxt99r?=
 =?us-ascii?Q?J/HA4GtRYjj2gihDk4NC8okCfX2cf1FZ0MlTW78JrE8PfeYqv3AsyociDaQU?=
 =?us-ascii?Q?ujcXYmqfQx7wrU6/QVTKSJIheI5Irm9HvRtneHp6CQ75ulZDo8eTEf/30r0h?=
 =?us-ascii?Q?fPgDbewJ7KTKGtGhLHpgAcuN6F33jtitEex8vPQTE/upXe+oqJ4Szx/HswUk?=
 =?us-ascii?Q?2C9l3Ir2XkGOGQ39jxr+0RLp+LvQVOKl4R6mgqbuA1MVMVzoL7zKI3qc+xyG?=
 =?us-ascii?Q?qvCO+MZS1PHuhxr/ekCuSG37mf8Am4hSVWW2juG10XfuUOCKXGdbhagb+AqB?=
 =?us-ascii?Q?LTAT3o8ifdPV4JazvIrKpFCFWUhSe81o/tR5EeFL/M/aIRdbYv+XuSelHf1U?=
 =?us-ascii?Q?/Keub+Zoy8D+b8hpajm/3KZpvlN/panBQkqKtkruXWqAlBlQkmVW5u4gMkOk?=
 =?us-ascii?Q?vn7pbEIjnuMF41wsipamnzQztpNyFj/bdSEZ31/ID7F11feNWNecp6dYQV8S?=
 =?us-ascii?Q?rj6gtIHlFo8rv2OhLRiOWXEodAnTjfa8iGy1Ts+9nampxL37xj1d626uGD5M?=
 =?us-ascii?Q?t0+s8mOFMJsLkmbSfqAFYBDyPgHO6kfXPIKRB77DIBzNQwPxdkprDbS0GvMf?=
 =?us-ascii?Q?q1AxKIlL0OPmik/KwamPV3sxGQQrTaNY8hJRAMHaf2yWzS48TtibnDfPI7Xt?=
 =?us-ascii?Q?QGkEJ8apSqkYt0NhaClhDjSSH15QrmkJASiRgYC69r/gP4tzq7Xpupl/Xfqd?=
 =?us-ascii?Q?7WsgjMHZARUQd3CL7R1jSU3X9fMBfmrjFDY1b459TplUSmNvB92y6l0JmRmx?=
 =?us-ascii?Q?qNGdmHkhFg0LpzmWkqQt/Ikoxx6N/UG1shdLNTbfyXOA+kPHvdvbI5zetvrb?=
 =?us-ascii?Q?9ANGzuIVQ3afCoZkjOQEqVC/7wukq1p7YeVgo7TqSYGcQtKc2MsOsgpN3QKL?=
 =?us-ascii?Q?tfh0qDp0f+rIRrQuKnZOG1GEraEGTXvf0tWblwUOVQUePzu1IP8a58UwrZ+t?=
 =?us-ascii?Q?1ellC6Vpz22jM+zTFbLqmiKmliNL2lwXkMjYxs8rNCdxzkCbsZudZ/JoM2L2?=
 =?us-ascii?Q?MoLZvK1SCgKEjAbmDSJBGSCVxABtVSnpTMf4W72sB0reMdVWeZNFVyz1rh15?=
 =?us-ascii?Q?L+ZhFro5Js/uo2ZCjh3XdnvM5RcYLvX2YneU2ospw9fmfecwLMrM/mF7UPJe?=
 =?us-ascii?Q?2pCnH9w27GJ0j6u4kizeTWo4KDpr1vq1B7/tAj5jSH5VdmiQ/DSX2vZFPHss?=
 =?us-ascii?Q?tAnEZUSzRFfdaIkVJ9mz/jhdoA5DRtM8yqc6Gy0ThSp/0EZq16Easck2FU2N?=
 =?us-ascii?Q?tAPLAuYt36Ls7jd9gb60Zg6fcquHVrDelN3K7wTFh9RUD7SEOazfhg8cE93r?=
 =?us-ascii?Q?/Oq7NSlHef5ITfUmHY2x1TcFIx0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E9B73E02BA10A489C0BB9C924D2DF8A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901da9c7-e4b0-403d-23eb-08dbd3aadb7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 09:31:38.2825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+ExXhpY2/yNSDAUccWk/1A9clBYWyrmh4wIxYxOh4bvSLSeTL1FHDfFfjQYSirSW1zTKa3uS0BLAlUFske0mJFlIbSzR6O7jgD+NZDmCpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7572
X-Proofpoint-GUID: mkgO1tXfpptOL0FzWK5V073oll7vwwSC
X-Proofpoint-ORIG-GUID: mkgO1tXfpptOL0FzWK5V073oll7vwwSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_07,2023-10-19_01,2023-05-22_02
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



> On Oct 13, 2023, at 3:48 AM, Emmanouil Pitsidianakis <manos.pitsidianakis=
@linaro.org> wrote:
>=20
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
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


