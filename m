Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A47480AACD
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 18:30:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBees-0004FR-0l; Fri, 08 Dec 2023 12:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rBeep-0004FC-VA
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 12:28:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rBeen-0002t1-RL
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 12:28:59 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B8GBk9f024162; Fri, 8 Dec 2023 17:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Qz4O6Bh86JivV3Y9VmHIH78LAgHaOlHwkDeX2MkuEnc=;
 b=DRwOXzQdiRsxjnHzGwI/6wgzNE3a6mOeRIN8P8CkkMe1TwcjIext0ry3g7R1YoJnLN4k
 A4DNLB/+vZlr0qAAdscpud3C0oYJoHsX9P0wHuX8pk6EddLtVfEqNvkvzWNZBvMqvGyp
 z44wH773Ah8mNscqBsYz3PON2RdXOgUHBZhJf0edvAaEAC9AzKzT5kuitAVVdQJJ5aNW
 9SPrr3Ws14e0NKZRy3yteUidctsL5axmHPr/Ms5TKr+sjDP702zqtAVx4N5xybXz6NhB
 iLzDhXx9pao7pkj6+zRiTEK1kg9Ctr7bZDtn2KTC9YCtgWkIfRg01dImWXxnhGjx3nY4 9Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdc1e98y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Dec 2023 17:28:54 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B8HReHX037488; Fri, 8 Dec 2023 17:28:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan95ykb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Dec 2023 17:28:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhE92b/FOit4OHYQkSC7MDw6Xe3qb0uCgm4jo5NQxPQ6YwNQ75gLu8PyytH+ZTp/gwzwUkrQrvf5AZyvFrnc4CtJGYJ2MyTih5kddCYyqh0x5L7n0+3BBmaUG2fvf1qzW3vPqHjQq4dDlZ2wuojdijBeY6sOsa+hDQ6MC9RPSqTje5yanxXLqQsZAUZsKXxZHTMu3QguHY1E2KL9s8iq34i+DGnezGPppZDeUoVv+mDiGh0ygTlnDP9D1hsK/OwxCbc4lM00kTQI+D2zRPzibPA36x3zvfTa0Xf5LzOPOTrGXE8EfWT9hdMYlrGDMqfRpeCGbC89oE89pylvH2Etzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz4O6Bh86JivV3Y9VmHIH78LAgHaOlHwkDeX2MkuEnc=;
 b=C0EuphE0wlKEZus9z96RMvhNMHzNS8XceJxKHS5W6uQfElNXfVnw5K8kBV7H4/gaXzjIi4NQiCWtr6N5AhtUcref+x06Yoc/EBhh+k3vQjA1JSRnpbkm3pAze3g7rAWWuQwJFNxUqT/4Zg2+3xbmxtVpLPsU582zne+mOWI8379E1tUqmIKKNL4BPYjYa+yZp/2vvbz92JDwZyWYYw6WbHanV3/9ZUFsuO9Jh4Fh56VRTsif7MchDTzSGCSDtAWWuAxbtl9KCsszw/sBq20mCFrBuQzChpjZrDToCCInZXc6dTj4Ub8m2prbxejCpZUZc1DsZGvB0Xr5xiXMqhQ2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz4O6Bh86JivV3Y9VmHIH78LAgHaOlHwkDeX2MkuEnc=;
 b=m1L2hlugJOKqxLzaxmQp8o7Ar0A2CGY1NmtMHYiN4hPwMmB5MICxyzj/JdBkm4xIoE1eI/x22hPs0JUx6zWIPe1xoRc5bPafxTKJNbMes/Jxz4vieggiQ4IypDSrJeo3m49ZFUOhD6rpUeWgNxjXbTNNuBDhbqBOs/CwFYb2avs=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA2PR10MB4618.namprd10.prod.outlook.com (2603:10b6:806:11f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 17:28:51 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7068.029; Fri, 8 Dec 2023
 17:28:51 +0000
Message-ID: <96222c49-9952-4192-ab55-8714ec66d5be@oracle.com>
Date: Fri, 8 Dec 2023 12:28:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 05/12] migration: propagate suspended runstate
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-6-git-send-email-steven.sistare@oracle.com>
 <87wmtoy7k7.fsf@suse.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87wmtoy7k7.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA2PR10MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: f41c6a66-976c-4760-5406-08dbf81324f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7ITXib1zZNjqYOLxYmh2DZtduQ1z+4ItBhWzSXEKDtLOwKmeqJBJEg/WW4m43sAka328vwSJbuxVAeD1MWtxN/8NvCnhlmVkhQlcgpoqyhKU6ilcOFAub9eH6dzEWunpiBjexxD8NYE2ncJCx/tFawCyb8xaLZTeiS8xnrEaIsr7fzkhMHuZEx8v17JBqXJn7YerCR9eokCp24pMiyfYKW3Y98NSz9x3TbFb2YURsLQ0boehqTj9T+RCtQzvXz2npzKpQEp+zF2jM2Ns9085R8MV4tOTXYF0dduZIKmlKTL4JktbbR/C5qv7uN6mx/oyl1A9VkKBLT56YvOXaFYxgjE+f/aOhb3JwPhFO0Ogz0O6YjkC7VR+FbVAQNI8Aqork4PJs1BTTlGwM02mYYeISv7wjw3mykXVgVC58ss06ILfylD+4If5UlzpRni1+DaQmjRaOO4INg5Tvy5BlX+ybPqkyBYMacWg+BXUjsWSLpeg7DAsfyiBNnxWn6utD4W2aYybXOScTJ4Yb81q5zMcR8iQWDfAX2jCL1fFn5jfNgEUQvFMWmL6HmiratHoIZ0gzbS3QhHxJY+OsELdwrqqt2h9av/oAiaGAA64JnJpPFjSpgpq0OPFxen1nYFx5aSGDREuG+BwygOePlp1VdGGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(36916002)(6666004)(53546011)(6506007)(6486002)(478600001)(44832011)(36756003)(15650500001)(5660300002)(66946007)(2906002)(66556008)(66476007)(316002)(54906003)(4326008)(8936002)(8676002)(83380400001)(31696002)(31686004)(2616005)(38100700002)(41300700001)(6512007)(26005)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlIvSGRmc1VMRlBZOVVCalRSc0RXR1g0RXlKdlNPa01IaGN1SUVITytiVVRV?=
 =?utf-8?B?MFVGbEd0SE5nNGNtZnJXWnJQM3lNZnNYYjJuaFhjTjFkNXI3RXVpV3NKVFJp?=
 =?utf-8?B?VTI2cVBOWUd1d0gvcDJ6QUp4NXE1NVovYzZoTjhrZm1Pem9IUFo2bEhDL0xm?=
 =?utf-8?B?T2t0OGNFdXd1T1FQeFNCQzBLZXQyc1RXOS85cStjbWhMUE5FQkJwelVMWVYx?=
 =?utf-8?B?SGtwT0kraXpUZ1d4V1cvQ3YyWnFTbzlHalhBYzY0cDRhZ25Wb0ZwNWVNbkY0?=
 =?utf-8?B?NWxXTHFHdUFkMzlYOXNqck1VWU82WUFtdUxhRE5ZY2t5RjNpVlg5KzF5ZW1D?=
 =?utf-8?B?S2lvZ0tIUGFHb08yRFV6U25FQ0RiSHp6MG5XdHpOeVJuL3RWbWpQSHR0b0ZY?=
 =?utf-8?B?RHBVM001a0htWEpNelZHVUVoU3d6V2s2ODJ3M2k0NWIzUlZFRk1YOGUwSlRo?=
 =?utf-8?B?cTNrbm95Q3F0Ymt4TXdNTVZUVHhoK0ZOa2lLTmduRFlMTE9QdGEvMHdPdDdz?=
 =?utf-8?B?OVN4dUluTEhra0NkZVdsT2FkNm1XWDhGTDB2STNxNUloekhtdTZON0txT3dm?=
 =?utf-8?B?QnEraEo5dlJHc08rQVBoRkhhdk9kcDZiQWVHNXBjNVZoOStkeEVvVFhUZVF4?=
 =?utf-8?B?U3FuQzFuL2JFemFUeGpFNy9DZGtGRm5pdGEyZWVCU3p6NE5YcTZpSVNlN3R4?=
 =?utf-8?B?aVdkNUxPUzZDNGlER0R0VjJ0amFhWlVOdXJ2dklSRXVUdENYem1CdXJPTEpS?=
 =?utf-8?B?Zy9qT01IM1V6c2c5aXBYaSt6Zm1iZzFSdVlWQmcwalNCbHVkWk1BNnE1ZEdy?=
 =?utf-8?B?SEFjRWIrcHBHSHkxdUpmb21wUVFEdW9PWk01Ni85MXJ3VFdEMEVXSC9ubFRL?=
 =?utf-8?B?MG1pTUdnVGZJVWExMU50blFxWk9WQ3puc3RwaVlBYUE0TGFyZk5FUnBYRVdr?=
 =?utf-8?B?ZDdldHFpOXp5VHV1V3hZazNvak5TcHcxZW5Ba2k5UndDSG1XaTRlWmpqQTVm?=
 =?utf-8?B?Y2xScEZSZ2VwTDYzNHRmcVpneURBZ3BobkZzTExYcm9JQkJhNkFuTUwrc21Y?=
 =?utf-8?B?aGtZYlc3V3Y0aXdGeUlVNFVZNlZpbk5wa1NTamFEa2RVc2NaWW94cjNWU0xG?=
 =?utf-8?B?MUhPZnV5UFFVcjZncTVxRXBnM0hxQWt2Ui9oM2pTTEw3eWVJODdPalBGenM5?=
 =?utf-8?B?czFHMVV6M0Ewa2N0K1p0c2lPL1B5bVNUWkpqc1UycllsSFJsK2Q1MVhmdzdE?=
 =?utf-8?B?a3dlSllqa0RleXNmZ0NJdXE2Rmg3d0pFTHdBU3VXS1g3d0U1TEg0S2ZNSTJs?=
 =?utf-8?B?YnZwZ25vKzNSY0FNSEozVElCaFVpOTBVQkNzR1JlOFNsM0tjQTNtQ0JNcGgx?=
 =?utf-8?B?NFVScDcwckEvQmwvVW5HL3dLUk94UVVYUkFtc1ZpYmtZZ0txbDJkOTAvZUFh?=
 =?utf-8?B?U3VxSEpjdXhMVkpxNFVEYjBBd2xhMGh5UklLRy9qT0gzUlFwUmJlb1NXazhw?=
 =?utf-8?B?Wmw5dDByZC9WSzBJZ041SEJybW9lL0UxbHFuZ05WMjk2S3lGSnRlRFVzS0VN?=
 =?utf-8?B?YjFFcVJIYzhqRVVXdUd3Z2RYTjh6RlNrcW1vTlBRNytKZklSTkd1VUlNWEhl?=
 =?utf-8?B?ZXRHMDJ6QmNSelRCUkZOWlNUWWZYQjg0eXBlRXJSTW5GVVRMTlZsVlFpZFhq?=
 =?utf-8?B?R05oMEdacWo3WUlCZkZ6UFRkY1lpeFBRWVRXWTc2MnB5ZUhiQXBBT2NlcWNU?=
 =?utf-8?B?SkdxYnA1QURvSklXUVVMOGM2ekxFVjRDaTkxTUpTMkM2V2dDeHcvbHh4SFRF?=
 =?utf-8?B?ZXkxZHE2U1M1YkRCVmo4cWwzbFoyeE1FcUhvT21nOTQ2NElOR29mdjRKZHBr?=
 =?utf-8?B?Y3lvMTJVOXVrcUFPTUVVWWNPcStpSFBlckdRaHpGYmNtYXBuUzBxVFQ2Z1Jk?=
 =?utf-8?B?Z3pVbGtLaldVQks3NXRnL1RidGUvRko5SDd0czZMRHZlcGdoWXlxT0RkNmhy?=
 =?utf-8?B?WXVOUGNFbEJ5VS9TWE96Wm55VC9xYWViVGtPQVRYNVNncVdKb1VnMytJZnE2?=
 =?utf-8?B?M2RJZFFVVks4SGt6RjEzYkVndXZkN282V21HQXBwc3JxWnBneVRUaVFCRjUx?=
 =?utf-8?B?dHpGdzQwemJud2hDdnV3MlRCSkpvZlFXUFkxTk1mWmRybVR2RmJweWJYbmlw?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TI0To9X7dvPUcRAlAX8UGCrLylK1A/Qilw6QkQmmtLdMHCJz97jvsUrfN1M4K8Lcgj+YqnfpjCwtK2hPJgkrzZDU70J0o9bUq0kuMjSuGHwWbuK74kcUIaXCrGaOd1lTv7uoU4rFDmtfim45RLW7AS/0cWRZ/7l21mQATsn0bPRIkre5QObZRNSdGz390xYeD7kzR7pmSOrQ/2xxEXrsNTMRSM/R9EKj6y+7OmGvsnAm8s9YXO0+i8XZ/oX7O0YgedCuairbJxJwk9xwHLShwpwaT6yiFKJvSL9WR6j671h1am7U0uKSlfrtlLIKabvbyPzF/dKHychz0LOzVWF7IYJHMVqYhw/CV5lHX3TY4I6xcxdBRZuGDGmxlUVzA5/PMTSNm/rHpSMeKjLrJ2wX792hNZ0P3ioADQpb+FoOsJI3ZquGO6xXW+3N9fQl+7QxEFMDCnkko2HPUHyKuueFOpzgZB9ITuP+VBTdMDjqUccy9Mp2B+Hx/Uj/p1mVb+PgwpuS0g+JQZlmBW7HlkZ5ZJpGob1zOde8A/CtxIcTZnSZDWI4UsFeTVnMsfRkXnP+J7TjlYrMMvkP2VAFBvVwihzgi63L8x9II9KobD8nA3Od2j1QTx+3tGOnhqpjmeE/j0s/QmrZ97nv+Xj/FWXmmZSBspf2qbKfdW7hzPgA0ojJ9K9j9VNCgIxi16TbBHYpQt6s8Pd/4A73seHhJFUIgbH7UyaM5wPOsatwnQNtI8dGITXIS+7CC6Z4SY1kRoDvs/fyZHhh8db0MDirdtJ5R1kfwfjssyJnHCrP7/TBBZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41c6a66-976c-4760-5406-08dbf81324f3
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 17:28:51.2576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1WKCNtRc+vjmo+/Ctam2dDOBqnv12z08+AF9jo8JxLQMKSBOYHC53XMsUQiI2b42sWGOS7xMoUDnLs0DzMo7BCkM/BAh4OLfONY7rJ1OZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_11,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080145
X-Proofpoint-GUID: OHLVuBvX7NpBlJn4Gak_3gfpWUaYUKre
X-Proofpoint-ORIG-GUID: OHLVuBvX7NpBlJn4Gak_3gfpWUaYUKre
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 12/8/2023 11:37 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> If the outgoing machine was previously suspended, propagate that to the
>> incoming side via global_state, so a subsequent vm_start restores the
>> suspended state.  To maintain backward and forward compatibility, reclaim
>> some space from the runstate member.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  migration/global_state.c | 35 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/global_state.c b/migration/global_state.c
>> index 4e2a9d8..d4f61a1 100644
>> --- a/migration/global_state.c
>> +++ b/migration/global_state.c
>> @@ -22,7 +22,16 @@
>>  
>>  typedef struct {
>>      uint32_t size;
>> -    uint8_t runstate[100];
>> +
>> +    /*
>> +     * runstate was 100 bytes, zero padded, but we trimmed it to add a
>> +     * few fields and maintain backwards compatibility.
>> +     */
>> +    uint8_t runstate[32];
>> +    uint8_t has_vm_was_suspended;
>> +    uint8_t vm_was_suspended;
>> +    uint8_t unused[66];
>> +
>>      RunState state;
>>      bool received;
>>  } GlobalState;
>> @@ -35,6 +44,10 @@ static void global_state_do_store(RunState state)
>>      assert(strlen(state_str) < sizeof(global_state.runstate));
>>      strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
>>                state_str, '\0');
>> +    global_state.has_vm_was_suspended = true;
>> +    global_state.vm_was_suspended = vm_get_suspended();
>> +
>> +    memset(global_state.unused, 0, sizeof(global_state.unused));
>>  }
>>  
>>  void global_state_store(void)
>> @@ -68,6 +81,12 @@ static bool global_state_needed(void *opaque)
>>          return true;
>>      }
>>  
>> +    /* If the suspended state must be remembered, it is needed */
>> +
>> +    if (vm_get_suspended()) {
>> +        return true;
>> +    }
>> +
>>      /* If state is running or paused, it is not needed */
>>  
>>      if (strcmp(runstate, "running") == 0 ||
>> @@ -85,6 +104,7 @@ static int global_state_post_load(void *opaque, int version_id)
>>      Error *local_err = NULL;
>>      int r;
>>      char *runstate = (char *)s->runstate;
>> +    bool vm_was_suspended = s->has_vm_was_suspended && s->vm_was_suspended;
> 
> Why do you need has_vm_was_suspended? If they're always read like this,
> then one flag should do, no?

has_vm_was_suspended=0 means a legacy qemu.  Currently the dest has no reason to care,
and we treat that as a vm_was_suspended=0 case, but I want to keep that field in
case we ever need to know.  But you are correct that this line can simply be:
    bool vm_was_suspended = s->vm_was_suspended;

- Steve
 
>>      s->received = true;
>>      trace_migrate_global_state_post_load(runstate);
>> @@ -93,7 +113,7 @@ static int global_state_post_load(void *opaque, int version_id)
>>                  sizeof(s->runstate)) == sizeof(s->runstate)) {
>>          /*
>>           * This condition should never happen during migration, because
>> -         * all runstate names are shorter than 100 bytes (the size of
>> +         * all runstate names are shorter than 32 bytes (the size of
>>           * s->runstate). However, a malicious stream could overflow
>>           * the qapi_enum_parse() call, so we force the last character
>>           * to a NUL byte.
>> @@ -110,6 +130,14 @@ static int global_state_post_load(void *opaque, int version_id)
>>      }
>>      s->state = r;
>>  
>> +    /*
>> +     * global_state is saved on the outgoing side before forcing a stopped
>> +     * state, so it may have saved state=suspended and vm_was_suspended=0.
>> +     * Now we are in a paused state, and when we later call vm_start, it must
>> +     * restore the suspended state, so we must set vm_was_suspended=1 here.
>> +     */
>> +    vm_set_suspended(vm_was_suspended || r == RUN_STATE_SUSPENDED);
>> +
>>      return 0;
>>  }
>>  
>> @@ -134,6 +162,9 @@ static const VMStateDescription vmstate_globalstate = {
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT32(size, GlobalState),
>>          VMSTATE_BUFFER(runstate, GlobalState),
>> +        VMSTATE_UINT8(has_vm_was_suspended, GlobalState),
>> +        VMSTATE_UINT8(vm_was_suspended, GlobalState),
>> +        VMSTATE_BUFFER(unused, GlobalState),
>>          VMSTATE_END_OF_LIST()
>>      },
>>  };

