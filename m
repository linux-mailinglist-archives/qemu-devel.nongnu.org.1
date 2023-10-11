Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D67C558B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZLv-0000j7-No; Wed, 11 Oct 2023 09:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqZLs-0000Xe-Fg
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:34:16 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqZLh-0007TR-7R
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:34:16 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39B3etms009487; Wed, 11 Oct 2023 06:34:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=FNvsUFwL6tfl
 ikNvCB7+zXcs8GNGmH+vC1opXvLXGDU=; b=rofoeCAlFZA5Ol4gXU/WuYA5KZjz
 Kp2pmYapM+UH0DgqqkGHwTOvs5JL5xOFxMpP8nXWybR/g21aDUQnNN2fD7ozZ9lh
 SRvFXLJk6YgVdNq6KTd3IdAYACuAOytuYqsRGYKymhtHukduzYHOxK1D1EPQBXlX
 tyhFN2MEBzvdNytsXjjs77mqjL08ZxPFeFOFiUN07SmnTWAl9JQvmITPhNQ/EZJJ
 K9pdF1he39PA1XdTDhnal4z42/PRQTt7seEJwon5MTKPk19PQg0hEBPAaJttj06X
 ZC49k+/pSgTI4kjzHHCRPwWS/0bISl0wwLf8HtVtj2Pig9xYBXSQHWBbtw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhtvdutp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 06:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJc8cvztvdyG0h/aTnbEjzqwEXRlNZVgcqONDDGcUnOnLWPthpX76Y+6AfbOC6vcozaM7vbYANlSJhPCmVv02GZgyQdfM5XwyadISRF5CBCoWPNUwr9T8lVJ+U8xwOAOhAQurw6541GRokjlzV9f8sPlC9IGyVw9JURI/6yJjKhPVqcCM5HpA2EnW9fLmTsfRmqjfMTD9rDIBcQ5cwS3P1y8GIGG9MM/cSoMrkjnachk9C3WF1PdYNyh6n9x7ggfC19veczSyfzj9sjwb2hTOvlYUV0AwBEyEms5m8Pf3mBn9Gs0xEMq2RYyT5EQp0SEBevk+rpCz7nPT3NQ37+Vmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNvsUFwL6tflikNvCB7+zXcs8GNGmH+vC1opXvLXGDU=;
 b=m4C3RYj5fg4vCM/oAZoVTYA6HzrHoHfx4k5zOZZBhLO66UnVQH6AgPia0roV8i6SnldovovOBjHg/suFVA2VRKw4BNsjYbjn4GO6smwZf3Ubp0PoIk9vFzzSct7EJvueQkFo0YKu/lH9XMXeenAb76Jh47dmCi/pIGideD1uifAWmmGKcISKisn9dEoTcI1nw0j684p+OceZhRCypzGR3Mie6QvtrlvcgpI7eJG3ocBPySz6mrarfTKaC+g78UIwfFF9JQxvo7F3DydQytkkZilKZD63xgaILWDxLr9HN6QpRZ4cNCOV3rJRt22yoXndXdlBISyhHuB+yqBI4VFikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNvsUFwL6tflikNvCB7+zXcs8GNGmH+vC1opXvLXGDU=;
 b=RUA+Zta0Lwb/u9MrPYJHOoH9h3ZZh8ERGcM74D0K5yuAVntd2QjnKLul2Fymk3GVz2fM0O25qTcxzCYjaWhvk5jOVrO7OjtFyWHEiymIo1LHD8mUAX1fSqfDVl+ia86jpnkMrUQQqVNLEB/Mg3zTEgq+Y9RsDMMvT91LwUkIQLMWxxbq3SaDPUroRIYEAWYiBEI9D7S+/GnNwm8U7nI/uOeMiv3gT1R/brqguzOJC52ST5eY8moEEVGX56m/FMvmzJq7kLiHE0xLF0rrYnYzNoX013oIfXrepbhD1rgO+byjSj9gWWHNGipEBw/7zHvI04Cojuo7G2nxuEThUg0VwA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SA1PR02MB9889.namprd02.prod.outlook.com (2603:10b6:806:38d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 13:34:00 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 13:34:00 +0000
Content-Type: multipart/alternative;
 boundary="------------r4ZlUUruLAgS0TVylOAPFTOq"
Message-ID: <21a8e6d7-5271-4ed4-a79f-d40c3dd7fe31@nutanix.com>
Date: Wed, 11 Oct 2023 19:03:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231009143615.86825-1-het.gala@nutanix.com>
 <20231009143615.86825-10-het.gala@nutanix.com> <87ttqzjygg.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87ttqzjygg.fsf@suse.de>
X-ClientProxiedBy: BY5PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::40) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SA1PR02MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: c565ad4b-a48f-44ba-2ef5-08dbca5eba08
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spLUsZgnuP7mpqUVEpkdpujN044ThehXjCvaHCIz2PDeBERnO2bcxMN2TtrOoNC+IEgttvVh9nHc4GbXWZ+wZGstwy3h7N6KkceY7Mh2gDDiZ4Tn2VYJRbEwRFKuOBTEQ2fKsVAVKxg6LOO0FM61IRs7rNkr4nHIj13dNpaSBHX90xB19VIJ1e7bJ/3dcZrbwnUO3/3MdMBFbPXnLnVpMBY9Ero+/Ms4NNzBDneBLI8K3/YT5oAbWhuqQuCBMWk9g/B2gjT11iK/WSVDm+5VeEwzdR3Egt9xAb5ABERY062w+auQxjuS1yLtETCwYbOqB6aWog8TnElKTZWbJDJISAsn9kDRZvMk1VC5LARCWU6aC/qTTRAYRI/C434N6sSl+QePAr7IIu69lkEHUwsAgjkoUs1SSo4EpXuUhBDSSs76KEfENMxMee5gqwp8Ztwy5//JuriRmVNL7A9XZHPvCSTqN5cMNwdfcOgc2XVSGFq4uz/bnGXodOiU0Rz4jpcyshtKKQAUXW3fqvDRn1W0TEdV0s4RXCDdt6aeKmMhG3epNzQjIU1VeN+Z/1cP2R7VNHa9yZ8nmom3XHlDu0N9QD0jT6QjQF4wwUfPZp0Uod6XU+K9wZH+A/hNqC+hyuKI7FL1lmxg8FuozPG+T6rdg2TKWMSMipTNXeKeFliIjxQr/8IxwD+ZYYrPj2YFAjpv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(83380400001)(33964004)(6506007)(86362001)(31696002)(36756003)(53546011)(6512007)(2906002)(6486002)(44832011)(41300700001)(5660300002)(478600001)(31686004)(38100700002)(26005)(2616005)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(107886003)(316002)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjFPUUp2WHFhQ3QyUFpLNm1rN2hNb1licHhLQk9NcXpaeDdxVlpqSHdKeVBl?=
 =?utf-8?B?SlRWQTZrWFV3Qk1BSjRCWXlHZU5yNmRqNUhUckdpRkpGTzNkdCtIY0hEcmcy?=
 =?utf-8?B?L1FvdG9pK2pIWDU2VXlVTDdBb1lFWVhZakhuNmR4WVZpcFdyeTFsVm5xaGZ2?=
 =?utf-8?B?RE9QU0ZoZGpnQXdXV3lOSXhWZmp2WE1YUVdON2lBMGg0VnVZUHA3bEhhVVNU?=
 =?utf-8?B?cHNFaUN3cUJiRDROZnBaTWQ5VE1acG5qVWIyRlNWZEhuZzNkUjZzMmQvMnNW?=
 =?utf-8?B?azBIWHhxVlh1U25MZldnWTRmNGtPL1UrK3pnK3BMa1VZNUtFdkJlRzg5SGlG?=
 =?utf-8?B?QjVDejcwa05mTFpSYjRLdzMwbWJ0MjBScko0UVpVMzltei9lVGNUT2NFMW9t?=
 =?utf-8?B?UnN0V1hDTWtDS3RPQUN4a3dOQm9jYzAySGZZM0ppaTN2bzZUTVpsVVZqUFVL?=
 =?utf-8?B?Ym5RajdoUE05T3RQRERQbWJZV1ZhbHhBanJ6K2NxbGVBMDdpbmcvOXV0dWZ1?=
 =?utf-8?B?TUpONVB6Q2VEN2ZwTjlYL09yWVpMYUt6aEFIUmdTNnJJdWNnZXIyVTBMOTdL?=
 =?utf-8?B?dUtjMThiSWRES1RIQzVZQlEwUU5UUTdKWWhCamZqQWZYTEN2ajVPNXN1b3B1?=
 =?utf-8?B?bVZNbjdPQXdKaWZWdU5IMVFiaHo2dVIwWHR2MzV6MnFaTE5KWkNOZW9uWXVP?=
 =?utf-8?B?R2d0TGI0dnVaV3YwUFR5NjRUZmxzcW9jT3JLUURsV29xSUZIUGFiSHB1WUZn?=
 =?utf-8?B?QWpqUmVNQml5cUJHcE5aRlZpajZyc1ZycGk0R0ZSeVZ0VWg1azA3SHBBdVBV?=
 =?utf-8?B?WlhiUFRpdDRYNy9RUnZTcm5LMWpVRGprdlQzb3FVNTJRWE9oMytLU2w5K2lH?=
 =?utf-8?B?MThDL2lvWmZhS0hwWEtFMG9DWUFVRys0OVZta0lFMXNqbTlUcks2U3ZZa2w2?=
 =?utf-8?B?OGsyZXZzczh3YStBdnNMeWFIL0lReXhRTlNsMWR4TFVWRWFyOTFNd2t3Uk9T?=
 =?utf-8?B?WDJwV2pNak1VSEhtYVBhamFLS0hLVXZJWTVYa2JwZ3Y2eHhxY29zZ1llaXY4?=
 =?utf-8?B?Ulg4ZDBONTdhT2VUUWNBUXNkU29BSTZPSGxkNktma1U3TEFaTHJrVE50RUti?=
 =?utf-8?B?emRWckJXaGh3eUd2S2UyM2ZtOExoMFhBV3dnaGU0T0x0MHlzLzJsbnZTcS9I?=
 =?utf-8?B?MkNVbnhoaU53Vk1TOEt2WFVLYjZkUmEzMTJWbk5McWdOdmY3WTQrTW9Hd0dq?=
 =?utf-8?B?QmZnUG5aYklhdFNNV201YTBOaDFKcnNhc25wemVRZk9pQlAybGhVS3dJQWtW?=
 =?utf-8?B?K1NwRjJUSFRpY2NJOGVMMGQ2eDdpVitySjltL2xpRWhMRWQzMm9lWml2bnpk?=
 =?utf-8?B?Q29yQWhHZ0dubmtyMHBGN0JoUnBHNTI2eCsvSE5VNHRJeklVOXMzMVJ0MWgv?=
 =?utf-8?B?Z2x1STNLVVdYbWpnTFRaOGNIY0JPdlVld0xYNUE1Mk1FQzU0eXhWaURzOHNa?=
 =?utf-8?B?RW5CVE52dmpoSG5kN1AyMmtlcnZ2QVYreUd5MVl5a1RaOVh5OWdaT0ZhTHRN?=
 =?utf-8?B?VndoZTE0K2VJbkNuem9KTVRSNmlHeUtjK3dWdVk1UzFUWG5nZVF1c0Eydlpy?=
 =?utf-8?B?NVlTV05nMWZ0d2toRXVHUThZcTZzL2FUR2V1SXkwQVhEUUZYY0hVbXY0WlJE?=
 =?utf-8?B?dDAyT0o2dVk5RjB4RTVBS01pZENVT0JwZXdaWjE2NnhmZWVrWVRySFNGbGEy?=
 =?utf-8?B?ZFU1eUZOTWVHcnIrZFRJaDlQeFo3WmVSancvM3d3NEIxT1JjRndrMTNwazgv?=
 =?utf-8?B?M0hTL3ErdFRML1ZLc3E5dnRCSnN5MzFjNjl5ZFhEUVo0N2Z5amVLYUJ4azRy?=
 =?utf-8?B?N3ZUWmNkVktuMXhsdktmcFExTXNSVW5Fa0F0R3V0cGl1cTJBTFhERndYd0Vk?=
 =?utf-8?B?M25jS2kyZTEvWXBwY0Vvem1iaGh5UkpvYUdoTWxnc0RJaDhPSjgxVWRSQ3Fp?=
 =?utf-8?B?NXUwbEsrMGRmQlVrK0RWa3lBa2lPdHZobiswdlNOQWVaN1A2bTg4bUlEQzds?=
 =?utf-8?B?b3NmMG9xM1VaejFIcWIxNkIvY0lROUhJRFhCeUI3Z1JHL0FIV2loN3hlOEtN?=
 =?utf-8?Q?Iuwqxs+HJaMBoTdQRbVTyUWFw?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c565ad4b-a48f-44ba-2ef5-08dbca5eba08
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:34:00.1258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1THBqbrBzbTii3DRh9fw2lyilg52qEtbRqgNyNAawRQTe6bAw12FkoAFTScruOtjAjsg+MxuIIxamLImuE5JPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9889
X-Proofpoint-GUID: IkK_PsBT-QVOOVgu9kzjp9PProE6Zj85
X-Proofpoint-ORIG-GUID: IkK_PsBT-QVOOVgu9kzjp9PProE6Zj85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--------------r4ZlUUruLAgS0TVylOAPFTOq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/2023 2:38 AM, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> Integrate MigrateChannelList with all transport backends
>> (socket, exec and rdma) for both src and dest migration
>> endpoints for hmp migration.
>>
>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> ---
>>   migration/migration-hmp-cmds.c | 15 +++++++++++++--
>>   migration/migration.c          |  5 ++---
>>   migration/migration.h          |  3 ++-
>>   3 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index a2e6a5c51e..21b57f7ed8 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -441,9 +441,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>>   {
>>       Error *err = NULL;
>>       const char *uri = qdict_get_str(qdict, "uri");
>> +    MigrationChannelList *caps = NULL;
>> +    g_autoptr(MigrationChannel) channel = NULL;
> No g_autoptr here because the list code will already free the channel.
Yes, g_autoptr is not needed here. Removing g_autoptr passes all the 
make checks (even -qcow2 181 test)but the return value is not right of 
the hmp_migrate() function.
>>   
>> -    qmp_migrate_incoming(uri, false, NULL, &err);
>> +    migrate_uri_parse(uri, &channel, &err);
> Need to check the return value of this function.
>
> $ (echo "migrate -d unix:") | ./qemu-system-x86_64 -monitor stdio -display none
> QEMU 8.1.50 monitor - type 'help' for more information
> (qemu) migrate -d unix:
> Segmentation fault (core dumped)

Yes, there is something wrong here, expected result should have been :

(qemu) migrate -d unix:
Error: invalid Unix socket address

or

(qemu) migrate -d tcp:12.11.34.142
Error: error parsing address '12.11.34.142'

I am investigating it right now. Will update on it and try to resolve it 
soon.

>> +    QAPI_LIST_PREPEND(caps, channel);
>>   
>> +    qmp_migrate_incoming(NULL, true, caps, &err);
>> +    qapi_free_MigrationChannelList(caps);
>>       hmp_handle_error(mon, err);
>>   }
>>   
>> @@ -730,9 +735,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>       bool resume = qdict_get_try_bool(qdict, "resume", false);
>>       const char *uri = qdict_get_str(qdict, "uri");
>>       Error *err = NULL;
>> +    MigrationChannelList *caps = NULL;
>> +    g_autoptr(MigrationChannel) channel = NULL;
>>   
>> -    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
>> +    migrate_uri_parse(uri, &channel, &err);
>> +    QAPI_LIST_PREPEND(caps, channel);
>> +
>> +    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
>>                    false, false, true, resume, &err);
>> +    qapi_free_MigrationChannelList(caps);
>>       if (hmp_handle_error(mon, err)) {
>>           return;
>>       }
Regards,
Het Gala
--------------r4ZlUUruLAgS0TVylOAPFTOq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 10/10/2023 2:38 AM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87ttqzjygg.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for hmp migration.

Suggested-by: Aravind Retnakaran <a class="moz-txt-link-rfc2396E" href="mailto:aravind.retnakaran@nutanix.com">&lt;aravind.retnakaran@nutanix.com&gt;</a>
Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
---
 migration/migration-hmp-cmds.c | 15 +++++++++++++--
 migration/migration.c          |  5 ++---
 migration/migration.h          |  3 ++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a2e6a5c51e..21b57f7ed8 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -441,9 +441,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, &quot;uri&quot;);
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
No g_autoptr here because the list code will already free the channel.</pre>
    </blockquote>
    Yes, g_autoptr is not needed here. Removing g_autoptr passes all the
    make checks (even -qcow2 181 test)<span style="white-space: pre-wrap"> but the return value is not right of the hmp_migrate() function.
</span>
    <blockquote type="cite" cite="mid:87ttqzjygg.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
-    qmp_migrate_incoming(uri, false, NULL, &amp;err);
+    migrate_uri_parse(uri, &amp;channel, &amp;err);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Need to check the return value of this function.

$ (echo &quot;migrate -d unix:&quot;) | ./qemu-system-x86_64 -monitor stdio -display none
QEMU 8.1.50 monitor - type 'help' for more information
(qemu) migrate -d unix:
Segmentation fault (core dumped)</pre>
    </blockquote>
    <p>Yes, there is something wrong here, expected result should have
      been :</p>
    <p>(qemu) migrate -d unix:<br>
      Error: invalid Unix socket address</p>
    <p>or <br>
    </p>
    <p>(qemu) migrate -d tcp:12.11.34.142<br>
      Error: error parsing address '12.11.34.142'</p>
    <p>I am investigating it right now. Will update on it and try to
      resolve it soon.<span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:87ttqzjygg.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    QAPI_LIST_PREPEND(caps, channel);
 
+    qmp_migrate_incoming(NULL, true, caps, &amp;err);
+    qapi_free_MigrationChannelList(caps);
     hmp_handle_error(mon, err);
 }
 
@@ -730,9 +735,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, &quot;resume&quot;, false);
     const char *uri = qdict_get_str(qdict, &quot;uri&quot;);
     Error *err = NULL;
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
 
-    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
+    migrate_uri_parse(uri, &amp;channel, &amp;err);
+    QAPI_LIST_PREPEND(caps, channel);
+
+    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
                  false, false, true, resume, &amp;err);
+    qapi_free_MigrationChannelList(caps);
     if (hmp_handle_error(mon, err)) {
         return;
     }</pre>
      </blockquote>
    </blockquote>
    Regards,<br>
    Het Gala<span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------r4ZlUUruLAgS0TVylOAPFTOq--

