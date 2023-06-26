Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D435273DE80
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:10:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDl1Y-00085H-TP; Mon, 26 Jun 2023 08:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qDl1W-00083P-4o
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:08:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qDl1S-0006P3-LP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:08:49 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QBO8JM011697; Mon, 26 Jun 2023 12:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=VbA4jbCGOX37Gds8sPLQ9rO6WzkMInsT07/PNditbZU=;
 b=32R878xE38kdhJU/57+11FlQmmmIdW35c8QPgQvr7j6/Jfu+vxoeENT/ZikodDSTTlG/
 5vzADCDZSb9fSBYSw9UHeG3MJmmSNs3VNx0kG+tHOqXDuUa2xYm+/CcvE6JLYr6eaV4F
 lJ4VaE+WGtrmH3AGUkIdKrmr9Inynmmlcu0jxH5frsNSuZJCFXhgyKUHsQ0gq2NN7QNb
 pfwWW7YkGj2OUp5tXhPMR4ioJGdW7xdsFl7EMQymcLdX/nsJSpuks9R+njWk9ym8+RId
 bGVOMZS0chSKt4fSNWbN3+2nyxUd7lphfhJVXYUmwSWXVpdMimsaTrBi3040QO31vSzd fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq932g27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 12:08:36 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QBNQ33026420; Mon, 26 Jun 2023 12:08:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx9fx93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 12:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPABsRHs54kSNezquP2sruY+0MABMT11ReSWHE5xrPn8xpltUgEPHqp99bOJ5++ep33r6OA/SJHl6VsXtzoxFpoYS6MQt1Ln8xhEEZoVuLb8YObuqinsm9ItJ4ef8uI21X6O8OBbkaeCogRnfd0oZp2whtDq8MmBAmufyoE/2NAjhh+MrS6H1HhtQwgq5B9xO0LgjA4sRF2UUJphovQtdhf9tiL1qSOOuvg+x1aDWHJCbnJwnPkQwv0CyohMFZxzEiQCE0lGUuKtw5vHru1R+FG75/oz2mbcaAe1k2zDYp5ik8PYtJ4Qkn2Xf46dha2xfyMjynr+p0h+c5lJWElA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbA4jbCGOX37Gds8sPLQ9rO6WzkMInsT07/PNditbZU=;
 b=CRI61u2Iq44YqnELMfLIQkxaETeiH7V5VBT3FzBquxRWSrPh8zeJRkQmBJyeh1/sZLTCPW9agbAGTU0q1XEXOEobVrEtAIzITlc6cDlRzg649YcxnYbkyZCwSGn0fj2w5veLXE9uXVxyYCRumcoV30pIX4SAnW48MQdZgtqpCp5q9Ejt7D4yhz0h+Wlo5Zox5Fm6ww3fPQqng82p0AlARvVrjXJTVFchUySQ809/BTs+21cnqOwnhyJQA9dO9kwxSa3ojhOMwylEgVnsyY65+9cLMqhKUwxJMB9RAyphzCfUYf/96SO78vrhncqCxVD+B76W5I6KYInI4PMX84xxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbA4jbCGOX37Gds8sPLQ9rO6WzkMInsT07/PNditbZU=;
 b=yniFEhiLjyrg+YcaK+GRHl1pTXCLVN3DhPwTbgdMgl7Nbz5aPaSq+zPv9Zlv1aTn3zXfFv15fEQRfuIpYefto5khY9QsoBg59zF5Tik4V1gNF97jTKNtfjs3AwdwfyWp5o8AyO5uvu/zeL8jS1jwYSsJMSiqXYMgnhc7dZcVRkQ=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by MN0PR10MB5935.namprd10.prod.outlook.com (2603:10b6:208:3cd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 12:08:33 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::917c:eeb4:5b13:a1ef]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::917c:eeb4:5b13:a1ef%2]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 12:08:32 +0000
Content-Type: multipart/alternative;
 boundary="------------IzfoPO7iJM608nVh9ZpFMOoU"
Message-ID: <49f01bcc-eefa-d277-93fe-e3bcbc2ccd42@oracle.com>
Date: Mon, 26 Jun 2023 08:08:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] qmp: remove virtio_list, search QOM tree instead
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
References: <20230609132040.2180710-1-jonah.palmer@oracle.com>
 <20230609132040.2180710-2-jonah.palmer@oracle.com>
 <20230623014315-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <20230623014315-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BL1P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::17) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|MN0PR10MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 634d9a68-9501-4513-a1cd-08db763e0f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4JIhEXRLyrIEzNhs8VZRPHXdEonLAJjuWlo/N/xG3Pl1zlaiUoBiyojC7hwrIb4SS3lNI7Agj5YJuI0HP9W+O4KOCqfe8HNfaYHqmoCavUYeOm+Ugqq4FT4GLO3ljlEmcvqTudv38a7Ce62bFMcqYdjf5SahepAopYHaU8M2y2Idxa0luU1KRWDnigqGF2FwTIiyHzWf4H3u9B8MSQaR6yyFvP2EZbqM9HxiBudElpPZNLK3w08BDCfKFgS2sxlsuGH5XjeiaEwbz2izm0QprIVxWaWytvw1KirmEtnNMwNy2hQfGjPrZbvoUqkllKcaTTjnDh6gc37do3cLkmQQk5VEYq3wDY3fdfe+dwL6I4M1rSvDt1rctacG5l+65hw0x44FK1vUHCMk2zQyxVK5Css/hx2jb6EmOTr6hxE0+xz41b8MjNZkInIMwioAa5TwRsJAT15TT8oQHYaIopUSSSMl4fYsed+ySJodYNmuCHA668p5jo8CsRlbjpHJKz0JlOJoUZz0e4SPVOqpH17Out43K4M2/ww2LRUfGsB+7QncYfjGqzZgAFaXHzYleYNEd8w0dTN9DXH3KQ2seIZEIbbixu61bg+OOWnpxtKs2VkjRAgcxb20Rziogz7dO3Ek3P9vOfdC55d7xNAG992ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(30864003)(6486002)(33964004)(6666004)(38100700002)(2616005)(83380400001)(6512007)(6506007)(26005)(53546011)(186003)(41300700001)(31696002)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(31686004)(7416002)(5660300002)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlRJMnNXcXNjR0EzNFlLc3VXUWQ0YjV5Vkh2MjR5d2xSVWVORlc3eWZhZGZ0?=
 =?utf-8?B?S2VqUGNVMSs5bVZGRFoyOVozbkdJVG9UTHQ3Rk9nb1R5OUZ0RHdUQ1U0eEtV?=
 =?utf-8?B?STZMa1NLMGg5VDJaSEpnWUU3cXZZL1liYmFlWnRxSWFoQ3l2OU9TdGcvOFVY?=
 =?utf-8?B?MkloclMxMU5ZSWh2OCtUbk1aSDVQaEhzaUs5R0NaOXNIS1ZKOW1LQ3lYYzBT?=
 =?utf-8?B?ZmVIYzdyV2p1ZmNWeHI0dGhiWklINFFheEtWb0dvTlZveU12S0xuU1k3aU5n?=
 =?utf-8?B?VGZoeUIraGR6Z0c2QUQ2MW1EeTR6eTUxb1VobEI4R1BHOWVRY1RzMXprcmNB?=
 =?utf-8?B?d25iMUxLMmxhWFVndFo4dEt4dTdhdjhTdVVqVXl2dUlpZncyVUlZdDlZQ2xh?=
 =?utf-8?B?b2VYN3NSbDNESVdvdkNmVFJQdXJiV25tLzV6anhVeHlKdGRxTnRTdk1SNHlF?=
 =?utf-8?B?OFFSUzVMMkxwajZQU2M3Mk9yaVNsUUVZUFF3Y0F2Zm85VmIyVWhZTmlFdFdI?=
 =?utf-8?B?U0RDUDhaQkwzZTJaV0FkbUpPNGhDQlRuenhjaERQdDBaYy94enJsVlBQQ0s1?=
 =?utf-8?B?WGNnUkJlRUZrQWJGYWlDT3ZEOThaM1Q1Y1pLZEgwVkFUdW84K2MrWHdXWDBG?=
 =?utf-8?B?QWh0ZDJ6b2pBRXFiQTdGNGYwejI3WDNBcjZ4SWRWYWpuK0dXYTllWTlldGgz?=
 =?utf-8?B?eW9BTXdZeFV1OXFSVzgxQTJjZ0ZJVkR4L1FER2tHV3RaaW15SXZLRDdGVU1H?=
 =?utf-8?B?OXp1RERkcUpJNVU1NWNaOFFBcEdVNGVjbDJ3aXdQRjlGdTMzK3R6UmFzTGJU?=
 =?utf-8?B?amlqb0JuOURUbnc3M24zc2pmYU9rcjkxVjNTaEZGN0RhZUpGdkdNOG9yc1Fa?=
 =?utf-8?B?eG5YeFpTdVpTdm9CNG1VSnFoTncxWDFVK2JOZEplV2dDUVBQeDAzT3hpaHBo?=
 =?utf-8?B?eHpxY0FzN3cyZGwyTmhEaU5iTlI3RUEzSmJZajRsaU1UMXh6WHJHR1NLaEpv?=
 =?utf-8?B?MitkVDhZNDZ4VnJJc29VRXN4L09ZcFhnYUpOVW1YNjRwNGtzcFQyNy9vWXBH?=
 =?utf-8?B?REFpUTdKWGJyRXJFRzdNTi8zMEhoRWpTY2lEb1RSYThmeGZ3VDJzcWMyL0VP?=
 =?utf-8?B?elJFM2xUZy9XMFNHaGhGalFWUGkxcFgrU3UveDgwd21CRnFkVWxnNGowZHgz?=
 =?utf-8?B?YU5SOXFJczhCMG5NKzlyaW5HK21KSzc5bzQyY2g5SlBKdVdzZkVocVpiN1Bh?=
 =?utf-8?B?UW9IVjNNT01ZNkh6ZGowM0VqYmNLTEEwTTgybUg0dHA4b0paZlhEU01nRVpM?=
 =?utf-8?B?a2FBdHloMk9FSnVBdnhsVXJ5UDczMHZPRXJNeVBnR0R4QkswQmQ1clRWU1FF?=
 =?utf-8?B?OFRQNDlvTjBMUURhS2JlNEp1RURXcW13SzZrR00rbUxUUFVUSG1CVzgwbWJR?=
 =?utf-8?B?TlFKT29VQloxWmd3eSsyMkdVN2x0NEdhTGxSZ2dmU0V4NGs2R3JNRE9Vb29B?=
 =?utf-8?B?NnJaMjhKY3JRZkdjc1h6cWxseEw1V2ZJR0FZUTlPMnlNOEYxeWVMcEd4L0xh?=
 =?utf-8?B?MlRwZ1haTmViTFBIUEV4OU04Q21SREkzMHR5Rm9IMGwzaG1hK1JRcWVpbjBL?=
 =?utf-8?B?a1o2dk5wTEI0Y2lrQjlFUC9jNkJrNTdFeFRxL21ERTExb0Y2RDYxRXVycE01?=
 =?utf-8?B?V09FMXdOSlFyaGZPc3pkWFZpcUxhMDlCQXJ1MjdMTnp3T2VuUHh2MFBkY0VK?=
 =?utf-8?B?dHVjM2dXK3BpdDNOVFRLeXJJZ3lHRGU0NkZMTlp3N0ZGalY3cXlOdkJja1JK?=
 =?utf-8?B?Q0FpWVJSL01iNlBqQi9uV1hRTUxIazhEY29YRkFXMWRYczE5aUZpK2piQ3pl?=
 =?utf-8?B?aFFWanNOWGFEajFxSURDc3F1NkxZRnJzSzVucy85ZkJhTHFpd2g5UHRJd3No?=
 =?utf-8?B?aS9lM1J3aHdQNjRsUGRjQXZyQURSYjJUL3FlS2dONWIxU09TOVIwdE02M1Bm?=
 =?utf-8?B?ekJja3JqMGZ4Z25kaGlkYnA1VUFibVJGQjIrUkRBWE5ra0RQc0FLRWJFNnJF?=
 =?utf-8?B?cUlRcjYxTG9mOHZDNE9Cd01iTnJVcHhuelJ4R2ViMGl0RmdteFk0QnR6YlNN?=
 =?utf-8?Q?vRI/8ePoYObMVxvhYuErWMbZy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TbGk8shmPBSaXHhiSRLy8GpTqAZsjBCY5DVFW0/eyiKYXu18m0fxFYCuU0cktrLYikfJxZd2tLCDrrYX5Os0Cun688urdam+oU+E587rpj7+aInvjNbOGZ1AGozsgICvuPlLV8GBFJ2Vc598k3jJ4Bx0TaZu249lCYe8blKLJ60yP1m2F0oWUv/LZsFElPyZivsVrggOj4QGGSyMoGPsEXTVpCJLnizgN6KnzfKMgXDQ/kCK1/XwLUbUPNONqiyBrSgN+2cC8HRQxERcmPOhvlSJdk2j2FZFXp+A3JWKGGJUB9AXiU4MmLu2iUjfxnVprPbeDCiYbwuSqMm0GjQFUrqXdevPVnxTBlt5xEgKolT7Q2Z+yH2lgCRwvGzn4T3IEhbooRO5waniZHs3Y1/jipL7wVVdg9RYAkXADcvqEjziWAkbpt+sbsDyMIvjfMai9Ne9yWUqVpHPPnSe/tjyFd9S+7ym5nR2WgSn5MnDf5gbBZPorve6TYsJ1+agUtiq9ZjoEUfrSWu1OrN7C1cCcFnn7WBdYlQyis2VGA2JxfMHW/95MDBvD0T0xFypeKOWUgZb35VFOmm6IAIIivGrcAj0UBrP77mZnzYZwQ02WVD6V+5evCBmz0aVDWdjY7X/6Ek7c7XJqMPmG3UER6dTDqjWh0BIJGEN6HzPyICKzkAMEQH4iN53LkGokr9KB9/l9eI7BRUzjbbzmXnQUF3nE0O04QSN4/cWlOUrqqsUexjVGcheca46AAevr+GSBGcTiYkc1lMzXt7+VlgScYY5gXBk61hQax69n8kzG6L/crpn941MEfqH4dZKgAxB6yCfLTLMCcULzaOV+Y3RfEKnhNU07Cfd8ZG3MQqxKqybu+DK54bEOby2F97yzHLuKn/p
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634d9a68-9501-4513-a1cd-08db763e0f63
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:08:32.3312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqpNp30ADyet2qL2w4+Q7EIVWlmvr0NStNRNRA9xwKg++s3ZI51bzyA6jY5vPW20NGIyC5B56F/am43Crnf6Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5935
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_09,2023-06-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260109
X-Proofpoint-ORIG-GUID: TlEfE20RcnAHTzRbLXy1Rvmyi3yldogg
X-Proofpoint-GUID: TlEfE20RcnAHTzRbLXy1Rvmyi3yldogg
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------IzfoPO7iJM608nVh9ZpFMOoU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/23 01:47, Michael S. Tsirkin wrote:

> On Fri, Jun 09, 2023 at 09:20:39AM -0400, Jonah Palmer wrote:
>> The virtio_list duplicates information about virtio devices that already
>> exist in the QOM composition tree. Instead of creating this list of
>> realized virtio devices, search the QOM composition tree instead.
>>
>> This patch modifies the QMP command qmp_x_query_virtio to instead search
>> the partial paths of '/machine/peripheral/' &
>> '/machine/peripheral-anon/' in the QOM composition tree for virtio
>> devices.
>>
>> A device is found to be a valid virtio device if (1) its canonical path
>> is of 'TYPE_VIRTIO_DEVICE' and (2) the device has been realized.
>>
>> [Jonah: In the previous commit I had written that a device is found to
>>   be a valid virtio device if (1) it has a canonical path ending with
>>   'virtio-backend'.
>>
>>   The code now determines if it's a virtio device by appending
>>   'virtio-backend' (if needed) to a given canonical path and then
>>   checking that path to see if the device is of type
>> 'TYPE_VIRTIO_DEVICE'.
>>
>>   The patch also instead now checks to make sure it's a virtio device
>>   before attempting to check whether the device is realized or not.]
>>
>> Signed-off-by: Jonah Palmer<jonah.palmer@oracle.com>
>
> Could one of QMP maintainers comment on this please?
>
>> ---
>>   hw/virtio/virtio-qmp.c | 128 ++++++++++++++++++++++++++---------------
>>   hw/virtio/virtio-qmp.h |   8 +--
>>   hw/virtio/virtio.c     |   6 --
>>   3 files changed, 82 insertions(+), 60 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>> index b5e1835299..e936cc8ce5 100644
>> --- a/hw/virtio/virtio-qmp.c
>> +++ b/hw/virtio/virtio-qmp.c
>> @@ -668,67 +668,101 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>>   VirtioInfoList *qmp_x_query_virtio(Error **errp)
>>   {
>>       VirtioInfoList *list = NULL;
>> -    VirtioInfo *node;
>> -    VirtIODevice *vdev;
>>   
>> -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>> -        DeviceState *dev = DEVICE(vdev);
>> -        Error *err = NULL;
>> -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>> -
>> -        if (err == NULL) {
>> -            GString *is_realized = qobject_to_json_pretty(obj, true);
>> -            /* virtio device is NOT realized, remove it from list */
>> -            if (!strncmp(is_realized->str, "false", 4)) {
>> -                QTAILQ_REMOVE(&virtio_list, vdev, next);
>> -            } else {
>> -                node = g_new(VirtioInfo, 1);
>> -                node->path = g_strdup(dev->canonical_path);
>> -                node->name = g_strdup(vdev->name);
>> -                QAPI_LIST_PREPEND(list, node);
>> +    /* Query the QOM composition tree for virtio devices */
>> +    qmp_set_virtio_device_list("/machine/peripheral/", &list);
>> +    qmp_set_virtio_device_list("/machine/peripheral-anon/", &list);
> How sure are we these will forever be the only two places where virtio
> can live?

A virtio device will always be considered a peripheral device, right?
Since peripheral devices are input and/or output devices by definition.

>> +    if (list == NULL) {
>> +        error_setg(errp, "No virtio devices found");
>> +        return NULL;
>> +    }
>> +    return list;
>> +}
>> +
>> +/* qmp_set_virtio_device_list:
>> + * @ppath: An incomplete peripheral path to search from.
>> + * @list: A list of realized virtio devices.
>> + * Searches a given incomplete peripheral path (e.g. '/machine/peripheral/'
>> + * or '/machine/peripheral-anon/') for realized virtio devices and adds them
>> + * to a given list of virtio devices.
>> + */
>> +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list)
>> +{
>> +    ObjectPropertyInfoList *plist;
>> +    VirtioInfoList *node;
>> +    Error *err = NULL;
>> +
>> +    /* Search an incomplete path for virtio devices */
>> +    plist = qmp_qom_list(ppath, &err);
>> +    if (err == NULL) {
>> +        ObjectPropertyInfoList *start = plist;
>> +        while (plist != NULL) {
>> +            ObjectPropertyInfo *value = plist->value;
>> +            GString *path = g_string_new(ppath);
>> +            g_string_append(path, value->name);
>> +            g_string_append(path, "/virtio-backend");
>> +
>> +            /* Determine if full path is a realized virtio device */
>> +            VirtIODevice *vdev = qmp_find_virtio_device(path->str);
>> +            if (vdev != NULL) {
>> +                node = g_new0(VirtioInfoList, 1);
>> +                node->value = g_new(VirtioInfo, 1);
>> +                node->value->path = g_strdup(path->str);
>> +                node->value->name = g_strdup(vdev->name);
>> +                QAPI_LIST_PREPEND(*list, node->value);
>>               }
>> -           g_string_free(is_realized, true);
>> +            g_string_free(path, true);
>> +            plist = plist->next;
>>           }
>> -        qobject_unref(obj);
>> +        qapi_free_ObjectPropertyInfoList(start);
>>       }
>> -
>> -    return list;
>>   }
>>   
>>   VirtIODevice *qmp_find_virtio_device(const char *path)
>>   {
>> -    VirtIODevice *vdev;
>> -
>> -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>> -        DeviceState *dev = DEVICE(vdev);
>> -
>> -        if (strcmp(dev->canonical_path, path) != 0) {
>> -            continue;
>> +    Error *err = NULL;
>> +    char *basename;
>> +
>> +    /* Append 'virtio-backend' to path if needed */
>> +    basename = g_path_get_basename(path);
>> +    if (strcmp(basename, "virtio-backend")) {
>> +        GString *temp = g_string_new(path);
>> +        char *last = strrchr(path, '/');
>> +        if (g_strcmp0(last, "/")) {
>> +            g_string_append(temp, "/virtio-backend");
>> +        } else {
>> +            g_string_append(temp, "virtio-backend");
>>           }
>> +        path = g_strdup(temp->str);
>> +        g_string_free(temp, true);
>> +    }
> I don't much like the string operations. We should be able to
> check object types instead.
>
I don't either but in order for us to check if the object is a
virtio device type, we need to use the device's path ending
with '/virtio-backend'.

If there's a better method to checking this though, or perhaps
checking a different type, that doesn't involve string
manipulation, then I'm all for it.

>> -        Error *err = NULL;
>> -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>> -        if (err == NULL) {
>> -            GString *is_realized = qobject_to_json_pretty(obj, true);
>> -            /* virtio device is NOT realized, remove it from list */
>> -            if (!strncmp(is_realized->str, "false", 4)) {
>> -                g_string_free(is_realized, true);
>> -                qobject_unref(obj);
>> -                QTAILQ_REMOVE(&virtio_list, vdev, next);
>> -                return NULL;
>> -            }
>> +    /* Verify the canonical path is a virtio device */
>> +    Object *obj = object_resolve_path(path, NULL);
>> +    if (!obj || !object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
>> +        object_unref(obj);
>> +        return NULL;
>> +    }
>> +
>> +    /* Verify the virtio device is realized */
>> +    QObject *qobj = qmp_qom_get(path, "realized", &err);
>> +    if (err == NULL) {
>> +        GString *is_realized = qobject_to_json_pretty(qobj, true);
>> +        if (!strncmp(is_realized->str, "false", 4)) {
>>               g_string_free(is_realized, true);
>> -        } else {
>> -            /* virtio device doesn't exist in QOM tree */
>> -            QTAILQ_REMOVE(&virtio_list, vdev, next);
>> -            qobject_unref(obj);
>> +            qobject_unref(qobj);
>>               return NULL;
>>           }
>> -        /* device exists in QOM tree & is realized */
>> -        qobject_unref(obj);
>> -        return vdev;
>> +        g_string_free(is_realized, true);
>> +    } else {
>> +        qobject_unref(qobj);
>> +        return NULL;
>>       }
>> -    return NULL;
>> +    qobject_unref(qobj);
>> +
>> +    /* Get VirtIODevice object */
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(obj);
>> +    return vdev;
>>   }
>>   
>>   VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>> diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
>> index 8af5f5e65a..4b2b7875b4 100644
>> --- a/hw/virtio/virtio-qmp.h
>> +++ b/hw/virtio/virtio-qmp.h
>> @@ -15,13 +15,7 @@
>>   #include "hw/virtio/virtio.h"
>>   #include "hw/virtio/vhost.h"
>>   
>> -#include "qemu/queue.h"
>> -
>> -typedef QTAILQ_HEAD(QmpVirtIODeviceList, VirtIODevice) QmpVirtIODeviceList;
>> -
>> -/* QAPI list of realized VirtIODevices */
>> -extern QmpVirtIODeviceList virtio_list;
>> -
>> +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list);
>>   VirtIODevice *qmp_find_virtio_device(const char *path);
>>   VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
>>   VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 295a603e58..83c5db3d26 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -45,8 +45,6 @@
>>   #include "standard-headers/linux/virtio_mem.h"
>>   #include "standard-headers/linux/virtio_vsock.h"
>>   
>> -QmpVirtIODeviceList virtio_list;
>> -
>>   /*
>>    * Maximum size of virtio device config space
>>    */
>> @@ -3616,7 +3614,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>>       vdev->listener.commit = virtio_memory_listener_commit;
>>       vdev->listener.name = "virtio";
>>       memory_listener_register(&vdev->listener, vdev->dma_as);
>> -    QTAILQ_INSERT_TAIL(&virtio_list, vdev, next);
>>   }
>>   
>>   static void virtio_device_unrealize(DeviceState *dev)
>> @@ -3631,7 +3628,6 @@ static void virtio_device_unrealize(DeviceState *dev)
>>           vdc->unrealize(dev);
>>       }
>>   
>> -    QTAILQ_REMOVE(&virtio_list, vdev, next);
>>       g_free(vdev->bus_name);
>>       vdev->bus_name = NULL;
>>   }
>> @@ -3805,8 +3801,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
>>       vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
>>   
>>       vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
>> -
>> -    QTAILQ_INIT(&virtio_list);
>>   }
>>   
>>   bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
>> -- 
>> 2.39.3
--------------IzfoPO7iJM608nVh9ZpFMOoU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>
</pre>
    <div class="moz-cite-prefix">
      <pre>On 6/23/23 01:47, Michael S. Tsirkin wrote:</pre>
    </div>
    <blockquote type="cite" cite="mid:20230623014315-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">On Fri, Jun 09, 2023 at 09:20:39AM -0400, Jonah Palmer wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">The virtio_list duplicates information about virtio devices that already
exist in the QOM composition tree. Instead of creating this list of
realized virtio devices, search the QOM composition tree instead.

This patch modifies the QMP command qmp_x_query_virtio to instead search
the partial paths of '/machine/peripheral/' &amp;
'/machine/peripheral-anon/' in the QOM composition tree for virtio
devices.

A device is found to be a valid virtio device if (1) its canonical path
is of 'TYPE_VIRTIO_DEVICE' and (2) the device has been realized.

[Jonah: In the previous commit I had written that a device is found to
 be a valid virtio device if (1) it has a canonical path ending with
 'virtio-backend'.

 The code now determines if it's a virtio device by appending
 'virtio-backend' (if needed) to a given canonical path and then
 checking that path to see if the device is of type
'TYPE_VIRTIO_DEVICE'.

 The patch also instead now checks to make sure it's a virtio device
 before attempting to check whether the device is realized or not.]

Signed-off-by: Jonah Palmer <a class="moz-txt-link-rfc2396E" href="mailto:jonah.palmer@oracle.com">&lt;jonah.palmer@oracle.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">

Could one of QMP maintainers comment on this please?

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 hw/virtio/virtio-qmp.c | 128 ++++++++++++++++++++++++++---------------
 hw/virtio/virtio-qmp.h |   8 +--
 hw/virtio/virtio.c     |   6 --
 3 files changed, 82 insertions(+), 60 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index b5e1835299..e936cc8ce5 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -668,67 +668,101 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
 VirtioInfoList *qmp_x_query_virtio(Error **errp)
 {
     VirtioInfoList *list = NULL;
-    VirtioInfo *node;
-    VirtIODevice *vdev;
 
-    QTAILQ_FOREACH(vdev, &amp;virtio_list, next) {
-        DeviceState *dev = DEVICE(vdev);
-        Error *err = NULL;
-        QObject *obj = qmp_qom_get(dev-&gt;canonical_path, &quot;realized&quot;, &amp;err);
-
-        if (err == NULL) {
-            GString *is_realized = qobject_to_json_pretty(obj, true);
-            /* virtio device is NOT realized, remove it from list */
-            if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
-                QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
-            } else {
-                node = g_new(VirtioInfo, 1);
-                node-&gt;path = g_strdup(dev-&gt;canonical_path);
-                node-&gt;name = g_strdup(vdev-&gt;name);
-                QAPI_LIST_PREPEND(list, node);
+    /* Query the QOM composition tree for virtio devices */
+    qmp_set_virtio_device_list(&quot;/machine/peripheral/&quot;, &amp;list);
+    qmp_set_virtio_device_list(&quot;/machine/peripheral-anon/&quot;, &amp;list);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
How sure are we these will forever be the only two places where virtio
can live?
</pre>
    </blockquote>
    <pre>A virtio device will always be considered a peripheral device, right?
Since peripheral devices are input and/or output devices by definition.
</pre>
    <blockquote type="cite" cite="mid:20230623014315-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    if (list == NULL) {
+        error_setg(errp, &quot;No virtio devices found&quot;);
+        return NULL;
+    }
+    return list;
+}
+
+/* qmp_set_virtio_device_list:
+ * @ppath: An incomplete peripheral path to search from.
+ * @list: A list of realized virtio devices.
+ * Searches a given incomplete peripheral path (e.g. '/machine/peripheral/'
+ * or '/machine/peripheral-anon/') for realized virtio devices and adds them
+ * to a given list of virtio devices.
+ */
+void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list)
+{
+    ObjectPropertyInfoList *plist;
+    VirtioInfoList *node;
+    Error *err = NULL;
+
+    /* Search an incomplete path for virtio devices */
+    plist = qmp_qom_list(ppath, &amp;err);
+    if (err == NULL) {
+        ObjectPropertyInfoList *start = plist;
+        while (plist != NULL) {
+            ObjectPropertyInfo *value = plist-&gt;value;
+            GString *path = g_string_new(ppath);
+            g_string_append(path, value-&gt;name);
+            g_string_append(path, &quot;/virtio-backend&quot;);
+
+            /* Determine if full path is a realized virtio device */
+            VirtIODevice *vdev = qmp_find_virtio_device(path-&gt;str);
+            if (vdev != NULL) {
+                node = g_new0(VirtioInfoList, 1);
+                node-&gt;value = g_new(VirtioInfo, 1);
+                node-&gt;value-&gt;path = g_strdup(path-&gt;str);
+                node-&gt;value-&gt;name = g_strdup(vdev-&gt;name);
+                QAPI_LIST_PREPEND(*list, node-&gt;value);
             }
-           g_string_free(is_realized, true);
+            g_string_free(path, true);
+            plist = plist-&gt;next;
         }
-        qobject_unref(obj);
+        qapi_free_ObjectPropertyInfoList(start);
     }
-
-    return list;
 }
 
 VirtIODevice *qmp_find_virtio_device(const char *path)
 {
-    VirtIODevice *vdev;
-
-    QTAILQ_FOREACH(vdev, &amp;virtio_list, next) {
-        DeviceState *dev = DEVICE(vdev);
-
-        if (strcmp(dev-&gt;canonical_path, path) != 0) {
-            continue;
+    Error *err = NULL;
+    char *basename;
+
+    /* Append 'virtio-backend' to path if needed */
+    basename = g_path_get_basename(path);
+    if (strcmp(basename, &quot;virtio-backend&quot;)) {
+        GString *temp = g_string_new(path);
+        char *last = strrchr(path, '/');
+        if (g_strcmp0(last, &quot;/&quot;)) {
+            g_string_append(temp, &quot;/virtio-backend&quot;);
+        } else {
+            g_string_append(temp, &quot;virtio-backend&quot;);
         }
+        path = g_strdup(temp-&gt;str);
+        g_string_free(temp, true);
+    }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I don't much like the string operations. We should be able to
check object types instead.

</pre>
    </blockquote>
    <pre>I don't either but in order for us to check if the object is a
virtio device type, we need to use the device's path ending
with '/virtio-backend'.

If there's a better method to checking this though, or perhaps
checking a different type, that doesn't involve string
manipulation, then I'm all for it.
</pre>
    <blockquote type="cite" cite="mid:20230623014315-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-        Error *err = NULL;
-        QObject *obj = qmp_qom_get(dev-&gt;canonical_path, &quot;realized&quot;, &amp;err);
-        if (err == NULL) {
-            GString *is_realized = qobject_to_json_pretty(obj, true);
-            /* virtio device is NOT realized, remove it from list */
-            if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
-                g_string_free(is_realized, true);
-                qobject_unref(obj);
-                QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
-                return NULL;
-            }
+    /* Verify the canonical path is a virtio device */
+    Object *obj = object_resolve_path(path, NULL);
+    if (!obj || !object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
+        object_unref(obj);
+        return NULL;
+    }
+
+    /* Verify the virtio device is realized */
+    QObject *qobj = qmp_qom_get(path, &quot;realized&quot;, &amp;err);
+    if (err == NULL) {
+        GString *is_realized = qobject_to_json_pretty(qobj, true);
+        if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
             g_string_free(is_realized, true);
-        } else {
-            /* virtio device doesn't exist in QOM tree */
-            QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
-            qobject_unref(obj);
+            qobject_unref(qobj);
             return NULL;
         }
-        /* device exists in QOM tree &amp; is realized */
-        qobject_unref(obj);
-        return vdev;
+        g_string_free(is_realized, true);
+    } else {
+        qobject_unref(qobj);
+        return NULL;
     }
-    return NULL;
+    qobject_unref(qobj);
+
+    /* Get VirtIODevice object */
+    VirtIODevice *vdev = VIRTIO_DEVICE(obj);
+    return vdev;
 }
 
 VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
index 8af5f5e65a..4b2b7875b4 100644
--- a/hw/virtio/virtio-qmp.h
+++ b/hw/virtio/virtio-qmp.h
@@ -15,13 +15,7 @@
 #include &quot;hw/virtio/virtio.h&quot;
 #include &quot;hw/virtio/vhost.h&quot;
 
-#include &quot;qemu/queue.h&quot;
-
-typedef QTAILQ_HEAD(QmpVirtIODeviceList, VirtIODevice) QmpVirtIODeviceList;
-
-/* QAPI list of realized VirtIODevices */
-extern QmpVirtIODeviceList virtio_list;
-
+void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list);
 VirtIODevice *qmp_find_virtio_device(const char *path);
 VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
 VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 295a603e58..83c5db3d26 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -45,8 +45,6 @@
 #include &quot;standard-headers/linux/virtio_mem.h&quot;
 #include &quot;standard-headers/linux/virtio_vsock.h&quot;
 
-QmpVirtIODeviceList virtio_list;
-
 /*
  * Maximum size of virtio device config space
  */
@@ -3616,7 +3614,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
     vdev-&gt;listener.commit = virtio_memory_listener_commit;
     vdev-&gt;listener.name = &quot;virtio&quot;;
     memory_listener_register(&amp;vdev-&gt;listener, vdev-&gt;dma_as);
-    QTAILQ_INSERT_TAIL(&amp;virtio_list, vdev, next);
 }
 
 static void virtio_device_unrealize(DeviceState *dev)
@@ -3631,7 +3628,6 @@ static void virtio_device_unrealize(DeviceState *dev)
         vdc-&gt;unrealize(dev);
     }
 
-    QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
     g_free(vdev-&gt;bus_name);
     vdev-&gt;bus_name = NULL;
 }
@@ -3805,8 +3801,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
     vdc-&gt;stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
 
     vdc-&gt;legacy_features |= VIRTIO_LEGACY_FEATURES;
-
-    QTAILQ_INIT(&amp;virtio_list);
 }
 
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
-- 
2.39.3
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------IzfoPO7iJM608nVh9ZpFMOoU--

