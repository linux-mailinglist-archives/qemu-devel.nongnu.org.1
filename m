Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BFF82FF8B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 05:24:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPxSS-000806-3Q; Tue, 16 Jan 2024 23:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=174635d8a8=kai.kang@windriver.com>)
 id 1rPxSM-0007zv-EP
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 23:23:14 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=174635d8a8=kai.kang@windriver.com>)
 id 1rPxSK-0000oC-Km
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 23:23:14 -0500
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40H4HCPY000569
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 04:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id:date:subject:to:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 PPS06212021; bh=Bw3QwXhItUsIq6P1I3vivPlCOC5bQxlQobWTl1kkI5A=; b=
 Ia3zMC4gPISallck1cgJcKJ9UES0SgrZtTyv55Y+GpP8N6nxj+l1GVuvzmlrU7rU
 +MoQqwxb+V8dWoI1BeY3x0axcCiT97MeI+0zZTHtsz0JgIw0LDIAmE7+1F5YZyk9
 VCKx4e7ZRAFKeE7n8VVq+ZpSrBbXvJ67Lqutn0Kbh5LMwKzjwMdJb84CF47+tHqx
 ELjtnrlJAFJvJibpZ1X9r2PhGtcymKsnQwUBglUeoU424u3MO6EEc9lk4k3ryVSO
 yRj67tU0G52M+4xHJ9cX1OlE9rBGkBwt52cYZlxMBrBdYAl7CPeo9xp/mtm4qEKe
 l8CEFt7oGVfg9tPV9cMc5A==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vkhg644wh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 04:23:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbAvpoHxYZkj3Or0x1EtpSppCQG75tuBiwHFXe1coGeP7wBb4mTfsW7OJlFg05ZMu2LEXeRIr3BZ+SHkkPgSEVhSUOl01+8wBIscu7lO+U+WMjVO2yIMA6UbYLajfyr75YlK3eQKtdePV5PK4oxERU8Rxzua4VfaqdrHzvpS+LaQ0YZI2EWExHkHeGaFbCpWn6+tXslCPsfWMhfJPWhBKd/rcN/EaJqwKlOu9VtGxr1qcvGI+Z/9T5jLW3+dXGCT5OvaS6FJm5B9Ezt1+wVdWrcw9UbUeNXB3j+lh9hxvbTS7J5l9qZ8QXf2uTUPmG6PRJ+3kRViYp2FMAVgWsO7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bw3QwXhItUsIq6P1I3vivPlCOC5bQxlQobWTl1kkI5A=;
 b=MrxFkR7bgcMwOjIa7HvRW03IeE17CmD3VLOoDL1DO7hTXzgfUhZFUdwTBHL+zGAFk9AEJEQ/+Eh050DizTe2OfvlLu9rirlkPSC33WnmDzO/bl30kcHYfkwSpxWO026oksYVQtAiMM2jmslAPzlOcAx11D36lwcnQUQM0dAUCruSum9rbMLTA07PtPY32rDH7/0q0YGHe6bxZJ3KUztjKT22aY1To4dxF/YhAivLswR3dUY31D579Y+3oz0I4mic4iMvIPh40j4g5ORZs/uw2YBWR7k8olXMV6BvXV1I0k+VdB8BvSgMNdpFKHdxhx6oeIMIBalMksHLSE1w90ouZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) by
 DS0PR11MB8184.namprd11.prod.outlook.com (2603:10b6:8:160::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.17; Wed, 17 Jan 2024 04:23:06 +0000
Received: from DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::dca9:26e2:b46:2372]) by DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::dca9:26e2:b46:2372%3]) with mapi id 15.20.7181.022; Wed, 17 Jan 2024
 04:23:05 +0000
Message-ID: <ada226b3-c7e4-bf73-ea48-9a0e1699ef7f@windriver.com>
Date: Wed, 17 Jan 2024 12:23:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] qdev: not add devices to bus in reverse order
To: qemu-devel@nongnu.org
References: <20240109095222.1420182-1-kai.kang@windriver.com>
Content-Language: en-US
From: Kai <kai.kang@windriver.com>
In-Reply-To: <20240109095222.1420182-1-kai.kang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0158.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::9) To DS7PR11MB6064.namprd11.prod.outlook.com
 (2603:10b6:8:77::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6064:EE_|DS0PR11MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d90199e-dc49-4ab5-3418-08dc17140058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jKDBRuvU5QFaoWBWBa4qnqUfJcxCOoJh5sSIlgbPRdLs+eRrQwI56pwIJVSeDdjTif4+ryajMeu8Icfd2ZEIau0q22002C7Hl5FQYzfLeBwzpaFC8zYfjPPJ3hIsGUhhVYa90RkOly7y2Xkmw7VZmQjR/ihztIgNNvHFN4iFYiRHs4I0pq2HG1quA/PGadEu3NhetqY4FqI/AeIWWSISmWnNwRljuMjrOO7nF7GGDUYRGZijm0BM5ecIT1oYIM5J2ueug+41JjI/E30cMbWSe0ELQNx0ED36QdZrDcTXg1hBrEEcx0HBzRfPuJ/t1iDL76rBe7r3zg4pnyJgf5WlRCkehjA4eef8BaAtMtfnycnUnY9bdPPQ5GDAZTdoYWXvjJ5th+DiGAqxhjTuscy9sZqpCodz2dWtmYEKL/O40pGaW5/C3gLEsPsBtV3adJSZ3rNu7ebLSvnRBWVyUWa4JnHSzgWvBoi1LT4YWSyKKDCSWASG62CyiZWn4B4wK/DGL9iNwEZsbaD6U9SCexE55GjCPdAqJItGV/sOmnLNHltRUYfSPrm6U72WYa9VB5JBNT7U5bmKc5KAqVWQJuK/LxXbND46eU9nyZQUaIS30EosMGiUwzBBzbffpbzy6k/xmUdk1shdNTWr8H93cNC3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB6064.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39850400004)(376002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(5660300002)(38100700002)(6916009)(66556008)(66476007)(8936002)(316002)(66946007)(8676002)(6486002)(31696002)(86362001)(6512007)(53546011)(478600001)(2616005)(6506007)(41300700001)(2906002)(6666004)(83380400001)(26005)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1JsSFZ3bitTd2N1K0dSMTFzZ3Uvc3g2M245UGdwaTR4WFEyS0JVcTFZUGpC?=
 =?utf-8?B?NTBBRkYzV3RCM3RRcXZHUm1SQS9RT3ZOd2p3azBheVBNeGFjc0xSYmgrdzBX?=
 =?utf-8?B?TDBnQjBIdUNMb2JjTDh5VXBydm1hazVPUzBrQUpBb3YzVUdJVFJEaFFjVWg2?=
 =?utf-8?B?QmF5OXRSZ1JTMWdYR1IxR3VSbVhJR2ZoZ245eERqWDZpZElnUWUwVUxzSlJw?=
 =?utf-8?B?LzliaW1ZQSt5OHEwS1diTEpxU1dQS1JWMDFJRmxDNkpaWG1LWmNZcXNYRHpG?=
 =?utf-8?B?MmdMeUV6citWbWFQT2paVTE1NzdCZFAvc3UzUXFyTGtjTlVqUjZWMTBNTDZL?=
 =?utf-8?B?M0Y5ZFhUK0xIWTViTXRSZ3cxMWdCSVZ1TlFHeFU2TjdQTTRDekFPUUVJaDBj?=
 =?utf-8?B?S2NRTElxcWpGd3NpUnVUeFY3QndDblpQQ1g5NVdVemV4RW1pZ1dGUWFRNGMx?=
 =?utf-8?B?SE02aVc5RGp2SWRYR21BSkV6YmJ0eDZHTDhFK200MlM1ZVZrRTBNWWhyK0Z1?=
 =?utf-8?B?QnlCVHRUUjBsMExpRnV1NENCWVBxei8wY2lycVF3K2pBbmJLYU5yNTZWZysw?=
 =?utf-8?B?bm1zcXU1NWxRblBoU2dMNlpabVVxRlNMa3U1cG1MY01OR1VnbytOMHZZMlVZ?=
 =?utf-8?B?U0RhZTdlV1hKZmJzaGNLcmNRaDdDbHFuMVh3Q04wa3htbkJtL3o4cmFVWXpJ?=
 =?utf-8?B?TnZPV2RzNk5Kcjk0NDJqeGJEL3pLWUpuOVJXU2xndkhjbllTaFRWR3Rkbms4?=
 =?utf-8?B?Zyt3cjNNV0I2WURzTVJjK1Q2K2FaUUU3WW9MaC9uaXVhS0NtQ3drZ1pNVy9y?=
 =?utf-8?B?VVRnVnRvV0hsMktaREV4ZktwSjk3QlVRaW5zQkFoMHRaeGFMTzM4ZzMramN1?=
 =?utf-8?B?QTJZSGJVZ3MxNERUc09mT1FQTTI3bnFleGthK0VkaTRSa2RBSGxhQmFybHBW?=
 =?utf-8?B?Vk92eERnWVM1ekRoYUxKNlZxb0RYL002dVRrRDJnYkRUNklGK1R6NUVKSDJa?=
 =?utf-8?B?T09XdTlOWkxKaEJCcW10eTkzbDV3MHppaWVDdDcxemdRRzRhdnhOblV3bmx1?=
 =?utf-8?B?OGlwNHR6UmtIbTNkSHhySTRwRkx1THVpUnFOSGNCZVpuWDJIa3NyK3k4Y2h2?=
 =?utf-8?B?R1ZkRnBEdmxUbDQ4L0F4dDE4NHhOUndHNmhyRUxybnFWUVJMaGtkY0xHSXhK?=
 =?utf-8?B?Nys1Nmt2dEtvaVI1bDhsMWdGaVVFeE41ZlU5eDN4QisyNkNibm1GVythRTJC?=
 =?utf-8?B?Sm9SRnB6clBVOG1iZDRvNHNvc2FoWGthV01VcHRyT3pMTUNaZ0ZQbk5wc1Y2?=
 =?utf-8?B?SDB5UjNjbWR0T3VUb2hLaldWUy80K1pQeWZvY3cwM2Z6dVJGdnNDUUxtUFRR?=
 =?utf-8?B?VjN0bWpGQkFWQXc1SUppbjNMUzlkTzdDbThGMGNiMy9Kd2xkN1N2clltMitz?=
 =?utf-8?B?SU5hSHBZOTJldDg3V2pWQ2wzQzNWeDdDcHNjcmlLbmlQSUJjc20xcWRQRFo1?=
 =?utf-8?B?Z3JvTEZOMUFwTjIwQkxXNVd1Q0piN1NKMkI0U2lFem55YXNSZitKUGZTd0F2?=
 =?utf-8?B?dFl2MnFQRUt1N3g3cllPYWxyNGN6cG05enZZOXBtN2RPWmZTd2krZzdGMHlN?=
 =?utf-8?B?QnNTaGJsby9nK2JLalIrVi8yRkEwa1B4c0hOWUNlVEd6ZWt1STRMT0JxZ245?=
 =?utf-8?B?UnpIY3ZIZmdyTkczaXV1SUREV2MwejhrSjUzVmFac2NLZERZdzU3VmdIL3Fi?=
 =?utf-8?B?WThLM2hhTDduSHp3SmlkdUNVUUoxY2psRTJMRnFxcHFibFNKaU42WGdUSVVa?=
 =?utf-8?B?d3hUQTVhOXdVd2xiQXc2bUZldHAyQTgwTTNvaGhBeTZKc0lueThqcHU3N1BP?=
 =?utf-8?B?cDFQSXVvNEF1cHVKYTE2YnNFREREb2ZadnJMekxOTTVGeU5rVWh4bkMySkpL?=
 =?utf-8?B?by9TbnRqMHRVRE9RMWloc0JVcFlHSlRQa01hSnVpbmg2U2FHTHFmMWJNTFJa?=
 =?utf-8?B?N3BSZi9XdlFKZzgzOWQ0V2tCRlhkWWlUWFRYdWlCb1luM0xpdVMwVXdaUUpw?=
 =?utf-8?B?ZUwxeWtnUXh2ZjBOM2hzVFFRZ05jSldiampQd1hsUXZGRlZCYnJ6bzdROFRz?=
 =?utf-8?Q?a2fSjAC2UF3A9FKi4c/vCZV5g?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d90199e-dc49-4ab5-3418-08dc17140058
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6064.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 04:23:05.5084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pPlWa3qOM62ETb3Y/7IcQB+JSAClOmULYHuhZ3+UgiPhfL9PG5EultNWinJZClmuRmp55eyx5zLTqyMue+x6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8184
X-Proofpoint-ORIG-GUID: RKzMTBJ2d60XA12ePvX3ANJy1nYWyFGQ
X-Proofpoint-GUID: RKzMTBJ2d60XA12ePvX3ANJy1nYWyFGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_01,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=927
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170027
Received-SPF: pass client-ip=205.220.178.238;
 envelope-from=prvs=174635d8a8=kai.kang@windriver.com;
 helo=mx0b-0064b401.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.748,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/9/24 17:52, kai.kang@windriver.com wrote:
> From: Kai Kang <kai.kang@windriver.com>
>
> When this section of source codes were added via commit:
>
> * 02e2da45c4 Add common BusState
>
> it added devices to bus with LIST_INSERT_HEAD() which operated on the
> single direction list. It didn't have something like LIST_INSERT_TAIL()
> at that time and kept that way when turned to QTAILQ.
>
> Then it causes the fist device in qemu command line inserted at the end
> of the bus child link list. And when realize them, the first device will
> be the last one to be realized.
>
> Replace QTAILQ_INSERT_HEAD_RCU() with QTAILQ_INSERT_TAIL_RCU() to make
> sure that devices are added to bus with the sequence in the command
> line.

Ping.


>
> Signed-off-by: Kai Kang <kai.kang@windriver.com>
> ---
>   hw/core/qdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 43d863b0c5..5e2ff43715 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -89,7 +89,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
>       kid->child = child;
>       object_ref(OBJECT(kid->child));
>   
> -    QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
> +    QTAILQ_INSERT_TAIL_RCU(&bus->children, kid, sibling);
>   
>       /* This transfers ownership of kid->child to the property.  */
>       snprintf(name, sizeof(name), "child[%d]", kid->index);


-- 
Kai Kang
Wind River Linux


