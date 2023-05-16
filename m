Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7038A704A42
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:15:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyriJ-0001DZ-Kv; Tue, 16 May 2023 06:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyriG-000159-6l
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:15:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyri0-00068n-6R
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:15:23 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G4SQpM001928; Tue, 16 May 2023 03:15:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=UWxHZ626r5Yd3V33d8i7KB9pPhZwPBrOXZVp1oYDQhA=;
 b=sdjyLJvEf+1WepBR6o/q/sUNZ6iKHgagd3oTFoRRyicK7MCS+QW+MGaNCOK9CZvpNI9s
 JfhUZJv27Mhd7RqysAij0xy0PFRbAQWfhrum47OPhicIyb54X9Cg5ML4Pd6b3grAmSVO
 IbBVQJdE9t+dWlF+Urk+a0NkYAxY1KXy7VFAGLUUcYm9788SgC+9aJAKkfORG5ArKqae
 PYDw16YGTyAfAkXeBfN7JCY7bdNcYK4nnlWAsJM2G8TRH6wzXN5SOLSzHJ9d1jnvMsJ2
 8/IAcl18yNk3J47IewI4Cl3Wt5bPgDh0jCm+MVwgRbyipLgZKzrCYfMa8wwkbmk2oBcI DQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qj9veduhw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 03:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnIYoJvQQ86LFN7XeBVTAfacRsdfODPWXUGCW719on729GGC9iv+y5rLqKBWLeGLiU2nPs/XfcgUB3raXszpGD5EwUqqCqdJ0qcbbMNyskJ+sFxIShhojE+3FQRqKjKbRTa5nF/YInjcox1ZRjsFawN9llI5BmSFZjJRSDywMetWcfpl8l2/C9Cgd9/UcEickvQzriJSqKhxuYzpHGBseNJ3F0lQQ4kkKm0ziQH3XN0pocF0+vaGSHQS4ysAdHq2q+IiIO4Ycc4K0zMOdeUxuLkFuHXWP6smdMmQRdBshYLAy+i61z+Bkit3e5NCalGTnRSEGxVKeS1EDsicNq8fgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWxHZ626r5Yd3V33d8i7KB9pPhZwPBrOXZVp1oYDQhA=;
 b=NDIRBhMpF8SAfAUpsNhN/D1D2kpwRYxivCliJ7c0I+r9JtA12/xKkZqNTYvcdUOJ6/W2ZPo9dCgvwyfVzIpU2olAuGWwQxPc4ADi376rBJLpE9AUyZHxfvo4iNqiL0tf7YtzsF9Xjv/g4EUuAAt7OZyT249KDLheNP8oVco/mMvjffutV4ivWY/Kh1dOIus4PTnbCqp8BzNF18UYuq4N5gzySVkkibWAe9FTZ6NfIZaB1YRZk5Fgp1bqpIGNxFmZLgEr+MpcyBS/NAsQBCLVQMUSBuaIjuI4UXxi7z4bq3TfOHGO0fWdvpBrl19jLHheNmlvg0ujfkndUJ45yZaqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWxHZ626r5Yd3V33d8i7KB9pPhZwPBrOXZVp1oYDQhA=;
 b=VdQmsC9KdE+aE6npfhzftPf9eD6JpfFodNgahplmijF7gWpxC9PbZ57X5/L7IlSd6Nven7GFo7bHjnansOwX0R4h4c44FKemBAn+D6Czzu1CruPbZ1pe0x6L5mhTGeHNbwrB1PLdFv/ShGYOG1Bc0TY1uJsORYAbQ2n0gjHEoUc/tf9kRxLVg5yVfxm7zExle5GJOOs/1O/ckiWWAzf9V/8na4D1D/B0/alFjqhD26u9fX+2hrVRIvFcLPCJpoDo32VQXUdq5WbqeFJ3eWGV9ICPTEIJ0LEd2OIhSYP9LK8jTDOWSgmnet7CwsBq4RsFYA7jUko4Q1rEIBPpm3YHaw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SJ0PR02MB7599.namprd02.prod.outlook.com (2603:10b6:a03:32e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 10:15:04 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%6]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 10:15:03 +0000
Message-ID: <55742af2-1249-0e61-0772-d5e6dcd66df3@nutanix.com>
Date: Tue, 16 May 2023 15:44:52 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 6/8] migration: modified 'migrate' QAPI to accept
 'channels' argument for migration
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-7-het.gala@nutanix.com> <ZGILNQxb6VD0CwSR@redhat.com>
 <04881f8e-f903-9886-a39f-141605d634a5@nutanix.com>
 <ZGNFlsLsIE/68+NS@redhat.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZGNFlsLsIE/68+NS@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::7) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|SJ0PR02MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: acf81c48-97ba-44ed-b10f-08db55f669d7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +PXY5Sp4qcucAZMEuS9P9BhO3RCKlAjkrx3/EogOc9y0JDFxHE/SkNCiHHvscobliNYGUl8w7U22yFjMfi4IHPP+Q7W9cHgQ6OFC64sKFlKIs/nZ+Fw1d5OCujkPMXGwLmUrz/7WEmkGL6NSsvtTW+0kAkQAtbmVzJR18KRS4xKY8Y4wl4Xxga0th7RSZTYwU7MM38ML7JLxd3ea/xoz3yk3B7vUsO4LarBO3QehWxlPxYBfS3WzGInrkGvb0wEwwep/28Cp+IOGujfeg4XLzmFFNbL/CvYy+hDuV0o2qIz3Fl7mKMHk8g0MjxhCfzznb5yPgxmAgWRXcE089RgPG53bjGnSjbWC+6ZD680jPfFi6l4B78gdTK9HpoBRHmlRfupfDsHRav8acyZOQ8gBOk4po5/oG3043d+0Fo0kB3lbv8OPNx3kKuYl9g5OmdTf/FNwQxspkJHlyZRzf8LT9HM5dEzvJiyiG9HtCCwjgHz5/gTr0493I1v9spq8JrtM05NJirMuNQLGFZeezBA46HXZx5KxAO0HaCJoN+QKfAuqO0sFg4u6gMBtUfXKYlnNxvSnwILXfDOomhQ2LV+okWgp2axj5Kvy06Ja0w0t7RXTH35drbZ4YsS8lV79GCxxgWMCLky7qh1GjtMCL8SFig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(6666004)(4326008)(6916009)(66476007)(316002)(36756003)(38100700002)(478600001)(66899021)(66946007)(66556008)(31696002)(6486002)(6506007)(2616005)(41300700001)(5660300002)(31686004)(44832011)(6512007)(8676002)(186003)(8936002)(26005)(53546011)(107886003)(2906002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzM3NmhHMng5MmRLaW5WRm5GZGcrb0d2SkdGMlpMWHNaQm00b3lsU0FQVmNa?=
 =?utf-8?B?dnNWUDlZeEFTK2p4TjgzZEExZHBIRXpQV0UxcVFzdWFJd2xTKzJYOFJ3WWZL?=
 =?utf-8?B?a0dYQytIdWRXZGF3NlY3dk5WMGlXZUFsSFZYVFlpdkxocGdaTjh4dkE3Y05K?=
 =?utf-8?B?VDYvZXBNenJKSUowZFJlMmZsendnNzlyWStFSjByL0FOV3dYRWpma2FPdDhR?=
 =?utf-8?B?d1FwdzQvYlZPWVdTV1VYVDNiTXhWMkh2TW1yQ3I0Z01CZnl6Z1M5OW81VjR0?=
 =?utf-8?B?anRuTlN6MllabzRoVlJsNjVpWThoUUNHVGYzbzJsRVk2REF0RlpiV1hEMEpm?=
 =?utf-8?B?TmpXNDg0cXhUakduNTU3QjlzSWdXbVFiWjNaZzVPd3JuTlNoOHNOZEIrUG84?=
 =?utf-8?B?alg4VUtkMG50VEhCL0NEMVRZUWtKVXBGL2xyUjJBUnQ3RmlHWDJKVmd5eE5l?=
 =?utf-8?B?a0JhT0hCand4YzB5UTlmVysyY1hpNmlUT013MG8xSHp1T2g3WGdNRWFvWWVE?=
 =?utf-8?B?aVRnZjdkZGxlUUtMdjg1OXplZWJld3RBRml1c2dFVWg0bnc4WEt5K041SWNl?=
 =?utf-8?B?NDFscCtGRGRob0JzcEhVK3BVTjRaYzJ5emZmKzVtRU91bktza01zMG9FY2R2?=
 =?utf-8?B?cW5QZDB3UGNLUFlJNjFoWUtjcTg1Zmx2a0pQYUtMcElCUFhXeWNYQUx0Wk1X?=
 =?utf-8?B?eUV5M3Q2a0VOUDR6cjFuTHVzUnYyeTdUZWliN1pYUWNhZGhsNFN3amxNRFFD?=
 =?utf-8?B?d0ZUNzZSVGFQOExqditVdy9XZnBXeGVKUXRUKzRWUmFEOG83andkSW9QcWt5?=
 =?utf-8?B?TjZzWHMxSkxWWndyQXR5RGJtQitsUnNycjBwa3BianJpYUhHSWUxMTdpUFRm?=
 =?utf-8?B?aTRCOFRpYk04SWpJTWVnM3hPZmcvbi9jSklpYVJROStzeVFJVzNyMFpTdUNF?=
 =?utf-8?B?dFJvNEhyczlJMVdEcVIxOG5mMDJGLy80STBxY2VGRUMwWHloSk5TZFRPSVlh?=
 =?utf-8?B?cm5KeTlhTTVGSFZ3aUdsWkRBekQrWjNmdFpVczh6Zm5RdVMrVzJITjYrLzdX?=
 =?utf-8?B?bnU2WSs5WGVvaTJ3cEltbmFmMlRWdTVqMHhPSm81TU90a0JOSTgwbUYvUUd0?=
 =?utf-8?B?Rmo2dWlMUmpWVnRlNkNWYzZBb1FCL082d0NFaXRaa20xTGxVZStPdEprRlU1?=
 =?utf-8?B?NUJJUGwzc3hTeUVHRURVZzFISVdaRUMwejg4Qi9qMmVRaW5YcDlIT0ZWZXZD?=
 =?utf-8?B?U21MRmlYbURTRXU3V3NWMmZyRGpwaTh2bm5yVTQ5RjU0M3lQTFJkaXVwczZh?=
 =?utf-8?B?Nzg5MklvRFErNG16Nzh4ekEvTGlHajdKK0R0SFZGUWR4V08rcGkzL1lzQmdM?=
 =?utf-8?B?WGdUbXZCYUxPTi84Zms2TC9UTTZHSXVpZkE0UVFhbVJIdlA3RXhZcE1yKzdW?=
 =?utf-8?B?VUU4N0tKTzVuaTM1Qk9JcUtZZVExQ0FBaGxDb2ZUWTkwVXZyc3dXNkF4ek9t?=
 =?utf-8?B?T2tVZWR2RFRpbUNBN2JaWlVqV05NYjF0d0FTbnNTRk9COHBnaHVsM1l2MVpX?=
 =?utf-8?B?SkQ4R2Rxb1VzSjArZm0wSkNJZklMb2pnMVphMWNUWENTZytXeWdpdndsRUtK?=
 =?utf-8?B?N3E2a2Y2dloya1luUzRENk44WHd4azVMZGRCekdtR242TG1ENGs1eHRwaU1X?=
 =?utf-8?B?NFlUQ3B6NitlT0FKNGNUU2kvbENPYWVudm44VVhra05NVmlxbUhmQnkvdkRH?=
 =?utf-8?B?b1pyamRTUWNjRTE5eGhTMUJFRENPRE94NVc2NnFBeFlCQ21Kd2JHUXdIUzlt?=
 =?utf-8?B?L29RdS9JVjI2T1d5WnFTVmxJMTRzZ2NXcVdCNkVWWnNTSmZrcmJ0OVpxZlJl?=
 =?utf-8?B?NXRqbTR3cnhqUkpTMHdUcThkZU5DaGI1dmVQUVJ4bjYvYWIzRzVSaUFJamFU?=
 =?utf-8?B?LzFDd2dZdDdXTVo2U1IwT0p6ZUtER3JCUWVZVkJhSnNWVmlhRjY5Uk9tbTRQ?=
 =?utf-8?B?TWM1b3hhVEF0U3QyaU1oU20xZkp4VG9xbm4yNHl3T1dwYnFzYVMrejZkMTBl?=
 =?utf-8?B?T2JmbTdvd2lSMUU1WDI4QlN2aTl0anVVZU1DWWl5RUQ1b20rajlzWFc2YlhP?=
 =?utf-8?Q?r5mY+BcFlESeStjak286jxNL6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf81c48-97ba-44ed-b10f-08db55f669d7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:15:03.6549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAgE/IqQITv7qAmQMwllQA2ZeQkCnnAmM+AHxGb/bn0oyV2KJ4te+KouXY4k58vnIOnYIS+aIt+aPSpRUICvzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7599
X-Proofpoint-ORIG-GUID: muTGbVq7WUMx2RJeR5afDjLjGTISGGdZ
X-Proofpoint-GUID: muTGbVq7WUMx2RJeR5afDjLjGTISGGdZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.811, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 16/05/23 2:27 pm, Daniel P. Berrangé wrote:
> On Tue, May 16, 2023 at 11:18:16AM +0530, Het Gala wrote:
>> On 15/05/23 4:06 pm, Daniel P. Berrangé wrote:
>>> On Fri, May 12, 2023 at 02:32:38PM +0000, Het Gala wrote:
>>>> MigrateChannelList ideally allows to connect accross multiple interfaces.
>>>>
>>>> @@ -51,6 +51,101 @@ static void migration_global_dump(Monitor *mon)
>>>>                       ms->clear_bitmap_shift);
>>>>    }
>>>> +static bool
>>>> +migrate_channel_from_qdict(MigrateChannel **channel,
>>>> +                           const QDict *qdict, Error **errp)
>>>> +{
>>>> +    Error *err = NULL;
>>>> +    const char *channeltype  = qdict_get_try_str(qdict, "channeltype");
>>>> +    const char *transport_str = qdict_get_try_str(qdict, "transport");
>>>> +    const char *socketaddr_type = qdict_get_try_str(qdict, "type");
>>>> +    const char *inet_host = qdict_get_try_str(qdict, "host");
>>>> +    const char *inet_port = qdict_get_try_str(qdict, "port");
>>>> +    const char *unix_path = qdict_get_try_str(qdict, "path");
>>>> +    const char *vsock_cid = qdict_get_try_str(qdict, "cid");
>>>> +    const char *vsock_port = qdict_get_try_str(qdict, "port");
>>>> +    const char *fd = qdict_get_try_str(qdict, "str");
>>>> +    QList *exec = qdict_get_qlist(qdict, "exec");
>>> THis seems to be implicitly defining a huge set of extra parameters
>>> for the migrate 'HMP' command, but none of it is actually defined
>>> at the hmp-commands.hx
>> I don't have a lot of knowledge on HMP commands. I had code changes here in
>> HMP merely to to keep it compatible with QMP command as it used to call
>> qmp_migrate() function.
>>> Do we even need todo this ?  For HMP it is not unreasonable to just
>>> keep using the URI syntax forever?
>> Daniel, I didn't completely understand your ask here. Are you implying that
>> for the HMP wrapper on top of QMP, we should pass it as a string only to
>> qmp_migrate() function ?
> Yeah, that's my thought. HMP is targetted at humans and aims for
> user friendliness, and does not need to have 100% parity with QMP.
> For the multi-channel setup, I think that's going to be something
> only mgmt apps do, unlikely humans using HMP need this.
Yes, I can agree.
>> In that case, we won't be needing migrate_channel_from_qdict() function at
>> all right ? Please guide.
> Yeah, I think it is redundant.
>
> An earlier patch already added an API to convert a "char *uri" into a
> MigrateChannel object. So we can keep HMP using a URI, but pass it to
> QMP using the MigrateChannel struct.

Ack.

IOW, now hmp_migrate() will pass NULL object in place of 'channels', and 
char *uri to the qmp_migrate(), and later 'uri' will be converted into 
MigrateChannel object anyways.

This might also cut many changes in the next patch, and if possible I 
can club Patch 6 and 7 together.

> With regards,
> Daniel
Regards,
Het Gala

