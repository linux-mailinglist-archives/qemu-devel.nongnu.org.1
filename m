Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB075696F
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:44:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRK3-00013I-S5; Mon, 17 Jul 2023 12:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qLRFe-0008IU-Ph
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:39:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qLRFb-0003fG-Q9
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:39:10 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36HF0l6Y017322; Mon, 17 Jul 2023 16:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=nTpgiftouM3xebDosMbu2H/IhWQQ7EYVZaJJzE7WnBI=;
 b=Io3BTc/vMnsNSXXrnumOlT3TXFN2sjAAp/KRq2zGBLTdZjadXwe9lQfj/9pO9B7CDXl3
 cX1XnLPJwqhUM9FkbaYCZghq+JJzLtGGsCHerZEkekKQi1njT2q1oO7XQR9uFjcyc0LU
 UALrDoPy35jWFe0eHZJRbl/HIle/u6qZa9/y5Lf55UnWQJhGYIh0y/5EJVluppTdUjty
 xORp3+d6eOoJECMWLblvfrpKMd2rWMPfCj1fvBDZcHCLCo+ZDO252F4fxW3dXY/kN6R4
 9cXDRipb+DXA/8sxmlm9sitSNg/swscnpQH2M1v7z4CNkwJfhDlRiUaTpYCZlUkiuyzj WA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run77u5m9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jul 2023 16:39:06 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36HGaCmi007768; Mon, 17 Jul 2023 16:39:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw3npn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jul 2023 16:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DswaZ2UvbSrAmJrwJtLTRafz1oFJt2j4Sqc12SFJwIrQgjetZrYIOP/mwUHdJJ5J0LLpxyZReM3LexCF75KMHvjf7ivYU8DhyprlpfbquTyWpwgW4Tq75sg62P99nN2bs+AGRzWomOMttlXkhpvaFAU0vx7Fs1GV+FY71yyLBk2OR/ibPUEarEGz4rG4zz/yPIG/9J6ushT9FjsgO+HjchuMP/DZFDnUPxPvkNhj7nxnZb/HPx1KIc3o8URMymX4v5XEADTcU6wakkhqJaHSiNrp8i/ilaTVrRmVfkNmGo9NJHx/2Rumd5t6J/n1fzKio+08n/CeBE87sGmxPGzIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTpgiftouM3xebDosMbu2H/IhWQQ7EYVZaJJzE7WnBI=;
 b=TcKCFMj4F0rCIXqRaB1NxD0wuV9n7i+75xFFmq9+ERKxIJ3fWXFZ6U2eOgr8PXSdyY5Sn/0kxTR44LzPPrYhKTsxmLA5BHZwqPGh84APTRc3RznG7ERkELMKQ1cFdMkt0RyBeduBnTyJQ3gdQJFzGJkdHTVmRKMic2bvL8uA4RQig1YFJ46VmOB8vOQwYP4yZSXhktz4JrbuDPnrEpiVE9WvtbIosHrB8aml8myZpQIed6oLKaFwGDeOnTMPtijtt+6b8gMLjTgy3Dqj0QA9h8rR+2lFoMCMiLhrNIv4UPqMuN8yfqFrR5rfYtkjs6QPHXKUrz7+L/gIqUm7Qtx9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTpgiftouM3xebDosMbu2H/IhWQQ7EYVZaJJzE7WnBI=;
 b=oEzxCCz5Cro5gRtI47bJ8G7cRLEFokVTWaDp01zDgY8ck7ev8+nT/K1z+dkHFuXwgA0LlmCA4j1FGNjvjx859au7RfOqmwEMyYEewpaZkA+Np6m5GueGLUmNbfpMnVNhHA5Hh0op7ZvcYfj2MR8xr0lgmMyQkLKAOMTrI/+lmvU=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CO1PR10MB4788.namprd10.prod.outlook.com (2603:10b6:303:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:39:02 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::c89f:f0e5:c5bd:aae5]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::c89f:f0e5:c5bd:aae5%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:39:01 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
 joao.m.martins@oracle.com
Subject: [PATCH qemu 1/2] dump: Pass DumpState to write_ functions
Date: Mon, 17 Jul 2023 09:38:54 -0700
Message-Id: <20230717163855.7383-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CO1PR10MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd00d3d-71a8-4a42-8455-08db86e45359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lilwdN/8LCIb4f9+Q/is6KFodTQhPg0BN6Uv6F6Q+4bbrvreG6dwV6+FgdPljcFh+5ZN25tFycAb1gi0jVIwyssIq1B4/OTjILsTuwExYS/FtPpftAt+ouB4GXFB7xwWl+jiJP98z+hOAshMDauu7Lnzug2nnnj80Bv1e0En5l2wzCjaFZTY/etG0MgqSvYH8K58lo9+9/ZdH/PJZ/xxZFWQi0g7sZFJuPOg7m6wQ6lxfc2ObFcYyVHwHTozOunItHypMCUofyFygoGsNdVTGmsWlsek9YN4llINRPWOfZYWW7+GJEfJpCXjv2YEDfifq0JsWiyoHRCYs8VLPCgK5CleTCPYxdsXkhDjmGDmSVhereZhZbFlSM6Nf3LACY1+BfedsESJnoqUxiX60ahbhIU98hVzZTQtfc9OTkitPhCvEQadqlEQQKanu0U+Aalv3eStJF+vUmSzKL2Fmg4l3y+bp9u0lXI157GsrFORxKyPlxHFIveTPi4PXsEc+zTeAH2tpcj+DD61newyhdNOS5YTVVFXcb3mwGm1zKm3Ssd1nSSJbpPKN1p6C26RID6Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(86362001)(2906002)(103116003)(36756003)(6512007)(186003)(83380400001)(6506007)(1076003)(107886003)(6486002)(6666004)(66556008)(66946007)(316002)(38100700002)(6916009)(4326008)(2616005)(66476007)(5660300002)(478600001)(8936002)(8676002)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ytGCo0OqNezEjg8pS7txJI51W42y9lHsV36BMaNUKTSVhw5vAGCEY0r+8Q/c?=
 =?us-ascii?Q?x4ifY8R+igwBOYczi2QJRfF+VT50IPGWR/rQAXtvClqskglGt1cRphQFUjqh?=
 =?us-ascii?Q?D8TA9BGWAbH360QSPOgh1xnoHzJ49L2SkHRZ+pBJEDF6C6GXwhuL+1GkBYVO?=
 =?us-ascii?Q?Y6mOl6fTRg4RnS+iDy+MYUI9i5Ufeu98fmKrjkKIz7Gsp64Kf7jhT5KDuiGY?=
 =?us-ascii?Q?AFXBTxuTycrHLjmu6agKU4LNqxls0WUKj6kikzdycwH56HmqSil7hCv5pTMq?=
 =?us-ascii?Q?E+2hDX/Q39ofC90dxQGJytGeK3yZBM2Cz84ECMvpKhvSUDRg+oF7PxcHvTh6?=
 =?us-ascii?Q?hjQHFS9xT8ZG6rskT0xvQfvc8EHG4LlqcCIIXeDFITklk2B9X3h68uOWycEy?=
 =?us-ascii?Q?ex/HyA6+H/ez/7rz8MiAcSexlaZhEAlUadRnwIbYH9ncJjwKkN68SdIklKhz?=
 =?us-ascii?Q?SGxBc06S/FimVlWCsn50r9Btb3b7HbPHYKqxFtPUAKWG6wdOT7kSmyZx7xc3?=
 =?us-ascii?Q?NRIVLTHD79brNmoAMKVe5gzc+984CE+Ax9hfHDMrzAnXtNZv7O63rq1aLPNR?=
 =?us-ascii?Q?JDe4R9bMWSd7blcB8dHfMonQ1PYomy2kuAAiaQCJvsNz+Vlhlkcc3GoSF22t?=
 =?us-ascii?Q?8aeL5Yl+uR7K+yorwK4r7B9gGxfKKn725GblRVZvWoAxpy1xr83GNaNaz70q?=
 =?us-ascii?Q?SBRcWbIZ+46ZIV4kHpUP1XTCPkt+BZpMaDWgTYPOqBE8bU0A799aVnIygjz2?=
 =?us-ascii?Q?PYZDycGmKwLLQKe+KSEobil552UGwqV7KKd6oqAyy2IC3P+PmEf5vcF3Sm41?=
 =?us-ascii?Q?3/9ScC0tQIVU1VRdB/hKybG621T/hguJPPusTNoJ6r1luYdHjpZSMsRqIXEO?=
 =?us-ascii?Q?TJdsAnDIaM9tfzhC4EC9L52scZCYn4M17mQ8ChuTiVIovr4V71oeOODk1blr?=
 =?us-ascii?Q?j2ycdxPvMzn4U0HvmysM2CM7LbYV66AquYaOXIFPbporyJ8mPV9SM5Whla/L?=
 =?us-ascii?Q?ggBVFUvea7C9sHTol090a6R/s0nuTxqNClgfI8LsbN7mvTYollsMZmZY/y6P?=
 =?us-ascii?Q?JZjwpAAmBezeSldNfJspEliIQAdqPeVx1ioIdxvLLwt5C4j8+LRFzZIKY4If?=
 =?us-ascii?Q?3YjTdFharpyGZ2fmznYWl1i9Xh64WXNUkWXxscmJAtFhh160gtUCX9veUxO3?=
 =?us-ascii?Q?HgQzoAEUKNs33DaG0HJVf0lVC61iP8CAFeAl5uRXCqRCaZmxAe2luT3HaurI?=
 =?us-ascii?Q?K8LBtDPRl2A8slr661snO2Zf/ADRtXnzf3ZM3EK3+gBuObQBnXhBCUpPLY6E?=
 =?us-ascii?Q?rJdI6UNKZzuEWBo8oxkytAVtb1C74ikamk3Vh08ntqWpCLZlqQl0vAQzryOH?=
 =?us-ascii?Q?vEYEyHBJt0yndd/TQ1vldjeAOXVQZZH1enDGLqSkAKFL4/F84XuOfpNEKTT3?=
 =?us-ascii?Q?VzpS81eAdtvPaJVDEkEI4Pg79yUxFqbCrp7Iqkb377zscd4C8h3UjVPPm3bD?=
 =?us-ascii?Q?Ti7vSy7T+aUi351bfm2GllPBbCAS0yceH/8jeJakyBf8N102dDIOfBX3bDgE?=
 =?us-ascii?Q?p7OqDwePWxH7mJx21P4oospMKenxdznOksB3TvqC/f41W4WxVHDmEXTmSBS5?=
 =?us-ascii?Q?JAwIJC+NmaoCzHwwXU1mwP4MF7xp7hJ3sg15o+OEIIId?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gHQJnjoQ5HZe4oILDyKmcgj1X+osUUNAy57cj3RzWvYs4ScAb0HG0eGIyOq9xuZ7gvdbZkq/jyqCYHerA9+O8ByEYTb+oGXfnZXY74ruHQZXWFNjCCvFpKelHgVn79O1JO8VFhMZsIjMUDbSkoJQAvx8miqw60ONH0nMdG/sNcgaKi6+5HLXuIvVTs6A5KomdsGXMf5GP3FUjACr77BH/8hOVk0WLVUmmQ+5isvzXf+GzD2dMWqAfYBhuKC/ivKWUWWpcdvUO6X2Vdhf+HcGcSpZrw0PRgCioxPdAp7qp9TT8SulKLKpi4OuojcEy4HY9fphNkhmsycnwmmqLadp/nW5d1RWYp3G6csAv/W005hUlWOx9Cg8wMm3WKUKovENVl5yNbPYFZEpmQkJnh2BGFnwXrOAMpJ4VXT3jMoASo3a7vuuqdme6m154FNOMpbg1TPx7rUe8sCOTWV9YqlIF31//x50Sgl+4Q7ybYn9IndcH5Aaw49J+zgd64MV0F3t5QZ9vad+HMbF12j8hVA1mgetEKJr2Bngg0QrF3x2CVbguPZSm6O9Wbgqcicr5dMwDBWllHz0IIistnFpvc2uyAUxypppMMN9ERML1e8INqDpSGVec4bRJrFdQllAsC0HhfSZ10RocKQ6Npngs2BAbmht3RSgj020T03KhvMAcsKy60cECwtZvAQQQiJmAUagy+CH+8ThUsKxr1a6iAyBmiCUz6TQ1VnMW/VZr9Yyy2tBGme68WLuNcOaqNrzv0P4ZSZCt0KW+lySGuLFcwL8iwznQaTBRGkrA4IJCqOIr2peNBSHMw15cXfPws9r/M2O
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd00d3d-71a8-4a42-8455-08db86e45359
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:39:01.5305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwuIaGN32agcbKkFKuSuyUnnQudv6VSGMdhSo+T1uiO9jgy0KMaTYSrZbJmirgVBdSlKXvu+QNI2Obc/h0mGJkg7FGZYd/iLmaXnQ76YAik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_13,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170153
X-Proofpoint-GUID: f-pI-6_ezkRS4FwvSiSJqpo5ZrVQgv4h
X-Proofpoint-ORIG-GUID: f-pI-6_ezkRS4FwvSiSJqpo5ZrVQgv4h
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Jul 2023 12:43:40 -0400
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

For the next patch, we need a reference to DumpState when writing data.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 dump/dump.c           | 40 ++++++++++++++++++++--------------------
 include/sysemu/dump.h |  2 +-
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 1f1a6edcab..2708ddc135 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -809,7 +809,7 @@ static void create_vmcore(DumpState *s, Error **errp)
     dump_end(s, errp);
 }
 
-static int write_start_flat_header(int fd)
+static int write_start_flat_header(DumpState *s)
 {
     MakedumpfileHeader *mh;
     int ret = 0;
@@ -824,7 +824,7 @@ static int write_start_flat_header(int fd)
     mh->version = cpu_to_be64(VERSION_FLAT_HEADER);
 
     size_t written_size;
-    written_size = qemu_write_full(fd, mh, MAX_SIZE_MDF_HEADER);
+    written_size = qemu_write_full(s->fd, mh, MAX_SIZE_MDF_HEADER);
     if (written_size != MAX_SIZE_MDF_HEADER) {
         ret = -1;
     }
@@ -833,7 +833,7 @@ static int write_start_flat_header(int fd)
     return ret;
 }
 
-static int write_end_flat_header(int fd)
+static int write_end_flat_header(DumpState *s)
 {
     MakedumpfileDataHeader mdh;
 
@@ -841,7 +841,7 @@ static int write_end_flat_header(int fd)
     mdh.buf_size = END_FLAG_FLAT_HEADER;
 
     size_t written_size;
-    written_size = qemu_write_full(fd, &mdh, sizeof(mdh));
+    written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
     if (written_size != sizeof(mdh)) {
         return -1;
     }
@@ -849,7 +849,7 @@ static int write_end_flat_header(int fd)
     return 0;
 }
 
-static int write_buffer(int fd, off_t offset, const void *buf, size_t size)
+static int write_buffer(DumpState *s, off_t offset, const void *buf, size_t size)
 {
     size_t written_size;
     MakedumpfileDataHeader mdh;
@@ -857,12 +857,12 @@ static int write_buffer(int fd, off_t offset, const void *buf, size_t size)
     mdh.offset = cpu_to_be64(offset);
     mdh.buf_size = cpu_to_be64(size);
 
-    written_size = qemu_write_full(fd, &mdh, sizeof(mdh));
+    written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
     if (written_size != sizeof(mdh)) {
         return -1;
     }
 
-    written_size = qemu_write_full(fd, buf, size);
+    written_size = qemu_write_full(s->fd, buf, size);
     if (written_size != size) {
         return -1;
     }
@@ -982,7 +982,7 @@ static void create_header32(DumpState *s, Error **errp)
 #endif
     dh->status = cpu_to_dump32(s, status);
 
-    if (write_buffer(s->fd, 0, dh, size) < 0) {
+    if (write_buffer(s, 0, dh, size) < 0) {
         error_setg(errp, "dump: failed to write disk dump header");
         goto out;
     }
@@ -1012,7 +1012,7 @@ static void create_header32(DumpState *s, Error **errp)
     kh->offset_note = cpu_to_dump64(s, offset_note);
     kh->note_size = cpu_to_dump32(s, s->note_size);
 
-    if (write_buffer(s->fd, DISKDUMP_HEADER_BLOCKS *
+    if (write_buffer(s, DISKDUMP_HEADER_BLOCKS *
                      block_size, kh, size) < 0) {
         error_setg(errp, "dump: failed to write kdump sub header");
         goto out;
@@ -1027,7 +1027,7 @@ static void create_header32(DumpState *s, Error **errp)
     if (*errp) {
         goto out;
     }
-    if (write_buffer(s->fd, offset_note, s->note_buf,
+    if (write_buffer(s, offset_note, s->note_buf,
                      s->note_size) < 0) {
         error_setg(errp, "dump: failed to write notes");
         goto out;
@@ -1093,7 +1093,7 @@ static void create_header64(DumpState *s, Error **errp)
 #endif
     dh->status = cpu_to_dump32(s, status);
 
-    if (write_buffer(s->fd, 0, dh, size) < 0) {
+    if (write_buffer(s, 0, dh, size) < 0) {
         error_setg(errp, "dump: failed to write disk dump header");
         goto out;
     }
@@ -1123,7 +1123,7 @@ static void create_header64(DumpState *s, Error **errp)
     kh->offset_note = cpu_to_dump64(s, offset_note);
     kh->note_size = cpu_to_dump64(s, s->note_size);
 
-    if (write_buffer(s->fd, DISKDUMP_HEADER_BLOCKS *
+    if (write_buffer(s, DISKDUMP_HEADER_BLOCKS *
                      block_size, kh, size) < 0) {
         error_setg(errp, "dump: failed to write kdump sub header");
         goto out;
@@ -1139,7 +1139,7 @@ static void create_header64(DumpState *s, Error **errp)
         goto out;
     }
 
-    if (write_buffer(s->fd, offset_note, s->note_buf,
+    if (write_buffer(s, offset_note, s->note_buf,
                      s->note_size) < 0) {
         error_setg(errp, "dump: failed to write notes");
         goto out;
@@ -1204,7 +1204,7 @@ static int set_dump_bitmap(uint64_t last_pfn, uint64_t pfn, bool value,
     while (old_offset < new_offset) {
         /* calculate the offset and write dump_bitmap */
         offset_bitmap1 = s->offset_dump_bitmap + old_offset;
-        if (write_buffer(s->fd, offset_bitmap1, buf,
+        if (write_buffer(s, offset_bitmap1, buf,
                          bitmap_bufsize) < 0) {
             return -1;
         }
@@ -1212,7 +1212,7 @@ static int set_dump_bitmap(uint64_t last_pfn, uint64_t pfn, bool value,
         /* dump level 1 is chosen, so 1st and 2nd bitmap are same */
         offset_bitmap2 = s->offset_dump_bitmap + s->len_dump_bitmap +
                          old_offset;
-        if (write_buffer(s->fd, offset_bitmap2, buf,
+        if (write_buffer(s, offset_bitmap2, buf,
                          bitmap_bufsize) < 0) {
             return -1;
         }
@@ -1380,7 +1380,7 @@ out:
 static void prepare_data_cache(DataCache *data_cache, DumpState *s,
                                off_t offset)
 {
-    data_cache->fd = s->fd;
+    data_cache->state = s;
     data_cache->data_size = 0;
     data_cache->buf_size = 4 * dump_bitmap_get_bufsize(s);
     data_cache->buf = g_malloc0(data_cache->buf_size);
@@ -1399,11 +1399,11 @@ static int write_cache(DataCache *dc, const void *buf, size_t size,
     /*
      * if flag_sync is set, synchronize data in dc->buf into vmcore.
      * otherwise check if the space is enough for caching data in buf, if not,
-     * write the data in dc->buf to dc->fd and reset dc->buf
+     * write the data in dc->buf to dc->state->fd and reset dc->buf
      */
     if ((!flag_sync && dc->data_size + size > dc->buf_size) ||
         (flag_sync && dc->data_size > 0)) {
-        if (write_buffer(dc->fd, dc->offset, dc->buf, dc->data_size) < 0) {
+        if (write_buffer(dc->state, dc->offset, dc->buf, dc->data_size) < 0) {
             return -1;
         }
 
@@ -1644,7 +1644,7 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
      *  +------------------------------------------+
      */
 
-    ret = write_start_flat_header(s->fd);
+    ret = write_start_flat_header(s);
     if (ret < 0) {
         error_setg(errp, "dump: failed to write start flat header");
         return;
@@ -1665,7 +1665,7 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
         return;
     }
 
-    ret = write_end_flat_header(s->fd);
+    ret = write_end_flat_header(s);
     if (ret < 0) {
         error_setg(errp, "dump: failed to write end flat header");
         return;
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index 7008d43d04..e27af8fb34 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -137,7 +137,7 @@ typedef struct QEMU_PACKED KdumpSubHeader64 {
 } KdumpSubHeader64;
 
 typedef struct DataCache {
-    int fd;             /* fd of the file where to write the cached data */
+    DumpState *state;   /* dump state related to this data */
     uint8_t *buf;       /* buffer for cached data */
     size_t buf_size;    /* size of the buf */
     size_t data_size;   /* size of cached data in buf */
-- 
2.39.2


