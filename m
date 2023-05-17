Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A06706E74
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:44:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKG4-00038k-MA; Wed, 17 May 2023 12:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1pzKG3-00038S-8P
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:44:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1pzKG1-0007wB-FX
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:44:11 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34HE4GJa002715; Wed, 17 May 2023 16:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vchXIQI4PIK+1koOJki/qbYgscyEogjsZ2HxJfcNY0o=;
 b=vP7vYSO68vy8r/W3YPID42wE0LKQ9+5bSRDVVxpyGNX/dCSKsce+x53LnCAafmEpPbI9
 YfU9VVDYsyt4TDe3No+Q/r5bSSQeZOoMmGHWpOD1C1qaW81aK8P7YdJEeyhbvxlREeq0
 BSeCNK0A8win1sdpnrut+j9ulcsFgosvs/VT2UGfFMFwXIqDiCH5mRjmYfyd80vIiG2+
 ktEi/BOhVRbn4cdbmWyrAp7+zFoyi67bcKJ2iV6JpG582Y41+xdyihnVvjO9dllNXNks
 edMbCRdFx9L/0wGXt9i+VivXMPNf8sIAGwBHOKyhS4IfbCwKEl8fRbQbEZQFDG+/yOR+ mA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye60r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:44:06 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34HFBcER004227; Wed, 17 May 2023 16:44:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj10bxyeu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoA3AoIonaLpKq/fMjTsNCw3XTQBHIsD9SgWLABazEqcaHig22iM6zlnyTEWU6ulKU+8KhAnuw1+DgWA/GUsFS+JR1t5GW0AMBZ0P7HT3PEs1h6K2pynNmyvEnSuXZ6kC9ATpES1krLEkQX1UCOr7wy8oMD4egXmZ7faB/WfSAyeLmik6m/e3ByPiWCTRE3jPHgA8zmh8QLKXUBNHKfh+wiMwtJfohz7y6+UuosU6pbok3DW20Vdmpw17IcjSIBS04yfGfRgJRsk4TLbvIBNbK2hV8bKhavqFAOx2Dv9f38ewGKb9475+GYZHbE6rivHhat8z7b6RriTKTEojpPe3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vchXIQI4PIK+1koOJki/qbYgscyEogjsZ2HxJfcNY0o=;
 b=kJrjc8+pKZWYEaR/D/mRSwZrTiNYOVv+0p7DjbbcoxDuSbpLu2qZNFs/MuDgN5mlBnL+hHPndcxf2B++gQtiuT4k9hGjzweNYCUIByy2NfqS/SJgB7H97nZ8rfnbPRmCtFbzkfdBrUrYk7/5O3vsWrsfWUMMavPdluqc5c0xj9M1cfA7qM+Eb9wJcTGj8vDRa/Wdt4M6UgmM6Zx/JB7iC1re/bxPs+ecYyGzk9YsVfwVu4xbh9jno5wglsinKkEz12ySS9FNj7vKrh2A7Kw7JOcCpmcf4b9dOIExtZqpa3FHLDLzqp/GTU9qzZYYHfYlOaX0FJ417KAbOJyD01ozWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vchXIQI4PIK+1koOJki/qbYgscyEogjsZ2HxJfcNY0o=;
 b=JrarVJFpBSMI3aPcudDlkYtxnAJYIBbEZdlmtX+3XOkDHscrjTeIZvlkqBqXMJzRg8/wZ+8ao5NbzoO1JHgRUh8YgofnNfZ1Bm09SZt1BBhPdgEId2vPgydk74yK2pNZ4JgywBklpgOH1fsv5rGcHLHrJmR25dCR+K+6IP9a4n8=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by DM4PR10MB7473.namprd10.prod.outlook.com (2603:10b6:8:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:44:02 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::23d1:65a1:d474:3b1d]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::23d1:65a1:d474:3b1d%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:44:02 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, armbru@redhat.com, elena.ufimtseva@oracle.com
Subject: [PATCH v1 0/2] Fix the documentation for vfio-user and multi-process
 QEMU
Date: Wed, 17 May 2023 16:43:55 +0000
Message-Id: <cover.1684338236.git.jag.raman@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::28) To MN2PR10MB4013.namprd10.prod.outlook.com
 (2603:10b6:208:185::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:EE_|DM4PR10MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: c4433cfa-63d6-48c2-91a1-08db56f5ebb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WI2IQSKFmpbMERnF4TiuQeJJ6XMM+M3SocEBVXpkoLHiuMDhZYHMdk73Uug1WFXoQqJZdndHXfu8Qj/Tc/fGfYP/3iol5xJ1TMZoEFVx2tUzRjlfaNVHhu/YwgB3z+sf4SJL/C356l/EGvwdUnxnqh8f9pRxlfo38vKCJexjFJVt+1LRmA9PTPx/PWPeYaiapgkNXSf9JEzB19ffs424CL+pjpIfmfuh0czXU5Nra2Za3irDJwS2Y5v9D/+t3BWZbLzFgkTPWO4mI6Cm/Wbd8mgJub/xGi2CRFkPa3ujLUjoNhrt0ZoNpWibmHSzNbtsXowxl+AMwIJB481dDbxBnuUx3kXKEhtKVrklJFQuF/XqFW8MMyTdv7/FP7Heymmjx0a0KXuiGuBJL0JhxQSTRluhsBl0hZUAaUzVnD2sv0LULiTxpMol/yPvS1rugosQIGNr0OeGgcUUIYcwKEFE1dI+3ElD1yeMi/t0EKaStpk5l62JO3xdYjsmtPnqUrC6xH7UazQan/znntffJvSExcErXewMhl8ieuzVQz+sTX1BBqhUnEiaSN7ETDfDX3h9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(83380400001)(6486002)(478600001)(2616005)(6666004)(6512007)(6506007)(26005)(186003)(107886003)(8936002)(5660300002)(8676002)(36756003)(41300700001)(6916009)(38100700002)(66556008)(4326008)(66476007)(2906002)(66946007)(86362001)(316002)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HhY8q4bT3Hfrdj2hqZXYTzZogTbM+wRzzitmqx0wa+I6l5D4wxTSL/D8y7n9?=
 =?us-ascii?Q?vSKq7CIYvcxTsRensI8p66aMXFedFPxQ2tVlhxdhPF09GK3UvVqWUsjYX5jA?=
 =?us-ascii?Q?RERLS1uvFRJVaL5bg1qBl4V3wx0R4+r+FCk7pnlMvlqxD0TUO4WqAEnM4vAL?=
 =?us-ascii?Q?4nSYJayBJzjHwoZOTdY04uobpkwI6CDhehhGnbKgFVWhFJAPoUCotvWKT7Yw?=
 =?us-ascii?Q?ySlUaLfjMiuXdUA08D8oOrHVzvFQYj5sLRfxpakCJge1AW0MmhESYoqQbLm6?=
 =?us-ascii?Q?5u6bJ+WZyh62IH1DMHig1UZWWm5z8dFjVElPVKePBSE6pv1eb5KPKXOlnwzv?=
 =?us-ascii?Q?Pbc+V89j5NyYOqq80r8PcK7DcZHtXT/hEXYgYnSvd22zYI+lvt5IslznfW2g?=
 =?us-ascii?Q?HxdAxhJSvxmNrDNk6C0JguBPf9IyrKt0De9UOmFeRwFA78+ChKvBsstlo8tD?=
 =?us-ascii?Q?OAi0/l0ew8w4VlJ+1SHtnoJjVfGololecKuMi/lJulw+/0Tv23qlkI185d1o?=
 =?us-ascii?Q?QTP+Hu5xaFRQgMJUZXz9MAJEAtrZl1+pE46Yg2ss7o9/VfK7WgWlb7Y43Xj0?=
 =?us-ascii?Q?aOg6FYZjVoy9tFXBv8ls5/4oOF3h62Zo2mYRkDW9Nh5m6d6SN+hXya4n8FsA?=
 =?us-ascii?Q?IWYW8uXtIB8YEgCCL0dAbf8k1p6U18hQJjQUac4uFl/RwgCNSYpjifzN/hS7?=
 =?us-ascii?Q?wb5bLksZA2FO0slu05HAwF8cWik4qq0rNXVFgyxhLwV43mdsGNJsRVY3h+Rn?=
 =?us-ascii?Q?Y7BNfONoilAsWFk6BpF70F9p0c1aGAyRnVui2l/14x+mGS0jUUfpNpvaal6U?=
 =?us-ascii?Q?QBFAFfRhnGsF+pYh+uBxQaefDT4p4zain9fr5/V3BS8FiNIcJD08jkVwfZFt?=
 =?us-ascii?Q?cuF2g74QPTgh8GXDWY6UzXZagj2UE6YogxQURD1EVPN05IlWytRuZj7SQ18e?=
 =?us-ascii?Q?nWW8yW5DEWuqNz2m9k0rr1O7tEnSZrMhRy7sNxBBpR5QLUe2mEHSkPI0g57o?=
 =?us-ascii?Q?HgjbQGpwBSIFylqcSPR8oHyPNjOIdSAgC+bD2aX4FU9IwMfACLq/n2XTyNqD?=
 =?us-ascii?Q?8rqKTz8vrKFZpZyZ1MOvhaeM3twte9VVnU9G39J2VJMOrY4e85rWPll30QSy?=
 =?us-ascii?Q?TA/eN42Quf7XvuAqhQer3g17koDw+SiYUCYpQqkF7s40Pi77tyfnRvBEEsVG?=
 =?us-ascii?Q?6YI1vUNCpTIpSuJzivkQ532qpKb9Pcp8zR/5+AUN+lGg2c2FfF/R9OAo14+l?=
 =?us-ascii?Q?FYd1SqaBkRjITEPaClNLQFVX6PQWEDDwnMic5EtgYo/yw6WOt6ft93gJ/7N5?=
 =?us-ascii?Q?bgMUqRycuH4+Bi30sKjbnxv5/9PReqT5AlyjSPS2iqOkMOZb5/9j1Fh6cxlX?=
 =?us-ascii?Q?Gr7eD6hT+GfCh1dJvkQsL2t/6EKGAsJ6V1HTl4+ZfSMaNdy9jkh/gdPWq1Jf?=
 =?us-ascii?Q?SQ+JKGH89KzyDPrMylqvywY2qACg9Ljh5oEtQubvKuCo0/+86fP+hyTQzFBB?=
 =?us-ascii?Q?/i9g4BvyyAVY6CIA+PjiXGEM5m9tSqF9P17olbSB1DSKKLrfVKcrXWOzP8nC?=
 =?us-ascii?Q?J/6DA/+H9fBzfBWt31q38K3qDn0+xXiwsaX4GQYp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h1fXsdjgXEcR46IhFdpRAAXMIQiKCWTM/FMWPrludX/ZjrKj+xZVN/J5R/ZIFdFTxwMNRA/uUWPI9uofIt1DpIJ7Y1sBn7OUJyZsDdBTvPZLba0FieIIYnN0m974bHj/eMHM5VWnpM/7pOVFrhq2EfWdpykPaQrrWU3MtEaVzN0D5QhWn26D43Tf6hf0AprFa6anx+FSAoHn0LwW+RpaL0dC14/NHsKr5VD9XhzSVbeKhCf9R/+MNm1h2pVIG47xgJjq28/uArv5flxFlTseNEOIwp4ZvQ2RsTMgPQojzJafYfSP+UQTwjp/AUy+jngF7pt2ZzG8d5O6Oo9gzneZaFaAsljMVlOou4AZD1TCAHo7dk4LFld08zL75eegQ3bYfvfKiNj2joHTUVTCADw5bCPToPowCjtDMUKFxi+U1k1nC9fG41DU5Sgw6YfFdFKvfTwymXOFcS4K/VWapot+fpdbLJp9X/yygSKacXvDF33RO/0QWlo7A07LrLFIUV6AoUai2QR+GkzYsU8+w/2X+Y21sgFaqmo2LXKVbvqhFIo+S+nJMJPTt/OLI0e0nGx3qcpjOhe77mmS+EP8OdDz/4C29D2vEwy+Mt9LKB4Np68cmqtyWmYl0bV61yv174DXgGR9wolbrC5BtRLo778Dyst3wDnib93msui8DjfF4n409GKSuyCPtFNuInAdo5OvQR5j3mizH9lPr4+F3mBQ1qpxa/Wg+d4X6BSKAzMF52dG9TYeg+9BreqxuHlqu5kSd6+21uPbbxbcSvMWIjnJuw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4433cfa-63d6-48c2-91a1-08db56f5ebb9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:44:02.6398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6mrrMQwwRshS5YTd82gFREGaZ4SPd99JsBvdQifxzBy2mU5/FKAdzrqLimsfCP+I4uFB/W2wr6qAf4rhf9ooQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7473
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 mlxlogscore=711 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170136
X-Proofpoint-ORIG-GUID: vSBzvqXntXU8FloyseRQZENHMAQSnebV
X-Proofpoint-GUID: vSBzvqXntXU8FloyseRQZENHMAQSnebV
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

This series addresses recent comments from Markus Armbruster in the
"Machine x-remote property auto-shutdown" email thread.

Jagannathan Raman (2):
  vfio-user: update comments
  docs: fix multi-process QEMU documentation

 docs/system/multi-process.rst |  2 +-
 hw/remote/vfio-user-obj.c     | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.20.1


