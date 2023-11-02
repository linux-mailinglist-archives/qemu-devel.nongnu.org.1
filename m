Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB357DEFC9
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:23:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUqi-0004HI-S3; Thu, 02 Nov 2023 06:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qyUqf-0004GW-B3
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:22:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qyUqd-0001mO-CH
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:22:49 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A282gal020911; Thu, 2 Nov 2023 10:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rvSpEcA7me9dy/VYaa+tSH4LbkL3Hu3PSIuspCCzmW0=;
 b=PNFXsZ/Qdnm74Sr1oHAKF4i1etNL5+YuNQzOmd+1ftAjpNnoFNjphd8zEV3j9eaNdS3C
 5WOtWej6NebczHaQVDmEfeE4XSkoNlzThvaZlCNcK2WvmW6WiU/9hmheIb6EwJyfs/ar
 91JXWVIHX34oopJDatd0c1qNkJ44e064i+UGw/yDRDI/S+yCw9TE/q+W2wTW8WEy9yrG
 xRjEe9hPTBwSVIurul2Kr4LNWB7dlPrP9IsVb0Un4c70JlgOhnHbtUl5Ux6X5XJXOyYg
 HcUvTy44Xa4jbIw38zoGQHmpjy2y9qXwmC0NedDnzJbJpWrfA+lb/yswtUMd8edVkDk+ tA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdsfu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Nov 2023 10:22:18 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A29j8SS020354; Thu, 2 Nov 2023 10:22:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rrejcpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Nov 2023 10:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7uw5o2/aLKI8qF2nGlars8hIOnDsTxMI+9sMTPoaYi0DMSDzqCz0EY6IWbnhBL4uhszxIY+bASWD6lOo2NuMdA31m/Q94V2g2xVhEX4BUQg3BHGB6chauF+GriMRmsre264uhHsAg7rkLMCmq/JIW8CGi+8hluin+tDLsg2+F0BnwXpos723HI3JdzbupNv1ix8IlNlb3mVjTKyJPQUpYOLrL+MzVctFmC8lPTJnCVdesEScu3IvCmpcd0YMkCCfJ6Z9FyJ4wIi6tmYSHR4ooV6kUDk/wJE1JAm+EewifBAc+R2YDC/I4UeVGRLQroWoUH45gcMAJUyxUhN+pzsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvSpEcA7me9dy/VYaa+tSH4LbkL3Hu3PSIuspCCzmW0=;
 b=X8IQjtAnGamv2/P4xBRPlzM5g/r3eFiCJFvivb/pq5my6nPEwLqbXN5trXpoLMcrbIdyfnPCjvn2TtQYRxnicFYxiHM2K10M74PR0l8xLGY7qW82xDaukO1o8wwULoLcgNhmzElRoOFhEFxYd9n19wOKI6xYY/5TynP3ClkIVdSFVtW7AbBWuas07H35HeHnxdr6NT52EhGnEeHLIHdcgo9OWskFoTQSWpJLdOcc34jAMJkfMc2+l48lJgi1CY3PDvWhqRhUGm8qK/IQWKc4yZXKbmXJv1P0siGiAH2ClurOV06fLsnglBi6zozZdyv9m3f0d2gN1ztykk71cCJvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvSpEcA7me9dy/VYaa+tSH4LbkL3Hu3PSIuspCCzmW0=;
 b=jhCMhURFA35yuZEm3KiXxD8r//NwE4HOWFlvueoFmc9yjWQGNDqZHegW8gWtyJgM/e/3wKFhxTXRsHyoip28aOSKAT19Fjk/R0+iztOPA3MkrD3nWaVqY4Mxj+Lux+3cHUnUyNZ1CUBH/wTvsL2ts8novAr9wnZY0tPhfoYwOGw=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BN0PR10MB4983.namprd10.prod.outlook.com (2603:10b6:408:121::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 10:22:15 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac%3]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 10:22:15 +0000
Message-ID: <6dde3032-ec83-4b27-9257-888cc1f6eea9@oracle.com>
Date: Thu, 2 Nov 2023 10:22:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] migration: Print expected-downtime on completion
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
 <20230926161841.98464-6-joao.m.martins@oracle.com>
 <877cn37x2s.fsf@secure.mitica>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <877cn37x2s.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0092.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::7) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BN0PR10MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: fe25cdc1-89b8-4890-7160-08dbdb8d9591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXrqIfLB5bMvkpoZs5bDgvkdCVja+aapOKBCgUQFoY3aFq308dkkNHKSuUHpcKGb45csNT1+zCqPdqu5M5tIaXpNhKFpW5d80bxp2O2dYGJKEG55gzIH5VEhlfFEcC3NXoMy8Fbn2tb4YcxzjRSeB7S5cuFLVtw4ke8pi/N4MCYCSuBWwwZpeOb2W6OdAONHiybtKAHWeDUBC23yQGjF5guRJv8HE0bLo0ZlQ2UZ/ecpl7QcPegfsbxsNM44VJJbgcDJYTzt3v6tD2m1aSi1defnnh+PzyQElpaTeImN9BgoeS+GqXCQLbmM2ekp2+Lg1TfJxWJdwZmNjywFVE0ZuTWBnrBomLy4ETtAm2nzkEQrupaztzvLHo6PNowEd4oBWEw92YBLVqvDagyxm0QCVjcl8qFEzQq7XcMiN3PD8XdNfiq8MogW8jxRGETXzsQqESfMmym+V8xt3Nxb+mjYWWw7q9OYvpHJRkWdsAkSL/6qnFX6tIDY6zGnx9Af3p6OuzkZo0F//NXTrsG4L7JVJTVMWbK3wb7iM+ByJojc55xKEtxJYmZEbUqQ9Fpe7QLbbZjFZHEWriWzzT4tuVfBPP1GoNHvyETrE6momGExhfuNxesiChPWO79g8+xwIY+krfAa2w9IXp+v5AfpATPCBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2616005)(26005)(6512007)(478600001)(6666004)(6506007)(53546011)(2906002)(83380400001)(5660300002)(41300700001)(66946007)(66476007)(8936002)(6486002)(66556008)(8676002)(316002)(107886003)(6916009)(54906003)(4326008)(38100700002)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUpjU0M5OTF4R2lHMkU1VjMzVVFGRHVTaWlUN3NNdklibjU3VkFSdVdiUVBE?=
 =?utf-8?B?SWlSNWlHSXU4OFpYV2c3U1QwK3FoM3VqOFVRamF5MU9zdDZnQWdYaHludS84?=
 =?utf-8?B?Y3VhNmNjdkhCK0lMQzlTZnlhZDR2TjZuRkc0S1grdzA5Y0FkbUtiYkthWjZx?=
 =?utf-8?B?cDhuYXdldFhiczF2Z3pRakhYM0tZUFF3a2ozM09JeHh1TytZVG1YL3dwY1NR?=
 =?utf-8?B?YTM1N2dOWkhrWG5NYVhvVFNpdDBmS1VxZ2ticlpHYnRpcGgyZG1lWU1Fcklk?=
 =?utf-8?B?R25xaGhBY0EyaHN5R1NtaXdoTVRuZk1YcUI5b3Z1c0p1cFcvQTZLTFZmdFZu?=
 =?utf-8?B?L1B2dUdleE1IU1QyVUk4aDI2MXZPVVpXVUd4aGJvRE5YYktCMVl1eVdYQjA2?=
 =?utf-8?B?NUE1eTc1NE44bDdYYWhLS2kzM1NFenM4ZHhETGtRYVAvMXU2eVBBSmt0N3Fp?=
 =?utf-8?B?RlViUEhhL1hvWWJreWRTWVNTWVRPbHFEMDJjNEIrcHNIMnF4YmQzc0VEbWNi?=
 =?utf-8?B?eTVPenl6eEQwb2VBWVVNdXNJaXBpVzNyODU2RjVqTGpkYlJiZ1lwb1hZcUoz?=
 =?utf-8?B?ZkpxZFkyaVczTFNpMm5hRHlyRGpsaHJGZnBpY0UxdkFNVWFrM0g2ZHYzWjRt?=
 =?utf-8?B?ZmR2MjM5QkU2ei9GVTBtOE9tMS80cGNqZEV2engrdWV4WHRmMHJ0REZvc0My?=
 =?utf-8?B?TGJ3eEgrS2ZSLzNmREZJd2J2ZERVSVlUZ0psdTRKVE1XTllXSytjMERhcWRL?=
 =?utf-8?B?ZzZQQ0ozK2J6UmVrSjNFZmUzNUN3YTFEUU14QVR6c1UzN1VhdG8zZlZrNUpl?=
 =?utf-8?B?cjRKQk9yTjFNUk1qOGZIQ2NiSzk0M0hadExGanJNbjF5di8wYXJCK2Z1U0pj?=
 =?utf-8?B?ejhrY1FiWmdyWFdMNkR4Rm03UHg0Y0hqb24xZm0vNzJ1SndwQ1JnQS9MNFhv?=
 =?utf-8?B?QWtFekpFdkJwS2xzazJYVU1lSVF0VGtySStwZm5SVVNPSTYvNVNMTXdFR0Nh?=
 =?utf-8?B?R0R2OHFlTlZDUmtMU25LL2luWTNBVzFaSFExbWJ5Y1YyTEM4eExyQUdZUEU3?=
 =?utf-8?B?UDJGVGtpbmVjVWtnV1JSSElleEpGMkZUV21hQjRqUkJqc1IycDEwbXdUN01w?=
 =?utf-8?B?cXFoeENnQW5yd3FFNGovRi9sQm9wVEdWM2ZVRDNtZFArbGpsdG5EOGh2Smhl?=
 =?utf-8?B?OFYySUlweFU3WWJOY3RibXh6TDJNaER1SUF6YlpjQ2J5ZUg0YzBOeFVZTnZF?=
 =?utf-8?B?WnhSakpXaENPYWcrbUtmMXh6em81djh0OFdYZkRmN1Z4S00xOE5seE84bERu?=
 =?utf-8?B?QkpFMldqTmZYMHhEbTNzVFR3bG5VOU0yWk5QSjloc1Z6Qi9wNTl2S1hpVml4?=
 =?utf-8?B?RGpkVnIyWFQ3a045N2VkWlJ1dTRVRVZVNlZNbzVjckw4YmdHSUR1Wm9kczB5?=
 =?utf-8?B?Zm1zNUZyU2FMZ3A5YzVlNGRvSG0vck0yVmM5VEhRb3dWcitVb05CelE5L1Bi?=
 =?utf-8?B?cmVWZFhtZzFURSs3ejRaRmgxakNXNEUyMWVyTUJaMldLbDZtMDl1N0VXbCtG?=
 =?utf-8?B?TW4xSGFqQy8wWjFtRWJUVWFJU0JrRXhkTkE0bXJlZVRVMnI4dXcwMiszZXZt?=
 =?utf-8?B?dEUrLy9Uc2dPNXZJQzR1dGhYMmdDS3pmREpUaHVMOHpqeGpMYXBrdUM4RGlZ?=
 =?utf-8?B?UFczZ2YxcWZmTzdsT2JZRlYrUmJVRlVWMTlGbzUyYmczMk9PL2dzcDhBWFFD?=
 =?utf-8?B?Qkh1bWNlWG5YTU1Sa1hOVnd1dHhCWkZoVGZvNnVSbnBJUUVZTEhqeDlrbzU5?=
 =?utf-8?B?U2F3YnBqdmxieEQ4WkdoVkNqbEUrL3VYaC9nODhJM282VG9PSWdnV3ZZdlJJ?=
 =?utf-8?B?ZGRFOHc3SVN2bUVjRy93YlJIYmNWWjNWc04yemZyd3Bzenh3WjEwczJYVmlX?=
 =?utf-8?B?bDhzaCtCa3hoVnJUajhUWVE5REFGREIrb3ZhWWdkaW1vU2s5WWV2TTdqV2tm?=
 =?utf-8?B?bGtlK0ZTb2VVOHN5S0V1cUpZYituNm1tYTFjRDQvMklSTW4yNjBVMmpLVUxG?=
 =?utf-8?B?NjRHcVFqZ0s0YjFZKytPS3gxUEFPVU4ycnJlUktjOEJnTVNOb3ptaTRFaFQy?=
 =?utf-8?B?UFEvbXV1T2ZaVElSZDNkOFhzbEJrVEZtQzhranY5Y3oyd2tjQlEwQkVzWERY?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S7zEQAmfbFCdGyBJUSOc9hTE+J3bhQCDizqY2EdgTrOSiqvAOV/EszcJlucjg8gkDXK9GwmzAFUWdP/S6DlFgzKIDc6tHUpfSxWaXsZlS9aSIi9zNtvyMUpon/QIGbCM//KNNFBgnt6dYgiqa6Lxm5ehLYGZsplDL+Q5fBP5V2OgDohI1R40XB34KGhZ1O/EgPUSm+/zFV/bJXw1vWO72Y1W7LU/GUHyJ91rqfSyrfyOsMPKwVtX84CFxFJ83zV4VQGZohcWNViO8xnScQWjCFJfPFc44hHnO/2cLaA30iA8gv0UeVih11ytarN8ZOcBwUSwleNMqfE7Q5ZckGjJ1wRdCp8b6awVT1Az4or6KZV89VkMMYatlaw+mqxnPLkPeu6t1sHs+JftO0G03l7WitQbZH7V2WYpVDV5FzSdx7Mas8fBU0GUbMJJ+LvVQ9s/paQmN2aXcyvRUVFptoq1LuVxdSWV2ycfyYHZIyjQVv5FUPBiBSqQAbARNYqNU35qbSCmtF8ubWIi8kfTpNgTLE7gxS9uXt/2lmxfikH4XlnUmgq65m9q6zNcbzst0cXK6lGe3PL3y/cBB1dCcPG/nobV1yzYfS1RvxSsZnrtcwhK1FkhvjR+ZjJDuPnDKPzNHvtsp8brBdmKS1pQlYAX6ntoXWXkXNtSNah3fDf7OoXNMo1Dc3Yak1yGf8mDxKSPbixsb0cp9zzoERqa8n6B+HTbB18/7NNXjaDVClJHB1ODIrOATpcZd41yMqpfox7JpN+UxpPfT/QmgOCBkjUTwbwPIME82mLYQ5VOsoRUjp0SdNuKz8tkg7Vigw0m+8kL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe25cdc1-89b8-4890-7160-08dbdb8d9591
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:22:15.1561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebkGJ6OtJ+5ps6q4lIumIQK7AJQ3wX6rFy5+1ai2Tg1Txz75j6br8uQcJxcflT1t7pBpLet2r7tR5HVRQBBqIbd5FqbnTawvOnZmGfhoqxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=831 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020082
X-Proofpoint-GUID: VTogw01DEJyZbBsiXSDR9UYqq1CO5RYM
X-Proofpoint-ORIG-GUID: VTogw01DEJyZbBsiXSDR9UYqq1CO5RYM
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 31/10/2023 13:14, Juan Quintela wrote:
> Joao Martins <joao.m.martins@oracle.com> wrote:
>> Right now, migration statistics either print downtime or expected
>> downtime depending on migration completing of in progress. Also in the
>> beginning of migration by printing the downtime limit as expected
>> downtime, when estimation is not available.
>>
>> The pending_size is private in migration iteration and not necessarily
>> accessible outside. Given the non-determinism of the switchover cost, it
>> can be useful to understand if the downtime was far off from the one
>> detected by the migration algoritm, thus print the resultant downtime
>> alongside its estimation.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> 
> I see that "part" of this series is on the downtime series by Peter.
> I have merged them (they are tracepoints, we can change them when
> needed).
> 
> But this one is not on that series.
> 
> Should we continue and send a patch for it?
> 

Yeap, I will follow up (taking into account Peter's comments)

