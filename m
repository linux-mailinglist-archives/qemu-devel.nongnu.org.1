Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F257FB3DD
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 09:17:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7tGD-0008KO-Bk; Tue, 28 Nov 2023 03:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r7tG6-0008Jt-Rw
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 03:15:57 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r7tG2-0005fO-J4
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 03:15:54 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AS6benD010252; Tue, 28 Nov 2023 00:15:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=LIFdSuXFNQSi
 2nq+gNyB2nVn2mgWv29y1Zg9Tmlv1k0=; b=S4vOxX33WYlM+G21qKDnMydDKsC1
 Qr+eabxi3BrwqwOuBRK/+7q1rOV9MB8MQ8BUDp09UhZUW3V0pLN9pHtZziRWPj5o
 2fqBZk/msNb/vaxscM+RyBkDkvFoTeKR5MMLc3tnpp+yKB/PKmUhpM7MgE6vBDvI
 8GpJwp+g+16pryEGbCnsKOMuzcYUN/qjzfIxjuNii9aeRGA0ZN1fJpO3AfQbSgf/
 IeEA14sVop/SCTMpteSzZjpzP6NpQ53ZLfHGAVHOxyI2Fe5twRe2eQAvfU/1HH6r
 tcrVirOE7SqOuFYsoYDsdV+8mHhuVuX42n57UJdiA/GPlFLABqieULpjFQ==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ukgvhvkyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 00:15:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzFRtshm9wjgVv4dTWsX4kQfI4r1K8tpfJpHTsQAslXHb5jUN2I6A/IIRYMbGmhwNhpTr58TCUHyklgnnOhXCc8fCJa/YuAV8tWSzNVHEsGN3x5FA5dcQPxrNf8TpwSyPHMgrSjWCex/Z1J10jBjnnvEOzctGz++69f768XRKIfapg8dWD0m6m5W1N2H+Fj95YnDF+U0mE1fU9dF679Lc5n+jPwfJle20OwacB2kk9NPLClF7Nth2sWI1spfpDZVr0XogpIGaXLapBlDMmH0qEo6pVcqag1Ou32kSsi0UWmpZVVz7bgfAXJWEkCM63t8JWYRlYssS4+BlyA77oyn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIFdSuXFNQSi2nq+gNyB2nVn2mgWv29y1Zg9Tmlv1k0=;
 b=aawpftJm9+t03580/8REwViwQ8r/T/E7G9RYfBUlE1rWQlo18KaOv/UFlUHJSlQQvfh39V/gN7QCQNEN1wbzicYRIuDw0LswOUuu9TVJ+OYB9snEu2ALhal2kexyOGVy18iMOXeta6IXW83L2b3bnnXfrBg5y+nVkPjnHqzv4AbGjz5vT2hkG/PUw2a6eC3taAygFNjgh74VcxtdIUBLgJWPki82GHvZjx5yu+6yq0fIWsZ3aqQTR6qMIFZ/tpoJqv7yaeIxnJwVld9YKFwGLxE9N50REgXKNioI/reLvKBTUd/hHFIhodVeQCXqWTGQagkhZ5XTbB5aoKAzkmbVeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIFdSuXFNQSi2nq+gNyB2nVn2mgWv29y1Zg9Tmlv1k0=;
 b=uGyNYHQUYiAArRyjQeBVxMyL05piZu/7PUlfIlkLFi0B1OnUuu7578epwVrKKqRuP4chz0Ltk5fqUh316Dj1tovSlClKg87gngyhzuzQlLYH/EFJtG1UKqBAlBe7kck72QzaxAoEq32TrHuyrA33tnp5YQpu/z/YZnHZD8GYLiWIhswzTrRGlVZyzxQw7WCWHt5HbMc1ECxQtw0SVuJzyUsS8kBgnghdzJDNZ1KPi2j2Fx7mZWjwyKoeomgBHq6HiElkZf5WAKoZi9HxMCDwhePxemAZHVjzgfUeIWnhnPn+hkDfXvc7oIu+u4qJAm0t7aW8vyYstKB8fbjy0LsWtw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ2PR02MB9849.namprd02.prod.outlook.com (2603:10b6:a03:538::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 08:15:42 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 08:15:42 +0000
Content-Type: multipart/alternative;
 boundary="------------TFamy714YmSeGJzxvhAFLYor"
Message-ID: <db753099-b8a4-4057-9459-5174ff81ddee@nutanix.com>
Date: Tue, 28 Nov 2023 13:45:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 'channel' and 'addr' in qmp_migrate() are not auto-freed.
 migrate_uri_parse() allocates memory which is returned to 'channel',
 which is
 leaked because there is no code for freeing 'channel' or 'addr'. So, free
 addr and channel to avoid memory leak. 'addr' does shallow copying of
 channel->addr, hence free 'channel' itself and deep free contents of 'addr'
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, farosas@suse.de
References: <20231128062520.36456-1-het.gala@nutanix.com>
 <87a5qy4aag.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87a5qy4aag.fsf@pond.sub.org>
X-ClientProxiedBy: MA0PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::20) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ2PR02MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: 896b62a3-210b-456c-358b-08dbefea3626
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuAhWOqMPH6tJfyj4E6y4NC4T5uzQ1Nv/UPbhU7E1D4iHgrUs11mYiBdGMkPzGySI6lOCGcy99I7M5518nOGHrW2wt68l+0rEglaRNIiTcYxk0c9AcO3NBwv/B0MBVYaHLW6/isTIwv0OxOmglyMCWVB3RXbaJul3OhpQ31oLehe4zo/rsinf14I+ydRLvHRb5Xu8A/anPNZR0NQR/iswBLuITwJTZ8AK+FBw0eWt+Gx6l2Ij23hbwT2LFYfzLQH3JQ0kOIOodGlKIx3zzqVxzByaI+mdVCfa8ctkRQGDFXGsisoC7w36GVnOED/7X/NC4ryfqu2czGOpZw6zZqG7Ro2VjrqWHoi5HEwuHBRCuVFmVIZCRtYaLiD2s6iQpTgQdTW35cdUiKJDHm+iIsFuxtul++FdV6LrH2bTcX6IarrgN+1G33xXHbNp3xZ4G2jauWA5Owr0M/xRuLcOncC2I6Ri+5GKKFJLAzy6A20odZM90j73E8qNbcafUwp0irnA51X3JCYgq2xuMJJDmbB4PrS6+LySGsvJKqzAj7SlTSnSEilYBWJ+AffFKV+xHQsCMN3l80vONc65SfgdQdiJMexYFg+qOOWkTvJ1F+nIMtspBVartxgZ+zYDS3W3zG46w1Dzsa/hfkzRjy2Kgr4IQBpSts7ZBcu4SsBT1xsNsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(38100700002)(31686004)(33964004)(8936002)(6486002)(4326008)(6512007)(6506007)(8676002)(53546011)(6666004)(66476007)(66946007)(66556008)(6916009)(31696002)(316002)(86362001)(44832011)(478600001)(5660300002)(2906002)(41300700001)(36756003)(26005)(2616005)(219693005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2VFbDhFYkV6RERRMEphdG40Vzd6ekUrbHVaRjk5WnErSzl3TVpFUUNmbktX?=
 =?utf-8?B?UVk3M2k5elpVcHloZXhSSC9FVk9hdGI2aS8zT0dXVmQzN3FMQXJISUpKVk13?=
 =?utf-8?B?em4vZ2NDcVB3aFpzTEw0YU53RHNDbW1kMTFJNzB3dGlGSGJTR2JTVjkzUzNj?=
 =?utf-8?B?Rk52NkJQQmdadVN5QW9oRUtzS3VqTUU2MkVXWU16WHNCV25oTjl6cy9vZi9N?=
 =?utf-8?B?Z04xc3JlZkZZcFJJN1Y5VkRaY1QxQS9VMGZxRFE4UkRsNEJ2VXgzQnJtUDYr?=
 =?utf-8?B?ZktURXhvQXlmSXdEdVZZNkhHR1lSdVVhN1ZNa0xRamZJZWF1YkMzTEpsMWVE?=
 =?utf-8?B?cGU1cmxrNW1uRVJkSk9Qa2NXZENMSmh3UTdOL0RsdDZnOENhQ2J6MGFIblp0?=
 =?utf-8?B?ZXpWR01BL2szRGlIUVVrVG5zUEVsVWNrU1lzdmtLdXBnZEkrZW1zUUJKMUVo?=
 =?utf-8?B?czRTR0hLREhQUHZZZnNOZExVR0VrWVV6Skh1QmkzWjBVTkl1R2NqRmxiNEk0?=
 =?utf-8?B?aGRSQ1h6ckJtK1BEbk81SjQzQi9rWjhKaXprSlk3SCtnYkdYWVI2VHVSYlEy?=
 =?utf-8?B?UXFORmV1RDZqVDlEUGdZUU4xREx2a3JzK2gybzUvOGtNNFlqZ2RmcmF0OHc3?=
 =?utf-8?B?enpYVWpqOWcyUFo4ckhoS1UxWGx6VDVzYmNtbi9IdHVBbFZWcnR2T09vZ2Nk?=
 =?utf-8?B?ODJZY2lQSDdGN2ZjKy9IWUp4M0R1YmVkMHp2c2tZVmpQSktsWk5YbVZjb1Ja?=
 =?utf-8?B?eTUyMU5CcE1tWkZxdHhiM2xqYUtWd1p0WVNNUjMyWWU2cTE0b1hrQUh5R1Jj?=
 =?utf-8?B?V2tlWHdjWUt5SjNkbFY5aDhvUzFUVEtnTm1TRWxMOW1WUmZpUFZ1WXgvZHpm?=
 =?utf-8?B?M2Y4QTc0bmFIM3RMdkJJendVUDVKWVo0OHkzOGVXa0dSSG16cDJKVExrSDBJ?=
 =?utf-8?B?MDllVnlwOTZONkNROGxpaTR2dTQvQ2VpUHFxQzNPRlJJakRWbDl5a0x4SWtV?=
 =?utf-8?B?SFdqSEM0T0dMZHVJb0xJOURBL2Z0VEZRdS80S0xyMTVCTC9IWkR2K0ZhVjN4?=
 =?utf-8?B?am5Zb0x2UjkweXJxZHVsWElxMkxIM1pidUlUQU5ZUVNCWlRYOGwzVm9JM2hx?=
 =?utf-8?B?bFE3Nmd4MkhhcGZ3YzFlZ29JdkVXVEszT2pnUmY2bXh2ZzlOZWFyQWlKR2dv?=
 =?utf-8?B?U2VyZ2ZLN3ZMYVlSaktTYU9YVUpPMVBDZklJMk1xZTlkS0lPTEI2cW9GTTFI?=
 =?utf-8?B?a0cybGdzU0tFc1JIVC9OKy9zTHhsRUhHcmdYV0NjU3hwYzBOOGdwa0RFTjdv?=
 =?utf-8?B?ZWNqTWM2cWxZVERieGs2bFliKytGM0wxNWt4RkVkMFJKbzVBYWNscytJb0Vp?=
 =?utf-8?B?Zm1iOFdQUmxPTll1NkpGSjk1RXFTQUtsZG9oYmtudEJYSXpNTVF3QzdjRHcr?=
 =?utf-8?B?cEhlZGZHL0pBUG8vTDB1STdRTmdETUJJcERrSWt5LzNiS2N0clZwaElnZTRl?=
 =?utf-8?B?b2FDa1U1enFJZ3FMcnIyRWMvTUwzMkhsVW9wWFk2T1RiM0tTL3YwMS9wVmZs?=
 =?utf-8?B?aWZuN2h4Uk9Pa0xwT0FWa24vRFkvM25pdmxadnEvVUZVdHBsVk10QjFYOWNV?=
 =?utf-8?B?TVdEaFFXQlNnRGYrOTJQeVRueFhIZHErK2tKNC9rL2JYY1UwVllNYUN4SEFS?=
 =?utf-8?B?QzQ2RTNOeE1XeSs5S2hYenRxM3JEMkFJbzY4dHpBdmV0WVJnS0IzMytoWk8r?=
 =?utf-8?B?elNKK2NmZStUOTBWUVZHbTNLa0doOE8rYjJjNTR1b1JoOCsrM0RvMjlia1lR?=
 =?utf-8?B?bVFhUWxpRVZVajV2M1MvdlRYU3o5T1lUTVg5VVdraWNTZFo0Wm01K1NQKzhl?=
 =?utf-8?B?cWF2VE5pMEZtTEZ0OFNGZDMzQUhFMTRSQWQvMzVGMFhyTTZEU3dyWS8ra25s?=
 =?utf-8?B?eHBpMTVKN0tIenpyRVhsbUtwYW1aSTU4czYxUUhRRTdVWUpNWnJDVUQ1Qk9z?=
 =?utf-8?B?RzRUUGFaSFA4b1pkM2FLTGQ5SlhzYkdSbERTK05td0pTdWpkSDl1enZudkJM?=
 =?utf-8?B?LzN3MVJvYWZGMGRhYWlLc0w2TXRrOE5qd1JCOW5tR3hlK0x1UE9hYkpwSnJO?=
 =?utf-8?Q?NNO8GtkuCcH8+HZIJAcpYGqnr?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896b62a3-210b-456c-358b-08dbefea3626
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:15:41.6116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsIfaXtdUmTuYpubIbtDgOiZoijb+20sCN/jGm6YNEd0aN/+cp4B9gmV8RmsPbokcXuE3k3oJHWlOBDDFwGadQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9849
X-Proofpoint-GUID: kWcPBug5kfhoBm-gq3iL7pOPZsQ2ddu_
X-Proofpoint-ORIG-GUID: kWcPBug5kfhoBm-gq3iL7pOPZsQ2ddu_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_07,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------TFamy714YmSeGJzxvhAFLYor
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 28/11/23 12:46 pm, Markus Armbruster wrote:
> Your commit message is all in one line.  You need to format it like
>
>       migration: Plug memory leak
>
>      'channel' and 'addr' in qmp_migrate() are not auto-freed.
>      migrate_uri_parse() allocates memory which is returned to 'channel',
>      which is leaked because there is no code for freeing 'channel' or
>      'addr'.  So, free addr and channel to avoid memory leak.  'addr'
>      does shallow copying of channel->addr, hence free 'channel' itself
>      and deep free contents of 'addr'.
>
> Het Gala<het.gala@nutanix.com>  writes:
Yeah, I made the changes in v2 patchset.
>> ---
>>   migration/migration.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 28a34c9068..29efb51b62 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2004,6 +2004,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>>                             MIGRATION_STATUS_FAILED);
>>           block_cleanup_parameters();
>>       }
>> +    g_free(channel);
>> +    qapi_free_MigrationAddress(addr);
>>   
>>       if (local_err) {
>>           if (!resume_requested) {
> 2. hmp_migrate()
>
>     hmp_migrate() allocates @channel with migrate_uri_parse(), adds it to
>     list @caps, passes @caps to qmp_migrate(), then frees @caps with
>     qapi_free_MigrationChannelList().

Markus, sorry if I was not able to put point clearly, what I meant is 
that the local 'channel' variable used in qmp_migrate() i.e.

'MigrationChannel *channel = NULL', is defined in qmp_migrate() and if 
the user opts for 'uri' then '@channels' coming from hmp_migrate() will 
be NULL, and then migrate_uri_parse() will populate memory into 
'channel', and that is not getting freed after it's use is over.

I think, that is where memory leak might be happening ?


Regards,

Het Gala
--------------TFamy714YmSeGJzxvhAFLYor
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 28/11/23 12:46 pm, Markus Armbruster
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87a5qy4aag.fsf@pond.sub.org">
      <pre class="moz-quote-pre" wrap="">Your commit message is all in one line.  You need to format it like

     migration: Plug memory leak

    'channel' and 'addr' in qmp_migrate() are not auto-freed.
    migrate_uri_parse() allocates memory which is returned to 'channel',
    which is leaked because there is no code for freeing 'channel' or
    'addr'.  So, free addr and channel to avoid memory leak.  'addr'
    does shallow copying of channel-&gt;addr, hence free 'channel' itself
    and deep free contents of 'addr'.

Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:</pre>
    </blockquote>
    Yeah, I made the changes in v2 patchset.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87a5qy4aag.fsf@pond.sub.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 migration/migration.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 28a34c9068..29efb51b62 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2004,6 +2004,8 @@ void qmp_migrate(const char *uri, bool has_channels,
                           MIGRATION_STATUS_FAILED);
         block_cleanup_parameters();
     }
+    g_free(channel);
+    qapi_free_MigrationAddress(addr);
 
     if (local_err) {
         if (!resume_requested) {
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
2. hmp_migrate()

   hmp_migrate() allocates @channel with migrate_uri_parse(), adds it to
   list @caps, passes @caps to qmp_migrate(), then frees @caps with
   qapi_free_MigrationChannelList().</pre>
    </blockquote>
    <p>Markus, sorry if I was not able to put point clearly, what I
      meant is that the local 'channel' variable used in qmp_migrate()
      i.e.</p>
    <p>'MigrationChannel *channel = NULL', is defined in qmp_migrate()
      and if the user opts for 'uri' then '@channels' coming from
      hmp_migrate() will be NULL, and then migrate_uri_parse() will
      populate memory into 'channel', and that is not getting freed
      after it's use is over.&nbsp;</p>
    <p>I think, that is where memory leak might be happening ? <span style="white-space: pre-wrap">
</span></p>
    <br>
    <p>Regards,</p>
    Het Gala<br>
  </body>
</html>

--------------TFamy714YmSeGJzxvhAFLYor--

