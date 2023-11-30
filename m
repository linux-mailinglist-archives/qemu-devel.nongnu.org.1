Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 323AA7FECD3
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 11:21:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8eA3-0001fW-ST; Thu, 30 Nov 2023 05:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r8eA2-0001fO-5N
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 05:20:46 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r8eA0-0002Gy-0R
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 05:20:45 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3AU6c6cB004364
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 02:20:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=kDZw6uDpZLh8jkzkHeVKCHx5kUOI6aR6T7VUVGfL1
 Aw=; b=ZbW4WCZsGwOkFS7OigfO19o3ugTYkpm22WhkWprXodo7jy7vKh/BhiSrZ
 IS3sjGcG1G6OCFsbRn40nTZijFIc2xPKVBsu5ppiWUTFcs9AOF/Yp2UfNVR93bF1
 sgyMUGebmGDFPHrQhsEtvWo3ECPpwYfW4Foc5PcdtcU8pDFGUkxfVk2oyuXgBzBb
 jX4epsHjqAVd30OU36b1yKDnnHC5ROKpX1HHvcd0tBd8GnD6dU0POdCnt76AyH0h
 n3eH830Xa7j4GBbm1IjzlAo+EM6APMazzZkdUqqdNtyNI8Fa+XHYYMz7vUcmwJOI
 a0WePIwcajd2ZWn/HKxQhNuRXZfEA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3unvf6k5k4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 02:20:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zo12dn+kyNgF0MI6uSZGDJgQcgBnbKoNDAmsSV7O6AwwsA5iltxFHXhf9aZckysCQwtQTM+N+rmmyiQ+vSFWjQeHIVrI5Yo4iv+XsG43nDfLLQHUxRwChu1H+9DG6v/p//nETuYHOhh2GadV8yY085ttCZoAZUry/eNKQNS5gbiejFd5eG9rVrJfigahqUfYMcEEItGXjeWTfsBwrDyPUI1zpKYHyBWZYjL/mvQa7V/ChrL2yR8mtoike1El5RSFeUMlbC1Q3gQt+Xj5LQUTJoKcHFsyQcedx5QZVOYCfkODZUgJyihOs3q+QvIpmNFBhuWfecFVQiSK2RZqbOE2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDZw6uDpZLh8jkzkHeVKCHx5kUOI6aR6T7VUVGfL1Aw=;
 b=BDrbtebIT+x412A9NmqO3TsiPMTNCExpOMniU7XJsqYwNrwujGqekFoB0kYURT0cdhwg3+5c3AgMhds9npjROoVgCJViNk8paY1ugFZ1LPSFPLa60PYQOrpGAkeaY9EUlSNLTuzlTWbuOqf/EqwYeux3ffU6Ep+4B/SGl/qgxsbZlm4SsSTxQT1RWXKw61sW6n0SzsVhIvpWR9OFyZ6OE5tmw2zn70K+ZPILUQBz31ydQt5yYM9PrsdKz2zb0G0jVmRJdObb+jV+nfMq3gHHSFeRnykTDw9EkNeypnQAyXDdPibmpDVexzjd7ybZa0BZBiMm2zi1Q8Ch0HijUftgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDZw6uDpZLh8jkzkHeVKCHx5kUOI6aR6T7VUVGfL1Aw=;
 b=QtyXLxO+Cq+NInC8HKY5p43DKe9RE1zDRsn/j0QHVwemV3pxAsRXN4fZXJhbPULfDULRJnU5DhrTbI1KFchnh0wVAbtGWcyKhYmGq6xSi2agg4R0jbO0+pGV1k/R+JZjmGlPXdHmBgnZDrzHNhX0E0V4lU2D+qvgG2WA1Djdzy8jUkL3QSlDD2arWTCyygpavseB7MNVRQIcBpgdIzvmURv7G87u3CCTQsp8urZBReDUQeKmie4C26qqtYkaPNt/v/vjTr4xHOS0Jy5wAlaTeUmYhZttWvD3GqHUxO1hSk9XsFiRPrXRQZUPa5a9+zObAL0NiI8xjkTlSN3AcAVgAw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ0PR02MB7199.namprd02.prod.outlook.com (2603:10b6:a03:294::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 10:20:36 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 10:20:35 +0000
Message-ID: <aa580a1c-851b-45f7-8b0a-27b555c7bf91@nutanix.com>
Date: Thu, 30 Nov 2023 15:50:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] migration: free 'saddr' since be no longer used
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <ZVdw_XMJ4mKMFejd@x1n>
 <20231120031428.908295-1-zhouzongmin@kylinos.cn> <ZVtmn0WXTKPxCbKU@x1n>
 <7b1c8be9-788a-4cf1-aa6a-ad8f718d7118@kylinos.cn> <ZWdO_C51ckWT0bdK@x1n>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZWdO_C51ckWT0bdK@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::24) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ0PR02MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a8ccc1-8f4f-4db3-77ff-08dbf18dfd98
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4bqaHYMi711sAJYePD8TMQ6VSFAnrj+G1LsDpV/WVtBUSZf1iwedmXQ5SYGBVFI0jiK8OUzRlgeFmRxzXHyIyZjrQVew68GY/unQCrGnu6e3ky3rs6Ex6EpFn2glmAZAhLyw4N0dy1lK28Z4OAnrojFsaIp8Casa2c5XlGreUGFMx3jk4821qDI7fNJ3kOVRYZfo9tYtb6zsRSAlgxsMJE8zMCdmhqYDol9XaYQAbHZAlnxBp0yahkIAQks6LQdHscWy93OeMVKX9TndItn5Q+C/+ZA5VVf+8ar/3oKs1lFscAR9lwS5WsbFjBkTpqvf1XHILy3ZRMhskgVh9ZgCh8Eo5fyRtfs8AFuAv1RcoXixoXVIi19uKjczmd8/KdNgCeI7gKBcyUBtCzsrVUq5vEvR3OYfIbv+iXoCto9fXeybRfYUldXRt269a2wja5GmzCnOUAD/2JZqgQyuuRiaa+J+4oycZgdam8KRM20zWLWibwvP+TDUg4gvmdSIzXkCM3cADTna14Q6xZOfsYzX2Jx8L/AwFSqqUgaDi1YmCvMt1X+/Sx2mjhSeF8++qnBemwxlwC4k4JJfKCU/V3ouUzxwiB70HafCCe5GfQgUwF0WvwtWsw4ojYtzwfaZuPtXOMfhVaiswSGtIbUue1t5Q9gEuPo+2Dq+X8bbF3LsLF5dJuefdME4D6rtQxA4T4D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6506007)(26005)(6666004)(53546011)(2616005)(6512007)(44832011)(5660300002)(8676002)(8936002)(41300700001)(4744005)(478600001)(2906002)(966005)(6486002)(316002)(6916009)(66476007)(66556008)(66946007)(202311291699003)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0JEWU1NL0JEZ3p5ODV0TG1xWnZFbHNYU0Qzcm1zNCt0VTBrRXV4dE5veTJ5?=
 =?utf-8?B?UXkvRlBlMUdYOVkrVnNOOXlVOXBGV1JPSWhqend0U0s1OU9yU2txZVl5YlBD?=
 =?utf-8?B?VVl4SUwrV0pIbEdsRndPRDB2WjZwRElHZlhvRzF5RnVOVzFOSVlGK0lpc0Fj?=
 =?utf-8?B?Q3lteG1UcWNCK0NWN1ZFNjhsdXRHb2o1VDNwKzRINWVsV1MyNzZWd1BtMUdl?=
 =?utf-8?B?UDMzTm5aRjAxSXJWUVlCU0ZDd0JrVUg0L05oQ2dhZlBEODRUWWRoMy9jWFVJ?=
 =?utf-8?B?U1BBb2pBZVBqYVBxTDI0R0xPYWN0MXJKZ2w2aEhNdWN2VnFyeTZFNFlQRkFR?=
 =?utf-8?B?TjZ2QnZBRSt2ckxEK2hmZE5FVGphb0g2MStuYjFIbUNwbVVrNzI1SVJvUzJ2?=
 =?utf-8?B?ZHlRN2FEQ0tCU0x3WGpIeUt5QjBJd1ZnclR3SlJRVWFyS0FOdUliNkVsdVdv?=
 =?utf-8?B?KzR5Z3UzQTFjdjByaEo4cmZYMVVhdHNCSGNaSVNMdFhMWGgwRGFhdVhWVWJz?=
 =?utf-8?B?UkthajlLMGQ5QVM4UnBISjdxYVVOVWNOYlFiTjlZUE1LS0g5ZHdocnY2TEJL?=
 =?utf-8?B?NW42eElLMlloS0NCMlNLelFscitHTklnZ3kzWXdFby9MelFta3hEc21iaGUy?=
 =?utf-8?B?ZzFOQklTUjIrUXNVL1pjeWxrTzBVSVNwY1dkZmkwM0EyUkYrenc1Rm4zSi9L?=
 =?utf-8?B?QUpSampacmlFdXVBNWlOMjVsUndIblZjZW0zc3FoNW9DQm5jOTlYUVl1Nzcv?=
 =?utf-8?B?eVhqVGIyNTRXQkVSYk5md1A3cklOMGVWQXFvNnI2SFd6QW0vUkFoWkJtNWxw?=
 =?utf-8?B?TTJqTVpkY1VWUjkxeVUwUGZvTFNPS1p4UWQxUTQyYTZEOStMT0tVWmtmeUNY?=
 =?utf-8?B?eXAyRm1RZGc1ZU4wSEtVSU1RWElvVEtFSG5RK1dlRTlGUHZLZTQ3WUdMTms0?=
 =?utf-8?B?cVBzeW9jM0ZPK3ZvZXQwcktzYWVWOWEyWkVLVkxtWUYwYUd4Y2I2KzVNbUND?=
 =?utf-8?B?UDUwdnpzaFh2NGFwcHgyYi9BZmRydGV3VkplNmQrcS9uNVFOWUM3VWhqVUVV?=
 =?utf-8?B?UnhnczVHWVN0YjBRVVdnb2tBSGNEVm1YVDRmS0JOZ3ZQTlZveTlkbjNsMlda?=
 =?utf-8?B?ZWdvbEVaRkNkV3R3UlUyd3llY0JmTGtKb2VwTC80eW9SZDQ2cU16K3V4RkdO?=
 =?utf-8?B?QXdOZkZHNEhOQ2FoZnN5TG96QXdoY1YyT2pLck5wMnhERjFzcEc1bWlVaGRq?=
 =?utf-8?B?V1FpaTQ0ZVowb0RMTGJFQlRKMXJyWENQWndtRnZTUlp3a3kyWGZndE5iN3Zh?=
 =?utf-8?B?NUZDc1d4STl5ZnlOTnlEL1JTaHVIekhDc0Y5enZWTTU3UjJYOE5lR0FucC8r?=
 =?utf-8?B?bVdzL0xmNWVtR2pWZG92WGk2N0R4M08rWTExWWV2c0U5OHFEdTQ0SU1qbW42?=
 =?utf-8?B?K1BER2IrdnRWR1RZaWVHVWc3Wjh2RytBWEVtekVoQjZzVU1jWGNSSXlZVzlM?=
 =?utf-8?B?NW03VS9SSHN3QkVrdDFETWQxYU4yc3Rodmt4WlFxbkVNcGtlUWw4ZWZSb3hn?=
 =?utf-8?B?SC9qdzJtelBVbHVlVHBDRGlwNzZjWk1LYTJtb052U0lpY2dCQ29uTFFkcUpz?=
 =?utf-8?B?czFFSjJJc3djOXZuQkFZNm1hb0dsWnpuT3VyY2VTblpiZDkxNjlUa1VPR3h5?=
 =?utf-8?B?RjNkT05ySVZoaUNxSVQ2VTZJUTZiNXhKNFlHTDhmN2t3Rmw4MEo5NGZRaU11?=
 =?utf-8?B?WFVqUDRaUE9GTVR4UXA4RytGeEtTSjdHd2VNUjMvMHMrUGhzMXI0bnZMTTlv?=
 =?utf-8?B?aTlUMDFxalFLUGRaLzRIRk9GbC90OVIzbWRqcE11ZjBMQ0diamkwTHlraEU3?=
 =?utf-8?B?YmxUSUxPRW9kQUw4OW5la09mNVdMY0FqbmxoaDRJK2tUa0lGVk55M0ZsUWk1?=
 =?utf-8?B?cGVXNU5va1pwZEhjcXhLY2h1SS9pbHgyUGZCWGgrVmVma25FNExYaFZYbU1L?=
 =?utf-8?B?clFxMEttRmxNeVNKM0hoTGY3NTVZL0Z5NlJ5bDc4eWZvMnpIbmttNFpKY0NM?=
 =?utf-8?B?RTR5ZkppKy9PQzREakhURUE2VGZoa01GRHlhNHc0WmJiMTNiU2RCU3E0RnVN?=
 =?utf-8?Q?wuph+znyTCTCUdM+chbz/vphV?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a8ccc1-8f4f-4db3-77ff-08dbf18dfd98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 10:20:35.4024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLKTpfQx27tbaTV42xl1sov8V1iDklSkJlP8nW8iuXDC7+szCmcwuMEyuUqcZmURtLxsx/xUFiiZdAaMU/7AXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7199
X-Proofpoint-ORIG-GUID: ftVYR4f5aPFP0c4OGJe8YqE-Ytxll3DT
X-Proofpoint-GUID: ftVYR4f5aPFP0c4OGJe8YqE-Ytxll3DT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 29/11/23 8:17 pm, Peter Xu wrote:

> On Wed, Nov 29, 2023 at 10:09:12AM +0800, Zongmin Zhou wrote:
>> Ping? Has this been forgotten?
> Juan,
>
> Would you send a pull to include this?
>
> Thanks!
>
Peter, Juan - Could you also pull a similar patch related to memory leak 
together, it has been tested and reviewed by Markus already. ref - 
https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg05948.htm. TIA !

Regards,
Het Gala

