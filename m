Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C47901B5
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 20:00:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc8Qm-0001rD-8T; Fri, 01 Sep 2023 13:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qc8Qh-0001qu-Qh
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:59:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qc8Qe-0004Pb-DL
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:59:35 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 381CAg6W000527; Fri, 1 Sep 2023 17:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HOxq423MOJBfI062c1Pobn6U9c0+zp6xa881KfDdwDs=;
 b=kx3gx+RSWntegCj40jb1E9MwP17y2uEvp4n8kNvXZ0In0B6A9SfbmzVIoYUrNzfxGEOF
 jFDMRFSdvGy2oBt3+nhfaKBVT3xHGDr3SqJiXDmP8rsq3KY5FZ7vshiSTgURFb/zgPBf
 cmLYvHvm6Sur9xpoAPjEZ9SrtKI7yqK4Wf1lz7k5u/c2GzWl7zvDPw95hIDU/5pW5Wth
 PWOL8UFlQ5ZLq+oD4jvRLomRMMQmbdQcIpp2Oohhtd9RBmlz8dk7rWRQs6Q+wCusFjkV
 a5YdaAOAIwJNNwFDTu6uQKLPTXhCKqJiYcKcSOnHw2AoZHYTIQf5RDb2JtKXdOucuQvy gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9p049qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Sep 2023 17:59:29 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 381HC38F001309; Fri, 1 Sep 2023 17:59:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ssyw6tv5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Sep 2023 17:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbk5pboIiamrg2StjP9Wli+RjwzoiAKityzwlYHMCWcj/1e5g0HKP0Lthw2B5k4dRBQVDWIOH1syhJaPoPDPx+rNdDaEQre2+XZnR4bgCqbOWnQ63tLYfp5GmuSjjQkI0n6Umc+AvhrPeZnYZtfNQaIyAp2+FWxVI0deSYlTdiJEbVWF6QJelOVlCmnNY9PngQPTCQQ5ZrT8DtbfUtsU0BW5SYAYn0WZWHTxvmyicCCHo3HD03jVpd9eSk9AtKll164zr6klXUeEK4NdNJldG+XNsFteb9sjcmscy3Gek4VCE5GB5fn5ztAHlqWecKc+pF3pPR+mtrTQhOqmH9pBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOxq423MOJBfI062c1Pobn6U9c0+zp6xa881KfDdwDs=;
 b=A9HKlpV84UyI0qW4Rc5J6gOc9Uyn5sBenntV/dDuz1C82ZFcaRmLPwMpeclCn5oNQU/YIQrFpoXP9ME41Jw0OUoGckXtsdEu0f0JNSjD0+6/PIOlG95jrvlpOZVjJ9HyVAKNm2oZaS8E17tJI9vyRKXy4esvE/8MX4gfdxMqwCqDMIM88c7/e772qpT+tE2cBRPt0GlU/ODTREYtM6111+Kwq6zl88AKln8raqDjCqLd76Cm+dZC3nlDDuD8Jq8ijeRHC0kyXZZFP2S3yk5KKRlfXQ10IOHVd+8O4/alZaL+kjRSze/JdM+bI5Sj2kzVs+cMwJ3qDEpkxbEE9cRvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOxq423MOJBfI062c1Pobn6U9c0+zp6xa881KfDdwDs=;
 b=O38zszHea2TK5pHY1VH7nBJ9J4MXtxiAcgd0YNt0MTWW7dGHuU+Uympj32lHjlYvD+mPY0IgK1bxplOAwNG+u1ZcS4DlxpgfgPCXlyGsNzX3AG2qaJM7gcjTOHZWydfp4m3TX3FKWvj4ENIBhwEgemIaZS3DRVistY1eOut7U3I=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by IA1PR10MB6829.namprd10.prod.outlook.com (2603:10b6:208:427::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Fri, 1 Sep
 2023 17:59:27 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6745.026; Fri, 1 Sep 2023
 17:59:26 +0000
Message-ID: <2f53f68e-7876-9cb1-4804-82fa08116aad@oracle.com>
Date: Fri, 1 Sep 2023 18:59:20 +0100
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
X-ClientProxiedBy: LO3P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::13) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|IA1PR10MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 6156c222-3681-4716-421e-08dbab152e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOSJ8O6QaqO83OhR5kewmlTbkTCtkuOrCGlHSEjoDksZo1gVwldaVLFtShih2ZWZNHlBWHC4wXnY88jntku06okxAKrH8h0PPDe8VQOxJ63NaCzQipO+OiVFEV3lpE8jXns5OvpFT+cAc1CG5ZFwRWeaWz7BNH+9khYKZOiw9HGEDxlhWFq5q7gwksVJnlxT2ros4rRX1XsOplWlNYE6mT6qR9RKKVFkE3UnOxPCiqA34JmFsII6ejR5uNNwl6uUXnRaNW5IfPbXBRYZ3Y8cBDBexjWoaPrT4ENE1FDEZP+lRXJ3HDRb2oDoXxd6K0ayj3eRXpwXxjM65G0ZtbMSSCT5sTrt1gYqaSyqGTegzxnSjgjlFvRgbfGxdULPBjpaDxyuVOpRSPOxVeOJ2PB6bpJiP9pDzB5pBSO6Qh2sKNdQcxEsE9u4XSGok3/mX5sVUx0LyuvFNk7mDwSMtkU4DdVm4XhChhbHXICKhY8PPnPnggjBxKO1Dn+2qpZQ3r1HUvFm1mFmrGPSahAGUJVSK652DotJPm94f84KqH5/47g5OHwCQF8Z02DSaUjQWKcm6rbVa5kYGsrpgOOwXKfBJzn4yZUdxTNEipgjS6lfArQOAIBDpU2ABvr1eT377sP1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(31696002)(2906002)(66476007)(66556008)(66946007)(316002)(38100700002)(54906003)(478600001)(5660300002)(8936002)(86362001)(7416002)(8676002)(53546011)(83380400001)(41300700001)(4326008)(2616005)(6512007)(6666004)(26005)(6506007)(6486002)(36756003)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGpQZXcvM2R0eENBY0hsVTNxWEVFeTg3a05nUWtsK00vT3FSclVUbFgwdGtw?=
 =?utf-8?B?WFcwTjhzc0pnU1dldEFCa3hxdDh2cTRKY2tSNitzSW9SMGwyczEyd3pJUWwx?=
 =?utf-8?B?LzlPT1VnVXRyOEx1dklRY1VvRWh5MjFTWURLa2t2eU5adGlaR1VJSUNsUTRC?=
 =?utf-8?B?Wlg3VnA2cHk2L2tYcjI1RGpBZjMxTUJ0RjNJbFNKbUFSZlhXWndvTkxMbFNv?=
 =?utf-8?B?Tldsd09SWi8zTEpqc3BwVkNFT2w1YmU1amZ1OTlrajlycmN6dVJuTG9IaS9G?=
 =?utf-8?B?Ukx1d2NFeFRZRjBPc0Y4QStNVzdyY2Z1QWc1ano0bk9XOVFrUkF2Qmc5elhV?=
 =?utf-8?B?eEhLc0QyREFEN3dpVVI2aDhUQmQ5RnBzVFZTZ2RUbE45UWN3SnlpMVhpcllz?=
 =?utf-8?B?WU5pZVFTKzZJM0FqQlI5MkcrMk5zb1M4eVl0emZnVk5PTDFiNG4xMnFIMkcv?=
 =?utf-8?B?ZTBGNXREWk1ZSWNrQTRXKy9pSFpxQ1JubmRoVTlUb2UvZk9tejZIT0dpbkRZ?=
 =?utf-8?B?YjBqV2phWWptT05FZ1RYdjVrMENsSnVBeHdmdkVlOERvd3M4cjEvQVh4Y0lG?=
 =?utf-8?B?cVM2WXJ4SVdVb1pRWE4rVERQOHdFVVBkUFM2eStrdUpzeHh1MEJ2UHJYTmtq?=
 =?utf-8?B?UXkzaVF1aWp4S2xLSW96SkFtOGM1eVRDZHlUV1NJeVJtRC9XdnF0Nk4rbzNL?=
 =?utf-8?B?amJDM01PdXBNMjVXekVIZUNqd2hkT0hzTTlvN2xDODE1Sy9QeUIzSjJkYlBO?=
 =?utf-8?B?b1NEOVQvSEMvZjU4R1Q2MkNMMDdSZTlibzk3Y3MwYjloRmdjZ05HMjlGeVQy?=
 =?utf-8?B?M3J6WjM4QmNtd29rZmErVEh3QTExeGhrYkpCV29FeWxETlV2NWFWOXhsTFFy?=
 =?utf-8?B?Um9FZ3FramVoTzkyMGpYRnJ6T0hCNU9CQ3BLUGpMNXFyaEM1cFJDdHJUMWpw?=
 =?utf-8?B?YUswYlJLYmx4MllwNGhFamVSQUZDeXMvU2gxbFR5bmhXWTZES0NwV1p6Yjk3?=
 =?utf-8?B?VVZ3bU9nNTJDWXRYbUNMRG1ROVpVdDFJYndScE1hVEo1TGFCYUFULzY1cUxL?=
 =?utf-8?B?aWRJdjNTdUNNSHdFVTdpSldzQ3Z0Z2ZQbWlmanZQWHVFY2hzMHVwMVVsdnBz?=
 =?utf-8?B?OFFvanIzOEx2RTROUlFPNWN5Slo5MExkbVcwM2QwNndGYkRyZ0xtL1ZIVHVj?=
 =?utf-8?B?ZHZMeUFvc1RJd1hSUkIvTDNQVFJxLytmRFdjNU1CTHlzUG9MV1Y0a2I1T004?=
 =?utf-8?B?MFJjVlcwT0JQME9FcnVxYUFVZ0Y2YU9naW1FZzJUQjh2RVBKWFVJaVJnUDhn?=
 =?utf-8?B?M1R6WEFMUDhabXd6Rkk3bDdnSUF2dU9uYTdENExvakhvRE9IM3FnRmtNY1Uw?=
 =?utf-8?B?d0Y2OWhVZTRobTZuaDcvdmQ1WDV5L1JyaFE0elRpaFR0amRQV0lubUt2MFgr?=
 =?utf-8?B?QmJPdjAvdWQydHNBUUxFTElPUzQzZjM1dko2UHBUUElnT0FYeEtqeDJLaEV1?=
 =?utf-8?B?WDMvRWJmeXpaQWRjaDArQ0dBWjRYS0kzMW9IL0dpZjVReStONDgycDFaNzc5?=
 =?utf-8?B?L0xvOFF5U3hBdHhpWG42OGFUTFFYRjJwZTE4SjdrbjRoRmhPbWNwb3NqZXEx?=
 =?utf-8?B?NHBlRGd3OGJHOXlMaldZZDdGRmZJMXY2ckkzRlU2ZzQvVlVreWU4ZXJJekd1?=
 =?utf-8?B?dXcyVVp5d0pPdHZJODdPYXJ1bjB3S2wyY2k4b2FDeEZVYVdUL2Y3UDBvclNB?=
 =?utf-8?B?VUhGZXE4d3ZTZG14ZG0zME0yWlB4c3JaWVc3c3I0STFRM1FmeWFNNkRLQmRW?=
 =?utf-8?B?QmFNNXpETzUvMjQ5V1ZjeUFzM2NkeWRmMDZFR0c3Y3JJeTNhZ2ZGOTByK1R0?=
 =?utf-8?B?MkE3dU5BRWIzbGNJVlFoWm9yN201azRPMEVzRk04VTRmN0cxQ3NJbWlWZ1M1?=
 =?utf-8?B?Tk9oSnRXT2FMaDZHb0VVamtuQzl4eVY4d01wSmJRQ0cxMWg3K1RCM3JtUE9M?=
 =?utf-8?B?TER2ZVRTRU9QMkhUZ2p3RnVURzc4T2pWZWZVQVNUdFBESXVPNmdvZjZpbU9l?=
 =?utf-8?B?aXpWaDlVMEd3QmdLOHZLTmM1QWtsVnBuTjMyYVhnVWNnZ0FOVWkvYk54WHFB?=
 =?utf-8?B?WTBXYldFTUZqMldTcGlBSTRyRmdGbTNXUFdqczF3VGsySU9ldkFyaHN1dmVu?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2s+QrHR2oAWNGPynk6oF8jcnznibH1rqmMDTTJkmzjX7NLV9+T0S/n+v7zCqB7SfNwx1n0/pzlNIepCrCCNYsWXBl0i8Rl9tiMtjyB+P40FcUOIR+xXFoEJUcn5Fg6A3E7t0S9J7ztz1X16ufBDNMNokMDrIpVxhfnbL3+GiaRaXeHNbnULCP8xq4BxRf5g55IFCP7lKvxeVWiljW052MyY4QauxJnxclnEaBflud4ch2u2MD7Tx/oV0XUQO1KB0fMfcujJ5+0IjkohuKtcCM5XpOC3MWuWB2ooQbcu3Js7yvxg1kt+YGGk6vgXcR+MQPjMvOLpcErz/ICkDJe9ONh0NB4hDPK1f/AYRxxQ4tkapqS36stb1bzi5AbmwBO7FJzqX+PYZotgwAH7JoxEZhe2+nZ+8qUY0euhBBIbOONtuLDNdQ8T+w2EnE5N4Rkpn2AeE1RfjGa/DoMAhy2wdrn3rBWRR2PXmEtflPlZkjH3RmlEIA6zn4gwuWLPymV4FKRQjYVLRYFLh4v+16pjqk95893PpGYIoDxDd/6JKVsuqflNic1N+yLowhvkcPdHlAdTbfM6Gc9xeKzvMnvwU007vl/htqb9xnyL8u3HI4L6Dhv27qC+XjvhPYX5LW4xMikMT8ofwU+NNQuot+q1bc5irUU9AX+hk0t4HoHdu9vUDsQewBQIK1WqtSkznM/N4qAY+zvA9/e8gKDQxxDXp8o8cgo3IQCZKwQEmQXyhkGpTaoukw1ytkE2eNEtStoFQg2d9EJitgjDEi2V1l3Uq8nApLV6EZQ+3PJvmKg9npRM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6156c222-3681-4716-421e-08dbab152e9c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 17:59:26.9391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1+khpk44Yp+yrT2dqo7k19RjQsrIuAPkENAX1OwOLB+q3j66yrtD4To5SK/Li9lMx87em3ldnsq7o5GnEcASGR81xqSpWF5K9SfYChZL+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_15,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010169
X-Proofpoint-ORIG-GUID: 7pO4DCDuslg8xolgWHAxzQ9QDrerMjhr
X-Proofpoint-GUID: 7pO4DCDuslg8xolgWHAxzQ9QDrerMjhr
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
> @@ -2694,7 +2694,17 @@ static void migration_update_counters(MigrationState *s,
>      transferred = current_bytes - s->iteration_initial_bytes;
>      time_spent = current_time - s->iteration_start_time;
>      bandwidth = (double)transferred / time_spent;
> -    s->threshold_size = bandwidth * migrate_downtime_limit();
> +    if (migrate_max_switchover_bandwidth()) {
> +        /*
> +         * If the user specified an available bandwidth, let's trust the
> +         * user so that can be more accurate than what we estimated.
> +         */
> +        avail_bw = migrate_max_switchover_bandwidth();
> +    } else {
> +        /* If the user doesn't specify bandwidth, we use the estimated */
> +        avail_bw = bandwidth;
> +    }
> +    s->threshold_size = avail_bw * migrate_downtime_limit();
>  

[ sorry for giving review comments in piecemeal :/ ]

There might be something odd with the calculation. It would be right if
downtime_limit was in seconds. But we are multipling a value that is in
bytes/sec with a time unit that is in miliseconds. When avail_bw is set to
switchover_bandwidth, it sounds to me this should be a:

	/* bytes/msec; @max-switchover-bandwidth is per-seconds */
	avail_bw = migrate_max_switchover_bandwidth() / 1000.0;

Otherwise it looks like that we end up overestimating how much we can still send
during switchover? If this is correct and I am not missing some assumption, then
same is applicable to the threshold_size calculation in general without
switchover-bandwidth but likely in a different way:

	/* bytes/msec; but @bandwidth is calculated in 100msec quantas */
	avail_bw = bandwidth / 100.0;

There's a very good chance I'm missing details, so apologies beforehand on
wasting your time if I didn't pick up on it through the code.

	Joao

