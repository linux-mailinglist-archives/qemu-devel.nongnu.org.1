Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CA4784870
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:34:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYVFX-0005UJ-Q8; Tue, 22 Aug 2023 13:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qYVFU-0005TB-P8; Tue, 22 Aug 2023 13:33:00 -0400
Received: from mail-am6eur05on2071d.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::71d]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qYVFS-0000PS-45; Tue, 22 Aug 2023 13:33:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FupGgt2KU92YE5VINQOY9heSfJGuqxunLenga2hKwFaezoIgqsnKXUar24Kq/rMua82u6TGPa3KG8OcWEgKYHSws6Mdde98PL/j/SvrD1XRCaPISAFdtPCyg8r+qUW5drbAJvVze/+IBhIr5Gz86qbv5hF6Rk/vhoVuEJvXPNWDYY4ur4ro9IbhBCmEEs6Tm9Yn9A55GvsD2IJBCBlYXdMs0wiXWH2Xoc+dJmZby/XyfvP4TEdfV1ULSD1PeveHWCAMsJaIn5F9DtlL30NT/ZAmxkgi6toKXAx6UPsmOH58ZfU+T56Mye6DI1/4leX5rnP98OiC0Xt7WQj8WAC1fYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/16+vxVSkHWHFkkeZFbp24pqnT8Curn8wNyavZYaMg=;
 b=ZNsRmO5J/4JelVy/Jy9TUwpduVubeEEoWqV0jKWU+4TrAti68XlPg+UK+U7dI4wT0exkXhOvVFcQ6Urz75ILsU7D+LMJfZ3ulu1drc3Ur1T11ZgQFJC49+WoXBgQv15sl6/94hPVMGSfLqqiQKSbm8v0FJgTPSvJtYat6ndU1L8MqNe+FtctqxcetrPxtbAi3fyB1KKZCvWpbJo85Dzuw2dbjt5w2oUUE29IC0/63paH5nIdRJ6asZ+GGZ9Bn/rP87TYo8o/NJj08A5OC0MeeZ5RiEJBm4Q24jPcAUozksapgltMBDqq//JQnWO+dhUfQ08kE5vBofhlglhXvK5JZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/16+vxVSkHWHFkkeZFbp24pqnT8Curn8wNyavZYaMg=;
 b=PmR1WdivKSTOAjZzq30EYn5IIfyGJkGTuzReeJVOF+7w8vLBYyjUMG1XYNaM2pJEGaVPxP7qdRKepsG9YKVzZ2HGK47ZJ9wFzKUzqGlsS6cDrk3VBFDqdOY0lq7fOYytfEaPo4qXcq7GL1Pfh5S37ZiIW5ZPLL5p1Ku1+vmjsJuV3EOyKPL6uYBJpEoTtI2jW4LQlBNZFtI7Akol+EZ4mHX/A4+R4pJ/MkxlxkaAJFwn/vrsXv2tUQt26Rm2Nz7CVhe08NAqI16BYFFzE2A3FH2a9nfypmQXq1gV2Sm/VQ4THc1WG26MCBhVH9Ti6l/8TTBRo8TE41CeHAlLyoFL6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by DU0PR08MB9004.eurprd08.prod.outlook.com (2603:10a6:10:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 17:32:52 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 17:32:52 +0000
Message-ID: <577e81f0-1479-41b2-9e97-ad6678cf7216@virtuozzo.com>
Date: Tue, 22 Aug 2023 20:34:57 +0300
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
 <60354ae2-d394-49b8-8289-787b4e02e2a6@virtuozzo.com>
In-Reply-To: <60354ae2-d394-49b8-8289-787b4e02e2a6@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::14) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|DU0PR08MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b95ae65-6510-4973-1645-08dba335d02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: leK+VXDXR1UPlmSmBDeADJH6QB74ZV6xiYa3pXZI+W4mNfKCe9/rAZlOnjy7wwG0d3BQODGWfqGkkY7PpV6JQbThjqUHEgjhM94GvXDFc49FhpZUNOYORQx05mS7DeW7CF7md9lpJlKfUYyocjU57BxwdyiU3RTEkUCuz1wLSGQjjoSoEXUXiOi23mD6BFRctcqGnZDg0tJTOTrIU05jv0QWl9DS8jr+kZSmozMmdzd4imTpaFeL8hDOqf+ifGL2nT4+uAG7DXArwIdrAkwLN49XkTGWHyY9rtPyoxqlTbgFfGPKVA6RA5ms3CrR5Dm3HHjgDeBYptK5rpi8GCXKkzmWh9FqUgKaBz/y6qAddzoE5uPKdTo2dEo9HP8J45OgvRsqNNrLr/S3QJX4ReLJTDg4VPlt0PPlpWwSdHZvDMGpARY25Io9LCO3zEzumzA4ZYoxVnfXAymRTNSU0qd2y3ci2nbYzl+b07XOHUdK2ZhOMxbhHFAzgbOxa5KtCgGTVQzpmxbDzxOehT1BrY0ph5RQ9OiUBCmEbdumCbWgxYvQ/ceXN1tNAjR5HP9JBzqhTaIEP4989JDHlQvY92KHJKO5qmi3fGwDHN7gVN5d3U67vPy4Wk0vOwQ45Wq2vlen
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(39850400004)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(7416002)(38100700002)(6506007)(53546011)(6486002)(83380400001)(5660300002)(44832011)(26005)(31696002)(31686004)(86362001)(8676002)(2616005)(8936002)(4326008)(966005)(316002)(66946007)(6512007)(66556008)(66476007)(478600001)(36756003)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTVaV1lRNWpWa1BBOCsydkdHM0x6bTdldEhvRnRIZmVGRTVENDFvVzRKVGVX?=
 =?utf-8?B?bVVIaHcvOEg4emZxTjlMeGQyNzZ4WUZTL3U3M2NaUEl5dFZvMm9OR0F3OWdM?=
 =?utf-8?B?aE0wWFlyYU8vWm4yWjA2MXl4RVZBRTdTbFNGQWpUb2Y2eksxQUVuM0RFOGxZ?=
 =?utf-8?B?Ri8vR1kxQjR6My9vdFNHbFVFVXFnM3lDUHZNMzN0ek5telJtNEQzWVNNZm83?=
 =?utf-8?B?eFAvV0xoaUVPUzI3RUpyR1R5OHlpdE9BaVowMFFSY0J3UXcwdVRLQ3MrUHZ3?=
 =?utf-8?B?VEZHTE11aTdJZjhKZ1V1VHhpeDM5RkZ6QWZZUi85VXAxWklyUWM0c212NVNv?=
 =?utf-8?B?UnNUZ2Q2ekVhTUJrVlRjaW1xenRTZDNuTXlZSm9RbkJ6QUgwTEFOc3QxVVo0?=
 =?utf-8?B?dlFTaVFHc0Q3OHVtYWh4dGVlOVFQcFRtN3NPNWdDRkZHMW1WTU94dktvNTNU?=
 =?utf-8?B?eVlXQ3hsbUpFSE9LYTV4UkVadUpudW1qK3hLaHgzWVpKeDFqNHJwRzR2S2pQ?=
 =?utf-8?B?TWZreVZXNjE3Qm1NU1F2SVU2Wm1DTm5ZanBhejNSWmFmTG9BRTBOTkJ0MVBO?=
 =?utf-8?B?c3RGV1RPTlV1MFNYTlRZc1B6LzM1OUNJY3A1NHlFdHR6T25ENnJ2UlNVZ01D?=
 =?utf-8?B?UDFZVGpKcU5HbGpwMW9vMm1DMWZrMTNZbGlkazZEbHlBNWNOeVV2VGhQSlBo?=
 =?utf-8?B?Tk1VdDhBbkM5ZnpmQUtwbjdOS0hIV2lLWVdvKzM4VmIzb0lwNXFBOFNScmlv?=
 =?utf-8?B?dnNFQng2Y1M1SUlwRkh3Nzg4V1VxSU1xRGxuYWVLTitzRis0V0pTNUd2NU1V?=
 =?utf-8?B?Q3Q3c3Y5Z1dYdlAyMDlDYWU1clZXOElERDM3cmNqaGNpZzZLUGM3T2IrV2Uz?=
 =?utf-8?B?UDRXODNnM2x1ejJBRlVaelBsak12UWVuSUpSOVRRUjFSZmhVMFNiUVFnUzBm?=
 =?utf-8?B?Q04rcnZyWWU3WTJQZDZGaHE1SWFTQUtVUVNYa0trdEhucXZ2QmEzWW16MzVv?=
 =?utf-8?B?cjVzcXR4VjQ1bkl5SFRLQjIyZzFXWXhLUE5qM2RISFp0N2phTHdhcld3d1lm?=
 =?utf-8?B?UzJ1dkxhNWR2ZzBoSDVocGNCdE5pbEs5TXFrUjJSekRSVGtNSkEvSHBGeEl5?=
 =?utf-8?B?WDJpbmVtaVFNSkplZE5WT1hoVFNCRlBNRzR1NWEvY3ZSRDFlNW9ZYlNlckpo?=
 =?utf-8?B?blRsNEE3UHRLZ3JEeENkTmZHaTNkUlI4QlNmSmcxRENOYVM0SzRIbVRZRHdF?=
 =?utf-8?B?WUo0T0tNZDJ5dm8rK2FzbzFNQW94ZmlXZnovbHl4WEI2ajQ1d29xZXZ6d2Zn?=
 =?utf-8?B?OUlvNkwrVDdZQWF3OWNYYml1Sm1FMk5UVGRSNHczZ1MwTjhwNi9ON1BwaTl4?=
 =?utf-8?B?SUQySkkwTlUxQzZqbGlUUFliNWlFcFpjRXdadCtKalROT0ZIOFJjbTlEZlRB?=
 =?utf-8?B?NzVSNVl4OW9WWEN3dmZoMndlQS9HSkZSTG1SajdkaHo2dmFIZ2JqRk5VZmQx?=
 =?utf-8?B?aldBM1AvWFh6elluUEJBbEhjdXlJRFUrOEcwam5OemZ2WXVReksrYWlnRlho?=
 =?utf-8?B?YnZBMDErMGRiclY5ZVhQNEVVK0RJRmpMZWdySWU5UHg0anE0MWZMbStRRTNF?=
 =?utf-8?B?WHF5c1lDZVZCK1A5Y1VVbnpZU2JBdlVXdkRnWWtrK1hTVk0vS2Q2VTNVZWU1?=
 =?utf-8?B?QTBIU0wyaVR1a2FZZ251SmdUbHVpN3RIc3VzZCthSXN0dzc2SkFMbGhVdnVp?=
 =?utf-8?B?TGIvTlNHVndIeDBTZEthYjc0V0puYlFYdTVTcm1YSWtxRTJhbWoraHdjd0k3?=
 =?utf-8?B?ZUlQOHVFMnRKaGkzT29BZXJNQTVBR2l2N042alIrVjdTNkFmODJGQURNTDJu?=
 =?utf-8?B?UUllckhmb08xbnFLSEJsdGQ5TmdYZ3FuRncvNzJ6QllzMmJiVUMwV0hzaW1F?=
 =?utf-8?B?UEhmdVpNWGtTdkFuVFRGWlpHWDVHbFlHdFlmTFNMRXA4U2M2QzBRWkVQdzJ1?=
 =?utf-8?B?Mm5EazR5b0I3NDN3NWI1UjlMTlY3dnhUY3hJUmdielJMdUpJMWd5SDE1aHRW?=
 =?utf-8?B?MHNaOHF3Y1k4YU9KQXkyTFpGMGJLVXpnUHJpbW5xdGY1SnNoTUtnOUtnRDB5?=
 =?utf-8?B?WUIvTW54T21HZ2lOdXhDS3F3MUwra2lwM3pSR2xHUGZpYjFiMDhNYlpFYlRD?=
 =?utf-8?Q?Ei7eR5mFJbX7SuH3evZQN+U=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b95ae65-6510-4973-1645-08dba335d02e
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 17:32:52.5678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1raspwMm45ltiCYmNcnOXlAWmkxYiC8h0mCeFxBq92e5qBESuwSfUGzp5uWBO8voqGdvp6Pk4xi7fl8mvDfU+0WOWwaEkm53JuremXTtk3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9004
Received-SPF: pass client-ip=2a01:111:f400:7e1b::71d;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

On 8/16/23 12:22, Andrey Drobyshev wrote:
> On 7/31/23 17:51, Andrey Drobyshev wrote:
>> On 7/24/23 16:11, Andrey Drobyshev wrote:
>>> On 7/11/23 20:25, Andrey Drobyshev wrote:
>>>> v1 --> v2:
>>>>  * Fixed line indentation;
>>>>  * Fixed wording in a comment;
>>>>  * Added R-b.
>>>>
>>>> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00606.html
>>>>
>>>> Andrey Drobyshev (3):
>>>>   block: add subcluster_size field to BlockDriverInfo
>>>>   block/io: align requests to subcluster_size
>>>>   tests/qemu-iotests/197: add testcase for CoR with subclusters
>>>>
>>>>  block.c                      |  7 +++++
>>>>  block/io.c                   | 50 ++++++++++++++++++------------------
>>>>  block/mirror.c               |  8 +++---
>>>>  block/qcow2.c                |  1 +
>>>>  include/block/block-common.h |  5 ++++
>>>>  include/block/block-io.h     |  8 +++---
>>>>  tests/qemu-iotests/197       | 29 +++++++++++++++++++++
>>>>  tests/qemu-iotests/197.out   | 24 +++++++++++++++++
>>>>  8 files changed, 99 insertions(+), 33 deletions(-)
>>>>
>>>
>>> Ping
>>
>> Another ping
> 
> Yet another friendly ping

One more friendly ping

