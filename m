Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C68A77EC8F2
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:50:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3J4i-0003BY-P0; Wed, 15 Nov 2023 11:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r3J4e-0003Ay-7V
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:49:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r3J4c-0003ic-0F
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:49:07 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFGXuQg006632; Wed, 15 Nov 2023 16:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OEOpJqVEwHdFKM7AJvqk4ZuZWmZvTC05fo8QyMp6vl0=;
 b=3uo72Y5iDpp+UI6e1nFhW7eoqGGoScaIhJ+x/Fuz+XrYGDFab82/IMICmV2CzBODwinU
 Mnqlj8dkca5G3DeAJx7LI/o+9+j5NDnNWTYE0xBzjbDC6m9TlcoMAHrwDLLGTcAQhf6K
 C6D6LWHNDtPTV8hnSLUKEGOLyCQX+xJeUNeUVgqMij6jUI21cuwg3zH0zaeq7m5k0a7g
 CYf06sC0H5gC2VSkwzm9L0I6bI4U2GfblBQAG+dBF9CuRXJW7F/l2cWecZc7a3bUztaS
 nqOATKGoyIvscVnN7DpnpCjGEX0PFcS6WWaZyPADfvT6uQOa5PrhpkC28MOxXchEGPuQ MQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd9059-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 16:48:58 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AFFbA2l006791; Wed, 15 Nov 2023 16:48:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxh3dheh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 16:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0Fx2KN+2VsDK2aDsvdOFarVhzrYn7Wc+HiUU8cMldNq3HehsC7XGZhl4o52pBO1yPjItMvv/VciLjTDvlsSOzdVDeQPg4qT4uBd4ycWaeKkAM6RUAmQ9e4ubCqnAVH+FPZnnh1t3yRPJR+b91zj9UjbPrWids6mQ9xvn4HA8BBTp4yO4w7q4X+6pmmLFUR0D5us/CpIBpBI61J0rkQtlu499x9bD+lC4aXUuoiNZCyfT3PcE7WsLczogyGCkUz2fLlaxWbv0TR96R3QA2l8zQGXshh9QftXCIB3b944z5Qi2/ghzdMxHbEsPQS+DXjymYSTpvTCUbVZ03VdJgr7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEOpJqVEwHdFKM7AJvqk4ZuZWmZvTC05fo8QyMp6vl0=;
 b=COamdDfS1eSStiSsnJOM0kaLdlExo4UmSNGYFDFrSFnQRA1bpRLYf96FZwq2d/nYcRgXp3CCQTscEK3+mI4IpT20Z7xJY4ZQ565ViuT3z2kb/xIRJ//RkY9/gIp1T6nr/PIm4fiuLJ0vKOyJZczOtNCL5elVwziQnVIOs7nCIyKCUGtqzmKd5QiTMWM1GA5CnCF6a74FELJMU/i9TpL+kg4HP8j0ewVcDKhFIuwGiKGd/hI7A+RgiE9rKhHeXw6F7XsHYLEwPXjHw3JaKkIFyeMcmLgdU9tQ+2z/hHz2jiJkKmd6JrlwkqnLiJSHh148yIYi9OPaNBV0UxpPcmfbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEOpJqVEwHdFKM7AJvqk4ZuZWmZvTC05fo8QyMp6vl0=;
 b=HpeJzBnSj4mUnLb7sQcpyyhS4JAPKHEeZPI7wdkA2eIX1y7mFrbfMpHMG09HBAdpZlwE39g0XwX7UqcWmWxmrVY10tFXl7AlIPtBy0fkJ3uYLqwa6cCQZW+0MZSWN8HiE8ApqhTTDkPJiSdGEx21u/U1q5qCqCBzqSi1qKWMzrc=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4412.namprd10.prod.outlook.com (2603:10b6:806:117::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 16:48:52 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 16:48:52 +0000
Message-ID: <744c3e8c-2908-49a2-807b-2951b05d0c17@oracle.com>
Date: Wed, 15 Nov 2023 10:48:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vhost-scsi: Add support for a worker thread per
 virtqueue
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20231114003644.7026-1-michael.christie@oracle.com>
 <20231114003644.7026-3-michael.christie@oracle.com>
 <bucsvfqgs73w73tt4l5z35smccpebjq36hcozpgrkeydm3jumj@zisakm4noecq>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <bucsvfqgs73w73tt4l5z35smccpebjq36hcozpgrkeydm3jumj@zisakm4noecq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::31) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 7411c4fa-db47-422d-a5cb-08dbe5fabf74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kp0U1AVxyGp35URXW3nohXh8U3NfRM+ItOgAX9q37NwotaiFe1voHmVRvBrXuaDLlSN+bhfDaGrXqLR5LCKM58aTwsuvyKZYCCeKzkBVgkFdqJuQPywCd3IwEXPcVa7yMJM8x8t2WI6uhCfL1YBtawW5W/l2mRfLnWvdQx46C0mDU9lJfcaGuAVN1ngPuUp5MUhiDxNXde2cnA61wqhu8fkvjgGmoJulQlpZ6jKRwSv2GF+3bGsaleJ7sZaMj2IONQjeHczqcgbdGjw3nD0p579EUEEFuZ/IsHeQkFaONg5ufc+v5+MfU3yzBAccJyE6oRfQaz2EKafTajSlAe7qyjtS4XbQM4SB573rDf2wx3NJyJGHVeUFUrDuKFZfr04rRhgsg3I6TWEpkHVjxFPYGai4FSwcMUx1QJVgg3a+/59PCGLaRetKU33S6dGtSQi4tYSGsPjTLmZYZuTLW02x/YVq6BlEvTw+RWa74+2NsVjpeftg+Gn6lNfUoVbnXp1n1w/RM5qBZ4mXCdJ6tpi9frumcjqtR9d5kodQKtsJDgwY8SjAADsP7kE0TmXu0bT2HD/N/foWrw1uR5tPxDrekN+GJJKaitH2IsjUKGzv2j+cpwDyc181Cpps7ZEN4zOg8L8AnqQCDru2ONT7H7krtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(2616005)(5660300002)(86362001)(31696002)(41300700001)(26005)(66556008)(66476007)(6916009)(316002)(6512007)(66946007)(83380400001)(38100700002)(31686004)(36756003)(478600001)(6486002)(53546011)(6506007)(8676002)(4326008)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS9Yd29HWnJqT1A3SFM0NTZIcVVyT3h6QjhzMkIyTDV6UEpmanBXOXl1UXo0?=
 =?utf-8?B?Q1Uxc0FuTTJUTU1ZTnEydnZQV2E5YzJWZUJ1NkdpZWthTThHeTk4SmU4NHla?=
 =?utf-8?B?Z1RLUUd3QWcvYnFrSmljUnJlKzNHbVpSZnlQVXpLK2xNNGJCSnBvMm9Ncjhs?=
 =?utf-8?B?WlEyWjRRMU1xQ0xSV1NVSFNORlFTdThlTTJaT1BJeTl1NlJ1SHBMdFdZemk4?=
 =?utf-8?B?S3hCZXdxblI2eUkybXdhakUzQkpqVnpzWno0UVFEdkliQktWbTBOTFpVR0Zu?=
 =?utf-8?B?RWE0R2swY1NZc0FxRU0xdTBqcnNmMXlZTGRNaHdhYVpYM0tLUCthRlNNcVo0?=
 =?utf-8?B?a29nSGZodGhoMTZKendXV0w4aGxidnIraFF3aEZhRW1hRnphOXhzK2RKN1Rt?=
 =?utf-8?B?a3FRTjVNV3kra1YvYU10eFJYUkdCTFNKZjlZazNRbmlZbVF6L3JCeVdGYXlz?=
 =?utf-8?B?NFdsZXNuayt5YmMvQlI5dnAwZjE3RmdwNWUyZk80S0x6SnJCZXh0Z2NNbGxT?=
 =?utf-8?B?YW11MWVxMDFndElseW1mZURGL2t2c1k3a0lqZlNuZ04yaWl5bW44UGphMjRC?=
 =?utf-8?B?MGgxR3cyNjJVNE4rNjFjOEVDM0lkZXFaNnpRZHJOUERhSmVZUjBsc0Y2dmE1?=
 =?utf-8?B?NnNMdy9kS2RSMnRJYU52VTA0eXN3VmRSa0R2YmNFb2laMFc1a0tBa0dRc0Fk?=
 =?utf-8?B?eE9DYjg3UlJveG1FSlk5KzJid1o4RW0rZ2ljQ2xKVW9UelVyT2dBWkgrcjd4?=
 =?utf-8?B?UGlaa0psZ0xadmFkWEJQcXExWUpXbHg4eVVqTlRsMDlSVFoyTEFiS2FXM0Qz?=
 =?utf-8?B?UllPWmJDK3ZPYVg2OS96aGYzUzdTYi9XdHpIWmxlVHdBUHVKcjc4T0t0OVBG?=
 =?utf-8?B?NFg4WituNHJmeGhqVEExNzlqeW13bHZ2OFFtM09teFErWURTb1AwMEE0YWln?=
 =?utf-8?B?L1I0alRyU1BjRG1IQlNhZ0NBQktsM2NxMmhEa0RndHNxOW1YYUFHVmJxdG5a?=
 =?utf-8?B?R1JhUFgreVRVSExLTzVQeGY0M2tQb2U1TWFFUXhqNWtJWmJiZC9NZ1Y3Q1FZ?=
 =?utf-8?B?TG8yakxseFMvaU5ocFFiWG9UOWJFU1FHdHVMMXRLdXc4T0FKckN2U0czQ0lR?=
 =?utf-8?B?VEpEZ2ROWnNUTzBFdjZPcUpqMkhLemNhM1J5NlZzZlZLK1hYNTNNL1ZFd3pI?=
 =?utf-8?B?OWpkNk52bVpiUzQ4UzZsTFBvdXdtVTRNTW4wUysvdDAzWXlsTEQxZndYUHlU?=
 =?utf-8?B?d1hBTXErMXRNSlVQWms1dUpFdHRpM2VmbG9zbXl5TUJiUzVBc3B3Q3Ewd2pw?=
 =?utf-8?B?cU14bUJ1UVlwNDNsVVZGKzhJaHc5NGl0R2d6R3pBZ0VYK21uTzVHbUhqUUh5?=
 =?utf-8?B?ekl0TStuTTB2UG43NXdaUGlKRjdDUjR3REVkV3ZodTlUT2phQTBXYW9RejQ3?=
 =?utf-8?B?dE1DZEprd2hiWmFJblE0ekMyNlZ6Zm1VYmxObHRnbGNMb3BlMS8rUEZzb3Zs?=
 =?utf-8?B?dDZ6UE0rOTFyalVMR0FIUTZadUl2cE9ZM0JWMzhVdG95azBOZTYva3U0NWxn?=
 =?utf-8?B?OG1EZjdBWkRxTzVWeUQyMHRJRnhmSnl3UERJallyNGd4blBXMWtEQ294MGh1?=
 =?utf-8?B?ZUJIQ1locmwwbFdtbWpNdWU5cEw3Mm1xMWFCMW5tWXh2N3FucFJKTS92V0Zo?=
 =?utf-8?B?TzNWdWUzZGZDQVZWTXU4MXFOUEdSYWs0RTBkbTJrd0JqKzZ4SmliRzBJVzJN?=
 =?utf-8?B?SEEzUFY0dHh3c2FLeThaY3kyeDFIb2lzQnZDOXlDT3BJc21pa2xOZU1NeFZs?=
 =?utf-8?B?bWE0cHBFUGZVOTBNSkZmZm56b0lMUWpWanIzOEhJMkZXaW1oL0p4ZHVQdFB5?=
 =?utf-8?B?bU1nZWNUM3FhSEpkQnFrc1pmaVVuVzZTMEttUFIzaGdHRWp5ZUlaTXZsWm9B?=
 =?utf-8?B?QzY5WmpyUHFiSm9uOE96QUFKUk5KSUh3TlBxUnBoelBWWkVNbExFVnhhRFFv?=
 =?utf-8?B?TGl6Wkc0ODMyOE1FWHByYVRzR0JodjZLVHlkaGlsbzk3bk9JaGtnWTBXeXB6?=
 =?utf-8?B?STY3eTJ4ZDBHdWdUTkU1Zk5jTFVZeVd4NzJEUkt0cWRZTkZJclY5NGptUjR2?=
 =?utf-8?B?eENrYmlCdldvVldxdU5PRmhXaHJ0V1JQckVHZUI1YjMya1hXcmJyNHFnQ051?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aek8M2ZFQPff+sXbOvNI0gYAm9lXIUE2vVo0IOnZgFPb87h3DyWGeVWCjdGkeMgFp+/n2ljV51gmG+YnvNYa/3oR6ANsjxVMENM8KlcxEaqYi9MefSrlZcTZ/2OybX7lbPiE/yJMNEE5Y7VAqbZV2bOH48XxfBynmT9vXHhiXvQqEj1ss11a5NdJm3zRWJoiZVme71ejfHz/o5j2hSwvl65LWAyiKSkFNG3qR+adD0RgvoDnFD4M2YAt+xwNrEzfqjKUm51hRqzvfcuyYXhNM/eWYBNpReilHVZlARb6CdoE2TjAVkP1N+0c4ylAhUOXO/9WFgWcup//7oDYGzENiMOiI/3UdBQHfMuZrvrLBb7eJyJUPGJ9V9M+XhTIPh2HIUaDG2jEZ1e0ilaLupgZi8aTJeD6HeCGyL+coF9JDTRrkLPJ0OrdUmriJWNxxqYK/ZVUaTgmJHPvXXCCVa65FVOa2DVVVl2tVuYNmSGjl51GWoiajjvWXdRotQYnINHreVGjy5FLKkA7wRmqk3SjPxuWFdLGUHxTWGKOgrvc7t6fZxSsPRIVBjpsDqgJj1xhBuD1zpd+WVu247ko58YwHaLXoAr3+kyO07Iu6NrO/0AX4Xb04BIIhOBTi4gqb8XJ6kroPFvcaNK8tRdaClfWVBmexpsxneV2S/HcvP9jmkVbnx0y3b0pR2PLtb3DDby8sRsJ2ABsdPuxOFbqMBZIf859mqoHxxSNUJFysu6gCvNL2Kn5JxHeKX02PJAr6gQrA1huDJZqlYWgB9TiLM97sMdVGm5E0s1WKX+ilJnXeH0QV2GO8BfnoHk5JeARusXE
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7411c4fa-db47-422d-a5cb-08dbe5fabf74
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 16:48:52.0819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnHOksS8RhaPVmxp5R+/GG02tq8gvusAxxI0+h9faKtHWi/CbdSyePAjNQfEqalOWrmaHnzz7r7afRlEwy/Mxw771m6s2RSVrCvdPqfd88U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_16,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150129
X-Proofpoint-ORIG-GUID: NB4TzJJgiE6dqA2ZEO-yMRjkHMAS95tW
X-Proofpoint-GUID: NB4TzJJgiE6dqA2ZEO-yMRjkHMAS95tW
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=michael.christie@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/15/23 5:43 AM, Stefano Garzarella wrote:
> On Mon, Nov 13, 2023 at 06:36:44PM -0600, Mike Christie wrote:
>> This adds support for vhost-scsi to be able to create a worker thread
>> per virtqueue. Right now for vhost-net we get a worker thread per
>> tx/rx virtqueue pair which scales nicely as we add more virtqueues and
>> CPUs, but for scsi we get the single worker thread that's shared by all
>> virtqueues. When trying to send IO to more than 2 virtqueues the single
>> thread becomes a bottlneck.
>>
>> This patch adds a new setting, virtqueue_workers, which can be set to:
>>
>> 1: Existing behavior whre we get the single thread.
>> -1: Create a worker per IO virtqueue.
> 
> I find this setting a bit odd. What about a boolean instead?
> 
> `per_virtqueue_workers`:
>     false: Existing behavior whre we get the single thread.
>     true: Create a worker per IO virtqueue.

Sound good.


> 
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> ---
>> hw/scsi/vhost-scsi.c            | 68 +++++++++++++++++++++++++++++++++
>> include/hw/virtio/virtio-scsi.h |  1 +
>> 2 files changed, 69 insertions(+)
>>
>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>> index 3126df9e1d9d..5cf669b6563b 100644
>> --- a/hw/scsi/vhost-scsi.c
>> +++ b/hw/scsi/vhost-scsi.c
>> @@ -31,6 +31,9 @@
>> #include "qemu/cutils.h"
>> #include "sysemu/sysemu.h"
>>
>> +#define VHOST_SCSI_WORKER_PER_VQ    -1
>> +#define VHOST_SCSI_WORKER_DEF        1
>> +
>> /* Features supported by host kernel. */
>> static const int kernel_feature_bits[] = {
>>     VIRTIO_F_NOTIFY_ON_EMPTY,
>> @@ -165,6 +168,62 @@ static const VMStateDescription vmstate_virtio_vhost_scsi = {
>>     .pre_save = vhost_scsi_pre_save,
>> };
>>
>> +static int vhost_scsi_set_workers(VHostSCSICommon *vsc, int workers_cnt)
>> +{
>> +    struct vhost_dev *dev = &vsc->dev;
>> +    struct vhost_vring_worker vq_worker;
>> +    struct vhost_worker_state worker;
>> +    int i, ret;
>> +
>> +    /* Use default worker */
>> +    if (workers_cnt == VHOST_SCSI_WORKER_DEF ||
>> +        dev->nvqs == VHOST_SCSI_VQ_NUM_FIXED + 1) {
>> +        return 0;
>> +    }
>> +
>> +    if (workers_cnt != VHOST_SCSI_WORKER_PER_VQ) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    /*
>> +     * ctl/evt share the first worker since it will be rare for them
>> +     * to send cmds while IO is running.
>> +     */
>> +    for (i = VHOST_SCSI_VQ_NUM_FIXED + 1; i < dev->nvqs; i++) {
>> +        memset(&worker, 0, sizeof(worker));
>> +
>> +        ret = dev->vhost_ops->vhost_new_worker(dev, &worker);
> 
> Should we call vhost_free_worker() in the vhost_scsi_unrealize() or are
> workers automatically freed when `vhostfd` is closed?
> 

All worker threads are freed automatically like how the default worker
created from VHOST_SET_OWNER is freed on close.


