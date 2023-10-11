Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB57C5B88
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 20:45:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeC5-0006aY-9F; Wed, 11 Oct 2023 14:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qqeBo-0006Yl-10
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:44:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qqeBk-0003A5-8l
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:44:11 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BI2Mu0006332; Wed, 11 Oct 2023 18:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=4t3GGSb4WE4bZgkNUSXmenibCD5Zm11zJqQvifaFiDs=;
 b=F5ZA3Gtx+9yPiChbqylNVjbh0OPLEAfrgnRBfhVa63p/GU7K+DNKy5QuiY+3DFzuv/km
 Gh90zKN5zgbqQM7D3WxuvOaqoXVC6gM46hzlPRNX3gGU0LwPRDZa6qiLJszZ1xbOa9ni
 BSOQ+iZHnu7IKwbxZTKxVnoq+MGVJEL87lz2S2KVOaUcGD5K12N4N75zoYi+09P4rYrd
 gf13OeAW4aoDPGgmj/ZQKOCyCCUJvjY1cduDuMOBIIBXvzzWRhr0x01aN/aTRyy0k++b
 pEGZswu9IkuIgqPhTYpgsu9Me42PVtQP+O/Yky+zJAmcPMOvl39tv3Tacn3MrFqV4pFf Yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxu91ay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 18:44:05 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39BIETAT018081; Wed, 11 Oct 2023 18:44:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tjwsesxfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 18:44:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL/rS3bTzV+pP8jVklr+nN/CVUHRPQMheABQO5RhiZ1Szevh7WJk9DUHVzzut0AG+R5Enmt3vqx6ZuqJmVjaqCWGYwM7zpfDeW6LNiaycf076pFEmyWkFQ8xELrgyZNddnBnDC2LQnlz0k5J8V1LyqxVvfEm3Gq7InQ9+UzhLSW0yPM/ATxwsaitWfGYkMvP0OUh1h+Lt7IkxvgsxA0VwLmgLUSDATlKGDmvuVV+SmXkHaeVtW1PBX3tBK8dWG7ht1o7UOR3qpDCw7iHmYfdkYwH4eTywIiKx7TPN4fMDmKXC70oiKEy9Ot7HiQTatDDXAQscvhPl/3XYnEjJF3FUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t3GGSb4WE4bZgkNUSXmenibCD5Zm11zJqQvifaFiDs=;
 b=bOLk8TrgX8x86ZAgqdpocNoUeew23KPW9eXHeZtW5iRtrwm0DmMQhYFNuF//K1M8ugy/d3MamOlQhRH2fztHxd2tUGGKVvJdaKa6oax+YFV4j84znt+OPKk6DnzvvyRcJtTFo9OoGFY3lbI2oteCj5pcTXUp3rPD6huvlceORX+sa7XfUeFjbmM/h0vllkNQSerbHP7QWL8XVd2ixRe8opfW58ULpk9ji57dSaAdCtkf7R4efFktEWjuRJzkIIHzIsdX1IQKkSFradmaI0UJXr3MIDA18fbnKNL3y4PXbNFp2dfQL9VQIjZEoo+NuAfCJh5umd1iGK7tCMgGKVTjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t3GGSb4WE4bZgkNUSXmenibCD5Zm11zJqQvifaFiDs=;
 b=pJEumhDuQLvRKfig1gg3r5XrXb6CJ6J14m+K+hyoV4JIFLnS4mscZFmzH4cvLsii2umXWzcZMtHkhLxeooUXUOUoKSBOcNASedPx7Iv49BmIXR0LPUDNG8b/oN/EAd7hp8jfSydXyt3TTxkCpQKa/8TCWdX9AhvRrLHmH877Q/U=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Wed, 11 Oct
 2023 18:44:02 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 18:44:02 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: 
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de,
 leobras@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] migration: check for rate_limit_max for
 RATE_LIMIT_DISABLED
Date: Wed, 11 Oct 2023 11:43:55 -0700
Message-Id: <20231011184358.97349-2-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
References: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e07e62-5f5c-496e-ea49-08dbca8a09eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfYFzLujDbLOLmLQ9GDGejSf/EToUm6Mrhj8b8f1jGtEdUDKZB+Z/VPTjiaiwMUE1fBzJzSsebwm5/ECacIGGp5hedEqek21W6MHZ7GMvWc7BF/pgPbKfPh8B3JAH/Veaz1g8UALGq+axSkwz57rWlGf9s3t9rHCD59zoEN3EomY8+qUtFYUANcG+6KFAzzPTrF042QBx6cw23rrJTLJJr960e5qt4pjWmIwT9GlJpx+BnkKi6UqJdaoSjTC1/BOUNYvArfmXL0KaxV7HJfsM5OVBokKOxda1xPzk4xONYwMs2NV4cnHeq+Pf17KtL1r9snFmsOSt1xIZww2KmEsLN7esrej70PaP5ZWSl5SyfiBjI7hkg/bnokOoNiRa3Inn1UPgIeUvwcsMGcMd23yjt0ocThXRE6P9FkhUjBC1X0M8DcoEXBwbOtYonjCv4g57t7bguZy7h3EqPPeiEVsKHqBJVW2ik5HkseX33Ep2lU+Kt8P+dAIv16LnKoiBHOSt2vRBhEWQmns06pAdgwS8YJqzvoRIE2Q/fw+bR16OibQdfEKhZdIuehCsX7AEtpmUjbG0nn6JINM3ERO8e1inkEjQhAz2PzO4rYFA+QDQo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(109986022)(451199024)(1800799009)(64100799003)(186009)(4326008)(6666004)(1076003)(8676002)(6512007)(38100700002)(36756003)(86362001)(8936002)(2616005)(6486002)(6506007)(83380400001)(66946007)(478600001)(2906002)(41300700001)(5660300002)(316002)(66476007)(66556008)(44832011)(266003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G8tCeL6bPhYY98k9yf/iG5Mu4Uqs3woS7ThHrH8XVHe4TOLvAzF/kdNDl0JT?=
 =?us-ascii?Q?1UGe0V8Qd+lg6DQBMPXip1tQZpH3whEaYb3llx9tH7SFs6Orc98+jBlbwKYQ?=
 =?us-ascii?Q?n57CmjIXWVNJUC53B2X7wVrMYbt640Lqav8+YbvLgxM4tnuw4VmRHM2TxmEY?=
 =?us-ascii?Q?S6E7atTROB6N1QojROuhMyL8m5afyBPpRr9OD+EJfcd2fXg4rT2U4n0pU9Cc?=
 =?us-ascii?Q?WLRyey1hmldIfjZ/g0FZmQ6DAsaCPhqwbrW8BoV8k5kVFwCG/wvxYjxPrA5i?=
 =?us-ascii?Q?KaT1rZzJkEGHmNoWufRtSLofBzqOydy7ddHG08dpjoI57T1CHzVPnYXCCgH5?=
 =?us-ascii?Q?ujs7ehcBHF+JQeVCQX2DXhoeucNumA3o5/BgTHwBwNS1yOjwMmhxxk+8porW?=
 =?us-ascii?Q?DvpjopLvBhwb0OV6QOMbp9CLPwil71b1mArccK1uwM24BeK16DKie5CQlpfR?=
 =?us-ascii?Q?IVdF12053uUAOfZ+pHY5OK1jUQy+Od/z+VmKArOGMPJOS4DHIhi0bqxV67HT?=
 =?us-ascii?Q?kkJ4+CcJp7R9gyaRYunP8waSLkOMrWfwHPYuxPV6SMiF3Vfb3BLANbQ4Dtck?=
 =?us-ascii?Q?gqaRw+0BmW4u5KaivWPFVlrTlVwq9sn3FzBYLBgNOz1PE4YFSLb+wUwpaZbc?=
 =?us-ascii?Q?91qtJOQ3/1W/l316tMYB12LpaLyxAPWNmvu6qRw7GwXrNKZ3WJAGFmN1V61w?=
 =?us-ascii?Q?pxbIG8xFSBG8X1CoiLs24cVVxNNXeB3f19lX3gxp5vhx+ayiWN6TovBDVz16?=
 =?us-ascii?Q?DYZ/PpXCGL4r9DLZHaYN1jzollWDPW8CWPFojO5sFJ02OxM6YTO28dBYsTfo?=
 =?us-ascii?Q?PwofnNW2U/W9kn4icsy3t30A5/HgNGX4bSFaN2tigl5nMrR+rtJqiaFKBS8u?=
 =?us-ascii?Q?6S/gNS/FGjZmNlU/2LQ0Y+K1GZUYY8Nsrr1+4sjKz/pZegXgwyFtWksynVIQ?=
 =?us-ascii?Q?BNDDyV1fTBU8JwzGfTDWPSPn0GMB2gejrwFCx920u7IqZMMVJ6CyLEcsvR1z?=
 =?us-ascii?Q?Tm1jwJif1a77Vida2cph9Hcif/uS0Uy/hZuo4GBwBQimYAfayvlGZaUAVLSm?=
 =?us-ascii?Q?2s5CwkUjbzrmAP1ONOZPNpfpXUYl9gZazUuoarxfst5ZLm2idZsmHwgg/60t?=
 =?us-ascii?Q?ya1o3r1pxT/njuFQV5bS8ruMG7r9j3Zvm6qbrr250Uw69IgGnty7oo3aAZ+Z?=
 =?us-ascii?Q?i4zW5NtMMMJvdqx3+K/V2TojOQ2Y8GdrGfBwiRv0Kis1nSG3XhttHHVdqAzt?=
 =?us-ascii?Q?GpTE2EVIGDDgiksWS3KwWzSn3ubYJaARo9q5AqcHlXlOTG01dedw92DKdZQ6?=
 =?us-ascii?Q?p4ylvybIlg0KaX7Jr5nxPdsqlyxv06gx9TEK1QCTRDuCFKIbAKee9NcoxIs9?=
 =?us-ascii?Q?8PJT/xTu0fgo7LgEIhqxkF8YNguR2lFakcdc02/ApQutwzajn96fsN8Yi0xl?=
 =?us-ascii?Q?uqi7oAt4OTRHPf10zq40mKS61xzW6nB4PdyTX/T7QteF5mrtn6SJTY0axlkM?=
 =?us-ascii?Q?EUcImJMZyjwmTb+157q6frnV7vcNJQoW3ncPFqy0Xdrt10cx0jhj7X5r4GQH?=
 =?us-ascii?Q?lnt/oFn6n5BvfspSI2R9Z2GEhglhXCRr30JjnAfA+AP/5uLpm9u7TMy7uOMv?=
 =?us-ascii?Q?EE+JdsUnJIzQ1WYppfARDq1zottdIJtbvC+OdBSFiDgLNV5IpXr6MZUinT6i?=
 =?us-ascii?Q?c+F1kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MpfVRQ3VVbNUB7mXo+q1O3GA4F+nIhVQf+rXT5V+QIOfwqW1ZtxjIaF1nCZ7+wLXA6BmvLTXQZEohChM3FyK6dV+wBhVmwRQFRuTtPTnG5ISRPlQklY9Il/SGPjnbS4u7iTQjmcQuOvsCIVDxsIEDewMccMGKdtFfwfDlkNx9WuztgBF6IXQUt5Ip/cECJ/ln0yn1T+XRYzCT+RzpSCg1l8YSGpGVbnV0DCs5OcQu0SSbxcZgCnZrtnxg9TqQ+79zCaYDdmQ5MeTctp7Fx21IOnh12C/QeVf2rXLtJMEk6G2a1HMdu1SRiQKRq8LIYogb1wg28s20nLuALjo+nVMYgaGxDl2JhwZCFQ/pEMM5eOl1xBof0EoP3jJoqk1BDuGHFWCwHzRKBc1l/YGLZ0MHnS2//j0AzpgzpiF44Zx64HBT+/96IQQSgUoEsYRYkc4XuBNqy9xiK8IfLVvmZ2bf4Fs4lPXSSdPpLZv0R6LfgrvahrHvyyv3FvjwS8Gzoujn4tr/8kWtK0AnXsHqUIL2A5kDlxuLwFMJuGhV4kzxvLLdo7XwfofmW6EQPcP9Y+8yCpjSplSLR6Mmch9HhvVGjNsDf/YvKsMFSTQXx6aC66KQj/q9Oxnp7fX0Bl/C3dbVuhBAbQxpwtzAgPzmWBU+x8q2PdMqnz0MS+jMK1NfhBonXA1A1lIlDnfJykpZypwpK2Y4F1v7+FGh1iDhaAsSK7NusT+Ub6zHSCeLSejids9q37nRdB/DWGtsTt/ma47h2g9wbCQ9YTpsryk0SsCVlplOFQmzV55WjeAXrYy8G8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e07e62-5f5c-496e-ea49-08dbca8a09eb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:44:02.5069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZe5cwx56WAMedIpD8ejYlul8tIhrpcVMmqaKihleOPR70vUtmnNS8+oougGDMXqJtnNIhCAw8kEE15hXDR+qcJIFGvtMdtgkPHB2m3lKrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_13,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110166
X-Proofpoint-GUID: D4M5pQOQLBdevOzIeSVLjeKJc8GsSnp-
X-Proofpoint-ORIG-GUID: D4M5pQOQLBdevOzIeSVLjeKJc8GsSnp-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0b-00069f02.pphosted.com
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

In migration rate limiting atomic operations are used
to read the rate limit variables and transferred bytes and
they are expensive. Check first if rate_limit_max is equal
to RATE_LIMIT_DISABLED and return false immediately if so.

Note that with this patch we will also will stop flushing
by not calling qemu_fflush() from migration_transferred_bytes()
if the migration rate is not exceeded.
This should be fine since migration thread calls in the loop
migration_update_counters from migration_rate_limit() that
calls the migration_transferred_bytes() and flushes there.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-stats.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index 84e11e6dd8..4cc989d975 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -24,14 +24,15 @@ bool migration_rate_exceeded(QEMUFile *f)
         return true;
     }
 
+    uint64_t rate_limit_max = migration_rate_get();
+    if (rate_limit_max == RATE_LIMIT_DISABLED) {
+        return false;
+    }
+
     uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
     uint64_t rate_limit_current = migration_transferred_bytes(f);
     uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
-    uint64_t rate_limit_max = stat64_get(&mig_stats.rate_limit_max);
 
-    if (rate_limit_max == RATE_LIMIT_DISABLED) {
-        return false;
-    }
     if (rate_limit_max > 0 && rate_limit_used > rate_limit_max) {
         return true;
     }
-- 
2.34.1


