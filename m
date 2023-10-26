Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E6F7D8A43
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 23:27:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw7s2-0001o3-OR; Thu, 26 Oct 2023 17:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1qw7s1-0001ns-Ah
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 17:26:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1qw7rx-0001U6-Kl
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 17:26:24 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QJsWcY025754; Thu, 26 Oct 2023 21:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=RuHKKTxh9Z0t/v9LczXpjIqEUW//sXRu9QpdKwmvqKs=;
 b=17Zhxu0gMi3m0qGTVmvgXxOWxkSkDL5cPR5T4WGtzYkNYvzFhmhhLLnxN7Fx67UFT2lL
 swfuS07WFcqQj6z7/y9REmn83Cg8D0FWTg8OCWXFLY4HAtPnQZb0DWlhUw72Lgde1Z6d
 eIOnpWiCm+gUxDwu2kAG3Cz6cW7NUU8EI580nk5DWwLYa6KgsX865qI4dDEGHegdJ0db
 bcAV6aqF4hk5af3yJkSXtOlxqHOVtZddYwFU6FYCl+p60ROR28qM1EMYYFcH0fwqRr5X
 Nnh2ORRlXIC4AE5LFScrtHUFsX9jJYcTSCz3JI3gZ3P9LVxOI4ANRTy96sPJNgNSJJ/N lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx3ng7aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 21:26:17 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39QKhtYb038828; Thu, 26 Oct 2023 21:26:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tywqs56wr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 21:26:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3hhvV9XLFYr2eyx/fw872UB1zpIHEJM6uS3KOtFD3zpHA5waeHXoJSni+oY0cLO2hQFZ3VmHiFN4TqWH8LI2kTnPjF3GvaWiJq8oy+UXMkIlHVQ1ePXYJxMLpMhOwCSE5mFmvlkT9mvvSuzUD1TpX23+WEa2pzskO/lPNGc4TiV1C5CsM0iN4XnyoCSwVveEMYwHaWlNbC1vSFMi7kYGns9tIT1yNMNtISbk6RWEqtH+Wi+2t9s8LovKjpGY1u5pfO6FDSdLmaPyYugI1lc6kTZCxt3LIhrtdwf7ENmpaP8jZX2FxmevPCct8ojbs3NNELIZ9RP//GNUxPAXxnMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuHKKTxh9Z0t/v9LczXpjIqEUW//sXRu9QpdKwmvqKs=;
 b=Ys5UDVWAbQj4kBC4lHZvorG1glma19SlKQ1dFp+VEN24qR0rQOn8BNTzdp2eon77+RkKQ/3hOHNbqRo1h4j58E5uJlC24goS7oiLhYY3vT25aua0avqed+lLqUXN9moHZNC+JfWmSr76DRk38Uk+DKvCw9pmlgpTXJ+/3dkvkUtKESlgNjPcy7knk12ftL4g+4ZaVaBebyhZQIJRk+c19WJcvzCDLdYs+btuaBKmgCS07Kw7YpgBNNh3WwGFTuDVdaCt1O9I5/7hivvWHPesSu8QgNgj74eVXRnDWjNxdquTaPel+SYLk1DklNyyrv3sYWoiTjI6UNzp3YXxxe3T1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuHKKTxh9Z0t/v9LczXpjIqEUW//sXRu9QpdKwmvqKs=;
 b=VseW9+BDn8aPG8MiR857RKOxXrjuvGKtnDqXGZ2TseXR+kiirguA+1bvwMoM7vda5+N+SVkIv5XiU/vKmPAWj+bgkbHBJMC4XCDni70tGEb4/UCNQcg2U/yqjeKVD1fIbB+wcKDF5bdjaJq/qphd/U899fLEakx6Ii5Euc5CA7E=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by SN4PR10MB5542.namprd10.prod.outlook.com (2603:10b6:806:1e9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 21:26:14 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::afac:25ec:c0ba:643]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::afac:25ec:c0ba:643%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 21:26:14 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, armbru@redhat.com, thuth@redhat.com,
 quintela@redhat.com, kkostiuk@redhat.com, berrange@redhat.com,
 dwmw@amazon.co.uk, pbonzini@redhat.com, joe.jin@oracle.com
Subject: [PATCH v3 1/1] hmp: synchronize cpu state for lapic info
Date: Thu, 26 Oct 2023 14:19:38 -0700
Message-Id: <20231026211938.162815-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|SN4PR10MB5542:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d3e5e1-839a-4460-70b8-08dbd66a2e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85vQHxXAYeW3jD1/GugmG/MLVrGSi6UT1WO5z3eKuG2CnRaN7uc611k4sBFN0VpYgFRscTTrsJ4e095Ko5dwbkdSj0OEBFCWrLN55hpZ37B/aP08I9Os5WUQJLSmfiYSu9CKjFLabpfcrKyGM0VHtKeNy33r1s7dDONdKcrG360ozN0L2jXmR9dsu2ETohJ2t2PvXRmRgbcXDQ9+Na2JSE3+mHwtsOuPYAta+oLj1JlqK5plkBwONmACXKvtB9eBv1b9m77dkLkvZ3lrQlbwWyefXstXkCXXSQePkrhCVSqi72vORVsuEiMTcST+pDOvxzgKexqV5Y3VnBvFQYkPgW+KGoxeaRoR5eUgIVoeq2FhT9C9fLVhMNO+Xd6I25XI+KWXOW3qqLoQ+K0ijMgQpU21tsCTz3E7lj8USI4OHVvcqVvhFeG2OLVi6JSDLI+NoflcLo09vXncNUtAo9GWYhvcoqj79oisDORmWc7COQUJRSfHB62gq49stGtLcn9EnZlFU+DNu0iC1yjQEvX5uUCf3/M205XONWsfGzp4G+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(2616005)(36756003)(1076003)(38100700002)(6506007)(6512007)(6666004)(316002)(66946007)(6916009)(86362001)(66476007)(6486002)(478600001)(966005)(66556008)(107886003)(4326008)(41300700001)(8676002)(44832011)(8936002)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bENEUW9jdWZ0MFFaN0drOVlnd3lpcnhBVm9odjlIQlNsbk5VY3h0bFVjM1dN?=
 =?utf-8?B?ZzM3emt0TUVLbUwxS0pGT3hlRmhoMkplVStOQisvaUxrTk53YVhUbldHb3h0?=
 =?utf-8?B?NWswMWJGc3RlYkFOMEJHSVpZa2llUGlqMVlCd285Y2RIVVE2T3l0UDFEenBS?=
 =?utf-8?B?RWtEbnpTK29WN1d5NUUwQThBd2U5R0gxVGs1ZDVxZm9pcm12ZkpaOHoxS3R3?=
 =?utf-8?B?NTM4eEJJUXJMOVI4NXRLSDFlcmZ4bkpUREZORHBNZ3Nnd0hrakxRZ1dYRjZm?=
 =?utf-8?B?NDI3U1o4Z1hLMnA2QUVMbWlCWmxsVzdGNjl0Zmx3ZjZHQzJWclJmWDQ2blBy?=
 =?utf-8?B?MTVKWjRpQXBraVRadHFaalFieEQ4dm5YL3FHOWpNc2VRekk0SkFlWHpwSjdQ?=
 =?utf-8?B?LzVvdEF3TmNwUVFaRUhjNzNhZ25VdzkrRElKODBNaG1zRWZmcUMwaVMybjZv?=
 =?utf-8?B?R2RVY0dTWUcrY2RzOUQ5c2VGRmMvNWZIbXhob2hVcVVJTUIzNUN0YlFKaEVs?=
 =?utf-8?B?TFVMRzVPczRSWXIyYlo5anVMWEo5ZG5IUmdIamRDbXliRUtrb1lxaEJSN25N?=
 =?utf-8?B?MU5LNGJLK3pWT1NlRGhQYlUxZVZYamQwdVc3dnNITnJMaDU5TjAvWnU2aXoz?=
 =?utf-8?B?ZjFtRThVandNYTdGM29rWGpPbmoyaHdTYlQySE9SajdQS3huUkhvejRtV2VS?=
 =?utf-8?B?WGpwb1dPMUt2VlFVRHltZlZzTlk0VzhrSXQwYk44eWUzVVFVOVRkbERydkpw?=
 =?utf-8?B?RHZYYUIwTmcrNHFNVmlXU2M4cVB0VG5kTHM1RkNRTlBjMDhuN3BQVTE5K3pk?=
 =?utf-8?B?cFRSRVJ2b3FPS3FzdXdUYURkLzhoV3VjdkJiOThRRUVtczA5SURCRTlBc0NM?=
 =?utf-8?B?dHRPYzIzeStoWUZ1VUxjLzRwdUo2eFVlM2JrVmdFMlZGb0dxSFZYY3FsMHRP?=
 =?utf-8?B?bElyUFFCeGFSMDJmc0hlSWFvZVY2aXdGN1FFYmo2dm5aWmgyZ1RVVkx6VFJV?=
 =?utf-8?B?WDY5WDNpRXpIcXlIdWV6Mjc1NjQzSGFiSmcxNDUyaUc5dHJTS1N0ZGxLeTRq?=
 =?utf-8?B?eXlCQWNYdk9uelpHdmFRSTlaajhJREpvbEEwRmhEY2w3TVFGR0dTQWVQWnFw?=
 =?utf-8?B?ZXUrZHVURFoxdEd4MXcxOXoxWUtaTXNTcFpKRFoxcFdZSGswYXBrSzR2UG05?=
 =?utf-8?B?ZFNtVFBRZkxidm8wZXdSK2x6dE5LbjNvTkFaZlVKaCsxM1hjMmhqYWVZRytv?=
 =?utf-8?B?d2ZBV2xYMVRvQjkvQ29rN3BTWTNYSy8vSU1tUVVGZ093ak5vTE1MVFd3blYy?=
 =?utf-8?B?Y3pNWVZsaGR5aWJNa3VPL3MzYmpxeFcrM1FmNVRpbEZwb1hXVEtxeTVCdVdQ?=
 =?utf-8?B?d3R5NUpVaXZJbUNzRHhoQWF0ZlY1Y1J1azg0VGswZmJRUEFCcjFHamdNMThP?=
 =?utf-8?B?Z2o4dU1tZVN1aDk1Z0ZrL1BLODVaS2ZqcURGTno5L2R1RnE5RjZobUcxRWRQ?=
 =?utf-8?B?MHJKc2JyWTRZc051QlpnV082SU5Wa1VjREc0K2Z3dHZnSEgxY3FhdzhRYVRz?=
 =?utf-8?B?MGJvZzVLUW9oYWllTWZJbTg0MXFDcW0rZWN4RWllSU1OOEEzOU1NRlBOL2pI?=
 =?utf-8?B?QkZCRDRMUHJZcGUrSmdzNEFSOUlqbGhISWNxbktrMG9ES0FxZFpsWHJNME92?=
 =?utf-8?B?bDZsWHV3N1c1Y2RLN2hQN2dzcnRCeCs2RU1PUzBycjh3UnhvV1I4bC9BRWlP?=
 =?utf-8?B?Q2g2YUh3K2hLcnJ3OUwxRHYwV3dPeWNLRzEwbEx3TVpOUzNKV0ttbDN3Umhm?=
 =?utf-8?B?QXFoUXlmK0lVanJCVVZjM0c4SnRvTE1GK1BPYlpzT3FZQkFpNGVSSHE2RnU2?=
 =?utf-8?B?ZDNuY3ZUYnRFdE5GcU5Vc3R5QktaTW0ySzhZL1pYMjVEa1I1azVCczB1cTll?=
 =?utf-8?B?VmRaMHJWS08vNzlnbkVyZjFDMkEyM3lTUXBFMjlCOUhybnMyOWhsdWhmSUht?=
 =?utf-8?B?TTBtRU80RWxmYlhtZ1RuaitqWlNJNWpFMWppczZYc0VqRDBvOE82WjIxamJu?=
 =?utf-8?B?YmhDaUN2WXk4MVBkUWlCaFRlYSs1ZEx5d1hvOHg3RVdkd0lhNFlRUWlLSEdm?=
 =?utf-8?Q?16P6eBeGjixNfkggiaS5huy0c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c7lbZs9Kkwc5U9naDv96BoOz4CtW8E5QGVuBminRiVefIzk0gAiBit7RFSIeXU1Z1cdXPmVwS7PrE1jGMv+XzwAxZifgW16zSSr+ZEuhjcwoYVhylM7jn7fOqvKDbUz4D+yMO23orAg64NDcy5yjsw4YJE/LYQLDQFQXlBd99rP39AGVhWbTbEvCOjqkbvvayrWpNJwbW4MUbUbxAOSg63GTAF4PTUiBtCAa2Mai+I7yVclWaGnxETfH+EeO3tg2MGWmrrvbByeaGnIGVfWDZ8Qr8hj+UVFbgeHWwyv6LR3fIy94QJfxOFqShruPYERw/s8Ml2q8PKhueZ05052HQl94NFSZoNC14vFFEcQRXTDQ0IDq8AWwKTw2abxyorj12nYk4VfzXVXH5BLNXPc4kplRVXOvAByzLhiE/v4dsWsvP5B4DysEAHhc5ue+Jid9rjoT5aMJxYhfNwgp9+TtRCDoLiH/JPETz5zJqdAwqu1I2d00UVx9Ohi2PdnXEIk0xwDJbK57DcCT0eZZebafqD+1AP75cSSJj6UzccFfJRMDcmD7JQ1qxHxgVrBKCEyNvzTBkTFao/VyvtgMvxql2xFT6rmRkpBLE8EER0562189x2/1rxXd0xivtmx+IO7GDTNdpStTqNXWNWNDTIXwJWpqq7rZzJSmLesbvWv9jwOb1qLeKW4rUXs0PtZvxy2lkBiJR3bDDG2kh1Op/0yG7q5V5e3xg331qJf946aY0qBV9lpMdrx2UQtSHkKkbyfx6iSr749mH8rTiefzYOTxugxk0rHBIhA3O9jubQxHO9JS0ucXQ+dA/zrCRx7jQ7iw1moplFen3f3Vjca8j4gv1w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d3e5e1-839a-4460-70b8-08dbd66a2e8b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 21:26:14.0328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6qtdEuR8IpSTvKjvbZHetCl4D2Q520Va+aephHbi+kEo6M1j0nX6dru3or3UVmnkflXTOQsqQfYcghN5F7QPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_20,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310260186
X-Proofpoint-ORIG-GUID: QZvw6op_NhaDi_Sj7S2EirIkTD8NOZWV
X-Proofpoint-GUID: QZvw6op_NhaDi_Sj7S2EirIkTD8NOZWV
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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

While the default "info lapic" always synchronizes cpu state ...

mon_get_cpu()
-> mon_get_cpu_sync(mon, true)
   -> cpu_synchronize_state(cpu)
      -> ioctl KVM_GET_LAPIC (taking KVM as example)

... the cpu state is not synchronized when the apic-id is available as
argument.

The cpu state should be synchronized when apic-id is available. Otherwise
the "info lapic <apic-id>" always returns stale data.

Reference:
https://lore.kernel.org/all/20211028155457.967291-19-berrange@redhat.com/

Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Changed since v1:
  - I sent out wrong patch version in v1
Changed since v2:
  - Add the Reviewed-by from Daniel and David

 target/i386/monitor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 6512846327..d727270fd0 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -28,6 +28,7 @@
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "qapi/qmp/qdict.h"
+#include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
@@ -654,7 +655,11 @@ void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
 
     if (qdict_haskey(qdict, "apic-id")) {
         int id = qdict_get_try_int(qdict, "apic-id", 0);
+
         cs = cpu_by_arch_id(id);
+        if (cs) {
+            cpu_synchronize_state(cs);
+        }
     } else {
         cs = mon_get_cpu(mon);
     }
-- 
2.34.1


