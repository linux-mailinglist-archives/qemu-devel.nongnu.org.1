Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B97D40A2
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:08:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1CP-0001w9-MP; Mon, 23 Oct 2023 16:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qv1CK-0001vZ-IZ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:06:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qv1CG-0005Cr-AQ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:06:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NIx3Z1022377; Mon, 23 Oct 2023 20:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CIWu20uV8oA+/hTiHNZrs1hKf574ZLvsEIrlsGkWkOk=;
 b=l50l+VAZNFC1YNeuOOe6rjft5UFWNLX9S1ixYix/9RlB37HgIFfDBWPLFp45oUMKeIdQ
 IoxHP3Yw3VEth0abl1MPDPKuw0pX+JhW3Q9x02lkje9p14ffCtw1l7TJMMuR4SFvd2kL
 JrKam+hrwWUIc7TZGjxRT3nzBMhCDEX5iK38FqHIdqIVs8AK22pa4liort7yrMP5E3TQ
 LqwZN8UH8yg9C05egrSq54j3q/UE3iZ45nZEGzZiwt+0UUbNn5rMOXj6sUL6u43jBslr
 T1iVwD08WPsVESSm0q+ZGzU5ohjCL0sCM31DU5vzIXJDpeZVd/90m/lv/Hnoc3JpYXgC cQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e34022-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 20:06:27 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39NJaJRh034669; Mon, 23 Oct 2023 20:06:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv534em37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 20:06:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkzAUpJeBSS/qPKjNsUBb5Glyoh/qBxpGHhVZpY4Sw670iA7+thVCFgXgaAi09Fp8gFTn6NGl5NOAh+lFAA+GEcmQqaLW3IDWQz1xYL7IKIkH3aPNfuzXxSx+W9Go5+Ta0EvJEbd4wJ7Gpnn8iJuqMBD9Ny2tpm9ScxbF2Dc9WBq7u+FyoiH7/psr99PLe19uLzb7dYVg82QJ2aUJbKTYLP+pXAv8TbCQ3N8Jw9loNfYvP+jYgnFz2Uyp8Hkg0pVqPm07cDEc2eSCx1Me9hZ3ckGKBZXk8IjwHYECZs/gWYBw1D671/31szSYE/lAIbBLq63Gd60v53Wc5fmLajenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIWu20uV8oA+/hTiHNZrs1hKf574ZLvsEIrlsGkWkOk=;
 b=iMu10yfVqV9oGv01no48uFn09SGJ17OIM9zmygoayoTLP8JBKN1pXstRry/YIuq18pZto0OOWpNzgmubF9Lt1WI6jqXQdznmrHgjn18MOxdNnOXoBeLKxvZYYQv9MP+dt/lMMMN6Lgdin7D4PlKrHEf6NlaiD5Mg2dTXjuxEkFCPfXz1WQd/Xbe8WosO15ji8c/l8yAJXAkBd0QqPH8wJszWqW1P1c1TqXAaAwMZK67hLe2nId29TBHq8Y5HShXrIvh+cUWEYd1kxynAEJRPZ3SSwxtqZpTEhszveMVVmFemomDNaWuOkhU4IR7qMCo+7U7PiK2zNvFKUESAnJ34kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIWu20uV8oA+/hTiHNZrs1hKf574ZLvsEIrlsGkWkOk=;
 b=tsh7zb7F4Vs+jlzlgC9GadlF5o39EsPfra7RCb02LARsGEBXgpG7OAK6Tbw+K0N+OFA2fTB1oDKXwXe39Fg69pT80Xtn/1fZCE+gsf+QFZTOvLZ3hpm2CQS/U0VswB5AMZIWXvI+mQVj0v3+kSrC7G+P567xyoaPkX8mp9yhJ8c=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MW4PR10MB6461.namprd10.prod.outlook.com (2603:10b6:303:21a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 20:06:24 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c305:4801:5bd7:4775]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c305:4801:5bd7:4775%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 20:06:24 +0000
Message-ID: <c2a45893-f5d0-40be-b125-388d953650e3@oracle.com>
Date: Mon, 23 Oct 2023 16:06:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/4] cpr: reboot mode
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
 <ZTaTrEPcK2yU8MT5@x1n> <389959d5-6d15-4557-839b-575b43bd2ed4@oracle.com>
 <17f8d519-f86f-4857-93c4-080f0b18834b@oracle.com> <ZTbD9kL1ggc8UsVK@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZTbD9kL1ggc8UsVK@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MW4PR10MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: e785d2ef-d91e-4aad-26fc-08dbd4038877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pS+nz8BdPbWAxA4gAFNhgeKWpIH7t7yN+sQL9Op/zzT0iqiSliVGqkThA9Y4RhY7KMiYSlIozyA+90gRAwCQaHiQrFNU0WXC7T7zSYZWS1ZgZ8+mz1ddun3p5xSb0aXuO9/P2A+tYp+jx+3K9acHz19idt3edfIFRf2IuqR3/YjM5dP3PfcjsXlMV/1jbaybHxjWXHXlKc5XIv/4Gx8hVQ1XQNOCsqAXc3pVfle7OCL/J/w3JzHDhTssV3+09kv/H6RQvMjp0Hip11lOqllUqZIBco7VQWFOjIYE20GeJbGymzMUR/e9pqw5+u2v5kQ0ekYKE/h6fXJM0nhvO/oMnx0qRGtLxB+ISoL75kRyONfpZtdZlWmd2h31TOBPVobJIfxpxo9j7pRdpwxefzLvUVi9r3a4WAKhQuYBd3xSoEEmPlo/Cra2GEdkoFzIY/OaGRRJrlKiOccN2FNB8l67jNYvXNbtWmanR+WZEMt8ABoWTPkQe3ZPlX7MlbcnwDnofBXbdtk9rD7DpkitmrDBs9QsGb08L+gaRPksHEwDt6mhxii30CItOotLZgaNcN1vYUn6H6UxIR4LsUjKpypoTD1zidA489TPilbuBAU//hmf+BFa8rhsVRgIwE32xl21bF0+cvzOnWgs1jhMX64TsjiARuYJZ9Bv2lrohP+0RtB0ncQTPYaMvbRy6e0dPCji
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(44832011)(41300700001)(2906002)(966005)(6486002)(478600001)(5660300002)(4326008)(8676002)(8936002)(6916009)(66476007)(66556008)(66946007)(54906003)(316002)(83380400001)(36756003)(31686004)(86362001)(31696002)(38100700002)(53546011)(2616005)(26005)(6512007)(6666004)(36916002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dytZQ2VpV2pEMm5tK1FuVHR2SWJ1aUQvYW0zUzhidmlNNjJ3V1lSRnRwN2dE?=
 =?utf-8?B?NkdhV1VPdWdBRUlITHRyY2hmakQ5ZmFZcDEyTkNPdkpBbFVybjRwMU53Nlpj?=
 =?utf-8?B?d2ZIbnFsKzB4eVUxK2E3eTVVbUNkNE9aSGNuMzV2eDN0WW16aHkwbDQ2OXlJ?=
 =?utf-8?B?UlpsajgrZUpKVG5qMTExREYySkZXUzd5WVVaY3hzRHNiQmhSaG9tUGwwVlFN?=
 =?utf-8?B?cW9uYTBSOHpLeldvN3ZlQlE2U0FmNmRxQVNDRnk2dWVjNGlRT0gwVGI4YW43?=
 =?utf-8?B?RWhXbjdORUJuaHZaLysybFp3RVhpVFZKT1NoM1N5b0lML21uNUowa3JNeDk0?=
 =?utf-8?B?Tjh5aWxkUjVBTC8wVk9WcGxHczlSdkM3YVY5ZTA5ZDQvNkVTbXc5NDFZQmpO?=
 =?utf-8?B?TC9pbnB5c2VxOTNjQ1YySmw3RXlyRzBIeXFUTWtmLzc2MGY0eEpEZzdRaFA0?=
 =?utf-8?B?TFBuZWwva3NqclkrNDd1ZG1JOUk3aUdDbXFaVU5iNGEwak03U1Qzb21PZlM0?=
 =?utf-8?B?MzJOb3l6MW1RcUZJOEoydkFrWUh0MXVUalh5MytKY0dtTkRuRUcwOE0xbFNs?=
 =?utf-8?B?Unlva05hd2J4dnIzRjJvV0xJd244WDc5cVd5dU45MmV0dFNQd1drVW93eXdX?=
 =?utf-8?B?R0Q1MmFjaXpzeUNscjU2clN3SVY3eXVPdDZTenZDOFVmNkk0bDd5aEJLSGZG?=
 =?utf-8?B?eEhYdHRhaE9aa05yYzJGRFc4M2tPcG5KdEJsREN5ZC90UURhWFhnbEFUQzR6?=
 =?utf-8?B?cTRHWk1lZlVkaW9hNmkxbmg5MU5CMlRnNng0QW51bjhoUi8xYmlyc2NDQU5T?=
 =?utf-8?B?dVFPQUY4ck1BL1JtUjJXSVUzRUZyVVByWGRPajFUdkdjaXdIc3BTM2NmQVBq?=
 =?utf-8?B?RkU5Z1BJYnhOb0VkUUk3REhyNC9Hclk3R1gxa2hwZ2tJK3lCL0tMbGhqeThI?=
 =?utf-8?B?R0ZhaTZ6ZEhRdVlEc00xSVVXMGozZVRqZ2lqTVBZRUtUbTc2MWpLVkZ0eTQw?=
 =?utf-8?B?dGZhNUpSWXg4dUJoeW1zUGhUWm0zMnEreGlmRStzYTZ5ek1FWUZ4NUZJd2dj?=
 =?utf-8?B?VTJGcjdFc0E4Q1pQNXE0eEFZRi9jUUU1bGZGWlltS1YwczdneElNZmVSTC9B?=
 =?utf-8?B?Ylp6TFQ5T3NXZHhlcjdhT2RWZzZxUzFuSGRiKzRXaUFDbU5uQWhtcWI1ZzlN?=
 =?utf-8?B?dHNIMk8rcmd0YTlpZEIzUm5KR3JWR1E0Q1RGNE1tVyt0aVhLSVFFWmpGbS9w?=
 =?utf-8?B?MUVFUU0wM0hPRC92N01KZFhsQUFJMkVBVkdNUURnbDVHZENQOVIrTWpIVGdD?=
 =?utf-8?B?WjV5c3YwaXpPRlF4UFMzVld3aHU0Q0VUQ2IwQjd6MVlVNHRWNmgwbWRVZXhJ?=
 =?utf-8?B?YTMyUTBzTVRRd2RGQlBWazdzajJlY2NKaXAweW83bW9RL1FvczV6Vys2azVZ?=
 =?utf-8?B?QmlIOVVKOXB3cmk3N1ZhVmt4M1IwSmRudTIxV3NLc3pqZnlrdmFWU3NvQSs2?=
 =?utf-8?B?TFk2Zzk5N0l6YXk1OUJmeGJjb3pRMnhiVHc1NUg2QUJVc01hNmlSTXh1aUwv?=
 =?utf-8?B?NDdVSUZHMmhQM3BsMHBOc2R0SUNyVnhmWXlEK0lxbkJmTXdkQWcrNzhEZUYy?=
 =?utf-8?B?aE4vL1NTWHA3YWY5N2hjaU1BcVM2SmNFYUdncHdNSU1nMFMyMnJMZ1FSS3NM?=
 =?utf-8?B?a2Z6RGVERDVuUXZqeWUrSUZoNFN6NlB2NXB5QzNua0hRSU1WbkRzUEFnY3hN?=
 =?utf-8?B?Y081R1FrMHRGQldQcGhudVMwbWplVDhjRGpRYy9BVlVZV3JaUG5OSUh2b0tK?=
 =?utf-8?B?ZUhKc1MveVJGcXc1T1p2WklHUzJ6OFQ3OXNkTTdvVnJUYXBzQXBpN0J2VHZn?=
 =?utf-8?B?QjdzZG82Q1JZd3k4b0IzWFZ0TkVQNVFHc2VVQVlydVJBUXoyckVIMktKY0ZD?=
 =?utf-8?B?cG9FZ2JUZ1dPYUF1UEpBQUJac3RhQmVORktYRnN1YUE0eDZxNitnR0t0QkZO?=
 =?utf-8?B?eFhneG56bk5HTjBweU93bnkzM2gyWklpNDE0NTB0WVJ4SE55REhXaHRSU1Uv?=
 =?utf-8?B?cysrUzF5TS96aVhqK1ZGaUpVV0o4TzhaR3YyenE1M1FwWGhHZUROUUZ0K3cx?=
 =?utf-8?B?VmRGUGtoRGxWcmJydDZqMkRHZ1habTVCeGViL3d3bmRzSlV3VmhGUkRPNnl2?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +sJ2cruk9t1gpvboAqV2zpmKtXhBZhYcqcHMHEL78VCGmphzQ54tiZZTHXPiWwWO528lJBekzAHEhza9SrFQ3RvtfdPIuxSwojrEZvCoTiZd4zEAQU7MnmkvuwRJylymoizuxf35+Jpu7p2oziuQCQY0w7HontM5CphTT5O2O3/cT1sl1bxpqlWiXKeC1jEhxAaOMD8ecO1ciENUA9tj+dk9eIbdeUZWX0MNGr4u9qg1qQZ5gFlojQADGskxAU1MtjM4n/nELjYQBhekPOGbdAdY+MPcEoB+5QRG4ORhMJI4EGCEmLheNOyQR1V/s+t6qxUViWnM1CB+YqoaiShJN2PBWGHnzOsfI0oufofU2wWlLH5tdgc6NGLCEBrLxkBgt2pwq27Zaw7oneL/mzz9YWymK5eqUQp53LPi2bIyJgiEZO0EWSGlZ2SycO+XLqKKvCImQqRpJE2WcjhNkgtwJedaa+xDO5r0fhyEWmHKDclA7b/3RhsY92aeIIfAWlaB5OsHT9uYyISU/AA1xdgBhkgiK5DAOEehtqDRRXDCydqfarrHWvUDJgyseRYUp6KTd2UcU/AivhhlqBFgBcfn5QP6Lino4aCjzzlWsR4KAMp7rwgsbr9Dyul9rGa/xAqEiso0CSUqWkNfvBBuBSVYZY+O/QIys+W1mB3gwrfBIiPyih7ZbxvknBDy3sQg1iMp8/4WOB5+FAkdj4DIK9uApxjKvwrSZe80znr2FwjH/rxh5b51Q9OZ3GCeRNt+jKrrfyw8e/Wk2C8zyKTc4AcLZHl1paLLHqpQWInGDsqFDgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e785d2ef-d91e-4aad-26fc-08dbd4038877
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 20:06:24.4297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIAjXepXdm6TUb02E0Xd/OS+s56ION+MLppEDk0Lv6mu5Lgph6eamzr8kPIBFjz8qZ1D/pOzPhjB7jMTCNG+M9dj9OYy9yuO6A/5+zLdAV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_19,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230176
X-Proofpoint-GUID: FMlvSP7DvXVtdzl8CmtqBlluzzABrA74
X-Proofpoint-ORIG-GUID: FMlvSP7DvXVtdzl8CmtqBlluzzABrA74
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 10/23/2023 3:05 PM, Peter Xu wrote:
> On Mon, Oct 23, 2023 at 02:51:50PM -0400, Steven Sistare wrote:
>> On 10/23/2023 2:29 PM, Steven Sistare wrote:
>>> On 10/23/2023 11:39 AM, Peter Xu wrote:
>>>> On Thu, Oct 19, 2023 at 01:47:46PM -0700, Steve Sistare wrote:
>>>>> Add the cpr-reboot migration mode.  Usage:
>>>>>
>>>>> $ qemu-system-$arch -monitor stdio ...
>>>>> QEMU 8.1.50 monitor - type 'help' for more information
>>>>> (qemu) migrate_set_capability x-ignore-shared on
>>>>> (qemu) migrate_set_parameter mode cpr-reboot
>>>>> (qemu) migrate -d file:vm.state
>>>>> (qemu) info status
>>>>> VM status: paused (postmigrate)
>>>>> (qemu) quit
>>>>>
>>>>> $ qemu-system-$arch -monitor stdio -incoming defer ...
>>>>> QEMU 8.1.50 monitor - type 'help' for more information
>>>>> (qemu) migrate_set_capability x-ignore-shared on
>>>>> (qemu) migrate_set_parameter mode cpr-reboot
>>>>> (qemu) migrate_incoming file:vm.state
>>>>> (qemu) info status
>>>>> VM status: running
>>>>>
>>>>> In this mode, the migrate command saves state to a file, allowing one
>>>>> to quit qemu, reboot to an updated kernel, and restart an updated version
>>>>> of qemu.  The caller must specify a migration URI that writes to and reads
>>>>> from a file.  Unlike normal mode, the use of certain local storage options
>>>>> does not block the migration, but the caller must not modify guest block
>>>>> devices between the quit and restart.  The guest RAM memory-backend must
>>>>> be shared, and the @x-ignore-shared migration capability must be set,
>>>>> to avoid saving RAM to the file.  Guest RAM must be non-volatile across
>>>>> reboot, such as by backing it with a dax device, but this is not enforced.
>>>>> The restarted qemu arguments must match those used to initially start qemu,
>>>>> plus the -incoming option.
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>>  qapi/migration.json | 16 +++++++++++++++-
>>>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>> index 184fb78..2d862fa 100644
>>>>> --- a/qapi/migration.json
>>>>> +++ b/qapi/migration.json
>>>>> @@ -620,9 +620,23 @@
>>>>>  #
>>>>>  # @normal: the original form of migration. (since 8.2)
>>>>>  #
>>>>> +# @cpr-reboot: The migrate command saves state to a file, allowing one to
>>>>> +#              quit qemu, reboot to an updated kernel, and restart an updated
>>>>> +#              version of qemu.  The caller must specify a migration URI
>>>>> +#              that writes to and reads from a file.  Unlike normal mode,
>>>>> +#              the use of certain local storage options does not block the
>>>>> +#              migration, but the caller must not modify guest block devices
>>>>> +#              between the quit and restart.  The guest RAM memory-backend
>>>>> +#              must be shared, and the @x-ignore-shared migration capability
>>>>> +#              must be set, to avoid saving it to the file.  Guest RAM must
>>>>> +#              be non-volatile across reboot, such as by backing it with
>>>>> +#              a dax device, but this is not enforced.  The restarted qemu
>>>>> +#              arguments must match those used to initially start qemu, plus
>>>>> +#              the -incoming option. (since 8.2)
>>>>
>>>> What happens if someone migrates with non-shared memory, or without
>>>> ignore-shared?  Is it only because it'll be slow saving and loading?
>>>>
>>>> If that's required, we should fail the mode set if (1) non-shared memory is
>>>> used, or (2) x-ignore-shared is not enabled.  But I had a feeling it's the
>>>> other way round.
>>>
>>> Juan also asked me to clarify this.  I plan to resubmit this:
>>>
>>> #                                        ...  Private guest RAM is saved in
>>> #              the file.  To avoid this cost, the guest RAM memory-backend
>>> #              must be shared, and the @x-ignore-shared migration capability
>>> #              must be set.  ...
> 
> Okay.  We can also avoid mentioning "private guest RAM is saved to ..."
> because that's what migration already does.  IMO we can simplify all that
> to:
> 
>   It is suggested to use share memory with x-ignore-shared when using this
>   mode

OK, I'll massage it some more.  I think we should explicitly warn about the
cost of saving all memory.

>>>> Reading the whole series, if it's so far all about "local storage", why
>>>> "cpr-reboot"?  Why not "local" or "local storage" as the name?
>>>
>>> The use case is about rebooting and updating the host, so reboot is in 
>>> the name.  Local storage just happens to be allowed for it.
>>>
>>>> I had a feeling that this patchset mixed a lot of higher level use case
>>>> into the mode definition.  IMHO we should provide clear definition of each
>>>> mode on what it does.  It's so far not so clear to me, even if I kind of
>>>> know what you plan to do.
>>>
>>> I believe I already have, in the cover letter, commit message, and qapi 
>>> definition, at the start of each:
>>>
>>> # @cpr-reboot: The migrate command saves state to a file, allowing one to
>>> #              quit qemu, reboot to an updated kernel, and restart an updated
>>> #              version of qemu.
> 
> I think this is why I'm confused: above sentence is describing a very
> generic migration to file scenario to me.  IOW, I think I can get the same
> result described even with normal migration to file, or am I wrong?

cpr-reboot has fewer blockers than normal migration to a file URI.  Most
importantly, the presence of vfio devices will not block it as long as
the guest is suspended.  That functionality is implemented in the patch
"vfio: allow cpr-reboot migration if suspended" in the V9 series.

I suppose we could use the presence of a "file URI" as the criteria for relaxing 
blockers, and eliminate cpr-reboot mode.  However, by making the mode explicit,
we can add mode-based options such as '-only-migratable <mode>'.

If we decide to delete the explicit reboot mode, I still need to add MigMode and 
per-mode blockers when I submit cpr-exec mode.

> IMHO the description here needs to explain the difference and when an user
> should use this mode.  I think the real answer resides in your whole set,
> I'll try to read that.
> 
> In all cases, can we name it something like "live-upgrade" v.s. "normal"?

I like cpr because it is a short and unique identifier for functions, types, 
variables, and user-visible tokens.  It reduces line wrapping and makes the code
more readable, IMO.

- Steve

>>> The cover letter hints at the cpr-exec use case, and the long V9 patch series
>>> describes it, and I will make sure the use case comes first when I submit cpr-exec,
>>> which is:
>>     * restart an updated version of qemu     (I buried the lead - steve)
>>>   * much shorter guest downtime than cpr reboot
>>>   * support vfio without requiring guest suspension
>>>   * keep certain character devices alive
>>>
>>>> I tried again google what CPR is for and found this:
>>>>
>>>> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08541.html
>>>>
>>>> I also prefer spell it out, at least make it clear on what that means..  I
>>>> didn't even see "Checkpoint/restart" words mentioned anywhere in this
>>>> patchset.
>>>
>>> Will do.
>>>
>>>> Besides: do you have a tree somewhere for the whole set of latest CPR work?
>>>
>>> I have the V9 patch series:
>>>   https://lore.kernel.org/qemu-devel/1658851843-236870-1-git-send-email-steven.sistare@oracle.com
>>> and I can re-send my proposal for breaking it down into patch sets that I presented in the
>>> qemu community meeting, if you did not save it.
> 
> No need to resend.  A link is exactly what I need; git tree even better.
> I'll comment when I get something when reading that.
> 
> Thanks,
> 

