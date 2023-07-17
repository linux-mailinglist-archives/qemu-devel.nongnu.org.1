Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AFE756971
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:45:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRK2-00012A-Cz; Mon, 17 Jul 2023 12:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qLRFj-0008Ip-Sn
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:39:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qLRFf-0003fm-DE
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:39:15 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36HF0efp016501; Mon, 17 Jul 2023 16:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Vt0W4cbo4Pe1559QbKuzhjC3+BZUk8oMShwnoZ99/tI=;
 b=uv3rzZrXj5YsuLlvf/YTCOCho2vg2mNPcAS++cz8WdngeNa7gKs+owdjrqurDbNfbR9h
 kQ7Iqb1KDqcJdIToGAjVkvNdw4fb/Rp4x/xinXHsjTkgfoG3+OHFbVV4wkvG23mY1htS
 73Jqwhya9Zz2gZUE8mrOd4EY1C25RezCGA8iK4TJcTBoJNswPTe4Hkiic+/ys+1gIjKk
 epWP6+FTqQDOx/jGtprQo9UjWPQx6qrXWE1zDcNpbS7vsacbPCga8LDfNB0vavJvPEgt
 k4OpCIzfUp7WGOgapUg1LXZmxyHyiMiGKxTasBnKRz00rF32xJ09xuUaqOOqOfhe8bID sA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run77u5mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jul 2023 16:39:08 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36HFbWXB023985; Mon, 17 Jul 2023 16:39:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw45d4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jul 2023 16:39:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbvrkZ2bzjwGnEav9EE9A6j5im43HdKn97HlMbVGTILLNYQtWqD59QhKbIIJmL+dTe6cO4YIjx5KBH29l58wrM9LuwnfyB+l6C5nzJ/7Vy4SlOeqUmuUBodEgZanwa465KcFOvUOODnz6I72rj2XSdvsu+rUTw0FW6phUukSW4FUG0pgPTwraVV3Tps4ItK7oY4W1jp7hkVSN+ZAyGSXsPffRiCPIr9QBx2DwgB0x7SLFF9emFbH/e3oXvJxp1xngWHF4PYjCU6eJ2XvczzivRPZeLO9oWSIR+2GFYdZt4fjS1A0giorZNERbG59YtqzKIRG3Ggvv1p0aR/Bw+Q6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt0W4cbo4Pe1559QbKuzhjC3+BZUk8oMShwnoZ99/tI=;
 b=cXa7+Rh7cwcjvYTN0Br/qxmww+TC6NVE0buGScdZIL1D9QuXnFhLc/dwhFZ8QGPkZigpUoff+9XzDsdVZb0ynToqKIGsvnIeetRwSGwSxcdUEVNrQ8sYMprtedwQxpWeWzkoBOMEF1xJkU3eTsPEtq7WGWdYTBYU0V+FbETRs0exnjzzSwGiOZ0vnxkVxKKKoUHHSeWRVcKuP1eOru2SJmrx55EeBhVLTjpnPRQmH621PbDDLg2moXe4/rhzY3BZVRGLG3Dg/i2iZ8eTv+2jZvRyG9+AcMe8uvtxhKm+QCpdBQP8Ruls4k1XZLzNCT+CPk4bssorByCP41Jd30jjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt0W4cbo4Pe1559QbKuzhjC3+BZUk8oMShwnoZ99/tI=;
 b=Lfdv2eqmkiRH7ZJeFC/f7oLOYahYrq+JvySsyrGHI8GdvzSWGCAee9Z1ojUE7gRORV+CUKr5OAZlv4fRfZ4uP0uXniV/sWuqzdcjh4DXEeaGiIrGaLb8nn1ddttfoIvMJW2bjVrcDK3Xm9AyFsa/dspnj12B4QLGE2ba1eiQWkE=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CO1PR10MB4788.namprd10.prod.outlook.com (2603:10b6:303:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:39:05 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::c89f:f0e5:c5bd:aae5]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::c89f:f0e5:c5bd:aae5%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:39:05 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
 joao.m.martins@oracle.com
Subject: [PATCH qemu 2/2] dump: Only use the makedumpfile flattened format
 when necessary
Date: Mon, 17 Jul 2023 09:38:55 -0700
Message-Id: <20230717163855.7383-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CO1PR10MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: ce60714d-d918-4c4e-9fc9-08db86e45576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGwA1W+AhmG3UUjA05F1iXXq//H0CqyIJ+ivWeGCUUoX/iESDQixwNponBbWFZlVxgn6Te99Gf4o2CTWor0RT0fL9slIBM9NuZlLyXBfnYL+wjfoQ9cBf8yAEw3ZKikVZBSHjQO+s3C36Ip23oKrznrWNfkY08JIaf+weBox2sLbc2fk+Do6ApOkrJVWdk6WFuBvjFXuxwQE9Z59GcYx9vlVE9gXGrLx1L8O/p6kDItGkhZgoaXITg5nC/6U3xOLKRyBZWHLUyVcWoV7ZX9RuRlwzYGerLRjMSP8CoNcWBCs0fC05UEOontDgVfv15ZdE42BOToPaIWxjOTzChG5YmAShpHEE0G3suJghFYOw7mRYlSyKpDDF9jDFjdvZvSqBSBlkGuG7iydCnMWAPsK2/bb3GfHscaUqBHT92wG69qst4CkSzcSyq3+G9Bi9/5QhUjEuXDNCgHGmHx1jWJnm7n4CBHcw4AeA0z+EcIHbKP+/a8DM49PcdvvyzdPdO5FHt1SKj3HIExqxipL3EAqmAxjzp8yj4cHmSKkpbesEXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(86362001)(2906002)(103116003)(36756003)(66899021)(966005)(6512007)(186003)(83380400001)(6506007)(1076003)(107886003)(6486002)(6666004)(66556008)(66946007)(316002)(38100700002)(6916009)(4326008)(2616005)(66476007)(5660300002)(478600001)(8936002)(8676002)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rtDz0Elyz+yyf0mMGJCK4jmJW0rtajWDy8OB+G5oiQowKgb686bi27SyhA0m?=
 =?us-ascii?Q?4gw4FKfA5J6COEmyNFY5w5e0RTU1y67TFlYtB9iOBf6U3HpwidinNsYY+v9O?=
 =?us-ascii?Q?wUX6hTdh2e6Eji/ql7ZLIL8hDbZrx8GWNZ4bDkDw9ggKQcb3OnFq5EcJXGiK?=
 =?us-ascii?Q?Bup0/lDvMVosX7hO3TLTXJlzZgVb5HQwZvLsj+OHs4GpYoTzSJf6QeOBt70w?=
 =?us-ascii?Q?twO1B04lZhAuZL8qiGEgG+H2/RW/uHYdL2E0xw6JFTjBBghPJupYr+HpWKsR?=
 =?us-ascii?Q?cGMcjZA1qLzJxdZOlccE3OnsT1e0oxFqbkPSzKHPOCSuIKnn09S7fFirirgf?=
 =?us-ascii?Q?tS8jEOgznJ5JWjY384JnHHPzjyV6KHmtUrU28e5IXf85cxRvGDoRRW5DjMaD?=
 =?us-ascii?Q?N1cqFDi7KOUXVZbpihIeiKdfD9aMyl2+5VKb8KTIkjuuUeDobrlKvUo0ZXSj?=
 =?us-ascii?Q?k7bxxGd9imve+hOfdpW95Jeh+ppmMbweRsb6e/ADKzSD34qtCCNvo0XzPAzt?=
 =?us-ascii?Q?bf5RyqRjIOrTgGzqHbMBvkMSPo77tE2DAQpD9Pg27rpsL0pOpCjuxfVDQAjI?=
 =?us-ascii?Q?BlQfLLtlINZUJRE48M+pnLBEUPavB9vxg0NCgEpLKXDWNR4bqy2DOOU1tRk7?=
 =?us-ascii?Q?GlGSRB8lev01zJw6yEfsg0jFfLBV5ZXi8ICFkGbSvsYy9SsCM3qGx2QkP96b?=
 =?us-ascii?Q?zZJdEerjfUl2CJcKxbe4aBi4lrTODlfjjTAvzdOHArLUel04Ie4LiCe8SNqR?=
 =?us-ascii?Q?2kMdABYn0uRNbvDP+h4+ITX57y/jNl0PdmMUUYimhq4nRwIcp14P1QA5PPTK?=
 =?us-ascii?Q?wefXE7y8dHbZrkY+QhVerHvCyuyCOYFuE+kBRvGPFvTqjtCN1y9aJRLsf9/j?=
 =?us-ascii?Q?Jnfc0D9oLVqARMTBQDI712izl4CwP6Abt/3mXDkmJYUOeykd6uG2W8Tg+wNV?=
 =?us-ascii?Q?oZc37OOneOI9oh/M1xQwQhGcLvVAS432TOccDZV8ItVL4EH39eRr0tslqymX?=
 =?us-ascii?Q?CVouu+Xilg52JwCpVjBEB7jQRUz7rkbPxjQ/+mCedKiKDS7FKJAL0P6RGGnI?=
 =?us-ascii?Q?AhmRbTKf5zd2QYfB6llSRVWAubJ8ixsvVmi6wbbPIHMjP59c157IKwkoz2LI?=
 =?us-ascii?Q?m7oPns17MTCIH3AAskdOgCe0GsV2WmZKHnDCnVME6K4Y8L/8yRC1fbjg+lv3?=
 =?us-ascii?Q?XPO5jJZDmy5gLTHb2ST2BnQU+gjqe/HHkgAobf1Y/bbeQ2XG+/B7g2B6hafx?=
 =?us-ascii?Q?bcDuu/8aL3bf9UU75hrHwAf99lZJffXo1bNKU1LUE3qHpN2QcCiaogVz1yUI?=
 =?us-ascii?Q?wbuGcvgHGQ36i1dezU4jEDDvFpdmk3t7GBxOFyvkmgLJAanaheCgQjHLCSI2?=
 =?us-ascii?Q?ZeTdpL3mHZ5xpI6odax2t8GV7l1yHlzUcxzHUZ9jrTZrWBASzBcKLY+/3lpb?=
 =?us-ascii?Q?nsxlirq6vCyqDu7V7l7XNTPpnm7OFTc1b9W36XTRYwwgd5md+c++zW8fqPlo?=
 =?us-ascii?Q?IMbSv0qcTj/Net6OCdISU0Trca8f9fXHzsmYcxFV9cQZPDO8t/MShFdTTnmd?=
 =?us-ascii?Q?PE/uTstvyTdHHWCDJ4qKKAP4fBXiSIm+yJ1/viraufO9Pm7cvwIEfI37Um++?=
 =?us-ascii?Q?OEg5DIj5jrpG7r+juI6e1mY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mTpwKg5euGl4d+obIFiV6PmhU5xb7iRA5k2ZTAINnoYaYJu9FVdkUht1xUKyW6bGyFQHYcl8+0x3CrGDgUVybGZh9eVdVpucpwEnYCXN7+rYlvqKq7xYkJ1UmNsrZYcoWt69F3PXC0FnURWCAoLpY9umCpBQNDrWkh0wFCrPre+86ZnMdOXTz9BoxtCjSGrszLjw9f33KSotFNF1LaL9M5QzWCrxxnQlbtntN8JI9bsKn10ZTUFZlCXJZkgPEGYxa8XqiAZqjXdnUIl58j20qPmISq/2HHsErduHn8aEcYY1lcFWTuPzymQJ+Ca76QK8ecLqG2BASWSznM7EUq1Fgyah42mqHgHqYfA7wDAEvmvmGgj/6TCfBKIt9z3GISrNIbIo1tvU4o06zS+q6pBedLc1aY0oUQhDu79wLDbmM8RdnOdi27KXT6MRS772BEJqyzSYgM0XYJvH51JbBTR0WcY6y7U8nCWnOiWhT974UC9Oo4bEoTQK3+pcwxtTgeJ6JC7VehBXPX7pA58wEXmfjtIaAO5UWF0so1ZJeujEa+J2TxOfHG4lmoeMIVF+55ym6jvfTEhBE8SMP9W1cTD9QT2X1CAUHAcumkE0K/CqqICMAaeTL7Up0DaofBokN3/PsW2XtWc6w/qPkCCenl9Nrx7zWolWbok+nAmgH68+g7xkkLhJYRvq4+8icaiUjAbVS4eJC9ITsJCbQv9YkrxHFtb0dELHYfl4WUAu89lwwS6awbgZrn0y2tTFcKba0nmp/pZCi23PPrZG760qkhf8a4fIvbwRFZnx+rSI4zwSze/PS7Cs5fCmdFS5FVzYx61N
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce60714d-d918-4c4e-9fc9-08db86e45576
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:39:04.9936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: on+dP1xLErPjH4WjQNDyoKxw7NLIw2cphijJME1TGdZWmdVmsTGnSQz1TgixTNAkLEWg4/697e7ebmECpuUhXUNM2Lgd5fgGiMNYnYiLWtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_13,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170153
X-Proofpoint-GUID: FiTYzCca1SjlfyM24ecO8GFhWT2Bex1M
X-Proofpoint-ORIG-GUID: FiTYzCca1SjlfyM24ecO8GFhWT2Bex1M
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

The flattened format is used by makedumpfile only when it is outputting
a vmcore to a file which is not seekable. The flattened format functions
essentially as a set of instructions of the form "seek to the given
offset, then write the given bytes out".

The flattened format can be reconstructed using makedumpfile -R, or
makedumpfile-R.pl, but it is a slow process beacuse it requires copying
the entire vmcore. The flattened format can also be directly read by
crash, but still, it requires a lengthy reassembly phase.

To sum up, the flattened format is not an ideal one: it should only be
used on files which are actually not seekable. This is the exact
strategy which makedumpfile uses, as seen in the implementation of
"write_buffer()" in makedumpfile [1].

So, update the "dump-guest-memory" monitor command implementation so
that it will directly do the seeks and writes, in the same strategy as
makedumpfile. However, if the file is not seekable, then we can fall
back to the flattened format.

[1]: https://github.com/makedumpfile/makedumpfile/blob/f23bb943568188a2746dbf9b6692668f5a2ac3b6/makedumpfile.c#L5008-L5040

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 dump/dump.c           | 30 +++++++++++++++++++++++++-----
 include/sysemu/dump.h |  1 +
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 2708ddc135..384d275e39 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -813,6 +813,13 @@ static int write_start_flat_header(DumpState *s)
 {
     MakedumpfileHeader *mh;
     int ret = 0;
+    loff_t offset = lseek(s->fd, 0, SEEK_CUR);
+
+    /* If the file is seekable, don't output flattened header */
+    if (offset == 0) {
+        s->seekable = true;
+        return 0;
+    }
 
     QEMU_BUILD_BUG_ON(sizeof *mh > MAX_SIZE_MDF_HEADER);
     mh = g_malloc0(MAX_SIZE_MDF_HEADER);
@@ -837,6 +844,10 @@ static int write_end_flat_header(DumpState *s)
 {
     MakedumpfileDataHeader mdh;
 
+    if (s->seekable) {
+        return 0;
+    }
+
     mdh.offset = END_FLAG_FLAT_HEADER;
     mdh.buf_size = END_FLAG_FLAT_HEADER;
 
@@ -853,13 +864,21 @@ static int write_buffer(DumpState *s, off_t offset, const void *buf, size_t size
 {
     size_t written_size;
     MakedumpfileDataHeader mdh;
+    loff_t seek_loc;
 
-    mdh.offset = cpu_to_be64(offset);
-    mdh.buf_size = cpu_to_be64(size);
+    if (s->seekable) {
+        seek_loc = lseek(s->fd, offset, SEEK_SET);
+        if (seek_loc == (off_t) -1) {
+            return -1;
+        }
+    } else {
+        mdh.offset = cpu_to_be64(offset);
+        mdh.buf_size = cpu_to_be64(size);
 
-    written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
-    if (written_size != sizeof(mdh)) {
-        return -1;
+        written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
+        if (written_size != sizeof(mdh)) {
+            return -1;
+        }
     }
 
     written_size = qemu_write_full(s->fd, buf, size);
@@ -1786,6 +1805,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     s->has_format = has_format;
     s->format = format;
     s->written_size = 0;
+    s->seekable = false;
 
     /* kdump-compressed is conflict with paging and filter */
     if (has_format && format != DUMP_GUEST_MEMORY_FORMAT_ELF) {
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index e27af8fb34..ab703c3a5e 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -157,6 +157,7 @@ typedef struct DumpState {
     MemoryMappingList list;
     bool resume;
     bool detached;
+    bool seekable;
     hwaddr memory_offset;
     int fd;
 
-- 
2.39.2


