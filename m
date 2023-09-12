Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F979DBDC
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:24:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBmh-0000Y1-KZ; Tue, 12 Sep 2023 18:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qgBmY-0000NI-DQ; Tue, 12 Sep 2023 18:22:54 -0400
Received: from mail-vi1eur04on071b.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::71b]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qgBmU-0003dh-Id; Tue, 12 Sep 2023 18:22:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky0X20y9LhccfsKmDf15UfiT0Qkg8EYX/b06G1zCi2pvjbOgTAI4pp3HhVGaZYgxKRlJPulRBnJzWPCg03wK4hzp1hNjRK7Bi26otR6zyYw4IkkbU8YNVFlAmCLptQIONAC+SEL5uhjAgKJipVBl70wpCDEgCo2x0bjGXrPgFvN+3I90E3IBqq0ALj5FEAdIjEF5eE2xZl37lxm+NtTbm7my+/Dgm4VUYj3fqYE0zLW4IFApgOI40pGnbybROxLGR8ytk4byfBP9IaEQaUWBFBMpLY8bdGvjk55XgtCAKlrzvvLZMVEdmYlnZdypdBxXnhl1mXAE4vU30diNcLKklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftcE5fMGepg5Nl26kR6MSgXSpG4q9bhC1ZPZHq9Lg/A=;
 b=KM8NtofcaaMWNhWXk902PvtRatO5bCTnFfFRfgflaNmEJ55JcbXceh9aceA6dnCgM/gSah6qbVCuM42of0h9pK8WqcUwn2lopNj8JyeCaQjL5m3bupNpQ/zfGuuV0vKFjLZS7DFmBgX+zh8fyVcTpxfVbv7UPP6ig279Ru49n+sDBSoGsnv9AWk2kVfzxxm8QkRdPNi0bBwaqZ9hRMJ4MxD2pu2iTfQzWPpx+VMO9342wnVaoYQxRF3jF12BSvihHFd4h9TIFVJkSUtj1buZ2J3sNH9CgoZJXHDN2t/2FAbLcZdHVQmFjcYycRHP3aDVedCsg7ogQs3rdupoL7mdTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftcE5fMGepg5Nl26kR6MSgXSpG4q9bhC1ZPZHq9Lg/A=;
 b=VDsEFVDRxcpguzsHhiTrpKwZ/olBw6DfV95q60hx79EKgHGvLlIi2eE3sSWK3kl7Fr0lkeDnsViivrqp7Y4JbZiAENQRG00bqwoVNr8PwCIiH95H4dLVJMj3yWJ3TGLWAvnyM8dvUfgdrUfqnXcJs+jvw7QNqIbSazl28HjoemWbtlC+96QhOHRegVr+cCVjIIdHX30sNL0/C8LelHE3nn6vGunXplLcFqUr0qiRpFONmkaZ1BH9UcjUP9HQxyzDm+VhSAWfTYLOKM8I5kg/tDzkYxj9ZLh+ElzeoSrCJGN6DgfSmiiuEBi2xdZUS2sa+ZE7uTwANCBIvLZwDFWTyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DBBPR08MB5994.eurprd08.prod.outlook.com (2603:10a6:10:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 22:22:44 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 22:22:43 +0000
Message-ID: <8b3df638-58c0-f0d0-c2b5-4a032c646a1c@virtuozzo.com>
Date: Wed, 13 Sep 2023 00:22:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] iotests: distinguish 'skipped' and 'not run' states
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20230906140917.559129-1-den@openvz.org>
 <20230906140917.559129-4-den@openvz.org>
 <2b3edc30-807a-2f3c-79b8-55d2f027af2d@yandex-team.ru>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <2b3edc30-807a-2f3c-79b8-55d2f027af2d@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::12) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DBBPR08MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: ee715c51-c1b7-45c1-2b61-08dbb3dec8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4PXWLq9aAamdCbT1uJTTT0jAspT8BwQnpde1LalJn61Kzh/S/KvPGrRYiApDDBNds+lGa8ls+wGMMXrlvNjIIcs0kzWqDxnTtPc4aB6F+v8+wepYdZvLyM8Mff1cuMJ++O1/H159z4VCOLl/RFOZjmbaq3RJYtykgHMQoxp76KW/JSBiqEj8nUcm6fivS3cWx/iJp9jqRmSUaB2MnlwDHdGMoSadvrU9jvBdQJWDqRC1TO81KEkm9KBzGVthdW2BJiXfpAF6jTNU+jlNSyoPrwJJLA8yrLBlVZYVo9hDiXn+NCZ1xUJtMlGmd2Uzzlj8r9B4CATyLRoPfjdbFbH0jOx/uATApE14jbdTONZK20Yd1woWyrzICPlFNdAocG5A8cwSNqV0zLLaAQ7CTVrQqJ6OiGwWiQB9PNu4Eshjo25A44xEq8/W++iWyVZJiosP0MEGdlCLJFxKcea/vphS8STYYi88/Gfwodti55TcG/fjM8z6BUJLUePhVL1beAGOLgcj9w1cA9ZwJxR6bxHJdSKRPQFtEHxfXkkhRRQK3Uyx0hydRHHKaBBaUFYTz+6dUecRnnHiyQRN0wPQ8a5Z5NPBZqRVJ+T/ALJvPPBicJTqOfiYMeD/MiUFpTTjkKnkw6KWLbACNK41tvP85D8Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(396003)(366004)(376002)(136003)(186009)(451199024)(1800799009)(316002)(66556008)(54906003)(41300700001)(66476007)(110136005)(66946007)(478600001)(38100700002)(86362001)(31696002)(36756003)(2906002)(5660300002)(8936002)(4326008)(8676002)(2616005)(31686004)(26005)(6486002)(53546011)(6506007)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0IzME5SU1ZSNDA5KzBoQTFlWXpkU3RoakZDZDdxa1J1ck5CdkxtWXZ1cEFz?=
 =?utf-8?B?dzNYZFllY3NLMXpwWWh2U2l0VjQxTjRNV2JQRmE4R1FXZEdZeVhlQjJXOSs1?=
 =?utf-8?B?VHdzRFFab0ViM3FkRHpmMDJXM1Jlc0IrQWtNSm5BRHQ0cVpITzdHbFo2VFBz?=
 =?utf-8?B?ZDlNWFBLTWtnTGs5TEpCZ2JvZ1o5U2N3bnJaOVNVQUdUSnFNYUVRazlENlJM?=
 =?utf-8?B?clY1dVhjeHBCellVMVVsNTF3bFZDSFZ2dU1CVWpadkxBRGlDZy9aU1ZNYlVN?=
 =?utf-8?B?V2tBUjZaVVk3OFBpRExCU0pRakcxQS81d1VLOVAwQVI1bVpqZzlKU01sZUNY?=
 =?utf-8?B?WXdMZkRJV0ticnA4a0duajMrcUs2R0l6M0laZnU5K0hNV3JXYTRYbnljM0RT?=
 =?utf-8?B?R294YlJPSUUzREdWeWlEMW1GTFRQU1ZqQ0M1S0hydVdBV2JWdk5OQ3ZTdkJK?=
 =?utf-8?B?SHJHWWUyWFlSYXFHMjhVcEE3N0x5WmFvcXlrbzhtdDNmTkQ5SHpWa2NZUmpa?=
 =?utf-8?B?S3p6UmFBSFJ5LzJNOTdiUkJibTVuZE15UnVpSFh2cFh0VEQxVXkwVTFkQjVZ?=
 =?utf-8?B?QjlrL3dMVDdqMDdMWUJJaUFpdWF3WTMramRyZFdaRGM2ODdaOUtkWlhYcHRM?=
 =?utf-8?B?MVRYQ2hRMGk5UUU2VDJrK0ZYSEFxMU1vaElxd0Q3QnBLQW55V29rdXd2ZXV1?=
 =?utf-8?B?UndndXYvZ3lmTkRQNXNDVWxLV0RVRVZSWE84b2pmNGp1Nlk5RHhkTDI5ZEtz?=
 =?utf-8?B?MVBadlU5bzBBTVVxdi9zcm1ueGkvVFJVS3R4WkJlZVlqbC9MYlAxN3RlTUxT?=
 =?utf-8?B?ME9Uelk4ZytpaU5NdVFaRXZzZlZaZWVrbFQ1TUI1bnpNbzl6OWpNL3BxTE5G?=
 =?utf-8?B?WXRLa0F1eFlvWHkxdlNmeUZ1VllIQ2QrTVRBSWcyUE1kMzZZRjd2M29sYXR5?=
 =?utf-8?B?RlMyak43cklraE1zalkzVGVwUGpTeThqUjFMRUVYL29XVTlCRC9LS1d3V2xy?=
 =?utf-8?B?cUZCdFV4YlMvY3lWMk4xNDFnUGk1cjVheWd6VlJmOVJxcm5MU09BMDlydTNU?=
 =?utf-8?B?RVVkRExEQnJ5b2YzSGZxbmdqL3NtcWw3N1hrMHB5S2FnVVNXZ1Z1b1ltL0di?=
 =?utf-8?B?OFBlNnVObE5hMmlxYnRNeWpRaWc3OXNWZDhOcTdjOVM1WDFldWZmZWk0SU1q?=
 =?utf-8?B?SE5VWENxbzNNM21zN0hxS0hTSmFOL1RBOUt3Z2l5QW9jZXNNZUlQNHNsU0Nj?=
 =?utf-8?B?OGYwUmZpTUxqU3dWQXFsOHE5NnJVemkxVUhWaGxUcDE0Yk1sdEUyZzlUYWMw?=
 =?utf-8?B?T3FNT0RkclpnR3doeUpQV3d6VU9rUjRMQUxUb2pYUEpIdTZCcmt1UXJienBs?=
 =?utf-8?B?WDFXUi9heFBqb2pOZ0tzbWtPYUNrU0NHN1RJVHllRDVHUXZaYzNqT3NoNmUw?=
 =?utf-8?B?azdhUmtQTXVpVUV6SjRBeGxKY09OYy8wdWlNYjdTYVdidEE0cW1scGlaL3Fx?=
 =?utf-8?B?WGlZcVB4UU40a3J5Nzg5emlhT2MzNE8vMkpZekFRc2RqdG85TGRnMU5IUWph?=
 =?utf-8?B?KytwdllJclNIK3R4UDNhWlFINUl1MzI1UVhnRFg5cUh5R2w0NHZDbkNpU0t6?=
 =?utf-8?B?RnFyK2pyUklKNTliNUdBUDNRWk9DbWp4MTRSOXd1SmJ1TjdxUnUxWXJTKzRx?=
 =?utf-8?B?UmNySUtoN01DdEU4SWI0Z2traVpPdEhYTTZOSnhXMGgzMHVhMnlDYUJWcTIr?=
 =?utf-8?B?YXloZGxMQVJmOENMZFp3bUM3ODg0Q0ZtNGtJbzNaaGdrWFlla2E2NlN3NzFp?=
 =?utf-8?B?MG1oK3FSTUthNnQyZ05od0tSWUdldk4wT2YzRXNQZWUraStBVFlnOXpRTWJE?=
 =?utf-8?B?K1BFZy9WdVVMRldGZ3NjZDZscUhGY1ZMZncxM21XNTlMUSs4NXZ1OWRmUWFP?=
 =?utf-8?B?ZG0wSVhqKzYvUlp4OFM5MGI2clQ0ZEZXY2tZcEZndkp2b2ZGdENEanNOdXBx?=
 =?utf-8?B?UHNXQkNXNU1aRFlYMk16SUJkRHhuVndQb09EUjhWMVZnaEE5WXU4cTRjR2Iv?=
 =?utf-8?B?Q1hBaktCcWovTm5hLzhXcUNrYU5GU2NZRm5FMTlIeG95Y04vN3BOdGJvWlRR?=
 =?utf-8?Q?qQnUytcI1m+diJa/pt6z6ZfMw?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee715c51-c1b7-45c1-2b61-08dbb3dec8d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 22:22:43.8100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k24QR4ufsJNNkJQzADMt38/+Iw4ZBxgqlQL22wlAR9ZkfnnuZ7wl332PHqrkzJGLnzkvmaG6xGRJQvYE4zBnKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5994
Received-SPF: pass client-ip=2a01:111:f400:fe0e::71b;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/12/23 22:03, Vladimir Sementsov-Ogievskiy wrote:
> On 06.09.23 17:09, Denis V. Lunev wrote:
>> Each particular testcase could skipped intentionally and accidentally.
>> For example the test is not designed for a particular image format or
>> is not run due to the missed library.
>>
>> The latter case is unwanted in reality. Though the discussion has
>> revealed that failing the test in such a case would be bad. Thus the
>> patch tries to do different thing. It adds additional status for
>> the test case - 'skipped' and bound intentinal cases to that state.
>
> Hmm. Do I miss something, or in this patch you only split them, not 
> making "not run" produce an error? So ./check still reports success 
> when some tests are "not run"?
>
> The split itself looks correct to me.
>
The original talk was to avoid failing of such tests.
If we would let them fail - that could be done much
faster and without dances.

Thus tests are still counted as "skipped other way".
But I would definitely like to concentrate my attention
on something abnormal, i.e. things that should be
run but don't run.

These tests count be missed due to error (see patch 1)
or due to the missed package. And the reason of skip
is barely visible within the list of 100+ tests. While
1-2-3 "should not be skipped" tests are clearly in the
focus.

Den

