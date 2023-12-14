Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5233F8123FA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 01:40:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDZkc-00043z-NN; Wed, 13 Dec 2023 19:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1rDZkZ-00043W-Ut
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 19:38:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1rDZkX-0000DZ-4W
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 19:38:51 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BE0TX4R005880; Thu, 14 Dec 2023 00:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ToxnNuZGy3eTEUeZ5bA5A8Fs0fVTHYueFxXc1VVclVo=;
 b=V8hjJtd6XsXWaH+7vPklNe5qnF+DzDcLwc1tpNA0eZWlzsb01tDMNEKi76qVX9FvqmDh
 y7XTzNqGFdUgevSeiISbc05iXdUMEzdHvGi+rFrHLdfIIsYv2HXlvR1eWLg4HHpLqX+0
 gQ/BOaULoghW8QPsWnWAAV0iSucwR9gNs01XhI5QqH1QYflMG8l61hQ0OCaQnFJ0E1Pn
 pP+G3niG0Wf68mfMm1v5xZ0U6uKfb5K8tWpoSRk8gB6tIz2zK1EZY87IvGljiTy52r4i
 /t7KY1RLhdtgz3X8JHw12ZHYwOya3EjvFfwf+8CfOUhWN/U9b7PmqqvhZQxhJtnDy+ih rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d9p3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Dec 2023 00:33:33 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BDMisD6008434; Thu, 14 Dec 2023 00:33:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uvep979t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Dec 2023 00:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNTk5QfksfZUMEI5aNxxictIvOLuyC03HhGPBUo03Sgba4CTYG4peyjIxvPnz4pukTpbU8epn6evHjT04tGfwmf8FgI14tMmBxm0owyPDB3KsnCGAVMdHCCqKGDUg9y51cxSPVAi6qs1BkdZpZOpmEb8N7GAhrppK3xxgkCN6uXotBFTlJiumrG/AhohObU+cDvvrDz2ccLAiS6jY5tXTMfSiLzDiiBa2lAvt8VHKL2mQQplQ0uZXQTi2y/G96Wq3PyYSTqKhGBGS0U7CwXq9sFufyUurKdQcbSfeeS0jW2LuLGU+UKkeRuQbd9KwTnplN0gEvIFmCdZDi1mXbURfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToxnNuZGy3eTEUeZ5bA5A8Fs0fVTHYueFxXc1VVclVo=;
 b=Iga6/A68SzLvW1ZI2aIDM+RDzQVGW1RkeLVIZctBNG/4cZvu5fy7JPy2mMSLtT8SmhyL79dbdYRQIhi4ZCQfx70WeIF8bTEdocH7NEE+hkriT73YpLzH7hLIPAOe6EsWFH8QdxHoUflihaMAVFJvudoHj9Ic6k1q0TTwOwNcoqIfIYkrZ5SKW+DyDQ/gkS/3ISGRK9gYl5ZOGwPujs1B2aHzVAnqkJvdPbCX8VRDjCsIIOdVd4iAfJp56MPcmzGnE9JL8qg1YLfWT4jtEoKoj9Dk82dBKIsq8wKHP+5OrYzMdikEgAFB5PBS9mpnsZZMyShGIg6DGWiE92blYLT7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToxnNuZGy3eTEUeZ5bA5A8Fs0fVTHYueFxXc1VVclVo=;
 b=l3/xhc7QJUhvTH80XJjJQh42juubivGnLgSZ2pDCDL4oeFd518JCW1KMnGLiuUHmGDuDkNFoLfXF6PKqjXfEqTBhKPI9dYacvOKm2xCNADlp23oFDBRXR+XAc61k1upyWksaANu+vGx0kygzlw+q6gsK8gE5etLxeBGnnBk2M6U=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BLAPR10MB4868.namprd10.prod.outlook.com (2603:10b6:208:333::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 00:33:18 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 00:33:18 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 raphael.norwitz@nutanix.com, fengli@smartx.com
Subject: [PATCH 1/1] vhost-scsi: fix usage of error_reportf_err()
Date: Wed, 13 Dec 2023 16:31:17 -0800
Message-Id: <20231214003117.43960-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|BLAPR10MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b8d25a-b225-4f04-b7a1-08dbfc3c43ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pnkqfdt+9UtmIHqgQZ3i4CFA1n0+EiNLRHfBvrEnYEFM1CrRA8y+g0mXmH1SuUyUz5jSxU6jfop6NKPOeyriZWpF8CTqtHWRNY0w0xu+G/QuZs1jsshj4+xK6Vvyui6BeopCL4Jno/IKEFwiSDyjx+/tU2skx3A7/XLrn79wGh0XqfQTrKuCl+ApcDtS+E6A6NSjPB1EPdmULdSFd881VFr6uzjYzPNgE68ELSmp+K+NWFI808OEcwHmAM/Z27nN9enVqBi8Yl8vHOsr0S1JlM/+ySDEBAmiQaFaZCLcpEAYGZOu0GNNRIhsEI0OpPkArQEXn1aPN8kofGj5yMi1sgwQvdSZMnNuqF5E1JAgyEQD2JWFJ6eiSXH9fD5TZJXB4IFtE38wFsDlO8Q4ueptAFUhWEazOpVoXB1pHgBqN/5GKsz+QpbPKldteq4mePrcugWAsbw8bvZ0wpC99GELn8RgmGJLYbgHzrasabWcctKEqET710mgm/Ayj7OBVuR9Wxt8HTufU1tLxWlGeS/EYoesmG+ixZ+mDEmtt+WC6Pt5ZR2yk6MAl/Pm5sIfDUcp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(2616005)(26005)(38100700002)(8936002)(44832011)(316002)(6916009)(1076003)(8676002)(2906002)(4326008)(5660300002)(66476007)(478600001)(66946007)(41300700001)(6506007)(66556008)(6512007)(6486002)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?drbxIBZabGeSkY8boLRD4R5+OsO2y/1PeAIyRbg/xI6FdFZAxvYV8eiav4So?=
 =?us-ascii?Q?pSr3I4K1JvAGIk0hefvzWJ5YUqNYyIWiOvtE8m2QvXzkhpi5qC3mCWR6EjN+?=
 =?us-ascii?Q?oz2Ua46FI9D7g+blkPL/4JUXRjzV1wG19WJ4aFDkJcsDFrWyEqO1D4bwodlA?=
 =?us-ascii?Q?kwmDHaO7BpcS4qUENs3ttAR8PM3gDoPWQWvUmSL8nnpFdshvsDBEYYImIcbT?=
 =?us-ascii?Q?tTVhI77iAYgVWUWfr6+Nv5dF8WXbZ6bBvDA4W7NYtb9kdvwFCHzjLY5eDLH/?=
 =?us-ascii?Q?WZaADa6RgvsFDuXrfP4erf3ZGEbWw0INjmEveYP3CLS2d8tbUjcL2pW5i66P?=
 =?us-ascii?Q?K95TvRcxc+sYztxpnnEheLg5cR/NA6ZRQdwHS7E8MJz6WNi+D5ItdexRD0qY?=
 =?us-ascii?Q?PHk5bscUYE86ocySPICvvW3xeZsXMQp5mM3rPKVcWWkjikiTveAv1luwr/Of?=
 =?us-ascii?Q?9v5R5oZe9asuQlXLoXKdmZuf9dxAqQtcOFCHwlzRjqpLmeX8SjT9oBET0qvk?=
 =?us-ascii?Q?pyyiIjcnQ4t6lKpMMJ4/Nq5Fq78PbVZy4AFNH0N8QvqxXdWUDMydTqagCwkD?=
 =?us-ascii?Q?vMvl7AQldpbddi+evdnhtsKD9XyFU8NlrWQMCeTvpGnOUa3KnKTUNyYXZ/Cy?=
 =?us-ascii?Q?em/IQox16gsNoQkngGEIi6zb2+DVsIzkH2TOEaDlCeuMOiDWJ7MsNpTxHaD2?=
 =?us-ascii?Q?j3vPISdljvlgE812UHmXXe31gUpaUxb+SR+JIeY+ePsSDcaS1w7J6Ron30hm?=
 =?us-ascii?Q?3+CCbFA87URz7s05hxVFX2f0Q8YCH4fowqyzshWnVdEZzH32ZD8YmiQlOGzt?=
 =?us-ascii?Q?p/Ne9rsiyDLnMQSTu4AE//HgvWAGrDmNRVULt2Qk0ehsJiGp4d0dN6ieQKUp?=
 =?us-ascii?Q?R1Ty8FLyY68Ki0y9c1FL119WjmBNlbsS8lv5d2RM2SeiTWI6Mp6izYo3godj?=
 =?us-ascii?Q?1LzBkblniPqb4H94rxokjwaxK45m92c4tMSg95NaOm6darzK4tIrPjArKKT3?=
 =?us-ascii?Q?4ODSMf4z5F0TArPQQEp8pKHgaqx2VEmpfZt5PSbDw2jHPc8/IsBmiglTR0d2?=
 =?us-ascii?Q?rUoLFCKd5PUPMcRouLSEai10wwAe7lrcJ6sRgL6wTSc47azzTdcwsg2BXNMI?=
 =?us-ascii?Q?sfpfxzQ3xDX8HHlh2dCjefbSQ+Rp8p+LpffoJZiE2vCI51ufbwOj08wt5d6X?=
 =?us-ascii?Q?bQr1cBUnQ0rz8/9kuRN1bJ8w0i7JR1CRLtLO/oLBbiLbRCuVc7/fBrV1OP1m?=
 =?us-ascii?Q?XMw4EZBkKps8yX5kvqI2XIkv7bPsXR71CkM2FYO1UJM+7u9rKGJ4z8q7xTLG?=
 =?us-ascii?Q?+TxhMj6Cy8wBe2PFQa3xC7rEMAwHWXO/qcq5rOa4J0ONoO9za61jv4cf++38?=
 =?us-ascii?Q?QcFLdE9vD3S5JihOce/xVxHBWcpfCw/xoQGeBvXTGlhLI4GnFSzp8x9oN1uq?=
 =?us-ascii?Q?JWzzJpHXhSNjyBOOvznLWnKv1ptWrJ8fQu2lT1xgROKpPfbSIJxm3LOaxCFQ?=
 =?us-ascii?Q?TfBUrutWOh/aVh+yYvmAG4t9XfYopTgYVZF2ufcjJU5OeDHUzvzshJqLbikh?=
 =?us-ascii?Q?kBG2JjLGwJ+irxXyYtuPnYIF4QLCkP+1VH4+c7BK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Zg5ElU5amNf1ZYCOn+TceS2pOktcZJKT3jZGVRofEK7Z8msTPTMamFDkscY+4Bzl20PS5izLOYvtL4rK0Yy/hHgKINnHk8Ze0sgwBESgBUaWGu1I/dufphbWMnPQaFtnuR4m4EOym9xPuZUTQdeN+dQMxj6rIqhO5y3IroK1apN385AY3C6ztrCMLXlEZ7GOrg2IYIaekjf7SeViwfld3MDYHmNfrQ1NThSuWSFCzEA9hXLYnd8LWyMlmjNiWITEuFJX5XPEFuqol11tnkZCg8TaEfC4eeoyVvHksf3QKu83mOCIOyzH45w6BlvI0m0+75tnsXIkCo3kRfSyYqqdoMCUrWoEGaNiYZSgxGG9XeFaKU2voI7xIhYFH+xSLJ/awKAUvkTGhhn1ax1KOt0o/eS5Y3WqrT7Ll8cGlt0r00Lpen7rR0/Ejh75QUbkyVYwFIWmX8MzvLZzoOCZ7VMJ3TtMAPbM66N+FpXPxhlLHBzeErvCH947Vnsn09coWf4uCvHVhzoZcLEOPt24yTdavERLJDwAgRUe4TQP2JGa+p/1V+Wb2AFxPOSRumZNZHSXdusnPm+TZfQhrImkMsv87h14CcvIYbeswHGy4gTX54k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b8d25a-b225-4f04-b7a1-08dbfc3c43ea
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 00:33:17.2575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbcNGeu17RsvMwgWaVRYpkVqI1BfpcnBRxcy0G6jgqEb+/fBH3mtm+mDJWoJkhPZo0ag/OucJhHTnPTsSNkDug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_16,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140001
X-Proofpoint-GUID: Jloya3YCw5CWOqogbPpbC7cS28fQxuzQ
X-Proofpoint-ORIG-GUID: Jloya3YCw5CWOqogbPpbC7cS28fQxuzQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
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

It is required to use error_report() instead of error_reportf_err(), if the
prior function does not take local_err as the argument. As a result, the
local_err is always NULL and segment fault may happen.

vhost_scsi_start()
-> vhost_scsi_set_endpoint(s) --> does not allocate local_err
-> error_reportf_err()
   -> error_vprepend()
      -> g_string_append(newmsg, (*errp)->msg) --> (*errp) is NULL

In addition, add ": " at the end of other error_reportf_err() logs.

Fixes: 7962e432b4e4 ("vhost-user-scsi: support reconnect to backend")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/scsi/vhost-scsi.c      | 4 ++--
 hw/scsi/vhost-user-scsi.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 3126df9e1d..9929c0d14b 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -91,13 +91,13 @@ static int vhost_scsi_start(VHostSCSI *s)
 
     ret = vhost_scsi_common_start(vsc, &local_err);
     if (ret < 0) {
-        error_reportf_err(local_err, "Error starting vhost-scsi");
+        error_reportf_err(local_err, "Error starting vhost-scsi: ");
         return ret;
     }
 
     ret = vhost_scsi_set_endpoint(s);
     if (ret < 0) {
-        error_reportf_err(local_err, "Error setting vhost-scsi endpoint");
+        error_report("Error setting vhost-scsi endpoint");
         vhost_scsi_common_stop(vsc);
     }
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 780f10559d..af18c4f3d3 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -83,7 +83,8 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
     if (should_start) {
         ret = vhost_user_scsi_start(s, &local_err);
         if (ret < 0) {
-            error_reportf_err(local_err, "unable to start vhost-user-scsi: %s",
+            error_reportf_err(local_err,
+                              "unable to start vhost-user-scsi: %s: ",
                               strerror(-ret));
             qemu_chr_fe_disconnect(&vs->conf.chardev);
         }
-- 
2.34.1


