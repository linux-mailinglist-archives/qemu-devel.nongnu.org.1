Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75557706E73
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:44:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKGD-0003A9-2T; Wed, 17 May 2023 12:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1pzKG9-00039p-3Q
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:44:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1pzKG6-0007ww-SF
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:44:16 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34HE4Cvn032042; Wed, 17 May 2023 16:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=SV9PPbXiZlZ7GZbGCBtzv1hg5biS8aPbXesi3n61zzU=;
 b=n1kUhNXyFWEF/mHaDZP59mNAJE4zHZsvQy2We48IuKiCio1LdxLYAFbH6OaSqtBANv62
 8xw7kJZEXSwHTYF6kuWqxyTxa7ecV2rFysGb0Q5sjPaJOc1GmdaxWr8eMIm1NFA1US7t
 cZiVz4+uhSD9oC+2DePWe5a0JcLqOdFCc8dUP3b2Vq17cUsDaq1CPHHCmf7dDebd5MeK
 O3f7M7Z1rKeSPcM84LG5u8F93F3lmqisNx7xITepUNhUsnCtg3V1VkVNo424sfAB+HBp
 cBdFyVcT0GevALWOF3gW4UpdIzreGnyYSAeAHVfZd1sGCyWNKuamPwTRpxTgsvmP/rD1 vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdpdam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:44:14 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34HG43wv039975; Wed, 17 May 2023 16:44:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj105dxgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZO8Vre1uJGfL1b5wLNMjC/3urCQTT8iE6irU1grocfFb4a4Op6sWlefDpbg1Kc1E4VWS0VQ2cuAqUp2XjNPypYqxs1xDZsPJQXTVwRry9Edx32stUhX0ROYQ3JmiwzLPULuWD88G+UcGNlijunCZsX3Pjytp9cYLgW9Pn9ITZzM8JDFtB4Hl7eGZgZUaCn8rM7xUTZGBc3BS5btNCF2oDZL6PgXz44tgwRwHLAZnHlFEAt2vAzFhY1umtblGOZ1IyA+20yKNB/soLeFv+yOp0AnYqUall9rDk9YDyYQ7FxIdq8aUiyFTgEJ94jcGIhkWQ5R3U1BiMIVFz1g9+Hz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV9PPbXiZlZ7GZbGCBtzv1hg5biS8aPbXesi3n61zzU=;
 b=HxQgm9aQzPe7/dmouys3SIOohDG3IPZeQr35K9qlUUb6jEKvJCetRsYCKqbc2qn6HxVldbihnrl3YQpa/z4yKNFlI0928XVJvJgfZgyAThlv8nrrN4DluEeCZztrvQ8zsAagv88DVjf2Y6pZJkIshXMFjMoCokPvUGn535fC2gCX83LUft0iGwydB4h7XQ7EukQdXxrlKb8HjqejbXPDZviu1MIYojv+0FFFPXjBuFiSd9r9e7efKDNbdVmHNhYk2Kfc4/42RQlodj3OqYleEtKJGL5JnsQttMdsySasAh/dJZYAswDcB4jcVGFAo59Ltrbnaic6ZwNlcNNYwNNg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV9PPbXiZlZ7GZbGCBtzv1hg5biS8aPbXesi3n61zzU=;
 b=JHpdE70N0l7vc7zrVi1Mtwovp25H5gzu3MNCPpD501wwZ5fgJNhZdedgfDt8ChhjWUkvmeiOl6/0NY5/EfPOCoBMuHHiQxEdwacrcVGSAeXyYZNDyYXaXMfK9cGPg0+oQ9zWYq6gRFqHX3Oo6qt6eyw6/hKBlrOU+mRM1DfY/v8=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by DM4PR10MB7473.namprd10.prod.outlook.com (2603:10b6:8:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:44:10 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::23d1:65a1:d474:3b1d]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::23d1:65a1:d474:3b1d%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:44:08 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, armbru@redhat.com, elena.ufimtseva@oracle.com
Subject: [PATCH v1 2/2] docs: fix multi-process QEMU documentation
Date: Wed, 17 May 2023 16:43:57 +0000
Message-Id: <863b725089a7ee6b65adffacfc896b6ef795e86f.1684338236.git.jag.raman@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1684338236.git.jag.raman@oracle.com>
References: <cover.1684338236.git.jag.raman@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:a03:333::34) To MN2PR10MB4013.namprd10.prod.outlook.com
 (2603:10b6:208:185::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:EE_|DM4PR10MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d614056-0a0b-4e00-4344-08db56f5ef48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFCMTW3wdZtzMgV/SdYdgl7OiHKBiDGOsDSD0jcJUdmO0aojttyXsZwf/T9/m3IH34keCOczAhv6qgZfX2rJ8NKsLrrLOwOzg1LDdGlBUbQuZ3OZOZbOdJ9hXzB9ypqUne/FJNQSR+KbdukvEUb/oS9hjP/+Hw7lGyUefpzx7CnZWuMtczUPduPPseNWah0gc5Zk1TUVn6+Pwqxuj3Dsir4K+e1OH1jLIVx61aq/s+24iprka92O34tzqMMOktUjh/dUpgJLmpJQy4v9oeNP3dwkdH3ME8MHhGPeA7Up12dUQdf2nMAPYzzHiYanL0zMLxLiwhy28aH9qa06MUbnaW85F2ipCEphLn+KfCjyYeBScWnu5vMz/5cvaKmnvTZJIRqbf8jv9YmkiNQsCimwsTRpiHYk7CbuS5D8s2qPw8TkRYBL2paBWY6fHgP+46M1muwXTMauIf8Ab5INBSNtSCu0hw7AvLP9Vhj8FhJkrAnPzj4niEPCu4eguf3UKQR4ykDaeVENA4d41a/bgs2eXCs3uc5x9oSv8q5l7/fyPCtSEZqKLUQQL+JKLHxhkjhZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(83380400001)(6486002)(478600001)(2616005)(6666004)(6512007)(6506007)(26005)(186003)(107886003)(8936002)(5660300002)(8676002)(36756003)(41300700001)(6916009)(38100700002)(66556008)(4326008)(66476007)(2906002)(66946007)(86362001)(316002)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B1pyfkzVNsDLlLpenswsU/ohoixZ2IU/l3yzwbaW7316aKz8w3XIagwHpTGi?=
 =?us-ascii?Q?ney5r3pn1ykBJp3fmyMuhlupg/EaBuiHiZcOE6pI5qTzN5mgt8rdgJ4VzNfo?=
 =?us-ascii?Q?4iJqLcQ3NokjIhL3OX9QayDQATaC8C8+xHcCuSz6urImyIgmcntTqiXJ40j/?=
 =?us-ascii?Q?CuzPJ6VDW26fR3erTq6Xa+Gh45k0BmW/05nz7OiujFeFA6FEr0prqphgjzql?=
 =?us-ascii?Q?s12U7NSf72J44aLTGCus7LkHmyHdsCJ65+MzoBHA3rZiFei6dcD4aghn5woB?=
 =?us-ascii?Q?HTE3zTumyvk+nGFolcHXWJQBVZ3N/hetN47lUNJ4MwT5LzLClsYToCmg6mFl?=
 =?us-ascii?Q?O+2c+8nh7+qzXswnE+ojSPctScYx/CJPOrCrZpLTrOaOXni+g6F/QmJKse2q?=
 =?us-ascii?Q?u/ix2dNzhofgAos/oH6i3kKuO9ocHJlZPJRhOYrzXvIFPf2A5uxVA/Ct+uti?=
 =?us-ascii?Q?+tfDYP3euQfitiv1Xkf4HkntWh7O1TvePufLrzriWM3E+/qwKjNJyuwkZvhB?=
 =?us-ascii?Q?mHOYblsZh75p2b+Cgc47p89MQ+/D7sBzaMZOzpPSvukVW2R3zbbqNPcyDCUn?=
 =?us-ascii?Q?89VKo7j8jLm1POiR5dZQwWW4UTsnnEf5j9uqqE1RtimoZHIRfPD8NTnL+A4D?=
 =?us-ascii?Q?XsojdMr6zDAo8F7hd8+c9qRY+F6zcoGYHEnp0KoHNVh+yk6bzJ5G2dHi3MA4?=
 =?us-ascii?Q?8Ys3416PrN1Ksms2s/FU7BdEtnAcWY+9nDvPV4wyVrFMP2+qPZxy0iWV9ZyR?=
 =?us-ascii?Q?LmX0IYY29bqF614EeRpOzRK/ZBVxPMRM6U6Ko3NwFLGIuEVqKDXUIDpjzboS?=
 =?us-ascii?Q?KN5AhiyTiUj+H8nwbvNiY+P70HlI6f/h64tDhUCVkKsmMcSwv2jJLDUMPclG?=
 =?us-ascii?Q?TfZ9gI/aFNwRU1fCsz4SZFzT8H0fdTBKdVqK3tn3+6IbA0KKQ3bIekILgDR5?=
 =?us-ascii?Q?vAyC+FpOHAN27Zth8UVf4R/3wrrt6SR4cqiZYyVxZz3zrmk5/+GDKke6Hmi6?=
 =?us-ascii?Q?9LUXjSlRZTZQF3vsvSuU5mC4fQ78d16gk/89xfwwzDqeCJJGl1XbDnhW7F8B?=
 =?us-ascii?Q?LyuY1Fd3NjsrnrZSHTADFcqq+lNkv7j0lARfotn/CFSJlfGwVRzAlVBHiDgu?=
 =?us-ascii?Q?v094JWjuRvIZvuounfR8nVHuetOELyGDMyvLz43XEZltv+HEJJ/lZeBjg9hN?=
 =?us-ascii?Q?S8LVy8+AvGd1mGy/IJOmbxAd3hkCb+sUyHkJ6KvHwpSBuQtfxtcZnW7xB9Qv?=
 =?us-ascii?Q?vnZkkBTOvhnvha958XAKxAC0CwT0g3U49eoIgPKfihIWCQHuYjr8hhwudqKy?=
 =?us-ascii?Q?v82AH91nZn5hVPlCF91xcDxetcQ6TSuwqioDuqcJ2E4Lzll9KqS/86L56Jdj?=
 =?us-ascii?Q?xrA1oxX++gDBNesbAQepQcNS+jRol8FSm41tlVWAXBerpPLrRDQXhmwnWbe5?=
 =?us-ascii?Q?5nhxtFaW+tlVZ95hQen56l/bSsv1V+bpUeMJRqLfik0xT+03BuvNL/NsX3kp?=
 =?us-ascii?Q?cshBTUMWrWTKnhXV8Iv9TyMgsFSQM++N7tQ9YKlUwylhBgxLeR+6jNLZQGG/?=
 =?us-ascii?Q?33Z6sRhm6P+p2n/uxYfCISGZgoOhC/bgeOLCtDSh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gvRQyj0C8yYJYfMhT5HJSxXA1usE2Yxxe/vmgkmgYF1DxeAjlW+F6F83ASxjnJkSkQ6Z8pDhBZUDQYrVa724mDnqDU0fA9mSMZPg7Sm9wK8PAnpPvGJtW4xwA+0agKmMsdOvzSo+IYDhnq3hPcpW2k1I4SNrvY24+KeheJ8JOv3pAhppTxD3BOx/3FOT7ASLmUrgLUiuHF3lTRJUYuBZRQ7OVpN97wKjFthuVe2mUQZX3I5kCfn3laSE3i1+jjiE4/EcYeO9+Kb1o59DkwNdeJkF64bApr1ryxcZvOlaine/tZNUbIkGeXAS7Z2cCxgKGTsGePQvo698n3a0/pBQSfvd7uwpU+Z7YyfDVfuzK0cpBhbqGq/DRzzjDR4B+9WUOfDuOIunAmdWU9UTDA15B/30+Hcx7xT5MC70Mr0vSDsLhbgK4x4KUfR08wWIxhdP3ybnzMi+ypbV1ewf6F/c4u9kld3cekjPhNDg+5puDdB9MPXTPsYyK38Q/afjsStCSX91B++WwPFbkriXhrCGb0/Lm+fsa+RHJiFK2POpeIXM8BYf1VT32m6/1k4OIvbFmuXFy9Kkd4WzGRwHGq05Y+08nfx1Rh+NIhStXdU8E25vpdfP7y7izoy+M9564GyuK726BUs1XrYjHphVLW3r3KF0VcLdlaFDE2ga4gPGHXnaICwg8jWowDFDYsmwopltjiKSx6uq2OmDwBmyAaPyvPYMnZ9KSL7MCqdhtgY2uxvzRj+bPO3VccASKey26zC3YwjFeQUsls/4q4Wr5MXM9w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d614056-0a0b-4e00-4344-08db56f5ef48
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:44:08.5871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oi8ql3WnCIc9SrvSqxr73u7hEsfGQ9nOp8tmMoKs04H1elIDHhO8vjo2a+h70xGLB8DXXZKtjkhevSYcDp9HUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7473
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170136
X-Proofpoint-GUID: pAodBKgTy3noRj12SmqbwfmmFJxuJqCH
X-Proofpoint-ORIG-GUID: pAodBKgTy3noRj12SmqbwfmmFJxuJqCH
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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

Fix a typo in the system documentation for multi-process QEMU.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 docs/system/multi-process.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/multi-process.rst b/docs/system/multi-process.rst
index 16f0352416..2008a67809 100644
--- a/docs/system/multi-process.rst
+++ b/docs/system/multi-process.rst
@@ -4,7 +4,7 @@ Multi-process QEMU
 ==================
 
 This document describes how to configure and use multi-process qemu.
-For the design document refer to docs/devel/qemu-multiprocess.
+For the design document refer to docs/devel/multi-process.rst.
 
 1) Configuration
 ----------------
-- 
2.20.1


