Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CCE7BB699
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:39:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9T-0005CR-7w; Fri, 06 Oct 2023 07:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qoj9E-00056o-E2
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qoj97-0000Fx-62
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:36 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3969E3YU025251; Fri, 6 Oct 2023 11:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Y1RewRnogzi3fJO905s1ZOFaBJNh+cWJJ7oQrUHgKfY=;
 b=TA8GRtQU/64EvLGvbF8vgaJ1/e4VEjbIWgJS32jGqzHetKzDQb4JGB8yOrKhOz0naqqa
 Rc9CUyKLwlgStdCHNmpw7b7WyD7uxM5nvhIKsj1/hLO3bYefoQgWYDcnbs8zDQRT1ywv
 zriP4LfouQxCTubgHk7PQU8qc2M4COdAdTYxtcF8654YBHAH8to3yYppOzMYEXrj8npj
 MhcvxJcWUih401Wt1z0ZhO6yh+FtQC69gaW83gW+26MBRly2VSeU1MJd5wYknFDSswtu
 WQovEunUYcgTDe3Xj4ycD478uW2V36Cv8Hzmo/57ZAIWUvM/9awB1iJLM+dU3l/x8Dlz jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakckra0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:37:24 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3969LYj4033621; Fri, 6 Oct 2023 11:37:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4ar3yj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:37:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNNB3C0K3W9Unj12MB6QWY3u91Tzq/+eg7a2ERt977bJlSMKcJxu04KeugYSHc0TrAuNbA7s2/zksLTZiJcWjJMj7pPV/r3844Ff30ZrHJfG+MC3bvln4LSyLjk1cpNEypQhaRJcpH/kKybeVVvBozjEZN9ciPvvXRe/YdoDG/hANA+LfL9xEls8nhU8PVKAMONH3P5+U8HiwWQ2maGibh0J6vm71Mo8bZYHyJXfRxUo4RlQAi5qZEYL75NGg1eupqzm84XYRbPjTz+TupwTTxNHByyaLGsihbvnt/2+UDTRpAzXmYKO3eTs9FaGM1lUISvAoCJnVUiUhTqEdWdCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1RewRnogzi3fJO905s1ZOFaBJNh+cWJJ7oQrUHgKfY=;
 b=Oezt7Jnsxz2PXioiDWsg36m6AnvXYtXjv3gvYysSaBYpMCbC7Mpyrj/BlRUk3BQdl0hKNs6DsKJib7ftKjrVBXF0hX197YVvluuy1Vwzdz9TaJy5t71hkZSi8y56HTB5hc8J+msFfSXOkByiXFSVGX4ouVdxQ+pNPUV9g2nKbCwoR7e/zEemRViI5ONb/E280n67SF0jFuXwmmAafJ3NnZ2aTvwsLPS8YA4cRouXSaF2iVBDHLW6Lc6Dx7VDoPDebxuAFgc5iRo8bmfIK6AGzo4GquWpxycjzFdBssnyW1FFP+xwG4cuDfmqPKWFiGQjtqkxMeHS0EG887RP4CHTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1RewRnogzi3fJO905s1ZOFaBJNh+cWJJ7oQrUHgKfY=;
 b=XAbKC/7pASRoZje4q/Vt84lecmw/uSDuLhN1YzMuacDE5nBV4nzzx/blnjvmMaVWqRj26wU5QGwfPblsO7l3NH+QcKgx4Fu7n1q5OUcIsGZ5oYirbwHpe9AYedjP4J2xzTepfbWq6uLauoc7Acgey7GpJnBhzddmffnuVhf69ms=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CY8PR10MB6802.namprd10.prod.outlook.com (2603:10b6:930:99::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 6 Oct
 2023 11:37:21 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 11:37:21 +0000
Message-ID: <f254478a-2e4d-4e6e-b19f-d5e56099f2a9@oracle.com>
Date: Fri, 6 Oct 2023 12:37:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] migration: Provide QMP access to downtime stats
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
 <20230926161841.98464-5-joao.m.martins@oracle.com> <ZR2cgcj//sAjzOav@x1n>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZR2cgcj//sAjzOav@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0284.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::9) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CY8PR10MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e9d355-ed4e-4af0-e8ef-08dbc6609a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CM4rFldbJP/GpKVWE66o7nfX7/mtRib1QbcbcM1ym2BiI/1zhP+nNuwYNoD9bfq2lauj0bH9YgaS/5c2ZNZZcf1UgP2J6qBN7/SCWu4Kj47k09Cv7pQAOfDVwxJYKTQCbxaB+zM+u/ZB+0jT7lbjB2kEEZbXoHuM6iKxsi9zGkrDFRf2PnomOccgsXx8RzlFrFD8n3X479pQmPBzJyLdk8I3HnOetvEpVQbLGX4zV2MzrZUPudVUzYWiwnGJZxN1pg0rbJ8SlQnQ0/GdiOElWJrbIeZHphxp7vlRA/sUbVuYv/aaqhTYWxD3/7vnDTSZH4gAOk9zLQLlzRUMcGblYlrzF1LsRulbWf3+UYHHu+O6k5wRx7opJzMyWzPOzxYWgBVgNPzHFBjhZcMrQo0+LrOrUaansdJD5xCmumjL9JW8aq1az3akpUAeaihZ9kgfbKoJbfMsY6538YpU6lzHjGD8hTszCGVBfU1ypXULenBFfZ+03qhEWQGv/h4IgusqpYpdI1/1t9km1ukW5TWMU5U5TavB0kLdg41XJoeEX2XpFMg6tdgNpfttsCjEUt7y/l9XCalAZWogJhXL6r3HMSY645+ahjvSENIjFffoTFGnUOGc1N3MG/KGQNO/VJcqJ51K9m6rR2oPvlY4+bvAzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(107886003)(5660300002)(6512007)(6486002)(53546011)(6506007)(31686004)(2616005)(83380400001)(26005)(6666004)(478600001)(66946007)(66476007)(66556008)(966005)(38100700002)(6916009)(41300700001)(316002)(54906003)(86362001)(8676002)(31696002)(36756003)(2906002)(8936002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS9tZUtWZGdzNjZIa3hFYXBVc3IwVkdNa3FFclFEL1VBaXYvS2FIdm9nQXli?=
 =?utf-8?B?Z0RtclpVcUtUYmZZMHhxMmRNNFM4cGdvbUZKRVJKVWZtZ0Q4MFZxcEJDZ3Yv?=
 =?utf-8?B?VHNyTTBsUG1qSTEycHdIZGYxeVNCWmZMZ1JuUVhsbUsvcnFtMlVpSytSVnJp?=
 =?utf-8?B?TEt1OGRja253TnVJN3pLZDNzVU1nTUViTHFoWjQ5Wkp6M0t2cVFFS1NHV2JV?=
 =?utf-8?B?bFdLbTVyajFrcmlLMldhL2FubG1OOU5ITVY1N0Fjcms0emFCbTRLaVlKbjI3?=
 =?utf-8?B?RC9qN09jSDl4RkhuN0NKRFBQSndCYnA5dnF4YUQ3MS9iMnJ6dmpWWUNTZ29L?=
 =?utf-8?B?V1Q1azZKeUIxekU5NmZIY0U0bXV2emx1di93d0VVeTdWekY4VmtXMTg1U3lX?=
 =?utf-8?B?V3hlL3V1Yyt5TDAwL01OWjJUV0ZYSnZOWTRXd1RJdmlLU25yaTQ3aDB5WUcx?=
 =?utf-8?B?VzRDcmlWK2RnRno0bnQxdFR1T20wWW9ZZWdHWmFhRGNISnBrTks1S0lrMktT?=
 =?utf-8?B?dEtQRURnZWxtQnQzbG9xV3dqY1haSHVlcVAzRGc0My81UEVpanNYMHBsMlAr?=
 =?utf-8?B?ZTQxY29PNUlLNkRCTGZhYmVaSXJrZUVDNUFWSGtvRGlSdVVFbXh0dzNVemY4?=
 =?utf-8?B?UURnNHNrQ05KdFVkRmVhd0ZGSXhjWUdqNnNtZ0RVWCswL1kxaU1VY3h6cXNB?=
 =?utf-8?B?S0lRcVo4N01JS1orNTJFMUR5M2d5UWFabE0rMTR4RlpQRVFQcFg2TnRDQ1Fq?=
 =?utf-8?B?dU1jTERKVmpKcUZKUDNtNkFad1NmY1BBeTJNWXFWaUZMK3RWL3JraUtrWS9l?=
 =?utf-8?B?b3ZNQUp5M3NxZC96MDJaQWtlQjNRRkJBeG13bjJtZ0tCaEFoK3dNNFMzVXUv?=
 =?utf-8?B?RGg1dHZxUUtIQkdaWVl0M0FZV0J4UnltZFRhRjVBWC9hOGRRMVc3NXo0Q2xL?=
 =?utf-8?B?cERFcXllWGtGSG1EZGNKMkNPOW0yMTRlK0lPRE9lSk1NRGdod0NqNDVIRnky?=
 =?utf-8?B?alRwdEpoUWgvbVRvK1BkakRiYXdMMmU0RDVsQXdMV2ZNQ3Q3aG5ZQ2FFbkNJ?=
 =?utf-8?B?Z1pvNSswTzMwWGI4SGFhYjJ5aFhwVVl6Y0k0MEx4THl1dWVoZEhzNVdOaTQz?=
 =?utf-8?B?QzFPOHEzTCsySmJMblRoazZLZlh5L04zNHV2K3htNmhyZkk0UUZZcTBKSHVJ?=
 =?utf-8?B?QTVHb09nVXVLSlNmeEdRY3NUczRwK3o4MmJnaXdvYXZNS09YREFqamtPczlm?=
 =?utf-8?B?S2d0TlJIeXdjL0hScjVRRDM1dGZNV2paNDJYb2VWeGVndTRzWnVLL1A4Vm1N?=
 =?utf-8?B?UjRyNXZLdFQ5LzZRM0xNZmlRRUlybWREV1JTUDBEeld3NEpDbkNiL3o5dWYw?=
 =?utf-8?B?UkZoWWJiVVh2TFdLdXpFWWhRTkRvczQrb2l2N1h0UlN2VGVWRjBGcWVOUEJt?=
 =?utf-8?B?OHBiYVQ1bUFSeDdiUVlUaTBybmZycFVtaFBaT0lCanZFNm9oalU0OFBmRy9n?=
 =?utf-8?B?cEZ0NkNXcTZIM1FEaWYvazV2dnl4OXVyQ0JzUGtEazlyRDQ2OFVsZjB3MFBI?=
 =?utf-8?B?ZCtCMXRTazVzTlUzT0tJdzJ1TGU1QjhTRi9CSG9pbkVQejBPT3lqWmhXZ1pQ?=
 =?utf-8?B?Ynlqd3ZMWWlDRzVJWER6a09Od1lvMkcvV1dvQmRNK0tsMEJkVHUwcXlnaXJx?=
 =?utf-8?B?dEQ1ejJHZVVUZ3BRME1VUVowczJWSXYyeE9OM0RsREYxY2JsZ0RjTEZwTHBR?=
 =?utf-8?B?MjBPZXowSzIvdHNlbjFVazl3anZZR2M3ZUFLVWZmQXFnT09JMnAvY3Mzd05K?=
 =?utf-8?B?czJ2UnJHeUF6dE5OTFR0T1F1bzJac1RDR1JBN3JIQjZTRGtHNWYyQWZoajFo?=
 =?utf-8?B?SnZGcDhWT0ZwenhyZnhUbGpNSE04SHl6RkZwZE1IaGhNVkJnS05xZlNxaW9U?=
 =?utf-8?B?eHIwaHhwRUYvTzFaR1lWbWR1aDZLTm1PWHF2OFEySk5lS2U0eEx6T3J4QjJC?=
 =?utf-8?B?SzhIVkI3UHJXM2g1dmp1cUpCT0VjRVV4T3Y4OHRLVzBGU2RvY0N4NEp5YkZw?=
 =?utf-8?B?dnAxM2hRdWREaVRDenFFcHNEaURQUnBORlRBWFFnbjk3SUJlb2MyNlB0Z2Y2?=
 =?utf-8?B?UkRmenFZZWQvUGpycHpHVVJQRE10SUc0cmFXdGc4Rk5DbUVUTGRhWHFmSmdX?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e2+9YG297ZfzGAFs4j2NcazH98srKxTb/oNVvKVQJY1w1dJqfRxoIzMrbTKNVCNMw94K1rWr3Tz6T5hI8NmtgBgTcqgudViIbAIJW8Hn3GC9/fBiEdko6NEYiDT5uO5WfsSTjS0rDMO3hkV32qEpPm+fG4mXhdlnkzO6g3DJPwiW0D35PTD+iHukiG46CiLp/c7O6+JIwJpJw3ysm9D+OwqxvWxcrJdw5+hTygJsyZZwvjebtJVe5JNF+ZOa2wRnkTwZXwpqxPFmtOxKECgBZDJ9nJdDzD7rV7ks1/I4sjNMno2aAEu/ruRn9fZC1DE/F0txKgkyfAuMGcRjGvSawinACiU5x/k0yI7t1hM2lmXUVLGfnHmdo/nqkxEBjQvMpy49xrgzmV+V0BGI2hNdWR8btFSgU+DGfSMeJf0EcQU7N4R7M0X0soHlKalV73UwsdrG7pruqRARGsHvucRNozO6siM/rO0sI5zdJ5o3C6YeOYnOjLnZb/TeQpAIMYklMq1N381bENO/4NmH/QD0rl5RnWCR++wltaODDyUjzS9+1/Yz3+25opwYK6B49emHGLhtvT2vcz9B67FV6GgvCnFzbcnLUVpYhX/hY6x5QrkvANajiXam1ptksxigiHlC5NMIqCSRvlR+ffRU6StHCnGas0e/THn3RdMXHnZVQcE8/8gVZunwca8WDyQwUgmze0pxusEWeDe1UP/s4bau9P4Ufkl+khuAhOExpN5TZlKoimaGHqXbfgGCHYhqAMDiyPvE0Z0vPvA6/9K7PuLQlhA3JgdHXTDKdsPkF1NHbYhVB3Zzg2EuilbEcJd8QIuZ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e9d355-ed4e-4af0-e8ef-08dbc6609a4b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 11:37:21.2470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hx6vZ4CiXxBiSF1Ualq95iKkzCCFJKmWcZaEQzPoXnlx/P9Jx+Ldyz3tgKlfG9mj3pcazEcvDyJ2G6VZ9keJGhVTDTzq7X2TSFPvYMXxEMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6802
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_09,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060085
X-Proofpoint-GUID: ADWe-yrvsYMt_RiCsmc78JYeDWUTXZ8o
X-Proofpoint-ORIG-GUID: ADWe-yrvsYMt_RiCsmc78JYeDWUTXZ8o
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 04/10/2023 18:10, Peter Xu wrote:
> Hi, Joao,
> 
> On Tue, Sep 26, 2023 at 05:18:40PM +0100, Joao Martins wrote:
>> Deliver the downtime breakdown also via `query-migrate`
>> to allow users to understand what their downtime value
>> represents.
> 
> I agree downtime is an area we definitely need to improve.. however do we
> need to make it part of qapi?  Or do we need them mostly for debugging
> purpose?
> 
> Any introduction of motivation of this work, especially on exporting the
> values to the mgmt apps?
> 

I added the statistics mainly for observability (e.g. you would grep in the
libvirt logs for a non developer and they can understand how downtime is
explained). I wasn't specifically thinking about management app using this, just
broad access to the metrics.

One can get the same level of observability with a BPF/dtrace/systemtap script,
albeit in a less obvious way.

With respect to motivation: I am doing migration with VFs and sometimes
vhost-net, and the downtime/switchover is the only thing that is either
non-determinisc or not captured in the migration math. There are some things
that aren't accounted (e.g. vhost with enough queues will give you high
downtimes), and algorithimally not really possible to account for as one needs
to account every possible instruction when we quiesce the guest (or at least
that's my understanding).

Just having these metrics, help the developer *and* user see why such downtime
is high, and maybe open up window for fixes/bug-reports or where to improve.

Furthermore, hopefully these tracepoints or stats could be a starting point for
developers to understand how much downtime is spent in a particular device in
Qemu(as a follow-up to this series), or allow to implement bounds check limits
in switchover limits in way that doesn't violate downtime-limit SLAs (I have a
small set of patches for this).

>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  qapi/migration.json   | 22 ++++++++++++++++++++++
>>  migration/migration.c | 14 ++++++++++++++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 2d91fbcb22ff..088e1b2bf440 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -217,6 +217,27 @@
>>    'data': [ 'start', 'stop', 'precopy-iterable', 'precopy-noniterable',
>>              'resume-return-path' ] }
>>  
>> +##
>> +# @DowntimeStats:
>> +#
>> +# Detailed migration downtime statistics.
>> +#
>> +# @stop: Time taken to stop the VM during switchover.
>> +#
>> +# @precopy: Time taken to save all precopy state during switchover.
>> +#
>> +# @precopy-iterable: Time taken to save all precopy iterable state.
>> +#
>> +# @precopy-noniterable: Time taken to save all precopy non iterable state.
>> +#
>> +# @resume-return-path: Time taken to resume if return path is enabled,
>> +#                      otherwise zero.
> 
> All these fields will more or less duplicate the ones in the other
> MigrationDowntime just introduced.
> 
> We suffer from duplicated fields for migration parameters, proof shows that
> dropping the duplication is normally harder..  I'm trying to dedup the
> existing Migration*Parameter* objects and still in progress, so even if we
> want to expose downtime in qapi I hope we can expose only one and single
> object.
>

Thanks for the background; I am now recalling your other series doing this sort
of duplication[0]

[0] https://lore.kernel.org/qemu-devel/20230905162335.235619-5-peterx@redhat.com/

> IIUC we can already do that by keeping DowntimeStats, keeing an object in
> MigrationState, and just drop MigrationDowntime?
> 

I can try that, sounds way cleaner. I didn't like the duplication either.

