Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13818A09CE9
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 22:16:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWML7-0000Xi-W9; Fri, 10 Jan 2025 16:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tWML1-0000VB-8G; Fri, 10 Jan 2025 16:14:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tWMKw-0002Vm-9I; Fri, 10 Jan 2025 16:14:37 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ALBsFt015562;
 Fri, 10 Jan 2025 21:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=wm6W777iHWE/M1YLfWans4zxCm57qLpB0XgFS0A+VqE=; b=
 ASz7OC9jY37NSnEHjSYGv2GFZnUPajcI3QVHhp5jHfPBo3Rw3MHCccexBq+KBv/A
 6GJ+2SIYXcnk42hIj0wCBAZvG10OWLW0mRj/KBvQOG1kcB6EQm7c30aT8rJYuTsj
 iH8X9UsbadObeObb23y1awv6FS8xmZoq6/H2is1Ajv7M7Yi5XxDLlTNjNgzb3Cn3
 P/iJblOptFzUowveAJs9qGL1xrqUOX+ZkJb3VWmkDlXljyPQ3Fs/vJVPKkyVlgKu
 C+LY7YTN5MTxxX8056HgCRXXrtyA4EoY4OPwyr/SG3aRqffOkdd1Tv4rS4HzTnmB
 iw0JBMy8Z+Gs9CZZJBpXUw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442my625wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 21:14:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50AKIpL9004868; Fri, 10 Jan 2025 21:14:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xuecwpwk-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 21:14:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hri+8dZewz5A2IV3/S2Gbh3ufDhuU+cgKnslfldPXXKZYnpAaLMXyBJNHEktKb8qfPbJsOYSlekVUOuh/jVTPftm9q7EGpGnLbww8afXAAZ/k9ADP/rW7D+RUfWpmfVTcMTR5JMrD4v3n4HqFD/RUI3KZHCwCJXyg/HQrTHMzdMosfvQN6zALHZIGVszGfzHDqz/AXOHrEv2Ps1/EmwBXwiKGqrCn0zx8UORwVOu4/CvNPpoX+cWn5/b9UMNF4GsEx06wxy8zWIpIOb/ZVVTnToy/CaTmSNjDxzXmpnrgYPgTVPTnSqlQNMvP/bb0+hoB02zESnKmdA65i7xDYGMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm6W777iHWE/M1YLfWans4zxCm57qLpB0XgFS0A+VqE=;
 b=VZlyZk6bQ1YvLeppb5ReJad02NZZqaQ7wdth6BQ4mKGxWju6LBMH7SI6IixjIbfk0lmG7KwC34QzdId2No2/XXMDILx9UHaNKUAD0yHEU69oWhlQEn1G699B2m+z2vp+pBxUImbQm+xLAzGVd216UWbncuIsApq/5+iepXUHnP/t268SzKWzNEG8A5Yhp+lJdnQnNza7ZwxpuYpwPB4n5LAgEviakZnVW4yXhnMYjnmLx6yPcI4mxt9FyGtfDF5MiSvIf9Wg0Kf/zb5StpcUdP83YRaS5XWCvaasU9Y+FWBzNgXC/GGARhVM5Abp7D52Uqnr7dd0Fk/+TCxi7hTN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm6W777iHWE/M1YLfWans4zxCm57qLpB0XgFS0A+VqE=;
 b=rfQaOYr/wvIBO/SJR1rCVz6cwDMcc42xLWwF+fW44EhICRuT0Dab/bga26f618XRscQC60yOB1hTYrUMBnFeM+RF8HcwqszUz3d0FG1Mb+pl1ZNanw1xj2YdOhdvl6pKFBd3lD4zmB4IkerrVNvG1IhVhRijbVrvNQ+rK0mbzeI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BL3PR10MB6113.namprd10.prod.outlook.com (2603:10b6:208:3b8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 21:14:21 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 21:14:21 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: william.roche@oracle.com, peterx@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v5 3/6] accel/kvm: Report the loss of a large memory page
Date: Fri, 10 Jan 2025 21:14:02 +0000
Message-ID: <20250110211405.2284121-4-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250110211405.2284121-1-william.roche@oracle.com>
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20250110211405.2284121-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:408:ec::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BL3PR10MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: fb600ce0-78fb-4fc5-9266-08dd31bbc011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jqMyb2+sFLG07GwDQbutXx5JdT0cdlO24VnIRrN6W+t+tETnxgGzvmuqaIFh?=
 =?us-ascii?Q?9MeYH1lIY+Zjr43KMv9IvmH/tlTIF9ZhprqhzMHYqVgXfCK2vhHRaS5viRoi?=
 =?us-ascii?Q?dVOFx0LV4XvrJ4H1DvLnUB6DO8zQLWFQxQZ6rsv90GhrV0DsbXtJxnqLEOVN?=
 =?us-ascii?Q?us/ESopfVMQc0WiTS6DSkxQ4GcTKx3Zelk74qn68ClTcD2y6/yZ2SJG3L3MG?=
 =?us-ascii?Q?5PhT4rSsaa2HRIkG9skfrZiYqsingWdOZIjjjbWRzPfAkXgq+vqYXk+oZ8be?=
 =?us-ascii?Q?/b8Mn0+E3FxrmYz2mgRAO7r1Lg2XbHIbhpDY7RHXZK2/QcI+de+x59nLBQ1i?=
 =?us-ascii?Q?j8QM5Lo8yDMQKhL82iB15CYe7ah/sDfu4CkujpXC3qYpWUlE/BvD4LQImIaz?=
 =?us-ascii?Q?IZs3nNr9sMmLTirJQa6q38M8ZNthkB6q6JOgqhh/Gsty5xJ6zhVBCb57rHp6?=
 =?us-ascii?Q?k9re0oGQ/oiA1y291awkl5GJGDAFG26D5yJ5aAVaozMiSlp1gt50MkHcfApy?=
 =?us-ascii?Q?6LyQVQOOHCqrZ3y12zxs65GclicRBYl6Ql7T2ru/NugXk2Fg/ta23IY01Ny/?=
 =?us-ascii?Q?Mu2cgrR3gnsuvCETfhs+uwqguAINxBz/myeYXrVZcWdno1FjVbhGQjG8mlvI?=
 =?us-ascii?Q?L2mWxwC946legSI7mfrrMC3tbPG5PGBVFxPgVZPv4yWbp2ixyxgQ59oernOo?=
 =?us-ascii?Q?3Cmo8zOPQooX5rCMYdir6jPbAni9agN2VbBN/yMV7Ihl2rjRxbLC5/hbAv1P?=
 =?us-ascii?Q?iL24EU1hZzYBjf4OiHleusWe4zOhlJ97uwzeSrQndtsakIVGLXcV2tHB6sPT?=
 =?us-ascii?Q?pdw9rqrHUHz1PEqIKR+0Gby9YGIpWdnrlQho2q8Ga/gq4kGHaojoYuVVl3v8?=
 =?us-ascii?Q?lgbfC/f1jhoVqOzgrHXTyVpSmrmCTySwJWg95ljgUCwkIiCdSSaUlDzT8uYa?=
 =?us-ascii?Q?YCj32lkdcqwe6xZAzY33ZQbf27zVs8SmrICRCVl88o5E8LKPyh7/bJ9Jdor7?=
 =?us-ascii?Q?CgvlSoY6L5vFEmCAS+JfYk9OJfYrlWDFkm7og6vk4GDQlkl4+6kt0j8PnC6a?=
 =?us-ascii?Q?0+/8veqRhUnPOz/V59xdLRsFVlndScUgDisBoeotsN+E5ZwFo9/quw7hR/72?=
 =?us-ascii?Q?2zMDwy5hAFS6YlKoPJvSqooriULrHUTrpMWoz59G04TfLBpNcODqHBc3dHJo?=
 =?us-ascii?Q?pc5Dlpos5EMOanguQp9jikpCIY9s/1kOWybrtgwNlMSQmnLbY1eTYFhq8WPN?=
 =?us-ascii?Q?3z1ixI7XIrGp13eWJC75kumD3W28LZC2A4+Io+pS2dLiD4nqzZ4QWJpDv8G1?=
 =?us-ascii?Q?8+0ZBAGoAWsFY4QR+jzWkAzTAfp4xqmSp6Z0WNOG1AJ6BGUXN2AC1w6i0cy7?=
 =?us-ascii?Q?uKoMw5dMKXoCKxvfpjY6KKEKr8wM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F3Lo61f83tV9n44N+l5LL4AuAYUAZBhvZJkVxcFPQgkO6VHP6akZLpgLUInM?=
 =?us-ascii?Q?vVmtkx23RdxhNHkfCAmmbeZ+PT2RNerZcitg/rvSeRzrOrBMK8IMwIgbfFW1?=
 =?us-ascii?Q?Y6vaj0V2c0hTIb+3Lmph6F6cDxzCsm24+R7iIF9vCTmSZAqiIUzqzA6GukE5?=
 =?us-ascii?Q?a3paJFyEcLRGrsFg9Wm0doSWVrLVpwtVgnXTdyJDp98a8ao3s5ZBq86r7RXG?=
 =?us-ascii?Q?AN5Abl+JywbPRS7rPhyTyRvxiUU1hyHv9qaeuWmLk8Unvdy5hF96jl/cnhUA?=
 =?us-ascii?Q?X/8mWOsSNtD+5j42lDShi/Ut/eNLGclg8VPIHfT+Qag5qktF8aWolvCxBpJz?=
 =?us-ascii?Q?MC9IrLze7LQ3WHjdxv9InyMEi2Fg6abLXVS72xjHdPMWWIV/bC0NDjqDKDmQ?=
 =?us-ascii?Q?4/A/t4/aDUdZwOZuyj109/LM1dyKJdyH7usXoITxdbvhw3dUdYO+7kDXbrKB?=
 =?us-ascii?Q?f7OC453kDI5PbQ5gBCXa+PCi53lPaCOAXLckiz/3BKrVq7dD0Srgg8EtT8s1?=
 =?us-ascii?Q?G/JNHVWiEpvy/YtRnFbpq5jfnzhi6S1bDzQ1k43PF171SF0WLjb/risePe/N?=
 =?us-ascii?Q?40L4NnGmZV16X5VnFJhXRJwZXgeJvHLzTN2Q1HXJ6cg5CsX63RwdUeThBDM3?=
 =?us-ascii?Q?g8VSGj0H2KduymtrswHH6pBx1GRBs3UnTm7m8egbkl7jUK/z7VgL3Crzwa/T?=
 =?us-ascii?Q?CDK9Q/5BA8WZyLtgILQei+U73ODAX/5meQHZCKcEWAMEZlHmyomczE2rbLBA?=
 =?us-ascii?Q?L/pBm/PphdUlAcEv7lLmk+Of7tWC6f5ufJILSBct+r3u/qzNTEwYyvXZFJDT?=
 =?us-ascii?Q?uAPi61SbNECF28kxh2dqVLMnnfAwZDTmy1h9kT+y3wojILy/utcfm79prtiq?=
 =?us-ascii?Q?W83gTc1Utor/CD5ghNH0POub4lCP6guq4ohysiaPAOQ0wrA+gOyGukILQkbo?=
 =?us-ascii?Q?XVDCiWBrA4KntTWF0Q/Yyj05afsj42pADb0CLencYqVy6cx3n3IsyHR62qtx?=
 =?us-ascii?Q?TqJjGwnZogWQ7ltgW5rCf9RJDpadEL1wVD9IvVcXtGSoZSm/Ao9HANPCKuGl?=
 =?us-ascii?Q?x4mCL2ckYrZS1O/r3yE0ymLzU7IBIPOQqbYPzrVYy9DAi9hsSVLFSMXtqWqS?=
 =?us-ascii?Q?0SygOrx6lfoCCiLJrp3uRLtuuD4NYAMbB1/92Og872Qu0Unl6rGAXo0vSg1s?=
 =?us-ascii?Q?W90SCZxRdsKBgCube+f7W5wPi1enWtoaooH3N+epW0LBG+9x7ch3TUHyIO8Q?=
 =?us-ascii?Q?+wcUknqUic7LV8xZ8fy8yns19pc4HkokijbESy1dVEFIOMuE4xVIaLgojPMf?=
 =?us-ascii?Q?1cv6cnsJCpp+2Y7QLq51h6rqMd89vD2cNX9MdeKa97eUVyZwxII5uz9vsear?=
 =?us-ascii?Q?uux/4tog5rYU2paPcFREQ3hY2hbinuNRo7ox7UofwOOvd4kUU/yrxDPyHCy8?=
 =?us-ascii?Q?NP/GWN/F94yUTA+nI9HBxKf8j0/k2P3Ed9vCwCfXywotcipnGti1YktPifZ3?=
 =?us-ascii?Q?Zz6s6XMUCy95lcNYP96vJ3C9aWAQ4ETl/oTkfgESJAH+cNsGe5Hp4FLrZpag?=
 =?us-ascii?Q?mxlS1CQghWQyaOI5x/PoqTs7Ue302zJk2Quik0vCPgJejJ15BJmRnqEmzYlP?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F5EVVlhnqs65HIfM7SjIkCZ6dyvmUqBdsPBzDyZi8FrOKmUQohr1v/ta3HXZEYp6eyCYW3ZoT9brVJ9tgD2ny1T61ha1hWyvV0D4BY4hFbfY3wd2fxN/1LnN5e7VG+dL4PgIomWodwUnn5am8SufEzhXrFoFMncehxtYtpmZ2T4pi4v2PBbDIp/6s7OLUtfFdEdKu77mIFp8i3pFcDvNNX4jHONUS6HflChApo9rsuAexUaQHZirxTvoFUjv3qWn6/R7msY0y5QhzYfBCd+GbZG+ukJpN2H8M0IwNx19EJWz1tXVrjAsFHMuIN09hcfGRhxCp53zPq1vtlmwt70ne4rLrUTzgpNPMZe4+MYGyCdRPnw1vM7emILIbFXxHUfPrzZuwpeF+HYZBP8G4iBfU3J2AjWgoH90fDyHGu243D4AulN2wQxWB7UYnpk1LBHluCeqBzezh4VBjQ81fG8vyleZG8QHqCFUmeLksWP9J2eURcnwF3brjrbNAA3X1uI3vJhzBg1T/Yx+OFIF+C7wn9wVPgsjRAgw1zydypTL20oLtGyxsWyR98jcMv8XmihGEJCjkmmqwajROjGQTJgEwcgg+r6uk1mQqHe5UnHmGRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb600ce0-78fb-4fc5-9266-08dd31bbc011
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 21:14:20.9447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 135YkcD02YxCCqft9Zj/hCLvM/XTvYFsukKBMkjiZQZs/hE4/273CAmNTHQ4AUZH1fbLlZLcQzyVYLVbc8OB0sORU+rXCJHULgNORNEimDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_09,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100163
X-Proofpoint-GUID: NKvnQ9IebNRvo2OzVIvdnFi8DudGaT-K
X-Proofpoint-ORIG-GUID: NKvnQ9IebNRvo2OzVIvdnFi8DudGaT-K
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: William Roche <william.roche@oracle.com>

In case of a large page impacted by a memory error, enhance
the existing Qemu error message which indicates that the error
is injected in the VM, adding "on lost large page SIZE@ADDR".

Include also a similar message to the ARM platform.

In the case of a large page impacted, we now report:
...Memory Error at QEMU addr X and GUEST addr Y on lost large page SIZE@ADDR of type...

Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c   |  4 ----
 target/arm/kvm.c      | 13 +++++++++++++
 target/i386/kvm/kvm.c | 18 ++++++++++++++----
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4f2abd5774..f89568bfa3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1296,10 +1296,6 @@ static void kvm_unpoison_all(void *param)
 void kvm_hwpoison_page_add(ram_addr_t ram_addr)
 {
     HWPoisonPage *page;
-    size_t page_size = qemu_ram_pagesize_from_addr(ram_addr);
-
-    if (page_size > TARGET_PAGE_SIZE)
-        ram_addr = QEMU_ALIGN_DOWN(ram_addr, page_size);
 
     QLIST_FOREACH(page, &hwpoison_page_list, list) {
         if (page->ram_addr == ram_addr) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a9444a2c7a..323ce0045d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2366,6 +2366,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 {
     ram_addr_t ram_addr;
     hwaddr paddr;
+    size_t page_size;
+    char lp_msg[54];
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
@@ -2373,6 +2375,14 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
+            page_size = qemu_ram_pagesize_from_addr(ram_addr);
+            if (page_size > TARGET_PAGE_SIZE) {
+                ram_addr = ROUND_DOWN(ram_addr, page_size);
+                snprintf(lp_msg, sizeof(lp_msg), " on lost large page "
+                    RAM_ADDR_FMT "@" RAM_ADDR_FMT "", page_size, ram_addr);
+            } else {
+                lp_msg[0] = '\0';
+            }
             kvm_hwpoison_page_add(ram_addr);
             /*
              * If this is a BUS_MCEERR_AR, we know we have been called
@@ -2389,6 +2399,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
                 kvm_cpu_synchronize_state(c);
                 if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
                     kvm_inject_arm_sea(c);
+                    error_report("Guest Memory Error at QEMU addr %p and "
+                        "GUEST addr 0x%" HWADDR_PRIx "%s of type %s injected",
+                        addr, paddr, lp_msg, "BUS_MCEERR_AR");
                 } else {
                     error_report("failed to record the error");
                     abort();
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2f66e63b88..7715cab7cf 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -741,6 +741,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
     CPUX86State *env = &cpu->env;
     ram_addr_t ram_addr;
     hwaddr paddr;
+    size_t page_size;
+    char lp_msg[54];
 
     /* If we get an action required MCE, it has been injected by KVM
      * while the VM was running.  An action optional MCE instead should
@@ -753,6 +755,14 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
+            page_size = qemu_ram_pagesize_from_addr(ram_addr);
+            if (page_size > TARGET_PAGE_SIZE) {
+                ram_addr = ROUND_DOWN(ram_addr, page_size);
+                snprintf(lp_msg, sizeof(lp_msg), " on lost large page "
+                        RAM_ADDR_FMT "@" RAM_ADDR_FMT "", page_size, ram_addr);
+            } else {
+                lp_msg[0] = '\0';
+            }
             kvm_hwpoison_page_add(ram_addr);
             kvm_mce_inject(cpu, paddr, code);
 
@@ -763,12 +773,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              */
             if (code == BUS_MCEERR_AR) {
                 error_report("Guest MCE Memory Error at QEMU addr %p and "
-                    "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
-                    addr, paddr, "BUS_MCEERR_AR");
+                    "GUEST addr 0x%" HWADDR_PRIx "%s of type %s injected",
+                    addr, paddr, lp_msg, "BUS_MCEERR_AR");
             } else {
                  warn_report("Guest MCE Memory Error at QEMU addr %p and "
-                     "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
-                     addr, paddr, "BUS_MCEERR_AO");
+                     "GUEST addr 0x%" HWADDR_PRIx "%s of type %s injected",
+                     addr, paddr, lp_msg, "BUS_MCEERR_AO");
             }
 
             return;
-- 
2.43.5


