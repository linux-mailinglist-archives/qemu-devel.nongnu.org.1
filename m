Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E00A317AD
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Feb 2025 22:27:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thxmz-0002k0-Im; Tue, 11 Feb 2025 16:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1thxmp-0002hy-Fv; Tue, 11 Feb 2025 16:27:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1thxmm-0002H3-4g; Tue, 11 Feb 2025 16:27:19 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BLMfNB017515;
 Tue, 11 Feb 2025 21:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2023-11-20; bh=4LKpWki9G/gsboh1
 p1DGEaeOwLIZpiFR7p07bRLLvtM=; b=nNOXSpVqPoAKX9VbVOttLQyQ6qUd0G2X
 03GZW0/2JfOod9o+rVscz23m2J0AizbrwVlj4+pWLBN31HzCwW6w3iADRzRL8ydR
 ZngrrV25dKwqCOr23Ds97RkddcUsgjWwNFTBK8zF6kzwDclbaaiwGWnCU4hcE0k7
 XYeOysMNHkireVPxKF5ER17zxSM/0+RBS1tVaj0k5gcgw0YBR1pmojmK2YF5j89w
 zKWEbceaP4toItOxKQVv5cR8QwbtySzYzTBd2V5cPv47dY0zYf8aZPCC6hZVByFu
 S29uUTWiTtcTb7aLPkHZUNZkGwYn9KafEZRzmzB69K87k4lZ71VhSw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn63xt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 21:27:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51BLFVbD002313; Tue, 11 Feb 2025 21:27:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqfwcdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 21:27:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbCYQHz5GY3ih9Ue53npS34eeRkWjVc77QsiuMG0Yd3J9USuTPMjnrNHjfAQ/T/duv9Aiwia3pMvrelDL+pFzGfr+eut/TMp8e74pcbRZzhXjOggpftyuqnY2W5bcTZ5xkJuofTh5ucCQj5jtDWyH1ztYIK4PBfn7TB0pZ+8ssR24OKUUdwll2iwG7uj4WDimf3HQi/bO+MPiGZsKGEk6c2N7GVA+F53a7z7fIu8NKPsPnCP2e+Xm1sC44R2LQ+oke8YjR2rL3kNoLes+SCqZg0EfwUKoea3NXqFGu3Hs/5MCzfqbvTRQamzmMKzKUZ+q3HfB4jlbHB/216JSZZrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LKpWki9G/gsboh1p1DGEaeOwLIZpiFR7p07bRLLvtM=;
 b=tiPjh47lP9ZLd2CB9s+CMfl8pnJmXsEtDi0w9Oz7JuwS+KOFKhFALURzZhDU/QY1LQoTIyM6oYUNMv0/63xXRo9yeIvK0ZCusMTNcj8NTY1iU6iHTIh/+2kNpnhIkok65MvM+goyhmsOWDMedSSAC6Ftsn/bVQ/0Yjx5Eo/+NEne+4ETRJEd5y8MEG6yyX9Dij7+RJfEbCc0h3veVOWvTbVzVAfMn7DUmPRkviq4N/kJL/yd0xmXQjv2ftcuESOi+3WeKJVWx4wwGVF0/XH0eIEZDNFnqcy1IdblgRI/2YPPtp6VGTRBx+CyAs4RxX6r/k+JZj8BzS/BE8HUSILH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LKpWki9G/gsboh1p1DGEaeOwLIZpiFR7p07bRLLvtM=;
 b=X1bb7uDZ+Pfoo0PhKRqS7st6a3CX7vol+/l+48Unn/BZHTQT87xIYC5yxSsCqpaQoJW8oof8oWzgettP5rJ085U5uSnV014ePHEXbRk016vV+gqqGxPTRkBlhoMXxthKae4LxW+Q58nMw/ZVGzQLKJGEzu6pU+0id2xux1Wc9Cg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB7462.namprd10.prod.outlook.com (2603:10b6:610:188::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 21:27:09 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 21:27:09 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: peterx@redhat.com, david@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: william.roche@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, joao.m.martins@oracle.com
Subject: [PATCH v8 0/3] Poisoned memory recovery on reboot
Date: Tue, 11 Feb 2025 21:27:04 +0000
Message-ID: <20250211212707.302391-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::33) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: da72a4c3-bb62-4a74-3ab1-08dd4ae2d768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?twFgI6CturySeIJ1uBQcOAONVLB6YvgnGg0WcZ0F7FEbNKNxLRODUhTOJJ3e?=
 =?us-ascii?Q?U4BrO0xMaX/4z4t2B8kDrf2Sowmvkcno2nzi6fB7LbD9Vjx2Y/Usg2M2EGzH?=
 =?us-ascii?Q?uUklw3rhZHnEjGbmAjDTNrGJCT05EcElemzjx52zZnBFJhekK9ZkAsACmAbg?=
 =?us-ascii?Q?qvd2ltJtAsli5yANS1OvpisiAVME/TMCTyqQ6S89JipK18szaEtM9DemZHPq?=
 =?us-ascii?Q?oY5gErSF6uh8q21BXofza05so4FsXGeASHhirj7ag7yQPtt9YYPyZ+kf3OjT?=
 =?us-ascii?Q?V+xrjPbk9Ox2T3y27zKcCpqCmIxR+X/anI/5TNQhuQgJbNbEYYenZKheOW6k?=
 =?us-ascii?Q?SV1ZDzLJX32XtaZplJYStnB6Qvg4nAtxCkVhIzGGrLI1Y/7txXLu+u9TKObu?=
 =?us-ascii?Q?4EbrKQzgnlZN3Dp6dl30Kplfc0GI7zYcJPWeOWxyCUAiJWyQ63CRRLfemeFc?=
 =?us-ascii?Q?XpGmGysjyJO9a43Q3y+myfxNFysSYRruHA7tcqXrKfTn9DqouN22mkdTqhlZ?=
 =?us-ascii?Q?ZWf/qF/+NN8Bh1f1I+gmUx5Zaoo90iXt5m95rlb+1nSbaJFrX8tX1XOCSQ+V?=
 =?us-ascii?Q?OA/dHN6S5GaZx3gdMRpXVONhM2kjyicINy0rn2hpMZKjA34KmtvC3kFD7s2G?=
 =?us-ascii?Q?Qfs/smSwHkeHy0dWKg0gG41qBgTTl7nTmVz3XFylWp0o7RYasF701UG7g9rj?=
 =?us-ascii?Q?/Q27Y5xchy1iiWZQy/XP0XXzlvoGhS1bCfzGmdQgUzVgc4e4O7+xGinxWKP6?=
 =?us-ascii?Q?q3IYJKCkcZA1wxx1wY6JWMvkQ0wPEQuijy1K48Eqfwz/ezB+nBZiPEk3rJtz?=
 =?us-ascii?Q?evFgNh+/4cZPpTNIOEbT8yTal4VEY1u9Nvp4qdlSSia0dhw6EuLdwgqxuwLT?=
 =?us-ascii?Q?uXoQM8rQACUiNq/xkyXShoTucdDN43PBcE3/fSuEJwkZcZzcPr+4zrBmqSGl?=
 =?us-ascii?Q?0DYJeVSjozdodaMxpL2thvyyMTUAJfZvJpDPzN6mQAlcM1Q32sjpVZlQoIyf?=
 =?us-ascii?Q?WIzAAgFpx5ougsQlKX0vABh9oxtAp9MpKDE/e2vXbQnWGuFnLrWEuPpMdHPg?=
 =?us-ascii?Q?wGPqnb02yoXwf2Li4X0RDGcAAH9aKv+xTyFY1kzKRfvRyAikylEs4HXAadIE?=
 =?us-ascii?Q?U0eXx72Q9d5J9YEyFJ4JsXY3hasKEeartkng5Yk3mbbwX7b5AstnndXw/gjj?=
 =?us-ascii?Q?mE9S4J+OC9owbgQbgPECNmW50jRMC87fn1/kHqGi384doD8gGP3QD5pOKAgx?=
 =?us-ascii?Q?bfu6wQtDfwmNUcfY6mWKjtlPUQQvA+UTzh+2h5ex+KSg6JqgnfANVSQMoV3G?=
 =?us-ascii?Q?C2IOJmQqfCptp+QsnaYrV9cIKhuDQpavpOcgiaUn9WUaO7+oW44Qp2MJ5G1q?=
 =?us-ascii?Q?Q+rS6aMuM9rTl2UAIcBxdMdzGiTv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZenjhEGh2+7oS1fO8swVzHcbJODJum6dBbCUzDQaS1yGp7F95ya3y55ELg6L?=
 =?us-ascii?Q?CkqJ96aS8iVWH40Kga9BffQFEZwiBF3/JHAyJrYcE8Nv0Z244jtdXD5zzOU2?=
 =?us-ascii?Q?nruMfn67HGouOuY/S5+M3AgojTPhsCHS2pl5sYvvsyQORd5mJ+PHCS1shau1?=
 =?us-ascii?Q?clsJRxAM1bqDe0hbB0PhTDia/2P9ao7buCtvD9ukHL+dFFqplW4SXJ2qcxLT?=
 =?us-ascii?Q?bHRWtXLPZJ2FudPRAtvDSA+F1yu4QP9qsOK3r4EQuxj6gPPQ2TGFUpy2zeBP?=
 =?us-ascii?Q?pYknCVbGmfJ/OKHY5Baab0AmhEG5XY8vfGOML+fNMfJGswZNEkIDzbL2SJJ3?=
 =?us-ascii?Q?LKBbPp8CH6cbhm5Ls+TMmm1ZYAJHG8fukKkPwxqr1ED21+BHoRXNXod8FmQQ?=
 =?us-ascii?Q?JDS30lNKXn/VYHIHIRDSyvCFZPS82E5bSqDcLEfo9E0tKRxluu3tgAiMIw1w?=
 =?us-ascii?Q?EKgEPzWGRtCdIk+yDrsKDXKv5z2hX89CRFbglKLVQF+QgIsMH4GuL12WG//+?=
 =?us-ascii?Q?XACk5ssTjtri1xshY70HiVVGbj5Y3ZM5CMdNXuWT+RljdAB3LRv4sBAHCzNu?=
 =?us-ascii?Q?qVBN903K99dYn4FEdGC7CMjtVsQIBq3X2+Et1eeP/BQOHHa47qUsQiRJG1cD?=
 =?us-ascii?Q?aUlbDyVHieWMPIxQCL6aIOggUwnDM2cODQh71o2E2/LzwRoYzw+Xaqhw+2fX?=
 =?us-ascii?Q?rnirBVfGPINMLZXAEsOHrFWSPybIL9L7RZnF+l/NwrvxHDkH9MidBgxoSAdH?=
 =?us-ascii?Q?yNJS5I0QcY87QQeqk21PRGA4TrVkMGBpQoqRBvaogrlLb2KJ07AqSjh+e9E2?=
 =?us-ascii?Q?+kvUl9D3tUO1P55gLs6QrB9yhGgttE91+/hH+QwYHoPwGQYcJ+O6h/vwj+Fi?=
 =?us-ascii?Q?y+xlweQnu+yNVWY1v+EXxjU+dJLRLz8QP5FnuS5llC36ZYDKHJeNRc7GfGQw?=
 =?us-ascii?Q?3Mu1zfD1Jy2zlNtkrKCGyYJRzi+AZ833gcgAM61tC8eN8j3WPgep0Z4y8Gsp?=
 =?us-ascii?Q?DVNvSqqU4fh8vg6b3LuFVzTH3XYlepawBIlh+jFOMfz0YI5sX/er2qXGC4Re?=
 =?us-ascii?Q?00Pnuva85Rg6X/oJObtJsOk1cT/TF4RfvMH02khiWQO+4vCyf+p+ktpNaa/H?=
 =?us-ascii?Q?Jly6Y3D1bOAKsy51z5jDRFs59kfs/b8J6P+NL6qnqr45pS2dKsa8BAKITzgg?=
 =?us-ascii?Q?4hfv0i+Tbk3UYp2ZkEGf8tzYVf/TTcPYzhPa6T2Ne08HrNAEzl7GHrZIJ8HY?=
 =?us-ascii?Q?ZbUnABjqVSR6wH3o1drFpVko9GNPjAajfvxEK//cJDhxuXluiDTJicY7y/JK?=
 =?us-ascii?Q?9UaqkcpKTOEKYK4zhC7wZ0CHpHEKlkAJsLZx1sGValoJcrcahQ/CIJpOUpvy?=
 =?us-ascii?Q?h1brpZ8ruLJSSOQqyA44DKKdFYUijHPfsz4+ZJx3aXvWnaudcBipWj9A/4UE?=
 =?us-ascii?Q?WrLPFZgKYzOSGsFg/8lrA8JcgbbdUeqZThWYLv+z7o2yRzglvh1d+XcPwWCF?=
 =?us-ascii?Q?YEgLPH5GXAMLBAZLmF86d4daFZPobCSXpvlmobdb9BZs3pQW0A+r84XuHsRd?=
 =?us-ascii?Q?pz+5p+v4MYUFpb8ZdJIqF1Y6+77eRjV32ewKemSd2x9PSGi4aYjvD6h7b9vZ?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qdIcWGPfYhrwSdocQUpjZO/BGGaxGbJ0FMGgB9Bwfp8YCxKZdmP+6orsS6iHIh7qXeM9VC05q2vR5zA2dYTfNHkujRHf1ucB/cvjWhvzq3YQbhxN0cnYOeHUsfpUSULhNLnK56b9a71EQzuvLpch7Gqx9YepS6Ftka5i2JuapKwQJOMKW3q+1XE5djdsfB1uWrLbr1c3an8RJXYLZq0I//OiLo/fC/58/bHNezT8KwoYaKFXXJRhT0L7Y8ndBS1cR0f0wvK6ll7Ie7XTEjOupNjr3DOWcQ8nR0u8pZPDsfDw7ofeCEiNCcyAfU8husKY6/fm3BqdvpV1Nq3hgak/fFN6/20vsoeJQVm7+Lw5t10XdO3q0dqAp3K1jGw5+4s4PiBDZEktrFoDSPuWlbkppgC/i4PDmaCBydZKDlTAwYNRTWOblIT3VGCPXPoVxc37OYFDiL5yYQIqQy39OjQB2CD3O7JBSSLSSOGCxKn0zplgFHapSNNMnDLu7Nyw31WibkyZUIpJ9Bjeh4OwkZw9izB6flPH0P7wit+ROOTMwdg9+XAzLc0r9Ybq/bAfa52U/qmas+EZKQ0pHgXhaz1O5u1wgD0OXiHWbfESZN+5Axk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da72a4c3-bb62-4a74-3ab1-08dd4ae2d768
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 21:27:09.5336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfMaxdPSUPzerfOA803hsA/uCKax+GWFQh8F5CQggPehdwY8UEGvQQtJDClVMrmnyJEEQu0WS4c/UDzaD7G9eBDPoP3Z2EK+ohrut7odtBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_09,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502110141
X-Proofpoint-GUID: vNv-_NaUm_FN6VROD-kDnnZZ0lO1Dc3Z
X-Proofpoint-ORIG-GUID: vNv-_NaUm_FN6VROD-kDnnZZ0lO1Dc3Z
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Here is a very simplified version of my fix only dealing with the
recovery of huge pages on VM reset.
 ---
This set of patches fixes an existing bug with hardware memory errors
impacting hugetlbfs memory backed VMs and its recovery on VM reset.
When using hugetlbfs large pages, any large page location being impacted
by an HW memory error results in poisoning the entire page, suddenly
making a large chunk of the VM memory unusable.

The main problem that currently exists in Qemu is the lack of backend
file repair before resetting the VM memory, resulting in the impacted
memory to be silently unusable even after a VM reboot.

In order to fix this issue, we take into account the page size of the
impacted memory block when dealing with the associated poisoned page
location.

Using the page size information we also try to regenerate the memory
calling ram_block_discard_range() on VM reset when running
qemu_ram_remap(). So that a poisoned memory backed by a hugetlbfs
file is regenerated with a hole punched in this file. A new page is
loaded when the location is first touched.  In case of a discard
failure we fall back to remapping the memory location.

But we currently don't reset the memory settings and the 'prealloc'
attribute is ignored after the remap from the file backend.
 ----

v1 -> v2:
. I removed the kernel SIGBUS siginfo provided lsb size information
  tracking. Only relying on the RAMBlock page_size instead.
. I adapted the 3 patches you indicated me to implement the
  notification mechanism on remap.  Thank you for this code!
  I left them as Authored by you.
  But I haven't tested if the policy setting works as expected on VM
  reset, only that the replacement of physical memory works.
. I also removed the old memory setting that was kept in qemu_ram_remap()
  but this small last fix could probably be merged with your last commit.

v2 -> v3:
. dropped the size parameter from qemu_ram_remap() and determine the page
  size when adding it to the poison list, aligning the offset down to the
  pagesize. Multiple sub-pages poisoned on a large page lead to a single
  poison entry.
. introduction of a helper function for the mmap code
. adding "on lost large page <size>@<ram_addr>" to the error injection
  msg (notation used in qemu_ram_remap() too ).
  So only in the case of a large page, it looks like:
Guest MCE Memory Error at QEMU addr 0x7fc1f5dd6000 and GUEST addr 0x19fd6000 on lost large page 200000@19e00000 of type BUS_MCEERR_AR injected
. as we need the page_size value for the above message, I retrieve the
  value in kvm_arch_on_sigbus_vcpu() to pass the appropriate pointer
  to kvm_hwpoison_page_add() that doesn't need to align it anymore.
. added a similar message for the ARM platform (removing the MCE
  keyword)
. I also introduced a "fail hard" in the remap notification:
  host_memory_backend_ram_remapped()

v3 -> v4:
. Fixed some commit messages typos
. Enhanced some code comments
. Changed the discard fall back conditions to consider only anonymous
  memory
. Fixed missing some variable name changes in intermediary patches.
. Modify the error message given when an error is injected to report
  the case of a large page
. use snprintf() to generate this message
. Adding this same type of message in the ARM case too

v4->v5:
. Updated commit messages (for patches 1, 5 and 6)
. Fixed comment typo of patch 2
. Changed the fall back function parameters to match the
  ram_block_discard_range() function.
. Removed the unused case of remapping a file in this function
. add the assert(block->fd < 0) in this function too
. I merged my patch 7 with your patch 6 (we only have 6 patches now)

v5->v6:
. don't align down ram_addr on kvm_hwpoison_page_add() but create
  a new entry for each subpage reported as poisoned
. introduce similar messages about memory error as discard_range()
. introduce a function to retrieve more information about a RAMBlock
  experiencing an error than just its associated page size
. file offset as an uint64_t instead of a ram_addr_t
. changed ownership of patch 6/6

v6->v7:
. change the block location information collection function name to
  qemu_ram_block_info_from_addr()
. display the fd_offset value only when dealing with a file backend
  in kvm_hwpoison_page_add() and qemu_ram_remap()
. better placed offset alignment computation
. two empty separation lines missing

v7->v8:
. shrinking the code to only fix the main bug with memory recovery
. the 'else' statement mistakenly removed is back in patch 2/3
. all the remap notification mechanism is removed, including
  prealloc hooks on remap
. no more memory error message specifically informing of a large
  page being impacted by a memory failure

This code is scripts/checkpatch.pl clean
'make check' runs clean on both x86 and ARM.


William Roche (3):
  system/physmem: handle hugetlb correctly in qemu_ram_remap()
  system/physmem: poisoned memory discard on reboot
  target/arm/kvm: Report memory errors injection

 accel/kvm/kvm-all.c       |  2 +-
 include/exec/cpu-common.h |  2 +-
 system/physmem.c          | 85 +++++++++++++++++++++++++++------------
 target/arm/kvm.c          |  3 ++
 4 files changed, 65 insertions(+), 27 deletions(-)

-- 
2.43.5


