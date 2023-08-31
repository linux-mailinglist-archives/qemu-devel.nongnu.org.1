Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC68A78F258
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 20:15:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbmCA-0005BW-LL; Thu, 31 Aug 2023 14:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qbmC7-0005B6-G9
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 14:15:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qbmC4-0003uO-Mn
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 14:15:03 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37VGPtDa023174; Thu, 31 Aug 2023 18:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UQ27940KxfghG1lGScASPsFIbEmT2BjIKDLvVimO5eE=;
 b=xKn7azoUiiVwlAdUtw39057B0euJiTcR0NlbFi8nVTLj8DrSH45neGrs8JqQDj7uMDVp
 FtfrgkNvEpaaUoj5EadRqxspM4jN5Y5qgCP5QZ1sR+/HF+aohyMx+T9w1Jocokx6rNJl
 TJmy+vHJvE2D6564FlDcRgZUIIpoXhhUiSFmadvhOMhbiPE4kaDuPfG9LA4jOzkv8ldE
 YWvqGJ5aseVMNH8sgfyAt3KweLQs9yw9k60VfAJItu3PsypQk3ryj8crEak1XElGp6B/
 npeT4PWSLQcISWTEBGTc5S8F+Ux8UEmFdbIAWRkc4ocBdAWkVAaMRetULEPue7ZJx/Wq Cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9fkagq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Aug 2023 18:14:57 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37VHvahd032865; Thu, 31 Aug 2023 18:14:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6drtu1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Aug 2023 18:14:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCRU8l/Tt/P7GhPUqRP7SC69ls/1PGq320+ibb6b9u8TXw6KEzl8lZwUYnDmFiTgpcQa+NR8djRbckSOCzhvEvdO0JEsxNky25hqeaP1QcrLlZ3wvyE65OjUYVGu31MelTrJKn9cLOuEZSYMBrH7D2E8swxSvrCWgd4nbGnLp43y7h1m88PvJmQ/ev+kQcGLYKAOv4LH47oSVrwS79dsHlY2Ic1QiDJBzHdrr1vDSM/yc3ecLO+xpMyYC0IzdPYD22gzY0qZu/kS2l7Eo38TdIg6ovcXaqQvJtczJ58k6B//2LkC76PUtBeNdLniVOmxQTUwMCWi1/R0P7OIPpSeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQ27940KxfghG1lGScASPsFIbEmT2BjIKDLvVimO5eE=;
 b=KdtghOMe2YTDOPpTwTwTI/zti5ZVh1trFg4cjnssWf7IK++Fw7HHROgm9kmUn6OnDs2UeVYHiXqj2v0Ujs8IUnovpXE8ersvstVx/I540qoGtCQDt5Zk7pdVdv/7Rg888O+Q2Nx0r9mQpOt71At+FBIpfSXMj2Ng/0qRMiH1vHxB6UP5pNgf0CRu7KwkyrE9561x4MJ+oFUsx478uGOeWLqxRhPy9GSFGmV2rwCLCBwcvlyOEuaoeY4g/YMqjPJqRZk7j5xY5rrnsA+pZKgsRKuIpZItWMvUMxZwjtfI85LMbKreLQx+V3XEYtSy/yp793+umbCSJnk2vaNh15U/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQ27940KxfghG1lGScASPsFIbEmT2BjIKDLvVimO5eE=;
 b=MhbBvsxh6JYz9onG0i6zI0cCMhsteArI/roFxDtw58Op0cmosEFPZhPgSJqEx81zDVkUTUXJbRjKARD7A8tWEo918Z7OsP1pLXJZBN07gu/qqA9RtxfZffmtPofRAzssLjOpfnSO3yMFLkHOcbfBtseXhFrLd8k+08vzKfB7ebA=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CH0PR10MB7497.namprd10.prod.outlook.com (2603:10b6:610:18b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 18:14:54 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 18:14:54 +0000
Message-ID: <29067b18-c7af-745a-283e-62f3a2442980@oracle.com>
Date: Thu, 31 Aug 2023 19:14:47 +0100
Subject: Re: [PATCH for-8.2 v2 2/2] migration: Allow user to specify migration
 switchover bandwidth
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Zhiyi Guo <zhguo@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Eric Blake <eblake@redhat.com>, Chensheng Dong <chdong@redhat.com>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-3-peterx@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230803155344.11450-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0197.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::13) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CH0PR10MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: c549d828-d867-4b7a-de6f-08dbaa4e2cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DdZwfZNQBtsnl2KvTJbSoIOkov1cuow6IRiAuMrhU7tJyz+8Pwc3UbI38bXjykvsCTiayHiwcY7I54dOtvRk0eRFIe/CHqB8n0tGZ8/9QX9phHgTO5ia52Ir5To3TJaTlP4DZV/FKvQkfjkfNMyYj1kE/uSedzoGoxtw3y6sZcMEdg1ojfqIAn+5ST975jP5b27Q9FVyYWoYdslK8MCkiRKN5HujY3k7nKHfZyxKs+/Hmp35ThRW8yWGjLP9E69/J6UHQp2GAZBBgt9mG+PnxjG7y3wzN8nDXJkNMvfHXoysND1EqIXYC0F8blJ5tjTMfau9/gh3lDeEw6WdEiuMAVw4gxt0P+8x22tpFKk7I5yJIp+CceG6/gJgeE3Zh+EfP2EQ+OgYAwxZHdrP9yAbB087LQFW0OPTY6M9PDWae/dj5ymI1oJ2Ea43cnAB0DW6WXCnvVsFa2CzgDsgBYh2E8eJ1JiJ+eurxa4VYHdavDymRxwYkNm0HjDYupp9RZv2LIbB+DBO9nhEtNGTMngyxrr0uaqV30FY7OUTnXkfHDReqWlef4QKxd2b7yCbNSbAdB0udfNG71wPGRHe+A7dOK859BQbygp35nzGzkjFWayP9WTfbWhjC9mtm2eLSAB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199024)(1800799009)(186009)(31686004)(6666004)(6486002)(6512007)(66946007)(6506007)(36756003)(38100700002)(86362001)(31696002)(2616005)(2906002)(26005)(53546011)(83380400001)(478600001)(4326008)(316002)(8936002)(8676002)(5660300002)(66556008)(66476007)(41300700001)(54906003)(7416002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REFRN1hUbGxuYUdQN2RMbTVWZGdFU2tSelJsU0pZOVo1aCtsOWp5V1NoYkJw?=
 =?utf-8?B?RDBTaWpTQ29KdktUOGR6ZUsvdXJZMXM3SEx4WkZhclFOT0MyNUJQTExnb01U?=
 =?utf-8?B?bGRUTEFlOVRoVXdGVXV2aXd5NWdJdHpHbjR0Slk1VXZuTHRXeEZodm9Ja1lY?=
 =?utf-8?B?U0lRMXltTGpBMjFPbEpxeDBnN0xhMXZNTjZZNk85ZTAyaUF0dXlIdWJxWXVU?=
 =?utf-8?B?TENIVVZWNVNHNG9FZmJIR3Vkd0hNTGNmb3FiNEw2MTBIbjUvcUpBVXF6UWFE?=
 =?utf-8?B?TndTWlZEQ0pVcVRwOC95S1d4dWJMZngwaGZUb3BsUkI4OU50NmdDL2QrM1Nq?=
 =?utf-8?B?enpnaHNwQXBSblJ6czhwZ1ViUHNESmdWb1AzS1lNZnUxWHNyd0FoZmxEck9C?=
 =?utf-8?B?TjFCRncyWmZxaFRRR0NxZzlmK1NJU2U5WXFPZ2lBWUtFWEZ1ZUhLVWNoeHVm?=
 =?utf-8?B?ZUlzUFZpVVp3U1haaE1xdlJmM29MbEJJNDZsWE5KNUp4eWcwdTZXYTJlQ0ZX?=
 =?utf-8?B?TGd0ZGQxSm9PSnlXdUZCTmsybDFWS2tWMDgrc1hjbjJBWDB5Tm1Xb0xPd1pt?=
 =?utf-8?B?ZU1wU0psZ0IxTHpmTHVGMmhlZlpBd3M2ellEOXk1WTRRMEd4RHhybEpodkNF?=
 =?utf-8?B?a3hWbXlleFBIYzZwUUw0V3V5N05jZG5XcUlicFJROWFHUlc3OVByU082NEhY?=
 =?utf-8?B?dVlHeEExRUgxWEhTMXRoRHZhWEFGWHRIWE1PbCt5SGJCS3RWQXAzMTlhVUVm?=
 =?utf-8?B?d0h3eER6VkZ0dGJhM2l1WE92a1pLeUdDRisyK1RqTHNyZWhjTDRYVk9VSXVI?=
 =?utf-8?B?T3JUOVlWVkt6TTE0c1VJcjhpYjZGckFUYjE3TzJOczJrYXJxUjVCdzVJdjhU?=
 =?utf-8?B?NUthVWR6VFVuZUFValF0NlkrTHZzVDJrSGpEMmoxS0lWQSthQm5NTGZaekRy?=
 =?utf-8?B?cC9WTTJIYlY1bzFTVHZ5WFpFVDBQbERlMEJ0MU5ucnBmMGpYemltMEFBVEFl?=
 =?utf-8?B?MVhaY0ovRVF2ekpLcFZYcTlNbUZ1ZEhqR2FvR1J1ZmluT0ZTajlYNHBLTUpC?=
 =?utf-8?B?d0dJSTJUZGk5UmlTS3BqOVBqMVhSb1NiYnhjS3Z6NTdhdlhoV1d5ZVdFYk9J?=
 =?utf-8?B?SVZyMWk0SnY1RnpmMjdsUHkwcHZKZHFJTDFEYkVGbk5lU0hxM2NCR1cwQ0pu?=
 =?utf-8?B?bXpNaHR1UFVtc2V2dWZWY25BQWEvU3RtMmVoWEViQUNFalZSc2QzYkYvNVdw?=
 =?utf-8?B?SzdESWV3T2hmaTFOaGV0c1VVN3ZyUnhSeXRpTnRGaTgyS05DSnBwM0RnbUlm?=
 =?utf-8?B?ckwreU94eklrak9WUTFGc1ByR1dBYmpHUkZBZTJNRXpBQXg0K0xJRXlmblBQ?=
 =?utf-8?B?Vm5PMzZNMG90am9hRDVUTkE2UnF1WXhQQm05MVdJY3k0UldtWmhCMVNva3lk?=
 =?utf-8?B?cktqb0xHaDFLeTRZMzBFUHRMME0walJIQkdYRGJuc1A2UjFoaUhmdGFhQVk2?=
 =?utf-8?B?UTJ1UzRGaktWNGU4dnRiWUdSaTNYQi9UcTB2RXRYem9YQWlYaEVXYUtPNUtW?=
 =?utf-8?B?UEdNRk9JR3RydGRqdDJYcE53aWhkc3hva2E5SnBER2NiQnJCUE41VnY3QmZs?=
 =?utf-8?B?MXc0dWZHd1NOd1E5ci80ZGEzRVpWdkttUmFJK3NTUTVPVmJVcU5sdWNrVk90?=
 =?utf-8?B?NjhtcjlsVFRsK2psZlpvdTZwNUtDVU92VG9NWk5Qb21BaURTcEd2WXp0bDU0?=
 =?utf-8?B?bG1sdk5DeXpCWDNGUTdMa09ZY2VqYStiQmttMCtHQmJydXZRcm1oY3FMQmtL?=
 =?utf-8?B?djFnVk9WRmhmZVdPTzRtYWprOFM3TjdjVHhBeE1JdUQxVnRkN1NxaTZhR3Vk?=
 =?utf-8?B?WUxhUi9qZmRKSGs4MWE0Vmg1RHVNV0o2Vm9mL3VVVUJKWm0rRWhXUjQxdnll?=
 =?utf-8?B?TnlaYUpvK0FFQVVDS2VjcklvODVVNVpFTlo5RHdLTkxqVkc3MTBiYlljWXJY?=
 =?utf-8?B?OHpsMnE5d0Y5MVhDRmVFR3Z5U0IweGxsZjdiL2pwT1ZDMkxCdWU2ZnN0ZHEw?=
 =?utf-8?B?NkpUTGk3b0x4VjFja1F3UDIyaWRMTTNxbzZ2WnJpdUp5aGIxOU9JQmg2eGtI?=
 =?utf-8?B?SFAyaG13VTkrRnR4QlhvSGxXRkRHTHZqM3JZMVdmVmpoVUtxMGZzZ1dhR2kw?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i/ai0CqvywjuABVc4n+wB9kVEBCyMxtcxfH/wka9wQq7f7cgqn6AF0z8WfFtUkGJiaojru6AwhrdqXb4OIKa+uaxb8iV5xApCcKY/RW/AASFg6Q5AiVWX3Eu/i86OjmCFtR2qClioHYrYLDBWit25Dxk2iXRWU1tTkNoFGcTWxZ/3liAnlWKoK4qMA+3n1PMgeWTKylE1zV17WSA/vzu6haVKkm/0nxU/g6fAeAo958T1uMaMXdFW57SMouNaxYqaJhEFSQnWNb/u56uGk0n1DTQxNR98hHUXGce1FzXA7g3p4mRy5hI37NfA6Y6SsJQs2HY/poXp88vy3MvLkfziE7Q2auL2dhDXYdQjlFRKaSfLA0UY8+7R5njX2GwGmd6/M6JS16uANg0Fw+jd2uLisv7/d/g4noj0v+q7FV7snPRuodynuqmX6ttvMuuf5hxvvIK8kPcn2F3Ccm04y8lfNGwF8p4F+2jHckoOyL8BWSNU974g32kebwNIER/EYRw4rrgonVIXb+IsycnkdOy0YDupt3QCiUGl8dEHXbrHuo4UOAZv1eFtoSfoADlWMC9dtkw32xPCL32uIzu7vp89p9+pN6jefh8KvjrD+LkrFUMVMUqFL77kPqP3OOCxQs4pOI2jNQG7T7gRZ6rFVVoTEhQ6vExiQs2HjHMrE8WzwRm+VpdC89W4UFi2Q/9fHSY4i3fBGaR+MQH+XVZJ8WUMtrqXhKYGD4KD4OP17jZoQLC+EZrzNVramF6K7rjtYlb4KrPxqznkuVVoPF+ax9mdOMPUDm7ZHrIwzFROlZTJ3M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c549d828-d867-4b7a-de6f-08dbaa4e2cba
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 18:14:54.2679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHNZ8uDjlKIhvrl0G40kDyj27rKfiWX10uM+KHFcQkJvj9VYEMZogxu4Z2H/HbK+Tz37fBG8KK17bz81UfkWy3zXhjvZYS6qH4+VykpfBG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_16,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=933 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310163
X-Proofpoint-GUID: XbYRSnDNFKvOYDgFnPZuD4n5Xaz54Kxg
X-Proofpoint-ORIG-GUID: XbYRSnDNFKvOYDgFnPZuD4n5Xaz54Kxg
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 03/08/2023 16:53, Peter Xu wrote:
> @@ -2719,7 +2729,8 @@ static void migration_update_counters(MigrationState *s,
>      update_iteration_initial_status(s);
>  
>      trace_migrate_transferred(transferred, time_spent,
> -                              bandwidth, s->threshold_size);
> +                              bandwidth, migrate_max_switchover_bandwidth(),
> +                              s->threshold_size);
>  }

(...)

> diff --git a/migration/trace-events b/migration/trace-events
> index 4666f19325..1296b8db5b 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -185,7 +185,7 @@ source_return_path_thread_shut(uint32_t val) "0x%x"
>  source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
>  source_return_path_thread_switchover_acked(void) ""
>  migration_thread_low_pending(uint64_t pending) "%" PRIu64
> -migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
> +migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " avail_bw %" PRIu64 " max_size %" PRId64

Given your previous snippet, perhaps you meant to introduce
'max_switchover_bandwidth' arg, unless of course you meant in the callpath of
the tracepoint to instead use @avail_bw as the variable to use?

