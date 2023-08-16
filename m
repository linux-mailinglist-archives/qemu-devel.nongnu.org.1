Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 482EA77DD27
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 11:21:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWCi3-0004TL-8n; Wed, 16 Aug 2023 05:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qWChm-0004Rq-TZ; Wed, 16 Aug 2023 05:20:42 -0400
Received: from mail-vi1eur02on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::72e]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qWChj-0006gC-SA; Wed, 16 Aug 2023 05:20:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUDPp3b1MMIdd3YXfhhJeFWTzwpWlQIv5JepV4gBxsl9dD+n3ZLzDB1ECCInFwFjyzH/xBK8TflHzPRoycmZZth7V7mr26ZQ5n18bo0LIt91zfu87pcw2UCo/JUOyCcjOqOEpeyEH0A5nSlC8XXjyfVfhM78wD6fXP3diupMqBkpVf/AUMnHslb51il+ovvOI5IHdY8HbdmtUlh1t2pXM+/MY4RtbKvAF9ttP13CNEm68Fpc6GU9kvFIfU+yiQcRorIVLJH7v54GkgQHreYlxIoTu9KuPU0TF7unxqoa/+txSnLzwO7PD10AB7AAfexpXgUcLw+2fmnN03dpm7Xj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwNQEri0EHqY1FkBVesn2SRDxM45Zi2gMqqWQs+7c0s=;
 b=Uh+X6qjYmyf1OeLEuE5IC2wK7bnMSM6gRKXcvt1Y1lysf789Dt79z4E3xTLnj7mPde3guCS2ct9gsunJVDcooydAhWDbmLKMGbVR5Kj+MY4Epk28WMjxOAo2/R326PCUKlaeXRzXfPzF+l2sm0IfmB6cti13k6JIm8lQTlDQExs1qi2JSRSki/UWzuMHiPDY3mZebrW6wWYKTQkAb5rNFAaGK10jZVyVyUR6FqEUn1ow8ny0GHd5Af+mD4uG6QYfoDk9JEIRt7/iyNmRCdFD/dhyXh4NEjaj5HaQY/rYN+6cjA3OfJ5tUUtG+4WtsakQk0vYpqNwRHgTN6FgsAFUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwNQEri0EHqY1FkBVesn2SRDxM45Zi2gMqqWQs+7c0s=;
 b=pU4jNONrSiaoazsEZzEG/PPnqFDjU2N8bvU0fkiRb6cuJs0yFnEaW00OmD9kEnFtFSZNnzFhJKe274yYFZkeSl8xVehX8K2/x/YxtwZdnYlNOPF/fWEZId7oWwswupE7QSfpYR5GFiywaOTo7ICaLFp43vFHmAwSzq/nAp+TRhzLyh/ptK4sXaNrHna3JqETLymCPE1q4osylFdikyzIRMXHxpO1D5dV1vwj/AMQmICOHjhWGYClc9sKNJOi6VS4DQ7tJOMFsXT6TCR6Pr8SsIP65++nhrOMe8Zq9GUfp3eGssqR6/wOEmNOkLV/ywHIFnSTtHCN6XFLZchl2BDWjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by AS8PR08MB6149.eurprd08.prod.outlook.com (2603:10a6:20b:29d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 09:20:34 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 09:20:34 +0000
Message-ID: <60354ae2-d394-49b8-8289-787b4e02e2a6@virtuozzo.com>
Date: Wed, 16 Aug 2023 12:22:36 +0300
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
 <85e0a9bb-8e8f-e414-70ad-528e45a803e4@virtuozzo.com>
In-Reply-To: <85e0a9bb-8e8f-e414-70ad-528e45a803e4@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::7) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|AS8PR08MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 14241c19-259d-463e-263d-08db9e3a0bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrWsk+1ob4NWtUUM75yFdyywJw0VsfYjebh2ocMMUzCeaVkL+m9HjJWsT+qHaJxerPof0gZEcJZAAr6nOU0vEYQfXNOn7a0Xsv8BRO9MWCy3B1g6Zy9qgjKXaZjqM1Ny366NfcrhJi/xXFBkk/6/HWvth9LeGIxG5BKBZsmKtm7Q6yDV2izwU9BfFud7hoNNLjvIvgh9KZSsofQPZGSB5SGNXKgs8JYUzULrFTK0uqgJfvxyvjtNd8p82+iAthoY36PA4lIttev2gvxPT4Y6je0LafTapTRRehr+hg2DKgMLSN+8JXbBM6+QoJfm0wU8qoBi0tYaamsOJE1uLKIj4rZ2w2ScAvTLWXZdOdKqv4rpJQVdU7lvSItwexu40CVFXRcPnhIalylgAP1LEPaUI1qsj6GwhDFxdmW2bgIfKoORnbxwmUd3XdJnl5bJYDtlArtoG4pwEesKobdtelslqDy7Oe6WU3kbqykOcQ5JQNNdl2VrcaiM/383YMRs1m+mgMTmNEtaitzZTa7tsPRETkIx9D5hX34xcL87iNGU3jTEJzegITQLgFGGgb4RF/k0s/8HZURK/U+wR9KLGo1GNVVkSXwcWz2ERy9bDEk+L4uLMmNYmYLPzJBVmd6SgNEQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39850400004)(1800799009)(451199024)(186009)(2906002)(83380400001)(4744005)(7416002)(86362001)(478600001)(31696002)(36756003)(2616005)(6486002)(6506007)(6512007)(53546011)(26005)(966005)(5660300002)(44832011)(41300700001)(316002)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(31686004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFJmUmhBb2lOSVNwa1pvcHc2QnJTOVJlY2tXTVN4aDEvb0RXNkxJK1p3bDVY?=
 =?utf-8?B?Y0RQdkdCd09lb00rL1B3Q201V09OVi82Qmg1LzdETEdpMjdRUUpHcUVlV0pO?=
 =?utf-8?B?Ry90eGZJem14c2JWSnZjOWxuT0F4TVNRL0szaUFUeXQ3ZStjRkFRWlJvaVlS?=
 =?utf-8?B?RmlGR2xZL3I3TW5HZnorOTMwNW1kRXVTaFVCaDY3Y1g5ZXZkbFpwT1dDU091?=
 =?utf-8?B?em54NmJuK0YybnBQVjBQOVdIc0lhL3o0dU81N0dselRQN1FWbDR5dXh6c2hX?=
 =?utf-8?B?ZklsNlJ6eHY4NVNFSzdSK29heHg2N2wyL1YwZlFKeC9ubmVBdzgwMXVzemhH?=
 =?utf-8?B?ZXFseC94UEZtNEMrRGJxanh0NGp2V3Jianh0UVArN0dUMmFZam0rd21yOUFl?=
 =?utf-8?B?NW1QQnJJcm5FUzFISy9lNzlIZEFRSWVCMncxL2xiM3NMbXZONFkxemgybUhI?=
 =?utf-8?B?VnE5UEx4bWRVZng1Q293Vi9jbGNSSFg2NHRveDVRMEU0K0hxdEs2WGV2aHVH?=
 =?utf-8?B?WlJHOW9pYklINEt5Ung4L2VXSlREUTl2RHpiLy96K1c1Sk5nWExCNTVwWmhw?=
 =?utf-8?B?ekVhUlluT3JSRm5mRWh1ZU9zNVg0VDgzWkM0V3dKcklSMU9Ra3NJOWxkNjQ2?=
 =?utf-8?B?WEUrOFNkT2Z0bFQxY2x0WVg5QmhXYXFzU2hqSTFCS1VkV1hCNFd3WFM1ZllD?=
 =?utf-8?B?cVhUU2Y1NUJnYWZoa0gxRWF3VTVjbWVWbDRaQXJ1ZXptUkd3VG1qWGhXUkJ4?=
 =?utf-8?B?ZFBFZnJMOVArUndnSXF1NzBlNWs5RHM3SVYvV1g5OGxGajMwTmJsOG9FbW1M?=
 =?utf-8?B?RmUyVjJRRUEvMDJPTXYzWjRNczV6bHNTOWNUVDdkUXFIRTljcHVKQ21qTVVP?=
 =?utf-8?B?dXArYm0yVmhQc3JDUWwra09MTlpzUzd0ZFIyZ29IaFg3QjRna1pHVzlsNzhw?=
 =?utf-8?B?QXRGMjhiVDM5Y050eTM5ZWVyVlhCVXE1azBRdHJqekEzZm1OazFqZzFNU2wz?=
 =?utf-8?B?ZXBlTklycGpOTlRWejV1RWpZS2piYlpWczM2M0FQUVNsbVlMaU1SNXBudUlY?=
 =?utf-8?B?T05wd0lJR3Z1a01sWElsM2lkVURmc0ZGTXcva2RDei9QUWp0ZHBtMWlxZzBZ?=
 =?utf-8?B?RG80cXJIWGxOTytOVzBvKzd1Q3V3SFRMUnlidkZWcyttWWtlYklOeXpDbHRt?=
 =?utf-8?B?blAvd3FEeEFWWjNuUENVYnNjdytCQitrNHEzTWppR0drQnV2K1hQWkYvNFlv?=
 =?utf-8?B?bDRBQVZzYnFPYXJhTGZkOVFsVFRpaUI2QlUvc2JMMDRiWXplcmhPT3doZS9a?=
 =?utf-8?B?M0N6K3JISFoydFVPVHlSbi9La1hPZ0xheU5tNDloaWlMcmRYaytadnRzcWhT?=
 =?utf-8?B?ZGh0aS9xaFMrNm51NHRFTE9qRkxCa2RzenM1Q1FkZXZtV281bjhNNENyWkN3?=
 =?utf-8?B?dEFYeGZvUUtybVNYOFErNWpkSE9CMzlINjRwaVBPN1pkTERKMHd2K2ZMQmdv?=
 =?utf-8?B?YjFIOWkrbnh3YlEva0NzUFkrTDhjMmozY1A2K09peGNQYW5ZWEdtWWlSVWRx?=
 =?utf-8?B?RVgwZ3gxa2RYK2FnR3kyR2hlUnJSUnZ2bDNNTjc2VTI2S1MvbzRYZXBuZDlW?=
 =?utf-8?B?Q1JMQXdGekNEaXBZQTlEUnQzN3FEOVhkZkZnOWlqYnloVFp5MUVJSVVCQ3E4?=
 =?utf-8?B?VURLNEtPQ09PSlRReUM0RXQ1Y2RxajlIeUxtVWJwV2dRamNNY0cwMHJtNy9N?=
 =?utf-8?B?SkxHTkR3Nk9aUWQvSUhQSGVZRUhhRmJwUWM0VFYvNWRMK0Q2a2FQcGNadUFZ?=
 =?utf-8?B?TDdQbG12UlJVUmVXM09LSkV5cTB1cWQ4YmhFbHJBK1ovTk1JZ0F6WUpBbUdQ?=
 =?utf-8?B?aFJ6cG45ck5rd2ZGUGMvQ0NBeDhXMjFraWl6Z2NLeWtaM3JYcmZCbzlKcHA2?=
 =?utf-8?B?N2F4aVpqaGhJRlNzQ3c5aDQ4Zm5sNUFZRjU4aUphdnNPWkhrazZTQVhGdTlB?=
 =?utf-8?B?dG8zVWk5RVAySWlvNkplZkQreWZubmUySVVyZG5yTW5ramxCR3MyOVJLRUxz?=
 =?utf-8?B?UktpTThVeFYvTWVRNmNsUXNCRTdJSHlDSWpaOEIxUG1TU0tJNUt6Rml1VG9S?=
 =?utf-8?B?YWhpTGhpdzRDc3BMZDlDSGk1T3FvY09oN0c5RDBuUTZZa3NHR2hTeVNkUWhC?=
 =?utf-8?Q?G7lAJfd0pO6uycacdFt+HUQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14241c19-259d-463e-263d-08db9e3a0bca
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 09:20:34.7510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibVcw+0K7kGCE+Nh67ADLSb1ourNT8xe3p5XP2DsfVA2a0YPZMqN2/9xpytxRqamtRTnjogSZJvIFD+2tIC6rbW+rIz7ctATira87lSWuAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6149
Received-SPF: pass client-ip=2a01:111:f400:fe16::72e;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 7/31/23 17:51, Andrey Drobyshev wrote:
> On 7/24/23 16:11, Andrey Drobyshev wrote:
>> On 7/11/23 20:25, Andrey Drobyshev wrote:
>>> v1 --> v2:
>>>  * Fixed line indentation;
>>>  * Fixed wording in a comment;
>>>  * Added R-b.
>>>
>>> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00606.html
>>>
>>> Andrey Drobyshev (3):
>>>   block: add subcluster_size field to BlockDriverInfo
>>>   block/io: align requests to subcluster_size
>>>   tests/qemu-iotests/197: add testcase for CoR with subclusters
>>>
>>>  block.c                      |  7 +++++
>>>  block/io.c                   | 50 ++++++++++++++++++------------------
>>>  block/mirror.c               |  8 +++---
>>>  block/qcow2.c                |  1 +
>>>  include/block/block-common.h |  5 ++++
>>>  include/block/block-io.h     |  8 +++---
>>>  tests/qemu-iotests/197       | 29 +++++++++++++++++++++
>>>  tests/qemu-iotests/197.out   | 24 +++++++++++++++++
>>>  8 files changed, 99 insertions(+), 33 deletions(-)
>>>
>>
>> Ping
> 
> Another ping

Yet another friendly ping

