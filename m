Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25622769A0D
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:50:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQUDC-0006gi-4e; Mon, 31 Jul 2023 10:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qQUD9-0006fY-D9; Mon, 31 Jul 2023 10:49:27 -0400
Received: from mail-vi1eur05on20724.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::724]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qQUD6-0005nZ-My; Mon, 31 Jul 2023 10:49:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHvWzhaZwJgg7QLriBVF+ReZ2JbHm+sQl0MeN6IGlyp830zL8jER6jCtXU1X30gb1QEwXQnkTHmgiiZ4YteBsKODcd0EKQdZKxgZ7Teau9DRGalsXDfnkSLaNGoytFMAHFINM6fsvutcrqUuvEsqv6mjN9KIFXEI1k6sEByGs8wXyggBOe9egKHJPBLd5uFIfME+0zVTQwE9EkPxr4gjGSPbobnC6r8LoZOwW9sIZFbAA4nXy9jZh429O5i+05FW8kbpcTNLSmdnOmD6GBVefXUAWk7uidYWkiRM9flo5uFQLjMYRU+HP/ECyWNtpBahr+4L+qKO48UyMWR9U3LNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsw8afC5OvT1dhiK4jleQo9aRz7GJyFlb1yfLNW6B54=;
 b=i4J8Q5AVH+COaYQdj98UZDFqwm6Ay1/n65k7lFLEdnbhkXnUrsO82OmWHGvwwe58dPrB5nLkQMN/046hI5iL3JX/80FQ4qNieO9SpQk0AWkLJxhQQkLAsnsWdeVONROcJKryGiovoyqzyVxzAbwJwNqiZ94JX3ial918t+6oLoETXo3/MuE+qUP7T+Jj47tuF0+dvvSl68JjkY+n/1WhbQHnMTP4OaM60hNa2HHOmzAtETstt3/BEhb41SEegm4JIiZOFpGpaxktx28hZBQb8jL3lQHZFIUCgqYMbWskC0ulyzZKRN7q0BrGXCiV3GNWF7+lH24AnGTDFpf+PujecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsw8afC5OvT1dhiK4jleQo9aRz7GJyFlb1yfLNW6B54=;
 b=L6+wpkxrTGvVPVAOypHOupfqzVA3FgYRharYAX+hR7Ft83BeMMKD+a5ckwzgvEOV8jkIfMwKqFU8WTI2W4JJR5AaxHiOAaPXjYFFptzJqzAcBkP2GgQgJvu5sCfxk06UgLbl+9I+bQVaqmT4tKitYNb5Vd7XnM/Xfkddy6ykzOCGbVhqIL0K8fo+rdzkA05d4gTkcfYqTrzdGmHGr6RpCTi69XCHt6XokIxebfRAfH8LtboxD1nsl/bPFP2oc+4YsKY0mmKo/PGiYPWISgtEojonXkMOADHzyuMvJKeF5W+uv52uddi4oMDZ9mjiJpk0oez6ZV/UyS48Csr4JQ8Qmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by GV2PR08MB8511.eurprd08.prod.outlook.com (2603:10a6:150:b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 14:49:17 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4a49:5a92:afb6:c681]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4a49:5a92:afb6:c681%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 14:49:17 +0000
Message-ID: <85e0a9bb-8e8f-e414-70ad-528e45a803e4@virtuozzo.com>
Date: Mon, 31 Jul 2023 17:51:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block: align CoR requests to subclusters
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com, den@openvz.org,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
 <c49fd209-9a6a-9e0d-752f-30a5178d855b@virtuozzo.com>
In-Reply-To: <c49fd209-9a6a-9e0d-752f-30a5178d855b@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|GV2PR08MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be55a19-5eed-46bd-26e9-08db91d5508c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PQ/uq9u9/MbHCBC3+xImMQ5E+GL5EWHs7vTHhIJ9+sDHaIkWJUZ8ceIRdKdLEBDiYOBvxXM8kEzKKtxgcWircwZpbCLowUMUndI5AfbULXLr+/wsxovh4S514+Y3qW0MaoCPjtiEJOKVFCMfT9PHidrgUi5r0WwtJIHFkTQ2RGkCSkUfXofNzI+JbBMHZp5EjvaMtcMCZ2arDXfaUmndfN9xweBubDV9aKyZYm25AmAGKJe5VXTC3t6YqyQOa18fbymOSIr4UWauYCcat7bUppP0+XfDDI/67TWgOeAPHGJCx7N5pmsBNUaNRcRcaw7HPpcfAw18RyCsdFiL2v3FWxLd8AxINKR/Qc8f2aqd0C8ig0mC2hfigwzuXFNO8rw6yb0LuIFvlko3U3kbx36Mdpfz/BDGi7NYUk7Hx2dZjVGVasIIFZs5tP9ChPx9/D3ZAZBJ6O2Aob18Gd3Sq8UrB3abY2TtlmhZmB7FtCCqJovtbopdUacxj2PVnUeZbmz1Wi/VoWRDfz6E+gBS0z1zgWJtMfyMIxMyzc/HodHvNmvchFvOHHHGEAHNq9cdEn3Mp1wxmj/9eGlkmxgeyfcjIS8enRw5HoEADEoYYiJLA/hmIvb6csOkpnZEIbEuswE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39850400004)(136003)(396003)(346002)(376002)(451199021)(966005)(6512007)(6486002)(36756003)(53546011)(2616005)(26005)(6506007)(83380400001)(186003)(44832011)(66946007)(66556008)(7416002)(41300700001)(31696002)(66476007)(86362001)(316002)(4326008)(5660300002)(8676002)(8936002)(31686004)(2906002)(6666004)(478600001)(38100700002)(4744005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZPUkUrMiszUXlsdnhGcFRNbENkYkhQTVoxVVV1cWowYjZmWHMxOVdVckZQ?=
 =?utf-8?B?Q0ZUVGN0bCs1TWY3bWpwTTFnd0E1ZEZIaHVEbDI3UGxZbEJBaG5kek00a1Nj?=
 =?utf-8?B?cmJFdHlDU0pnWHM3RllyTHVRNXhpcjZLdVhmY1VOR3RkU0I5WktxUkt6cDJh?=
 =?utf-8?B?Q0VaYlVaOFNFZW13RnM3TDdWZ3JXRXUvSHhNcU9xTUhaTjlNN1A0bXBRNFdP?=
 =?utf-8?B?R1YraTNlbi9zRHNzS2J1aXlXMFoyWlhVKy8wSmIyMXh4WGFaMWJ3K1BsQ2JZ?=
 =?utf-8?B?cFEzTXV4RWRmSE1ZVjdoYTZIaStFdEV4bG9VUEtGdldCTHE1Mm9tYnlnTEZB?=
 =?utf-8?B?SHoxOXQwVnY1UzJCSGVrOWZnazl6dGVOeTRJcEg4aEZqUlVBYU1qYXQwd3Y2?=
 =?utf-8?B?aXNjYlVLem1TV2MwTTN4QmxjUUl6NS83d0N0NzFLOUdtbkJvYm03OGFUbGVX?=
 =?utf-8?B?eitBQ3NGaFY1Slh5U3hONzFqY3lrRi9GNVNPYWpXS09pdjZmc3BuMERwS2Nr?=
 =?utf-8?B?ODNiRnFRS0NxYW5RWm9VOFNFVCtQQS9HWFlkdHlVbFBJRGtINDc4ZlNKbTZv?=
 =?utf-8?B?azBpT25wd1ROUS9yK0YydTRnSDloaWIzNWVwSFo2T1JYeUhKSHA5a25Sck1w?=
 =?utf-8?B?c1R1SnI1S1d6bkhSTUZkeURSQUdxSHNxQ3RzVEo2bVNxUlkrcklGOUtUNmpi?=
 =?utf-8?B?S3dZVVM4RXgvcERSbU1QOWxRbC9GcVZtMDVGRzNPQmdEWTgvVUVKanRhK3BW?=
 =?utf-8?B?dkdJREtoczlFb0tMYzk1STBDS3dtQ3llNlZWMVRRUWE3NjlNVmkraEJNWGxI?=
 =?utf-8?B?eURtUTI0akIzWUw5K0VWR0RjYWRPNkRieFVlT2srUmpxaWJqWkdwTXUvaHhp?=
 =?utf-8?B?ZnY1YjFXeEpCZlFZZkx2eVlac25lUi9LOGF0SWMwMjJiSjkrQklqdWFoVTU0?=
 =?utf-8?B?T0xiZHVSc1NFTURSSGNVNFppZDRZMCtia05TVUJtT0JpcmZIRjdtWUlING5t?=
 =?utf-8?B?MUNtU2lGWEFRWE1ISStEdWlqMzBsSVNhdlVKODFtUE5Ka1RxdS9WRXF1ZVlF?=
 =?utf-8?B?VWlYdlFEaDF3M1JuaFVub3NJbXJYREp5Rndkc0VIc0VZT3R5MEE1bUVDVGMw?=
 =?utf-8?B?UDkwUGRqOUFRRThGOThFakw0Sk5uTUZSNjA1d0dvM2RtRkluRkJvY1VTTTli?=
 =?utf-8?B?YjR1a0Z5anVDK2Yyb1BCZGRFUnI0V2lnZkt2UjVadWdoMWZja1A3VEhGaFFI?=
 =?utf-8?B?S3pXdHBuZ3AxZEcwQThJUWJRaStOVnhTVkUvMGZNM1FQUGw0L3RRblZGWEdC?=
 =?utf-8?B?S0plN1Vna0xTQXBnMUlEc1RmaU1IbGQ0YlhVeHZDb3A4L3R3K0cvdXdxZTJJ?=
 =?utf-8?B?OCtWUUl4NkVBSDFvWjNUdXFHZk9nWlk0MFFmSE5JTTZDUSszdEpqTTUyV1lS?=
 =?utf-8?B?WHRjQk9FTFRCZlpqYXVGWWVROUN3bHZpemk1ZEgxa0h4Sm15Z2NDRWxscDd2?=
 =?utf-8?B?MkdDWHR2a1h5SkJZVTExTzFoRGpYWmdrZytiSGpzSTcwSXBGWmNPNWZDYldt?=
 =?utf-8?B?eTQxUXNPMDlNNjJtMjZobjN4M0VjODdJYTloYXEyaHlDZjk4aVRMeUQ4dnBm?=
 =?utf-8?B?ajJLbkpOYkZaOHdaMUk0Skl6dy9ueWMyUmtvUU1BMGY5K3Q4UG5lMjhwQlNu?=
 =?utf-8?B?TWZvMUM1dk9WRi82bTE4ZUpJZXgxYUxxRWplMkhLdlBnanF6N2JhWXpuQStu?=
 =?utf-8?B?ZDFabGRkOEQ4SlRtUnhyTzFFNVRFOTlHT25XWGVMd0hpbVd5a0lHZk5QZzV2?=
 =?utf-8?B?YjVCcW9Xdy9wTUJXaXFMZHl6RVNIZk1Mc1FSSDNpR1FuOFdUSWF3YWE3UUNm?=
 =?utf-8?B?c084aW0xMU5QNGw5ODY0a1lZT0sycjNzUy9iS1ZBVXBRZFFFbXZUcHY1S3l5?=
 =?utf-8?B?d2NheWwzM0prYU1iUHBzQ0hyc2NyTmtYNy9NM0NxUmpJOC8zeWt0allSTVJ5?=
 =?utf-8?B?ZmhHbHNZTHhNUFduaDh5WmthNnNVczIvYjN1VXlCWWhBOTdGdkZzK0JoWnpa?=
 =?utf-8?B?WUhTYTRsVWk2U29oMEwycnhZNzRhWGJuVEowTHBadDdyMDRYRnhRK0doYjAy?=
 =?utf-8?B?RWpTTmtRcXRoQm5aUWpBbjlLYjZIL01kV1lNZldyV3grK1orcGd2aXpSL01z?=
 =?utf-8?Q?hj+C/RQt/tIkm940oukjijU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be55a19-5eed-46bd-26e9-08db91d5508c
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 14:49:17.1792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxvWdpbx9m/PFt1JfRpcxPf/yeypIVRxrHBu1RYczZ03EN9hvQVDl0QKy1QDmMDRxazG4JrspaX/K3aesWTmAXhQ/hKjRms/byyEok8t9sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8511
Received-SPF: pass client-ip=2a01:111:f400:7d00::724;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/24/23 16:11, Andrey Drobyshev wrote:
> On 7/11/23 20:25, Andrey Drobyshev wrote:
>> v1 --> v2:
>>  * Fixed line indentation;
>>  * Fixed wording in a comment;
>>  * Added R-b.
>>
>> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00606.html
>>
>> Andrey Drobyshev (3):
>>   block: add subcluster_size field to BlockDriverInfo
>>   block/io: align requests to subcluster_size
>>   tests/qemu-iotests/197: add testcase for CoR with subclusters
>>
>>  block.c                      |  7 +++++
>>  block/io.c                   | 50 ++++++++++++++++++------------------
>>  block/mirror.c               |  8 +++---
>>  block/qcow2.c                |  1 +
>>  include/block/block-common.h |  5 ++++
>>  include/block/block-io.h     |  8 +++---
>>  tests/qemu-iotests/197       | 29 +++++++++++++++++++++
>>  tests/qemu-iotests/197.out   | 24 +++++++++++++++++
>>  8 files changed, 99 insertions(+), 33 deletions(-)
>>
> 
> Ping

Another ping

