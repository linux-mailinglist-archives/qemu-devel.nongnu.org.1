Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD6C9F1F1D
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Dec 2024 14:46:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMSTV-0007hf-RS; Sat, 14 Dec 2024 08:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tMSTO-0007h7-43; Sat, 14 Dec 2024 08:46:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tMSTI-0002ll-Ii; Sat, 14 Dec 2024 08:46:21 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEAwEQD025593;
 Sat, 14 Dec 2024 13:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=D6njwfVDxDhYFFDjxoyIbiLbxpAhu2aeoLrNdWp/R2o=; b=
 BFYE2DZpIFMTNeaMR+PdKm7zvMG0pIrbsO0RlAW7IK1/BUSm5CEE8S8dU1Vjvvs4
 cSaMD524L35ud5Bd8cfCR0hV9akTWTHY97pX6MpVex3K2smrFyliV8QgO7cPbPTC
 MQ749FvhKdlBowQJchRFnJv5iJzOXp7qTSJ0M4qFmzDQfjWhTV/eGl00YtFgrnLl
 S2MOrrjrAtzveaDnn+Bet4GX4P+cbUB+5eS3X7/mzC+/mMizLraf2yXMMp+msZlo
 KDtYBaFxbwt97fGB7+vqKPOE9qZ18vGzKyUbhPuwp1hK0OwIrjC+szLjJlSCcOFO
 vjG4vpTBZLDQA6CYf3ro7A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec0gu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Dec 2024 13:46:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BE9bCIP011038; Sat, 14 Dec 2024 13:46:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f5jx7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Dec 2024 13:46:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRvOvhqcRpnc5rwmyNHseybDSat6qr0eonWuAmCfWzSXfYCxWXvyoiK8y4rmJjaNQOqvUyFlwqXtwuAl8W1Y4Ml2DMhIwDmZlhmuI72Qg0gjBlxAm1pnhJmy6X3m88Rtr39UQYlJ5XFCL2caBMfYm7PrGv5YLNGxr+K4S597ZfQeTh93YLv8/PDFgw5UWM3z5Pvlo13FPOYi+NFKw1SaUVg/jQfEsNvBCUSUdcCy52Gi7Rvo55vsfLSHOX7nuuV+RKH5E9o7ePUrPicTG4ULuOIg1K8garXprNJ+M/oZucZ4DJvqkGMxJfdMPfrqyAwOUaoHMPWTAfxzC7GQyisPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6njwfVDxDhYFFDjxoyIbiLbxpAhu2aeoLrNdWp/R2o=;
 b=EaJaYo/o25tjWa+LupJqRbvyK27DycGLP9Kx7NATQSDw+KcvAGZ3rRUq41FlkNVypFEV9Wa2XoRFEekFlEBm0mE46PNhgk+P8I3Gpuiq3HLjovG2RMYsMCrdKbARSYOdccwjRfDyH1LkTpkAojS542Ck4pHETVLQLi5Oa099DU+Cl/1/hqh/oYPgItLMU5Mw/lF62Ih7ilL1grlfIYCPYmHJ426coECzCHRLH845PFR3awEDg3Viu0vuljHZVC85bIdatTp/W/MyRZmn1JfVw2jcAQMFYNRJr0BKeHt9SYPbnASZSbmWnyMEJ3giH3uIVQVQpyxe1S7A+Z8P98U6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6njwfVDxDhYFFDjxoyIbiLbxpAhu2aeoLrNdWp/R2o=;
 b=K9BNOeGEQRbA/668W8CxgoYlvEo5yycCOXz7cx+32Ty+OzhDtNPx8pymWbuxtq526Jlqitvg6+yxu986qPM7uRCw9BslLv9miuxYqOjdj/36r3dNf1KbdO4g3nzkB556Df4zCGvKJzy9ZnHPAv7h3Fsr+sFgxGU3W1I91aHk17s=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5624.namprd10.prod.outlook.com (2603:10b6:806:20b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Sat, 14 Dec
 2024 13:45:59 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8251.015; Sat, 14 Dec 2024
 13:45:59 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: william.roche@oracle.com, peterx@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v4 1/7] hwpoison_page_list and qemu_ram_remap are based on
 pages
Date: Sat, 14 Dec 2024 13:45:49 +0000
Message-ID: <20241214134555.440097-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241214134555.440097-1-william.roche@oracle.com>
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20241214134555.440097-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::23) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: ade26d55-d98b-4939-077a-08dd1c45a46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u19TGTSrNgW/rkr/tRzzQQVS/wHpX9te7N73NRa9cllRwUdtk6JS4mF8++bu?=
 =?us-ascii?Q?JHCo9yUW700j0nCByn0qPtEqSrI8qVgqJXDTDSnpfoeBNthCUaZMJ8LIEfoj?=
 =?us-ascii?Q?4jCTAOyxd0pBLYOic7zaX5tapiOZbgBp1XnFj64Dg2pht2pFidA7FsixyGEl?=
 =?us-ascii?Q?HVdMedi7BEoyQ17IZj8JlbB9GQhC3jcLip3jKhkJJjoCMQtkQ910hWz0h3T5?=
 =?us-ascii?Q?Juscl/soB0quL6SL0VrLKR/IOiBVkdUPiLImMYMWAx0i/YJa4iLmjMeJaO3U?=
 =?us-ascii?Q?uXNjZjQ1rVyaRjtEffSjJNaLoy623O0fmdLbUNHb7khXni38o+YDRsOiic4o?=
 =?us-ascii?Q?9u0C5Q3ug2kK3XVI4DxqdXN7q33ZgYFYqO+zidjM465N21VcQwnJ4voHNvGt?=
 =?us-ascii?Q?98ZpmLWlxIRYFc0s/1XEHhXrEGVV/yC7aCmpEdD7YkD7BqaCPbXZp+Z7QRgc?=
 =?us-ascii?Q?PDTHhbsNOGKgqnXc174xdmY37jDHykW/QUPDSGndgT0rheOE4E2bmKA0eIL+?=
 =?us-ascii?Q?qn8mKg4HUQ8pcfpShSdm+jeVPNJPzNx8qtbDpkBq3n+qHOKCsdiY1R8xNVvd?=
 =?us-ascii?Q?TNqEhKMuwgv9XgVkwhVdsaBRiFLkmDFvR6y7eu+m93yu0WwMPPWZKMxCecMc?=
 =?us-ascii?Q?K/old5K+MHcY85Ao8k2NSoK1hJYCdN7xlxWHmzLK/tafQUgDub/JwvmgeYUG?=
 =?us-ascii?Q?iISE3x25bTDTXZOJURdERiEsQWb2YcyQxHaEKXCi3C8opA/clS2enLzFSMBW?=
 =?us-ascii?Q?9dxoc9OrHrtiX4HlzrWtSsuJGf5xqlVQZEKZ08JB/HVYIZmoA3vrCqTCBMYo?=
 =?us-ascii?Q?gOTTuJ+pgpawTwKZ0QtQdsgdB/vy5GsZhe1sEyKF/Zi2aYp76hCepBylqwX7?=
 =?us-ascii?Q?y721He0R5IiYKeFkvzCExgHu5qngUsxT/k/m21lYrP9kH7A6j7X+HuLnDJV9?=
 =?us-ascii?Q?0FxU8ZDZQzf9uaII+0r+ePV8vxFosE1JOPy52sdG+pTINu6HEnACUtOjz+bW?=
 =?us-ascii?Q?dzeKyX5pWzBu1iAvzXXgQdRWmzUrE/+oCdGFY0J71GygrNZY6+GpB7D7PSyI?=
 =?us-ascii?Q?SGKbBbq1ng8YDEo5I0eefii2TF4wPPnB+uFQFUSmxSIudjEsB3aUUzGWc/AD?=
 =?us-ascii?Q?nzBxa2u40PpmBYrdF6xV45iUyUQB7Um6ZUhRg0aHfRYJwFCvpnKvEQF0Xb5+?=
 =?us-ascii?Q?ZftfyvhKY+AAV4cigc0UcsCVRRl2K2t+M3pOaWPz5wxG7auIPy7CTLMHZ5oN?=
 =?us-ascii?Q?Y1p1HgmS7nwS0nWHtWe63hB5tFSS5Hy4nLEY/oe5Sno1/aQd3h3njtRlvniv?=
 =?us-ascii?Q?3M9yIteLiU4hTN0HUYKHs5h5YbhFY8gKi2FxNzvh2xPbFQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NrOTnPeFOVKgkeOI+9s4XJBgV84yRFskBkJEVBqHzkuOd60pdiQaeC6AmoXU?=
 =?us-ascii?Q?fQz6nPbsE2x1kKP9BAKFGjDNKWt6E24P+SJc5Ir4onkGTqgMzqM7nScgUu5F?=
 =?us-ascii?Q?ENJekM9nWkKctFigLKT4CBp4nfli6m5MJk2qCG2YTe//IgbsP02CRFldrdr3?=
 =?us-ascii?Q?ymgjLfyXh6iniOlyEmAwbu3yChB0rJ/MlAl18CswM4oacXvhpQbvDQJhKMdM?=
 =?us-ascii?Q?aSrCtU9yHJX2bVrPregSaHZS2BJEd0dUcbNUmrMjUpNzzuaJVZBCrbKTTTCN?=
 =?us-ascii?Q?xVfR0wbuSVzel79lUJN0csRXqo0qdTkbUGXJLUlGJelDuSRGL7O/cZSIIQb7?=
 =?us-ascii?Q?9LCmOHxyjfz5Kp3fkyYPz3tNN/0f1lgiQKp9tjmyucSxjvddzbqKzhm5XTXs?=
 =?us-ascii?Q?jiU90Ue4wVADz2ngoi2+OqJxH5p2R03QNikt3twWeftcO3ryoCCcrFoYE9Nd?=
 =?us-ascii?Q?rRKoMnDQ+7XD6zr6GtkHmc6qxrQeQL/88wkZ0WgEEisPmkFXI7kOTn2r9f8/?=
 =?us-ascii?Q?xiGl0J+/wB1B//tpHBzY6k2c4E0htOt/1JKtNngtVgWofG153SCp/9HcfR0A?=
 =?us-ascii?Q?OPu+1MWIbFcqr2KjJs7+nMkLUgpqZxFM2BwIXl/on0EQy9pbbPN4O1/iVcFt?=
 =?us-ascii?Q?pO1qxu5FnyXXMFJhOIVa5dLNO0964DxTMqYBsrSGyDrDNzuqxpr6HjG8OvvE?=
 =?us-ascii?Q?vyCrrSsjhCmRY5BiqrGMkWoT2UOjbJIZg2NLeU2E2Vvb1pSjbGBdABCGDcE5?=
 =?us-ascii?Q?Qo8U0Sd3sWuVl1h1bT1Oldi/DnA5CatthDpOzGvoQZgYiQxIEHrIHCTCOAnI?=
 =?us-ascii?Q?m058c5uYA+wfioNwnhcdEFUqtKxomdtoQGoiRd7FZ7YmngHISg+iMQnMnikl?=
 =?us-ascii?Q?60siXCPL3n5MKrGmpUhmJERZItre8GJrzNLGzQ1UZpHiFGRl5lghTtTjViJ9?=
 =?us-ascii?Q?jok2xect/cEPnXNwvwggVfjGdveqOlpS1zHlU/iCyHsNht6jDtzQvUe4MuYU?=
 =?us-ascii?Q?vySIEFTXoXi71oyDFC2WqzlpTOQYBn6gpiuDKz9n8D8hVkrZZHccTpRgkDK/?=
 =?us-ascii?Q?LbXbsaskVSY7i0TFal1EpImLLdc7NNiAYFNZUqHpPAipjQnWp4kkr1UhtHUn?=
 =?us-ascii?Q?2hna86WmaZXOhnbBK4Ky98MLV3NFePpi6ZOb/yOfHyZNhtsX9JnPL2EyWxXe?=
 =?us-ascii?Q?nY0JwhniPFp6fAGptezzX7KDDxL5P9OoLVgRhIEXjmjtM09C8PUmot3KGqhB?=
 =?us-ascii?Q?zKKElVT8fzHMUirnxIj925JF7MMT+K43NE1VS3Ld6F+GxGx4DQRtF6r5CT4i?=
 =?us-ascii?Q?9P05dUOCafy0J1KaROwETB1vjCrVONBy+iWSDVccXmzVNBViKhati3jfSKj5?=
 =?us-ascii?Q?A/Sf88aXfPm/flAuQ26So1DSVqmSr7s4zIkoPpYVkbQ34u8jpw/NYTd/qH9F?=
 =?us-ascii?Q?LLOkWEeEs5VrGPNI7kfxI/J7fh+eB0rbAPuLF7KLksPfSHWPUquYH+WALC3X?=
 =?us-ascii?Q?hdl1CcjuiI30QLMLPpv3raT+RyttEp1lHarsDihR6IKC8bg9I1aKzmA7kspC?=
 =?us-ascii?Q?2vdeFwGYLEblm2yf6S1X/V1Qu5nfUz3fnbNlJg8b8gJfv/3kj07d7F4rEOpZ?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zUSdPcZkCJ+Nl46aT/pi8UTGwIuyd9uErlVOaFOywFLpJAdG5ia55TRVNucIjrNxfgnRv18J2I9aMiog3VsKOO7SokDMOBCxTw6ZvasWSAEgfHCuX3fuod1AWX94XgZvFHRMapMDhigO0mxvUz54RzBDLnQ2UDOq0w8WdqgQYoRiv6ZuHejeGZHDPpUShFr7m/VNtti146ILndYi7MKbYffRXSpUpIO8PVhoEr6eiesogXk7kk2q2B1uPpEWCwfRveK9ypqLhmQ7AjgTRndmXwoaqvXyGHp4aqDVqpKjTBN5y0ehQw/HLtnsmCb5LpkCD2hnPQZmeSAkCXoStYr4aF7SSMrAQUq4qv6LnTePic02F8YMddJzZv0ZqgvHaZ8cJDbUPM7ZJPSDT3IvptslVleNFEk7/gK+keai40DCfQZLY7mCi9V+wD0iwIAd8tNkP8GGCDyKZzNNb/mo8cKo+FQlY/SX9qgOiHGabcFsrsEUp/gSrzbL0/SibLi86zviJPb0I5NcbV5hJV1kQ1V0RHhCkIPVH6YUckNsV7thVWoIfb+FmxYfWau+beZEc7PyMV2sADVxlCXf8wOuvOQ0KjM2Q0iAGEH2PXNkuLsojbI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade26d55-d98b-4939-077a-08dd1c45a46c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 13:45:59.5183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tA671FqcUndgkeGfkQONgZEikCvimqhhC0foRtW02Nw77v3FHgntFRN73JtxedaWWURotakzurliPTf7wyqOJwKfqaA63J1Ywmxmh/8zmuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-14_05,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412140112
X-Proofpoint-GUID: -esaKWJxFPL6xg6gjw9-wb67M9jygvJj
X-Proofpoint-ORIG-GUID: -esaKWJxFPL6xg6gjw9-wb67M9jygvJj
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The list of hwpoison pages used to remap the memory on reset
is based on the backend real page size. When dealing with
hugepages, we create a single entry for the entire page.

Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c       |  6 +++++-
 include/exec/cpu-common.h |  3 ++-
 system/physmem.c          | 32 ++++++++++++++++++++++++++------
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 801cff16a5..24c0c4ce3f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1278,7 +1278,7 @@ static void kvm_unpoison_all(void *param)
 
     QLIST_FOREACH_SAFE(page, &hwpoison_page_list, list, next_page) {
         QLIST_REMOVE(page, list);
-        qemu_ram_remap(page->ram_addr, TARGET_PAGE_SIZE);
+        qemu_ram_remap(page->ram_addr);
         g_free(page);
     }
 }
@@ -1286,6 +1286,10 @@ static void kvm_unpoison_all(void *param)
 void kvm_hwpoison_page_add(ram_addr_t ram_addr)
 {
     HWPoisonPage *page;
+    size_t page_size = qemu_ram_pagesize_from_addr(ram_addr);
+
+    if (page_size > TARGET_PAGE_SIZE)
+        ram_addr = QEMU_ALIGN_DOWN(ram_addr, page_size);
 
     QLIST_FOREACH(page, &hwpoison_page_list, list) {
         if (page->ram_addr == ram_addr) {
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 638dc806a5..59fbb324fa 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -67,7 +67,7 @@ typedef uintptr_t ram_addr_t;
 
 /* memory API */
 
-void qemu_ram_remap(ram_addr_t addr, ram_addr_t length);
+void qemu_ram_remap(ram_addr_t addr);
 /* This should not be used by devices.  */
 ram_addr_t qemu_ram_addr_from_host(void *ptr);
 ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr);
@@ -108,6 +108,7 @@ bool qemu_ram_is_named_file(RAMBlock *rb);
 int qemu_ram_get_fd(RAMBlock *rb);
 
 size_t qemu_ram_pagesize(RAMBlock *block);
+size_t qemu_ram_pagesize_from_addr(ram_addr_t addr);
 size_t qemu_ram_pagesize_largest(void);
 
 /**
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..2c90cc2d78 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1665,6 +1665,19 @@ size_t qemu_ram_pagesize(RAMBlock *rb)
     return rb->page_size;
 }
 
+/* Return backend real page size used for the given ram_addr */
+size_t qemu_ram_pagesize_from_addr(ram_addr_t addr)
+{
+    RAMBlock *rb;
+
+    RCU_READ_LOCK_GUARD();
+    rb =  qemu_get_ram_block(addr);
+    if (!rb) {
+        return TARGET_PAGE_SIZE;
+    }
+    return qemu_ram_pagesize(rb);
+}
+
 /* Returns the largest size of page in use */
 size_t qemu_ram_pagesize_largest(void)
 {
@@ -2167,17 +2180,22 @@ void qemu_ram_free(RAMBlock *block)
 }
 
 #ifndef _WIN32
-void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
+void qemu_ram_remap(ram_addr_t addr)
 {
     RAMBlock *block;
     ram_addr_t offset;
     int flags;
     void *area, *vaddr;
     int prot;
+    size_t page_size;
 
     RAMBLOCK_FOREACH(block) {
         offset = addr - block->offset;
         if (offset < block->max_length) {
+            /* Respect the pagesize of our RAMBlock */
+            page_size = qemu_ram_pagesize(block);
+            offset = QEMU_ALIGN_DOWN(offset, page_size);
+
             vaddr = ramblock_ptr(block, offset);
             if (block->flags & RAM_PREALLOC) {
                 ;
@@ -2191,21 +2209,23 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
                 prot = PROT_READ;
                 prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
                 if (block->fd >= 0) {
-                    area = mmap(vaddr, length, prot, flags, block->fd,
+                    area = mmap(vaddr, page_size, prot, flags, block->fd,
                                 offset + block->fd_offset);
                 } else {
                     flags |= MAP_ANONYMOUS;
-                    area = mmap(vaddr, length, prot, flags, -1, 0);
+                    area = mmap(vaddr, page_size, prot, flags, -1, 0);
                 }
                 if (area != vaddr) {
                     error_report("Could not remap addr: "
                                  RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
-                                 length, addr);
+                                 page_size, addr);
                     exit(1);
                 }
-                memory_try_enable_merging(vaddr, length);
-                qemu_ram_setup_dump(vaddr, length);
+                memory_try_enable_merging(vaddr, page_size);
+                qemu_ram_setup_dump(vaddr, page_size);
             }
+
+            break;
         }
     }
 }
-- 
2.43.5


