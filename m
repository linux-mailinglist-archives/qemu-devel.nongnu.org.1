Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAA2828CD8
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:43:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNH3Q-0007J2-Gm; Tue, 09 Jan 2024 13:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rNH3L-0007Ha-Te
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:42:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rNH3H-0001Fw-3z
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:42:19 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409GPJOl028013; Tue, 9 Jan 2024 18:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=rdPPRI5I07e6ygBKJaESDk//4ZDR3oj3IjAqf+QnWq0=;
 b=SCG1eIgVwkNCRgbHDT5u05n7GRsQ+vkbMOuvxpg8LYsCg/L1rEB49RQXMldy6dwoi5lt
 VKHtLsAph2dHtf+hV/yPf/HnOJAjtEmfo8e+wean3xJCpOY/YaozAFX+Y5ggwVCP/CCh
 rOuVqJ0cv3RNgTSYSLxflaGyLdIc0xelRG+QVLmsKPmkZmTYUZdmqmbJPZdg+LG+26YJ
 yadebgdrK03SESEIKFoUp8tXYZ3MddqbqOIIKQTbqC+NK87w9p3a9LtMd/jvvMuI4Co+
 no2uhKBSt2WeOlEMmTmTzf4fmrOJgXlakcx/ZG7cK4vuj6gIEolax9tABPNjjNotV36z fQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh83dgnys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jan 2024 18:42:10 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 409I3kvS012149; Tue, 9 Jan 2024 18:42:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfuwh77fj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jan 2024 18:42:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8Us5ULj8MnPqyEWhCzeuew1ogyJ/PV26vWQ9qxiaCjHFQd9jGMg/ptz59NZdkEefr3Scs+kZQ2ahIiIE31FWtNkOZWjgsYRUtZzdXwrdnCUAVb0FEnv6Szk3EJZJNO7Wd1SFjh+xGEn34oZeV8/3sbH4jPNyIdinX6kpnp0mQDaG7OF2HSqX3tip6IwR7Y7aNH7tvvUBFzgHygN0LIsesWy0RWGo1eEPz8UpxwJPUmrRNH7zMbBl9SEWvE2owbKOwqChKaSbgfw7+LQndrgR1mYbomJar+FC8PFtqYiu4iZJsjcK5i6nYY4wri8NCCTUFpMXBrq8z2ing2cTUz9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdPPRI5I07e6ygBKJaESDk//4ZDR3oj3IjAqf+QnWq0=;
 b=iXnjr8zfpyPFAWcIQaJtme7V9xU4jQGGf0PEHcBNUhao1NpBP85IVRkBTN7DqNAUM2F7veaZ7ht4bkOyh3FwHCYW0uHaMOdTFhcsuIJkOGqJXygIjBJVSJ/jvIVXO9wJpDMqbI3CSd1eiilWnHu8lIKoSV20TjJz3xXNAtSNUskHXLMDhyV5yMX5ttA1+GlxVuYDOjoNXi4jLRXgw0jYdvtFRP6v51S/yM3HbdRZ0P4ztU5+DQudkkQC07QvR8VLwz4xVpQ4WtNBsuf8LeZA0XMrAtnKjKoW6JDEyRjCvB9Qd5Ygeg4igmefv0CCSIhFOqFz903+Tmbz+zYN40ffUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdPPRI5I07e6ygBKJaESDk//4ZDR3oj3IjAqf+QnWq0=;
 b=yyVknGeK3tOlXFNS+hj3UeH9dkuN5+tgElM1JGdO2Aca63qOwC1YVWB101b1E1zwcjKZMf8Z/XZ3dpiiLQkpSWclWtk5f5z1v3X6sPiKRiPJpI/WphIb+0yNZTRrBa4M0O15ckmRg5h2k3Cxtu5BEzcA2rfq27m5zOyR7vLudEU=
Received: from SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16)
 by CH2PR10MB4247.namprd10.prod.outlook.com (2603:10b6:610:7a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 18:42:06 +0000
Received: from SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535]) by SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535%6]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 18:42:06 +0000
Message-ID: <c44c60b2-bc82-4884-a7df-98b327737495@oracle.com>
Date: Tue, 9 Jan 2024 12:42:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] oslib-posix: refactor memory prealloc threads
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20240108151041.529716-1-mark.kanda@oracle.com>
 <20240108151041.529716-2-mark.kanda@oracle.com>
 <2be78fc2-f76a-44de-8db7-fbc1bbdc0d2b@redhat.com>
 <1854ecdd-88d8-462d-aa0f-990c2bbe57ff@oracle.com>
 <02801117-4408-4069-b0ba-b54f4d050fc4@redhat.com>
 <ZZ1VDF0U7PkOwgWh@redhat.com>
 <fc3a6a13-6a2d-44c4-9cf0-a91dc2cf1b97@redhat.com>
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <fc3a6a13-6a2d-44c4-9cf0-a91dc2cf1b97@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:802:21::34) To SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_|CH2PR10MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 5130944d-3e1a-4a4b-d648-08dc1142add5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: airXoH/5YkTOw7DcjGfYOd8FlfmTCohuYO0E32wPqDEMs3w8Kd6tGzaOLr67pYclrnILA9oFAtoAFdmTbsce+QmDawx0nOt+xR99hRWTroFmPFvs1E56eLdqfovmWxv5Xwjy7tgcvpXymc+QTayfSIk8Z7CSozUuIWo4v8l7y09VLH3QvRjw/mbuCBOa8UdP29D2LiTargDS16p8ta+Q8OGeJYyJKSO3rtHslvJFVTZ9AP+807kvy9hc4G+CNzT1b12Ric35fus3bSgmKVotfEZYPifqGNWJ/4sNfDFLCYc+PQ6wy0LtZOiUkr883ejNj+KhO3/0WtQvVcJ/MSwLqBAiJ7wwblSp5AzWyQWwie7e12KxMQTS6kFAsbyaPd+lsyOz10nnsfm8RQ/hqXYy0nseZxzvaWz6clQUtQoQScWWyjG914G8pT9SEt18bhP2KuCxNAwtxro0GCtR3T8uWLXGCeLc0s+/8UZp9ebLOm7KAXlq5iW9isH3dkczn/VIZFmlaXKX31z08hlVX56AupA6poCjizWWUksyKp4HecdV/sZs0t1umb5gpfG+U4eSNEa7y+8KYoj6amcL0guEAbOmiE6gy/COpIsCjzcW+jZbRx4aTIJh5eqJiyg85WI+6IViPFSz1PZ4s9PFb1RjQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5841.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(66899024)(83380400001)(66946007)(41300700001)(86362001)(36756003)(31696002)(38100700002)(26005)(2616005)(6512007)(6506007)(53546011)(6486002)(2906002)(66476007)(478600001)(110136005)(316002)(6666004)(66556008)(5660300002)(8676002)(8936002)(4326008)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU9HOXlGak93RTBjN0x6RVFyZ2Exb2hHVnN5TGhaNklDekRiZXFJdlRTckd3?=
 =?utf-8?B?OG1KOGZSM2ZJektvalJFOFNkYzNFaVM2cVJtMCtIQ2YrY0FRZ2t6dFpZWEcv?=
 =?utf-8?B?UTJtcndhcS9QTVlyZXdWbmxBNXJ3NnB1VWNOTmtNYXd5eU8wam9TMGJjeGwy?=
 =?utf-8?B?ZzA1dm5FdmFPTFVlZWtyMEFEZktDQUNUeVBUNVFsMW12SFJWT2hKQmMrbnFW?=
 =?utf-8?B?RHVpZHdsZlVqaDZSUEU3eFJNTFFoYTNjaG9qUmp6d3hPVWdnL3BET2lFT1dV?=
 =?utf-8?B?QUtCTW5GcnhoVG9Zb0pGZ1hnNnZIaWdHc3Q4OGVEdzdtMmJ0RjVXQ3dVYllD?=
 =?utf-8?B?MHJIRjN2K1FiYWE4RWkvRTZrWWF0YW82U0lvVlVldW5JNXk0b2UrdUxXTEdj?=
 =?utf-8?B?dlJHdWlDaEVPSFpZQWtCWkNyeVJhUlZNdkMySHA2UnNKYVZRMStSeTNEMXVJ?=
 =?utf-8?B?NnFpMlBRQnBzSm1uMjJlYjRNL20vMi9MTWJJbjk0ZTQrdElmMnVMKzB1dE5Z?=
 =?utf-8?B?MnNqbVJqejV5Q0pYUmlvcjF5Q3d0T3BzSHdrZEl3c2NtK3FxQ2tyc2ZDMUE2?=
 =?utf-8?B?dGw2bFhGcTJ3cWp3UGJWMGVGeXlSVnNidlhyTG94TTNKc1F4aEVsRW4wV2dX?=
 =?utf-8?B?Z2NLVTZXZFNTYy9JMytiM0VKZjMvK2thYURpZEJnYjFRVmtBdlJyazRZR1ho?=
 =?utf-8?B?NnJ1NlRJYzlhTDMzSDdPWGN0WVVEaXhzWFRRV3dBT2FwcEpCa3RqazUxVFdN?=
 =?utf-8?B?eTV5TGg1YmZrQVZ5eklYRmdiSDIrQStFSVYrR1A5QlpqZnFld1pQcm8vUWtV?=
 =?utf-8?B?NVkwTkQyQ0owNExYRzgrZUxsTmt3bzByTzRmQ2lWalNBVWpPMmgyR0l0a1Nw?=
 =?utf-8?B?bVVacExTb2xpdjVLdGN0UVpOdkZwaHVObDluZDBOUnJLWTZBd2F6djVkVjg4?=
 =?utf-8?B?SlZ4UkEwQW9nZHhXTHFOM3F2dGRUbWxVdWptc3FWNlptdTA2YVNnTFRXaVpZ?=
 =?utf-8?B?azJ6QXJlQlY2QnN3TzlmWWZIUFdLWFh1VWNObE0yYXRjM1FqZFZYN2hLQnUw?=
 =?utf-8?B?V1lJUllsNzFpaUg4MnNtZXpTdURESmIyRjJhN21jQmlKY0tFMzlqMDQyaHhJ?=
 =?utf-8?B?aWZ1OTIxdkdRVlFJMHduY0o5TEtsUnhqVllUVUdOZHJpYnUzZ0krOHZ0TTgr?=
 =?utf-8?B?NFFlT2V2UVg3SUE0YnBpSmJzVHB6MmZDYVdiODhPVDdxZ1VjWXNwYktWNkVK?=
 =?utf-8?B?cytYMnFNSzZHdmxLMWVUNENZNzQ5OGdadlNKK052a055KzlWVEZNbGQwRlF2?=
 =?utf-8?B?NG5uOS9udFI4dGNOZXVFNjlscExwN2pUUTUyUlRXRklpVEdiRVBBaGlReHNR?=
 =?utf-8?B?YmdZdFFPR2xKV2tJc1BFL2FRRm5aLzFnamJBamhLVzV6MWYxS3dsN0tOQnRj?=
 =?utf-8?B?TTFFYlZ5MC9tNXpoWWo3TlNwYThqa1k5RnI0Q1Q5TVlJUm5VSDh4aEIvbmJm?=
 =?utf-8?B?ME1sQUpkazA5SFozMU5MSVlXZ3hSK0FyQ1J4ZlZjckhIWEhsK0ZndHIwelJ2?=
 =?utf-8?B?akRJci9DaTN1VExmQ0dyalkxV1VudVU4RktyaVdhaGQzcGRybTFvL3hSMUdQ?=
 =?utf-8?B?eUY1R2N6ZW5SN0VGZGpkZHU3aUJQKy9abGczbHk1dnlZMkpqaFZVeERoMmR5?=
 =?utf-8?B?bUwrelV3b1NXUDEvb1kxcUhTREpBM2E2UzN0TSt1TEVXV2FRSmt6L2FGSVJZ?=
 =?utf-8?B?V040TkZWV1AxcnVUS3hLd1A2V2RHR1BGd0IramdVcDl4ZFYzanpaWFBwSkh0?=
 =?utf-8?B?My9QQWNmNUU0Ty9ES3RiVXUvNUZwRUZXSE9DTS81bjNRKzcwcDV0WnRxRzRD?=
 =?utf-8?B?b3lhRnNLdWlpK3BaTVVoeUp0WnlsZkY0aXN3OEZBWm5Kc2hUbThUL0RQeWZ6?=
 =?utf-8?B?ZHhpTFp5UUw5TXhSWCtyOWJpU292dHhra3JudFA4dlQycTAzQXYxUm5VTFBv?=
 =?utf-8?B?VmZxNlA5UE9rdFdDYXRpQTRuaExvUjhRQTVUL3hFUlRyb1hjUFdlTXAzSHRX?=
 =?utf-8?B?dlhuTVZZSldPMTBCRVNaeTdrMGVSMnhZTFh1MW1XSGVseHBtd1I3ZnFJMU1a?=
 =?utf-8?Q?IF73dFRQiyvKs6vp1Lbb6Ezk/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GBwxgs2uuVKxUmG7uVYGnb6gwsv5Bro2IFutfW1E2qk3PYdhRfCXBuBaXOMEatB366pOrR8TmEDROnHMBiSl9gaqvYt5vxSf/uDrJ4+6xX1foJekhLc0wf6UKY1X2oLwJKTRrcki8WwPfpDB7LgWaToo4BgYucdz2HVWbp08RcIGKUXiMGVecZiW9MHHHx0eR26+Go6N2jIZmxPZsr3v1BH9bUUwYLDY8pdR4cQrrgKYoxBr4yEnqOoaoooOH7q0ftGsfJDN+SXv+PSkJId2nnGYBaS0O9wL6RPKSe70QoARmhTIf5srT2Nr1FvewqyqZJhXi+zLMFYs04p5W7T86pKMOePCCPpas2HM2N1W9WFALdAsdIeVzJx8zj95V6MUOsHQhQrsUsubS31vr66R3f1f/1nllnJTsR+fDrRN4TMhjpPlwTKPObHyBdrl/wEoxJi+XKfmPjz23Axxky64cgHomMRoOIkfqbP+TDeiPrDGnbnul6Y6xWEGtIU+kTuF2bvL1Elc0wCPsQKbRE9s0mgRZSvqYNs7VU7KbYNewppp8nkeLWwv53ataLII99XvZwg9trMwir9cMSVbqW+i15xA6KYQTtdix88ytSuzSAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5130944d-3e1a-4a4b-d648-08dc1142add5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5841.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 18:42:06.3018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AI2HHxU1tNbXLxgSVc/z6CygMLzDsUuMPwaXDTtaL8lU+Lsu5GtKk2NFqjrUrP9ECXkgVWAOgyDNOLV6hOqnyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_09,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090150
X-Proofpoint-GUID: z0duQ38yQgRQMt0qUBEmuzzsUr1MOtX-
X-Proofpoint-ORIG-GUID: z0duQ38yQgRQMt0qUBEmuzzsUr1MOtX-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 1/9/24 8:25 AM, David Hildenbrand wrote:
> On 09.01.24 15:15, Daniel P. Berrangé wrote:
>> On Tue, Jan 09, 2024 at 03:02:00PM +0100, David Hildenbrand wrote:
>>> On 08.01.24 19:40, Mark Kanda wrote:
>>>> On 1/8/24 9:40 AM, David Hildenbrand wrote:
>>>>> On 08.01.24 16:10, Mark Kanda wrote:
>>>>>> Refactor the memory prealloc threads support:
>>>>>> - Make memset context a global qlist
>>>>>> - Move the memset thread join/cleanup code to a separate routine
>>>>>>
>>>>>> This is functionally equivalent and facilitates multiple memset 
>>>>>> contexts
>>>>>> (used in a subsequent patch).
>>>>>>
>>>>>> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
>>>>>> ---
>>>>>>     util/oslib-posix.c | 104 
>>>>>> +++++++++++++++++++++++++++++----------------
>>>>>>     1 file changed, 68 insertions(+), 36 deletions(-)
>>>>>>
>>>>>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>>>>>> index e86fd64e09..293297ac6c 100644
>>>>>> --- a/util/oslib-posix.c
>>>>>> +++ b/util/oslib-posix.c
>>>>>> @@ -63,11 +63,15 @@
>>>>>>       struct MemsetThread;
>>>>>>     +static QLIST_HEAD(, MemsetContext) memset_contexts =
>>>>>> +    QLIST_HEAD_INITIALIZER(memset_contexts);
>>>>>> +
>>>>>>     typedef struct MemsetContext {
>>>>>>         bool all_threads_created;
>>>>>>         bool any_thread_failed;
>>>>>>         struct MemsetThread *threads;
>>>>>>         int num_threads;
>>>>>> +    QLIST_ENTRY(MemsetContext) next;
>>>>>>     } MemsetContext;
>>>>>>       struct MemsetThread {
>>>>>> @@ -81,7 +85,7 @@ struct MemsetThread {
>>>>>>     typedef struct MemsetThread MemsetThread;
>>>>>>       /* used by sigbus_handler() */
>>>>>> -static MemsetContext *sigbus_memset_context;
>>>>>> +static bool sigbus_memset_context;
>>>>>>     struct sigaction sigbus_oldact;
>>>>>>     static QemuMutex sigbus_mutex;
>>>>>>     @@ -295,13 +299,16 @@ static void sigbus_handler(int signal)
>>>>>>     #endif /* CONFIG_LINUX */
>>>>>>     {
>>>>>>         int i;
>>>>>> +    MemsetContext *context;
>>>>>>           if (sigbus_memset_context) {
>>>>>> -        for (i = 0; i < sigbus_memset_context->num_threads; i++) {
>>>>>> -            MemsetThread *thread = 
>>>>>> &sigbus_memset_context->threads[i];
>>>>>> +        QLIST_FOREACH(context, &memset_contexts, next) {
>>>>>> +            for (i = 0; i < context->num_threads; i++) {
>>>>>> +                MemsetThread *thread = &context->threads[i];
>>>>>>     -            if (qemu_thread_is_self(&thread->pgthread)) {
>>>>>> -                siglongjmp(thread->env, 1);
>>>>>> +                if (qemu_thread_is_self(&thread->pgthread)) {
>>>>>> +                    siglongjmp(thread->env, 1);
>>>>>> +                }
>>>>>>                 }
>>>>>>             }
>>>>>>         }
>>>>>> @@ -417,14 +424,15 @@ static int touch_all_pages(char *area, size_t
>>>>>> hpagesize, size_t numpages,
>>>>>>                                bool use_madv_populate_write)
>>>>>>     {
>>>>>>         static gsize initialized = 0;
>>>>>> -    MemsetContext context = {
>>>>>> -        .num_threads = get_memset_num_threads(hpagesize, numpages,
>>>>>> max_threads),
>>>>>> -    };
>>>>>> +    MemsetContext *context = g_malloc0(sizeof(MemsetContext));
>>>>>>         size_t numpages_per_thread, leftover;
>>>>>>         void *(*touch_fn)(void *);
>>>>>> -    int ret = 0, i = 0;
>>>>>> +    int i = 0;
>>>>>>         char *addr = area;
>>>>>>     +    context->num_threads =
>>>>>> +        get_memset_num_threads(hpagesize, numpages, max_threads);
>>>>>> +
>>>>>>         if (g_once_init_enter(&initialized)) {
>>>>>>             qemu_mutex_init(&page_mutex);
>>>>>>             qemu_cond_init(&page_cond);
>>>>>> @@ -433,7 +441,7 @@ static int touch_all_pages(char *area, size_t
>>>>>> hpagesize, size_t numpages,
>>>>>>           if (use_madv_populate_write) {
>>>>>>             /* Avoid creating a single thread for 
>>>>>> MADV_POPULATE_WRITE */
>>>>>> -        if (context.num_threads == 1) {
>>>>>> +        if (context->num_threads == 1) {
>>>>>>                 if (qemu_madvise(area, hpagesize * numpages,
>>>>>> QEMU_MADV_POPULATE_WRITE)) {
>>>>>>                     return -errno;
>>>>>> @@ -445,49 +453,74 @@ static int touch_all_pages(char *area, size_t
>>>>>> hpagesize, size_t numpages,
>>>>>>             touch_fn = do_touch_pages;
>>>>>>         }
>>>>>>     -    context.threads = g_new0(MemsetThread, 
>>>>>> context.num_threads);
>>>>>> -    numpages_per_thread = numpages / context.num_threads;
>>>>>> -    leftover = numpages % context.num_threads;
>>>>>> -    for (i = 0; i < context.num_threads; i++) {
>>>>>> -        context.threads[i].addr = addr;
>>>>>> -        context.threads[i].numpages = numpages_per_thread + (i <
>>>>>> leftover);
>>>>>> -        context.threads[i].hpagesize = hpagesize;
>>>>>> -        context.threads[i].context = &context;
>>>>>> +    context->threads = g_new0(MemsetThread, context->num_threads);
>>>>>> +    numpages_per_thread = numpages / context->num_threads;
>>>>>> +    leftover = numpages % context->num_threads;
>>>>>> +    for (i = 0; i < context->num_threads; i++) {
>>>>>> +        context->threads[i].addr = addr;
>>>>>> +        context->threads[i].numpages = numpages_per_thread + (i <
>>>>>> leftover);
>>>>>> +        context->threads[i].hpagesize = hpagesize;
>>>>>> +        context->threads[i].context = context;
>>>>>>             if (tc) {
>>>>>> -            thread_context_create_thread(tc,
>>>>>> &context.threads[i].pgthread,
>>>>>> +            thread_context_create_thread(tc,
>>>>>> &context->threads[i].pgthread,
>>>>>> "touch_pages",
>>>>>> -                                         touch_fn, 
>>>>>> &context.threads[i],
>>>>>> +                                         touch_fn,
>>>>>> &context->threads[i],
>>>>>> QEMU_THREAD_JOINABLE);
>>>>>>             } else {
>>>>>> - qemu_thread_create(&context.threads[i].pgthread, "touch_pages",
>>>>>> -                               touch_fn, &context.threads[i],
>>>>>> + qemu_thread_create(&context->threads[i].pgthread, "touch_pages",
>>>>>> +                               touch_fn, &context->threads[i],
>>>>>> QEMU_THREAD_JOINABLE);
>>>>>>             }
>>>>>> -        addr += context.threads[i].numpages * hpagesize;
>>>>>> +        addr += context->threads[i].numpages * hpagesize;
>>>>>>         }
>>>>>>     +    QLIST_INSERT_HEAD(&memset_contexts, context, next);
>>>>>> +
>>>>>>         if (!use_madv_populate_write) {
>>>>>> -        sigbus_memset_context = &context;
>>>>>> +        sigbus_memset_context = true;
>>>>>
>>>> Thanks David,
>>>>
>>>>> Could we just use the sigbus handling alone and support parallel init
>>>>> only when using MADV_POPULATE_WRITE where we don't have to mess with
>>>>> signal handlers?
>>>>>
>>>>
>>>> Ideally, we're hoping to support this with earlier kernels which don't
>>>> support MADV_POPULATE _WRITE. But, I will check to see if we really 
>>>> need it.
>>>
>>> That's around since Linux 5.14, so please try simplifying.
>>>
>>>>
>>>>> Further, how do you changes interact with other callers of
>>>>> qemu_prealloc_mem(), like virtio-mem?
>>>>>
>>>>
>>>> I'm not familiar with the intricacies of virtio-mem, but the basic 
>>>> idea
>>>> of this series is to *only* allow parallel init during the start up
>>>> phase (while prealloc_init == false). Once we have parsed all the
>>>> command line args, we set prealloc_init = true
>>>> (wait_mem_prealloc_init()) which causes all subsequent calls to
>>>> qemu_prealloc_mem() to perform initialization synchronously. So, I
>>>> *think* this covers the virtio-mem use case. Am I missing something?
>>>
>>> Good, so this should likely not affect virtio-mem (which also ends up
>>> preallocating memory when loading from a vmstate).
>>>
>>> To make this all a bit clearer, what about the following to make this:
>>>
>>> * Optimize for MADV_POPULATE_WRITE. If we really need support for
>>>    !MADV_POPULATE_WRITE, this is better added on top later.
>>> * Pass in via a parameter that the caller requests async handling. 
>>> "bool
>>>    async" should be good enough. Then, pass that only from the memory
>>>    backend call, while QEMU is still initializing (we can find a way to
>>>    make that work).
>>> * Provide a function that waits for any remaining async os-mem-prealloc
>>>    activity. That is essentially "wait_mem_prealloc_init", but without
>>>    the special internal flag handling.
>>>
>>> Further, I do wonder if we want to make that behavior configurable. For
>>> example, one might want to initialize backends sequentially using 16 
>>> threads
>>> max, instead of consuming multiple times 16 threads concurrently.
>>
>> Seems to me that no matter what parallelisation we use (within
>> mem regions, or across mem regions, or a mix of both), we should
>> never use more threads than there are host CPUs.
>
> Yes. It gets tricky with multipe NUMA nodes, though. And that's what's 
> being requested here.
>
>>
>> Can we have a pool of threads sized per available host CPUs that
>> QEMU can access. Then for each memory backend fire off a set of
>> init jobs that get distributed to "appropriate" threads in the
>> pool. By appropriate I mean threads with the same NUMA affinity
>> as the memory backend. This would give parallelisation both
>> within a single large memory region, as well as across memory
>> regions.
>>
>>
>> eg 4 host CPUs, 3 memory regions (1GB for 1st numa node, 1GB
>> for 2nd numa node, and 1 GB with no numa affinity). If we
>> spread the init work then we end up with
>
> I'll note that having a mixture of numa + no numa is not a common 
> config we should try to optimize.
>
>>
>>   1st thread gets 500MB to init from 1st memory region, and
>>       250MB to init from 3rd memory region
>>
>>   2st thread gets 500MB to init from 1st memory region, and
>>       250MB to init from 3rd memory region
>>
>>   3st thread gets 500MB to init from 2nd memory region, and
>>       250MB to init from 3rd memory region
>>
>>   4th thread gets 500MB to init from 2nd memory region, and
>>       250MB to init from 3rd memory region
>
> We do have prealloc contexts that are used to craft new CPUs with the 
> right NUMA affinity. Prealloc contexts are set for memory backends. So 
> extending prealloc context to limit/reuse threads and do the pooling 
> might be possible.
>
>>
>>> Could
>>> either be a machine option or a memory backend option 
>>> (async-prealloc=on).
>>> Once hotplugging such backends, we would disable it for now, but 
>>> could allow
>>> it in the future.
>>
>> IMHO "do the right thing" without user config is preferrable to adding
>> yet more cli options here.
>
> Sure, if there is an easy way.
>

Thank you David and Daniel for your feedback. I plan to address your 
suggestions in v2 (including optimizing for MADV_POPULATE_WRITE).

Best regards,
-Mark

