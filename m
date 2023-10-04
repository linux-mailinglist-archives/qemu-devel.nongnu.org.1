Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1342A7B7726
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 06:31:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qntVn-0006CL-B0; Wed, 04 Oct 2023 00:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qntVl-0006Bz-O6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 00:29:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qntVf-0005po-3F
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 00:29:25 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 393FT7l2015990; Tue, 3 Oct 2023 21:29:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:from:subject:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=KxitHsI3QyhrbCjiiPwTg8v+Icusof07jSvDJmPPx
 KE=; b=A6InQ0wlGjSviXoRNkKUOpKcBhwvjbOyCEr2R0FO2bAc6Ro0rRIwnn59w
 p5oJM88uu73XOYXsWd7VqJYwItivmzzo9I9F57E6nZCoxcP9Ke2V8ayqSOvHW6EG
 Q5nnY5Zkcol8CVjpwbkQaU0yAGJ0RgI7U5nRJwgczybTwda+oEY8pLyb1LjJksSD
 XR6r8jHMNDhCnSSLSMyNm3d7zly7tFBYOgQOL1nw91y5/q57n4Rl2lz9gb98G1Jf
 6WhY1BUukskhkB/5TIChDPFNwi+BEdT3Ds1cYkodJ5WCFwkHDDx1SVpXBcGU0Ude
 cGDAlorp8Mrkh8VPmAa7VmCZ8yhQQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tehsffprs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 21:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnZp+PYeBKilkaa3jzLOx6xNl0hsxni6lgvwfpjT5jEIC13mAHvZKzeoXxXL9pePQlmmyHHdH2EYAwSKwzpLJ1O6T2loBAdj15Qk+F4Co2hG4Ld7+uNE0qz+AAAP+ts2NbVqZYG1QnXmv1sskoWx+uYChwgwz9SpISJxUZCSVKNjByhTzAvzJjMwiaOHS0zmmTR9GfdadkYhONYIzZ3YanZKTihoxxEq/5N8BNjnj6JkkbsOyHypPNw2gx6yAwPZh3smKJGjYb7fHv71Tgcp8yucSq95gsV5D+clfDRCbMG5Jka/V8STEpHgbzWXyCcfPweh3p5WSi2BoxWvG+YxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxitHsI3QyhrbCjiiPwTg8v+Icusof07jSvDJmPPxKE=;
 b=Nvrcbo+gBbv7bawqPrq0UWiqPjAqsaplkHnO6Fw2nFTyuDl2URkqqIhHXnhBwDYnUYkVACNobIjTS5ckpwXfGhYU7dloY5xJYUYOZ/tw93u4PwB5iB+fxzlxzj3r1PHNMdVTegM9KBpI4ev+RQMb3OW2IO1UjHwbfY4iGGDU4BJn+5mkxHMM7tHgONfh5eyGhZO4E5bC5vu+35qOF9ETEecQ+yV+MvFeb0RyJkwpAQurwHdmSQw706rw5k1TL/hqh58CVNi8YGzC1yeosO5plvE/FnK/Qe/q+thItrNOIdlNjU/oWOkOFiZ68gLPA5quB3ht7TmKYPD20JuFk94MQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxitHsI3QyhrbCjiiPwTg8v+Icusof07jSvDJmPPxKE=;
 b=bdHHOOVt5ryTk2dv0LAd4r/k+arQdvhdPayaE7KR3p9fTOFqAbdfWB7Easpf/I7tfAq2vaC+W/GyUkkwnbMEqHdE8bIbhZ9JQ6IlURZIaVCRIKJt8gd4drPvQoc2iMrVlaw8//pD3trNne24aSv92pF7H1NxY/8MTtXtR/y3v1L46ToQR0Ls5AeRXnsnTEzN5tcPDn1xvhYBuRFuTa2BQtQdJdiMxi3azZ9HigXYt9Z50sIeUR7TKsh125imqbh0QxDnpS72V8NpuqoRN1OXZ5tgyBlC9CHZ+91wzvHCuX4OVpwgqLmdChdyjfeBiuF92wJw0SkIOHEyZjrjN1jaFQ==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by SJ0PR02MB7293.namprd02.prod.outlook.com (2603:10b6:a03:29f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 04:29:12 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4d3b:ac91:5aa8:d77]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4d3b:ac91:5aa8:d77%4]) with mapi id 15.20.6838.016; Wed, 4 Oct 2023
 04:29:12 +0000
Message-ID: <c281b1e9-a027-4871-a1d5-7fc10f4ba1ed@nutanix.com>
Date: Wed, 4 Oct 2023 09:58:59 +0530
User-Agent: Mozilla Thunderbird
From: Tejus GK <tejus.gk@nutanix.com>
Subject: Re: [PATCH v5 2/2] migration: Update error description outside
 migration.c
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, leobras@redhat.com
References: <20231003065538.244752-1-tejus.gk@nutanix.com>
 <20231003065538.244752-3-tejus.gk@nutanix.com> <874jj77u4a.fsf@secure.mitica>
Content-Language: en-US
In-Reply-To: <874jj77u4a.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::10) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|SJ0PR02MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cf5914-d70b-43cb-6cce-08dbc492754f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kudItaW2fUHliSEOeM3hob+yuV5+9W8pKFD8+uaWnQWJnN+I5LnBr0qbxZn/LL8S8NbFLyP2wQv4yXdCdX/W8aaQQJXrgnbW8Rk77RUiIL5Spwcpgo6Xgi8MLa6/0ExTRCklgD0jjkIDlN8hJHst2fmQSDeunOavN3ddcJFUL6ciekrY+fgmOp9sHya7RsTgnI7v3BUR6GT0tj2m2qnICozh5KJ2dgnr4CG20OXgT9vMbF6dzSQURPl6eGp/sDw5X9qxPy0HF4ft1lQWqVW1niDgFqP4sr/SzYasFNzP7ZV02kCiFcp7BR3osDaE69tS0f053tJvEuQ4pvOacq8Vr0a8mFmavGp0rJjS/NZRErYaVV+3eXHlK6A09MUK1FSQNuCGfYD4XVjJOQQQ+IeSPysP3aeGAnhdmBmWq23fHK5Cap9dnQCgbcIkFCxosZfhYzWgAHqWkc7gwOEeuTe8Kh8ZZo6YUi2EjvSeq4+VyZgThkbXToUWKizZObyXk0EH1BGx+pwpXrd/iJ4diu3eAWG9OF4RMOVToLFe5IEPylL6cc/siq/NejwONR5Kqestn/WfBZQ/h55ViXFVCftuxcf6ev8vOzJPZcjkUOfVH6k8Fq9LsxAYI3r3R64HJnyRR+hmyg2VfyW+tpNELE2lAO+0VxrgcJYiDRl+EdVAE+RfhepsxCr5MEMK4J3kQCg4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(66476007)(38350700002)(66556008)(66946007)(6916009)(316002)(41300700001)(52116002)(6506007)(6512007)(15650500001)(53546011)(36756003)(2906002)(83380400001)(6666004)(5660300002)(26005)(8936002)(8676002)(4326008)(2616005)(31696002)(6486002)(86362001)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1NjdXhQYlk0RE5WMVQwTmhFZDJDdG54cXZoTi9uMUN3c0g4cUZMZ25adnFo?=
 =?utf-8?B?bTJKNUUwRWx1dkE5VHhnd1Z0K084UGxNSlZheEl1R25FcC9pNnZ1MzZTd1Er?=
 =?utf-8?B?NkVBUkpVT0tVUGd5RG9jSGE1LzhLak1UaEhUcm1mMHhLOS9iSXNaWnhxTUs1?=
 =?utf-8?B?aE4rc1BYTDhqYm1ick80ZlIrS0NmU2EzSmxkQVg5dHkwWjFXd2I5UHdnZlVz?=
 =?utf-8?B?VWRwYUdqWklMVXRST0tZd3FraFVzckg2bG16SHB1Yk9rbmhMWjc4a2VYVjRF?=
 =?utf-8?B?SWZrQXR2bk9nWEdpUzYzQzNTYzR2akJqN2RLZEFqMmc2clhFcjJBTlZYT1ND?=
 =?utf-8?B?VG04NXUrTk9hWFE2TThhRUZiWVp6ZTdvQ0FwZ3lTa0hFSGFYNTMxSVg1Rmpj?=
 =?utf-8?B?Ull0TUMwa0ZrR3kvSGNZYXVKdE9ZOCs4QXQrRy9wYVlpTTI1THlvQ29nMmxt?=
 =?utf-8?B?Q0hpeVNpQjNhOTY3R1dYbnRmUVE4dlNWZmF1THJQL0xFZk5Vc2o0cFAxSVVU?=
 =?utf-8?B?V240a3pwMmJWOGlkWTUzSGFTRUFvTU02T0JSdWhyNUZUcmxoeFZOZGw3QnMw?=
 =?utf-8?B?aFN2eVpYbXNIc3VrWHZiZWhqWmNhRm96bk5IU2MxNStrUU40cE9ZZllOY1JB?=
 =?utf-8?B?OXVEZUQ4VmFybmZhakF0UmkzOFBEclFhUE5ScXUwZUlRQTdGUnB0TjVua2pp?=
 =?utf-8?B?eHRaMjdmRWYrZmFQRExrSmZpWFYvR2xHUHhRVktkbEoyOUIrNXhZQ1UwbXdF?=
 =?utf-8?B?Ly9HN0ZQSUNnWUI2YWtrZERsVUJvWjBjQXpBTStDQnUyVFcycURPQlAwb0hR?=
 =?utf-8?B?VXZTeCtoaUpTQk5BbFpEVmV4dkJzK1BBWUUxLzZRUG9ib2RyMHA2cUVjWnZh?=
 =?utf-8?B?elpha1djaFA4djNGb3VLZ2xaOHQ3OWpubWF2MU0xTlR4UkdRS0kvZEprTTdy?=
 =?utf-8?B?YzR3QnV0cGhVZUtDa1RGOTFLQ3V0NGdJODdqdTF4Uk1ETU14cW1ybndNUHRC?=
 =?utf-8?B?TXMzd1U1R2hNUHBxS0xZdjRlaUtWK3pJUG1qNGFTcWs3M3E4NmF0MStxQWJH?=
 =?utf-8?B?Tk1DaDM4NlVNakJicjgyVitKakVUWXpHOU1aRE95QVZzNFVJcGtTOEU5M1Fw?=
 =?utf-8?B?RzNGWUxYeEZSb04xZTBlUU9zYVRpS3RVN1BhTjBHUXBDckJJL1V1Y1RxT1Zo?=
 =?utf-8?B?R0V1M0E0SnQ4M2pHU2p6dXJuL0M5OWYwcXRPQXExY2VwemsrZ3VYNWRRMHVW?=
 =?utf-8?B?TnhDaXN3SU1BZmxGaG1xMkVvRXV2aUI1U1ZBR3lVdzlCaXFubzBNelVhS3lO?=
 =?utf-8?B?ZE5TdUJpUUhDWC9VK1RJaE13clRFT2hNR2FLaktWdmpZNm9wWTJnSHBpUzBZ?=
 =?utf-8?B?MXRWZ3JncmtaQk55YUpzU1dpdjc1ME1ueGlIaG80cjdjZW1BUGFNdkc4SzY2?=
 =?utf-8?B?dUIwMmRTVWdjdlFRMTVmVStUNmtBV0dYaHg2cXdlbkNCL2NEcFlkYlBCaW9n?=
 =?utf-8?B?R2tIZ09GdlJiMmhFc0ZNaXdqQUp5UXV0cmoxV0xyREJlWFl1aWRBOVFDT2Nv?=
 =?utf-8?B?ajJpL1BlaE84Q3d4TjVmUFZmYzh1WXlaL3g1SjQxUGNKQU9RcWVYMlh5MlQy?=
 =?utf-8?B?eHd5TE8rMnBYK3p5dFNNV3lab3I3bG10R3lmWFBMajJOMEhCYWh5L1hLbE42?=
 =?utf-8?B?Sk5qOXZxaVZZa1YzQXdDSlNyM1lnU2tJS3JPblJXSi9HUXhEdTBmQmNnbjFi?=
 =?utf-8?B?VngrWGQzbyttdHVES0RYSExObU9meklETHhhMVd3ZzZpY0JIendudnRvWFBI?=
 =?utf-8?B?VG96cEU4SWZYclZGTDdWK0NSUXpXQkhpNGRveEZoSTRYMWk0bFFidmRyYTFV?=
 =?utf-8?B?WVM1UWZTdDFjZmlKRTVRTWM3MEQrZThDYzErL0pZamRwMDh6VXlNQXAwRVZa?=
 =?utf-8?B?MFRjOHV5ZE4zYWxxSFZ5VDZZVWkwM05oMmIvN1FxUEdERkpOeG5BUlgySGtP?=
 =?utf-8?B?TktmaStkZHZZTWViT1hVWThsSnRUUTBsSG03N3c1eE1vc1ZudFJvNkk4bUdk?=
 =?utf-8?B?aGdCcUw2Q2I5RnZMVGNFUUNwNFZkQUEzNVV6dUV0WHAveGxXc1l0ZG5hT2F1?=
 =?utf-8?Q?nMV44YLtzRBptTpAZ0t933XNR?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cf5914-d70b-43cb-6cce-08dbc492754f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 04:29:11.8773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpcjngHZe8LSaf3UEEtivyABwejFqQv/J8QR1uWXn6PrDZ7yj/9K6ovDbHkMBkZSOYdC0IKcRTwZDP8Y+jFWiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7293
X-Proofpoint-GUID: EOgpFxsyAiS7-PKu44dRdV63YO4VBV1_
X-Proofpoint-ORIG-GUID: EOgpFxsyAiS7-PKu44dRdV63YO4VBV1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/10/23 6:14 pm, Juan Quintela wrote:
> Tejus GK <tejus.gk@nutanix.com> wrote:
>> A few code paths exist in the source code,where a migration is
>> marked as failed via MIGRATION_STATUS_FAILED, but the failure happens
>> outside	of migration.c
>>
>> In such	cases, an error_report() call is made, however the current
>> MigrationState is never	updated	with the error description, and	hence
>> clients	like libvirt never know	the actual reason for the failure.
>>
>> This patch covers such cases outside of	migration.c and	updates	the
>> error description at the appropriate places.
>>
>> Acked-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> Queued.
Thanks, will be sending out a patch with the "Reviewed by" trailer added.
> 
> But I wonder.
> 
>> index 1f65294bf4..60eec7c31f 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -979,6 +979,8 @@ static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
>>   static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
>>   {
>>       int ret;
>> +    Error *local_err = NULL;
>> +    MigrationState *s = migrate_get_current();
>>   
>>       if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
>>           return 0;
>> @@ -1002,6 +1004,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
>>       } else {
>>           ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc, &local_err);
>>           if (ret) {
>> +            migrate_set_error(s, local_err);
>> +            error_report_err(local_err);
> 
> We are setting the error and reporting it.
> 
>>               return ret;
>>           }
>>       }
>> @@ -1068,10 +1072,14 @@ void qemu_savevm_send_open_return_path(QEMUFile *f)
>>   int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
>>   {
>>       uint32_t tmp;
>> +    MigrationState *ms = migrate_get_current();
>> +    Error *local_err = NULL;
>>   
>>       if (len > MAX_VM_CMD_PACKAGED_SIZE) {
>> -        error_report("%s: Unreasonably large packaged state: %zu",
>> +        error_setg(&local_err, "%s: Unreasonably large packaged state: %zu",
>>                        __func__, len);
>> +        migrate_set_error(ms, local_err);
>> +        error_report_err(local_err);
> 
> Again we set the error and we report it.
> 
>>           return -1;
>>       }
>>   
>> @@ -1499,8 +1507,11 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>>            * bdrv_activate_all() on the other end won't fail. */
>>           ret = bdrv_inactivate_all();
>>           if (ret) {
>> -            error_report("%s: bdrv_inactivate_all() failed (%d)",
>> -                         __func__, ret);
>> +            Error *local_err = NULL;
>> +            error_setg(&local_err, "%s: bdrv_inactivate_all() failed (%d)",
>> +                       __func__, ret);
>> +            migrate_set_error(ms, local_err);
>> +            error_report_err(local_err);
> 
> Again.
> 
>>               qemu_file_set_error(f, ret);
> 
> And we still have qemu_file_set_error() here, ouch.
> 
>>               return ret;
>>           }
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index dd9c76dbeb..4cde30bf2d 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -14,6 +14,7 @@
>>   #include "migration.h"
>>   #include "migration/vmstate.h"
>>   #include "savevm.h"
>> +#include "qapi/error.h"
>>   #include "qapi/qmp/json-writer.h"
>>   #include "qemu-file.h"
>>   #include "qemu/bitops.h"
>> @@ -336,7 +337,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>           ret = vmsd->pre_save(opaque);
>>           trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>>           if (ret) {
>> -            error_report("pre-save failed: %s", vmsd->name);
>> +            error_setg(errp, "pre-save failed: %s", vmsd->name);
> 
> Here we only set the error
> 
>>               return ret;
>>           }
>>       }
>> @@ -389,8 +390,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>                                        vmdesc_loop);
>>                   }
>>                   if (ret) {
>> -                    error_report("Save of field %s/%s failed",
>> -                                 vmsd->name, field->name);
>> +                    error_setg(errp, "Save of field %s/%s failed",
>> +                                vmsd->name, field->name);
> 
> Same here.
You're right, I'm only setting it here and reporting it eventually in 
savevm.c. The trivial solution for this would have been directly doing a 
migrate_set_error() here, but that ended up breaking the build for the 
unit test test-vmstate.c
> 
>>                       if (vmsd->post_save) {
>>                           vmsd->post_save(opaque);
>>                       }
> 
> 
> So, I am wondering if it could be better to just report the error in a
> single place for migration, and set it whenever we need it?
Yes, that would be very convenient, for all the errors to be reported in 
lets say migration.c. Though that'd also require all the subsystems 
under migration.c to properly propagate the errors.
> 
> That is independent of this patch, though.
> 
> Later, Juan.
> 

regards,
tejus


