Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7B7148A7
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 13:35:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3b8c-0007K7-CN; Mon, 29 May 2023 07:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3b8Z-0007Jt-PE
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:34:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3b8U-0000Ib-9H
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:34:07 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34T7kLFI018446; Mon, 29 May 2023 04:34:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=DAUGH3WYt5eO/YsSY61yTMOL+PO9ye36+qdYZ5rrr20=;
 b=0+uUUTvDHGjxSlukwBxfB8bQyoxr4gzrQ6wzkkY3kaI8w+XSKM4vaO8+gnp1f9YsFIUR
 Zbwpante5FEJvGdbofbXqfmEKjBISAkx6nRR6Ai78sPJ2rYArTKIDmg2E8Ucf4srAHhl
 xTUEok4kU2zMHYu51Ff2qkraH3i2LiC+ldYet60b0eV9XI+PmsI7GEGUdfTdz+jnQkwn
 3JtNIHgSHqTqekAlkDfoOFLK2Qn7DF2JTSLkKatx6g9Zk3Ywi/kmWkDQ+CMdEr1D6nDp
 iZ7dN9t2fU851n7UVBaANnjzpHJnr4/INwBGpI/zhC/KKk8Ey/YFt9P/BTV1BwsUCs7B Lw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3quhcxmx49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 May 2023 04:34:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5W5CPAtzntgpYVLZ9GLmSJBwuc6ex0i8E/GpdjwZpquMzcdr8QIVmSOikBNXBeC70gDN3/ZtFLXSrvzKfvy3dD4IcIlDbYVXBNOJ3f+RxyXpA0F04m65O0LIWFcL/z+YGlIB67CAhJKn/OXkxlhAvsyy2kWCgl1tQM5YDdkgq6UXBmx6u264NlzRtGfdK4YHOrMB7puoOYG7UDLphmbIKZbyKARBhEqa3itn8PsfAGrpmcWO1D4XqXMJdgJVwIstg9e2t9U32gQVP6Em2zJQ3nO8UnRppT8kcgBQwdw3oN+9eSDIfsfZQd3l3M+iBR7Cre9ssdc6b8CAwxq+Ro9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAUGH3WYt5eO/YsSY61yTMOL+PO9ye36+qdYZ5rrr20=;
 b=n1B+EeEdnnv0MIvKJX4dtnPXhwfErXu1G/Tu4BTZExj8t0rxLMzHbvG5TqJ1YIditxTlYyGBVQ3exqUx3caol599xYcX8aJer/2yq4xra8DI40roul2HW4y6zbXOXZL6171/fAnL45nJNAi8bm5SDGyN1VSfsllRDL7bJwAoNsMkWwTC0jb7LLQKTFqqIfkDT4Ab4TzmWd/YlalMAxGQprsfMnNjr3uXyfGsSm3+vcYIsdYX0RLcSoVAkoaDjpcI/RReopZOQBgW38hBb1vT+H9aJ9eqJqA0j5oVsm+dD/CgplzTndaSUyO3sriMqmMI8jwjNQo0/ypYhysxJU8+MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAUGH3WYt5eO/YsSY61yTMOL+PO9ye36+qdYZ5rrr20=;
 b=ebLgN5iPiNAM7R4Yqaj708tCiJARtPNzdMtCl5XivKidcAUP3alNQDvupTxHEwaAN8inbiON4u4XpSUdaFY9WECga/NE3h9K2G7PAa1ceI+plT1rFZatVdOm1SF3GmBbUYIzHutKcnOb3VMUkR6EvnwwumU8nfoL5vahVR3nOIUpnbtE76GUtCSgJoigFrDdNT6sYBq96xWZK360FabtDiuT6Q+nqGAHf3+fjX3ZYCuJyvV3ridyrI7eq8nE80qbq2KydHvCar5yRQYU70Plvw0NejmXjaLnMxZ05dNL+uzSSSQ5CSoQJCyrWw7IdNnptR8f2r7yVL1wS4xpxQLBeQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA3PR02MB9970.namprd02.prod.outlook.com (2603:10b6:806:382::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 11:33:58 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb%6]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 11:33:57 +0000
Message-ID: <2837b5c4-2f70-c6b2-8309-13c40540ec1d@nutanix.com>
Date: Mon, 29 May 2023 17:03:45 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 6/9] migration: modified migration QAPIs to accept
 'channels' argument for migration
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-7-het.gala@nutanix.com> <875y8gjo5h.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <875y8gjo5h.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::18) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|SA3PR02MB9970:EE_
X-MS-Office365-Filtering-Correlation-Id: b9398093-6cbe-4d50-064a-08db6038969c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqVE4K3DDn9pDD0UFNsevjD67hqQwuz63x7g1uB5S2d4Zbwdo0mp9bAxq1e3jruVudMCTb+d3LY0Qche+BrJuqSV6d7mno/F0ym2fxF4uTtyqhmgEPy/JQnVvTC7/2oZcb5BM0U1KDoou6MRDNo5qELo6lf5OUbAQar8Tl8p7kYGeS/s2nGBNyNx5RgqUk683yD9tpKLNmBOdTcqWVOD6Og7RF450q4gpYhzYOMXtMSff0MUYWBCLMYhsVBrJWqj4nm9Y3F9CL1GOx584xe0eokoHbRFP7DDgGF40u4DWS+3cIRB7sdLLvZy3BBf6JfIB5sx5rze0e8XKCqusFyg3FHjvCYARgf+htH4bRM3T1d3xwgIc4wZqLDHHHsvN7waBREBpa/EAecL7HyHzauXychqJaBf7nY74yg4x+dCKxBxWlZffufNQR3Lsv2dP60bwyVbbZRBINApnikjLy0fFA+uHAlQZlK7PNLc77dTREgr1Te3O+H5162177D4eiNM8FvqH8XBh5BeHzU0j89kHPTCceptbsulN6Xf+HFsJMTY/DjuhNL56Xc33XY7rjjj4LwPoavFzYES1a/vGTymzYKSE/jU0MTPvjwpSpN6U0O+CkFbogDrv0anH/rJtUeqKczgWz7QqUIlK16Nquyx5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(38100700002)(31686004)(41300700001)(6512007)(316002)(6666004)(31696002)(6916009)(4326008)(86362001)(8936002)(6486002)(2906002)(8676002)(2616005)(66946007)(107886003)(66556008)(53546011)(66476007)(36756003)(44832011)(6506007)(26005)(83380400001)(478600001)(5660300002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFlRQ20vbFp3bVJ0YTVRVXI4OEdQNTRlZU0wd3ZVMlFOUGNDZDJFeUNrQ2tv?=
 =?utf-8?B?alhZNWcxeVZYa3ZtbjNzNXZ0Yk5sKzBHa0kvSDZGcmdpS3ZZa20wUGo5TElI?=
 =?utf-8?B?ZVJQcnd1RHlzeVJIczlmOHdmT0FLd29DWVllU2NjYXJwRzZQcVkxSTZoSHJ2?=
 =?utf-8?B?UHVLUnFWYXhvcWNWTEFEY2VteWxoeDBjbTdjaVRvRWJMWU0yN3RYQ3JrZldl?=
 =?utf-8?B?WXBDTnNlZWFFWDErRzZwVElRWExLRVRpS1lXR2x5MVNBWVpHRHp1aE5wTUhv?=
 =?utf-8?B?KzRFVlVPbkxsaUpJNURIb3FUM2VnNUFnN05EeUtUN0Vkc0N1RnVyaU1abVpW?=
 =?utf-8?B?UGxNNnVEWUgrYTZ6VVRzYTkvdStmVXBhTHRoK0N3R0ZTZnd1dkVlTDNPQWJM?=
 =?utf-8?B?OXVWbTRoWTZrLzZxSHZ2dndxdzdOeEx5eDhnMFlQMnFYbjYxcnZlWmFEdmRW?=
 =?utf-8?B?alN6bmdISTdlcEhNQkZmWFJEd1pYOEVlTE1GdkVWbG84RDRLL3BPN3ArSGpU?=
 =?utf-8?B?Mm9xd3N6Z0Nrb3VwT3JjMTZ6Vjg0TUJ2RXlsWGd3VkJHaGJPV3lRNmNrUXE3?=
 =?utf-8?B?NUZYUmNKV2xnYmRvM2hqcXZ3NUM2L0pGMUx4TStUM2xhb0RUZ2dMcTFnZzY3?=
 =?utf-8?B?Q09FWjVzM29XMDZrVUExdWpwMDVKOGNGUzZTSWd0Z1YvTXpxRUt0OXFzMDFB?=
 =?utf-8?B?NEF3aDgrSTRHY2thTWxucVN4Z0RRV0pPOFl1dERqNlI0LzNKbTcwazBVY2dF?=
 =?utf-8?B?NDI2TnVzRDdpdmtWV2U5NTA0QUN4cmNBNC9hTFRpREszRkllSGtHQlNVSnJa?=
 =?utf-8?B?MGNaTVREcVRMbU5iU1BaQmdsYWkwN2hMYU9Va3VGUTF5UEV1bUJxM0Jqd0Va?=
 =?utf-8?B?c2NwbThjWlhNcWdyeFQ4T0V0REZWWlRSN2liNmpPSE1jYi9makRudU56VklP?=
 =?utf-8?B?citPNisxQ28wbDVSNjlHR2RRNGIvb0JIZFIzeUZuNVFmMjNtQTd4YmxsWlNv?=
 =?utf-8?B?WkVQTWF1eUl2TnhuU0JsM2t4WkVWYjFUelRHNzg1bEVta1BFclgxZVdRVm94?=
 =?utf-8?B?ZHFxajk1NGxyWVlodVFzdzNqc0xabGZ4VnNwZW5CaUtvbklUZU5OMVYvWURG?=
 =?utf-8?B?YW9pTkl4MnhzUUZBelR1ZEJJUlI1bkJlN2YxVGRtL3Q1ZFA1U1hxLzhkMCsz?=
 =?utf-8?B?TTZXSFFUdnIyMUtqSnBTV211elZIcDV3RVg5bkQ1VkxzQWFHcjNsREJZY1Fa?=
 =?utf-8?B?K3A1VkNlN1pFMGxmWmtYQ2RkWE9ISE9nU01OYjN3WUxMdm5QVW05MFhTOVhy?=
 =?utf-8?B?S0g4Mi8xNTJmQU82TnZIOW5PdjlVQmhUUXZ5QkRqaXkxOTRnd25PSXU4QmVw?=
 =?utf-8?B?MTJPUiswUldyczBobVQ0Y2lTTjJndzdIZUo3WE9GMXc2dGs3TjBwbFdCRytT?=
 =?utf-8?B?NVAxckVnNmY2ckNQN1hRdXlSR3FySlJoOXYwUWtsc3Z0b1JITXJMTWp5UkNP?=
 =?utf-8?B?T3M5VU1OdWdJMmdRU0JrazRLN0lTRXFrdm9VY3ZoMlJiclJ5dXhhQzdUZDNh?=
 =?utf-8?B?NXYrRmgzVEpHNVE1bWh5STEzTFp4ZW5BSXNNd1QyRzYzWjlYMU4zdUpoTzRU?=
 =?utf-8?B?cW5RYWJ5ZWdabG9IL295ZUZOc0xhZkk5K2pNa1Q1UlE3a2VPVUdEUXhIeWpy?=
 =?utf-8?B?cERaZ0xuRUpBU2hiWnVNMlgyWXR3aDZsdVEvMEkrL2lVRjdzdDVBRnZ3R0lu?=
 =?utf-8?B?aEx6bFpaZEFFTXFUTnNYbURMOFZZRHhWZzBkVVA3bzE3am56OFdveXBJcVo0?=
 =?utf-8?B?bTdyS0tDRENhN2hxaVhBREdKRDlCVXkrYjBCWFlGaDVrMWJKcG9tOHUxTllZ?=
 =?utf-8?B?enNiWlBubjlodHhjek9Ka2dLQlg5TlNyTUxHVVVLVFhER0dIa2FBenV2bXhK?=
 =?utf-8?B?UW5tT3llRVV6TjYzTzgxa0lEUnBNdS9vK3NQZXUxV3RxUkEyMXlNbkxpMXdH?=
 =?utf-8?B?Z2VrMnJhYWxGcnllVmNOOFRrUkQ4S2RjZlViKzhjZTUybE85MEZJamw3MEQ0?=
 =?utf-8?B?UWNVOHI2RS9mbWs2ZWlhWnE5WHJyN29raTd5SzNpUlAwR2tNWDROREVjbENJ?=
 =?utf-8?Q?uNSIiXDWNWlnf/yWpw+2e5yfY?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9398093-6cbe-4d50-064a-08db6038969c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 11:33:56.8013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0GJq04C945rnYrfME/PX80C39DGDCHHVBf65GAYWdNFsJlPDruyRRtY6QnWBL+j4gKXQ5jeszawEnXGWZHGsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9970
X-Proofpoint-ORIG-GUID: a8_pNps54TOOfBEzq2e8VTpnNyaZRmB6
X-Proofpoint-GUID: a8_pNps54TOOfBEzq2e8VTpnNyaZRmB6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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


On 25/05/23 11:20 pm, Markus Armbruster wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> MigrateChannelList allows to connect accross multiple interfaces. Added
>> MigrateChannelList struct as argument to migration QAPIs.
>>
>> Future patchset series plans to include multiple MigrateChannels
>> for multiple interfaces to be connected. That is the reason, 'MigrateChannelList'
>> is the preferred choice of argument over 'MigrateChannel' and making
>> migration QAPIs future proof.
>>
>> For current patchset series, have limited the size of the list to single
>> element (single interface) as runtime check.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> ---
> [...]
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index c500744bb7..86bbc916d1 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1448,12 +1448,47 @@
>>       'exec': 'MigrateExecCommand',
>>       'rdma': 'InetSocketAddress' } }
>>   
>> +##
>> +# @MigrateChannelType:
> As mentioned in my review of PATCH 1, I prefer nouns to verbs for types,
> i.e.  Migration, not Migrate.  More of the same below, not flagging it
> again.
>
Ack.

Also, I forgot ot mention in the 1st patch - even for union and struct 
namings - nouns are preffered over verbs ? or its just for enum types ?
We use structs like - MigrateExecCommand, MigrateChannel --> 
MigrationExecCommand, MigrationChannel ?
and union like - MigrateAddress --> MigrationAddress ?
>> +#
>> +# The supported options for migration channel type requests
>> +#
>> +# @main: Support request for main outbound migration control channel
>> +#
>> +# Since 8.1
>> +##
>> +{ 'enum': 'MigrateChannelType',
>> +  'data': [ 'main' ] }
>> +
>> +##
>> +# @MigrateChannel:
>> +#
>> +# Information regarding migration Channel-type for transferring packets,
>> +# source and corresponding destination interface for socket connection
>> +# and number of multifd channels over the interface.
>> +#
>> +# @channeltype: Name of Channel type for transfering packet information
> @channel-type, because "channeltype" is not a word.
Ack.
>> +#
>> +# @addr: Information regarding migration parameters of destination interface
>> +#
>> +# Since 8.1
>> +##
>> +{ 'struct': 'MigrateChannel',
>> +  'data': {
>> +       'channeltype': 'MigrateChannelType',
>> +       'addr': 'MigrateAddress' } }
>> +
>>   ##
>>   # @migrate:
>>   #
>>   # Migrates the current running guest to another Virtual Machine.
>>   #
>>   # @uri: the Uniform Resource Identifier of the destination VM
>> +#       for migration thread
>> +#
>> +# @channels: Struct containing list of migration channel types, with all
>> +#            the information regarding destination interfaces required for
>> +#            initiating a migration stream.
> Please format like
>
>     # @uri: the Uniform Resource Identifier of the destination VM for
>     #     migration thread
>     #
>     # @channels: Struct containing list of migration channel types, with
>     #     all the information regarding destination interfaces required
>     #     for initiating a migration stream.
>
> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).
Ack. Will change that in the previous patch and will take care in future 
patches too. Thanks for informing regarding qapi documentation changes!
>>   #
>>   # @blk: do block migration (full disk copy)
>>   #
>> @@ -1479,14 +1514,44 @@
>>   # 3. The user Monitor's "detach" argument is invalid in QMP and should
>>   #    not be used
>>   #
>> +# 4. The uri argument should have the Uniform Resource Identifier of default
>> +#    destination VM. This connection will be bound to default network
>> +#
>> +# 5. The 'uri' and 'channel' arguments are mutually exclusive; exactly one
>> +#    of the two should be present.
>> +#
> Long lines.  Better:
>
>     # 4. The uri argument should have the Uniform Resource Identifier of
>     #    default destination VM.  This connection will be bound to default
>     #    network
>     #
>     # 5. The 'uri' and 'channel' arguments are mutually exclusive; exactly
>     #    one of the two should be present.
Ack.
>>   # Example:
>>   #
>>   # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
>>   # <- { "return": {} }
>> +# -> { "execute": "migrate",
>> +#      "arguments": {
>> +#          "channels": [ { "channeltype": "main",
>> +#                          "addr": { "transport": "socket", "type": "inet",
>> +#                                    "host": "10.12.34.9",
>> +#                                    "port": "1050" } } ] } }
>> +# <- { "return": {} }
>> +#
>> +# -> { "execute": "migrate",
>> +#      "arguments": {
>> +#          "channels": [ { "channeltype": "main",
>> +#                          "addr": { "transport": "exec",
>> +#                                    "args": [ "/bin/nc", "-p", "6000",
>> +#                                              "/some/sock" ] } } ] } }
>> +# <- { "return": {} }
>> +#
>> +# -> { "execute": "migrate",
>> +#      "arguments": {
>> +#          "channels": [ { "channeltype": "main",
>> +#                          "addr": { "transport": "rdma",
>> +#                                    "host": "10.12.34.9",
>> +#                                    "port": "1050" } } ] } }
>> +# <- { "return": {} }
>> +#
>>   ##
>>   { 'command': 'migrate',
>> -  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
>> -           '*detach': 'bool', '*resume': 'bool' } }
>> +  'data': {'*uri': 'str', '*channels': [ 'MigrateChannel' ], '*blk': 'bool',
>> +           '*inc': 'bool', '*detach': 'bool', '*resume': 'bool' } }
>>   
>>   ##
>>   # @migrate-incoming:
>> @@ -1497,6 +1562,10 @@
>>   # @uri: The Uniform Resource Identifier identifying the source or
>>   #     address to listen on
>>   #
>> +# @channels: Struct containing list of migration channel types, with all
>> +#            the information regarding destination interfaces required for
>> +#            initiating a migration stream.
>> +#
> The list doesn't contain migration channel types, it contains migration
> channels.
Yes, my bad. Will update it.
> I'm not sure what you're trying to say by "with all the information ..."
>
> What does it mean to have multiple channels?
In future patchset series, we will be introducing channels over 
different interfaces (src-dest pair), with each channel having multiple 
multifd channels. For now we will restrict the size of the list to 1.
> Please format like
>
>     # @channels: Struct containing list of migration channel types, with
>     #     all the information regarding destination interfaces required
>     #     for initiating a migration stream.
Ack.
>>   # Returns: nothing on success
>>   #
>>   # Since: 2.3
>> @@ -1512,13 +1581,42 @@
>>   #
>>   # 3. The uri format is the same as for -incoming
>>   #
>> +# 4. The 'uri' and 'channel' arguments are mutually exclusive; exactly one
>> +#    of the two should be present.
>> +#
> Long line.  Better:
>
>     # 4. The 'uri' and 'channel' arguments are mutually exclusive; exactly
>     #    one of the two should be present.
Ack.
>>   # Example:
>>   #
>>   # -> { "execute": "migrate-incoming",
>>   #      "arguments": { "uri": "tcp::4446" } }
>>   # <- { "return": {} }
>> +#
>> +# -> { "execute": "migrate",
>> +#      "arguments": {
>> +#          "channels": [ { "channeltype": "main",
>> +#                          "addr": { "transport": "socket", "type": "inet",
>> +#                                    "host": "10.12.34.9",
>> +#                                    "port": "1050" } } ] } }
>> +# <- { "return": {} }
>> +#
>> +# -> { "execute": "migrate",
>> +#      "arguments": {
>> +#          "channels": [ { "channeltype": "main",
>> +#                          "addr": { "transport": "exec",
>> +#                                    "args": [ "/bin/nc", "-p", "6000",
>> +#                                              "/some/sock" ] } } ] } }
>> +# <- { "return": {} }
>> +#
>> +# -> { "execute": "migrate",
>> +#      "arguments": {
>> +#          "channels": [ { "channeltype": "main",
>> +#                          "addr": { "transport": "rdma",
>> +#                                    "host": "10.12.34.9",
>> +#                                    "port": "1050" } } ] } }
>> +# <- { "return": {} }
>>   ##
>> -{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
>> +{ 'command': 'migrate-incoming',
>> +             'data': {'*uri': 'str',
>> +                      '*channels': [ 'MigrateChannel' ] } }
>>   
>>   ##
>>   # @xen-save-devices-state:
> The text feels cumbersome.  Writing good prose is hard, especially when
> you're not a native speaker.  Eric, would you like to try your hand at
> polishing this?
> [...]
Regards,
Het Gala

