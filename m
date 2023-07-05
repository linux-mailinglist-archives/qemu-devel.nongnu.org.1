Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE59E74901B
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 23:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAGr-0000QL-5M; Wed, 05 Jul 2023 17:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qHAGL-00004z-Te
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:42:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qHAGI-0002Hf-S5
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:42:12 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 365LaWDk016804; Wed, 5 Jul 2023 21:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=EMp1KuCILT+g7tKLLameehq37YSyZuFYIgLpSf4y96A=;
 b=bRUOJBl3tCzrNj9XMxhCHSH7WpRnQgq6+jiLzmB0UOrSaWDcHAP+zq7BrpBKJvygGikq
 vUCUbWQD1AKE8aPGG+fJRLfLqSMDJLo/i6H+eLYMl5tGo1xWduG5qo1DDQ2PAeKrPkOz
 ovJ4ASvAgURs8xGUXxY6Cecpp/tQX+UQQru6+IoRn+KMfo3U7VMwHjg6wUez3+SGhXqe
 wWna/v8LPVAY/oBylf9iQJgJbqmi02/ObWjEsFlpYNBXzI13rhdqKw/ksT/SIdGv99Zp
 jXorSGh8PC1NhVgkALYG6yte99E93yBmSYDK9FeMx4W1Sbe3u4P60091loipYDA+JUWz Zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnfkug34c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Jul 2023 21:42:08 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 365Kp4FC007122; Wed, 5 Jul 2023 21:42:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjakc5c4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Jul 2023 21:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n15wjwIDr5jaqwoitxf2dngyIluYMkV0h9YMOvxc0ywcdFtImlnQzKdAL/gmLWNJYx36tV/yFm0GDHygMT5t3rhMOEuxMKTvrTxe/gFbp2eolaT3kgDUxvNlGddnvR608OuzpIylQMbVRqD9eWyBY9lfi1Ap7QTrhCKoDux5EhMs8LPtzx5Q7LiVGOwsHG9/em6O/qWA+M/9jM/f6pPK7VXlr7gTwlXB7vbd0t6PMGWlIIt9zXmG3uEObmtFDzQE7ft8ZBbji44A/0A2TuwUIyvnxQc3aEHi0/sQ9rMRenfwauwMw4f7U+1xximsZm72Zqt0LeTn37k1TXoQ/9JcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMp1KuCILT+g7tKLLameehq37YSyZuFYIgLpSf4y96A=;
 b=f9YoLh9w7iSB9cQC8c7YORBd5h7i9Qb7a1zy5ITKmTrb6l3mf7QLNJl5BEFTjPSLO98nmcx9VpuFZzbnNXurbjx4bv9AOKnSjIFqAf0kOxTXPYY7vDPkPorPcHrilH1N7nSk/XLRRnMu4f1UauHTMWVfVk5eqkMYc7BwAIo5WO/E+GaufaGZPG06R5GOdG2aq6AxSQIifiz7afX7pIZT3Pd9GE9I2JtIRmXFMPaJXmtWSlKDDNBb+YwDZaVUjqw2dc5P+PYHYYJCKRC/W2Z4/xcQzm7NQvFalb/BZ/jfZkkQQnYP3I/HIn0niBC+CeBuFJZaWozqBsMRhF8cgGIxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMp1KuCILT+g7tKLLameehq37YSyZuFYIgLpSf4y96A=;
 b=HKIlegiRg2EAGzFtRR72NtXl5DxVXNzCBcFnV0EDt1Jj7pYlLuJgbMOep9FfYQ+hDUMbwAXgdZsib/xJiVw9daU47/CialdGOQsZ401mur7GET+Sgnu+C7ihDrsVc2c85bZx2Ace8Qf6z05LLj8WxcT5BtoxGIJGD9DNQhlAPiw=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 21:42:05 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 21:42:04 +0000
Message-ID: <b6db309f-3d71-1f54-2f3d-30d5b3ebc889@oracle.com>
Date: Wed, 5 Jul 2023 17:42:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3] migration: simplify blockers
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Peter Xu <peterx@redhat.com>
References: <1686148532-249302-1-git-send-email-steven.sistare@oracle.com>
 <ZICpKM2zSZSkhmTW@x1n> <28823c9d-e82f-9073-ddb3-6211d80d81c7@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <28823c9d-e82f-9073-ddb3-6211d80d81c7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0117.namprd07.prod.outlook.com
 (2603:10b6:5:330::32) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA1PR10MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: d5dac918-279d-47da-f4d5-08db7da0ac94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7cz5ohUu4NPBKKfyFFks3q/5cuBlRO3f+rZ3xX4V2Jra7zASeKWJtHgm/XRqnu3tLb2XKd1izEwH/PrNUqBfDw41b70qvMyu0x9KLGkK3+CkWa960Fof976VTVk63LVcGmzRoRI+rNnL8046gFUxf0JOJdDhbxZNvOAYR40Epja+SI4hGDEf6PbcMMZy6NVZ2mzqmZccEplbkJjlG7M2nXUrLgpK/VVTwGGgGSro04AqcNstlWmIhXFMQxBoCSz9MaH2HXfyes0P5rmGS+hKaEsmBubKC4QX9V0/aiRQJdKp4EXGUf3xIwUhAdJkt119HX8M2A9ewizPwjOeSzb4rJ2SYkviwvXXBG5UOQpPwMSOIHipD9PxNvCcblNzWwGIS9tEzPn/UFyNOrLwHc/dnkD1xddTfXvR1l6DU9VwTgBhwgSRAihNMNwTwiDlCo8Uv1NfxTdAxMt+X1YlWwFU3pECzYJtm8yzvw7bPLqAxb/03yPwyL25fZhB6Kaby7Ycb4XRC16reL0EjzxznkTgkMzldrqHY0U+8iKbI0ytdHzuEi4GeTu0SMBygkkdxPm9zRVUZHnvdyx2Zh8lRHdurINhhT65dDA119JX6hO09Fm7LqsKme6MR3XfiVslMI+x4aQu+qyio4x6wmkUfswNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(2616005)(83380400001)(54906003)(36756003)(31696002)(86362001)(44832011)(8676002)(41300700001)(31686004)(8936002)(2906002)(5660300002)(66946007)(66556008)(6916009)(66476007)(6486002)(316002)(478600001)(6666004)(36916002)(53546011)(38100700002)(26005)(4326008)(6506007)(6512007)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTdSOG52ZlFTc3ZGZGFzb1V2QkZZMzByZmRncVBrMDBFR0JaRzY4MnhEbzhU?=
 =?utf-8?B?U3hXRnR3VjRzdUF2WVhaZ0VXK3NoNlcrbWYzb05mamc5Rlp4aVNpemVkbUxk?=
 =?utf-8?B?WkRqWnZLdkc3aUxaeThUamkzalBvM3hwQ0hkT3J0WmJXNERIZnRHOVlCSlpm?=
 =?utf-8?B?RDJwSCsyTmdqVGRicUFqLzNwUjdMbnhHRG1JRlV2aHRXQ0JodTFBazNQSzNq?=
 =?utf-8?B?a21rM2VmT2RBQ3BVUFF5N3NYSTZ5ZFlLYkZQdW9iekJTb29yZDFkUUVRVjVT?=
 =?utf-8?B?Unk4b1lLZWlCbEdtV3FlVlZXMlBESXhSUmxROU01MzRMUmZBbFVUZDFYR3N4?=
 =?utf-8?B?cFRpMnQ5Njk5dTE2Z0JoN2o0VXFIdDl5dmttQ3U5c3BpTncwNU16VFBGSVlk?=
 =?utf-8?B?VjhlYWVYRHNhdmRvT0x1QmFpYUxteTgrNlN3T0tiaUJORmlUeHcxcmJad0Fa?=
 =?utf-8?B?WFY0VFhBSE50Zi9zNm5SU1VZN3RBRXJCQ3NrZGxvTmlLbllNbVBlM1RqOVNu?=
 =?utf-8?B?L25Va2lkVzYwRVZ5MWFGeUdPNmYwd3JZV1RaTXczdzVBaXRyUVR4Q21TY1BP?=
 =?utf-8?B?NFNDc3FuZWlFVGdMY1lOVWFHaEw4OU41a3h0TDlOTlE0cWpTUUtSc1B0cEJn?=
 =?utf-8?B?blduV0Q1UzhPU0c2SlFKRHZsUWVXdW5XaWhJZ1RKdENSV0NnYnNmZHVsSmtz?=
 =?utf-8?B?YXQ1V2V3ZnpucnRFQm12RjErUDY5MmxaU09oWVdyU2FUMGpVR0ozVHNZM3FG?=
 =?utf-8?B?aE1ESStYcVkyQmo1amZyZnhPOHJ6Tk9IMEpyc0dKUjI2QXZuYWk4QjFYTXFQ?=
 =?utf-8?B?UXhqRVZRaFJMV2xNYXF0Z1NGR0dJcjBPRmlYRVN0Z1praUdMaWduTnl0YnY4?=
 =?utf-8?B?L0RrVlFaSTFJYzV2U2lvQ1daVnY1YzNhZWVQUVhGRGE2VXdlNzdLQk9RUzVw?=
 =?utf-8?B?OS9BWnJ1RjU4NUdqb2ZKTVArVzFmL0pLZHliZGlDNy9MalpkZEJZQzhmUXdR?=
 =?utf-8?B?Nk1zMVBRTjRpV0tEY1ZydU5uSVc0cTQ2aFgxV0lQbWlZcWNXSloxdVZFVnh2?=
 =?utf-8?B?QmNSN2NPSGNvMDVNOWM0VkxpMjJTTkxLRmFJOVp0Z0RuWlcwbUhjQ0hlQnN6?=
 =?utf-8?B?aHdyOC8wcDhBY05QL0JIcFVoY3dzN1RlT09mcjlRSmVRQ0ZPeVFNRG0zUStU?=
 =?utf-8?B?eHl5RHhJOWxscXhsam9FaDVSd1RCdDZ5UTRLRjN3R2RmckJENnFObjJ3dEhk?=
 =?utf-8?B?RUFGTnUwR3ZHOUV1RDl5Q2hvV3ZLZU4wQ0NyMm9hMElLQ2YyVjhNbG5nYXlx?=
 =?utf-8?B?c1JER1NOMjVKVmRWTWs5YnJZRXhvRE9Kb2k1NDBzTnFYZUJhbVlZV2lRbmZ3?=
 =?utf-8?B?cEZmV3ZGYS9JeDkyN3pER0pRR0pyOWlDdml2TlF4NjYreERKbHhEVExEZWhj?=
 =?utf-8?B?cXB6VThLMlJsbm4zaE92VGNDVUdtY1hoOTdGQjhrbVYyUUJlUkZuRGNVYzJh?=
 =?utf-8?B?NWtoS2ZPZ2d5L2RxNDlZa1phU0FleTJTQlZYNU5Eb2QxcVcwbkxvUVFrOGhZ?=
 =?utf-8?B?RFYrd3FTOTFwODI4TXZ5UXlTU0JNWEx2dDBqUVVEVS9uakRtaG1wbGJFZ3lB?=
 =?utf-8?B?bFJvRHdSUitFaDlVdWgvVnA3dTRRc0tRdlp2SVNhUFZST0VWM21WNnRoR0xK?=
 =?utf-8?B?dzFtaHdoMHduRjhXbXFJVFJZb1JhUWgxTU9HRlA2d3FoRUZka0ZYVlE5L1lE?=
 =?utf-8?B?QlNXS0VsRTkyRmtQTE94OWQycFJlKzRMTTVsVEpqVFhtd09qeTQrZEhqM0RN?=
 =?utf-8?B?eUZMeUZoRzMvbWVTMUNOSzZBWVVIRXpTYWRsN0czZFdNM0dxUHFwRVB0TnpW?=
 =?utf-8?B?ME13VTJDcVFna1VRK3lpRERzNEF1NlJXRTd2RmRDRnZGS2ZaMGR3Nm9ONk5m?=
 =?utf-8?B?VjBxMXFiZ0ppc2pGWkpBUzNSWmFZSERoTktXTTRtTmx6eWJUaDJxRTJpZmov?=
 =?utf-8?B?QThUUCtaWEJEUUtQck1VUWY0UnZzMHBGcXhIMERSaWl4bkhTZWhuWFFibWw5?=
 =?utf-8?B?YlA0NzRrL25EeGR0RnB4Zm4wRUpnRUczOFBOQStzOVpzamxQaWlmMjZmTGJB?=
 =?utf-8?B?VGhoWGtWekJpaTl0ZTVmNDFqRlRYVzI3U1B1bGFyMmpyWjFQd0cwRW5ON2Jq?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NXpjZdbqEnP8ZeyNhvICiLE+4ywLJaL49ayg0tXFce0HpJZbh5DpPxrLZRVs9Q8uo2thlOIl9vBGuJ5/Z7oHKmPyEIma+Ux5C60d2RMPM98fyfgMZFu2PG+8ZBPFR+c342pcCV40ENRe39vwOhosQNCzerpopR7VCnNEc+mgo0VWutUq9kGKE7KNToQoaFJgHdzksrPy6A7sXRkGRL6tJyJxpYRfdMieubgnfCUzf+j/+0CoYK0lLPOfSWHLINMLKNTfSHv7TGlAZvE6eC0ks/snnsCErkerPBi9E75XPlF1BzBxlQmwTAGDkFjE9fUb7QWL++P+6kqLBQI3Oa1E33BhSTeR+aX/J3Q2/9X2VS3iJ0i+tGXb/+bmsaxWG5WVz2yW4Yi7XTKFDO0cAHt5afxjKcYkNnwLjCsg04Q3W/aZ2UuINt3kMnJ+opS8G5/QztyUkymZSJoUIbgTrewlLSL7ayJZmslThnkFpZPSzo89O5Hr99eZC7EwR0dj4ifq/1CO+Czk77CvjhBiiScD80+6B9TRXdkaaTHQG40WtgHm9r37EfL4X2iboNBCSVodD4fMkBCB43eZlCRaVM7gw01NBblgVmwjIEU6OBoSfrMs6nlNeSRJKEv69qJ9XHNqr66dF5Ia3TTPnvGVmOP3xJUC3l86kETZjoNFHxEiCJFWpfX6slvzC9W1wh1UY6xIeAClCB6HsuZrTs320TFZ6qEaMoll7jarO/IGr2cMlv92pT2jS7cn8I6G3oX6FH9a8fR9YUEh/4Il+ozE7Bu8SpR+i5B2c9io+eQmFTd/ednyCd74CyqDN4dFuj9EErBp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dac918-279d-47da-f4d5-08db7da0ac94
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 21:42:04.8228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP6bF5CZBgmS3XjnCvhYjy5ENf2EmSp/hYGshRaR0/3eOH2rx3VaONrlMyXEv6DnKyXFYMeDQX18Bcjj6TPfT5IQXisZHmaQ1iMEakMGTqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=964
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050197
X-Proofpoint-ORIG-GUID: ZW_yr5e7P7ToSGVn-Z20DPCOMemC5r64
X-Proofpoint-GUID: ZW_yr5e7P7ToSGVn-Z20DPCOMemC5r64
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/5/2023 5:33 PM, Steven Sistare wrote:
> On 6/7/2023 11:58 AM, Peter Xu wrote:
>> On Wed, Jun 07, 2023 at 07:35:32AM -0700, Steve Sistare wrote:
>>> Modify migrate_add_blocker and migrate_del_blocker to take an Error **
>>> reason.  This allows migration to own the Error object, so that if
>>> an error occurs, migration code can free the Error and clear the client
>>> handle, simplifying client code.
>>>
>>> This is also a pre-requisite for future patches that will add a mode
>>> argument to migration requests to support live update, and will maintain
>>> a list of blockers for each mode.  A blocker may apply to a single mode
>>> or to multiple modes, and passing Error** will allow one Error object to
>>> be registered for multiple modes.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Hi Juan,
>   This stand-alone patch is ready to be pulled.


Ahh nope, it has been too long and no longer applies cleanly.
I will rebase and repost.

- Steve

