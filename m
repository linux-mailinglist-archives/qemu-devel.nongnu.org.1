Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B68987A4592
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAHZ-0007KV-7x; Mon, 18 Sep 2023 05:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1qiAHW-0007G6-5V
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:11:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1qiAHR-0002ve-Mu
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:11:01 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38I6tlcr029853; Mon, 18 Sep 2023 09:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=EJ/1F1+POgNOcwb1YNci2DoCdj9Z+h6t1v4m5/E8fN8=;
 b=LGLqzhFU0jhcrW6bqqyTYQQ7WxcC/03PuepwVgq3udC63tYmEei9BGQ0VBrGKS+fj46K
 NtzAOVAgd+5Hlwn8e0VYLGnFnWLCtiOQE6FMB0oXFaehCTOzZzcApbDDsmzyDtu5OCDO
 3jIt7Z0C7unuY/9Poh89NjFhrFReGgfDlGJFheiMNYdwgqosZDoKbps5ZiqqDUW6xyzm
 MZ8Sd/LTxYAOwoL5aCjnb6u98dNvJ47iu9RjusYeHjtB4wmMMCuKM+gRlVjtwCgofCel
 u7MombQ03+bu4LAGVSJIV9XG+lyVyoYCEjBUHxMWWheAS+SFS8gUrraONFQ95+TvSysr vQ== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t554pjp4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Sep 2023 09:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWQ2stQd2h8ogYujVUZnLTgEWAjl8JUcb2j7wtvRgGtjxYhzbAS9BJtUOYp8Gufv2ytNUmemZ8KXlmFi3+JBxbvttSK/ijCOU5jgG1uwF65HOxQi1DpKsBDNKjMj8uEHI22t7wP4N1BkZMSBH5eEw4qVp5NXSAYN2+ms9n4NfsIZUceNvqVNJyMHLNOTortVQnfC37PZ+5DYsc3gMcBaJn5rx5P2s8H1kan6e3gMDPmWT7Au7xzgN20f5kQRwYWFi7i2FVVIA+g/W9+6xh/ShUOiO5sm3S2bVECYSsJ3OlAIygd8SqAEeShFCAKnKe+SyhkKezGIGBd+5Hj721Jfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ/1F1+POgNOcwb1YNci2DoCdj9Z+h6t1v4m5/E8fN8=;
 b=h2sITGTC7asHrOvuPoFVvUmVDvmdMkElcufspVcGXCzhUXbkVVzLM9Xbso3x+TSvEDiqwIhhR1S+sP6zf6HcMXQowlbG3zlwCm1rtygSiDx8YHnwPGH473+tNRud2U0dQ2QVLyMZmig5gpCNBixuwZxDK2auaHVKsswRUXMXNJKMB3K54UhfsOMht0HvvwJTNuZ859FachseROsOnug2QS+405v9oEiB5XYW1h3MQHseX/JPmQkPahSJmQp1Muzc+MbiXQ/PYzTBB6sQkFAJhtMMOoVDGCsu2yAUKKUQ284Gobrx0PsR9+3k6ex+e/U7Zhp90fDHIkmDeAzooVu2wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9884.namprd02.prod.outlook.com (2603:10b6:a03:53a::21)
 by CH3PR02MB9140.namprd02.prod.outlook.com (2603:10b6:610:144::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 09:10:23 +0000
Received: from SJ2PR02MB9884.namprd02.prod.outlook.com
 ([fe80::a94f:6abd:3103:4104]) by SJ2PR02MB9884.namprd02.prod.outlook.com
 ([fe80::a94f:6abd:3103:4104%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 09:10:22 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: Juan Quintela <quintela@redhat.com>
CC: "f4bug@amsat.org" <f4bug@amsat.org>, Joao Martins
 <joao.m.martins@oracle.com>, Meirav Dean <mdean@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "afaerber@suse.de"
 <afaerber@suse.de>, "bazulay@redhat.com" <bazulay@redhat.com>,
 "bbauman@redhat.com" <bbauman@redhat.com>, "cw@f00f.org" <cw@f00f.org>,
 "dustin.kirkland@canonical.com" <dustin.kirkland@canonical.com>, Eric Blake
 <eblake@redhat.com>, "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "iggy@theiggy.com"
 <iggy@theiggy.com>, "jan.kiszka@web.de" <jan.kiszka@web.de>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>,
 "jjherne@linux.vnet.ibm.com" <jjherne@linux.vnet.ibm.com>,
 "mimu@linux.vnet.ibm.com" <mimu@linux.vnet.ibm.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "imp@bsdimp.com" <imp@bsdimp.com>, "z.huo@139.com" <z.huo@139.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "david.edmondson@oracle.com" <david.edmondson@oracle.com>,
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Alessandro Di Federico
 <ale@rev.ng>, "anjo@rev.ng" <anjo@rev.ng>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "wei.w.wang@intel.com"
 <wei.w.wang@intel.com>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: Call for agenda for 2023-09-19 QEMU developers call
Thread-Topic: Call for agenda for 2023-09-19 QEMU developers call
Thread-Index: AQHZ57EUHNn8FVCZRk2n1jj8PupR8LAbuw5BgASVdoA=
Date: Mon, 18 Sep 2023 09:10:22 +0000
Message-ID: <C9AB9626-9269-4B12-A836-635F911011B3@qti.qualcomm.com>
References: <CALUyDQ5Tcby25VQ05REYXsv8v_MO-nVcsHcrQWEAJefPArCoXA@mail.gmail.com>
 <87pm2jvgjc.fsf@secure.mitica>
In-Reply-To: <87pm2jvgjc.fsf@secure.mitica>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9884:EE_|CH3PR02MB9140:EE_
x-ms-office365-filtering-correlation-id: 460718fd-0344-4569-3648-08dbb8271682
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ii0Q5oXvgZOr32Kl7sS9pNsoRXe6QPIz1oeBkXZiQUN/PfF1992ZxdAca+PSwMX4PT7CYLF/fzMpCHe+jFMB/SnBQdCZ7UNMaImmb7AuzYH4NKLmVRmRt4WBW9ipXSXCKl6GHD/9VlJIAmeHcWz62yh+HkMAFJr5BMRnAl/X4uP7ZcvcNDBtZ/uMWMq5ayBlh8NZVLVqswyipZxkSIOdheAL/DWQVzMFEO7c4RBWcj3zEAPMfMnGh1UrzxGH55kj8RgwOLd4Ihn7gGsMw2vGoEYpsld9ydJQ/34h7puydoclWCy24VRlTWQqJ05gnKht4mWJkj277LuN8H5wdEG8BW1qpfxpBHs8//mFFVT/J2e0DvdQq9DlAqfwopn01h4DGA8WBfIE8+1qfwgMW7V0koyuqHvtAtva04A5PoNTOXv2VzqMYYdMaWt3MAbw23z5LgNWNt1lICDb/epQVQD05dDitVt9U7ppG9b9nIQ9g5jvZfFw2dyUooQQGtU9m5HG29w401tFmTcjUNerrOvWLMI5vtG/V094V0IIYLg5+NeF5u9UpoB6eCIt8M3bDzGvgN747064uX4dy9BWBcG/7ujQAzuVAHbTc4adYKEwQ2wxvzz2BaZw8Z72goQaLlMmP1N8YdXUnyMmB/wCJwkPGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9884.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199024)(186009)(1800799009)(6486002)(966005)(5660300002)(6506007)(53546011)(86362001)(6512007)(54906003)(316002)(66446008)(64756008)(66946007)(41300700001)(66556008)(38100700002)(66476007)(38070700005)(76116006)(91956017)(71200400001)(478600001)(6916009)(2616005)(8936002)(8676002)(26005)(33656002)(2906002)(122000001)(4326008)(83380400001)(7416002)(7406005)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTllNGhWZG9FajJyUjRERjZFRmtkc1ZsVjJidmpmZnRkaVMyUUpsRVlxZUVw?=
 =?utf-8?B?ZFM4REZYaDNxSE1xRlNTL1VJMG0yUnhKNDh4bXl4b1pUenpGOVJpTktnRUhR?=
 =?utf-8?B?ZVAwclNkWDFuQlQxWTBPS3hEbVdyVGpEb1BJd0V1TkducldOTGpZUWtWRTVt?=
 =?utf-8?B?c2NIVzdxc2Y2MEJSb0Vockh6RmU2dUtDeEQzdC9OL21JYXppbStaODhQcnZD?=
 =?utf-8?B?UGhsQjZZNGRScGRwNzZjdHJSUmdPOW1rQm5SZnJsYnB6bXhjdGx3eWVaSFNO?=
 =?utf-8?B?eGJnMjB0ejJhbmxKUmZMZWhVb01vSlhNSVh0V3d0cUF6OEx0aG52Uy9RS0Mv?=
 =?utf-8?B?QmVGMGFuYjd6cEZnTk1xdHRsMjlrMWpxMStBM2l1MzdTc3I0VWVUODJQd3Zr?=
 =?utf-8?B?SXVTdFREa2tZVWtvaTN4ZmFGbm82S1BkdTFUVjlmWkcwMXZ2MGhDbmtlcHlS?=
 =?utf-8?B?eFV3cDhYcVpGdXQwdkhmMi9GZDhkR3VNaEpmNHoxei9MZXJmWFYrUkdOelJa?=
 =?utf-8?B?WTdvdmtJMXNEdFZDVjBFd2hCRXdXQnJCNVhueVNTZlZ3RUJmcVJ6cTN5UCtX?=
 =?utf-8?B?Q0hDNVFsT2ZpejZQaTNNRCsvMHhLTTZpRDhGTkVDQ2trcmxxNkxKVnQ0ZkhT?=
 =?utf-8?B?ZFh2UGRTaGxZY2NkekorYld2T3MwS0IzVW1mbE5uUVBBelRyeWZVU1BYbjlP?=
 =?utf-8?B?OWZHTDlQcnl3NlR6a1h4clNMNWMzWW5IemRRZHA0YWRaY3BtVkljYThTZ1VN?=
 =?utf-8?B?bVFhaytpMHp4T0ZzRGUxdGpST3AwNXVJVHdIUzZrK3hZbUdvVGJCa3NhU0Mz?=
 =?utf-8?B?UkNUS0Z5QVJHOUZYQ1VZSzdTQlFOSVQyeU5GTU5NS2VoSEFSWU41QkNYai9w?=
 =?utf-8?B?cXBCcmZUWW9Id3V1SDY5eTNha2tIVzRZTFBXekJvRXl3RmRiTCttTFRrMGho?=
 =?utf-8?B?OG1mNTlZNVVZSUF0SkFPKzVTY0VDMktTN05HRVp5WXF1WEUyeG5tRUQ1dEIw?=
 =?utf-8?B?OUt2QWMvTkFLRnVjQlUrNzlQKzRQWUYzb0tPa1NveWJ3WXBvRFdkSkthYi9K?=
 =?utf-8?B?RzZmZFFGZ1VUMFdYWjdnY2ZwQ1ZIUzBBNzEwU2R5aFlvTDVsRnpGclF1U25C?=
 =?utf-8?B?aG1KY0YvMzBtYUFrbk1ORjhGQWUrWnRlR3BSdmNqNzZmbDVCS2w2UHlpU2hy?=
 =?utf-8?B?U2xMYTNkL1VPQWZIdWdqY3Bzc29PbXdxMW5Td0RxWWhTRUs2Qm4yMEF4ajlB?=
 =?utf-8?B?QVdTK2JpeTBGK1kxVnUzRzJXbkFkU0NrYzRhRGZSVnh6RXdZam5nM0MvNmo1?=
 =?utf-8?B?R09lMkRHNCtrS2RpYTAwTWNFUFN2VHIzZ0gvV0NHdzZUK2diaytBNHhRQ2l4?=
 =?utf-8?B?Smswc3ZCcVNMOFRpYzRpVDdNS1hiMmJ6T09KNmpCWjJaRHowZXNaVDBEbHNS?=
 =?utf-8?B?ZXM3eVhFQk5DalhRZVZNWEp6dGVBRmpBRjV3dkwrMEJ2Sjg0dEl1RXZydGY5?=
 =?utf-8?B?RGlJTmIrMUxaWnA4Um0vbHBhUmxaMFc3U3dVc0g0ZWNrS1YyT2RkUGNhY2p3?=
 =?utf-8?B?VDUxVnVpSitDZHpUNkJRNWZlQ2cxUStLWWhTVUFacDFGNFovNHpkOXhOTVE3?=
 =?utf-8?B?dUliMmxReFpJdk1qSWRDQUpWYkJ6NitwQStjc0NrSFBBaFBEWDhERnpEMmRn?=
 =?utf-8?B?QjRwSHdReTRoRWkwdHdkKzMxd01HODEzZkJNN0N1OXVOdEFkaDhiNVhJSzJZ?=
 =?utf-8?B?RzlERUZLeHdaam5SL0JWRVB1K3VQT3ZxMm5yejhybTNReW5wUkROOVRPUlJO?=
 =?utf-8?B?bzFuRVp6alBwWGViYlVIeUptU1hOcmY1ODN2ZXloNWxjRTR6cnV2SEp6eFY3?=
 =?utf-8?B?ZWllcnhZVVh2cjU0WGZnakk0akpPK2p6QkorVDB6L0JkcWIrbk1xeUdtTkRU?=
 =?utf-8?B?SHJYSGJVRzAwV2pIVWE5VkZ2U21TTzZha1llTzlHRDYvalRUZmdjNkdWUjZD?=
 =?utf-8?B?SWYyV2lRdHBpOVFLYndRVW5GdUZMVzNXbGZVY1JGV0dyRjZMNS93d0FFWkhm?=
 =?utf-8?B?TFptTy92MXovcnViL1M0T0N1bzhkU3NjMllJandCSEkzamQ4dHljUmlBUi91?=
 =?utf-8?B?c1ltRWdiV2JWZ3haTnNoVjRIaDBSK0w3TTJNUE9xaFcvaVphZ1RmbmYvYTM1?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A101E5343562694CBC0A0C754573BA9F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NHB2cFgzRDlqSThSZ3N3UExYSGY4QXZ1OWx2TE1VdXRYaENlU3F1RDV2U2xP?=
 =?utf-8?B?bFdEZ1FoYjJqMHZ3bmlySVNiMk5FNGxSNGFqYzU1TTEvQUx6Q2k0MXphWWxk?=
 =?utf-8?B?cldzLyt4dHdHMVR6QjV6akZUR1dxb2YrQXFmTHhwQm5tMkg1UW9PMGNKM1Fh?=
 =?utf-8?B?NnQ5eFRQSEg2Smc1MDhxQWYwMDlTYXNReGFVbDBlYkw5RkZvaFFXTWRHb2E1?=
 =?utf-8?B?eHNYZXY0bVNPODBFbFNjT0lmOFJ2bkFRdDhsNkpzN0pna1JYc0FRd1Z4L05C?=
 =?utf-8?B?WXYzVVFTRFBjcVBCQUhyek1KanYwSUpoU0JiTkU0RU0ralV2RGxOSFZQS0dy?=
 =?utf-8?B?aWlJM3Z1UU81bUJRTmswUlZvL1FMaC9KMU9WYUFtUktQS2RYRVFoTnBzb2Jt?=
 =?utf-8?B?ekk0Zmw0WVlFWkNvWndIcUkzclY3VjFYN0pkRk80WG9MaWhic3VoeU9WTFRC?=
 =?utf-8?B?Mis4cExXKzUzZXl2c2JtWjVQMlB2bWNGeGlZWlpGTVNRS2tscGl1QjhVUlh3?=
 =?utf-8?B?OTRaM3VPc3k2YW1sYXZZd1ZKbkpHUUJBUkVreVhzRjFCdmVZS0ZnMU9XMG5C?=
 =?utf-8?B?eG03Y3dBVEdFQUg1VFdaWURNVHV5Um1vYkl5UGcxY0lmbzZCNk9CT3JURFdk?=
 =?utf-8?B?REZkREhoU201SHI1eE82aWpab2VWQmFBa0JBd2V3dEd1ajhqY1BmRG1ZWjFu?=
 =?utf-8?B?NFJXOGcwZFlPVlI5L1VKcjE4NmFKWi9EMzNRK056VDFLRXdXQmxrVzJPMVJi?=
 =?utf-8?B?RkR0enlqU0Z0QUEwajVickhkT2RacFl1R2F5SkJiYjVGc2k0ZXRIK0R1QW9G?=
 =?utf-8?B?YWlRUGhTdGwzci93Yy8xcHJCcEVwcndoeUJhKzVreUl1TjVKSkkxUCtoa2Ur?=
 =?utf-8?B?ZGt6SU4wU2lvL2xYNkxmcjBYV1kzZjJna0RmNHVaS0tZdWEyS3FFMnRiamQx?=
 =?utf-8?B?WEZNcFV5UDhFTHh5YkR1bTgrMktMQk1sN0NyaEtzUFNCeUNMK0hIZ2dYY1Zk?=
 =?utf-8?B?VFJheUpzMnBOMGRvTnFwMjFLVkVvS1k4OGtvZ0VOelNCMXBsTE92N3VjU2Fx?=
 =?utf-8?B?czE5MGwzU3BuUklYWlRiOTRVUjNTQkRsS3hXTnM0SElTTUhxZW9qT2ltdmlS?=
 =?utf-8?B?Z3pTbFBHZkRTYWFENjR0bTlvUmRpZTZDTlJwREM5aGtWWU5BNWdlNlB5V1lC?=
 =?utf-8?B?cndBYzI5VFg5aXBaQ2VvbWpxWUxOWFBYQVUvb01VWUhndUw5ZjBkeUg2TlF0?=
 =?utf-8?B?Sit4UEt4UkwySmU4TmtLVW1hMkVKcmowSDlxbHBkemFFbXF2RlJjL1VLR0Rx?=
 =?utf-8?B?TzlGZHhEckZwMnBNTXlOQ2MxeHlZRVVKWXFYTys0bmo2bTk3dnp3ZmluRktp?=
 =?utf-8?B?VmllNEw3TlAvYWt1Z0NEaG02V21zMWJuQlJCZUE1dW94ZmRmQkNMS1Zndjdp?=
 =?utf-8?B?cWJnYXU5TjRSRUs1cHdCTS9ISGNFOXE4NDJ5N0FvT3M5VDFUNjFWWjNNNjlV?=
 =?utf-8?B?ejVJWEp2bFVNUmx5c3NjRkhrc3o1bHB3VHJlOS8wVS9HNjZhRWNDTXZEN01D?=
 =?utf-8?B?bi9Hb2FPRVpoQUFoM0o1a01SV0xpOEJnRTcraTZEcmdBM3NKRExmYjl6QmF5?=
 =?utf-8?B?ZXZkODJ0TjVSU2wwcGprVlN5Rk1uMjdHV1VtNkxNbkN0SFVYSy9sYzlydU4y?=
 =?utf-8?B?V1VwSnMxRGVJQ1Y2alJEN05mc08wVEtVN2o1NUJXdXlCZjRaYS9NLzJKQmRk?=
 =?utf-8?Q?oUI06AULBH8klYSzQsskDWTXa61SDAuVSYsUfjX?=
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9884.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460718fd-0344-4569-3648-08dbb8271682
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 09:10:22.3502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZBfnFiB4FS+dfIEUhh4kWdzIzmHY0resMEnX2/LMYw9BviP9US9q4n865prz7tNg+34rfMH9ff/dXU4WYDA6dgU5zzFTZsTm2vLZahNh3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9140
X-Proofpoint-GUID: QBS1C4XIJ4qIQhP7qoaTTZZ_TtQ8KHPK
X-Proofpoint-ORIG-GUID: QBS1C4XIJ4qIQhP7qoaTTZZ_TtQ8KHPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_01,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

U2VlbXMgbGlrZSB3ZeKAmXZlIGhhZCBhIGJpdCBvZiBhIOKAmXNsb3dlcuKAmSB0aW1lIGluIHJl
Y2VudCB3ZWVrcyAtIHByZXN1bWFibHkg4oCcc3VtbWVyIHRpbWXigJ0gLSBJZiBJIHVuZGVyc3Rh
bmQgY29ycmVjdGx5LCBMaW5hcm8gYXJlIG5vdCBnb2luZyB0b2UgcHJlc2V0IHRoaXMgd2Vlaz8N
Ck1heWJlIHdlIHNob3VsZCByZS1ncm91cCBpbiB0aGUgbmV4dCBtZWV0aW5nLCANCg0KU28gSeKA
mW0gaGFwcHkgdG8gaGF2ZSB0aGUgbWVldGluZyB0b21vcnJvdyBpZiBMaW5hcm8gY2FuIG1ha2Ug
aXQsIG90aGVyd2lzZSBmb3IgM3JkIE9jdCwgSSBoYXZlOg0KCUnigJlkIGxpa2UgdG8ga25vdyB3
aGVyZSB3ZSBhcmUgd2l0aCB0aGUg4oCcU2luZ2xlIEJpbmFyeeKAnSB3b3JrLg0KCUkgdGhpbmsg
dGhlcmUgaXMgc3RpbGwgb3V0c3RhbmRpbmcgcXVlc3Rpb25zIG9uIHRoZSB3aG9sZSDigJxzdGFy
dHVw4oCdIHN1YmplY3QgKHJlbGF0ZWQsIGJ1dCBub3QgdGhlIHNhbWUpDQoJQWxleCBhbmQgSSBo
YXZlIHRhbGtlZCBhYm91dCB0aGUgcGx1Z2luLUFQSSB0byBjb3ZlciDigJhpY291bnTigJkgdXNl
IGNhc2VzLCBhbmQgdGhhdCBzZWVtcyB0byBiZSBudWRnaW5nIG9wZW4gYSBwYW5kb3Jh4oCZcyBi
b3gsIHNvIEkgdGhpbmsgd2Ugc2hvdWxkIGRpc2N1c3MgdGhhdD8NCg0KDQpDaGVlcnMNCk1hcmsu
DQoNCg0KPiBPbiAxNSBTZXAgMjAyMywgYXQgMTM6MDksIEp1YW4gUXVpbnRlbGEgPHF1aW50ZWxh
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVk
IGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YgYW55IGxpbmtzIG9y
IGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBKdWFuIFF1aW50
ZWxhIDxqdWFuLnF1aW50ZWxhQGdtYWlsLmNvbT4gd3JvdGU6DQo+PiBIaQ0KPj4gDQo+PiBJZiB5
b3UgaGF2ZSBhbnkgdG9waWNzLCBwbGVhc2UgYWRkIHRvIHRoaXMgZW1haWwuDQo+IA0KPiBZb3Ug
Y2FuIGFsc28gdXBkYXRlIGhlcmUgaWYgeW91IHByZWZmZXI6DQo+IA0KPiBodHRwczovL3dpa2ku
cWVtdS5vcmcvUUVNVUNhbGwjQ2FsbF9mb3JfYWdlbmRhX2Zvcl8yMDIzLTA5LTE5DQo+IA0KPiBM
YXRlciwgSnVhbi4NCj4gDQo+PiBUaGFua3MsIEp1YW4uDQo+IA0KDQo=

