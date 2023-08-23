Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A947854D4
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 12:04:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkj5-0000dd-3A; Wed, 23 Aug 2023 06:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.henderson@nutanix.com>)
 id 1qYkj2-0000SB-TJ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 06:04:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.henderson@nutanix.com>)
 id 1qYkiz-0005u8-UH
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 06:04:32 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37MI7aja011591; Wed, 23 Aug 2023 03:04:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=hSf0KKYk4C+kx26se1v5/VkzE6H4u29Fehz6tJYP+
 /8=; b=CCg0bbqytPg4QbYXzFZzDsx/GhdjK+XfCJtuIZOUoh0xV9SGOYJMXw1v+
 gl+Mohpyv31i9jaQcV/tKiDtC75meioLNPiJd3EjotqiDImmmfkpyuRK8EWmQb69
 I/rA4qhwOe/0XHKLkqyRgFsJQS9A7lCmiGtztKRl2YfsYe+/mrU7+Slii8XnB2mx
 ZPF9zKOzy47IQtGhHpXY3ijGEOB5FrUdeN7ejNDhxTyPWM+fF7Y64HI/ujwCIeYA
 DkpZRyPYgGML1vB9XWoPh8+gxwjNCtl/k53f9+C9RuSG4jPV24Y64OWWBf6PErth
 tECTJGGHarbfOckZNFU+T+UYHBZ+A==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3sn2121j2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 03:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsHftEQZFk9w9q2GnXYmCrQ3SsbMdojOpc51FeqR50G8FDGvRlepnXR4MJ25OgAItI1f8ENGSnIVb6PVuNe5QAQHmZNDGyhUzYLEKk2VwDbhS7t22ByxoLJOOM4ISG5NS+7nzJEKBafZuYgjGP/0uNEzaSLc74Y1HBgvPnairX7AhmSiwVc/TXlVnZ6uyb4Tg4suVdDDoKj/21sGBpVTpvq/YoxPCwz4ssEVCPxiXZ3aV5KNexQIwii/LDfjJs5i/PhBczwZBfhQ3kXiU/sx+td1vCQf8aQb3/38K8OcRS4gym4jN8S0HY+KAbsO+L7U5fXNvSD1N5oNnxEGdL+gkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSf0KKYk4C+kx26se1v5/VkzE6H4u29Fehz6tJYP+/8=;
 b=cN55wBPNLGStbjeJ6x6RT1mkClg6HBgXHKHP/nnoE6x/IbeWmp+8Vj3/f805dFtKyD3wkqhohjFyubdsM8wlfHyTgdASCIA3qcY6Dj6wYP1p0FDG7CcugF46d8Jh/xWUvthDdpL4TbCKwKnUs6VnBjIe2sLMtcx/dt9/vus1ZSVqyuOQuq3qo6ZwT8IlMr7gfXxysbMQUupAh1LszcCAT4YxgjzuXLWrYgBOzImVbUxpj+fEJuhp4jAso2zunpjhSR71+VgHZQERsJP645go30yICsGMaBGQDlfR1LBR4LxKbwR03b5NDans6pMZb1pcoszTRVIJXnhO/gO9/EP2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSf0KKYk4C+kx26se1v5/VkzE6H4u29Fehz6tJYP+/8=;
 b=liiVu/2tN0cufDxVt9JLc7OZ6npB9c6nFQrWFdmn/y5V1WlQY5pRmvj618/we5Lsle2BPvTG39Dpn6bH10DFAtuDw0uPGcrcd3DjJN9JZew7oZcZkvOUxDp9rDhQYXahL5KxUE1/Ol1jUn8VCLZabR56fagRVlx3XvI37ClxBcTgeZg7HKrUtMX4I+/YV9asfNFsOvlT9984PMPhVEfX6mnsrr5uNxfzZPeyDC6C6dxucjf3g3rLA2MyF/sf9G180FBjRuqdhag7jA/WJbhCzmuyGrneqSM4A720jVOTxj3TyfDiMbvgVcscJmWCkcS56xgIyqsXjOGECGZLnvOgVQ==
Received: from MN2PR02MB6880.namprd02.prod.outlook.com (2603:10b6:208:1f7::12)
 by BY5PR02MB6770.namprd02.prod.outlook.com (2603:10b6:a03:20c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 10:04:23 +0000
Received: from MN2PR02MB6880.namprd02.prod.outlook.com
 ([fe80::20aa:33ec:7f5e:936a]) by MN2PR02MB6880.namprd02.prod.outlook.com
 ([fe80::20aa:33ec:7f5e:936a%7]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 10:04:23 +0000
From: William Henderson <william.henderson@nutanix.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jag.raman@oracle.com,
 john.levon@nutanix.com, philmd@linaro.org, stefanha@gmail.com,
 thanos.makatos@nutanix.com,
 William Henderson <william.henderson@nutanix.com>
Subject: [RFC PATCH v2 1/1] vfio-user: add live migration to vfio-user
 protocol specification
Date: Wed, 23 Aug 2023 10:04:00 +0000
Message-Id: <20230823100400.152847-2-william.henderson@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230823100400.152847-1-william.henderson@nutanix.com>
References: <20230823100400.152847-1-william.henderson@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::15) To MN2PR02MB6880.namprd02.prod.outlook.com
 (2603:10b6:208:1f7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR02MB6880:EE_|BY5PR02MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: dff23dc0-c16c-4c9d-e02d-08dba3c0538d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHKLrIDzZZtWZw54FUNdBCaBLStu+3+adPCzXdLuNz891pei3pXA2ujTUfATFP6jPeFDo9HennnnyEb+uKx7LC6WFzudUxsOKSg5/q3O7t2X0LZJ5wIdWXUXC4JPV1+lg4ZOG5+z30c6a6Lvd1Y29FxY3Ka2s/KUQbbFi2LNGZd0U06MxoWPIdEgtuyB7EmIgR9MbTfiO1UwCtuUz8GDsDn9PIFvyE0g4PNDg6iLPdPUPrG+Xdgd2/GszyLWw8HTGMUiWxxU7cQOSuu3+ITezVdT6QdW0JfEoFfvKFBT+/45jenNEHhkIT00H3XCwrL2pR0aKgcYDtNbpiPb+TwxOfz/9t+BAdEX/8zM0MbhRdknki3pEpp531JEnM7/2qjZXyc8m0uNknpuFIj1C34H5zNt1UZKl4T4u2qsh4jjJfeDXGq1+VdB34R/MZ6t/gKp+OqVjR6D7Ibgewf9EptFp5OW9JFowJ9xBiCbltV1Bn7fvCG8QS3XZdUyUJtB1CAkTEB2KgBZpYVF8RKvFFuIkx9X94X8m4f9UgHRTap1iGlQ/q6+ZNdIGsAFFPUZZGrt8lT4cuuZaP8NKQUkTZKmpU27ghIKnMlscO4ZDhaLpjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6880.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(136003)(39850400004)(366004)(186009)(1800799009)(451199024)(8676002)(8936002)(4326008)(26005)(86362001)(6512007)(83380400001)(107886003)(2616005)(1076003)(41300700001)(38350700002)(38100700002)(316002)(52116002)(6506007)(478600001)(966005)(66476007)(6486002)(6666004)(36756003)(6916009)(66946007)(66556008)(44832011)(2906002)(30864003)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GhuPsn/spwW37HB0ILyntwxt9LcqVzemFdtl7jD91JyiOAExJtNUFtihPKrj?=
 =?us-ascii?Q?1rBf/anbmEX0lUvM/KppvVZT6SaTjaylkJ+i07zY1hhLhQEiTzKyyZadFHx0?=
 =?us-ascii?Q?T0+wKPvMojn4GmkIVC2ESqa9xXXEY7sAH/XHDXwXkFFdKnHm2r7vU4XAzfve?=
 =?us-ascii?Q?3KjvX8G8l04fKHh/MvadUzGvwSQ1o0lxTxSXohz4Z8fvg55jVqb2JKQrVPtw?=
 =?us-ascii?Q?/b62LbDmzFttj5FUZTMBRtgnrJn1xoxfpx/kxgP/MpsSda7xQeWjW8WSFsnE?=
 =?us-ascii?Q?ICHzAg3TxjVLq713woFT0Vy3gk3P47p2kDOz/ssCAn85AFcNlqpQI8UsdscV?=
 =?us-ascii?Q?+ZnCpSY+iIn/TAqSYXAIzvs+Hk/aig1xMj3VZZ8OEopd4xDw0CR3CX8XQjUt?=
 =?us-ascii?Q?plCelL0slGxbm84r+ccI8kwAOPelq9L1fEQ+ZMzDdOPewPe32T5sBLRILFCi?=
 =?us-ascii?Q?hxEL6HjOehdHF/5lFq3h5JzDhT9DjLJPzoMyMbgUFLoeExWHRn4vj9NDoOhT?=
 =?us-ascii?Q?8u387VqIuSMIC+nNtYg3/LXSXB2qo7n8ox8+M5kW0M1ycqlvQApa2rhFgogW?=
 =?us-ascii?Q?IYiJXgc/uSGVIjoqhHo8huk0wKh1ZvUXZS4OYGVpD2Kpj0b7ymMOJ1/JvlQB?=
 =?us-ascii?Q?0bBqbz509c8FvG4cc0mM0hgILywpuM3odeOWISJotFYTyTbPZxGdTSVfin7S?=
 =?us-ascii?Q?m66lCRquzumq9dDZiuvvG4muxPP4FA5FlMKRXOoP5Qe3GnxeiHgDpR2NXUlu?=
 =?us-ascii?Q?DoF6g1NNNgfWPMzf++RPWZdLrxveSB3/+9nDslYzfioxxbVUxpEpOamH6G10?=
 =?us-ascii?Q?IInXOD5scO0EDBnbW9iQMLqkjHQ2MIljG+qqjWn7hRLqUNlEV0zY2C2yjfr1?=
 =?us-ascii?Q?yg2rpQSlP0/zKdyi+RupBxA1C4cFE4DvMKPDpiGWCrheYFGQAtVX35BErdCv?=
 =?us-ascii?Q?cGCdxNllYlquHhGqhOqwE9/f+2tkBSd130jADDlLV4ZhsPyQyFvOmklyXTe7?=
 =?us-ascii?Q?lsRMyQJXyRQomrhIyVpZrHO0YMveDGx21BLITYc8NsM2n3P4+O/HQKS4MiCe?=
 =?us-ascii?Q?aK6zi3PHidc/7hDstStSfMw9q9kv1sRaBeZE2gFAcScadLzsCo8+FhoMx0Z0?=
 =?us-ascii?Q?pm2FK4X7fQ5Boel5a9JVjIa/4aMnDHVe0f6DA42MDPo1LQkamERMoIre9POG?=
 =?us-ascii?Q?m5Gru+ZCEXeMd7T0cXiqifW5FSuXsdCOmBeHyPc0FixXe8ONYyiCPHUD/A+7?=
 =?us-ascii?Q?58HKqle4uM4du2hmEw7L3xm5Za8b+/ptSdN7csFnq54a60G6uXeNMlQFUTqx?=
 =?us-ascii?Q?mRh7i3WMRSjsgWCgXZHDrOt2F4nfOcJE85lA+KmVdj8N8Ge3twW1RAHFNBoa?=
 =?us-ascii?Q?7YRygSMKGoN+296tLeUopxeHyTOEPgSZfmKC3pfr5GZTP3Koie14D4lTf2hv?=
 =?us-ascii?Q?aNGOz8IrMRx1mzqJiWA7cLYHCyBsn+Wf67WPR+Dvc1B4wvkyKOf21oJtF0W0?=
 =?us-ascii?Q?DXSzUrd4AkSyiuuVYxfMn3rxwlheFgnq2NU4uhTVaRJxgnhYhlpexYC8wluD?=
 =?us-ascii?Q?KZB/be3hEqczT0+8lhQ+CIT8z+/NDGwk4RmKpv2ksIIV9qH1M3ThDA36XxZa?=
 =?us-ascii?Q?wLKtBurVWPhp1rmSySsQM4o=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff23dc0-c16c-4c9d-e02d-08dba3c0538d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6880.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 10:04:23.5400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRDd22lxhG15NFGOkkgT5VvvIplUPXzE6HKhl2OkZ/4Wq2M4PMysD39sIqvBRPlJxF6RrmLA8WmwR1MtzoWtwfdrkvrfokJ+5F3iAau6ykA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6770
X-Proofpoint-GUID: hrgRJ9mo3RIc_Aj4Da1_yvZD6iH6mdbT
X-Proofpoint-ORIG-GUID: hrgRJ9mo3RIc_Aj4Da1_yvZD6iH6mdbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=william.henderson@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

This patch adds live migration to the vfio-user specification, based on the new
VFIO migration interface introduced in the kernel here:

https://lore.kernel.org/all/20220224142024.147653-10-yishaih@nvidia.com/

We differ from the VFIO protocol in that, while VFIO transfers migration data
using a file descriptor, we simply use the already-established vfio-user socket
with two additional commands, VFIO_USER_MIG_DATA_READ and
VFIO_USER_MIG_DATA_WRITE, which have stream semantics. We also don't use P2P
states as we don't yet have a use-case for them, although this may change in the
future.

This patch should be applied on the previous pending patch which introduces
the vfio-user protocol:

https://lore.kernel.org/all/c55f5ea0290763724bca1677314f8e2218785743.1688051596.git.jag.raman@oracle.com/
Signed-off-by: William Henderson <william.henderson@nutanix.com>
---
 docs/devel/vfio-user.rst | 413 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 396 insertions(+), 17 deletions(-)

diff --git a/docs/devel/vfio-user.rst b/docs/devel/vfio-user.rst
index 0d96477a68..047569a424 100644
--- a/docs/devel/vfio-user.rst
+++ b/docs/devel/vfio-user.rst
@@ -4,7 +4,7 @@ vfio-user Protocol Specification
 ********************************
 
 --------------
-Version_ 0.9.1
+Version_ 0.9.2
 --------------
 
 .. contents:: Table of Contents
@@ -366,6 +366,9 @@ Name                                    Command    Request Direction
 ``VFIO_USER_DMA_WRITE``                 12         server -> client
 ``VFIO_USER_DEVICE_RESET``              13         client -> server
 ``VFIO_USER_REGION_WRITE_MULTI``        15         client -> server
+``VFIO_USER_DEVICE_FEATURE``            16         client -> server
+``VFIO_USER_MIG_DATA_READ``             17         client -> server
+``VFIO_USER_MIG_DATA_WRITE``            18         client -> server
 ======================================  =========  =================
 
 Header
@@ -508,26 +511,10 @@ Capabilities:
 |                    |         | valid simultaneously.  Optional, with a        |
 |                    |         | value of 65535 (64k-1).                        |
 +--------------------+---------+------------------------------------------------+
-| migration          | object  | Migration capability parameters. If missing    |
-|                    |         | then migration is not supported by the sender. |
-+--------------------+---------+------------------------------------------------+
 | write_multiple     | boolean | ``VFIO_USER_REGION_WRITE_MULTI`` messages      |
 |                    |         | are supported if the value is ``true``.        |
 +--------------------+---------+------------------------------------------------+
 
-The migration capability contains the following name/value pairs:
-
-+-----------------+--------+--------------------------------------------------+
-| Name            | Type   | Description                                      |
-+=================+========+==================================================+
-| pgsize          | number | Page size of dirty pages bitmap. The smallest    |
-|                 |        | between the client and the server is used.       |
-+-----------------+--------+--------------------------------------------------+
-| max_bitmap_size | number | Maximum bitmap size in ``VFIO_USER_DIRTY_PAGES`` |
-|                 |        | and ``VFIO_DMA_UNMAP`` messages.  Optional,      |
-|                 |        | with a default value of 256MB.                   |
-+-----------------+--------+--------------------------------------------------+
-
 Reply
 ^^^^^
 
@@ -1468,6 +1455,398 @@ Reply
 
 * *wr_cnt* is the number of device writes completed.
 
+``VFIO_USER_DEVICE_FEATURE``
+----------------------------
+
+This command is analogous to ``VFIO_DEVICE_FEATURE``. It is used to get, set, or
+probe feature data of the device.
+
+Request
+^^^^^^^
+
+The request payload for this message is a structure of the following format.
+
++-------+--------+--------------------------------+
+| Name  | Offset | Size                           |
++=======+========+================================+
+| argsz | 0      | 4                              |
++-------+--------+--------------------------------+
+| flags | 4      | 4                              |
++-------+--------+--------------------------------+
+|       | +---------+---------------------------+ |
+|       | | Bit     | Definition                | |
+|       | +=========+===========================+ |
+|       | | 0 to 15 | Feature index             | |
+|       | +---------+---------------------------+ |
+|       | | 16      | VFIO_DEVICE_FEATURE_GET   | |
+|       | +---------+---------------------------+ |
+|       | | 17      | VFIO_DEVICE_FEATURE_SET   | |
+|       | +---------+---------------------------+ |
+|       | | 18      | VFIO_DEVICE_FEATURE_PROBE | |
+|       | +---------+---------------------------+ |
++-------+--------+--------------------------------+
+| data  | 8      | variable                       |
++-------+--------+--------------------------------+
+
+* *argsz* is the size of the above structure.
+
+* *flags* defines the action to be performed by the server and upon which
+  feature:
+
+  * The feature index consists of the least significant 16 bits of the flags
+    field, and can be accessed using the ``VFIO_DEVICE_FEATURE_MASK`` bit mask.
+  
+  * ``VFIO_DEVICE_FEATURE_GET`` instructs the server to get the data for the
+    given feature.
+
+  * ``VFIO_DEVICE_FEATURE_SET`` instructs the server to set the feature data to
+    that given in the ``data`` field of the payload.
+
+  * ``VFIO_DEVICE_FEATURE_PROBE`` instructs the server to probe for feature
+    support. If ``VFIO_DEVICE_FEATURE_GET`` and/or ``VFIO_DEVICE_FEATURE_SET``
+    are also set, the probe will only return success if all of the indicated
+    methods are supported.
+
+  ``VFIO_DEVICE_FEATURE_GET`` and ``VFIO_DEVICE_FEATURE_SET`` are mutually
+  exclusive, except for use with ``VFIO_DEVICE_FEATURE_PROBE``.
+
+* *data* is specific to the particular feature. It is not used for probing.
+
+This part of the request is analogous to VFIO's ``struct vfio_device_feature``.
+
+Reply
+^^^^^
+
+The reply payload must be the same as the request payload for setting or
+probing a feature. For getting a feature's data, the data is added in the data
+section and its length is added to ``argsz``.
+
+Device Features
+^^^^^^^^^^^^^^^
+
+The only device features supported by vfio-user are those related to migration,
+although this may change in the future. They are a subset of those supported in
+the VFIO implementation of the Linux kernel.
+
++----------------------------------------+---------------+
+| Name                                   | Feature Index |
++========================================+===============+
+| VFIO_DEVICE_FEATURE_MIGRATION          | 1             |
++----------------------------------------+---------------+
+| VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE   | 2             |
++----------------------------------------+---------------+
+| VFIO_DEVICE_FEATURE_DMA_LOGGING_START  | 6             |
++----------------------------------------+---------------+
+| VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP   | 7             |
++----------------------------------------+---------------+
+| VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT | 8             |
++----------------------------------------+---------------+
+
+``VFIO_DEVICE_FEATURE_MIGRATION``
+"""""""""""""""""""""""""""""""""
+
+This feature indicates that the device can support the migration API through
+``VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE``. If ``GET`` succeeds, the ``RUNNING``
+and ``ERROR`` states are always supported. Support for additional states is
+indicated via the flags field; at least ``VFIO_MIGRATION_STOP_COPY`` must be
+set.
+
+There is no data field of the request message.
+
+The data field of the reply message is structured as follows:
+
++-------+--------+---------------------------+
+| Name  | Offset | Size                      |
++=======+========+===========================+
+| flags | 0      | 8                         |
++-------+--------+---------------------------+
+|       | +-----+--------------------------+ |
+|       | | Bit | Definition               | |
+|       | +=====+==========================+ |
+|       | | 0   | VFIO_MIGRATION_STOP_COPY | |
+|       | +-----+--------------------------+ |
+|       | | 1   | VFIO_MIGRATION_P2P       | |
+|       | +-----+--------------------------+ |
+|       | | 2   | VFIO_MIGRATION_PRE_COPY  | |
+|       | +-----+--------------------------+ |
++-------+--------+---------------------------+
+
+These flags are interpreted in the same way as VFIO.
+
+``VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE``
+""""""""""""""""""""""""""""""""""""""""
+
+Upon ``VFIO_DEVICE_FEATURE_SET``, execute a migration state change on the VFIO
+device. The new state is supplied in ``device_state``. The state transition must
+fully complete before the reply is sent.
+
+The data field of the reply message, as well as the ``SET`` request message, is
+structured as follows:
+
++--------------+--------+------+
+| Name         | Offset | Size |
++==============+========+======+
+| device_state | 0      | 4    |
++--------------+--------+------+
+| data_fd      | 4      | 4    |
++--------------+--------+------+
+
+* *device_state* is the current state of the device (for ``GET``) or the
+  state to transition to (for ``SET``). It is defined by the
+  ``vfio_device_mig_state`` enum as detailed below. These states are the states
+  of the device migration Finite State Machine.
+
++--------------------------------+-------+---------------------------------------------------------------------+
+| Name                           | State | Description                                                         |
++================================+=======+=====================================================================+
+| VFIO_DEVICE_STATE_ERROR        | 0     | The device has failed and must be reset.                            |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_STOP         | 1     | The device does not change the internal or external state.          |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_RUNNING      | 2     | The device is running normally.                                     |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_STOP_COPY    | 3     | The device internal state can be read out.                          |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_RESUMING     | 4     | The device is stopped and is loading a new internal state.          |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_RUNNING_P2P  | 5     | (not used in vfio-user)                                             |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_PRE_COPY     | 6     | The device is running normally but tracking internal state changes. |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_PRE_COPY_P2P | 7     | (not used in vfio-user)                                             |
++--------------------------------+-------+---------------------------------------------------------------------+
+
+* *data_fd* is unused in vfio-user, as the ``VFIO_USER_MIG_DATA_READ`` and
+  ``VFIO_USER_MIG_DATA_WRITE`` messages are used instead for migration data
+  transport.
+
+Direct State Transitions
+""""""""""""""""""""""""
+
+The device migration FSM is a Mealy machine, so actions are taken upon the arcs
+between FSM states. The following transitions need to be supported by the
+server, a subset of those defined in ``<linux/vfio.h>``
+(``enum vfio_device_mig_state``).
+
+* ``RUNNING -> STOP``, ``STOP_COPY -> STOP``: Stop the operation of the device.
+  The ``STOP_COPY`` arc terminates the data transfer session.
+
+* ``RESUMING -> STOP``: Terminate the data transfer session. Complete processing
+  of the migration data. Stop the operation of the device. If the delivered data
+  is found to be incomplete, inconsistent, or otherwise invalid, fail the
+  ``SET`` command and optionally transition to the ``ERROR`` state.
+
+* ``PRE_COPY -> RUNNING``: Terminate the data transfer session. The device is
+  now fully operational.
+
+* ``STOP -> RUNNING``: Start the operation of the device.
+
+* ``RUNNING -> PRE_COPY``, ``STOP -> STOP_COPY``: Begin the process of saving
+  the device state. The device operation is unchanged, but data transfer begins.
+  ``PRE_COPY`` and ``STOP_COPY`` are referred to as the "saving group" of
+  states.
+
+* ``PRE_COPY -> STOP_COPY``: Continue to transfer migration data, but stop 
+  device operation.
+
+* ``STOP -> RESUMING``: Start the process of restoring the device state. The
+  internal device state may be changed to prepare the device to receive the
+  migration data.
+
+The ``STOP_COPY -> PRE_COPY`` transition is explicitly not allowed and should
+return an error if requested.
+
+``ERROR`` cannot be specified as a device state, but any transition request can
+be failed and then move the state into ``ERROR`` if the server was unable to
+execute the requested arc AND was unable to restore the device into any valid
+state. To recover from ``ERROR``, ``VFIO_USER_DEVICE_RESET`` must be used to
+return back to ``RUNNING``.
+
+If ``PRE_COPY`` is not supported, arcs touching it are removed.
+
+Complex State Transitions
+"""""""""""""""""""""""""
+
+The remaining possible transitions are to be implemented as combinations of the
+above FSM arcs. As there are multiple paths, the path should be selected based
+on the following rules:
+
+* Select the shortest path.
+
+* The path cannot have saving group states as interior arcs, only start/end
+  states.
+  
+``VFIO_DEVICE_FEATURE_DMA_LOGGING_START`` / ``VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP``
+""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+
+Upon ``VFIO_DEVICE_FEATURE_SET``, start/stop DMA logging. These features can
+also be probed to determine whether the device supports DMA logging.
+
+When DMA logging is started, a range of IOVAs to monitor is provided and the
+device can optimize its logging to cover only the IOVA range given. Only DMA
+writes are logged.
+
+The data field of the ``SET`` request is structured as follows:
+
++------------+--------+----------+
+| Name       | Offset | Size     |
++============+========+==========+
+| page_size  | 0      | 8        |
++------------+--------+----------+
+| num_ranges | 8      | 4        |
++------------+--------+----------+
+| reserved   | 12     | 4        |
++------------+--------+----------+
+| ranges     | 16     | variable |
++------------+--------+----------+
+
+* *page_size* hints what tracking granularity the device should try to achieve.
+  If the device cannot do the hinted page size then it's the driver's choice
+  which page size to pick based on its support. On output the device will return
+  the page size it selected.
+
+* *num_ranges* is the number of IOVA ranges to monitor. A value of zero
+  indicates that all writes should be logged.
+
+* *ranges* is an array of ``vfio_user_device_feature_dma_logging_range``
+  entries:
+
++--------+--------+------+
+| Name   | Offset | Size |
++========+========+======+
+| iova   | 0      | 8    |
++--------+--------+------+
+| length | 8      | 8    |
++--------+--------+------+
+
+  * *iova* is the base IO virtual address
+  * *length* is the length of the range to log
+
+Upon success, the response data field will be the same as the request, unless
+the page size was changed, in which case this will be reflected in the response.
+
+``VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT``
+""""""""""""""""""""""""""""""""""""""""""
+
+Upon ``VFIO_DEVICE_FEATURE_GET``, returns the dirty bitmap for a specific IOVA
+range. This operation is only valid if logging of dirty pages has been
+previously started by setting ``VFIO_DEVICE_FEATURE_DMA_LOGGING_START``.
+
+The data field of the request is structured as follows:
+
++-----------+--------+------+
+| Name      | Offset | Size |
++===========+========+======+
+| iova      | 0      | 8    |
++-----------+--------+------+
+| length    | 8      | 8    |
++-----------+--------+------+
+| page_size | 16     | 8    |
++-----------+--------+------+
+
+* *iova* is the base IO virtual address
+
+* *length* is the length of the range
+
+* *page_size* is the unit of granularity of the bitmap, and must be a power of
+  two. It doesn't have to match the value given to
+  ``VFIO_DEVICE_FEATURE_DMA_LOGGING_START`` because the driver will format its
+  internal logging to match the reporting page size possibly by replicating bits
+  if the internal page size is lower than requested
+
+The data field of the response is identical, except with the bitmap added on
+the end at offset 24.
+
+The mapping of IOVA to bits is given by:
+
+``bitmap[(addr - iova)/page_size] & (1ULL << (addr % 64))``
+
+``VFIO_USER_MIG_DATA_READ``
+---------------------------
+
+This command is used to read data from the source migration server while it is
+in a saving group state (``PRE_COPY`` or ``STOP_COPY``).
+
+This command, and ``VFIO_USER_MIG_DATA_WRITE``, are used in place of the
+``data_fd`` file descriptor in ``<linux/vfio.h>``
+(``struct vfio_device_feature_mig_state``) to enable all data transport to use
+the single already-established UNIX socket. Hence, the migration data is
+treated like a stream, so the client must continue reading until no more
+migration data remains.
+
+Request
+^^^^^^^
+
+The request payload for this message is a structure of the following format.
+
++-------+--------+------+
+| Name  | Offset | Size |
++=======+========+======+
+| argsz | 0      | 4    |
++-------+--------+------+
+| size  | 4      | 4    |
++-------+--------+------+
+
+* *argsz* is the size of the above structure.
+
+* *size* is the size of the migration data to read.
+
+Reply
+^^^^^
+
+The reply payload for this message is a structure of the following format.
+
++-------+--------+----------+
+| Name  | Offset | Size     |
++=======+========+==========+
+| argsz | 0      | 4        |
++-------+--------+----------+
+| size  | 4      | 4        |
++-------+--------+----------+
+| data  | 8      | variable |
++-------+--------+----------+
+
+* *argsz* is the size of the above structure.
+
+* *size* indicates the size of returned migration data. If this is less than the
+  requested size, there is no more migration data to read.
+
+* *data* contains the migration data.
+
+``VFIO_USER_MIG_DATA_WRITE``
+----------------------------
+
+This command is used to write data to the destination migration server while it
+is in the ``RESUMING`` state.
+
+As above, this replaces the ``data_fd`` file descriptor for transport of
+migration data, and as such, the migration data is treated like a stream.
+
+Request
+^^^^^^^
+
+The request payload for this message is a structure of the following format.
+
++-------+--------+----------+
+| Name  | Offset | Size     |
++=======+========+==========+
+| argsz | 0      | 4        |
++-------+--------+----------+
+| size  | 4      | 4        |
++-------+--------+----------+
+| data  | 8      | variable |
++-------+--------+----------+
+
+* *argsz* is the size of the above structure.
+
+* *size* is the size of the migration data to be written.
+
+* *data* contains the migration data.
+
+Reply
+^^^^^
+
+There is no reply payload for this message.
 
 Appendices
 ==========
-- 
2.22.3


