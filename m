Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A627EA2E5
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:33:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bkL-0001wc-QC; Mon, 13 Nov 2023 13:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2bkC-0001tn-PF
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:33:11 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2bk7-000344-HQ
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:33:07 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHi6Nk017359; Mon, 13 Nov 2023 18:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JRa5T8bmotRTAZNhbIUaiD29sa5b32ZgpUeGF1b9jHc=;
 b=iUhSDequAIQsZyzNOGKNHkIqMg923D2MFUIyf9JRrdHA86IVXY6u5KmvoG6CxpyIKw11
 IeWUghZvJTQNjiX2cN2gwMawAT8YzsQ/lfLH1y6ASwERxTW9pQp7jbKpTc6DbN6Xnatp
 jfQE3otRQEnJfUzv5lGW+Rf9x6oJcrZU3L9fm/iHaPHlaKPaH8oFILF8sRn+Y2R7QMOA
 jZ7BwoAz2QbhE8qpd6QXfDYv2h1+jErMHOZ9DHHe26Tlq2f8bsCulT3/TT+sXNQDld89
 fp8T9SIQOsNYQYzO2jW2uEY+7dUXgDIQrJXLjP332ODx8jnvjBYwuYkVmuGTi2Of7FXf HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mdkj6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:33:02 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADHgrVQ029926; Mon, 13 Nov 2023 18:33:01 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxqqaq5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:33:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQtQC8S0iNpTJieByh68jH1m6vsjG+QdcSMDXTuci4D91jlwZvIkwV+bEH9aqaKcngoj8/YLtoegqOaLuwGSKOSG1KW1TCb1p9HS1ihMj741gnKHn12grQ98/hWdBsFa9LnKI4SjlHZshntKSIsqTEOJG50hM3g5em3mA9n3SB3a4G2DnmboWE+oNJu3D16bRm0QpWrdTw+qxSIuBtkFVdAiFWKaJf5OMBJ3/WwfdGV3Vckhq/8Dgw1Vxd5A0qmxfs5lwwPMowG4qpeFW55SeGntCAQW1HXDv4G9XsSOCHQdr7YmWUcufJNH17wCqdDdEK+lRrBQQBsfMF3FHPQN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRa5T8bmotRTAZNhbIUaiD29sa5b32ZgpUeGF1b9jHc=;
 b=LuZL9SIXbX/HRKk55pGo4dmxzeE6ivA9ozK4MU7EzH8RvoyahluLKBoX4+YEC+CiIq83/IrQc8mScjSGqRMhXwThGxaBSbSxwhP0tU5rwufPd0Tlut9YVHjdtGGXqyka5sLdKcY2iRj5PewtIgeqd1k8S9MPAU2rlDZCvEpCdhu2O4TMlICk+1zYVoSgVYXpHrh1buQygqaTnH7NZjct213YUizakZhE5hiUPOsI7iDwOYBTdalhGxFj4Ig7ViucMgk6Zd0QsnsS2Q0M5qSQYfvTJOVN/1+2Qbumfz4mSQAEXrQ9eDD7L31GQlAwnGtXpAPKFkNggsoap1CVNz8LZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRa5T8bmotRTAZNhbIUaiD29sa5b32ZgpUeGF1b9jHc=;
 b=V7N4OP1TRMenhWhArwvJGAg3WhbMO1lkOGADC8VinFpMEK7oEvYcAuTKGZcD4JnU3O3fe+7PJ4zIz/C9E9MvSFtuTy8wsRWtu0DCEMT7TlvMvBaexaVdW3LVmIKvy1iTyBX65y6qLHQHrQUzKTzTGrh9j/8lP8m0AK1d2LCxBGY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS7PR10MB5359.namprd10.prod.outlook.com (2603:10b6:5:3a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 18:32:59 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 18:32:59 +0000
Message-ID: <18678958-498b-471a-916f-9fb4bc815ae1@oracle.com>
Date: Mon, 13 Nov 2023 13:32:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 06/11] migration: preserve cpu ticks if suspended
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-7-git-send-email-steven.sistare@oracle.com>
 <ZO9yumiyrNdAkHjG@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZO9yumiyrNdAkHjG@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:510:23c::9) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS7PR10MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: f6726ccd-44bc-4d8c-3c8a-08dbe476f613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjHAPeFxD1BYlpucbxdzEY9ZEmIZPmR9Arb6AwGw2NiWiAuRTjyA9T22dcj+DjLk/WiliUC1G9u4gcFS3FyPYHO00pctmsgySo64OzmSLzJ8rOXNhbR65wZpHnwImR7+E7RKH2oexOYyVMVzN6GqPWfMVQGrCCtutt6cJ80ODjuhAUKccDziHsINtxpgdzhq0OHynvBDc4pFjjpRSA7yCLM1p6SldOfwtY2aYt6QAkw2Qk4zKeS89yQKn91QUng1JV9NJtszKROl9klisY0PgCvqpkTfnaUjlj1w1Su2rXobA/NqBmqpdytecPiautsBmAlotg4sT0W8lJtN5DeRagSiVuAoVfoHMhyCu1CNo5KNbSM2Se8bNdvzGqzwInxn6RJu0CrJCoZhxBnxHrcZcbMkVoF1Eg3ZA+k4iuksjPXEE06coVSWo6G3Hl0J3IEoqPSIPh0wJCLkUw9Egs+7Jq2XMl0+07trK8dNKhaxuy526tFZsLN/5mqFnHA/83QlaplzwXSGHtnJDWI/Oe2HUOEkmHcjTH1Kqz5AocjwbaA9LQHBTEwy4rEm9fV7WgDhp1we/D36xWbwWTGilQkrma9tuYrDaVU1upsImWmiSHEO/l+96cQCGL3coM53Z0isLGtb3w2qUZ8ZISvgW3YjQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(15650500001)(83380400001)(36756003)(31696002)(86362001)(38100700002)(8676002)(8936002)(4326008)(6486002)(478600001)(44832011)(36916002)(53546011)(6506007)(316002)(66946007)(66476007)(66556008)(6916009)(54906003)(31686004)(2616005)(5660300002)(41300700001)(26005)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3hDTTZwS0NZaXhEdmJOT05VSm5VQklleWFZTEtvVzQzdWUzOVhJRkNMV0ZG?=
 =?utf-8?B?UW1NUktra2Y5WCs4enhuNEZUOE5kdkROdFFiSjFxUXJzdU9kKzVMR0UyNjhk?=
 =?utf-8?B?QzBVbloyWmdwSGpCWmo0dFQ0MXFWOFFtdGtjNkRNV3l5Qzk4Qm5UbHh2T3NS?=
 =?utf-8?B?NVBRbXlTRHRUY0g5dTZKZ2pXNUpZeHQzQzVxZ1hhUXVEVmFnd2Y5NTNJdDJO?=
 =?utf-8?B?MzE5Y1l4bmF4S2cxdUZWYVZ3UENIZDgwZTRYaklGcmVJbmprUS9pcW1BcXE2?=
 =?utf-8?B?M1ZKQkZld3J2Q0g0MGNUdng5Vmo2UkxWNXNMZTU1Q2pUUi9iY2FQeGJMaVBD?=
 =?utf-8?B?Ynp0L1VjOTBEQzMzS0xGRzFqandxcEp3TS95bnJISWFvOU1pUFE0Y2EySUpl?=
 =?utf-8?B?R2JSTi9zMkZMN2lzZ2JjdHAxSTZML0VJWE9ySWoxS0hOTklFb0J0SEtEaHh1?=
 =?utf-8?B?Y3VhcVNkbVZHTUI0OER3UW1MNXNzbDkvdzVIc2ROamttc05SWDFCUldremV5?=
 =?utf-8?B?bEJ1K2Y1TTZLNG15OHoxZ0pHT2N6WVVxMTNTYW9penVOcHk4NlNmMUs1T2Vl?=
 =?utf-8?B?TzdWVXlqQStZSTl2ZlEvQ0dnZi9ZdTRxa0V2QmlnZ0FaZFQ3VVluUDNLeTZH?=
 =?utf-8?B?WTJyRmhmRmhSdm9iQ3paSFZhSzl3WHJnb3BQN0RQNWxiMlV3SmdXVTRIWlBp?=
 =?utf-8?B?U1VZYVpFWXg2clErTzZTVkt3a0d1cUtHRlgvMVEzNmdpU1VOVm1QSmJlaHlq?=
 =?utf-8?B?d041cjE2K0podnN5bjVJcWp6SjRhYU5uU3R4ZCtvaExRd0w1bTNqaEhOQXFi?=
 =?utf-8?B?WUIyNkVCK2t2bUFrMzBBRXpFbXNES0hKTnErcmE2NGpqOTVsc2I1TWd0SDNS?=
 =?utf-8?B?Q2E2SG5TUzQ2Z21jbUhsWUVXMEpPTG04ZmJTNlgvWnVqbkdHeFMvRDM0SWMv?=
 =?utf-8?B?Zzl3L3FnVkk0R1AxOWVUL1pPUWVLK3JhSGoyZXZjeGRXMk0zaWNVL3RNV3hS?=
 =?utf-8?B?ZUE1aytTSzVCd2dpcTQrOXJJbkxOc3pHMUUzNGh2cmpYZGxpb0FBMVdzYmdX?=
 =?utf-8?B?RDJYZFhVWjFybFNiM2I4eE1EVDdkcGhuczhuTEZobU1XM1ZEOUxIQjRsMjc1?=
 =?utf-8?B?THdwbHBFZTU0eHkvb3lNeTRSVkZ1Smx3T3Q4eHdTN0tUazVSSkdNVHpVTElD?=
 =?utf-8?B?OFFFckZlREhac1lmRWs4MkxsaDN6Ly9NcHVMWGZPcW96b2F1VVRDaE9nbUto?=
 =?utf-8?B?dHVZZVExTlVKazZBQXE4S2JLU0Z4WjYzSHNxUVNadjVrZlBRd05zWXlGbWFV?=
 =?utf-8?B?YUE4NHVNNk55RS9TRkhzZ003OE1mWEZSbkt6cEVDang5QzBQaXowRk82Vkht?=
 =?utf-8?B?ZWdNRmNMSG9kZy8zaUZkUm9iYUFDUGRIb05QQUE0djFZN0JSZGNpdktlR1Ir?=
 =?utf-8?B?VitiV1AyQmE0VGU3b1E5dEJaRUFiSnFlUm1nTEdpUFFxUiswR1RmK2xYOHBr?=
 =?utf-8?B?ekNYMmRtYndieGF6a0o4OXd6S3ZlZDdVSTN0dFQ4bkxCbHlDQXk4Rnhoemwv?=
 =?utf-8?B?dm4reWhYK3J1MnppSUN6ajBTS3UrMEpJcnQ0TEJpMzUxTUJ4V01QVXNkQ3RV?=
 =?utf-8?B?RXVTWUJtdHplb1hUSGFwUVc3Ry9wTzJNQ0tmenh4SWJlajRsTVhmZVB6TXh2?=
 =?utf-8?B?dlAxSXF4QVpsTzA2UllqNDR5VkJrejEyZUNCd0I0TVREZm9oc3pOc3dBZlla?=
 =?utf-8?B?KzRUSktrZVN3OHIzenNXM3dQeFo1UlB2ZGw4eFFqQUJpU21mbHRNS3NQaFIy?=
 =?utf-8?B?ZHNnbSsxS1dHc2Ewd1hMWWlqYWRjNHBERHFLakk5NTl2UExiT1d3N09QSGls?=
 =?utf-8?B?MGJTa29OT0FqVXkvVndEOGRaY3MySXpqbkQ1bGpETnN3UGgrL1N2emlabHpI?=
 =?utf-8?B?NjBDUVVRdThGaXgxcUxKRVp2MWtPanBUL2IzWHoxb3hxUkdRR3B3Y1l1a2Zl?=
 =?utf-8?B?Vm5iaGxZL2Y1R1V0WmlqQmhiYk5DV1lpRTgxVVVVM0s1YmJrUENXeHYvM01D?=
 =?utf-8?B?dUVyZWdDRXNDTkI2WG1sVy9ZRU5FMHFVZXNsbktIMUpxZHVLQ01jaytseG1V?=
 =?utf-8?B?T1I3QkxJZEJrOGJCODBwaCt4QkhtY0Nqb3ZuVWhvS2htQktKaHRQd2NidmNa?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 38YwWiNMaypHr6zai9c23nJA6PldVI+N/OsbeD2bMhOjJW1n29dSo0wvQEZxI/Ru+BEtRB8fn2jrs4G6BKdJVQN6j0o8K+YbPodmI+cxxpcAZ8fb6uZDZMRZrd8T2sdm1c+BAQvgtUa2WrY7zypCl8C4+wiTp0QV4MAx3dtthMdzlt955NwvEVY5vFfM+zSMZFdt86B18lcZgVIOuOg0WEXM0QBJr2krIwha2VQUJnMks6WvXpCYwS9VLBqu9V+53YC2NK+FfNVLVEd3gbl6xIyEFi3O5FSdCa9Z88kUJaRuH97S+CfBnGJ1nRMOhc3TZ9CR9lurqtsZvE0jpB6WYMQ1gZDCaRnxlZcBIM7AySsD3x1LtGZfyHkwxjs4OXV4F1Ez7bQQMpPgpZeyX8E83UA3F+IPQ/NbydTQ4xLS9kK8jDc5gLsUfgNRYvNcz6vtfAGxshEXLNJFuHTEkfUGhU7ovTECBMlSyG7Psl7K3Za9X2gvFZHDbOE+hkVGQNUPep+LYPPJrrqN6xRH2s7yxiGH11ibON8EFTZ2WzsymVdpnpSn5BFQP4vSnQhtrOtfOp9R1kSTVXoCOKC0Gb5SYVVgQqFH4qJte70jB/MwpVqhn2oIUBz8GIc9bipl43wIgpNzk+xdzWXuO9+OHPLYDo4DmA8MpvFp1F1duliMgwV3nVifwGsKMUEUNOulKcI8S/pEHVdlboPxgR/yOG9eXTvvNG7aqr/t7g8VoygWbYkxiqUGyjfgGniqQ6y7CJ6e1CRTf0EAfH7V8vGyhUthxg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6726ccd-44bc-4d8c-3c8a-08dbe476f613
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 18:32:58.9864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCC05imoNnVHThVakQqficcOX+VHaMsbea7b9m3fb6QvZeXtaCFFo0JW10/PoP4lEMtIoG5N1KdnzbB5zJjEhzm0Ha7Wrl3oHH5j/Un+CMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=807 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311130151
X-Proofpoint-GUID: -Un9rZ7szNI4OmJ-v_D0l0Xj3pb3FN0T
X-Proofpoint-ORIG-GUID: -Un9rZ7szNI4OmJ-v_D0l0Xj3pb3FN0T
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 8/30/2023 12:47 PM, Peter Xu wrote:
> On Tue, Aug 29, 2023 at 11:18:01AM -0700, Steve Sistare wrote:
>> During RUN_STATE_SUSPENDED, the cpu clock remains enabled, so the
>> timers_state saved to the migration stream is stale, causing time errors
>> in the guest when it wakes from suspend.
> 
> Instead of having this, I'm wondering whether we should just let:
> 
>         ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
> 
> stop the vm for suspended too - I think we reached a consensus that
> SUSPENDED should be treated the same as running here (except the vcpu
> beingg running or not).
> 
> So the more risky change is we should make runstate_is_running() cover
> SUSPENDED, but of course that again can affect many other call sites.. and
> I'm not sure whether it's 100% working everywhere.
> 
> I think I mentioned the other "easier" way, which is to modify
> vm_stop_force_state() to take suspended:
> 
> int vm_stop_force_state(RunState state)
>  {
> -    if (runstate_is_running()) {
> +    if (runstate_is_running() || runstate_is_suspended()) {
>          return vm_stop(state);
> 
> That resides in cpus.c but it really only affects migration, so much less
> risky.  Do you think this should be the better (and correct) way to go?

Agreed, good idea, done in V5 - steve

