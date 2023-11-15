Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BC87EC753
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:32:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Hr2-0004f0-Sw; Wed, 15 Nov 2023 10:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r3Hqo-0004ao-RG
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:30:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r3Hql-0002N3-1e
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:30:46 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFE4mum015771; Wed, 15 Nov 2023 15:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=maICOIHZJIW+K3vRyxIJS/NoLsyHt4NqJ7On5qgvvrg=;
 b=aBRgutDL0lzMUV8eM30Mx4eZS8Z4UuuZXEf1HpwYrIqPakAIR0a+5nn81ExOT6wVdEBT
 fW2VjCYQrCcoS6ZJVv9dQc01WPlGcl+Vn7P0kvj41YoTnzBHQhpRl/1t7fDdzmJxEzte
 9kft+Yhd2yGRSJIPgGHuV2aaCS0FsGnIxEPMRHIW3dLXzhuCOAod5KoWSg3b46BUdRbU
 VL/E76FyQ0JJUv2ERiYUxiF6EH/siUNAu4WP/BtOtcx2jJO7aGH61d1PZYKgxZzWhBF3
 673XNzIExhD93/1LLXzc9tHiYHpxOxRj8z+xFxrAtqMeLmG7uHEcCKMzXOeDX/5mWHdx LA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n3gqka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 15:30:36 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AFEeHGi014777; Wed, 15 Nov 2023 15:30:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxqth047-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 15:30:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSlnPRmpOPokXTuc1wecsvCt7vUoyQ7FoXIuKylA71lXZ7rz2yOEUejEeGRy4TNcHvU/oxxhZQL0Z/1OJF4lFmC+eQQprTWGf14cZxNlhscn39MdxmvbB54U3H41/67seFvDTU9VZbVXFWPA+uNFVgnT/iKo1Fk7Ja/55T2n8jOQhiIsOFtVMnO8A3CaeiqBme8K/7F9HyD7JcFngIwwyCl9XYHvtHJhtJuynLoMK+iloEB+NC6g9xCryVlAudS4m7TD5zEGLOIRNwrfozRH8pFlLZBeBfn705nrCaecDGHCiJYhmCetk2ATJHev34PVAUp4oxezocSUzdGu4OFqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maICOIHZJIW+K3vRyxIJS/NoLsyHt4NqJ7On5qgvvrg=;
 b=jTTDDzqjTiXFSzdBD0eFfbg7IKdGpU4iBoH7Y4mvqCgmeJZV8fOLS8vLdVBCnFVT7udsh1/2EolHnzvWYAa/aXKSxTdymJZl2zAS0iQKMmz/xhJKQ+quQjtPkru7Q0XJIK1Km2jBR1nUZHMCprCSWtgBFoXTWwfuVQLhkVeNlqXlNIza0eVZaJJ5IvqQXKswdIiD+rUE+Va/GzwWmxClcZhRXjnJyVls7x5c3xxWqjb1B/CpDV7/HCuYC/HgoQyMfGlbHcVCtOoviuwx4/8oyl54Hy17o6vbxU6u6nDAU6+PKjqfGsMboRTaNsshcJIVQIXeYFKx9Nx+G1qmaITtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maICOIHZJIW+K3vRyxIJS/NoLsyHt4NqJ7On5qgvvrg=;
 b=e2tbtdernxRX7ZyOOZbi0BVqxOYCpofDBMsSku4DshWiuQM0bPPH3QG6sw8mTcpFIWRnZYDHqwHgsqbeiCjjLLdLjkOEmTQns/CR3Hunh9K12pShB+WIb/0trtMn1fOwNK5crFOAo4prwPG7xcpl8sa1lwKxQJhbV9uaUQI6gBI=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS7PR10MB5925.namprd10.prod.outlook.com (2603:10b6:8:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 15:30:32 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 15:30:32 +0000
Message-ID: <587d8444-17a4-4d19-a856-ac55e46069c5@oracle.com>
Date: Wed, 15 Nov 2023 10:30:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: flush messages on abort
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
 <ZUUu2IuUQ/Od7+Vr@redhat.com>
 <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
 <ZUi7izJoVpU+iiuC@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZUi7izJoVpU+iiuC@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:208:234::28) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS7PR10MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d34128-2498-4eb6-a0bb-08dbe5efce56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/IQzaL0DM1uwajUyyz8FOqzqOv2HyVSwiRaAl98/miiMsxDOuWbs9zRIC5C6v1bGnfKKnVY05opptkdX6k3aCMdN5MhVWY22XK8lsNG8v8C5C0OakzBFnVl0iNUax+K5MgDBOjzmWVs/q5waT8gjSzt/b8UKLVygmvpYoKBvgm3IaYuwwVb2NiX4t62f1n7Fv5fQE+3ZdpjLoJ7A6Px0rpiT3o8HZXKqA/Jw31UvqwYQGa3uLWKd7iCOEtxDTbofeJAS9T2cu6hvX6xDuYaTXkxu2KOSBOXJqxJvn9zFJO9tbNKzRm24xmwpMoHoYbp/XGLGhaKhYiUvKvx+jEIIlYd/1B2cpK2T28Q/axG/lWtYv3bfmlKZdvcZtmD0p//fTZFcG6QzS0/pFA9z8CkNVcSqdEHK2wtag5SMOKemq/qDT02SLAr4d6/hVkAqmvIT1g8Rhn0a8HrAikAUy4bOsI1l4meFzc93vFcd9Gwe003dLzxc5Sb5pWuhxcCMlCTRXJNzOJjrlyLmAyVCEy+lFdVVAECi1iiYTtAqvGdNxOCec4ZA07A2yky6nmw516vP9Yd7JcLknqW0O6dRpRTvVz1ejy3PlYCHth7oRZJI3DlpU2f0aZBO1H8k1Dd8+twdekY7MpV2ITwtvqy9XytYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(36756003)(86362001)(31696002)(83380400001)(38100700002)(26005)(6512007)(2616005)(6666004)(6506007)(6486002)(478600001)(36916002)(53546011)(54906003)(15650500001)(8936002)(5660300002)(66946007)(66476007)(316002)(6916009)(66556008)(4326008)(41300700001)(44832011)(8676002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0RiOWR4aTZJYmkvck9SUHZEME5CVFg1OGgwdlBpbFBaUWRRaVdKUGhmQngr?=
 =?utf-8?B?dU0wT3VNcS9DZHEycnpXMXBKTUZ4MHp0Z0FhdVBvTU1rQVplR3RmbWg0dEFM?=
 =?utf-8?B?MzJzN2JmMGNZM0RZNGhBZjViMmN2UnQ5NG9QL3RnVy8yb0lIUjFaanRqeno5?=
 =?utf-8?B?dmNtZStoQkg2bmh6OEtPblU4N2VCZ09BZTJBQnpDMXFSSnRGWGZ4cWI3dXlr?=
 =?utf-8?B?ZS92YndUbWJIRG1aaUcrZGRtYytSN1lpMmZlbUhHeEM3aVFMSnl3STJjV0xK?=
 =?utf-8?B?UiszVno5NFdUUlNtV2NjQzcwWGVhaStuUDMvWEhxd0xsZ0FVKzBtcXI2Wklv?=
 =?utf-8?B?c0t5V3d1VVcxSjZ1VEdLZ0xvRVpBdkhSSTZob0dHZWxON0xObTZqSVJJcGox?=
 =?utf-8?B?K3hSbnNnbTROZHZTekE1bFQrR1hzeDZYMFZQWVRvWnVLRVZvZkpnSDFCSyty?=
 =?utf-8?B?TThXRG9Xa2h0c2tzK01rczJUL1FqUHlIUkRYUExHSHBJSmYrMXRLY0ZDMVpz?=
 =?utf-8?B?bDV6d3J2Q0U1VkdQa0pPQzBzbUt6K0YxYk92YVZUUm4wVENVRUFqVWhIenVC?=
 =?utf-8?B?TkhjZGxiNUk5LzZyRXdyWXZtZFhhNkl3QzQ2UGhkWlkzVDlHak5LUVE3blRY?=
 =?utf-8?B?NTVubTJzMVhuWXdNRjNWTzJVNnJUVW5vbzNkNVU5alNqK1FzakE0cG82NzZs?=
 =?utf-8?B?MEszY2JUVUtuWmpGUzY4Mi8zcnBSaUxobFc2YTFaSU5lNmdVTnAvUnpCZGlC?=
 =?utf-8?B?SStNK0pvZTV2TzFnQ2xIcVcyNndNdnR6RXJKMmpRT1B2K0c0L3BQakQzS0VC?=
 =?utf-8?B?NyszeStNemhjSDJEd0RUNjMzZXc5aUthMXphNFFXb2RUN0gxRXJWM2N0K2py?=
 =?utf-8?B?U0pDQUoyUlExYlJDMGcxeXV2TXIwSUdBS0pBWmFCazlVVUpVMTYxZnBKejRi?=
 =?utf-8?B?NXMxbjk5cndyWXd2a0lsYVRSTHdBL1pJQ1Fna3Q1UFFOK1pNbnExeDRkY0lV?=
 =?utf-8?B?a1VwMFJhcURUZ284Z1dFQklocGM2SXUwT2pUS2xmK1FQd2FTSmV4TWFLR05O?=
 =?utf-8?B?NlhQZ1lrMTZtOFhpK0pVMzlOZkQ5WUlGT2lKMHd3THZJVUpkc2ovVFJ0b0Fm?=
 =?utf-8?B?Z0Zldk1oRk5HUk9ZVC82cDJxZnZac0ZJZXNyL2Nhb1dXYUlxUjVTNHlaejFT?=
 =?utf-8?B?ak02WVVra3ZPOEVSMGFYODRtMHFYbXVQdVc0TGNhZysvekdndXFTMUtZS0VE?=
 =?utf-8?B?azdEeURRNGVJejhTMGNacnROM01BRWNqcDBINW4xVG9wNkpRQjduRU9jRW5X?=
 =?utf-8?B?Tm8xQ0FZNGVpZFdNM3ZvWHM1K3k2MHhWYUdRMlpzaHVWeWE2dVd4T3RWTlNZ?=
 =?utf-8?B?Y2psWVJhMDgzZmdTQW1KWS9tZnVNK09RZStVeGs4dSt1RkFxcmNyTGYzMDRD?=
 =?utf-8?B?MWx3T0ZNSk1BaGRzSER5OFZKNVkxQmRxcldNbkxqa3hXZEU2TmNLR1hXcnpx?=
 =?utf-8?B?ZmJGQVRmNXRrbDlMVjhrZDdQZkZZcVY4WXZsLzdxNjFLOStXSEh0VlArZllN?=
 =?utf-8?B?cXExbmFaMmhmd3VERWRjblVXRkNRenBDTDRuTERkcmJHUFBGaFlmV3pPcmcr?=
 =?utf-8?B?ZExQdkZRWUhaR0ZLU0lsdytubWJNNE91NHZIZkJSQ1NodlZvbENCNUphNklR?=
 =?utf-8?B?V3RwQUlkNE0zQnllbmdINUk3allGZE4rdk56NHQ3eUM5Rlp3ZW5nMnQ5UVJX?=
 =?utf-8?B?dzc3ZmJUSGxrd1lDOXBrOGNvK0Y2WHp5cUdJcTQza3JGMlhTNnkzMElhbERT?=
 =?utf-8?B?S1VKbnYycnVFbWxjL0g0cGlJU1BGTXRFM2F6b3hFVGxIMVU4SmZMNmQxVUc3?=
 =?utf-8?B?blprT0hCQlJYNXBqb3ZUNTNpblAvYnI0MkxwUVFQUmppZHpPckRoNitoT29L?=
 =?utf-8?B?Y1N6eDF1amNyK21nUVhtMDhrMmw4NCtyVHZhYkNUZGZ2ZzVOa3NuRHB3TFFK?=
 =?utf-8?B?OUk4dGJheVZCMjRiV3UraEVDZ0ZMdFZIMFZOSXVuMi90TGt5WG9QaVVSNVk1?=
 =?utf-8?B?RStDb3A2SEhOZ2U3REIvcmwyUE5CVTNWMC84RmRrZFVMSFRjOGNLeG9qd28r?=
 =?utf-8?B?L3RuVzJmVzFBMXFRMlJpWVV1b2h0Yy9KbU04eUdzbzYyS0J2TVJsRzZjZjlh?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /gJeeJqPyW5qwTEnq4B88nKV1SGrPx0YlpoTfI6ZkLxUOWC64EtdbUg/uZjH/R6/MzKPkbKyMAOFVHqNGrIXpbhe9ZMD3kRBdS29LLp/SYySLvxuqHX6sAbr+B/dxDBYjdqiN/Q0DyxYdi3+2Whv0R8Ar5pyj1n7L4yFWoR7CIdnpfBHYlgd6Z0Kxc6tlEcXpi4AfJbQwaL1QX+c/XS7JOxFpi3h6GlpdlAOosZp0XX404Q6+SLmOdNqEiyjDnVMQO3EnbizGdH5JtQ6OYGHBHQpWeBbIw5909Nd9asyO5dYLmKGDB1sIa562A6mHAn87wgoi7EG936vhdh+SyThXL/lumpbJPxziaHnVoRLthGAaqzfnLRZTzHhHWcHDLkt/j01dCjdacDJPR5vKB1MhxL/KjN9R6ntMyFjytTnTdCbZJ0HTT1+6H4QvvxOu/YefHJXNVrgWbPdAt2UpRJatsBMCS8qYA5R6WvJN2ElwG9rWGZ8Rr5RRcYcwnb5Hg6cayz0iaeY7BeNMXBtjLyVLGnlF+TgUco7K6U801s6aVCyLAo43wQDMNCHQNRWvFk7UCWC0XU9S6IjejAN+Rv1lZQ+uMxgj/sjPTy3Ymjds58BIjro5B8EKjtcB8wr3MjZuAaPyDYbDKrkIBFK5yhpMujLH8lovSE40B6OTL1cw8ueVFo6b23gIzYL57qSy4uEtKJE6BKWJICaEhAvIpZI2FFZMVGeKLN4QTLg2a04DubS2QEvJhc/xI34ABTSe9rzF1XVgM4JtvakCiwlZxsOZVtr2LBx39M/7CSw2M+xi6qWt2tK2gv+d4LYlIdgorCRFzCqAxgZmUtOAqynhqrvJA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d34128-2498-4eb6-a0bb-08dbe5efce56
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:30:32.6673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0J2eP7mxX2joLXt5QhFqN5oVMESPGb4pkmvmZ4HrAE/WYtQAgWQBL47trUGVUQvJ98/NcngOihrZ1F1Y7l51/Nhs9q7SP4UI/VbPxO5G+s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150115
X-Proofpoint-GUID: TjNGUiK2jy6S51h_4Wvr09L6fxoLDHL1
X-Proofpoint-ORIG-GUID: TjNGUiK2jy6S51h_4Wvr09L6fxoLDHL1
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



On 11/6/2023 5:10 AM, Daniel P. Berrangé wrote:
> On Fri, Nov 03, 2023 at 03:51:00PM -0400, Steven Sistare wrote:
>> On 11/3/2023 1:33 PM, Daniel P. Berrangé wrote:
>>> On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
>>>> Buffered monitor output is lost when abort() is called.  The pattern
>>>> error_report() followed by abort() occurs about 60 times, so valuable
>>>> information is being lost when the abort is called in the context of a
>>>> monitor command.
>>>
>>> I'm curious, was there a particular abort() scenario that you hit ?
>>
>> Yes, while tweaking the suspended state, and forgetting to add transitions:
>>
>>         error_report("invalid runstate transition: '%s' -> '%s'",
>>         abort();
>>
>> But I have previously hit this for other errors.
>>
>>> For some crude statistics:
>>>
>>>   $ for i in abort return exit goto ; do echo -n "$i: " ; git grep --after 1 error_report | grep $i | wc -l ; done
>>>   abort: 47
>>>   return: 512
>>>   exit: 458
>>>   goto: 177
>>>
>>> to me those numbers say that calling "abort()" after error_report
>>> should be considered a bug, and we can blanket replace all the
>>> abort() calls with exit(EXIT_FAILURE), and thus avoid the need to
>>> special case flushing the monitor.
>>
>> And presumably add an atexit handler to flush the monitor ala monitor_abort.
>> AFAICT currently no destructor is called for the monitor at exit time.
> 
> The HMP monitor flushes at each newline,  and exit() will take care of
> flushing stdout, so I don't think there's anything else needed.
> 
>>> Also I think there's a decent case to be made for error_report()
>>> to call monitor_flush().
>>
>> A good start, but that would not help for monitors with skip_flush=true, which 
>> need to format the buffered string in a json response, which is the case I 
>> tripped over.
> 
> 'skip_flush' is only set to 'true' when using a QMP monitor and invoking
> "hmp-monitor-command".

OK, that is narrower than I thought.  Now I see that other QMP monitors send 
error_report() to stderr, hence it is visible after abort and exit:

int error_vprintf(const char *fmt, va_list ap) {
    if (cur_mon && !monitor_cur_is_qmp())
        return monitor_vprintf(cur_mon, fmt, ap);
    return vfprintf(stderr, fmt, ap);                <-- HERE

That surprises me, I thought that would be returned to the monitor caller in the
json response. I guess the rationale is that the "main" error, if any, will be
set and returned by the err object that is passed down the stack during command
evaluation.

> In such a case, the error message needs to be built into a JSON error
> reply and sent over the socket. Your patch doesn't help this case
> since you've just printed to stderr.  

Same as vfprintf above!

> I don't think it is reasonable
> to expect QMP monitors to send replies on SIG_ABRT anyway. 

I agree.  My patch causes the error to be seen somewhere, anywhere, instead
of being dropped on the floor.

> So I don't
> think the skip_flush=true scenario is a problem to be concerned with.

It is indeed a narrow case, and not worth much effort or code change.
I'm inclined to drop it, but I appreciate the time you have spent reviewing it.

- Steve

>>>> To fix, install a SIGABRT handler to flush the monitor buffer to stderr.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>  monitor/monitor.c | 38 ++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 38 insertions(+)
>>>>
>>>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>>>> index dc352f9..65dace0 100644
>>>> --- a/monitor/monitor.c
>>>> +++ b/monitor/monitor.c
>>>> @@ -701,6 +701,43 @@ void monitor_cleanup(void)
>>>>      }
>>>>  }
>>>>  
>>>> +#ifdef CONFIG_LINUX
>>>> +
>>>> +static void monitor_abort(int signal, siginfo_t *info, void *c)
>>>> +{
>>>> +    Monitor *mon = monitor_cur();
>>>> +
>>>> +    if (!mon || qemu_mutex_trylock(&mon->mon_lock)) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (mon->outbuf && mon->outbuf->len) {
>>>> +        fputs("SIGABRT received: ", stderr);
>>>> +        fputs(mon->outbuf->str, stderr);
>>>> +        if (mon->outbuf->str[mon->outbuf->len - 1] != '\n') {
>>>> +            fputc('\n', stderr);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    qemu_mutex_unlock(&mon->mon_lock);
>>>
>>> The SIGABRT handling does not only fire in response to abort()
>>> calls, but also in response to bad memory scenarios, so we have
>>> to be careful what we do in signal handlers.
>>>
>>> In particular using mutexes in signal handlers is a big red
>>> flag generally. Mutex APIs are not declare async signal
>>> safe, so this code is technically a POSIX compliance
>>> violation.
>>
>> Righto.  I would need to mask all signals in the sigaction to be on the safe(r) side.
> 
> This is still doomed, because SIGABRT could fire while 'mon_lock' is
> already held, and so this code would deadlock trying to acquire the
> lock.
> 
>>> So I think we'd be safer just eliminating the explicit abort()
>>> calls and adding monitor_flush call to error_report.
>>
>> I like adding a handler because it is future proof.  No need to play whack-a-mole when
>> developers re-introduce abort() calls in the future.  A minor benefit is I would not
>> need ack's from 50 maintainers to change 50 call sites from abort to exit.
> 
> That's a bit of a crazy exaggeration. THe aborts() don't cover 50 different
> subsystems, and we don't require explicit acks from every subsystem maintainer
> for trivial cleanups like this.
> 
>> A slight risk of the exit solution is that something bad happened at the call site, so 
>> qemu state can no longer be trusted.  Calling abort immediately may be safer than calling 
>> exit which will call the existing atexit handlers and could have side effects.
> 
> If that was a real problem, then we already face it because we have
> ~500 places already calling exit() and only 50 calling abort().
> 
>> A third option is to define qemu_abort() which flushes the monitor, and replaces all abort
>> calls.  That avoids async-signal-mutex hand wringing, but is still subject to whack-a-mole.
>>
>> So: atexit, signal handler, or qemu_abort?  I will go with your preference.
> 
> Just replace abort -> exit.
> 
> I'm not seeing a need for an atexit handler on top.
> 
> With regards,
> Daniel

