Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E21797AAAC0
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:50:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjav0-0007a8-4a; Fri, 22 Sep 2023 03:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjaux-0007ZZ-FA
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:49:39 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjauu-00087j-Pe
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695368977; x=1726904977;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XkunXYMpT+vAqa4DIhsl0SiyGpx01eX3M/gjGUMUsYs=;
 b=faBbvpHW+/vIsFn4+uCEn3pX3Lrl3ZbraLEkrrD83younrGd/+vr3aE0
 RQ9scXjD5PZSff1zC7hcmOZ+dAavKkYPDSGwpm1ZWfeSsVMexpeEjHhm7
 WH7nTa9UZ95/dbqJzjl+wkNCXlASTr2sj0CgJfkDGVPooU3c/oP4Nl0ZW
 rFUc2udap7hNRsYZ1Hm6rk+XuZCmKJDgntBvu1HqN6SAqtC2mk5ltHCd7
 rS2lO2E3zDSdSh8gv6tAjPFPZLIrxaBYxA7k2Xz6TSGC6hPFsBF6Em2CS
 qQW2fvXwDl5LxvEZ0w898AILFcxjVkS0/TQ+FYFvrvChcTEy82mlvYbo2 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="96134280"
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; d="scan'208";a="96134280"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 16:49:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBWIHXxGs7tbwox3DQ309ci69V+tpjafAEKSoQmyCvsaTmIVf0JCLYgC2jKEIhS3E2lfJAliAIyGxQok4nsGe8oU/hrz/M2uwCHlgG8zEtojNDwFsGfjLUOWJC2fgT9wGY/kkL63lW1v2NehKZtf1xd4kTT/wJQDkVCJwGJ3yeB4iD5sDkvTClAzR8WEFe0sT8DSNzJxow46YQWpLCG1+Ibpcl0VVmcrVPPlzFbhJ1nc6jUT0CBCcSGO7McJJd2+mIm1IumFjCzthyD1OZahY+3VClOS2VjQLYkxZ3BUxGi5yKSj/3pjn48W7qblpTsnvLlXDx2FctMGz8EMCWmd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkunXYMpT+vAqa4DIhsl0SiyGpx01eX3M/gjGUMUsYs=;
 b=TmaHD4689F9Rz8968g6RKLJnrLi5GAl/tR2MvE+yyVtkwFwYMXR+03S81JzeXxRjA/NHDWU1edIzaJMPRc6TqJV5mXoRvR6d53Vf5csGxdTvF3rwqyBqVaVROrrfgyaAEna81eum99CU8muBPy6DY5MerQ0We3JYdqCKVXv292Qhfyo4pRuC9ikuP/OIwa2ZzyVTsiMOZIV6jKScS+hSxVXfHLxxPdwGUULsp/IS1WA4z6BMKh6r3TOjRjpoWyBf/yEfIuapHwjjHPqGd0+iQpoTfsBXuIGy/51YsX7xd2FK0mICrW9XZbWvcjVECddPLV/kSuivfU2cTo+w7b0HiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB10339.jpnprd01.prod.outlook.com (2603:1096:400:253::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.22; Fri, 22 Sep
 2023 07:49:26 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 07:49:26 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com"
 <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 11/52] migration/rdma: Drop rdma_add_block() error handling
Thread-Topic: [PATCH 11/52] migration/rdma: Drop rdma_add_block() error
 handling
Thread-Index: AQHZ6j+Z0j4Zu2AGtU+Fxw11xPoyWbAlCqGAgAAap7WAAVjVgA==
Date: Fri, 22 Sep 2023 07:49:26 +0000
Message-ID: <a1bc4c7e-4618-148d-b681-81b1f911b359@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-12-armbru@redhat.com>
 <94601877-3170-8d7d-d161-3b72041d9551@fujitsu.com>
 <874jjn7p6w.fsf@pond.sub.org>
In-Reply-To: <874jjn7p6w.fsf@pond.sub.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB10339:EE_
x-ms-office365-filtering-correlation-id: 62fe24fb-9d32-4743-5370-08dbbb407206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OdvBS7ei+mW6cG2dMdjCutk7eh2IMUr4OuPT4e7QmTTOBTVy3hr38tucRrqOIHgzMiwbztFzZzWNDgNPD8AgLdJVXjyhr6OPx+A/QE52LeM3LxavyQUIyHUM4eh2byt6J5u0laqwkqRAGSzxnHTnu50nMW7oEyPto7OEnaqpTOHgJrk+tLql1xHt/dAH+MeX+1NNRWRSOoP/YP4+lBacpkfsgQ6vhVpFgoIDETlAQ8eaR9EVr1k69RcGb6N6WqCqsAHc0DDtK969zx+bjl5zHiYVzF/cQodNBtBOZLcgDRRlNv2lyzaHydL0fcfs6LRDp03qgbjPRaDBIikVdj0HpHbHF7KDcI05meQbz2hpwZL7B2FJs4fyWhlvm6pXbbCBfCPlMNMcb7Trt5/liXh/ESSQo1Nc2uFkzDSCXZ++pJtoSG5LOZPvuIEtMV2n+L0AVdQ3NnjFnRmPPhlwPub1LP8V/285DrS5Fk8RM+sQoeMU9q9H5IBwT9D5mavPhQqkkcNQ538AY/7+ggpInIPFMTbjNn3EVoK+nH/0WSEcU4WcH+ANWT2nAjiWHakb5l10YJcu8HKxwzfjsAGrWtqSZK0nNd0lcIWj0kVtDSQs0zFAAUrL/4EnhwM4KmFI9s5aSg2VPqJJ7ewFQ6ppG0BHjZTCG1waM2QxJ3Yw1luHVdLCUfTVlHffERrvBZVD6BkR3/seZvQ0JuzqnV898CKj3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199024)(1800799009)(186009)(1590799021)(31686004)(71200400001)(6512007)(6506007)(53546011)(1580799018)(36756003)(122000001)(82960400001)(85182001)(6486002)(31696002)(2616005)(38070700005)(38100700002)(86362001)(2906002)(66446008)(478600001)(83380400001)(26005)(5660300002)(41300700001)(316002)(6916009)(66476007)(8676002)(4326008)(66946007)(91956017)(8936002)(54906003)(76116006)(66556008)(64756008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVpYTDRqeHRsT2YwYzhZdERVTU00M0lWRXo5ajVtWEh0bFBscHZDRHdnUGRF?=
 =?utf-8?B?bXJFS3JqRHoyZWhmWFNXdTFnanE4amlncXBiL0RtSVQ3bCtsRnc1SGRkRkFv?=
 =?utf-8?B?T3dUYUYvT0lIc1h3RVp5ZUt0Y0tPYkJlb3FjcTRhVHFaVWVpbGJOcmdrYkFG?=
 =?utf-8?B?a2xrR3l5VUk1enRpN1Vrb2hpODBaK3B4V3UrOEFTelFGSHVZYkViKzZpRFp6?=
 =?utf-8?B?QTl3L09HVTVrc3VKQXBvWGwvSS9EaG5NV1lPd2w4d3F4cWVYTXpNOWpacnZ5?=
 =?utf-8?B?L1RXeXVIS29UdHNkWkVLMlZ0Zzhhajc5WFJUM2RMSk5WanI4b1NIYWcrSU0z?=
 =?utf-8?B?dEdlUGN6bnJReWZWYXFhcmtCSzF1WUJkUWdxSEJncC9XYmhPTFpkUGEvQnZG?=
 =?utf-8?B?NzhjRWQ3L1JyRFNPRHk4bk51Umc1cDNqNk52VS9QSWhLTjVoZ05HTUNaSW5x?=
 =?utf-8?B?UVd3R3hEQ2J2dGpuNlRncVlrSEdmdzhpWmVaUFBtT0JhTTljS0w3M3RBbDVX?=
 =?utf-8?B?YmpmZU5DWFhMUjJ3L1lWYmlyTkRjQ0hJUXJ4TjFPNVVmOHpwa1BxZEFCcjdT?=
 =?utf-8?B?S3dJYWZKSXpXM1ZhNWR0b0RmZFdNd3ZjdHBkeU5ia2E0dXlLd1B3Ri9LRm5j?=
 =?utf-8?B?alk5Tk9zdGR4a1dKM2doanIvcjdrQmNzR1hJYmdtbFVublBjQS9WZnpUN0FN?=
 =?utf-8?B?TTN0Wm1TeE9tbjFsaTMyYktHZXBhZ2JxOGt4cnEwU1lEQUF0cU0vUWlBUHY1?=
 =?utf-8?B?ODg0WXZMN1YwOWcrS3N4L2RzbENoMVEycjVybzUwaW5iU3pzSDByYXF5OXNH?=
 =?utf-8?B?ZGpsZW0rU2tqNUFNY0ZoalZocjMvWStvZzltYjdvb0VNbEhaLzBqOXV1dHdI?=
 =?utf-8?B?QnBCSi9lWVJrMFZWVzJLMEdKYzVNMzlTZFF1ZEhUQkR1QjRBdnhFSjFmVWd4?=
 =?utf-8?B?ODdhYzZvK1VDYituem9jczNzNmxHQmdUazBlL0JTWVZtVkpabk5CSHpySC81?=
 =?utf-8?B?VmY0cFZuUTBPSFNrVGtCZVBRTzg2MXFRcFJnTG8zMWpLWk8za1Q3clQ4WVI4?=
 =?utf-8?B?S0RKd1ptMzYzTmVzQ051MU1RdTE0M2Eza1V2ZW5rSTRiSTkvZnI0K003SzNr?=
 =?utf-8?B?RzNyY0R6V2o4RzZRREdDRjU3amYxN3hwUXdjZHJJblUvNDFWeUNic1BSZ3BH?=
 =?utf-8?B?VEI0UmFDNDJXM1VTODAyN3hFWVBadWowVXdRdTZ2WDdSWWlBM1lUZjBhTkNj?=
 =?utf-8?B?M0RsMlNpQ3ZnNytwOWd1SnIxT3BKalo2SEpsa0phM1EzMVhySTlFUXpOK0xn?=
 =?utf-8?B?R216MjE1TUNBWnFKVTNUNnpHaXY0Wm5Kd252dUltVytIaThEMVRJK3RreDFq?=
 =?utf-8?B?cC9UR1liRmZhVlk2SWQwRzBOVEFLcDgzcXBodTdVKytpUDc1N2lhcEUydUFw?=
 =?utf-8?B?QitzZ3g3ejk4Qnk5ay94TnZxUjhaMEthY0Jra0Z6YmVRUTdkWDhxWmIwSnZD?=
 =?utf-8?B?STd3RytVMVZyWmZ2SmQzbWNQVVdIL3U3TzZ2bk0wMVJ3WVFZOVVjS0pKcEFC?=
 =?utf-8?B?ODVsSnFRV1ltVituTlkybmgzR01xakh6YytVenZrSmRXdC9TV1VKYWZsVFJ0?=
 =?utf-8?B?Y1F6Z0htc1hkbEkwR0o1bm80d0kyU2pvbEZhL2tTUTFRU3JSQkREYmd5eGtW?=
 =?utf-8?B?ZGoyVXFKVnNjUFM2OTVTQi9MTXBTcHp1NWlmaG52Nks5TUcvSGFHeHZBMUlU?=
 =?utf-8?B?aHhVcTRwSkx4ZWNXTDNnVlJHdWlaMjcvMmsvclI0WTZ1NlpOa0hoQmpGdmQ3?=
 =?utf-8?B?SlZ6QnpMK3JsVE5jWkxoeUlzZURQdzNDMHZLdzN6ZGp2Ky9pRkFzMXNNV3lY?=
 =?utf-8?B?MzR1NDk0c2NPNFNaNk1qY1J3RFI2RmJtZHFMYmpJMzdkZlhtZ2w0Nm0xdm1N?=
 =?utf-8?B?VlBHZ0toeWpWMmdMdjJtRnJZSUN1WlJXaXpjQ1BlZ01mZXI5Y0REbzYxaFcy?=
 =?utf-8?B?RGpVWUdpZUxWWWJ0dndFN1IzL1VwVjlqNFRTcU5LbkVyYjk2ZjFCbXRMaHo5?=
 =?utf-8?B?dnF3Ni9YUGJMNzQ4TTU5WXZrODlXN1lWQTJhWHd3Z3VxdTN4akNONERXSjlY?=
 =?utf-8?B?T25ULzVVRkJKMys0TzVQZWkzcE0zaDRMTFQvQmtzOSt5c1VMQkVVWHk2U0RZ?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5583842CB3FD5448B5B33F092A68674E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mPYbL0FOy7Sn1rS1tJ5obw/qRv09+VyRCwy8w0JNsBVl7zRBqRFn7dx3NrRDG33TN3RSwILOQKSO4+MIrVFPFLSDtzU7f9haTSr/nerdxmG7w7C1xFPY8F24crIl19I9pbNOuDN03oyMbrna03Vc24ZxcVmlU+V2zylvpbcyZRsX+mNAr3P8JGVP/GRUPkzSaQJNNuUagDunzdZ1hCg3bdLCZbHP5ldunmP/It0Sorh2tLMs+8vmWxuIvAusFaicgAzmwNcEWnzp2kCUEJi6C/NSFIbYo7ETJmLD7SHAoQA5R3WR8wqecPeMQvLV3mb3GaOgRcgLpuNPgJLagHyrpUnN4roB80Bt9TWOpB2MRss6quBYZOR5gGHEERWv0Icw5uJKDv52CgwQiqJ5KtMfDQcM3vp4yd2wtFr/QnEerzco7awnFaYPVDleM+ZwY2vDEtfPpUQ4s8IpXjmRMvHYjUteWcMZXAsPjkFnUfhnjBxzL41ZELXmrh0ERgKfBs9X5iL5qBv5aFqMFng3j/FNYC/Yj3KxHbjVmmd0aJUO6KSkqZLtOK9BGa/HVhGZvHfyokCIwYH+Dfs0kPT2TqJpqKXtyOL6oVCduxbgrH05g90MYC9UivrqLtJArdhEy86cEg+zQsU4BqodO/ocPNlEeDfwe8fBZJAoGFKwI9maGsteVdz5OrkfzzhnfeustsPznWwwPJ805G3Hog/15/0s5dZaDkNPWqVisk/M7vr0GZP9bDatOH5KHyjUairmPYhPCZRJkfrlmNo5cfhqJqEpbF8sOWSmOcMrbwfqQX/LiJQ=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fe24fb-9d32-4743-5370-08dbbb407206
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 07:49:26.8138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEDit5qyDho3ynXN+oO/An+G6LahMdgMtvomdosCbGKUmPfAPIFO9IMuFcQTTZy0CN8zgFJ55C05wUVL0QWbvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10339
Received-SPF: pass client-ip=216.71.158.33; envelope-from=lizhijian@fujitsu.com;
 helo=esa16.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDIxLzA5LzIwMjMgMTk6MTUsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiAiWmhp
amlhbiBMaSAoRnVqaXRzdSkiIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+
PiBPbiAxOC8wOS8yMDIzIDIyOjQxLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4+PiByZG1h
X2FkZF9ibG9jaygpIGNhbid0IGZhaWwuICBSZXR1cm4gdm9pZCwgYW5kIGRyb3AgdGhlIHVucmVh
Y2hhYmxlDQo+Pj4gZXJyb3IgaGFuZGxpbmcuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXJr
dXMgQXJtYnJ1c3Rlcjxhcm1icnVAcmVkaGF0LmNvbT4NCj4+PiAtLS0NCj4+PiAgICBtaWdyYXRp
b24vcmRtYS5jIHwgMzAgKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4gICAgMSBm
aWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+Pj4NCj4+DQo+
PiBbLi4uXQ0KPj4NCj4+PiAgICAgKiBkdXJpbmcgZHluYW1pYyBwYWdlIHJlZ2lzdHJhdGlvbi4N
Cj4+PiAgICAgKi8NCj4+PiAtc3RhdGljIGludCBxZW11X3JkbWFfaW5pdF9yYW1fYmxvY2tzKFJE
TUFDb250ZXh0ICpyZG1hKQ0KPj4+ICtzdGF0aWMgdm9pZCBxZW11X3JkbWFfaW5pdF9yYW1fYmxv
Y2tzKFJETUFDb250ZXh0ICpyZG1hKQ0KPj4+ICAgIHsNCj4+PiAgICAgICAgUkRNQUxvY2FsQmxv
Y2tzICpsb2NhbCA9ICZyZG1hLT5sb2NhbF9yYW1fYmxvY2tzOw0KPj4+ICAgICAgICBpbnQgcmV0
Ow0KPj4+IEBAIC02NDYsMTQgKzY0NSwxMSBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9pbml0X3Jh
bV9ibG9ja3MoUkRNQUNvbnRleHQgKnJkbWEpDQo+Pj4gICAgICAgIGFzc2VydChyZG1hLT5ibG9j
a21hcCA9PSBOVUxMKTsNCj4+PiAgICAgICAgbWVtc2V0KGxvY2FsLCAwLCBzaXplb2YgKmxvY2Fs
KTsNCj4+PiAgICAgICAgcmV0ID0gZm9yZWFjaF9ub3RfaWdub3JlZF9ibG9jayhxZW11X3JkbWFf
aW5pdF9vbmVfYmxvY2ssIHJkbWEpOw0KPj4+IC0gICAgaWYgKHJldCkgew0KPj4+IC0gICAgICAg
IHJldHVybiByZXQ7DQo+Pj4gLSAgICB9DQo+Pj4gKyAgICBhc3NlcnQoIXJldCk7DQo+Pg0KPj4g
V2h5IHdlIHN0aWxsIG5lZWQgYSBuZXcgYXNzZXJ0KCksIGNhbiB3ZSByZW1vdmUgdGhlIHJldCB0
b2dldGhlci4NCj4+DQo+PiAgICAgICBmb3JlYWNoX25vdF9pZ25vcmVkX2Jsb2NrKHFlbXVfcmRt
YV9pbml0X29uZV9ibG9jaywgcmRtYSk7DQo+PiAgICAgICB0cmFjZV9xZW11X3JkbWFfaW5pdF9y
YW1fYmxvY2tzKGxvY2FsLT5uYl9ibG9ja3MpOw0KPiANCj4gVGhlICJ0aGUgY2FsbGJhY2sgZG9l
c24ndCBmYWlsIiBpcyBhIG5vbi1sb2NhbCBhcmd1bWVudC4gIFRoZSBhc3NlcnRpb24NCj4gY2hl
Y2tzIGl0LiAgSSdkIGJlIGZpbmUgd2l0aCBkcm9wcGluZyBpdCwgc2luY2UgdGhlIGFyZ3VtZW50
IGlzDQo+IHN0cmFpZ2h0Zm9yd2FyZCBlbm91Z2guICBUaG91Z2h0cz8NCj4gDQoNCkJvdGggYXJl
IGZpbmUsIEkgcHJlZmVyIHRvIGRyb3AgaXQgcGVyc29uYWxseS4gOikNCg0KQW55d2F5LA0KDQpS
ZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg==

