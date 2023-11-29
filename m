Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7643A7FE13A
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 21:39:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8RJc-0007Ju-FG; Wed, 29 Nov 2023 15:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r8RJa-0007Jj-Cp
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 15:37:46 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r8RJX-0003iC-IA
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 15:37:46 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3ATJOU8n025194; Wed, 29 Nov 2023 12:37:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=6Z4kjyLd7aL0
 J51qHlKIQDk+sZ/4f9OsF1c4J6+NtQ8=; b=lNWd4tXsezEGhvAMUUXRyPUUlIf/
 KDJUc8zv+IR0wXcc2SA/7/zMJx6vOKkLmSQUdAmkppTCSOb3SUhTtkJk2NFi/aoK
 ZlH5Asy7Yu+lzdtmTjjC7FcAZVHUE3EEFNvXWqGohhb/i1yG7gGpkzrtv8DmGAWZ
 CxU7lXn4HfKWVF6ETHMlGBHc41lrelpPpTaGQ0JNpASFoslNBjr7b7TDUEPDCdEj
 SPiEC17tm4bk2AXhdB3H7Vm5z3uAX9sgn64jjLI1uNcppMbadSHDhL+/tLggwQAN
 8FNCRxjLU2k11JM4LBChzR2zs5AxKl2/tvmlh9dtYs0QgXlZSAnzGEsJwQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3unvbsspr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Nov 2023 12:37:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUb+AENHH0mRhwiVS60yKjyho7w4PVzEOjROVY0TtrpIlTzdHhcoaQRRKFocIT06oKsIDO+PPAwSL3HuJr2JLbKM2giKCkn2L1OJ2TWAvLHVFdNLmWpoQv+wfgz+dm52YCynxOBB+IQVd+ue4ds+wS0VaPV6eaRsPo8D06koKmysGceZYEnNypmXyZrtiA+71qIQyoM7e7+ttpio72WTzRrKVwyxt7+U2y6YeFNmF4KX4z/z5MAcOk1uB8l33uvyke/kD7xs6RcLO/Yf8d5R7xdGtRROfphOSwH54GD7lRKOb+pPMBW+A29ufnpSIkaySGolGO4doFQ/vE8dQNmFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z4kjyLd7aL0J51qHlKIQDk+sZ/4f9OsF1c4J6+NtQ8=;
 b=FeUGS/H1WWQebzgbzCbR8dApV3XGuxWxZENA+O3K5XprQ5kOYDb2dpw2PgpPORZ+zQP3omseepQe/TFts/02CuVpyp2c+hu6guWotPlK6mMb9wfdKWDGYXxmFX+LHDkbXSpFembTomteLkD7cPm/+8rWTifU/yN4xRkWAm73x99s16Abv+7Owwas8rkrC6XgFzukpWAvbN8rXW9FZm/ruXu/2cgPE7zUvAsMenY/BWKP82IvpFXdQBXfyCr+qPyfGunhnb3P1njyAcsy3iUXIMRkB7fLTuLKz1axKA7osIb2nedNWt9C50Bn6A3UftS6i9FxRxq2Vj0daf/6VgVjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z4kjyLd7aL0J51qHlKIQDk+sZ/4f9OsF1c4J6+NtQ8=;
 b=V3kAAtIFK95dg3tmuuNRtNOfv2JuGFvOJN/wEquyEfOR/pImsrOiZFZwc5T5ltcb+0qO1lyVbEHf4SZ84+BPEkWlel+Jweed0eJwg3raoEf7rfIsVYKuggNxysvrzOR+3llRxdHm+xsYd5mjyDNgBuuRPsWW6nZVxMXCeZV0Q2gaXsUFMnZy8VKqBIs7i1Uj7VyzQ+il08YGyIIEqGZwO9XScxZmPJpIrUd1lqIzJAjHGqwu6NgxSwcSV2FNid7NDT81OVzVmHWTa6OFrKx5S9LOZ4Wyl23mqOvbIPnoSL9suLGcgzONlQR2navnE0AdHWisuehafR9uAlofc+NnbA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ2PR02MB9316.namprd02.prod.outlook.com (2603:10b6:a03:4d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 20:37:34 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 20:37:33 +0000
Content-Type: multipart/alternative;
 boundary="------------8xgUPQMBHn7VvB5DB1l0yLK5"
Message-ID: <80e9331a-0691-4bd1-8589-a78c2814e627@nutanix.com>
Date: Thu, 30 Nov 2023 02:07:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] migration: free 'channel' after its use in migration.c
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, farosas@suse.de
References: <20231129080624.161578-1-het.gala@nutanix.com>
 <87fs0ok9i1.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87fs0ok9i1.fsf@pond.sub.org>
X-ClientProxiedBy: MA0PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::18) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ2PR02MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: a72837ed-9f47-4639-a31a-08dbf11b03b4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hkzJkgUh35jMrcmzg2Kqqoa+AZxV7ckeM6AiKNFbBNukZCSfnGow6ezRKSS4t8sGK2sKA39pZwaXMQp88RdEYiayH30MyY0JkuavFYsUPmuLciWud6FmEE/U30w+l9gIxHBvuofyUCdSeO8+phoW2AZZVvNcoLdIRltQwRT8SVFlTBliRYxB6lxRVE90Ddx1JWqcwlYT8k6RJjukMabt21uV76P7a7NZ47Hi2PUy0fuyuINeXk08uj0++TzQHP5XrA4V4yr1damGmEhA4/fBCagL8eBk7Jl5hyBYsuDUFyduutS/M90aS4/z/hK59Hi7Rjk/hkzW1jA1X+wAqr/ret2ExOcFu7P8w6mjlxQ/goxgtgPoKGnbwsTuvhi3EY7ljsqJpIjdoRnI22WEZYNbdBIOId7ZaCW9mb1GIHS1ua2w1lG3uFzRDuGfWFoKGMvttd0GhoZX7dhGIJApV/qMtlukvmgdc8bGQRV3iLhELtJ1JwIF8ejObq80fZYeNPBj5eh0VyGk8nneOMA48AdQF/TRslKZOBAx9tkTrFFDKQz04FoQxXT2iH77YjDHUpqTRi3kyOGW+GdB+6y7eqYyvhfvLN0GhVZZB0t3VU0eWjZbIsnUNgsgeKYAmp8cis/2Um97U0omyi4X8HZi/QlbX0d1pfJJvar/FW5L8rK25o6pnZTOeQdclR0eKWuk+Uy/rclrmyme8PzQHr/hjnALT9lFUOTREtOzXS2LebYzlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(30864003)(31686004)(5660300002)(2906002)(202311291699003)(44832011)(6512007)(6666004)(53546011)(41300700001)(478600001)(66476007)(8936002)(36756003)(86362001)(6916009)(4326008)(6486002)(38100700002)(6506007)(2616005)(8676002)(83380400001)(33964004)(31696002)(66946007)(316002)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aENYeFZlNFpFNnJxZ3RXU0czMytIY3VzNGtEbGxQL1c4Z0NLRGpyakVqYStl?=
 =?utf-8?B?aDJwaStHSW9RbU9oK1doc0MzcUw4MURoUEoxd3R0OFd3R2J5cmRML0k2WnVD?=
 =?utf-8?B?UlBnbjNwZ2Fjd2lzUHFGZTNvTGdKUE9zOE1XNUFoNEJlbEtNc2xuTjF1U0hF?=
 =?utf-8?B?ajFhQnBWSzExdnhIMkFPWVcza05FL25BMXZKcnZHd0tlQjY1MVlaaFM2Tkdh?=
 =?utf-8?B?N0tNYVROQWpmVzZVT3NSR2RJTEIyMkx0a0RaZGZiQ09abldNejFSMzNyS0lF?=
 =?utf-8?B?WllTcDducmRTT1ZRWkJRMTJaMDlkYnBFVDNveEVaY3cwRVF5ZmQ4NnUzcGFa?=
 =?utf-8?B?ZDErYy9QYndQVEVoWGY1Wng4c2d0Unl1MWs3cFBwaWNZbXlTQUJnVUNzT1Fz?=
 =?utf-8?B?VjZnTHZLQnppUmpaUERnRWlHVUF3ZG1tWUxNck9yN0djK1dOU2g4dE5ReUJT?=
 =?utf-8?B?K0lNSjJwR2VGQ1YwR0NaSk8rczJMRTFxL1BkUUZoY1BTblRwMktmdFY5c0JZ?=
 =?utf-8?B?cHcyNHA3Ty9mN0RlY2g2a1ZnRk9JNlJ0M1daUXZWazAybHBkSjhvRkMwYjFv?=
 =?utf-8?B?V2dZQUR0eldoVUJyNnRJcFhqS3Npem44OU9HUUlTVVlwejN2b3FqYXU5Q3hr?=
 =?utf-8?B?NjdSWjZqRjQ1cXNkNkdocU9wZDJxWmhJc3N5UnJxSFlCQnc4ekxONGJNaVlK?=
 =?utf-8?B?aE0yb1N4RW1mZnA4dC9PeVFHWjk1d2VaM0JNbWJIRW16eDRjK0srcllJWGxY?=
 =?utf-8?B?Yy8yWWVCMHl0VkwzMWVodVZyYWpZdk03WThJOG1YeVlOQ01FcW50SSs0Tk40?=
 =?utf-8?B?QWJTc0s4S0RMUWI3Z0hrZk5LN0xwZ3JtSmlkZnViSXdTY051ZTNtb1MySjY3?=
 =?utf-8?B?RVBKMDFZRk0vTlNLejBwZldJYU9pV0J2RTRjUFdKM2k5eGtmbjB2TW1uUTlv?=
 =?utf-8?B?cVZCejgwcDdCbDZoRVoyVDJJZFhqN05oNHdkR2tjZklNOGpzL0NVbkhLN3M0?=
 =?utf-8?B?dmhCY3M5OVdlWEEzdjNLaFZkS3NFeHpURWlZR0RxR3V1b0ljamdLb2dwMEd3?=
 =?utf-8?B?LzVxbHc2Zk1Sd25neWdvV0VDTStGbE1HeDRnSDVqb2g3NDZOQzFKQ2dQSVQw?=
 =?utf-8?B?RW1RVWZMdGwzTnN6SmZNWUFIU1pESUNOWGZ6WnlUQ0xhdHhqcEd4OFVTQy9z?=
 =?utf-8?B?aDJSSjNvWVlSc1ZDdXd5VXVDekM0cE8zWGJLckV3QnpFT2pvQjhhQkRvSDZl?=
 =?utf-8?B?QW1kNmhVT3VKa05WdkhZQSt2WlFqaEZNN2ZmWGVpSFhVSFFXeW5GS3ZmUUg4?=
 =?utf-8?B?TlQwTUMxR255aFVGM2RzUzU1aXdWOG9CaUtiVXRzQUVVK3pCYllnM2pCbDRl?=
 =?utf-8?B?S25DeUhKUTdMT2l1V1luZUJsSGo0UkZJV0JsWksxVzV3UXFkTENjd29ENEpl?=
 =?utf-8?B?Z3ZLbzZyWDZtbkFMc213UTdzakxmOEc1QkkwVjVFblFORHJkYzJEQjNxNVFE?=
 =?utf-8?B?UTVRbjcva3dwK25VZGJlWlVYd0xyRkFUR0I0a1Fhd1JnM3JHSWNnYWszdW05?=
 =?utf-8?B?ZmVhamZxQjBHaTIwRmNaa3dkOGhhYmhqbUo3UjlvU3hCVTNjbGtEY2htY1pC?=
 =?utf-8?B?cWxoNGpPcjBlQVdYaGVaNXRxRk9LdFQ1UHZKU0VwVUtYa2V2SnhjMTVzVGRv?=
 =?utf-8?B?RGZSZmI3RGMyN3J6UVlZdmRnY0cxZVZkL1pseFpNU0hBSHZZb2ZtaEwvd1Fy?=
 =?utf-8?B?UUUrUlp6VGRXZUtkQlB0dkRyZ01ubDg0aG9QaHJJOXFVQVYxcjE3UjhmL2pm?=
 =?utf-8?B?TEUzYTBiTVhSdCtDaEg4SVFwbWhHNEozeEdlTVB2bXh0bjB1QkFad2hoTHAw?=
 =?utf-8?B?aHZvTW9TN043NC9qRUxIcGlaanpVUC9FcEdVa0dKc0lKbVVCWFdkZU91TWlE?=
 =?utf-8?B?anNBanI3TTYrWWNHelkrQytDcHV6R2NtajgraDZwbldqVG55VFBSeU41MnJK?=
 =?utf-8?B?SjFxbWtoOWtzZUdqTHg5UmdBK2RYNldETjYzTmRuMVJrTGFUMExHd0VvenFa?=
 =?utf-8?B?ZytveEZHYktnWUhtbmgzNGtaL05tdW9qNFdFb3RsMHRpbFhBYkx4bGVXSVBQ?=
 =?utf-8?B?eWZBS01pcHVkSTBKSklQcm55WjBHWXc1dTlReWMvZXBvV2xLVjJRN3pGY3BX?=
 =?utf-8?Q?bYftf1q5Nfr5gemgcMukvVOyqGuDlIf96ZsmzOCL70SM?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72837ed-9f47-4639-a31a-08dbf11b03b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 20:37:33.2927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCibFKNwfo/ET41nsLtWzk93i1frXf86I45drFiHs8FETfBVmVpNYFraOPFT4/gE3XRAb4tS/RFY8pNfjwFjDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9316
X-Proofpoint-ORIG-GUID: bnfiTIekgHnHfdC1nzOpf9EC9IPbDtpj
X-Proofpoint-GUID: bnfiTIekgHnHfdC1nzOpf9EC9IPbDtpj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------8xgUPQMBHn7VvB5DB1l0yLK5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 29/11/23 6:21 pm, Markus Armbruster wrote:
> I'ld like to suggest a clearer subject:
>
>    migration: Plug memory leak with migration URIs
Ack. Will update the commit message
> Het Gala<het.gala@nutanix.com>  writes:
>
>> 'channel' in qmp_migrate() and qmp_migrate_incoming() is not
>> auto-freed. migrate_uri_parse() allocates memory to 'channel' if
> Not sure we need the first sentence.  QMP commands never free their
> arguments.
Ack.
>> the user opts for old syntax - uri, which is leaked because there
>> is no code for freeing 'channel'.
>> So, free channel to avoid memory leak in case where 'channels'
>> is empty and uri parsing is required.
>> Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp
>> migration flow")
>>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Suggested-by: Markus Armbruster<armbru@redhat.com>
> Keep the Fixes: tag on a single line, and next to the other tags:
>
>    [...]
>    is empty and uri parsing is required.
>
>    Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp migration flow")
>    Signed-off-by: Het Gala<het.gala@nutanix.com>
>    Suggested-by: Markus Armbruster<armbru@redhat.com>

Ack.

[...]

>> +        addr = channels->value->addr;
>>       } else if (uri) {
>>           /* caller uses the old URI syntax */
>>           if (!migrate_uri_parse(uri, &channel, errp)) {
>>               return;
>>           }
>> +        addr = channel->addr;
>>       } else {
>>           error_setg(errp, "neither 'uri' or 'channels' argument are "
>>                      "specified in 'migrate' qmp command ");
>>           return;
>>       }
>> -    addr = channel->addr;
>>   
>>       /* transport mechanism not suitable for migration? */
>>       if (!migration_channels_and_transport_compatible(addr, errp)) {
> I tested this with an --enable-santizers build.  Before the patch:
>
>      $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -incoming unix:123
>      ==3260873==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>      QEMU 8.1.92 monitor - type 'help' for more information
>      (qemu) q
>
>      =================================================================
>      ==3260873==ERROR: LeakSanitizer: detected memory leaks
>
>      Direct leak of 40 byte(s) in 1 object(s) allocated from:
>          #0 0x7f0ba08ba097 in calloc (/lib64/libasan.so.8+0xba097)
>          #1 0x7f0b9f4eb5b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
>          #2 0x55b446454dbe in migrate_uri_parse ../migration/migration.c:490
>          #3 0x55b4464557c9 in qemu_start_incoming_migration ../migration/migration.c:539
>          #4 0x55b446461687 in qmp_migrate_incoming ../migration/migration.c:1734
>          #5 0x55b4463df1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
>          #6 0x55b4463e4d8e in qemu_init ../system/vl.c:3753
>          #7 0x55b446f63ca9 in main ../system/main.c:47
>          #8 0x7f0b9d04a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)
>
>      Direct leak of 16 byte(s) in 1 object(s) allocated from:
>          #0 0x7f0ba08ba097 in calloc (/lib64/libasan.so.8+0xba097)
>          #1 0x7f0b9f4eb5b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
>          #2 0x55b4464557c9 in qemu_start_incoming_migration ../migration/migration.c:539
>          #3 0x55b446461687 in qmp_migrate_incoming ../migration/migration.c:1734
>          #4 0x55b4463df1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
>          #5 0x55b4463e4d8e in qemu_init ../system/vl.c:3753
>          #6 0x55b446f63ca9 in main ../system/main.c:47
>          #7 0x7f0b9d04a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)
>
>      Direct leak of 8 byte(s) in 1 object(s) allocated from:
>          #0 0x7f0ba08bb1a8 in operator new(unsigned long) (/lib64/libasan.so.8+0xbb1a8)
>          #1 0x7f0b9a9255b7 in _sub_I_65535_0.0 (/lib64/libtcmalloc_minimal.so.4+0xe5b7)
>
>      Indirect leak of 48 byte(s) in 1 object(s) allocated from:
>          #0 0x7f0ba08ba097 in calloc (/lib64/libasan.so.8+0xba097)
>          #1 0x7f0b9f4eb5b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
>          #2 0x55b4464557c9 in qemu_start_incoming_migration ../migration/migration.c:539
>          #3 0x55b446461687 in qmp_migrate_incoming ../migration/migration.c:1734
>          #4 0x55b4463df1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
>          #5 0x55b4463e4d8e in qemu_init ../system/vl.c:3753
>          #6 0x55b446f63ca9 in main ../system/main.c:47
>          #7 0x7f0b9d04a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)
>
>      Indirect leak of 4 byte(s) in 1 object(s) allocated from:
>          #0 0x7f0ba08ba6af in __interceptor_malloc (/lib64/libasan.so.8+0xba6af)
>          #1 0x7f0b9f4eb128 in g_malloc (/lib64/libglib-2.0.so.0+0x5f128)
>
>      SUMMARY: AddressSanitizer: 116 byte(s) leaked in 5 allocation(s).

curious: how to get this stack trace ? I tried to configure and build 
qemu with --enable-santizers option, but on running the tests 'make -j 
test', I see:

==226453==LeakSanitizer has encountered a fatal error. ==226453==HINT: 
For debugging, try setting environment variable 
LSAN_OPTIONS=verbosity=1:log_threads=1 ==226453==HINT: LeakSanitizer 
does not work under ptrace (strace, gdb, etc)

> Afterwards:
>
>      ==3260526==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>      QEMU 8.1.92 monitor - type 'help' for more information
>      (qemu) q
>
>      =================================================================
>      ==3260526==ERROR: LeakSanitizer: detected memory leaks
>
>      Direct leak of 40 byte(s) in 1 object(s) allocated from:
>          #0 0x7f97e54ba097 in calloc (/lib64/libasan.so.8+0xba097)
>          #1 0x7f97e41c75b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
>          #2 0x55ae31b02dbe in migrate_uri_parse ../migration/migration.c:490
>          #3 0x55ae31b0382c in qemu_start_incoming_migration ../migration/migration.c:539
>          #4 0x55ae31b0f724 in qmp_migrate_incoming ../migration/migration.c:1734
>          #5 0x55ae31a8d1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
>          #6 0x55ae31a92d8e in qemu_init ../system/vl.c:3753
>          #7 0x55ae32611de2 in main ../system/main.c:47
>          #8 0x7f97e1c4a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)
>
>      Direct leak of 8 byte(s) in 1 object(s) allocated from:
>          #0 0x7f97e54bb1a8 in operator new(unsigned long) (/lib64/libasan.so.8+0xbb1a8)
>          #1 0x7f97df6055b7 in _sub_I_65535_0.0 (/lib64/libtcmalloc_minimal.so.4+0xe5b7)
>
>      SUMMARY: AddressSanitizer: 48 byte(s) leaked in 2 allocation(s).
>
> This confirms the patch succeeds at plugging leaks the -incoming path.
> It also shows there's one left in migrate_uri_parse():
>
>      bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
[...]
> Aside: indentation is off.
>
>              addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
>              saddr = socket_parse(uri, errp);
>
> @saddr allocated.
>
>              if (!saddr) {
>                  return false;
>              }
>              addr->u.socket.type = saddr->type;
>              addr->u.socket.u = saddr->u;
>
> Members of @saddr copied into @addr.
>
>          } else if (strstart(uri, "file:", NULL)) {
>              addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
>              addr->u.file.filename = g_strdup(uri + strlen("file:"));
>              if (file_parse_offset(addr->u.file.filename, &addr->u.file.offset,
>                                    errp)) {
>                  return false;
>              }
>          } else {
>              error_setg(errp, "unknown migration protocol: %s", uri);
>              return false;
>          }
>
>          val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
>          val->addr = g_steal_pointer(&addr);
>          *channel = g_steal_pointer(&val);
>
> @saddr leaked.
>
>          return true;
>      }
>
> Obvious fix: g_free(saddr) right after copying its members.
>
> Another fix: make @saddr g_autofree, and keep the initializer.
>
> Separate patch.  Would you like to take care of it?
>
> This one, preferably with the commit message improved:
> Tested-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Markus Armbruster<armbru@redhat.com>

Fabiano has already answered to your query.

Regards,
Het Gala
--------------8xgUPQMBHn7VvB5DB1l0yLK5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 29/11/23 6:21 pm, Markus Armbruster
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87fs0ok9i1.fsf@pond.sub.org">
      <pre class="moz-quote-pre" wrap="">I'ld like to suggest a clearer subject:

  migration: Plug memory leak with migration URIs</pre>
    </blockquote>
    Ack. Will update the commit message<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87fs0ok9i1.fsf@pond.sub.org">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">'channel' in qmp_migrate() and qmp_migrate_incoming() is not
auto-freed. migrate_uri_parse() allocates memory to 'channel' if
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Not sure we need the first sentence.  QMP commands never free their
arguments.</pre>
    </blockquote>
    Ack.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87fs0ok9i1.fsf@pond.sub.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">the user opts for old syntax - uri, which is leaked because there
is no code for freeing 'channel'.
So, free channel to avoid memory leak in case where 'channels'
is empty and uri parsing is required.
Fixes: 5994024f (&quot;migration: Implement MigrateChannelList to qmp
migration flow&quot;)

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Markus Armbruster <a class="moz-txt-link-rfc2396E" href="mailto:armbru@redhat.com">&lt;armbru@redhat.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Keep the Fixes: tag on a single line, and next to the other tags:

  [...]
  is empty and uri parsing is required.

  Fixes: 5994024f (&quot;migration: Implement MigrateChannelList to qmp migration flow&quot;)
  Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
  Suggested-by: Markus Armbruster <a class="moz-txt-link-rfc2396E" href="mailto:armbru@redhat.com">&lt;armbru@redhat.com&gt;</a></pre>
    </blockquote>
    <p>Ack.<span style="white-space: pre-wrap">
</span></p>
    <p><span style="white-space: pre-wrap">[...]
</span><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:87fs0ok9i1.fsf@pond.sub.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+        addr = channels-&gt;value-&gt;addr;
     } else if (uri) {
         /* caller uses the old URI syntax */
         if (!migrate_uri_parse(uri, &amp;channel, errp)) {
             return;
         }
+        addr = channel-&gt;addr;
     } else {
         error_setg(errp, &quot;neither 'uri' or 'channels' argument are &quot;
                    &quot;specified in 'migrate' qmp command &quot;);
         return;
     }
-    addr = channel-&gt;addr;
 
     /* transport mechanism not suitable for migration? */
     if (!migration_channels_and_transport_compatible(addr, errp)) {
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I tested this with an --enable-santizers build.  Before the patch:

    $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -incoming unix:123
    ==3260873==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
    QEMU 8.1.92 monitor - type 'help' for more information
    (qemu) q

    =================================================================
    ==3260873==ERROR: LeakSanitizer: detected memory leaks

    Direct leak of 40 byte(s) in 1 object(s) allocated from:
        #0 0x7f0ba08ba097 in calloc (/lib64/libasan.so.8+0xba097)
        #1 0x7f0b9f4eb5b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
        #2 0x55b446454dbe in migrate_uri_parse ../migration/migration.c:490
        #3 0x55b4464557c9 in qemu_start_incoming_migration ../migration/migration.c:539
        #4 0x55b446461687 in qmp_migrate_incoming ../migration/migration.c:1734
        #5 0x55b4463df1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
        #6 0x55b4463e4d8e in qemu_init ../system/vl.c:3753
        #7 0x55b446f63ca9 in main ../system/main.c:47
        #8 0x7f0b9d04a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)

    Direct leak of 16 byte(s) in 1 object(s) allocated from:
        #0 0x7f0ba08ba097 in calloc (/lib64/libasan.so.8+0xba097)
        #1 0x7f0b9f4eb5b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
        #2 0x55b4464557c9 in qemu_start_incoming_migration ../migration/migration.c:539
        #3 0x55b446461687 in qmp_migrate_incoming ../migration/migration.c:1734
        #4 0x55b4463df1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
        #5 0x55b4463e4d8e in qemu_init ../system/vl.c:3753
        #6 0x55b446f63ca9 in main ../system/main.c:47
        #7 0x7f0b9d04a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)

    Direct leak of 8 byte(s) in 1 object(s) allocated from:
        #0 0x7f0ba08bb1a8 in operator new(unsigned long) (/lib64/libasan.so.8+0xbb1a8)
        #1 0x7f0b9a9255b7 in _sub_I_65535_0.0 (/lib64/libtcmalloc_minimal.so.4+0xe5b7)

    Indirect leak of 48 byte(s) in 1 object(s) allocated from:
        #0 0x7f0ba08ba097 in calloc (/lib64/libasan.so.8+0xba097)
        #1 0x7f0b9f4eb5b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
        #2 0x55b4464557c9 in qemu_start_incoming_migration ../migration/migration.c:539
        #3 0x55b446461687 in qmp_migrate_incoming ../migration/migration.c:1734
        #4 0x55b4463df1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
        #5 0x55b4463e4d8e in qemu_init ../system/vl.c:3753
        #6 0x55b446f63ca9 in main ../system/main.c:47
        #7 0x7f0b9d04a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)

    Indirect leak of 4 byte(s) in 1 object(s) allocated from:
        #0 0x7f0ba08ba6af in __interceptor_malloc (/lib64/libasan.so.8+0xba6af)
        #1 0x7f0b9f4eb128 in g_malloc (/lib64/libglib-2.0.so.0+0x5f128)

    SUMMARY: AddressSanitizer: 116 byte(s) leaked in 5 allocation(s).</pre>
    </blockquote>
    <p>curious: how to get this stack trace ? <span style="white-space: pre-wrap">I tried to configure and build qemu with </span><span style="white-space: pre-wrap">--enable-santizers</span>
      <span style="white-space: pre-wrap">option, but on running the tests 'make -j test', I see:</span></p>
    <p><span style="white-space: pre-wrap">==226453==LeakSanitizer has encountered a fatal error.
==226453==HINT: For debugging, try setting environment variable LSAN_OPTIONS=verbosity=1:log_threads=1
==226453==HINT: LeakSanitizer does not work under ptrace (strace, gdb, etc)
</span></p>
    <blockquote type="cite" cite="mid:87fs0ok9i1.fsf@pond.sub.org">
      <pre class="moz-quote-pre" wrap="">
Afterwards:

    ==3260526==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
    QEMU 8.1.92 monitor - type 'help' for more information
    (qemu) q

    =================================================================
    ==3260526==ERROR: LeakSanitizer: detected memory leaks

    Direct leak of 40 byte(s) in 1 object(s) allocated from:
        #0 0x7f97e54ba097 in calloc (/lib64/libasan.so.8+0xba097)
        #1 0x7f97e41c75b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
        #2 0x55ae31b02dbe in migrate_uri_parse ../migration/migration.c:490
        #3 0x55ae31b0382c in qemu_start_incoming_migration ../migration/migration.c:539
        #4 0x55ae31b0f724 in qmp_migrate_incoming ../migration/migration.c:1734
        #5 0x55ae31a8d1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
        #6 0x55ae31a92d8e in qemu_init ../system/vl.c:3753
        #7 0x55ae32611de2 in main ../system/main.c:47
        #8 0x7f97e1c4a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)

    Direct leak of 8 byte(s) in 1 object(s) allocated from:
        #0 0x7f97e54bb1a8 in operator new(unsigned long) (/lib64/libasan.so.8+0xbb1a8)
        #1 0x7f97df6055b7 in _sub_I_65535_0.0 (/lib64/libtcmalloc_minimal.so.4+0xe5b7)

    SUMMARY: AddressSanitizer: 48 byte(s) leaked in 2 allocation(s).

This confirms the patch succeeds at plugging leaks the -incoming path.
It also shows there's one left in migrate_uri_parse():

    bool migrate_uri_parse(const char *uri, MigrationChannel **channel,</pre>
    </blockquote>
    [...]<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87fs0ok9i1.fsf@pond.sub.org">
      <pre class="moz-quote-pre" wrap="">
Aside: indentation is off.

            addr-&gt;transport = MIGRATION_ADDRESS_TYPE_SOCKET;
            saddr = socket_parse(uri, errp);

@saddr allocated.

            if (!saddr) {
                return false;
            }
            addr-&gt;u.socket.type = saddr-&gt;type;
            addr-&gt;u.socket.u = saddr-&gt;u;

Members of @saddr copied into @addr.

        } else if (strstart(uri, &quot;file:&quot;, NULL)) {
            addr-&gt;transport = MIGRATION_ADDRESS_TYPE_FILE;
            addr-&gt;u.file.filename = g_strdup(uri + strlen(&quot;file:&quot;));
            if (file_parse_offset(addr-&gt;u.file.filename, &amp;addr-&gt;u.file.offset,
                                  errp)) {
                return false;
            }
        } else {
            error_setg(errp, &quot;unknown migration protocol: %s&quot;, uri);
            return false;
        }

        val-&gt;channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
        val-&gt;addr = g_steal_pointer(&amp;addr);
        *channel = g_steal_pointer(&amp;val);

@saddr leaked.

        return true;
    }

Obvious fix: g_free(saddr) right after copying its members.

Another fix: make @saddr g_autofree, and keep the initializer.

Separate patch.  Would you like to take care of it?

This one, preferably with the commit message improved:
Tested-by: Markus Armbruster <a class="moz-txt-link-rfc2396E" href="mailto:armbru@redhat.com">&lt;armbru@redhat.com&gt;</a>
Reviewed-by: Markus Armbruster <a class="moz-txt-link-rfc2396E" href="mailto:armbru@redhat.com">&lt;armbru@redhat.com&gt;</a></pre>
    </blockquote>
    <p>Fabiano has already answered to your query. <br>
    </p>
    <span style="white-space: pre-wrap">Regards,</span><br>
    <span style="white-space: pre-wrap">Het Gala
</span>
  </body>
</html>

--------------8xgUPQMBHn7VvB5DB1l0yLK5--

