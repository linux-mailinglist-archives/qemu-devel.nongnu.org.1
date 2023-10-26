Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 296487D7E36
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:15:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvvW0-0005ix-S0; Thu, 26 Oct 2023 04:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qvvVz-0005iX-Gg; Thu, 26 Oct 2023 04:14:51 -0400
Received: from mail-dbaeur03on2071a.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::71a]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qvvVt-0002jJ-AX; Thu, 26 Oct 2023 04:14:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9Iv+uByc0JlimLtp6Wx00p/QBZ3/FwReOB9suCnCs2Gogl283WdE4vBwBOuS+co9Ef1MNsre3wGLl9ewvqUkSNT7zFODILQ/nbz+nkB6xh8kzRv/uyWINZpX2TZHvCYJW8BOhx6CWTIjZSN/jtMOlNz5rRBsz6Bqg2bbWD0j6FBvGaLA/fWNvRZTPGHH80Fx/CIdlMME/dbNy8Fp8KM2w7iMplZhAqxJm/6Nl8Pa29vKJSSnropzIjatSHhYiUGh6WVBDc5R/SJ+v2IGJygKx0ONSJJU+eX/DfSBEX02KOp2byZW+DCXm+itrD8Xt2iV3+ztvOU84tF/PsD/k2Nog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYQ8MXWAt4gognTuCl248f/+SLcW3lJQ0/qxHLkJKwk=;
 b=oKCkE5ohSD4uWNExYGeVQhYaTf2i+Odc16TOoy38ir8uyTJUJRHtPcp2Y+hcURr8ZUd1576sAT0E5xd7bWkDFl1Ph/gLGTbHpfqW8efiwNYPJ/1A7s0QvrkgLp2HoJLUOd9zk85dd7YJeLN9HOwU8hN2gZWJdMDcoTRxflsxm98oTYBHccP75G4WCRmmaanifVFgnLmVY/pjRBonAzvtxnUUt8PIUZrDKj2Eo80ZpZISqpOJ53ULRPXQ3x5YVz2PADnqDEIvr6Iuuvzc0qAgIYssg640AUM/uSnxhUauK5R1kucPithgNp/8H7BXAgTM4UtcYQVnV3fcmek3JvmOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYQ8MXWAt4gognTuCl248f/+SLcW3lJQ0/qxHLkJKwk=;
 b=eaXVBSwOgDUlBE7bCnlGrLPawcqFxTiSC3ZVFJl1ebaJSolkV4RqoFzmOGEj/ISAjCgXHOK1p3iaHEleXf51v/65xflpRF+yQAroYMA2eN4JOzo0wkCDi1VVp1MtPtu8JvRE4HNBcM+UOGAn+DYt4iThtgdxv9WqXTqEz0BCC1vNMuSCFs0B2iKToYYAdtHdnu5WOyRRMODYsxFtpO/QysOAb+xkIp/uDG0DfjgTnoykwHdwUIhoogHLp1yX5rDZKUIS6vR0MxTUF2fTVqSS5NmQSv0F8jPgh2HPCSNw1g9tWVZStCQ+HdXA/eWeh0lR9oJSbMYuDRW2Vqsrx5pIGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB6278.eurprd08.prod.outlook.com
 (2603:10a6:20b:29a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 08:14:40 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352%6]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 08:14:40 +0000
Message-ID: <c33a3e1a-cc84-4d8b-b546-a078174eb9f0@virtuozzo.com>
Date: Thu, 26 Oct 2023 11:16:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] qemu-img: rebase: stop when reaching EOF of old
 backing file
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 den@virtuozzo.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-2-andrey.drobyshev@virtuozzo.com>
 <02d69c45-4b7b-4b86-aba5-d661102714dd@tls.msk.ru>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <02d69c45-4b7b-4b86-aba5-d661102714dd@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0131.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::15) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c77644e-80a5-463e-9ef0-08dbd5fb9a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5bq7f3LNQHqdD2VEjf20MJDxt/rGVpFNxhAk7ARgdnXC0iLx9c84Ki4ihDgYejUW29dMbTAKhdVovTAgSkfbNIoh8DPYTrqY3Nnokqt8T9X2dSXOkBsPeepQOLrnb1F1j78P8HacCoQqvFangwpx4m9MWGta0ZQ4ZumdUlzCrTPl9pC4ju9EMo6gXCxqBo28gx0bVhtOCNgpJMewCRaqVWsVntyE9hL0ok60jfuCZeUjwVq2yQI713KFzko1g+D86ObyhsK5w9OnhMgCKj3lIOP8Ay2cIxCpGVdaAoUOVu1nupsCFz+yxcTUHUtt60gWFugQaUQPj6vFhLGFC3fDd3ZU045pTks9Ku+yNlL1K4x6KlQ2AigjpUY9UlLrhlirfSLZrtx5eacIdWNFQ6+gyQ/UR7ruLAYwFvbQYFUl9nETuuG0oXzTOE4E2nhWO1ukMOgC5/lih1oE/FigTepBJv6edqCtlLQohGxU2xPgozD7sXAkVcUYtxgnIEaDkBMA47T3LJiH5CR0nDK1mkSW9Tyv6bcvYCtsQIWrKlkYkTUHyPtNj/kUu0YhMPWzPYGd0ML4qcW9dBRnbFB2SDZb7++8578TU2s7uh2Pes+ECfR9iojmPSBiamBIbaGG554bwvQYBO/Rc38jwjnFhaf1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39850400004)(366004)(396003)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(107886003)(6506007)(4744005)(44832011)(2906002)(41300700001)(38100700002)(66476007)(66946007)(6666004)(2616005)(66556008)(53546011)(966005)(6486002)(6512007)(316002)(83380400001)(86362001)(36756003)(31696002)(4326008)(5660300002)(478600001)(8936002)(8676002)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZaeFlUWnJiWUdybXF2MmVuMlY2aTdsTisvWDUrSU1LamE2MzdJMmh2d1hp?=
 =?utf-8?B?M0RNeGh2MGNQbXZpVWs3bGRtay9XMHFhYkRYRm12NXBEVzc3TWUrREFFWUMx?=
 =?utf-8?B?UEhDY0pxdklPMm15NkVISGxuU1l3cEhlVGFRVmE4NWk1aU1vODJWQy9YRUQ0?=
 =?utf-8?B?aE5DU054V2wrSlU2Y0VjSnVCd0p3SE8vRXRaZlBkWjR2S2xmZmtSNTdDb3k3?=
 =?utf-8?B?b1ovcG5BN0hmd0xIeWhrOVhlbnFGVmNBK1czeFVMUngveTdxeWwveE9IQW9x?=
 =?utf-8?B?RzljVWI3b2phR01TU1BDcXRlUzZqLzU2ZDNmclQzOS9Eb0c2YXBjZTJtQkpu?=
 =?utf-8?B?ajFqUVJ0Q3VkU2wxbjV3My9DZkdHWC9Pa0x3M1VnZUdobVFkUWlqcGQyUmVp?=
 =?utf-8?B?c3crTFd5dGZ0a0YrVUJ2MnBoSnNHT3UyZG9CazlOMFl3cHRRdm9sRmw0M2Nk?=
 =?utf-8?B?UUlkVEtoU0wzWm1IT29HcUdrdmhHU1NDNEFZL2JiMkZkbVJ0b1dRd2k4c2hW?=
 =?utf-8?B?RWlzblg3L3ZQQW04ZmgyYjFYMDRvcm82Ukh0dC9GL1JUMjh2TWM1dmJ2c1dt?=
 =?utf-8?B?d0VJOUxLUXdVdS9kS1FzMHpobUtwa3J1N0xkWkMyL3NTZ0JZcjlmZFVKY0ln?=
 =?utf-8?B?K3YvVG10VmpmcnBqbUdTY2lCT3pRdFovdGt4MmQ1S2dTazBpU29PcUlTMk9K?=
 =?utf-8?B?ZVFuWGdHQmNrZENEQTVWV0VKR3pzQUhHOXZ6R2RMODk2ODNLOFJyOEE2bk9y?=
 =?utf-8?B?cTMrK3dXOVpocksxdEJIRnFPK1JGdGtvZ0hZZDdpaGExSksxeFdOMWRTQmZx?=
 =?utf-8?B?VDFVRlVCalFXZnl3ZTBUYWNoNjVDYlNIenZldGRBcHV6RWtNT0JUK2ltdG8v?=
 =?utf-8?B?Q3h3SjlYaXg2VmZSaXYrVXhEeWZESHJ4WVF6c0NhSmUzaHpoVVNYQ2ZzZzVQ?=
 =?utf-8?B?RWhMNy85VGNudlpYOXd0QnE4WC9yYWZkb2N3RFhnV0ExUmZoWVZQNFRDY3Rw?=
 =?utf-8?B?YWdFb3Ava2lPRXVQaE5wY1FnV29uV2ZhanB4RFBEUHppMWxVNFBtWXJqWEdv?=
 =?utf-8?B?eWhyMkg1NU9wcUJrT1Z3Mm90SVBSMXV4NlA5cXlXdmJFOTluVHVrSHlwUUhu?=
 =?utf-8?B?Ymk4blZkM0Y2NmNIQUlGV2lNNlBvVUpqUUd4WnRJZUFLRFFOS0ovUG9EL28z?=
 =?utf-8?B?U0k3ZjYvellSMklKMTROdTMrMmFudlQvNXdsMXJaRTBTZ0pmOU5kSTRLWTZu?=
 =?utf-8?B?OEFDdVJ5MzFrWDcyQkVWSEQ4U3NLMEZ3N2VpR3BLK05adVR1Y0hIQjhUSG5v?=
 =?utf-8?B?UDJkRlNOd0VuTHJhelhGWTVrYUNPTnpVQmlHbmRhbEhVRStVVk1NM2VGbTBP?=
 =?utf-8?B?YUZCUUxtS09QSTMxS3I4ZjZSQjZ1VzVLMDk5UlM0aTlwZGlzdXByZGlwZVoz?=
 =?utf-8?B?bFMwb01uK3hQcmt6cm9DRFltYWMxa2YxZXpmcFdXSzZHcVQ2eGg2OFRoUndZ?=
 =?utf-8?B?NDE2Mm1XZWZqYnRqaUFKV2FpdXIrWVFIdmE3dFVOMTE0bDhUbFE2TW9JUzFv?=
 =?utf-8?B?VXdSSk93clN1NHVvS3lQTEd5R283dW4zSDJmQkhEMitOekpFdnV1eWQxVExk?=
 =?utf-8?B?K2NJK2RxcjlQb0dhTGhDZ1NscVJNbEhocVhMakNmRzFvRk5pZkdNSGt2QlZX?=
 =?utf-8?B?c0pEY2c3MXl3ZlU4YnJVODlTQ1Q4V2lWZk81dFEyRGZQdlJqRnl3V1d5aXJB?=
 =?utf-8?B?a1U2Z3lHckxsemtCYjN1TzF3V3pzOERxY0VGd3lLOEFTUFpCL3ZJeDdxcTJM?=
 =?utf-8?B?MFlWRTBwRnMwL3YxaEd2dkdjeDFjanpGKzRnMmFuYmNGRXFua005QVZ1Wk8x?=
 =?utf-8?B?Sy9BNUVSMS9jS2MzUVlDZUpDeVJ4Q1FPdE54eCtzeWxaYUlkOWUrOURaV2dl?=
 =?utf-8?B?d2V3REJYYTBZaExlYW9Vcmd3RXNJbDhORUZ6T2U1NTBRdlpFWVBtWVhKTC9I?=
 =?utf-8?B?WXJQNnQ4Zjk3OTVEYUtFamxCZXE2Nnk4NkZYZVdpVlo5TWR4cTFpTzJITysr?=
 =?utf-8?B?a2I2WGdac050VmxDQzdRVnlKVFA5T3p6UmdhL1FtVVNDdVRmZEpqSHJqS0RP?=
 =?utf-8?B?MWR6S2dDNkNLWmhYWkw2MjFoN1A1Q2xpSnc1MFAxc1FwbXJTZDNTT1U5cUtq?=
 =?utf-8?Q?5Ygl3DhFdk3AKyLLHUkDpGg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c77644e-80a5-463e-9ef0-08dbd5fb9a1f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 08:14:40.3544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uugt1kGTXpmxbs8RyhXHJAV/kRQIaHB/dHOeAj2qjWzFD/WST4570EWo/pdpXPQNRyEWEnojkoP7jtaoZ78Ym0IdOy6L5SDjAiAHxEmpKI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6278
Received-SPF: pass client-ip=2a01:111:f400:fe1a::71a;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/26/23 09:32, Michael Tokarev wrote:
> 01.06.2023 22:28, Andrey Drobyshev via:
>> In case when we're rebasing within one backing chain, and when target
>> image
>> is larger than old backing file, bdrv_is_allocated_above() ends up
>> setting
>> *pnum = 0.  As a result, target offset isn't getting incremented, and we
>> get stuck in an infinite for loop.  Let's detect this case and proceed
>> further down the loop body, as the offsets beyond the old backing size
>> need
>> to be explicitly zeroed.
> 
> Ping? Has this been forgotten? It's a few months already..
> 
> /mjt

Hi Michael,

It's not forgotten, there's already v3 of this series and it's already
taken to the block branch by Kevin:

https://lists.nongnu.org/archive/html/qemu-block/2023-09/msg00593.html

Andrey

