Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E1C793E41
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdt56-0008Hk-43; Wed, 06 Sep 2023 10:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qdt50-0008Fl-Sh
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:00:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qdt4x-0007S8-GC
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:00:26 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 386DomE9013915
 for <qemu-devel@nongnu.org>; Wed, 6 Sep 2023 14:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=mt6zBRTxIaDR6jeXChhh/mzfvlNIyfQ3YlpI7kgU6xs=;
 b=mj5VxhvtmSRzJlQBpdwHRjf2HiIILGbKoGxoO6T40hkMJqfWJeOfNiAR/UwzJttHDafd
 np2zDkU7beqth58wG5/6fx/wYmzhLg4KfJ0KctUc7fpYTpFx2uR1wVaKWMOMDRWDAJQf
 AsWi9Br1t72gTlcj3+L37+XeS589E5JLAUUncY20uStXJJ8Lw8dKrdjIVOR9CRQDj8cJ
 wrp4lF1/+I/ytMN3+NNe6hoJyoyhLAZx6o3ruNgmb0+03AcJz3YK5j/+5q9gEbXh08sE
 sIXIMhmSApaRmY0ffxhlPqGako9OqJXQ2HEji6NAFAwNRw1JZWnZZSGLFr5foPTkHfbC 0w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxtnj81vg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 14:00:18 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 386DgaLw010418
 for <qemu-devel@nongnu.org>; Wed, 6 Sep 2023 14:00:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3suugch3wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 14:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH6ukbfBmck6V/SAT5Br4oRPvAodGoScahhTBxgHPYTT700yEQ/3TpJmQ9oiYmmavSl8gVshxb8I4delaV0wZ80ZDVzADJZRqDbi63qgoTLnulF7MWGq1Zocy2kBJPkEWkSrqX4gdSQn6AsojsPeheYMFCMqYZKXu9+ZL4hGhWlbFMfr1/41/89qAbJX12vQKApniQ+VQTL1+PwXG+1+hiGPZnn6CBLW1mik86YQOqgxcZzyveB+ZNyCIbro3BTOYyosEziO69/l2OUHrez4VaccAnp1VX0D4pX+Co4DgVa0GDVAMkbPAtLNj90InnxyKc44j2tSQ9yvSDJxSwHrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt6zBRTxIaDR6jeXChhh/mzfvlNIyfQ3YlpI7kgU6xs=;
 b=FFfFYWurDxyKnTypiwbWcPNntQqMTlL0QWQUdCDbTREkQgLFF/KdeU2MGCjif3l009s098TyA12aIryYORmVMeu7oaBK7x6fh6/YuiU8QKZZ6NtS66/CP4XzPffqOFcjq4s7PFKgR+j+DeUAOBWfVAAE0vOuRvB4g4rHgcNjF1+iBqSdcjev4oYArGjI5pvmtHrmFbFkmIqatz/+Tt2kS823CV3OyYlnAIbNcgYTpcFDuMawnLPFVAfdQsEzPq/Avoa520bDAS5OeSY74ZNLkyF2Ik2p2fDHdt36D45zB0THIEziLi1aCvL29cqL75RrA8IKT/DahVwyTmf530UGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt6zBRTxIaDR6jeXChhh/mzfvlNIyfQ3YlpI7kgU6xs=;
 b=LIq4DCCL6zKL4PTAaMVMEsc5+wKL3xxBAOZknZfBcnOp9+bYCYZ5qYPb/+RYMXYrL+MX3B2ClQx0umJgbundSBcCLECUDgJ1fX6RChcOY2rviCXm7Rc7ZKN5ebrVi95U6rMIFCQ8UZU3ffX45Dd7bj5YsKgcIvQGIGoNcUfeILI=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 14:00:15 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a3a4:998b:966b:41ac]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a3a4:998b:966b:41ac%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:00:15 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org
Cc: william.roche@oracle.com, joao.m.martins@oracle.com
Subject: [PATCH 1/1] migration: skip poisoned memory pages on "ram saving"
 phase
Date: Wed,  6 Sep 2023 13:59:51 +0000
Message-Id: <20230906135951.795581-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230906135951.795581-1-william.roche@oracle.com>
References: <20230906135951.795581-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|SJ0PR10MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: 396fe83e-02a9-411e-cb8f-08dbaee1984a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQCnR0+bszxHtBbjQtfTj/XKijsc/v01XdVMxDBjKMdW+b85nwMfpG27D6SIJHU4GX9CZUBT+vWxllJIBpt+7WT078fkPDe+hcA1XUb3NsIH3Kv7Za2E0wba/ti8Zpx73Ka1K7NwWiipy/O/Fhnsldgy/UWDMoO3cBcymzumCI72KyHIfapeCdKEZypGQ4sHFSK52+kNfdS0X8TgAhkI/87vgwGMOnKyLp5X86htmOn0hrMrc5kz7TIulY7EXVBBvGZQWE7Kpl0mLK0pGomYrOrvrk3cgmAf7oMZNDcln8qA6n344XRAF3P0L1GOsfcEb2AVfHj1Nf3JG0/nNYRoRvMBel1+SV8kB//jTwE4RFUUtXyyupgS+LpvqsJyELVmHBtYaK89GAbIXWZzAcb4PzxRSwdqmShn5Aw0hZN0s3cBxiwZGIjfrNC2nN2Q5B71LvtSbHn19OCRh+ri5m51c50SdgqNGBXdYhY11w3hKHFv8iaNURazU+AzC7gkyvLgK6Eb/caAY3ZrmUSo7DwZJiqIbPDUFOu5lTSUvtDpMokl5GprEFZoiT0keOB4B35H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199024)(186009)(1800799009)(8676002)(5660300002)(316002)(6916009)(66556008)(36756003)(2906002)(66946007)(66476007)(8936002)(4326008)(41300700001)(6506007)(6486002)(107886003)(6512007)(1076003)(6666004)(26005)(2616005)(478600001)(38100700002)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CcYlZP7e6imlvASdU/Q3QdTiu8T/YuhEaVnOITlOu4B7dag8IYAQnYHuabf8?=
 =?us-ascii?Q?TStLbV6dO8mkh3YVZ8DlI92Na70NoXX/COJxd6d9X/Spap57rDpDfMU7WCGa?=
 =?us-ascii?Q?a6y4UDprgj0KN8I3gBv3nhRJKBSRyihDwttOV1KT9P4O0dr+qI+xtFVMMZK5?=
 =?us-ascii?Q?3uH6RwqXjxL6HQrVVHuDd6YdcG9FT67i77rlqnXCfJQBKNi6kNAd1rNLB6pC?=
 =?us-ascii?Q?BW6CO/8eEOWlgEag2ui9fg3Ua3XRWfzspfVyhDdINHVnAsj+PXrta9odDz+7?=
 =?us-ascii?Q?i9TFL/BhBxFjs+YC1TAUwsaPzpdPokPPvblu814nkHzL7vgNc+4UwH+PxfuR?=
 =?us-ascii?Q?Sv70s8R8Zxen0UxIJ9Y1NVffH79KofxazVPiDi1aO9Kxq3M7xhiqAQspCMV9?=
 =?us-ascii?Q?xyuDA+GUvgAlpdZRo8PyyZtjP0T8cn3oUX2UKNBfmX/LL04o4e1GBm1Nh50E?=
 =?us-ascii?Q?2EenL5VQtvvpZrAS8P0LCg2YPuo9liRzpGIVXhEXlwx8i4G4LgbWo/wJ1BGS?=
 =?us-ascii?Q?AAyF77nsPb80emqvrqlpRuyL8bZKJfqTSGCSW1VtGUZaHOO8K2xY3Q/PrB3V?=
 =?us-ascii?Q?wAUNklzSgAVFFZlvB0rG+htUAKyWlGBsxq8LRzNnE5WC7yidvIVjmHugz62e?=
 =?us-ascii?Q?mtP2CaEUDKkGVsmTbqwX1nxlH1ytFig/L1O/QW+RWXpGqFfeGRctlb2MfjPO?=
 =?us-ascii?Q?RwTWpo6sMrbvvmU0G68Qq3Zu5P2yGf9dwYIDi3OH221FT5pBXOvUMdAehDHX?=
 =?us-ascii?Q?66Oq+5qkpqlKD9m+Mh26FFVRyLaUcqyY73yINjWmteeHshWpbFiJGqx4h6RI?=
 =?us-ascii?Q?4xHS1xSD0r5jc0hd4nowMGzxqBbQtT9A3gATUl4+DjiKk2jEtf0pNzOe2Tzp?=
 =?us-ascii?Q?ootWOEpFbapqU8OzgyZUbW0MBwbDjt7cug9v3UfR22DIj+2L+cf4u445vXtH?=
 =?us-ascii?Q?wT9A7bgjIWeekJ6XkXiVmNP0Jw2y01tcZb6M+IZdQq6nmrwgMVPLIjBEzheF?=
 =?us-ascii?Q?/lsYJxKDP9ICbxwR8W0Dt0CjpdosLy3klJzGB/RIdNk+lhBwba8P1Nzqgw2O?=
 =?us-ascii?Q?+7ltrFRKkXoaO2woXnpWIwV4VwwJns9oKEwRhOPV/qkT9EXJqgxS+QqPQmUU?=
 =?us-ascii?Q?RaEQd9DOG4TGKhxaPhcPEw7D5uS7J9l6sPZVVq2VLCCHTMWSxFaH023jWjcG?=
 =?us-ascii?Q?VTMPMotL9bl62jHfe2AI9O1dcmRNmB/ZXfiHl+Um8VLKYwreJXCfeeQtEXqr?=
 =?us-ascii?Q?ECsXrXm1RmK78kh5Bfnqc0ZrEYSdy4kycyGfsSAPlXwMwVes29gwwElwhAon?=
 =?us-ascii?Q?gLtxtnRd0rQSQYi2idkymyNCC6jcL4Nq75cl+riVoLndoJkII3VJM284/GB0?=
 =?us-ascii?Q?P2zP0Wy2ZMlz3jTw3jJAASFKTTTLYAfzT4u+cAgo1WMS66rq3lXnsnONGGrU?=
 =?us-ascii?Q?G/k01TV4B3Vzkhm/bjgM4o/s99/qR2p6N1eYcsp4A/8/RtYhPgmYPBDuSFK9?=
 =?us-ascii?Q?mRgDCYdGqZQdIcyUvbp/6THD+5mYqx7Te3oLCjcCy0a5rVPS5bILOn6gIDql?=
 =?us-ascii?Q?eTPSCCClXUHPntHqDLjlWQTJiYK68Txtm3uGXxEZw0vogxvxclMVS/uckWyw?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rXjjoDqoU8x57Efc7Rm5vwzd5aFtguTMJGzofl5Riuhq0iZmPY/vBDC5KZWfPLxN0wALRx7uZuHSp7VaBT/q3SZow+fOMszJS9AwFkmC2VwAXqwbxNFO91tjD3AmbGG9NZVxFNLMVo+t7OtlQQeLZkfm95JUQHYekJN0PYIKlDl3VzebuwmhcyVBshaFG/03+Sco1MkaNanQ582aMkIy3bS3La1CE78cQzbcIaeXW/iBm4ahSqmL3hDSsNLlEQL6u2WJo2yCFci4XFRf6SeAoWSJdbOM9iooiVTTnUEuMb4q4tV2AxNBIUX0b1Q8zdAHwdW0s5JiaDW2DY0nkLoduTIKbN/Q3gpJDtR8cK0KBNZYndwMzQF/PrsTUvcuoCEq7iAh9IpXslmaiye6bp+Xdk4G8Qtdq6IsRXP0vX9pMo8tv7tQpy4/GKqh1WGsnVrzCwVtKojOAclDtQ/rFcmUlEXwA0Uit2B8z/u/hMXN99yYZHaSgmAAmf/7BXT4aZV2N0msDNfoX/rxJNWT8zL0Zw6GHjIGaY0vxGr1nzRYPaWeEjuoN7nFx/rXtdFYI12yMJPln1GhB0U5HhdHOdtc+aDwucpxPDTHLqL4hbp3rqjuZR21c+3I7bykGbYrra+mqoE8EYPDqSfdVAnkgH+tW5aZDvPf43jCzvn10zu0xya6eanF30Yirv7eyT1/2a8GxTiTBJe0SdLsGtjCuj7xb345HlQsEeBZ5q6E9SYH6ahNgpOWJxSuFK86SoFlO/fi
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396fe83e-02a9-411e-cb8f-08dbaee1984a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:00:15.0178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrYR7TqViDh5+sF48949PyXPaVGSX1/FpFRPFGjWfZ565q8Gbd+Mg6DQRsmyKlLkQGptK/WxryXiTO2dH1mhBo5rsaGHyTYq2cb0dxLkPNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060121
X-Proofpoint-ORIG-GUID: LpgyprPf-N5bPiEObmD7Y8Y0VqaYdOsg
X-Proofpoint-GUID: LpgyprPf-N5bPiEObmD7Y8Y0VqaYdOsg
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
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

From: William Roche <william.roche@oracle.com>

A memory page poisoned from the hypervisor level is no longer readable.
Thus, it is now treated as a zero-page for the ram saving migration phase.

The migration of a VM will crash Qemu when it tries to read the
memory address space and stumbles on the poisoned page with a similar
stack trace:

Program terminated with signal SIGBUS, Bus error.
#0  _mm256_loadu_si256
#1  buffer_zero_avx2
#2  select_accel_fn
#3  buffer_is_zero
#4  save_zero_page_to_file
#5  save_zero_page
#6  ram_save_target_page_legacy
#7  ram_save_host_page
#8  ram_find_and_save_block
#9  ram_save_iterate
#10 qemu_savevm_state_iterate
#11 migration_iteration_run
#12 migration_thread
#13 qemu_thread_start

Fix it by considering poisoned pages as if they were zero-pages for
the migration copy. This fix also works with underlying large pages,
taking into account the RAMBlock segment "page-size".

Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c    | 14 ++++++++++++++
 accel/stubs/kvm-stub.c |  5 +++++
 include/sysemu/kvm.h   | 10 ++++++++++
 migration/ram.c        |  3 ++-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 2ba7521695..24a7709495 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1152,6 +1152,20 @@ static void kvm_unpoison_all(void *param)
     }
 }
 
+bool kvm_hwpoisoned_page(RAMBlock *block, void *offset)
+{
+    HWPoisonPage *pg;
+    ram_addr_t ram_addr = (ram_addr_t) offset;
+
+    QLIST_FOREACH(pg, &hwpoison_page_list, list) {
+        if ((ram_addr >= pg->ram_addr) &&
+            (ram_addr - pg->ram_addr < block->page_size)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 void kvm_hwpoison_page_add(ram_addr_t ram_addr)
 {
     HWPoisonPage *page;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 235dc661bc..c0a31611df 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -133,3 +133,8 @@ uint32_t kvm_dirty_ring_size(void)
 {
     return 0;
 }
+
+bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr)
+{
+    return false;
+}
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index ebdca41052..a2196e9e6b 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -580,4 +580,14 @@ bool kvm_arch_cpu_check_are_resettable(void);
 bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
+
+/**
+ * kvm_hwpoisoned_page - indicate if the given page is poisoned
+ * @block: memory block of the given page
+ * @ram_addr: offset of the page
+ *
+ * Returns: true: page is poisoned
+ *          false: page not yet poisoned
+ */
+bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr);
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 9040d66e61..48d875b12d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1145,7 +1145,8 @@ static int save_zero_page_to_file(PageSearchStatus *pss, QEMUFile *file,
     uint8_t *p = block->host + offset;
     int len = 0;
 
-    if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
+    if ((kvm_enabled() && kvm_hwpoisoned_page(block, (void *)offset)) ||
+        buffer_is_zero(p, TARGET_PAGE_SIZE)) {
         len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
         qemu_put_byte(file, 0);
         len += 1;
-- 
2.39.3


