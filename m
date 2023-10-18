Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEAD7CDCC0
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:09:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6IB-0005Sp-DZ; Wed, 18 Oct 2023 09:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qt6HG-0004Vy-AN
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qt6H6-0007z4-IH
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:52 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39ICwvDh006505; Wed, 18 Oct 2023 13:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dJHRwnB7VNZkcDGe8xnXkP6DEPJfund63feMFtrVyGo=;
 b=cbeZ5NDBdCr0PAOrFVb1a4Fo/fSiXLzQg110QvKsR1G8iKugaYL/6UuCEZ6rh2k0rl+B
 G9yYbozZRF6GlUmIjZBXWEWupJKZ3vdj4HNnq71c3F56yypvJuUPkY+QVXdMgXyxiEnX
 Aam7xp/uI5juWfxkeNUJ+42o/c9xFcjiwjNQoVP9Z3wbgO8oMCX3NOjKDdI2cWJUkoDC
 Hfd85uxgrSthe9/gPvHSBjd3n3SJPlUlV32js3/EbzzTT5NQU5Rm+EX/+r0mCZRiI8VF
 GRd02xVUHCB+DQH5h/fvtND+jNj0LXOPZdYXg/skXIk4e4VJgtu11LeClJPfPBYgZYsC CA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cfkvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 13:07:47 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39IBoJ5O027096; Wed, 18 Oct 2023 13:07:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3trg55976q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 13:07:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cg0Gax5+iIYewhKSTaXi89rL0DNukZamv4/YJbyt0aJyHVDGbSfraoy4dgAoBbj3Sr+SWNImOKJ2za3xVEA8OHo+HOluiEJzx5llQHZ5f1/QqIf1yo4RSAfxPVRaJH0LWKuSnbZTa4I+uHQcfRku/T3eLJMuFrXbftKi/d6Jhp6VTqx98BqK5Zk8+1jHNThH9OYvM2jChbw1dwK44WNb76n9BA0WBKxHgPsEuRaAP0kJCsHkXW3A8e2m7HgJjdAKeEirC4MHPcLASobSpJoSllgshTrKdu4aorTk05Vmv+uqUGwbPkJEhq9E0vbQ1Y22DR+gmPMAGJlgf31e/WjQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJHRwnB7VNZkcDGe8xnXkP6DEPJfund63feMFtrVyGo=;
 b=Guk56oWSYvRZTxf3GJwRIiJS648LEBwAZqH4Evhpo3xJTutWIDlOs5g1BRZUIoGd/4NDomw9EztI2J9Bbd1ksERO0v3rPpTuMwZp1aVYrNoQ61zgEuaIY/LJAuZ5kmf2iP9aGtAYkjl9gEbn3beSGRJsU/09yzE3MRXxaI8z0ZtTGO4nAfV/N+XJAJrWHUMtPKVBK6B0qm6welk+ZNAehQvge3J5y2utFh9lHvto6a0XQUkRp6cNfcJ3UUdRmsYe3ovQJXY0ml4bD3GXlKE7XD8/Cof62MNKunehsUFfFUfUgsvk8nwSF6zyJiMyne12ZBukWCgKcTIA+3BwEmkcKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJHRwnB7VNZkcDGe8xnXkP6DEPJfund63feMFtrVyGo=;
 b=W6mSHYaRIZYRLmyREu+ejUr9b562ihXOjAmrvBYrIqw9vDeKqCn6LhqX3yJS7U7tZO3Eo+T7/LVbsCtykJvRII8lWaHo9rt7UxjTl0KHo5aCc4jn+FW6x46p6BQGyk0eOoCQSrbnKdXVoQ4/sEEtZP6X3KAeDMpJy80gfQ11Ms0=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BLAPR10MB5059.namprd10.prod.outlook.com (2603:10b6:208:327::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 13:07:42 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 13:07:42 +0000
Message-ID: <3d3b5d7e-e122-436f-94ec-87437cf17a41@oracle.com>
Date: Wed, 18 Oct 2023 09:07:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] migration: simplify blockers
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1697634216-84215-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1697634216-84215-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::30) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BLAPR10MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: bf080138-1599-46b0-cfe6-08dbcfdb36a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iv47aEnUnoynGMM3kyWuuGuPyZKIXjj18p/jbjULD8ZlTZCITISr5wplIPcS36BOYuipIseQBDWgw9MumO3ZAWPUeGUyQl93QoaVzdrSxvqOOufoXWUYOV3Z97crGHPN/9vkQR8xR28mpyGIqUgdQ0JVL53Vu7cyTUhBoGpr5wnDMUmTbrcUBJ5hudRY+d+3pa0umrr4NVokAOHA+4a2z6PEhS1TH9X5GFaZtvSSbmMVtekWE+WNsIOhNLJ7atagKfLg3kdRYOZwJ/trI+LZNTkbsKUWO6EcI/4y/rlYoPaOmXHB7MelCna/SQ+E/vQH6ndk5zAc42bhR/3HR+4JTUT2Q67bk1VO5ODXe7RLaN6I2YMv8U1DTwMjfhkrvScTRV5E464DdeF1WvIyVqBhLyN1rW1Nz5atoL6M2kknFRpQY1MAZUb2ZNiXTU/BLAY5K5xPb0VXbpsEApm5dfWJmPDKunOdiXhWmlmCvUTX2h172F3xKGdDmDHeifHczZC6aQGvKlD7VqGlKQbt3lz+OpBBpyvXRKiwsl3734dc/FIPQdAEGUGdUZLyyrms8s7EtKLaFxPAEJMUqL5pt5UsutpIgrCaioAlMij7YeEKSAvMOo3cM3dPrqKpUEN11bMh1Fn6Xy7ltSvs9UI/SU2ldw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66899024)(66556008)(66946007)(66476007)(54906003)(41300700001)(6916009)(316002)(6666004)(36916002)(6506007)(6512007)(6486002)(478600001)(5660300002)(36756003)(8676002)(8936002)(4326008)(31696002)(44832011)(86362001)(2906002)(30864003)(38100700002)(26005)(2616005)(53546011)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUx5NU8xOTRtSE1WV3ZROS9kaDR4aVc0b2tGbllNM2dUOTg4STRacno2M3Ni?=
 =?utf-8?B?S2FKMXZKYUdMczZiQXVteWRCV2Z1N3cxOW8xaEpoV01VY2Y3N2pld2Z6ZS9X?=
 =?utf-8?B?Vld6ZHdFR0dnYkg4ZE1hYnBzU0h1SEcwNkVqZmtOSDJMb2tNYklsR3M4TjRC?=
 =?utf-8?B?V2crWEpZMDlyMDJsaW5UUU90M0pIRmMwOURsMktJWDNFd3pNZTM5bUhDNHJK?=
 =?utf-8?B?SXFjeVRMQ3VnMjI0a3I5QlBrTTV2cytZSFk3Y2JBTXZPVW5ndlhmek1wL2M3?=
 =?utf-8?B?NmJMZzU4NVhhNmNlcVZYUU4zbWI3S0FTQ2haQ3E3UU9OREFuNnFnKysrcjVE?=
 =?utf-8?B?SW0rb3FDT2ZBbnp1NFZXWUhOViszdzBBZ3NkejFyaENhYXB2bTlZZU5YWi9R?=
 =?utf-8?B?TXlWYUpBS01JWHVzbzhhV1NtU1pQWTV4OGk1VVg1VFVZanphZWlHSkJkMUVr?=
 =?utf-8?B?ek15UGY3czBoeDF6ZTNLMHNSVmdGNUxNTU84UkRqT0hmWUdpTHZSNWtUWjYv?=
 =?utf-8?B?OFNmMHJCWGtKdVRZWjhHZ1VFY3lLTWdzYzEveTFZUDJqUXozNEJIRmJPY0RH?=
 =?utf-8?B?MmRuVERxMnBDdFJrQ3o0ZFcybmNNMjRXM0huVEtlbkZKSzNYOHFNQjRqR3c2?=
 =?utf-8?B?OXhlRDQzaTYwTUY3Z3V6Z3JTRkM4SU5TRGpZalpRYUpiRW1JR1JMVmltM3B2?=
 =?utf-8?B?VnptZjhGQUMyaDlGTzJQV1ZZZTRxckVHYmJCQjJxQXF2Mmg3MmErYm5JWVZx?=
 =?utf-8?B?MFBFSG41UGxNWEtiYlJQbSt1bitDT3lLZFYvejFCdTJ4eEdJcVhuMXZYS0Ft?=
 =?utf-8?B?bXduOVBkNURLWFZ1bWxnS081THpBaFFwcWhpMWRmUzNMcExKdW9mT0F3cDJ2?=
 =?utf-8?B?Y003SFAycm9OQWF3VU1oNnN0K1B1UEpEN0JjeERlRWJhRDM3RkJra3YzUHBW?=
 =?utf-8?B?YnQ3aUJqSW05ejNWdU96SjBrRHFmSnkxVzZidFVBSmI4RGdaRTdZMjRQSUQx?=
 =?utf-8?B?YVBzWmZKeE5XRmJIVFFCbUxXNDFKR1FoM2pWTXdERlUyUVpyNzYrUXo4QVNx?=
 =?utf-8?B?WDhlZzBOYzN3RzErc1N1eVZqdnBwR0V2K2ZkQjBleFJEK0tYOVczdjhialBk?=
 =?utf-8?B?NkVINXphU2U2dVNyRnkvZUt2YW5qYmZJZ0lYMU9sMjdIMWFVYnJmdFdSdFdC?=
 =?utf-8?B?WG9oRVE1VklGMWhrbW9SQnJEeitmL1lUNWFBcFFNbDNNZllvd2thYy9JR0xq?=
 =?utf-8?B?V1dtcFdUeElVM3Y4MklGRDIxQ1hMOVlvNC9vWm5BbzNyb2hOSzZ5NXJiUFNK?=
 =?utf-8?B?SUFHSkltcUNTdE9YQkFRVU5aUEVsODluSkMraXBDSEtqN0FDaTgyOU9OaDQ0?=
 =?utf-8?B?N1c1NGpUVkh1RS9uTVF3cmgwWW9hWTFNc0FoeTJmUzJWNkpWRnRqa2FGUVcz?=
 =?utf-8?B?VUdENCs5M3dxenorNDUzMnEwUHJtd094bjJYZ0c0RDZsVVROS1QrUzhkQUdP?=
 =?utf-8?B?ZUdRamJKRUhSSUtmUDBSV0JRRzFibFpicHV5dXlWY3BtYnNQY3ZlNDRGZy9i?=
 =?utf-8?B?citIY0tqdm13TU4xQnR5U0tRaE5WaU5GSEdrc2owbFVuWFNaazNrcGRKcTk0?=
 =?utf-8?B?QW1HM2w5ZjdyTHZBaWx4dFJVL1pLcTE3ZWtvbkkzbFgvdXVWczcxc0hSQWdF?=
 =?utf-8?B?elJOZmVyNC9uMTF3RnJGM2hMcTVTSmNpQi94Vm8zNXVCZ0dnaS9yaC9UMkFw?=
 =?utf-8?B?UXhzbWxOc3NnVkhGSkFBWFNGVnlUcWp5VGY0ZC9oa2RNQVhOblFvWjlUZTlY?=
 =?utf-8?B?cmNRRlpnT3lQdDlMVWxNTTh2cEVPdUNOOFNFeHA2eE5HdmlIc1YyZlRIMDhm?=
 =?utf-8?B?clRnZjFvNHBPT0ZWQzQ4Q1JPcUswSUNUYkk1b05uYnk5YU9oYWVXMG4xTEFn?=
 =?utf-8?B?Mk5wck9sMmczVlZISHg1SzYyMDlxMHNySEhjRllqMXhRd0p4emNRc21JdXk0?=
 =?utf-8?B?aTFRNzZ4NkdJN2JtUDRuZzdTbExuaFYwaGVMM2JQcjczb21KQlBZK0MyNWFh?=
 =?utf-8?B?MXBOQUF4ZVYyV1QyWGl5R2dqNVhqUWlpRURnazFhZHZYMjNaWStjb3B0K3c2?=
 =?utf-8?B?cVNEZm55L3dMaW9uWlBCejlNbWxNei84L3cwSWlqdGkxU2V6c3JjRTFuMUp5?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0WE4uVfJVtzKGneLN7rWrgqa1FVxaqGDMQ0eMxe3D+BmHS+ccgZPfUwsBoywgkEYZwPYJGAL6CGatKQJJTgBmzZCByA3PPCltyr7nTuKljze+oqon0ze5VN5tYm3tY9wsaIPPlNyYXwHtIdPEAp0uPQav4iLSOeSBaAIDBeJdN756CiXcJ741ORbKl6ENEygC1EwvALs6KDWPSysym/3y7knZxotr8qMD5v7CVOZQ2oF2ZeiJw23vkmV29LhxqZKxh4jpKKTjJnPE78DWITG9FZpUfv2SpsSQck5I29A+ZyBVC6GJJZJjaPOd3oKJJle+SJcFLeq58UUjpk4R1cnQIAmljwsfoKnW4cOIPTJ2co5by+/4M35U7LZiauNwYmHzBgObZRIwX5d3wPdeGPjwJUR1rmLaj8P/08U6Edl9vIclcI+jYC3pky13+DZVpjkH5vpD+t378bu3rHh4I2CMwzTUV1zJJWOCvBScSQcfV5DOF3g6DEVrIXVUgwRIWd+RYqkKAn7O1tU+rGPYDJH1tDtbWIGbFfSEgH/X2OStOplCMRio9Y7DhvrcY3zzpyzEz6sE0LjQ5Lm80/f9B37aJPMW0SLj18haZIxje2fhnDbSVX2ir3np48gUbo7M2WKG88tgx5o+KcjT3tZZuOkyhgfddibNwSXqXVxUthgRcaXU/XXSle8SZyU5ehG7xwznn1RGpwLPuV5IbGb3q9dWzZoaE9es1G2JARxokfIor+k/E9qudW4C96ADWXkCJkYxL4eYsyn2YGmO+SJU60Rfw5deqsF+WMEw3p5QZ4w7Go=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf080138-1599-46b0-cfe6-08dbcfdb36a4
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 13:07:42.7397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBS5k6Kl/AYWhue9Ffg1knJobzAYlkNTgw6s1zCBPCY2mnUKUeSbjehZElU5IhRsZAgxhGP0d7xZ1Gf5u1WgX9asLBcPeZ9aZUEHDJPm3nQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_11,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180108
X-Proofpoint-ORIG-GUID: Dv4YhhyIaCwBpPypMOSKRvEL-KexE7st
X-Proofpoint-GUID: Dv4YhhyIaCwBpPypMOSKRvEL-KexE7st
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

I rebased the V4 patch and added the new maintainers and reviewers.
Peter has already reviewed it.

- Steve

On 10/18/2023 9:03 AM, Steve Sistare wrote:
> Modify migrate_add_blocker and migrate_del_blocker to take an Error **
> reason.  This allows migration to own the Error object, so that if
> an error occurs in migrate_add_blocker, migration code can free the Error
> and clear the client handle, simplifying client code.  It also simplifies
> the migrate_del_blocker call site.
> 
> In addition, this is a pre-requisite for a proposed future patch that would
> add a mode argument to migration requests to support live update, and
> maintain a list of blockers for each mode.  A blocker may apply to a single
> mode or to multiple modes, and passing Error** will allow one Error object
> to be registered for multiple modes.
> 
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Tested-by: Michael Galaxy <mgalaxy@akamai.com>
> Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  backends/tpm/tpm_emulator.c  | 10 ++--------
>  block/parallels.c            |  8 +++-----
>  block/qcow.c                 |  6 ++----
>  block/vdi.c                  |  6 ++----
>  block/vhdx.c                 |  6 ++----
>  block/vmdk.c                 |  6 ++----
>  block/vpc.c                  |  6 ++----
>  block/vvfat.c                |  6 ++----
>  dump/dump.c                  |  4 ++--
>  hw/9pfs/9p.c                 | 10 ++--------
>  hw/display/virtio-gpu-base.c |  8 ++------
>  hw/intc/arm_gic_kvm.c        |  3 +--
>  hw/intc/arm_gicv3_its_kvm.c  |  3 +--
>  hw/intc/arm_gicv3_kvm.c      |  3 +--
>  hw/misc/ivshmem.c            |  8 ++------
>  hw/ppc/pef.c                 |  2 +-
>  hw/ppc/spapr.c               |  9 +--------
>  hw/ppc/spapr_events.c        |  6 +++++-
>  hw/ppc/spapr_rtas.c          |  2 +-
>  hw/remote/proxy.c            |  7 ++-----
>  hw/s390x/s390-virtio-ccw.c   |  9 +++------
>  hw/scsi/vhost-scsi.c         |  8 +++-----
>  hw/vfio/common.c             | 10 ++--------
>  hw/vfio/migration.c          | 16 ++--------------
>  hw/virtio/vhost.c            |  8 ++------
>  include/migration/blocker.h  | 24 +++++++++++++++++-------
>  migration/migration.c        | 22 ++++++++++++++--------
>  stubs/migr-blocker.c         |  4 ++--
>  target/i386/kvm/kvm.c        |  8 ++++----
>  target/i386/nvmm/nvmm-all.c  |  3 +--
>  target/i386/sev.c            |  2 +-
>  target/i386/whpx/whpx-all.c  |  3 +--
>  ui/vdagent.c                 |  5 ++---
>  33 files changed, 92 insertions(+), 149 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 402a2d6..bf1a90f 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -534,11 +534,8 @@ static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
>          error_setg(&tpm_emu->migration_blocker,
>                     "Migration disabled: TPM emulator does not support "
>                     "migration");
> -        if (migrate_add_blocker(tpm_emu->migration_blocker, &err) < 0) {
> +        if (migrate_add_blocker(&tpm_emu->migration_blocker, &err) < 0) {
>              error_report_err(err);
> -            error_free(tpm_emu->migration_blocker);
> -            tpm_emu->migration_blocker = NULL;
> -
>              return -1;
>          }
>      }
> @@ -1016,10 +1013,7 @@ static void tpm_emulator_inst_finalize(Object *obj)
>  
>      qapi_free_TPMEmulatorOptions(tpm_emu->options);
>  
> -    if (tpm_emu->migration_blocker) {
> -        migrate_del_blocker(tpm_emu->migration_blocker);
> -        error_free(tpm_emu->migration_blocker);
> -    }
> +    migrate_del_blocker(&tpm_emu->migration_blocker);
>  
>      tpm_sized_buffer_reset(&state_blobs->volatil);
>      tpm_sized_buffer_reset(&state_blobs->permanent);
> diff --git a/block/parallels.c b/block/parallels.c
> index d026ce9..691298c 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1366,7 +1366,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>      error_setg(&s->migration_blocker, "The Parallels format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    ret = migrate_add_blocker(&s->migration_blocker, errp);
>      if (ret < 0) {
>          error_setg(errp, "Migration blocker error");
>          goto fail;
> @@ -1403,7 +1403,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>          ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
>          if (ret < 0) {
>              error_setg_errno(errp, -ret, "Could not repair corrupted image");
> -            migrate_del_blocker(s->migration_blocker);
> +            migrate_del_blocker(&s->migration_blocker);
>              goto fail;
>          }
>      }
> @@ -1420,7 +1420,6 @@ fail:
>       */
>      parallels_free_used_bitmap(bs);
>  
> -    error_free(s->migration_blocker);
>      g_free(s->bat_dirty_bmap);
>      qemu_vfree(s->header);
>      return ret;
> @@ -1445,8 +1444,7 @@ static void parallels_close(BlockDriverState *bs)
>      g_free(s->bat_dirty_bmap);
>      qemu_vfree(s->header);
>  
> -    migrate_del_blocker(s->migration_blocker);
> -    error_free(s->migration_blocker);
> +    migrate_del_blocker(&s->migration_blocker);
>  }
>  
>  static bool parallels_is_support_dirty_bitmaps(BlockDriverState *bs)
> diff --git a/block/qcow.c b/block/qcow.c
> index d56d24a..0b34878 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -304,9 +304,8 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>      error_setg(&s->migration_blocker, "The qcow format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    ret = migrate_add_blocker(&s->migration_blocker, errp);
>      if (ret < 0) {
> -        error_free(s->migration_blocker);
>          goto fail;
>      }
>  
> @@ -799,8 +798,7 @@ static void qcow_close(BlockDriverState *bs)
>      g_free(s->cluster_cache);
>      g_free(s->cluster_data);
>  
> -    migrate_del_blocker(s->migration_blocker);
> -    error_free(s->migration_blocker);
> +    migrate_del_blocker(&s->migration_blocker);
>  }
>  
>  static int coroutine_fn GRAPH_UNLOCKED
> diff --git a/block/vdi.c b/block/vdi.c
> index 934e1b8..a68b2fd 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -495,9 +495,8 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
>      error_setg(&s->migration_blocker, "The vdi format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    ret = migrate_add_blocker(&s->migration_blocker, errp);
>      if (ret < 0) {
> -        error_free(s->migration_blocker);
>          goto fail_free_bmap;
>      }
>  
> @@ -985,8 +984,7 @@ static void vdi_close(BlockDriverState *bs)
>  
>      qemu_vfree(s->bmap);
>  
> -    migrate_del_blocker(s->migration_blocker);
> -    error_free(s->migration_blocker);
> +    migrate_del_blocker(&s->migration_blocker);
>  }
>  
>  static int vdi_has_zero_init(BlockDriverState *bs)
> diff --git a/block/vhdx.c b/block/vhdx.c
> index a67edcc..556ceae 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -985,8 +985,7 @@ static void vhdx_close(BlockDriverState *bs)
>      s->bat = NULL;
>      qemu_vfree(s->parent_entries);
>      s->parent_entries = NULL;
> -    migrate_del_blocker(s->migration_blocker);
> -    error_free(s->migration_blocker);
> +    migrate_del_blocker(&s->migration_blocker);
>      qemu_vfree(s->log.hdr);
>      s->log.hdr = NULL;
>      vhdx_region_unregister_all(s);
> @@ -1093,9 +1092,8 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
>      error_setg(&s->migration_blocker, "The vhdx format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    ret = migrate_add_blocker(&s->migration_blocker, errp);
>      if (ret < 0) {
> -        error_free(s->migration_blocker);
>          goto fail;
>      }
>  
> diff --git a/block/vmdk.c b/block/vmdk.c
> index e90649c..059958f 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1373,9 +1373,8 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
>      error_setg(&s->migration_blocker, "The vmdk format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    ret = migrate_add_blocker(&s->migration_blocker, errp);
>      if (ret < 0) {
> -        error_free(s->migration_blocker);
>          goto fail;
>      }
>  
> @@ -2854,8 +2853,7 @@ static void vmdk_close(BlockDriverState *bs)
>      vmdk_free_extents(bs);
>      g_free(s->create_type);
>  
> -    migrate_del_blocker(s->migration_blocker);
> -    error_free(s->migration_blocker);
> +    migrate_del_blocker(&s->migration_blocker);
>  }
>  
>  static int64_t coroutine_fn GRAPH_RDLOCK
> diff --git a/block/vpc.c b/block/vpc.c
> index ceb87dd..fbd94fc 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -449,9 +449,8 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>      error_setg(&s->migration_blocker, "The vpc format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    ret = migrate_add_blocker(&s->migration_blocker, errp);
>      if (ret < 0) {
> -        error_free(s->migration_blocker);
>          goto fail;
>      }
>  
> @@ -1187,8 +1186,7 @@ static void vpc_close(BlockDriverState *bs)
>      g_free(s->pageentry_u8);
>  #endif
>  
> -    migrate_del_blocker(s->migration_blocker);
> -    error_free(s->migration_blocker);
> +    migrate_del_blocker(&s->migration_blocker);
>  }
>  
>  static QemuOptsList vpc_create_opts = {
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 856b479..99a1c82 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1266,9 +1266,8 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>                     "The vvfat (rw) format used by node '%s' "
>                     "does not support live migration",
>                     bdrv_get_device_or_node_name(bs));
> -        ret = migrate_add_blocker(s->migration_blocker, errp);
> +        ret = migrate_add_blocker(&s->migration_blocker, errp);
>          if (ret < 0) {
> -            error_free(s->migration_blocker);
>              goto fail;
>          }
>      }
> @@ -3237,8 +3236,7 @@ static void vvfat_close(BlockDriverState *bs)
>      g_free(s->cluster_buffer);
>  
>      if (s->qcow) {
> -        migrate_del_blocker(s->migration_blocker);
> -        error_free(s->migration_blocker);
> +        migrate_del_blocker(&s->migration_blocker);
>      }
>  }
>  
> diff --git a/dump/dump.c b/dump/dump.c
> index d3578dd..d355ada 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -111,7 +111,7 @@ static int dump_cleanup(DumpState *s)
>              qemu_mutex_unlock_iothread();
>          }
>      }
> -    migrate_del_blocker(dump_migration_blocker);
> +    migrate_del_blocker(&dump_migration_blocker);
>  
>      return 0;
>  }
> @@ -2158,7 +2158,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
>       * Allows even for -only-migratable, but forbid migration during the
>       * process of dump guest memory.
>       */
> -    if (migrate_add_blocker_internal(dump_migration_blocker, errp)) {
> +    if (migrate_add_blocker_internal(&dump_migration_blocker, errp)) {
>          /* Remember to release the fd before passing it over to dump state */
>          close(fd);
>          return;
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 323f042..af636cf 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -406,11 +406,7 @@ static int coroutine_fn put_fid(V9fsPDU *pdu, V9fsFidState *fidp)
>               * delete the migration blocker. Ideally, this
>               * should be hooked to transport close notification
>               */
> -            if (pdu->s->migration_blocker) {
> -                migrate_del_blocker(pdu->s->migration_blocker);
> -                error_free(pdu->s->migration_blocker);
> -                pdu->s->migration_blocker = NULL;
> -            }
> +            migrate_del_blocker(&pdu->s->migration_blocker);
>          }
>          return free_fid(pdu, fidp);
>      }
> @@ -1505,10 +1501,8 @@ static void coroutine_fn v9fs_attach(void *opaque)
>          error_setg(&s->migration_blocker,
>                     "Migration is disabled when VirtFS export path '%s' is mounted in the guest using mount_tag '%s'",
>                     s->ctx.fs_root ? s->ctx.fs_root : "NULL", s->tag);
> -        err = migrate_add_blocker(s->migration_blocker, NULL);
> +        err = migrate_add_blocker(&s->migration_blocker, NULL);
>          if (err < 0) {
> -            error_free(s->migration_blocker);
> -            s->migration_blocker = NULL;
>              clunk_fid(s, fid);
>              goto out;
>          }
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index ca1fb7b..8eb4fbb 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -184,8 +184,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>  
>      if (virtio_gpu_virgl_enabled(g->conf)) {
>          error_setg(&g->migration_blocker, "virgl is not yet migratable");
> -        if (migrate_add_blocker(g->migration_blocker, errp) < 0) {
> -            error_free(g->migration_blocker);
> +        if (migrate_add_blocker(&g->migration_blocker, errp) < 0) {
>              return false;
>          }
>      }
> @@ -249,10 +248,7 @@ virtio_gpu_base_device_unrealize(DeviceState *qdev)
>  {
>      VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
>  
> -    if (g->migration_blocker) {
> -        migrate_del_blocker(g->migration_blocker);
> -        error_free(g->migration_blocker);
> -    }
> +    migrate_del_blocker(&g->migration_blocker);
>  }
>  
>  static void
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index 1d58894..e0d9e51 100644
> --- a/hw/intc/arm_gic_kvm.c
> +++ b/hw/intc/arm_gic_kvm.c
> @@ -516,8 +516,7 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
>      if (!kvm_arm_gic_can_save_restore(s)) {
>          error_setg(&s->migration_blocker, "This operating system kernel does "
>                                            "not support vGICv2 migration");
> -        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
> -            error_free(s->migration_blocker);
> +        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
>              return;
>          }
>      }
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 7eda9fb..61c1cc7 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -114,8 +114,7 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
>          GITS_CTLR)) {
>          error_setg(&s->migration_blocker, "This operating system kernel "
>                     "does not support vITS migration");
> -        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
> -            error_free(s->migration_blocker);
> +        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
>              return;
>          }
>      } else {
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 72ad916..77eb37e 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -878,8 +878,7 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>                                 GICD_CTLR)) {
>          error_setg(&s->migration_blocker, "This operating system kernel does "
>                                            "not support vGICv3 migration");
> -        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
> -            error_free(s->migration_blocker);
> +        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
>              return;
>          }
>      }
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index d66d912..0447888 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -903,8 +903,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
>      if (!ivshmem_is_master(s)) {
>          error_setg(&s->migration_blocker,
>                     "Migration is disabled when using feature 'peer mode' in device 'ivshmem'");
> -        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
> -            error_free(s->migration_blocker);
> +        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
>              return;
>          }
>      }
> @@ -922,10 +921,7 @@ static void ivshmem_exit(PCIDevice *dev)
>      IVShmemState *s = IVSHMEM_COMMON(dev);
>      int i;
>  
> -    if (s->migration_blocker) {
> -        migrate_del_blocker(s->migration_blocker);
> -        error_free(s->migration_blocker);
> -    }
> +    migrate_del_blocker(&s->migration_blocker);
>  
>      if (memory_region_is_mapped(s->ivshmem_bar2)) {
>          if (!s->hostmem) {
> diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
> index cc44d5e..d28ed3b 100644
> --- a/hw/ppc/pef.c
> +++ b/hw/ppc/pef.c
> @@ -63,7 +63,7 @@ static int kvmppc_svm_init(ConfidentialGuestSupport *cgs, Error **errp)
>      /* add migration blocker */
>      error_setg(&pef_mig_blocker, "PEF: Migration is not implemented");
>      /* NB: This can fail if --only-migratable is used */
> -    migrate_add_blocker(pef_mig_blocker, &error_fatal);
> +    migrate_add_blocker(&pef_mig_blocker, &error_fatal);
>  
>      cgs->ready = true;
>  
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cb84067..b25093b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1761,7 +1761,7 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
>      /* Signal all vCPUs waiting on this condition */
>      qemu_cond_broadcast(&spapr->fwnmi_machine_check_interlock_cond);
>  
> -    migrate_del_blocker(spapr->fwnmi_migration_blocker);
> +    migrate_del_blocker(&spapr->fwnmi_migration_blocker);
>  }
>  
>  static void spapr_create_nvram(SpaprMachineState *spapr)
> @@ -2937,13 +2937,6 @@ static void spapr_machine_init(MachineState *machine)
>          spapr_create_lmb_dr_connectors(spapr);
>      }
>  
> -    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_ON) {
> -        /* Create the error string for live migration blocker */
> -        error_setg(&spapr->fwnmi_migration_blocker,
> -            "A machine check is being handled during migration. The handler"
> -            "may run and log hardware error on the destination");
> -    }
> -
>      if (mc->nvdimm_supported) {
>          spapr_create_nvdimm_dr_connectors(spapr);
>      }
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 4508e40..deb4641 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -920,7 +920,11 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>       * fails when running with -only-migrate.  A proper interface to
>       * delay migration completion for a bit could avoid that.
>       */
> -    ret = migrate_add_blocker(spapr->fwnmi_migration_blocker, NULL);
> +    error_setg(&spapr->fwnmi_migration_blocker,
> +        "A machine check is being handled during migration. The handler"
> +        "may run and log hardware error on the destination");
> +
> +    ret = migrate_add_blocker(&spapr->fwnmi_migration_blocker, NULL);
>      if (ret == -EBUSY) {
>          warn_report("Received a fwnmi while migration was in progress");
>      }
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 7df2158..26c384b 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -496,7 +496,7 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>      spapr->fwnmi_machine_check_interlock = -1;
>      qemu_cond_signal(&spapr->fwnmi_machine_check_interlock_cond);
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> -    migrate_del_blocker(spapr->fwnmi_migration_blocker);
> +    migrate_del_blocker(&spapr->fwnmi_migration_blocker);
>  }
>  
>  static struct rtas_call {
> diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
> index 2052d72..fbc85a8 100644
> --- a/hw/remote/proxy.c
> +++ b/hw/remote/proxy.c
> @@ -107,8 +107,7 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
>  
>      error_setg(&dev->migration_blocker, "%s does not support migration",
>                 TYPE_PCI_PROXY_DEV);
> -    if (migrate_add_blocker(dev->migration_blocker, errp) < 0) {
> -        error_free(dev->migration_blocker);
> +    if (migrate_add_blocker(&dev->migration_blocker, errp) < 0) {
>          object_unref(dev->ioc);
>          return;
>      }
> @@ -134,9 +133,7 @@ static void pci_proxy_dev_exit(PCIDevice *pdev)
>          qio_channel_close(dev->ioc, NULL);
>      }
>  
> -    migrate_del_blocker(dev->migration_blocker);
> -
> -    error_free(dev->migration_blocker);
> +    migrate_del_blocker(&dev->migration_blocker);
>  
>      proxy_memory_listener_deconfigure(&dev->proxy_listener);
>  
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 2d75f21..07a5157 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -332,8 +332,7 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
>          s390_pv_vm_disable();
>      }
>      ms->pv = false;
> -    migrate_del_blocker(pv_mig_blocker);
> -    error_free_or_abort(&pv_mig_blocker);
> +    migrate_del_blocker(&pv_mig_blocker);
>      ram_block_discard_disable(false);
>  }
>  
> @@ -356,11 +355,10 @@ static int s390_machine_protect(S390CcwMachineState *ms)
>  
>      error_setg(&pv_mig_blocker,
>                 "protected VMs are currently not migratable.");
> -    rc = migrate_add_blocker(pv_mig_blocker, &local_err);
> +    rc = migrate_add_blocker(&pv_mig_blocker, &local_err);
>      if (rc) {
>          ram_block_discard_disable(false);
>          error_report_err(local_err);
> -        error_free_or_abort(&pv_mig_blocker);
>          return rc;
>      }
>  
> @@ -368,8 +366,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
>      rc = s390_pv_vm_enable();
>      if (rc) {
>          ram_block_discard_disable(false);
> -        migrate_del_blocker(pv_mig_blocker);
> -        error_free_or_abort(&pv_mig_blocker);
> +        migrate_del_blocker(&pv_mig_blocker);
>          return rc;
>      }
>  
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 443f67d..14e23cc 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -208,7 +208,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>                  "When external environment supports it (Orchestrator migrates "
>                  "target SCSI device state or use shared storage over network), "
>                  "set 'migratable' property to true to enable migration.");
> -        if (migrate_add_blocker(vsc->migration_blocker, errp) < 0) {
> +        if (migrate_add_blocker(&vsc->migration_blocker, errp) < 0) {
>              goto free_virtio;
>          }
>      }
> @@ -241,10 +241,9 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>   free_vqs:
>      g_free(vqs);
>      if (!vsc->migratable) {
> -        migrate_del_blocker(vsc->migration_blocker);
> +        migrate_del_blocker(&vsc->migration_blocker);
>      }
>   free_virtio:
> -    error_free(vsc->migration_blocker);
>      virtio_scsi_common_unrealize(dev);
>   close_fd:
>      if (vhostfd >= 0) {
> @@ -260,8 +259,7 @@ static void vhost_scsi_unrealize(DeviceState *dev)
>      struct vhost_virtqueue *vqs = vsc->dev.vqs;
>  
>      if (!vsc->migratable) {
> -        migrate_del_blocker(vsc->migration_blocker);
> -        error_free(vsc->migration_blocker);
> +        migrate_del_blocker(&vsc->migration_blocker);
>      }
>  
>      /* This will stop vhost backend. */
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 1346492..a697f66 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -412,11 +412,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>      error_setg(&multiple_devices_migration_blocker,
>                 "Multiple VFIO devices migration is supported only if all of "
>                 "them support P2P migration");
> -    ret = migrate_add_blocker(multiple_devices_migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(multiple_devices_migration_blocker);
> -        multiple_devices_migration_blocker = NULL;
> -    }
> +    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
>  
>      return ret;
>  }
> @@ -428,9 +424,7 @@ void vfio_unblock_multiple_devices_migration(void)
>          return;
>      }
>  
> -    migrate_del_blocker(multiple_devices_migration_blocker);
> -    error_free(multiple_devices_migration_blocker);
> -    multiple_devices_migration_blocker = NULL;
> +    migrate_del_blocker(&multiple_devices_migration_blocker);
>  }
>  
>  bool vfio_viommu_preset(VFIODevice *vbasedev)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index da43dcd..0aaad65 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -891,8 +891,6 @@ static void vfio_migration_deinit(VFIODevice *vbasedev)
>  
>  static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>  {
> -    int ret;
> -
>      if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>          error_propagate(errp, err);
>          return -EINVAL;
> @@ -901,13 +899,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>      vbasedev->migration_blocker = error_copy(err);
>      error_free(err);
>  
> -    ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(vbasedev->migration_blocker);
> -        vbasedev->migration_blocker = NULL;
> -    }
> -
> -    return ret;
> +    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
>  }
>  
>  /* ---------------------------------------------------------------------- */
> @@ -994,9 +986,5 @@ void vfio_migration_exit(VFIODevice *vbasedev)
>          vfio_migration_deinit(vbasedev);
>      }
>  
> -    if (vbasedev->migration_blocker) {
> -        migrate_del_blocker(vbasedev->migration_blocker);
> -        error_free(vbasedev->migration_blocker);
> -        vbasedev->migration_blocker = NULL;
> -    }
> +    migrate_del_blocker(&vbasedev->migration_blocker);
>  }
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 9cfac40..4d09793 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1478,9 +1478,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      }
>  
>      if (hdev->migration_blocker != NULL) {
> -        r = migrate_add_blocker(hdev->migration_blocker, errp);
> +        r = migrate_add_blocker(&hdev->migration_blocker, errp);
>          if (r < 0) {
> -            error_free(hdev->migration_blocker);
>              goto fail_busyloop;
>          }
>      }
> @@ -1530,10 +1529,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>          memory_listener_unregister(&hdev->memory_listener);
>          QLIST_REMOVE(hdev, entry);
>      }
> -    if (hdev->migration_blocker) {
> -        migrate_del_blocker(hdev->migration_blocker);
> -        error_free(hdev->migration_blocker);
> -    }
> +    migrate_del_blocker(&hdev->migration_blocker);
>      g_free(hdev->mem);
>      g_free(hdev->mem_sections);
>      if (hdev->vhost_ops) {
> diff --git a/include/migration/blocker.h b/include/migration/blocker.h
> index 9cebe2b..b048f30 100644
> --- a/include/migration/blocker.h
> +++ b/include/migration/blocker.h
> @@ -17,19 +17,23 @@
>  /**
>   * @migrate_add_blocker - prevent migration from proceeding
>   *
> - * @reason - an error to be returned whenever migration is attempted
> + * @reasonp - address of an error to be returned whenever migration is attempted
>   *
>   * @errp - [out] The reason (if any) we cannot block migration right now.
>   *
>   * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
> + *
> + * *@reasonp is freed and set to NULL if failure is returned.
> + * On success, the caller must not free @reasonp, except by
> + *   calling migrate_del_blocker.
>   */
> -int migrate_add_blocker(Error *reason, Error **errp);
> +int migrate_add_blocker(Error **reasonp, Error **errp);
>  
>  /**
>   * @migrate_add_blocker_internal - prevent migration from proceeding without
>   *                                 only-migrate implications
>   *
> - * @reason - an error to be returned whenever migration is attempted
> + * @reasonp - address of an error to be returned whenever migration is attempted
>   *
>   * @errp - [out] The reason (if any) we cannot block migration right now.
>   *
> @@ -38,14 +42,20 @@ int migrate_add_blocker(Error *reason, Error **errp);
>   * Some of the migration blockers can be temporary (e.g., for a few seconds),
>   * so it shouldn't need to conflict with "-only-migratable".  For those cases,
>   * we can call this function rather than @migrate_add_blocker().
> + *
> + * *@reasonp is freed and set to NULL if failure is returned.
> + * On success, the caller must not free @reasonp, except by
> + *   calling migrate_del_blocker.
>   */
> -int migrate_add_blocker_internal(Error *reason, Error **errp);
> +int migrate_add_blocker_internal(Error **reasonp, Error **errp);
>  
>  /**
> - * @migrate_del_blocker - remove a blocking error from migration
> + * @migrate_del_blocker - remove a blocking error from migration and free it.
>   *
> - * @reason - the error blocking migration
> + * @reasonp - address of the error blocking migration
> + *
> + * This function frees *@reasonp and sets it to NULL.
>   */
> -void migrate_del_blocker(Error *reason);
> +void migrate_del_blocker(Error **reasonp);
>  
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 1c6c81a..65f9791 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1462,35 +1462,41 @@ int migrate_init(MigrationState *s, Error **errp)
>      return 0;
>  }
>  
> -int migrate_add_blocker_internal(Error *reason, Error **errp)
> +int migrate_add_blocker_internal(Error **reasonp, Error **errp)
>  {
>      /* Snapshots are similar to migrations, so check RUN_STATE_SAVE_VM too. */
>      if (runstate_check(RUN_STATE_SAVE_VM) || !migration_is_idle()) {
> -        error_propagate_prepend(errp, error_copy(reason),
> +        error_propagate_prepend(errp, *reasonp,
>                                  "disallowing migration blocker "
>                                  "(migration/snapshot in progress) for: ");
> +        *reasonp = NULL;
>          return -EBUSY;
>      }
>  
> -    migration_blockers = g_slist_prepend(migration_blockers, reason);
> +    migration_blockers = g_slist_prepend(migration_blockers, *reasonp);
>      return 0;
>  }
>  
> -int migrate_add_blocker(Error *reason, Error **errp)
> +int migrate_add_blocker(Error **reasonp, Error **errp)
>  {
>      if (only_migratable) {
> -        error_propagate_prepend(errp, error_copy(reason),
> +        error_propagate_prepend(errp, *reasonp,
>                                  "disallowing migration blocker "
>                                  "(--only-migratable) for: ");
> +        *reasonp = NULL;
>          return -EACCES;
>      }
>  
> -    return migrate_add_blocker_internal(reason, errp);
> +    return migrate_add_blocker_internal(reasonp, errp);
>  }
>  
> -void migrate_del_blocker(Error *reason)
> +void migrate_del_blocker(Error **reasonp)
>  {
> -    migration_blockers = g_slist_remove(migration_blockers, reason);
> +    if (*reasonp) {
> +        migration_blockers = g_slist_remove(migration_blockers, *reasonp);
> +        error_free(*reasonp);
> +        *reasonp = NULL;
> +    }
>  }
>  
>  void qmp_migrate_incoming(const char *uri, Error **errp)
> diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
> index 5676a2f..17a5dbf 100644
> --- a/stubs/migr-blocker.c
> +++ b/stubs/migr-blocker.c
> @@ -1,11 +1,11 @@
>  #include "qemu/osdep.h"
>  #include "migration/blocker.h"
>  
> -int migrate_add_blocker(Error *reason, Error **errp)
> +int migrate_add_blocker(Error **reasonp, Error **errp)
>  {
>      return 0;
>  }
>  
> -void migrate_del_blocker(Error *reason)
> +void migrate_del_blocker(Error **reasonp)
>  {
>  }
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index f6c7f7e..83b0c0d 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1601,7 +1601,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>          error_setg(&hv_passthrough_mig_blocker,
>                     "'hv-passthrough' CPU flag prevents migration, use explicit"
>                     " set of hv-* flags instead");
> -        ret = migrate_add_blocker(hv_passthrough_mig_blocker, &local_err);
> +        ret = migrate_add_blocker(&hv_passthrough_mig_blocker, &local_err);
>          if (ret < 0) {
>              error_report_err(local_err);
>              return ret;
> @@ -1615,7 +1615,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>                     " use explicit 'hv-no-nonarch-coresharing=on' instead (but"
>                     " make sure SMT is disabled and/or that vCPUs are properly"
>                     " pinned)");
> -        ret = migrate_add_blocker(hv_no_nonarch_cs_mig_blocker, &local_err);
> +        ret = migrate_add_blocker(&hv_no_nonarch_cs_mig_blocker, &local_err);
>          if (ret < 0) {
>              error_report_err(local_err);
>              return ret;
> @@ -2211,7 +2211,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              error_setg(&invtsc_mig_blocker,
>                         "State blocked by non-migratable CPU device"
>                         " (invtsc flag)");
> -            r = migrate_add_blocker(invtsc_mig_blocker, &local_err);
> +            r = migrate_add_blocker(&invtsc_mig_blocker, &local_err);
>              if (r < 0) {
>                  error_report_err(local_err);
>                  return r;
> @@ -2269,7 +2269,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      return 0;
>  
>   fail:
> -    migrate_del_blocker(invtsc_mig_blocker);
> +    migrate_del_blocker(&invtsc_mig_blocker);
>  
>      return r;
>  }
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index fb76986..7d752bc 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -929,9 +929,8 @@ nvmm_init_vcpu(CPUState *cpu)
>          error_setg(&nvmm_migration_blocker,
>              "NVMM: Migration not supported");
>  
> -        if (migrate_add_blocker(nvmm_migration_blocker, &local_error) < 0) {
> +        if (migrate_add_blocker(&nvmm_migration_blocker, &local_error) < 0) {
>              error_report_err(local_error);
> -            error_free(nvmm_migration_blocker);
>              return -EINVAL;
>          }
>      }
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index fe2144c..9a71246 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -891,7 +891,7 @@ sev_launch_finish(SevGuestState *sev)
>      /* add migration blocker */
>      error_setg(&sev_mig_blocker,
>                 "SEV: Migration is not implemented");
> -    migrate_add_blocker(sev_mig_blocker, &error_fatal);
> +    migrate_add_blocker(&sev_mig_blocker, &error_fatal);
>  }
>  
>  static void
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index df3aba2..d29ba91 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -2160,9 +2160,8 @@ int whpx_init_vcpu(CPUState *cpu)
>                 "State blocked due to non-migratable CPUID feature support,"
>                 "dirty memory tracking support, and XSAVE/XRSTOR support");
>  
> -        if (migrate_add_blocker(whpx_migration_blocker, &local_error) < 0) {
> +        if (migrate_add_blocker(&whpx_migration_blocker, &local_error) < 0) {
>              error_report_err(local_error);
> -            error_free(whpx_migration_blocker);
>              ret = -EINVAL;
>              goto error;
>          }
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 00d36a8..d8f2f95 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -671,7 +671,7 @@ static void vdagent_chr_open(Chardev *chr,
>      return;
>  #endif
>  
> -    if (migrate_add_blocker(vd->migration_blocker, errp) != 0) {
> +    if (migrate_add_blocker(&vd->migration_blocker, errp) != 0) {
>          return;
>      }
>  
> @@ -924,13 +924,12 @@ static void vdagent_chr_fini(Object *obj)
>  {
>      VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
>  
> -    migrate_del_blocker(vd->migration_blocker);
> +    migrate_del_blocker(&vd->migration_blocker);
>      vdagent_disconnect(vd);
>      if (vd->mouse_hs) {
>          qemu_input_handler_unregister(vd->mouse_hs);
>      }
>      buffer_free(&vd->outbuf);
> -    error_free(vd->migration_blocker);
>  }
>  
>  static const TypeInfo vdagent_chr_type_info = {

