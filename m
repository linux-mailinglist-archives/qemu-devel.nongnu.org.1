Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 159FC7156DB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 09:34:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3tqe-0005rw-Ae; Tue, 30 May 2023 03:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3tqb-0005qx-L9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:32:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3tqY-00061s-EN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:32:49 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34U2mgFc023087; Tue, 30 May 2023 00:32:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=proofpoint20171006;
 bh=xXlsUviS9ekvpORi2x94gL/spEISGeqeNeMoyyFQU7s=;
 b=2OHEGOYaKbxC4Y1Zo96hlZOCXTAmc8ZD5565gelLkLrpNaWi7X3DN8jE4PMitROvZoOj
 qAZSHgu7QZlPMTq4WHfDPIsJjkFVJ7BB3ezgzwvBiUAe4k5ursDJBenbkdCnu4BFBJr6
 iSwL7djouP5FZAOrG7CVZJ9G4pq7guQ8feGKuUoAkz+WlhMfIfNYbbnNSnpOjR2Rj0SC
 5CqboLIqVeGI02CVPHN53ZoIBA4o4AYfuT/+I7tVFHxOQRxa8FnpTKFiI8eTbewT1das
 m+ROSDwf+Qm/+JT/E+HQ2b/BuNIyYDWw8QphzhmJZoG5hpvDZ+N3dMLnvT/TY7SAyvb5 cg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3quds5mw35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 00:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsurVFRWaQUxFVBIeSyFxrAoZttrO09bl4iS8I75VEgjM0uCWFWuUM7h7OhjILb8IztQ3T0x6ELjn6aswPbPPGorhD0EFSuo597Sx3tA4CRB3hLrUGymRU3R1W6iOAggV5MZrxR6cyIDLWvvzzPLn8UC3HmnXaRzHGhvNbg1sNk3DuOAFw2HKANQMpFapk8w65pT7fZPNo/B+aDL2HBsAxaUX5jFAFTsfbfAhNw7iDpgg3QF2vrQDu/m6XtVB5bb2SL6QTuWcmM0xElFQHGIlsJ8fd33JJy+Rx6H62keI9g7hs2q3xPBu4Sl+d7TKeI4yOzVoWr3/ymPI9fb/RsJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXlsUviS9ekvpORi2x94gL/spEISGeqeNeMoyyFQU7s=;
 b=Y+IEpAckhlVwx1pj9NydzDlIMU1AYSKYAZaB8hpjsOv+EBv1oKhaU2tEqvVaS0ocPe2nWlN/NBk43O5ebI7cms+zg22eHDPEigs6kxRjRs5iAaKg5UMfvbctHXdq1CZu0hLbLNJzMmUGnNzGHpMeUm9rEsbl3IKMrMhulKO70v+GMUxVWEOzjaWsteNgvR1iOw1IbXnmBg/dpfsBsgzH8067+o4xOZTEqW6UEb4i+J4Rj/lcltjkPO/+Q1c+49c1eL2uTX+6aTscdFBN1nFM7ICEE+6n5NPiycvNkD8YlnSyUXmbMCVCEBZ61BnAHuaFS7IqnvDEfG+VXI2Szf5ZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXlsUviS9ekvpORi2x94gL/spEISGeqeNeMoyyFQU7s=;
 b=DFE3pWNFYnFAxWqH7D/igF+bljRbCWjnXp2nCp4WdaWS5hKZUIOA8GTq847HnLOJO0FkSNHOlx9jXKVKt1HIq/19aNGtbCuNd69DQIdgSUq+YmVXJDre0INmnQRf7zOYFC2Ta1sq5OQJ5oXrPc0wOHTj9KXtLEiQhLV4rX3Zsl4YkGZPlsJCp5KComf+P85R+wEJ/emFh7L3of0Qs+7+b2FGnVRRRmp5ameb1x7B1cT5nTSiTKhEBpvD3u+ZPd0cSAbSQ51GISK7MZ8xJ0XDsmwl4XSVU6eUFnmAdLGzHBJao7a+LNrO4Kic8ZyAvtpxuVlQRzzgy7lKviwGHTp6vA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by IA0PR02MB9920.namprd02.prod.outlook.com (2603:10b6:208:48d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 07:32:40 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 07:32:39 +0000
Content-Type: multipart/alternative;
 boundary="------------GCoaJwyxXlJFHzcb4iBxgQ90"
Message-ID: <99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com>
Date: Tue, 30 May 2023 13:02:27 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-2-het.gala@nutanix.com> <87sfbkjow3.fsf@pond.sub.org>
 <af2e5fbe-75f5-d6dd-df8c-8894cc5b0056@nutanix.com>
 <87edmyuwzc.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87edmyuwzc.fsf@pond.sub.org>
X-ClientProxiedBy: MA1PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::20) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|IA0PR02MB9920:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc27f80-5287-4b81-f498-08db60e00baf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wdh6Unjw90ErKV7Mt59gjuG5XUNXIGiraWCoUj7P85MYqvnI1MjoM5Hgb2Tu+gl0RSI8Q+l+TaPLKjEzgp9Dg3u6lMuUGJjjvZ7Ym49xooxccSTYDVQ/veRS9LADjOdR/GoeBJll9sDQJm1epTEqprYqJaSK6DLO9sQr5LAEQBUBWSeraaeCS7EoNNnO7eJXNdH8WYkoo1/ud8gi4XXm93FYP4pkkj6tsAYibu6Sgt87zanDMyGfKT+yk2mXv7HnAfkuL3ALFG/VrQPRA4FPzJy5EKX7LFCheJaZyXVWZVMT5lqYk6p9r3DxXXbLSWTV0bRer1l64+dwUbsTM+f0pc8cqPa5cyK/3XkdiKgfUNy+rvz/j9vp7yTJswcKsgx2Ph74hmWAzZn48xSKNhg3Q2J/t+7qWyhptQSZl9Mlj15aEYSe7FUwW8lqrM5f2MKN1qE//rQ3EtXLCqcA7RaXPrQW5H43RoScO7a0H6cb7JbR1g1o6LqBVtarY6b5k70yI5gHb9CvFEdlDzHsURBDP0XMP6xgCAtVqZLPD6+vIgkA0mEuntxNevlOL6nAvR2wHny8g6yQbKbJdbUyyhoSnBiCzMCb/o6CICt6ZPi84VD38FgNlR+fzprHz95CDxL4D5a/CF9o2yY9vL8x3hZqsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(26005)(107886003)(38100700002)(41300700001)(6486002)(33964004)(6666004)(186003)(31686004)(53546011)(6512007)(6506007)(2616005)(478600001)(66899021)(6916009)(66476007)(66556008)(66946007)(4326008)(316002)(5660300002)(8676002)(8936002)(44832011)(2906002)(86362001)(31696002)(30864003)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHFtWWE3YkRZQkRvUjhGNUFMNmtISzdiL1hGYzZ0VmVTTGpid2xZdFlkVTJD?=
 =?utf-8?B?K2E5ekt5VXYxTEoxenpGQjFTd3JqT1JsMTRXcEdaekE4U0htSUdHWnF1M3kz?=
 =?utf-8?B?R3g4UkN5bVFHZTZIQ0lpTk1JMm0yRm5LTzlFL1dJbzFTZGo1YWVLMmtqbkI2?=
 =?utf-8?B?TzhSV2REVmg2bjArYlJDZUFPTHZUR2NVZXU5dkdFREwzMStxQkxWQnVDSzhT?=
 =?utf-8?B?ZEpBbWJ3RjFCaXd2RFNoTGY1Skg4Zm1hRlV2bWVtMkg3VVZ1UzAwQm5YZVlm?=
 =?utf-8?B?b0szZ3ZlMTZpWjY5SUIvK29KMno2cFFXUzB3RWZmTVUrV0tudWIyYWs1Nm5D?=
 =?utf-8?B?ajAxNHBXNmhuZVh5MHpSSldWV0pKSzlUSk81M0pGYW14eXhPVTdyUWlyN1k3?=
 =?utf-8?B?SHVYU0JIUjY0cWg1Y0Y5NzFQV0hQZ0NHKzNtQUdMR2VPQkRhV21oTGt3VW00?=
 =?utf-8?B?SVRaQkd5ZVM0ZURnUFlrSzloMFM3MVkvSnMyQzZza0FmODRVdTg4WTRTdC9N?=
 =?utf-8?B?ZnlZLzdNUEVoMU12K2lDZkVjVGkzYVZSS0xzdFB4ZXZ2ekI1TkZUMTNVM3RH?=
 =?utf-8?B?QWQvVk1PaUZNQ1l1MjZjMCtCc3BJWmlHakdEK3RKNlZsNW93TXNGSEdIaSt4?=
 =?utf-8?B?bmdNQ0l0NkttbUtsaFZ1cmRHMjlUQ2VsQVlNb2tTQVl5dWsxbEtuTGlkOGZL?=
 =?utf-8?B?QjVWSHdVbGlJSFR4UnpPUkdpMmp2R0k5aENqWHo0ZENzVFVuWWIwUXphY2Zt?=
 =?utf-8?B?c0ljR2dDQ3ZOOTlrQThab3haaCt1YUlqQ1QySWk2Q1dmR2dmNUtvRm1Rak1h?=
 =?utf-8?B?cDlwQ2xQZTl5VHFUMkQxWlJOZ1k3N2E4c2V1bEUyUHZGeWNlakZDeGlyNFFq?=
 =?utf-8?B?VkM3Z1RFbGFsaXUwbjdzRVZlcHBPY2NMV0lJMXUvWTZyTkJHWUpQbjIwZnVH?=
 =?utf-8?B?dTlCMHJOVGo5bnhPN0F0QTBqeEN0VURBaXRxdy85a1RaZWlwT1FVSW5vL2Rs?=
 =?utf-8?B?dzFtSk9JMnFFekpFVFJDa2h1OWFGVVR5TFM0V2p2dFJCM3JHVDhrT2pscDI1?=
 =?utf-8?B?N3Ywdi9wKzBTVlJtMFVhZ01xMVpoRW5rWXRKU1hMeVAyVms0TysxYUYwcFkr?=
 =?utf-8?B?MVA3N0UrTHlnK3JJZGpMekZFcmJldnhaU0o2Q1RkdFVLaHZtTWR3bXBSNzJW?=
 =?utf-8?B?eXJZS21BT2tBbkxPbldtYnJFeXdsclNBWC91aE9nQ3JsS1NTZGdyem9MMndx?=
 =?utf-8?B?Y1VuVXB6M2dsSFo1QmdHelVLMnB3QkhZSjNad1F4Y3IxUllsVkVQNm85N2l4?=
 =?utf-8?B?bEZhSG52T29HMWswYVdJdUlqSDhhMVlaZ2NkYndNMEFRUXVWYnduZHhHWFpH?=
 =?utf-8?B?bWwvamh4dGp5OVNrOEQ1Qkl2OE5lQ2Y2Q0ROeTlhb2t3eWpBQzBBeWN3dWVN?=
 =?utf-8?B?eVF4VnZCdnFpM2p1NHZvanVvNkFmN0xNRW1xeFltNUk3S3lGV0lXOVBEdmJ6?=
 =?utf-8?B?M2FFTXl6OTdPb0pZWEs1OXdpbENCWjF5ZUMxNXpaNTNIK2ZpVzYxODlBN05i?=
 =?utf-8?B?UWhaaGF4ZzVCbUFKckxDdG4zaWorL09KM01yWG9VRXRGUkt1cUFzZ3N5bVBk?=
 =?utf-8?B?US9icUgwUjE3R1c2NjV1T0ZBVmg5VVI3NURQRVR0K2RtckM2V0l2VklCeDFW?=
 =?utf-8?B?NU1OWkViTEFBbGRxRkRYcjhYVXdRRUR0VG15NUY2M0lVb1dJeEJGNDAwemtW?=
 =?utf-8?B?YzYvaUVmMFNCdFBaa1BDampiQmtrZWV5ckhOejVpYlBxR3VmMlMrZDhFcXVQ?=
 =?utf-8?B?cEJzZmhUK3VUaVFKMlk4amtDaE5Qc0lja0Y2MWhJZksxOVJvT21weVBDeHgx?=
 =?utf-8?B?ZnRkY1FtOW81RksvblBCUjVhODFFSzh4WEZJT3RoUHVsVHRkU3lNN25OQ015?=
 =?utf-8?B?UGRuTTltOFJTODBLKzIrWndJYVNGbWFUQlA2RUtPUmNFSXQ2SmtSZnJOUktZ?=
 =?utf-8?B?ZDRxT3BrU25DWFRjZlBHVnRWcE9nWlhRVzBBZ3B2aTRjQWE0M3BVTDJhdEYz?=
 =?utf-8?B?SDVieDMvaDFqREd4bk9rVlR3b3VRbGU3enBaUFh2cTFlTERFbHV0RHZxdkFj?=
 =?utf-8?Q?lVkk1CZd5NBQAknf6nISlSrTd?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc27f80-5287-4b81-f498-08db60e00baf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 07:32:39.2459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7b0BGxSVdq2D477Ipv5n4ZC11Fx9Zuf/drxewhHUH5nZ8yzyHnQ9Oio07tF0EJjv29BLWEVKIYuNNYMhYlCVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9920
X-Proofpoint-GUID: obfGIyl2wPP4-BkRvo6bfy2sVALg6Yy9
X-Proofpoint-ORIG-GUID: obfGIyl2wPP4-BkRvo6bfy2sVALg6Yy9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_04,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------GCoaJwyxXlJFHzcb4iBxgQ90
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 30/05/23 12:28 pm, Markus Armbruster wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> On 25/05/23 11:04 pm, Markus Armbruster wrote:
>>> Het Gala<het.gala@nutanix.com>  writes:
>>>
>>>> This patch introduces well defined MigrateAddress struct and its related child
>>>> objects.
>>>>
>>>> The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri' is of
>>>> string type. The current migration flow follows double encoding scheme for
>>>> fetching migration parameters such as 'uri' and this is not an ideal design.
>>>>
>>>> Motive for intoducing struct level design is to prevent double encoding of QAPI
>>>> arguments, as Qemu should be able to directly use the QAPI arguments without
>>>> any level of encoding.
>>>>
>>>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>> Reviewed-by: Juan Quintela<quintela@redhat.com>
>>>> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>>>> ---
>>>>    qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 41 insertions(+)
>>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index 179af0c4d8..c500744bb7 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -1407,6 +1407,47 @@
>>>>    ##
>>>>    { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
>>>>    +##
>>>> +# @MigrateTransport:
>>> I'd prefer MigrationTransport, because "migration" is a noun, while
>>> migrate is a verb.  Verbs are for commands.  For types we use nouns.
>>> More of the same below, not noting it again.
>>>
>>> Actually, I'd prefer MigrationAddressType, because it's purpose is to
>>> serve as discriminator type in union MigrationAddress.
>>>
>> Okay got it. I kept it Transport as they are different transport mechanisms. But 'MigrationAddressType' looks cleaner and comaptible with 'MigrateAddress' union too. Will change that
> Transport isn't bad, but I think a type that is only used for a union
> discriminator is best named after the union type.
Yes I agree with your approach too. Will change it to 
'MigrationAddressType' in the next patchset.
>>>> +#
>>>> +# The supported communication transport mechanisms for migration
>>>> +#
>>>> +# @socket: Supported communication type between two devices for migration.
>>>> +#          Socket is able to cover all of 'tcp', 'unix', 'vsock' and
>>>> +#          'fd' already
>>> Migration is between hosts, not "two devices".
>> Here we are just talking about socket communication right ? So I thought devices might also work.
> In QEMU, "devices" are the things you create with device_add.
>
> Sockets connect "endpoints".  Also called "peers".
Ack. 'endpoints' sounds very appropriate to me.
>> Will change that to 'hosts' as this is in context of migration i.e. MigrattionAddressType
>>
>>> The second sentence confuses me.  What are you trying to say?
>> I am trying to say that socket is a union in itslef right, so it covers communication transport mechanisms like tcp, unix, vsock and fd already in it.
>>
>>> Also, missing period at the end.
>> Ack.
>>
>>>> +#
>>>> +# @exec: Supported communication type to redirect migration stream into file.
>>>> +#
>>>> +# @rdma: Supported communication type to redirect rdma type migration stream.
>>> What about:
>>>
>>>      ##
>>>      # @MigrationTransport:
>>>      #
>>>      # The migration stream transport mechanisms
>>>      #
>>>      # @socket: Migrate via socket
>>>      #
>>>      # @rdma: Migrate via RDMA
>>>      #
>>>      # @file: Direct the migration stream to a file
>> Should I change from '@exec' to '@file' ?
> Uh, that change happened somewhere between my conscious thought process
> and the keyboard ;)
>
> What about
>
>         # @exec: Direct the migration stream to another process
No worries Markus. Seems okay.
>> Other than that, it looks better than what I proposed. Will change it.
>>
>>>> +#
>>>> +# Since 8.1
>>>> +##
>>>> +{ 'enum': 'MigrateTransport',
>>>> +  'data': ['socket', 'exec', 'rdma'] }
>>>> +
>>>> +##
>>>> +# @MigrateExecCommand:
>>> Documentation of @args is missing.
>> Ack. Should the naming '@args' be replaced by '@filepath' or @path' or something similar ?
> Depends on what @args means.
>
> I guess its [program, arg1, arg2, ...].
>
> You could split off the program:
>
>      'program: 'str',
>      'args': [ 'str' ]
>
> Try to write clear documentation for both alternatives.  Such an
> exercise tends to lead me to the one I prefer.

Hmm, basically here the @args means, for example ['/bin/bash', args1, 
args2, ..., <command>], where command -> /some/file/path.

Does it even make sense now to break into 3 different parts ?

	'program': 'str'
	'args': [ 'str' ]
	'command': 'str'

This might probably just need to tewak something in the exec file I guess.

>>>> + #
>>>> + # Since 8.1
>>>> + ##
>>> Unwanted indentation.
>> Not able to see any unwanted indentation here ?
> Looks like it got eaten on the way.  The last three lines of the doc
> comment are indented:
>
>      +##
>      +# @MigrateExecCommand:
>      + #
>      + # Since 8.1
>      + ##
>      +{ 'struct': 'MigrateExecCommand',
>      +   'data': {'args': [ 'str' ] } }
Yes, you are right. I figured out after replying to you and was looking 
at the code. Thanks for noticing it out! Will change spurious 
indentation in the v6.
>>>> +{ 'struct': 'MigrateExecCommand',
>>>> +   'data': {'args': [ 'str' ] } }
>>>> +
>>>> +##
>>>> +# @MigrateAddress:
>>>> +#
>>>> +# The options available for communication transport mechanisms for migration
>>> Not happy with this sentence (writing good documentation is hard).
>>>
>>> Is the address used for the destination only, or for the source as well?
>>>
>>> If destination only, could it be used for the source at least in theory?
>>>
>>> I'm asking because I need to understand more about intended use to be
>>> able to suggest doc improvements.
>> This address will be used on both destination and source. In code flow, in later patches, changes on destination as well as source have been made to incorporate same definition.
> Does @exec work as source?
>
> Maybe:
>
>       # Endpoint address for migration
>
> or
>
>       # Migration endpoint configuration

I think @exec work as source too, because in exec.c file, there are 
calls for souce as well as destination.

I would like to go with "Migration endpoint configuration" because I 
feel 'migrate' and 'migrate-incoming' QAPIs are defined in context of 
live migration.

>>>> +#
>>>> +# Since 8.1
>>>> +##
>>>> +{ 'union': 'MigrateAddress',
>>>> +  'base': { 'transport' : 'MigrateTransport'},
>>>> +  'discriminator': 'transport',
>>>> +  'data': {
>>>> +    'socket': 'SocketAddress',
>>>> +    'exec': 'MigrateExecCommand',
>>>> +    'rdma': 'InetSocketAddress' } }
>>>> +
>>> Aside: a more powerful type system would let us extend SocketAddress
>>> with additional variants instead of wrapping it in a union.
>> Markus, what do you mean by additional variants here in context of socket? Can you give a small example.
> As is, we have a nest of two unions:
>
> * The outer union has branches @socket, @exec, @rdma.
>
> * Branch @socket is the inner union, it has branches @inet, @unix, ...
>
> A more powerful type system would let us extend SocketAddress instead,
> so MigrateAddress has everything SocketAddress has, plus additional
> branches @exec, @rdma.  Naturally, the type of the discriminator also
> needs to be extended, so that it has everything SocketAddress's
> discriminator type has, plus additional members @exec, @rdma.
>
Okay, so you mean something like :

+# Since 8.1
+##
+{ 'union': 'MigrateAddress',
+  'base': { 'transport' : 'MigrateTransport'},
+  'discriminator': 'transport',
+  'data': {
+    'inet': 'InetSocketAddress',
+    'unix': 'UnixSocketAddress',
+    'vsock': 'VsockSocketAddress',
+    'fd': 'str',
+    'exec': 'MigrateExecCommand',
+    'rdma': 'InetSocketAddress' } }

Even I agree that directly leveraging this is the best option, but then 
wouldn't it introduce redundancy ? we would not be able to leverage 
socket union right in that case or am I missing something.

Regards,
Het Gala
--------------GCoaJwyxXlJFHzcb4iBxgQ90
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 30/05/23 12:28 pm, Markus Armbruster
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87edmyuwzc.fsf@pond.sub.org">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 25/05/23 11:04 pm, Markus Armbruster wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">This patch introduces well defined MigrateAddress struct and its related child
objects.

The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri' is of
string type. The current migration flow follows double encoding scheme for
fetching migration parameters such as 'uri' and this is not an ideal design.

Motive for intoducing struct level design is to prevent double encoding of QAPI
arguments, as Qemu should be able to directly use the QAPI arguments without
any level of encoding.

Suggested-by: Aravind Retnakaran <a class="moz-txt-link-rfc2396E" href="mailto:aravind.retnakaran@nutanix.com">&lt;aravind.retnakaran@nutanix.com&gt;</a>
Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Reviewed-by: Juan Quintela <a class="moz-txt-link-rfc2396E" href="mailto:quintela@redhat.com">&lt;quintela@redhat.com&gt;</a>
Reviewed-by: Daniel P. Berrangé <a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a>
---
  qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
  1 file changed, 41 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 179af0c4d8..c500744bb7 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1407,6 +1407,47 @@
  ##
  { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
  +##
+# @MigrateTransport:
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
I'd prefer MigrationTransport, because &quot;migration&quot; is a noun, while
migrate is a verb.  Verbs are for commands.  For types we use nouns.
More of the same below, not noting it again.

Actually, I'd prefer MigrationAddressType, because it's purpose is to
serve as discriminator type in union MigrationAddress.

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Okay got it. I kept it Transport as they are different transport mechanisms. But 'MigrationAddressType' looks cleaner and comaptible with 'MigrateAddress' union too. Will change that
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Transport isn't bad, but I think a type that is only used for a union
discriminator is best named after the union type.</pre>
    </blockquote>
    Yes I agree with your approach too. Will change it to
    'MigrationAddressType' in the next patchset.
    <blockquote type="cite" cite="mid:87edmyuwzc.fsf@pond.sub.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+#
+# The supported communication transport mechanisms for migration
+#
+# @socket: Supported communication type between two devices for migration.
+#          Socket is able to cover all of 'tcp', 'unix', 'vsock' and
+#          'fd' already
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
Migration is between hosts, not &quot;two devices&quot;.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Here we are just talking about socket communication right ? So I thought devices might also work.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
In QEMU, &quot;devices&quot; are the things you create with device_add.

Sockets connect &quot;endpoints&quot;.  Also called &quot;peers&quot;.</pre>
    </blockquote>
    Ack. 'endpoints' sounds very appropriate to me.
    <blockquote type="cite" cite="mid:87edmyuwzc.fsf@pond.sub.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Will change that to 'hosts' as this is in context of migration i.e. MigrattionAddressType

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">The second sentence confuses me.  What are you trying to say?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I am trying to say that socket is a union in itslef right, so it covers communication transport mechanisms like tcp, unix, vsock and fd already in it.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Also, missing period at the end.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Ack.

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+#
+# @exec: Supported communication type to redirect migration stream into file.
+#
+# @rdma: Supported communication type to redirect rdma type migration stream.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">What about:

    ##
    # @MigrationTransport:
    #
    # The migration stream transport mechanisms
    #
    # @socket: Migrate via socket
    #
    # @rdma: Migrate via RDMA
    #
    # @file: Direct the migration stream to a file
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Should I change from '@exec' to '@file' ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Uh, that change happened somewhere between my conscious thought process
and the keyboard ;)

What about

       # @exec: Direct the migration stream to another process</pre>
    </blockquote>
    No worries Markus. Seems okay.
    <blockquote type="cite" cite="mid:87edmyuwzc.fsf@pond.sub.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Other than that, it looks better than what I proposed. Will change it.

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+#
+# Since 8.1
+##
+{ 'enum': 'MigrateTransport',
+  'data': ['socket', 'exec', 'rdma'] }
+
+##
+# @MigrateExecCommand:
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Documentation of @args is missing.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Ack. Should the naming '@args' be replaced by '@filepath' or @path' or something similar ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Depends on what @args means.

I guess its [program, arg1, arg2, ...].

You could split off the program:

    'program: 'str',
    'args': [ 'str' ]

Try to write clear documentation for both alternatives.  Such an
exercise tends to lead me to the one I prefer.</pre>
    </blockquote>
    <p>Hmm, basically here the @args means, for example ['/bin/bash',
      args1, args2, ..., &lt;command&gt;], where command -&gt;
      /some/file/path.</p>
    <p>Does it even make sense now to break into 3 different parts ? <br>
    </p>
    <pre>	'program': 'str'
	'args': [ 'str' ]
	'command': 'str'
</pre>
    <p>This might probably just need to tewak something in the exec file
      I guess.
    </p>
    <blockquote type="cite" cite="mid:87edmyuwzc.fsf@pond.sub.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+ #
+ # Since 8.1
+ ##
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
Unwanted indentation.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Not able to see any unwanted indentation here ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Looks like it got eaten on the way.  The last three lines of the doc
comment are indented:

    +##
    +# @MigrateExecCommand:
    + #
    + # Since 8.1
    + ##
    +{ 'struct': 'MigrateExecCommand',
    +   'data': {'args': [ 'str' ] } }</pre>
    </blockquote>
    Yes, you are right. I figured out after replying to you and was
    looking at the code. Thanks for noticing it out! Will change
    spurious indentation in the v6.
    <blockquote type="cite" cite="mid:87edmyuwzc.fsf@pond.sub.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+{ 'struct': 'MigrateExecCommand',
+   'data': {'args': [ 'str' ] } }
+
+##
+# @MigrateAddress:
+#
+# The options available for communication transport mechanisms for migration
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Not happy with this sentence (writing good documentation is hard).

Is the address used for the destination only, or for the source as well?

If destination only, could it be used for the source at least in theory?

I'm asking because I need to understand more about intended use to be
able to suggest doc improvements.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
This address will be used on both destination and source. In code flow, in later patches, changes on destination as well as source have been made to incorporate same definition.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Does @exec work as source?

Maybe:

     # Endpoint address for migration

or

     # Migration endpoint configuration</pre>
    </blockquote>
    <p>I think @exec work as source too, because in exec.c file, there
      are calls for souce as well as destination.</p>
    <p>I would like to go with &quot;Migration endpoint configuration&quot;
      because I feel 'migrate' and 'migrate-incoming' QAPIs are defined
      in context of live migration.<br>
    </p>
    <p></p>
    <blockquote type="cite" cite="mid:87edmyuwzc.fsf@pond.sub.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+#
+# Since 8.1
+##
+{ 'union': 'MigrateAddress',
+  'base': { 'transport' : 'MigrateTransport'},
+  'discriminator': 'transport',
+  'data': {
+    'socket': 'SocketAddress',
+    'exec': 'MigrateExecCommand',
+    'rdma': 'InetSocketAddress' } }
+
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Aside: a more powerful type system would let us extend SocketAddress
with additional variants instead of wrapping it in a union.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Markus, what do you mean by additional variants here in context of socket? Can you give a small example.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
As is, we have a nest of two unions:

* The outer union has branches @socket, @exec, @rdma.

* Branch @socket is the inner union, it has branches @inet, @unix, ...

A more powerful type system would let us extend SocketAddress instead,
so MigrateAddress has everything SocketAddress has, plus additional
branches @exec, @rdma.  Naturally, the type of the discriminator also
needs to be extended, so that it has everything SocketAddress's
discriminator type has, plus additional members @exec, @rdma.

</pre>
    </blockquote>
    <p>Okay, so you mean something like : <br>
    </p>
    <pre>+# Since 8.1
+##
+{ 'union': 'MigrateAddress',
+  'base': { 'transport' : 'MigrateTransport'},
+  'discriminator': 'transport',
+  'data': {
+    'inet': 'InetSocketAddress',
+    'unix': 'UnixSocketAddress',
+    'vsock': 'VsockSocketAddress',
+    'fd': 'str',
+    'exec': 'MigrateExecCommand',
+    'rdma': 'InetSocketAddress' } }

</pre>
    <p>Even I agree that directly leveraging this is the best option,
      but then wouldn't it introduce redundancy ? we would not be able
      to leverage socket union right in that case or am I missing
      something.</p>
    Regards,<br>
    Het Gala<br>
  </body>
</html>

--------------GCoaJwyxXlJFHzcb4iBxgQ90--

