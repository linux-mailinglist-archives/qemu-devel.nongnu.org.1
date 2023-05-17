Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7405706E1A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJyc-0006Xc-DD; Wed, 17 May 2023 12:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pzJya-0006XA-95
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:26:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pzJyY-0004uJ-Hq
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:26:08 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34HE5BZj030978; Wed, 17 May 2023 16:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Dd8EXgiKZKdKw1PIz3jBGlnZ85OMy73Prq3hmaW5X6g=;
 b=3PrbrjPChq1211ki+hBVM8YlhhV512WD/gxt2jlvW1bgs8pMMPNWcavLaCZbbZVNA3xt
 G/jwFzvXERrvKjBtHnf/+KCQ2CKx5yhFniICifYCTUCq6F/tfLEIeqWHkRcOuwAbGrQL
 OdA44kD/6wpKWnURNNvOFmC8ULxF9H+RVRIZCjXQyQ9tMod6u5MQZ1WGlwPU4QEGx42I
 fQ046Gird50yFAdcmM6PTes28aD5w3ko4v0n/SNP/P+uugkWIMA0mVwpI9ThlyMlvjW5
 I2zL7JgcYBuTgGdHaFIKGe7rQiH6UZwi05fOFpw6/I03lB0E7972BTwk2gGz8H2nJZev lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc69y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:26:02 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34HF6LpG025089; Wed, 17 May 2023 16:26:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj105n2vb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:26:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC3HZPA3TR8U8aV9he/e1p9d1C281JMFNHpb/D0v9M0hftYvc/TWd8VlObnouxblsqwU01tAzmQTaP0KDzzK+PbM5A9NCKmKINia2OajujUD57u4gkZhbtLC2se7F82xZtOcGPWraEbjvdUPGsVJ74V3+zwvE9FitfoSjkc8ZhcTrVVYYD50Ty+zTVO+CgXFTKDaDPR6A5JadAtGGWYIQbT6w4cHlMPrrEkKFf7A039mGb300djY4UrdFAWxBkq4rfe1TQf1PLm1f7qQuhS/1ltLuQYglYDMbzYXjGMh+hww5S8Kugwz6oLALFtsGQfUCRsSw7x32uVPULBQQbFaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dd8EXgiKZKdKw1PIz3jBGlnZ85OMy73Prq3hmaW5X6g=;
 b=crB6eqbVxUR10GvqyPwx2UwKV6F9LJyiXXBOUEkal8KxHhVb+xnVUzxuliHH8vTMrhDlfWCpl18lSaCUoIBd1ope4Isdjf0XxUGQUJ+cFEG71GyLQBJtHzXmnCp5V5jHVq59Vj3qCUDX40SKB1O5Juc2s/NicdV6hr+mAq19FhurLB1rekmdfQNPtGTGfYQNjy2apGxNo+weSdaR5hHraSNqPeGu606zpfFcODTyadVDegCoNatcvn9t23w+XddhRPGTFJMfaLaAqnsrSUBYIv0DZIC9aVlAweTjqjOPNlIxOyf8dx4uBUNJonfdoeM1CKSizdmFzY0q+Av//I/izw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd8EXgiKZKdKw1PIz3jBGlnZ85OMy73Prq3hmaW5X6g=;
 b=LPneb9oZoIS7YgOKKyG1ECfqIXLps6l/eFOgCMxewhosO/A6rj3YndDXW6jOaeFnv0rNKzRSQppMapu0Yf4jVCVcCOGc8ItygFBpA/16ww+wQFQfnTNbq2+XiWAUKeJsiNy9Wb17HitVjXZ/+Z4QX0whVRRgpudlx2+ELzhjlk4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4178.namprd10.prod.outlook.com (2603:10b6:a03:210::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:25:59 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:25:59 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Cc: boris.ostrovsky@oracle.com, miguel.luis@oracle.com,
 eric.devolder@oracle.com
Subject: [PATCH v2 2/3] ACPI: i386: bump to MADT to revision 3
Date: Wed, 17 May 2023 12:25:44 -0400
Message-Id: <20230517162545.2191-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230517162545.2191-1-eric.devolder@oracle.com>
References: <20230517162545.2191-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f5ac02-4a26-407f-ca16-08db56f365cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjFEYZM0oB5ErfPLgNOas7tU7+aJoxjw80IRNj4KmUc2wsEkno4/Y1s7/DUecZ5KDQ4iVwnF/N5HJl7VpQFoRaARLhWIPzphwR5VHFCd2jckLZOif4b0z7xh1B70bTYfS3FjXP7LtJtiyGRklWAs5KLheXWBK/kI6JKnHDWo2Hg5flmLg0GhscSHdJEbt3U1ylNCFcXitSH1gQjto763lx7eFPbqdSCrHIwZFCwPcs9/xIBg1uBoh+GMxM3grEaoDWgGmRjBsG3g7K6NVLX5pRo9aeB2evbPZRfC8NLEjhcPK7uclHRsLWMpinqpFujGlTECpvMInIhmMdyG6JUb0eYjtoaEhKld4mz9rwBMkcP+29ky+P97VJGEWoXLzhg3xoX+A9SkgC7X3rBgOP9oL2RxLu5J4wR2/uAP34v5Jnw1CxobXtaucNzqiRz0coN7ZHt1cDt26sJaWlXtkw8RNhLxNqdF+x0D/Q6JHYt/mYEG9SdnAa7asBz1bvDGJ0Qlu2Ra/76jl7PoCBld8kY6SMOeN8GUBW3z8o39xF/c98sjnGCy3dl+ui2wFFY15m3zNmRgi7zOvx9sclyxXMhETxIGuGY7MOjfxx0R9ATblpllHsIsXWT/XUIn+G8qrtpd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB4531.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(5660300002)(41300700001)(2906002)(36756003)(2616005)(83380400001)(86362001)(38100700002)(1076003)(26005)(186003)(6512007)(6506007)(8676002)(8936002)(107886003)(66556008)(66476007)(66946007)(478600001)(6666004)(966005)(6486002)(84970400001)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yWbYDxXmcC5soi8klKBCn8woi69IrWnQSRSo3tc0Pzvq+Rg5MsVpfNF/k9Wi?=
 =?us-ascii?Q?wGGfDTfBLxRPT98o1xCe/IE31+OonGr9JVyA1nRp56R+i0MlV6rg3A2B/OWe?=
 =?us-ascii?Q?DOIH3oaIzNRrAlStU7NjND1y8DTR1XqkQultM454FsljQg3IsgJUmFT4Anaz?=
 =?us-ascii?Q?/ohDHv+vddcyQkxcrLbxPXXYxxzjALFAEKSUYAbFPO6WVupgqtetoXYDfEA7?=
 =?us-ascii?Q?pUGMXRRR6yGFpjUj9RD0Xo8W+/NfGsJxN2wqgTkZ6yh4EXQeciYhhuflXD1A?=
 =?us-ascii?Q?+GMZBIiXElJ2lxi6nFnZjwuCe9IGs1o52rxdFnz2XtasZSd+dWf0Z8O4oOXL?=
 =?us-ascii?Q?yesa13A+RT1BmxyS1uLEWdfS6b3jeFUxbwhnKCVVzjQGyeEgpJca7jCZ1g94?=
 =?us-ascii?Q?vG1rMfTDITxqG96hcEo2bN5cd3EY06YSx9BWYpc3IKF4G/JfoEY4T9Jbhka4?=
 =?us-ascii?Q?zp6G8HuYeZrYJDWVfLGfuAzsjUcBxIiyrvM9zPDm3ugCawtCxA1wzCY/JPkb?=
 =?us-ascii?Q?XZZGLHzERIwSIEPD0qg7/BjmzhAGgKaVTdelbT8xadN8bFL+/xwnb96fcKOV?=
 =?us-ascii?Q?oWzfeP37X3OewACDj6lEMrWlTJ7My28eEws5DQuaQxtDsv7qmsfKKpY77AyZ?=
 =?us-ascii?Q?yRUpGjqJQeLqtShgtKP4lV6OG9JqCbPTMXxqouNvXMMnbFDAdiYM0VrGAjbh?=
 =?us-ascii?Q?syaxSy2qw5QGCwE4/BF2tMFpiPSlk8lwlaU+gYifNaQiJqOmSq+Jz4WxrMWA?=
 =?us-ascii?Q?JfxJI4YUeQtbY8OU3w9lwzOXjp7PrUoYHz8LPpIKJv+AlqRMv3tseiFt/kkg?=
 =?us-ascii?Q?nWwqckxKmWS6xXV8CedjSomcSLxXcZ4uuZpj4sd7N96ukWngOagqqYJk8e+q?=
 =?us-ascii?Q?286mYNjOggYvgbl0KKpguYKTO7BdyMfytrAeAzJ84cG2/SSppYuUnCDCQLD8?=
 =?us-ascii?Q?S7tHcBrjpck0Sog5v58UnHHyJrwxVMg+w3zhkFXvSYxgLH9X32sfvXq7UMD8?=
 =?us-ascii?Q?gGueHbapDnp5hjb/DD65hHM7m+mjVPz1Q7MIOTOjOy3kmkgGoWXdPqlVIlc/?=
 =?us-ascii?Q?kGx5z5WfYs/RYsa6wZhSbPMmjR/CoJR3wujx2q9N74OAvZrubHqNoENtBzvR?=
 =?us-ascii?Q?u+AGMuCmB+lTK1/8o/MHn2SnFh2T8O9Yz2yseCyszlP3YJlmyPdg4LixuYTB?=
 =?us-ascii?Q?Hok2YWmnoB/ZsoLHyC3XT8obD9v9C4JXFWH4L6Q56tFbHM0a4V2Mr0PUCI1P?=
 =?us-ascii?Q?82Pft6FNDkGFVb1hjwbWpSQTba4pcSmUWOkX5U7Zxq4UDpytu42gcuyNL5zB?=
 =?us-ascii?Q?924Tlg0RzyczCbdbDn1XqlisqkC3LyXwA8skvzig2ulElRb5MRnf3UwWlDmz?=
 =?us-ascii?Q?ntjymIfr+hIihc2+3uzbQvQY/kjashzKPPKm8CsVK+23rO9cMwqHbbArPTi9?=
 =?us-ascii?Q?WzxhvRXafhfa/eh/UokdTOWikGRkzRjGTHxny3cmJ8jaewtG/EedC8L4RuIw?=
 =?us-ascii?Q?qs/D4F0NbNNxoVabo1QH7ZL59s9KhU7Ool7A/DwSuAkWEoO+QTEYaNyIH6CV?=
 =?us-ascii?Q?LAOWOo4jrDA8k1T8dxJdYJms+fl9fG3m6+JxOdYefR+LXw51UBjp1og19abU?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HxAY2nwxFTkWwJhQhWrOsDSPfkXnjJ5vKsGYk1lknoaQxBYoxbY00mCYhcYox5wudt5VFCTyrFd5wHOWVOxvqkAY5XgVrEUMQkba0GXOoWpRXVI+pozhMLo8zsxmHIxZNJwOoCI1VzhtaP6Uq+Omd/Jcwu47+KzqcixzLhzHj0NJ7FTh7ghieZYoe+s9c8vz7lCSFB/ejpprrKly+i34Ch6JyrIvs0ltR9nLoF4ewwQ6RmmJ2qOwalwwaSbBSfljNIN2Y7hr/ew4OLvRJpxzuPQZgCi96shRdJbDgoSzG9DFO1mm7J7czbZ3Dy3c+v4jViujcG1K+/BS/QMf503tMk7wCrIYlxaLMyjTvBwSAhD31II23Ko5L2CWzIYpDNwdM9eKIsJGqD2w30XqHIe+6B4xEFg+lKBJt28bG4AYBtbTC6tfNYZUtyc6gpRNX6trMve2bdLi9nTRALUuDgnCeGtZ3rcLBXUA9aPcdzSrHacUBkegbeuLDpve1wbshLSVmoq76trIw3wvM710ME8RPjmQTJo+iJF+Lm4MDkPBUPhgw6evBqzsBFwKHxYr/YHc/k/F5feSzNb3N2TSsth/cTUp5MrrF/M3IZKgma6M2NexqGl0WGsr8hlcnLgSsdTbEmLhK605xq9FFVGuQM/SPNNHeqiNYSaAekCb4v+C/YbiU7pg4rY7O1aOXYwLIfoLkfq32+IfxLCGtaWNReG5cAMJMyZy7+beXkkxRaDF/M9oP7U0YgoyGdlKmqYfU7pEAI5T9ElmsY1XtXWswismsBjVHrly2aRpdjnc47j7OyjXZfZ+/oyjUfAm6eSbESDNAIdWW9BZ5QBOOjsLKg0NbJR7II0/CeppbkRO7dRQe2g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f5ac02-4a26-407f-ca16-08db56f365cc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:25:59.0291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVEjpPAxDafqeSyMr7yEdR//UB9Od/Arvc/1e+yrGTTJVwB/93elva7uFjK+6hTNJ20wgezHlN+b1+d5bJauqrQROiywgzF/QfLAnFRers4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170133
X-Proofpoint-ORIG-GUID: xiUfWRFYBG1NPAXEOQ8CND4GWdpdbJne
X-Proofpoint-GUID: xiUfWRFYBG1NPAXEOQ8CND4GWdpdbJne
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=eric.devolder@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently i386 QEMU generates MADT revision 3, and reports
MADT revision 1. Set .revision to 3 to match reality.

Link: https://lore.kernel.org/linux-acpi/20230327191026.3454-1-eric.devolder@ora
cle.com/T/#t
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/acpi-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 52e5c1439a..8a0932fe84 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -102,7 +102,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(adev);
-    AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = oem_id,
+    AcpiTable table = { .sig = "APIC", .rev = 3, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
 
     acpi_table_begin(&table, table_data);
-- 
2.31.1


